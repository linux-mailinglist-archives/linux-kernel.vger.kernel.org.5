Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9236B783A40
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjHVHAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjHVHAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:00:34 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D3F18B;
        Tue, 22 Aug 2023 00:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX9uSrrHIlAlkTjQ7RM70D/ppqm/m1M4KdOs/rKi7NKLDHG/CiN3n1o5OYYZEMlOR2XmrkBmvkUu47rO2jmHhZeO6LpIoh5DpQBlG0rlVwj8uNrI0UgmAjRN7fE9ZZ1MFVXAxmP2QfnWs8qB6FQzifBmAsDcdeAzAo2yxKY4IQjA8ZZkSlNcPqoUGjylULCsNW1IevynncKjVCTHjDqKnD5GIkNrCgtm1QfnS7R03IIUp/kXrO5NzfTvvH0kndF4ALd46ucsXZGe0Si/puEgbxCqMl/Iy6eD6LrUKEh1Lp+U2PXT7brIvy0yKwT0s4QKDB4IBPasWB0n2qHP0M3TrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efvWtCSsMGFQg/NV+InDHkydf9xYTsi6+jNZ6OmcvwM=;
 b=LX3WitqCq7mctP+W50v987wCo5l5V7PkivWsKKaEZjlJf9lkl23L1zEs+nphpk8uDperCGn1aCKkN7kVrywEDtqJHVyehoanvSrh2eKN81W/mHa9qiHSFhK3zZq4GsAglEJ1QWblK9V7GOhPuZBE/PdIB0WpPsRLwucsto4O5LyU9VLDcAiWC72X/Lpqatf9ki/uKSBXTh2MuDP4vcfQhOOwHsRAAJjlUEKCD9T6fweyK7BRI54LSfs3zaRL+hJDiDErItcjbp1o9ezXRRYM00mDSoqYtt01fbGC9twx81HOrJlcBw7O7sLaE7pzZQk1fnbP2eTCG7pRmImqX/tMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=embevity.com; dmarc=pass action=none header.from=embevity.com;
 dkim=pass header.d=embevity.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embevity.onmicrosoft.com; s=selector1-embevity-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efvWtCSsMGFQg/NV+InDHkydf9xYTsi6+jNZ6OmcvwM=;
 b=S3w1ZQlYD7SanIVhRcdVn1h7J/dbbCv8TbdVS2VR7EhvF6S6i4aNegJ+0g7+Ih23Vn3Bqc6+jcoglkmU0pByXK+3ZzGAHlr6hDW3D5LG1VJIKEZshRxdCNbO4ProuFBEoPB6SpSXDhT7/dMUhCgxBWgbd5C0myulfosZS8wPbl4yBoGRPOTnQ3GxqvNtYOzm2YudaOoGJgr6IfmUU3RGV0sDHH2qQTjtd3VaIUZm7/qj1ku37NF+tCjoyKhfQYt4uOAMPXHixt3GaG8B9/q9jLGHtutnIQ/WSIyCTkmE7cuph/JjBWwNTBLjag5Nb3RTmaInQGORWLbKxAtUzuJY9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=embevity.com;
