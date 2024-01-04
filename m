Return-Path: <linux-kernel+bounces-16750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3127682434B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402711C21A44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F02224E3;
	Thu,  4 Jan 2024 14:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="I04Ax1cp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90188224CA
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4046bEgX022991;
	Thu, 4 Jan 2024 08:08:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=HoJJ0zAeIazoo1E
	QZbHCtVJoKQByFciovvb6JqxXPos=; b=I04Ax1cpzLGXs5eV+UYFkUJlQW+ym7a
	+w5wx9MUYrYTzDp9l0I7j2h53qgPC84/8w8xiJe1CdUtfCPWl9doVS6wAifR5lmG
	JwHoqq+fknUDRPl+IyWx4Xv5Rg5vzNt75wXPRBh6HUUka5TunK51mPwLk4EfeI+h
	PtwrpncE3PxrLjBYTeDSpvzHRrtz7aL/yhP8Bq0KMLjXQF22IBr/cPsyyBSbJ+sN
	VIl5m5w6bNq9xD0GDbFWgMEoOuU+5Fs0iYp5JlD93QDP5ozertAoqR0G9SWjqMz7
	L440AgOmNX/1s1RTtd9WbzuvESA/6a0bxokD2zeJ3AXeXM98VmTXNjA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3vahg2etp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 08:08:40 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 4 Jan
 2024 14:08:38 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Thu, 4 Jan 2024 14:08:38 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
	by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8F1EB474;
	Thu,  4 Jan 2024 14:08:38 +0000 (UTC)
Date: Thu, 4 Jan 2024 14:08:38 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regmap: fix kcalloc() arguments order
Message-ID: <20240104140838.GF14858@ediswmail.ad.cirrus.com>
References: <20231220175829.533700-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231220175829.533700-1-dmantipov@yandex.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: Q_Y_tU77_X_IfFYRXl0Sa3rdCWneEQAy
X-Proofpoint-ORIG-GUID: Q_Y_tU77_X_IfFYRXl0Sa3rdCWneEQAy
X-Proofpoint-Spam-Reason: safe

On Wed, Dec 20, 2023 at 08:58:19PM +0300, Dmitry Antipov wrote:
> When compiling with gcc version 14.0.0 20231220 (experimental)
> and W=1, I've noticed a bunch of four similar warnings like:
> 
> drivers/base/regmap/regmap-ram.c: In function '__regmap_init_ram':
> drivers/base/regmap/regmap-ram.c:68:37: warning: 'kcalloc' sizes specified with
> 'sizeof' in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
>    68 |         data->read = kcalloc(sizeof(bool), config->max_register + 1,
>       |                                     ^~~~
> 
> Since 'n' and 'size' arguments of 'kcalloc()' are multiplied to
> calculate the final size, their actual order doesn't affect the
> result and so this is not a bug. But it's still worth to fix it.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

