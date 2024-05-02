Return-Path: <linux-kernel+bounces-166207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045238B978D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FFB1F252A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738965644F;
	Thu,  2 May 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BlgmQBCu"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9954735;
	Thu,  2 May 2024 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641713; cv=none; b=JZ5GFQyv3x5OK2EOx27sJNHmUkt09F016sOSJG8GoVT/GhCuoJu03ZsMOO0y1oE5fmo4O7ENp2TjG7AClNMA+C1BsbU/p8QcJXEcuq/xyHVT4WkGJfxxKHXxgazmH1Sqa0+b1GxSVHZmWJst9f92jrqWg37gNqVAzWlCW3Ap1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641713; c=relaxed/simple;
	bh=w8QjHcrlLNytid75AMyv9vPhb5KjwI82qLWvBRClbC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iKBjomY5J2F+192Jk/JQa7EBNxv0PAbErMLjZm9ccV6/cNKjsLLhv98Ckyw/FnP8oApBe8Ozb+dhWJ9iRi8j4rw29Yi0rITyKpi7o44rkOmHgyWTOZKB2dm/RbwHld2M9iACqN0QHGvKAIwakbl5P6oH6uzrRk+jj/bEK6DXViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BlgmQBCu; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4426fe2X018298;
	Thu, 2 May 2024 04:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=VJrjKuSFrH1gRBcvsZN1w75FIo5Vye6zZ77H/zyS4h8=; b=
	BlgmQBCuVZvnR+1s/J4qr3vY3zxRjADbfA9OUr1rCg8tHfnfISvx+jsC5KGT7tlc
	doL7BpRkb5CdOswy2vzLDRshsqAN4kzshlV6zJEqxtKQBxKIckWBk1o/Ebnjxqfx
	jacP6QLS9sqxmPEhLIC+GAfuHsAn/eQpkPAcI79XgXmZmuR3agjQLM5rHPszPOqd
	Naq/pNw+FGtM+AF79MPniht721kSHrOLA2ppfNrEhE6pgjlC+tCKKzveh9wf74VI
	vcWYRlkQwMYXoAmSvojOfKCcA7Tye3qMR16bMEQasKbrsNNXnN/GL+UXP48YE5Px
	3ua7m5gx5FN7NZ9iduirFg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3xv0e8g9bf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 04:21:38 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 10:21:36 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 2 May 2024 10:21:36 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 57C8D820244;
	Thu,  2 May 2024 09:21:36 +0000 (UTC)
Message-ID: <a9345d24-af36-42b4-9139-0701a0dbe1a3@opensource.cirrus.com>
Date: Thu, 2 May 2024 10:21:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: cs35l56: Perform firmware download in the
 background
To: Takashi Iwai <tiwai@suse.de>, Simon Trimmer <simont@opensource.cirrus.com>
CC: <tiwai@suse.com>, <linux-sound@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
References: <20240501111755.21231-1-simont@opensource.cirrus.com>
 <87ttjgk6ph.wl-tiwai@suse.de>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <87ttjgk6ph.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5r_XGd3UwelsfKl2wpH1nWx0Tm5vaTNb
X-Proofpoint-GUID: 5r_XGd3UwelsfKl2wpH1nWx0Tm5vaTNb
X-Proofpoint-Spam-Reason: safe

On 02/05/2024 08:34, Takashi Iwai wrote:
> On Wed, 01 May 2024 13:17:55 +0200,
> Simon Trimmer wrote:
>> @@ -964,6 +1011,14 @@ int cs35l56_hda_common_probe(struct cs35l56_hda *cs35l56, int hid, int id)
>>   	mutex_init(&cs35l56->base.irq_lock);
>>   	dev_set_drvdata(cs35l56->base.dev, cs35l56);
>>   
>> +	cs35l56->dsp_wq = create_singlethread_workqueue("cs35l56-dsp");
>> +	if (!cs35l56->dsp_wq) {
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
> 
> Do we really need a dedicated workqueue?  In most usages, simple
> schedule_work*() works fine and is recommended.
> 

On a slow I2C bus with 4 amps this work could take over 2 seconds.
That seems too long to be blocking a global system queue. We use a
dedicated queue in the ASoC driver.

Also if we queue work on an ordered (single-threaded) system queue the
firmware won't be downloaded to multiple amps in parallel, so we don't
get the best use of the available bus bandwidth.

> 
> thanks,
> 
> Takashi


