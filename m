Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40143751885
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjGMGD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjGMGD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:03:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2117.outbound.protection.outlook.com [40.107.255.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747C52113;
        Wed, 12 Jul 2023 23:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTfzzzxpUa0YJ+WZr0cdc3l+jeGVARxI3fwB61QomPK21J8olxHCTZr8wsLj1GEsxu/OKi692EUMmJ5AeuqBHW666++e+592EZJH1iXuqiz08QLCvTbkDLR0tTsSaT0AcgedotlgOIdfCzkY1knNjCVXCDJaVPeofWBe0LBseZfvJPwmRSOWmx+jYwXYTxAf6NSPAzFE9veQc2CreSHJ3+Hm8O8V693N03Vo+wjUorpfWRMol+nR3fm4Nvsz64FMcBDlizvbeYf8+pVY0h3VhHER+U0iiWoTnmtIcQwQzeEYsNBtrAFhyQ1PMlxB5lBtTAHcPPuKDOJ1wrJvdsXmGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1ilo/VGq0uHDI5TNAOclk4A8wtrcXF7naaW60xWAuc=;
 b=CQGa/L+KB6Tc00SmqLicAzoQkudZ5vWC2e5d7cAhE9uNHgRzIXzzKKlK26sDu7ObQObFfYj8Txl1LFfimEvKm4t3Z+70dKb6PS+1VpQoPBUwNmo5JDaafEFQddg4HcJf/dikoRw2gtFa1ej462vfk4vm85v+kSp6XmfXo3yJD/JpBapHy134FpEYCHkpc1fq872K1HRBrAjqjQ04RNkZqZfaU9gHx62YV8vwA9vjorQ7i39wL91HKHCe5Io/1s+Nnl4I8c+qvcPbvih9ZkMStScOYdbu4gMT4dKkZAAOUQdE5Hz8vQR3zGfVvR4Cmv+V86iW1nI9biIDqkk8nAjl6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1ilo/VGq0uHDI5TNAOclk4A8wtrcXF7naaW60xWAuc=;
 b=DGe3mz+Ij8nQnH7r1oJitBGe43sKuMilFHzhSLVU+4XB+ltUm2hCYg3g0K+yqKR4C4VSAQDPnFLzb3KPNDyioTXDxkYGpuW2VtTh12jyfq255cGjexlfvdGJ2IO9iqMVRsc6+euP/1R3aT5hbhhow+oCKcG2gZmdDxLOaukuXD+X2gvfOHI/6xNUWxCeELkSoDzIu+qWckO5mk39WUz2//m9F1XDJ1ShK6eyf7JA1eUs6J6r/GcTlFFjpJ7MQ0/lCoq0POeHhrmdYdxjTh6oe/txG1T6zKACDj7fRK0wX+La7WM++hoz4ZaWob0Q3pYH65MWD5Pnu3Up701kjrEVhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com (2603:1096:4:d0::18) by
 SEZPR06MB5622.apcprd06.prod.outlook.com (2603:1096:101:c8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Thu, 13 Jul 2023 06:02:43 +0000
Received: from SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c]) by SG2PR06MB3743.apcprd06.prod.outlook.com
 ([fe80::2a86:a42:b60a:470c%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 06:02:43 +0000
From:   Wang Ming <machel@vivo.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Wang Ming <machel@vivo.com>
Subject: [PATCH v1] scsi:mpt3sas:Fix error checking for debugfs_create_dir()
Date:   Thu, 13 Jul 2023 14:01:06 +0800
Message-Id: <20230713060120.15330-1-machel@vivo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0164.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::32) To SG2PR06MB3743.apcprd06.prod.outlook.com
 (2603:1096:4:d0::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3743:EE_|SEZPR06MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 289dcc4e-7729-4ba1-c17a-08db8366c614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wsoGfuc2ijmsgRjk9hZVfBMLS0JYhocTROzi2nMD0WWE4ql761h0EuSatf2dQD9WGyLZqIxiaROBs7k2RmccJUlJswvfllzu3yGsFAvFhYt0kbt1PREvNvdv+jYKpbpLj6W1wlSHXJQiaw/Th4vOHedn+8ryxBU+zgUu2mLaKUEFzF77OMlKHcXbV9E2mVFlyaWfVSBvyJM2bTsFh5CrgD1A4n9ZXvZTeixpUecWUom7jZTyn2LyJpINRoRw2qT7JESJlo4zDk4jKb++sbKFBR8c9UZGLHvnDFKg1Oj1TlT7TkqykFcHDgD/eA271Yjal5Cb946qRMe7xv1EESUKT37ehfufgtWIggPMbMPzz9dQH5+Y+z2VTytVV2BZsCZBEo957MeS2UWWv/AMMPsugwYpKp+U/RHOJO2xqK0HC/ylIzFT4+J5WofIXlKnDRbzgJJtBb0U9ocvf+nIM9dkKef6qZGPbsTDFidDTY0D00lmJdMGLiOU6J9WrJzY1HoqCTfyj0uVkmNPXRfi4h5M0sl4T1va68ewMvJiiD4on/CBOniijIX6nzjMma6TEkc6ATQGqWaNqGXZ/89NLU+QR5ctxLFTKxPK4L+vd2wD0tYS8C0BKatpXcpQAJRH+vJ1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3743.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(451199021)(36756003)(86362001)(38350700002)(38100700002)(478600001)(6666004)(110136005)(52116002)(6486002)(6512007)(8936002)(5660300002)(316002)(66946007)(66476007)(2906002)(66556008)(41300700001)(8676002)(4326008)(2616005)(83380400001)(1076003)(6506007)(26005)(186003)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nxNe5d0Y7tkCkeJfLOkn7mIDxbW+QaL/NvDNyYwBnLqZ+3f167WcoJzLwSZs?=
 =?us-ascii?Q?aAcw2Ny/SCamK4nkg0AbJMXTg8/54YxUmOEBLxgYFBKEbV9uIAG1C09q+IG8?=
 =?us-ascii?Q?viNSj7LAPOKmFMwnRpCOPM8chvf4QjQsWsPXI5S/r2nX+AADO1wnXdB0XrOL?=
 =?us-ascii?Q?fbyls/GR5s9PDs1bdcpAKV9XLZ5zobwvMm5oskGRAmATzt4FEWltAkRcA58N?=
 =?us-ascii?Q?VazONX0BQ1E19b0Qhcdtfh4H4ILbTfiaItz1MERyGvqpK6rd2CRuvXb4GIp2?=
 =?us-ascii?Q?qTdScpB1z72+/7wBq+wnsdVhPUYKeziowItVNUzdIeLHYf4adR0XmusV0+HC?=
 =?us-ascii?Q?cfg7XBEw88WYkN7ujk3nkX/vytLl60EpEdYDbuQpUPHXlhO2MEflgLrTbmrG?=
 =?us-ascii?Q?dgHjp4ZaoW4HMNlMf9bbib81z7Fb9vAjxTCI21DaNOmV8/vp77qFCwBpJJmP?=
 =?us-ascii?Q?cGR7xxdR/BDvIXcc7co/iuIA6TVwHLuR4eLp9/65XmxT7mKjZ7y88khdIQ/P?=
 =?us-ascii?Q?xUdPOiu4IYL6aB0hC8x6Gest0lrsl3TZn+1E5MeEhNB1X1R7ORrPj8+FhVIN?=
 =?us-ascii?Q?joPGDlUrpNQ2kvWp2tbr+OlMIQJKPIjSNHMuvquSeU+cO+qKc/zH9gekKLiR?=
 =?us-ascii?Q?tyTyH+KM/UIkcaqF+NhTN50Yd5Y0WEm3L0T6ftNUT1iqvxnPU90UrsueRVrq?=
 =?us-ascii?Q?S3VIwl3couokuWcZy5qdMZj4CXOB3IN9bg3ESXS3Foomr0ORxULCxAV8Ch8i?=
 =?us-ascii?Q?eTKfQe7nQ20W1FQkpdZDNwpUdzTtw4WAB8gPDemnEf/mNs7B2M3pC5dfs3Ad?=
 =?us-ascii?Q?prsRnkpvptFsL0Th3BWdGLhZ+HR1SZAUwMsjwiZ2eIDN2WyL2zutNfGe3WTp?=
 =?us-ascii?Q?fSChdNeYl3M6XbGHF7pV/sP6y6DR85sABX0x+TCeKx5nwFt4mrZQvq3F2ljD?=
 =?us-ascii?Q?5Y9F8jVLyoZF3JXAon8U1iyxx8toeVZDwpUPTVPz1kIw2DlbgDB90y4HwDnN?=
 =?us-ascii?Q?4kytwLzxgOCGCMmAL2wLfJsqYDhfbXjv6Snoo1lxKD4qkRzcb+srhda+rDzt?=
 =?us-ascii?Q?KJcaNjJ5I5ErmRZxknu9ddO/nKlu/F6yrBoOr2GOBsA78h2B/SvPf326I9wr?=
 =?us-ascii?Q?bToSGd4teeTpBNi/OjLsTtb6pjr5Wwu26wp3unhHYs9iFAG/lpSffvnR1D9q?=
 =?us-ascii?Q?+M7MbEPlE4rmfG14eV9ctBkCOAxHq3PUQOmIwUDJ8XJsCQ+I0WD42onuUTWI?=
 =?us-ascii?Q?YhfLjFWdaCpT1CXJ0jGbkBv8bFy33roCE/jVZYnJotSf6jZoZk8XnaNKhc31?=
 =?us-ascii?Q?Ahixvrtlvobr9Efr+nzNdzw5e4bqb0oiWOJcaWU+XhNYbP/KQKxgNS5nYWiO?=
 =?us-ascii?Q?e5hS6T7x76fazLYLZX6ktOYbkuA3/L23FO3hmOuXTFd/xNMVD4zO0t6feqN2?=
 =?us-ascii?Q?EuatOcSORkQNVImC5ZJ8dkmffLzxo9DMeRbfGkzoJ9SCF1PETyTPh8tQy3Go?=
 =?us-ascii?Q?Sy0qciXejN9MDTcWivUrzgS7pbpts+Vnvekm32hIo63bERub31TIS3O7Vekm?=
 =?us-ascii?Q?DSSSpyyW0uo5Nd07MJIGtKau0UYa6smaOISpJ7n9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289dcc4e-7729-4ba1-c17a-08db8366c614
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3743.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 06:02:43.6991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02YUE6IecUI9zLeg1k8sa6yAQoWNIew4aYkNWqOFXluSlA9CkjhO6H04mQnOp/kh9ECtDuvZDg0kGfZDPWqkzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5622
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The debugfs_create_dir() function returns error pointers,
it never returns NULL. Most incorrect error checks were fixed,
but the one in mpt3sas_init_debugfs() was forgotten,
the other one in mpt3sas_setup_debugfs() was forgotten.

Fix the remaining error check.

Signed-off-by: Wang Ming <machel@vivo.com>

Fixes: 2b01b293f359 ("scsi: mpt3sas: Capture IOC data for debugging purposes")
---
 drivers/scsi/mpt3sas/mpt3sas_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
index a6ab1db81167..2ae7aef938d7 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
@@ -99,7 +99,7 @@ static const struct file_operations mpt3sas_debugfs_iocdump_fops = {
 void mpt3sas_init_debugfs(void)
 {
 	mpt3sas_debugfs_root = debugfs_create_dir("mpt3sas", NULL);
-	if (!mpt3sas_debugfs_root)
+	if (IS_ERR(mpt3sas_debugfs_root))
 		pr_info("mpt3sas: Cannot create debugfs root\n");
 }
 
@@ -124,7 +124,7 @@ mpt3sas_setup_debugfs(struct MPT3SAS_ADAPTER *ioc)
 	if (!ioc->debugfs_root) {
 		ioc->debugfs_root =
 		    debugfs_create_dir(name, mpt3sas_debugfs_root);
-		if (!ioc->debugfs_root) {
+		if (IS_ERR(ioc->debugfs_root)) {
 			dev_err(&ioc->pdev->dev,
 			    "Cannot create per adapter debugfs directory\n");
 			return;
-- 
2.25.1

