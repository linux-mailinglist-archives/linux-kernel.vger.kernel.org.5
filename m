Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABDDC79A316
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 07:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbjIKF6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 01:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjIKF6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 01:58:35 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E0B99;
        Sun, 10 Sep 2023 22:58:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBxcqyyq55WZXj9NQHzYVXdakNRzBykeEkpgG9f+9XDIn11xHODR5X5G1+XOCns01ehKoGbKLzTLBZeethfK1piiFj0lwfsqxvTXzhyzRhs87reSCl6Ou1KhUcQB0Uw0eHAetfs8omtIULeJa+L/AYxAZcsoBfMXDOkeqARrpWgLYQ5/v2SotkdeGa2ONz349HIGaK4GJ0KLReKowXU7LGPyGaX9igRaJbKO2rq5XJD3FaJwSQBnCGLBpnypfDzqSMgBFBhwdSPwul60KsMzEvjNbC+dzsU5AEIWQd86i4BcK3aFCp0IFZwCvnYugFazvMJjckjFdvCR/MSNdUrUNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u11Ub1nkRoHi+c9WBPQqyAjLUT8sD5PY72jL6MwLuPU=;
 b=Z5auSptO9PCvmREN45mne5+4dDXJDmr1vjwhN6/kc/R+ewQyeL3LeFsZ8GJOo3ISFH3a2zL/hVD2FAdV1G9/0Phv1sbREjAJyXMkxwo7VsKxTjnpoATbbTyhHHIbEFEohW9FNJIs0il7JsF2wVxb5IhnRE4hBew1Deqbd8FoaAOwFzO4bfn2fU+SyngiVVDsZDLRO9msSzgNthlj8dR51yMan0zsX6dNutjwFGssLhSjymqQechDAo9+goETEb5/urHekF4h0odQ8oP2p3bKQovNla6DBuNjxYhZp5HFquxoIhhMvBViLr+9ey3KVYUzqjRHCn0aqcvXk/bWUNaX1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u11Ub1nkRoHi+c9WBPQqyAjLUT8sD5PY72jL6MwLuPU=;
 b=QjiB0YHyE2HgBMhuSWu7FybLMY7YyX55otMnu+6yVeGYJzYjiA2LEz1Vih+kU8Q7D6alOBhMKVau6jLRx4kf+3wBD8tzujSw9LyfLS65tpVXsMoOTzwgaOCQ5yuEWiJ3Wmtse6tx7MObO3JRewWMnAwQICsxYXLRsWBs7YpeUAUfnmlNyWfvPhdOiaI3rOfcBbuxCqt8tNnqFPiPajHJCoSgbV4OkKvbG0ABSAcjXSW6raD3NhBjoZSPv41qU/Qu8p0XDrntiUhOFvE0OaBtKqr1VBYm5BLL7fDiyxnB6s3pbVIV3bH+nXHq+/Gj3SKldF+uxDqEYfjbu0qr8eL0yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SI2PR06MB5170.apcprd06.prod.outlook.com (2603:1096:4:1bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Mon, 11 Sep
 2023 05:58:24 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 05:58:23 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lu Hongfei <luhongfei@vivo.com>, Bean Huo <beanhuo@micron.com>,
        Can Guo <quic_cang@quicinc.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v3 0/3] scsi: ufs: core: support WB buffer resize function
