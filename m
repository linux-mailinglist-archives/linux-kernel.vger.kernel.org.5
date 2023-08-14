Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FD77C2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233042AbjHNVqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjHNVqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:46:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F7A10D4;
        Mon, 14 Aug 2023 14:46:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37EJOsFk023657;
        Mon, 14 Aug 2023 21:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=/7ROwlVhlu2Jna5QcnLwasLV3/8Weul2J8Px21TzAjE=;
 b=U/EJEqaZGE3k5RfB3JoR8moK/CDd1NR1hw2URcwbGgWf9BcWgUVVr8qcLAgpSf8QxHnH
 /xZg1DSv5aVWF2OF9xWxwI6xuea2QxqnLY826UHc8zB4Q+RDfsqXtMWXnHrnXnfQYDLP
 xqsurT4EkrHf9LbZtSef1f8JZ0H+8Jx7H61R8QSi+KtsXEvgUVX5vEG8y4jF14hU9brY
 MobbUD9ThSdeIpn3E7hRIa80RVVj2iCN1VLkUeimm3SI/k97Gjar5lRR8TB2hQMQiwxl
 asfRJAfszvjML6c2ineGzZtAqLBF1vMYvytvoicxoQVfwcEh7C4yQwSjO1FAUhdK7z+U UQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2w5umkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EKObtx027346;
        Mon, 14 Aug 2023 21:45:07 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rdx2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 21:45:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWpz9UFU9qw5dIhSySfj6OyFY9yVms8fA8arR7ImLyaZzpxNk11kxQpPMndVD6Vc+eaE5/NYGU3yK4cQ8RgUfq/+VMaUyEI8cnQMp4J11ZpxVEj+5uEw3K4J15kQF95mEwydauh77dHkR6NLKPXSGplctk19TirJx/nw91UxLayCepiVcbOXwQdOS//Xls9VZriGWJmJQThdkvSSYpYB5DZZ27w1DShY3FXJLiVyUD5JhrcAWI+NBHsjy/P5eO85QmImVCa6S1LZSin0i6fN5yMeYW8ftVvQ8C9gOmuwQ5wHpF7FkBfGWe910gDz/JcLMqvgprU01xKWo16PJPdkvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7ROwlVhlu2Jna5QcnLwasLV3/8Weul2J8Px21TzAjE=;
 b=F4sadD40svK0K43bzMK5zVwrjfnHQlLaqkaeSj2Slf3Ed6zIUU6PXqoIainlyJBotCclRNyTTazLuU5quXvAyrWw//+1j2Itd+TX2s1fTSRxyo23snvMlKaQ5cA2KqXl4EJMMMdP3GsQCA0zwhZ6+s9IDGqXBORBfILOQeaSA2w1KBu35pKfVVORH28HJT64s4esDeqM8Lon9xVx0CoAnmnCSxq+69u2JoIECgCeI5Zy450jBbceDv2RAu35MSzrs3sB0VtUbdthph1l3bjIRyiKXTgpRNFa00A+/mO+muFj1MYPfrplYvcqjZGyD7sI//WYti+X2uAA/tObhT0rpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7ROwlVhlu2Jna5QcnLwasLV3/8Weul2J8Px21TzAjE=;
 b=V+sSfnF7vKeGfw14UvurBED4fjCR6KXY50emeITwd1XEu5+JhGqyIQgzp+YwuQEcj6RThECMexEquV/g7bAJnsB6uFd5Y0ENuDnS9Z9UY5oP1VEP/MD52vW5O+rS1/a8unCXHsidfVDg866p47C78wLOpa+QRBeg2jMMEjBHZjw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6222.namprd10.prod.outlook.com (2603:10b6:8:c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 21:45:03 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::be4f:55e6:89c5:4f57%4]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 21:45:03 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v28 4/8] crash: memory and CPU hotplug sysfs attributes
