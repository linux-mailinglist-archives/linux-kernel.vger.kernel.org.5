Return-Path: <linux-kernel+bounces-50816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B99847E43
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452621C213BB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9247D7468;
	Sat,  3 Feb 2024 01:50:34 +0000 (UTC)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82536FC7;
	Sat,  3 Feb 2024 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706925034; cv=none; b=XTAgcKWbfNRBvIDL5MifMogjJcoTDatuS5QfYg/Uhe99/wzF5pkEWXJIG8Xv2xOrxLb0I+GtL11M0D6P9dhWIk2vBOavkg2Up82FOOiDOswOQOB7RXXoydPmAd8EOaTBWNn297MMuAikXE6zhSge0BsRX3A3/rFueGwpS2NWTUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706925034; c=relaxed/simple;
	bh=wO/AAN7qkMOANrzj2oDNliIrqUtXa0hARBodmlndRVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liVCGqSk1O53lh03mKDVvF1pgFHl5Tdf1sQ7hi1jEM1zQwSFonPbVPmxteE+Maeo8u5aN86GO+VAZJuZjIKTxLg6IfcjJW9YN9tQ06L4yZutmSRfeJwbLXZuTOWtSo6rqkTHoeqdEo0xeD7K+lZLW7LP/Qy0Hr29BRMzCQWot1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so2485180a12.1;
        Fri, 02 Feb 2024 17:50:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706925032; x=1707529832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x7SrZrWWwvN/Zz751LjEUwz2jtidjtV8u+us50VcWCc=;
        b=CLxDGDI+E3DWDyZePji3ykQowqiyIE7mfpLxTU1uC0CRdeCw51D8KAbELrTgR9/PJa
         hsD5JFIL0ieAUO4TmZz6lmVu7kAY4MIiTnSugkYLQDv+mk2egJUgMhPyzG9yriw6/x6L
         ebazlNWmFZeaym/gmYUkwJRVEKBuvwCA2qWBuFwaRx2s5aztHX1wLXR5Ynhan2673MOx
         8EJrUDHhN8unmvSAYXS+R/imP2gRuUocrK6wbXqLEKNzRJcf9dPIQ55OEa0n1CJpccYJ
         yR6dvl5Vdb7fXx08R2pYzqK+TitmXDMnSFRXtE+z2mO89QqN8lOzR6DMOiGjBB9zLkd7
         lLqw==
X-Gm-Message-State: AOJu0YwPflTISAzlCAWOvFf2V8ZiYJGySSuL6o8akkN5gKGf9c5jpkhO
	wM5DNw1AKUpdmATTn15hGeANElWH6xljPyfwOJvRA+CG6OaqRdUjLiWo/40bfhVVzyezweMfiP5
	0h0iYvYBCGs1cYLjJEP6BQ8fCLnPo1qpicfk=
X-Google-Smtp-Source: AGHT+IF+lKbwnE57FXGXoShKSBpJLM8jGkJoDGJQaP1ZdF8uGcAU4DJrjR5hZPmZ9KV6h38FXOc5aoMEDWgHG0yOcws=
X-Received: by 2002:a05:6a20:e54b:b0:19c:b4f1:4538 with SMTP id
 nf11-20020a056a20e54b00b0019cb4f14538mr3121864pzb.24.1706925031801; Fri, 02
 Feb 2024 17:50:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202110130.3553-1-adrian.hunter@intel.com> <20240202110130.3553-2-adrian.hunter@intel.com>
In-Reply-To: <20240202110130.3553-2-adrian.hunter@intel.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 2 Feb 2024 17:50:20 -0800
Message-ID: <CAM9d7cipqHheaZOj9Qr56COjjdU2Qk1pLtUzkjZxtq4g3irLww@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf script: Make it possible to see perf's kernel
 and module memory mappings
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Like Xu <like.xu.linux@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:01=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.c=
om> wrote:
>
> Dump kmaps if verbose > 2.

Maybe we can add '--debug kmap' option rather than using an
arbitrary verbose level.

Thanks,
Namhyung

>
> Example:
>
>   $ perf script -vvv 2>&1 >/dev/null | grep kvm.intel
>   build id event received for /lib/modules/6.7.2-local/kernel/arch/x86/kv=
m/kvm-intel.ko: 0691d75e10e72ebbbd45a44c59f6d00a5604badf [20]
>   Map: 0-3a3 4f5d8 [kvm_intel].modinfo
>   Map: 0-5240 5f280 [kvm_intel]__versions
>   Map: 0-30 64 [kvm_intel].note.Linux
>   Map: 0-14 644c0 [kvm_intel].orc_header
>   Map: 0-5297 43680 [kvm_intel].rodata
>   Map: 0-5bee 3b837 [kvm_intel].text.unlikely
>   Map: 0-7e0 41430 [kvm_intel].noinstr.text
>   Map: 0-2080 713c0 [kvm_intel].bss
>   Map: 0-26 705c8 [kvm_intel].data..read_mostly
>   Map: 0-5888 6a4c0 [kvm_intel].data
>   Map: 0-22 70220 [kvm_intel].data.once
>   Map: 0-40 705f0 [kvm_intel].data..percpu
>   Map: 0-1685 41d20 [kvm_intel].init.text
>   Map: 0-4b8 6fd60 [kvm_intel].init.data
>   Map: 0-380 70248 [kvm_intel]__dyndbg
>   Map: 0-8 70218 [kvm_intel].exit.data
>   Map: 0-438 4f980 [kvm_intel]__param
>   Map: 0-5f5 4ca0f [kvm_intel].rodata.str1.1
>   Map: 0-3657 493b8 [kvm_intel].rodata.str1.8
>   Map: 0-e0 70640 [kvm_intel].data..ro_after_init
>   Map: 0-500 70ec0 [kvm_intel].gnu.linkonce.this_module
>   Map: ffffffffc13a7000-ffffffffc1421000 a0 /lib/modules/6.7.2-local/kern=
el/arch/x86/kvm/kvm-intel.ko
>
> The example above shows how the module section mappings are all wrong
> except for the main .text mapping at 0xffffffffc13a7000.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-script.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index b1f57401ff23..e764b319ef59 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -3806,6 +3806,16 @@ static int parse_callret_trace(const struct option=
 *opt __maybe_unused,
>         return 0;
>  }
>
> +static void dump_kmaps(struct perf_session *session)
> +{
> +       int save_verbose =3D verbose;
> +
> +       pr_debug("Kernel and module maps:\n");
> +       verbose =3D 0; /* Suppress verbose to print a summary only */
> +       maps__fprintf(machine__kernel_maps(&session->machines.host), stde=
rr);
> +       verbose =3D save_verbose;
> +}
> +
>  int cmd_script(int argc, const char **argv)
>  {
>         bool show_full_info =3D false;
> @@ -4366,6 +4376,9 @@ int cmd_script(int argc, const char **argv)
>
>         flush_scripting();
>
> +       if (verbose > 2)
> +               dump_kmaps(session);
> +
>  out_delete:
>         if (script.ptime_range) {
>                 itrace_synth_opts__clear_time_range(&itrace_synth_opts);
> --
> 2.34.1
>

