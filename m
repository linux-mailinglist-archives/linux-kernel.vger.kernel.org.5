Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163E47F4E52
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344117AbjKVRYs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 12:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344109AbjKVRYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:24:45 -0500
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB3483;
        Wed, 22 Nov 2023 09:24:41 -0800 (PST)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5c239897895so2518272a12.2;
        Wed, 22 Nov 2023 09:24:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673881; x=1701278681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKbC8s4IlnELPuS9rnCyIQ9xG0e09amttwp/cHghswQ=;
        b=fxa6eO+QdMbjIBrQL3EEN+FRM/BkIXLZvDs0eBu0r4oBiKCN3f0HTHZz3Zb/oNTNNN
         TiPntVszK6nlo5DIdJyn0UjzzS5fHFWNma+tH1jcynMdfU/QH9sybHNKEk73E8FdYTDu
         piS82no0X/GJMvi3V7TxP2NYkRhX1irLeVdknhRnWy68OBZHz7blq041dQEFjOYpa/bp
         hLm/z5iZGfchVVuSgLfkF9QYTjH+sKPEuTQSUwyoM19xA6R7KbyNE48JC6GDZih3buBz
         HUdqy67nd83L7bUj9wRV6QdiGBZVixTvqWS270o+s6c4CaMSWfNVJDpxfYPSkiYegD0s
         MUOA==
X-Gm-Message-State: AOJu0Yw9CDOaTQM/isLvEg5I5eXk32AmaQPpZvB0dt588CACpUuvFSZ0
        26nC9oHs/jlGvz0ZKk3HRIkGuGHRsgJJZqciBGg=
X-Google-Smtp-Source: AGHT+IH2AdMpsfKZKttBW5WYkolV8QcPT+iP6etg+hWfFsNaod1qAG4rhj+szwmmc3WWwIDLlTQ94d+eS8+aX4ITmwM=
X-Received: by 2002:a17:90b:1e53:b0:280:2422:d2b4 with SMTP id
 pi19-20020a17090b1e5300b002802422d2b4mr3011155pjb.22.1700673881209; Wed, 22
 Nov 2023 09:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20231122022805.511839-1-irogers@google.com> <ZV40tp7uiaTk-Qp1@linux.dev>
In-Reply-To: <ZV40tp7uiaTk-Qp1@linux.dev>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Nov 2023 09:24:30 -0800
Message-ID: <CAM9d7ci8J_3+Hv+tHPBLx3SOXiPsGyxpYNHxZU==qR544f9hVw@mail.gmail.com>
Subject: Re: [PATCH v1] perf MANIFEST: Add gen-sysreg for ARM SPE
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Wed, Nov 22, 2023 at 9:05 AM Oliver Upton <oliver.upton@linux.dev> wrote:
>
> Hi Ian,
>
> On Tue, Nov 21, 2023 at 06:28:05PM -0800, Ian Rogers wrote:
> > The necessary files for generating sysreg-defs.h need adding to the
> > perf tool MANIFEST that lists the files for packaging the perf tool
> > source code. Fix for the following:
> >
> > ```
> > $ make perf-tar-src-pkg
> > $ tar xvf perf-6.7.0-rc2.tar
> > $ cd perf-6.7.0-rc2
> > $ make -C tools/perf
> > ...
> >   PERF_VERSION = 6.7.rc2.gc2d5304e6c64
> > make[3]: *** No rule to make target 'perf-6.7.0-rc2/arch/arm64/tools/gen-sysreg.awk', needed by 'perf-6.7.0-rc2/tools/arch/arm64/include/generated/asm/sysreg-defs.h'.  Stop.
> > make[2]: *** [Makefile.perf:456: arm64-sysreg-defs] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> > make[1]: *** [Makefile.perf:242: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
> > make: Leaving directory 'perf-6.7.0-rc2/tools/perf'
> > ...
> > ```
> >
> > Fixes: e2bdd172e665 ("perf build: Generate arm64's sysreg-defs.h and add to include path")
> > ---
> > Note: the breakage is in Linus' tree and perf-tools, not yet in perf-tools-next.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> I had sent out fixes for both of your comments [*], no preference as to
> which gets applied. So, FWIW:
>
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>

Thanks, I think I can pick up your patches as they came before.
Namhyung

>
> [*] https://lore.kernel.org/linux-perf-users/20231121192956.919380-1-oliver.upton@linux.dev/
