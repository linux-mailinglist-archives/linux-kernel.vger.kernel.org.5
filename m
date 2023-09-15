Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98D07A250D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235943AbjIORqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbjIORps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:45:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D626DC6;
        Fri, 15 Sep 2023 10:45:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FHNtmu006078;
        Fri, 15 Sep 2023 17:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=rpYOy7EF8qJBo7gF1TEbg1iCIabk7Cyk6ccYH1VL0ng=;
 b=MBn21bZ8Ybht2FcTgWS5NvyR7cg7tS9cMYtNbjh4+nRoFRpG9Ursuz3UMgQX6eCKbi3U
 gohL4ma5x243hHEQxulrtQEcNqvwJYv/MUIdsQKKeGI9wpT+WiEkDf/6NoDk2SpVtUz1
 0fAQigt06XJyaNchFlz6F0oVPfi3LM4XUCu1TBSF/9JOuuyGl+ni5QD75ieXe4S6cyUY
 I2buyYFfnZGYHTHOQtfxE0a+puzd5mczapImlFg3j9GbHPZuch3ba3SNumso2rlHArGZ
 uyhe8B2qpOOWWAnHlX9z3ME0Te9+xOO6pLxmw40s3A6diALHN1aQL+S9m9HYrky/AKc0 TQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7kgadx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 17:45:01 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FGe30R003091;
        Fri, 15 Sep 2023 17:45:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5acwrr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 17:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO4kvckbkbAV2BIabFS2NsnxgrHc7q170LOWNvO8Vv7PpGdk658nawa61PbC7UJFAn1vkYR8kft/WRSYps/M9oiEFv3lnYKWX3KCEqEbSrYWCqz+RtWS0etjOJlqkuem7hzPScdMDDYpgrXT5hL8/PTuODPdmVWks9FPWT7Lu9SQJ1eJtrWsy+K3/FeeKHpTlw36Ab8yMVY6IgMXR/QrfaECM2beuMc/YxYdcHJ6lvE2h40k71O2L7fJrSsYA600HnTCdnQERQib7aWKB8szmPIdZcu2xxpAdF/xRDrkwa6ix57XkjTKa2ZdmbrvI6FS/qk8Q1SGeBtmKtt01fFOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpYOy7EF8qJBo7gF1TEbg1iCIabk7Cyk6ccYH1VL0ng=;
 b=YYszLzMsWRUZssgGb5SEpzpIlbB1EmOysRfzg4I6zTY6DWfbg4TO4R1SM9Nz3c6mFIDTN6Jf23zCrYG8aD3XHp4RKMaldBoQupLsjsr7LuNbgcxCmenMXC0gvLR1rIEC0kg7iXPX4X0EyM76cQzSVUYOwJM9GbGa41dzW+ojB3jePNLaGwIq4fWG3ijdIrz6ojHQEG8v10VI4V9b0qShDqr9HqPGLqmWADxZv7qw8vLmYyqkMINwGC49PrvjfiTfskockrkTPH+CzleplrU4FsK+BEnnEoOk+hmnCEFk4DofFsCT6csFI4eyO7cVB2v4911lc28m5nw+yH2Nj7WR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpYOy7EF8qJBo7gF1TEbg1iCIabk7Cyk6ccYH1VL0ng=;
 b=TVyleGzd8MsRlcmSO+GpykeHVtuPKKuqgSFh+hcAxlzJmlXWCaR6JnadpLrjhzbRY3TbzpFa8Tn/d8cB7C2LbybpjyzLshIi7JNB/k+wGPdkKjk438pJUUi3BqlqvREFEJ2LQtlraz4hymuj93u3lerLHGaCKcYR24ofCIbtBsI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.38; Fri, 15 Sep
 2023 17:44:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 17:44:57 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2] kernel/sched: Modify initial boot task idle setup
