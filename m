Return-Path: <linux-kernel+bounces-97589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A57876C3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294FFB20F10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E775F578;
	Fri,  8 Mar 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlUEfC23"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8DF17745;
	Fri,  8 Mar 2024 21:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931898; cv=none; b=rCfQ+N58xE59xLOdtdBgZ9jqq7Rcmp+SFlwOmIF/8gPMF+PCt0dTDkan2H5UOW+gtAYAj10TJSzFUTzNQTWDPpkfwD1kXXd4bn3yZvp1ElTWVK7vvmNO1MN7LUfU+uqWGv0u2U5DSfTW+wNJv4q34aT40LAi7ZOHSnrF67FpJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931898; c=relaxed/simple;
	bh=2GHIXJPloA0g/FHvC8srFZitcWCm5kq+2bTiaMIbpSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJf2wClegnxGScLMQD4HoOxiEhYkCrJe8uA6aGii8vTxuFe5jWaaPkjSJfKYJ+QPtiYWSCsVODOvlu33Slqz0X3ZkxvSP1DsDcbb2BBPwGRJj5inwKfqE/Aj1BSfsg+ntgJFL/+7bjvKGNpCq4g/3sDZvCJz01z+WVJ5nQXDi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlUEfC23; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e66da40b18so797765b3a.0;
        Fri, 08 Mar 2024 13:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709931896; x=1710536696; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fjpZAMJBAu9QgQuXUo9LhCs4dCb/6W9jscOKJm3Xm7o=;
        b=WlUEfC23WH4rxcn+E8Bh/AqsxYULQrIQrShqjZtf+8HvFJ6ogPdFR+1QvbJp+8ywPs
         6Y1D+hNJ5Uv2e8bKvrkScnA1vMPS+ORjTocQgkHdWcD1Pwvrz33+oPPGqXiI1BjNM+ym
         TBbFry/xIhrjKMda06ddMiSkLZLm0MFjVqlThce5sJN+xxCvj71oxwq5BCsq4GLtmgS5
         49tRlF5P8MI2JuzQDNwZctM75ZoJRCOTJSMm3s9RkxBpDGt9KtEXwcqCuYsFixWEm7uF
         SWGWyd3va5EJjPNDpJo0zWz406ytO68YygMUU0lUd/ARPbyepxofOedOkzKqrZ1uVw1n
         0b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709931896; x=1710536696;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjpZAMJBAu9QgQuXUo9LhCs4dCb/6W9jscOKJm3Xm7o=;
        b=kfyCnE1hz7OKOp0twj462EC2wa9e4ax5cq6pZoKRPcZWAnggXwn3sFunZin/MquEl+
         +I8D2OPl4NGTYeENw3wQKO2vl9FzzZ+hJroJ+cgB+j7pQGAfWRCYsrt+WP2M+zerBkLk
         oYw4cVGb1GdGq2HRlGf+Rk/GrVGbNSYnvAEiRnvU9ehDSH+vwONjfWT7lWkCbyYGtgNg
         aNsnKrD79xSWEyfXRXN32dmkFTTbrl7x02RKqgxnKaXvTARgJYL+DBR5SjtJpz8aOxvo
         lPfQf3dbAzwtAqTPdIX77WRtX0s6C0NtHyo+c1QyLV81tUI40JVHhSgu7W28qowLihNA
         wg4A==
X-Forwarded-Encrypted: i=1; AJvYcCXl3s6uJXUT9LkCSxEIHQCXr+YqGpD+VvyXEHsWIum0FUcDIvGlt/C4hegc6dicEiuWLuNx6FKjzrthqQrjWwqTl36ikRElmSgLO05irhmf7X/CVGiVz8iuCKp+geER/z80UyUtGt/3e1vhb4KX/sgKVE5r6FS8phFN0ot5vwqQqg==
X-Gm-Message-State: AOJu0YyVwnExpxqKx+R/kpmU5xbE9JrKdj8gS0mh9sPftvM8ONQ1PPdt
	ymBuTzmoRXc3RMeyMkft3pVAu6ge+DDDJ0F6I2PUa//WGHjYPka3
X-Google-Smtp-Source: AGHT+IE2bE9o08o/ETuxRvXCqtM11mgsHI6U2w8TrgOkft0uxleWtKI/Ys+602xA43x7/FecWouENQ==
X-Received: by 2002:a05:6a20:6a99:b0:1a1:4d41:3570 with SMTP id bi25-20020a056a206a9900b001a14d413570mr124034pzb.59.1709931896105;
        Fri, 08 Mar 2024 13:04:56 -0800 (PST)
Received: from gmail.com ([192.184.166.229])
        by smtp.gmail.com with ESMTPSA id d12-20020a056a0010cc00b006e55aa75d6csm122920pfu.122.2024.03.08.13.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 13:04:55 -0800 (PST)
