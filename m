Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E67534A5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbjGNIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjGNIIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:08:42 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B933C02
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:06:21 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2PF602H7zBR9sm
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 16:06:17 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689321977; x=1691913978; bh=dzkqdXBCjh2/hP0nLSBmNUO8a0p
        M8KMO6JR7JU7+9WA=; b=pAFYueIN9JkTRCC7sXygcbgO1RcfVrRLw0yT+gN63Fw
        zXbzpXYwPSZel728WkxaRV8BQ4qkNFD9hD6BKDHgGdnk/WEwdTGg/svCLQCZGyQA
        0h8mlJTq6jDJeCg/8wR9IvseARV5esDIZS9gixdLPTk5BjX6pz/10G1QXx889ize
        jo+zAYD82LvbJyc5ZW45Ex5C9i+zhfhV8XZVpzRiL/wfrflddQHBD9h/eo2q8CgS
        yqsYZeLN+KCZG/kgO2BNL/Vlg0xuQ4FgfV0R2rqYDkVarAQmbJB6Ev3NCPrz5aWV
        DrsrXAHwQqG0crA2sfHJgacxJBm+nKn1bIKgIsbQkcg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VNLDK-LFSLHF for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 16:06:17 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2PF53MTwzBR9sg;
        Fri, 14 Jul 2023 16:06:17 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 16:06:17 +0800
From:   shijie001@208suo.com
To:     alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: ERROR: "foo* bar" should be "foo *bar"
In-Reply-To: <tencent_09B72958FF97A0465961F04F38F298FE6E08@qq.com>
References: <tencent_09B72958FF97A0465961F04F38F298FE6E08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <22e66975eb7b90c1e10527cc6dd76e99@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix five occurrences of the checkpatch.pl error:
ERROR: "foo* bar" should be "foo *bar"
ERROR: that open brace { should be on the previous line

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/radeon_audio.c | 11 +++++------
  1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_audio.c 
b/drivers/gpu/drm/radeon/radeon_audio.c
index d6ccaf24ee0c..a010bc2c155c 100644
--- a/drivers/gpu/drm/radeon/radeon_audio.c
+++ b/drivers/gpu/drm/radeon/radeon_audio.c
@@ -35,15 +35,14 @@

  void dce6_audio_enable(struct radeon_device *rdev, struct 
r600_audio_pin *pin,
          u8 enable_mask);
-struct r600_audio_pin* r600_audio_get_pin(struct radeon_device *rdev);
-struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
+struct r600_audio_pin *r600_audio_get_pin(struct radeon_device *rdev);
+struct r600_audio_pin *dce6_audio_get_pin(struct radeon_device *rdev);
  static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
      struct drm_display_mode *mode);
  static void radeon_audio_dp_mode_set(struct drm_encoder *encoder,
      struct drm_display_mode *mode);

-static const u32 pin_offsets[7] =
-{
+static const u32 pin_offsets[7] = {
      (0x5e00 - 0x5e00),
      (0x5e18 - 0x5e00),
      (0x5e30 - 0x5e00),
@@ -359,7 +358,7 @@ static void radeon_audio_write_latency_fields(struct 
drm_encoder *encoder,
          radeon_encoder->audio->write_latency_fields(encoder, connector, 
mode);
  }

-struct r600_audio_pin* radeon_audio_get_pin(struct drm_encoder 
*encoder)
+struct r600_audio_pin *radeon_audio_get_pin(struct drm_encoder 
*encoder)
  {
      struct radeon_device *rdev = encoder->dev->dev_private;
      struct radeon_encoder *radeon_encoder = to_radeon_encoder(encoder);
@@ -526,7 +525,7 @@ static void radeon_audio_calc_cts(unsigned int 
clock, int *CTS, int *N, int freq
          *N, *CTS, freq);
  }

-static const struct radeon_hdmi_acr* radeon_audio_acr(unsigned int 
clock)
+static const struct radeon_hdmi_acr *radeon_audio_acr(unsigned int 
clock)
  {
      static struct radeon_hdmi_acr res;
      u8 i;
