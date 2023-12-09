Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F316380B25D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 07:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjLIGev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 01:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLIGeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 01:34:50 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A703310D0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 22:34:50 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b34ee2a243so106348239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 22:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702103690; x=1702708490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krIB10NVL6AIK6bQuo2cNO3TNm2D4qclSUfhU0mxqUw=;
        b=nnuYhLkd4aHLz0obzM4UiP8CVt3RIRZxtA3ffa1ewi7NEsj+Q3bXBwCpgFEGgG5Imj
         ElHwa0ruFRARD9ho+Hu0emJpAdqDI5u8u/McVbHbDE93V+B1q4X9cjtO3gd2yQDuH4P2
         WdQ2nsB5QaJDajvkHlk2ssAjpmw+0xM/PcAVwtGXHsfpoGUTwy/HjATThjWTEX6WIEgZ
         7t2wkTFJsA0v2K8Ek0rFL7wdGR3H5ZoxDzrtwoMgSCccIasaxeUNwaLHmiDWvOIX2WiY
         +Iu8UAXXX/iU18fg1vUTiAyjgAvQnMOHwgk8FQK2Vpala6gD5nDd1vlvejaRD08r4kHO
         zZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702103690; x=1702708490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krIB10NVL6AIK6bQuo2cNO3TNm2D4qclSUfhU0mxqUw=;
        b=LvhbzQrtGAP7rZFjGLetNnjY/UAhRfymVMMv26QAqeSWDozHPEuy+z5EF22IaUc5yX
         K9WPGIO8hFq7h+z2zM5QZ6jQl2b9tuAmZnGIDFnJrMb7ki9r8lrvpp4gpwt8pyhjFwTm
         9Pzk2SvSQMBt/O9aqANbjHHo/4ZVr5it/aySJpuwrmmNLUNcCcWQdWeKoNPFwtplsscN
         UV0XZs7dN/aZgtKAm5JVQlNLUBS6uyWlR5BRFhhdz2f7wAh0Z3WE9cumbF+VXgyZRAP3
         /hnXOrf7tRm4Ht/affqFmlm3embOl/Ju2ebm/vUaG6GE4t7DaGOBY4idrrsQgUZrNiT6
         tSSg==
X-Gm-Message-State: AOJu0Yxq+7QtFk6h0El/nN9UGjXHJ7TMIwY39mKX4Y1lX7Fp0hSds2LI
        02Xq4GE/01RpaKBxDgS0wPuG5A==
X-Google-Smtp-Source: AGHT+IHNXxdwGP7ugnByuvD+fvW1/pUMQJah2vdsQ62uiEpucd3NS26DZJpzko1ozuv9mFX8lTWgWA==
X-Received: by 2002:a05:6e02:158c:b0:35d:8995:364 with SMTP id m12-20020a056e02158c00b0035d89950364mr2192704ilu.56.1702103689900;
        Fri, 08 Dec 2023 22:34:49 -0800 (PST)
Received: from leoy-yangtze.lan ([94.177.131.71])
        by smtp.gmail.com with ESMTPSA id b8-20020a170903228800b001d052d1aaf2sm2700471plh.101.2023.12.08.22.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 22:34:49 -0800 (PST)
Date:   Sat, 9 Dec 2023 14:34:40 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/5] perf mem: Add mem_events into the supported
 perf_pmu
Message-ID: <20231209063440.GE2116834@leoy-yangtze.lan>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
 <20231207192338.400336-2-kan.liang@linux.intel.com>
 <20231208102922.GB769184@leoy-huanghe.lan>
 <98863f44-4a35-4910-8db0-dbbf0474f6ae@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98863f44-4a35-4910-8db0-dbbf0474f6ae@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kan,

On Fri, Dec 08, 2023 at 01:14:28PM -0500, Liang, Kan wrote:

[...]

> > Now I cannot access a machine for testing Arm SPE, but I will play
> > a bit for this patch set to ensure it can pass compilation.  After
> > that, I will seek Arm maintainers/reviewers help for the test.
> 
> Thanks. I guess I will hold the v3 until the test is done in case there
> are other issues found in ARM.

I will hold on a bit for the test until this patch set addresses the
concern for the breakage issues on Arm64.  Please check my review in
other replies.

Thanks,
Leo
