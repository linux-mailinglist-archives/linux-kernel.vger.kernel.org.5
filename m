Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4B7619E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjGYN1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjGYN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:27:24 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D17910E5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:27:23 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-79969c14964so1622608241.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690291642; x=1690896442;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ioiyZipNYQNpGagkyruO8NE61Cv2rplOTlMfdFh0CCk=;
        b=B5oIVzIvrI6yphVwz5iUuGiAcqTLBSfjfUDCebR/4w70SIZ7ZTGIAwsK7PdDEu/K4I
         sG7Oky5B/CK8YxQo/cHvcAKjsvUDPBt68n95wjBJbrTqsIG1anTLiwZlrRG8tn1dNVKj
         grfnmg2ie+/ajWinc2ZsNwooO7Q4osaM7B8Isqdt3Qwt4pZMrISx6T+eHlUi5DslIwyv
         R3U94lhpAuLtKRLKdwhYL35BO5nYJE7jCr6WaqUV5Nu4/wQkkJm6N8okt9ZxC72cNQrT
         6Wru4RTC7UcBhHOR1U0BH5FZDn4ZtAljd6me15mMSp1KY/TYrx/K7IvUCGkmlTggEIef
         spVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690291642; x=1690896442;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ioiyZipNYQNpGagkyruO8NE61Cv2rplOTlMfdFh0CCk=;
        b=DjoR3y1EVOxJVqLbnxiNcECcDXOv81GRQF7MvycJrr46PgYb/jBFGcc7YjFYvrGskd
         xa88Dt800kTp8uIEDO2Ly5NIeFJzTbUoQeXsE8SsE7/U+dVumT9XuhxcpYwysb+ZIQA1
         CQs+2gCY2Ev12dZ14Q5Jc1AGWrJT9VIlctKGnJl0FRyKh8o+TfYwzh5giwU+FGTRCcuN
         kP3cgXS1qd3y1J8N5eznWTc02N8xqNnOtEiybcYA/GMG1cDkMKfppOvTOm94A4IWyGog
         xH/vMTpfw8rpiFyCzl6SjceRwf4KB07QRUb2QZA2+LIPUfNmB/3cHfPswA/EYKVrQ5Bp
         2dEw==
X-Gm-Message-State: ABy/qLZAMT8dGeosgp8io0sYOaRt/RA8o6iS8Pkne+kJQSKIG9Wa34L5
        XnNwDouoOQhu4ih26aOURe+DXFl2B9j2TPkCF7BH92B46wsh467bbBI=
X-Google-Smtp-Source: APBJJlFNvn3s+3oAm8bOTez+axljqCb0cdR/HKWhBcUfLXHM467GPio5fZcYZwWXG5SRV0YkJpZLQMlUHpBTLGG1gt4=
X-Received: by 2002:a05:6102:3d7:b0:443:5ce7:e62d with SMTP id
 n23-20020a05610203d700b004435ce7e62dmr4261554vsq.21.1690291641801; Tue, 25
 Jul 2023 06:27:21 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 25 Jul 2023 18:57:10 +0530
Message-ID: <CA+G9fYvV-71XqpCr_jhdDfEtN701fBdG3q+=bafaZiGwUXy_aA@mail.gmail.com>
Subject: selftests: mm: mremap_dontunmap.c:53:6: error: use of undeclared
 identifier 'MREMAP_DONTUNMAP'
To:     open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org,
        linux-mm <linux-mm@kvack.org>,
        clang-built-linux <llvm@lists.linux.dev>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Stefan Roesch <shr@devkernel.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selftests:mm: mremap_dontunmap build failed with clang-16 due to below
warnings / errors on Linux next-20230725 ( or older kernels ).

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

clang --target=aarch64-linux-gnu -fintegrated-as
-Werror=unknown-warning-option -Werror=ignored-optimization-argument
-Werror=option-ignored -Werror=unused-command-line-argument
--target=aarch64-linux-gnu -fintegrated-as -Wall -I
tools/testing/selftests/../../..  -isystem
/home/tuxbuild/.cache/tuxmake/builds/1/build/usr/include
mremap_dontunmap.c vm_util.c -lrt -lpthread -o
/home/tuxbuild/.cache/tuxmake/builds/1/build/kselftest/mm/mremap_dontunmap
mremap_dontunmap.c:53:6: error: use of undeclared identifier 'MREMAP_DONTUNMAP'
                   MREMAP_DONTUNMAP | MREMAP_MAYMOVE, 0);
                   ^
mremap_dontunmap.c:108:6: error: use of undeclared identifier 'MREMAP_DONTUNMAP'
                   MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
                   ^
mremap_dontunmap.c:149:6: error: use of undeclared identifier 'MREMAP_DONTUNMAP'
                   MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
                   ^
mremap_dontunmap.c:200:21: error: use of undeclared identifier
'MREMAP_DONTUNMAP'
                   MREMAP_FIXED | MREMAP_DONTUNMAP | MREMAP_MAYMOVE,
                                  ^
mremap_dontunmap.c:252:6: error: use of undeclared identifier 'MREMAP_DONTUNMAP'
                   MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
                   ^
mremap_dontunmap.c:310:6: error: use of undeclared identifier 'MREMAP_DONTUNMAP'
                   MREMAP_DONTUNMAP | MREMAP_MAYMOVE | MREMAP_FIXED,
dest_mapping);
                   ^
6 errors generated.
make[4]: Leaving directory 'tools/testing/selftests/mm'


Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676HpK243gMBLYJCp4OXDmWl/

steps to reproduce:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2T3676HpK243gMBLYJCp4OXDmWl/tuxmake_reproducer.sh

--
Linaro LKFT
https://lkft.linaro.org
