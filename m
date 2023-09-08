Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6807C7985C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbjIHKYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjIHKYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:24:37 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2101.outbound.protection.outlook.com [40.107.215.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813482110;
        Fri,  8 Sep 2023 03:24:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKjJuD45R3vmNSJRxMJ7cS6nkus0OZYV25cSo5/NFc3Q+vjz105BtG+T9jc9SRwLxCm+pqUuobKfyrcHPWgpoQSHv2P/m3G/Ih6U4uYk/NDIGGD64Pm9im8RY3USrWlR21LwF+VeedZrF7fzpbnRzda6NP5mYFM14GCFaRBIVOfnGBMdLBBkO9HCaBuixm0iUnbqYPTIxy4eaxpwjmBFBTFt+qn+p6gthBltWuLz/GviDJhFZsPkislMf7W0tOFdZGq/VENhltHUCR+fq3l2Y89CxyJbguF4jOe1VBLq+C3eAtT7eaOGWV08w6VwDOARAY5ucbo6HyIRiN2yEWlCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPnlR08hbsoclGERdenfkrp/RinvaXl1VOr7NFSDndQ=;
 b=PvZJawnYdqvLhyal7j+n7FDEOOmYPL1Dj7u88z6NRkmTpLP19gYa37vCy0D9A3OJo0mXDlc5QUwjv7vqZ8QWaZsxffcx/+9/iaMUCznlL5MudbNPX0JAdd8UOrw7AS9Xu6YMIzNZL7vAy7KbR6Cqe/ypqBrXAR4hj1B1D/NNbkjmsBL3mSuHRi0L3UEkqcWlfm2DXHva0fnR9HKUcJswhFSo2oBnPNXubGdgdvcYYJBGoNZRN+VKJpeIlRxuu9hpi4Vjt495hX5x9eFlm5he/8+aznvbKF5++jdFYj0lVDjdp/qJh1hwKiVpkIovpvL7clmIYrzd8VvVLCYw9wnp2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPnlR08hbsoclGERdenfkrp/RinvaXl1VOr7NFSDndQ=;
 b=BrAThSXCl55FbeeAecQASk+SgyvIcMhdUuLfqk4TuH3ZBKLm+iiMSztxBp68eiHASfUrzh8xfSMR8LtYk7ylL4Ak2iofqKk6os1gkoYVaxMpAu56ENSvjJXkT7bOxaExRK0vNLOcbxvykCLTbuCsx3tS78Vap2E1O98URpI+l3oBbrOJ1rWxtAJc6nXLL3EG9q+rh6oqWB7KmyDbT+usf6FK/XHqzt0OVwvi8518P47YlsZc9hOUaxk6qi5lnXnG8xP9ATIVTnlnhBgdB9ZU4VWkobvJ6/buemUNeZoo76WA5Oc3nyuXOTG0eg/EfGI8aZxfjPy9zTm8UQdJmvOYrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com (2603:1096:400:451::6)
 by SEYPR06MB5110.apcprd06.prod.outlook.com (2603:1096:101:56::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.38; Fri, 8 Sep
 2023 10:22:28 +0000
Received: from TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e]) by TYZPR06MB6697.apcprd06.prod.outlook.com
 ([fe80::5bef:53ac:2a7c:6f4e%3]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 10:22:28 +0000
From:   Lu Hongfei <luhongfei@vivo.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lu Hongfei <luhongfei@vivo.com>,
        Can Guo <quic_cang@quicinc.com>, Bean Huo <beanhuo@micron.com>,
        Arthur Simchaev <arthur.simchaev@wdc.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        zhanghui <zhanghui31@xiaomi.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Eric Biggers <ebiggers@google.com>,
        Keoseong Park <keosung.park@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH v2 1/3] scsi: ufs: core: add wb buffer resize related attr_idn