Date:   Mon, 14 Aug 2023 17:44:42 -0400
Message-Id: <20230814214446.6659-5-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814214446.6659-1-eric.devolder@oracle.com>
References: <20230814214446.6659-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:806:d1::7) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: 669e711c-0b7a-485a-541e-08db9d0fb762
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UwOAwyrKlDqvGn74pbgcWjLWFttjQBJOf1f0t6pWaHWTOuuMWep+lfAobHqHhYAWzIcaAdOah264EXkRStgdVyzV6iPY868hqUGgB1pMq5htkmKMBdrqnBtgCpDy8GNWFT1/SfoNOHnL16Xhq5UxJdo35XF8lW7yXOlZ12VvRDEiT2yWOV49/GlMJK1iXcKPG+LcD5SyfiDZilkVmBxY8HJHg87CcSiuo9iY7e7TXPzeY/iIIeY+9TMc0WSGT7lZ7t1k6uZEaz024r3wPXNCMYvGwEXcc0Ki7BOL75f+ryFrg4Lvu2cFdngbZ8Hj4NExVFC1Osm9kkNaz/4/vHxc3KaEnOYxOncw5tOjXk3ZPQcEmB58L0Xg3lYXB4q16h4YUpCty3L7zzc56LWEUGyWucZf7Qr/bCsFKYZYAHTLATApdkdcj2HxOtcbd6uN9/DD+FYE+ko0sa2Eco4wh/I/KrmYEa5Su7GiXCjHm9ba9DkDZMqa0Jf6HnWh1VzMMt6kql2rhIjDlHCne5z7X4YGfQTGc595piX271M6Whz4Kiwhn8DaBAwIIiSA8ObjNDaQR0s0uaWXFBHYGbrpEZtdmJkrMABtvx/dyZ00peGMAcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(83380400001)(36756003)(86362001)(41300700001)(478600001)(921005)(66946007)(66476007)(6512007)(66556008)(316002)(8676002)(5660300002)(4326008)(8936002)(38100700002)(2616005)(1076003)(107886003)(26005)(6486002)(2906002)(6666004)(7416002)(6506007)(7406005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+klxjqehBIUc7IsIj205xl+NuASUcpA4seDt8j7srqRWULTPTT1bnVcy6j7X?=
 =?us-ascii?Q?XPbkcyXjqK/s7YhfbmKtZuCGStoAjsLkjVTm4e83trGYHpa7s42aOTHQFqjK?=
 =?us-ascii?Q?uNgveBmDcxjrbpzTWMyJivVi4xCAOCyRec7GbZ8OWvDxnfFRJc6fhSsZFZTU?=
 =?us-ascii?Q?CzXFSt290e5M/bVh1USnHTFKugUWFxL78RVGLjGDwqy04HNFK9RdKlbVcrUN?=
 =?us-ascii?Q?RnrrgTqJuqBCpp/UEKDwTvRoHwgTVBkdWgNajVqVKjdcg627rKc/1uoglc7s?=
 =?us-ascii?Q?2LgPy1Xkt/uE94lrtzSUxAaV+33golH32d2AiDCgFv0RUnHNvrr5nS/9+13T?=
 =?us-ascii?Q?0SKp7gQ1B34j1kQbrtSwmCl0YA/pltQuuAGRJiYj+pop4w8x8PhuTxQOl9vS?=
 =?us-ascii?Q?gyqJkS1OEbWY8VNsq+9C6Ka9GB67jhmmlVd00RHSh8MPgUTyroob4SOnUz2z?=
 =?us-ascii?Q?kclq0KGsAXRi4apbS+qrhxBY30+O3Om4AZN3Vu0HAqWSWbWk98O6VQKqkw39?=
 =?us-ascii?Q?e2sRR/oNJLjYONKRGJESOWlj6+9eAGrpvI0XxVL0eUlWWNEczpGPY421V9aN?=
 =?us-ascii?Q?OkSntdNfPbxCk5KB8UkYzjZ6nSQmYTiATg1/KRUrb3SSU9zva3Kd5uBNDLyq?=
 =?us-ascii?Q?yUO6Tu7YGLGP8VOu7ATT3qV2RjnPaTKzrWQZh4u2uObezHfXs1e7+z5eVYrc?=
 =?us-ascii?Q?k9toT2XLOcFjjyDlV/CHUGM3Giq6pIbFXBBApUM8Kj4Xyf0Q9Yq8afn/oR2f?=
 =?us-ascii?Q?7emteomiCjLqJ8M+NAHUdr9GaGHACEiI+ruZPsn3FNpSl35Io2/mgE5YoGyh?=
 =?us-ascii?Q?b2KHCWmljhOC1VsMr403bMfrzOGN9vTCRkXWerp3b2fjzseJPZbGnhj+ljhL?=
 =?us-ascii?Q?BPXW8whnLhAvatbxY9UHpkn/IFUa2gH2lFXbFtaJ5tHwkGxpgnSOJQiCJzgr?=
 =?us-ascii?Q?FNWYQOJa6X5QyNNRsz+Uakg2W4P+MPGTjK8VOEEldq7w/1hOhcT/mmm0GCgu?=
 =?us-ascii?Q?MMFS9B/hCAwGKEBqTL7GZ1FIuNAb9MjnTMld5HeBybTUtVZ8RwthLz8w4T2u?=
 =?us-ascii?Q?LE6Gj80/Lec+GqhEKWsta5in8iFN6/kGsN+mnAJrEKQ2K3PlqjKBWWMA9Gsd?=
 =?us-ascii?Q?e7ZBymjvoXDZpJMbkVUlOdFD0p4LE8/vDsSU7Gr9TjC/+h0hkubxVNdx3wZk?=
 =?us-ascii?Q?wB3QLd/mf85z/7TOWViCvCx+L6Z46gxbF+aULL3UtlNrzGAjPwX1o6DryYeX?=
 =?us-ascii?Q?FYmxqMaNZtyxRxY8cV8HDLfyGG/v12n1x5HmV6l36v0aBHvDDAxBrWp1L9qm?=
 =?us-ascii?Q?mwLDYwfCmZ9hR1OqzgG4u6pkT48vzx9giIaQojfVlPPLthNhq5A0C4MsREl1?=
 =?us-ascii?Q?0Bml5DdMQgWUfG5gNQJbR5mpYJxCwUfYHrLw42rHiIn9MU9gqbuNcAzKcGEm?=
 =?us-ascii?Q?3N7M1J9ohHZXiEmIa3/RPF8qBBRmsmQQKylxFnO3EnCSNtbWXFmfwRFhsHLW?=
 =?us-ascii?Q?mdKjIygfotPkbnho9VYQ9dw69AbZQ6+JcskX5XG2QjULo+7su7GM4WwKvGeC?=
 =?us-ascii?Q?W+NUiPNRiu8RmtVIgKAPTedMybi74WfBmPH2+4eM8+Eh0zC8pid08EvRTjEz?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?feN2Xbup+LDhlGwXJtLhyQKOtabIIRVKbK6MJq466UDDpB7SrNvuWG+dLE92?=
 =?us-ascii?Q?9NdQ5F7mKaB01HAwnFFfLvrrArDJFReGuS85TYT+iMOFHdNOA3uV5qgjflaT?=
 =?us-ascii?Q?lYxWxNueMTvygDrTkx8hhlNpCGtWPhEPKKAVyRH13WuUb61E7mJgMHpEKtkf?=
 =?us-ascii?Q?DhwjPSb6VgNKoqG5h9k3a0xRckRuReM6coMqAHQaL+75RVGo0ooHZL/EoaSV?=
 =?us-ascii?Q?qTbPVS7p9NxygVFX71npejPn8gfQ0DnpvhOLQfdUIWJDa48bRcCY+qWXwLs3?=
 =?us-ascii?Q?upPpOl59veltwR4GbaSeOAE9QCNAmx7OjHUy6HDIRMlViJ0Nt23xBna0zHcA?=
 =?us-ascii?Q?J+g1ftCQmyfQ3byuSIpWi7OMzudphdQEICcC/Ck+Dy5yY9DljfbA2jnDAcSr?=
 =?us-ascii?Q?OxCpR2MsCwe2DeEGjzh/ogat1gfAxX9r8pznINpNUY4xtXdXpGiwRA4iBC6g?=
 =?us-ascii?Q?fInd/griKeQTt4AEwOUorcPGYzmsxQ6sTDgiBFN6Yi+RHi0rBFmvobOPk1Hj?=
 =?us-ascii?Q?oKaJv7f++FO9+7R8meeRn2/rR4M1kh7sDGmcGc08Pd6sd1EzXioRQxYfyftM?=
 =?us-ascii?Q?eDAsnm4YdOkQ+vPB6RnYRTh86Xf9GmF2sTb5O82+u45odZ2ZoyMvyGl2cn/J?=
 =?us-ascii?Q?GguduQ2O3IEWTc8pn8VkhBw9yp9OUozzvQp+P2QyVEMVOImVf4UtpbixriFx?=
 =?us-ascii?Q?qtyv4DGHSr4MpUL5RA0NTllmdfe96VPDBD8GZ933PasjyzscnF78r+uOAlF1?=
 =?us-ascii?Q?7A/xkOMAL6HKDtJ5Wydn7tidTFif5iBRwvyJHRfSkq8x8tZXj7A0NuKOFSzm?=
 =?us-ascii?Q?3ZeNI/J8qGmRif53AstG49PuPmm9RyoLXdqcwnieHZhFzarXZItN8q6NiBQG?=
 =?us-ascii?Q?Nng9XiPK6OeddDeCh6rhdbFFyLN+R8zc+xdZmk14xOkDzrYC0ku6vnsfBRDL?=
 =?us-ascii?Q?KaSw4uLoFg/89uDwDIbfbufU3biqttPKKMuRid8e+RuZQefC4dkI3d1U7Crp?=
 =?us-ascii?Q?1DfHH/HDVfYjUUMe6TCc4YvhVvwDSAk8FysTvEfhfyfdoSdyGZby3B7vMSmt?=
 =?us-ascii?Q?qVkN3UKd7Q383GVgISMaLGbNNKLF4KyzIlrVBk3bDnkAVb4mdjmkoW8eLxt6?=
 =?us-ascii?Q?XeC5KcDDx4W+xmdxaSObZkPP8Jbz3wyk/FaMES6rMwE5+G26z2axDxxA8Tla?=
 =?us-ascii?Q?EqlwoYbKxfNaCXJemNh09BM40JNssL7FSsrNhK42CVwvcn6V6Apz13rxdikS?=
 =?us-ascii?Q?lEWqkx4b3J6BjwUjOTGxIcCmAeKzzmnuTOEWDp54UmDcFftmqckNAJXf+Y3g?=
 =?us-ascii?Q?vxQpNx05chs0jEzy7Y1OLXXqf/3gMpyo/kKXJie2V1evZe8pgqbe3zZ912Ta?=
 =?us-ascii?Q?buoewstakVauAa5V3NwAWC4upYBZNQuzUmSVaHw+PNN48T2k06Iz59uiPahV?=
 =?us-ascii?Q?KHIFK5FUauA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669e711c-0b7a-485a-541e-08db9d0fb762
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 21:45:03.2524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUCerdzko1e6AlZS/h/luOhXSU4MEfWZk1hZ+hn6hMYkTZoAzCAdwZ+cWXWe2Fh5iHiKfWKGMpEoezu0CBjT/U0+Z9sX8my/B7t7jp/ujcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6222
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_18,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140200
X-Proofpoint-ORIG-GUID: yxvZOn2G205rjsrP-s2P-6yBTJR6cN4b
X-Proofpoint-GUID: yxvZOn2G205rjsrP-s2P-6yBTJR6cN4b
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the crash_hotplug attribute for memory and CPUs for
use by userspace.  These attributes directly facilitate the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, expose the crash_hotplug attribute to the
/sys/devices/system/memory directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/memory/memory81
  looking at device '/devices/system/memory/memory81':
    KERNEL=="memory81"
    SUBSYSTEM=="memory"
    DRIVER==""
    ATTR{online}=="1"
    ATTR{phys_device}=="0"
    ATTR{phys_index}=="00000051"
    ATTR{removable}=="1"
    ATTR{state}=="online"
    ATTR{valid_zones}=="Movable"

  looking at parent device '/devices/system/memory':
    KERNELS=="memory"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{auto_online_blocks}=="offline"
    ATTRS{block_size_bytes}=="8000000"
    ATTRS{crash_hotplug}=="1"

For CPUs, expose the crash_hotplug attribute to the
/sys/devices/system/cpu directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
  looking at device '/devices/system/cpu/cpu0':
    KERNEL=="cpu0"
    SUBSYSTEM=="cpu"
    DRIVER=="processor"
    ATTR{crash_notes}=="277c38600"
    ATTR{crash_notes_size}=="368"
    ATTR{online}=="1"

  looking at parent device '/devices/system/cpu':
    KERNELS=="cpu"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{crash_hotplug}=="1"
    ATTRS{isolated}==""
    ATTRS{kernel_max}=="8191"
    ATTRS{nohz_full}=="  (null)"
    ATTRS{offline}=="4-7"
    ATTRS{online}=="0-3"
    ATTRS{possible}=="0-7"
    ATTRS{present}=="0-3"

With these sysfs attributes in place, it is possible to efficiently
instruct the udev rule to skip crash kernel reloading for kernels
configured with crash hotplug support.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel updates the crash elfcorehdr for CPU and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above rules
test if crash_hotplug is set, and if so, the userspace initiated
unload-then-reload of the crash kernel is skipped.

CPU and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule skips
userspace processing of memory hot un/plug events, but the udev
rule will evaluate false for CPU events, thus allowing userspace to
process CPU hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 Documentation/ABI/testing/sysfs-devices-memory |  8 ++++++++
 .../ABI/testing/sysfs-devices-system-cpu       |  8 ++++++++
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 13 +++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 7 files changed, 76 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
index d8b0f80b9e33..a95e0f17c35a 100644
--- a/Documentation/ABI/testing/sysfs-devices-memory
+++ b/Documentation/ABI/testing/sysfs-devices-memory
@@ -110,3 +110,11 @@ Description:
 		link is created for memory section 9 on node0.
 
 		/sys/devices/system/node/node0/memory9 -> ../../memory/memory9
+
+What:		/sys/devices/system/memory/crash_hotplug
+Date:		Aug 2023
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) indicates whether or not the kernel directly supports
+		modifying the crash elfcorehdr for memory hot un/plug and/or
+		on/offline changes.
diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 77942eedf4f6..b52564de2b18 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -687,3 +687,11 @@ Description:
 		(RO) the list of CPUs that are isolated and don't
 		participate in load balancing. These CPUs are set by
 		boot parameter "isolcpus=".
