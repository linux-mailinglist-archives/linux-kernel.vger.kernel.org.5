Return-Path: <linux-kernel+bounces-166293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FE78B98A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 384E5B24A62
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484BD5788E;
	Thu,  2 May 2024 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="EE2eePhF"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549856440;
	Thu,  2 May 2024 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645080; cv=none; b=WlCe91D3tsdqbt7FYkfmCQ5r6htq9gxPVeDu1eSRdjNC7j4yF8lNHV9zdupfOVP6Mc9JAJ6hiRwHho8x+sCGbQJCDf11F+xz3VZy+Acqq6d2y1USJsrDeS4ijcnkorkDs7XPzXRno+qtRN3RyYc9mLqux6f1D6jakKgElUa3mQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645080; c=relaxed/simple;
	bh=sbIV7C29RJ+T1lX+E8sZCLiaBYd2zk0Nq7Q0l2njHYc=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=P7+ijyb8BYB3e8CjW6lI2dDDs9uxJthPPkgckde4N5qhP8RlaWIv1fBw/1PcS2R/yamwZofUPIydUfliZQaitAu0TeN36cYqvKObniObfOFu1dfm5xGg8JIXadLVrVlo7n9MqgpbmhMegJcxJhvXNeBCqQuq0VXoTFhDmkCoSpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=EE2eePhF; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4426QJF9029883;
	Thu, 2 May 2024 05:17:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:references:in-reply-to:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=JdCKGuzvpPEqIMdCQbeQSVDZQ5P0ciLsz3huW76jYp8=; b=
	EE2eePhFPzsI7/YYwR5McN4859a9PNTQSg9lbQsFwtzusPmyb/B93xdyjYka+m9D
	Rh4rZpxJW6mwC+QACdnwDHdSjIqKeTGLsh0+zjlAi6q5eGhyi1dWBLN6lbDZ8aD1
	3U6Blx67/CVKVc0YOP/2W4oJU0+VPqAAAWn7P7EdMSTaJM4QlvIl8lf49H0TEf85
	4ZtwdNOKYcPK8UvtNyKE62Rz1rREPEI3vLs5EzqhBy5xB26FqKr4K5hR69tL46p+
	F8RF6tAP2qLpjo8cfNnTLcuhA4z/KPWJSBxxWVSbnGg1y2RaKO6vOuMkEvcSq1kq
	BmkiNk50xLSJmCnpYakrwQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xv0e8gaw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 05:17:50 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 11:17:48 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9
 via Frontend Transport; Thu, 2 May 2024 11:17:48 +0100
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.61.64.231])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 5FC71820244;
	Thu,  2 May 2024 10:17:48 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Takashi Iwai' <tiwai@suse.de>,
        'Richard Fitzgerald'
	<rf@opensource.cirrus.com>
CC: <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20240501111755.21231-1-simont@opensource.cirrus.com>	<87ttjgk6ph.wl-tiwai@suse.de>	<a9345d24-af36-42b4-9139-0701a0dbe1a3@opensource.cirrus.com> <87h6fgk0ba.wl-tiwai@suse.de>
In-Reply-To: <87h6fgk0ba.wl-tiwai@suse.de>
Subject: RE: [PATCH] ALSA: hda: cs35l56: Perform firmware download in the background
Date: Thu, 2 May 2024 11:17:48 +0100
Message-ID: <001401da9c79$fb9f2de0$f2dd89a0$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQBvb2ocE+GAzujRRIysQCID0b/eEwD72286AkBBwPkCXIFon7QtT9tg
X-Proofpoint-ORIG-GUID: 5tfCnV5rEW5f9pYu0v8QANcb2UyW5qKv
X-Proofpoint-GUID: 5tfCnV5rEW5f9pYu0v8QANcb2UyW5qKv
X-Proofpoint-Spam-Reason: safe

> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Thursday, May 2, 2024 10:53 AM
> To: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: Simon Trimmer <simont@opensource.cirrus.com>; tiwai@suse.com; linux-
> sound@vger.kernel.org; alsa-devel@alsa-project.org; linux-
> kernel@vger.kernel.org; patches@opensource.cirrus.com
> Subject: Re: [PATCH] ALSA: hda: cs35l56: Perform firmware download in the
> background
> 
> On Thu, 02 May 2024 11:21:36 +0200,
> Richard Fitzgerald wrote:
> >
> > On 02/05/2024 08:34, Takashi Iwai wrote:
> > > On Wed, 01 May 2024 13:17:55 +0200,
> > > Simon Trimmer wrote:
> > >> @@ -964,6 +1011,14 @@ int cs35l56_hda_common_probe(struct
> cs35l56_hda *cs35l56, int hid, int id)
> > >>   	mutex_init(&cs35l56->base.irq_lock);
> > >>   	dev_set_drvdata(cs35l56->base.dev, cs35l56);
> > >>   +	cs35l56->dsp_wq =
> > >> create_singlethread_workqueue("cs35l56-dsp");
> > >> +	if (!cs35l56->dsp_wq) {
> > >> +		ret = -ENOMEM;
> > >> +		goto err;
> > >> +	}
> > >
> > > Do we really need a dedicated workqueue?  In most usages, simple
> > > schedule_work*() works fine and is recommended.
> > >
> >
> > On a slow I2C bus with 4 amps this work could take over 2 seconds.
> > That seems too long to be blocking a global system queue. We use a
> > dedicated queue in the ASoC driver.
> >
> > Also if we queue work on an ordered (single-threaded) system queue the
> > firmware won't be downloaded to multiple amps in parallel, so we don't
> > get the best use of the available bus bandwidth.
> 
> OK, that sounds like a sensible argument.
> 
> But the patch has no call of a queue destructor.  Won't it leak
> resources?

Oops that's a good spot - I missed that and will send a v2

Cheers,
-Simon


