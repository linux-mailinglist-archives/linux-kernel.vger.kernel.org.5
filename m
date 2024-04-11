Return-Path: <linux-kernel+bounces-141486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 023FD8A1ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2161F2B472
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CB8205E2F;
	Thu, 11 Apr 2024 18:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="SxfDLmbn"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5E315E88
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712861027; cv=none; b=TVZNE49AqQmQm3BtYjJenEjWl4Gb0bKzZfgH5jh8jXpwlSKKy7TODV2ZHua+6AEXxqS21LEQ9tSErQOf2uY8uD6h1VedF+B7ghvBwkAWnvtJA8plppWzuaWjzRPmB3O4UjbDTEESyeLlH05/5wMrCaTa+dD95pO2VH1FMAOZ8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712861027; c=relaxed/simple;
	bh=a3JvUEhgYK+th3NCl2xP4vXg/lpXBSLqgc8nLV72rpU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nmBr969aRNWhXgNzpLhMIlw2aEw9BDl78QFRs+VW5qP6+yHKgd/zCSYICYrfPdweqXgACcZ6Hekz0CAarpQ4OwWAaaeYY67Ezm41PTX0pi+aThsWsDwSZgftiWrtQWaMzIcD6xE7498Q2OI7pPBtcmOYqbqZpxr0JC2Vo+M/SW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=SxfDLmbn; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 162A24269B;
	Thu, 11 Apr 2024 18:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1712861022; bh=a3JvUEhgYK+th3NCl2xP4vXg/lpXBSLqgc8nLV72rpU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=SxfDLmbn4C0FHradf1Xvj6eoisfqZiNOMVhNdxdgHo1NXlIB/dbWS/wzj7bn6DGW/
	 NTt6SGUM8bZrQe1tL93LuYhRW67a4Imuzypj7Kyz8L5KRHP0KQqoTXOLfWYVI7bvAe
	 M+fdkh7Z1E0OnNt1boNhIk7u9FsTO0sAekynhELR0de5yFs2lr1xtmxYdeDa6pehzF
	 LKJiq4QJpwlqoQ+p63rnkcUDDB/Lo/UPQrqmsa+qVuYvSLpezbl3c9OIl/YtYiEgD+
	 sOsykq2DUWdG71dSOs48cNQHSHF+9gaFcPhQ8Kyp0Uu/YkyzblwkZj7kL+KuaSH0MS
	 TcEp9qwJBnqDw==
Message-ID: <f6484dcd-ebf6-4b6f-be17-69b05539e33b@marcan.st>
Date: Fri, 12 Apr 2024 03:43:36 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64: Support the TSO memory model
From: Hector Martin <marcan@marcan.st>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Zayd Qumsieh <zayd_qumsieh@apple.com>,
 Justin Lu <ih_justin@apple.com>, Ryan Houdek <Houdek.Ryan@fex-emu.org>,
 Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mateusz Guzik <mjguzik@gmail.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>, Miguel Luis <miguel.luis@oracle.com>,
 Joey Gouly <joey.gouly@arm.com>, Christoph Paasch <cpaasch@apple.com>,
 Kees Cook <keescook@chromium.org>, Sami Tolvanen <samitolvanen@google.com>,
 Baoquan He <bhe@redhat.com>, Joel Granados <j.granados@samsung.com>,
 Dawei Li <dawei.li@shingroup.cn>, Andrew Morton <akpm@linux-foundation.org>,
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>,
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Asahi Linux <asahi@lists.linux.dev>
References: <20240411-tso-v1-0-754f11abfbff@marcan.st>
 <20240411132853.GA26481@willie-the-truck>
 <28ab55b3-e699-4487-b332-f1f20a6b22a1@marcan.st>
Content-Language: en-US
In-Reply-To: <28ab55b3-e699-4487-b332-f1f20a6b22a1@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/04/11 23:19, Hector Martin wrote:
>>
>> An alternative option is to go down the SPARC RMO route and just enable
>> TSO statically (although presumably in the firmware) for Apple silicon.
>> I'm assuming that has a performance impact for native code?
> 
> Correct. We already have this as a bootloader option, but it is not
> desirable. Plus, userspace code still needs a way to *discover* that TSO
> is enabled for correctness, so it can automatically decide whether to
> use stronger or weaker instructions.

To add some numbers to this (I was just made aware of this paper):

https://www.sra.uni-hannover.de/Publications/2023/tosting-arcs23/wrenger_23_arcs.pdf

Using TSO globally has, on average, a 9% performance hit, so that is
clearly off the table as a general solution.

Meanwhile, more detailed microbenchmarks often show TSO as having better
performance than outright using acquire/release instructions without
TSO. Therefore, just giving up on TSO and using acq/rel semantics for
emulators is also not an acceptable solution.

Additionally, the general load/store instructions on ARM have more
flexible addressing modes than the synchronizing ones, and since general
x86 emulation requires *all* loads and stores to be like this in a
non-TSO model (without much more complex/expensive program analysis to
determine where this can be elided), the perf impact is definitely worse
for emulation (e.g. stack accesses are affected) than for a
microbenchmark where only the "target" test instructions are being modified.

- Hector

