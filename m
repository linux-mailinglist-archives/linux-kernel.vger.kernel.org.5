Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939527A6B12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjISTCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjISTCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:02:22 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7298E1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdac026f7so73205247b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695150136; x=1695754936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OM7/ZBsweEHQQFPt50lI+eLlVKDaLR0lSsGnYD/uIDg=;
        b=TL7YK71y+TUTy6fGHYiqdt4EtznmZCsTiHX38kHatN4xhHv67/jiXlPuGF2TixAK/m
         AwAnc1huXwj7Kkc1XDnMP1lT4t+s/lZd7VTuW6gu2fgOFm1OiPF7V4JZgnOuavWSO+EB
         OylC/CtOFWRfzrNpB0UKREr5Bd6tSYckKJXohuyIjLLv3vUrmi3dlHv4IahrJ2oaB3em
         UOpkZCFgCRhIanNHMSCO4awRhDvx3N9Y2pVAjUXrKBO6aqF93RDswWshoCVSVLu3ZgF2
         km9BZHT3khi3N+Oi4nroprbc4fCKPDIMV1dfsdu29GaMjWZnK1xf66H5lDijGxxOdSrO
         h/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695150136; x=1695754936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OM7/ZBsweEHQQFPt50lI+eLlVKDaLR0lSsGnYD/uIDg=;
        b=dRh4U7RAuuBxjfZVEwKn8TkULqOs1WF8Tqim8fb5SYDBaHHq7x8d4NSwiS5dPUSKf1
         /40I5TJVFfeZudOpxciQ2lHsBf0vMKgDssIwioF2pVZTWGN+gu+wJcVAgsm3nUl0raE1
         uB38eX8DxQkzksLEH4qpxi0Y4OmVDuIRh99Kx6E3MR9ep9fE0266zmxLPdNDqdwK7I0r
         hDRXDCldlkxBY1EWbEOSQsPYSD/ZZHoX1xwGXw/zI2QBMhA9ZoPlOS4inMXRaUDR46JT
         Aqr5MH2TGz0GdvC0orBkVRQSdRPr7p+lZcLbiWhAuxaN+325mPpxHJMJ8I5ektnJHEtl
         Ygyg==
X-Gm-Message-State: AOJu0YycEw3Qy03Q8xo5Biljt1dYYt7UBRJbiZU3obbPG5u06X1mo9s5
        KNZ8aX/9Zx3fcbdAI1+vkkP79a2dB/ya+HfHAFiH
X-Google-Smtp-Source: AGHT+IFf0kRJIOcrKDJvGyy+9uuMetyVG0rmWrcYJuPzwTUle78T8JRLjh7ImzOta7b6zc579tMrz4KeWMgNFH3qWKPl
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:8f5a:6a6a:cafc:a3ad])
 (user=axelrasmussen job=sendgmr) by 2002:a25:ab48:0:b0:d81:68ac:e046 with
 SMTP id u66-20020a25ab48000000b00d8168ace046mr6411ybi.12.1695150135954; Tue,
 19 Sep 2023 12:02:15 -0700 (PDT)
Date:   Tue, 19 Sep 2023 12:01:57 -0700
In-Reply-To: <20230919190206.388896-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230919190206.388896-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230919190206.388896-2-axelrasmussen@google.com>
Subject: [PATCH 01/10] userfaultfd.2: briefly mention two-step feature
 handshake process
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

This process is critical for programs which depend on extra features, so
it's worth mentioning here.

Future commits will much more fully describe it in ioctl_userfaultfd.2.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 man2/userfaultfd.2 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
index 40354065c..1b2af22f9 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -200,8 +200,9 @@ the application must enable it using the
 .B UFFDIO_API
 .BR ioctl (2)
 operation.
-This operation allows a handshake between the kernel and user space
-to determine the API version and supported features.
+This operation allows a two-step handshake between the kernel and user space
+to determine what API version and features the kernel supports,
+and then to enable those features user space wants.
 This operation must be performed before any of the other
 .BR ioctl (2)
 operations described below (or those operations fail with the
-- 
2.42.0.459.ge4e396fd5e-goog

