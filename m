Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C27D9DFB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjJ0Q0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjJ0Q0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:26:35 -0400
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1E5106
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:26:32 -0700 (PDT)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.19.113])
        by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 40CEE105D2E4B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 16:10:38 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.187.19])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id D91C5100004F7;
        Fri, 27 Oct 2023 16:10:35 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1698423035.601000
X-TM-MAIL-UUID: 878ee63b-890a-4e06-9af7-82ba57401f88
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 930B310004DA4;
        Fri, 27 Oct 2023 16:10:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud4bpmZO4vi6JR02Ww/+DsOwyel9Ee4309pzWYsLplSvNNDKDWDgC+wAHFqwwbtmctPdEOqARIksRNbU5NQiFZJUIxAS1pABzl0FDFVpx7DdDAfgvzL2Y6xqk3RItfICxGUgVz1SdgJIUGUcuKwKOrlZg4I80WToicZZqprFIXE7q/XERyFvfmZuVdiYpBU8WaTnk+rYzBEeAgyZ6/9KA9ckV7CBu+Az10P99UTElL2rMweb1LZJnrtG/I9oIuuYdndsd5gEVrY30JZweGNI8IeAK65+pzUuA0cd6RKiLy8fDHjeLasyiuL2pUKXaDB73VYKqKD11qvy1otQO0GcCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSNSQiLw2taR/25gESYnwRtDRVy5PR4seJYFt74sGfw=;
 b=EnAff9SjBoAbgQrhnwu6sFlohwEEj4wU9fjz6vCEg8WreR3Kcu3lYZuLIBLpbgmER80PZWSMUxHsLPnLUyjB+i4ns9ETKwP2eaGCtSQrdL+VVH5NtF/meDe/+VQ95ELM1+MHgJhUAjONBO3+bfr4Xt6sx6+mh6DICJwvimrGY/V7DSgjum44jXfmE7bx7WZPMtQscFVTnCQQPQxcd5oWq4rXMPbSzL+fm8WL4Ga7+iJnYfaxUWh76KmwVmqZuLbh7ASBx7SD//R+XpJWFmEBBkSfO8Fq+4IxowUtCMmfQ2SXPbRPUFTg1EJn39+OvJiMfHeK2WTBFgMW8Yygjor4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=gmail.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From:   Harald Mommer <Harald.Mommer@opensynergy.com>
To:     virtio-dev@lists.oasis-open.org,
        Haixu Cui <quic_haixcui@quicinc.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Harald.Mommer@gmail.com
Cc:     quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>,
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
        Harald Mommer <harald.mommer@opensynergy.com>
