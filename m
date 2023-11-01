Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691567DE529
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 18:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344716AbjKARRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344676AbjKARQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 13:16:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A335BED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 10:16:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1GYoW1011191;
        Wed, 1 Nov 2023 17:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=KfrZaW0K5c8cXVE5iHHCWDIvF9HlDZH10tB2zeapSQo=;
 b=EiENbQFHa5daXGAmmIcKNpIrhIEhs/g0BK/cyk17cEWdQAQQx16NwQxoE3L1yxla62zt
 Ixhrxe+xtlus/m7mzf2MO0uenFK6hfGxXQncA88QRweKWXL2uVhc3vd56TrDOOZZdSnz
 ZEUb/fCIkY530ZHZljfJtAm0TKolleMLvTqxwOxUXsQKWp7y0wCHDfXE3n9lFuv+hk99
 /kAHikcPuELOqGdJQGWS1LwCwsIevoXx91iwMkW7Q+LhPGJB782eVh+HIqRbd6oH5gW/
 /3pmLZUPdz7TAFaXhySuw3+Au+03zF3WAWZIJbD+krJvo6kl0PxKEvaE3zUqcU6h3Qx1 jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s7byxs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1Gj6B8022465;
        Wed, 1 Nov 2023 17:16:40 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7br6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 17:16:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOnmiLg6SBv7I2bjS68SmHZsAxmcxJaUE+faqYDk55NVCibpjvL41eAHzfIRcaqFlPpdkjqJDIYf1mD7qC1Or4flDYx6q3MfjoBJy0ZpjEfFZslp7+fzfoTH2ea0pd6lU7QKNVj9HZIr9kP64HFUrYEAszobg+Kn6fB6Vtkykb0yev+As3+oNNrpnqSOI5OTc+2Hg5YZNBFECx4hGr0q6bhDmf/N7AA8dtFz+9Ts8zFQIyAnSmnx4+3OEn+n3ytYez5l6RzoQZztqYyYqBKFKTXkb9UAF9czWAXdtinxCIi0fdNj1VM+t4TpIO3sY+78dNpqvQk5yC7Hcm2yDLYULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfrZaW0K5c8cXVE5iHHCWDIvF9HlDZH10tB2zeapSQo=;
 b=KNfbCYo1Su/a4I9ImM79aJm7CiUo4pjciTonEdnB5WszxHPXPsUL5gPUVTorEuqg9AajvbUYWBoP7628/iDiplU321UKJTKGqR9P8Rh/H+zlwkY3SLnm3T9B1H7x5A7wiw/FZns9WEfWV45Biq1cseoet1BGChfFk/4Nwpnam+A9ieMis7RUPbBH1kEhAfoqk3fYWXaO38LSWcMPNWwzhFsPwXM9YJPx+8JnxQUf+dic6wjmHxiNnaxMDKMMR67wvt8bSwYRU2V2zAIN4SlygQOkvRvVOTh2XrS+V4gyiDK6b37LYyhW8zIT2uRYmB/xF5dqAzOUxOlQufzDhV7yEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfrZaW0K5c8cXVE5iHHCWDIvF9HlDZH10tB2zeapSQo=;
 b=LbllPnf+323ewMHHKhHf/cF8qPDDK8XwNLuhlRmjHKVb5jaqmjikZvLf9Gn4timt+vfjJNi5dp8tyoZmsOYE2huyPhH/xgYzWyp7y/u5UbjKUx7AQNq7LdPgqFAzM7/8p3fEmxplwIOD54eIfq/GFAyQfJFj27dcWCXimLoSAtw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SA1PR10MB7684.namprd10.prod.outlook.com (2603:10b6:806:38e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Wed, 1 Nov
 2023 17:16:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Wed, 1 Nov 2023
 17:16:38 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 01/12] maple_tree: Remove unnecessary default labels from switch statements
