Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA6B775BDE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbjHILVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjHILVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:21:39 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1761BFA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 04:21:39 -0700 (PDT)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
        by cmsmtp with ESMTP
        id TV3cqyw9NEoVsThFzqxIAZ; Wed, 09 Aug 2023 11:21:39 +0000
Received: from just2025.justhost.com ([173.254.28.237])
        by cmsmtp with ESMTPS
        id ThFyqelf3sstSThFzqGCrB; Wed, 09 Aug 2023 11:21:39 +0000
X-Authority-Analysis: v=2.4 cv=FYIkeby6 c=1 sm=1 tr=0 ts=64d376c3
 a=Jt2RHIFfQig1ELqEZVeWfA==:117 a=Jt2RHIFfQig1ELqEZVeWfA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=UttIx32zK-AA:10 a=5SfhNeb3QxAA:10
 a=DgXrqYuCAAAA:8 a=XYAwZIGsAAAA:8 a=eSCCvEbRnsAFwu8X_C0A:9
 a=NFkmT8Fa3oR8cXbSjPxL:22 a=E8ToXWR_bxluHZ7gmE-Z:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=singleboardsolutions.com; s=default; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xVtv0AdgaSpLzUC+dN3EE5AGQnYPgea8VSjA9nT2SfY=; b=JboYb1havfS9SOb9nvMkGsbxT4
        ekSpqMhEQDlt85lk/ljLX9yPVOXzZLS6XomWa5Y8vhXyUmFvWP72Imazy9n4g+MCvBEodLzqrRzoc
        auTYyHH7oM0lHaChM7abUcMsZFZr5SXcpxfzKyADCZPZdMq+RFH+sc7ciYKL21Gqmhxz4TSYOrPdu
        nWyYwM+5N7dsMgspAr/YESATGvA12sB9/GqbGeU70E18vBV1yPD6Z4mQLbnsWSRGwNZzafxQeu8G2
        0c2zQgKsSpUdCD6LGimavgkb0cjK2u0t/z+M/2SIFx1UgxKpEY/11t7WfYI+2BQ+ArP5tZEeLoU6q
        Fvnf5mNQ==;
Received: from 097-084-242-070.res.spectrum.com ([97.84.242.70]:62810 helo=localhost.localdomain)
        by just2025.justhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <tmckahan@singleboardsolutions.com>)
        id 1qThFx-003Jjq-2q;
        Wed, 09 Aug 2023 05:21:37 -0600
From:   Thomas McKahan <tmckahan@singleboardsolutions.com>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Thomas McKahan <tmckahan@singleboardsolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [RESEND PATCH v2 1/2] dt-bindings: arm: rockchip: Add NanoPC T6
Date:   Wed,  9 Aug 2023 07:21:16 -0400
Message-Id: <20230809112120.99-2-tmckahan@singleboardsolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809112120.99-1-tmckahan@singleboardsolutions.com>
References: <20230809112120.99-1-tmckahan@singleboardsolutions.com>
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
X-Exim-ID: 1qThFx-003Jjq-2q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 097-084-242-070.res.spectrum.com (localhost.localdomain) [97.84.242.70]:62810
X-Source-Auth: tmckahan@singleboardsolutions.com
X-Email-Count: 10
X-Org:  HG=bhshared_jh;ORG=bluehost;
X-Source-Cap: ZWxlY3RyaTk7ZWxlY3RyaTk7anVzdDIwMjUuanVzdGhvc3QuY29t
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIMy97RlBp9HLNsMCEnTPTYHb9ZpOnHQkeJqb8oXOUsoOitz/Hoe3lj7oXMUv7+QAYw36N1NergjWjLEmyZZJRFA3Iv+jyHkqdx5vIOB+Se3Z5QFSXVM
 UzwCtKsjCnL0Ivs4gToiPJiQkSqRMi/sTdBiCyIo8e6hlNDKwe3N3idqM17DHTWan4YScW7UR17OYKDeqG04waezf8lEom7vkQhAOIIu/WrbT5+nEBGkh5c4
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the NanoPC T6, a single board computer from FriendlyElec

Signed-off-by: Thomas McKahan <tmckahan@singleboardsolutions.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

