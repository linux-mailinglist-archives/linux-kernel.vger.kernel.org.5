Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2C774878
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjHHTda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjHHTdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:33:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF90A29E7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 12:04:33 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DATat029229;
        Tue, 8 Aug 2023 19:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=l9l5S6t37I+7EH76DXNqy0hHvCPH7CpTTq9Wce1Kos8=;
 b=FmL6L79EzsX31cRIz2cMqKxDSGcAgIO4i8HNyhTdamm/CQK7Vz+DChKcmRsyW3BZjG3t
 C/BTy3dmAJBqHabz3DAjHNljZtOYJYRXGao9nfE1KH/zTsO+XGZR2/C2wZpkP+OzRFIn
 Rv7RG5vGjh93QWfAa76HyjOfJhbpTKHLc8+WKgGi/8qEOi4V9ApcskoaQu4bIh9Qqf22
 2PyPN0ua2eMj9s1o/BrJlysk6FDUZX/AvcTj4zNC73sV51tQhBC27o2HaE8Vy/sU8JnW
 /jwsM41g35j6fdkaxP+okd2Yqebyt9kCFf7M6CNK47jS2IYiBfvwT0pfQ6UfwVvb9L// XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9dbc617y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 19:03:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378IsbLL027330;
        Tue, 8 Aug 2023 19:03:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv67q7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 19:03:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bykmRnT/7fB7TpL/uNfyZ9BzWIaP0vpzFPSgMSG4cOaudsAgWUJPSYPECNJBtR8jmLZD2JLVXl/MQFVtGJNyWBsZOgVPJUOGK4nMqqfdycwMB8RQelkwAKVXtVOYOJqvZ0ceLh5pG8pWCE9Ig74NtLNfKhnKHzQg24/i+Ae4cCe84+DopUpN5Dnh0uucW1EBdp5xq883GOmlsRyYgd2Ox4USPASZhSaIHhwzYWPQeneeei0wKzSSEkf/vVccN/paZyK9CDOkIJ4/QurFelmCDWYLIQ7qiKJMMrhzTh4kESEDnBOe8ssra5b/ac2xRh4KKT4Iae5mwbke3OINArXPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9l5S6t37I+7EH76DXNqy0hHvCPH7CpTTq9Wce1Kos8=;
 b=LiZ7IXw77KAOQ0hSq0mZymCtPpCCh/jCv7MNhM4NDOzcBsHY3WmR4/TaermDD1DpTZQsB8UaMKRqh4CuLUBlSsoJwHiUVsSOixV/Q0U66uigo8qBJ+8jujAVZnow4+12mA82KS9hIu4unjqjx+3j7Ru/9VT5ojd4CmlZ0p39IXxrpjNr+AvtIM9yfknKVBdSkgsqpDmkyOp4OAq1O3mvKjCfB9LBwyy7JzuvxFZzUOciNlTx5u/4YHyPaKAuj9/5LvoSRpJFB/8nAPnuRxw+chGiSTbiwpS1rEmRjGEKjcueJVWyp8iHb7wbOxPDM2swh1j/AxoZb0udbN8nyq7Vrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9l5S6t37I+7EH76DXNqy0hHvCPH7CpTTq9Wce1Kos8=;
 b=mXS90sORTExyndfCkny61/+4/tqbIZjDwwIxmzrX57rKJmKPO+ULat6xstXJ6MOWO2FT1bz7g9c6hnQFBGpbsIUQxllKWEE9qwHXjBzef38Po293OmH9RYzSu/6mr77XgdqZZdXpeishXAdjcX5FjphsatTt2+W9mmv23Wt+lUY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by LV3PR10MB7938.namprd10.prod.outlook.com (2603:10b6:408:217::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 19:03:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::26d3:6f41:6415:8c35%3]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 19:03:36 +0000
Date:   Tue, 8 Aug 2023 15:03:32 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [RFC v1 5/5] maple_tree: replace preallocation with slub percpu
 array prefill
