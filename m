Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAF880F4C0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376806AbjLLRjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbjLLRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:39:51 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2EA93;
        Tue, 12 Dec 2023 09:39:55 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6ce33234fd7so3141600b3a.0;
        Tue, 12 Dec 2023 09:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702402794; x=1703007594; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bimU+RjPXnA4GcSVMRC2y8VYJ0x8Wxk5dqkFvYFDmQ=;
        b=UcB3TR4+hVzwbuXwUvncgd6U5wdRg6cfgNSEOOXdeXTGVp/ALfzBJNLs8Mj776Zn2q
         n3T5Tjd3dFaQlXoHJN2SLXUn+nVfHMK7zZBxg3y8pleb78t9WT2sdbcIIbIGpQ6N9szh
         QwdzxVV1W6Qsq/qbRDuSlGg6MldIt9AvuCIAIGhifRTSf207jLbJomMvsb8U86/LHeKL
         vYmLmmjURW9eXrxsjoVxmR7SRZBxmXtfz0uEaMB7PDh1N8jYrShFw1ckARbrunRQyLqr
         sgo++0VJ6+binmrFA3a13ggj+ejmWTLCt13qu/DxM7Nh9YwDE9EnAGuks4GqlrmBSvOQ
         p8/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702402794; x=1703007594;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0bimU+RjPXnA4GcSVMRC2y8VYJ0x8Wxk5dqkFvYFDmQ=;
        b=KjQZrEZVnniJ0OLvU4WR2jvsc/Yrmi3JeoUIbMPVSn4MaljUowbXDqiDn6grFjXtpX
         nl0ZX7ISoC0yetMFPeaG+rX5P4nx51gyFbaihhbYjNODHfiSfw1bzOhlzt2blMcVhQQB
         r3m8HWdpALFIvMJnSEilRtNJatO0+im9EJt+cdSGsrdPTTrFM+gLBB2qUz+3LAsDkzwW
         BmFN++ujNpOTioDABpLJwsMJiBCZAh1x/7XFRic/aezAqxD6L5iCMf0md9yWpCzqY29g
         WdjS9qpeQRuFW/gAlZxT2dL5YS7A5wPQKRaTn8c1OpAXR8fxB9WbO1T+NUakKm6UiAwJ
         0Rnw==
X-Gm-Message-State: AOJu0YzCo2DJ3mH8p9rnC9SmMmow8cXI7nO39G+vnOLm+ucu/XOTgyNn
        I9u3rim4eTU7F5akB1+z127/srIurCRJgFr+
X-Google-Smtp-Source: AGHT+IFadAS+SyDVgm58OPghc2OCdPROFHBDIHrxFJPHsDzzW43OTDML6jWi0zmAD3TWRQ0XOnYK2Q==
X-Received: by 2002:a05:6a00:8606:b0:6ce:2731:7a02 with SMTP id hg6-20020a056a00860600b006ce27317a02mr2253347pfb.56.1702402793924;
        Tue, 12 Dec 2023 09:39:53 -0800 (PST)
Received: from neeraj.linux ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id c11-20020a630d0b000000b005c2185be2basm8418384pgl.54.2023.12.12.09.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:39:53 -0800 (PST)
Date:   Tue, 12 Dec 2023 23:09:48 +0530
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com
Subject: [PATCH rcu 0/3] RCU misc fixes for v6.8
Message-ID: <20231212173948.GA11724@neeraj.linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series contains misc RCU fixes:

1.      Restrict access to RCU CPU stall notifiers.

2.      Remove unused macros from rcupdate.h, courtesy of Pedro Falcato.

3.      Force quiescent states only for ongoing grace period, courtesy
        of Zqiang.


Thanks
Neeraj

------------------------------------------------------------------------

 Documentation/admin-guide/kernel-parameters.txt |    6 ++++++
 include/linux/rcu_notifier.h                    |    6 +++---
 include/linux/rcupdate.h                        |    3 ---
 kernel/rcu/Kconfig.debug                        |   25 +++++++++++++++++++++++++
 kernel/rcu/rcu.h                                |    8 +++++---
 kernel/rcu/rcutorture.c                         |   12 +++++++-----
 kernel/rcu/tree.c                               |    2 ++
 kernel/rcu/tree_stall.h                         |   11 ++++++++++-
 kernel/rcu/update.c                             |    6 ++++++
 9 files changed, 64 insertions(+), 15 deletions(-)
