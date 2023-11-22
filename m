Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CE37F3C85
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 04:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbjKVDnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 22:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235050AbjKVDnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 22:43:51 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2108.outbound.protection.outlook.com [40.107.117.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B27D40;
        Tue, 21 Nov 2023 19:43:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/j39i+ZhYo4aedxp2jW/800TuKlxXn9EJRh4eKKj1Evy5PHWgc8u0nmO52VxlBVbgipshuBgfnUOB6wwajn4cth1tvXlWjWM7eP88x38wcRrU3WohkD/o6gUDqtVw6pUh/AZxTu7/ltyZo7446NFWUABYulcowRc/IOP+Q6x5NJNgIiGoudVDg7ntbbILxb4DyZyJ3StSo/mVR9NpNGksJw0s9EpAcpeXzu1ljCEpR2fs967+6NcB1kF0BLGekd7bZZsgl98SE77mTO8dfYZliawSNPGzM8vJOgBG7oxbZbHZK+mDN1yT4JPNorjiipFvst3gs+KZ2oSNk1EJsHcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zF7zxYa/iqdjwNaBWqKo3n/cQt49pxvEUHoeuOhUTi4=;
 b=eU/RviAohldrHalEbEF9gD7zc6wf6C+MzyoLvjRacNP/LPCJef/Ows5jfPu604I0lcxPBzdpsmcIy1hSxSy3kObDcwDlbeIjIAoedGtZs68Fq8nDpAK2NCkXEZz7jTP9qMAIyyymUZ9An+ESI8bK8urxI4sufBXITPyrGaOhNGp6zdUaw2k6BuYazkH5/+ghxFA6SV/RRsD15+tTajmWQmoWbIdgbl3cyxrCHIRulg+lCImFN6y1HxzDXm6+oHg0oFbYGMKTBAYoHXwF11A4frfPDN0RuVErXavme3njVuHdgDHjDi28pk5neGyFtSay+isZ2lflTzqmMI/9X2TI/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF7zxYa/iqdjwNaBWqKo3n/cQt49pxvEUHoeuOhUTi4=;
 b=BdOjx6DHWuzX4GjUJpZL/UR0awLzTlPPXbbD9ho5BgumwyFbX5HoKAn0biBs5ziehfvN7bLg5L2QxaK44q3UbqyteNsUY3RZcgJi2EET87xcF/gz1q3QY8tONUERyptLaLSAy56Z5LPHcpaOG7hZR4T1kaOBJkW+2ppUI0gNHpBAl+UH/7jj9c6RNPTU2y8/I5j3vacKKbJZukXPaFOqcd+qsdSkiwBfkN/CkMWRNnS3Nq5Hf+y7PHZpy31jRZycv4gcR/4POIRjPNHJgHQxuYHPP8/wK+Cfdw6N7JD/c7CAEWM+pB0Xrs+5qeYlT/OPb+kO+/wjNH70+UF3QvLn/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com (2603:1096:300:67::17)
 by KL1PR0601MB3891.apcprd06.prod.outlook.com (2603:1096:820:2a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 03:43:43 +0000
Received: from PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d]) by PS2PR06MB3509.apcprd06.prod.outlook.com
 ([fe80::863b:f0a1:3066:24d%7]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 03:43:43 +0000
From:   Wu Bo <bo.wu@vivo.com>
To:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>
Cc:     dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wu Bo <wubo.oduw@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>, Wu Bo <bo.wu@vivo.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/2] dm verity: don't verity if readahead failed
Date:   Tue, 21 Nov 2023 20:51:50 -0700
Message-Id: <b23a4fc8baba99010c16059a236d2f72087199a1.1700623691.git.bo.wu@vivo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1700623691.git.bo.wu@vivo.com>
References: <cover.1700623691.git.bo.wu@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0002.APCP153.PROD.OUTLOOK.COM (2603:1096::12) To
 PS2PR06MB3509.apcprd06.prod.outlook.com (2603:1096:300:67::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PS2PR06MB3509:EE_|KL1PR0601MB3891:EE_
X-MS-Office365-Filtering-Correlation-Id: 40514c59-c666-4e35-6059-08dbeb0d3966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mgJeT2DMxqVMa5/YhRg1iDWgNPEWSInfEMEm7R79T2PPbh1L2g51df5ynB48ExZ+L/Z1asefSVV2ijj8iakLZZ+jnGnFWdrRIOqVr3M/LQOfst4Ffehx66S2Slmrr7lzRPHOHThETTSyqhyP/xJZbRAu+kOFYSEAEXTHxh6SdG/t8szIuiyQVdXhwCmGT/0IaVDih5LjPeMKIfypeuAOMfFOLeD46grtWK6rFW1u0Ffs83vEv6bJE4sLGARfcQYxllgbfPYAJfdE6OmLigE3hhA2iTSb61586IzCWqqVKyaPDT/GcHDyCl7QjPPI2TW1qQIkCbB568+y62tD8S/vz4t3RIe8fo34a0g82Lvg4Qo0jTJHh52WTveBoEwYFFYZZwlp1ZEo0kDc2fsZU5kPwkRYsAN8IvGJV3R+k2TXFdqC8z/x4giyKKG8C5u1RLcw8J3B4030ma1o1ilwbxejIg4YB58auRTEUwec3rA5yGdpbW7FBcnm2AbTjG70V6HVt+dPjz/WyRnM/rp77zN07fvdOgQX7AKns3VX89DgMULN6D7Y6NpAoIlBnUyx+7STEiqWOfBqJ8W2o9aWBKq9i4QcEa2QJ6dHlcGxlRrVkqYc2HhoY/JOCMLcTUhbKGC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS2PR06MB3509.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(41300700001)(38100700002)(5660300002)(2906002)(86362001)(6666004)(38350700005)(52116002)(6506007)(6512007)(36756003)(478600001)(6486002)(83380400001)(2616005)(26005)(54906003)(316002)(66556008)(110136005)(66946007)(4326008)(66476007)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ptU2ksE2HAoQme9mEZ77rdVetDbehL6GAPQA8IdWnxCCvJZ4dEDycMSm2Lt8?=
 =?us-ascii?Q?3aichP6rRFaLkk0JHoMgbdTXUpitSuqyHAStQdsdrdfHpcr6kbHBdhoZ1Xs1?=
 =?us-ascii?Q?k1gozUDPr87vZyqI+WeF1Rd5seQD0j6RXGMFA6RHgeGXgpllEVfBzsSGeWD9?=
 =?us-ascii?Q?xgpNjh2YQxM+o5YFin3XhF4fX2yybIgbFBM7Dar4Y0JpbtCIZ37Rwt6OiJHy?=
 =?us-ascii?Q?elz6yYquuRetiWBR/h3fvv8zOUByhtVnGijTYHgjcByr/vzQNlBgf7tWGXMv?=
 =?us-ascii?Q?0I44lrAoPxd4xuhDyM/KBzRg/Txc9iPdQkVuB0GwM3OEhg9Fh2kbHvUQ1UgD?=
 =?us-ascii?Q?KJcMnaHma/SA5lX7i+NUs5NBLJCIwprs4VW4NA2Y/Fa+e0Bk2bEu/moWo7UW?=
 =?us-ascii?Q?ASGiliVVzZUnVS7Z1R/XNZcw6g7wH3B+e47WqNYaW5zUZzRa3d1K69xuqFul?=
 =?us-ascii?Q?euZeqZAOhRrxad+EPBKF1bipsv0aaBSP1Okr/asXPp4fLdHNqUVBLQAj8sZr?=
 =?us-ascii?Q?2wOJ48ose4vg/FY/GMgn8iAkiTvctHTt52edZ5YLXTJMZlOJNt6Tni5jLSOd?=
 =?us-ascii?Q?BE5xYsTOPytCcA2Gzsvacm3FggRL8xGkenrsjJ3F0OaCzhrDlqK7aKxwIe8P?=
 =?us-ascii?Q?D3c0oEK9lCG7AIeogcWPVDaecE13pJnxV8jaIpyKZ9Ovw5Tw2rPKrRGOv1ng?=
 =?us-ascii?Q?uA+mWS5+GhAyb+ctcUDbvLJIEm07G2BHcc1CWe12M+gXxolfWS4eZaAAm14t?=
 =?us-ascii?Q?8cQ0KaW7HK7U7hzsEie1oWDcxeD/efj2G2toV2Shf1R2+9UZjUs3+R79eVuI?=
 =?us-ascii?Q?hnbiGRfWFXoknM1D248m9kQeobZiLTeE0NTi64cdIdeFtEmddPvx9vZDFTlE?=
 =?us-ascii?Q?5k0jPX06SgD7RQREaz5lZpqs81eRulPq8g/HMb5F+8oQpbKt+1epCws3D+Xi?=
 =?us-ascii?Q?D4wU1tidKSVV1kIdJQ7QyMyMcL3XUjD7uLajG+CNevqpl26zuwhDspvDyn9C?=
 =?us-ascii?Q?/iIs5JP7YzMAaIkOtJArGt75yGEVQOfov1XAq9RKCErBtyK726HbK9qiJ75g?=
 =?us-ascii?Q?KCikSL7p7EuOUghhk4NUcpMRcXRptbM+nD8OYPk8pMFvSt7yeGsflVZksj7v?=
 =?us-ascii?Q?BeIrmZg++KYcXCXJxeYgoyBD52bnOpsjblFYHUFXyxitC9iMcpUo4xZTcy8b?=
 =?us-ascii?Q?jtyjOEmzH97iNDtVxH0kyF+mBlvTndFEIGfMzlzOFlvDVVSG8lkxDUJ13saD?=
 =?us-ascii?Q?8m89Rd/9MmQ1oBIEaEckrsdugIm8qwQ6yVcG8xBNrnUqIWKr895OM259n5kh?=
 =?us-ascii?Q?HnLNLASGlOZ7KuCSWhZ8tsHttloKOL/3aQIrhIeUm+wT2pHFG0rttN0Mh90F?=
 =?us-ascii?Q?yEe8LJAp28mY2DLMkQ7By63+tAT5BreuCVbfn6ndzXR9tFzDQ0WBFRrL/lyZ?=
 =?us-ascii?Q?Zi64Uhlhzd80PPkJ70Iokfs6oEg3JdVjfWmTQtvQrYh/URmNGRxdrz0jZgxS?=
 =?us-ascii?Q?KfYRaJmritrjrBCWOHhTFpMFnCalUQHpJiNoSj8LCZ/4tDS2HuJ+F2CQzKmf?=
 =?us-ascii?Q?zL9gQWGYvO/py6njVkpVmFLZMdfl+bBzcLWTGcFe?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40514c59-c666-4e35-6059-08dbeb0d3966
X-MS-Exchange-CrossTenant-AuthSource: PS2PR06MB3509.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 03:43:43.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4U1xo8kz7MxwC+C4P9D6TMi5qpVWI9sp55pn/W8DXbjm00E/nCI2svgZEGRSNDAL/INf/SYuXt2vEV66nw5vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3891
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found an issue under Android OTA scenario that many BIOs have to do
FEC where the data under dm-verity is 100% complete and no corruption.

Android OTA has many dm-block layers, from upper to lower:
dm-verity
dm-snapshot
dm-origin & dm-cow
dm-linear
ufs

Dm tables have to change 2 times during Android OTA merging process.
When doing table change, the dm-snapshot will be suspended for a while.
During this interval, we found there are many readahead IOs are
submitted to dm_verity from filesystem. Then the kverity works are busy
doing FEC process which cost too much time to finish dm-verity IO. And
cause system stuck.

We add some debug log and find that each readahead IO need around 10s to
finish when this situation occurred. Because here has a IO
amplification:

dm-snapshot suspend
erofs_readahead     // 300+ io is submitted
	dm_submit_bio (dm_verity)
		dm_submit_bio (dm_snapshot)
		bio return EIO
		bio got nothing, it's empty
	verity_end_io
	verity_verify_io
	forloop range(0, io->n_blocks)    // each io->nblocks ~= 20
		verity_fec_decode
		fec_decode_rsb
		fec_read_bufs
		forloop range(0, v->fec->rsn) // v->fec->rsn = 253
			new_read
			submit_bio (dm_snapshot)
		end loop
	end loop
dm-snapshot resume

Readahead BIO got nothing during dm-snapshot suspended. So all of them
will do FEC.
Each readahead BIO need to do io->n_blocks ~= 20 times verify.
Each block need to do fec, and every block need to do v->fec->rsn = 253
times read.
So during the suspend interval(~200ms), 300 readahead BIO make
300*20*253 IOs on dm-snapshot.

As readahead IO is not required by user space, and to fix this issue,
I think it would be better to pass it to upper layer to handle it.

Cc: stable@vger.kernel.org
Fixes: a739ff3f543a ("dm verity: add support for forward error correction")
Signed-off-by: Wu Bo <bo.wu@vivo.com>
---
 drivers/md/dm-verity-target.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index beec14b6b044..14e58ae70521 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -667,7 +667,9 @@ static void verity_end_io(struct bio *bio)
 	struct dm_verity_io *io = bio->bi_private;
 
 	if (bio->bi_status &&
-	    (!verity_fec_is_enabled(io->v) || verity_is_system_shutting_down())) {
+	    (!verity_fec_is_enabled(io->v) ||
+	     verity_is_system_shutting_down() ||
+	     (bio->bi_opf & REQ_RAHEAD))) {
 		verity_finish_io(io, bio->bi_status);
 		return;
 	}
-- 
2.25.1

