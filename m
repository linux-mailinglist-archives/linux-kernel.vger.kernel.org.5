Return-Path: <linux-kernel+bounces-163960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC98B7699
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30833283062
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60FC171E71;
	Tue, 30 Apr 2024 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQ6gN2Um"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99511171E40;
	Tue, 30 Apr 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482448; cv=none; b=tLrVKpWqjxgyOEIeNawMqDFJfoSSWPCHo+9Br2IVDIRyZFxL337KeaoMBew6vjMRRCi+9Vg0LGbrlnw5Ob3/48FZ6qpsFOdHU+VKcB7yuWblPNSzhaf1fu3ink2A7f/lJqyG7kh+L/yq18vZXL/45jvX8gGvRNb1N14jChHKVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482448; c=relaxed/simple;
	bh=nfbj6lQg4QIj6KrahuDN2fQ6/mkpe1Kohjlw6rM97eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyvtCnNUEDs7+zOJDKBM6ZGHa+CLEpZVWgmHHleIHRzH0vm9lCDVG53iDFeCH99aL2vE09LLIzeHBiued7ajBahadpWUzJYznlway94tgHxZuAe4K5DheddeCFmRn+Oif9ODP4NBGXD5DLVzHezP/ra/OHX41uLHmIvpzb2wtNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQ6gN2Um; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso5015772b3a.2;
        Tue, 30 Apr 2024 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714482446; x=1715087246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWMKvvPXKohVNDvWimNhPf5Ya38IldwOhHFHwAj6j0Y=;
        b=XQ6gN2UmCsFWN1cTb00GmjPbm28pXQDg+92X1rLaTIJXbqEqc60D/MP92xPomuYzaw
         VDkzm48ViHyy0cJDc613rW+UOGcmfzqrGEePYbFQN145z2QL2Y9E3xJUusLz/XOQ4B/5
         GiJXSeBi5Ktbz5vCoMsG2bMCdpJ5Rh8r9Mq6g8E2C253Flu029nnJCtpLaskSuD4pu0q
         NdAqDzyiAll3kvt57kWg5Wy7V8HJGLTBjOU7xWloLDqb3kolUQ3tGsF8UxU4zWC/nCml
         EDfDKCe3AimbQzaluJ2JyOU6ARVoBVH+uoBEBqe8vplk/T1S+gLUQbO/ezg48eo04lL5
         MsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714482446; x=1715087246;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWMKvvPXKohVNDvWimNhPf5Ya38IldwOhHFHwAj6j0Y=;
        b=tUml0yRhsrXgDU9ugOgfPcUI7ptLVEnuLQMa0PTq50GMePzKy/mzKGP/JuZqAPlJM0
         CIu1eWbuKicPxjnG4ZvqGI5A/uU1x+ZqigiLbuXgZHSO1TZLbtP6+NR6HfgWjEvqhtFe
         Xgnqi4fh+dXDWYpRaDSmrK+CNg2dl1xkNP0hnVvqKQCP34PqWGo25XJgOdw1x4ZFs1Yb
         RvNMaF4D1nG+IwCEgvPIa4Q4bCyZ6SxcWL9ULgJSw3XhdUEpN3keg6MyFgJzH4g7SB0b
         fub70DDCZ45MxaatABtyAQPgPaXrZlB3hT+4PyI/+YPu3Nnhq5xekbwjKx88rnn5rqpM
         QLsw==
X-Forwarded-Encrypted: i=1; AJvYcCWQDT5zl5CvJSoZGlUBsNaIoxrzp4i57EiiFItxGtkryxtp7YR/JcaofBNH++15M4MbJ8eIFk26wSzJi/FZOkfdA+KS0uK7QFR21F3E
X-Gm-Message-State: AOJu0YyQI2BbAwgyTttW2fLvfR9Uj7lInH/pqCMwjNfx68ZJTj64e+na
	SrD/USP84t8lIxNZ3TQbwXXbsEakd9FAusptu+JIBEooYelKika6
