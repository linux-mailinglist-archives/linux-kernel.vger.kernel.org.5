Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BEAF7B6C01
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbjJCOqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240119AbjJCOqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:46:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D025AF;
        Tue,  3 Oct 2023 07:46:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393Du05u007308;
        Tue, 3 Oct 2023 14:45:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=xjNAU7duT3Y7dvWfiFIXYIaaG7xrGHtocFB7IBdTdXU=;
 b=c1loemysrqBbZYZsSNbVqf+BJaFqFnIaTP7CzM5kS0AZh43xAtamBpoHCyMyekfDjEPJ
 RYMj1ikh43mgTPADzdFbLzBYAy2LPB2dre2QmkN3W7DXoEuKJoGAdN1fke9OmNXHQ75M
 hxAyZOYvAtPPcSvYb2UWJrqSRzT6kjagdMRD8BRYSu9vnhurTOLjiHCHPxZeYHPNqCV6
 n+zHgtZopqkjN4rd3c6b8IUNr+n8+Cm8fCrpX747hLGC9hegZ3I2eC+Y3Uqbz/uiCqMH
 njPepyBk/d/CIkYAv05qXuILhygwvVNsxxDBlOjaQMf8KyRu/zCg6uIFeB790KuyIyyJ zQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tea924xaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 14:45:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 393DqwLs000448;
        Tue, 3 Oct 2023 14:45:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tea462q93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Oct 2023 14:45:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4xqwxGMl+2ZcL65bTwhVyLLVN+TDo+Oto2oUtHTeaWaQUS3+MOdxlLBt68p+AU2Z3dVmzp7HlBts2IbuJr7pAzKanH+/iDRZ/SZOfOpJQcOg+I69tSfcEMmPbA5F44m2QmUL+xIEs9yczR68ZoQg2FYEfKkPIICBFaWxtt5CsBsfpz2aSbTzeBLjhS9ag0wY58lwIu0GkdfreF982jIhYgsky9CuBYhecJLEeJlMLgQrBWZdbLY7fyD+Av6WH7j4cvudkQc7bMuuEnBNX5HxqkAPlBAOmdHa3qt+LAmn9amAUmSmGyfJXQXQo3UVFhmUZrghFoAvIfaSd5Tq2DYHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xjNAU7duT3Y7dvWfiFIXYIaaG7xrGHtocFB7IBdTdXU=;
 b=aqAIN0rW+Uvn62x8x+5/EBSsyBsCJu6BfSOxuTNr9fMBHU5jpXC92SlXE54IJmnTdhHh4Y5nVK608A+XaghMqdJLQagMECs9rfDmuV5YtixIjGoxypMJ+eeCEA9LZud83xdqgaQwqEiKYtApoEVk5pWviAr/6weTm2DrecxellBCMoztj7PdECh/+Jc/HhaXpa2C0YR0VLcthtwKe9y3tDghIOBbSS26rlbrz2UzxYmVdMoGm5TKplnmr88liMtlnwZZ7NzUgaogww6jsB/oa0a1kzuDoVNRb9aMuJzmIZhZ067aL3gHghr/ySPuZMKxl5qM2Ue+ug0UHRm6Z8LzpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xjNAU7duT3Y7dvWfiFIXYIaaG7xrGHtocFB7IBdTdXU=;
 b=FvH2bbBLWq035K8G2DEcLuWv7PfyFyhAAujB6ix9XetYW2gcBiHU10MO9F5hw3yIaSwyFXTy33ZH00Ikz8Q4rNLL5yUB7iJS+uMcRPD9Vn38i6P0gRZt+XIw8whIdDl2s53/avXulUvjOIbXti841aPMOMaJ6OG3lMJ0K9+aTdc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH3PR10MB6788.namprd10.prod.outlook.com (2603:10b6:610:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 14:45:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 14:45:29 +0000
Date:   Tue, 3 Oct 2023 10:45:26 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/3] mmap: Fix error paths with dup_anon_vma()
Message-ID: <20231003144526.upn62oqknscpwci2@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
References: <20230929183041.2835469-1-Liam.Howlett@oracle.com>
 <20230929183041.2835469-3-Liam.Howlett@oracle.com>
 <843f059f-dd54-4481-b46a-e87e56274db3@lucifer.local>
 <db77d8e7-4b29-2348-c034-3a2cf120b7b2@suse.cz>
 <6f85e46d-78e3-426d-9a24-3aadfd91bdc6@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f85e46d-78e3-426d-9a24-3aadfd91bdc6@lucifer.local>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0445.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::27) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH3PR10MB6788:EE_
