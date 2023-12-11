Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50CCA80C18F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 07:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjLKGyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 01:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKGyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 01:54:22 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9E4D6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 22:54:28 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6cef5220d07so498000b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 22:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702277668; x=1702882468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K0+jiNBabf5mDupvKR2mxyLiAA9W8b3A/GEvdc87WBA=;
        b=QZfNGXT1YylcttanzDAQro8DIpxp/D/f5fAX2Nke6MxZwFYvj+BNyuolOESab19G20
         IHbJ/tF4xFhdHTpDOTMLPyzsujGooQPsCIsPdb6Y76CL7pHilvu1/ySAVHfESbxfqNM6
         6kfOVZrTFgNA8rkqfE8qwvY044BjaUsomacyA7OwA/eNgCRpoqrOivY1bZ93WrhJ9Zyp
         GAzW91M4JL5KDL0QFit8cayv2K3kgfLosvtwhnoKveYvlMezfLpKa6qGholzbUqoB2Fw
         FCNUc+ZBM7PYSP/I7IA6fK19cpkXGg6BKRkHVHHEqzZOy4kxhHAqb9QkNmECfmoVChwG
         eYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702277668; x=1702882468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0+jiNBabf5mDupvKR2mxyLiAA9W8b3A/GEvdc87WBA=;
        b=rHdGu/1QYqiKMFo/uCgiQ77eGUuWd0ZCMrQO30FFjDRj1BH3BjWgKomiKuZRCOKxG9
         Z8YmTyc0VGzNDgcfXmvZJZeZahgdoT73s+HUkXr4gSHbnFlMEbIGeVKXYk6qAHAVuZVt
         mqi/mh7Yul1RbCf3piEleKNlRW228Dpw/a3DXJS9ci/Oezq7UjDhptVw7K6Znl8OJCay
         F8tr6JxAe3jBnsVAGlHOzKBbndsOHHXwDe97TNhTS0AqqjdexeOqXeL/arDo1Y/1bCHV
         UjIYKcmXKwHUO2B12rtYBwnDU0ezObzSJ9BfkfmousHkN9sgiAx6wux1+QruhM0bDJK0
         gixQ==
X-Gm-Message-State: AOJu0YzxZQkrwUSmDdOkhhAbXFTLXRv2hu5g9GGvHoN9U9lKkelPraAD
        DjfJ8MqbrCoBBpdFnYD0F3w=
X-Google-Smtp-Source: AGHT+IH/pYfG/5sObmi85s725MYUr/WUemToVANiuOxH6/n+mdr47weGDuXAg9Xpu0eLS+5TAf8g2w==
X-Received: by 2002:a05:6a00:1749:b0:6ce:2732:1e07 with SMTP id j9-20020a056a00174900b006ce27321e07mr1556995pfc.65.1702277667738;
        Sun, 10 Dec 2023 22:54:27 -0800 (PST)
Received: from toolbox.. ([103.46.201.248])
        by smtp.gmail.com with ESMTPSA id r1-20020a62e401000000b006ce91d27c72sm5751054pfh.175.2023.12.10.22.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 22:54:27 -0800 (PST)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com
Subject: [PATCH V2 0/1] Make gb-beagleplay driver Greybus compliant
Date:   Mon, 11 Dec 2023 12:24:17 +0530
Message-ID: <20231211065420.213664-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In beagleplay beagleconnect setup, the AP is not directly connected to
greybus nodes. The SVC and APBridge tasks are moved to cc1352
coprocessor. This means that there is a need to send cport information
between linux host and cc1352.

In the initial version of the driver (and the reference implementation
gbridge I was using), the greybus header pad bytes were being used.
However, this was a violation of greybus spec.

The following patchset creates a wrapper around greybus message to send
the cport information without using the pad bytes.

---
V2:
- Add more comments explaining the new greybus hdlc frame payload
- Remove msg len warnings. These checks are also performed by
`greybus_data_rcvd` and thus no need for it here.

V1: https://lists.linaro.org/archives/list/greybus-dev@lists.linaro.org/thread/Y3ELHKLKTP5TQZ5LYKCE6GHWMA3PUOTV/

Ayush Singh (1):
  greybus: gb-beagleplay: Remove use of pad bytes

 drivers/greybus/gb-beagleplay.c | 55 ++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 14 deletions(-)

-- 
2.43.0