Received: from AM0PR07MB4243.eurprd07.prod.outlook.com (2603:10a6:208:b1::20)
 by PR3PR07MB8130.eurprd07.prod.outlook.com (2603:10a6:102:171::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 07:00:25 +0000
Received: from AM0PR07MB4243.eurprd07.prod.outlook.com
 ([fe80::9b2c:ac40:b73c:6653]) by AM0PR07MB4243.eurprd07.prod.outlook.com
 ([fe80::9b2c:ac40:b73c:6653%7]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 07:00:25 +0000
From:   kornel.swierzy@embevity.com
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kornel Swierzy <kornel.swierzy@embevity.com>
Subject: [PATCH] Fix encoding of ethernet frame length for big endian platforms in QCA7000/7005 protocol header.
Date:   Tue, 22 Aug 2023 08:59:56 +0200
Message-Id: <20230822065956.8719-1-kornel.swierzy@embevity.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0421.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::25) To AM0PR07MB4243.eurprd07.prod.outlook.com
 (2603:10a6:208:b1::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR07MB4243:EE_|PR3PR07MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a0165c-7e33-4fbe-82be-08dba2dd75b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +U5ptL72HWHatyZpU9ZqyqDrWC1bU/7G9U3xfrKiwe4658XcoVon+p3X4e/JEmA4yeEvCags31JkdaLvhcUch2ZuMZtsg4yrcoye7ClelrAw3kq3or/sr59Cl7o23Rq5gYqgb+f9z2vXL6ibR3v5gVrahmz1d4x0YC5YASkF2zokijuFkjVm1evckHit7TLNIQqD+c4MytezsNt6K1t5vxwEWhPgYuF3WGA4ORGE86OS0P7HrAmKdi9UIw3rvIc8eaYZ4Z9yNhwN+tTRCo/8g79W9DM6zkpPo+fvixJBCsY5qGZL1hHdNuGR1lePHcS6Yb6fjHd1LsvqXvCzWEYC6kvJ3/GuOv11GuqPWMqbV7gvPBo1holS+VaIbmTydL0wxTQFnxsK66sIEWfaEXurtI9euU7dNe/GGLUs7BTD107Lz3M1gKvDTlHRtVMdaSxfGv/S8lfc1I+4tG8/g9S3s+N3zaGe7o3wDCXVB6kAG8UPoi2KKbaNIQyJkNbqfqcqXV/2x3mHk/3BodoO/Hb0p+zj8VIcfXx4sncAdZqve3PDIcJyaGr+NWdnZpI3B5cr5/RJ04Lo1sF/7odb93PEbB32ikcioYk4f/AgpogvidMYaK5xWd9WfWkNB0z7a4KVQt5tScIVoE77I3BnBJ7jxAWkx+L9iTFuqeCToDg58+Wo87YEQ4+rzVLZlHUYIx3dfPoZCAgPT/WUSPcAODXVIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4243.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39830400003)(186009)(1800799009)(451199024)(2906002)(4744005)(38350700002)(38100700002)(83380400001)(6486002)(66476007)(66946007)(316002)(6506007)(52116002)(66556008)(6666004)(41300700001)(9686003)(6512007)(36756003)(478600001)(86362001)(12101799020)(26005)(1076003)(107886003)(5660300002)(2616005)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ES1vdfAVmqY0MP6mpy6lrm9T499rFZ89qtNt5kH4FEn6jVOt7ZRMexHKOUKA?=
 =?us-ascii?Q?4zycFQ+qETg7qHi9tCYEAH66lH6tYjHdE/PLuRcYQs/a19yG2BhuZ9zKRCpl?=
 =?us-ascii?Q?uSwr2SgsS1I2XCKJ6GQa1HKesG8Gge9zL85WHwlkkpPe/O/RpjItPPawsdpA?=
 =?us-ascii?Q?oCo+lofKBzXaQmGrxiDlOFa4BJx6prdRalDdt9e33r//lOOsp6Y9ffO96+Nl?=
 =?us-ascii?Q?/ln8uvdQPJ0Iog/qpgKQfI8J8oXRBQJn1qgehaDEbAxw+yi7YvUd4yB5OKd4?=
 =?us-ascii?Q?JUeHNmUaA+WafjoBK4V4sRyiaRDyYchJIvAheZ/+SacbQ2b+Ec2mzn4+PrM2?=
 =?us-ascii?Q?ouheWGSPuiaUYgAEYB1mDadMNM+DbMjLyV2dVB3+XcMiCiYhsKVHUii00iHe?=
 =?us-ascii?Q?xAs+E9JBFIIvbvSnQZtbz9FkqJ+GyTpMuB9XDd3JSz7hJxmcZZSycTB3nP76?=
 =?us-ascii?Q?5fxM4c6EcXsbE/LdNUkeKw0d+/cqeaBJnwzGCg65Wt++hZFxFrYpGccGAb9w?=
 =?us-ascii?Q?YNgwiZv7cPkepFhjjp4ByAAEGBSBYtq2pRSk/CrJVlKkhPkCSXXkjOp5hyys?=
 =?us-ascii?Q?y167x4RHE2SXRcFwNLcl3OfhOSvAmxEsnkni+SCNbmks8ALckmtqz84fD4kZ?=
 =?us-ascii?Q?pvsUKoC/yNtkId/eUVbUvfgccjtn8hT1fzVFbtssHNAaSo+FMsuaKLousr6K?=
 =?us-ascii?Q?IvFRDNbrx5FNEV6RtefHfkOUUKVSdGNS9oq3ii4GjIeeF9E7gzeYtpxKelvC?=
 =?us-ascii?Q?vC4Exc2mHEWVp+1Pyr4kitlKCyAf51JarAo2hugF6QHHkKwzxEwD1ZJvrK4X?=
 =?us-ascii?Q?WGXFagpNOwe3J/kdXyLwSULtajTAvFPlv+b5CUTSs4SOvY+DwYIg4xwK4tRQ?=
 =?us-ascii?Q?D9WIJXnQfFjDL1YzakXnLSb/q0UmhzV/aKCvKFouCzE76RRdfilxQVl+EapZ?=
 =?us-ascii?Q?fZHQ54tI5REpHKjXhQGZBbWANgpvOuuAVmvMcIxGNe5Z4zfPyCD01ckWGpLI?=
 =?us-ascii?Q?loX69xiNHz4y+Un8Zx2c+LwCSQd7y1qkF5lcG9DvcvIy3QFZnsvyH/HS7soT?=
 =?us-ascii?Q?y5N2onfEe7VajwKdj0rTKfAWMVGXMZQ44PiukOGEyRU7HR0hrGJ52/vMVho3?=
 =?us-ascii?Q?FZyLp6AXNi5Iw5Q7m08AGllEWYE+W6lBnfS1kva0EIRnbkzRIKOjHUPtOZ9F?=
 =?us-ascii?Q?3lElIKvbJCSV3QngqZ5gYWZw+lAUdqwh1apJ4HJRZXJsM+9OaCCChjrTHN7V?=
 =?us-ascii?Q?HEAmWZSUmb2JQv8CKqGISE9r2V7Q76zzZdb3+jXBapHrxpa1cfaBy+14lMmO?=
 =?us-ascii?Q?mlmhmHPXIv2Bz23QfrSwT0fIE2WjYWsxhfQjhkY7MEBUentLHJO1f2PMixi1?=
 =?us-ascii?Q?mPpYL2azqjgPRmWN17nI/mAgD3nn4aEgeY5mSfsfXgMal90qAmzO4JKKfV9Q?=
 =?us-ascii?Q?hAvfgNuiORJSKggl5gSo7HwP4ISud/VYSH1xwrbg4gKpTvJQei5WGmlivH8S?=
 =?us-ascii?Q?brderIzh056ioQXtpSnK2rX53wO2p2gwgpmmxF8y1oHGh+P8mP7Q1CYOzyip?=
 =?us-ascii?Q?VCkfGLu1kPcRHN40hdl5esRNNI4ZATwxiu3YXiUmZtUc0wfpwfUojK7aeu2X?=
 =?us-ascii?Q?gA=3D=3D?=
X-OriginatorOrg: embevity.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a0165c-7e33-4fbe-82be-08dba2dd75b9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4243.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 07:00:25.4268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 39a59075-037a-412d-8cc4-23a40ffb7ab9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ol4dP7BNGFHYnMG6wXVn8lWEBOVp0ZKlTY4SvU8J+ib+rMzNLH0pAOvV2SLGnso0+KduEWB10ISvKNAp6hCVTjA58uCqhMLJL5/Kqx0OXbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8130
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kornel Swierzy <kornel.swierzy@embevity.com>

QCA7000 protocol requires that ethernet frame length is encoded
as u16 little endian value. Current implementation does not work
on big endian architectures.

Signed-off-by: Kornel Swierzy <kornel.swierzy@embevity.com>
---
 drivers/net/ethernet/qualcomm/qca_7k_common.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.c b/drivers/net/ethernet/qualcomm/qca_7k_common.c
index 6b511f05df61..7bb7ae85fcf7 100644
--- a/drivers/net/ethernet/qualcomm/qca_7k_common.c
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.c
@@ -30,19 +30,15 @@
 u16
 qcafrm_create_header(u8 *buf, u16 length)
 {
-	__le16 len;
-
 	if (!buf)
 		return 0;
 
-	len = cpu_to_le16(length);
-
 	buf[0] = 0xAA;
 	buf[1] = 0xAA;
 	buf[2] = 0xAA;
 	buf[3] = 0xAA;
-	buf[4] = len & 0xff;
-	buf[5] = (len >> 8) & 0xff;
+	buf[4] = length & 0xff;
+	buf[5] = (length >> 8) & 0xff;
 	buf[6] = 0;
 	buf[7] = 0;
 
-- 
2.25.1

