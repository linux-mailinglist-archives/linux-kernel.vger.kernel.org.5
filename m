Return-Path: <linux-kernel+bounces-130198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA884897543
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FC0E1F2B3C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6584214F119;
	Wed,  3 Apr 2024 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivWKiRt0"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD5A58203;
	Wed,  3 Apr 2024 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161899; cv=none; b=PIHqhHVQdqj930zyMLSzMw2ZqFoG2SsMFM0qH+yDCNVE+IOMnQvd/kYRvAOVGWo/Mj2rhveWL8Hkj1gV8QrQVXVyoXbElMlIziEKMPKPXOEbxrZWL7Pc/lES4REU91ApUTwhrhAqn2RT82N3NrHaxzZqRoa1D4ZcmRjIgA4ssm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161899; c=relaxed/simple;
	bh=wCGfbqkCjZqO1k85+SxiFGnS5gu5jwe8FmDhiwuzS+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyB3bjCjg6tjjMyrBMl8S6XsI+sgbriEJamIQSNqJEMloKodPcSk9II86Q0tL1hBYWOLrRAvsfPG7///haXj4TbkBjbacsejnVbgDKRFItT/EgPihdjJS1oW8oL/8UCTWB+imIzA0vbJaLsORjMWY2JzPqpA5neKFYLV9qS3LEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ivWKiRt0; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6154a3df493so9309877b3.1;
        Wed, 03 Apr 2024 09:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712161897; x=1712766697; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WitudJQrPd2aFPqvPyORq1RfFG+UAlZFwAtUhdU5ix8=;
        b=ivWKiRt0B2I5aWf5WtiQcklSaD7i3m4gyUU4q64TL77qsMSsAv08kPBSekgxpQ8XdT
         WrRe2c+AbwjbCjDGcljSX3nzYI0QqYW1OfRVWgLGuG16B/CixIFG7ZRrHKxuYvrQvJGm
         BRtOWkg75dm/dADPiGCP1obZfxjkNeL+VHwClWDvaXQLzM8UwcFIkC/TG3facQ/AI2/B
         Rg8PZm+rF+paTsq3z2FrDf8YOz27g95vQ+dpuSHTfdRBkAV1Uc2bN3PZJssJ7ed1Nme1
         pSg0P6l4YXJjYmWU40EeZgB8G9tGEiJU3Gtebo6f9d+XiNKxel5xA66JsvTNfu6EHABb
         jE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712161897; x=1712766697;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WitudJQrPd2aFPqvPyORq1RfFG+UAlZFwAtUhdU5ix8=;
        b=tBVDtPgASNbvws4v57psZ5Akd6f3Rr+0yhNfF4+wwmS07HVGN6SFfVCXjYjuqPT2jy
         MKEtqzeV2CKis61pAAjKhqTBLS5xcMdg4j/FQhFrptpkb+z3ijFKeWCLmwJby+ElhX++
         QeMppoNxHytiSFJFUhke374wfXZyr1+O5PvGJmeCONd54CsH5Kj7TCihbj+k296B49uz
         ZP/gq1LWFkKTSd1C4GrPoza1R2LYSJ0NAarJCmH2+vExHKjjehfjjcwloy6rjIEhUHFS
         CsTourn9vaP1jJ3CTiW3Sp6rJMz0am1+a2GfpLEJyBBC8znKZIpur0idC9ufvpy9ZV+a
         98uw==
X-Forwarded-Encrypted: i=1; AJvYcCXB3e6G5LIVAlOpwEm0mVgE9tztboO/DvWhskP1brxjrpbZPdDOvyO/ABGAntxXy+sA9CH9fM+5/NPQ97l2wOz0t6CW+N0Y5Lh4M3a4co0xNoGjpJD07am3uLL76ny2jxhSNtgJYw/YAmwJyw==
X-Gm-Message-State: AOJu0Yw3mLZ3FHFRLelqvAIjy1dv/7Oflty+dt9mkbuCiQeYRnB5RV2a
	2hv/wRSbNv8BZpaHq/b9HmrMnGLIXBiIna7RrKdhiEIQj/EqHjlX
X-Google-Smtp-Source: AGHT+IFMH30xboktbAbDIrpwyqMLjCXk6lM/Q2cAcPlVax5NsBs+K/Z/OsSe8cOBgGPht/3y2tq2Jw==
X-Received: by 2002:a81:6cc2:0:b0:610:b545:6605 with SMTP id h185-20020a816cc2000000b00610b5456605mr1908655ywc.26.1712161897057;
        Wed, 03 Apr 2024 09:31:37 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:e71b:60d3:a7cd:425b])
        by smtp.gmail.com with ESMTPSA id l3-20020a81ad43000000b0061548271a57sm652178ywk.98.2024.04.03.09.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 09:31:36 -0700 (PDT)
Date: Wed, 3 Apr 2024 09:31:35 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, mark.rutland@arm.com, linux@rasmusvillemoes.dk,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 01/10] cpumask: add cpumask_any_and_but()
Message-ID: <Zg2EZ6II4QNuO/QM@yury-ThinkPad>
References: <20240403155950.2068109-1-dawei.li@shingroup.cn>
 <20240403155950.2068109-2-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403155950.2068109-2-dawei.li@shingroup.cn>

On Wed, Apr 03, 2024 at 11:59:41PM +0800, Dawei Li wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> In some cases, it's useful to be able to select a random cpu from the
> intersection of two masks, excluding a particular CPU.
> 
> For example, in some systems an uncore PMU is shared by a subset of
> CPUs, and management of this PMU is assigned to some arbitrary CPU in
> this set. Whenever the management CPU is hotplugged out, we wish to
> migrate responsibility to another arbitrary CPU which is both in this
> set and online.
> 
> Today we can use cpumask_any_and() to select an arbitrary CPU in the
> intersection of two masks. We can also use cpumask_any_but() to select
> any arbitrary cpu in a mask excluding, a particular CPU.
> 
> To do both, we either need to use a temporary cpumask, which is
> wasteful, or use some lower-level cpumask helpers, which can be unclear.
> 
> This patch adds a new cpumask_any_and_but() to cater for these cases.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>

Thank you,

Acked-by: Yury Norov <yury.norov@gmail.com>

