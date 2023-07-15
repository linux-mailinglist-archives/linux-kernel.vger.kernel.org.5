Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403A075471D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 08:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjGOGnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 02:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjGOGni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 02:43:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABBEE5C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 23:43:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso23654105e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689403415; x=1691995415;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YE44eEGu3nrDR+8Ra5USiZDPPI0F82g/UHvIO26pztE=;
        b=R1djB4Lc76RhNEa8JVegoXSjwMl/9r5B9BUf0PO1fY6O9Fru+jBtUnwP13Ek/fOk/6
         qAa81NSn6XfuoPRMRISXOXfftpwc/j3FAkltl0+9g1IUWtXbOSLPgYsOv0EKXz7GrA3N
         RACc4n2uunQ7EfZUuF/hgSipNhEU4on9DBG7p5xbVFr14kVXmsD0a+zkTQhbPxhLinxc
         vsUNjoAeJhyZY68YLdU8eGSI/GYTQHQcJPOxquh+MyVNgcH+hpGj0dEDtlj+KYCscEDk
         tbVqOYOdEJns/WSoJDTTjn5QE9A6NVOFGutZ3IvgludniH9GEXX347pObRtOGYJt+GkW
         bOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689403415; x=1691995415;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YE44eEGu3nrDR+8Ra5USiZDPPI0F82g/UHvIO26pztE=;
        b=gIK1hGoICvGjhNMi80hRijOJDTpTKVJAoeAHUR+JTG5pSqNrqDDf9yw8M7trNmXJ54
         H/g82nbGeMbDpwdEZqEyLDg8/0LnMrWUu2VB6L/ADEFwANgjjH/pOa2yt+/4vfgWCyOT
         cMVEtDfhZxpiDicQXGntRrv7o1vYqzCdlU4tAlVSIhKS/ZZI+4En1sap/lXZDyP61ceE
         56TrRzFScTQ6QRw4+u3B0f15FmOdbeCkrhlSn3oPhem4BXbaY70l7wubwinuG46INCBy
         ywsb+fXEko1Bhvt4Nq/KBfl1mh24wM4xBh38CEc8Elyg4fhV40eWvE5AURIngzgkTQ71
         v2uQ==
X-Gm-Message-State: ABy/qLbhp8LxSfcM3ggoSeV3GU/20dzFBB8ly6ZPAQaLybWeBZbUXBZa
        v8/tYUWdRaXVUp6b2aa3kKDIxInjd9pczTDdso0zFbFX
X-Google-Smtp-Source: APBJJlFaJAHRSHMGav3cZr//gYhnATxdElUFT+SA8Jm1ni/5M4D71/9wIVZsZE9LvKu5jQIGQsXf6igbwuMRfiNaBfY=
X-Received: by 2002:a05:600c:3658:b0:3fa:8db4:91ec with SMTP id
 y24-20020a05600c365800b003fa8db491ecmr4753493wmq.10.1689403415334; Fri, 14
 Jul 2023 23:43:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:de5b:b0:290:25e9:9dde with HTTP; Fri, 14 Jul 2023
 23:43:34 -0700 (PDT)
From:   Budi <budikusasi@gmail.com>
Date:   Sat, 15 Jul 2023 13:43:34 +0700
Message-ID: <CAH0GyZCWfdGRT7pHVqRg7OS90pKg8TS44N31R17iK4fsvwRn3g@mail.gmail.com>
Subject: Anyone help sudden build error
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

used to be perfect for make to build/process module but suddenly jut type:

$ sudo make modules
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
make[4]: *** No rule to make target
'/usr/lib/gcc/x86_64-pc-linux-gnu/12.2.1/include/stdbool.h', needed by
'/home/budi/Downloads/KERNEL-linux-6.3.9/tools/objtool/libsubcmd/exec-cmd.o'.
Stop.

Anyone please help shed a light what actually it is
