Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9558E77F327
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349510AbjHQJYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349551AbjHQJYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:24:04 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224231FD0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:24:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdfb11ea2aso18859325ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692264242; x=1692869042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KPbt6Jr4uE4XqkroaxTN40QvL9ZRwcamAUU0Alom8Ec=;
        b=rI6iWAqTfcbFXuRszbw0kH7S7Efm8TDPPaTRvQfqQAODkeiPGEer1xsAgnG42yVQr9
         L3URCg142nt5JV7OT34bh5MdV49Y/N9+vDCDkRWeow95/CTCqjeWhbS+mjW1SKxpI+D9
         J9WzjfnihA0HQ3OQ22c1eO5ymIPPiWyFE5N0svVLR+mDVK7ijU0cJsuqAty+bKyRlhSv
         iDYIQEtErdogHHIlKmTtsWRXCgeDabvOQyFBJjASvlFsk/Z9c3v+5wNsoGVLF9E3UmxC
         iHBnf1Bbvrssr9ej6ikHkdY6q0moHRV3UoyFuEbAsd0tnfbURsGaT6Ui11pgMfahVMUN
         f6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692264242; x=1692869042;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPbt6Jr4uE4XqkroaxTN40QvL9ZRwcamAUU0Alom8Ec=;
        b=d/KEmYOEFRczaf+gPcFtlZDZNW1H9Ian+OUWZfNMfo30bEqTlrFSo1gObKv2fxL8H5
         qthhM7oLUHDqJCOf0c9oZCBa5QDVfmp8jrSznPyYytpZrKXYQ/7CGwPBsHhetr4VlO4Q
         aS3y4SJwEU8Jrgu08j43XYR7WYx3Ydl0zBpgphx+oc1O8gjT12s6CSdiHvSeIQ6pXphz
         1+MoCwytSIFmpxickNAZYbu9/rKxZQQ23K/eMfsERK26sUmAB7j1hc0OPEWQtBkLSRhg
         gihhzPtmrjRpht0N1bf22x1oF4iNi5kIL4xv59MIkWcHg7afseBIsESPgGR8RM2crjwU
         2EDQ==
X-Gm-Message-State: AOJu0Yx6nWAEH2xRQOeyRzbtfKR4gVxbVyXL1B/CQf+ejb4zxKXoy7Z+
        p/j/6DGkcSSmTzo4CZqH8xQ6FQ==
X-Google-Smtp-Source: AGHT+IFk70YzOl9gPu9ed6IJstA4fhK4tebZKjgbqrU2bEbbFU9mBw3Ch4/wFSeVGfyDH7rTfUpgxw==
X-Received: by 2002:a17:902:bd89:b0:1b8:95a1:847c with SMTP id q9-20020a170902bd8900b001b895a1847cmr3827038pls.40.1692264242560;
        Thu, 17 Aug 2023 02:24:02 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-204.hinet-ip.hinet.net. [211.75.219.204])
        by smtp.gmail.com with ESMTPSA id y22-20020a1709027c9600b001b8a85489a3sm14600942pll.262.2023.08.17.02.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 02:24:02 -0700 (PDT)
Date:   Thu, 17 Aug 2023 17:23:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/6] perf parse-regs: Refactor architecture functions
Message-ID: <20230817092353.GB176609@leoy-huanghe.lan>
References: <20230606014559.21783-1-leo.yan@linaro.org>
 <CAP-5=fV1m440mKc0R=m5C4N2NtoiixchtnpX2eR3PA_5hXbqEQ@mail.gmail.com>
 <ZNvCxM/ULdUfzHtR@kernel.org>
 <ZNvHx+KxIL6JzEl/@kernel.org>
 <ZNvJdsVmmAWLmfH6@kernel.org>
 <ZNvKjeFkXY8ezf9e@kernel.org>
 <20230816020715.GA135657@leoy-huanghe.lan>
 <ZNy3D6DV3Q9YjxKd@kernel.org>
 <ZNy3jg7xxBp4161E@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNy3jg7xxBp4161E@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 08:48:30AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > And move that to perf-tools-next, we can go on from there.
> > 
> > The above is because we don't define CONFIG_PERF_REGS for these
> > architectures and thus that variable ends up not being used, so I'm
> > fixing up like below, in the cset where you made DWARF_MINIMAL_REGS
> > receive the arch parameter.
> 
> I added this to the cset commit message:
> 
> Committer notes:
> 
> Make DWARF_MINIMAL_REGS() an inline function, so that we can use the
> __maybe_unused attribute for the 'arch' parameter, as this will avoid a
> build failure when that variable is unused in the callers. That happens
> when building on unsupported architectures, the ones without
> HAVE_PERF_REGS_SUPPORT defined.

Looks good to me, thanks for fixing.

Leo