Message-ID: <20230808190332.3kf7bprtxdjvm4d3@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230808095342.12637-7-vbabka@suse.cz>
 <20230808095342.12637-12-vbabka@suse.cz>
Content-Type: multipart/mixed; boundary="yvvp2yzdjcas7lni"
Content-Disposition: inline
In-Reply-To: <20230808095342.12637-12-vbabka@suse.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YTBP288CA0022.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::35) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|LV3PR10MB7938:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f135cb-a0ae-481b-8baa-08db98422b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMyf851w5haos7NgF4UK27dtcEzIkun8IudeOXoWKxb2OZhhAf/OS5NHwiXJ6g/Yx0guGQUlIdL/TAGfOP+IQ1ZJkNrOYXRF779R1Goh/joBXsJt5aDWhivxFYmqryALEuUeoWKEmfbaYgZKIGTZDmVeAj5rHcKd6JnNFdiLMjplGYo+ZfX6Ak9lM93ljWBjg6wQV6a4UfUdwNJ0iDu8rcp3YVpwL04QyzIEarhOJFxfdGtKo/dX3Eg9dliLAnqOOsABjJozPDUf3/7iNUqvZ0ibv0cZk+XmjvfK1ie8y4LPELnbBhBsRxhWORJJvttvesVsS0TVPBrNb47pwRZv/rA2R0PT/22G51Jke84ibkrc/+S6AhfDojgjdILBj1bT7EqMgFiTckaZtD5evUVy9dICLKkgvXHeYv3FdeS3IiBw1PYquA9kAUJyj/jJuEsxIM1WpkZUIh3mMpfBxRVVEUlUlu0gcd4q+r2yYvE4OS72iTwbLrDnEYPBbEvyeUGVe+/rs21uRYmHZcAJ7vMPw/P9bwbMUCwcW7y8da7aTSFBIvGC0C3teJ6fn7KDYV4Op+xWzEfLrzDEPoqprjhtHjcL6KwnBEMM3P1cJAUFZsFYUNKfhDbtLIq2NYZmRsqP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199021)(186006)(1800799003)(44144004)(9686003)(6666004)(6486002)(6512007)(86362001)(478600001)(26005)(6506007)(1076003)(33716001)(41300700001)(54906003)(235185007)(316002)(7416002)(8936002)(8676002)(2906002)(4326008)(6916009)(66556008)(66946007)(38100700002)(5660300002)(66476007)(83380400001)(2700100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OL5HXCwq8ziRoMTWvZDnocQwSnzjkA1zCNcFbY/NNv5lrPa6Grt0M8ieZpDI?=
 =?us-ascii?Q?6K5mhs0dJJSJFgOBzOShGDR9sscx2MIwfPzc0yIoFRyNCfjZAIoPB0mW+9DB?=
 =?us-ascii?Q?ioNb3MM3LSc54FgqyZkuplZSFZVQ7GxQHaL6SHUwcoFCU0giKPXn9GmW/95C?=
 =?us-ascii?Q?qP54IL8i8aZj+htspsvWlniVshjztqHfbFW5pzW/02tunvzTSRhKSJl9gJiu?=
 =?us-ascii?Q?lu5vf17qxM2TjAfYuJi8YfybNZYEqYA80+kZaBdYgCuQGlQnS+QJNm8stA7u?=
 =?us-ascii?Q?44qN5EPwnn4aRthX+wFdGMT8pteJZ4wyPBCotQRQfNez2Epd5MewCg80DPa7?=
 =?us-ascii?Q?GGoH48XLsEhwR64QObt6jo+i/YWxB+QR9P3yAyQ3bwrlN/D4RzJGDKg8Qr/U?=
 =?us-ascii?Q?uYPBVfm3cTWIfg/BfOJ95vpInZFowKfQa2eWOY3NcfLQcHIfgmHV4cQw9gt+?=
 =?us-ascii?Q?TF1S+YnLcAIgFqqJ3owe5erdhmHO4SNcVxSAuefQjQp1fVzNONTlcFuJO7ck?=
 =?us-ascii?Q?RWAfSQ8jVS2uQnFfJ6yqevhuolZ6q0F4M5Fl5K8ofKR1YzjVlybGX5fYSMix?=
 =?us-ascii?Q?WTo4G5c5Q6MMMldhjzShsQ+yKrTowZAQIBIRchf/6I/jreVu4mFXxM2P2pvg?=
 =?us-ascii?Q?pCtb2yqVWFe+JgC6SrwQfHtLIYiWOsC2Pi/KMN6/iskBwjWmYaD3DLW4SURS?=
 =?us-ascii?Q?IHynbkVOJIZ4vIFLTd+ttcHZaIiS/hwZH4j95l3tnNEmnoQ3KHPC+5aiN4/R?=
 =?us-ascii?Q?/mZ+tfjIEyU3YdN6SeRxP1AA8oSIxCHdZxNWpgpSpMyH5FSj2fRCOXiM+N+J?=
 =?us-ascii?Q?bGndulB9uqZY2KVqo6ooag8X8fPr8ic0RluI9WVQBQQdkc7bas+FosV6SPMi?=
 =?us-ascii?Q?cc8D+GjvW40sktxs4yiCIRDQn7LME14ZRdiRgNwZ+OV6bmU0IHFTVknMzeib?=
 =?us-ascii?Q?0wCXcSMhNBKRYJzsfFLqimreNH22XZa04ivJlICH9HV3I4If+4hff8Qgch8u?=
 =?us-ascii?Q?/kc9MhyDuA7EN0JMNN0D8WyZJiJYXkr7LsDqFPGUL9LDAdNzLpyP/JDfvfbP?=
 =?us-ascii?Q?IQQWboAh5KCYxf5EDA+u0ThyyTE+Jr7bKQiD3PsLeZBjFRx4pNW/iOqa5uhb?=
 =?us-ascii?Q?DkG/TxyJBGah6pqhK1JDodU2m7ymJfWS6RLw1a7cdBvWrsrcTR8rhrLMA0m/?=
 =?us-ascii?Q?QZJ91jB/+cJVDfG/9FlR9MrryLe8xhtCtucT5PkIiaeLppyOfvO2UFQGjtDR?=
 =?us-ascii?Q?NnWnrDsg1ucLkk2CGlBohfnO8lwWOXct69eJ5HJ3whMeOjJjI8Wuvi9/xW9o?=
 =?us-ascii?Q?Dm83FK5Lwjs7ziUjaBPHYcdDsraijFp0oA/h4bLHjWYXmMyq0GfRs4KBNlAk?=
 =?us-ascii?Q?LIBK0gVW1xaQerO50+19voxhJBiMAaGzFPULgYCUvx0rBMOoFVYwl0TUEMzT?=
 =?us-ascii?Q?VWyrhEahYbMxFSNgSWbgaSrwvA/tCWRP1XwiujD+diBu2JehGpffJL72+J4e?=
 =?us-ascii?Q?cRPnknwfOEf2Nr35QaMkwBew7MpDmFJcDe7gtoD0bxzvVIll119G5bJibHdV?=
 =?us-ascii?Q?ohwmdc6zI6k5GVE3gt2WQsCvFynBP0NkUn69g+79mPRd26JCNxK1zU6aA31b?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ni3P/khyhXoTQVIkxs18+BmMUluQb6KCSJ6wDO/EIRqKXINPMckqDh/uOIEr?=
 =?us-ascii?Q?0TIuOfjMUtxhgHQ2UR1GM7K8rgSVLZMjtgdtMnklNeUlqHoDJB44PrtcAxED?=
 =?us-ascii?Q?DJ3cSSItM7xtZzbDylsLddhNPdMUli0uO4aBec6HhT6QanT36wBb0xsMfGdn?=
 =?us-ascii?Q?X4Pg9eCzMCb9gj7dAySdfkBvvnBkKjQv0Sv9hNtyEVyM/KAt511moHHTLZwi?=
 =?us-ascii?Q?LpU7jn755R+QjTzUavhD+DGW5ekzeGgOh7h/sndnf2v/0mikLu8xr34Gwd2Z?=
 =?us-ascii?Q?bPxpdg5j40wQdyHh10rncd7trxkX4TptLvuN15KKuwJdw7Lip7RWptDHnir6?=
 =?us-ascii?Q?DNV5dTK06BZOdZabk31oZeQd4a4819uI4uISAN8O2i88k4rQ5o9bkLE3NHw4?=
 =?us-ascii?Q?7sdjEHEhtCW6Twe7RVmBl6qiyWbB17pEUSmrBVZR7cDfpH5koblsYmuapv2i?=
 =?us-ascii?Q?qvq+UnXhlD65YSO6bZM09koJoGWMzeTvfaxJr2u4xJFnaVezql7b6cTH5Puu?=
 =?us-ascii?Q?mgyHeJKm4vDpje83MXMB1Vd5rD7yTHKrAYfLuZqgw6M088f14P4wysGdvpO3?=
 =?us-ascii?Q?CTRUHACTbQIPWutailoTUVvWOJvYB1fXKvw3H+OlQD+31cLO8RXrg9Gio+sR?=
 =?us-ascii?Q?RdGL0aIQ+1pFfxyBwH/8zopL83719JT6lIij5Uz3KVXspmyXj6aOVqXlkwbp?=
 =?us-ascii?Q?kGDOkKgUukCauD5Nz6VOjDPPKwYqRGMWPsLQdMwVYqpy1a3cN979DZqgMk8L?=
 =?us-ascii?Q?mA6b1NZ78xl2qCmtb12OmHy8XSWrDo+BLVU5LiWsASaMB/Dg2UwBwLrEYMIB?=
 =?us-ascii?Q?+wehWHWRNnY51ox5ZLRKO62iJolWuBwDwJ8zmx9+xKGPkLZrOpkMsdcQYRwE?=
 =?us-ascii?Q?me1jCK4dSTLfUdZnpuS+rHNE9y5phetRM+R8fkaUuxV797vO+lV9+S9gm6N1?=
 =?us-ascii?Q?ImadbQdS0E0MNcaMCocLxFEO4dp5yQNmaayOcDLFvN4PRbklkR2K2PkKzKVC?=
 =?us-ascii?Q?cLOyTycxRL6wAhy/UmjJgBtuR+QBhvrXFcWekv829YNlwWM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f135cb-a0ae-481b-8baa-08db98422b1b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 19:03:36.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BYi29DMTigMPkro3RhyBQJiQlgy1ZbQDqsQM3fciHEWmwXbq/FDWFyIGreP6SPWIsBYt3XBqjabXuUKij85/1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7938
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_17,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080169
X-Proofpoint-ORIG-GUID: eGKTlP2vXm45AQCv45AoUMXOT4aMxc68
X-Proofpoint-GUID: eGKTlP2vXm45AQCv45AoUMXOT4aMxc68
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--yvvp2yzdjcas7lni
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Vlastimil Babka <vbabka@suse.cz> [230808 05:53]:
> With the percpu array we can try not doing the preallocations in maple
> tree, and instead make sure the percpu array is prefilled, and using
> GFP_ATOMIC in places that relied on the preallocation (in case we miss
> or fail trylock on the array), i.e. mas_store_prealloc(). For now simply
> add __GFP_NOFAIL there as well.
> 
> First I tried to change mas_node_count_gfp() to not preallocate anything
> anywhere, but that lead to warns and panics, even though the other
> caller mas_node_count() uses GFP_NOWAIT | __GFP_NOWARN so it has no
> guarantees... So I changed just mas_preallocate(). I let it still to
> truly preallocate a single node, but maybe it's not necessary?

Here's a patch to add the percpu array interface to the testing code.

Note that the maple tree preallocation testing isn't updated.

> ---
>  lib/maple_tree.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 7a8e7c467d7c..5a209d88c318 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5534,7 +5534,12 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
>  
>  	mas_wr_store_setup(&wr_mas);
>  	trace_ma_write(__func__, mas, 0, entry);
> +
> +retry:
>  	mas_wr_store_entry(&wr_mas);
> +	if (unlikely(mas_nomem(mas, GFP_ATOMIC | __GFP_NOFAIL)))
> +		goto retry;
> +
>  	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
>  	mas_destroy(mas);
>  }
> @@ -5550,9 +5555,10 @@ EXPORT_SYMBOL_GPL(mas_store_prealloc);
>  int mas_preallocate(struct ma_state *mas, gfp_t gfp)
>  {
>  	int ret;
> +	int count = 1 + mas_mt_height(mas) * 3;
>  
> -	mas_node_count_gfp(mas, 1 + mas_mt_height(mas) * 3, gfp);
> -	mas->mas_flags |= MA_STATE_PREALLOC;
> +	mas_node_count_gfp(mas, 1, gfp);
> +	kmem_cache_prefill_percpu_array(maple_node_cache, count, gfp);
>  	if (likely(!mas_is_err(mas)))
>  		return 0;
>  
> -- 
> 2.41.0
> 

--yvvp2yzdjcas7lni
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-tools-Add-SLUB-percpu-array-functions-for-testing.patch"
Content-Transfer-Encoding: quoted-printable

From 3d4ac32997cab4fc8e957deb4a58a5a7afa485bc Mon Sep 17 00:00:00 2001
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Date: Tue, 8 Aug 2023 14:58:13 -0400
Subject: [PATCH] tools: Add SLUB percpu array functions for testing

Support new percpu array functions to the test code so they can be used
in the maple tree testing.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 tools/include/linux/slab.h              |  4 ++++
 tools/testing/radix-tree/linux.c        | 14 ++++++++++++++
 tools/testing/radix-tree/linux/kernel.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index 311759ea25e9..1043f9c5ef4e 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -7,6 +7,7 @@
=20
 #define SLAB_PANIC 2
 #define SLAB_RECLAIM_ACCOUNT    0x00020000UL            /* Objects are rec=
laimable */
+#define SLAB_NO_MERGE		0x01000000UL		/* Prevent merging with compatible km=
em caches */
=20
 #define kzalloc_node(size, flags, node) kmalloc(size, flags)
=20
@@ -45,4 +46,7 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep, size=
_t size, void **list);
 int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
 			  void **list);
=20
+int kmem_cache_setup_percpu_array(struct kmem_cache *s, unsigned int count=
);
+int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int cou=
nt,
+		gfp_t gfp);
 #endif		/* _TOOLS_SLAB_H */
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index d587a558997f..cbe7937fdd5e 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -187,6 +187,20 @@ int kmem_cache_alloc_bulk(struct kmem_cache *cachep, g=
fp_t gfp, size_t size,
 	return size;
 }
=20
+int kmem_cache_setup_percpu_array(struct kmem_cache *s, unsigned int count=
)
+{
+	return 0;
+}
+
+int kmem_cache_prefill_percpu_array(struct kmem_cache *s, unsigned int cou=
nt,
+		gfp_t gfp)
+{
+	if (count > s->non_kernel)
+		return s->non_kernel;
+
+	return count;
+}
+
 struct kmem_cache *
 kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 		unsigned int flags, void (*ctor)(void *))
diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index c5c9d05f29da..fc75018974de 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -15,6 +15,7 @@
=20
 #define printk printf
 #define pr_err printk
+#define pr_warn printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.39.2


--yvvp2yzdjcas7lni--
