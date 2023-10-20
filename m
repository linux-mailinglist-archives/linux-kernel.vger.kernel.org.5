Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288177D064B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346841AbjJTBza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346825AbjJTBz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:55:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110D411B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c8a1541232so2791655ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697766926; x=1698371726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=67URzkOz2NZ+RP75J+cnzPWwyvWGIBXhKdfsX2HVXi0=;
        b=bV/Q97fx/rFrfB7Pcbj/22rle9D7czx0uz8ANZH/1HyHfQzbfbrjC5Ka+NXJoVlEeM
         BcWR1X6onFxr7CLlLU9r1q0Y3zOJZv5+zSZxB+A0Gsf1EhHWIuiYjZ/H2Z7LlEhCQUPu
         xLpnjQpvqhOgXfaPasui+HQOQ40zULwHuSyQ4nPuyhp0hWdC3E7KwBH8leEQSOYv0yxC
         JFbJHKkJkmRopmNAtcJsPi6SXWwZj9WCkanzbP7bEC7s6hgom1TX5p9846yMCtf/CKLj
         LzJiEQnhU/Rjo2psvsWUPetQldagrLiww6PNcv73xUkwx/VD9ikB/ycFnrwSZDCa+v5i
         gMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697766926; x=1698371726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=67URzkOz2NZ+RP75J+cnzPWwyvWGIBXhKdfsX2HVXi0=;
        b=WAYd1LsavNLGHA6QeWOl8RKXHz2laQ9lf6rxdy2Ov7aSeQERSgQqWLjo6iy9dNISKy
         oHlK8+5J4vMYgVtIpPcl2gOARpmuXTOrXEcL41rHmSoFVAcVRRkeKaWjQuWjYGExIz/G
         GNuD2akqxpHkVuqvWRmlEpkWLblvb5RAlx0WcoOMAuGCfbFOSLa87NsEtrKAUJinI9jt
         CxUKa8VdF+D1XSAmkpUcQUh7GmN0+xT6DCmD37XknzACXDyle5fnyvjlBqwTc8QCS+tI
         PlhSbQHKjGhI+oARSTR2dFlUlbuvsNAwWkq8VFs/UvTw2qyVEkafV8WnQyAKS0o30U9U
         xEoA==
X-Gm-Message-State: AOJu0YwegoDNZyPsYKzTGCyxVhbrUmqy4cnqUFgWYinNDmne+n3TYX/I
        d6efZY9xWZ+Glcett78tc8c=
X-Google-Smtp-Source: AGHT+IHD6V3+VlPlrLy2mcmmE7vxwcXbnDv+dr/HtFRbxHFXvPT9BtDdD61CDSYP5Rn85eHrZWmarw==
X-Received: by 2002:a17:903:27d0:b0:1ca:7a4c:8356 with SMTP id km16-20020a17090327d000b001ca7a4c8356mr566418plb.27.1697766926448;
        Thu, 19 Oct 2023 18:55:26 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id y22-20020a1709027c9600b001c61073b076sm362211pll.144.2023.10.19.18.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 18:55:26 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        julia.lawall@inria.fr, Andi Shyti <andi.shyti@kernel.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH v3 0/5] staging: vme_user: Remove printk's & clean up log messages
Date:   Thu, 19 Oct 2023 18:55:18 -0700
Message-ID: <cover.1697763267.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Staging driver vme_user has a bunch of printk() calls in vme.c which
triggers checkpatch warnings. Remove all printk's by either changing
them to the appropriate logging mechanism i.e dev_err()/dev_warn() or
by dropping the unneeded printk's.

Also, clean up the messages further by using __func__ in the string
instead of function names.

This patchset fixes all checkpatch warnings like:

    WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
             dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
&
    WARNING: Prefer using '"%s...", __func__' to using 'vme_lm_get',
             this function's name, in a string

Patches must be applied in order.

Changes in v3:
 1. Patch 1: Use only dev_err() to replace printk(). v2 replaced some
    of the printk's using pr_err(). Leave the calls as printk's. New 
    patches added in v3 handle these printk's. 
    (as per feedback from gregkh@linuxfoundation.org)
 2. Added Patch 3: Remove unneeded printk.
    (suggested by gregkh@linuxfoundation.org)
 3. Added Patch 4: Remove NULL-checks for bridge device & resource.
    Corresponding printk's(part of the check blocks) are removed too.
    (as per feedback from gregkh@linuxfoundation.org)
 4. Added Patch 5: Replace printk with dev_err() in vme_check_window()
    Since vme_check_window() doesn't have access to bridge device, pass
    the bridge pointer to it.
    (suggested by gregkh@linuxfoundation.org) 
 5. Edit cover letter subject & body according to patches added in v3.

Changes in v2:
 1. Correct "cleanup" to "clean up" in cover letter.   (as per feedback
    from julia.lawall@inria.fr)
 2. Patch 1: Change the pr_*() calls used to replace printk's in v1 to 
    dev_*() wherever possible, as it adds more context to the messages.
    (as per feedback from julia.lawall@inria.fr & 
    gregkh@linuxfoundation.org)

Soumya Negi (5):
  staging: vme_user: Replace printk() with dev_*()
  staging: vme_user: Use __func__ instead of function name
  staging: vme_user: Remove printk() in find_bridge()
  staging: vme_user: Remove NULL-checks
  staging: vme_user: Use dev_err() in vme_check_window()

 drivers/staging/vme_user/vme.c | 222 ++++++++++++++++-----------------
 drivers/staging/vme_user/vme.h |   4 +-
 2 files changed, 108 insertions(+), 118 deletions(-)

-- 
2.42.0