Date:   Fri, 15 Sep 2023 13:44:44 -0400
Message-Id: <20230915174444.2835306-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT2PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::31) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA1PR10MB6243:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd6aa0c-66d9-4d0f-f035-08dbb6137a39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YoDY3p35NO4JJvZ1zjaFyt0rsSSSFhSTid93NAwtmbpfWpiPE48VUJybM18vrUuPJjZf8Ks2MYUDGVRVYxSF3O6dVn6dTtrNkF2plJjsOLHlgf1/YE2qHodUL2A5py1CQh7HoKgBQC5kkncACGMeId06M+nqk2e1ef7NFnID/x1K4oyBO+lf7j/TvoxIp5iIbfIPIm2w/oyg+ZUhFf5jEKvsFY0LTH2+ENTaPEBQg9wVWl7a8sK2f9hU4ozFp+TNUwLBkOeswqGpGNXHNIbyyeTwaZ60TS9H6KGDQlXvaKCdyU7PJ3f15UlZZv+OSBblAA6DteYq13vuVyNpk4C7DQeHCxUmTgWdl5qyAs3WaWfnFs2uNj8EaFrbWZwKS81wg56Qa0CL+kjlWzWS9xR0PKa56PCbkyvgqkOJ16zDvzHSC+9nPtZkWoLsN4Xn7/gO0iQfZV6Z4pHQ6WKTw5qGnmekdPp+XHla4cujToJ0oSoU7An6SH1BJkU3nD3y4Gbhr6VLX/fQOXexe1fgWlx0c+uvuj3g3eWtFx7UfmQ72S+Az2ANou+oLTuJ4ONKMm4NBySw1ktmVk7tbk7gl4fg6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(186009)(1800799009)(451199024)(6512007)(54906003)(6666004)(6506007)(66476007)(1076003)(2616005)(41300700001)(66946007)(6916009)(8676002)(316002)(66556008)(966005)(8936002)(4326008)(5660300002)(478600001)(38100700002)(26005)(83380400001)(6486002)(86362001)(36756003)(7416002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4sueTJ5WgYSetS1pxMjU9LJ7kJ88cHeiitvwXzlCmAKBKkHySXLM/1YTpIVD?=
 =?us-ascii?Q?dIwPDJPlwWrcsw7cfTpmz6vNyRGYa5TPo3tnmKhxmRc2yRAcgzj6z6wAW/1S?=
 =?us-ascii?Q?1900pKJj4m8xuqQSU3qXIPO9ax8hwvaEBL6pc8nqhlFhpM9bzGGEoJReTN4X?=
 =?us-ascii?Q?LH/89CTgqwl4JN9R8ZI2I/4DsQPiFd+wu2ZiZluGJCK/mIZvJoKJdSvu5CXE?=
 =?us-ascii?Q?ohzQY4Dxh4dSfq/AyhyC0Y47O/opXq+K/Kb4PPFw6B517WliO1JwArx61OpP?=
 =?us-ascii?Q?nlPfGdazdtVE+g+xkBVjdOxJy+3I0kgsPmUvr5nU2ugbM1ThovKYgNEjR+ay?=
 =?us-ascii?Q?oBFQCtmVwjG3Ey8L/B6wY+dwIV1d0793a6TiUWUsui38I6198VYk1u7CWVMU?=
 =?us-ascii?Q?OKsME+2bPHBpEZZ+8mX9ZD5rOv3tjHoK/bFYQjfK3KYWHCltyUcFjF2YygY5?=
 =?us-ascii?Q?9zulysKKNltKYhuAl/aGL0bOalzV97NYD4S1iUbiao5zkPXCjInCWiBf8edn?=
 =?us-ascii?Q?UW+nOipABNstGm7pLLWEHU9FrSfraG0oIuq4VobUzsKPQ5seP41TzVXStYV2?=
 =?us-ascii?Q?8l00YuQ/SAvAzxeGsXJPngn2CyhUKvUrptH5PnDKorv+n3EVehdcbaZa6Xna?=
 =?us-ascii?Q?maAjNti//SqpOgoOFW4FnEfKUk3fxS69hIj0UpWxLvGnNTd2/pKP7smKiJpL?=
 =?us-ascii?Q?loXrqlh9i9BQ8eCGu1rstLW6vcK3ItK+WwatiqBR4l5SB2RwiyQkTH32CxJc?=
 =?us-ascii?Q?syxCtm15N23r2F46tePSs33ZV/xh+QYEDrp6lk0e8PAjNLcM9NzH7+WnoLlv?=
 =?us-ascii?Q?qJFnrzjZrClHhzB8QkJCQ+gasksdqDs0DkDUohhyfhEyLcw1QNHCmueCxcrM?=
 =?us-ascii?Q?9IL8pvjoCiHeTjS6Q99hPFZHFAFDH9CBWgzbrJnS7F4FGpmZ9Cd1ZSogi4gG?=
 =?us-ascii?Q?mtfDCkCFBQPXIVVmxASIp/oISH33UWsr4znmyb2z4Dh+oYyGNKWgE3DHZUrV?=
 =?us-ascii?Q?3F76PvJbRYtJqOaBMzC5B8m5sCg0pLalylWwwnElzgt7H7wjO6KE9HqoqECV?=
 =?us-ascii?Q?1IBGhMOU3V0UXkPcxD7sruUOycmto1SPkRpdLlLK8JPZzPtFr5a+kiSqI86J?=
 =?us-ascii?Q?879PrG74D+iIdrjOF4Aq9rBmu7eJ+afxzpDc43wXitFRDM56D7Nkba846iMp?=
 =?us-ascii?Q?U6Iyyy3IfBefEvowoLjszdH0JZJIw747yoHPXakNIiVjJuaTXCOmJP/s/Wu2?=
 =?us-ascii?Q?c9c8GYPLLPP7BKhvVUYRu+gwFX4DiE45Hn3s4djDIEwSBdL9ZZbx9Y1AUZGf?=
 =?us-ascii?Q?gk9u6IDi5pBrZ6G+lf7+Nn/GnkuQBGh06aoEx4Wmb0kmkH/quoPZV7KhxO2i?=
 =?us-ascii?Q?PNJ+hCMLVNSTJb1b/E/4uzghGt/S0gp0x7+mqHSqxk17wizwU/SU+WeVlDHZ?=
 =?us-ascii?Q?InJ4XwUcWhSg/YZDH/LTp952S0+SL8sS1jkshZ/MZsQR6Mm8o6Vv2JWliR6k?=
 =?us-ascii?Q?3ZWkyN4ADXASd4OFnBLD3LCfLDY96bcToj3cYdGdRVEF54cWL9CVdee1jbG4?=
 =?us-ascii?Q?RofRIBSUQOXZywEhDPyxfW8i66yibJBoPmA6d/BP+5i5IoQv6/dN+Vl/XCAL?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?FQ1bF9CPIxP8igUDHYMfSUYhURni3rAP1FQneG1hvPXprfko0E4tqVlep8Vg?=
 =?us-ascii?Q?RUYZzVDTtPiOEC5botwrJbznIPdauy+Gz3Z3ou4G/0ceEkW1qBhBpO2GBUUL?=
 =?us-ascii?Q?ztYGtf6UUA5RwQcJKwsuKKaCLCot0Cdpa64taihsvDvTdtv/PVMjTaS5ao7f?=
 =?us-ascii?Q?VMRHRpzx5RmqoYALGPA46QGYsW87YQhwHs7oRWoKtz7G45gLpLl1wqvYDm9y?=
 =?us-ascii?Q?uSeAA/0jXPUNvVAZ/+DHg6wfR3EN4dlk5HqBiTwbvtUOcHoXdiMMc8K6z6sH?=
 =?us-ascii?Q?oCNQ7eoxji6xtoiXzvC3DAr6PjSYBChCKFa/VI0f3L1OZmiaS63dPMp5W/O6?=
 =?us-ascii?Q?0tzJGk6/u1M/OYf/TVlJdrRz5ZuJN4u/I0EHG+UIAhzcVhv0MXBuFRpKjgro?=
 =?us-ascii?Q?VWUBZ3w1DLFQS9V+VkDz55U80UCwDmnkIp3ZIcyPltMb1LGccUVsjpgD05v4?=
 =?us-ascii?Q?PTKWT0M50RPmnZKsAfKDvNGXzxuo0NQlIaE2xwV1M7l5hKF1C6k0+OaWPVlm?=
 =?us-ascii?Q?VUUsnUF1AY/mdP7u0wcjcXN/SodSoK2edEtVjVZCiysQllr4+aHifWFzBzIf?=
 =?us-ascii?Q?LbAjgNVDwOd5x3kMQ6CifdFI6DvovFp+8CHuatppWIJl4k4J3loxK9W688+Q?=
 =?us-ascii?Q?liCAy5ad8f/Oosj8FG2Tg1ThYmobPGqz0f7hJ5riCGpE48MOYvMgBro2I8nD?=
 =?us-ascii?Q?IXGhwBCyxS4ZmRl+ggQZ8IcmA8SHJvBH7JtWmLnV5HMhMHtQNJ1lGIqrM3Na?=
 =?us-ascii?Q?cYIg9HNDKToILqXsk5VmGDbLDhoV/i7MUIaqdZtmtQ8N+GuwJjwTyeuCt1R7?=
 =?us-ascii?Q?/XVCJ+qpwxYrcH4z0Lj8btNttvNy6cHxStO4StUl5cpvdcRo1Z28vRluQ3zG?=
 =?us-ascii?Q?a7U/1kzWn8ZsbW1pTaVWFNb77U5snlVxrCkqudKB3J59F7nVovMOwNv6CYBp?=
 =?us-ascii?Q?ISl7vD+TQEkPKAM/P7i+uWxPsJ1ADUbylVRBeVHl2iwo5OnDpS+xKn+K4aJE?=
 =?us-ascii?Q?iJXigq+WGqi51BCYsuXOce8HhGOWK8wz51Qemh9MfDyxHQLEBLDK4TVHlMmE?=
 =?us-ascii?Q?1MijsBrV4Cn7swQw4vQYhSQ5yOV+5Jv5ClU6ZvalWu1vFxV8a2CcY50ONAt6?=
 =?us-ascii?Q?FOIzLtZ0ooBsfJTN1qwJBJdUtJbpOGarcw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd6aa0c-66d9-4d0f-f035-08dbb6137a39
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 17:44:57.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FSqqBKIjrEnBjImaR3REJxyh/QadaxWvnGVF63AZEF5FJHQeJY38wvAehP9nsBXDuNOtP6hgLL6GLN4qVAtRYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_14,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309150159
X-Proofpoint-GUID: TCLnCxuw_HOsrkz8WkNiqECUKa0iEXpy
X-Proofpoint-ORIG-GUID: TCLnCxuw_HOsrkz8WkNiqECUKa0iEXpy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial booting is setting the task flag to idle (PF_IDLE) by the call
path sched_init() -> init_idle().  Having the task idle and calling
call_rcu() in kernel/rcu/tiny.c means that TIF_NEED_RESCHED will be
set.  Subsequent calls to any cond_resched() will enable IRQs,
potentially earlier than the IRQ setup has completed.  Recent changes
have caused just this scenario and IRQs have been enabled early.

This causes a warning later in start_kernel() as interrupts are enabled
before they are fully set up.

Fix this issue by setting the PF_IDLE flag later in the boot sequence.

Although the boot task was marked as idle since (at least) d80e4fda576d,
I am not sure that it is wrong to do so.  The forced context-switch on
idle task was introduced in the tiny_rcu update, so I'm going to claim
this fixes 5f6130fa52ee.

Link: https://lore.kernel.org/linux-mm/87v8cv22jh.fsf@mail.lhotse/
Link: https://lore.kernel.org/linux-mm/CAMuHMdWpvpWoDa=Ox-do92czYRvkok6_x6pYUH+ZouMcJbXy+Q@mail.gmail.com/
Fixes: 5f6130fa52ee ("tiny_rcu: Directly force QS when call_rcu_[bh|sched]() on idle_task")
Cc: stable@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andreas Schwab <schwab@linux-m68k.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---

v1: https://lore.kernel.org/linux-mm/20230913005647.1534747-1-Liam.Howlett@oracle.com/

 kernel/sched/core.c | 2 +-
 kernel/sched/idle.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c52c2eba7c73..e8f73ff12126 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9271,7 +9271,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	 * PF_KTHREAD should already be set at this point; regardless, make it
 	 * look like a proper per-CPU kthread.
 	 */
-	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
+	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 342f58a329f5..5007b25c5bc6 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -373,6 +373,7 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
+	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)
-- 
2.39.2

