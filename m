Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AB77E02CD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376371AbjKCM2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376270AbjKCM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:28:22 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2065.outbound.protection.outlook.com [40.92.89.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F131A8;
        Fri,  3 Nov 2023 05:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbTwa+AfGqcIW7yYxTMX2js5S5AbaDwPYYzFu+mIyXbVqUpbJJMa2Mb6E/0i30A+ev8iIxS4jI7jIhwA7Ec5jYMDQ+Brv7fvU7gUaWeBhKYFBJZ53jsRJaUwrPX0JXeyIdpGeVRuunrABh7l94GtyX5Je79d/7uCmeIlo7Z1kcYSwvtfXADKJH+LXaVv3aFnxmHy+jyVmz5P6KDRFWsMug3/4/7ecsyWH2thVg2e3mBN3eE0pvTJnxq9zTQaV2+B7AZEZryfCMRGJ7MFGOE+Yizg2uLuvaymK8psRHp9sY4NAx2wnkaOB9iZ/7gjfsK3XUAO03ntT3d+5YX5MJTlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0y5qiJxKQlTXRK1p0RZpjs5R/99wSgAnj3d5FFrS70=;
 b=SBfWBxdzdOnsN6RlbWdE8bxJ/qBPRez51GVQcUczGvZaORZXvwXbX3MZ0RODlhpfTYFU/8Zx66RErvhf3RoAB7ln5NkjAjKNIhYWm3+it0zkYIcycihyNaBHqxGlkY95zKq/zRmW8As+GUid7PtpLkah9zyBVDaf7s05jvu2XarFe1bLqZNBeFPgNu2IgKZdd3mVlcxt2LMbx5bh/rfySrjeJTDy59EmvclfwrqRMEDOZKON7F+Pu/+vIQqvOk4kHBMaJcRbueN1ROcAMWkYthUdv3oQLjPwF/3Iqq6V0/51X1I2+nP2RdGcQidAABYnS2hGXOndViBYfuMucL/TLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0y5qiJxKQlTXRK1p0RZpjs5R/99wSgAnj3d5FFrS70=;
 b=cVe+fRNbmyLFnk1C6HAYspd4AQ+33guS9qKfZrOyITw+Q/Ltkq1LE6nG7SFmxnDJjocgjE9U+/CD/WD3GLTo7WZRO2tW4tWpDxC+S15PJuUcUZet5pt0wgRiA6bmfx3/THgK2CUvSMH6LF9ejcn1hGl5EP8d46i8JgW+NyZKBTYYZ5O6oiY0qnM4sC+RJ+0WNZRFzyP4Gu2vET7sAwlpWf5hBaqFzTSMm0uwR9R1fSg0CAANUqHiC6Wr/biYs19OZjMOOGP0FwSDNqXTvsF+8GIe4MsEXFDQsuT+3IUTGT/HRbELlro8YyWVGc3ebpWexoAoH1g++01ktUSS2qIOOA==
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
 by PR3PR10MB4112.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 12:28:17 +0000
Received: from DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97]) by DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e2b0:8d7e:e293:bd97%7]) with mapi id 15.20.6954.021; Fri, 3 Nov 2023
 12:28:17 +0000
From:   Yuran Pereira <yuran.pereira@hotmail.com>
To:     davem@davemloft.net, netdev@vger.kernel.org
Cc:     Yuran Pereira <yuran.pereira@hotmail.com>,
        justin.chen@broadcom.com, florian.fainelli@broadcom.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] Prevent out-of-bounds read/write in bcmasp_netfilt_rd and bcmasp_netfilt_wr
Date:   Fri,  3 Nov 2023 17:57:48 +0530
Message-ID: <DB3PR10MB6835E073F668AD24F57AE64AE8A5A@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [QQIafjqrQ44oIrSesDFq8zjzpV1pHjFv]
X-ClientProxiedBy: JN2P275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::13)
 To DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42a::7)
