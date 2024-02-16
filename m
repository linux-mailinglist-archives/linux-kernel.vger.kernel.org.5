Return-Path: <linux-kernel+bounces-69104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D85A858481
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04161F21338
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAE513249C;
	Fri, 16 Feb 2024 17:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSSKlAF3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03758131722
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105732; cv=none; b=iAY3NrIa2tw6Vb2sbJ4+YgGNFqmAjK0e37M/ho4576Zn9LqfGNapkVtrzKJwR3Z4eVUPIxzlICKBy8JYyZ8/VvU0kYtBrqwvXly1sXIy579/kF5SNEh0xack7kk4aolbyfrruZKb+UmIk+0ze+sgXZZD4Ow0Aiq7XjjxaIemnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105732; c=relaxed/simple;
	bh=wTRb9lJ0nVs4kr0sv4yA4lFLI2PF0QM9GnJww5OBJ9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=luMrhzxoQJ7/VeeUHdqdx4IhZ8OBfIfhnrV1+xwMF2HU8ljZODuyxHhIOPVDhcFLxmFTfZzd9qsbZRP9ywIohLqydZaAnb4MjXL+OpfUkf9PhGVSHo0SgWWU4B7sfdFcB+kfefIEe3OZ8qHXL+UeK7k+FLfQoaIQnzr5pEgiWgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSSKlAF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A38CC433C7;
	Fri, 16 Feb 2024 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708105731;
	bh=wTRb9lJ0nVs4kr0sv4yA4lFLI2PF0QM9GnJww5OBJ9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSSKlAF3eXLA8VlBrRn9Clb5GmJmIBYwtt1LziBZ8emY4Da0LSr4Pl7Cu1kdAkLji
	 vvRP8MxDQdrKnsZs/A3dpE3ogO5vObIZwHdJBpQPHbCNXgBWC79CVJmQcCn7Ippixm
	 JaorLxNqiCKhcqRhQVzPX7TyLJ3iEdor9LD11RZtmXmrL2ygslb7TpM7M8EDWuqy7b
	 gpzbWyxoj5sh1i6G0mXD5fqWBv5iUHusYj+30Y1lifuEX4isW5GBNybcYUPSBDBSbB
	 nsU+Rh3RuJSc+PsVES4zGgsDK43PVZrm3cs2zSWzIABA9pzgSs1KLVvDeoJbxJPMjR
	 jaxaFuZ4TMldA==
Date: Fri, 16 Feb 2024 14:48:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf augmented_raw_syscalls.bpf: Move 'struct
 timespec64' to vmlinux.h
Message-ID: <Zc-gAKByhLBV_X59@x1>
References: <Zb1EBzpBn4s-mIa8@x1>
 <CAM9d7ch6tvwMgdOg=1hZqE23bQUKDtYOdyJ16kkyt+6uY4q7pw@mail.gmail.com>
 <CAM9d7cgPAuY=R2FTOc8ffZpe_O9iaosZ7FNHvpB-aCk9pj1N4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgPAuY=R2FTOc8ffZpe_O9iaosZ7FNHvpB-aCk9pj1N4A@mail.gmail.com>

On Mon, Feb 05, 2024 at 03:16:25PM -0800, Namhyung Kim wrote:
> On Fri, Feb 2, 2024 at 6:01 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Fri, Feb 2, 2024 at 11:35 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > If we instead decide to generate vmlinux.h from BTF info, it will be
> > > there:

> > >   $ pahole timespec64
> > >   struct timespec64 {
> > >         time64_t                   tv_sec;               /*     0     8 */
> > >         long int                   tv_nsec;              /*     8     8 */
> > >   };

> > Acked-by: Namhyung Kim <namhyung@kernel.org>
 
> Hmm.. but it makes it fail to build with GEN_VMLINUX_H=1.
 
>   CLANG   linux/tools/perf/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
> In file included from util/bpf_skel/augmented_raw_syscalls.bpf.c:10:
> linux/tools/include/uapi/linux/bpf.h:55:2: error: redefinition of
> enumerator 'BPF_REG_0'
>         BPF_REG_0 = 0,
>         ^
> linux/tools/perf/util/bpf_skel/.tmp/../vmlinux.h:46833:2: note:
> previous definition is here
>         BPF_REG_0 = 0,
>         ^

Right, the following oneliner fixes it (the minimalistic pre-built
vmlinux.h we carry when not using GEN_VMLINUX_H=1 already has it), I'll
squash it, do some container test builds and resend.

- Arnaldo

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index d3b672593c540259..0acbd74e8c760956 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -7,7 +7,6 @@
  */
 
 #include "vmlinux.h"
-#include <linux/bpf.h>
 #include <bpf/bpf_helpers.h>
 #include <linux/limits.h>
 