X-MS-Office365-Filtering-Correlation-Id: 0699c1f7-420b-4b67-268a-08dbc41f6331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rK8INviaDH8/zf8DtxvWVca85zFSKBYl9KVYejwU78Xs9JFnjgZXcatTgUObnChd0LKGxEx4Xx+OwM2eXL8M4omJsioygf3IHmx9CUQZssq01c1md6Lm818eA3aBdYGT/sBFMcka4ECAfwp8rrXM6VVcAoiGRVfq3jZwZsVc4DAIAZ7juDezV4fR7HTy0YsC/QuLHfRuPWjBhUigbI93m3QiL/x8EkprRxHqMcjsaQuxo5KKpLpNDj/atzi2OQ2ciBHzZMWGnoPQ7Ijz52dszCw7wRKJJVeqHG09QlqsD76mY/3/hTtk/JEW4P5RIXDzIznPXzKEs1lWh+qUU6DSb6jkSvTOSXEXW0Po6Dv0IxCO8OuQj71xt289qa4UwuZNEbduuWoJKEG2pPLilz5yZKK0OhBe+XyE9hJbcNTFDgponjEL0qjEJgJRkdPMxRhyisJSEGLRJ3wGivjGrAQ6pqHG1vXc8SK4pXthfJMBGRgSDEIgNcGZF3anqVQeADSItcWMkdDuICLfyApZ0a+Ia690iFREF91dKquySWAFpbpQuWqJvdXF1mV325F/eqol
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(53546011)(6512007)(6506007)(9686003)(478600001)(1076003)(6666004)(83380400001)(26005)(2906002)(33716001)(5660300002)(66476007)(6916009)(54906003)(66556008)(66946007)(316002)(8676002)(8936002)(41300700001)(4326008)(6486002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FXa8KE+9qTe5Dvf23sc6HrC3wheuy7Je4+LZnUfvQhpNluW9hwX0e5Gt56uy?=
 =?us-ascii?Q?JP+qUwHL+QnCy/E49CG9N5pjbeeHYnEXsiC+sXwMEiYzCSqb9wkS4ILVBiZY?=
 =?us-ascii?Q?F2ZqhvXwqHlEm6prvMqkHDUW0LvnaDBzKtuMcaZ0bMzBYv8zbQKNUSs0L6mh?=
 =?us-ascii?Q?LsiiODY2L9YaE7U3fnU8oKUgywwkf24tpMvEo9aTiTC5FCZIb+GdFj+dF8fJ?=
 =?us-ascii?Q?eqNzhArUrvetUUU+q8wV41r00C++iWeg/icKCi1mJ2TInNXTotq9Oe5Gqipg?=
 =?us-ascii?Q?a2DQ1vlAU42G8Ysp6Yywdgbl2ScucHHoAUahX9d7t6MXfIgAnFNKYXC8F5mB?=
 =?us-ascii?Q?dK1C+dGyNVVZpLtSIdZhlD1QM8kfJoW9cDf2EN62MCtFXJpnBL5cuuPZ1Pxo?=
 =?us-ascii?Q?TRHDjqbyfHi7KkS1W9SDNaHkptxNuSLvHU0kqL874gR/AZgRObz5q0PShkkb?=
 =?us-ascii?Q?rWJoz07T4J3Lxomz14yqkgaK3MZIejZH3w2xzihkM8q0sh88iGt+L7OtAILV?=
 =?us-ascii?Q?hNnrVkMSMykYoSGDkxG8wQEIZzN2xou0GNV51kf6QheaI8SrMYDBc2VQiZlI?=
 =?us-ascii?Q?XfKGSS5kLVHyouPKnR2BSfM9oNaj3B/6mdgam1Lo59uFOJVcHJrFMBZ+FgiM?=
 =?us-ascii?Q?MxYFykDZkrEfnIWLN/BYBBKmDLC+3jgcEC0Ae5A7qJcVw94aT2w9nwJR6l/N?=
 =?us-ascii?Q?51hq5AeC7axnyN6ncqsgiLCYqhmWl4L1HUzTz/RClIHPBcmlE+l6HalHmmkp?=
 =?us-ascii?Q?affvLMZY9HsOhZImmD0LctKHoED93H6/+iUVnCSrVYSBavvGmkXq3LQCx4om?=
 =?us-ascii?Q?Wxl54tbnLDS3j1ZguBhvLWosfZBfyyZBYpPBxhU6avYGHLkHOSxtZgf8gavf?=
 =?us-ascii?Q?egLDamU00iEfDgJ6lKY7+anqDUxkvk1F3xcLQbrG9iDpEqyQVmTcKtPuXIOR?=
 =?us-ascii?Q?w+ZZ3vSfRBi+Vyj9QMyos5L/fnmOY5HIaT75Hk7vRK8cfHf94QWYTTZA8OIO?=
 =?us-ascii?Q?N9jRZ5Xmn2VnJGBfi0SQmkXxA8NOrydNg/7+DqCexvwh5yB4eFt8gidE3bW7?=
 =?us-ascii?Q?za4QO6Nnef2rPJhqWdN993vHK5WjAXU8DEFnOAT5m/n0XqMryRNjgtA2ggC0?=
 =?us-ascii?Q?fmymR9ip5XumjJBtlyIiOr4I+iSdtDmClb5EuelZW9dFxYapfhOYHsRFGB9+?=
 =?us-ascii?Q?eCrLxj5PkGeF6dHE5Dvv5aCcWv5ZTsE6Y5eaGx8ksYKptvtLwPC+RD+ipQ8r?=
 =?us-ascii?Q?M6dwV0+sKpAgKW76onHlpqs05TPHf+ykLVxoUawBCXGCr0VcCi9FedU2EsHA?=
 =?us-ascii?Q?9/PZY4iFTkazSCz4R4gbsK5KlGedKh4I+k7GLw2Vx3e4+VfaSJS06qnQiVbi?=
 =?us-ascii?Q?KnkMXnB6M9EXkLStSqDdrMuicDrrGtFQtEnzHytNm9vnXuNz6HLqySXX6P2v?=
 =?us-ascii?Q?qq8VPZpBDUJNNgaGVmSvSJMHK+UCr0b6piOKGHN2VLVAoIMOKv/4a9bYGRa0?=
 =?us-ascii?Q?NbUFLPV0zKguaTC315Se85RK+rWBJZgjgmwUnuRolPCcyytjr/bPUMCOaG6H?=
 =?us-ascii?Q?qzpZvPrUVqILtikcVx+mlRhQeAgY5ZtzBmYBL9VD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yqp2wkrmQDXifa+g56vg/hKp5lGoDRnjTrQiKag/hcHtPC63/UehCymC+0rO?=
 =?us-ascii?Q?J88OzkHIutNZxIsT4v1zDF+M+tIW0l6CdYXC8kIwBUQXwj4hUdV5mrPF45YY?=
 =?us-ascii?Q?ft0BXEaK5f5h91wZpA1GdQwZWwqsQV1NQHGIWdoFh98vjSY4GgUo1lS6wZrH?=
 =?us-ascii?Q?aIW6xxnflIR4qWhozJ1Udb5Qzf9ETOV5Gt3P+BYn6SgmwvUYMwBWmQry7ubo?=
 =?us-ascii?Q?t8GewDk4ssKqMg+zht/MCCoyYhvfbP7VR0M1lFcHsJO6oJ7afLTZfn2mzRYm?=
 =?us-ascii?Q?prAbISTxyI2ICEg/pO5vMK2hbxm1gXIbfBuEDbaeMCjkIIWeXu1To7P9PXRr?=
 =?us-ascii?Q?nLRL1/pF8BbPg8RPUs1IoSYy2qrr4DRz5KlnW3wJUf4y/n8VA8NHMiahiPEh?=
 =?us-ascii?Q?GTUHMtxIm8wW5i9k108Y1a2z4ccZhBek7gBS/tMtIUEuRiuC8fMeOzIdtjFD?=
 =?us-ascii?Q?4zoq201bYaeRRE+D79UuWmUrZIt9xkJlTQhhSoNpRS3FjoomL0D2YKfi6CTn?=
 =?us-ascii?Q?YqDs0x3ycBSpPtZFhxWsfirH4/wjO81ON/aNwlkupeQHNYuU4tnsUn+bgroj?=
 =?us-ascii?Q?cOD/hITuBvq3rd7yTfZUQ3PwA/pskctcjh0JwOuT5w9FtpKTuvm3fJhcZyK4?=
 =?us-ascii?Q?Jna8Tx44Rf+WG5OIhtFI9MPoQq/aicwsEyqHyEnvmjjS9B1Z6bKGvBgPpFar?=
 =?us-ascii?Q?OdYYdOejqauqcujJ3GJwhcylNgnbHuje75Y5ijfHlgAalIdceAo5oI1qndgF?=
 =?us-ascii?Q?UEUmtrOCHaNQHmc763EHZXRIoRSJ/GP7UwaX7sBZrPb7Kigu55e44iX5Ak7t?=
 =?us-ascii?Q?YvLB1RyDOLIHfs8kO+Q7iRUsi3KnbxmH5p3N1oVggicndSH//eOTxwesuXjQ?=
 =?us-ascii?Q?/jlsKDeU/A7XDzd7M2uwH51py6GFXwdRZl25gz8ZMuWDIV2QPCyAr5mqmPQJ?=
 =?us-ascii?Q?y07BCEyqw3pPwfWvLt/mpA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0699c1f7-420b-4b67-268a-08dbc41f6331
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:45:29.2126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AShsTeQB473SGaro8BVXuyM1J3KoLDeoSBPDLG5yBKQj0cGN7tdhObBDGMtlUuslgN+dVwipqNR3P9obUaTXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6788
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_12,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 mlxlogscore=952 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310030109
X-Proofpoint-GUID: Eqrv8WUX_VC9v5aE1G2jXgJDUIMxifd7
X-Proofpoint-ORIG-GUID: Eqrv8WUX_VC9v5aE1G2jXgJDUIMxifd7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lorenzo Stoakes <lstoakes@gmail.com> [231002 03:43]:
> On Mon, Oct 02, 2023 at 09:26:03AM +0200, Vlastimil Babka wrote:
> > On 9/30/23 00:28, Lorenzo Stoakes wrote:
> > > On Fri, Sep 29, 2023 at 02:30:40PM -0400, Liam R. Howlett wrote:
> > >> When the calling function fails after the dup_anon_vma(), the
> > >> duplication of the anon_vma is not being undone.  Add the necessary
> > >> unlink_anon_vma() call to the error paths that are missing them.
> > >>
> > >> This issue showed up during inspection of the error path in vma_merge()
> > >> for an unrelated vma iterator issue.
> > >>
> > >> Users may experience increased memory usage, which may be problematic as
> > >> the failure would likely be caused by a low memory situation.
> > >>
> > >> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> > >> Cc: stable@vger.kernel.org
> > >> Cc: Jann Horn <jannh@google.com>
> > >> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > >> ---
> > >>  mm/mmap.c | 30 ++++++++++++++++++++++--------
> > >>  1 file changed, 22 insertions(+), 8 deletions(-)
> > >>
> > >> diff --git a/mm/mmap.c b/mm/mmap.c
> > >> index acb7dea49e23..f9f0a5fe4db4 100644
> > >> --- a/mm/mmap.c
> > >> +++ b/mm/mmap.c
> > >> @@ -583,11 +583,12 @@ static inline void vma_complete(struct vma_prepare *vp,
> > >>   * dup_anon_vma() - Helper function to duplicate anon_vma
> > >>   * @dst: The destination VMA
> > >>   * @src: The source VMA
> > >> + * @dup: Pointer to the destination VMA when successful.
> > >>   *
> > >>   * Returns: 0 on success.
> > >
> > > Being a bit nitpicky/refactory here, but anon_vma_clone() appears to have
> > > two possible return values - 0 for success, and -ENOMEM.
> > >
> > > As a result, it's not really gaining us much passing through this value.

Passing through the pointer simplifies the success code path, in most
cases.. for these callers though, it doesn't appear to matter.

> > >
> > > It'd be nice if dup_anon_vma() and anon_vma_clone() were therefore updated
> > > to instead return NULL on ENOMEM and the dst otherwise.
> >
> > But we also need to represent that dup_anon_vma() had nothing to do, because
> > "(src->anon_vma && !dst->anon_vma)" was false, and in that case we should
> > not be returning dst from there?
> >
> > So maybe we could return NULL for that case and ERR_PTR(ret) for the -ENOMEM
> > from anon_vma_clone() ?
> 
> Yeah, you're right, actually I think that would probably be the best
> approach as you'd both eliminate the awkward out parameter but retain the
> fact that there's 3 possible return states (dup'd, no need to dup, error).

I don't like 3 possible returns as it makes things less readable, IMO.
But, since the two callers to the function don't use the assigned
variable again it won't make things too bad here.  We can document it by
using the variable name.  eg: anon_duped = dup_anon_vma() instead of
err = dup_anon_vma().

> 
> >
> > > Then we could de-clunk this whole code path, and the quite natural fact of
> > > 'thing didn't return a pointer therefore had no memory to allocate it' fals
> > > out.
> > >
> > > But this isn't exactly an earth-shattering concern :)
> > >
> >
