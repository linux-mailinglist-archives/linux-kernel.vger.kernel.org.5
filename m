Return-Path: <linux-kernel+bounces-21146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DF9828AB7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 18:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12DAF1C23B67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6851A3A8EA;
	Tue,  9 Jan 2024 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j99ANECe"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB53B185;
	Tue,  9 Jan 2024 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6d9bd63ec7fso1583377b3a.2;
        Tue, 09 Jan 2024 09:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704820150; x=1705424950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6I/UzxeeSAED7iM7HDuJTONIJ2KKw54eiBxBJsUAF1c=;
        b=j99ANECehDGuuocIYMlunulYX+Vl6XBPhix7rb+nd9hp/7xCQqvq+hbrFxVyLHyPkX
         nXCRiHqAiTq1+RbxWuraVjrChCv32HafQKqhWWYxQyF2P7Pf9ONtK4eVAQr32dsRZ2LT
         +YXPrqweonyHxGWWK+rh3VfvC+iQY8zOX3VpYfaCXZ2sfzvv+T5WRyLU5cH/8kAkJA7y
         7T6Oegj98jkQfPW5PdBCvLxQlpCWm4vdhBexUo9+ZFHxHWnnn6sLN+ooysadTWf9Ltz5
         4o4ch/WI2U0kwEydux2yymGKe/TEa/SINNHQLYj6e3Cs66GAm0fzOicBjy142xloFscS
         soBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704820150; x=1705424950;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6I/UzxeeSAED7iM7HDuJTONIJ2KKw54eiBxBJsUAF1c=;
        b=esJVhO8atwYwjci0nH20sXcEMkVvST3ZWuqMX9tDHIoz0rYVxAKTaqTBVqFEdnKFca
         3LdvrJ59vtfTBwBMAfDjz7IJMa5ggsnLEJj1Tcu1PqP/qkulGddaaPBaEe3IWbI1YE8t
         ODwETJXu1TbfUhsQKeLcogxYcBWUeLkvSLgns9cA8tQj9twFWp6B6YGW55h4BqCbeTij
         m5kvTqUiIV3VSOS6FGMIz1jPhytWgcmFCs+GLfKl1dVIQIj9NLRqSTDj4Erfxctir45W
         4Y4n3JCt9mOW1Dy466hQBr1ECXlx6jRNwXIFHn+R2OphUvxXITMNsp2RcaJ/oWhwFz/h
         N1Hg==
X-Gm-Message-State: AOJu0YwhHFma3Xs/M6UR8I+gKrc0vjwMGw6D50X+p4ikElFpfPLDZR1n
	7dXsrdbjaVaGo5qpsiJYRyU=
X-Google-Smtp-Source: AGHT+IGbHBY87b9+cLnBphbm2WrEUcTqTZw78s+6rmXGcCu4D5i3IsBr6slXU6F3gt+g15APEjnJqQ==
X-Received: by 2002:a05:6a20:a104:b0:19a:13f0:d739 with SMTP id q4-20020a056a20a10400b0019a13f0d739mr166549pzk.38.1704820150114;
        Tue, 09 Jan 2024 09:09:10 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p30-20020a056a0026de00b006d99c6c0f1fsm1904760pfw.100.2024.01.09.09.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 09:09:09 -0800 (PST)
Message-ID: <9e1bb616-35b9-492c-be9a-011943b59d0c@gmail.com>
Date: Tue, 9 Jan 2024 09:09:00 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] arm: ptdump: Rename CONFIG_DEBUG_WX to
 CONFIG_ARM_DEBUG_WX
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linux-hardening@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-mm@kvack.org, steven.price@arm.com,
 Phong Tran <tranmanphong@gmail.com>, mark.rutland@arm.com,
 Greg KH <greg@kroah.com>
References: <cover.1704800524.git.christophe.leroy@csgroup.eu>
 <d651269a681150f9bdca8103434fb3f4b509f784.1704800524.git.christophe.leroy@csgroup.eu>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <d651269a681150f9bdca8103434fb3f4b509f784.1704800524.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/9/24 04:14, Christophe Leroy wrote:
> CONFIG_DEBUG_WX is a core option defined in mm/Kconfig.debug
> 
> To avoid any future conflict, rename ARM version
> into CONFIG_ARM_DEBUG_WX.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Looks fine, you might also want to 
s/CONFIG_DEBUG_WX/CONFIG_ARM_DEBUG_WX/ in 
arch/arm/configs/aspeed_g{4,5}_defconfig so there are no surprises when 
people pull in those changes.
-- 
Florian


