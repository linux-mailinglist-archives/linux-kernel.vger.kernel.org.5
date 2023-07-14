Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EC97530CD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbjGNE7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjGNE7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:59:45 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C7D2D40
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:59:44 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2K5p048GzBR9sh
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 12:59:41 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689310781; x=1691902782; bh=kKU3uyB6okQSTGQqzBMPumiXiBT
        wf7W7pXC7rR7eRcU=; b=jTKq5bHrxgGenSCsBcUePEu8ahT3UeW4zbqUl/8BFrR
        ABqV3UYTd3Ya+6mPCaHL2s4BtxKzAMRtH1mO+76gS+BiQwueJ0qOmtH6vwmNeI7P
        H+tGgLIU2OBqBscEqgKmV2NaYFgsYIdIvBq9fSthQqgcxGK/LXZZStOeT6fPdLrY
        AoebTuu3vgMy/4G78apxMSJcWx381frcOO4fr2/2kkanIy4J8PKmEZqf5nHNdIJh
        /EJUQrMYU6uu/LkNUDuK+CCogfCPEAzFaUAKiYXdHRqUcHDXmcAz5XYs60+qngGJ
        C/VsMxALuxklw59BRABj6Z7FhrAmiaoEAWl0Eeprwmw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nD-FhRwFMdWd for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 12:59:41 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2K5n3m0JzBHXhS;
        Fri, 14 Jul 2023 12:59:41 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 12:59:41 +0800
From:   shijie001@208suo.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon/dpm: ERROR: open brace '{' following enum go on
 the same line
In-Reply-To: <tencent_FDFE1B9D84BD3C51CAE7FADFDCF6613D5D0A@qq.com>
References: <tencent_FDFE1B9D84BD3C51CAE7FADFDCF6613D5D0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <21b12c2d37bff73a0c625b6af9d95021@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix four occurrences of the checkpatch.pl error:
ERROR: open brace '{' following enum go on the same line

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/ni_dpm.h | 12 ++++--------
  1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni_dpm.h 
b/drivers/gpu/drm/radeon/ni_dpm.h
index 74e301936906..4e3e7303e035 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.h
+++ b/drivers/gpu/drm/radeon/ni_dpm.h
@@ -59,8 +59,7 @@ struct ni_mc_reg_table {

  #define NISLANDS_MCREGISTERTABLE_FIRST_DRIVERSTATE_SLOT 2

-enum ni_dc_cac_level
-{
+enum ni_dc_cac_level {
      NISLANDS_DCCAC_LEVEL_0 = 0,
      NISLANDS_DCCAC_LEVEL_1,
      NISLANDS_DCCAC_LEVEL_2,
@@ -72,8 +71,7 @@ enum ni_dc_cac_level
      NISLANDS_DCCAC_MAX_LEVELS
  };

-struct ni_leakage_coeffients
-{
+struct ni_leakage_coeffients {
      u32 at;
      u32 bt;
      u32 av;
@@ -83,8 +81,7 @@ struct ni_leakage_coeffients
      u32 t_ref;
  };

-struct ni_cac_data
-{
+struct ni_cac_data {
      struct ni_leakage_coeffients leakage_coefficients;
      u32 i_leakage;
      s32 leakage_minimum_temperature;
@@ -100,8 +97,7 @@ struct ni_cac_data
      u8 lts_truncate_n;
  };

-struct ni_cac_weights
-{
+struct ni_cac_weights {
      u32 weight_tcp_sig0;
      u32 weight_tcp_sig1;
      u32 weight_ta_sig;
