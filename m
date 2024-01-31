Return-Path: <linux-kernel+bounces-46771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AC78443E5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB8D1F2B45C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660D412BEAC;
	Wed, 31 Jan 2024 16:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PqakqdRv"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E9012A15C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706717773; cv=none; b=NprGkMEnFyFuqN9HqjQwRXGIRkj2gdSzOMxuqzC7crXHjaS7znwuZ0wK3Fu159Ubc1OfkQNM6clR6vjLEb7+OJ8IJAYdFtbPbv+fEQTUzJyTA+TniZpy9cravr8pzVJP9YHHdtzn6WiF8uaRahtH0D39p+1zvAeVcUFIgVteDu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706717773; c=relaxed/simple;
	bh=+wYHOH0sY+bbKWDIz+zxEqp0+Fflu1jjg0LhFxkOhBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kY9b/KE1LFZ4HLLXjMR5B3v47eygDQweH/FAWJAAKMhNcBpcpJWswykgWGOd47QYaKg9wbsxpZ7trCt9NCUPm9LQww9vwLbbqAEpQoxUtUtfTEW7PhgImvthkmNEvKRrTQZhNlKiNbzKZenzCYTEsU8qg+xTJhGLjsogt4V2gbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PqakqdRv; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d8f3966982so20199895ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1706717771; x=1707322571; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uU0ajicxi4sJuGXVspRxCJUdD2UpJBefkUcjwQaeEz4=;
        b=PqakqdRvbaJbYIIok37Ulowfu+Mfp3r0XlkbqkxzaV6qaDa8FG74JZnXesIMXr0tqA
         aQBSYi/r1TubIvUosrIVZ5O/7aMitlUlDE4ZwEWphlBD617zJI8FpoCky+MvBqVXZOHW
         Ybe+AbCyh94qEfyXN/6NGCCX7KcXLroQ4rbrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706717771; x=1707322571;
        h=in-reply-to:autocrypt:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uU0ajicxi4sJuGXVspRxCJUdD2UpJBefkUcjwQaeEz4=;
        b=kR9qr2E+ZXJojsYsnvtiSY7aFRxF0pBiUslMp5eI+qqEYts7px+uQhym2IC/Rj7gf8
         5Na8bLt7L7dd6O65veiq55NpqmCDtPozrNBqaOiicP506z+9dWH90+Dlf0kBm2jpCcyg
         AjaTu7Phop7bA2nSUzSBdYR1SIAkSxwyVyDtDeDGeQ/HXMtthVqiqArKb5BftJN5Sler
         yPCJeyYGb8aTF5YWffbaKIONM7XjtfEnZbhNporPlcPRnSoYHMXqjGRfzeEn4tdo3Cna
         gyW0DaYB19dGyIiQDByOQZh4O2o/4RYPyUTrQkQufQ7MbcOacFg4GQscr+V7gFSXtPFo
         7kFg==
X-Gm-Message-State: AOJu0YzV6p2gl+QP2bImSH3EjD6dY+dDEuwqY5F2V9dxj3cxuAN/JdNz
	Mzq1wrLD+FsGKunDM5PtNiuroytSWaDhJwI46yJ2tBq8/qIsrWY4gtn3D4t1xg==
X-Google-Smtp-Source: AGHT+IGbFr+HZwjDoQapkL+FLbfqQONw9jTN2X5BiXd3q6pUh2kUOPjJLGGqClIk9riPLRLqKvb0hg==
X-Received: by 2002:a17:90a:f309:b0:295:f83d:590 with SMTP id ca9-20020a17090af30900b00295f83d0590mr1056461pjb.27.1706717770734;
        Wed, 31 Jan 2024 08:16:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVdkRxGbq+gEYnc14HAzV9/To+A86PBS8zS5gXdqdZrhsWbXCSKZakH+kHU8IiAe6RgHX9QeTDDmbvXhc6pAqVzxmZ9xyclXGe4OLP0SF2Z6gbqgKPne4tq8ih+3N6ViRoZsChvfrHm+dgcQsBGFlnIXXvpagEsq5O3I+jJ+1wYCwa4ssGv0Lo809noc+dV77ahJ2ZvGK2WmGtgaUmCJKEi83nCo8s7dXmrHZbBpIK9A4BPbWHdYXUlKCfsz45+yLcyl+U9STm+PlPANwHPZ3vjXRNTIhTLO4Bqu8NG+w/MgQPrDlrV0A1DjhrpVReW0iWUPIoLsqsnFzSDsKVFw0at3Q0gKfsX5WJ7nK3MdgpTcpvetVdBKQ52Mh9RM6nCAKfsoTGPuvJYMgV+YqK/nAuyhOeNHGqVabbEJlR5HcA=
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id so10-20020a17090b1f8a00b00290701c8623sm1636032pjb.28.2024.01.31.08.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 08:16:09 -0800 (PST)
Message-ID: <28b48c2a-37ab-4d20-a6f1-d12141c192ba@broadcom.com>
Date: Wed, 31 Jan 2024 08:16:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: flush: don't abuse pfn_valid() to check if pfn is in
 RAM
