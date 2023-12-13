Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14059810AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378650AbjLMGyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjLMGyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:54:16 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4119AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:54:22 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28aedba3641so10667a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702450462; x=1703055262; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6dX2BToRtt/4dJc5/t/XYX1+5u/z/qEPWr31SMH8000=;
        b=QDvqVJS4yl1Onj+M9EebtVqhLgJtSz7Zq113oE+kkoykByUldkAgrsdiALWg1TJduH
         3nV/ZRg8SRbgAcnX4dR2Y0doI3joihkwo5R4fScrsinYJ85gIi4Q+NBv85QyrM9y+CRl
         HaH3qYTP+ufVkuRgsjDmIwC/Ql62aS7MZTp266PCeQpcpeByGyDmoXZ48K2CVMABma54
         8Rgg2y8RLvl+MoUXOnJrwhl9YBZI8E4JJY0GzvwJjwrY7iU4CN6PBnRnGq/9+DtPifym
         aZrkYpPg5irR6Ft7ZYzvuLwD9jhdsHCa/hFHvpSmGvVxpvxBeByrgjSMrnvFbhviDolv
         mOGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702450462; x=1703055262;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6dX2BToRtt/4dJc5/t/XYX1+5u/z/qEPWr31SMH8000=;
        b=cp4dTUQT9InqhqAhjmqIQGWr7/RQhlABdD9GOIc4KelbvA8E2y2ksqpgg9Tqys/M1g
         5EOTesQP2NPVWvSv9dlbk4J5VJMguJyi/a8GWooXfmnGF92D3tI3Sl6E6HgM+mGytBD8
         EqyK+3TjeL+8U5D5/QGjkgueXH9btgtn+qBWepzR3qd4fbbBQigNySgT6h3gLRCcY4Wx
         d3XdDwD1Dvp0QoaMsQti9XiQFuKYfs2mncnlNPUayytlX2n6hU+sUExOz5XMNiJNT7Ss
         eSNLq1QQaNSpJV483YmVFsA6garAYZjc25LTJDnoVsKciQGx/3BaytnG0hecPjfy4luo
         AcSA==
X-Gm-Message-State: AOJu0Yw1AnVe6zVSvCGXs9rHsbn8deJxg1v6HvSpFbrKuCbyuUV6rO+u
        BHGE1ug04RuCAlm7Ow1LwNtykmPOf7zVqseTfXymRxHuZLfoxw==
X-Google-Smtp-Source: AGHT+IFzyq9dKsAro+xJdqdtR1fBN35pAOUy9z7yDQL6K8yVepx0YHYqCNu/ZVm6tErvtuPA45CWmPL2QZFrh8PZYCE=
X-Received: by 2002:a17:90a:e558:b0:28a:ea24:dd5a with SMTP id
 ei24-20020a17090ae55800b0028aea24dd5amr17285pjb.28.1702450462205; Tue, 12 Dec
 2023 22:54:22 -0800 (PST)
MIME-Version: 1.0
From:   Dwayne RIght <rightd942@gmail.com>
Date:   Tue, 12 Dec 2023 22:54:11 -0800
Message-ID: <CAAZfa0i3zEWrf6mJwzJ8JBqx7EKCkbSfnjRKBR8dbmhjt37Hug@mail.gmail.com>
Subject: new to kernel programming, heres a tip on global structs
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

global, both dynamic and static data structures in the linux kernel
can be used for simple messaging

you can use global data structures in linked list and binary tree format

also with a global struct system, which is intended for messaging, can
be used for modules such as code in the kernel, like a loop reading
the global struct hitting a global struct member flag defined in an
enumerator in a function in a module and stopping the loop in the
kernel or elsewhere, or moving to another function

or it can be used to send string messages between functions

im new to kernel programming, when i get time i'll do stuff like read
the docs and try to put sqlite3 in the kernel and try to write gui
programs for kernel development, like a gui makefile program, but
hackers do use linux
