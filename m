Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A80579EBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbjIMOwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjIMOwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:52:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0315BAF;
        Wed, 13 Sep 2023 07:52:17 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DCPkXc005556;
        Wed, 13 Sep 2023 14:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=WySQqKjwlKswxdNm4YGZAbqiADOLQstUIlzOlsupMOk=;
 b=T6P9MZfb0nxfySQDsoMM8rF3LEiw/nobGlqFOXgaze2kWQYsDAwb3puMshh+UGQ/FL/p
 DLrpgJWbZqegJz8F0rAMbQy0do6zrWdy6k3NMLy6Hef2NDIqBToSIpk5pQ0Mz+DFcthK
 js3TJnCsjxWPiRZf4aBJbFtEuuQVVEel8S928hOaxfDfyqREFeXVlVlslXbDKd2Mfb9M
 A9lRi5ENbpg2Gpb8B0NWgChYku7BLmCdd8anxyQyuCb05AUT9KlV3A9J40vOwp53j7Fs
 7uPgsMotKeqVMWi/YWf8JpivNwCflry9hh2qJYoSAW60wnC0J8vRjG+Ez3Cfv1qUi3UC Iw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y9kt8qn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 14:51:32 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DEZO8C004510;
        Wed, 13 Sep 2023 14:51:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f583h5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 14:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNK0TmfCl3i+mMhczer47FiupS+uqSKAymw8Ou2HLL5zHq3YOLGucRLy5VnF3T+DkHnRE7iz/glRDYqEXCzAc/p2GECHmc5YSYZRqoRpRyk4a7k2KFzbNSBvOm1HkZwVm3hxMlV5vtE+3o+frF1JeoRXmB+Oj1jOcykOCM4jrSzcqqGdKMLNwka6qLHWxYp0aoj0shiweQl0V2YO/ZnKmlVsK3rZhrvoRSrbP3hmay5+l9dEB7uFHyRMiuGN444qsM+6xCYAFMgP5eS0V66x6RDoGu3N8125pFFmHGKivf/VBnMPVZTNugkYmm1QfnvRSnSkcyxArp+Dsl8VEIu5nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WySQqKjwlKswxdNm4YGZAbqiADOLQstUIlzOlsupMOk=;
 b=fi6L7dj1jEi72WxUV99b0XgnUYj8YJf7rC+TVvwGUmyDDeLX16qvmJO9FL1DzkT9PdPFju6gFwrSsHtBvFiDaMuklC5WdzJ1sDvQsJALnaXpxILe7Qw/vytaxmwrIJx32ii/X+xXxEXCFf92MrnTncSiDUonxbgPBGiOV0pYthcuKkQZQgrPbIqyJ/bzuHPF/M8vxiVoy+GM86KqY58WyzIElvYefeoBaY/d7N+zjQGzwf+z1UOZarKKS6ZA+/kvSt6OWEw0FKx8Wy6BAVAs0eFOc7R9wtOxp9xZ6kQcvbdeS0tijtpM9y68U9A+VkAhqSyMBxHyHdyDrsOLb03SIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WySQqKjwlKswxdNm4YGZAbqiADOLQstUIlzOlsupMOk=;
 b=mHGh0RwgJ9mWGkYnkdFhVrM8t0t/Uu9mQI83LEJIiKSDKPzGFVkDSbTFoTY+zopHVJK0q7HA0DhkcIxF+Cmn+iAMfc/CueUXjKRkk4N/dbqRHGxLoRpTWpwpaYaAvbyeU0HXt5eamP+IfIwinmva0698qh4d5EOnb3ERjUBp/kA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4464.namprd10.prod.outlook.com (2603:10b6:a03:2d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 14:51:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6768.036; Wed, 13 Sep 2023
 14:51:29 +0000
Date:   Wed, 13 Sep 2023 10:51:25 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] init/main: Clear boot task idle flag
Message-ID: <20230913145125.xssion4ygykunzrc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20230913005647.1534747-1-Liam.Howlett@oracle.com>
 <20230913135246.GH692@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913135246.GH692@noisy.programming.kicks-ass.net>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0504.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f555c77-27a9-4183-1650-08dbb468e989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvyDDprgoeDOMiO6x69WmrzPKSajy3Xg/Kxqy5AHRsWkiiJwBAX63MlyVBNQTfypz8CXJPQj0S8JYdbg3WygVzRCBqKJ0PkqhcNBRq03syapF+hr0AF/1KxdLmjgJUVKfUFDC7IaPrgEO7agvLWyXKAn5/h+5DV7Hij88gF0C033ImSMXh2UUYSgXezS3D/vbkIbteNs9rX8BE3sikiLTSlbhsE2nKNKPbBbHbgaoF2OByZ11r/ip43rmNbU2vMIhAihYMpi7GZioeZNQZhL31/V8PWZEcu1CDTF/5XvQksCFsQAeNK54FHyU3v0eV3Z9FnvG8B1THiibKmT1jEUqenm1otI2kVK3KIHuDjXIcZn9tabUtaZhANH6Plg5lpigOtSV454yDPWc4CCYhNhC05Ggu4nAenbdRHEGOLqzfwYqdt/rtkkWnRyOS7oSApQfFOD9aW/x6CIRmPj2QpkT1cI9D03NBsaTdiger814NhCaQP37m12+eUgS4QDzcPNKWQiPK3dcSeWGN0NGu/yxdUJt+x8sQd2f793pXhR+MyvX/vlK5JZBVwxM+2se+ST
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(346002)(376002)(136003)(39860400002)(186009)(1800799009)(451199024)(6666004)(6506007)(6486002)(6512007)(9686003)(478600001)(83380400001)(1076003)(26005)(2906002)(7416002)(33716001)(6916009)(66946007)(54906003)(66556008)(66476007)(316002)(5660300002)(8676002)(8936002)(41300700001)(4326008)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jhqR2Wb361xH5s/2HvFVcqP5M8m2bW6yBipfZdvb407JAf1w6BfrdGQLiHGp?=
 =?us-ascii?Q?kDdLlaMk00a9Yt7NOUTRqbL7BepH23M92SNn9AQkZLJYSxuyo83WjiO9Beip?=
 =?us-ascii?Q?bkTwAqReUtDKaIE/hNMttWXDsmyOOqNuoGjcXX7spKNffJAhAml0MHyVfuMq?=
 =?us-ascii?Q?y9x8E5gMXCtviD9dBFlzWO8+4e2HIA25xdEJ6E0+O6ueAcsh41zrQKz33Y8D?=
 =?us-ascii?Q?cOF8LWfJQYzIDMsFRL00caMujo77lK8LcCFi8C6+A8Wq3e8AZEoCfPjfe87e?=
 =?us-ascii?Q?WLerIQK/PkFz/5drh1qzHla0r67YpTkCKZb9MlzG/JMUB6NTHgHBzh2561bJ?=
 =?us-ascii?Q?cW0Es2ZSi1N1mW4Lcyi0hJfHah8wWEXv2BAEf16xK9KAY7waGeYGBBAjKS51?=
 =?us-ascii?Q?VxhhhksTwYD28+UkLH9dYGJJSxsJo87i42T6nG0a6U4KNX8OmivnoW4b1u9X?=
 =?us-ascii?Q?fjnb6MOLHGoABkh2ZGFq3xiQ42l5QWlLXO4zyFD86DRaBEUW6DD0ZChItpQ0?=
 =?us-ascii?Q?9FpJu8KaBIQP8NwKd5laM63MZ1cg21H1UEcZPp7AdEPffRLsvC/BhDL+VLI2?=
 =?us-ascii?Q?7D/08xmbqJ4zSYu0skTXBbovwB3W2WY0hKspCucZGS14/ngvEoh3AxG6UNVO?=
 =?us-ascii?Q?REo/X65d/c514CERCu7pc3OVGfAETdFLwi+wncaw4PI8eyWY4Y/E7LCc+Iph?=
 =?us-ascii?Q?JQvcsfiVSJMKqO+yfJ31n3bgAXHPl2Fbnc8Nc6luozBJLQbkEnwaWAEC/nfu?=
 =?us-ascii?Q?SwYChLjZlFeyT1xCHQF/kW//p8eREXnPMbddFfyipIqPqZhm9zdqC6rwEI6z?=
 =?us-ascii?Q?vmQmW4QRNTBalTVsHOXmy1Hd/RxZ4z1wbd4zNuuLE/JYZ0ExGD2gqoHVtpxM?=
 =?us-ascii?Q?JsIE27XMtA5Q6rKu55LpEY33JkjtMoX7J825JL0NzKIAYLDT7XFs2mwXJiJg?=
 =?us-ascii?Q?THCpGVBoDOAbOROV4/Lj07H8+dmnwzebnMKLuEaWOkuqgNPWzsnA/afnPnVA?=
 =?us-ascii?Q?6LEX/HmKjdhAAYjlk1OjtW2Vwr645XZ7jmu/iuIeygu5PgZHYaDWL9bwIwwc?=
 =?us-ascii?Q?7quX6vIlS874CZTJwkqjAkzcGcHfS6P80ENnW14nAAUqRZbTfzUCjCKE0KZQ?=
 =?us-ascii?Q?ebeyGyJx4y1mSQxNXuY2jSzxNyLamBH5+uIl0PdqK90Cfl4npZRPWEGa5TIf?=
 =?us-ascii?Q?YfxH3KJexw13F9xiv7IqL/7NkSTAi6raaS5yMVgoBKxceyMlmR4otoh8btFa?=
 =?us-ascii?Q?JW9z7zDWLNdLhmaxM1+k4/5Nqbx8e6oj3KJOTrb1WBMerxHRElck+23eMPML?=
 =?us-ascii?Q?dNFoATKRMdmTml0JpwCXHRx31sIxRjK1vD1QMHjebDVMDzwZqajX1kQiBipk?=
 =?us-ascii?Q?LTmSqgzf0T4b5W0P5FObTJ6angwwzPqHSmOnB1K0EoMWEq6m78drb8hm1YXR?=
 =?us-ascii?Q?DCwCQZq2KW5IswUUp7EaWUqUoTWXP7F/qnlIw99E7dWJoG+7MLW8Oo3R2u/6?=
 =?us-ascii?Q?66rqyzNrVfwordi27Wq1yt0pvokYDpnjrR15GF9RFkGeJAQS2Rnv+a0t/uH7?=
 =?us-ascii?Q?hAHkpyE5pd5QRaSQiNSmFDzLj28H1p6qIc7jH65KOyEJVgIsHmAwzfBJqDh3?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?tiXXUa6W0b/tUbNT4fd+/rwEeZajfgdb4Yj1Z29DrJrYQwgnXhLnTNNlmN3Z?=
 =?us-ascii?Q?DaOSv5Jdrb4JoZVT1eG+9RQwqSPTr5OPMnoWl0jUtqG0vmIQSDVZucOcAKJ+?=
 =?us-ascii?Q?LRtmEeqtdlphPFm6MSLfi6GUATGnt/RMLxJFkiomXpqvMbOBMe4afgXzp3Jy?=
 =?us-ascii?Q?AhoDvWz2CBvzLka2b4H52IJVN0ypm/tigpcJRx3UoG4H2KzLePUkkVNhZFWt?=
 =?us-ascii?Q?d/LCugYWHHaR1bvMRNNyfNhjOadir20GcbBGgNr30gl/L8z5GvhwjbZ6n7od?=
 =?us-ascii?Q?p8dI+UUx36aYUQGPCNUXgJMiXJQub4+mrhCS2t/+NXSULWIPJVtx9VoULbZp?=
 =?us-ascii?Q?KknAimR9CIIwBB80WbL9a5v1Omh9VCExACUoQlb3yJIIjbu/I2Mmky8kMg9m?=
 =?us-ascii?Q?Q12OwU606bygjmQwTD7R4kx14Pl9Sv3ZqeVYRH2CdnfYePc2Z/tEkYaIY2pe?=
 =?us-ascii?Q?9ZBQ2Q+OtEMhcSXlyNgOnMrPEbbp3g6VqH0chX8R3VaWEdcX9B0+4CAiC+7d?=
 =?us-ascii?Q?wRp3aI13OJ+1R3YnTsr8bqYZYwtmGLXOwx5pVJtQhGGwgtcNtjhRU1ZRLRXy?=
 =?us-ascii?Q?yxJaZb51GCen8OmMEWhp5UJFTQASX7D7q95Y4G1mMvz1zkAXdo+t0oRzBCzm?=
 =?us-ascii?Q?dMPOjloIc4qaW3mQYHQ6jApWUUPWqqP0Jshk1JjiYrGsNuGdhPTs+pPNpqIU?=
 =?us-ascii?Q?uHtsUvC2/TLT8a3rEV38ogqjJA4EZfpjDroq9XqEi236ePS3X/tAEBusyh/I?=
 =?us-ascii?Q?HRurlSD8Kg5uUL1x47QVZ+6gLXrB3DTHfDDdXyos6DthlqwlGWuu44sAj0NV?=
 =?us-ascii?Q?XTrFmoYpb/sw/a/RnjEvU853SvnzquHt+tWEg5LG69x/Hv2DnyS4C7X1THaN?=
 =?us-ascii?Q?pVf0mWODvJVaJMplVJuN68sA21kelRcs3xqG5eWACzo9oyWtmWlZQQrtigx5?=
 =?us-ascii?Q?EeJRR1nMf5jENv9n4HSuqBXwEH109hJza7nuiWzIBgJrf9gts6QZxW1RL2wX?=
 =?us-ascii?Q?liXEwzgBQ8V1Ver3QT6INXQoiXSV5Zw0x2NHYnONwbrJEIhJP3TznHoi+UKA?=
 =?us-ascii?Q?NetQNDey7O8uGGsKxpapWBUiZ/sE25pp59ygAiQ3tRkaLjl+uoeZkzoCNZ8W?=
 =?us-ascii?Q?JiJ5S1NK2ZvsSUO4TLr1hXN6RRK3IDAkNg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f555c77-27a9-4183-1650-08dbb468e989
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 14:51:29.1931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6COpEo8ELLrS+9girUr6wO1DDMpcqTIGQwn+u9rHaxOqx7pH/kpTpI5OkHUDD931PX6CEw24cRuSmTH8dZebeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4464
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_08,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309130122
X-Proofpoint-GUID: GyMLAMxRjRR0hLEcz-aXvUSrVNZMeRa2
X-Proofpoint-ORIG-GUID: GyMLAMxRjRR0hLEcz-aXvUSrVNZMeRa2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <peterz@infradead.org> [230913 09:53]:
> On Tue, Sep 12, 2023 at 08:56:47PM -0400, Liam R. Howlett wrote:
> 
> > diff --git a/init/main.c b/init/main.c
> > index ad920fac325c..f74772acf612 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -696,7 +696,7 @@ noinline void __ref __noreturn rest_init(void)
> >  	 */
> >  	rcu_read_lock();
> >  	tsk = find_task_by_pid_ns(pid, &init_pid_ns);
> > -	tsk->flags |= PF_NO_SETAFFINITY;
> > +	tsk->flags |= PF_NO_SETAFFINITY | PF_IDLE;
> >  	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
> >  	rcu_read_unlock();
> >  
> 
> Hmm, isn't that pid-1 you're setting PF_IDLE on?

Yes, thanks.  I think that is what Geert is hitting with my patch.

debug __might_resched() in kernel/sched/core.c is failing to return in
that first (complex) if statement.  His report says pid 1 so this is
likely the issue.

> 
> The task becoming idle is 'current' at this point, see the
> cpu_startup_entry() call below.
> 
> Would not something like so be the right thing?
> 
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2299a5cfbfb9..802551e0009b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9269,7 +9269,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
>  	 * PF_KTHREAD should already be set at this point; regardless, make it
>  	 * look like a proper per-CPU kthread.
>  	 */
> -	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
> +	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;

I am concerned this will alter more than just the current task, which
would mean more modifications later.  There is a comment about it being
called 'more than once' and 'per cpu' so I am hesitant to change the
function itself.

Although I am unsure of the call path.. fork_idle() -> init_idle() I
guess?

>  	kthread_set_per_cpu(idle, cpu);
>  
>  #ifdef CONFIG_SMP
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index 342f58a329f5..5007b25c5bc6 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -373,6 +373,7 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
>  
>  void cpu_startup_entry(enum cpuhp_state state)
>  {
> +	current->flags |= PF_IDLE;
>  	arch_cpu_idle_prepare();
>  	cpuhp_online_idle(state);
>  	while (1)
