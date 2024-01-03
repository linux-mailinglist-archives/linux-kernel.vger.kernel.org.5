Return-Path: <linux-kernel+bounces-15867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A2823482
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF297285511
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D751CA8B;
	Wed,  3 Jan 2024 18:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="d9KqvX+e"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A61CA83
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5c21e185df5so7941067a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704306751; x=1704911551; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDNUdYKSJrbt1kOIT7+/YWZJNmzuihBswydqTVX3dhs=;
        b=d9KqvX+e4sngVVoOYeqNWoQgX0FbtWACFPOBduZ1k5NG+jX5FZlmuM2KDVBIR2BQYy
         /5saCsb7gYrRm31ots0G4caetcraHrnB07OUxrTP0yCNRlBPqPebaDMaDVgCckM0pXqM
         iFcSRGShYP7DCnSsp9YO9gGCqRnYN03HjH3Hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704306751; x=1704911551;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NDNUdYKSJrbt1kOIT7+/YWZJNmzuihBswydqTVX3dhs=;
        b=TjHZFI3mvsNjgwa5URRSnnQJpy8iF4ZD47Siq9cc+l8ISdWACP3n3rXvnpJgJ1ZnWw
         T3bk1VbAxNzNchQD6qmVcbF5GDabvpCAQ7BooKbdbT6+1SaYqeeSFxceHm8xDCLKgtqR
         ztcljg53jQ6oynwZrfBYU71QZInH3/86wt8XsgHxrwouDZ6NEkTBd2nDGku+2XxmjY7z
         m83+1FC7+/0poH87Bfj2WVR+vga8lKIifJNZqeN4q5rNe+TOEzKDA1739sq2rpjND+Ed
         p9dMsO3MbAr6hPtmqt97fNJpBwmFudscZPkSJ6UGVP4fYhGQeG0xXpsC7nz+Cqf8clSB
         h6ug==
X-Gm-Message-State: AOJu0Yz1xHrk4dJz9hRUJJsbjLnNFI5JbmwqatPxizpMxvgzLUfax3Mi
	ZJeNWcaFHOvDfDUtpRI51A1wUFvbbEtq
X-Google-Smtp-Source: AGHT+IF3FGJJpowqBbhSqiaZjV5WP86LuUmXvBGCENk6GyPvdW3WmtZ87yJDDhm9xzm/1Q5rv/CZqg==
X-Received: by 2002:a05:6a20:6d25:b0:197:ceda:2a14 with SMTP id fv37-20020a056a206d2500b00197ceda2a14mr769589pzb.61.1704306751068;
        Wed, 03 Jan 2024 10:32:31 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j33-20020a635961000000b005c200b11b77sm22706829pgm.86.2024.01.03.10.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 10:32:29 -0800 (PST)
Message-ID: <fc6f3fff-9915-4ffd-93f0-a633d5662147@broadcom.com>
Date: Wed, 3 Jan 2024 10:32:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: mm: Fix SOCs with DDR starting above zero
To: Will Deacon <will@kernel.org>, Elad Nachman <enachman@marvell.com>
Cc: catalin.marinas@arm.com, thunder.leizhen@huawei.com, bhe@redhat.com,
 akpm@linux-foundation.org, yajun.deng@linux.dev, chris.zjh@huawei.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240103170002.1793197-1-enachman@marvell.com>
 <20240103174531.GE5954@willie-the-truck>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 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
In-Reply-To: <20240103174531.GE5954@willie-the-truck>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000082cd3e060e0ed653"

--00000000000082cd3e060e0ed653
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/3/24 09:45, Will Deacon wrote:
> On Wed, Jan 03, 2024 at 07:00:02PM +0200, Elad Nachman wrote:
>> From: Elad Nachman <enachman@marvell.com>
>>
>> Some SOCs, like the Marvell AC5/X/IM, have a combination
>> of DDR starting at 0x2_0000_0000 coupled with DMA controllers
>> limited to 31 and 32 bit of addressing.
>> This requires to properly arrange ZONE_DMA and ZONE_DMA32 for
>> these SOCs, so swiotlb and coherent DMA allocation would work
>> properly.
>> Change initialization so device tree dma zone bits are taken as
>> function of offset from DRAM start, and when calculating the
>> maximal zone physical RAM address for physical DDR starting above
>> 32-bit, combine the physical address start plus the zone mask
>> passed as parameter.
>> This creates the proper zone splitting for these SOCs:
>> 0..2GB for ZONE_DMA
>> 2GB..4GB for ZONE_DMA32
>> 4GB..8GB for ZONE_NORMAL
>>
>> Signed-off-by: Elad Nachman <enachman@marvell.com>
>> ---
>>   arch/arm64/mm/init.c | 20 +++++++++++++++-----
>>   1 file changed, 15 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>> index 74c1db8ce271..8288c778916e 100644
>> --- a/arch/arm64/mm/init.c
>> +++ b/arch/arm64/mm/init.c
>> @@ -115,20 +115,21 @@ static void __init arch_reserve_crashkernel(void)
>>   
>>   /*
>>    * Return the maximum physical address for a zone accessible by the given bits
>> - * limit. If DRAM starts above 32-bit, expand the zone to the maximum
>> - * available memory, otherwise cap it at 32-bit.
>> + * limit. If DRAM starts above 32-bit, expand the zone to the available memory
>> + * start limited by the zone bits mask, otherwise cap it at 32-bit.
>>    */
>>   static phys_addr_t __init max_zone_phys(unsigned int zone_bits)
>>   {
>>   	phys_addr_t zone_mask = DMA_BIT_MASK(zone_bits);
>>   	phys_addr_t phys_start = memblock_start_of_DRAM();
>> +	phys_addr_t phys_end = memblock_end_of_DRAM();
>>   
>>   	if (phys_start > U32_MAX)
>> -		zone_mask = PHYS_ADDR_MAX;
>> +		zone_mask = phys_start | zone_mask;
>>   	else if (phys_start > zone_mask)
>>   		zone_mask = U32_MAX;
>>   
>> -	return min(zone_mask, memblock_end_of_DRAM() - 1) + 1;
>> +	return min(zone_mask, phys_end - 1) + 1;
>>   }
>>   
>>   static void __init zone_sizes_init(void)
>> @@ -140,7 +141,16 @@ static void __init zone_sizes_init(void)
>>   
>>   #ifdef CONFIG_ZONE_DMA
>>   	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
>> -	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
>> +	/*
>> +	 * When calculating the dma zone bits from the device tree, subtract
>> +	 * the DRAM start address, in case it does not start from address
>> +	 * zero. This way. we pass only the zone size related bits to
>> +	 * max_zone_phys(), which will add them to the base of the DRAM.
>> +	 * This prevents miscalculations on arm64 SOCs which combines
>> +	 * DDR starting above 4GB with memory controllers limited to
>> +	 * 32-bits or less:
>> +	 */
>> +	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL) - memblock_start_of_DRAM());
>>   	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
>>   	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
>>   	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
> 
> Hmm, I'm a bit worried this could regress other platforms since you seem
> to be assuming that DMA address 0 corresponds to the physical start of
> DRAM. What if that isn't the case?

