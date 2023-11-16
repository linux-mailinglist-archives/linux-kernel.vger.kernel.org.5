Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0C7EE61D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbjKPRpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKPRpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:45:49 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983581A8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:45:44 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32f9268bf8cso822183f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700156743; x=1700761543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=31lYSY2gScfJmzy6bBEtYXDpksRo7piXakrkacNysY0=;
        b=EMfToD67FrdEb0AvzYukUrvxkA+b8TaYGG6CCqXEGsf3ocONPCh6Ki0NfH5ucIeXhz
         ExEpDMcdg2ysufqVtOyCbaB1b5jOdizmLsLU4oOSQjgZG6yW4n4JmTF6idIQr3zkjZBX
         bJIz01HQmYoMB6mYFvLkBPejwwvpEDr7wnKaJku9UZbn3t53XSKl+kVCyWu40IVMMHoz
         wA16K+AAPxpzxOXXv0thWjMAh55PN4GQzbR7NUh/SdaNIMo2URhe9yjAAAZT6GkxF7cq
         yUQ3OKNm3ZtH5q1qNMcfK8uBxoM1VkvvDqf254vK1KKDveUPaCqfHl/zfw4M5a0N+XkL
         NFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700156743; x=1700761543;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31lYSY2gScfJmzy6bBEtYXDpksRo7piXakrkacNysY0=;
        b=lrXOnx408OW2v28+3cFMCmDtv1ALYZP1CE+4MssQre087GffVBOZ1A76QFVjRIibKr
         O3BFkvBlojXuX0g7kEaKU2V3D0vleEs1xUUHj4N6X4xxX3DbhggGklpKDFo5uY6QVP6S
         hmtNB2m9THMuyEoYmUWg7kXW2zjC6QxN9JjZKeBPBZZC+nhbxgvfzmMTMtjsNg6o8evF
         5XgQA//MOJn0Lw88E9fdnd6NaYTFesXGt5G4+vkXGIi3AdlWiMLxU06ekKPGTjfU/G7o
         j60RdTylDHd0szc0xjHyCZeYd2cQDD9BWEBFr3JYjPUlLqwb+K8k49uvc/vrnbqaNPCb
         CexQ==
X-Gm-Message-State: AOJu0YxkrEEpnfT3qkeD1Bpm9zEIOx+nGF+YnnUi+j0xoMP1z/Nm5jTg
        gIRGd+BaQDtXYvAbKpaFMI04+SIa8FbMIoYRxvZVYQ==
X-Google-Smtp-Source: AGHT+IGNVHhghBUl5iM/P/Z0aAWMjuKqtbfYIzxA2kdl7Qr/+Mlq2Ay1qmoyp8LzTWuwVbY2DWkIIJnthzW3Vy82DD4=
X-Received: by 2002:a05:6000:178f:b0:32d:84c7:2f56 with SMTP id
 e15-20020a056000178f00b0032d84c72f56mr13158051wrg.21.1700156742901; Thu, 16
 Nov 2023 09:45:42 -0800 (PST)
MIME-Version: 1.0
From:   Brenton Simpson <appsforartists@google.com>
Date:   Thu, 16 Nov 2023 09:45:31 -0800
Message-ID: <CAAL3-=88exVfuL1Y-kvPNbsU+d-UTfDLFViWVObFLtbC4xueeA@mail.gmail.com>
Subject: [PATCH] Input: xpad - add Lenovo Legion Go controllers
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Erica Taylor <rickytaylor26@gmail.com>,
        Vicki Pfau <vi@endrift.com>, nate@yocom.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Cameron Gutman <aicommander@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the controllers are both attached (or detached), they appear as
0x17ef, 0x6182.  When only one is attached, they appear as
0x17ef, 0x6184.

84 (mixed attachment) is already recognized as a gamepad by Linux.  This
patch adds 82 (both attached/detached).

These controllers have many more buttons than is typical.  With this
patch, here's what's functional when it presents as 82:

Recognized:

- X, Y, A, B
- both analog sticks, including L3/R3
- D-pad
- menu and capture buttons
- rumble

Not yet recognized:

- start, select
- 4 rear paddle buttons (Y1, Y2, Y3, M3)
- gyroscope

(There are also non-functional buttons when reporting as 84 that are
out-of-scope for this patch.)

Signed-off-by: Brenton Simpson <appsforartists@google.com>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f5c21565bb3cec..ecfcea8740a009 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -127,6 +127,7 @@ static const struct xpad_device {
  u8 mapping;
  u8 xtype;
 } xpad_device[] = {
+ { 0x17ef, 0x6182, "Lenovo Legion Go Controller (unified)", 0, XTYPE_XBOX360 },
  { 0x0079, 0x18d4, "GPD Win 2 X-Box Controller", 0, XTYPE_XBOX360 },
  { 0x03eb, 0xff01, "Wooting One (Legacy)", 0, XTYPE_XBOX360 },
  { 0x03eb, 0xff02, "Wooting Two (Legacy)", 0, XTYPE_XBOX360 },
@@ -459,6 +460,7 @@ static const signed short xpad_btn_paddles[] = {

 static const struct usb_device_id xpad_table[] = {
  { USB_INTERFACE_INFO('X', 'B', 0) }, /* Xbox USB-IF not-approved class */
+ XPAD_XBOX360_VENDOR(0x17ef), /* Lenovo */
  XPAD_XBOX360_VENDOR(0x0079), /* GPD Win 2 controller */
  XPAD_XBOX360_VENDOR(0x03eb), /* Wooting Keyboards (Legacy) */
  XPAD_XBOXONE_VENDOR(0x03f0), /* HP HyperX Xbox One controllers */
