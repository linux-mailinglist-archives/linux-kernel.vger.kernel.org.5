Return-Path: <linux-kernel+bounces-37091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E2383AB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C017E1F2197E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461E87A70E;
	Wed, 24 Jan 2024 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nghjgqqm"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E79760DFF;
	Wed, 24 Jan 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706105653; cv=none; b=Z3MlwmiRNNU+xV1FKMwIKtGv3ulK1THd7pz88X7hvV8Xvql28hUYLLDS+Dt55nOeIHgHwjsPxuGvrF+Z0n3eISK2wW1ib8Lp6M6TlZf+otqu9M8x3we2aEw66GfA2RR4AsElRHw2CGDeVBggsvTYSjQGxxX2vMw9OZ3izeoL+z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706105653; c=relaxed/simple;
	bh=ayLeps8v3W7HX8vlungxHlMOuxcEHcvYI51ejw6W6y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tptyAykvizZsItVkiZLDqGgyf/8IqWygOnyGZ0TjK9hnCPf3G4ioDekHMdT5fHq+lBzGVF+hAJC5+Pj8regL9n3WvyRzUWsWHbMBcTax7Etvuh5t0zcESk83rnckT9wGsLvAzmOvaf77pE/RxWnyBJ482OhDziU/CLeKDAuSgh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nghjgqqm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28fb463a28so541043266b.3;
        Wed, 24 Jan 2024 06:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706105650; x=1706710450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVt0ZnKeByvzhrfkzssJmlz6f1Lvfiy149b2/exZGTI=;
        b=NghjgqqmN9zD+1HEfq0faYl/BWOF/o3EcsFMGLgR1xdXx9NCWVovmWxZMJXQCkSGJo
         67Bv+T/QcBmKIKhrEX23qwS8U6dkMwDXJO8O0nYiujcnjW5fCB6SXkXdq0lL4prgdH+S
         Kss+w5Gp/j7XGF8BCYNJgDCiD1JD93NYN/l6GQYmkK4TOTgSF1mjpl2rBX18aW6qM7zA
         Gn9x/eJzRaIoJ4nDBjVCPqCsH8XTgcra04Mtc1j6Axdb52bJErk7ZbBVYqYP283ogEFm
         EzLA5ntm4q0fElz/p1toQvdL2K0e7pCRbIaOvkDA9xc1ktagFkPdVa/IOzt+mREPtw1M
         2AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706105650; x=1706710450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RVt0ZnKeByvzhrfkzssJmlz6f1Lvfiy149b2/exZGTI=;
        b=M7jRcQ543oXrQQBFexf0xQ3/Ydn1v+uDuGq/0ByGlYytLeRCbVDnF1iZ1pzkqPDhOv
         CBRpV5NxtmCaIoSMoBvVxkEFYc+3PX8avxvNdnSszBcMACt9Hp5g+sARFBWmRuNsAkYt
         N2S+zt6PnwF2XcgstlmF0UoNd7IfaZS55iwtkgb8wq2Vbhq9NBRz/EMoikCVof+/51xA
         cMHbiQdlUZ6fdxwD5GTrIM9uz7tBkUQy0wVGSw7w2oi3qNBXT0oxvsxZwI0badkB/cS7
         AKhqbMtoG6NEzkaB5Ue8pnjImnKUeBABaFghVL3sG2NfcXPpgbGBRJIqNzv3KtVOuEq9
         d49Q==
X-Gm-Message-State: AOJu0YxGhfoYrtpA3M3TREuCC/y3kxtVV0QnUwr/oInBA1kF/6DSUa2U
	dN7YnwuHDk4xueCdICHroomfVM5He1fu2hw/VXNza1cjd9jLWurU
X-Google-Smtp-Source: AGHT+IF9Si4NHAOAqa3uYGeUJLR9rrnIrYwH+j1jIF67RS+3PdY09F2BJ2FydAo0qGhNxG2VPd32pA==
X-Received: by 2002:a17:906:f197:b0:a2f:71f1:b9e4 with SMTP id gs23-20020a170906f19700b00a2f71f1b9e4mr780499ejb.53.1706105649844;
        Wed, 24 Jan 2024 06:14:09 -0800 (PST)
Received: from andrea ([31.189.8.91])
        by smtp.gmail.com with ESMTPSA id vb5-20020a170907d04500b00a30f04cb266sm1142517ejc.5.2024.01.24.06.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:14:09 -0800 (PST)
Date: Wed, 24 Jan 2024 15:13:58 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	mathieu.desnoyers@efficios.com, paulmck@kernel.org, corbet@lwn.net
Cc: mmaas@google.com, hboehm@google.com, striker@us.ibm.com,
	charlie@rivosinc.com, rehn@rivosinc.com,
	linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] membarrier: riscv: Core serializing command
Message-ID: <ZbEbJpnUoFPW0fhd@andrea>
References: <20240110145533.60234-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110145533.60234-1-parri.andrea@gmail.com>

On Wed, Jan 10, 2024 at 03:55:29PM +0100, Andrea Parri wrote:
> Changes since v2 ([1]):
>   - amaned inline comments
>   - drop ARCH_HAS_MEMBARRIER, create membarrrier.rst
> 
> Changes since v1 ([2]):
>   - add smp_mb() in switch_mm()
>   - introduce ARCH_HAS_MEMBARRIER, amend documentation
> 
> Changes since RFC ([3]):
>   - introduce prepare_sync_core_cmd()
>   - fix nosmp builds
> 
> [1] https://lore.kernel.org/lkml/20231211094414.8078-1-parri.andrea@gmail.com/
> [2] https://lore.kernel.org/lkml/20231127103235.28442-1-parri.andrea@gmail.com/
> [3] https://lore.kernel.org/lkml/20230803040111.5101-1-parri.andrea@gmail.com/
> 
> Andrea Parri (4):
>   membarrier: riscv: Add full memory barrier in switch_mm()
>   membarrier: Create Documentation/scheduler/membarrier.rst
>   locking: Introduce prepare_sync_core_cmd()
>   membarrier: riscv: Provide core serializing command

Gentle ping to the riscv&membarrier people who have survived the merge
window: any other thoughts on this series? suggestions for a v4?

  Andrea

