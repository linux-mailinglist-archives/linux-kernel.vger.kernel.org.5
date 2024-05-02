Return-Path: <linux-kernel+bounces-166105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF028B9642
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE7CB2237B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3D328689;
	Thu,  2 May 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nh7BA6x1"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D61BF54;
	Thu,  2 May 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637927; cv=none; b=Blu6WY5YbnQDsXQEwB7O8Tgfch4B4ibq9jBPkf5S76+tqjYQPaO3YJOhQNZDAWbnEFlB0DOQLvLaIpPCgXLYCRQcp1Bvtp79eJrp5dsRA5Ls3AErfSTsc71fIfV56JBdAO+bnmlIqP+jfYuHMxEkW2DNJ7Kp8jdOUM0Cm5lCgNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637927; c=relaxed/simple;
	bh=OsPDvE3Lc6w3KXCcRc+fZ2cjA8Mhoib7g1iA5Vr9FoA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tO6gjTFcYNhVi77kApOUv8DeyFCjZ7iPtQ68btt/CFvCZAng8DbaI4b5DcLpKGed7qj+HGCv9bBr19gescRFvLQFRKej7A/M04Ec67mgHxczpVuNtnTdtH93AWK9rhoWtiN2se0VQp2wdTSbn61mU/X4Muq60DvdXWOmBvB4Kb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nh7BA6x1; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4425jDSB017800;
	Thu, 2 May 2024 03:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=EhWtohCGUIZ/Xrs
	7gzkRSrh00jig+0JIKfHJVexSxuE=; b=nh7BA6x1vW4FSvjCjnWDe9HfSSwZM9R
	zYs75gPDPPv4UqASOTqALlq3POj1T9sBiPAB5ke27j78uFdcsw5JDYsv4BK47h1F
	GU3c+DG1MWcmNtAXY7siGmOESWjr+RBAtwb4S6ynT1jkMBpy3ExMirsls9Gp3237
	iz8qTZ99lIr06a+tsdDU0e+BGa+8jQSUqzwSWpA/oesISuXMPPw3kLWjw+QnVLHq
	t15zyEacoYqqB8felAhx7FkjP47ghFRs7ZVhy8BfwEg7YKSexKNXA4zku35h9kUZ
	cP6ErkVwCTDJjOtEGcB0TMXLjjDDyUtZFpjXC/ibo/UwZg+/spTaxFw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xrxry5fdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 03:18:08 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 09:18:05 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 2 May 2024 09:18:05 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 5F4CD820244;
	Thu,  2 May 2024 08:18:05 +0000 (UTC)
Date: Thu, 2 May 2024 08:18:04 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
CC: <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>,
        "Liam
 Girdwood" <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 0/4] ASoC: use 'time_left' instead of 'timeout' with
 wait_for_*() functions
Message-ID: <ZjNMPOOFg9myFSz3@opensource.cirrus.com>
References: <20240430115438.29134-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430115438.29134-1-wsa+renesas@sang-engineering.com>
X-Proofpoint-ORIG-GUID: eedWidXVslVxbzPC805TxwhRqVampm1s
X-Proofpoint-GUID: eedWidXVslVxbzPC805TxwhRqVampm1s
X-Proofpoint-Spam-Reason: safe

On Tue, Apr 30, 2024 at 01:54:33PM +0200, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_*() functions causing patterns like:
> 
>         timeout = wait_for_completion_timeout(...)
>         if (!timeout) return -ETIMEDOUT;
> 
> with all kinds of permutations. Use 'time_left' as a variable to make the code
> obvious and self explaining.
> 
> This is part of a tree-wide series. The rest of the patches can be found here
> (some parts may still be WIP):
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/time_left
> 
> Because these patches are generated, I audit them before sending. This is why I
> will send series step by step. Build bot is happy with these patches, though.
> No functional changes intended.
> 
> Wolfram Sang (4):
>   ASoC: codecs: wm8962: use 'time_left' variable with
>     wait_for_completion_timeout()
>   ASoC: codecs: wm8993: use 'time_left' variable with
>     wait_for_completion_timeout()
>   ASoC: codecs: wm8994: use 'time_left' variable with
>     wait_for_completion_timeout()
>   ASoC: codecs: wm8996: use 'time_left' variable with
>     wait_for_completion_timeout()
> 
>  sound/soc/codecs/wm8962.c | 12 ++++++------
>  sound/soc/codecs/wm8993.c | 12 ++++++------
>  sound/soc/codecs/wm8994.c |  8 ++++----
>  sound/soc/codecs/wm8996.c | 14 +++++++-------
>  4 files changed, 23 insertions(+), 23 deletions(-)
> 

All look good to me.

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

