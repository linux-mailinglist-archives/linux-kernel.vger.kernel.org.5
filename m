Return-Path: <linux-kernel+bounces-92271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C14D871DBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3DB81C23103
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD9B59B5C;
	Tue,  5 Mar 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="q/icdnj/"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD9F54917;
	Tue,  5 Mar 2024 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709638027; cv=none; b=iaQiCXzarsNvs7V8TOdVaYu1gjGiFZRsafp6Gn/85RQOkE2lRL+X76s8isX3whytCWJUvUvD0pAJ+j8RoUyv47aG/5G/7qDAvUk/UVSQ6JbzkPJLZ9/xchRpNJXCQHnP3JizY2UMYaqOTq5JIL/m2POGaUP3eEswykpdut0Ke64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709638027; c=relaxed/simple;
	bh=8J3F7dpUbugfhUSCrPuCrCvwKLWOTzLlmXb9efyMG+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BIS/0FZLF8OdpVeg3n2mkOpbAhIya+KGqIbjVcUrjfGdK1LezECjHIGEl0GpFyCW8Uc+Ud6Ag4Acl4iWwqMNCaoO2s4Vp8deaKmlV+KqfS5fJTE7yvO0VayF0M/6Jte3E5RF/FB87tr4wq+Crp8oGJY1KoBZwPaaq/bsNxjdr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=q/icdnj/; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=valentinobst.de;
	s=s1-ionos; t=1709638007; x=1710242807; i=kernel@valentinobst.de;
	bh=8J3F7dpUbugfhUSCrPuCrCvwKLWOTzLlmXb9efyMG+Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=q/icdnj/qAB2qiBv8Kg24voOdG/3+W25Sct4I/y+bU8i2P6nZ7y+7C8uKwAd0+G+
	 EPeQleX5Uz70EEoM8KN3ZSikDoMjWs1Ad9loPVVOUEn4fLFXglI2HB+IFCNuqUVk0
	 Y0EbunVsk5yPDO028PTeJg7gPgmO8xzqUPEiAmJTl21NX790GnAHaEJH7nAUjQZVT
	 oZY3TLnZm1T+mK/xYvWQTSh0bPsS+LHw9WYzAsI64cJS4wSqZ9oH8uXufr7fwLJg0
	 bJB0AgAVeIfIZRegjNZMhYiuNAVSk+a29l9rmI1f1W+pHPv8+VAEdiH8CzKK7Daw7
	 KwYjT71uDpJzT+cmVQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost.localdomain ([95.223.130.98]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1Mwfj0-1qwTxX2Gi2-00yC8T; Tue, 05 Mar 2024 12:20:21 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: aliceryhl@google.com
Cc: Jamie.Cunliffe@arm.com,
	a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	ardb@kernel.org,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	gary@garyguo.net,
	keescook@chromium.org,
	kernel@valentinobst.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	maz@kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	nicolas@fjasle.eu,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	samitolvanen@google.com,
	wedsonaf@gmail.com,
	will@kernel.org
Subject: Re: [PATCH] rust: add flags for shadow call stack sanitizer
Date: Tue,  5 Mar 2024 12:20:17 +0100
Message-ID: <20240305112017.125061-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CAH5fLgg0yGbuHnMbMB103Zssg4KSfXUR3kvhr0kuqTSah=6kWg@mail.gmail.com>
References: <CAH5fLgg0yGbuHnMbMB103Zssg4KSfXUR3kvhr0kuqTSah=6kWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:gEEJ6cSatmSGonn8Io6yx8x3YGsfuJgCroTsfGdlZH25jmjFENX
 28qC2V9HneRd0N2YxzZt834iCQM8rhN8kZ1MTw1f0AGpDu1VwXQh61OWz19AOEyqbUxCjob
 iX9omwwG+FLWXzCIAxr+UaGPmyrPutpQWF4d231oD/CP3w5IR/41gcuMix0mM3pGz74azUx
 ZmnHUMEi4UoT4S1eiAi6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vedfcIpbmPY=;dZuHOCTtIcJA3uYMlVFkIktOqig
 WT8LPNbCsxSxVCGp2kyR8w2z9GBJsIBfW2JhKFiTeMPbNqhaeBp+aQwHLayiDjVKuCAGd/OAS
 lhpjdAjPhDDvt1F73nZ//+LEL1loUfl2DrImh3PR6xAEPN1CSueOWYG9SCqFuTJv5XMXEdJZ9
 kU+nZ0pZuWkw1MEY0TpS8UcXK4VArFEQ66JXzykqDSZvxDSmLJ6NhQqb4ns6BvuTrkEP3EEp1
 4MUX7YGo/IYFrW4W+VWGubYlFNwvx8S260h4bzq5Tg0dNnHGlV8tI9JBTVo04lTqhXj9WZQWA
 BeSK1vicUOGSGuMmzX6zrMzbs84VikgL6mRszQ+vUpqMavmqla8vNRwJkEVM8gm+aE8ntJ5eq
 CeeeiLZ11z5MMn1NRfBFQCwFmVCXPYH3/6ehf8UISd8L7LjjPDN0cWvta/VJNx+LcMQkpKLYu
 vCHDWUZMWIJ7QvPXl9zxGgtB1mbrnc6phBSHZUArdcJrpZqk4VrtjKyhilotfE9jhuw464HGV
 q+tbJUIifmVzwijpNRJJ/RfubK6GvV7nigG1c2RGVWG7KNDrFnZ/F0l7xv3UYvAC4GFOomWhY
 HBbPBfmv1hZB9FK2VH3fe9xV+tg+0Pw1Pmr8YDldRdCVr0wjcf0P6ynOBKv9Zzcie6VTU51TM
 57iFh+BQHKgGdCcfU01Dm+b8eSKiO1AIdUgWF3Ku7Mjz1OFQl4n9PK3MGniULBX397nd2jL0V
 x+Xauh1zQOIXGjlb0xTFF/uWOb4vioPj5BOFir7oLemipa9aRG4Y4s=

> >>> It's not 100% clear to me whether this patch is enough for full SCS
> >>> support in Rust. If there is some issue where this makes things compile
> >>> and work without actually applying SCS to the Rust code, please let me
> >>> know. Is there some way to verify that it is actually working?
> >>
> >> Perhaps you could write a Rust version of the CFI_BACKWARD test in LKDTM?
> >>
> >> Alternatively, the simplest way to verify this is to look at the
> >> disassembly and verify that shadow stack instructions are emitted to
> >> Rust functions too. In case of dynamic SCS, you might need to dump
> >> function memory in a debugger to verify that PAC instructions were
> >> patched correctly. If they're not, the code will just quietly continue
> >> working without using shadow stacks.
> >
> > Was just in the process of doing that:
> >
> > - `paciasp`/`autiasp` pairs are emitted for functions in Rust modules.
> > - Rust modules have no `.init.eh_frame` section, which implies that
> >   `module_finalize` is _not_ rewriting the pac insns when SCS is dynamic.
> >   - Confirmed that behavior in the debugger (C modules and the C part of the
> >     kernel are correctly rewritten, Rust modules execute with
> >     `paciasp`/`autiasp` still in place).
> > - Kernel boots just fine with Rust kunit tests, tested with and without dynamic
> >   SCS, i.e., on a CPU that supports PAC/BTI and one that does not.
> > - Rust sample modules load and unload without problems as well.
> > - `x18` is indeed not used in the codegen.
> >
> > I guess we might be able to get this working when we tweak the build system
> > to emit the missing section for Rust modules.
>
> I suppose the -Cforce-unwind-tables=y flag will most likely do it.

Yes, enabling this means that `.eh_frame` sections, which are converted to
`.init.eh_frame` sections for loadable modules, are generated for Rust
objects.

Tested booting, kunit tests, sample modules (as builtin and loadable) for
both, dynamic SCS active and inactive. Backtraces on Rust panicks also look
normal.

Confirmed that in the debugger that builtin and external modules are
rewritten (or not rewritten if no dynamic SCS). Did not check that the
`eh_frame` sections are exhaustive, i.e., cover all `paciasp`/`autiasp`
pairs, only verified a few functions (in init text and normal text).

> There's also an use_sync_unwind option, but it defaults to no, so it
> doesn't seem like we need to set it.

Are those defaults stable or will we notice if they change? If not it might
make sense to set it explicitly anyways to avoid surprises in the future.

    - Best Valentin

>
> Alice
>
>

