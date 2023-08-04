Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1211B770685
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjHDRAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjHDRAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:00:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0767D1994
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:00:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374EiEkq002988;
        Fri, 4 Aug 2023 17:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=FX3AVzelaw6ITZi6EysUWnMmnKX/hf4MQkplrvHqWt8=;
 b=2YijfXjTiAbI8pZDFTkVBwIhoeuSdoPw2zUyJ6SngNzto+6LCsvOvv5KwOujCfpIC5Rx
 Bkwlzz9F4VvmEm45brMT8CPWr0WvGDVE+HOPR1H8lj2bOii1i3gxIWM52mNkbAUbhA3h
 rScIpQwlgRvxExsoYhr8WDMQNnKHpHrHo7CK42pnMgkr9wQvIMntsn2kvJr0Pwq9NTrc
 dzfWCfdLnBmnPUcB4n79P+S4N9ClT0PnmZIQr3caSYugua5Xcu/cmhRsOKjgg8/IfOUi
 Bm3CA1rdyzmZnSown8wX55UMvCLrTslGhq1oX4g+ygl2OP8H6T/k7VX5Bk7Zm1MRZMAp Gw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4spcc9v4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 374Gt8Y0029324;
        Fri, 4 Aug 2023 17:00:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s8m29bmms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Aug 2023 17:00:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOZt6J+fR95OXDTDPq8mSe1+yIc414rz89GFy2D9Z95sXjUqlOBsGiNVTz4vTcUyew5ebVi9TE5OyAFWKMWPWKA5zauT7pbQ5zmYY6e29x8gdTOyEZjprYENdEY5I8wTAs46gDaxE0iIzpbZz9d7BEm9PhIn10eB70mZWXS4lnVNOxo3PIi6XmNxMuyh5WCH1F8YhShaH7pM4wqp90sUaKdPjceFI/mPtv+dvXn1cnGlT7FK+BmZk3oRkuzS51ayLUkb9vvY1Efn7vUNa5uti6c5EAq1Fqsgy7VK60RHLc3zjSCBVIx9zBh3B94P2/5d7ux3AQEK0mnFmSmJ09aMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FX3AVzelaw6ITZi6EysUWnMmnKX/hf4MQkplrvHqWt8=;
 b=cximcLXJsO6Vtj6EykUo3Jp/LwVoxsfzTd+qkHFvGDVmFVAENpcD6B7sLSBFeU2bLYIOwzAGcOUYzKYBkOBk/4V0x5LVQw86aXqusy/5oA45m7NVcLlhwpeRFRzrMYtCQHnpqidGTiA5vxDDYJKv2ZfBmR9qflg+rxBUQrBylcJF3vSxja4gp/Z5CWvcas3S8XhRDsq3s2ItRCaTB1Vu0v8jX+EdhCoOyizzXN8FJyA0RImnOJ1g2m/ZVjGj4YrLRbr8/8W1ClbnYZfn/nt6t+zr8T92KfflgXHMm30CyYTosWbcVBRvEhWqG0eovrkDXTCvnaBI+l1/vC7kDKTN7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FX3AVzelaw6ITZi6EysUWnMmnKX/hf4MQkplrvHqWt8=;
 b=v7f5DHXDp4ghxTE+tb3rPGDm2IDu4iG4/CswdFtSWaem5kA3AYqWLg2XQuIuPnfiCUB6ZCsN5pYZGqY+cm0KdwsZoflaDEUn7n0O9CpxTfIkiEgLFII+XNWEf1mWdLEyxPDjnokBtnP8imU+/owHEudpzTcALkoYFEp8Xy0UiAI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4939.namprd10.prod.outlook.com (2603:10b6:610:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 17:00:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 17:00:14 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 1/6] maple_tree: Add hex output to maple_arange64 dump
