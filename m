Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF17F755F34
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjGQJ1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGQJ1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:27:11 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2092.outbound.protection.outlook.com [40.107.255.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7242A123;
        Mon, 17 Jul 2023 02:27:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3cuiwpnJd+vt/widWhUzA/8nSK6zW2+nkxYHoPOSIGW6Pnrck9fXeM/94GQn9EGm/ftayeqOLVX/+T2sugdM3Uf5O7DYalDefzR7IZTJQNGaAJuKpQAQY/gK4cka3mrSjCjZqRLZMSUpyUMQ6jSCY/cnxEoUN07rZRmxb27LJKAag8i4TsFUZILlPSbsZyznz1aD1BGlXXhQE3kWjbZAqb5Qj91gfO2+eVrtP7AIA3SdL5au3VWfLeiZsosH2bkW724D8BU1+iakr7rMg9Tom3ykziz+kE4YB5L9E/xY8AMmv3mTkfSxXHqI4GiYZmruTC7gHsPjTDHQX4P5kwVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aT+EmTIM5+5KB0FEDiM153IWWv3fGKE5EhSv3s7zMOo=;
 b=ORTIEasmnkwkzTCoJP1OBCfLMtHfKG4fh1imJuxrLJeAzZDleth7+sN4snkEXTsQH1hxyh9hGdk2lIxQtqwDt/LEOYaNAMjxDBZABFBfduima4jvlGU3TQJsYa5StbkdR2UFYLGrXVEGdHiTok4SHjej//oCF4RICPc2/WqxPja9IMjie3orb6r/y5YjeDnH9HSARlnzNT8vxun5hcYIauic4RXlLS0NXkY5+EcXNRdlnKByF7RQBVG6QpxT+krwDejGLt4RAOYkXD0yIyB3WyBesaAfxvEcs2ljMdKu9zBxC50UpVlg8DCEHB/RRq+5W2izA7vAei8K1fnRIBCc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aT+EmTIM5+5KB0FEDiM153IWWv3fGKE5EhSv3s7zMOo=;
 b=BhiRjYd1j/piTIkPiA3MB4gYmPL57CBVu3+Os89NhROMk8AanGFy/YbgIK8fSb8GIx8t7JnOFm1VBWlXtcGhYVAkcWqHNZtaALNB6eu5Z/uHsxdIvTQkI7i2nE0oe+xEOo+gIPwmyGZSWuv2cYFaHLaqem8ulk/HFX+Ukd9WlvEV2chHweSXhk2RJoCbJpkmRdloq4bTX5tG9QlrTMgPgMNs8yQ2KVNXW3Ko4W3V2v0VCl7g6Y7YaQ54Nf7jmWc2AWusS68aXhoOZrSgG9btaACiVbQoGcXICKj1+k7rU4vORjB7wPbZyxofJNdzO0BwUbUHCPxEof3m6ndVfROVqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9) by
 KL1PR06MB6273.apcprd06.prod.outlook.com (2603:1096:820:ec::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.31; Mon, 17 Jul 2023 09:27:05 +0000
Received: from SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a]) by SG2PR06MB5288.apcprd06.prod.outlook.com
 ([fe80::f9b8:80b5:844e:f49a%6]) with mapi id 15.20.6565.037; Mon, 17 Jul 2023
 09:27:05 +0000
From:   Minjie Du <duminjie@vivo.com>
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com (open list:ISCSI),
        linux-scsi@vger.kernel.org (open list:ISCSI),
        linux-kernel@vger.kernel.org (open list)
