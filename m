Return-Path: <linux-kernel+bounces-88925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1732F86E875
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375F71C20F54
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BED2AE72;
	Fri,  1 Mar 2024 18:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iX0zcOkQ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B451CA98;
	Fri,  1 Mar 2024 18:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317961; cv=none; b=sSpFvd+s9uN//SWHf2xI4NHUAiAu/hRQCwK7hNl5W7X6q+ze4qJZGrtOr1KbTNfFvsrK+6JpCX00nFqWB8sGINgtkONpoKHHnxTWW/tQkUD2JRp+XM8pSk7jQx0AmmNlJkIfGNObJXeE8Jjr0T3Gb3FbHRwXRtmaIDBU5dzXPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317961; c=relaxed/simple;
	bh=JcNEXE4QsOGmgDGsC9eZ1l1kLpaRnMvu5OL2pM2/sQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSsmqbzOk0rc9GsTYoNZiFYCO/nNPBzYYJ58ALnm73pZVICS45ler9VizaxVGUa+OICaI1OQL8UCJxwVmpPM1cbAhZs0zLfsi9GDSmfFCdAq+orbCjWRkc40LvqthP4R3aZM54KyjX09cz7NPk44F5/rdM8Bfqb3tUiWfYr+he0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iX0zcOkQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e4e7e25945so2119599b3a.1;
        Fri, 01 Mar 2024 10:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709317959; x=1709922759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2zoWd69/c/xQwKCc5kew80N1OSNY2Vy38NtdpoKdy7s=;
        b=iX0zcOkQMfif8qXNPgHwQC0XENB9L4mgdTPCv+zqgce3uAtEzCgl4lmH8lHWB83AUm
         a3U85cbGAtpMoBRvSxq76FZbLC1+jU3HmwTKKVWpStiZI3WdmFWpjjdGI17jSpelUvAn
         SuK/hazjuY1q/4HFl1oL9BSe2rDD/VySLDiBoySzVgMvTUaqvDGO7GITRg/DWu2jFxl8
         Y9FqLbDO2Pp/BXddqgN8sJoYWvdMUxOwr1Nr0T04oGDjfJlRp+2cymDmgEdQj8OQ2isU
         fQdvfaTArW7mShESXEtq6jN4UwWwTm+PDvbAc7Fictiknb/IOJJw0yTTssrPiMmhy9Er
         xoDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709317959; x=1709922759;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zoWd69/c/xQwKCc5kew80N1OSNY2Vy38NtdpoKdy7s=;
        b=cQrdwoA6C74wzVuoQVRoEobLIm1545MmsV2haS0mcYddGjccL7vy1nMI+3svTnEfCJ
         qxSnNJriUxs41Z6ntmrbavz8sTn4i/a2R8r6nlwJ7bDsAbTjzNgCPSrcs3fq4DMxeEiK
         nUH1UeVt1leG3AkWROCPxCOg35y+Cw5/LqhKMa6xWxpS0jbToHfjrCuOf8xyJRW1nMwY
         RaZr4FrrIEBLCXwI0TNvP6L9u5pFDKHYJ7SxUIfEh2LITvWTCLUFrVPowvaLy4LEau2o
         k2+nA0t3E4gz+NTbqfzrjZs39bCoEeeVCT2mOq57sMDwjSLCYx6A+2m3lklzcptXrpBS
         w+Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXwj/iMJxtRy/seJKr30dFnGSVDx/gewPa0wa3+jGk28bec2WHjdMyfDgIpU7sPE+zadgj4xDX4/zph8i4Wf3HdXJQUuTLx8MX6dS1W
X-Gm-Message-State: AOJu0YwVqGIOGL4LsBtErMaALlR21zf518jcn+WvidZs+uolJOKXGM90
	5TtrfwMzRA80Pfk/QyqJWbmyi1WjF/B5AgTsrv+MdGQRpkB2bfR7zSwMGB5H
X-Google-Smtp-Source: AGHT+IHsA+kb0mWbpTYQCUVaXWYI46NMqQyK9ULCROTbAMQoO57zD9zDCfCi7BCHjj2m5R7WoZZK+g==
X-Received: by 2002:a05:6a20:3d06:b0:1a1:3cff:874e with SMTP id y6-20020a056a203d0600b001a13cff874emr2095148pzi.8.1709317958607;
        Fri, 01 Mar 2024 10:32:38 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b64-20020a62cf43000000b006e5a915a9e7sm2368344pfg.10.2024.03.01.10.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 10:32:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <62b69aaf-7633-4bd8-aefe-5ba47147dba7@roeck-us.net>
Date: Fri, 1 Mar 2024 10:32:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann
 <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
References: <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 14:46, Charlie Jenkins wrote:
> The test cases for ip_fast_csum and csum_ipv6_magic were not properly
> aligning the IP header, which were causing failures on architectures
> that do not support misaligned accesses like some ARM platforms. To
> solve this, align the data along (14 + NET_IP_ALIGN) bytes which is the
> standard alignment of an IP header and must be supported by the
> architecture.
> 
> Furthermore, all architectures except the m68k pad "struct
> csum_ipv6_magic_data" to 44 bytes. To make compatible with the m68k,
> manually pad this structure to 44 bytes.
> 
> Fixes: 6f4c45cbcb00 ("kunit: Add tests for csum_ipv6_magic and ip_fast_csum")
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> The ip_fast_csum and csum_ipv6_magic tests did not work on all
> architectures due to differences in misaligned access support.
> Fix those issues by changing endianness of data and aligning the data.
> 
> This patch relies upon a patch from Christophe:
> 
> [PATCH net] kunit: Fix again checksum tests on big endian CPUs
> 

Various test results:

On v6.8-rc6-120-g87adedeba51a (current mainline), without this patch

- mps2-an385:mps2_defconfig crashes in IPv6 checksum tests
- ipv6 checksum tests fail on parisc, parisc64, sh, and sheb.

The previously seen problems on big endian systems are still seen with
v6.8-rc6, but are gone after commit 3d6423ef8d51 ("kunit: Fix again
checksum tests on big endian CPUs") has been applied upstream. This includes
the test failures seen with m68k.

The parisc/parisc64 test failures are independent of this patch. Fixes are
available in linux-next and pending in qemu. The sh/sheb failures are due
to upstream commit cadc4e1a2b4 and are no longer seen after reverting that
patch.

This leaves the mps2-an385:mps2_defconfig crash, which is avoided by this patch.
My understanding, which may be wrong, is that arm images with thumb instructions
do not support unaligned accesses (maybe I should say do not support unaligned
accesses with the mps2-an385 qemu emulation; I did not test with real hardware,
after all).

Given all that, the continued discussion around the subject, and the lack
of agreement if unaligned accesses should be tested or not, I don't really
see a path forward for this patch. The remaining known problem is arm with
thumb instructions. I don't think that is going to be fixed. I suspect that
no one but me even tries to run that code (or any arm:nommu images, for that
matter). I'd suggest to drop this patch, and I'll stop testing IP checksum
generation for mps2-an385:mps2_defconfig.

Sorry for all the noise this has generated.

Thanks,
Guenter


