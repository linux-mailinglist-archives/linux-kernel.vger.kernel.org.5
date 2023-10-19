Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A287D0499
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbjJSWBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345256AbjJSWBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:01:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69BC112
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:01:34 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507cee17b00so178601e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1697752893; x=1698357693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVH7g5Xn7KERhNbwCPYA3chPVbA58wuAlRpGYKpj+Ag=;
        b=dM8DfLrQRsUlwILnQznK2dZd+bBw2FtHHDC/J5Pc/0SXxpdv2h0eg/Z0buMdSSyCz4
         KxUSKjsXNFqOJ6JAAvwwIueelMMRmunjcM1WEUGyHOzWsotdopnCl45VXg8gPv9lsKts
         DicbsMGt/obSa6o/vpKZ5du0KSqpzFY/1ruetv4sJX7Z1iiNAzbOhn5NWb7Kf85mZjpV
         CTTFFBSBYgsoe691WM8H+0fKS+IHoiAZOg3KY6uoRCvCo5uQ6g4NNz9OOqGtZu0nUTaD
         3iO6BsvlkQScJkbch9ec8sBvPdwM+xziFmDsX/1ZhYH9h7eCmIejZiJ7AeS03JbChj/v
         VeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697752893; x=1698357693;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RVH7g5Xn7KERhNbwCPYA3chPVbA58wuAlRpGYKpj+Ag=;
        b=QcKHPxEaacpvbiagQ3zsaraOUDpTgh75Md9yeis3OI5sVSAz1edkT384i9fVy9xSNc
         tKbFhcu3TMZ/VHwcS36yOvI76g5nnCfGCO+wDhmtTEbg6eiAWLVWP5lWM3lfeoNomNpK
         FvoszyaunofyCxFtNQNLGscW5zRMud8CsaS1gWXLRAU55e8G5WSLOINPwcbKlUupj3w9
         qajLyXiuduHUw+AZ2ufyYfz10LxcXU2rd+I7Q2i+7ESoITncS89myJ6rEgLYK+AjIX6i
         HIuVMBG+AebYQRCreExtoAgQZFAmc3DI6Usei9eXeavFNO2i9yUBFnSQ2FeoNqLjjVHP
         LhKA==
X-Gm-Message-State: AOJu0Yx5ZV0wDpOqzbKHzOJVNzp2XXck/455FI0aztqmDxbngmF8G/LD
        Fnb1+HkUf7vZ4sNiPTaUpiUBgQ==
X-Google-Smtp-Source: AGHT+IGr1MrtHZ96/nhgRMar71OOUSfXGMOyZYoXUPX+20SnusubhbiGhasbj3+M0aAya7InYsY03A==
X-Received: by 2002:ac2:488e:0:b0:503:b65:5d95 with SMTP id x14-20020ac2488e000000b005030b655d95mr5431lfc.6.1697752892966;
        Thu, 19 Oct 2023 15:01:32 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:a8cd:a90a:ba21:5ae1? ([2a02:8011:e80c:0:a8cd:a90a:ba21:5ae1])
        by smtp.gmail.com with ESMTPSA id g11-20020adffc8b000000b0032dc24ae625sm289631wrr.12.2023.10.19.15.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 15:01:32 -0700 (PDT)
Message-ID: <d1fa32d7-4b1a-4451-b717-e91f75f3c322@isovalent.com>
Date:   Thu, 19 Oct 2023 23:01:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] tools build: Fix llvm feature detection, still used
 by bpftool
Content-Language: en-GB
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Manu Bretelle <chantr4@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Fangrui Song <maskray@google.com>,
        He Kuang <hekuang@huawei.com>, Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, llvm@lists.linux.dev,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Tom Rix <trix@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yonghong Song <yhs@fb.com>, YueHaibing <yuehaibing@huawei.com>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <ZTGc8S293uaTqHja@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <ZTGc8S293uaTqHja@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2023 22:17, Arnaldo Carvalho de Melo wrote:
> When removing the BPF event for perf a feature test that checks if the
> llvm devel files are availabe was removed but that is also used by
> bpftool.
> 
> bpftool uses it to decide what kind of disassembly it will use: llvm or
> binutils based.
> 
> Removing the tools/build/feature/test-llvm.cpp file made bpftool to
> always fallback to binutils disassembly, even with the llvm devel files
> installed, fix it by restoring just that small test-llvm.cpp test file.
> 
> Fixes: 56b11a2126bf2f42 ("perf bpf: Remove support for embedding clang for compiling BPF events (-e foo.c)")
> Reported-by: Manu Bretelle <chantr4@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Carsten Haitzler <carsten.haitzler@arm.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Fangrui Song <maskray@google.com>
> Cc: He Kuang <hekuang@huawei.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: James Clark <james.clark@arm.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: llvm@lists.linux.dev
> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
> Cc: Tom Rix <trix@redhat.com>
> Cc: Wang Nan <wangnan0@huawei.com>
> Cc: Wang ShaoBo <bobo.shaobowang@huawei.com>
> Cc: Yang Jihong <yangjihong1@huawei.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: YueHaibing <yuehaibing@huawei.com>
> Link: https://lore.kernel.org/lkml/ZTGa0Ukt7QyxWcVy@kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/build/feature/test-llvm.cpp | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 tools/build/feature/test-llvm.cpp
> 
> diff --git a/tools/build/feature/test-llvm.cpp b/tools/build/feature/test-llvm.cpp
> new file mode 100644
> index 0000000000000000..88a3d1bdd9f6978e
> --- /dev/null
> +++ b/tools/build/feature/test-llvm.cpp
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "llvm/Support/ManagedStatic.h"
> +#include "llvm/Support/raw_ostream.h"
> +#define NUM_VERSION (((LLVM_VERSION_MAJOR) << 16) + (LLVM_VERSION_MINOR << 8) + LLVM_VERSION_PATCH)
> +
> +#if NUM_VERSION < 0x030900
> +# error "LLVM version too low"
> +#endif
> +int main()
> +{
> +	llvm::errs() << "Hello World!\n";
> +	llvm::llvm_shutdown();
> +	return 0;
> +}

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks Arnaldo, Manu!
