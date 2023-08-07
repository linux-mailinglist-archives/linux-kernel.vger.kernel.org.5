Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C36771C82
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 10:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjHGIm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 04:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHGImV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 04:42:21 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3087B1736
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:42:16 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id a1e0cc1a2514c-79a10807b4fso1575685241.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691397735; x=1692002535;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=egVUMnfkRE9YRrGbcJnSDyhsV2A9haD4We8Vn8KKt2M=;
        b=EISyKeZtDR6GxhxHDmcLx55R8wAgFz2f35jVcidRgpyzxUwmxVLyppNOPg87NjeZU0
         xvyTBQLAanlRp0VEN/ao94sxtFhIKhE9l+pK3LD+8JUzUB5B4rACIHKzhgyoNx1U59Di
         I3j3UFhWWWeSYjD6qhjHW9rN/o1V724pL+NtZ+zUmj58SDbl3zyTm0W8JkHU0OqIi3i2
         ZjPBRQTzT4es5ow+7kG6SmhFVn9sVhHtzlG6K6hxeOlwb2opKJAbzHzlUbtyhsM4cEUG
         BfN2aNkb0VfEtZb4Fbml3tHV2U95OJy02RKCVtfdosPRrW2oezLQzQljm1+G14v7Z4X3
         Oz9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691397735; x=1692002535;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egVUMnfkRE9YRrGbcJnSDyhsV2A9haD4We8Vn8KKt2M=;
        b=UZc+gDAqqNTWU+CUXytv4UzZig+P60TNEUbaYUB8VRawAr2jj7QZqCuayP7b2SmDZF
         DIReJQfBb2Eh+1FNFcSZQFKH28bK7CsbLDYwvuhpQTQubP2i5Cqg1NL8lRSLvLqv1QfM
         l315huVjKV1gSM0chKbhCHNN6pN5SI+h049x92tBklyjAKvkDEwtDZkpvy0nlH0jEdiI
         LZCoCAw16bBkbSL8yLRHki+tLSKbFlWOG56QxedFkCCP1SALSF0heYrQmcI0W5C3JGuS
         QIaxLenbCdNnL0LISF0l0pQTbrupsbBx4SGA1WL6kBzj9C3TJC0mPebCXE2e3ypB0v/S
         tlKw==
X-Gm-Message-State: AOJu0YwMcUBrL0uZdnR9kbtZeHi9OGf56Pt5i6RuZuNZlAnOL/+Qads/
        CBpFIC0rVf59Batvdn2055dhoQPFuBpYko85jwTPSX9+DJyywNI1/qI=
X-Google-Smtp-Source: AGHT+IF59YMRDSz7OaYEyouN2C9YcjHGWQT19vyf4Es9QnuGEqGn/HcblPEikMZNTR9ZILKOvpCXLS9SAky+7cLWY/I=
X-Received: by 2002:a67:eb51:0:b0:444:3f96:ff70 with SMTP id
 x17-20020a67eb51000000b004443f96ff70mr4120479vso.33.1691397734834; Mon, 07
 Aug 2023 01:42:14 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 7 Aug 2023 14:12:03 +0530
Message-ID: <CA+G9fYsnoxm82ik3YNs_qUdZkxkNmVrknhC+ezqSKrEx6WxJ7g@mail.gmail.com>
Subject: next: arm: kernel/watchdog.c:521:36: error: too many arguments to
 function call, expected 0, have 1
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Michal Hocko <mhocko@suse.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Petr Mladek <pmladek@suse.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ resending in plain text mode. sorry ]

While building arm mxs_defconfig with gcc-12 and clang-16 on
Linux next-20230807 tag the following build regression was found.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
--------
kernel/watchdog.c:521:36: error: too many arguments to function call,
expected 0, have 1
                        trigger_allbutcpu_cpu_backtrace(smp_processor_id());
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~
include/linux/smp.h:271:29: note: expanded from macro 'smp_processor_id'
# define smp_processor_id() __smp_processor_id()
                            ^~~~~~~~~~~~~~~~~~~~
include/linux/smp.h:264:31: note: expanded from macro '__smp_processor_id'
#define __smp_processor_id(x) raw_smp_processor_id(x)
                              ^~~~~~~~~~~~~~~~~~~~~~~
include/linux/smp.h:198:34: note: expanded from macro 'raw_smp_processor_id'
#define raw_smp_processor_id()                  0
                                                ^
include/linux/nmi.h:193:20: note: 'trigger_allbutcpu_cpu_backtrace'
declared here
static inline bool trigger_allbutcpu_cpu_backtrace(void)
                   ^
1 error generated.
make[4]: *** [scripts/Makefile.build:243: kernel/watchdog.o] Error 1



Links:
 -  https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230807/testrun/18858575/suite/build/test/clang-16-mxs_defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230807/testrun/18858575/suite/build/test/clang-16-mxs_defconfig/history/

--
Linaro LKFT
https://lkft.linaro.org
