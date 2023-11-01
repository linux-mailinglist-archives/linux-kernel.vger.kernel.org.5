Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30467DDF43
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjKAKRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbjKAKR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:17:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C44120
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:17:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afa071d100so99376837b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698833845; x=1699438645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vprtd1rnc+6PWmI9YtTse/TMvnp22Nc9rwicgWr4RkQ=;
        b=Khfnj0y2ac9BFIyLjiz85G0lATt4TAJ02Vm3UaXjXQ3L3r0H6dedXWkWGhl49+O3wx
         4urwKE+YDUeddAnNjVHiKU3Wtek8bfHfaumxL/tVjSP1Hsh1NpBulUGPTmADhEMlvP/j
         24Zd7P5YppVwvdpoxJARrL6odJeu43oJtn4EImlnRGJlxPwYKCVXR79/NewPZHbEZJB4
         Z/VG0YzHWZbLrcpmVY3WIMvelPauPlCIKanNR7GPE+2FQLcRErT4pLeiH02pYKDPoZIe
         WyErqa/7sMmxDMxeVkEvwO+qsJWBbbLvs6TkHztS6WOnSiAyphEcI1FsNxKSvhm/h2iW
         l2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698833845; x=1699438645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vprtd1rnc+6PWmI9YtTse/TMvnp22Nc9rwicgWr4RkQ=;
        b=Jd34w+Lho7wqEtGVkmUG3JOVd4YCTKafccdbfGfXebiIHlQbFTFfSYAHUbOQ/PVdaw
         nquwlNz0Ma3jYrWYlEejGZtKHdUl63YEkLm94LAs5HkwaAo+TYoFb5m/UC68ffls4A/c
         i447MfQSxr5SGDJZrLUcADJA9CO3WM54E3GNOMXeCOstBSDt/FQwo9IbOe25b/IKxhFB
         U85OhgbOuwoNStt0F5unxZmEot8kDlWJwRcZaMmJOCFlkeRSY3t3AVcLgwxEUWd5Zuvb
         Rf5VuBT3yiFtov25LV5FXk7wQ3gfxvaRfmTjzAeAhNlZs7rvgm0bnxVTWrHLSdMhCOdg
         nhiw==
X-Gm-Message-State: AOJu0YwompvuwZuALXjMKtM5WN2jwC5WOQEMnNnfrXYtKEjVLKl7LSkF
        3n3KPdWMmjDxCb3uDZpUvFnJBer1aaoX
X-Google-Smtp-Source: AGHT+IGkfIXtBIMbWiSohH3G81opyz7YcOkbxfQvv4/AQ1loEffyLJXXLOsN3/OXjkkFqgKoDde5Qf0cSNH2
X-Received: from mnkumar0.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:313a])
 (user=mnkumar job=sendgmr) by 2002:a25:ce94:0:b0:da0:3bea:cdc7 with SMTP id
 x142-20020a25ce94000000b00da03beacdc7mr263093ybe.2.1698833845477; Wed, 01 Nov
 2023 03:17:25 -0700 (PDT)
Date:   Wed,  1 Nov 2023 10:16:25 +0000
In-Reply-To: <20231101101625.4151442-1-mnkumar@google.com>
Mime-Version: 1.0
References: <20231101101625.4151442-1-mnkumar@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231101101625.4151442-3-mnkumar@google.com>
Subject: [PATCH RESEND 2/2] dt-bindings: usb: add no-64-bit-support property
From:   Naveen Kumar <mnkumar@google.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        royluo@google.com, devicetree@vger.kernel.org,
        Naveen Kumar M <mnkumar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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

