Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA7B7A6B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjISTCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjISTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:02:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C447B138
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5a586da6so2485587b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695150144; x=1695754944; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yByc+t8MiUd/FlhKNAv002747b3UkcfIteNK5wC98N0=;
        b=SgOcQtHMjLK+EGkutrFRwTSKlH9Sc5Qc0BTau9o3MxVjYiaMeBlrZRW2K//iS4AsEB
         t5y6719VtwzZ5Zj7MGrm8AUC628FlAFhNmGiS5jwQSFCRYmo8D0ziMoEUK+iEOfqSJQs
         e3Uep8dyPpfXJZIi0ME9wSGnrHuEbTY6NnrnBqufYk3h03Jow4xC8m1io9D6eevaaYWZ
         c7GMg5v/0FXsANHfWX361BEfVqO5wgeGP1Vpif0J3rjqSrHtieptDWNKIZnWduHsk2kr
         O2+clrM4Efk1hgoEOqHEikBNsjzYZmfoRb7ZD+k+cchG/BUHug+ws3NWfXBpghk7z7rj
         Bmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695150144; x=1695754944;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yByc+t8MiUd/FlhKNAv002747b3UkcfIteNK5wC98N0=;
        b=biyLNDqf6tazUMU5R3WBhOLIQ2/D0LpRNgTgrtRRGSJb+X9jFGW7bN7pwZx+rk1+K6
         n7p3QrjDRPKx6TdiHdZn4fPKGy6PSVHeQxVnb7Ay9ci3rg/P4sNRiNFVE0dDmJQHb4oT
         EQnjiGwxF13OREl1oySNkiQy2pCbFB3MtvTlnrtae3Q/BL71Zas4QayXq5U4cG5U0Hzh
         D/hqMWs4dOtFRlV0iuO4E6gcBKk02kbX/r/C3eiZ4ZHmzcVkuA4+FyBuuQOZU+aFug0I
         jNW6lY2qNl8ifqwIUr8JMqzIxZNFdHaXCKfCTBMEKPraNozsM4vMmAjRx8gcIF4yvEHN
         EEbQ==
X-Gm-Message-State: AOJu0YyoXUbISfjZ/79GHkzA5vvA1A/8/odrdQb2xocUvpioqehZBCrw
        32JUhmm6skt2Za0NM0U5wBQ11YUVE/Lyr+H4GoaP
X-Google-Smtp-Source: AGHT+IFoQhXcjpZz0tNIspX2HizUbJrBHJVvEou6jQsnzb8YUr35yLjePVG0NBfJ9xY4w5XR/FlOcKZy982n0Y9YdDP2
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:8f5a:6a6a:cafc:a3ad])
 (user=axelrasmussen job=sendgmr) by 2002:a05:690c:d8f:b0:59b:5a5b:3a91 with
 SMTP id da15-20020a05690c0d8f00b0059b5a5b3a91mr113072ywb.2.1695150144075;
 Tue, 19 Sep 2023 12:02:24 -0700 (PDT)
Date:   Tue, 19 Sep 2023 12:02:01 -0700
In-Reply-To: <20230919190206.388896-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230919190206.388896-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919190206.388896-6-axelrasmussen@google.com>
Subject: [PATCH 05/10] ioctl_userfaultfd.2: describe two-step feature handshake
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alejandro Colomar <alx@kernel.org>, Peter Xu <peterx@redhat.com>
Cc:     linux-man@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fully describe how UFFDIO_API can be used to perform a two-step feature
handshake, and also note the case where this isn't necessary (programs
which don't depend on any extra features).

This lets us clean up an old FIXME asking for this to be described.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 man2/ioctl_userfaultfd.2 | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
index 339adf8fe..e91a1dfc8 100644
--- a/man2/ioctl_userfaultfd.2
+++ b/man2/ioctl_userfaultfd.2
@@ -83,7 +83,6 @@ struct uffdio_api {
 The
 .I api
 field denotes the API version requested by the application.
-.PP
 The kernel verifies that it can support the requested API version,
 and sets the
 .I features
@@ -93,6 +92,25 @@ fields to bit masks representing all the available features and the generic
 .BR ioctl (2)
 operations available.
 .PP
+After Linux 4.11,
+applications should use the
+.I features
+field to perform a two-step handshake.
+First,
+.BR UFFDIO_API
+is called with the
+.I features
+field set to zero.
+The kernel responsds by setting all supported feature bits.
+.PP
+Applications which do not require any specific features
+can begin using the userfaultfd immediately.
+Applications which do need specific features
+should call
+.BR UFFDIO_API
+again with a subset of the reported feature bits set
+to enable those features.
+.PP
 Before Linux 4.11, the
 .I features
 field must be initialized to zero before the call to
@@ -102,24 +120,11 @@ and zero (i.e., no feature bits) is placed in the
 field by the kernel upon return from
 .BR ioctl (2).
 .PP
-Starting from Linux 4.11, the
-.I features
-field can be used to ask whether particular features are supported
-and explicitly enable userfaultfd features that are disabled by default.
-The kernel always reports all the available features in the
-.I features
-field.
-.PP
-To enable userfaultfd features the application should set
-a bit corresponding to each feature it wants to enable in the
-.I features
-field.
-If the kernel supports all the requested features it will enable them.
-Otherwise it will zero out the returned
+If the application sets unsupported feature bits,
+the kernel will zero out the returned
 .I uffdio_api
 structure and return
 .BR EINVAL .
-.\" FIXME add more details about feature negotiation and enablement
 .PP
 The following feature bits may be set:
 .TP
-- 
2.42.0.459.ge4e396fd5e-goog

