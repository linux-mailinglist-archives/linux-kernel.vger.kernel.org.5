Return-Path: <linux-kernel+bounces-121290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EBA88E4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC80D1C2BF9F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882B0132499;
	Wed, 27 Mar 2024 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6ZQOJD4"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7441017BB3;
	Wed, 27 Mar 2024 12:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711543217; cv=none; b=SoIJRGjB0+FNp+Unip7W7unZYb/uAY0EzW09B0Gk/EDsafJfpFiud6adnTCoUZB58Szeq4e9T7UlKZhDOtI/rpEgcU0KLjyVsWBm61XKP/OT3SuwML+W3IwB7ReIoVjl/uHuiftD/P7Th5wuvc45iiTNz4wX7ctXqaiXBp875u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711543217; c=relaxed/simple;
	bh=vqrJ5VzMfXlx/Y9j1KWBiClOP7ga73CZKpxbeFf1/iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxL829uBtfF46QH34pRp85bV77kcejELCH+nkOyEQWnLVd43HljD7TQ07KAqLdz2E1bF+2b3LWQCOo0/kBF1PXpkX299lO64A8Eyffu8noz8wyJQste26lOp0ZXAlCi0sUEoA2UNFUSWxHy5sQiKNlISuHQpBLQMSi292CjPhjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6ZQOJD4; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4d42d18bd63so1650063e0c.2;
        Wed, 27 Mar 2024 05:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711543214; x=1712148014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g+FXAXUoAMddOfVyu1X6NS/tcVaDCZa54BSmGD3WKj0=;
        b=V6ZQOJD4uQTCc7vRrQHpxKMmN/Cx8i8RA2nD+me6D1SCOW6gnDCqm/pK0X2wIdIRG1
         pfB0wr242Htr+KIpfwJjZRr2XZfX2hElESv7iD1HVpajizJlTZrfFMA3vLc9qyUPFwTg
         T+7CinjkVlunr9dnWi8WkBtaayxoyY0A6bbRJolLFIaVt2ZGxZ8uUMZqunK9XYzFnWT+
         fTndf1gjS7acDG2kfGgCVIrVN9B3boypVpfyZWyZmtTghTFwrZIQctkG+ssHfvWOoluw
         0Zdv7b+uxjY7B5w33jBWhbr9xAyC0wu7610G6VTgeg0DV6VczKCa3GRUtXPVoQkX2rIm
         JOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711543214; x=1712148014;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+FXAXUoAMddOfVyu1X6NS/tcVaDCZa54BSmGD3WKj0=;
        b=dv1jYeqeXotVncpuNzcu6PIYda7IUdierPRhbeFy/TXBGBOYoHxPqUIihAB+OSHrYJ
         G4yIrYDzO9tS7uEcXyCNUF8MhjGShATaOwvU1xqM7OTt0WduijkQFX+K4rx7bgRHq7WK
         uE/dqPTFSvrgLVuoq5iMiW2acLgczv2Y7sphYlAT7rwKLoIlr7JpSqXXmcpvLlCTOO+2
         pZuwSCSqItBhVwN/vFVSpPcrgKhSN2kcax8LWLY44EEa5itLOy9oMPy2gP/n+t45tobY
         R9XUXfaAJnMy/6IUWKVJ3yLeRbtriKRShwh5mxZOOc+Y9xEJ4aDxpZ4deA7WDGciX81w
         mm9A==
X-Forwarded-Encrypted: i=1; AJvYcCVGIPF2G2vFOvnX57hFzv/LNaw9Z7E03RpDequKsF+wdncED6x/dibHl9eNSWisjx6klaB8aMsdCihHPRmGTMFLwnJQbiSya9wJrKhK
X-Gm-Message-State: AOJu0YxQ65qnnRh5Yw+dX60P0Ri8XZNf4uRrGRixH2t5Ir8KuZQsy78f
	UDFM3gUshCaZsAQlWSf4QImLcolIIlZGmCs9LImuzhobyRv4xx+e
X-Google-Smtp-Source: AGHT+IG+QqyfVfcgfscx8Fy+bRpptm/CI8N+Y+dZgq/zSf4MqiSE8oqdVAYjXsaLGmSda22GqYniTw==
X-Received: by 2002:a05:6122:3983:b0:4d8:7339:4c35 with SMTP id eq3-20020a056122398300b004d873394c35mr862861vkb.13.1711543214355;
        Wed, 27 Mar 2024 05:40:14 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id t3-20020ad45bc3000000b0069697d41adfsm2284331qvt.55.2024.03.27.05.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 05:40:13 -0700 (PDT)
Message-ID: <6620d1c1-4178-413e-b090-dd2a9ba9abf3@gmail.com>
Date: Wed, 27 Mar 2024 05:40:10 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] net: txgbe: fix i2c dev name cannot match clkdev
To: duanqiangwen@net-swift.com, 'Jiri Pirko' <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
 andrew@lunn.ch, wangxiongfeng2@huawei.com, linux-kernel@vger.kernel.org,
 michal.kubiak@intel.com
References: <20240322080416.470517-1-duanqiangwen@net-swift.com>
 <Zf09VnR2YI_WOchd@nanopsycho> <001201da7fe6$3aa37f10$afea7d30$@net-swift.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <001201da7fe6$3aa37f10$afea7d30$@net-swift.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/26/2024 6:29 PM, duanqiangwen@net-swift.com wrote:
>> -----Original Message-----
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: 2024年3月22日 16:12
>> To: Duanqiang Wen <duanqiangwen@net-swift.com>
>> Cc: netdev@vger.kernel.org; jiawenwu@trustnetic.com;
>> mengyuanlou@net-swift.com; davem@davemloft.net;
>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
>> maciej.fijalkowski@intel.com; andrew@lunn.ch;
>> wangxiongfeng2@huawei.com; linux-kernel@vger.kernel.org;
>> michal.kubiak@intel.com
>> Subject: Re: [PATCH net v5] net: txgbe: fix i2c dev name cannot match
> clkdev
>>
>> Fri, Mar 22, 2024 at 09:04:16AM CET, duanqiangwen@net-swift.com wrote:
>>> txgbe clkdev shortened clk_name, so i2c_dev info_name also need to
>>> shorten. Otherwise, i2c_dev cannot initialize clock.
>>>
>>> Change log:
>>> v4-v5: address comments:
>>> 	Jiri Pirko:
>>> 	Well, since it is used in txgbe_phy.c, it should be probably
>>> 	rather defined locally in txgbe_phy.c.
>>
>> Did you read Florian's comment? Please do.
>>
>> pw-bot: cr
>>
> 
> I replied to Florian:
> " I want to shorten "i2c_desginware" to "i2c_dw" in txgbe driver, so other
> drivers which use "i2c_designware" need another patch to use a define. "
> 
> He hasn't replied to me for several days, what should I do next?

You emailed me directly rather than do a reply-all and have the mailing 
list copied. At any rate, you are only changing your internal clock 
name, so my suggestion to standardize the 'i2c_designware' string beyond 
your driver did not really make sense.

With that:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks!
-- 
Florian

