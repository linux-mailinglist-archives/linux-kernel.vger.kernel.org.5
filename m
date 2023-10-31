Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A717DC770
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbjJaHjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343643AbjJaHju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:39:50 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF736DB;
        Tue, 31 Oct 2023 00:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RyOH+5XohJsIi1BgqWOXofRQQQgrLCw4FAt/fm6z/yk=; b=PGtix28Zf4pAIEsP4nKidFn+f7
        huANLzHOeBDGKkkye39AHonmxcBa0p3WKZ4Y1JXbx8+tbZHTOC6f4WAB4IoamKHiye39bhyRlkw9e
        K0JUM74BPxm7yTs48GG8xbds71OmjUBUWw7jQBrWYQp2deNtknGblZTVrxS8zvIIGcIwBYA1Q2FXE
        kVBIsQPUSNhE5rwFfWaN0uOh3cRfXiahY0T6bgkLNOAitTfhvcQaA58rinWweUsG6FGds6LFrK98y
        9mFAvwij9iuTlU4WCx9jjwsZW/mHHxNjc68jTnxJWFwHS+Gco2U9xFKbxReucCYJpKvTz5PTHI7lM
        6ws7In1w==;
Received: from 251.48.60.213.dynamic.reverse-mundo-r.com ([213.60.48.251] helo=vega.mundo-R.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qxjLW-00FHU5-63; Tue, 31 Oct 2023 08:39:30 +0100
From:   Iago Toral Quiroga <itoral@igalia.com>
To:     dri-devel@lists.freedesktop.org, Maira Canal <mcanal@igalia.com>
Cc:     Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        Iago Toral Quiroga <itoral@igalia.com>
Subject: [PATCH v3 3/4] dt-bindings: gpu: v3d: Add BCM2712's compatible
Date:   Tue, 31 Oct 2023 08:38:58 +0100
Message-Id: <20231031073859.25298-4-itoral@igalia.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031073859.25298-1-itoral@igalia.com>
References: <20231031073859.25298-1-itoral@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM2712, Raspberry Pi 5's SoC, contains a V3D core. So add its specific
compatible to the bindings.

Signed-off-by: Iago Toral Quiroga <itoral@igalia.com>
Reviewed-by: Maíra Canal <mcanal@igalia.com>
---
 Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml b/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
index dae55b8a267b..dc078ceeca9a 100644
--- a/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
+++ b/Documentation/devicetree/bindings/gpu/brcm,bcm-v3d.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - brcm,2711-v3d
+      - brcm,2712-v3d
       - brcm,7268-v3d
       - brcm,7278-v3d
 
-- 
2.39.2

