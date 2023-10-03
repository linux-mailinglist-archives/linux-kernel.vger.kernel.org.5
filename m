Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B307B5F3F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 05:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjJCDOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 23:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjJCDOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 23:14:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1E0BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 20:14:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2777a5e22b5so327316a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 20:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1696302866; x=1696907666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hu7+B11Hw3uM8Sa5n4kO/9PErxC3pYlTJZiv/P9tfjA=;
        b=XuRKVxWREHyYqdUpuu+wbgt9ImtEsf/VoXtO4mhRTDEz1gFruoCSXE/yQydpT7An35
         BE4OUMYDLw+owayv4V199kzKuyHQBfnt9StvQLvhdSTNAG7g1gSGYGGJ8QEdMA2bHxiX
         Dqm1R+YkE3SyIlljlho4j7EGaIVbrzpsK6ZuFM2sO1sgOZdZNK3cpDaC29OD24S3lO2Z
         vHGgIDb6cGpUE73iaEBvpGDrkpqoh9nq29P+yp9BEr7SwoO1gfzjc0ZSCdFpiNbacFP9
         2QXfiADDTrStB8+cv+VVzl3KiSGcFiQ4criwV0fkc+MQgns7FxirfGHMpxPR6phebfJq
         iFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696302866; x=1696907666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hu7+B11Hw3uM8Sa5n4kO/9PErxC3pYlTJZiv/P9tfjA=;
        b=NqImJbj06JQOse79VQykUP15FXUdJ/0GK5Qs9TCpkwhXMc+DSrXZPF1svJfprpkaNH
         KGHrCj3WaM8YAa4fq8mrQhXf7hdmVDG8nKc/pKnZm+aYMWJW4SUtSlLZEY+1UfiGxURd
         as8UdByyyvyajImDsOugbg+bih8IB25fs1zaQc9HD+WiCMZ1uBagI6ACfwkemkXjd0IN
         nKzet+i0L2eeIlwq4XDR2JCZuMFD4p1TszPaoOFytidK2azSjpcK/mp6NmQ4CH/Y0lD4
         kMj7L30QreTmJxQqaJcnp7oMVYPFE8vxxQAEYhi/I+vp7HPfqu9e05K/ub1kx0HFB52c
         mWXQ==
X-Gm-Message-State: AOJu0YzyquSA0OLfkaBC0I+ZTEZB83pRu2ViUG5vAQ3YGzqYLlyGopXx
        qj5CMmckpqzmASto5rsAku4ktPqsMYgwPXbmRlU=
X-Google-Smtp-Source: AGHT+IHqxNV4tPPonq9LPtBza1qpSZfthVa8Rtd8vQ/1LJzQZGXpYnbuPRDajiU27c+Dz06G0oyWfQ==
X-Received: by 2002:a17:90a:17c5:b0:274:87e8:7ce1 with SMTP id q63-20020a17090a17c500b0027487e87ce1mr12865512pja.39.1696302866594;
        Mon, 02 Oct 2023 20:14:26 -0700 (PDT)
Received: from basil.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a004b00b00273fc850342sm7692550pjb.20.2023.10.02.20.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 20:14:26 -0700 (PDT)
From:   Tree Davies <tdavies@darkphysics.net>
To:     gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com,
        anjan@momi.ca
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/3] Staging: rtl8192e: Rename variables pBA, bCurrentHTSupport, and pTSInfo
Date:   Mon,  2 Oct 2023 20:18:46 -0700
Message-ID: <20231003031849.176743-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NO_DNS_FOR_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series renames 3 variables to fix checkpatch warning Avoid CamelCase
Thank you in advance to the reviewers
Tree


Tree Davies (3):
  Staging: rtl8192e: Rename variable pTSInfo
  Staging: rtl8192e: Rename variable bCurrentHTSupport
  Staging: rtl8192e: Rename variable pBA

 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |   2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |   2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c    | 112 +++++++++----------
 drivers/staging/rtl8192e/rtl819x_HT.h        |   2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c    |  12 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c    |  20 ++--
 drivers/staging/rtl8192e/rtllib.h            |   2 +-
 drivers/staging/rtl8192e/rtllib_softmac.c    |  15 ++-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c |   2 +-
 drivers/staging/rtl8192e/rtllib_tx.c         |   8 +-
 10 files changed, 88 insertions(+), 89 deletions(-)

-- 
2.39.2

