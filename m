Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3031A7531B3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbjGNGEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbjGNGEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:04:20 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96687271F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:04:19 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2LXG3d6GzBR9tM
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:04:14 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689314654; x=1691906655; bh=ezthta+WZ36eYrWV9Zb+A2N7VbH
        gwUOqc/NALhwnFGo=; b=eTtIg3AT72wukEEUEmZQSOsx+up3ItDoggfAIb3yyM4
        Fdl8UPMTwtMiMAm56tEAbkEkZCiN6MmPTmrwH/kNBZJ/ikNZvCeFawbsrFkvVdOJ
        oGKfl/3JxmMI2XZcCiFtX7LRdaIJP6Koic95sIled4YTrC7/2hzzRBCAC4Tn16mv
        Dm75ZwI5Olm4j7f3Smx8Mbg1SgMFLx+k3094V42YGK6QgblZJFyh5dKlHnOfV8aC
        iY+OEz81pFW4ukB8TVN0n6umpdv2GQ4qTYnKjqLNtL61iUMbDtyUxpvQSsnYEPDF
        SGOjkFXqGiUo0eijxglHPLdOPXBTLHt7+xCAs6FEezQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iApVlYYNNFxh for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 14:04:14 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2LXF6blyzBR9t9;
        Fri, 14 Jul 2023 14:04:13 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 14:04:13 +0800
From:   sunran001@208suo.com
To:     airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd: open brace '{' following struct go on the same line
In-Reply-To: <20230714060105.13377-1-xujianghui@cdjrlc.com>
References: <20230714060105.13377-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <e565a40b4ae73352204fbf49e55de452@208suo.com>
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
  drivers/gpu/drm/amd/include/yellow_carp_offset.h | 6 ++----
  1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/yellow_carp_offset.h 
b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
index 0fea6a746611..a2c8dca2425e 100644
--- a/drivers/gpu/drm/amd/include/yellow_carp_offset.h
+++ b/drivers/gpu/drm/amd/include/yellow_carp_offset.h
@@ -7,13 +7,11 @@
  #define MAX_SEGMENT                                         6

-struct IP_BASE_INSTANCE
-{
+struct IP_BASE_INSTANCE {
      unsigned int segment[MAX_SEGMENT];
  } __maybe_unused;

-struct IP_BASE
-{
+struct IP_BASE {
      struct IP_BASE_INSTANCE instance[MAX_INSTANCE];
  } __maybe_unused;