Cc:     opensource.kernel@vivo.com, Minjie Du <duminjie@vivo.com>
Subject: [PATCH v1] scsi: iscsi: use kfree_sensitive() in iscsi_session_free()
Date:   Mon, 17 Jul 2023 17:26:57 +0800
Message-Id: <20230717092657.9776-1-duminjie@vivo.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0157.apcprd04.prod.outlook.com (2603:1096:4::19)
 To SG2PR06MB5288.apcprd06.prod.outlook.com (2603:1096:4:1dc::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB5288:EE_|KL1PR06MB6273:EE_
X-MS-Office365-Filtering-Correlation-Id: fb03584b-2a78-4ee0-6032-08db86a7fc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GgHQy3vRPACvtrKFUsa52fhRz5iNIbRNErHoha47gRIs+wZRGE84F0Zzy51FV7Y2oAGNKGSt4DfFv7MPEAIbN2iYETvuyuglb8dm4iub4D953FkhWhMgOCR0D9Dro2D9SIFHweAwZj281VPxJgdFeW0AERELR4Xx1xbdD0PHzGm5UBKs3oDhY/0fbSsQOLdjyAwUIePiPMRIhp2/jgNGqytGxcEvHvtbT5A4/OYvIG1RePeZVHGaf0IC0jPd6fthFcAyem4pzYjiV8FUaqi/S6rTJYqvu6xVT/jmljcu6nc2LkfoiJfxfzq29abN/YOoVIl1OxNEbFsGGPL3Q4FPjmqsY4cDvtKikGsB/MCpbXqBX988A+L3UiH/0rSMBYtvGP9ABwj0CjdUQpmMd6VcAnX+ULs7rC05tJk2HR6BH/lb5BMEdaTRgxf/Z6si9r839IZrZ/YeKE/hTCQde3+ECabywOEx6VPAceDn1ROsB/R0A1VTSW2dfKUOpRoZA+tazfcHqRAqyebpgryT3tetKdoUY1nlIa1MVtxVmHFjMvSkPtlft9C0goYrDB0Lzl0L4i7UdNUEQGyXON0YUxgfLbQPkLSVetwmEzkVSNpeK4qWtZFu/rWS/UB3GwUt10xo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB5288.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(451199021)(83380400001)(52116002)(478600001)(4744005)(186003)(2616005)(86362001)(6486002)(26005)(1076003)(6506007)(6512007)(107886003)(66556008)(66946007)(38350700002)(38100700002)(110136005)(41300700001)(2906002)(36756003)(6666004)(4326008)(8676002)(316002)(5660300002)(8936002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8G7M/CcFAo+OqYUWsmBMaftxmUh0NAAHdgTTePgeKettQQVRKlxSpvxiWYMX?=
 =?us-ascii?Q?jhOzrag9evS4j+EflIM0U5zz2+3CkI+s5OC7aUpfMng34Tz+bVnYNvBrm3vs?=
 =?us-ascii?Q?UdVnMYJvy5qMo546NoOs16/xdDwiVr3H3IDo1pYqZrxGRYfjPxkcFXL6schn?=
 =?us-ascii?Q?1x2mbw0qhgJddn/WDbFKZfT8llaM73ozMku9zeiuLoM5sWhauwaCu7moWOmt?=
 =?us-ascii?Q?jY/yK9Rjk+1aTvxiDNsEhTHO891Fx0kWmsavbcoEkbDwCOSHdwNB1Nx0sQve?=
 =?us-ascii?Q?5BaJNS+YLOdQ6IGFNP1TSnNc7f3zry8yAtelC5m/sgnyK/EtkEuDte5XhL38?=
 =?us-ascii?Q?pGvdufgdelFVUR5zcQOzSr43oWKI59Kc2yK6+oreAYwcwPGhpUxdXpA97O96?=
 =?us-ascii?Q?kkRwBrf3kQjY63pgVOhfxbRF0aqWOJ2YpbQ4mfFJHTL6/uCFAoF2ZfGubsiq?=
 =?us-ascii?Q?E6hkc1R/sf0SD6CmZpblX5has8VWwc74lgrvMAgXo+sw8bBoQHkQ94NUeVAF?=
 =?us-ascii?Q?qGi0GDo0/0+jYqoTaL6IBdG5S9YYI1Fn4EU/rNNscLV3Cd+e+66DIs2taU3Y?=
 =?us-ascii?Q?MvxliNQ30h2NeXjye0gbWZlBVSidCD4OPosOLIgH7hYBvCv4bYlhWo4Q0Iep?=
 =?us-ascii?Q?Hd6HD/IPszHy58Yhd3CrBZ5fpIDyTTtt4Ft7TS9ZtkV7szqla1KD0R2okHIh?=
 =?us-ascii?Q?oucumLdPz82VlEt7poaVXqBM8pSniTq/GD9KeD71cnS0uYh1jQInjWmXY1mX?=
 =?us-ascii?Q?xDag5PWZ8sFdcNhTx4xJLd94N1ClFzeePMTlhHOaWQ8BN5CR5yvwwCb+oDTF?=
 =?us-ascii?Q?9H01SOFVlDFl0+yE2yr30tLLN84yFEVYSF7/42Yyy8lA3mxqYU6OdDyC32ID?=
 =?us-ascii?Q?uzcXSckKto3sJ0a6sLF8cJ5SVbX+LvKyhaPQa6WQPJib2VbbLh380SJ+F5g4?=
 =?us-ascii?Q?YDjtmR6S3fVaDMa2Q9qCGsHy7L7qKnCLNh6nqQSOf8hhK18rgaNghIa5IzOI?=
 =?us-ascii?Q?0WNW2T3I+mP3yCvfBEWQ6bbIye+MFkQjilWkN11QgGU1CWgFOlutbdjFm369?=
 =?us-ascii?Q?d7P5Ngz341hxjLrFIBJy3+TpUK52lZGqP59Qo9KvIRoDLR4W5YFqTjQKrE82?=
 =?us-ascii?Q?yQ692c5LYhLJSime5yAVYJ4drr0mxY6rzT2b0zzzdlCDZ6XkUMmiBS+Ld5d4?=
 =?us-ascii?Q?Nlog5hd0yZmtoAGa6pvHRT5W7SuuIHBfoTc3hE+wtjRu0t8D2mFWKaUjPYlc?=
 =?us-ascii?Q?lQ+Zm480HHRU/ucDDNn+jZxv/LZJiSAtrpJ6JxzByz4NjblkjJhAMasSw3iL?=
 =?us-ascii?Q?buJ7pwiQbOmWg9ZlxQj1bx0CykV5kSRAeJ3KfABOp3ZXOUHIjf9Ljta+g0Xz?=
 =?us-ascii?Q?FMhc4J8znXjqE3KtKB7b6Rv9wgiwfHg6D6WQSWo1u0mXDYvGf6XqMqzlEIwJ?=
 =?us-ascii?Q?8lh4LEko0j0PcjEpnErV+ksRohDYN0Q/CNOiRVnl5ZbYDiTuKhaWGU1sVsjP?=
 =?us-ascii?Q?kHe+bg3DMDNE2smyCyr2EFzlkjcSj2aWyQsm+XPvbPCSeaChluYIa8/neqZD?=
 =?us-ascii?Q?fKI6O1vKulsO4ewQ0LU5rjF1HRprexLq4DVFkiO7?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb03584b-2a78-4ee0-6032-08db86a7fc19
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB5288.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 09:27:05.1592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqE/vQJCy/ezDQTEwfPlGAq9H0zKl+BMWmf7hADfo0vqeJ7SOqo9l2zzxNih0ABcM9Bp9fcBZPdAe72O9kGBdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6273
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

session might contain private part of the password, so better use
kfree_sensitive() to free it.
In iscsi_session_free() use kfree_sensitive() to free session->password.

Signed-off-by: Minjie Du <duminjie@vivo.com>
---
 drivers/scsi/libiscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 0fda8905e..2f273229c 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3132,7 +3132,7 @@ void iscsi_session_free(struct iscsi_cls_session *cls_session)
 	struct module *owner = cls_session->transport->owner;
 
 	iscsi_pool_free(&session->cmdpool);
-	kfree(session->password);
+	kfree_sensitive(session->password);
 	kfree(session->password_in);
 	kfree(session->username);
 	kfree(session->username_in);
-- 
2.39.0

