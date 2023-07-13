Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583587516AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjGMDRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGMDRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:17:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE5B10FC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 20:17:32 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1ftL1lm5zBKy7r
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:17:30 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689218250; x=1691810251; bh=vy2hpwLqIbN4V8wU9/R2s/5gk++
        9S9+eXX9ZvB2DiBg=; b=NcdAuoR974e/19vTeBX57gNMOJW+huU5uXZ4cj40BRa
        ZSyFIDs6VOmtOZmQgt9AQSt4+nsLNLTcLrJvPDpQfenPw5dIXC3kHJXnV7SE5RQP
        svAYc3Cq2wLHebpEjC23Aq8WLHqwc6TkZKXbdXpjCvye3rMjk5qviwjb1Z+Py/co
        YGuCAj9JsGBG+p6uog8zalWmA3icbCmEVD8guOQ/k2SMteYFnhkPijXiWIE0/nhK
        iWSJIYdLBw9VN0+Ei/oBlJVyZwBhC/Y2aMqDNNcr4zkjZfgYYsBROryowrF36aMU
        OO+kIpoAXSvrOVXN9Ae5r1xNCUxwESyTyI/LzaFivFg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WkKBBZ4LsJFZ for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 11:17:30 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1ftK6NTSzBHXgq;
        Thu, 13 Jul 2023 11:17:29 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 11:17:29 +0800
From:   liubin001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: "foo* const bar" should be "foo * const bar"\
 that ope- n brace { should be on the previous line
In-Reply-To: <tencent_4F166AB6DC9C757B0454E3F4875027411F08@qq.com>
References: <tencent_4F166AB6DC9C757B0454E3F4875027411F08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <7d2a5aba980cd6b7928c15e65fd94086@208suo.com>
X-Sender: liubin001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(1)The standard format for declaring a pointer is to add a space bet-
ween the type name and the * symbol, as well as between the * symbol and 
the variable name.
(2) that open brace { should be on the previous line
Signed-off-by: 	Bin Liu <liubin001@208suo.com>
---
  drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c 
b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 96504a320c2a..b56936f95d31 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -87,7 +87,7 @@ struct rpc_channel {

  #if IS_ENABLED(CONFIG_DRM_VMWGFX_MKSSTATS)
  /* Kernel mksGuestStats counter names and desciptions; same order as 
enum mksstat_kern_stats_t */
-static const char* const mksstat_kern_name_desc[MKSSTAT_KERN_COUNT][2] 
=
{
         { "vmw_execbuf_ioctl", "vmw_execbuf_ioctl" },
         { "vmw_cotable_resize", "vmw_cotable_resize" },
};

+static const char * const mksstat_kern_name_desc[MKSSTAT_KERN_COUNT][2] 
= {
      { "vmw_execbuf_ioctl", "vmw_execbuf_ioctl" },
      { "vmw_cotable_resize", "vmw_cotable_resize" },
  };
