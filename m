Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053087626EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGYWhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjGYWhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:37:21 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905A24ED8;
        Tue, 25 Jul 2023 15:30:02 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1bba254a7d4so664408fac.2;
        Tue, 25 Jul 2023 15:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690324129; x=1690928929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wIlzTzrN9fphTucPdXNiodkKVngUbgF/op8qk9BeIR0=;
        b=pOucNzm9wPLIrHoD1+pOT5ieiQdLrE2nmjzeLGrmtO+DZPvXXznyIVbA9otHUD3LTR
         ahkxhGiCUDfgF8U1rIdbYL70VB9W6XbHUq00G4zDGSIX6ZbLCmbejH8V2OYw0myUpRGD
         mAcZ2+e5n15LWfc2dDIcyyyjjksfgLzSV5hjP5IO6dQQuBswrcc02/GI2fw1+SDswxJb
         EnZfpb0dko0qDQlVJSUPNij6FNsqAIEQu8YzDoOadHLQDT7YrE+wIjnPUYYOmgunR6xk
         pXcKEFZPAlFiC8TUKrnFzvxexKTC9jBcFdNuCVD/JRI9NRCbejzV/z2drPpYboSxT8eZ
         8mpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690324129; x=1690928929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIlzTzrN9fphTucPdXNiodkKVngUbgF/op8qk9BeIR0=;
        b=aUN65jL+F84B5yUgkoB5JCEv1Lmb0hQC87XPnKiZICdIgiA4E76gD3Yem/IkwM3z8U
         p9b8pGovmtS4Q7mL5Oq+bTDjqXScwC8z4XiVlOpDG1oCjw39Ga6igrKL5yyL2Uq1u11g
         55ZPEHGbqVp2xSzZ7BISg32k8qiDqLcj3oxmTmflf2GS3jTKJLTgXAjPEKRTGqdw67vW
         iRRjYYJkwXQb78PzCIoob9CZYTIcbYgaAJwp+YaqAPbtL8zVTTKQl9ihCFIuKWkCg+Ym
         wrrRzKOcjaDBtlDNk19u1y8hd+CHLj5y3fxav4WHaKIgs7x3dil9FgeZ4cVbe5r9Sq13
         s4kQ==
X-Gm-Message-State: ABy/qLZiM0qApUYMXBGbjiqRcz/RD2Wv2SVCAgIQzwKAmyrrSp0vO+Xv
        xez+sev9RYR0UGh2TYizbYFkN/sQ4FSf3w==
X-Google-Smtp-Source: APBJJlG/fMOoVXiXYWBDu9X13cXiELqNonLaC+X3BL+mKsve3XbXr7JpQlRP4vAmJc2HRFKqpZOWbA==
X-Received: by 2002:a9d:5f07:0:b0:6bb:2945:b180 with SMTP id f7-20020a9d5f07000000b006bb2945b180mr350882oti.11.1690323608460;
        Tue, 25 Jul 2023 15:20:08 -0700 (PDT)
Received: from localhost.localdomain ([97.115.139.81])
        by smtp.gmail.com with ESMTPSA id c1-20020a9d75c1000000b006b884bbb4f3sm4258127otl.26.2023.07.25.15.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 15:20:08 -0700 (PDT)
From:   Aaron Armstrong Skomra <skomra@gmail.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com, jikos@kernel.org
Cc:     pinglinux@gmail.com, skomra@gmail.com, Joshua@Joshua-Dickens.com,
        jason.gerecke@wacom.com, stable@vger.kernel.org
Subject: [PATCH Wacom EKR Battery Fixes 0/3] 
Date:   Tue, 25 Jul 2023 15:19:36 -0700
Message-Id: <20230725221936.123775-1-skomra@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the ExpressKey Remote battery will persist indefinitely in
/sys/class/power_supply. Remove the battery when we stop getting
reports from the device.

Also remove some unneccessary code and make an EKR struct name more
descriptive.

Only the bugfix in the first patch will be sent to stable.

Aaron Armstrong Skomra (3):
  HID: wacom: remove the battery when the EKR is off
  HID: wacom: remove unnecessary 'connected' variable from EKR
  HID: wacom: struct name cleanup

 drivers/hid/wacom.h     |  1 +
 drivers/hid/wacom_sys.c | 44 +++++++++++++++++++++++++++++------------
 drivers/hid/wacom_wac.c |  7 +++----
 drivers/hid/wacom_wac.h |  4 ++--
 4 files changed, 37 insertions(+), 19 deletions(-)

-- 
2.34.1

