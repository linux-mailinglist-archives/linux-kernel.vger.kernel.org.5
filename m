Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF978B4A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 17:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjH1Pkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjH1Pke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 11:40:34 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2060.outbound.protection.outlook.com [40.92.19.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9D299
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 08:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqYDaBfsP2OnbsUpDmYagRTHdG6oKv7ic1iMMPHnqNmgiF+fqQip729ejDZqZ6kdsPJdltqs1rLcC4TKtM4ScqgnekR4hupLWiBL2wknT2qmAf1U+OqAJbnObqacN3Kc2NHFrzNxutaWiR+1GPz0vUyUZ1hdgGSki3D6dUTzKmg1nB6vCFh9r24VEhttqzFID0aGtxi7HqYv+Pc/ue1uBadiqX1diXpRsLzTK0AzfoAtnoFKZ15uhHFcEVeCqXTFXZQscdJSiiOSkRpBUVTpd318faZHYkeBM+NtcJKj/1YSkiLdA5+9XPAHxKc+1aHgcNitePDhyAjHUJtglGyy+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6h14LEXsA8bjLn3YDP83KOkfBZlB7NNnD07iXLe32Xw=;
 b=huqy3w5bQsjZ8R5YFrMvS5zXBtzOcbjKWjKbI6MybDYM8Q/EjTmjA5ddRThhHg5mnnN6wJ/Iobac+I5sTKi/llGQanTuFGJFaDidz6hBTQ5QwJh5GfjRCxHkxvILFxrN4l7MEWm+k7l+Ue1yhTPr9AlvwlVo02LwIICm3/1BJHbh4kD++VzQiA+Ku2B3w7refdEYZlbRcBa0+AZXx4KdRsvgJxrKO8NHPq54+6w8GnKBtOQ8qDLYMJz7J8rHHWjIi8ypo88HIZswXoROttyjI0H5ETLjHnRWQ73czuHb7Osn3Pd3RVG53yrv2Q/dunI/8WpmacZZb8cEEbIU/MDxKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6h14LEXsA8bjLn3YDP83KOkfBZlB7NNnD07iXLe32Xw=;
 b=cx4mq1mRWNWz6tuTbi9nH361fazw9Pv8LlWIyN12YuPURU5nGxmP9OyH289hKxs9IP8KLO4Bm7x45SM4wJfa+2SMMhNh0l8P1sOb+OU1fX3nkYQTfPhnidnEpH4jsst/lrVIJgjHb3H26gCm72f8PZqu369D2FFdQ2/J3JruN738QWpY8R2iYluklVIDSr9yQu94keEoSbRxqsoYajm/aUy795rrJqnyX30M+soySuCoRoRQ6dyMOVFKynfSg7CsCxYxEqRNAYbqyTufNmuo8jtJTdP+9fTwrE0LHnX7Xd+iy5VRyh+22BsO13lVaVDSDTsGteWG8frIVljs07vflQ==
Received: from PH7PR11MB7643.namprd11.prod.outlook.com (2603:10b6:510:27c::22)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 15:40:30 +0000
Received: from PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20]) by PH7PR11MB7643.namprd11.prod.outlook.com
 ([fe80::bfb7:d3a3:2ed:6e20%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 15:40:30 +0000
From:   Oliver Crumrine <ozlinux@hotmail.com>
To:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org
Cc:     Oliver Crumrine <ozlinux@hotmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v5 2/6] staging: octeon: remove typedef in enum cvmx_helper_interface_mode_t
Date:   Mon, 28 Aug 2023 11:39:07 -0400
Message-ID: <PH7PR11MB7643DEB4401AA83A0578087CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1693236450.git.ozlinux@hotmail.com>
References: <cover.1693236450.git.ozlinux@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [968Y9KRmeDr1tvWvP5kJNotOcLtbwuFKt/te1yqce5JGSEdG2S/S4s0a/oNcqpPr]
X-ClientProxiedBy: BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::6) To PH7PR11MB7643.namprd11.prod.outlook.com
 (2603:10b6:510:27c::22)
