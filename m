Return-Path: <linux-kernel+bounces-42524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE4F8402A3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B93C28345A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1557D56473;
	Mon, 29 Jan 2024 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WliwLMXR"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC57E55E51
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523403; cv=none; b=RL82i5RbHBR0bAis3UyozbhcVcv1mM6aHxELlN1Ln5/gfv0RFA/AgIP7RuBkQSYTXSgTbM3k15CtGc5lj6xwAjCmaEfaxRy/HvvjtGUVz4CUutznjBu28skSD5tj4XqNpE9PoTgUB/N4ZcDF0RO3aKYUijof8a3zgrf2zwmsq3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523403; c=relaxed/simple;
	bh=9bB/+pYSzIDzHnesJvCHGI9xL4OX/zPz3pf6v9GMJ88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmOgekBzX131cpga5t0v8x57Co+sGmAnozwavURdfRJ8KzbydKdZPfc4N865v0diQF2Hik8UoBFUEQFK0VpSGA5GlAn7NXeUGhBOC/2M2a2LomEuGSb2L41qyn7oHrQYSHHrHq4DJtNTlZIey5ob7zIzzw3RjigZ8AgAtzqjRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WliwLMXR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ef64d8955so7133635e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706523400; x=1707128200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NKy2gXfjJl67cLJ142YEpKmEzsXs/wjVnlS7KJyhEVM=;
        b=WliwLMXRtTGdulxYWnj0Sw7G05KaAUFXAzuh3E3URhTJTXToxChS/R5/DzKimA4Ltd
         mdfQ5Z9oIwHl8UhvY4npeH1Z4F9qOWCEEhXDG1FkfzHwbgN+HmpArHGeLUoq+A3Cv8f4
         XTjcHWSJXFnTQjoWjR7cTW99szaf0ww6w+RT2EhLmmdPes1uMD1agXxYrMOtefAGzrfU
         2zGE2PqTup7ufMTlgIPIUIswnoG0mgVJgxdAa4S/3UAWYGVYGYTXRh7WQRv1v5O2SXWI
         8PUave/05EBPl5qu4AxzfktfxTHYeFlQqMXG91NYR6WyVXc6/sDcmFlWlqiv5WGCeNG5
         h7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706523400; x=1707128200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NKy2gXfjJl67cLJ142YEpKmEzsXs/wjVnlS7KJyhEVM=;
        b=W0Y56hqryWFkO05NyTJC9sd6kpyEdzDjqXn36QyjZrdkkGgFHemC4WxsBcr3yepAWJ
         kHi6xjQpZLbrQsOCDCLQCnIKsKZuuTy49gnoJ6O8fm/A4LPaOU+3V9cYuz7i8v5TZQ8Y
         GbgvxxeXiNDwZIBdbiYdOXj2UBOWUBOPgBOrGuLTiTIo43SZVVhI+D3Arh048rd2O5di
         NwX/94mXiCUBTA936LtOU5ms529B8AGP3fCndfL3geDQxQtkWObPQ1pFg4XkckjCwcz6
         TQxdhLZuIk9qpBpMmLXhv+LYZDT9OoXJhm1MD1JfMfPY9FAZh9HNuNPsnrnPqX3ZuFLR
         pgvg==
X-Gm-Message-State: AOJu0YwAuSB8mVKJ3+xP2sLpLRtFt+vY/h2lNW2Q63lM03TFDilhK06y
	azhQ/dUHZ8me2XrLGbRLVRtPmbxslrseTHItGGwA3esqfpG8hk3fVZBVMurSxl+PaZHf35yRldi
	2CEqmFg==
X-Google-Smtp-Source: AGHT+IH5bjN8ErIkVNKTlTrzFnhf+0GWnSJB3KhJvYnwW8dR3tdpM+mdQ3RTeCDlNT0u0sOij3Dtdw==
X-Received: by 2002:a5d:438e:0:b0:33a:e478:94a6 with SMTP id i14-20020a5d438e000000b0033ae47894a6mr3466412wrq.31.1706523400116;
        Mon, 29 Jan 2024 02:16:40 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id cl10-20020a5d5f0a000000b0033aeb20f5b8sm3292519wrb.13.2024.01.29.02.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 02:16:39 -0800 (PST)
Date: Mon, 29 Jan 2024 13:16:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Laight <David.Laight@aculab.com>
Cc: 'Jani Nikula' <jani.nikula@linux.intel.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	'Linus Torvalds' <torvalds@linux-foundation.org>,
	'Netdev' <netdev@vger.kernel.org>,
	"'dri-devel@lists.freedesktop.org'" <dri-devel@lists.freedesktop.org>,
	'Jens Axboe' <axboe@kernel.dk>,
	"'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
	'Christoph Hellwig' <hch@infradead.org>,
	"'linux-btrfs@vger.kernel.org'" <linux-btrfs@vger.kernel.org>,
	'Andrew Morton' <akpm@linux-foundation.org>,
	'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
	"'David S . Miller'" <davem@davemloft.net>
Subject: Re: [PATCH next 10/11] block: Use a boolean expression instead of
 max() on booleans
Message-ID: <6eaa0f91-104f-4efb-9ea3-7c7f21e75842@moroto.mountain>
References: <0ca26166dd2a4ff5a674b84704ff1517@AcuMS.aculab.com>
 <b564df3f987e4371a445840df1f70561@AcuMS.aculab.com>
 <87sf2gjyn9.fsf@intel.com>
 <963d1126612347dd8c398a9449170e16@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <963d1126612347dd8c398a9449170e16@AcuMS.aculab.com>

On Mon, Jan 29, 2024 at 09:22:40AM +0000, David Laight wrote:
> From: Jani Nikula
> > Sent: 29 January 2024 09:08
> > 
> > On Sun, 28 Jan 2024, David Laight <David.Laight@ACULAB.COM> wrote:
> > > blk_stack_limits() contains:
> > > 	t->zoned = max(t->zoned, b->zoned);
> > > These are bool, so it is just a bitwise or.
> > 
> > Should be a logical or, really. And || in code.
> 
> Not really, bitwise is fine for bool (especially for 'or')
> and generates better code.

For | vs || the type doesn't make a difference...  It makes a difference
for AND.  "0x1 & 0x10" vs "0x1 && 0x10".

regards,
dan carpenter

