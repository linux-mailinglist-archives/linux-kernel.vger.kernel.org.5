Return-Path: <linux-kernel+bounces-91847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D9887176E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B98C31F22531
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6717F7EA;
	Tue,  5 Mar 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="LCDGbDCw"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD91E7E59A
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625148; cv=none; b=kCPAF54tnWmCRP5vsEwklElyLMgQwgqCpsCl+Q3pa/Kq+EfTDBd6SRVvWc6en0rnvg1vCkvaaMPPuyw7pjyRQTo+miacXR+UpUpXK0lyW8oSP9q8FD5rl/TkfK915id8VAPP/yHgWB7DE3BHX7s62PPP68YxdzzHoNqf3s7oORA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625148; c=relaxed/simple;
	bh=+AQlQK0Lza0f5cu21CkeCnxElnTqhZNcxRlem6VN6L0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xl3Y0vheXZw5/wxP1qULyJupZ2Vai80XA+7Od8CaqeCsQ3gwalIZS4OaK0QqH1hY4XuH1Bs9VlYq7SrCrwLEBSgcvNB1tTvAxPcxTRx4QtGS1XgAFqVR13xKyFHNKR7qtXYqw5D6ajR/qDAoMVIAEWUUmc0KWGe6MA3D5Xcxz/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=LCDGbDCw; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709624839; bh=g5kgWxn1NIxh/U33f+1njLKEvQkBSk5gIYUqK8r5evU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LCDGbDCwYGUQi+o2l4zqRcEZaCrkX297/Y6vTVxmHzBk4eepQgpJx2YPZgJkb+d0T
	 z55wijeuGIrkDXeRIk38CZ9/FufV354Ql58pax6cLzTv+Y7Jaka7yJKN0W8SI13wyt
	 NAe3FZK4vqAzxBNDf38xUfUetxUzxGId+P2i/OFU=
Received: from [IPV6:2001:da8:c800:d084:f0c8:5d03:8100:4abe] ([2001:da8:c800:d084:f0c8:5d03:8100:4abe])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id BCFB4E35; Tue, 05 Mar 2024 15:47:15 +0800
X-QQ-mid: xmsmtpt1709624835t312y5jks
Message-ID: <tencent_E56A833916E00EC7B4840C34FAF1250ADE0A@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9Xa8SSBDSIszojUPOQR3Pu/YiSKnZ9CLUlp33j5I4BOid6UBpNni
	 k0FZVOccwXNfc6U3Gk2ep4umWe2WreSNJpgnico/BladWbJulFvtIJ640xgIS6L++jcew4UWTlR3
	 V2udqtjWFqXUEm9nO4o3JHRxrm1mluMwBFtOY4M5WX7+8f8lKJdebMzqlKAy7X36UnyoTyCvhKN5
	 33mfbM1t2mzcDPa1IX8cuJDiE9h2pwMBYQJHFyMjXIJTpq2RxmIG1Neq4hjT9Y5L0tMBo5d3aOCx
	 xFYL/rarWRKEZv46xrrJRt1ZGxUxXT5Jses+xQWME63PA8pp7wS9Px6RFi7KzY3YBt3rH7qTwa82
	 UCV/zNu89FpSV6notQosadR8xoHVIfjjVBoNcyDHdtehGS46YrMmS+xsRqcVpOtASGLJBbquX/2O
	 xDjp64aZmsiaX++BnbZ2jwdFBY6lQmGEysXk+PuvBcMWHdNpA91T5phc6DofwzNz8TAaHxEllH0w
	 B1IaCKoPS0kRkQvXNQuEnWfoX30Yo+wZ4WXFK0/RNi0MrahUmAdDGpzpoGjY0Dai9aPKuxDiZR7w
	 bZ+ZblwIu91JhbF/9yHCjYiiCWDC20A+6DKuVSj/+aKUzRkGJFTyiTX8Nx4KXlW4DCsf1P3eRSNn
	 IZ1GXAimu3gC4vA624z8JqOhJMzOUvefatPu8x5alvcYp2rnl4fklz+Mp4SIRSonX+85Zl/V9n0y
	 N7QEO0tGlzjCy+fu64bi39/zRM4nnzKrUdnr6LoeOO3FQkUJw5YwAEy5+c/YjuCDEDN8rsNgN5EF
	 X5eKadoM9zjR7g2sGtWApTsOVwcYXiwEBZzUcrE0V8TbVgm0JBxO+xa4yxeb0FKUyIOQcMkWJUa6
	 6cPUPjSOePfkVTLQdM5//+UipMwTU8uVv0mr3y8BQY/yn2Bni+o2SfWIt/4oyOB+jCwGwEzGH7zG
	 rQqUipDJK2veb7DniAdVVtPRM1MTQhkYXalaxZLVKUcV22g8Y+DQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-OQ-MSGID: <cd8da084-4021-4bcb-86da-e7295589c8f1@cyyself.name>
Date: Tue, 5 Mar 2024 15:47:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] riscv: Kconfig.socs: Allow SOC_CANAAN with MMU for
 K230
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com>
 <tencent_0432DA968E39B81431F921F38D747C008208@qq.com>
 <ef8df22f-dac8-4652-bf17-d10254e6abfb@kernel.org>
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <ef8df22f-dac8-4652-bf17-d10254e6abfb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/5 07:46, Damien Le Moal wrote:
> On 3/5/24 06:05, Yangyu Chen wrote:
>> Since K230 was released, SOC_CANAAN is no longer only referred to the K210.
>> Remove it depends on !MMU will allow building dts for K230 and remove the
>> K210 string from the help message.
>>
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>   arch/riscv/Kconfig.socs | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
>> index 623de5f8a208..b4e9b7f75510 100644
>> --- a/arch/riscv/Kconfig.socs
>> +++ b/arch/riscv/Kconfig.socs
>> @@ -75,13 +75,12 @@ config ARCH_CANAAN
>>   	def_bool SOC_CANAAN
>>   
>>   config SOC_CANAAN
>> -	bool "Canaan Kendryte K210 SoC"
>> -	depends on !MMU
> 
> This seems wrong to me. The k210 support does require no-mmu. So why remove
> this ?

It just allows SOC_CANAAN to be selected when MMU=y. With this patch, 
nommu_k210_defconfig still works.

> Does the k230 have MMU support ? If yes, then I do not think these 2 can
> fall under the same SOC_CANAAN.
> 

Yes, K230 has MMU, you can see the bootlog from the cover letter and the 
dts patch [6/7]. Could you provide some reasons why it can fall? I 
didn't see any differences in .config after this change after executing 
'make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- nommu_k210_defconfig'.

>> +	bool "Canaan Kendryte SoC"
>>   	select CLINT_TIMER if RISCV_M_MODE
>>   	select ARCH_HAS_RESET_CONTROLLER
>>   	select PINCTRL
>>   	select COMMON_CLK
>>   	help
>> -	  This enables support for Canaan Kendryte K210 SoC platform hardware.
>> +	  This enables support for Canaan Kendryte SoC platform hardware.
>>   
>>   endmenu # "SoC selection"
> 


