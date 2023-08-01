Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FB276B494
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbjHAMRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjHAMRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:17:18 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A39B2113
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:16:47 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-4476f090985so1162651137.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690892203; x=1691497003;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P7KMPAGh6NlnTnD5lkpWaGqJsOcwuB2UI/6mC3n3LBk=;
        b=mjtZY3OFs3s5aOiEaSCQBZoAvipmtOnrzzQPqVNlqs4d8Q0VcoZNYI4+02y449Gisl
         f2DXV5YbjUT1Drj2gQwXWN02RaaMK6ssN8JdHIguPJ2L+JIlLTDhO7ue+gaqBGqYS6id
         RGd04rkmQXdwY9cr3tknVf8xP7w8WKWHIAwbIGBh2mUQSWFpjmb9NYwv36ZR/b6WQlfX
         0xkp0+ckyPSLkEcR5H4xHy42OPfPsKjxswNntwGOiCa7vrmg6W+dPtARb+ICYTJ9UmcT
         LYWa89MjW2aU5eIgDWc1t+1rPx25P7+xcR+CJdgcNW0PPxdOh1yTvtsbUyrAOJokN+oe
         7tWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690892203; x=1691497003;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P7KMPAGh6NlnTnD5lkpWaGqJsOcwuB2UI/6mC3n3LBk=;
        b=V22TWwCQLiMbjqUqwXNPAYPtxcj8DhH7yw0Eu+hcHlH7ld7jRgPD1iwqUo1iOQ3L0Q
         /CBIsfSZ2wAYgDIurqX4khGyQlVJgn49RjTAzS8tJKvUF/RRqrhHHINfCJmBnJv9iL03
         xFMh8WLPzZdMLY70uYBsiPh/2L7NQw3ycsTq2Twd9FP6ythzAjm8UD29ET7FUle/ecmG
         48RlzCEx7+Ms+MPvKzZM3stpt5pzpsVxZe6LKeAxz71kkcYEtErGPA/MlCXdlVPzIdFB
         iyWu0LmpIJl6GNSxids4lh/Zmd5eM978BRjIENMvAENp2nIchzKYM/XbwmDaqphUdGEe
         mYYw==
X-Gm-Message-State: ABy/qLZ6m2pXYBAPugagNc5o/YO80XIfmXnfvXw/CcurJWim8euq6hoY
        u0XCAxt7LJ/hD3Jt4CqEfwO7Y5eh0xpiJ6OvyeSMeX6DPobWBY2Jz30=
X-Google-Smtp-Source: APBJJlGcvvgozeFW/7IFKU0qI9C3S2si5rDkhW2xeQeDdaCu0/6DDLOfEK/KM+GujWYsL45S5btDzQNNtA12BUGslbo=
X-Received: by 2002:a05:6102:87:b0:443:6c48:4d49 with SMTP id
 t7-20020a056102008700b004436c484d49mr1506490vsp.10.1690892203480; Tue, 01 Aug
 2023 05:16:43 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 1 Aug 2023 17:46:32 +0530
Message-ID: <CA+G9fYur8UJoUyTLJFVEJPh-15TJ7kbdD2q8xVz8a3fLjkxxVw@mail.gmail.com>
Subject: next: arm64: gcc-8-defconfig: ufshcd.c:10629:2: /builds/linux/include/linux/compiler_types.h:397:38:
 error: call to '__compiletime_assert_553' declared with attribute error:
 BUILD_BUG_ON failed:
To:     open list <linux-kernel@vger.kernel.org>,
        linux-scsi@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
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

Following build error noticed while building Linux next-20230801 tag
arm64 defconfig with gcc-8 toolchain.

Regressions found on arm64:

  - build/gcc-8-defconfig
  - build/gcc-8-defconfig-40bc7ee5


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

log:
-----
In function 'ufshcd_check_header_layout',
    inlined from 'ufshcd_core_init' at
/builds/linux/drivers/ufs/core/ufshcd.c:10629:2:
/builds/linux/include/linux/compiler_types.h:397:38: error: call to
'__compiletime_assert_553' declared with attribute error: BUILD_BUG_ON
failed: ((u8 *)&(struct request_desc_header){ .enable_crypto = 1})[2]
!= 0x80
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^


Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/log
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/details/
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230801/testrun/18754886/suite/build/test/gcc-8-defconfig/history/


--
Linaro LKFT
https://lkft.linaro.org
