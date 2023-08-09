Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFB577524E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 07:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjHIFoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 01:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjHIFoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 01:44:02 -0400
X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 22:43:59 PDT
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8691BE5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 22:43:59 -0700 (PDT)
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
        by cmsmtp with ESMTP
        id TQY0qMOEabK1VTbxkqPBrp; Wed, 09 Aug 2023 05:42:28 +0000
Received: from just2025.justhost.com ([173.254.28.237])
        by cmsmtp with ESMTPS
        id TbxjqbDxX5XxGTbxjqzOyC; Wed, 09 Aug 2023 05:42:28 +0000
X-Authority-Analysis: v=2.4 cv=U8OBsMnu c=1 sm=1 tr=0 ts=64d32744
 a=Jt2RHIFfQig1ELqEZVeWfA==:117 a=Jt2RHIFfQig1ELqEZVeWfA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=UttIx32zK-AA:10 a=5SfhNeb3QxAA:10 a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8
 a=DgXrqYuCAAAA:8 a=LN1DEILRDWMThqYPT54A:9 a=AjGcO6oz07-iQ99wixmX:22
 a=AbAUZ8qAyYyZVLSsDulk:22 a=NFkmT8Fa3oR8cXbSjPxL:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=singleboardsolutions.com; s=default; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IRedR4a0UlTeO6ZLpW4sOxZ1W5NZ59F4Kr/32UOhOHI=; b=Fb+cNBMESaV3YERu24pAVhOYrS
        yp+fmY1ZbPXQR6GjDOREBMv9ESiwIonrw7EPEoLtz+RGksXJMGliW0nQJjE5oKQ5zGgswNY5DZqNB
        OErLhrdUGlA2AkGp8VdO1hwsDHYyLcZmrvA3V3Ug77CS+CEIveOG+c9B272FShakyuX3Y5IK0g6gd
        iQonanpixIP7EHMyTLfO1Bvt9/n8eVbcIeTD429+F3jAx7uTI/BAMnJUP5f8PW3X+j/Tgyo3J32W2
        DI3l9vMDLHA8g/+XG6Tq+L6II8O7s2CKVruUSu8p7ye+3vvTWP0Dn1Km2QeBqrKBkADbDFTCK4XGK
        lw0ji2nw==;
Received: from 097-084-242-070.res.spectrum.com ([97.84.242.70]:52104 helo=localhost.localdomain)
        by just2025.justhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <tmckahan@singleboardsolutions.com>)
        id 1qTbxi-003yPQ-2S;
        Tue, 08 Aug 2023 23:42:26 -0600
From:   Thomas McKahan <tmckahan@singleboardsolutions.com>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Thomas McKahan <tmckahan@singleboardsolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add Support for the FriendlyElec NanoPC T6
Date:   Wed,  9 Aug 2023 01:42:08 -0400
Message-Id: <20230809054213.27447-1-tmckahan@singleboardsolutions.com>
X-Mailer: git-send-email 2.34.1
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
X-Exim-ID: 1qTbxi-003yPQ-2S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 097-084-242-070.res.spectrum.com (localhost.localdomain) [97.84.242.70]:52104
X-Source-Auth: tmckahan@singleboardsolutions.com
X-Email-Count: 1
X-Org:  HG=bhshared_jh;ORG=bluehost;
X-Source-Cap: ZWxlY3RyaTk7ZWxlY3RyaTk7anVzdDIwMjUuanVzdGhvc3QuY29t
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAwqdBzMfFRUiFo6P0yB88iNGc7iXVDfp0swKFP6nloHnsyIBj37t7/zDpRAzbzm/a8lDC7gk9+TKPj698k7s3kls8yiaFkN6rNT8BTWevqjWD6nhmdC
 sK8WgW2tcxnjiF+w8aiE9kVHtX+q/Eu60/M7FSq1YSBCf+iXoaGp3po+oOiQzta8TZa6klWGnuu/3vC5EeMSlyJ2KE+o9eJ0pwUIhjLyzepDP8fl0KBfqKd8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This adds support for the RK3588-based NanoPC T6 single board computer.
Note this series is dependent on the PCIe 3 support [0] being
upstreamed. The NanoPC T6 uses PCIe3x4 like the Rock 5B and EVB1.

[0] https://lore.kernel.org/all/20230717173512.65169-1-sebastian.reichel@collabora.com/

v2:
 - remove unnecessary "okay" status from sound 
 - add '-regulator' suffix on 2 regulators that were missing them
 - use generic node name for rtc
 - remove extra lines
 - fix alignment in I2S entry
 
v1: https://lore.kernel.org/all/20230802051441.3106-1-tmckahan@singleboardsolutions.com/

Thomas McKahan (2):
  dt-bindings: arm: rockchip: Add NanoPC T6
  arm64: dts: rockchip: Add NanoPC T6

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-nanopc-t6.dts    | 842 ++++++++++++++++++
 3 files changed, 848 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts

-- 
2.34.1