Date:   Mon, 11 Sep 2023 13:57:05 +0800
Message-Id: <20230911055810.879-1-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SI2PR06MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: 417aaaa4-92df-406f-8765-08dbb28c1bfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9ed8txoEEu5vfHxEKkex3i9Ret5sPquM6qbOLNGJJwmzvmBN8sSSsTBLmCe08hSUbKF75Q2xLMnlkx3CchfdDTzhWxEw7OpRHeY8LHrYfqKjAptmMPYPlmSIaZ8f8B/ZMsE+ahbwC7Xw+Akis1f8h6YXmtaF4p/2Qiu24FPYAr7t5qTePNngih1AzUcjYAZzvbxV/+lrzSO70SrXmoxAygsMiwqhk7tLeBdezs8ASJCGH83UT0oTmLdtaA3MLZb1m1nShwYwrkaCsGTNohsJNvQpQ+RIoo98NHxv1rRPy+P/Ac32ThuzHjE3vMSGlVPRtDvJjjPsAc/EDFMfk7fXjxZDG+okgyMAtpEQEfD7mMnaZx021l8lW3wemuQ6wR8sH8NBGwLuyQBVchCAksPQTSUcperAbiw9n++BFaD3LvRLYJ7ArhvzzFrktHwcHibHe7tTIFRFmlOSvW4qxRAzIfAZadOV1rwA2jux2xRLv/1s+yOhUlTc/HJE073iv/dbDLwgCcMHLAI3VY9B5QlEtYecIj2eM2i8yr6wPSzzIJdVRlLIKsdQs3mubhhdOB/hglJvmr2MrNRDmkZ42kzCJkzkICvZ21UilkRfUiN5Ek43n2HuX4j2eTfWOH011MST
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(186009)(451199024)(1800799009)(6666004)(7416002)(110136005)(66946007)(66556008)(66476007)(478600001)(107886003)(5660300002)(8936002)(8676002)(6512007)(4326008)(26005)(1076003)(2616005)(83380400001)(41300700001)(316002)(2906002)(38350700002)(86362001)(38100700002)(6486002)(6506007)(52116002)(921005)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FX/mvzfCtq5dg6pJW1P/CJDubbsdBRJkfHkueQZZmt4xltgKKuFArjgYW3/A?=
 =?us-ascii?Q?c9xqyrUgLgPp+/pIceIkp8fGWDcugIPJRBlVl6IIvPgnDIDJxxWOzZdZ9p+7?=
 =?us-ascii?Q?MLm4FyU/kNnkNNL+hlF1O+JboVHjTqkfHdE6l2bb+PG8QzwJQsuTZ/Gwau4r?=
 =?us-ascii?Q?yKW1fSaTy2mOao7+y79pSOvnDeXP4MVVI8Uk2Di/CSqMNJUn5JubE8Lgix2M?=
 =?us-ascii?Q?x7e2sewxraV3t93iBd36MLy9lNjrEX0srIQyyujTEVoJxVfIwBpS3yY9RqPz?=
 =?us-ascii?Q?8cvcdBKtuY6J1wsY7i0XoYdAlX99YeNLnut5ZV+UfrUnhHeER7YhUkoGmBqy?=
 =?us-ascii?Q?vmYGcD6ElOxZoLIPoJJ3X6O7fxZGZFh8Bd8tYfZQ/SWejexIsVafSpHpEnRm?=
 =?us-ascii?Q?g0kfqL8KeCieataprUr4jY+TNij0MgRiVZpe0w2d9zCgTMYodafgShvXDJPH?=
 =?us-ascii?Q?ihnreQggiJgiYEUXpwSOtFDU4XQ5towViakRcX/FoLrw9mWqk7zz8vW0gxP6?=
 =?us-ascii?Q?NlJUBoY/BQrOwgb8HtN8nJsOf4Gx741BtsmMTUj1/zH5+ijnjIziD8tueW+0?=
 =?us-ascii?Q?obONR/rna3Z3Bgs0kkMl7Il0fR06Mg5YKhb5DYw+dfNrSoZp1Xfaqpad9mC2?=
 =?us-ascii?Q?XJWrRk6b2JBt1gZpy17uOLvhq0zOUcCDN0LQp52d3Ke+cf0x2LJ2RJ2wMwLs?=
 =?us-ascii?Q?5aqoCC9EDsrvb6TJPAl3ABXhPoY+DIBJnYU6TApnuYtpYH0mXmFZ+5mYjBlh?=
 =?us-ascii?Q?kZJTrRiRfZDlM7D/l8dghY6bbEZjmvoHRMHX8jRBe4ESmX8HiFXJ7JqazG2d?=
 =?us-ascii?Q?DRxtut4PhXUmMXbSFQdaRlApBWekkcyHd+ckkaS97usTEQjWmD4yScdXgaK6?=
 =?us-ascii?Q?emEupf/rYdX8nv9+Dkyhxkx9EGBt9AQg6tvWHuOPOLGsFN6DBnmhvfJApyx/?=
 =?us-ascii?Q?KDSWCoIRZScMPAKR2dym72t7dWZr6hM7ECPDJjps3xoaznnWdigAb5bwtjRX?=
 =?us-ascii?Q?fTR/iuCz9aF6FBBpF68nQkz1v2WqP6ZkVaoYC75EVWrOWzWgqKp/F8hJy7QU?=
 =?us-ascii?Q?UwIbp25Z+5vHyzjwfDjti6o+WQzyfvTr8aE4R+IkEiSsXgvDg9MXK1Fl18EQ?=
 =?us-ascii?Q?7ukIS1JEfwsnTKknMi375XNo7WaAi+/PxG2aezTI1tFG8906Et9FWIdto6K8?=
 =?us-ascii?Q?mFYk/kwPspm91L6qKTmSULnjTnyzg2+y3dR6QJoeFCNO2qgm0vWJpHlD4QvA?=
 =?us-ascii?Q?jW+FG5ko7Boqg/nSmLLSlANW4mUFNeMzDxbEG8D9bAPaX8xocC0ypvP1AV6Z?=
 =?us-ascii?Q?83F2CI5PjGkMXQlstuYRrRQBwBOVFw22tG8XgdOi7ecvpvusmZQu9+LEGaMJ?=
 =?us-ascii?Q?hU0tGLuQd2DNLO4m7aBsaXHALU8fSZgNGhncYWe8enS/QOwdy/Jk2YUT6AqM?=
 =?us-ascii?Q?hlVg4/J0QKh+8MRsJM8kXgvtuwJC2H0CPej8qFsCLL5V1EUDSS5zHwZtMVZn?=
 =?us-ascii?Q?8QqmjDhIq2c5hJZi5mSjKjNHdhJV8RjHzjEAyl8cfG9BnD3WMVmtWX4xvJuu?=
 =?us-ascii?Q?K2j8jkxiYenIzg4qqfE7NnHWn3ZIcJpKF3S2aBjA?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 417aaaa4-92df-406f-8765-08dbb28c1bfb
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 05:58:23.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlpnLCtH5ezbO/IJRw9TdTYWi1YUpPCVcE2T/y8CnGCO86L5/LYEK4rXGGCwzYWcD3f8IhO1lhKFo+0iyWv+gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5170
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In August 2023, the ballot for resizing the WriteBooster buffer has been
approved.