Date:   Fri,  8 Sep 2023 18:20:16 +0800
Message-Id: <20230908102113.547-2-luhongfei@vivo.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20230908102113.547-1-luhongfei@vivo.com>
References: <20230908102113.547-1-luhongfei@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0196.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::23) To TYZPR06MB6697.apcprd06.prod.outlook.com
 (2603:1096:400:451::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6697:EE_|SEYPR06MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3a5e46-fb2f-49fb-33b3-08dbb05580bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Acy8Xc/SSg+ksDBFgzcb2uvvFGeVtkQ4EZ+GKXXYz0to6K1fXInnKlImRRFHKXH28Ya53ni/YX0LG8s46FSV/A54UcKUVCrq9qSHOdNTwVz75lDcgTXW+yLLZ1wikzJWswnSA1No0hk3j02DYjeEcU/srjqWCuJTNcBKib0DrHaCiRIxKE8YgldWv0anFVGLmOOo+WhbvRDD4UyQFvt8gmJeuMP2YTlLYq+jBqNVgqrX7Bod9NjnOjsi6d4274TLZiH1YLUOsy9+xJJN9z6qe0qP4yZJ8rYA0ZEjIN6pdXlDLv2aw/PpwCZJw6aLe2EfTKWitMj2H99ysaSKa0097QQXU0OjYyMoAF3HGSDn8riCDC5Y4qpXG4hF7gJMWod3sXf4akTpj94YKbtdyk2NRLDwQ/OEiWccXRk/n3s8XDd1CUEnGsjFlTW3t9r6ah7O1ECeOb/Xu91pQWDvinmx5i/8vZsGOAxJAZfuhMFRI2Sr2PB/8rw1BnYLCMVlZPMtCUGz2vIR8fh71/yGK9Yacv9mUeB/6R6tcvZwy+jLjZnXgPPl9lLPeEn0iI1IIeFpFV15eJGjiXWYdUhQ9OAlClhehw1m/JEtyDow036MV9c2N+/2TF5pwr8XQ1JYTSmtFuS88CRqZWRKM6QzUepCuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199024)(186009)(1800799009)(5660300002)(4326008)(8936002)(6486002)(6506007)(8676002)(66476007)(316002)(66946007)(4744005)(41300700001)(66556008)(2906002)(478600001)(52116002)(6666004)(110136005)(6512007)(26005)(1076003)(107886003)(2616005)(7416002)(83380400001)(921005)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vMenDI5KdbHvCexLgixZO/cYjoLbka+u7iQQJLeb+rTEzvS8IYF1CN/RDA92?=
 =?us-ascii?Q?W1NIMP1jh8QrYkFqbwEAFDcC6b0roUxdANzxf4CBisrOb40XkSBzKbCQnH4o?=
 =?us-ascii?Q?JzK7/UtIpAd7fl9Q/wyAHIIPmf8wLh7Mhomf+gSxt1kl7iD5ZjC9m45uTOV3?=
 =?us-ascii?Q?ITQ7D3Pqqlq0rg0lpu+wv9GHaSWNxeIa8jGH8S81dxKGsjYI1n53RLNclsxT?=
 =?us-ascii?Q?ITvaJS0gV3a6Cwv9T27y+iS7Q0Etshdpe4gSdAb3MlkgBmkLc38A/ngOdtNH?=
 =?us-ascii?Q?25bePixj0dRFVaBlkol9/4FTPmQWOO2alwoxC5aFkgCTCRboCQGbrgeo8AIB?=
 =?us-ascii?Q?LPcWA+k4DS/yAJT3Cj/lZEmoe4oUrMMen6FfD3W3geAS/TkAVGFVobKVShkf?=
 =?us-ascii?Q?pBudkx+L2NYwTwlCldreFqkEtnFe+IuPvL/M5ZFoowYc8ZZyT5J9rF/FXU6Z?=
 =?us-ascii?Q?Y0mshSBqwKBcz35WB6C3fXceOO7KQKDrTNTqn4RBg20NUTzYtupv+AuXiWvK?=
 =?us-ascii?Q?CZLmm3n+w9v89CLx20l3a6nBMTt3AdrB31PPSnAx5mouqCRaXp6kGbCBZuVR?=
 =?us-ascii?Q?z8h5dAPno04SvAAxTrds3JzRW24Oqi2TmgGHXzPBzgMRDg0jLxuGtjX8bk/7?=
 =?us-ascii?Q?8cP3ZuBEiUUKHB+Sx0A7aRDyHWWBU8WXpZTdXD9QyusqYKogXZ3O2b9cdMdh?=
 =?us-ascii?Q?qglCSreJ/ryToT6HBgu2nDmgwmaiEUphxKtY09jDUBBVNWXz9q94YqFnCIEu?=
 =?us-ascii?Q?pfaUE76W79AMUiPm510whJzrrNobPBnm4pIW4BVj6OiJ2gYUlyHFWoGoiFnb?=
 =?us-ascii?Q?izD3fee3rSkVKTXI+1ltMQZiCmlODa3mn1d+JlNrPupPOu6r4BCDu0seaZls?=
 =?us-ascii?Q?w4Nx6hIBZUfzB4kM9uQ5UPN9RLevO0N+WTllB8CTs+lWvKMbz/OEHRmXq+jR?=
 =?us-ascii?Q?P8+DkqkY9AMasG/4pzdg97MfS+U5zInWKirHCnjxxkdFCyoF9z0jrMKRd3wW?=
 =?us-ascii?Q?WxISaiz03GCRXGs4AQOy/Dc2aLofjZPyS3EHaueFt6co8MHcX0yISKUPr8tS?=
 =?us-ascii?Q?8CVacBTfOI5GJpMe3PNPljKScXF35+cTgg9x9SuHQSWL98erxnbS2sit3uAQ?=
 =?us-ascii?Q?Y5BKTiaEJEAAVIKxfz/2wSFJlGHcJ1HIYpbjJAv5ZXK4yP6TT5NT3sROeVo1?=
 =?us-ascii?Q?Z1Hr+Rt1N3w9v6O4zKfTRPEv+Y/0PYs3Onfs8nTwWeBUtVstgmJmCBBsTYQp?=
 =?us-ascii?Q?3zumdSz8O2BMPdPmQje9td6Q2m4MYWTJjPWKgJiVI8D4elYAuJvJ/58FWCjX?=
 =?us-ascii?Q?joAKtdFLHr+WRr4HiWeoucPTbhGUfBJEah7U/om2Bw8g8mlZZSEyeZd2jPHz?=
 =?us-ascii?Q?BlQ5n4g1l55wxUR+vWC6Fi5Jr6B8aiKD7ct6/sUNHHaq4MfPD+sf6gehBxfH?=
 =?us-ascii?Q?5fOstPe6RutI9It1/TDUzFIFenC0HZBTtiGHmqZJEHkKMFKgji1IG+G/RuLX?=
 =?us-ascii?Q?2wHftoEWQXB1naHYaFPyUMVAeex1k4hFQE3r6YqKgEh1ASIKClu6kStbNlqh?=
 =?us-ascii?Q?Dh5xc8R0Lm8okce791/GA5gmMddDJnviMk7ESOQ1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3a5e46-fb2f-49fb-33b3-08dbb05580bf
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 10:22:28.3885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQbf8mb09yl6B48bAu5Rm4c9nw3R7YDFSMPUOla3JPEPYMdV+69jVmPBnw4QxrFAh02p4QoNz3YVEims280plg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5110
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFS4.1 will support the WB buffer resize function, and UFS driver needs
to add definitions for attr_idn related to this function to support
this feature

Signed-off-by: Lu Hongfei <luhongfei@vivo.com>
---
 include/ufs/ufs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 0cced88f4531..8016bf30c8c4 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -179,7 +179,10 @@ enum attr_idn {
 	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
 	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
 	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
-	QUERY_ATTR_IDN_TIMESTAMP		= 0x30
+	QUERY_ATTR_IDN_TIMESTAMP		= 0x30,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_HINT	= 0x3C,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_EN		= 0x3D,
+	QUERY_ATTR_IDN_WB_BUF_RESIZE_STATUS	= 0x3E
 };
 
 /* Descriptor idn for Query requests */
-- 
2.39.0

