Return-Path: <linux-kernel+bounces-17981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DD825649
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853621F2247F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143FD2E40E;
	Fri,  5 Jan 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="OBU69Wcw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85322E623;
	Fri,  5 Jan 2024 15:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 405Cpwp4012446;
	Fri, 5 Jan 2024 09:01:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=hCR4EmcMYIBdHpq
	zJzZE8aUhAR9GR9nB+1npMXbK+K4=; b=OBU69WcwJL0L7H1b4rm47LQphdjUCu6
	TT9nJj8I2VcYIxXcXFNCjI92WD/6zgEd8dxGEC+u/tIvi2piWm39RRMBcd0xyrUO
	5e8vDaUwDYLn66eEcspkfpEoLvdZP9shwQ4XaS5sQKL897NDRvAtQZ4SsnoqlFi/
	8oO7VNws8qymx+sQ5UoGHyBZIAJlj0JyS/koXT0M21fOYChcnQGqd2o/tuTMXG5U
	ih/yHp61QcvMZJ8q0PKOEDwvwWZEI82hb4RvP7K+6LLA4gvAeYbaFMrGYEgevoSP
	4XRbQt7AyiG6QYgXVWSkEeeAMWhclGUMxKbb7EBErZeFcxhi7cr3QWQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ve9e8gqbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jan 2024 09:01:21 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 5 Jan
 2024 15:01:18 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Fri, 5 Jan 2024 15:01:03 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 81A6615A2;
	Fri,  5 Jan 2024 15:01:03 +0000 (UTC)
Date: Fri, 5 Jan 2024 15:01:03 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: James Ogletree <jogletre@opensource.cirrus.com>
CC: James Ogletree <james.ogletree@cirrus.com>,
        Fred Treven
	<fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        Dmitry Torokhov
	<dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, "Liam
 Girdwood" <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman
	<james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Peng Fan
	<peng.fan@nxp.com>, Jeff LaBundy <jeff@labundy.com>,
        Sebastian Reichel
	<sebastian.reichel@collabora.com>,
        Jacky Bai <ping.bai@nxp.com>, Weidong Wang
	<wangweidong.a@awinic.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Herve Codina
	<herve.codina@bootlin.com>,
        Shuming Fan <shumingf@realtek.com>,
        Shenghao Ding
	<13916275206@139.com>, Ryan Lee <ryans.lee@analog.com>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        "open list:CIRRUS LOGIC HAPTIC DRIVERS"
	<patches@opensource.cirrus.com>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK,
 TOUCHSCREEN)..." <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND
 FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>,
        "open list:SOUND - SOC LAYER / DYNAMIC AUDIO
 POWER MANAGEM..." <linux-sound@vger.kernel.org>,
        "moderated list:CIRRUS LOGIC
 AUDIO CODEC DRIVERS" <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v5 4/5] Input: cs40l50 - Add support for the CS40L50
 haptic driver
Message-ID: <20240105150103.GI14858@ediswmail.ad.cirrus.com>
References: <20240104223643.876292-1-jogletre@opensource.cirrus.com>
 <20240104223643.876292-5-jogletre@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240104223643.876292-5-jogletre@opensource.cirrus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: nInpbhH6Gxayo2Puvzw74qxNoSGhXQlv
X-Proofpoint-ORIG-GUID: nInpbhH6Gxayo2Puvzw74qxNoSGhXQlv
X-Proofpoint-Spam-Reason: safe

On Thu, Jan 04, 2024 at 10:36:37PM +0000, James Ogletree wrote:
> Introduce support for Cirrus Logic Device CS40L50: a
> haptic driver with waveform memory, integrated DSP,
> and closed-loop algorithms.
> 
> The input driver provides the interface for control of
> haptic effects through the device.
> 
> Signed-off-by: James Ogletree <jogletre@opensource.cirrus.com>
> ---
> +#include <linux/input.h>
> +#include <linux/mfd/cs40l50.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>

Need bitfield.h

Thanks,
Charles

