Return-Path: <linux-kernel+bounces-75742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C282185EE44
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 01:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39ED61F22D8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F93011181;
	Thu, 22 Feb 2024 00:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pRb17MbG"
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B0C10A05
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708562839; cv=none; b=I+kGEIluPikeKmOud2wOqUr2ERDDakgrN8eV7PGrxfoFRmUX9xla03sPGr0u5TJkCWrFPWr5LeldJDf1/v3u0eVdwwEhGJ8XdeBKdvj1WlWNSCddaciQHk7X3Ps8/tBWGjllGskYr/nbeQtIu2jt9tcuA6hwlsMe9Qf7v9tt3qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708562839; c=relaxed/simple;
	bh=TPRDg52o/XUAEJGbQcaz27E13NquY89Tp4mylzmLm5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6a4g0CAcfOJxky285u9sSk9xoBrhTiMb9h4v1Z7sgrrpnwKAtr9zwQPAbProtkkJWJsmNmFsOHqqHZXLX1lrc55JLgc0Wsm+SDDipHSyA5s5uSc9e6yWldLGtVrffopeh1QVP8W2vOX3cuflv7dDiZR8k9QmkXDshtYXotAQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pRb17MbG; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c17ac08a38so30565b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708562836; x=1709167636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PxnB8hIBaJHKU9GMJod5TzavYw729HDn9dbYWz/K8DM=;
        b=pRb17MbGCSgF084iq8gn+zcwxWgWZ7DZdI4X3SQ4AQePL32QfkTF3m/ziJYnQP1k1S
         2pMHI23BvPUIhmY0m6OkAntfXbw3EfAeUoV7KRsemjn3mXuov2AUF18H4uEs8A/atUSu
         cWNiwZoec7ZLBovAlsoMNZBRLGZZrrA0gd5CCE2WCT59gHi+190Gw527w92Mg07nGNQz
         b+aRR9ZXjcf75FYFJ8QUOhfvW/kN4lsfidpabsdKasHSFv7cW6SLjzDKcs8rJjgMEzdC
         Mzb/E9HeHazoNloEL8LElBrxh1NYpZ/mG7h3Jr74W4qoEcZCXa1P0por5A6xtMniQdWf
         2xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708562836; x=1709167636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxnB8hIBaJHKU9GMJod5TzavYw729HDn9dbYWz/K8DM=;
        b=sWuDQ9b+fXI+2tGBpMOYBFUoqhtVomfBBoH6JzeBbLGKXqiK1o9f02g+EbMo8FL33n
         1LnsjOgahiihg8tOfr/6vA3NM6m8eA643HoTwfMTlqLn5vh7P6Jry2rZTw7q+mdiTSkP
         niF4VLS4PZ4UMpEI9uZ9dYV2lsXhIEOMd8ZpZboNMl8AhO4h1vhwfzNs927g15lE6hIE
         clGpZko5or/gEBMszQPXjMWXPmkaD9d2K4o78tnwinjpMueni/23Zl67rlZKIJDVL0gi
         if9nDFy/aW4N+wvj+HdWXMDSEb9wvCQtNyqUAw7PR4jRpO9n9GhIecnw/h2px4jWrj9e
         oJWQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5+/KnPkFb9Uv/hECuB65uReWMFslktlVBJXgy6+csc9UWdxeoabKPd8Lr+4QoQcPtO4QjbTywIhQRjULV4RQc2oWldeI8ChchTkwp
X-Gm-Message-State: AOJu0YzfJ9935SnE4susEs+JdTtqmqOzBRL4Qxs4yhUnPOLZ3DvBowON
	V0zAr0SkY6E0LOM35aHuwYrgCVlIHt5IsqdhsZo/D8QWUf3Yde+wLxBlT7SQdgA=
