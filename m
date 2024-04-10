Return-Path: <linux-kernel+bounces-138902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17CA89FBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781D7282A40
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A54F16F264;
	Wed, 10 Apr 2024 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qHQDc8nA"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BE16DEBE;
	Wed, 10 Apr 2024 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712763453; cv=none; b=XpxFnq9wqN4lr5wHjWbHq31SUBKy/gK8JOU36mqVTYyx8ye9XshzgEyhzvEFZicPAT5bCZ+/ySs4dWU0ud3f8+bJdfZTZgoJXF6eZB+1M4y3m0NF3ZmXHqFJnJKdTDHLblkMUopRvtrIaSzDTt6pmUhyMfhG09wdCo1H8ZAU0cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712763453; c=relaxed/simple;
	bh=lehSfaH243LXCD6sAoOXW9jcrRWK8YPPkbntDIj4gNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JM2aCPXNyVgD1/cmn7a0tdLROnmEtT//mt1UbNDbNiUtKvxwY3SLvXjKF9TqZjF/iXcxVjh3Vie3yxwMPCcUZ43y1liGq7x/qK4o40bhWBmoh8ZlkLf+gQyMQILRp78FOOndkUt7WJ+jN88E46a9COVDu/hYkAR7tN+cUSZ6Wz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qHQDc8nA; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43A5ji46028164;
	Wed, 10 Apr 2024 10:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=Qu83Tf/i0xP/o08yPLOaQHlB6LgAi9Y5S45cHMDmpZI=; b=
	qHQDc8nA8aU84AvaZLNoKDbXgw6W4Fvfs9CqPA/UkteZaqPxjZVGfCsJrD/9PH6e
	nRgaD+eA4Mtv9XDXz8n9kSgHN0pont+IgVYrn1rJPZM4csC1ffvLecKKeE4/TSv+
	Ry8WYAaPR1N8bCblUKh7wPAX0Sfs3dCymSYQAV0jaffY1jwmhjBR99/YROjbx9IK
	IRMpeur4tCOBw8vyOJkBMDC2YIrxxZR2tSx0F3U3KHuCEoRsurcMngnSVdPWYqKC
	Nq8YOicB86v1fTZSSXK3JcmYRhiI2MO0S9zvIBrHj4klmen/TO2ZjaVyIKyOcCZN
	QaiP8IsQXI7ZkQpki7qggA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3xb3sxn5mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Apr 2024 10:37:07 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Apr
 2024 16:37:04 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Apr 2024 16:37:04 +0100
Received: from [198.61.64.213] (EDIN4L06LR3.ad.cirrus.com [198.61.64.213])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4501282024A;
	Wed, 10 Apr 2024 15:37:04 +0000 (UTC)
Message-ID: <6b427ff3-9528-40f9-8638-1fabdc3e4880@opensource.cirrus.com>
Date: Wed, 10 Apr 2024 16:37:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: soc-card: soc-card-test: Fix some error handling
 in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <2db68591-64e2-4f43-a5e1-cb8849f0a296@moroto.mountain>
 <c8e9a7a0-6fcf-4bbe-a659-b2360f5980d8@opensource.cirrus.com>
 <6aaca4c3-46c4-475a-aecd-cf471370e97c@moroto.mountain>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <6aaca4c3-46c4-475a-aecd-cf471370e97c@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: wZqbFBKgA9JYLC5aYDkIYND5GXSvuogb
X-Proofpoint-GUID: wZqbFBKgA9JYLC5aYDkIYND5GXSvuogb
X-Proofpoint-Spam-Reason: safe

On 10/4/24 16:31, Dan Carpenter wrote:
> On Wed, Apr 10, 2024 at 03:43:45PM +0100, Richard Fitzgerald wrote:
>> On 10/4/24 15:22, Dan Carpenter wrote:
>>> Fix this reversed if statement and call put_device() before returning
>>> the error code.
>>>
>>> Fixes: ef7784e41db7 ("ASoC: soc-card: Add KUnit test case for snd_soc_card_get_kcontrol")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> ---
>>> v2: call put_device()
>>>
>>>    sound/soc/soc-card-test.c | 4 +++-
>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/soc-card-test.c b/sound/soc/soc-card-test.c
>>> index 075c52fe82e5..faf9a3d46884 100644
>>> --- a/sound/soc/soc-card-test.c
>>> +++ b/sound/soc/soc-card-test.c
>>> @@ -148,8 +148,10 @@ static int soc_card_test_case_init(struct kunit *test)
>>>    	priv->card->owner = THIS_MODULE;
>>>    	ret = snd_soc_register_card(priv->card);
>>> -	if (!ret)
>>> +	if (ret) {
>>> +		put_device(priv->card_dev);
>>>    		return ret;
>>> +	}
>>>    	return 0;
>>>    }
>>
>> Thanks.
>> Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>>
>> I can see that put_device() is also missing earlier in the
>> function:
>>
>> 	if (!priv->card)
>> 		return -ENOMEM;
>>
>> I can send a fix for that.
> 
> No.  Let me resend.  I'm sorry, this patch has not been up to proper
> standards.  

The same could be said for my original code here.

I suggest moving this block of code _before_ the kunit_device_register()
so there's no need to put_device() if the alloc fails:

	priv->card = kunit_kzalloc(test, sizeof(*priv->card), GFP_KERNEL);
	if (!priv->card)
		return -ENOMEM;

Also I should fix Smatch to warn about missing put_device()
> calls to prevent this sort of thing going forward.
> 
> regards,
> dan carpenter