Date:   Wed,  1 Nov 2023 13:16:18 -0400
Message-Id: <20231101171629.3612299-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
References: <20231101171629.3612299-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0489.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::8) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SA1PR10MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 614ced25-77f2-4876-8f82-08dbdafe4ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N7P3zcZiMYevt1Roq58q6IEM41IBw0yt/o4rnnwT7w1Q21qsAiofzbrQXj+n+ji+IgiEsBuUkTRNBofYJDduzH06tJ9oErjWEB+h8xl+mfvGx5wZV8OYJzPL3Nzl00vyQCer4QAOtVN5dLGGxpg1JHJwPZhB2RMvQJmxG6fsupIvCaMLhwRicu3li8+veb0EYEsoo7BUQMFLiX+44HTrxlGtmR4BNfI+gdr7h4AECcpiByHOzKjNBM1YhazRX67/11SrmFqjaNp/hfBfr6/Dx9b3oPkUmV3t84CNq5zL8An+kYIehDy9qX7duIjZJsaizcRZ1bQRMVHnNrxNnExMGmZmqYCJbqhOA/oA+0w2BSyYO5T6KbrcRCqsvuz1E3vz3CUxhNoTwa+Eh/MA5kmi6rqTmR8eD9rAhBsGxoww38OP/VwW+DInALMReb+Mxd2/s95bayFxTHOBIDKM5NAQuts6HmIlm888xf0kLOA1XuizlX/wYvsiR0icAfE8ldBPVjGqhEJ5ZvQV2giB+AsuXAIppHHDos2HrjeyEljGs6TCptA9Khm6iCgDScrnW/IXrVb60bB/NEn/YRWEs3Jf2Z2T6OcR1iYI/HW4RF93r/uJjAzJg02l4VOwF2x/TFWa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799009)(64100799003)(6486002)(8936002)(2906002)(4326008)(41300700001)(8676002)(5660300002)(6666004)(6506007)(66476007)(107886003)(83380400001)(1076003)(2616005)(36756003)(26005)(6512007)(38100700002)(316002)(86362001)(478600001)(66556008)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tTsnPDae89Ck8qV2QyptLvn6NBkZKIwR47CtPOzE6mZDqJ9+clsu4K6fo6JU?=
 =?us-ascii?Q?/YaLMlQZdS9/Pfz16IESVpDNreNuWuhB7/ytvBoKf5lrbprAV6ewH1r97cI6?=
 =?us-ascii?Q?89/gqwJobjk1JRzrLsA+qBHL8CdP1nKTtl2JC5Y+mcEtQhy1bbpt40OE6btB?=
 =?us-ascii?Q?dN/vpAoUjnID2bkEBmiKlTs72yVeAWiUDqgK77zoDXCLLd+u7urvjY2cSm7H?=
 =?us-ascii?Q?PMA0agEFDdR7ycBGNPRDAs1NmgNzxDlltvSItuXXrd3Nc3q+xZguea4Ipr3v?=
 =?us-ascii?Q?GHcNPnwUptrVMkH6YRI2xdZ6dAZdCx28QV68mxsgR3LT46NBfsvuqbrANTGa?=
 =?us-ascii?Q?w3klYzz0riUv8bsCb4lT5YiuPUTLKo/O7cYnYDdORloF5RacdqGhlDKdw6dP?=
 =?us-ascii?Q?4f4DSeO/Sz6hzD/lOfi8IAnpHOzJOp2hbNBLWPGq40aBvIjt+IMtMSMiD2Wm?=
 =?us-ascii?Q?Remi8ygGyuGqYuhXt3rzwY4YzTXByvEM4TtrEvqM9yt/N8WjQdtE8FaPEyBe?=
 =?us-ascii?Q?KDFXurdIM/OfnGd11VwGOj/bnbjTLP0fLutdMZJDtmO3M8hYH5XIXhg+b7Lm?=
 =?us-ascii?Q?3VFqHxHOaKgyN747domINZXZRuMG+lP9SS+K5+SUEc3f3KyLyJ8y8SK6+e8h?=
 =?us-ascii?Q?htp/ehZO9zSTKpiksN7ozCAqEuOQj+dKIf828mU5N2TKYMb66KfR9gd05JZ3?=
 =?us-ascii?Q?GjZ2UUei5rytTGAPgL54plOfAjUQS2i1P90oATnHV+J7PVy3BqR2bUzsTl2O?=
 =?us-ascii?Q?7a3rGT+ziyNEXIdLpTllyfwMisk4WXRFlWHOttERmDHBFrh2g+K9lXwSakZN?=
 =?us-ascii?Q?bGa6G9H60/97/vtuiPGtl9Lr1CexAEMfw+htcZ3q3pa4+IVlRgiMaRbT3Cnw?=
 =?us-ascii?Q?eWHb/fuYv2X8A+81kcbq4GfON91tCRr1/P8UMlzKC6nnXFD6J2fEagj2208j?=
 =?us-ascii?Q?kV9fgg5/u1vfhGmyDLTOuZEdxSDlNe3H37fd6IbpmT/ovybb0d4XxPpYUXhR?=
 =?us-ascii?Q?VPzgSJO6fGdM8LcKhG+2WNko0dhxnc2FJjsVrXvXB0gg+fr9yE1SfTlVnbzJ?=
 =?us-ascii?Q?Pvf6wKLIrLdEMzrPN5RaSJ4Y3Ruxtn/scxpnSC7DK4CrvqrO9c35ZIJryke3?=
 =?us-ascii?Q?XQANZICaG5eOuUzKxwmgd0Q0254TZOu0WMURqNzLsX+5/+/OXrBtlJ5GZFLn?=
 =?us-ascii?Q?hyOiwkFmZ0EJBmSeT2s2TPabsAujroEfrCTUHi0B/uFvTrn29j+bWK7s7Qh6?=
 =?us-ascii?Q?T0kHyH9ctAtQuN7dHARraoH/yCSzHgH93qzzlF1xXbbZBhPrYEwTzm2UN17N?=
 =?us-ascii?Q?UbnkahUvU+PNy5nRnoJB2zStaNPzGIEP8IHw9cgNN9hsPNt7H9v6B6UTuySk?=
 =?us-ascii?Q?Cro6gYZN494tFA+YE/abi9V4PM6JS1c8TKvYxDB1t+e6x0ikis825mpXXTIK?=
 =?us-ascii?Q?6Qg8vaE/eZVXmKcDilauRJAauwfv/dziMRR53R4XaH1pZkQQmtI9IhtyWgAM?=
 =?us-ascii?Q?inccKKwfd9u9EWxcmoX1K6zNZUxl1HXfkGbG2FoEqXLHAEe2xhRWgTUV1Xnh?=
 =?us-ascii?Q?4PtwJXSCm60vi4+G5qj5HsBvH90qKrchivkLDw2h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: HSZPs9QVf6a2SDli53FgzajYGjKVf1nxoOe4RMKMcMpx4TCeRZNGezS9Typ8jRWXSFxka14kXB5zWIUSLYGf3JOe0aygrTuHvXVb8J6ifarFZesoEtIePyKRv9+fUS6NaQ9LXHJFBneagIvk193oyIyv7Mj/+ddpF13GFBZze6w5bBmT3cUkYV3oZJZX5EalBZ7pvTfALIjk0LpVCj79+4bphVHkRwKj7L26WVjG2d2GY7a4X3FZXVCr3iCK363yMb5KKHYXiW8mAwEeYDtbjrs5qBs6Pg5K94Bp1tsRKVDXE85Yl5S9A1AkdynuMjjjNGqcvKhpkTkLm5ab7PDRY/yUAltSnJoCQhmS7gVO/EZ6N3v+zsAiexMp0cCeOPOt2jsul8XRfGrcygVVQX+fzMeOwvtOYJk+NUpkvsk/Fpjqg6S9jEM3aYzBok5hC3WpsMfXpKB34GyfluxMmtX1aZRvLCmofY8fn4zu/y4r6t863dJnDd5WxwcQKhTGs/Wc3IfbnJgWn2W/7qQTMaF/hcuMdKy0NSDTj2MIvXRrQ+RRtc2uwyJAsr0+VLdciAPbMkL6EVT1C/F48g4dpy8xc7fUq+mYT6/rOfOO6AQEnMAA2ksa7lcdRSRFoHwtNTM6thu0t1M1uVjsm+Aar8EwIp2uyvZJkhz0xn7mXlqTQjtJZqX0HUxyOUgeBQJxTNsaz4I8WCOIACXVFJxRNs+GR7ov83uwK/ALNzqwP+eOsPkgbd6UAQI4kyP4epccvAUhUxMDtSAUv7chGE5OdOLglBFvU/kTCpQFKo3N+Kr8i2wJll42b8Oc8NKaP/J+PP2D4CEbhRTuHw4wOOrenG2KbJkXZ+ezW+6wsrKG9uVGGjLWPgyRNBweQ6+FZKbGeNNVY6cbT1AZdmUlBDx70YMCaQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614ced25-77f2-4876-8f82-08dbdafe4ef5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 17:16:38.5042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3//2Va5STVN/IMTXo6jgruSv9KYKu9Qa8T6TFL0XE4dcdT/q9m4ANhEpHjyC5coLLovgS0zu6YpaTQDq5SCJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7684
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010134
X-Proofpoint-GUID: fW9RmoQstYFRFIXapQza5PZkMIZ7nbxl
X-Proofpoint-ORIG-GUID: fW9RmoQstYFRFIXapQza5PZkMIZ7nbxl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removing the default types from the switch statements will cause compile
warnings on missing cases.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 0e00a84e8e8f..0fcbfa7e9942 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -759,7 +759,6 @@ static inline void mte_set_pivot(struct maple_enode *mn, unsigned char piv,
 
 	BUG_ON(piv >= mt_pivots[type]);
 	switch (type) {
-	default:
 	case maple_range_64:
 	case maple_leaf_64:
 		node->mr64.pivot[piv] = val;
@@ -783,7 +782,6 @@ static inline void mte_set_pivot(struct maple_enode *mn, unsigned char piv,
 static inline void __rcu **ma_slots(struct maple_node *mn, enum maple_type mt)
 {
 	switch (mt) {
-	default:
 	case maple_arange_64:
 		return mn->ma64.slot;
 	case maple_range_64:
@@ -792,6 +790,8 @@ static inline void __rcu **ma_slots(struct maple_node *mn, enum maple_type mt)
 	case maple_dense:
 		return mn->slot;
 	}
+
+	return NULL;
 }
 
 static inline bool mt_write_locked(const struct maple_tree *mt)
@@ -6718,7 +6718,6 @@ static void mt_dump_range(unsigned long min, unsigned long max,
 		else
 			pr_info("%.*s%lx-%lx: ", depth * 2, spaces, min, max);
 		break;
-	default:
 	case mt_dump_dec:
 		if (min == max)
 			pr_info("%.*s%lu: ", depth * 2, spaces, min);
@@ -6758,7 +6757,6 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 		case mt_dump_hex:
 			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
 			break;
-		default:
 		case mt_dump_dec:
 			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
 		}
@@ -6788,7 +6786,6 @@ static void mt_dump_range64(const struct maple_tree *mt, void *entry,
 				pr_err("node %p last (%lx) > max (%lx) at pivot %d!\n",
 					node, last, max, i);
 				break;
-			default:
 			case mt_dump_dec:
 				pr_err("node %p last (%lu) > max (%lu) at pivot %d!\n",
 					node, last, max, i);
@@ -6813,7 +6810,6 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 		case mt_dump_hex:
 			pr_cont("%lx ", node->gap[i]);
 			break;
-		default:
 		case mt_dump_dec:
 			pr_cont("%lu ", node->gap[i]);
 		}
@@ -6824,7 +6820,6 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 		case mt_dump_hex:
 			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
 			break;
-		default:
 		case mt_dump_dec:
 			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
 		}
-- 
2.40.1

