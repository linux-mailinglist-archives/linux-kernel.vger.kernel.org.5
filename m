Return-Path: <linux-kernel+bounces-106524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 995B387EFD9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6C4B22C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1636538DD3;
	Mon, 18 Mar 2024 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="G9MnHFNA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vWHDqHgm"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC39B2032C;
	Mon, 18 Mar 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787030; cv=none; b=m8CkzgG/oSHE6+xqiHsc34YCZf1w91gumVBrW0YOeFxyIq5V9U2lw33yk9NX7WYQJDTR0HIx0HvFezVN1KXwfa1UTufSzkmn6icR0kyrN6sceoDe5NutMZUbNvwY5TGx3xlD/pOqfYXBvY2SQ8O/0N+qirue1VJQcrcXqgturkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787030; c=relaxed/simple;
	bh=xxE50xPMPYB11vGzAhAyE+tFfO87yBa51aO6I/ChkXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAKylIyZfhev4wFAWhLYkH/A5UD6nHGNhRd5A5wR04fa4NGprQ5Z7J3JGcjRs7a5DFZlxKOUI/s2XvxiTbjmrs/xn1IleKEDEIqGhJJQ5I/G3OBONAiemKWhS1G0JFoXNP8oZgsBo/FI4dE+eZ2Fn7necT/xVeR80y0lrTN7x7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=G9MnHFNA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vWHDqHgm; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 85AE7320015C;
	Mon, 18 Mar 2024 14:37:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 18 Mar 2024 14:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1710787025;
	 x=1710873425; bh=o6YQkt2TIA7njQXTlYbqx7Op1KWTM9KAfdSpYmpRw/k=; b=
	G9MnHFNA6P1U+CKmLtgPSjOtDSXCHaUH1P/+EhaBDz9x/JwG15m2oWNYUe+Naw/7
	++y4FSBd3BtXQemHGH6O4mWdj1MMXRNKZQsX6MeCsv4nPzvOHRYdKApSFqJH+c3G
	U+0/NxjwY7QQ8DvsyBHeZY3dOBLabx1OhilFAXODExq4KZZjobt+3Q4rxn6rhbqW
	fzZa/gturj6BPDjza5JRPcBX43wg2xEBJEl+fHjRBXCvStH63hwErgeSlzLx/GRh
	Zbj2lgI1ErZhriP1yhFeFNzoEezyfW9jAEn9ix2gEy9iPIHHaSUx7eMK21UeXfkX
	0c9Fjca81fEnzW0XdIzEjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1710787025; x=
	1710873425; bh=o6YQkt2TIA7njQXTlYbqx7Op1KWTM9KAfdSpYmpRw/k=; b=v
	WHDqHgmffn21rCfa5HAk9mqKWwPPYAx2oogV1QozmTz4d5VvzaRgIlOmZx7rhFZx
	vuYknEbZldnpXyNyKpxTqQsRUWcih7Cw35nFO/0eBIvtIKazbFxxsXhwpO/7k3a3
	P7EiLJ/nWJMe4Rm4oCRnBecWy20RI4NgxeE3vcU5srbqxH2dKSK345oNhMl+fd+g
	SO6A7V1/ZaOUzGYJ7uofR5YCR8iAjyVuXiGY5s1ZqQS6WG6gcoTQRVhgGgqbTqm0
	a5kQxRaKw3mFKdGrrr307sbudrifyGY/1FVJIYlWumT4LgYOzZ4l3ws9iirPG9YH
	ois+4gdU9eZhO5z/mbRgQ==
X-ME-Sender: <xms:0In4ZSjRE5r6mHiQd2rCNYYxHi8zVymVI3kttcxy0rGrpaEB_efbAw>
    <xme:0In4ZTAaMDHC4M3gf0A9rBRYaKpMQ8WodX3dd1eK9-8MvIKYp0HqQleM_GXgVxqZN
    ZM4rFVgUDJf8PMFAQ>
X-ME-Received: <xmr:0In4ZaGeouQB_asArTyHMheETxU9NLkNFDNhbIIpgOTQtqJKyKVRdgOsK1h5_NNNV09Dyrg3pC9SxCS9HsMhqiCwxuzQNDr0f_p5ucw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvvefukfhfgggtugfgjgestheksfdt
    tddtjeenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedvuddvudeiteefjeegheeuudfhgefhkeekteeulefggeev
    heevieekffffiedvtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdr
    giihii
X-ME-Proxy: <xmx:0In4ZbScEZMVxYb1AdrQYuclh4SGfZzY_PiLlq44pj8ny5GcMeDs9g>
    <xmx:0In4Zfw0fTtOW7S2S1c5-IZRMHyoV7EypZDQ-P56jD33HUXQ5s3ENw>
    <xmx:0In4ZZ6TILMJe1rp1OdZ5TDSChWtmSCpObLFu8rf5rNA3gW5M1uIYQ>
    <xmx:0In4ZcxfxBUFjJlHiqTogRRH0dq9O4TgG3EnmK3Qe7f8qT8ThBK95A>
    <xmx:0Yn4ZfnlvnA7lwAc3ONLg6T_ZjnxkekDwBlYgG3N8-LvJ-rhkzJYhw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 14:37:03 -0400 (EDT)
Date: Mon, 18 Mar 2024 12:37:01 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: quentin@isovalent.com, daniel@iogearbox.net, ast@kernel.org, 
	andrii@kernel.org, olsajiri@gmail.com, alan.maguire@oracle.com, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] bpftool: Support dumping kfunc
 prototypes from BTF
