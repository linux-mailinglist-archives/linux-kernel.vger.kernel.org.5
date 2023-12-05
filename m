Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FEA80431E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343567AbjLEAHM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 19:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234764AbjLEAHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:07:10 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4988DB6;
        Mon,  4 Dec 2023 16:07:15 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-286d8f3a08bso347253a91.1;
        Mon, 04 Dec 2023 16:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701734835; x=1702339635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXxRUBMltgF34LwxAb3e3DHyHstq0fsBeAaJoMUOcWA=;
        b=W5OjHSKrJZvyCWnBljCl7adCsjXiDAbHaUgHvbDbbjMuQRRAovyc42z+Ta2XNxQKqm
         KkDBcw7PdJrM7AAH7fkvBeLWZh/gg93ZxaypK5Q5cqTItkKxaQX93QzQBx7VdwIcRTWV
         uEhGwXHfMXJIyRqRyi9odp0EThnZ+87xbOJ/NIGIVZqSwIdqsfkbEYzX4l8pKpJ3W+fz
         ugeCAk3gBn2ztxipmxdO4cBJTNXypmWTAlDhqw7uJueMJ7VArpAtuQB/OjHkIF9YrjTw
         tWxPxpFOQXj05Tgvi7XtFdrT/DyXBpRh3PIWXqotvsUOKpl2+mUao96gcMcTiZ1o2374
         VREA==
X-Gm-Message-State: AOJu0YxnxNYEv7zM8HqW8iDXrWCjP8zwSK5Dz3V7ZoGbo9R0RIblSgq9
        wzn/fqerstGFL55TxQanzgeSd5YYK7bq2R/0TB4=
X-Google-Smtp-Source: AGHT+IF9/LPawIP1YEm8gK6QD87oU95Do+mmLsroe4YfoU40ZSlR8NL53iMJJDPh0qLKlSxqzcsrKTO+zZ8NrAQx8ok=
X-Received: by 2002:a17:90b:3509:b0:27c:f309:f381 with SMTP id
 ls9-20020a17090b350900b0027cf309f381mr444092pjb.6.1701734834681; Mon, 04 Dec
 2023 16:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-21-irogers@google.com>
In-Reply-To: <20231127220902.1315692-21-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 4 Dec 2023 16:07:03 -0800
Message-ID: <CAM9d7cjVreWV_8QW27YKpmTHSfbPq17rBAhwxa-AcsVHHa5psA@mail.gmail.com>
Subject: Re: [PATCH v5 20/50] perf maps: Rename clone to copy from
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
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

On Mon, Nov 27, 2023 at 2:10 PM Ian Rogers <irogers@google.com> wrote:
>
> Rename maps__clone to maps__copy_from to be more intention revealing
> of its behavior. Pass the underlying maps rather than the thread.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
