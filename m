Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F37C76C4BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbjHBFRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjHBFR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:17:28 -0400
Received: from qproxy5-pub.mail.unifiedlayer.com (qproxy5-pub.mail.unifiedlayer.com [69.89.21.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069AC1BFA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 22:17:27 -0700 (PDT)
Received: from progateway7-pub.mail.pro1.eigbox.com (gproxy5-pub.mail.unifiedlayer.com [67.222.38.55])
        by qproxy5.mail.unifiedlayer.com (Postfix) with ESMTP id C744E8033926
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:17:26 +0000 (UTC)
Received: from cmgw13.mail.unifiedlayer.com (unknown [10.0.90.128])
        by progateway7.mail.pro1.eigbox.com (Postfix) with ESMTP id 00591100471AC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:17:25 +0000 (UTC)
Received: from just2025.justhost.com ([173.254.28.237])
        by cmsmtp with ESMTP
        id R4EfqS7TjsBigR4Efqlz1d; Wed, 02 Aug 2023 05:17:25 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=Ub+U9IeN c=1 sm=1 tr=0 ts=64c9e6e5
 a=Jt2RHIFfQig1ELqEZVeWfA==:117 a=Jt2RHIFfQig1ELqEZVeWfA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=UttIx32zK-AA:10:nop_rcvd_month_year
 a=5SfhNeb3QxAA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=QX4gbG5DAAAA:8 a=LN1DEILRDWMThqYPT54A:9 a=AjGcO6oz07-iQ99wixmX:22
 a=AbAUZ8qAyYyZVLSsDulk:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=singleboardsolutions.com; s=default; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U4DX76mWHOowxF0p7uqV/JAT6U60P2EhAMKmm+yitJg=; b=AWyBuuweNOXZ6PJgptK61CXA/Q
        sH1s9ybshAIiOcMhYHVSEJa1f/HMmkL3hiNg+eCvUQz9DsgQefYD/qpkLlEThd/yGJPUPX1Pi6/0P
        FQ6J4lsJJ6K0IMFe21xeAxkpt2O9j9DC7qbU8ROcT2f7LmRUB9y7/Q9SahexrN3xop3PGQ7KHwiAV
        55k+WUMm2MzCqa0UrcwQ0UeAJi7Ub1m1TM+qD3vnbrBRfLdmygYbQ2JXS/zPN435M5+bZ//7gnM6R
        wo2UK+oJjClXOMxHxmWcQIQGh++1GUp3z91hwqo0rwOgmHD/qVW2/TV792SMjw+x30IYNjmLQ7VhR
        FsTYihgQ==;
Received: from 097-084-242-070.res.spectrum.com ([97.84.242.70]:50744 helo=localhost.localdomain)
        by just2025.justhost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <tmckahan@singleboardsolutions.com>)
        id 1qR4Ef-001wRt-0c;
        Tue, 01 Aug 2023 23:17:25 -0600
From:   Thomas McKahan <tmckahan@singleboardsolutions.com>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Heiko Stuebner" <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Thomas McKahan <tmckahan@singleboardsolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Add Support for the FriendlyElec NanoPC T6
Date:   Wed,  2 Aug 2023 01:14:05 -0400
Message-Id: <20230802051441.3106-1-tmckahan@singleboardsolutions.com>
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
X-Exim-ID: 1qR4Ef-001wRt-0c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 097-084-242-070.res.spectrum.com (localhost.localdomain) [97.84.242.70]:50744
X-Source-Auth: tmckahan@singleboardsolutions.com
X-Email-Count: 1
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

Hello,

This adds support for the RK3588-based NanoPC T6 single board computer.
Note this series is dependent on the PCIe 3 support [0] being
upstreamed. The NanoPC T6 uses PCIe3x4 like the Rock 5B and EVB1.

[0] https://lore.kernel.org/all/20230717173512.65169-1-sebastian.reichel@collabora.com/

Thomas McKahan (2):
  dt-bindings: arm: rockchip: Add NanoPC T6
  arm64: dts: rockchip: Add NanoPC T6

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-nanopc-t6.dts    | 845 ++++++++++++++++++
 3 files changed, 851 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-nanopc-t6.dts

-- 
2.34.1