To: Yongqiang Liu <liuyongqiang13@huawei.com>,
 linux-arm-kernel@lists.infradead.org
Cc: yanaijie@huawei.com, zhangxiaoxu5@huawei.com, wangkefeng.wang@huawei.com,
 sunnanyong@huawei.com, linux@armlinux.org.uk, rppt@linux.ibm.com,
 linux-kernel@vger.kernel.org, keescook@chromium.org, arnd@arndb.de,
 m.szyprowski@samsung.com, willy@infradead.org
References: <20240131125907.1006760-1-liuyongqiang13@huawei.com>
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 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
In-Reply-To: <20240131125907.1006760-1-liuyongqiang13@huawei.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007b11af0610403249"

--0000000000007b11af0610403249
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/31/2024 4:59 AM, Yongqiang Liu wrote:
> Since commit a4d5613c4dc6 ("arm: extend pfn_valid to take into account
> freed memory map alignment") changes the semantics of pfn_valid() to check
> presence of the memory map for a PFN. __sync_icache_dcache() should use
> memblock_is_map_memory() instead of pfn_valid() to check if a PFN is in
> RAM or not.In Some uio case we will get a crash on a system with the
> following memory layout:
> 
>   node   0: [mem 0x00000000c0a00000-0x00000000cc8fffff]
>   node   0: [mem 0x00000000d0000000-0x00000000da1fffff]
>   the uio layout is：0xc0900000, 0x100000
> 
> the crash backtrace like:
> 
>    Unable to handle kernel paging request at virtual address bff00000
>    [...]
>    CPU: 1 PID: 465 Comm: startapp.bin Tainted: G           O      5.10.0 #1
>    Hardware name: Generic DT based system
>    PC is at b15_flush_kern_dcache_area+0x24/0x3c

Humm, what Broadcom platform using a Brahma-B15 CPU are you using out of 
curiosity?

>    LR is at __sync_icache_dcache+0x6c/0x98
>    [...]
>     (b15_flush_kern_dcache_area) from (__sync_icache_dcache+0x6c/0x98)
>     (__sync_icache_dcache) from (set_pte_at+0x28/0x54)
>     (set_pte_at) from (remap_pfn_range+0x1a0/0x274)
>     (remap_pfn_range) from (uio_mmap+0x184/0x1b8 [uio])
>     (uio_mmap [uio]) from (__mmap_region+0x264/0x5f4)
>     (__mmap_region) from (__do_mmap_mm+0x3ec/0x440)
>     (__do_mmap_mm) from (do_mmap+0x50/0x58)
>     (do_mmap) from (vm_mmap_pgoff+0xfc/0x188)
>     (vm_mmap_pgoff) from (ksys_mmap_pgoff+0xac/0xc4)
>     (ksys_mmap_pgoff) from (ret_fast_syscall+0x0/0x5c)
>    Code: e0801001 e2423001 e1c00003 f57ff04f (ee070f3e)
>    ---[ end trace 09cf0734c3805d52 ]---
>    Kernel panic - not syncing: Fatal exception
> 
> Fixes: a4d5613c4dc6 ("arm: extend pfn_valid to take into account freed memory map alignment")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> ---
>   arch/arm/mm/flush.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
> index d19d140a10c7..11ec6c5ff5fc 100644
> --- a/arch/arm/mm/flush.c
> +++ b/arch/arm/mm/flush.c
> @@ -15,6 +15,7 @@
>   #include <asm/smp_plat.h>
>   #include <asm/tlbflush.h>
>   #include <linux/hugetlb.h>
> +#include <linux/memblock.h>
>   
>   #include "mm.h"
>   
> @@ -292,7 +293,7 @@ void __sync_icache_dcache(pte_t pteval)
>   		/* only flush non-aliasing VIPT caches for exec mappings */
>   		return;
>   	pfn = pte_pfn(pteval);
> -	if (!pfn_valid(pfn))
> +	if (!memblock_is_map_memory(PFN_PHYS(pfn)))
>   		return;
>   
>   	folio = page_folio(pfn_to_page(pfn));

-- 
Florian

--0000000000007b11af0610403249
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
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILTlRvNM9lXPZVsQ
c5Pv+gy9C7/cAZ6Hq/fCc8xJiIaJMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTI0MDEzMTE2MTYxMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBbLoWQwMzTy+whEFovOC7PRmJy3P0GOGJ/
1hiw4jisxJ0GAx0zA9rVzfn2OKTCIlu7uF4p5hSPluQk9fNAlc6FFmIwCOXgbmZ6kVqCq9rxUS1E
mGIv+OB2+p/dyJWtZGfAeUnGEB7jjcwqJeEygg0dz5KghDxXMUTFA5sJpHbdAP26GShfU7xOjUT3
avQYq4cblD1luf8oW47lZCCa3NO5ofFkSZXR5kLayKdtfNxgw7uZ2w9dVl7TIuCv4JG+l0nzQHMe
6DPJ4mM+AbJXvvEboYC7x7EfAeZTJqe5Im1jpHTJTDGihGHpeDTl4g7/dFBVozMAOPjcz+lM4eIu
j3gy
--0000000000007b11af0610403249--