X-Google-Smtp-Source: AGHT+IFSLTMc3hCuIYilhHI07UG+3jHSb+dOia9uI0EVHy8hIHGEMNdRSjhvd4xYo+3moab7FJoglQ==
X-Received: by 2002:a05:6808:170f:b0:3c1:5440:d2c5 with SMTP id bc15-20020a056808170f00b003c15440d2c5mr11757138oib.38.1708562836074;
        Wed, 21 Feb 2024 16:47:16 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id f10-20020a056a000b0a00b006dddf2ed8f0sm9533333pfu.154.2024.02.21.16.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 16:47:15 -0800 (PST)
Date: Wed, 21 Feb 2024 16:47:11 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Mark Brown <broonie@kernel.org>
Cc: rick.p.edgecombe@intel.com, Szabolcs.Nagy@arm.com,
	kito.cheng@sifive.com, keescook@chromium.org,
	ajones@ventanamicro.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, conor.dooley@microchip.com, cleger@rivosinc.com,
	atishp@atishpatra.org, alex@ghiti.fr, bjorn@rivosinc.com,
	alexghiti@rivosinc.com, corbet@lwn.net, aou@eecs.berkeley.edu,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	ebiederm@xmission.com, shuah@kernel.org, brauner@kernel.org,
	guoren@kernel.org, samitolvanen@google.com, evan@rivosinc.com,
	xiao.w.wang@intel.com, apatel@ventanamicro.com,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, heiko@sntech.de, jszhang@kernel.org,
	shikemeng@huaweicloud.com, david@redhat.com, charlie@rivosinc.com,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	vincent.chen@sifive.com, andy.chiu@sifive.com, gerg@kernel.org,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com,
	ruscur@russell.cc, bgray@linux.ibm.com, alx@kernel.org,
	baruch@tkos.co.il, zhangqing@loongson.cn, catalin.marinas@arm.com,
	revest@chromium.org, josh@joshtriplett.org, joey.gouly@arm.com,
	shr@devkernel.io, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 15/28] riscv/mm: Implement map_shadow_stack()
 syscall
Message-ID: <ZdaZj0pqaVJiNOUg@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-16-debug@rivosinc.com>
 <ZcJX2IJb0hOM5RF5@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZcJX2IJb0hOM5RF5@finisterre.sirena.org.uk>

On Tue, Feb 06, 2024 at 04:01:28PM +0000, Mark Brown wrote:
>On Wed, Jan 24, 2024 at 10:21:40PM -0800, debug@rivosinc.com wrote:
>
>> As discussed extensively in the changelog for the addition of this
>> syscall on x86 ("x86/shstk: Introduce map_shadow_stack syscall") the
>> existing mmap() and madvise() syscalls do not map entirely well onto the
>> security requirements for guarded control stacks since they lead to
>> windows where memory is allocated but not yet protected or stacks which
>> are not properly and safely initialised. Instead a new syscall
>> map_shadow_stack() has been defined which allocates and initialises a
>> shadow stack page.
>
>While I agree that this is very well written you probably want to update
>the references to guarded control stacks to whatever the RISC-V term is :P

Noted. I'll do that in next patchset.

>
>> --- a/include/uapi/asm-generic/mman.h
>> +++ b/include/uapi/asm-generic/mman.h
>> @@ -19,4 +19,5 @@
>>  #define MCL_FUTURE	2		/* lock all future mappings */
>>  #define MCL_ONFAULT	4		/* lock all pages that are faulted in */
>>
>> +#define SHADOW_STACK_SET_TOKEN (1ULL << 0)     /* Set up a restore token in the shadow stack */
>>  #endif /* __ASM_GENERIC_MMAN_H */
>
>For arm64 I also added a SHADOW_STACK_SET_MARKER for adding a top of
>stack marker, did you have any thoughts on that for RISC-V?  I think x86
>were considering adding it too, it'd be good if we could get things
>consistent.

Please correct me on this. A token at the top which can't be consumed to restore
but *just* purely as marker, right?
It's a good design basic with not a lot of cost.

I think risc-v should be able to converge on that.



