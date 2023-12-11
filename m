Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4AC80D478
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbjLKRut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344788AbjLKRui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:50:38 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BB7DB;
        Mon, 11 Dec 2023 09:50:44 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c9fdf53abcso46204941fa.1;
        Mon, 11 Dec 2023 09:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317042; x=1702921842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXgQ3cwlEauWhm4w/5MumIv9AzGW6cuxTgfbxgjY3dg=;
        b=dE+UAmF9KCD6sbThbCQTB4zPW5Eed66WfNKDEG9UdwvFLxPA6Y6VT0LlIc+f6U3+cz
         7pwJM4bkz65OT6Ib9dLq0jbqhfk7xmKG8qluErTIuGg0vYPNpyO+0XDhkZoKmmv5ihPS
         cYODRa0/B8eorFkIThoBYEYfM8p91wAgPJiOsSdOcf9KceeuzO+5QMyh5zztR5DEyk6O
         58Cb1SZHg2JLKkvRAZxlPYZBjQiJji3M+CyD83MARCCL12GL3NT2BISNgEvdtsIy9p8t
         z17yrve5ztGP2dUmVYgGhkLP+9cqDSwFBGussG17TNSx4RrAYv7lzrCbRupChvJK7BMy
         Pp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317042; x=1702921842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXgQ3cwlEauWhm4w/5MumIv9AzGW6cuxTgfbxgjY3dg=;
        b=lOVN8nkG6qVmpAsenihTfomZ9gdAFV65pcF4uIGbkT3sfsNQsqpr9SfKrdkVwUyxKX
         Anj5jUAhoJq6A7KDLS7iU+208jVeHYY2/c6cHzA0WCI+AEjzHt/JVmamhLccmAGCcdUo
         W/MYovls6kyko2/TgtXNLyo0r6HuWyvari7x2mcEedl2Qa07QF/zNYD+NJQhBPcLthe/
         Uyy9GiEMXFYzuYMFBEDkUL5d6JsjajwKf6yKCJsouA8GtxlAMbBmn33UYmikL2WRSltd
         DYVT1R1VJGQfL6pshini5ZOMJec5RqsoO3dJ3GsQL3l5WCbv6KngSJCjSNUOPnbwYqck
         jPpA==
X-Gm-Message-State: AOJu0Yxze40hwmp2Dlx77HtthHsgawYj/K5XvWzMHDSjlFCVMFVVZ9F1
        ZNX7ejBhHRIs6SoND28bnfmO5k3fQoBgAeUS
X-Google-Smtp-Source: AGHT+IEauNyodeTccBOVRJVKyjKv+RkLy8Cs/5HB00BieRqqHIwCWxKKvgs/7iA1S0pIP982Lh/J1Q==
X-Received: by 2002:a2e:a544:0:b0:2c9:f643:d6d7 with SMTP id e4-20020a2ea544000000b002c9f643d6d7mr3851894ljn.8.1702317041605;
        Mon, 11 Dec 2023 09:50:41 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id ce11-20020a2eab0b000000b002cb28360049sm1039631ljb.96.2023.12.11.09.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:50:41 -0800 (PST)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH 00/19] Omnivision OV4689 refactoring and improvements
Date:   Mon, 11 Dec 2023 20:50:03 +0300
Message-ID: <20231211175023.1680247-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series contains refactoring and new features implementation for
the Omnivision OV4689 sensor driver. Specifically, patches 1, 2, 4, 5,
6, 9, 14, 15, 17, and 18 are refactorings, and are not supposed to
introduce any functional change. Patches 3 and 7 perform migration to
CCI helpers and subdevice active state respectively, and should not
introduce any hardware- and/or user-visible change either.

Patches 10-13 expose more sensor controls to the userspace, such as
(read-write) HBLANK, VFLIP/HFLIP, digital gain, and color
balance. Patch 16 implements configurable analogue crop rectangle via
.set_selection callback. And finally, patch 19 enables 2x2 binning
option. It should be noted that publicly available sensor
documentation is lacking description of many registers and their value
ranges, so a lot of values had to be found by experimentation.

Any comments and reviews are welcome!

Mikhail Rudenko (19):
  media: i2c: ov4689: Clean up and annotate the register table
  media: i2c: ov4689: Fix typo in a comment
  media: i2c: ov4689: CCI conversion
  media: i2c: ov4689: Remove i2c_client from ov4689 struct
  media: i2c: ov4689: Refactor ov4689_set_ctrl
  media: i2c: ov4689: Set gain in one 16 bit write
  media: i2c: ov4689: Use sub-device active state
  media: i2c: ov4689: Enable runtime PM before registering sub-device
  media: i2c: ov4689: Remove max_fps field from struct ov4689_mode
  media: i2c: ov4689: Make horizontal blanking configurable
  media: i2c: ov4689: Implement vflip/hflip controls
  media: i2c: ov4689: Implement digital gain control
  media: i2c: ov4689: Implement manual color balance controls
  media: i2c: ov4689: Move pixel array size out of struct ov4689_mode
  media: i2c: ov4689: Set timing registers programmatically
  media: i2c: ov4689: Configurable analogue crop
  media: i2c: ov4689: Eliminate struct ov4689_mode
  media: i2c: ov4689: Refactor ov4689_s_stream
  media: i2c: ov4689: Implement 2x2 binning

 drivers/media/i2c/Kconfig  |   1 +
 drivers/media/i2c/ov4689.c | 951 ++++++++++++++++++++++---------------
 2 files changed, 579 insertions(+), 373 deletions(-)

--
2.43.0
