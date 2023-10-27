Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260477D9DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjJ0Q0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjJ0Q0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:26:42 -0400
Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467519C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:26:40 -0700 (PDT)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.10.213])
        by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 31064102D3618
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 16:10:38 +0000 (UTC)
Received: from 104.47.7.169_.trendmicro.com (unknown [172.21.173.48])
        by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 629A01000178F;
        Fri, 27 Oct 2023 16:10:34 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1698423034.128000
X-TM-MAIL-UUID: e43ed3f8-9ace-4c60-a35a-33ec83871918
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.169])
        by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 1F59D10000FF6;
        Fri, 27 Oct 2023 16:10:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHgzfVEtYWBULpElT8gV14FnrgrOhr6VMzlOTE0xgus9xtT875Gf9Pun9wTxV1WXVlisKQH3texYgb8cp32S5clSBXZHiU2UVlMIGW924EVfvym9KIUwZIs4QxSxePJDnclJLPqjmTx92EzNcoWuvOljzIgd1dnA+fvXHNsw1I63UCAxrFZgjF8IoqpXoVPglBkVh0q6X2HiHpaIjidhNVX02Zfk49Qy4ZKYOStVOAha15AqB/BiCRk72uQYMMJcpJMjJ9XG0ZYZPOT6vChTMWgObm1O8eZTOv1uQfSt0cUMVoW7P03ZCvfhHTVK8ul0I4cGYzRkMg7r3a5gt6leqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znQedgMTuZ6mQLkyK/55KkRjHGFmQNPL/WdixuHCFgk=;
 b=Z8D8M5mUfjIBa6qUxfh3fDdas3yPoZaGyGfNqm61u9tjuC4JOx1xtgFkRD19XKlSsXRPlZmjc5FfYS5XoRaZ3Eypx7Y2DA15yRYx/Kdv2rJDmwR69Q5zMpg9+EWxeguRNA5FMQqE93FmuaEYJ1Jr/a0jtoWRSYPneEfvdkKl+UpePxgshom6hAZpSkRZe19IFUaMnR+BQwyK3JKMVc8IQO1L/GpBZv7W+hUKmJt+6hN3ZwRt28w/x3GEh9bGUuKY5bGw/BP0Dy4Q6XtwqoP6qOopEAvlHt5NRgV81QZI5cOVkcHDSUh2jGxgs2/+GmvPmBtdF7qAvW16H0WAXuEReA==
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
        Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: [RFC PATCH] Virtio SPI Linux driver.
