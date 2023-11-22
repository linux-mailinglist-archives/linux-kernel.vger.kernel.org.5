Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3087F3B37
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjKVBZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKVBZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:25:05 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2040.outbound.protection.outlook.com [40.92.107.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D97691;
        Tue, 21 Nov 2023 17:25:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M52MVz1xCaFzwQTmWVCvFYyNWg14a9JON5a29X69f36DnAoY0EUI2s0hmI+7jXqi4ucOFny5+iy3efzs1VLnRkkhntb4R/XGhdtsTaxvd2oPMS1WBUnoBzRUQv/gFRuuVHE3p8v79yKf7rUNsEa6VplIoJmIiOGHM5P5YhnAMBbsvbywatd70GkLK+Lbjn4zbm2jhYsFv/Md5B2HeFic3S9MaHmoyVlv94s8QyDyMx/6IuDKv/aHQ587iIYkmHzHEgJjrinKfsQ5G8W92jvPS1lk0JWfZJ7ark4UShN1yMfnrku6TMm/FoWzQ+KJLg3EFx2akX/JBDIGVdv8c8VuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4nagn7wz/9YH++vhzfM+ICRMfPQv8SJawrhaEoQTsI=;
 b=TqzIi5fDPn3UYMfjMONqEy3DKZGYjnWDmmysK1fvT8hnmefapcLYMKcAuozV3pcvdhJQbk6vm8T+1M9W/DRuUrVVjqvYHtN0QddbNhkOXiQ58M/kDy0mk74b5uhUyh0j2v+gmPaYD4go0MQLeTVS0ZSMs7tNuXCYV2GnGnugaJo2S4p7RMkDlew4CinQ6d6XMTTSv712qdwZofeXvQ3/HKGchrCIG9TkrntpFiLlOvy1NK/gQ9PgwRU7kHqaRTIGfOQcJdpwWsY8Nllabok1WCmgJrNONu55TMjD7Pgf4nOyF8pRPmKYMhFWFjYSLRAgErOntypoCA8HTaydAkQf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4nagn7wz/9YH++vhzfM+ICRMfPQv8SJawrhaEoQTsI=;
 b=Mn6HXyd2qSVj8JLjGEyIjHQbdghNJEeRtUFk4TcMaP/sP1T5ztr8MgYig+bSa+Z29UC+/0MRIsaCaDFKQ8ILRo8u4UT6fIPMlYl/fCb9mC3fuvg5mmwTJjd/NJuwc/t+S31ByG3qkrshyQpibA2apLPrkrIB4DQ7x3n5m904OifVV5hJDi6pNDkGy2SJMJfR3sYS5dlVm4DVq5+JLCBT7GK2V2G6KJt3jU1gNUsTicpbCJ2yavRRHcOi2PqJTdBtWsDbBuZQ6FeSvIoITN77eEUBOpQi1TMqmk8Gwyu2kA/YG+lM3Xxe+ob7QDNnf+z2SzGrgxFQStR5wy4ZI60Ojw==
Received: from KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 (2603:1096:820:41::14) by TY2PR0101MB3632.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8003::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 01:24:57 +0000
Received: from KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 ([fe80::907f:e0c0:d442:e14f]) by KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 ([fe80::907f:e0c0:d442:e14f%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 01:24:56 +0000
From:   Ken Lin <ken_lin5@hotmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     groeck@chromium.org, Benson Leung <bleung@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Reka Norman <rekanorman@chromium.org>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Zoey Wu <zoey_wu@wistron.corp-partner.google.com>,
        chrome-platform@lists.linux.dev, linux-media@vger.kernel.org
Subject: [PATCH] media: platform: cros-ec: Add Dexi to the match table
Date:   Wed, 22 Nov 2023 09:24:43 +0800
Message-ID: <KL1PR01MB38096A17A4F89721CC3DA073AEBAA@KL1PR01MB3809.apcprd01.prod.exchangelabs.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [tHznemHqqNXdxnt8FUH0WB/VJfdl1mG6]
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To KL1PR01MB3809.apcprd01.prod.exchangelabs.com
 (2603:1096:820:41::14)
X-Microsoft-Original-Message-ID: <20231122092333.1.I02f6efa3023c0bcb437ee3b7ebaa2910a89ab0e9@changeid>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR01MB3809:EE_|TY2PR0101MB3632:EE_
X-MS-Office365-Filtering-Correlation-Id: f3f52483-6c78-4438-d792-08dbeaf9d583
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VJJ2g01ij4Rouzu8nbABsc0AqUuyO8BMcFVOAwFBRBuBUIErEdf8YrmRpedI49wnTzWMaPea0FehLntPs59BWUH1Qdmy5r8NOQXzA21R8Gx+2XtjFRYvm+NbXiBoWww+ic32MQFqiX8Bt8hte9KKVlHDzwGkYyPkBlvPtQwUZw9QWWMnpfFIb95zivUyiSLZ/fYv+TPUDYjS8bDF3LktA36iJO9v6oYqp7l199ZNwxopoTPxHrecFlM9NXNkqyPYvW563VGg1qPguK5adPjZyaAvu7oOsy55paeR80On40x4n7MnBNH1DVDIGB7KpG2jbohLk182vaud02A9xFy+/phLzAEeJIQWqV7Wsovg1jwOb/5DSOCUryZlYgB2NUiVNetl7lpVnJ2e36cfBS4yyE3oWCGeWgrLQndwWz1d4dFGm6FH3BpASlcALTQ06A0jklsojehK0wijkX1bwsRXotroMb+13fehJ5MWOKseCS9Ok+IMh+2JhihLW2+jwx7n3lRI8bXZGk2qDUwlmcvN5KekNlgjidfrOom39apK9LQuaRP8VnaDuRjNrwFGFbQ9
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qjS21Lt24kQOJ5bNrh5gbSjqm0bxk7SzRacrq2t4k0fb7YpoYbND6NZExw5D?=
 =?us-ascii?Q?Z4+sMgMgchSAsWWmdP3bjS9C/w8lk8p2wCdJnd3WMwqAWjFD8ibFa2cQBKGS?=
 =?us-ascii?Q?eMz4VLDZHjWNgu5CY2yQl2TxlOWrh7ENgATzrF6GNVOedEbAWS3ovMnLy6mG?=
 =?us-ascii?Q?bmguNdxQAKC31sdnaarUmUFBhcFzSSNyUUlHThIQrQTReE9MYdyh3rQYrLkA?=
 =?us-ascii?Q?9YE6BknLrRYqTR6Sd7CLaDKp/hqWRvCGjrKzf6tXA64KBRIDyN/H0iL6dR7a?=
 =?us-ascii?Q?UbenKgyCcZQumOzEri7eBnV40NJqJ4DT2Vjo+fhJdgRl51j+EwbdZdfsa8Ja?=
 =?us-ascii?Q?5nDRj+VgD0Nty6FxSGgEJ0kZIgZJHk8m3uLbB4kifdSgJTPMMVUO3Up+cEpn?=
 =?us-ascii?Q?FQxTcl29YCv3fmUZfa1WOBZSQyePkCO+PFWjHvYasY0Eo4fumK/6nIxpelW0?=
 =?us-ascii?Q?cXDLvvQtCdbhrbhGmKbEtqOBeRZkk/TU5kyZpsnSdd5nB1mQvJWRT8ox0nNa?=
 =?us-ascii?Q?30YzCGH1mH3zdevlEb54+8XbwxvdakI8kTy9n9aURDoWxCyp9A50M7470l5d?=
 =?us-ascii?Q?bigSqFlif9sUXBLVaKWiUALDoeDjdG4Bav7xD/WVhQOQrvHRYHmckxr5teIU?=
 =?us-ascii?Q?DRGvEeptA0uyZhsPJQwIhZFlGSes7aXpjLBUaa3tbdKeo3ScPFkg0Ksqdf8Z?=
 =?us-ascii?Q?H8PG9NBx8w7H2i7tSaEf5xvX32Y9l9siKZ2f77bOOsVJrBpBzNib0lK5wSX4?=
 =?us-ascii?Q?dn3aBmyPEolHyAoOMmnWpyDXMHBIQOV13MMe+saWwVmR7KISIfZ1eV9YqdMe?=
 =?us-ascii?Q?rMG/cstyOsuZhlK5aJFIluiAiQ+Idm4FapgvW2fi7pNUcOd8FuItFnqhdWvF?=
 =?us-ascii?Q?O2PjfY7v3NOqCwXbd2fqDP3UrGXzOLqD676OC/PAHtxogKDRqCeNShI8A6Pj?=
 =?us-ascii?Q?It43DzP1KGib0OjwTHdLXCv9dkSsbTKuWOEnzv5GTqFIz2xO0nXXNoaWtvUH?=
 =?us-ascii?Q?efxjpkuXtTvv64bz9/5XHqPN7GMwPSUEls7/R1PS4gEYLtJijhpe3pEedgxQ?=
 =?us-ascii?Q?xBEHPeLXor6rguHzT7jddhbeMBbdVqkaSR/+0sOnh4IaCqtLj5qQhyagYjHe?=
 =?us-ascii?Q?7o8HJnD69ndMpErwejEsdlxNMwFvcQDJczDatDKLNScGl7Kp+E/Q3W2is/tH?=
 =?us-ascii?Q?W4gxDnb/KrqbH1GwKAaSC5w0GFlEKEibICtP+Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-d8e84.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f52483-6c78-4438-d792-08dbeaf9d583
X-MS-Exchange-CrossTenant-AuthSource: KL1PR01MB3809.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 01:24:56.7937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR0101MB3632
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Google Dexi device uses the same approach as the Google Brask
which enables the HDMI CEC via the cros-ec-cec driver.

Signed-off-by: Ken Lin <ken_lin5@hotmail.com>
---

 drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
index 42dde3f0dbde..52ec0ba4b339 100644
--- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
+++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
@@ -324,6 +324,8 @@ static const struct cec_dmi_match cec_dmi_match_table[] = {
 	{ "Google", "Boxy", "0000:00:02.0", port_d_conns },
 	/* Google Taranza */
 	{ "Google", "Taranza", "0000:00:02.0", port_db_conns },
+	/* Google Dexi */
+	{ "Google", "Dexi", "0000:00:02.0", port_db_conns },
 };
 
 static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
-- 
2.25.1

