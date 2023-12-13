Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FA78110EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377582AbjLMMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjLMMU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:20:26 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DB4CD;
        Wed, 13 Dec 2023 04:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702470029;
        bh=tE9lejZ6+1W68lWo5ayV1iSQspAij2+WbiKQT0W05Fw=;
        h=From:To:Cc:Subject:Date:From;
        b=NZZ2v/cscYsHaD0R/dEw+WSkCXywzErHcJdJc98BKZsC9AyjQUiIXCXH+kT9EtKf2
         JLqQdztraaZ4UBcyFSrNdTYlPEG+WdWqSKN7p0QFBLaxW+IuQqHJgAv6Xhj/TdvghA
         S8Ypvalbaty6H0dWCJX/HKGcFFVb/ScVyA/qb0Dn4UQ2QswXXFIkbJ4KD6eHINqlpG
         WiCeTtEv4aJWClR6YOrd45YvULufuWuWld3ZGvRxtRUfFrc+jXo6+rmV3x6XreTe3o
         Dt17CwN3/e551wu7IZppG5pjNIfFNrQXmh8WCSp6gV1rIw0VWTV2FZjzJF1Oyk86jU
         IX6BV4a2UAl9w==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 315F73781478;
        Wed, 13 Dec 2023 12:20:28 +0000 (UTC)
From:   Eugen Hristev <eugen.hristev@collabora.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, kernel@collabora.com,
        eugen.hristev@collabora.com, tiffany.lin@mediatek.com,
        andrew-ct.chen@mediatek.com, matthias.bgg@gmail.com
Subject: [PATCH 1/4] dt-bindings: media: mtk-vcodec-encoder: add dma-ranges
Date:   Wed, 13 Dec 2023 14:20:14 +0200
Message-Id: <20231213122017.102100-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As IOMMUs are supported, dma-ranges is not mentioned but
additionalProperties=false, thus we have an error when adding dma-ranges.
Add dma-ranges as a possible property because this may be present.

Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
index a2051b31fa29..403530de5624 100644
--- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
+++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
@@ -38,6 +38,8 @@ properties:
     minItems: 1
     maxItems: 5
 
+  dma-ranges: true
+
   assigned-clocks: true
 
   assigned-clock-parents: true
-- 
2.34.1

