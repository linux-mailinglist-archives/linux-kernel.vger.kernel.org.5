Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A4C7F4E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344039AbjKVRXS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Nov 2023 12:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjKVRXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:23:16 -0500
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3881B3;
        Wed, 22 Nov 2023 09:23:05 -0800 (PST)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2809b4d648bso36522a91.2;
        Wed, 22 Nov 2023 09:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673785; x=1701278585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qlEt1Uw0z9InptNq6gWRXZziu0xVvzCJEDfECIpRgbU=;
        b=ied5aNWjLmNNiJLJ0xMkURaFxYS35+C3DZ1iuHU0idNWpUehJm8DaFdkrf1DYyp6OJ
         v3jZPzAZIMAYxHL38qsfe9KeTAbonKcAkspqu7BhKcRIY1mkhLwCpzFJZL4RfnYmH8qP
         BT0EwaMeAkE7zxiTOlfPaE+brH5bPAF8BWu7K5HhdWiROBXF4RNwh0eNrSrngvDSsiAC
         QxgEc+27rk9a5b2lABVe6T7a+Q0/OcfOYu2+uDMMFiZ5zPHmXfsuAjDPQw77ziOKEPTS
         os7kLrGkbi6wtm6ongetUUfhVyBmcNLMx1J6XJMG6HUEXZoO49z4F+AY1cp+k7vsAbkH
         VHSw==
X-Gm-Message-State: AOJu0YxWOETipAKDex14/NM3bXlSbjrpqnTxfuv0wCEMin9p82frdI9S
        YgmU0qSfgLgJG+Bq3EWgxOYpb4og3P8EcPl0qXY=
X-Google-Smtp-Source: AGHT+IHhciAc8GOaHAfwCV2MofLEnns1P6djCRCLVGmDUUH5/kcvWPo9QSzh52G3s7wjF2oFJQ0fpF6/xb2Wg7iJF4I=
X-Received: by 2002:a17:90b:b13:b0:280:4c83:5f31 with SMTP id
 bf19-20020a17090b0b1300b002804c835f31mr2648019pjb.48.1700673784801; Wed, 22
 Nov 2023 09:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20231122022805.511839-1-irogers@google.com> <ZV3xe1qVCiz5bkLP@kernel.org>
 <ZV3yFe7+wUNWwkVc@kernel.org>
In-Reply-To: <ZV3yFe7+wUNWwkVc@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 22 Nov 2023 09:22:53 -0800
Message-ID: <CAM9d7cjn6ozPxZTjTQWtjGVWnOZBYfog1EWdbrBiwN9vS=fu-A@mail.gmail.com>
Subject: Re: [PATCH v1] perf MANIFEST: Add gen-sysreg for ARM SPE
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Oliver Upton <oliver.upton@linux.dev>,
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

Hi Arnaldo,

On Wed, Nov 22, 2023 at 4:20 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 22, 2023 at 09:18:03AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Tue, Nov 21, 2023 at 06:28:05PM -0800, Ian Rogers escreveu:
> > > The necessary files for generating sysreg-defs.h need adding to the
> > > perf tool MANIFEST that lists the files for packaging the perf tool
> > > source code. Fix for the following:
> > >
> > > ```
> > > $ make perf-tar-src-pkg
> > > $ tar xvf perf-6.7.0-rc2.tar
> > > $ cd perf-6.7.0-rc2
> > > $ make -C tools/perf
>
> And I detected this while doing these tests on
> perf-tools/tmp.perf-tools:
>
> [acme@toolbox perf-tools]$ git log --oneline -1 ; time make -C tools/perf build-test
> 4dbc034e08146c48 (HEAD -> perf-tools) tools/perf: Update tools's copy of mips syscall table
> make: Entering directory '/home/acme/git/perf-tools/tools/perf'
> egrep: warning: egrep is obsolescent; using grep -E
> - tarpkg: ./tests/perf-targz-src-pkg .
> make[1]: *** [tests/make:348: tarpkg] Error 2
> make: *** [Makefile:103: build-test] Error 2
> make: Leaving directory '/home/acme/git/perf-tools/tools/perf'
>
> real    0m7.498s
> user    0m12.059s
> sys     0m5.491s
> ⬢[acme@toolbox perf-tools]$
>
> > > Fixes: e2bdd172e665 ("perf build: Generate arm64's sysreg-defs.h and add to include path")
> >
> > Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > Namhyung, I'm testing this together with your headers sync series + what
> > is in perf-tools/tmp.perf-tools, will report results soon.

Great, thanks for the testing!
Namhyung
