Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5775176C4BE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjHBFRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjHBFRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:17:47 -0400
Received: from qproxy4-pub.mail.unifiedlayer.com (qproxy4-pub.mail.unifiedlayer.com [66.147.248.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B0D273A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 22:17:34 -0700 (PDT)
Received: from outbound-ss-761.bluehost.com (outbound-ss-761.bluehost.com [74.220.211.250])
        by qproxy4.mail.unifiedlayer.com (Postfix) with ESMTP id 74DF48033504
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:17:33 +0000 (UTC)
Received: from cmgw14.mail.unifiedlayer.com (unknown [10.0.90.129])
        by progateway8.mail.pro1.eigbox.com (Postfix) with ESMTP id EF18B10049593
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:17:32 +0000 (UTC)
Received: from just2025.justhost.com ([173.254.28.237])
        by cmsmtp with ESMTP
        id R4Emq7n9gYDyaR4EmqFEqi; Wed, 02 Aug 2023 05:17:32 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=cZwXElPM c=1 sm=1 tr=0 ts=64c9e6ec
 a=Jt2RHIFfQig1ELqEZVeWfA==:117 a=Jt2RHIFfQig1ELqEZVeWfA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=UttIx32zK-AA:10:nop_rcvd_month_year
 a=5SfhNeb3QxAA:10:endurance_base64_authed_username_1 a=DgXrqYuCAAAA:8
 a=eSCCvEbRnsAFwu8X_C0A:9 a=NFkmT8Fa3oR8cXbSjPxL:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=singleboardsolutions.com; s=default; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6GLBXSnMCa64ncjUK715f/djLaOjkGdOOQ837Kd10UQ=; b=ZK9hCv+DZp+G++t/37AXvdgCN1
        1GkZ6tzydrAaugzJD5mZvco88ag++Bdbw0C/KEh+i8Z6lI4xFtMNFlS43qGRfcldaEOHBnUuDumfI
        VBPwalhU8kO8Z7o7o6hdiLHwMWs2hEtU0IA0+LsvuA/erkfoaahhbq490qRqLQHB3rjJWArlXYCD7
        kw732GGGo23YhAiIXvMTrlSdGnS7NScSPnqzhtVnpgp+GO2EuGdXMHY/UHzsr6j3yL5o4rbcLzO8g
        fripNeSykmKSK5ecSysfJVI4Pgi883BGKBodQPqqkW9v+rfRpCjgfWi9AClLRgXU9fwp8QGpAu4lW
        hWMik41g==;
Received: from 097-084-242-070.res.spectrum.com ([97.84.242.70]:50744 helo=localhost.localdomain)
        by just2025.justhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <tmckahan@singleboardsolutions.com>)
        id 1qR4Em-001wRt-16;
        Tue, 01 Aug 2023 23:17:32 -0600
From:   Thomas McKahan <tmckahan@singleboardsolutions.com>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Thomas McKahan <tmckahan@singleboardsolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: rockchip: Add NanoPC T6
Date:   Wed,  2 Aug 2023 01:14:06 -0400
Message-Id: <20230802051441.3106-2-tmckahan@singleboardsolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802051441.3106-1-tmckahan@singleboardsolutions.com>
References: <20230802051441.3106-1-tmckahan@singleboardsolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - just2025.justhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - singleboardsolutions.com
X-BWhitelist: no
X-Source-IP: 97.84.242.70
X-Source-L: No
X-Exim-ID: 1qR4Em-001wRt-16
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 097-084-242-070.res.spectrum.com (localhost.localdomain) [97.84.242.70]:50744
X-Source-Auth: tmckahan@singleboardsolutions.com
X-Email-Count: 9
X-Source-Cap: ZWxlY3RyaTk7ZWxlY3RyaTk7anVzdDIwMjUuanVzdGhvc3QuY29t
X-Local-Domain: yes
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the NanoPC T6, a single board computer from FriendlyElec

Signed-off-by: Thomas McKahan <tmckahan@singleboardsolutions.com>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 115ca986e20f..ca5389862887 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -227,6 +227,11 @@ properties:
               - friendlyarm,nanopi-r5s
           - const: rockchip,rk3568
 
+      - description: FriendlyElec NanoPC T6
+        items:
+          - const: friendlyarm,nanopc-t6
+          - const: rockchip,rk3588
+
       - description: GeekBuying GeekBox
         items:
           - const: geekbuying,geekbox
-- 
2.34.1

