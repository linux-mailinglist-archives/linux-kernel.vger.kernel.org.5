Return-Path: <linux-kernel+bounces-52427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 643448497F5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DBF1F2138F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7017588;
	Mon,  5 Feb 2024 10:43:31 +0000 (UTC)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BB917575
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707129811; cv=none; b=iB/5BmUawFaZN8LcLPzG8AgVX78mq3AxDdnZIRzziiIL0KDvi2lX6nb2o2d+fTGp0K/X5K0NLmLRgU8F5qcoIKBYznWOCeVI0KEjtbCu74eXkOLz/o30P1Mt1To0OSmDKf1OrlspcZuJCrE/KxYIg5D+kulWBYgG3sQT7W7XriA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707129811; c=relaxed/simple;
	bh=wae8WXBpMrupkMu8qpekTMb7NwMJ3LJZiULn/omIxyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldzd1WWixzo2iHUaCOtW3SB2HyAGEUm+uYJXU4x0mfKUv7R9ifDJAbZlRJysWKnLptaGbmulCSbS4garj/gPM7mn1s84kJk42JxipuvQXjtbckI6wuKkpZcLdHu6yMlLaD2Io8OBHRwhJmZ7W5U1lnHg//osvTdoX3Jb1MInRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-290da27f597so2785500a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 02:43:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707129809; x=1707734609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wae8WXBpMrupkMu8qpekTMb7NwMJ3LJZiULn/omIxyc=;
        b=H3+8UtRyZ6rIAhw/XGIeU6Ipm1qxqhqvJJYTdJfVlmiRgrvPcJdgrA2lhDLY6RBtJ9
         PzuLDT5FCE8PhNFWtrpq2ZHslJzrdyJO85ryppT/EDA1rBR3zyRLp4AFnK2x2U/cjngG
         58kh5YNpdxZahqTPgfKthFa04+tS1RU8XNjq7J3HKMPSPKc3bM0nm88j9GvEOHHE7bGx
         RvDH/5kaQchiI0dTynnFrCTsChtdiVAqgXko1D4CO2TiCpHZzXVzT3U2kh9hZNNGeG8i
         Xr91Tt2c2kG23tTyijklMcEZQmw7ZxveNanyZO9BJjLJeZBmxsMB+0G6DUzzR4sow+SO
         QWug==
X-Gm-Message-State: AOJu0YzpCqtltb2r0VV/23G6BxTDM7WXBnb9KJfBZyBmu4uVQIsPIbpB
	iCUs9q0+jPxD8+sWLpIkYpqUuxxIKvlcknXBHactXu16FA7RXzAdYLn3odvnH7B2n5BG8LRlpSL
	QDrECOp1vtWzKUDSHGU52sMDQwDg=
X-Google-Smtp-Source: AGHT+IEZkP2aXwQYrTb/2HJ/EM8D8sip4YfOLpNrFda2aTlFYqJq3PTNElTnnP4OMdKnmcmwLl3lg1hHXDWOdaRufOU=
X-Received: by 2002:a17:90a:ac0c:b0:296:b8e2:b836 with SMTP id
 o12-20020a17090aac0c00b00296b8e2b836mr4468pjq.4.1707129808884; Mon, 05 Feb
 2024 02:43:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20221111081316.30373-1-mailhol.vincent@wanadoo.fr>
 <20240128050449.1332798-1-mailhol.vincent@wanadoo.fr> <20240128050449.1332798-3-mailhol.vincent@wanadoo.fr>
 <c47fedaf-cdc9-f970-460f-d2ee7e806da4@linux-m68k.org> <CAMZ6RqKj207uv5AF_fvb65nhCM32V=VAQXsUGLNmbeXYKPvZJg@mail.gmail.com>
 <9d9be9dbe92f43d2a95d11d6b2f434c1@AcuMS.aculab.com> <CAMZ6Rq+RnY16sREhAZ6AFn3sz1SuPsKqhW-m0TrrDz1hd=vNOA@mail.gmail.com>
 <77831c6f-7fc9-c42d-b29b-c3b2f3f5e687@linux-m68k.org> <CAMZ6RqLyRxvUiLKZLkQF1cYFkdOqX73V2K=dGbNROMDj61OKLw@mail.gmail.com>
 <002675b0-6976-9efa-6bc5-b8bad287a1d2@linux-m68k.org> <CAMZ6RqKx=EO9kcOmxRyBuhULdDyTCeAXz25j_uF7TSy72Jahpw@mail.gmail.com>
 <00a7e866-23ff-fc63-b6df-364580f69c78@linux-m68k.org>
In-Reply-To: <00a7e866-23ff-fc63-b6df-364580f69c78@linux-m68k.org>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Mon, 5 Feb 2024 19:43:17 +0900
Message-ID: <CAMZ6RqLkCPuy+mQxp0HuVBgfSiFgFOwimYm1Ro7ESANyF-fRyg@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] m68k/bitops: use __builtin_{clz,ctzl,ffs} to
 evaluate constant expressions
To: Finn Thain <fthain@linux-m68k.org>
Cc: David Laight <David.Laight@aculab.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Yury Norov <yury.norov@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Douglas Anderson <dianders@chromium.org>, 
	Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Marco Elver <elver@google.com>, 
	Brian Cain <bcain@quicinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney" <paulmck@kernel.org>, 
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Mon. 5 Feb. 2024 at 18:48, Finn Thain <fthain@linux-m68k.org> wrote:
> On Mon, 5 Feb 2024, Vincent MAILHOL wrote:
>
> >
> > This is why I am asking whether or not clang support is important or not
> > for m68k. If you tell me it is not, then fine, I will remove all the asm
> > (by the way, the patch is already ready). But if there are even a few
> > users who care about clang for m68k, then I do not think we should
> > penalize them and I would not sign-off a change which negatively impacts
> > some users.
> >
>
> If clang support is important then clang's builtins are important. So why
> not improve those instead? That would resolve the issue in a win-win.

I am deeply sorry, but with all your respect, this request is unfair.
I will not fix the compiler.

Let me repeat my question for the third time: are you (or any other
m68k maintainer) ready to acknowledge that we can degrade the
performance for clang m68k users? With that acknowledgement, I will
remove the asm and replace it with the builtins.


Yours sincerely,
Vincent Mailhol