Date: Fri, 8 Mar 2024 13:04:53 -0800
From: Calvin Owens <jcalvinowens@gmail.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	David S Miller <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 2/4] bpf: Allow BPF_JIT with CONFIG_MODULES=n
Message-ID: <Zet9ddK2kaEuTrOW@gmail.com>
References: <cover.1709676663.git.jcalvinowens@gmail.com>
 <afebd15dd032f908e46871bec5be438063ae7458.1709676663.git.jcalvinowens@gmail.com>
 <a7ac9672-06d1-4f6a-b676-01c9868ea39c@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7ac9672-06d1-4f6a-b676-01c9868ea39c@csgroup.eu>

On Thursday 03/07 at 22:09 +0000, Christophe Leroy wrote:
> 
> 
> Le 06/03/2024 à 21:05, Calvin Owens a écrit :
> > [Vous ne recevez pas souvent de courriers de jcalvinowens@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > No BPF code has to change, except in struct_ops (for module refs).
> > 
> > This conflicts with bpf-next because of this (relevant) series:
> > 
> >      https://lore.kernel.org/all/20240119225005.668602-1-thinker.li@gmail.com/
> > 
> > If something like this is merged down the road, it can go through
> > bpf-next at leisure once the module_alloc change is in: it's a one-way
> > dependency.
> > 
> > Signed-off-by: Calvin Owens <jcalvinowens@gmail.com>
> > ---
> >   kernel/bpf/Kconfig          |  2 +-
> >   kernel/bpf/bpf_struct_ops.c | 28 ++++++++++++++++++++++++----
> >   2 files changed, 25 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> > index 6a906ff93006..77df483a8925 100644
> > --- a/kernel/bpf/Kconfig
> > +++ b/kernel/bpf/Kconfig
> > @@ -42,7 +42,7 @@ config BPF_JIT
> >          bool "Enable BPF Just In Time compiler"
> >          depends on BPF
> >          depends on HAVE_CBPF_JIT || HAVE_EBPF_JIT
> > -       depends on MODULES
> > +       select MODULE_ALLOC
> >          help
> >            BPF programs are normally handled by a BPF interpreter. This option
> >            allows the kernel to generate native code when a program is loaded
> > diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> > index 02068bd0e4d9..fbf08a1bb00c 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -108,11 +108,30 @@ const struct bpf_prog_ops bpf_struct_ops_prog_ops = {
> >   #endif
> >   };
> > 
> > +#if IS_ENABLED(CONFIG_MODULES)
> 
> Can you avoid ifdefs as much as possible ?

Similar to the other one, this was just a misguided attempt to avoid
triggering -Wunused, I'll clean it up.

This particular patch will look very different when rebased on bpf-next.

> >   static const struct btf_type *module_type;
> > 
> > +static int bpf_struct_module_type_init(struct btf *btf)
> > +{
> > +       s32 module_id;
> 
> Could be:
> 
> 	if (!IS_ENABLED(CONFIG_MODULES))
> 		return 0;
> 
> > +
> > +       module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
> > +       if (module_id < 0)
> > +               return 1;
> > +
> > +       module_type = btf_type_by_id(btf, module_id);
> > +       return 0;
> > +}
> > +#else
> > +static int bpf_struct_module_type_init(struct btf *btf)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> >   void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
> >   {
> > -       s32 type_id, value_id, module_id;
> > +       s32 type_id, value_id;
> >          const struct btf_member *member;
> >          struct bpf_struct_ops *st_ops;
> >          const struct btf_type *t;
> > @@ -125,12 +144,10 @@ void bpf_struct_ops_init(struct btf *btf, struct bpf_verifier_log *log)
> >   #include "bpf_struct_ops_types.h"
> >   #undef BPF_STRUCT_OPS_TYPE
> > 
> > -       module_id = btf_find_by_name_kind(btf, "module", BTF_KIND_STRUCT);
> > -       if (module_id < 0) {
> > +       if (bpf_struct_module_type_init(btf)) {
> >                  pr_warn("Cannot find struct module in btf_vmlinux\n");
> >                  return;
> >          }
> > -       module_type = btf_type_by_id(btf, module_id);
> > 
> >          for (i = 0; i < ARRAY_SIZE(bpf_struct_ops); i++) {
> >                  st_ops = bpf_struct_ops[i];
> > @@ -433,12 +450,15 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
> > 
> >                  moff = __btf_member_bit_offset(t, member) / 8;
> >                  ptype = btf_type_resolve_ptr(btf_vmlinux, member->type, NULL);
> > +
> > +#if IS_ENABLED(CONFIG_MODULES)
> 
> Can't see anything depending on CONFIG_MODULES here, can you instead do:
> 
> 		if (IS_ENABLED(CONFIG_MODULES) && ptype == module_type) {
> 
> >                  if (ptype == module_type) {
> >                          if (*(void **)(udata + moff))
> >                                  goto reset_unlock;
> >                          *(void **)(kdata + moff) = BPF_MODULE_OWNER;
> >                          continue;
> >                  }
> > +#endif
> > 
> >                  err = st_ops->init_member(t, member, kdata, udata);
> >                  if (err < 0)
> > --
> > 2.43.0
> > 
> > 

