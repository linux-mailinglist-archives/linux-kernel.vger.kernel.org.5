Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2BB779333
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbjHKPdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233325AbjHKPdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:33:46 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2052.outbound.protection.outlook.com [40.107.8.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A469A10E4;
        Fri, 11 Aug 2023 08:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpUjM4YD+vKU66A9wADdArTIprwvFbAkiUMYupbQxPf7Z4mI+UjJiCsJl4FGE9oSPoBK8Xc6t3jAkR/LeJ4kj1EDSiCYCXzCCEjAvr0a3oZ/+LPd2fbT9Wt3Rc/mQstibPebmxgoQAhRbI+uRcVfSIVIX9uGzPiq5FSd9mMRl5llAg+e/dJUdGgmzfGbjzulYYRXgGEnCxcIaAcMo0uNEFwaSSCseKeTGZpeU49029h7jn9rsii10xsmU0vPNxLdtwijpcfoWw1oojzHVeTbIe9KMYPgXtbfVbQMN7H06J3W5ciAcqtihNIf856vfqRrUHE57/nbGSGEtMQrrrGBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVsi/i1yx4kwhMaLV9kwmwH+vEyaFigGUIjKMRzibiY=;
 b=Ybkg5YrR92ErKHbBuNveLJFS6iyaSjpDtLjy4dDTFvOatEEGW8qlMw6xnRxmHiHzo+eqlBRY2CKjU8xFrwvJYJkLqjEN2SrZTIbz+wqTUg2UR2htDWtHHBjwrAZn7SeqaHepbnAUQLUdXPWsP8bfcp7ufcLZUG8OlZkezI7GDbdFQIaOFb7UzVyozxL3a7AG35KIqcAn7S/wfTz0Ki01MOgO1DGOj356fuEo3UbkU06nYtmZM2BWOYlIbbXEUqPmje58j/BWBHCHSps9sYAG+btIbVhq1UZMvgUZaPSPZmLltMAResFSmFD8v7ijUVtyFt0A61izswq4nLlIXOt2uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVsi/i1yx4kwhMaLV9kwmwH+vEyaFigGUIjKMRzibiY=;
 b=gGFhOGi5DlwfqW9WpLik4vznshCHiyKSgW978Qe9Y5hmAOISD78uGor+fxNNPYxpliUeE1FkgKo5IQ6R1AHktE/7LTBHau7lZazOJ3ltBlYqlB6TV8pGd8WnZ8pbWMVGf5Xr5nLuive7KeK3+xmOF+HJId1NLdHrKEDC937BY0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PR3PR04MB7338.eurprd04.prod.outlook.com (2603:10a6:102:80::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 15:33:42 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::2545:6d13:5905:bf50%4]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 15:33:42 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v1 0/5] Add MACsec support for TJA11XX C45 PHYs
