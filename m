Return-Path: <linux-kernel+bounces-20588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2128281EB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE5F287775
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7406B186E;
	Tue,  9 Jan 2024 08:30:02 +0000 (UTC)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61093716B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.crashing.org
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 4098QmWa018414;
	Tue, 9 Jan 2024 02:26:48 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 4098Qmev018413;
	Tue, 9 Jan 2024 02:26:48 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Tue, 9 Jan 2024 02:26:47 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: richard clark <richard.xnu.clark@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>, gcc-help@gcc.gnu.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: undefined reference to `__aarch64_cas4_sync' error on arm64 native build
Message-ID: <20240109082647.GJ19790@gate.crashing.org>
References: <CAJNi4rO+Dw5qYDtyJVbuo0OqAoXpGq_Qq6xjH9cvMCAUnW+77g@mail.gmail.com> <CAJNi4rMHtM=39jzkzwqt++kVpSp0=XfDrVdY94WoW6B34oKwDA@mail.gmail.com> <ZZb2f0U4qTWDjCGj@FVFF77S0Q05N.cambridge.arm.com> <CAJNi4rOpzmQAW1Fjst-Em=SQ7q8QsQh0PWhVxUizrOW9JukOgQ@mail.gmail.com> <ZZvS8rigFJR8L56c@FVFF77S0Q05N> <fb6c8253fd90e66c036a85954c3299bc2c047473.camel@xry111.site> <CAJNi4rPj0Wc7ByqrS-GVLUUEnOFPZi8A5nLLCEEJErqAe16EZw@mail.gmail.com> <9aef98eed96ed32962ce90499291cb30ad5e3e14.camel@xry111.site> <20240109074843.GI19790@gate.crashing.org> <4ee8067e72028b070d92e10fa33ddde3a498cb48.camel@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ee8067e72028b070d92e10fa33ddde3a498cb48.camel@xry111.site>
User-Agent: Mutt/1.4.2.3i

On Tue, Jan 09, 2024 at 04:09:20PM +0800, Xi Ruoyao wrote:
> If GCC is configured with things like --with-arch=something, libgcc can
> contain (FP/vector) instructions unsafe to use in kernel w/o special
> handling.

No, it can not.  Please file a bug (<https://gcc.gnu.org/bugs.html>) if
this happens to you.  Thanks!

--with-arch= only sets the *default* options, the user can override this
always (with an -march= option, say).

> If libgcc is so vital GCC needs to provide a way to make it work for a
> set of compiler switches incompatible with any pre-built multilib.  For
> example, installing the source of libgcc into /usr/lib/gcc and provide a
> tool to build a libgcc.a with the specified options.

That is how things are supposed to work, already.  Either libgcc uses
only instructions that work everywhere, or libgcc is multilibbed, things
like that.  In all normal cases this is completely transparent to the
compiler user.


Segher

