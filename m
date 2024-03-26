Return-Path: <linux-kernel+bounces-120034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8E88D093
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47952328EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8422413DB9C;
	Tue, 26 Mar 2024 22:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDGImm8/"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730313D538;
	Tue, 26 Mar 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491148; cv=none; b=RUEw/f1NrxkUTWXF136M4U8QAz2zQ8Wi64XmO6cUHTrOXGQY+43AEqSp1EVIb5mmjLH5tCFn8qNq9s9TbWEepXIpHmNho92gzKrQq0eXhRZXuXHQC8f0MOr5ezaVlTsf/A8pUWoqzyhff++verojkU0U6eY5FHVo2Z8mGbU6nus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491148; c=relaxed/simple;
	bh=+wYDyMnpKuLqfY43YpqtSm34ANzOiArR8y162hs7Fgw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BY8qsIzOsPF7xmS8V3u7UIDO9RYDpOYz0MLPVOQXHom7TeqBlWg18DgiCYVcXdXwfwSY15Ro1+ZldcZNtbnHCiZwjG0mpZLwQeVgwWFH+gP2JshIHaGBZ7bSd//HO/mR1e8SlG5NrBHRhYF/qH3zMJ1zqvbo3ip2PCMck9naZ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDGImm8/; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ea8ee55812so3658071b3a.0;
        Tue, 26 Mar 2024 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711491146; x=1712095946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bvrBpa6NIqmeIkXane8RW2BCIfL8oLVJSB/0WwZJE4=;
        b=BDGImm8/XBWbRuy3nrNiT+oxlBMEv6d/KvKQtygvmEUDi56DmOow8x9V+7qdnCQJfw
         gLKRdep9ADFrxnvv/jBOEP8d2JoLgpjUihBwno8WY2A45ZkTz4v4lw7yYATxfBZc9JUl
         AOArB8ItirnnOU28k0fLEpeppbR+AulP1NILljj0iacealWWnzOY4wvh966SpfdYplkL
         PXFFPqHw1u4gzLH9bBHyK2oKlIesuvNlWZeCOiBtFVn1l6M88ifXHvBfoiHoilliK4Ux
         NtFFDR9sAhaAgCmKAX6f3J5uTLm/IFVwQuOWLTHMjij4QMvvNy+h8pwUG0LDPvPnZnYH
         VBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491146; x=1712095946;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1bvrBpa6NIqmeIkXane8RW2BCIfL8oLVJSB/0WwZJE4=;
        b=FIFTgTUvRre0bU9QSNfWrB66mV8VPi1smdCHVT/uQhfHXu8ch+I3wWvlquS1qZqObK
         z0wzx+XcHJUe/evDiwjMtEL2SEYqx6Xk49H4S6SMT4Xg4fOF14MBG+chF575XNr+BKu0
         qYiyxQUghitHgo0u50KE8fDA22eR+gt7KQeMRwLa1iY7rLoY0+qHumFn+6J9pFycyvoa
         1B5Cmo/HH+tASqpj4ngZDefVsY6DuJqcoeXX8WuSdtV6FBGB3FnLFrIbB+grSVJNRJPv
         0BPQhK3fIZ6lSI+LMyNLN3Aaf8bwMn3t6sP9ksp/BfCczAiPOFNrrqHROihn8OMPxHJu
         7/bA==
X-Forwarded-Encrypted: i=1; AJvYcCVcBE00g/Vw0su03+6mZgbcRIskfZ62waJs1rYCEdh11gyzOnVyw64Mov1bSvsx0wgJHoGa47OSv0ImralIJdTDokRCC6pqoBXYYxMheig3uIUzdC1LRYXf+AcCIkqFK7Pkl6wU376JjgMS6Efri8guax2qT7azI+Vscw1i4kXmNw==
X-Gm-Message-State: AOJu0YzAqRbXPe+zf7YWeFYbOXRDfJekUH22PQ5lO0JTQDhgyRdqmtp/
	AEX1774xktdqKlDMo3lbVRcwzZilctBf/YV9w1EE/tCJb28Qbt5J2EN53YKlU3w=
X-Google-Smtp-Source: AGHT+IGGeFNHDlhY2bt27k9H3IoMCM376JL/pBz7c2YgVW0if7A3uQaiNEyUhIlMV5hbE/Hj95e6eQ==
X-Received: by 2002:a05:6a00:2303:b0:6ea:c42f:d75e with SMTP id h3-20020a056a00230300b006eac42fd75emr1855892pfh.11.1711491145682;
        Tue, 26 Mar 2024 15:12:25 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.232])
        by smtp.gmail.com with ESMTPSA id r10-20020a62e40a000000b006e6529c7d75sm6516071pfh.3.2024.03.26.15.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 15:12:25 -0700 (PDT)
Subject: Re: [PATCH v2] riscv: dts: starfive: Remove PMIC interrupt info for
 Visionfive 2 board
To: Conor Dooley <conor@kernel.org>, Bo Gan <ganboing@gmail.com>
Cc: kernel@esmil.dk, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shengyu Qu <wiagn233@outlook.com>, Conor Dooley
 <conor.dooley@microchip.com>, stable@vger.kernel.org
References: <TY3P286MB26116B828A34D614C09F4E8898202@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <20240326-create-motivate-2792be1692c5@spud>
 <f472affe-d1ef-cbdb-b5c5-76f6b3ac78b3@gmail.com>
 <20240326-ladylike-retold-9034734c2445@spud>
From: Bo Gan <ganboing@gmail.com>
Message-ID: <222340e5-b5d7-9abc-57df-ad1478090177@gmail.com>
Date: Tue, 26 Mar 2024 15:12:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240326-ladylike-retold-9034734c2445@spud>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 3/26/24 3:10 PM, Conor Dooley wrote:
> On Tue, Mar 26, 2024 at 03:06:33PM -0700, Bo Gan wrote:
>> On 3/26/24 1:37 PM, Conor Dooley wrote:
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> On Thu, 07 Mar 2024 20:21:12 +0800, Shengyu Qu wrote:
>>>> Interrupt line number of the AXP15060 PMIC is not a necessary part of
>>>> its device tree. And this would cause kernel to try to enable interrupt
>>>> line 0, which is not expected. So delete this part from device tree.
>>>>
>>>>
>>>
>>> Applied to riscv-dt-fixes, thanks! And I didn't forget, so I re-wrote
>>> the commit message to add some more information as promised.
>>>
>>> [1/1] riscv: dts: starfive: Remove PMIC interrupt info for Visionfive 2 board
>>>         https://git.kernel.org/conor/c/0b163f43920d
>>>
>>> Thanks,
>>> Conor.
>>>
>> Hi Conor,
>>
>> Thank you very much for taking care of this. Actually the PLIC may silently
>> ignore the enablement of interrupt 0, so the upstream openSBI won't notice
>> anything. My modified version, however, will deliberately trigger a fault
>> for all writes to the reserved fields of PLIC, thus catching this issue.
>>
>> Hope it can clarify things a bit more.
> 
> https://git.kernel.org/conor/c/0f74c64f0a9f
> 
> Better?
> 
Great! Thanks again.

Bo