This v3 series implements the function of controlling the WriteBooster
buffer resize via sysfs that will be supported in UFS.

version 2 changes
-Using sysfs to control WB buffer resize instead of exception event handler
-Removed content related to exception event
-Solved several issues that caused compilation errors

version 3 changes
-Removed UFS version number check
-Optimized several function names to make their definitions clear and easy
to understand
-Fixed several formatting issues to avoid reporting warning information
during compilation
-Removed the ufshcd_scsi_block_requests(), ufshcd_wait_for_doorbell_clr()
and ufshcd_scsi_unblock_requests() calls in ufshcd_configure_wb_buf_resize.

------------------------------------------------------------------------
Lu Hongfei (3):
  scsi: ufs: core: add wb buffer resize related attr_idn
  scsi: ufs: core: Add sysfs attribute to control WB buffer resize
    function
  scsi: ufs: core: Add sysfs attributes to get the hint information and
    status of WB buffer resize

 Documentation/ABI/testing/sysfs-driver-ufs | 52 ++++++++++++++++
 drivers/ufs/core/ufs-sysfs.c               | 70 ++++++++++++++++++++++
 drivers/ufs/core/ufshcd.c                  | 15 +++++
 include/ufs/ufs.h                          |  5 +-
 include/ufs/ufshcd.h                       |  1 +
 5 files changed, 142 insertions(+), 1 deletion(-)

-- 
2.39.0