Date:   Fri, 27 Oct 2023 18:10:13 +0200
Message-Id: <20231027161016.26625-1-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8EUR05FT026:EE_|FRYP281MB0095:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 89e2c61a-bd54-458c-c1fc-08dbd7073f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRu8s2UdYifPCPdFWsuFMdqECdgH8bwcpo4CBnluOgRCScFv6WblODKSzNleQRYdUGlIaoI2thHGryYFoYb53nRFPy3XQ2rGLuUSfchKXBGHNfUD6OykBDTDSB45p8xwPV02UbfSMSFueJgcInx3WARfSBQZP5vkFhv20eZCOP2gaSUeWrD2HzvnECMubxvth8tafGBaiVdgOkbHv1mIVCkTCelfnRolmMEddVAPQuzGW4Y4mYtrOMLuhq8WikIdF1F/ntmXwH8ITkEL4c4t+iDJST7hXiaGBb5dfwpo8DAaCLNQm87lD7zBSKxY1kFOF5r5l4u/l6+5Qvt6G90LahmcZjw3oZi/yEPUIfoQsC5TsGsAHxsc3z/UUnjvcuon7e6zXt4kIpXNAMzDjZirUq5USHaq3AX/7Khqy7WybLesUZk/UGPM3x75zqVHO94r8J1WlGnRZEjcvRjUjRh+VhtaWpwR/Qto8Z72WTSnbbyaAfn1CQXW/+qjaglWDl4066VUGrED/520Zkp5wAbmM+Qz9sgx4xkHpVelyVgvAVxb5o+Ew2jOUENdO/cSVW+x8RLrWZSc121JKRcS6P2H67SubSfcCZ8Q2PICYtMbYmJv5VobcrQN4hjkvyHkg1me+GT1C19MEN2CFi/0Cu0VveIZprLpycqOYJrRUlIPkByGVvQfoLQREYj+wB44w+3S8sUhNIMnQF8mjzSG6Hp+YxV3o5GhnYah5Xkv4cAnjuPwI6mofS/zpk1dJ3esOKGC/TcJvQ3bUnkA05oZCb4Mmepx99pEiZi5yrxHIt1ULD0=
X-Forefront-Antispam-Report: CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39840400004)(136003)(230922051799003)(1800799009)(82310400011)(186009)(64100799003)(451199024)(46966006)(36840700001)(36756003)(40480700001)(54906003)(110136005)(70586007)(42186006)(70206006)(81166007)(86362001)(36860700001)(47076005)(2616005)(1076003)(336012)(26005)(107886003)(4744005)(2906002)(478600001)(316002)(4326008)(41300700001)(8936002)(5660300002)(8676002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 16:10:32.7612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e2c61a-bd54-458c-c1fc-08dbd7073f39
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT026.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB0095
X-TM-AS-ERS: 104.47.7.169-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-27962.001
X-TMASE-Result: 10--5.167200-4.000000
X-TMASE-MatchedRID: GJ8SmjE8Z++6TyUO/xKZhYHohmLzO6JeD7q0B2/DERzSlcm0ThcAIHVY
        40dPvzCfmHH61pATHChPEaD+REo4DcddJPEKsqAMES46qCSbf/WHvP6CYoqPSgN/ojyMXH62qc0
        rDnrrMThvmAGL4jCt6b/a0nd+hIFCI/NGWt0UYPCIZ1XRF+BYFXfEipD9VRju6+FlhOxuf7YH9e
        LzJatmZRpeoCcJ3+rq
X-TMASE-XGENCLOUD: a2e25b29-bd08-4dec-b118-d40607311936-0-0-200-0
X-TM-Deliver-Signature: 3C25C6CD187B3F4DD4731AEF111D2FCB
X-TM-Addin-Auth: 3jy7hcZ0QLzdWQb37YtEygwo3Di1thit0v+Oww0ov53S22c1XQlAhlahgYa
        o3xxz295rw6SdEdoZWHAlXIcFl+S9Bgw8BYDWoAeZmxZez5XnZ9tj3zQQvP6NYSLjWr5KvUD7Ha
        Gow+j2Fk9kL9PWu8OW8eHy0n9FhCwtcdarGr4AXOZ8OCZS/fP0P4dCbOdY4lJRs+O4GLZSySyy5
        nRObDXX1/C3dM42qHvRyPVu+YOiaFJzHKfgH1U9TvWxRRoOnolIwrWOkCNwr0jcn7qEeGAzHkfx
        pDGT1N5sf2tXAQQ=.elBD4CPWCusAYIjuTEqpDlXRn24+p14AKDuNO7ANLKLbb/C2iopJXlP7VZ
        cjG0VulVhrSx3zga5LguGZ0Oy1Qd0c9LC5ZtMrP5RMwVru92dZH0PnsT2H6G3TW+TNzgLXBqfx0
        JNX1+9uwyo0ijNCXtjcPrpwOAXgiOchoSsYk0lFgLdqJnuZH4MEYYFFL2RORxBPUoaR6/QiPNmb
        4yinVc+6/yM/x/YsuDadft6xF/+FAssY9cY/S3YH019T3Kk2DFlLHwG7wdVuh6JxKhoQb2dEVgB
        HilU9ktkiOYgJMq4Pus1qGlpf38XA+4bN4YyMfoGeQ5LvSEx1R3nizmVfHA==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
        s=TM-DKIM-20210503141657; t=1698423034;
        bh=znQedgMTuZ6mQLkyK/55KkRjHGFmQNPL/WdixuHCFgk=; l=549;
        h=From:To:Date;
        b=FudlT83PYuLuzbDhHbScB35EkfqbyrNzqQg25PAhsMqskJF/YLrWdtL5FMWkQuED9
         l8BdOoZd4rfq/spaujESYlokBieLsPmFhvUstZLeCoUw/Rl3h1SOo2E1vAv02Wim31
         1YtKft/zEJ1x/kxV4IaSiBlA7RyjsEnrbLWtG6Xlfw+6exvhfoZcT7YRwireh9CeCt
         RTXmUI3s0crs85EcDNX2rdLRNaZUUtr8SqPXyzhrB5nsA2L0EQpYsM1T4vzYkq7DfT
         KuCYLaKut6htuvAOju9Zb5OG6gMTs6QGf8O/4Ez6jbfQ0AkT5Ib242ACrz2v3etg2c
         gMjnzzaeoL2Mw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a virtio SPI Linux driver which is intended to be compliant with
the proposed virtio SPI draft specification V4.

The virtio SPI driver was smoke tested on qemu using OpenSynergy's
proprietary virtio SPI device doing a SPI backend simulation on top of
next-20231027 and on Linux 6.1 with target hardware providing a physical
SPI backend device.

For discussion with the author (Haixu Cui <quic_haixcui@quicinc.com>) of
the work in progress virtio SPI draft specification and with other
people who may be interested in virtio SPI.

