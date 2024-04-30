Return-Path: <linux-kernel+bounces-163744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4898A8B6F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BDFC282595
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548F11292EE;
	Tue, 30 Apr 2024 10:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ip6josMp"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4D6FC02
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471651; cv=none; b=PrQNRensaN4CMD9nhPTddKPsQxkwoLONDhBBqeQ8IGk/CkIgLjLMM0UjJ0mMEMYJfLtvrLjs6i3/wiJO+5QS/B8u4pQyTq/0LLJpt/+/HqkVTclsJWRK5XNym3o+NLVxd2kjnZYX1YBPlCDs97DhjS2MhOM2SoMuHHqp6VQuumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471651; c=relaxed/simple;
	bh=uGZ3yS0XSXdg0GZ5ndeB/1HjCOL28oo4tqJKIluqlq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJSEya130SBfB8GPTtlepO1cGwk2Vk2l3KUA/7uk1MM8xMo06FBR0moIBULpV7QCwDbJtqWurWlM5hV4YfmiqWvcrbwOpE9erQPcka1nbUZfyI+09+tf4IKg6wvZPPFsrBMMqFV2RjYeTNXAU1Aa9kkTbVp+35iS1H3a05V/S24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ip6josMp; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5872b74c44so615687966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714471648; x=1715076448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X2r6vFxOsrH1SI0fFJepI48sxB8CrSsgq16crhknR74=;
        b=Ip6josMph68aQ6O7+0xS1/cVzmhAI+r/1mSPFU2UH7hqkmt+thlyrM1jbKlbnafaDX
         WI6DbCZ4ecKeNJm9Ha4LDThQiMLjbmdNlgDq3EzKfBnL8UjXH1hAOL6B5lllmQuz9BxO
         SL5YrSWcIr5ENq3xF3l9IO4LgQ3CCbXQUkbszxbhRu3vSJoxmANhDuHsgW7KbUWNdQSw
         WIdJy/mluzj/PB4N341k8ZmqwQriGtrJ+2kxIL2HXzYc05qePy9Tfb4ZjtDfe3ftugcI
         Z41mybvb7YeAdsCcqSyaAK14SS0ZxWILKPNgSChZbse9Sza+KILgiJUtiHXqv+ftWxpo
         0J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714471648; x=1715076448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X2r6vFxOsrH1SI0fFJepI48sxB8CrSsgq16crhknR74=;
        b=gpIfL1MPxIiZb3wLoTSzsjS9b80PzDyWyWaCqeZi1+02R+Y6xM6WWmwnpAG4d9UoE+
         hpM+XdzhlZsxlfyiQbdTqGe6BJ4EtiiB7CEjjLmXGWfJyG7nDj79eF0oqTqeL5dcATKu
         vdJuPQq+4QAs+gPo2FnAjVi+9kq+5EChr3mHa85DszlSRUIn+wLWtNSnKX7u0j0QuHXd
         B1sWtTqZSpxm8MouipYao/GHpVVQYCqpe1ulRXRfO+6TyELZnxBmgwQdsPxbwyobbVbh
         jvQD6w5OHfd8rox3zNFegymBSQ5lXB8yTZj/fJ+6DHJOakWt3nhTHn8EtawI5IDXYBKL
         wQQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUodah2ytk2EE21XTyCvao4KcO+pjZ2anPDSB8l/TWKo3gz5BwK5BuEBvS/krJq+U5Zcb2eMqYDoCx8+vLu2K/ijR3D588wj/cY+MO/
X-Gm-Message-State: AOJu0YxeCvTjWqSiRxHvTbh2kxUk5gKT+KHkzKLZS2wkvyK+lnfwWPbB
	aZRmw2J6M0/Hmd8qHOsZ3grBHDtWEafsY0g34q5fQpszDdZqwi6kmkYbl8GF9bA=
X-Google-Smtp-Source: AGHT+IHR+yWfIkq8eqNqKOZTDszbKiLaNlUcUX8HdX0mL0Ur+qB1bBfC1nK9CY2nqr33YiCTWvl8sg==
X-Received: by 2002:a17:906:81d5:b0:a58:871f:8eb0 with SMTP id e21-20020a17090681d500b00a58871f8eb0mr9371487ejx.7.1714471648237;
        Tue, 30 Apr 2024 03:07:28 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709065f8e00b00a559bbe8a00sm12131014eju.100.2024.04.30.03.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:07:27 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:07:26 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, 
	Conor Dooley <conor@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, 
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, Evan Green <evan@rivosinc.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] riscv: cpufeature: Fix thead vector hwcap removal
Message-ID: <20240430-6781cbaa0a929246cb77dafd@orel>
References: <20240429-cpufeature_fixes-v3-0-6aa11dde513b@rivosinc.com>
 <20240429-cpufeature_fixes-v3-1-6aa11dde513b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429-cpufeature_fixes-v3-1-6aa11dde513b@rivosinc.com>

On Mon, Apr 29, 2024 at 03:29:51PM GMT, Charlie Jenkins wrote:
..
> +		 *
> +		 * Disable vector if the boot hart has a T-Head mvendorid and an marchid of 0.

I probably would have added the 'why' to this comment, i.e. T-Head doesn't
have standard V so things will break if we try to use it, or whatever. The
'what' alone is just putting the easy to read condition below into
English, making it an unnecessary comment.

Thanks,
drew

>  		 */
> -		if (acpi_disabled && riscv_cached_mvendorid(cpu) == THEAD_VENDOR_ID &&
> -		    riscv_cached_marchid(cpu) == 0x0) {
> +		if (acpi_disabled && boot_vendorid == THEAD_VENDOR_ID && boot_archid == 0x0) {
>  			this_hwcap &= ~isa2hwcap[RISCV_ISA_EXT_v];
>  			clear_bit(RISCV_ISA_EXT_v, isainfo->isa);
>  		}
> 
> -- 
> 2.44.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

