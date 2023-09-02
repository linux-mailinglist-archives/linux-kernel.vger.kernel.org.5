Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F55790929
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 20:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjIBS3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 14:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjIBS3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 14:29:30 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A259E56;
        Sat,  2 Sep 2023 11:29:27 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bf092a16c9so1056895ad.0;
        Sat, 02 Sep 2023 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693679367; x=1694284167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S/h6f60a51OBLWnoS64kjCROnu9sNnSGTdI4hkrdrgU=;
        b=lebTLeQVGx0DeXQV10YvxSIKZ12oDvE/q/+Qtw2bHEXfLvHzXmXYLBPXasWME62uOt
         FBOQwSb2FsTDOpXHrAn+Hv1Lio1wAnjFnWxSQWOyMgbCDkf6H/ASx3HpB2uLaSYiPBFR
         Br2yt7SHN/37kqxibdis+1DlNPu1xvnRhkBqx+kZBGJrBZBH0Jx1kchrMmHkiTS8BP/2
         bQrjoLK8WPTR3vBOcLXDjIRSIXtRZ0nzZhvdeKADDvzfYY/zYilrf9LNAUOsSKql05kg
         QjtoRLOqD1YDfg6BaU1T23YnN4uQYG9XlnYPu9O6su5DpSzJ7Fq3Z3azAuUcBIAwGg9E
         Aw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693679367; x=1694284167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/h6f60a51OBLWnoS64kjCROnu9sNnSGTdI4hkrdrgU=;
        b=dnTsrgISrraGLJedOzi+DcIuFzGU9ujZisZa0KPYUd/UhAbqLJkXHLWkvFeSHFe4O7
         eqrO/W2/u6Oymx/j4dYepC35pCnwWxsvE0yHFEVAPug4CSGue+pfOrOgZ4mdxMcs0K/W
         kpQLNdaThshOKFiILThst6RRjyC/QDf6RQacAarr8fTUKsRSlCxuAindRZQ2E5BXeuvP
         mx7PQ7mvkJY82NGsfgyYFeEKeedLq/Rr9j94skMonCcnGS+VH9GAp58wx2+gSi0SZuwb
         BgTuDmgb8vev4AYlg52ySW/2Ls3fTN4zoBMH1JiU+c2QyMcqG/S8b4bVibpMEhPbHZoV
         WY7Q==
X-Gm-Message-State: AOJu0YypXV+zUb7IEpAkCTalifB/nguNIk1HK/thwcAXzLcJkxJIOUSb
        ymPfxMdUFYInVo5lhONHJ5NiLCFzT9c=
X-Google-Smtp-Source: AGHT+IG/uEbtoVkHaVb2B12zE2+36cqoiOeVslgBCDws8JeZpUrN1RRTE+9A140Ffx7K8OEhgJKP3g==
X-Received: by 2002:a17:902:eacc:b0:1bf:2e5c:7367 with SMTP id p12-20020a170902eacc00b001bf2e5c7367mr6724508pld.42.1693679366775;
        Sat, 02 Sep 2023 11:29:26 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001bf846dd2d0sm4918970pli.13.2023.09.02.11.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Sep 2023 11:29:26 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Nishanth Menon <nm@ti.com>
Subject: [PATCH v4 0/3] greybus: Add BeaglePlay Greybus Driver
Date:   Sat,  2 Sep 2023 23:58:40 +0530
Message-ID: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
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

BeaglePlay is a board by BeagleBoard.org. It contains a main AM62
processor with a CC1352 co-processor. They are connected over UART.

Greybus is a hardware protocol that was designed to provide Unipro with a
sane application layer. It can be used in IOT and IIOT applications
keeping the intelligence on the host.

This driver has been tested on BeaglePlay by BeagleBoard.org. It serves
as Greybus Host device and communicates with BeaglePlay CC1352
co-processor which serves as Greybus SVC. This replaces the old setup with
bcfserial, wpanusb and GBridge. This driver also contains async HDLC code
since communication with SVC take place over UART using HDLC.

This driver has been created as a part of my Google Summer of Code 2023.
For more information, take a look at my blog.

This patchset has been tested over `next-20230825`.

My GSoC23 Blog: https://programmershideaway.xyz/tags/gsoc23/
Zephyr App: https://git.beagleboard.org/gsoc/greybus/cc1352-firmware
GitHub Branch: https://github.com/Ayush1325/linux/tree/gb-beagleplay
Video Demo: https://youtu.be/GVuIB7i5pjk

This the v4 of this patch
v3 -> v4:
- Add DT Bindings
- Reorder commits
- Improve commit messages

v2 -> v3:
- Move gb-beagleplay out of staging

v1 -> v2:
- Combine the driver into a single file
- Remove redundant code
- Fix Checkpatch complaints
- Other suggested changes

Ayush Singh (3):
  dt-bindings: Add beaglecc1352
  greybus: Add BeaglePlay Linux Driver
  dts: ti: k3-am625-beagleplay: Add beaglecc1352

 .../bindings/serial/beaglecc1352.yaml         |  25 +
 MAINTAINERS                                   |   7 +
 .../arm64/boot/dts/ti/k3-am625-beagleplay.dts |   4 +
 drivers/greybus/Kconfig                       |  10 +
 drivers/greybus/Makefile                      |   3 +-
 drivers/greybus/gb-beagleplay.c               | 494 ++++++++++++++++++
 6 files changed, 542 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/serial/beaglecc1352.yaml
 create mode 100644 drivers/greybus/gb-beagleplay.c

-- 
2.41.0