X-Microsoft-Original-Message-ID: <4635ce9b2859bd5c85c8472bb1ba5de5ed3ab46d.1693236450.git.ozlinux@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7643:EE_|MN0PR11MB6088:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b75103-0b62-4b15-a36f-08dba7dd1c0d
X-MS-Exchange-SLBlob-MailProps: EgT5Wr3QDKxNKrAJbXfMZAF33NU6xvg/c6TGqpqdjuqwFt4FTz8mGwOPzeXrMehajQAY0Ce0/FfJUL8ciSs6DFYOezmAc1fvPxE8XetEL8mfGOC2DQT1Z8O+SINWytri2Lga4WcTrJ7wrGxl95t0XWKk3kNOgmIZ9N8hWkUWjBFN/TXSUm4ELEYJJ9putpqvnnftf6WjFCXJ+YN5HElvGpsomPEljaynF7Jo5aDTKu3ELQ4yOf9BFUOavgJlRLESOeeTtqy7RLEEGklWgkvQ2KNMb6b8+iF23ljVY2F8Nfkb8AFMEye8op7ikm5lnDvj8e/LSIpxHgJBgU3Zj+XBYQb2suAqTRmpz+qGkch3o+XEHfm5LJjV2jq1vVVIvKDqw2jAM5UOmRIwOg1PtbxrHSFfopYEVXnY5O9uZJs/2kLGQpavr3QhHqG8KlvoyXgeHJdXlG4tFZKB12ANm3Ke42n8GiwHzD0ICsBdrqZxbs0QAoi9YMvkSHKI0gI2kz51KQyWljGCanZ2bTR6yLhQnasaQMbg20gJ98f+M/k7k3XVxpFOLy0ZoYhHdKkFJcr7S/wOHZ/FO45T5bNp2ZKBcDfjsj1h+1H1sA99+m42zbB1BEAvmJt7jP2zgWYLGGtBFlGVExApt6NA33WjE4TrozG3/dMY/RT1EV0rZTCefmFb6+QM29lX3j0xLmZPK2zAB/hiBXDLvmp/gSH/Ht2dgHubUlxZi09tn9zfc84qJKg=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gBLbK66kLFUe038xzGRi5eOd/MqHL0CJTyY6scPdB9nkj9zEsWzb/UAdGBp4KKIitAVPJxSOXwRkzAUb5SnUFCfd6ZMIerwr1oALfWpY2GamzNkMLwWkysbsokX5SohjqeF8ZA9XZ/xt/CoOpF577lDm3aS0O5A2eQa+5ne6gfRlGcAUEgE/z+lODKovV7g9eDEfZYzZ4D/6fvTwLcpA+oC2kaz7JbF/591BNlsseBMePKopduSj5LY2COWSWyrUZRfNtigEV1x7nzPuWAysEtSdxe7fzwgSamKqo7Mda6n8s6Ax3i185ylS3qqHIDzdu1bgS/puUf2gNsKjLc7rXT0OJ56A5X7KfapkJ7/FI3oST5if7bb9OFRvRY2tYOLDs8jNY2HinKhMnjl8D1QmdmIWxPjCwMQGO6tAgPdZ2binMN51Z/oOaNr2D0NJFOSgEcKon2iWYXhY+BVLne98HnW1sNCKB8vU3HOttZr06U/uulR/kxXBf1+BfSx9G/pCsyMw3FkqYuhonmjuoWs/mysVmeVFuGVvPLSMEQD5EHhjrve6WoAix5ExjTxqMOsjIZMo6TuqgtP6SsIZvnHnamI6XnYUhGm/KCnz0QbKsxphNTKJkUsiAILicpDzigfv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ts+82/JCz8iu+47IK6yJim1aOFS7A3wCCCd7Dnd8pw8LltZBi9nM2+OxE0sk?=
 =?us-ascii?Q?v3MH/CI7B5SBsR4vNEBWKk30DhDi5+0A1SOymyYuYjWCWigo8We9QutHzmLf?=
 =?us-ascii?Q?QHwxIMlO3Ij656VSMGSIU9/VYF67lpjsfQ5W/YCgIoP0/pq8PwMXLXvAsCL2?=
 =?us-ascii?Q?116i9+CzYqmaqGiD9o74gk/hH4S5lgAYp/cjVupSLAZdMI65Y2v5K8pc/wCJ?=
 =?us-ascii?Q?LLojnAJXuYmdTwoLtQ7zqLqtMpwi/b6U1iHcGP8nSY/9TW9uH6cc8fprdnN5?=
 =?us-ascii?Q?yKsgiOV8zor7b8FguPD7lFjZ6oLc6QA+UeUUbYBLPUK9WwngwCfoD/VZ076B?=
 =?us-ascii?Q?BB/aLvGaiJG/gRWjTJPrOCXi4l9yYx++vh/Mjrt0wM8CxNuFNxJJMEhuy0E/?=
 =?us-ascii?Q?xv3U1II2QW9OyMCUW76b9r3PSpFdG62CSGhUP9WTHhH5HcpykqGtKHGwvrkT?=
 =?us-ascii?Q?e6xcUXOQ41T34FDNFBAhjGVb4Sscir/gww0eJ5mNHg+6oUXKEvYiEA+4gIh/?=
 =?us-ascii?Q?CJFxy1TzoMmI9sWz1aRcEfQp2Uvgb+Bqh19ERm7GPDTeqVu27UEztM2Bsxvv?=
 =?us-ascii?Q?8AUyB+oMzzpPY8+cinTB/29THyp4xSuisX5YtCYT7HPoIuavLJgbacIz2nz5?=
 =?us-ascii?Q?sUGpGTPSNRjggL7n9d++aSVtBiZH5qnfbHK5wWiCeCxqf7KTADgAXsAFXfXb?=
 =?us-ascii?Q?vmWBKwRJSmTYxCJWp9qzpeB5MdFuasUjIgsdC9PXRIej9Qns+6Xx6hsKORZt?=
 =?us-ascii?Q?Z136U2bgRfpF4TbG/Kz25+e1g80cdmoEIEceDylT2GiaYc7ltqyiAqwwqtpI?=
 =?us-ascii?Q?iUEuLuHJ8GmhL3W5jtnXd4LjhP0xh+ZhdEFszUF/FhWmyMYD8O2xH9OVb6TH?=
 =?us-ascii?Q?tz15eQuk6T3VYtKjZ6Iy/kR8EXc5/no4BdLrFDbus81obdOj+h4v3xHB4bYy?=
 =?us-ascii?Q?j5Ygt4L5J28DJ0z6ETTgw73CRsrK5SRZWpQl5aI4lC2+HECmDB1u+bd33vPT?=
 =?us-ascii?Q?l+eLcx0H8y15yg1/3wj9AZBe3DKOTfrjhETdUBq+ug3wUwZ/e4gtw3wb0UvT?=
 =?us-ascii?Q?w+rpPzvxvrv7Y/LUOVCkK4gxz985MBDIpobwnyiuM68CboCKls4DzPS85HhV?=
 =?us-ascii?Q?Qd9GrXnHhq7ahBMvSoZFNaKX+WG2XinyiczSkpXOwRIwP55O+1ZxKaIpS31w?=
 =?us-ascii?Q?PfoIZfxH+9tv1U2eo4DJtSL52C6dnDJ+Lp2yF6/7OwM8oNMMTj03kDOGBJqI?=
 =?us-ascii?Q?D7pyFDHKFYXL/fjA3eu9v+gZZgL2rvj+GMcc1IM6Dw=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-e8f36.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b75103-0b62-4b15-a36f-08dba7dd1c0d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7643.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 15:40:30.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef in enum cvmx_helper_interface_mode_t, and rename all instances
