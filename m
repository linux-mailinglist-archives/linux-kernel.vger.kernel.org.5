Return-Path: <linux-kernel+bounces-80963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81392866E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3156F1F25748
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C875FEFF;
	Mon, 26 Feb 2024 08:50:15 +0000 (UTC)
Received: from cantor.telenet-ops.be (cantor.telenet-ops.be [195.130.132.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9B1BC30
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708937415; cv=none; b=DF++htudToAyIk7G7C27Wtf64SEKRo816UW492zJnahriM+CH5dxcdoddSuXAPgcgyWh7bkB9uH0Oyw18y/Rprb40E+CxyIdNFMLLdHTO2KTNcZnviOQD1QYiN3u15wP8+4ZNH82GAX7I1xPJ8w4zAvGSfcq2hEfCfjADR+Sm4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708937415; c=relaxed/simple;
	bh=UTaRrHgCR+1O6yG7TBz18ppjcUfPxclKMbwpvsVBIJo=;
	h=Date:From:To:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TnREqDgRBDwO+IeVqV8PlZe2cRb53o5OmSBHiYUY4PRvaNEqqmWGymdDwJkDz6AIb1CynYCvNGOnqsB+Fk36UOK504ScYbfMLEmIXWB/NmusE7i0uQI4Wbs7dpUpvUGTssdkIQYlQkDg3ZTZqwltGp+b9tBdarIBOvokLQwlGKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
	by cantor.telenet-ops.be (Postfix) with ESMTPS id 4TjvH43dPdz4wy93
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:41:36 +0100 (CET)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:7662:e968:947d:f3d0])
	by albert.telenet-ops.be with bizsmtp
	id rkhU2B00e5Kh3Z506khU3b; Mon, 26 Feb 2024 09:41:28 +0100
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1reWYC-001jsH-O0
	for linux-kernel@vger.kernel.org;
	Mon, 26 Feb 2024 09:41:28 +0100
Date: Mon, 26 Feb 2024 09:41:28 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.8-rc6
In-Reply-To: <20240226081253.3688538-1-geert@linux-m68k.org>
Message-ID: <70425240-866d-e245-39dd-f0ed636b187@linux-m68k.org>
References: <CAHk-=whZ=iA6DhijePcW-pJjZ8YD4T5qLpLKVSUT+4gWNm_0sA@mail.gmail.com> <20240226081253.3688538-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 26 Feb 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.8-rc6[1] to v6.8-rc5[3], the summaries are:
>  - build errors: +3/-6

   + /kisskb/src/arch/sh/mm/nommu.c: error: no previous prototype for 'kmap_coherent' [-Werror=missing-prototypes]:  => 80:7
   + /kisskb/src/arch/sh/mm/nommu.c: error: no previous prototype for 'kmap_coherent_init' [-Werror=missing-prototypes]:  => 76:13
   + /kisskb/src/arch/sh/mm/nommu.c: error: no previous prototype for 'kunmap_coherent' [-Werror=missing-prototypes]:  => 86:6

sh4-gcc13/sh-allyesconfig
Seen before, SH ICE crickets

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d206a76d7d2726f3b096037f2079ce0bd3ba329b/ (138 out of 239 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b401b621758e46812da61fa58a67c3fd8d91de0d/ (144 out of 239 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds

