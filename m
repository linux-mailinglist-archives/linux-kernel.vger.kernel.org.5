Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8DF77068A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjHDRAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjHDRAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:00:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA61A46B3
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:00:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374EiPjS019904;
        Fri, 4 Aug 2023 17:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=CSBRiN3QDXn+UdttUmnB30Ar+vyLKFI9e7V3W37fdL0=;
 b=vL/f7lN9E7+9n+zVgvdsuH3Nc6hULuQrWyNPN9219tI5gQFHBFNfaCqlc3WkGVVOlH1q
 OHWpjLRONSNTpeFcu7P+1ec0WlGQHeF6LzAR3bviB4Y7c70m+PfGLH46j2z2ofbJvGP5
 FOZDl4ICM219iijRHQHKjbhGyZtm8f6ueXyineIFUHQFtq7Ea47vLAeVpej+ctWNYjr0
 5rsr0dIffxERRCJY/RAzJCx6rWW5UXo1eu9Yt42zMRMHf1qgR4vA9K9JmKvKtmGZjTuY
 XNiVswn+cZbqRTBzEhXMaEyqY77vohhgYXJOLpqOZmeIvm5p1smXdluyNAqplNPNDOf+ vw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4sc2m942-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:26 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374Gghws040734;
        Fri, 4 Aug 2023 17:00:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s8kpkmhy4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUptpqReCMyNwnLvcLGqM9CslKvJYSUWsA5F0BaZdk6QEgr1ofPAtFDg5Vg0lF1lCmjV5Kw1ZKnY2cCtuyHIagpUvhBwUv3/evSHkGqGz4MGamjgOciBUH7DgBv9vNhLlJrlIsjJFyI6iN1rJUZRTdzN0lrDauG56vn8e66IZR/lUraiUdgu6OIJdejHUp71yKQvN8bD2dQt2wJ0BBwoyOgxFmQt2PMFjC8s8H6xg7DxoExyvHQuIIxFzwqJBwl5FsO0HUS79kvohvzcQW4L72Rl6Yk/qMOgerCqxEsA1vR0+ClI8uZEm99ZoP55jUSvLcy597uVqz5brMDONYZ0RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSBRiN3QDXn+UdttUmnB30Ar+vyLKFI9e7V3W37fdL0=;
 b=AnruR5XiAgajrB8ECVilyiq8dVqrcyoMu+/Y4HDq/6mUvIP9iTx6jyUc1nAN3H/MiURB2Ba+r3n/4k1Ir1S2R+pxPu+Yw/YmlwnC2qPb2/hzn2etim9OFtaBQ6W25PQ3YOAxX+Xwyz95ZFHGZ7hGBNzPygESbyzmIX9qCvHKVBScDiV3cy8fJge75neE4mrJg+2RoM0xRnee8dx+50rnkSsbEhaJ8GBoZ0UBkskYGx9AZYQ9Q+BYrTk6a1kkFGJUknK9mN1Y7hY9TcM0i1zESjQEGeoAP1Shxg1yhXOwAN4X3T3WLbYm+fs7xPoRIjMdMNupP8hZWbpkidw+kDG4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSBRiN3QDXn+UdttUmnB30Ar+vyLKFI9e7V3W37fdL0=;
 b=fkb/JbfH+7ggYfasiZ4JOJlBaUirZCYcq6OcnHCPzrK8cfpgpxaK1S3vkN9fwC9bkjhFu4ynx/xAIoNcDOSe3LEsc1iPbDm1A/Pv50GiwrkrjGlqWqRDHN2JQ973UjdVaEp3dxpixH7qgcMs4Tt3IUxrvFNvSsGrEa7itCs1bNI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4939.namprd10.prod.outlook.com (2603:10b6:610:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:00:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:00:22 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 4/6] maple_tree: Introduce mas_tree_parent() definition
Date:   Fri,  4 Aug 2023 12:59:49 -0400
Message-Id: <20230804165951.2661157-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
References: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0286.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::6) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cf2793-7ba3-4480-2e65-08db950c4a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kABZ5l4rOAILR0fqwkZ7OGNhs24/hRUJRyJvRpTZfMAtqwBTRdFO3RmUqM+jhN1shqqB8ccw/PHv2z3wnZYkQszTTHEGBNzOvibVMiob1iQzg5U6rVvE0X+QHn8IJ6GAJWBOEbt70/Q81w4FVU5ecY5ao9JRLkcvkiVMQht0u+frtCIJDtO8dNIdE/F8YXEcX+3Ch6aZqWhWjP1S0V+5ZmJBUPYAI3xbdT3DK5Ysi7dDXR7W5MSONnx1DR4nVg6OobUNDhj3u0EuhSUpnrvCO1ijDa2LHFAtMgdc8geOw1dkDFLde4QkyfxSVC7SRRSrRL/zILeNXBhbd4gjr1yacLJUCPztkqINrnkOOGrqJU+hiUvO/kSu342+1g2c4zlosHbwXqQDIIpgi/yY0KrESv+KuzCFXwIuVRyhB53gma1wz2y5fieN3E50AkfjMM9nEG04D+fxAV17Lr5zuoVp7UviPbVQMmmzjLLcjkJIO5Nv5wGYa2qqikFo5guEeR0CM0z6zw0YZGlFP9LknnBgu+OCpnA8U6tk0Al9a+oSseRNQoFPSR1wFFnz369MQlw6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(376002)(136003)(186006)(451199021)(1800799003)(6666004)(6486002)(6512007)(86362001)(6506007)(26005)(1076003)(107886003)(36756003)(2616005)(83380400001)(38100700002)(5660300002)(41300700001)(8936002)(8676002)(4326008)(6916009)(66476007)(2906002)(66556008)(66946007)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pKpNAdwRhUUrAvdRLMeaQtL+1d7Yxs3ttZs1YrIsKP4Ed6HncUAu3izdlRUv?=
 =?us-ascii?Q?vmrUJaXEbQqnrZaPQIDHUemAYHYfBF+QhXCxtYw8ddcLIDmuhLcWvP2Ak75V?=
 =?us-ascii?Q?do6nDQIE2Qbd7bDxaKTj0OmgPkxdv/I1KBVWv8G8eDp/Y9IHpuAHT72YIZer?=
 =?us-ascii?Q?Kelxnd15VIBFpdD9DErblwQ4ubG2QDZIaAD45ih6q1AhJpSxzE+lbt7mmF+k?=
 =?us-ascii?Q?3Rbj9qQXcxEOG347NPXdJQWC8A8+7mvYi3fsQ3itYOeCmiic6S4/A/+7+R0Z?=
 =?us-ascii?Q?lEQVq2K3WG1juG/+vKavtPWZWSwWSAl1XOTCEoX+Eo4ecnMl0tnOBwwDOh6+?=
 =?us-ascii?Q?Ev90wSxex1IRN8vT9H9XyAKSJtga4ZnJ1vcbtZk6GNdKBYWKcjdbhxRcwMrN?=
 =?us-ascii?Q?FSlYAFUyk9KMsFkdAilFuIAx7yC1QFjvUPKLcR/AxnFI9vFbRDYFn2ZbrZzg?=
 =?us-ascii?Q?+ik38KhwtbfgWFIgeL3ffpdsbs50n+Qp/04uL1ipTBQyVkRV7UqxMfONQPr6?=
 =?us-ascii?Q?jGdahJ/KmPQ8pcZnl0hqfU9plsMfb0zSi03H4Ar0geQum7jfvS4SPLWmFIuG?=
 =?us-ascii?Q?zLr9NGhydTUzeSLX1s380UtEkkFSAXiplVULoCrRmSgAaOj/vbtbu0US6B/U?=
 =?us-ascii?Q?rIymX0KD/GzO8ida5oijQQxJRQSNJlyB6pYkoiJ8q7xmgF0I9N858Y3GqDCj?=
 =?us-ascii?Q?bJKPww3RcMcJ+l+K1w3skEBPxZCdCo+L14URz4C0jhL0IoqmZn9ET6Lk3ZXq?=
 =?us-ascii?Q?cDlJvTShlm5aVLt4sx29GisinYcjvq/hIBKuY1tSmi/ErKHDD9tOBqFyfhMo?=
 =?us-ascii?Q?w5GeC5YA3pe/YyiW+T/yRLRQ73f7IyiFsCW4GJveq1BPcjZbtHxW3Iy7gfP+?=
 =?us-ascii?Q?qdHBDloZAcMKP5W0AN5mwEgkchs1QZM0RZg8RjsgZeRxgcmYWIevkMB8gzXw?=
 =?us-ascii?Q?I1Is+VHso+CEA+3BMVd0t70fn4up4WnlksjWsUwGnI7toXQP6fdgzhg04eO5?=
 =?us-ascii?Q?4D5unb+na7JSOju2NnyzcK4MwUStJerg8+NunsN8SVumrRLeCBr2URyTwA97?=
 =?us-ascii?Q?g2nmOJiJ8D3HzGI2R6o8+T0Ummw0yOYTf/s4FcdeIT3VQ1jQrfGOkSV4cwYk?=
 =?us-ascii?Q?26uEJf/NZGCU9fzBWxJ8Cdh7csNIVY2IvodQLhBDhbHdMoYQwu0PvnhBn43T?=
 =?us-ascii?Q?tXlfKcUWGmAWnpPgV5ymdYhulvRV5q+P0VvPsv2TVDrOs944oNyR/ouquK9a?=
 =?us-ascii?Q?9jgadsonWlibGk3YuO3Xm5qkIRl/Sx5fRqLzmVcbv5Yc8jlEzA1UDmciE/EI?=
 =?us-ascii?Q?9Ed1BZoEyua6CbiVkGckbN3zVc6NnoZF2w8kFtuGGM9NOOA50dOrwyTGwBAq?=
 =?us-ascii?Q?FKiGNDw02YMiq8C8Aw/OIFyVdPBlbSDHXSvDhwKXcMISt54xrtCYv0JJI30Z?=
 =?us-ascii?Q?JSMK0RIGA0guYyt0axzCw2s31xgmzAf9YyLEIasSNY/l8lwr+szlL1v9vRtN?=
 =?us-ascii?Q?zDlaU9ieNywBOAy4P11zJBlciHx+mcrUaR5qZt1b0Y46hC83nEjteHGig9SP?=
 =?us-ascii?Q?xCK9GyZjoSu7NYifvPig5ZuhcyFGQmC6sQ2RRX3X5CdAjQqNUukDDFDgmY2r?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ckoAJr2ULvhjkE4Jd261i8V7kjLEeVp+2V32gx9spiO9E2rpQujf90DITUcj?=
 =?us-ascii?Q?N7fUMApJPpZFFEbK4NNqGOOCDXCk46P5CJSasEkrWht1Z4fCIUJlh4hpIht0?=
 =?us-ascii?Q?tTV21rwYUiE8isfY8rqCINslRhiori2X3oYjFA2zklko/oQEEcEBARici6s6?=
 =?us-ascii?Q?tADCuLdnqZn1Cx6fKChKjvDXCs434PzveBLTxt69gaqgVGZxcd5Uxzk5ZcJz?=
 =?us-ascii?Q?M/kuRXFhfbdJ5b9XGFZzkpItzWixvDlLbhia8vROBFbJzC4vweEWlgUDrdEY?=
 =?us-ascii?Q?sx0XNIxiesTXQywhwqvq1uIjb2heuyglV9IjCSqKYMvMMoQRroRzx1htr4mi?=
 =?us-ascii?Q?nwzrOxGEEpQzgqS7iUIt/3TT44OCvRzLti5ibXweHZThcy+L4yHBlPEhPQ3A?=
 =?us-ascii?Q?jTAYg1WoGPM/Mm/qO7t1weBPmfy11V9mPvfxQWf67xxUb64d76gOvG1Pmj3R?=
 =?us-ascii?Q?wQZvnhrT5mFoMr+BsQSGSNmpd3EWkt8ovPj3RnxG3eOreq4rSHDd5qUYjAJz?=
 =?us-ascii?Q?QcGdFn5dhQqE23QOKqabmt50ozlI/5laARMGNl6mjt2zEJ3eAkAits3udl9w?=
 =?us-ascii?Q?Re2RoVLN7XhXTCZlsLIUIPhGFy6VhxhEM/VTSBv9Ei4ZQIK3xtCl7q+AZ6VN?=
 =?us-ascii?Q?yQKCXq16kN1flbgeRiUeaOd1ECjUGm7ZDnG5Pznc34jizflHrtLA2EPi7jZU?=
 =?us-ascii?Q?qdmCQr9bfr+s5tVZbxzkNqv0jEQnEBA5Bh8KVVCL/QtXO2Uts6xd/ew6zY0s?=
 =?us-ascii?Q?Qwjk6P21ukMBeixk044t3unTN8GsthvFmi/iJ/FP8VKcZZhjYyThIxdIK4Xa?=
 =?us-ascii?Q?sz+/lrJ4aEhtrkrbOedM9x/M9txTCKq3m/F2RDB2NTEYdaAhm/dYvPjHxFFE?=
 =?us-ascii?Q?qAHRib+QlbvTkwoBdMzlGafPZAuB+6bZq9WPVvTq7X+1XDxL6EkundSFBE0y?=
 =?us-ascii?Q?cX+49j4JMFWZJAZNcIDRvm8hc+HNeG+eKCnnDLNew5s=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cf2793-7ba3-4480-2e65-08db950c4a6a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 17:00:22.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fS5pV1J8KCqHxjkdlzikOOeI9QLIsGsy+g7qCNkgRDzceDGemusCnFA5mfu8rmUkJ/jwdq0CXGzFuAlJ/opK2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_17,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040151
X-Proofpoint-ORIG-GUID: SYYsx-cerzgYfAgzjKl_eg0581WQsUrB
X-Proofpoint-GUID: SYYsx-cerzgYfAgzjKl_eg0581WQsUrB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a definition to shorten long code lines and clarify what the code is
doing.  Use the new definition to get the maple tree parent pointer from
the maple state where possible.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index c01b1be1480c..cf41e0dbb87b 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -75,6 +75,7 @@
 #define MA_STATE_PREALLOC	4
 
 #define ma_parent_ptr(x) ((struct maple_pnode *)(x))
+#define mas_tree_parent(x) ((unsigned long)(x->tree) | MA_ROOT_PARENT)
 #define ma_mnode_ptr(x) ((struct maple_node *)(x))
 #define ma_enode_ptr(x) ((struct maple_enode *)(x))
 static struct kmem_cache *maple_node_cache;
@@ -1728,8 +1729,7 @@ static inline void mas_put_in_tree(struct ma_state *mas,
 	void __rcu **slots;
 
 	if (mte_is_root(mas->node)) {
-		mas_mn(mas)->parent = ma_parent_ptr(
-			      ((unsigned long)mas->tree | MA_ROOT_PARENT));
+		mas_mn(mas)->parent = ma_parent_ptr(mas_tree_parent(mas));
 		rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
 		mas_set_height(mas);
 	} else {
@@ -2798,8 +2798,7 @@ static inline void mas_wmb_replace(struct ma_state *mas,
 static inline void mast_new_root(struct maple_subtree_state *mast,
 				 struct ma_state *mas)
 {
-	mas_mn(mast->l)->parent =
-		ma_parent_ptr(((unsigned long)mas->tree | MA_ROOT_PARENT));
+	mas_mn(mast->l)->parent = ma_parent_ptr(mas_tree_parent(mas));
 	if (!mte_dead_node(mast->orig_l->node) &&
 	    !mte_is_root(mast->orig_l->node)) {
 		do {
@@ -3661,8 +3660,7 @@ static inline int mas_root_expand(struct ma_state *mas, void *entry)
 	node = mas_pop_node(mas);
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
-	node->parent = ma_parent_ptr(
-		      ((unsigned long)mas->tree | MA_ROOT_PARENT));
+	node->parent = ma_parent_ptr(mas_tree_parent(mas));
 	mas->node = mt_mk_node(node, type);
 
 	if (mas->index) {
@@ -3938,8 +3936,7 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
 	node = mas_pop_node(mas);
 	pivots = ma_pivots(node, type);
 	slots = ma_slots(node, type);
-	node->parent = ma_parent_ptr(
-		      ((unsigned long)mas->tree | MA_ROOT_PARENT));
+	node->parent = ma_parent_ptr(mas_tree_parent(mas));
 	mas->node = mt_mk_node(node, type);
 	rcu_assign_pointer(slots[0], entry);
 	pivots[0] = mas->last;
-- 
2.39.2