Message-ID: <rbivyqu3i57xdtetdjsvwxp4fdstvgmnhmhh2py4jqgzror4az@z3mwj5xvrymc>
References: <cover.1707080349.git.dxu@dxuuu.xyz>
 <9b8ebd13300e28bd92a2e6de4fb04f85c1b6ce7c.1707080349.git.dxu@dxuuu.xyz>
 <CAEf4BzaSSTY0KTBYACvvVUeKVWd9wO+FM91E-9ES4dHwY-wX+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaSSTY0KTBYACvvVUeKVWd9wO+FM91E-9ES4dHwY-wX+w@mail.gmail.com>

Hi Andrii,

On Wed, Feb 07, 2024 at 04:50:15PM -0800, Andrii Nakryiko wrote:
> On Sun, Feb 4, 2024 at 1:07 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >
> > This patch enables dumping kfunc prototypes from bpftool. This is useful
> > b/c with this patch, end users will no longer have to manually define
> > kfunc prototypes. For the kernel tree, this also means we can drop
> > kfunc prototypes from:
> >
> >         tools/testing/selftests/bpf/bpf_kfuncs.h
> >         tools/testing/selftests/bpf/bpf_experimental.h
> >
> > Example usage:
> >
> >         $ make PAHOLE=/home/dxu/dev/pahole/build/pahole -j30 vmlinux
> >
> >         $ ./tools/bpf/bpftool/bpftool btf dump file ./vmlinux format c | rg "__ksym;" | head -3
> >         extern void cgroup_rstat_updated(struct cgroup *cgrp, int cpu) __weak __ksym;
> >         extern void cgroup_rstat_flush(struct cgroup *cgrp) __weak __ksym;
> >         extern struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags) __weak __ksym;
> >
> > Note that this patch is only effective after the enabling pahole [0]
> > change is merged and the resulting feature enabled with
> > --btf_features=decl_tag_kfuncs.
> >
> > [0]: https://lore.kernel.org/bpf/cover.1707071969.git.dxu@dxuuu.xyz/
> >
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> >  tools/bpf/bpftool/btf.c | 45 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> > index 91fcb75babe3..0fd78a476286 100644
> > --- a/tools/bpf/bpftool/btf.c
> > +++ b/tools/bpf/bpftool/btf.c
> > @@ -20,6 +20,8 @@
> >  #include "json_writer.h"
> >  #include "main.h"
> >
> > +#define KFUNC_DECL_TAG         "bpf_kfunc"
> > +
> >  static const char * const btf_kind_str[NR_BTF_KINDS] = {
> >         [BTF_KIND_UNKN]         = "UNKNOWN",
> >         [BTF_KIND_INT]          = "INT",
> > @@ -454,6 +456,39 @@ static int dump_btf_raw(const struct btf *btf,
> >         return 0;
> >  }
> >
> > +static int dump_btf_kfuncs(struct btf_dump *d, const struct btf *btf)
> > +{
> > +       DECLARE_LIBBPF_OPTS(btf_dump_emit_type_decl_opts, opts);
> 
> nit: use shorter LIBBPF_OPTS, DECLARE_LIBBPF_OPTS is a "deprecated"
> macro name I hid, but didn't remove

Ack.

> 
> > +       int cnt = btf__type_cnt(btf);
> > +       int i;
> > +
> > +       for (i = 1; i < cnt; i++) {
> > +               const struct btf_type *t = btf__type_by_id(btf, i);
> > +               const struct btf_type *kft;
> > +               const char *name;
> > +               int err;
> > +
> > +               if (!btf_is_decl_tag(t))
> > +                       continue;
> > +
> > +               name = btf__name_by_offset(btf, t->name_off);
> > +               if (strncmp(name, KFUNC_DECL_TAG, sizeof(KFUNC_DECL_TAG)))
> > +                       continue;
> 
> should we do a bit more sanity checking here? Check that component_idx
> = -1 (entire func) and pointee type is FUNC?

Makes sense. Will add.

> 
> > +
> > +               printf("extern ");
> > +
> > +               kft = btf__type_by_id(btf, t->type);
> 
> nit: reuse t?
> 
> > +               opts.field_name = btf__name_by_offset(btf, kft->name_off);
> > +               err = btf_dump__emit_type_decl(d, kft->type, &opts);
> > +               if (err)
> > +                       return err;
> > +
> > +               printf(" __weak __ksym;\n\n");
> 
> why extra endline?

Was thinking b/c other entities (structs) are double newline separated
that we should keep it up for kfunc prototypes. No opinion -- I'll
change it.

> 
> though I'd ensure two empty lines before the first kfunc declaration
> to visually separate it from other type. Maybe even add a comment like
> `/* BPF kfuncs */` or something like that?

Ack.

> 
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static void __printf(2, 0) btf_dump_printf(void *ctx,
> >                                            const char *fmt, va_list args)
> >  {
> > @@ -476,6 +511,12 @@ static int dump_btf_c(const struct btf *btf,
> >         printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
> >         printf("#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)\n");
> >         printf("#endif\n\n");
> > +       printf("#ifndef __ksym\n");
> > +       printf("#define __ksym __attribute__((section(\".ksyms\")))\n");
> > +       printf("#endif\n\n");
> > +       printf("#ifndef __weak\n");
> > +       printf("#define __weak __attribute__((weak))\n");
> > +       printf("#endif\n\n");
> >
> >         if (root_type_cnt) {
> >                 for (i = 0; i < root_type_cnt; i++) {
> > @@ -491,6 +532,10 @@ static int dump_btf_c(const struct btf *btf,
> >                         if (err)
> >                                 goto done;
> >                 }
> > +
> > +               err = dump_btf_kfuncs(d, btf);
> > +               if (err)
> > +                       goto done;
> >         }
> >
> >         printf("#ifndef BPF_NO_PRESERVE_ACCESS_INDEX\n");
> > --
> > 2.42.1
> >

I'll send the next rev after the pahole changes get merged.

Thanks,
Daniel

