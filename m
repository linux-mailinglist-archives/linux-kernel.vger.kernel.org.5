Return-Path: <linux-kernel+bounces-91005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71F97870857
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1160B1F2134A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F21612E9;
	Mon,  4 Mar 2024 17:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="KVJbzvVt"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D81E484;
	Mon,  4 Mar 2024 17:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709573674; cv=none; b=g9nrit9xTfD6gMxEWXAP69QhC9LABi9E2PSM4cyBhCIGSbMKgpTYSenO9UUBGojQGUGJDfnTISdOTYos5wWgfAKD3Ltc7zzpry+r6PT1tA9yfV6yQQO8gbhpk2HwDpUFBaErjZMrhtRfKJZQWZlERsD3fzDt/E752k40DfOxt8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709573674; c=relaxed/simple;
	bh=TUFC2oXSkwh1q+EPlqWlIYwORwjSCpCR0ZK+J1sWVDg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckVAg4+MUeQnDADjgfGBurcyj7sCG7zDQHeWnWV15N+x03gSx3Wd+jeOlYBuDEJb5aECeJLgwq005Qyb7L61gsqKZ4+NyXPZNkU8yj/EdXfQENMIpaQmKwP9F6NyPhpgveeI5ElPxFtLslMFgg14Yg4mRlTbf4Bv2KSp4vh6Q64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=KVJbzvVt; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 424H03rG023294;
	Mon, 4 Mar 2024 11:08:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	PODMain02222019; bh=UmgdeD3y5bH8MTO7d9mjBfyE5hjIg3x+2bIjgp9F6A8=; b=
	KVJbzvVtmtnT9Mz7C9idMb6aC/rJgH7jReMf23cfoKrPMhio0HJbfUcSlLc3c35o
	16hGfV3YAurNHMZ5mCzS3kc7vt45xkDMs+TtQm2RmKPNFZSoAf3XqhcyT6+HtmVc
	bGMeF2e+9OphoBDETNJOsMjTmvP6JXoJI8KxUg5T8ylZ2NCD/APavn1X3Icdy2oY
	EiQ/phA0mtqdA/nHzMXHa7IKUiIPtQtXP3gKlNlXunYlwB1akH/r6FE9sU6tKhN2
	It2olIOVuh+XmUq2LcCCG+tthL9DL/6UfAc03lUdhYNvcjZHKwCA86rHC6uAtMm3
	Ch1+utbxVgn5UGNEWgEljQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wm2d2j4uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 11:08:57 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 4 Mar 2024
 17:08:55 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 4 Mar 2024 17:08:55 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id B6E48820241;
	Mon,  4 Mar 2024 17:08:55 +0000 (UTC)
Date: Mon, 4 Mar 2024 17:08:54 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
CC: <linus.walleij@linaro.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] gpio: swnode: Don't use __free() on result of
 swnode_get_gpio_device()
Message-ID: <ZeYAJkHwPImooI9S@ediswmail9.ad.cirrus.com>
References: <20240304160320.1054811-1-ckeepax@opensource.cirrus.com>
 <CAMRc=MfAZC8yGXXYrCLeSxonOwozgxRdPC4h=aVgCMSkA7O_dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfAZC8yGXXYrCLeSxonOwozgxRdPC4h=aVgCMSkA7O_dA@mail.gmail.com>
X-Proofpoint-ORIG-GUID: o8tyN_KVLbO71e-kPl2lMRBj3NUNHT8H
X-Proofpoint-GUID: o8tyN_KVLbO71e-kPl2lMRBj3NUNHT8H
X-Proofpoint-Spam-Reason: safe

On Mon, Mar 04, 2024 at 05:34:27PM +0100, Bartosz Golaszewski wrote:
> On Mon, Mar 4, 2024 at 5:03 PM Charles Keepax
> <ckeepax@opensource.cirrus.com> wrote:
> >
> > swnode_get_gpio_device() can return an error pointer, however
> > gpio_device_put() is not able to accept error values. Thus using
> > __free() will result in dereferencing an invalid pointer.
> >
> 
> Can you post the steps to reproduce this? Because it should work[1].

Hmm... yeah that does look like it should work, I have had the
patch sitting in my tree for a little while, let me double check
and I will come back/resend if it is actually still needed.

Thanks,
Charles

