Return-Path: <linux-kernel+bounces-1855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667158154D8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576FD1C23AD6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842A5376;
	Sat, 16 Dec 2023 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORX7BgZf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908557E
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b9e7f4a0d7so991229b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 16:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702685375; x=1703290175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdA4va0gZa6nUIdxAUVBRHBZJl8udaeGAnDZ+2Ao6NQ=;
        b=ORX7BgZfR8AmkozpUXjmG+VZHzRcIC23pSKD5DRx+Hzk4pa12vBb/G6Aet+qFTEndN
         9pYUxmQUQBMXLVAFkCPW3L98+N/Ckokk8iJarTClUPvkKY/G56dfbyc/OOLZziHrDzJG
         cuad9cBVEEJUOnU71Vgc+KHFrL4IpA03RyovsZxTU3YCrnLjvydkQmMb7GafWSVcAgfd
         nBchsDUcMHrZ5mN0RufHzdovpoc4YbC8wN/ZKcT3EMUZVrNl9WpkoT+UIdz+nDYoo9PA
         Y3KHxYYiKmyt/BH7u0FA4xjNfOK3i/MP0PGnQf/N4KLMEUkvNyipDfjEGEEfgpoOkPV0
         fWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702685375; x=1703290175;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdA4va0gZa6nUIdxAUVBRHBZJl8udaeGAnDZ+2Ao6NQ=;
        b=TaNp0Pha0AVpnXvAUFz47ahxx35WkuztCgns+gZpItuPpT/Nz6DdKFRdp7CFNJnVvV
         rb2vhy2+mnImf7EHQyxtRue22vG16LSferze1m545ULE3ENdteXUgjhKA1Hd8VrEwi1+
         V8oHwpMJNwdzUOQEk6/oWkwTCAh30Fa5Uyr2VcMDH2Uo71/yQR38LntNQQgt3x0rn3SI
         hogYsdeHgM+f7VC1SD3oWi06fagbwcxkuXcKHEFKucq1vfkmCKpgXTCjnwwt7f2n3/et
         xb2Cm2cQRfvkpsaFmnlXD6Ayl6xcXNg0vVL4c2egi5RsfhAs06Y4H1zN6S52HApm2Ubb
         3B4g==
X-Gm-Message-State: AOJu0Yz2RryfBVSQVmzr8LTFbz+hw+ZX7ZtF6xsNJ58Tx2lXaTwouY1g
	ZP9rMkilksII/++h+ch9qs4=
X-Google-Smtp-Source: AGHT+IETrkQSURFgZazcQePnO2skiylCFTEp/72zKBWjsKkEXSPyWWepGDnybCHecw0vyPZiqgJEhw==
X-Received: by 2002:a05:6359:c83:b0:170:2e7f:bb98 with SMTP id go3-20020a0563590c8300b001702e7fbb98mr14637892rwb.55.1702685375340;
        Fri, 15 Dec 2023 16:09:35 -0800 (PST)
Received: from ?IPV6:2406:3003:2007:229e:ac29:68d8:877:4f72? ([2406:3003:2007:229e:ac29:68d8:877:4f72])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a018500b0028658657e9csm16913744pjc.46.2023.12.15.16.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 16:09:34 -0800 (PST)
Message-ID: <e60f7697-1a1a-46a4-9def-b59cae9777a3@gmail.com>
Date: Sat, 16 Dec 2023 05:39:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] greybus: gb-beagleplay: Remove use of pad bytes
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, johan@kernel.org, elder@kernel.org,
 linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com,
 yujie.liu@intel.com
References: <20231211065420.213664-1-ayushdevel1325@gmail.com>
 <20231211065420.213664-2-ayushdevel1325@gmail.com>
 <2023121559-overfed-kisser-3923@gregkh>
From: Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <2023121559-overfed-kisser-3923@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/23 21:50, Greg KH wrote:

> On Mon, Dec 11, 2023 at 12:24:18PM +0530, Ayush Singh wrote:
>> Make gb-beagleplay greybus spec compliant by moving cport information to
>> transport layer instead of using `header->pad` bytes.
>>
>> Greybus HDLC frame now has the following payload:
>> 1. le16 cport
>> 2. gb_operation_msg_hdr msg_header
>> 3. u8 *msg_payload
>>
>> Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>> ---
>>   drivers/greybus/gb-beagleplay.c | 55 ++++++++++++++++++++++++---------
>>   1 file changed, 41 insertions(+), 14 deletions(-)
> This doesn't apply against my char-misc-next branch at all, what did you
> generate it against?
>
> thanks,
>
> greg k-h

The base commit of my tree is 
`0f5f12ac05f36f117e793656c3f560625e927f1b`. The tag is `next-20231205`.

I can rebase to a newer tag if you wish.

Ayush Singh