to cvmx_helper_interface_mode

Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
---
v5: More descriptive commit descriptions
v4: No change in this file
v3: No change in this file
v2: Send the patch set properly, with messages in a single thread

 drivers/staging/octeon/ethernet.c     | 2 +-
 drivers/staging/octeon/octeon-stubs.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9eee28f2940c..023b107e077a 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -798,7 +798,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 
 	num_interfaces = cvmx_helper_get_number_of_interfaces();
 	for (interface = 0; interface < num_interfaces; interface++) {
-		cvmx_helper_interface_mode_t imode =
+		enum cvmx_helper_interface_mode imode =
 		    cvmx_helper_interface_get_mode(interface);
 		int num_ports = cvmx_helper_ports_on_interface(interface);
 		int port;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 9f269626b862..0b0c609a771c 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -220,7 +220,7 @@ enum cvmx_spi_mode {
 	CVMX_SPI_MODE_DUPLEX = 3
 };
 
-typedef enum {
+enum cvmx_helper_interface_mode {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
 	CVMX_HELPER_INTERFACE_MODE_RGMII,
 	CVMX_HELPER_INTERFACE_MODE_GMII,
@@ -231,7 +231,7 @@ typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_PICMG,
 	CVMX_HELPER_INTERFACE_MODE_NPI,
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
-} cvmx_helper_interface_mode_t;
+};
 
 typedef enum {
 	CVMX_POW_WAIT = 1,
@@ -1265,8 +1265,8 @@ static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
 					    cvmx_pko_port_status_t *status)
 { }
 
-static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
-								   interface)
+static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
+								       interface)
 {
 	return 0;
 }
-- 
2.39.3

