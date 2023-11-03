Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CD17E05B0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 16:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjKCPla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 11:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjKCPl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 11:41:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8401BF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 08:41:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50946ff87aeso4618e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699026084; x=1699630884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRaJx5yqDoLyT5Xi3DrUXbLg8Rya2MY4ntt0ooWt/pY=;
        b=YVa5r15iCTcnhduAgAXBO91zsBizM++a3H9jJurUuQ3smDK0JtQ7d6pCNwKt4CS+hG
         m3hfRf1Dbjh/z1Oqk3axxH+2dO+1YHrUttmpZANCAiRO+wVasa6cYvlMDEfqHoufP+4O
         U+ATdT/CR6BFzAXoBXbzG4rloH58Mv4yqFeRNeNqfBLjbrpVDNDUXlP+rNcxhcMiDcme
         EP4YjOjuuLITF4oOiNm9D45aTvxR0j4naQz40tiwedM6drfcdZSxbNuhRE13ArOMGEgU
         sNAcPHKBnlhNMcolfqipAbPGC9eQg/hWsQ8yZN8fXgwBLGjN8F9rEfbC3lVb9E8GC8zL
         hhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699026084; x=1699630884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRaJx5yqDoLyT5Xi3DrUXbLg8Rya2MY4ntt0ooWt/pY=;
        b=nUIEM0h3WLB7fzkOqRI0De+XbNlFLPGDjmrLH6wSPXz/ea5GgWMYTiZGlksLufXR4q
         BZHZWtHvrw9pX8uVT1GYYPOr6rEqH37MpWVaMXBG9reWkV7cXp+NFsBjPtAk5ctAinYl
         i0MccyZTTEbCqYH6GV4ypa7OcgrMzSwYaaPTnyBzHHqx6LmnCY5pW98vYSTi9NwKX65j
         MXSyirp/DPGdmULEUUJH4cCXPR0VJDYlx7zkpq1sYLa6ewQz6ZsdUomltnnTmqYeMf0P
         Mq710B05rIqagV/eBuHP3BpHdllRzl9pnWghr3BQ+tNQdRS29/zxmiHrobJikJiCpiQo
         4oRg==
X-Gm-Message-State: AOJu0YyWF0xrWP9CX4MCkrQFt9wBoq60D4I4U2yTxShGtPBvF7RrP4fx
        XCgvgjs6z5we8Wsj519LhoALa5A+wGg32H6Ily0LnNs63e1hTssSMXyq5g==
X-Google-Smtp-Source: AGHT+IH310mUKc8QXz+cZoC/fxdXqHImALuyVrBOwQDL0RiBksQVuXw44g9e6DniBg/n5jlSutqpX8jNZa0LiEdDLEg=
X-Received: by 2002:a05:6512:358c:b0:509:4535:b272 with SMTP id
 m12-20020a056512358c00b005094535b272mr143154lfr.3.1699026083710; Fri, 03 Nov
 2023 08:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231103113501.490012-1-james.clark@arm.com>
In-Reply-To: <20231103113501.490012-1-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 3 Nov 2023 08:41:12 -0700
Message-ID: <CAP-5=fWazX_q1W8HN7ErrRMB2bx5sz3x1V=+XqY7Hxx0jR0p9w@mail.gmail.com>
Subject: Re: [PATCH] perf test: Add option to change objdump binary
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 4:35=E2=80=AFAM James Clark <james.clark@arm.com> wr=
ote:
>
> All of the other Perf subcommands that use objdump have an option to
> specify the binary, so add the same option to perf test.
>
> This is useful if you have built the kernel with a different toolchain
> to the system one, where the system objdump may fail to disassemble
> vmlinux.
>
> Now this can be fixed with something like this:
>
>   $ perf test --objdump llvm-objdump "object code reading"
>
> Signed-off-by: James Clark <james.clark@arm.com>

There is also "perf config" for things like this.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
