Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F2A7FBA0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 13:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344655AbjK1M0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 07:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344627AbjK1M0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 07:26:00 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C323ED5B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:26:03 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-462f98044b4so618568137.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 04:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701174362; x=1701779162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zWjEZ/SUQrSUmyqfWuq2eTx6HkHasTKwK0H9S4JJ4Io=;
        b=lWcy7SBow1DtRWWJqH1Kfbp66ON0TDBk0q1ARXZMBJrFRp4KuD566mXnp/mq7+CtQA
         kHR68ejp8ulUGkpOIoKtQuZLH2gyf58AIfGFxDuc3DSyaAs0sEy1AdpUGX0NKvipbe4w
         lesS2ShGh7zb20S4wIN2UmjzAgowOLrXzrcKA3Yjb8Cj7o4IDWbcXN/L2ORdQ1wlxytR
         Cj7GNYCI2tdYbQgDQgY17dyRpSICz1JlmTGNjVg37Dk1XZGd+i+dYkwJUvHiL311MH5g
         mM1dTHWAcyxUPblVzOHM8LNqYnxG6HbtSOIY8ULBzY+Mv6MAWCk+NvGW/VLQ08XFuXE/
         C4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701174362; x=1701779162;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWjEZ/SUQrSUmyqfWuq2eTx6HkHasTKwK0H9S4JJ4Io=;
        b=Ict/TSYmv91GoBdKU2SlKqPq/ezxyN6k0mVCwAteIqdF7r3DP/KYWdSgSE9PWIXrbB
         zLuquT+/bl//kYHL8HH5ayOYU0Y70YyJmXEA55L2ZEdPAkgtL4/06tROF1mU/6rAiD6X
         tBmv1+G1EXVj6OUSJxpx/wNN0QZYLirZ99rE4S7fceFPeGPFxT5QRRBwR7C9bS+VbDDE
         5+MEUrvrEEg0QHxyDAlNcOz81pgvnFoRrxIj2/QF9TpgvhDTwIDydXCNcr0xCAWxP4Wv
         JB7t1zUIep3aUo91g2wDxGSkvccQsnv3/Gs0AWnNErhqVItwwcjWC6D4MiM5plAQcGQy
         H8Jw==
X-Gm-Message-State: AOJu0YzKn+VkpVzR28IXE+Yl6lNo335YBjiEc8pkdeFpqgF4ZnNX+hwy
        NfCtAx1qrsRt8Tw4JYaww/SQrkkN32h0Q+6/4fz3qXvgzbVaIfrfN+U=
X-Google-Smtp-Source: AGHT+IExkbIGK+yxz9Y8kDkIjRByaumTYqTMVx/OaGjw1A52Cq9j2XTHa5tlKE7tPXxeoL5sSv1H+Ge/FeZLf+VtD3c=
X-Received: by 2002:a67:efcf:0:b0:462:a31c:78c3 with SMTP id
 s15-20020a67efcf000000b00462a31c78c3mr13888950vsp.20.1701174362355; Tue, 28
 Nov 2023 04:26:02 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 28 Nov 2023 17:55:51 +0530
Message-ID: <CA+G9fYvbCBUCkt-NdJ7HCETCFrzMWGnjnRBjCsw39Z_aUOaTDQ@mail.gmail.com>
Subject: btrfs: super.c:416:25: error: 'ret' undeclared (first use in this
 function); did you mean 'net'?
To:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        linux-btrfs@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Anders Roxell <anders.roxell@linaro.org>,
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

Following x86 and i386 build regressions noticed on Linux next-20231128 tag.

Build log:
-----------
fs/btrfs/super.c: In function 'btrfs_parse_param':
fs/btrfs/super.c:416:25: error: 'ret' undeclared (first use in this
function); did you mean 'net'?
  416 |                         ret = -EINVAL;
      |                         ^~~
      |                         net
fs/btrfs/super.c:416:25: note: each undeclared identifier is reported
only once for each function it appears in
fs/btrfs/super.c:417:25: error: label 'out' used but not defined
  417 |                         goto out;
      |                         ^~~~
make[5]: *** [scripts/Makefile.build:243: fs/btrfs/super.o] Error 1

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231128/testrun/21349057/suite/build/test/gcc-13-lkftconfig-kselftest/log

 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20231128/testrun/21349057/suite/build/test/gcc-13-lkftconfig-kselftest/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ymoxor9n54ID51BFjRBS06YQ3U/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2Ymoxor9n54ID51BFjRBS06YQ3U/config

--
Linaro LKFT
https://lkft.linaro.org
