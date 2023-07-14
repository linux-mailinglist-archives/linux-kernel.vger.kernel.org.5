Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7A57531E1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235151AbjGNGX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjGNGXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:23:55 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3792D57
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:23:52 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2Lys3sVnzBR9sN
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:23:49 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689315829; x=1691907830; bh=22hHmkRO9TkU+Wjx8NhVjpSomcy
        bO0NSKa3A1lNZF14=; b=n91HPB3XgnslP02udG3Do0NmQKoiitEAyz4nKJ+gWEc
        9yxvXvjrwUw8izpYXSjoT0hBxURswf+JCngR2vfAbqyKOn1xcT9TG67UyDhrLgSS
        SovEydUEdgWBQOZfwjz2ycFMaBFAeL8ms4WdHIYVbShoKut4pQboaynhSzqJ8nqY
        YfL3QG7Zxptqe247DOh3KjOdaJUkWk2mALqoV7u7cSTInDYT70jl5K9NsE7532Mw
        Octolhxtvm+p/7BXPpegZgMSXaFsoyR9e4f4A+YidNQa9t5Ipds4s0GlHKJgHf2l
        GcyRpTLZs10tpoaFuJJimqIK0GMyxopgUfbi/xAXvpg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id p7x_Q7Xa17rw for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 14:23:49 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2Lys1d27zBJFS7;
        Fri, 14 Jul 2023 14:23:49 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 14:23:49 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd: open brace '{' following struct go on the same line
In-Reply-To: <20230714062152.13738-1-xujianghui@cdjrlc.com>
References: <20230714062152.13738-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <41b04a00f926becfd2ca9cd4c5406074@208suo.com>
X-Sender: sunran001@208suo.com
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

Fix the checkpatch error as open brace '{' following struct should
go on the same line.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/include/atomfirmwareid.h | 6 ++----
  1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/atomfirmwareid.h 
b/drivers/gpu/drm/amd/include/atomfirmwareid.h
index e6256efd03ae..1ca5fe7b131b 100644
--- a/drivers/gpu/drm/amd/include/atomfirmwareid.h
+++ b/drivers/gpu/drm/amd/include/atomfirmwareid.h
@@ -28,8 +28,7 @@
  #ifndef _ATOMFIRMWAREID_H_
  #define _ATOMFIRMWAREID_H_

-enum atom_master_data_table_id
-{
+enum atom_master_data_table_id {
      VBIOS_DATA_TBL_ID__UTILITY_PIPELINE,
      VBIOS_DATA_TBL_ID__MULTIMEDIA_INF,
      VBIOS_DATA_TBL_ID__FIRMWARE_INF,
@@ -51,8 +50,7 @@ enum atom_master_data_table_id
      VBIOS_DATA_TBL_ID__UNDEFINED,
  };

-enum atom_master_command_table_id
-{
+enum atom_master_command_table_id {
      VBIOS_CMD_TBL_ID__ASIC_INIT,
      VBIOS_CMD_TBL_ID__DIGX_ENCODER_CONTROL,
      VBIOS_CMD_TBL_ID__SET_ENGINE_CLOCK,
