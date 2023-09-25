Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277CB7ADDD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjIYRc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIYRcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:32:24 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCD510D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:32:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-27763c2c22eso1342748a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695663137; x=1696267937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPRNMc6QxDaS9SdcjzPdFDOU6oAT6GNBa0QTuorzuF8=;
        b=jjiEFL8dSoZwhSzMxhugrxApy9aE6J5zcmdTXxX+r/jEJrilbqEAfsAvV3VKVJs9sY
         25ffD1lnyBkzU9PZLRQ2au8m8HzDFgOVy+J6Bp++HME9fXqiO/LveMRzh3jzMtru0Zu0
         LjVfiGwF029l9cM/aBF1kgCVR0RDtHtY4GbHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695663137; x=1696267937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPRNMc6QxDaS9SdcjzPdFDOU6oAT6GNBa0QTuorzuF8=;
        b=t5YPWi9zYgvHT+enDKYH/4DZGoNQW6nyZsLaiauLaAjDRVc8ZeAvhNA0sD9EMnSM5a
         R5twNHhiV3XHSPp0gEyHkyEbIuwa/3nyIHao2GDEWmm4Cbqu8bMKqOxDXG7R/1PIAwYd
         5+mJdyt5eaIbJN/mySvCHIPqwOrjWOIKpp5qv4AAju+eKdWY1Jtupq3v6xldQpKJ/g0/
         G8vGAO388VyjR/IITEjkl+9jYK1Mw0DHNit4zUdCEmbkLGitCz1zXINCgyhttf6Wvr1P
         8p9mZj/W6DjG1tFNZ+zBY4Lrxac+3q6z7hVqa7pvllTjLQT8ofN6i5qUL0RI1woODQyE
         C2AA==
X-Gm-Message-State: AOJu0YzAFab3mcsabPNdP8DtVVzlB0FSnl6AyWDg5j+i4daS2YE2Ulq5
        bMFWQc8Y7yCGYGMA7hEpEixxKA==
X-Google-Smtp-Source: AGHT+IECCxYPGpI+kobVKm9RWfrM+GJ2fPW9D8r3Bxrb4kOmVe3ezTbZWToUmOb93SWYxe658JAmDA==
X-Received: by 2002:a17:90b:1e0e:b0:274:6ab9:9d38 with SMTP id pg14-20020a17090b1e0e00b002746ab99d38mr4981500pjb.36.1695663137113;
        Mon, 25 Sep 2023 10:32:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r8-20020a17090a690800b002680dfd368dsm220478pjj.51.2023.09.25.10.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:32:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] MAINTAINERS: hardening: Add Gustavo as Reviewer
Date:   Mon, 25 Sep 2023 10:32:14 -0700
Message-Id: <20230925173211.work.448-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=690; i=keescook@chromium.org;
 h=from:subject:message-id; bh=jU6UNw31oUqQUYhDtt+JXQvd0s/SqELjJbjRTiNZ7fo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlEcQenw+bIIXybJxzdlEP1dKoVXj3CYsfYVxnL
 NZXpwVx75GJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZRHEHgAKCRCJcvTf3G3A
 JphfD/4yCkbGIpvpv08Fcp2ZPRVNT6TJccgFC7qsjXSAUFTtpxfK4vPvFIn8h/WuBQHP13mbVII
 uEMvqxH0sGlhxPAkY/oFAKdeS4pB1bXiZTLUaQ/2z3QYPFH+JZw4tAa4N6VItyFMKXx08P/AktU
 h2rUwz6GwPSX4cHaqn1AAX2/2IiX2T8zUtu63jeBOulM7ACrdKBU9DBhGqGeiZPGomyNAOKWVW9
 6Q6QUAEeUxDT0UUGlqvt5qB1daX4kJAkJe7aMrNs9mNtMLnqNP2dQbTTDWwrG/622VF+3N34p+n
 OwjnfiVt/9DKovgjFDZc98h9Dp8vDBEwyy/kIAmDgHXnl523VRwPHBmnve3FL3jO7m+Wmg1Tv8c
 UDHISn9QHel92brAV6a/oNBx22N3C9VU6Nv60KYmzFce6l2XLm2xf3Hj8mZwsacTrQoOC63W7/A
 xu466CBwKxgYeGfW291Cs889TemaL/ESEMtLnwsIn1WnV6j5QQ1dKhbhntoTv3sY9w/+TiRiZQ9
 wdRpQZcQS6AO0mnu4owisO67EPm1R8ew2i/sDzxfYu9bKum/zmt35TxueTkEFr3MVAaij4Qv6U3
 qwq2gzd/Cr+rlsGpV5jd1NVHviQa8YZOTaEUrfzoB0wTPS9YBaqC5TC8QyXWlov3x/aSxe9FUky
 ccv6a3by 2PslRsw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's an oversight to not have already listed Gustavo here. Add him as a
Reviewer.

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 741285b8246e..5f18ed0fbd42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11393,6 +11393,7 @@ F:	usr/
 
 KERNEL HARDENING (not covered by other areas)
 M:	Kees Cook <keescook@chromium.org>
+R:	Gustavo A. R. Silva <gustavoars@kernel.org>
 L:	linux-hardening@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
-- 
2.34.1

