Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA43807891
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379257AbjLFT1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378759AbjLFT13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:27:29 -0500
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73BC1BD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:27:35 -0800 (PST)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-58ce8513da1so60748eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 11:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701890855; x=1702495655; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dFmA2oj7DydOQis/5pnKChGhB5lB4thJZtXd8sMcBkc=;
        b=B6f5gY/dgKfgvPfQX4Vs+NfY/CbF4gPO2UzUGdg7TEyCJ2EJnmd0ryCjzho/BDtsRX
         dLQUchnIbQCQztOgqsHxkhvi1v8Pe6hTSfnQ3i86nrnxr9uv7YxKEX2qPCRECbKI6Iuv
         JZeX7G7xP+Ezc8TcEGgIuqtOeXZaKGink4W+MfDNNcC5/uIh/jSnY/yRGGRKAPAsUrR3
         5Sqcn9vKQHMC0X+zYOcSpFIDuCnCJAs76qmF6sE3S6UM4wXfVJmObs6eFg9NMiUniG0V
         in45Tki08cKfWKnJV8jhAUDRBV2e/gkLSdwQkp42buuBWt1CTx8eCrRDXkqklFhxkfg1
         h0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701890855; x=1702495655;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFmA2oj7DydOQis/5pnKChGhB5lB4thJZtXd8sMcBkc=;
        b=Td+WmHhM7zSf+P8erWRrCd+Y7kDBwL5eU/TVqsbebPCjpUJwc2AU8SLp0SnXJU5hj4
         322ornB+lZLegUs4TvvHw29EzL2feu5w1CtUfzU38iXFo3yztptmQEjWXpsWJVs+mOaO
         bF32OqBEtQBLa6Lx23HG3cvsBhKcQhqboBjdoYmNPSCVL2f0xUN1KKTz4lDYAh0twEw2
         VFxVVmMTfwsI82npSIzEZ5aOUX6CbbJhBg29ZeoefoMGY6bBSJTjW7tgEXqr4rCyOuI7
         +vcZVZXZJmR5mbdt2pPS2FclyboZSnVPnZQdte9/PE/Ge3Rswmtn0MoGO866dFwABwMT
         cmsA==
X-Gm-Message-State: AOJu0YzhcFpQZH5i00N3XZw7FsEPbstQ5cCSF4tPbYySuoseN1TJ9BpX
        FKaxHwIjVec3cOzsJ0IDGYg=
X-Google-Smtp-Source: AGHT+IHe3xAg61xtUO1zc6I3jf5YPnH9sExYXliRjKkgvoBKBXTJGRt0EkrBmYArNKwZJj/kBV20zQ==
X-Received: by 2002:a05:6359:6b0:b0:16b:fa51:4862 with SMTP id ei48-20020a05635906b000b0016bfa514862mr1550312rwb.29.1701890854897;
        Wed, 06 Dec 2023 11:27:34 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id p1-20020a63b801000000b005c19c586cb7sm255367pge.33.2023.12.06.11.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 11:27:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 6 Dec 2023 09:27:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue fixes for v6.7-rc4
Message-ID: <ZXDLJZ42TGL9LlM9@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a12deb44f9734dc25970c266249b272e44d3d1b5:

  Merge tag 'input-for-v6.7-rc0' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2023-11-09 14:18:42 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.7-rc4-fixes

for you to fetch changes up to 4a6c5607d4502ccd1b15b57d57f17d12b6f257a7:

  workqueue: Make sure that wq_unbound_cpumask is never empty (2023-11-22 06:17:26 -1000)

----------------------------------------------------------------
workqueue: Fixes for v6.7-rc4

Just one patch to fix a bug which can crash the kernel if the housekeeping
and wq_unbound_cpu cpumask configuration combination leaves the latter
empty.

----------------------------------------------------------------
Tejun Heo (1):
      workqueue: Make sure that wq_unbound_cpumask is never empty

 kernel/workqueue.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)