Subject: [RFC PATCH v1 1/3] virtio: Add ID for virtio SPI.
Date:   Fri, 27 Oct 2023 18:10:14 +0200
Message-Id: <20231027161016.26625-2-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
References: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1EUR05FT067:EE_|FR3P281MB1709:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b405083c-42a5-483d-e89d-08dbd7073f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mOVNfZLhwSiRsJbT9YpNCOzYi6fjqv8GwzXOcuTqyovPw26pZGbul6cCISnFGNIJdRf1EvaJ4jrYLzNXSSuMzgHRZGA/h4cAw6fzhHovovePBqsFNeCGQfdZBF11+8/bP/2SCL/HUWztlyCsOwXvhT1VS7BEjGAOoebnIyLKRWwuC5lr++5QqriVB30yQ8HVjUelFyf5amzT5jwBdFsk6F4XaJiH9oeRotXj8tAncLfWwN0ARX0OcOkSbbI7Cm1+zJFc/Wq2GSXTt/bVrsQrKjV4d6pv2pzVr/HFN9KdBDYyT6jwLFUQrV9a5NW49TPTnEqVonlBlW3FKiF1+6gE5MahCegXt+lAjHoAKlwa/Fhrloj6x9q4Zh43LOExWsCGSoyVK1PZqs9B/f517qBeKwmWnj355/iCA77ongCrXppbJh6dyPooBaCl6ajpobUt4HrWyZizmx+WScoE7EUr9Wcr++blYd+aPrpARPxcxAXj5b6c6ovY9mAX6+iYxyouMl6x6QDNvJgPOI1ay/bL2RUbtVskTBXRGLolfOFFbIGaethlIAFbtUWUBCH5e/+hTCmHeFNNg/GUMHfHsx8cPniclse3ii9A5gF4OI0dB7tl4qsSxU3ndgm9+crJGyJd7GxZ5CsqlrJr6GisBoR00Uk2tXIuswYqzEAJbCQEnTLnR/mbVTqIolflN7HJ4kJEODJoZ1JNbqFoypCd/WWwMPeO848/pFKNUuFIW8y839brIYtVR5m+5mWblcBJGsmhzUK17i8h8K9Ew3zn67Kxe1y7WYLtm8EVuRRgS6ZJrgU=
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39840400004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(46966006)(2906002)(86362001)(42186006)(316002)(110136005)(5660300002)(54906003)(70586007)(4326008)(4744005)(70206006)(478600001)(41300700001)(107886003)(26005)(2616005)(1076003)(81166007)(36756003)(47076005)(336012)(8936002)(36860700001)(8676002)(40480700001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:10:32.7712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b405083c-42a5-483d-e89d-08dbd7073f38
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT067.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1709
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27962.001
X-TMASE-Result: 10-0.491300-4.000000
X-TMASE-MatchedRID: BrKfIHwbYjXJ+P2VFrJmrBkPtuOr7qUwbNjTSFpLxCgW+iZuJylrLk9A
        UWTSPmMGwDaIN9ul/L4BWl4ObycmgvCdAcVltQ/exNPI0Wv0ie8GhuFLY/rERHGDuy8y1qkuYKj
        ldhK/3R4K0qPq+vrLdwGuRtyAftYho/a1y7Xfm64s9l077GK5Fg==
X-TMASE-XGENCLOUD: c692ecfe-7c95-45ed-8d81-886fa099ed3a-0-0-200-0
X-TM-Deliver-Signature: BD965A7D2834CB3228D224E8E4C5DAD5
X-TM-Addin-Auth: cr5d/b5tqeFroDZ9o0xyL30n8iuw8TzHN93pXlLQzm1Jha7PvqMEIZb+XEr
        6lxFo4zR3jWyXXbhhWdJNFIkSRXHBj4yyfYKSiIHPBSYtfr8sjlG4AgETjwAk/hNVCBaDA9ODYU
        PN9h0ItJFiKRwCNnQd2AcM8f0WX2ZUZTetVMKiCnSz0Vh4z7NG/N4Vvs0M5LmCJ8K4wIUF7WnA/
        eXbqvVSWa7T3OI304y3GKBdG4C9tTglByNfwMbmwc5JPzhuJhjrHWYDfkQltsCbnCsZRHTOqjsj
        fK+Juc+qs/4EOrE=.pNDspnEe/RnzmlKBbObUt8I8qBagYgIdEHxn+aAKmJw4MvO7Dv5j/ZZVWs
        JTV9f5bmol0w+8P2CTT2i6DHiA3jL0gzCFDeem+0KdivE+ZDEIwKI/Ow8mXAmxlEjmMN8TRfo4z
        0cLFAjgkWSiVgQXT8+yVhiLjcFl64B6qMBvf+eH9MdAHX+fOJIurftX1JARRBkz+9yriQMSn4ZA
        X6Qu4Djuz2S+Ai3rGF3/rsOflEgk3NwP2Y0lN7e3+GB0iGwH7R43m+f5OhLYNdV2oAhd4LRFKSd
        Kdm6QoLhEEhccwsak9BwtZSMtxgStn0edliV7S01WqPzN9AXA1+Whr5y2tw==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1698423035;
        bh=X4lHlvXtqSBf3mrkpOXdURMt/g8gLYp+Io15Exs90WE=; l=724;
        h=From:To:Date;
        b=B8ePw87+R/KVDHmgP+U8w7O6tpjPiJa5xFvas58mNw6NywPvWaLpoOChLRra3ME9V
         HwWM0T7ys51MRDZcSaIOiS9mL4fJX3Ngi8rWQhEmwlRb/7aXOkdTy6g24td0I74xHv
         oVECyE7aTIPicC/nKD0LKVJrsjTtAVCU14RWI//3NGYKJAiPrtrwVkS8qgZ3OAGS1/
         6BcfV7oPcyFHxMD8ne18AFqzjQB88bnVxSue028zn+UvMw2fk7f6DeuSS2CbpyZ41Z
         Wo0SE4AHTINlsa5XJ5dJ1BaEXWVXnO4Xtj1m60k4GN8MmblsbbaT7i9sx5Ka/ZCmfF
         UaFZZzh5nTJkg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harald Mommer <harald.mommer@opensynergy.com>

Add #define ID VIRTIO_ID_SPI 45 for virtio SPI.

Signed-off-by: Harald Mommer <harald.mommer@opensynergy.com>
---
 include/uapi/linux/virtio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_ids.h b/include/uapi/linux/virtio_ids.h
index 7aa2eb766205..6c12db16faa3 100644
--- a/include/uapi/linux/virtio_ids.h
+++ b/include/uapi/linux/virtio_ids.h
@@ -68,6 +68,7 @@
 #define VIRTIO_ID_AUDIO_POLICY		39 /* virtio audio policy */
 #define VIRTIO_ID_BT			40 /* virtio bluetooth */
 #define VIRTIO_ID_GPIO			41 /* virtio gpio */
+#define VIRTIO_ID_SPI			45 /* virtio spi */
 
 /*
  * Virtio Transitional IDs
-- 
2.25.1