Date:   Fri,  4 Aug 2023 12:59:46 -0400
Message-Id: <20230804165951.2661157-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
References: <20230804165951.2661157-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b912ad6-9581-4633-6c86-08db950c4560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d7Zktq7fjjhwSy+rvEgLak+wzE911BkqwjT30JR+5NLBLvX6PmGllI39s2KRGh0e353e7LWh33uV0fmtoNFtY+X0uXvBCc7H5UivO8h3qE8+mCXUNMrufOsa/2bDifO52EdJKcMp4o+aZzzCB24JXsPrdbTSznkA8CB2ux8MFzwKc0UohREz12U49U1DvdOjOUla2pVyPHruQuQMN5fdPnPa4syRHitCwm90NgATQvjBCFWkviWfFJFVYLWsm6f0MHf62weicQsq0XzxR+CRFppo7Zfxm3qOWL6knbOX1jCk0RoNDSSO5fFuu1rPKBVJzcZge44rg0A8SouZZM7RsBrlknlfEIW6QS7G3Ezd/JzCFv/YVWQNQwY5gimTuzZIsq5p0Lt7qrv6aIlcQebKQDPCCoKfb8djKTzSJzmVtliFdl/nIvZFBYI+kYUJz0RRzlQbZ4TM6nhjK9PR+HQRvi8Px7geqYafzAMUktTfzukq++/tjfCfggkvbu7zQIiAcn3EQNrHs2XnBu2C2NaKoB6zTSEfjS+nJN93u/805HiybdJ4nsxe2RBoo6YlL4EB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(376002)(136003)(186006)(451199021)(1800799003)(6666004)(6486002)(6512007)(86362001)(6506007)(26005)(1076003)(107886003)(36756003)(2616005)(83380400001)(38100700002)(5660300002)(41300700001)(8936002)(8676002)(4326008)(6916009)(66476007)(2906002)(66556008)(66946007)(316002)(478600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k6IQPoLcAFBnjWZNwS7UXw79/aOqt5nL0+9vwRb3qL1Bfipzab1E30JBr9rG?=
 =?us-ascii?Q?n90qnp5HvNSOyfQTUXASLn454GSXkXZuDRRW/mrJUVkPAV8MprUcAKxucadu?=
 =?us-ascii?Q?y1+KxuHgpELUZvtzV/YoIahlpLUhajbVVIEauyfF6BgiRNU6qenbGwFtpyc2?=
 =?us-ascii?Q?p+8M3F5BMUYc40sMuHfOnIzqkwmh53+LMNrvGRF7/8GPbUgqzKCPjEPvlluE?=
 =?us-ascii?Q?/76v9fzDx3yUL1kXtccovBQlnG6XVofovEdCECikpQ/nHZBQFThqayd1XpMR?=
 =?us-ascii?Q?nfVO3PEDMUZpVVPJCNBOlldL6Vcl+IJ/RnA7tnCnDeXu433D3NfuQxYaPyhe?=
 =?us-ascii?Q?fcPfS0nrPLhzVmrvXZ17YYkS9/Yn6zsQ2pudnoBOtAKNQmFE+E3EuBHj7kdL?=
 =?us-ascii?Q?fsQJFyUs2klkjJtsOYHjxQgJCx+JV3iYVX0yp6PM8v7yvSgfc8eS+fkwts1e?=
 =?us-ascii?Q?oiIYQrpfXb/lQ6PuXvjihwVfU+orJoE8ihLAIgq0/dL3Qg9DPfA5UxHiS6is?=
 =?us-ascii?Q?ey+FKfP/awmqisMSJc7nJNcKCErS4yU4Ah012BGcJ4OU5CNWLIO5m97jtBPv?=
 =?us-ascii?Q?ryrjH0lFAgz/w/a7uy9NUMgLYPtnJaO1Gjq1mjj8c8L8ApwfWx7DyDKWp4Hk?=
 =?us-ascii?Q?UCAvUb8LliT10IeKGasPRF68xVDwkYROMQbTYAWgKuxawcJ5rK5xwrFG5LN9?=
 =?us-ascii?Q?6Q+LGufhZ+/LtOBbIZ2I+Wn7aj8dBEAxCS8bf4YEn7JBi5rvjxZHj8Bzqp1T?=
 =?us-ascii?Q?TCUWZBn1sYE/y0u4qINAt2bYYpUdunnyTO1hCzOPvVc5IdTrvRcRQSOseAEP?=
 =?us-ascii?Q?7KAuMI0fhbJBdlUlI/hvM/5Qlb9VZwPjsjGyuZ4dPMYaldGswWCm74AW112i?=
 =?us-ascii?Q?6OCOsSpAJJOFyXRzniLRqX0lcgCLpSBI1JpZDkeayqfKLuA775QmI9X1tJVz?=
 =?us-ascii?Q?JOc0y8ffn6EMlHqHV8mktSNanN9bV5r0mv2G1tkrye1PNh8K8Id3o4HBgr0+?=
 =?us-ascii?Q?eS9apu5wGP5cRMYnmKwn4Pj1I0BIcqIcjddBvzBHH8paT583wY15UU5El3qz?=
 =?us-ascii?Q?Dm8RsW0OJ94ZNy0DKzTHb6+gZcnvkcCEf16OrUtVsZCd9OnJ7LzK67YrkdaX?=
 =?us-ascii?Q?r0lblatu9hHIwoRbyGMkbU7JyFVc4b1HfAKlRLIWPFPQDTKBxNqxDp41bQuJ?=
 =?us-ascii?Q?vFcQJ8gf0ipGCt17HZT6Wz1XI1aLdej27k5OJIekb6IZXN4bnz/831l5ip/G?=
 =?us-ascii?Q?u1dzkJxfepAmIIcQbA/C+vnae7DBu/L5ukdFZhLcu4nWyCMCyohPb5mPE/0E?=
 =?us-ascii?Q?Uj245v1LRljdJaymDvoUo0o5pPvDEFFpHUlKt5YcH5c3kkLhuW0K5jDiLw9Y?=
 =?us-ascii?Q?8WuaKAhqMLCbDRlMIQ21W4HxxYZdI0V5YyGwZ8CNnVNiVYBcoyvrfvZqis0Z?=
 =?us-ascii?Q?cyWJdV2oMuz3lrU5azQS/Nzous4qhMDPejdIwV/P0U1Oz6UmzqvGt8HI3tua?=
 =?us-ascii?Q?WcCYT8qMXdcDQFY1/L02o/fe//38BfN6l/S0fDTYxKmE78f9QQiS0L+Ee2Yj?=
 =?us-ascii?Q?UgtHwZMlGQJPhmwf80b2U82GEU7QxAHDLQopml1vpHzzRznniz8twW/ip6UQ?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Dw1Gb1g6ISuF8arsAOWKcyJQS/uE9wsm1W5QnowOz0WwtmDSWPCt7dAO8NEX?=
 =?us-ascii?Q?3vP7zxBqbWhEy4pww2G1Yov2+s+7V5eBz2HVuedUdxNYqBQoBdYj3a8Iugzn?=
 =?us-ascii?Q?8HcAAWH4yAgY0rLnCOEgO3jzSoFAQOswQ1pVbgZUp1ZZMrJB8HBf6EFaWnRw?=
 =?us-ascii?Q?RKU+5HxocBorfS7UhB0FJbQvJIpJr7sTbIjxt1Bq4g12UYY2JyA5NfJDUYnm?=
 =?us-ascii?Q?nigX1aILltdJyS8nvCrKJ3E/PN/4S0cDQqqhYrTtpIQ9qFEPWUfuYxeYcTNK?=
 =?us-ascii?Q?yi3XIdLVeXzyj9nqpjiSRM9mgIz0pp4VOoANz7qKg0s2syelg612VY798/ts?=
 =?us-ascii?Q?Mi7y7PLv3MqMjH/mGn1m0L4vg9Zdp0840TdBFh52evBILcd/quGiCdlz1suA?=
 =?us-ascii?Q?MUUqQdmxqfWBdQu77YFNUqVcP1fIU1M0HA+fLtqmepAP5efa8DFbXOFuV6oT?=
 =?us-ascii?Q?OgfG7NHCMHnsG7o4zxez1iZCZEb3VnL3khyPD5xSaZp/vy6BQ2Wdun4HiRxP?=
 =?us-ascii?Q?y7lZxjGWrZ2aScDd0QHvk+w4G80QZf0+QMQWJRpSB7x5xDKcAQUNG9BMu9vz?=
 =?us-ascii?Q?em/R//rZn6T+oyd0Cr0N6yvaQfL106Mf8UYPE0P/Ucpz6xDwuZIK4agMr2E2?=
 =?us-ascii?Q?QfealzrGqwvNipYLMpWV1PVG+yt4vuBSelfzFUYmfSE9ohUX8IuMa8uezmKM?=
 =?us-ascii?Q?PIik6TDL6o68LeURzXcw+de7dVgy1kWqcnX3Tcf6k8tLMnqJFH7TsKDYPyaY?=
 =?us-ascii?Q?k1yaqnWDMQdBzGEyuFRh82PBghTU3pu0DTHzxqid+B1P88utmSqFFO1rScET?=
 =?us-ascii?Q?ooxDQheDjipuKffOyH+w3Xlb2jLOlNob7lOuVeXmYFajUFYCGTNKNnUBRCGB?=
 =?us-ascii?Q?zahhJqOGEeTTzkSNCR0uEjcsouG8wkPVZI/GOUm+EAHaETnG5orPC9VIJP9D?=
 =?us-ascii?Q?gM0DWG4KwovWgzn+yUoqkE8QLuYsffAD+EfGi2OOQYs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b912ad6-9581-4633-6c86-08db950c4560
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 17:00:14.0317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwStVAYx/5TY+2sIIgw5sl1Pzvjdrd7oNXb0hgzkM4eMRBuiTQQXqaYNwZPRh20CO8y6DRSgo2pLCCPeSjM4Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_17,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308040151
X-Proofpoint-ORIG-GUID: T-VwZFYPxZ1PUH_Y7Vj4TK1BF2Xb-T4a
X-Proofpoint-GUID: T-VwZFYPxZ1PUH_Y7Vj4TK1BF2Xb-T4a
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dumping the tree, honour formatting request to output hex for the
maple node type arange64.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index a3d602cfd030..880ce0fcdcac 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -6833,11 +6833,27 @@ static void mt_dump_arange64(const struct maple_tree *mt, void *entry,
 	int i;
 
 	pr_cont(" contents: ");
-	for (i = 0; i < MAPLE_ARANGE64_SLOTS; i++)
-		pr_cont("%lu ", node->gap[i]);
+	for (i = 0; i < MAPLE_ARANGE64_SLOTS; i++) {
+		switch (format) {
+		case mt_dump_hex:
+			pr_cont("%lx ", node->gap[i]);
+			break;
+		default:
+		case mt_dump_dec:
+			pr_cont("%lu ", node->gap[i]);
+		}
+	}
 	pr_cont("| %02X %02X| ", node->meta.end, node->meta.gap);
-	for (i = 0; i < MAPLE_ARANGE64_SLOTS - 1; i++)
-		pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+	for (i = 0; i < MAPLE_ARANGE64_SLOTS - 1; i++) {
+		switch (format) {
+		case mt_dump_hex:
+			pr_cont("%p %lX ", node->slot[i], node->pivot[i]);
+			break;
+		default:
+		case mt_dump_dec:
+			pr_cont("%p %lu ", node->slot[i], node->pivot[i]);
+		}
+	}
 	pr_cont("%p\n", node->slot[i]);
 	for (i = 0; i < MAPLE_ARANGE64_SLOTS; i++) {
 		unsigned long last = max;
-- 
2.39.2