All of our most recent Set-top-box SoCs map DRAM starting at PA 
0x4000_0000 FWIW. We have the following memory maps:

1. DRAM mapped at PA 0x0000_0000
2. DRAM mapped at PA 0x4000_0000 with another memory controller starting 
at 0x3_0000_0000
3. DRAM mapped at PA 0x4000_0000 with a single memory controller.

Here is the before/after diff with debugging prints introduced to print 
start, end, min, mask and the dt_zone_dma_bits value:

Memory map 1. with 2GB -> no change in output

Memory map 2. with 2+2GB -> no change in output

Memory map 3. with 4GB:

@@ -39,7 +39,7 @@
  [    0.000000] OF: reserved mem: 
0x00000000fdfff000..0x00000000fdffffff (4 KiB) nomap non-reusable NWMBOX
  [    0.000000] OF: reserved mem: 
0x00000000fe000000..0x00000000ffffffff (32768 KiB) nomap non-reusable 
SRR@fe000000
  [    0.000000] max_zone_phys: start: 0x0000000040000000, end: 
0x0000000140000000, min: 0x0000000100000000, mask: 0x00000000ffffffff
-[    0.000000] zone_sizes_init: dt_zone_dma_bits: 0x00000021
+[    0.000000] zone_sizes_init: dt_zone_dma_bits: 0x00000020
  [    0.000000] max_zone_phys: start: 0x0000000040000000, end: 
0x0000000140000000, min: 0x0000000100000000, mask: 0x00000000ffffffff
  [    0.000000] Zone ranges:
  [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
@@ -88,243 +88,243 @@

Memory map 3. with 2GB:

@@ -39,11 +39,11 @@
  [    0.000000] OF: reserved mem: 
0x00000000bdfff000..0x00000000bdffffff (4 KiB) nomap non-reusable NWMBOX
  [    0.000000] OF: reserved mem: 
0x00000000be000000..0x00000000bfffffff (32768 KiB) nomap non-reusable 
SRR@be000000
  [    0.000000] max_zone_phys: start: 0x0000000040000000, end: 
0x00000000c0000000, min: 0x00000000c0000000, mask: 0x00000000ffffffff
-[    0.000000] zone_sizes_init: dt_zone_dma_bits: 0x00000020
-[    0.000000] max_zone_phys: start: 0x0000000040000000, end: 
0x00000000c0000000, min: 0x00000000c0000000, mask: 0x00000000ffffffff
+[    0.000000] zone_sizes_init: dt_zone_dma_bits: 0x0000001f
+[    0.000000] max_zone_phys: start: 0x0000000040000000, end: 
0x00000000c0000000, min: 0x0000000080000000, mask: 0x000000007fffffff
  [    0.000000] Zone ranges:
-[    0.000000]   DMA      [mem 0x0000000040000000-0x00000000bfffffff]
-[    0.000000]   DMA32    empty
+[    0.000000]   DMA      [mem 0x0000000040000000-0x000000007fffffff]
+[    0.000000]   DMA32    [mem 0x0000000080000000-0x00000000bfffffff]
  [    0.000000]   Normal   empty
  [    0.000000] Movable zone start for each node
  [    0.000000] Early memory node ranges
@@ -54,7 +54,7 @@
-- 
Florian


--00000000000082cd3e060e0ed653
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIN3TZMDf3Of034RY
5h9BsVOsYCAagiHFBo8VVujHEyUaMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDEwMzE4MzIzMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDgStYj5wAhr11Yij6QuJrfXGlXVRgT/NLk
RhIXrb2EJWepKr47j2PtD1wqX7unmha1FApd/dJMuLkDi2n0l5EAiCI3AG6YUcXmZokvGJEWBNph
e8TSjfj8oWJE/Y6Y3InfUBiUEz8j+Qh57bXSng+fJHO8UMA1pFSLm55y7fSIG+3PnAklOnh8+woZ
jejgD48A7k5TRX9uRTYF/ptqVGCT/3t+J1uZ0WVevj9ILmJIwvdPTcnT4CAN317m/Z3JSUyMekrP
I9J2rs4lfgbqyDAhJkqdYFTAn3Zs3lctmU8psuaP6629SnGSJ04b0GF64isuJG9CrX0q2EW0PGbc
+UOH
--00000000000082cd3e060e0ed653--

