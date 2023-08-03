Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E093B76F4E9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 23:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjHCV47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 17:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHCV4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 17:56:54 -0400
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF163C2D;
        Thu,  3 Aug 2023 14:56:51 -0700 (PDT)
Received: from fedori.lan (51b69adf.dsl.pool.telekom.hu [::ffff:81.182.154.223])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000072E2E.0000000064CC1C45.0001D182; Thu, 03 Aug 2023 23:29:41 +0200
From:   =?UTF-8?q?Gerg=C5=91=20K=C3=B6teles?= <soyer@irl.hu>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Gerg=C5=91=20K=C3=B6teles?= <soyer@irl.hu>
Subject: [RFC PATCH 0/2] media: v4l2: map UVC_CT_ROLL_ABSOLUTE_CONTROL
Date:   Thu,  3 Aug 2023 23:28:56 +0200
Message-ID: <cover.1691096157.git.soyer@irl.hu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Logitech Streamcam can be mounted in 'portrait mode' as well.
It reports the current roll (-90, 0, 90, 180) with
UVC_CT_ROLL_ABSOLUTE_CONTROL.

This RFC defines V4L2_CID_ROLL_ABSOLUTE, and maps
UVC_CT_ROLL_ABSOLUTE_CONTROL to make it available to
userspace.
Then, the userspace can rotate the stream based on the roll.

Is it better to use V4L2_CID_CAMERA_SENSOR_ROTATION for this?
The value set matches that control.
If yes, is it worth mapping UVC_CT_ROLL_ABSOLUTE_CONTROL to
V4L2_CID_CAMERA_SENSOR_ROTATION for this camera only?

Any feedback is greately appreciated.


Gergő Köteles (2):
  media: v4l2: ctrls: Add ROLL_ABSOLUTE control
  media: v4l2: map UVC_CT_ROLL_ABSOLUTE_CONTROL

 .../userspace-api/media/v4l/ext-ctrls-camera.rst         | 5 +++++
 drivers/media/usb/uvc/uvc_ctrl.c                         | 9 +++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c                | 1 +
 include/uapi/linux/v4l2-controls.h                       | 2 ++
 4 files changed, 17 insertions(+)


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.41.0

