Return-Path: <linux-kernel+bounces-111085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD398867B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC93F282F21
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCF514002;
	Fri, 22 Mar 2024 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jfOkAL69"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5113AC4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711094327; cv=none; b=p+0k7gwFpTyV18HYaejyjEE+xrT7FVr3pYo272XZH9hqfPJdUw7XJtfpLoScNgRXYc6vXbSe674VzHwvpfkL53ViXtAPuju+5RjXQbmphU2xkQ/ikbxqvoy7FgmnFG5EeZR7ZKueFAFGmmHRSueYruVDUbnSbddv5h0hX1+xuYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711094327; c=relaxed/simple;
	bh=Qq2UvdnGF+i0lv3cQE2vwfxzP0IBqc7zAeM21eyo6SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aelo1AF/Nbw6AXULBYSrHnSY2i52bNmbaPhFjLGBWHdnPr2I4+OVN+0Gve+Sg8BT5x5rnMgrPFvspbkm6+9dlssOP3yGZTgwnNEk6E8rg9L2eIZQAxlcDrtUJX5wAYiGwSfqcKxKbqKjBI8lX7e5PH6L+09WP/+8eCnmqzYy2cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jfOkAL69; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4147e283c4cso41485e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711094324; x=1711699124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq2UvdnGF+i0lv3cQE2vwfxzP0IBqc7zAeM21eyo6SQ=;
        b=jfOkAL691tIThdM2H6V8bwKl0a8v0F+Z2P6HHsYjwVCxMBc99VJHaB3dZOUPZXA5MN
         glky4jDmSJkxyAE6eXqaRq3tLSWtT9xKnef/Onj3bCv7z7YlKYgq/DzNASaICEeetebc
         5iEgZBjhiNEWRvFJHaau5VQfR6zTBo3czlGiDaPv3aVn5sbhITQdk+Sk4lrGuIGGR1/v
         jT2vfxjcLddwscfgP4ARuQ5aM8CMiO2qDPbjTod2e3ttRze9DcGw3PcXBAOy8RVWChrH
         s/nIC00DVB9QJ2BnDBTrETu/F5YLcex4UnxznOLk+G/WUJZVoDh6iivSMmIw8fiUpI1I
         tvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711094324; x=1711699124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq2UvdnGF+i0lv3cQE2vwfxzP0IBqc7zAeM21eyo6SQ=;
        b=QnHnU+gP+/OqT21w08UL3V9lb3y9fq6F8CLE/pBMEHZDuEnvbnL4DiIFmH1fgqPkm8
         ytem+dj1aHAn8SCQMwx6cC7C3yQMQYf+P+FjMdxk9qj6KOkhrsn0TgTlYWuJ0S3P8ILq
         WdxolqSG5JoElGuzAiPWEXpFWD6292Xnt3EuX3g1hdlw3Qr3f9iqsrnM6R1IjlfdY5ZG
         t0+txIMqe/tKTRUzNNezdNItLx5aM4sy1UrGE17lcEzuCdr/UW9fwHn9eG2cDjG9Smcp
         ERcylAMFPTVqrAAdoSXcQMcwyURM5QyVeMT5zKVn+ARJf1iOzN7SWBNGWGpIVu8CZRAt
         zAaw==
X-Forwarded-Encrypted: i=1; AJvYcCUeUPEd6TQ780oLk50MFgy3cOYzS+zM0EKSbFiOqoXb7QVevJlFRN4Cl3wtcHk6siStQP3S9X8CJYJ+p824RpT4xejIRQkvXRhAGc8S
X-Gm-Message-State: AOJu0YwupGVQaU8mv2X28kX+YYinoh+V2lVSlnrVngguMn9U62f8TPSO
	1RUU5sxTISoc2ur+mb4dMwaYpZuU5TfHWLwlSWaPlQ+rA0KfQHdoy2EeE3+D+Ic=
X-Google-Smtp-Source: AGHT+IFfPw7L8Q/FyVD0aA/iJBlzVnrZAE+Hkn53NugKvE+lKFP30YlXVm9GuwDSXbo7RH3uCwUB2w==
X-Received: by 2002:a05:600c:3b17:b0:414:b66:51f3 with SMTP id m23-20020a05600c3b1700b004140b6651f3mr1050755wms.14.1711094324659;
        Fri, 22 Mar 2024 00:58:44 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c501200b004146bdce3fesm8016711wmr.4.2024.03.22.00.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 00:58:44 -0700 (PDT)
Date: Fri, 22 Mar 2024 08:58:43 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Deepak Gupta <debug@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, tech-j-ext@lists.risc-v.org, 
	Conor Dooley <conor@kernel.org>, kasan-dev@googlegroups.com, 
	Evgenii Stepanov <eugenis@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [RISC-V] [tech-j-ext] [RFC PATCH 5/9] riscv: Split per-CPU and
 per-thread envcfg bits
Message-ID: <20240322-168f191eeb8479b2ea169a5e@orel>
References: <20240319215915.832127-1-samuel.holland@sifive.com>
 <20240319215915.832127-6-samuel.holland@sifive.com>
 <CAKC1njSg9-hJo6hibcM9a-=FUmMWyR39QUYqQ1uwiWhpBZQb9A@mail.gmail.com>
 <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ab1ce5-8700-4a63-b182-1e864f6c9225@sifive.com>

On Tue, Mar 19, 2024 at 09:20:59PM -0500, Samuel Holland wrote:
..
> This is really a separate concern than when we write envcfg. The per-CPU
> variable is only necessary to support hardware where a subset of harts support
> Zicboz. Since the riscv_cpu_has_extension_[un]likely() helpers were added
> specifically for Zicboz, I assume this is an important use case, and dropping
> support for this hardware would be a regression. After all, hwprobe() allows
> userspace to see that Zicboz is implemented at a per-CPU level. Maybe Andrew can
> weigh in on that.
>

Hi Samuel,

I've approached Zicboz the same way I would approach all extensions, which
is to be per-hart. I'm not currently aware of a platform that is / will be
composed of harts where some have Zicboz and others don't, but there's
nothing stopping a platform like that from being built. I realize this
adds complexity that we may not want to manage in Linux without an actual
use case requiring it. I wouldn't be opposed to keeping things simple for
now, only bringing in complexity when needed (for this extension or for a
future extension with envcfg bits), but we should ensure we make it clear
that we're making those simplifications now based on assumptions, and we
may need to change things later.

Thanks,
drew

