Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA028049A7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344316AbjLEGCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjLEGCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:02:02 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD0618D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:02:08 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-464752da340so717976137.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 22:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701756127; x=1702360927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MbGfZIumAG8MWScd3jekKM1BGoJdVx+w4q+lDBLye5g=;
        b=Pu2SbgpnyNVzzPnrCbjLloxNzTTniFbyyDofYAA4429NuRPFd7TKlosMiMjuB8gvf8
         C4Mvq9CwpNmEI4G1GGD5v4dMBPKaPWF8FMsV/wwtJZ0rmeMOM9is7mJBw4RS4qqoa3Yq
         KcRGhKkSAbDidNM/3CTBItlgqFKsnmxLgE6wfXHAuRKJ+RHD9ODctZTlVW61KsUj1Zng
         Fp0PC1CDgf4UH4x/6B6HzZmvocMuEmeayBhJ6qbNpe0YnUzMdmB2oIaTZKOQ/1Hy4VuN
         K/cjgwonafbKCLwHGPTUMo2WR/PafDC+6dUrTNkO0FoDy7lxpL92m/v0s5izhV9MCizh
         CFbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701756127; x=1702360927;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MbGfZIumAG8MWScd3jekKM1BGoJdVx+w4q+lDBLye5g=;
        b=Lpa0m6IwLPAaWhpXUr3oI4DdKMT9iv5F/bJxUypHkBTKgBumxzzMu0evjzY3LPcfS7
         duZ/7EniB1xEJzF7coi4bRuWVwT/MrMbS9KVKVMCjrbhg/zDDjLcMM9Lu35Tjb7iCP8j
         loeV1IJyKkCmNJ9Iykb4CIL4YyHjQjAqMdDnV7y1h0R++AE3UMHyhwduvaTbk+1I9lgE
         Ty1Sv24bnRpOwE+tzEoE5HtGx7aSaXX5pXljJl1L3iUDE5zuRO8ZxJjHy6uZjvXQ/bz7
         5kr0Mx4sjyTUpwGZmHTE+iphNUZCSc4iFF6r0JLZLh2uxVx1tBy6pAwOt23wA03TdeHh
         Wmjw==
X-Gm-Message-State: AOJu0YwSa+dvqig7nphPPwpTfdufBRqRcEUkCpBCZGmjpTNcRjyzmt1q
        5GdtM3VqTP0IryWfISW9U2fVVJ+lkpQh5odmc6KYsA==
X-Google-Smtp-Source: AGHT+IHvKqnSwS1BLyzX1vMS4LTuVHrCtdDTFnS9dO+gsy1r9yKxz3zYlHv4rNjFqNOjx1gZc4Nxs2/fOzhwS4SJDXA=
X-Received: by 2002:a67:af18:0:b0:464:3c0a:fdd4 with SMTP id
 v24-20020a67af18000000b004643c0afdd4mr3333612vsl.2.1701756127145; Mon, 04 Dec
 2023 22:02:07 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Dec 2023 11:31:55 +0530
Message-ID: <CA+G9fYvAUt8GyeGrb5UK8HZDVru6Ucu3BJyMQv0vkO3jYwOHHQ@mail.gmail.com>
Subject: mips-linux-gnu-ld: arch/mips/mm/cache.o: in function
 `cpu_cache_init': cache.c:(.text+0x4f8): undefined reference to `octeon_cache_init'
To:     linux-mips@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following build errors reported on MIPS with gcc-8 while building
Linux next-20231205 tag.
But gcc-12 builds pass.

mips-linux-gnu-ld: arch/mips/mm/cache.o: in function `cpu_cache_init':
cache.c:(.text+0x4f8): undefined reference to `octeon_cache_init'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231205/testrun/21486880/suite/build/test/gcc-8-malta_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231205/testrun/21486880/suite/build/test/gcc-8-malta_defconfig/details/


--
Linaro LKFT
https://lkft.linaro.org