X-Google-Smtp-Source: AGHT+IFQW51Ku/ImGoPSs950+adhzT+886b6tUADgTZUL5ML8mna9RSoy4lwYuNJKPGd9ASJAC3mlg==
X-Received: by 2002:a05:6a20:970f:b0:1a7:99c5:802 with SMTP id hr15-20020a056a20970f00b001a799c50802mr15143359pzc.37.1714482445868;
        Tue, 30 Apr 2024 06:07:25 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:ebd1:1da6:4efd:79de? ([2402:e280:214c:86:ebd1:1da6:4efd:79de])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a000b4a00b006e5597994c8sm21025457pfo.5.2024.04.30.06.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 06:07:25 -0700 (PDT)
Message-ID: <f86b0c15-8fc4-4ed7-984a-3ab90c66a3eb@gmail.com>
Date: Tue, 30 Apr 2024 18:37:20 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] media:cdns-csi2tx: replace of_node_put() with
 __free
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, mripard@kernel.org,
 mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com,
 Julia Lawall <julia.lawall@inria.fr>
References: <20240429171543.13032-1-prosunofficial@gmail.com>
 <6df5d715-3e31-40a5-9db3-2c3b9f12efac@wanadoo.fr>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <6df5d715-3e31-40a5-9db3-2c3b9f12efac@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/04/24 00:10, Christophe JAILLET wrote:
> Le 29/04/2024 à 19:15, R Sundar a écrit :
>> Use the new cleanup magic to replace of_node_put() with
>> __free(device_node) marking to auto release when they get out of scope.
>>
>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>> Signed-off-by: R Sundar <prosunofficial@gmail.com>
>> ---
>>   drivers/media/platform/cadence/cdns-csi2tx.c | 19 +++++++------------
>>   1 file changed, 7 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/media/platform/cadence/cdns-csi2tx.c 
>> b/drivers/media/platform/cadence/cdns-csi2tx.c
>> index 3d98f91f1bee..88aed2f299fd 100644
>> --- a/drivers/media/platform/cadence/cdns-csi2tx.c
>> +++ b/drivers/media/platform/cadence/cdns-csi2tx.c
>> @@ -496,48 +496,43 @@ static int csi2tx_get_resources(struct 
>> csi2tx_priv *csi2tx,
>>   static int csi2tx_check_lanes(struct csi2tx_priv *csi2tx)
>>   {
>>       struct v4l2_fwnode_endpoint v4l2_ep = { .bus_type = 0 };
>> -    struct device_node *ep;
>>       int ret, i;
>> -
>> -    ep = of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
>> +    struct device_node *ep __free(device_node) =
>> +        of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
>> +
>>       if (!ep)
>>           return -EINVAL;
>>       ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &v4l2_ep);
>>       if (ret) {
>>           dev_err(csi2tx->dev, "Could not parse v4l2 endpoint\n");
>> -        goto out;
>> +        return ret;
>>       }
>>       if (v4l2_ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
>>           dev_err(csi2tx->dev, "Unsupported media bus type: 0x%x\n",
>>               v4l2_ep.bus_type);
>> -        ret = -EINVAL;
>> -        goto out;
>> +        return -EINVAL;
>>       }
>>       csi2tx->num_lanes = v4l2_ep.bus.mipi_csi2.num_data_lanes;
>>       if (csi2tx->num_lanes > csi2tx->max_lanes) {
>>           dev_err(csi2tx->dev,
>>               "Current configuration uses more lanes than supported\n");
>> -        ret = -EINVAL;
>> -        goto out;
>> +        return -EINVAL;
>>       }
>>       for (i = 0; i < csi2tx->num_lanes; i++) {
>>           if (v4l2_ep.bus.mipi_csi2.data_lanes[i] < 1) {
>>               dev_err(csi2tx->dev, "Invalid lane[%d] number: %u\n",
>>                   i, v4l2_ep.bus.mipi_csi2.data_lanes[i]);
>> -            ret = -EINVAL;
>> -            goto out;
>> +            return -EINVAL;
>>           }
>>       }
>>       memcpy(csi2tx->lanes, v4l2_ep.bus.mipi_csi2.data_lanes,
>>              sizeof(csi2tx->lanes));
>> -out:
>> -    of_node_put(ep);
>>       return ret;
> 
> Hi,
> 
> Nit: return 0; ?
> 
> CJ
> 
>>   }
> 
Hi,

In success case, ret variable value also will be zero, else for non-zero 
ret value it will return from v4l2_fwnode_endpoint_parse()'s error case 
handling block.

Thanks,
Sundar