+
+What:		/sys/devices/system/cpu/crash_hotplug
+Date:		Aug 2023
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) indicates whether or not the kernel directly supports
+		modifying the crash elfcorehdr for CPU hot un/plug and/or
+		on/offline changes.
diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 1b02fe5807cc..eb99d79223a3 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -291,6 +291,14 @@ The following files are currently defined:
 		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
 		       kernel configuration option.
 ``uevent``	       read-write: generic udev file for device subsystems.
+``crash_hotplug``      read-only: when changes to the system memory map
+		       occur due to hot un/plug of memory, this file contains
+		       '1' if the kernel updates the kdump capture kernel memory
+		       map itself (via elfcorehdr), or '0' if userspace must update
+		       the kdump capture kernel memory map.
+
+		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
+		       configuration option.
 ====================== =========================================================
 
 .. note::
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index e6f5bc39cf5c..d6d470d7dda0 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -741,6 +741,24 @@ will receive all events. A script like::
 
 can process the event further.
 
+When changes to the CPUs in the system occur, the sysfs file
+/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
+or '0' if userspace must update the kdump capture kernel list of CPUs.
+
+The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
+option.
+
+To skip userspace processing of CPU hot un/plug events for kdump
+(i.e. the unload-then-reload to obtain a current list of CPUs), this sysfs
+file can be used in a udev rule as follows:
+
+ SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
+
+For a CPU hot un/plug event, if the architecture supports kernel updates
+of the elfcorehdr (which contains the list of CPUs), then the rule skips
+the unload-then-reload of the kdump capture kernel.
+
 Kernel Inline Documentations Reference
 ======================================
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index fe6690ecf563..43dab03958f1 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -282,6 +282,16 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sysfs_emit(buf, "%d\n", crash_hotplug_cpu_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+#endif
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -469,6 +479,9 @@ static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
+#ifdef CONFIG_CRASH_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
 #endif
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index b456ac213610..15bb416e58ce 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -490,6 +490,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", crash_hotplug_memory_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+#endif
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -889,6 +899,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_CRASH_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index df395f888915..172e9a544928 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -486,6 +486,14 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
 static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
 #endif
 
+#ifndef crash_hotplug_cpu_support
+static inline int crash_hotplug_cpu_support(void) { return 0; }
+#endif
+
+#ifndef crash_hotplug_memory_support
+static inline int crash_hotplug_memory_support(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
-- 
2.31.1

