Return-Path: <linux-kernel+bounces-48354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D459845AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABAD1C25935
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C3D5F49A;
	Thu,  1 Feb 2024 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkWqBAYE"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64335D473;
	Thu,  1 Feb 2024 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706799837; cv=none; b=M4zLIerm33WmRFI//hciseXcAml+Z2dqInGQVdciEBMr8gmg+6KHcvcSBN+lST3aUDtza7zk6Oj7OQ01qLePB7uy0rBQHABVR793MvnbgXytF1XYGk0FnB5QhgSSYbxYH2H9x5lxna9Ad5vl8GfsMDWbIvH8u+TRUoBcoYgtW1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706799837; c=relaxed/simple;
	bh=V/ONzrff4iKHb3CCc2p1U9n5EASoNMBZGX8D6oRCtP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWXOIfbxCIPks1PcdJoYHWJNE85jDggg6xy5a/bU0sLWRsxx6atjrfnS3mnMWbPmZa+AsjO4N3alkt0e8BEuwK0EvVWJlcbWW4t3SG4aFYXQao1lj2QyS9yLnZ2U15wJ0OG6hpcYz6zBqkvVkhAe+/jJCdOv3VSbO8V/E5MIxz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkWqBAYE; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e80046264so9256535e9.0;
        Thu, 01 Feb 2024 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706799834; x=1707404634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQI82xkebwfzT3j+NbzdVCePUJoKXQTTgiIMRHd9tA0=;
        b=RkWqBAYEYynbQiNMX7OXhIfiRCcceHKoO+Dma1ggp+vvBEw3TrAGgKCLxzeA3O9A5y
         7E9Idun/cSuEVALjvV3qOYZIPOUnnbV3GPxDhFeN/Hj20adGAPpxPM+WCnhG+qtab/HZ
         pY3aksbXYi7R6Wxm0czV4kTRVbD2+Y6fe5r5jgBlmM1ocXbn0i1jpFUAfRpBmCNvxrBE
         iJzttPtRYRaNMR2igX0hs6y+SGhT61p9mhS4HbHvY1tvQzntqkNTO65d7k98X+gFqV6K
         gsck/jWZoRJL4Kc1LjwIdTtzYtNROGenRoW2ED/bjcVbth47YgRsSgN/DE1W7z3mttfZ
         6HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706799834; x=1707404634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQI82xkebwfzT3j+NbzdVCePUJoKXQTTgiIMRHd9tA0=;
        b=PojqinmA7IqGGp+Ff7aQkIBN+BR3aEBkt1fGxJe1NMkfq6V9x66SwKDOX387dHIno7
         mCDnge4XQtYTLBGyoK7wQh3Fv0MJ1nzWSceJNBUzCSe9rsgBJsqxYwgfDhdb/QAroi4Z
         UayalZdZS5AZNit3KGwa0j1ea4B4t/4UqM76rERHrwkt1ziHC/tXP8TUtTRb4vq1nslB
         ThZO/aQg/y2RvXhU/SzV7Sl+NWkdnykp4REqejn8PwC7sZ0SrJEPIq6s86lpf7VchJFY
         xAdcdM2JUp2J/ohaDxSHNBB23UUZMtVc+CL/u6T7PeVNuZZSYnXWySlk4GfAtepcIENN
         XjHg==
X-Gm-Message-State: AOJu0YzxvTRxkexdtU497WZEtxF71ZJR3TFr9af/fES4Qy9IK0Ejo0J6
	5OMe3edGTfMj8r1h5ict94jJT4JerRv968W3MGM+N0bOdUuAWIhO
X-Google-Smtp-Source: AGHT+IHgq8VDz2gMVFec1rt9xa8alnLqg6m1IYYBrYWka6TlPpdIpPCK3IdQ6EOAmX4jWd4gg88q+A==
X-Received: by 2002:a05:600c:1c9b:b0:40e:f702:a304 with SMTP id k27-20020a05600c1c9b00b0040ef702a304mr3558063wms.32.1706799833416;
        Thu, 01 Feb 2024 07:03:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUDpgq0/uHUFP6DOMM/DOOgv6iaPTfvvlORJEtejjXG7NB3wNC7NPVgdP/a80SSBXcJjbaEEIyh+mqStaWE9ShiuHnhGiu0Ude3P4CSFQ3d+CGq9+DAjgcm1aQxefjN0mJjaRHu+d+pEnI81EDPulpbkTCKWAzVI1NQ2CjyFnruwvjT3XSCNT2xi8Rz/Pm9l+yrTYDvmZzT8WwkDZ4TJRCZL7qKJ7JE0w208ZTXS3EdwtHkyMVxRJFjaC6vmbIEV3KJHxW+9E8y6RugEGGGc+RAgrRS2/mcChzL72DvHvv09MdkNJ3SyGTtS/aWraB/umbXkoKBO3eu0iaPDyYl45cI7AIDf4cvnmpMVE36WXwBNDuS5C+dFi6826+JbRT5aVrMB/812NuBe36eW2blfMeKt3OBcyvpvyCF+9r1L742OlcdPyGlBCXjfCg1ZVYrnPqeTySi49U/aQRdxiXSjmMzo/VA+l2tLlv2iNnZdz/5YM0P8SL4ZrgKVPAT0fLShXJOKH7m6PpeKfu+0fpLDF8QTj1FESwPMhuWww/x2V1Ed9CIW4dUvtVF5d9pzMZaqIdpMFOCe6tTae1G15CtxUebt68+gSBiml4shJT3SMHsg1px/hmq3Vr8DBHs63fugiLnN0pAWPPBo3jKqA==
Received: from andrea ([31.189.34.185])
        by smtp.gmail.com with ESMTPSA id bk7-20020a0560001d8700b0033addbf2d2csm16043387wrb.9.2024.02.01.07.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:03:52 -0800 (PST)
Date: Thu, 1 Feb 2024 16:03:48 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ved Shanbhogue <ved@rivosinc.com>, Matt Evans <mev@rivosinc.com>,
	Dylan Jhong <dylan@andestech.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC/RFT v2 4/4] riscv: Stop emitting preventive
 sfence.vma for new userspace mappings with Svvptc
Message-ID: <Zbuy1E7mz9Oui1Dl@andrea>
References: <20240131155929.169961-1-alexghiti@rivosinc.com>
 <20240131155929.169961-5-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131155929.169961-5-alexghiti@rivosinc.com>

On Wed, Jan 31, 2024 at 04:59:29PM +0100, Alexandre Ghiti wrote:
> The preventive sfence.vma were emitted because new mappings must be made
> visible to the page table walker but Svvptc guarantees that xRET act as
> a fence, so no need to sfence.vma for the uarchs that implement this
> extension.

AFAIU, your first submission shows that you don't need that xRET property.
Similarly for other archs.  What was rationale behind this Svvptc change?


> This allows to drastically reduce the number of sfence.vma emitted:
> 
> * Ubuntu boot to login:
> Before: ~630k sfence.vma
> After:  ~200k sfence.vma
> 
> * ltp - mmapstress01
> Before: ~45k
> After:  ~6.3k
> 
> * lmbench - lat_pagefault
> Before: ~665k
> After:   832 (!)
> 
> * lmbench - lat_mmap
> Before: ~546k
> After:   718 (!)

This Svvptc seems to move/add the "burden" of the synchronization to xRET:
Perhaps integrate the above counts w/ the perf gains in the cover letter?

  Andrea