X-Microsoft-Original-Message-ID: <20231103122748.1615386-1-yuran.pereira@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PR10MB6835:EE_|PR3PR10MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: a7768b91-ee06-4bf3-e0f1-08dbdc685b6b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xm6eHKEQYhq4LdgDlTZtFUqy1/x42LYVmQviDkJj1Dt6ktHPcaFbHY+G4cfMqKI2dhOIg5lZiyWbGGR4b5dgIzey+odQ+krC99sSkpo0Rd6QbE3oV13AfT6jNwlB5oFQuXYyoNS9iJlCh9JWemt8P2sr4onEWcUz0AeriCw1OINRLlnKeBol0MCeYbHOpVbh26OzPMTDWBH1YaLJ/zf9emROduQ82dU67QVTpCi59ywgNL9TaRJ6Vq0XJatL6XAZRkI+hvVn/eD1+qDh62+QszamjTei3ZiOdcR6M13wN1piDzsKNgjs4rTSVDznfwvpyEgAylfmiGQKpElHEJhBryNNqftxw3JeqmgbB2t+eK1KDuI9hsnIjzzCWFt5WIy9u00p6ejhXrgQMX7qjadBIaaBubgbwPN5GABiT0Ir9jLZODSrx91WcN7JZz8gO1FNFZP52Wx7AaauHkyQgkOPECSTzt1E0mzSbsh2Ny1Xq0PQuzM3IFeUMAXUchI9iN2hNte+JEB5CUw1ryB8hoKcfDcT8O9nKLF6CCTUGZ1cVF5XfdYHU/AKoc54GTNqLyEuhdNyzEpNyKhzIBRzXA1EzAEu1tzl/JcWR6vL8f6797eLRaQlJKFjCUnJ2F8v4KM5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JEiMmH8DJ0Kk2rcFMk8vmyTHUVv6z4OrBBCRO00IvLTZn16uwiGEtVb5cR9b?=
 =?us-ascii?Q?yFDOEqjw/IM58Ngahn4ptaKnPJkjPPADCkKZdZmGZ+zAdfvBROVS41Ra7ZH3?=
 =?us-ascii?Q?HhItjLNCFdJm1VlcvEV+aC1g/dJ3hosDTDYJqNLUMyou7PmGT+MaeDbqlF1b?=
 =?us-ascii?Q?YXwmQQ3/6CqFPyt/z3aY5UEUKPiEIjvBglgf+d5nry4fl2NtBA7PEwMnI/56?=
 =?us-ascii?Q?bLK7bSdN2k08x6WBXXR7ujf1P7lOzOME1VqGOqWJ3oDJ1fsA93ZCaJh1ALKg?=
 =?us-ascii?Q?k5LMIFBcLUh7qEGU7t7ZgN6+H2LAFYMjWgz7IY/jhuhVxEqnPzClW8V6v1Zl?=
 =?us-ascii?Q?NVU3QwYrFNLDl6XJu1yBhxhCzOTg/31lyYg6sUCVRk9+f4sZcGxDkmsblXNB?=
 =?us-ascii?Q?GIiNm9UnKZJof3wOHVvmhjr5Hl7YIK7sjFdTEDJD9rM6Uvoz4gRa/mYDLjaJ?=
 =?us-ascii?Q?HuWfCLbs/hTnQXmRuCwQ999a29EeXfjNwXCZihaWqVB8tDRLt4uSKdPkQMwQ?=
 =?us-ascii?Q?34L10l38W/HzvQFX2hmTAZQmOBCCis0m3QS/KHg2mo4j3ttPNWU0uoQzxm67?=
 =?us-ascii?Q?OaojphxqbqcG39DYp2ZlvNsMU0fegQlTXXfVBnJ5neBr1hlVWyMeBtqv1OtG?=
 =?us-ascii?Q?WPACIAYtgdxS76MOobvvopLxowfHxmNOTAanF6RXUwborToL4x4s5Fgzz6x9?=
 =?us-ascii?Q?WnX2k/WOtxfZMD+zQEaTecThC8ALUlKl4Uk/k2b3f2mC19eRMVwt+NaVwyMz?=
 =?us-ascii?Q?/uCChL1MbtjbEFv2o39grhEJL8CXL2wpiJq6AG/W3pA4uoyFB6wAe25AV6+w?=
 =?us-ascii?Q?gYNkEjhsX7vFcidaiW2C+usNe0gY98zlPOh5E5ffJUw6J8tK+3f6ADwcbMvO?=
 =?us-ascii?Q?qaY1grVrVfRVZRkA+uhp3WpqYUBwAatCzW/eSk6aP4mZRH0di3GaIoTG5chC?=
 =?us-ascii?Q?MnMk0bd+ppDdgJ+nyS6kvDxdXJbMkdurKTbSrHDPNfRTTDDW9fm/0+jwuOAH?=
 =?us-ascii?Q?67VX5LNqVmO/IaAUGB4pBK6fIsJR8rIhdExO6FlqmjcOb6t0H+y06oGoMOhk?=
 =?us-ascii?Q?ODhSPO4XGZAkTc5n3aF0PanEBd9TzKflm1PmSrwPnoKcuD54Fq7ckoN+kthK?=
 =?us-ascii?Q?paIXToPoCzKuBoJBlkBXqRszIDQ9DrF0jQZhU4GcOehISewtZybapnDmQ3qZ?=
 =?us-ascii?Q?HY8x4RnsmMzPfKuO+XCRVPZuJJwmTn1Iw7PD6PdsMSoFnTnHvy1H3qAIY9A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a7768b91-ee06-4bf3-e0f1-08dbdc685b6b
X-MS-Exchange-CrossTenant-AuthSource: DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 12:28:17.7015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions `bcmasp_netfilt_rd` and `bcmasp_netfilt_wr` both call
`bcmasp_netfilt_get_reg_offset` which, when it fails, returns `-EINVAL`.
This could lead to an out-of-bounds read or write when `rx_filter_core_rl`
or `rx_filter_core_wl` is called.

This patch adds a check in both functions to return immediately if
`bcmasp_netfilt_get_reg_offset` fails. This prevents potential out-of-bounds read
or writes, and ensures that no undefined or buggy behavior would originate from
the failure of `bcmasp_netfilt_get_reg_offset`.

Addresses-Coverity-IDs: 1544536 ("Out-of-bounds access")
Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 29b04a274d07..8b90b761bdec 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -227,6 +227,8 @@ static void bcmasp_netfilt_wr(struct bcmasp_priv *priv,
 
 	reg_offset = bcmasp_netfilt_get_reg_offset(priv, nfilt, reg_type,
 						   offset);
+	if (reg_offset < 0)
+		return;
 
 	rx_filter_core_wl(priv, val, reg_offset);
 }
@@ -244,6 +246,8 @@ static u32 bcmasp_netfilt_rd(struct bcmasp_priv *priv,
 
 	reg_offset = bcmasp_netfilt_get_reg_offset(priv, nfilt, reg_type,
 						   offset);
+	if (reg_offset < 0)
+		return 0;
 
 	return rx_filter_core_rl(priv, reg_offset);
 }
-- 
2.25.1

