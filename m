Return-Path: <linux-kernel+bounces-14513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D94C821E20
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB48828397C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9973F12E67;
	Tue,  2 Jan 2024 14:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9Kot7xB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96A12E55;
	Tue,  2 Jan 2024 14:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A473EC433C8;
	Tue,  2 Jan 2024 14:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704207201;
	bh=33py32HipQADVMip2QWDvskvo4ArE+O9uBBmaumLfiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9Kot7xBJ+tffPDF2Uq3v1XI+nGy2eUAWOpn4y8nL9vnMOUEOx1xZ74j/PwQFV2xk
	 HdZwBzfSSAIKpG5mlPQTWHhmfa4u4U2m3eeXCDACaCDk21Q+axko7rhR5gjZO1kLrL
	 0WVp/stC/NEtPgZTE6om7EWBaDttRk8HLkCyqebdjKBXWvOae431bqSrBteisYnq7/
	 05cL3O/gmcD8jwlHnaT/z8SsUR0jUWX5izW1RoFOiBPJfVa4VUK4v8c7ehYwF8BAbx
	 p3tFIucCeWupZ8yhu6Xo0CIH8eiG5mivO3ccyPepCNRFfggRU3QqSsJ2Ex679D2BXT
	 JFMQGgB3FeYpw==
Received: (nullmailer pid 2821843 invoked by uid 1000);
	Tue, 02 Jan 2024 14:53:17 -0000
Date: Tue, 2 Jan 2024 07:53:17 -0700
From: Rob Herring <robh@kernel.org>
To: Alexander Graf <graf@amazon.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org, linux-doc@vger.kernel.org, x86@kernel.org, Eric Biederman <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>, Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com, Anthony Yznaga <anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, David Woodhouse <dwmw@amazon.co.uk>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 17/17] devicetree: Add bindings for ftrace KHO
Message-ID: <20240102145317.GA2815776-robh@kernel.org>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-12-graf@amazon.com>
 <39a33f9b-0290-428d-ab1f-f90856cdb31d@kernel.org>
 <34e78a84-a29d-4b01-a860-cac3959f6cb6@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34e78a84-a29d-4b01-a860-cac3959f6cb6@amazon.com>

On Sun, Dec 24, 2023 at 12:20:17AM +0100, Alexander Graf wrote:
> Hi Krzysztof!
> 
> Thanks a lot for the fast review!
> 
> On 23.12.23 15:30, Krzysztof Kozlowski wrote:
> > On 22/12/2023 20:51, Alexander Graf wrote:
> > > With ftrace in KHO, we are creating an ABI between old kernel and new
> > > kernel about the state that they transfer. To ensure that we document
> > > that state and catch any breaking change, let's add its schema to the
> > > common devicetree bindings. This way, we can quickly reason about the
> > > state that gets passed.
> > Please use scripts/get_maintainers.pl to get a list of necessary people
> > and lists to CC (and consider --no-git-fallback argument). It might
> > happen, that command when run on an older kernel, gives you outdated
> > entries. Therefore please be sure you base your patches on recent Linux
> > kernel.

[...]

> > 
> > > +            mem = < 0x101000000ULL 0x38ULL 0x101000100ULL 0x1000ULL 0x101000038ULL 0x38ULL 0x101002000ULL 0x1000ULL>;
> > ? Do you see any of such syntax in DTS?
> 
> 
> I was trying to make it easy to reason to readers about 64bit numbers - and
> then potentially extend dtc to consume that new syntax. KHO DTs are
> native/little endian, so dtc already has some difficulties interpreting it
> which I'll need to fix up with patches to it eventually :). I'll change it
> to something that looks more 32bit'y for now.

"/bits/ 64 <0x0 ...>" is what you are looking for.

Rob