Date:   Fri, 11 Aug 2023 18:32:44 +0300
Message-Id: <20230811153249.283984-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::11) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PR3PR04MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: c68958ff-28a4-4954-6179-08db9a8057b8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Tt6HPkoDzIgdPO+xEQW4BoSuvtLzZvYn3+w6/Gsd0JmKsjHi0BANjhk0wgpt2jSZpRQm/LXLd2nH7L8ezRsUz2WtADChzSfjuytSbO4+9c9M9YhBx29Aotl1CIO1CtkiAUa3i/4OsQfxSzAs8W0Lx0N4AneA15MdTbiykKBAu43QSPF4R4MvbM7qxbK+ix4EGCcYlgnlG2JMnb/uj+WZ5xYtXGxXo/UZ6+V+r03ZzfP4cCgzxw1BQQBiILEm2JimhdxO1c6BNYaG0Jz0DoXsmE4x6KboXurTj0mnXqIMKjmVQI6kPgDbD6UzXORTFmg0DIa6gpMXU98TYeZn2i2f6hjC2Nso4Ad/EtprOFepDO3JbV07Wxq/VjL5IUR6IpN3fg1rQWzKW01qW5kBL+esccKWOIuG4iRA449XGnFsV8LZQZy3skyvrjbNy76+vsbo0JxdgxDWsSm5+sJhOfhTYyNNUEJZcOW6F9wwAclZG4f/uScIZioF5M0az1EYTqKCGU+UGpJ8KYVUSwTwnXqWKDzkTA7LYwWqHqH0YT1sy0goYElkuCGcdK824Cxxdcr5YfD5XxCnz4AZG/cgHRJ5PlLGoI1s7h5oZ6sQAWd+eMYZAXiEkXOtjVQiWt7WIwt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(366004)(396003)(346002)(186006)(451199021)(1800799006)(2906002)(6486002)(52116002)(38100700002)(2616005)(83380400001)(6512007)(26005)(1076003)(38350700002)(6506007)(478600001)(316002)(4326008)(66946007)(41300700001)(8676002)(8936002)(5660300002)(66556008)(66476007)(7416002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rI74vOhSGH4tzR6SM//yHWsjRio6rXbACqx3ijiNiv8VnAfFHUbGxK05Mv9n?=
 =?us-ascii?Q?seClyhn6DBlfxYHjLUboAhlE/op5nl46lWHm4kZAuZOlm9hnLUCh/6GCChcZ?=
 =?us-ascii?Q?GpbjiIHg4h7haXrR8pUFHzgdL+Irv0vX70UnqoAZhBNwmPQRnTgNe/SJ8HvM?=
 =?us-ascii?Q?KujvRfnlGkGZzYrlHboxaG13s5j8uubpcd1hPdAV/nNJpa8fJ1qV2MDxguRW?=
 =?us-ascii?Q?M2kCQJkMV2eGIv090n7Jxk4EtFxLIVMfSyeGsgKe6GcttLhWxtDisvOumk7e?=
 =?us-ascii?Q?erVEXlVNkPdCxLiZp+2VSrixDyE5/PQwsu5sQB8f1rAderbaRBQWTnbaY8xl?=
 =?us-ascii?Q?JeGeAmSeEyCmpMxQm0nMo+pUhqv3u3RlZG4ObK3O2zWMWj7WEtgdtgUIDx+x?=
 =?us-ascii?Q?6KHKeiD/oBfIV8EnKwgvb7CXj+fYcQA+xpP0HElbnvWqMntPRhPJTRqT3klj?=
 =?us-ascii?Q?z/rgbtzLJoa+f2wL3b61/QZ+B2D1BRbbw9oUP08fzbx2585670IldMVhaQ1h?=
 =?us-ascii?Q?hQZbCPK3W7flrHA+Df4Smbq+ciTEkbE0pfNDYAaV1H5tSYuV5CUZVjt2uuJj?=
 =?us-ascii?Q?Ee7Q/7Qcmm8xlluzDj+ng6iMn/g7oSfxY+JTiKm5JEehb0EaVqP/FPl95wIW?=
 =?us-ascii?Q?J2N2D9CeF55vxOdet3sGpxyUUFhITrMINELi6LbjSHLd1Ojp3fC8IR93eFhS?=
 =?us-ascii?Q?Kd6rXdgLcFN/K/m+h6635nAPHn0wjnjxF4jd1dixHg/8cTYaeoZiwftLpYkv?=
 =?us-ascii?Q?hxd0jdxtZytibH1i+XwzfYiaEjwPfWeNv0Cj2pXVzgpQaUUxOAMT2j61T230?=
 =?us-ascii?Q?epUBAvwKqR481Hv2VuHCv9HbSYaJlznvBQuDeKjIutSbEia1ruNqvQ4Pcc14?=
 =?us-ascii?Q?OqkSsyxeJH3BjT+yz4kL2ku2f2EkqwpIXO7UiPT9Sxo/o4Jnu2H3DeK+qCyU?=
 =?us-ascii?Q?Qf1G5GWWJDO3Ii0r47ZckG96UPrBq4k3/PCJWG4txh+SWu2KLoc3ot1Y1YCM?=
 =?us-ascii?Q?hSGKNJPO6zD2+k/TQeQ3OYJzVpthDinpUHpoBIAqZtO4EWuRbbYWFWqiL3sk?=
 =?us-ascii?Q?Rqt7eFyuyHwa1yh+10FhkDvf/3qhK4FqRKmU07ZCHuHpKMLbB2bjIin6wx+Y?=
 =?us-ascii?Q?jBVe0BBLVAn33682RJXcBckXsl78O2gPi8WhDo7lbCTzw1ajwxB/jnn4BCCC?=
 =?us-ascii?Q?pBvRwomO3juZbTT4i2XT9vTOiusmqDPZIcOk7CjrsPG93+FHJVICJDE1hHvK?=
 =?us-ascii?Q?8/Mq34GRIyvv6E5SbEZyVM5ozMY14ppqs3Sg2S3q91zCLPjy1ZOxybtz1y3k?=
 =?us-ascii?Q?UD3Pe6dacRqWYsAq7uHdjxwoDXp/h8BgLncqJJu598pB1OzweNPAoiwsHP+3?=
 =?us-ascii?Q?N6LAEqim7Y9EYeycYaRZaHsNF8IKkEkv5ZN+u/SbgdarTs3evB4tLRC0Hkj7?=
 =?us-ascii?Q?k9quWsN3SABPgxPaq6ffBUfvXZu+F/aEL/29p+V7+3sNFYsDkV7ETutdz2w3?=
 =?us-ascii?Q?0fEeswrjy7eQ+uuIwxOVWcCDHd0rnKOTiyyfR9zqEWEsGPTEopD69J4sNCzy?=
 =?us-ascii?Q?tcuujTTgdD6EqRf9mJFUTCOEtrhWW23W0iQEWK5s8t99Lw0lJCjlX+/H6c7j?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c68958ff-28a4-4954-6179-08db9a8057b8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 15:33:42.4113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /zyHBy8Bi9SBJUh9vnxIdfgh/VaU5CjrnYh9WBtBQLRffOu8dte1Y1+PGzvwVxNlUytG4wLxYV+lomqtWWQ70bLNHd3gFg3mTmtWAUGCunA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7338
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the MACsec support for TJA11XX PHYs. The MACsec block encrypts
the ethernet frames on the fly and has no buffering. This operation will
grow the frames by 32 bytes. If the frames are sent back to back, the
MACsec block will not have enough room to insert the SecTAG and the ICV
and the frames will be dropped. 

To mitigate this, the PHY can parse a specific ethertype with some
padding bytes and replace them with the SecTAG and ICV. These padding
bytes might be dummy or might contain information about TX SC that must
be used to encrypt the frame.

On the RX path, the PHY can insert a similar tag that contains
information about the RX SC which received the frame. However, the RX tag
is not enabled in this patch series, but I consider this important for the
review.

Radu P.

Radu Pirea (NXP OSS) (5):
  net: macsec: declare macsec_pn_wrapped shim
  net: phy: remove MACSEC guard
  net: phy: nxp-c45-tja11xx add MACsec support
  net: macsec: introduce mdo_insert_tx_tag
  net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag

 MAINTAINERS                              |    2 +-
 drivers/net/macsec.c                     |   79 +
 drivers/net/phy/Makefile                 |    2 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1878 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   72 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   37 +
 include/linux/phy.h                      |    2 -
 include/net/macsec.h                     |   12 +
 8 files changed, 2051 insertions(+), 33 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

-- 
2.34.1

