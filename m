Return-Path: <linux-kernel+bounces-164886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1378B847D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 05:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10DA1C22300
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071A029422;
	Wed,  1 May 2024 03:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmXIHm9X"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73412B71;
	Wed,  1 May 2024 03:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714534301; cv=none; b=ZEQ6/lho73hGFOAKGV4cgcQYJSY9cNoqNr3ehtR1eWj/dHuz2AmZS9jh3XHvh5CHLlkHhpq6UiHuERCCy1/kC6u0TrlRDj+NBW4kNpTG2gm0BJMuHq71vwjUGXqp405nCOPWl1DWd69aEfOi7ZriQganxtqXHMa58D/SkTt9pcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714534301; c=relaxed/simple;
	bh=PabL6LOoQHGYM7jhG0HXdV2dhKCQxCq28w8/njzBgBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Imj2ArmwTe12V2/vOcFZV+HM6Jh/K8b56BmNLiPf7CtD2yaPb2ecFGwZwQ15BatOst7vi4vakbTpI2F7KLf9RA69qIoNkCOYnmdhtCSElAE3UXfKZHIOD9bnC5LiL08A2o4LabyjED+lGEfIX4TAytzdH0mtFPbMuiGvV94Y/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmXIHm9X; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ee1c0ecfa5so2048700a34.0;
        Tue, 30 Apr 2024 20:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714534299; x=1715139099; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/uYAYfME0ywDE8lmQB/ydzgc+UD/wslCeCSNsfYVAd8=;
        b=QmXIHm9X8hYD7DUAx3onYSCCYkhxxIRB1RZWewTkkoDuJs6c6mGMdasbea3qlok/qy
         nB1ZXdD7cVO6k6X87+Geeoas1j2htGsQqQub9jXC75QZbKS9tmNdQwHse9tIsKNNoZaP
         0LsKbmPjbdAJfCp/wRuoeqFj39O4qVgoY/yuUHxzVFecDeI9IcDpQHDPi9ZNXuqjDLcm
         m0VMFB1Hkkb6GQkZXBuh2ymOG1QVnFrI7vFYiOfEO/L7LG/+wNh5DzVpGpKFgZdNndAU
         AXn+qKoqO06hMKuqVyUfudH7a/doUMFfKDIG2diX11aa3N/udB40y056GQPXpwWlJxRg
         VZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714534299; x=1715139099;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/uYAYfME0ywDE8lmQB/ydzgc+UD/wslCeCSNsfYVAd8=;
        b=N1WVUTimCWIgqNDyPKFPpr6GkZNZBHD89XL4AHBEp+xYfOLa4HS9SZN/TNb1Ru5zlC
         t5dXaRL7ThMbOu6wXv27jXHYQiFzjt8bGbdAGjpvp5z1ifhxD+rdLlCgZsxOw+o9jf0C
         +NVVcHT5IS5xDKEq50Qb1x8KuCpm6BJ8BT3HVvHBNJrCCgT5LPkU/AIch+PSkusRjnxv
         kkm7owAo3mI626Pivi0f4Stb2eEe4+6mffxAlNG0y75zrja0w0rzHfxuBGb19GC477zO
         Gfg1czDf7IA/aU7f/OOT6/IJSchD4xiJWHysBAUv4sv23l9UoIvkZyH1+skeRl9Sy0CH
         jQSA==
X-Forwarded-Encrypted: i=1; AJvYcCXsAIprx3F1QpDiSzCzS70HK47ukV5Wx7iqnbt58KCshW5Egrpw7lzrGE2FOoI5Hs181mxXq4qnQM0ATMKVFBcmdtfz82xpXdCfY7HE/C4lm27tt49m/wmPHhmnXKZCPeiqk/QmSNQHxbQ=
X-Gm-Message-State: AOJu0YzCX+yBCScM3tx7xqDrQPiXYhrpMT2vUKA/M5W0ckv64sbvOxyB
	6rXw5JA62oywHCH8h2HHG/XZ58Raz7vxtAuQJiRz6HLSyNAXh/j0
X-Google-Smtp-Source: AGHT+IHdX4lONgwa5zmyiDhdbfXkaA13S2aH9i8jVM5hrpbuZN7i/5s5y/mO/Gvf7XHt8F2kkRw+EQ==
X-Received: by 2002:a9d:638b:0:b0:6ee:4713:8e56 with SMTP id w11-20020a9d638b000000b006ee47138e56mr1516313otk.0.1714534298601;
        Tue, 30 Apr 2024 20:31:38 -0700 (PDT)
Received: from ?IPV6:2402:e280:214c:86:c5df:1eec:52b9:dcb8? ([2402:e280:214c:86:c5df:1eec:52b9:dcb8])
        by smtp.gmail.com with ESMTPSA id e131-20020a636989000000b005e43cce33f8sm21690709pgc.88.2024.04.30.20.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 20:31:38 -0700 (PDT)
