Return-Path: <linux-kernel+bounces-109297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6005B88175B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0869B21DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CFC85290;
	Wed, 20 Mar 2024 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTxfdXcX"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0476A03E;
	Wed, 20 Mar 2024 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959684; cv=none; b=Z+YxbERpYaeBd1TSIQciIW5M7gGkhuq4B1eBMFzQ82JAQc3UFBColWBnHjHwuujZiwyPVb74aqbyTRCPMCfbNgM+u7SEi/i5+DmVmam6P912QhbjLQibt9bCbZC9TNlci3hr7V4Q5ARZ3eCSxXN9l43+fGstMMYjtRZlcJGnAf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959684; c=relaxed/simple;
	bh=Gz/P33fFCTff43Rq/o0LHp22/YTPl3TsF1V0oJhNZok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlsFVaD4aUM9GDqz8F295XSKAGF0M478/jaH+OLUnRJgfXKHAiyK3YcBVPDTGFL9GJ3QKWp7ob2UMnWsy9vSp8/VWLnfIWlJ35bUuRpNTjASi2b9G1GdYJliWuNc2BOGzjclcAjC7v9HozzYYl6W0hTVWU8sfS3umEUVHX8Q/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTxfdXcX; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60a0a54869bso1731977b3.1;
        Wed, 20 Mar 2024 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710959681; x=1711564481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8CqzmKnLKN4XLhYr2mcJsa7nMPWQk49wTjtbgHns/Fw=;
        b=UTxfdXcXprrj1cKjdKh6wcQGUKv6GTeu0m0vF10mf316u+sb9Bp4scDEnn13Iko3kR
         PrEm53yoh7mrUSXhmIRZOSiwytfR5avBeSzAvNaQwFUQJfFAX9Z6efJtqotNBo28EpvO
         nWZHF0TnkxWCegfe5s2o5KWH4OhmdEUyJ3qMjTOWBsz1l6rw5zbEuoneSl6FlgPiu7ZT
         jAYd3xFOrVGxXda3povwHeg/0ms/xeaZB/K0swQixiQJD3lBF8d4TA5nV8ocBsSHFNIv
         Q2nWPPm6xgOZI8XHVNySXO+dGAk2kK2xl+GxIdnTUqI0+skoiLlsc9sO1Zbq6oCVLN52
         BuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710959681; x=1711564481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CqzmKnLKN4XLhYr2mcJsa7nMPWQk49wTjtbgHns/Fw=;
        b=Ub9CcpPzW17xiAcm3/8Kqqs5irqPQ9mmGBK0z5feEANWeu61NAvwka4V9Zy8BmP4bk
         CLZW/zcWfLZAMZwRKNZK2FCkJS6i0Z3oatyYxjXrwI1R6Kbghaa1B0yX7Mj9JNvMA6Ek
         H35MtYX2+NKzbZPS0hb6QDe/WHIFfK50u9yCRjuwQw785P39f1C/naKzaQ1vE6kzR2Hl
         ganKaJYW4cMlRIHjx5LKTX73Fure0We9w0E5G9SiQ2Seu0J31hgdQQqzqmVYvpS6ROBB
         UwuNp56prK7QyYFYvOqsdGPIRVBqeMe/WZracefHjjPtWMb+ay1Ti0ZuJjsHxV0+dYZ2
         cBVw==
X-Forwarded-Encrypted: i=1; AJvYcCWxOIVcVHa+pSPpYOc/ERzILWyeU9ywUxlJ8gi3m+5oBBw7kuqKSV73IrKEgF9mOnS/IfsQKgDSlhnlIUFDoH++Yd+ZFaSquDDuoD44OHRzjUX0cEVsOHp4857wkRe/WdScCKqU
X-Gm-Message-State: AOJu0Yx03VhsQCGVS/0yO1xKbOxgS3fz/PNXyoBpq2JPRAn7x0f4ic+B
	0vt3lwo2UuTBoRkA1DJoWCfVQiJsAIwWTwyrprPwmEJ1dOpTG57cVMy8kQ2H
X-Google-Smtp-Source: AGHT+IEr2fAfEe5mdkuWjLoeT9//xU7HCKwZspMudTxZ/L4BCjZUeSakTuwy1dxTaxe17eduxKH4FA==
X-Received: by 2002:a81:4f0e:0:b0:610:e459:435 with SMTP id d14-20020a814f0e000000b00610e4590435mr473086ywb.17.1710959681453;
        Wed, 20 Mar 2024 11:34:41 -0700 (PDT)
Received: from localhost ([2601:344:8301:57f0:a6a6:49c0:6a02:df54])
        by smtp.gmail.com with ESMTPSA id m4-20020a81ae04000000b00610e32312f6sm810825ywh.43.2024.03.20.11.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:34:41 -0700 (PDT)
Date: Wed, 20 Mar 2024 11:34:40 -0700
From: Yury Norov <yury.norov@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Herve Codina <herve.codina@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2] lib/bitmap: Fix bitmap_scatter() and bitmap_gather()
 kernel doc
Message-ID: <ZfssQF5MIQSFCaT8@yury-ThinkPad>
References: <20240314120006.458580-1-herve.codina@bootlin.com>
 <20240319193338.068c2559@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319193338.068c2559@kernel.org>

On Tue, Mar 19, 2024 at 07:33:38PM -0700, Jakub Kicinski wrote:
> On Thu, 14 Mar 2024 13:00:06 +0100 Herve Codina wrote:
> > The make htmldoc command failed with the following error
> >   ... include/linux/bitmap.h:524: ERROR: Unexpected indentation.
> >   ... include/linux/bitmap.h:524: CRITICAL: Unexpected section title or transition.
> > 
> > Move the visual representation to a literal block.
> > 
> > Fixes: de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Closes: https://lore.kernel.org/linux-kernel/20240312153059.3ffde1b7@canb.auug.org.au/
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> 
> We took the offending commit via netdev, so I feel responsible. Please
> LMK if anyone else is planning to apply this fix, otherwise we'll take
> it and ship it to Linus on Thursday (19th).

Please go ahead and add my

Acked-by: Yury Norov <yury.norov@gmail.com>

