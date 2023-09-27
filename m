Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3107B0EFC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 00:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjI0Wmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 18:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0Wmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 18:42:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A926AF;
        Wed, 27 Sep 2023 15:42:44 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RL7TVq005192;
        Wed, 27 Sep 2023 22:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=xnoNn2UzH9PDucjwrgvnY37cJc5FsHfCWrJ+WfTVHpc=;
 b=pvmjJx23zm21MOyE9uL4n8N9WVjawPs7A27ausxDZEuKRL3laAhzssQiwx1nc/g0zm16
 VFmftzgoj8hzCnAuL27rHlrv5Wpt29v8b1YIgpOnY1+faGAUrUrRo/BHjmfdgId9P89T
 KEgGl4nhb8ktAyWW5+6h37xgVRnobKqmi9NIUreaNvNdS/fQyAt46QSPghaA6sFuycHS
 Kl9LPV4odsM/KsYc0XRPJW6EYf/tTrQ+gPD9tuNDAK6PrzNWaUpqs31ed9SbPMmepLlI
 opdWmap/+meJNgQ+PPCxPrVb2WrVzxLteC1AU3rEt7YHXPrXtqG2DVx310bLOlObIExm zw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pm2aww2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 22:42:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RKXlnN039385;
        Wed, 27 Sep 2023 22:42:15 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfestd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 22:42:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AiTaLkSM0SGBAUDPAQsYzC1BbyGFpE6hggkjRPui7VlePaUoL14SpPQ3KDSG8n6F4v+HSz18HEauUtAUQU4tXCQngfzICr1JMlQj+lzYdUp+PK5h31T2A+TJRvs74u7LWHH/aYrudPQ7P+v5QZACUu4+qWdVlR2LfrCKc7FS8OPz8P/NTq+Rd6dCXFe4SnNULvUeMCuv2jMOvLDBh+RyfiVREW5+YnATuHIYBBmCjvFTiWXNEz5s9jLE7QgGLxozrLydqSTA3+WwtIn6naKugOYzliWEvEZuBf3052otaKBYQipkElceMT5MlYhanasdQp90LMANWU3jtBKZb8qnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnoNn2UzH9PDucjwrgvnY37cJc5FsHfCWrJ+WfTVHpc=;
 b=CxjVshrd9m2DXAURrx3hXmrjUCIASqCBQaCLriqyt7dbYlNt/on0q8nwJLoSYm018R7WFK0Air0PFKnyupIj7am2lwgyGYclySoa9e9niMUQDw4ajORTMKPO2Tow+uDZL2kbdBcOiFuiC6b6YYFjQSs+U2LRCOwFKPnIHBd8grL9ziJa3W5U04/k8uECQPIE0SgemIUXjUs0xx2/nOQFn+c9F1OSnHy5pXykaLFNLnEl8FM4p/3eCsHocToxRgdQfc0jfJbh+RybPQgYXX7ixpV+/D8Q9fjl3tnTtrm9a9QV/+r4SwjbxmWvSgfPPCPixjzvbf27Cu2KC1DMw+rbkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnoNn2UzH9PDucjwrgvnY37cJc5FsHfCWrJ+WfTVHpc=;
 b=O58RJkfJiYDYDYiTnzAiCHLJOa8Roa6UXgsR2JCDuoN/nOEb2aHhFMB0sXrry1kblKUv3sJtIW/ljqgIPyy6/WNarZTSaoG9Yq+d7pZD4ZbdfgnhhQsog+JJ77shFba9Oiql0sOc34bub0829UJ0skLrn8FqAhlC3UKnagytxWg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4299.namprd10.prod.outlook.com (2603:10b6:5:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 22:42:13 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 22:42:13 +0000
Date:   Wed, 27 Sep 2023 18:42:10 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] mmap: Fix vma_iterator in error path of vma_merge()
Message-ID: <20230927224210.5l52b3cj7dt6kvt2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org
References: <20230927160746.1928098-1-Liam.Howlett@oracle.com>
 <20230927160746.1928098-2-Liam.Howlett@oracle.com>
 <ZRSLRN1Yfku/2dMZ@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRSLRN1Yfku/2dMZ@casper.infradead.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0022.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM6PR10MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: 17bfc2dd-9ec9-47dd-578e-08dbbfaafe4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZihBlnbOOrqZ9Sd8he6Wc5da5CptM+DndpJBBHYBfgKMeUhM84fEZ+SyWPyKL0f3kSbtKvOO75w9HTmDjGsnoTWiT9f6FVrcrNzbaYoPlKp1vwMi0QQ69+ZhgVuwPDNuo/dalbDTZJbLWkBwgSuWH6BEjbZCIQ9Xk7uUMwGBPo/2TaG0HQLrS6I+ZqTMjQ1Wwnoyi/z+TGgtUGP5/QAXHalrkijuq5VP9zr7Gbko097B03+WpvuR4708prAoQ/ISzqQnBvlhB4lPyoBNuBJ7Nv3k6rjBRPGc/KuaHPCsilU/Qs5EgPfmLrlbBbAm9BAnui+imSKS3agjyUnCAre1xE4lVgMRQml5PvaGJLwXOEmn2S2XmBinoDOPg6p/QR48545A6lS5rw7dFfOBuJfykAgtu9n5sfduh7bUwGULPQT9cvGUIviEeXJ0QVoB1AaE0nt1JXXJojBc1lriRTgtlv0TPpJlvOZgs79wvK1xp601hoh6LuE88WB9GGpKfTcEXhoZzoPUWxuX4f/906L5Nez9Yn9ibVoLcjgrtcgnxuXUe5is04ZSF8oPXvIHnLh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(346002)(136003)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(6512007)(6506007)(6486002)(86362001)(38100700002)(1076003)(33716001)(26005)(2906002)(7416002)(316002)(41300700001)(66476007)(6916009)(8936002)(66946007)(66556008)(478600001)(4326008)(54906003)(8676002)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N9bnuPvkz6oZCC9A0gh2MH4CHUZp7OlaKvJiGxb3dJXTsmX73sum2EQwsEvz?=
 =?us-ascii?Q?QNMYvQN6z/+J1Ek7mmmS5GnPb+XHBVOFfpBUIY1V1q55rxQjGnTIWSze95hq?=
 =?us-ascii?Q?/lEdGQhCnOxevc89VLGwD8FDxTihoGV5K3Hru1I5nw9qShGbIW+jabcbk1sX?=
 =?us-ascii?Q?NFE4u0+18yOlu3obLWU2Z6dpaXTyyjdDKlNV7jmYAyDl5QPXG8EHsTRyuziq?=
 =?us-ascii?Q?QWsncekxLpKNZ2PqWL1n6FEasfM361/aAA3n3bWnxqUZxTVkOTZAmnbEBIwc?=
 =?us-ascii?Q?+Osnjb8PLo/OiACICd6WrLe1uCH/X7VJUu7ODylaGgXVkVzyt/sJgqY3o+br?=
 =?us-ascii?Q?AGuzwxg/Gyhkpc6S/yEriGJrLoxOr1Tiso+Re6inrRMT69ypMjKINnNt6UwG?=
 =?us-ascii?Q?URaafItfCq/fF4N3B3ZKEW9UWtCKGZI9RtzbUd4VeKS7qZ1uzvVgwSMcBj+N?=
 =?us-ascii?Q?8N95IZKDWKnPiknpqgAIf275PGphCn1Z/cv6hATD4HsW23Wz5WWc8fbzkNn4?=
 =?us-ascii?Q?EWrn1LSB1xTJbAQ+Ff6inqpIH2z8/AyGm4T54k5X6Uw6QDetttKgbQPvhrq6?=
 =?us-ascii?Q?wmySn2wzWPDWVGb73CEk21R+thPT/PjU7eIvM38lTPKz8q1dxBwwggIYep0f?=
 =?us-ascii?Q?xHg1nLZlfZ9B8kw4tyH3jC+UlWJAc6zFcUwWd1091+k4U0LrWOeG/ci9t6Ik?=
 =?us-ascii?Q?kFKKXwpwd5gdqvshCpUGpSvdwkzL7X/KMF6Wqmne+YzmMmNJ1s4a1jNlK081?=
 =?us-ascii?Q?ZlBj02w0r5oWMB8Rlt963AtRLSpFC3Ikv+ciLyntBe+icPUioi0Wm5o/iSPy?=
 =?us-ascii?Q?bhiTpFMJDngwSdL275Fn9kGDtAkFMiOdZ2edtjr5FXrPgB/vfDr2Kh9AjpOo?=
 =?us-ascii?Q?pOgPOTKuBl48wCx71+ZkXAfRulzjGPXSwfcCJKnwmayBcyh5ZAZSQVtHv7yE?=
 =?us-ascii?Q?cnXNxz8S6EpxhGe8S9lW7UdlbRZMNM+lm+VDdzAg+wPcr/RHR1G74fuvlpgm?=
 =?us-ascii?Q?WvSkZ6nn72FEu/XpCqvFVRPboLQaPzuvHqaDNJmcXvRtaSIg9XN5t/UL4x7F?=
 =?us-ascii?Q?JF++EpWGjts/6bXFdWIBydJRhM1zFEl3TcPNrtXBj+KcbjO3UQflFllILr4c?=
 =?us-ascii?Q?N/QINRJaCd74qC7GOoffR+d/pA4nW5bFmnSfEe+O3rchgiZp6+3iuPueIN9d?=
 =?us-ascii?Q?wklSsQMgSw4hGPh/qKry2X3IZNVEDqw/ygAWzl7f/dm1YH9lBNYtFQPVIV2I?=
 =?us-ascii?Q?OLdZ3li4Ngk54Uhi/9q+JsK3ESy8d9xvoJpU4rYsPkrM2i4otE/HN+drT8/i?=
 =?us-ascii?Q?VNxvwda52Gw4bvkOH53sGfM0wbL8uDyyscnWJQNr7Lpg6M4RrEQI7a8ZpVbL?=
 =?us-ascii?Q?lxiHY4jRZbexGidwCq4S6SQHUdaBV75LLLuMlDzqgOPCt+K2r9N//G4m49uu?=
 =?us-ascii?Q?ZIwnrhtgsf/S3dlBSDQZySqAegwQsWMqr0TVs5UoHNPRmuIAleQ87k70kFvE?=
 =?us-ascii?Q?+OYM64Lp2hZTaYfQgCguiMcjeqry7nT2od+vF/r1OySNnr8q4u55QGsO06l7?=
 =?us-ascii?Q?5uKaV5qtHzRhl513zD0jwZPCMA9TZijfyVZ9H9XF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/KVVcaHL6jkkdePTHWiUNZjAZ1kXy0L8FipSkatcfckPvEOzXd8nPLyrl1u2?=
 =?us-ascii?Q?KjeV37oL6gacSCPk6x/+Z7pN/QBTSP1iNqazNrBkHBFEbiZfNGFdpGqEll9+?=
 =?us-ascii?Q?R4zJAilqnbiCyCbIR07SwBVQ9p1gCSokOJeQdvQMEqCfKFCjSfno5k8fTvQv?=
 =?us-ascii?Q?f8VRTnAnSJO/8nO5U6FKGdXDqA1L3xQiebJI/nAJq/rvfEODu98maItRCyqa?=
 =?us-ascii?Q?wQGooq+0ZnFX009VzIZUYDzSPPLYXk1v+/gmmEBSifim0Ju8+NwwVCWeZGMj?=
 =?us-ascii?Q?bwoD4+g26nKXAAvcsTHGf/q3Zd4z9sSZAWe3CqUWlEf3Mv4fO8QvBzvqU3nG?=
 =?us-ascii?Q?3E0pKDJ6F8msxrP6I82bKgfmytJatiDhVY6qdagMJgVKLPgiR3neT9peLIGP?=
 =?us-ascii?Q?80qZKjDol+zT9p83/vQ83lUotjbXvdffAcOdsUhjzhkxPiDV64C+BxOOvnN2?=
 =?us-ascii?Q?XupN1CtBV6uF8LmVgq4j/cwXXwgXNCZgds8W1ifZTi9JqF0TLUkG/WXtTHId?=
 =?us-ascii?Q?9euHBzkuiq9j6NStcqO3iqU9txM+Xvw9+cn0qljYE47FRnzuQd2TP2NXmicI?=
 =?us-ascii?Q?cZEhfrVJ81wvZe1XRm3oa4JYrlOEhQ9lup6P0LIIIQDTGLt6cWcFjb1fxuhH?=
 =?us-ascii?Q?wDrZ8f+yseIzlkSSe1Tmd4Y2X0h7VxkpnRLSA3326aTcJkAqZhQlRFeFz6Ph?=
 =?us-ascii?Q?oI+PcPYt/NrvJNtAFYZus1LDvKZauw3Z/FMxayw8hidfto4nH9qQoYkbc3cM?=
 =?us-ascii?Q?4D4T5cJszE2o6S97xjcARhMwKXR4+Cv+nhfv/ztU0mEe70eHzBp6TkJ7UeBB?=
 =?us-ascii?Q?kdMAwaJ3n0YFT3OoBp7VqO4vKG+ghAs1bSKish5iEdgBx7l/3IEOkpwHorkb?=
 =?us-ascii?Q?328ABSyDIKNB/WAiQmLE0+Ud4Ffgc/KWFm5/WrSrOTyhUNpHZqJzhUna8G4R?=
 =?us-ascii?Q?nhBUCIOuRzV+ne9iSSFVVnyiHLGalIGYId0Kh2yD3Q/WuoaOlsGRF8TRiujW?=
 =?us-ascii?Q?EW44HHZUozzBT75bEoxO6QH+6Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17bfc2dd-9ec9-47dd-578e-08dbbfaafe4e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 22:42:13.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4N3FxCGHLoMj95iC3F2Y8Ogskk6C4mrX02HlUpsUjzjBCHZ8Qcc71fsGIpTGB2LnBs5odKHa7YcQawetjZ/dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_15,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=275 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270195
X-Proofpoint-ORIG-GUID: -8Bc1bZEefcP-UMxNbRpJ0ui9NEtDpZI
X-Proofpoint-GUID: -8Bc1bZEefcP-UMxNbRpJ0ui9NEtDpZI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Matthew Wilcox <willy@infradead.org> [230927 16:06]:
> On Wed, Sep 27, 2023 at 12:07:44PM -0400, Liam R. Howlett wrote:
> > +++ b/mm/mmap.c
> > @@ -968,14 +968,14 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
> >  				vma_pgoff = curr->vm_pgoff;
> >  				vma_start_write(curr);
> >  				remove = curr;
> > -				err = dup_anon_vma(next, curr);
> > +				err = dup_anon_vma(next, curr, &anon_dup);
> 
> This isn't bisectable.  dup_anon_vma() doesn't gain a third argument
> until patch 2.

Ah, I'll respin and retest.

Sorry about that,
Liam
