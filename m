Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC380F4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376914AbjLLRne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbjLLRnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:43:31 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7069693;
        Tue, 12 Dec 2023 09:43:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1d08a924fcfso54683735ad.2;
        Tue, 12 Dec 2023 09:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702403017; x=1703007817; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdTQW81TUFg8C2LBr5hrwnNeuP2zn3bh5csoTb3XyjI=;
        b=Th/XAmoQ8XiaGaIU0QhPrPo8MNs9Av50+nb4a+d7Gl2jMMO0hS4emsHmJB13K3myVJ
         mtIxGwkbpDx0C2Vh+zX1KVrNqGlVxY5+Ix+FN6m75GmgoEc1xOt2qbuxC9wqgdYmoT8G
         V3+PLdxJYtz18K1z5VQQRvr+qnVN6K/+Iy2nPidowsPi9tTL69tmDZXpsfPDY3IcR+D+
         OoRwjO1BNjtxOF91mHF8v6EKRgmskHelMt0xtbwqxDFb5qh9ynTbDD/rc1CWyEyaLF3s
         EKLee8q8MgGnlydY/J4xLOS/8IwIpS5OaSVIAIXA2RUznxQVCmJw7eTNKZAp8SeM1+dQ
         s+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403017; x=1703007817;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdTQW81TUFg8C2LBr5hrwnNeuP2zn3bh5csoTb3XyjI=;
        b=tcemOMRHC8XB5n3juiCNL77D5pUMLIPfmYz3kmrFTj151dgd3lD9m/JuZYnfSlAd1g
         UVX0hfGpB0Solo5Ee2lVI5nRd5lbqHV+8NjnfAeCilPt7Z7hqRHqnFNUnMZqYSqLe6Cp
         BYIG0/v3eJglvrFgu8epNgVwg33cz374FWCyLHS9TFQXhDAQaQFnUeoca3H3Tjq//wQL
         LHaUNVXcnmIdKfHSVnqGqNQC9zeyKyrSZ3iKg1Uu6Oed6KWjWoOpKdQiVKh91ewrpQWm
         e0APQiZfx3t5PnFJFS4TiUpC67G0uNLhhkpZZWDulv4xESYHR7ClUbrKi0unXOJ3I7Xa
         0NwQ==
X-Gm-Message-State: AOJu0Yx/nZ2piuC60lM//jx6+ay2NDFsP+WsgKcHYCtzH5UngkHUBk/8
        M2nrGiwVf7FsKVyFcbVXIcd5G8qJgBsSUNRr
X-Google-Smtp-Source: AGHT+IHrMylmsFnbfZdBfw3h6puUyjP7GPaQE/O6Xp2+Ck8XHtHLmh5SanXcd0daviKb27ZqWIF65g==
X-Received: by 2002:a17:902:e88a:b0:1cc:43af:f568 with SMTP id w10-20020a170902e88a00b001cc43aff568mr6900604plg.6.1702403016900;
        Tue, 12 Dec 2023 09:43:36 -0800 (PST)
Received: from neeraj.linux ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id 3-20020a170902c10300b001d1cd7e4acesm8892791pli.68.2023.12.12.09.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:43:36 -0800 (PST)
Date:   Tue, 12 Dec 2023 23:13:31 +0530
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com
Subject: [PATCH rcu 0/1] RCU tasks updates for v6.8
Message-ID: <20231212174331.GA11807@neeraj.linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series contains RCU tasks updates:

1.      rcu-tasks: Mark RCU Tasks accesses to current->rcu_tasks_idle_cpu.


Thanks
Neeraj

------------------------------------------------------------------------

 tasks.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
