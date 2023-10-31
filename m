Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C933B7DC569
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjJaElM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjJaElJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:41:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B2AB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:41:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so5214143276.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698727267; x=1699332067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vprtd1rnc+6PWmI9YtTse/TMvnp22Nc9rwicgWr4RkQ=;
        b=tH16I95CKUfZ0YPNmD9HKsUuvHhLNsh+jN2rt+vlfjj478qUaPAJjSISkx4kug3/fU
         SJhkFNm0l0hg3ubN6Mb49G5I1D3+MOvjyhMCt7OBfhouADE2xUABTncaXmC41GGg14JK
         mDrtrx2aa9hQfGQ8lNNL2184bTpx0L5dJb0mVE8yLPnuZpeEM2dxRfTHuxeABieMRwO6
         VsWMaUbTnxPwmEFVx6x0rCcpZmcrH5qACG6y1WWRvMUT00RTGaDl+oQYJIreaFJ/HRna
         tGn4CVF9GwJ8YnNRg9deK+IGQSNunYCiAopomXInRszq2PbjTbnLaNm/1LKTiJ5f0A95
         ESzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698727267; x=1699332067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vprtd1rnc+6PWmI9YtTse/TMvnp22Nc9rwicgWr4RkQ=;
        b=txExb7es9kfup46cCLaQJJrVVfKzXyWqDvvIN8199bSjyygZyHvBNZSCf531NnH6ZY
         1uRWs5Ei7l5+wD7ib5e9C1N7N8AVqmYNGtMS4zUO64zzWGX/XkB4C0pknjD4n1o841pN
         v2lr4Q8l1cfwzFmQMBNSIlNBBB7NgNNV6ciNTSBduGjTm3WLdJsIAs5vk6TYP3ugY4xd
         Nc4d7Dw6+yQ6ON14kzxdtgieXBEAz2A/go54TBGJE36LzqN+DIFYQAyyIzRjawBh9KLQ
         yhIq5zbdvkD5dxxi2k9rJ5tafiwkgmN739DV6+MRw3zKweGnApFHNYiLGyxaM0UjzP61
         Riww==
X-Gm-Message-State: AOJu0YzksBFua4At4qaXxfKfPf2hQBDwtvJ2lvq3mXlLCpLaszqDtNLu
        rcrMhiiodySoOqIio/3LWI3YoYG/EHGE
X-Google-Smtp-Source: AGHT+IEWTHudUpZ0bOr4errsoYCA6YThAwqSHURzraWyydGu8fZqxl0t8CFXT5EE/124DtjvNQ2jO0Q7WScX
X-Received: from mnkumar0.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:313a])
 (user=mnkumar job=sendgmr) by 2002:a25:d754:0:b0:d9c:66d1:9597 with SMTP id
 o81-20020a25d754000000b00d9c66d19597mr211275ybg.13.1698727266148; Mon, 30 Oct
 2023 21:41:06 -0700 (PDT)
Date:   Tue, 31 Oct 2023 04:40:21 +0000
In-Reply-To: <20231031044021.1162403-1-mnkumar@google.com>
Mime-Version: 1.0
References: <20231031044021.1162403-1-mnkumar@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231031044021.1162403-3-mnkumar@google.com>
Subject: [PATCH 2/2] dt-bindings: usb: add no-64-bit-support property
From:   Naveen Kumar <mnkumar@google.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        royluo@google.com, Naveen Kumar M <mnkumar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naveen Kumar M <mnkumar@google.com>

Add a new DT option to specify whether a host controller is able to
support 64-bit DMA memory pointers

Signed-off-by: Naveen Kumar M <mnkumar@google.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.yaml b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
index 180a261c3e8f..20dc134004f3 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.yaml
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.yaml
@@ -25,6 +25,10 @@ properties:
     description: Set if the controller has broken port disable mechanism
     type: boolean
 
+  quirk-no-64-bit-support:
+    description: Set if the xHC doesn't support 64-bit DMA memory pointers
+    type: boolean
+
   imod-interval-ns:
     description: Interrupt moderation interval
     default: 5000
-- 
2.42.0.820.g83a721a137-goog