Message-ID: <80aaad79-9426-4ee4-afe9-a10c089df086@gmail.com>
Date: Wed, 1 May 2024 09:01:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] media:cdns-csi2tx: replace of_node_put() with
 __free
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, mripard@kernel.org,
 mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
References: <20240429171543.13032-1-prosunofficial@gmail.com>
 <6df5d715-3e31-40a5-9db3-2c3b9f12efac@wanadoo.fr>
 <f86b0c15-8fc4-4ed7-984a-3ab90c66a3eb@gmail.com>
 <76b3d25-2ba3-2f9f-3ed6-61a63983a225@inria.fr>
Content-Language: en-US
From: R Sundar <prosunofficial@gmail.com>
In-Reply-To: <76b3d25-2ba3-2f9f-3ed6-61a63983a225@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/04/24 22:53, Julia Lawall wrote:
> 
> 
> On Tue, 30 Apr 2024, R Sundar wrote:
> 
>> On 30/04/24 00:10, Christophe JAILLET wrote:
>>> Le 29/04/2024 à 19:15, R Sundar a écrit :
>>>> Use the new cleanup magic to replace of_node_put() with
>>>> __free(device_node) marking to auto release when they get out of scope.
>>>>
>>>> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>>>> Signed-off-by: R Sundar <prosunofficial@gmail.com>
>>>> ---
>>>>    drivers/media/platform/cadence/cdns-csi2tx.c | 19 +++++++------------
>>>>    1 file changed, 7 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/drivers/media/platform/cadence/cdns-csi2tx.c
>>>> b/drivers/media/platform/cadence/cdns-csi2tx.c
>>>> index 3d98f91f1bee..88aed2f299fd 100644
>>>> --- a/drivers/media/platform/cadence/cdns-csi2tx.c
>>>> +++ b/drivers/media/platform/cadence/cdns-csi2tx.c
>>>> @@ -496,48 +496,43 @@ static int csi2tx_get_resources(struct csi2tx_priv
>>>> *csi2tx,
>>>>    static int csi2tx_check_lanes(struct csi2tx_priv *csi2tx)
>>>>    {
>>>>        struct v4l2_fwnode_endpoint v4l2_ep = { .bus_type = 0 };
>>>> -    struct device_node *ep;
>>>>        int ret, i;
>>>> -
>>>> -    ep = of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
>>>> +    struct device_node *ep __free(device_node) =
>>>> +        of_graph_get_endpoint_by_regs(csi2tx->dev->of_node, 0, 0);
>>>> +
>>>>        if (!ep)
>>>>            return -EINVAL;
>>>>        ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &v4l2_ep);
>>>>        if (ret) {
>>>>            dev_err(csi2tx->dev, "Could not parse v4l2 endpoint\n");
>>>> -        goto out;
>>>> +        return ret;
>>>>        }
>>>>        if (v4l2_ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
>>>>            dev_err(csi2tx->dev, "Unsupported media bus type: 0x%x\n",
>>>>                v4l2_ep.bus_type);
>>>> -        ret = -EINVAL;
>>>> -        goto out;
>>>> +        return -EINVAL;
>>>>        }
>>>>        csi2tx->num_lanes = v4l2_ep.bus.mipi_csi2.num_data_lanes;
>>>>        if (csi2tx->num_lanes > csi2tx->max_lanes) {
>>>>            dev_err(csi2tx->dev,
>>>>                "Current configuration uses more lanes than supported\n");
>>>> -        ret = -EINVAL;
>>>> -        goto out;
>>>> +        return -EINVAL;
>>>>        }
>>>>        for (i = 0; i < csi2tx->num_lanes; i++) {
>>>>            if (v4l2_ep.bus.mipi_csi2.data_lanes[i] < 1) {
>>>>                dev_err(csi2tx->dev, "Invalid lane[%d] number: %u\n",
>>>>                    i, v4l2_ep.bus.mipi_csi2.data_lanes[i]);
>>>> -            ret = -EINVAL;
>>>> -            goto out;
>>>> +            return -EINVAL;
>>>>            }
>>>>        }
>>>>        memcpy(csi2tx->lanes, v4l2_ep.bus.mipi_csi2.data_lanes,
>>>>               sizeof(csi2tx->lanes));
>>>> -out:
>>>> -    of_node_put(ep);
>>>>        return ret;
>>>
>>> Hi,
>>>
>>> Nit: return 0; ?
>>>
>>> CJ
>>>
>>>>    }
>>>
>> Hi,
>>
>> In success case, ret variable value also will be zero, else for non-zero ret
>> value it will return from v4l2_fwnode_endpoint_parse()'s error case handling
>> block.
> 
> Indeed, but it seems that the return ret at the end of the function always
> returns 0?  If that is the case, return 0 would be better, as one can see
> that that code is only reached in the success case.
> 
> julia

Hi Julia,

Noted.

@CJ, Thanks for comments.  Understood the point of Nit.

Will update the changes.

Thanks,
Sundar

