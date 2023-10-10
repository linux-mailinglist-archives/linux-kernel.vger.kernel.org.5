Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D797BF03E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379286AbjJJB16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379138AbjJJB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:27:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12389D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 18:27:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399NxXGi008980;
        Tue, 10 Oct 2023 01:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=bkNfcwCWaEDwkxBa2KRBFI3vvCzvZMaGm31Z3K3/biM=;
 b=YXlSDkzLTubA7eN17Gr/g0Ac0qoO+jA6zzQRYW40QsUSd3T9notD5oAJSmqmLd2uiUJJ
 l+IftqhWR1ii+j4INzzBhFwWX/aWs9V+OAzBhb30lEEiyWLPWihTKxplro4TrS4uXfCj
 uvYeL1L1kT4vTp9g05MmsFtqyTTa1Fr91Y8F6Igv4whDcbuK//CNRVPeKhmw1G1oG8en
 R7c18EO9AssN1pADDM+XS1hSeF1Fxx2gvn7HDcPFweh1vpCDp3/sQcVN0gyMiBVcwiyc
 /JTMKtxco9TGGmisZ9abSQ4xnJU8zPTsJ2ZBADyKqD3ETtgzn0IVIutgfOHaaFZWb2MU 4Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjwx24029-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:27:03 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39A1Ann5016304;
        Tue, 10 Oct 2023 01:27:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws60byj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 01:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Trra7QolEdEQvrR87s9i0LskEYz4A29ld37zI4Bv21v5Tz3zChwVATeTLwZVx9brM7u+Rq5zzQXeGKBWf0Yhopv6pvcF9kPn4KkMCBps+iRL+ZDgYpOdbR7mBNpRJ0Rq1Y1Nx0Hk1zGTjBCZrC2BJfRSS/2A2n4mct6LuXn6vzBxMnWtaH3RmidTAbGC05IMpMJQy20D3OSSy+E+UXV2je7thf8ZcM0s29ePW13tP6tnUG5Wn+F2x28rEQsQ0ERz7dqiXf46baMhaf8I84zi7s69UYbOl4+ErRzsL8DzEmUKJa15PuJEjUs1ekDUo7bCDHr/v67xLW2fNQ5bcaW0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkNfcwCWaEDwkxBa2KRBFI3vvCzvZMaGm31Z3K3/biM=;
 b=djXEZIB4WYJz6OosPk3BRb3n2t69+xcgC/TEXhBpi2wdkNAI9IVPoScMc0QQ90T9t7j1LGhYnaYEuQ081CwKcrABJWSbq4JQw75cBhAlI1fS+FINpbtgsf0W63kn7rwCw30GD/bkWNbw/T1Nq2UWT6bwhnflucz4k2F7WiWe+EmCzHoS8HSE+egCDsuy8WJbYdVKOjz/+Ay0XgM9kyRM6FgqESXqLCpuG5nc74HEO8kWAzq5DplcLpDMEnWRQwzsnq7BcdOjoA3PUIKX509qi4vw6dIp8vN1mRMCCsdihO48mmDLScymZhJqGF0wCk2GqujZFafEMnwCbruFKMLdLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkNfcwCWaEDwkxBa2KRBFI3vvCzvZMaGm31Z3K3/biM=;
 b=SI3vF0SgpuHZSeMPKg6ICT5SceUiVkWLO6PKROcG458CX9mmcN5vRSrnclgOinqqVpFVqqyZdRTAenNJiCLqZrQWGkZ23/5pCAzvwLTvQCezO34iSbqSgnIgJoJtwAst9eNERYHX+uZBViYPyRRO0CmNtqgzGDfFzR8c9wss1No=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5825.namprd10.prod.outlook.com (2603:10b6:303:19a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 10 Oct
 2023 01:27:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 01:27:00 +0000
Date:   Mon, 9 Oct 2023 18:26:56 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Barry Song <21cnbao@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Message-ID: <20231010012656.GA244811@monkey>
References: <20230929205731.GA10357@monkey>
 <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
 <20231006030836.GC86415@monkey>
 <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
 <20231006223512.GC3861@monkey>
 <20231009032926.GA3376@monkey>
 <070bd916-d4d6-41c2-9f51-af35e80c96b9@linaro.org>
 <20231009150401.GA3846@monkey>
 <20231009151513.GB3846@monkey>
 <0343c1d5-8706-4cf8-a17e-25ab27f654d8@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0343c1d5-8706-4cf8-a17e-25ab27f654d8@linaro.org>
X-ClientProxiedBy: CH0PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:610:118::10) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW5PR10MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ca1d8a-e9e4-4d69-9f8d-08dbc930000a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYyTQmqsKu50lu159ZLP9Yv7LQJjoskgluMv0/ln19ap37e9l3RIUGxD24Pr20uuORwN+LosE+Wy29wyNrmwDzwbD4h0pTbv8aVGVh931Zgn72XrfWM1/u8J0B0LBdX5AbiHU0Ma2CthcYjXHnttgNfkaHkbVC561KC7lYNl6zeM4ZgKI/5DyZ7zE4iGlSvBbBl66DRN2jwSbWpcI1J/0Jb92pjrkrdm0+eQ7PxUqNVb2H3tOev8JRQdceECqIWiHFktC/frrjERqx3s23M8JwB19fMLBMexaPBgUejo5cOciGte8yqn726wQZ5YD9Hm3/B7VYOas1JYadeVRl5ZSfk3AG+KiGpfmV72Px/CVFjMZgJ6fT6z2Weh9HFgSxrak2hZYZ/sSLBpZOO5k8FN/4UhZlNPpjlfof54bQctuWBJEKI0s7y+XHqa2hKgSL/8MKmhmanqDuSJ3j5sM4g2ZJQq6mVEbJEfWvrEb1TCTE+Pbk4/LPqN5fqkpGE8OWgnTHd0lDIvcxFDg8MtZHqJn/BvDfAp5sEBh/WSdcY1SWE4VO/6m7+qXByDFt2q+JC7Hse4oqa3inERTJyW4r2nxunTi8YYy1B0OLF6H8V16K8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6666004)(26005)(5660300002)(38100700002)(53546011)(33656002)(9686003)(478600001)(966005)(6486002)(7416002)(8936002)(4326008)(8676002)(41300700001)(2906002)(6506007)(44832011)(33716001)(66556008)(66476007)(54906003)(66946007)(86362001)(316002)(6512007)(6916009)(1076003)(10126625003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G7SfTGKhkvuMu6LBMj2tPgDG+fWBikWPI8UmtH7sDhpdIhdupknEznKm9740?=
 =?us-ascii?Q?kOjoGH8gHP+SsN/+ReAvS2KjRZhYmyeTzpuliOC1KjAK4MhEiSw/lE41I8B4?=
 =?us-ascii?Q?PqPh5Mo6glZbtUNAKXkPYYxxueP+Z8r+GPJqGH2lvCzKx8qIakelUtmzlhWp?=
 =?us-ascii?Q?1ucrtJ4o8tEBCJriwgywPUMcB7m9U/kv5GgSMW3yunzlS0dk/vHr3jiUMfzO?=
 =?us-ascii?Q?jp1TPi5D+QfIAKDREJB/6W0VaHqhb/s18p/2LlOrObHAkW3xqR6Vf6R5MYng?=
 =?us-ascii?Q?eGaGz+dwjcxhVD8FozPc3B5xpaTLdMlzCI/jaoh7QNzampJh59QqcIqB+MHx?=
 =?us-ascii?Q?jw5nIUc2eohu9eGXlh2CBjv+XxgbzZN25iC24r4kg7aAGaDDsrvgx+etIWQw?=
 =?us-ascii?Q?Gs1DgXTwSDMcn7cVXU/MQ5WhnVHN1bLvTta1lqUJaBkeKjq0anafjtmEwDGP?=
 =?us-ascii?Q?b6HL4OS2us7Ii7uSbFY0GIHpGzx7AOMEWw9T5IVT8rM/V64IwuetaFbpIJ/I?=
 =?us-ascii?Q?E8/D/SnWt2CNVZaBgonac1Z/DPliSPFUAJm/jWsDugqWn2pc5kCZghqQOlUR?=
 =?us-ascii?Q?zVrBP6+m/O831d6JBttLr9S7tx0vC/Sy/m1OxARuoOg9T2H28q01XXpFaCar?=
 =?us-ascii?Q?DFqrviTpwQrd8mD1Zyzt+gvXloEq3Vv0reAN2Qw31wsEeFX1D3OAV5e08kDt?=
 =?us-ascii?Q?iTut+VwEDws0Yqv0BSmYML5Po8jBY6uxx8zqtigS+YaNS56e37EusVTRpA80?=
 =?us-ascii?Q?NkFhEjrJLawroBGog6XvOCtIbSNJgxEMh5e4iRpKPRdgVd7Tg+fIX5v8BIpB?=
 =?us-ascii?Q?QXNlGEV+l6PIHQdaY85JHn98NHIym90R23ZU/wcln8sHOPmUkt0OT8iE3yOV?=
 =?us-ascii?Q?oh9lKZKjRMt4XOK8f8WI+mJERxd0JTlHyPh2pJYXbG4IfKC9gfCsoynJxLPf?=
 =?us-ascii?Q?yiMrKplgQHo7ZDGimRa9qxAMqzrKc7GB/y+amw0vs6/rx49sGn9htUapp3ea?=
 =?us-ascii?Q?t+xn9UNXDilQQX3ZBI/XtCLMByuWcAhQrPJ7Y3WC4Gj2PxYa68XH6+2Iw9Ce?=
 =?us-ascii?Q?S5lMDTXPcFoWUmhjl2tesz2J15ERP0azTIMi4Z43AfotzltBLDMKonkIhK8A?=
 =?us-ascii?Q?kbUh4rQRJ2yjscYGcVc10ryL40WyiWD57LJ1iRfl8I6Ghigt4aA8GYHbyV5Z?=
 =?us-ascii?Q?wI2iroJbFgkVxAewkmp/VzImruv5O7OPaJ6yTM8+wGi+pjkBp42rKY/OBjWe?=
 =?us-ascii?Q?ujHX3Kz+VhFYJTkqU0Er6oIEzbvJp2upJAR2ilGjAS0kbpSCp/Giv7cIPotv?=
 =?us-ascii?Q?ZhxaLUK8JHknCvD9W6bIcr+q8Ia952BR7YfnaT6tCEGc6S0auJz/Hq0+tiR1?=
 =?us-ascii?Q?T2AAPUb4XUzHNAMpqRr8DF6FynnfuMPVx1oW7Cb9WGaNf6eLpGnamCUXuiAm?=
 =?us-ascii?Q?iUGQ6gtsqwW2Dp5X491QzNgBPrxG70/ES9Q1tV4vzMuSEySt+JaS/xHtYZ1X?=
 =?us-ascii?Q?5mVfMouCmykv6H8gsBUoiZc6UfwA2broj/TvkvvuMIF0AyZ9a+8qUWcDY7uO?=
 =?us-ascii?Q?1VZ2U4w7zOK/F3CgB1bkoSjGUOIlIssM+V8l/h498/r/miHXvSv17hsQi894?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?69JmKuibkApBEIHPFArpb2JFsy9/APCm8DEs2L0InX+ChYxLEHPrDPwqNsJY?=
 =?us-ascii?Q?0naJGAIScrvpMEBDjRA4aoiqCJ2PiK8wA0pm//MA00kQ6tCgejULtzNUGy6Z?=
 =?us-ascii?Q?+MT0sxaTd56Ztn+mxJQh527Mjqz6ePMf//3crUCsGdl8gdrk/qz6qfGkUVn+?=
 =?us-ascii?Q?likU/1vMH6HbQe5ZLFktljKvqUJuoJTNkHPEmxvgYtFUjNspdupJErKHy0sd?=
 =?us-ascii?Q?D4LLWqqiuVWv3iX1rOxldvDrd84A5mCDOWSIm6XppCm3mhOYJKesse2asjdp?=
 =?us-ascii?Q?EPnZHUBAjuL+i9mp9to0nV16T3HxQA5xZepNTuA2Mp0YPaGxY9X1XpYydxAV?=
 =?us-ascii?Q?Ri8t+9/Z3y7SYig5HXLAaEauKJ77v2maTkW04rarLcZJaAhqBN0wS6uF+bRV?=
 =?us-ascii?Q?wMCjeiPoDRlJNEJXL6EDTuYgTBQ+B/zwSkJpns5n2w+0/YXinFEvxAKM2BIr?=
 =?us-ascii?Q?AV4gW/pVYPvtj4ctB4s7Td8AVetL6HGZbwmsNKRrmoRlQSfkbhMt3i30HfLa?=
 =?us-ascii?Q?nZJyek1EvnUBlsaiP1WyzLOmoZ2px0CLPF7rCPgOJrdhY8KIfDMpgMReicho?=
 =?us-ascii?Q?+W2REAzMBmw07+crl8NhYmNbHie34IMX0QZ8eXVd6oMBxzAi7DkI1379lWHI?=
 =?us-ascii?Q?A+bMNqDVaBGe8ck6shbQYnN5dWYFA/Kl+TuolMD3uc6CtXobwtcELXAD2AKE?=
 =?us-ascii?Q?wgetN3m3RkEmQF1RcnO5aYoneUaZow4KaXvdKbIaqveAL+72NVopFykU8rwX?=
 =?us-ascii?Q?ZqMSBKW5XbgQcxjeKnnQ8WqBCpDZEL1b41CiydviE5nIIjA3yOPsCTBJNKGk?=
 =?us-ascii?Q?YbX2XhRVrftz6dwB7IPlFq42t3XpiPxcVg0daYdbYpAClshO4kizqWzEJnQA?=
 =?us-ascii?Q?Gdi0tEdV7ybd5W/jiNO09V5Yb99f/SnDGXFNVUkPzgsqgzmhqz9hYz2oUcI+?=
 =?us-ascii?Q?Y3NvXlhA0qKxvhFHCyMp5hStnUBntKGOoUmkpzEGi+UWLAlhO4KyWHqQbVGW?=
 =?us-ascii?Q?E2kJm+juV0p3BnwaihroQeAyyDVEiE6drG0+p36itSfD4jECjJQGdZH3YyDv?=
 =?us-ascii?Q?iIp6yCBEj7Zh8fr8LEgoMnfCZoli+oZ1uskquw/nPbXyCOvZGSN4To0hSfZ/?=
 =?us-ascii?Q?PcDLbWyuedRoM2ij5no2s7iSLPZzLnhbxA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ca1d8a-e9e4-4d69-9f8d-08dbc930000a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 01:27:00.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fRYzMdixlHd9smv73kHp+vzBeU6XNmaWomsDGUl3Dkw/AG4sstDQGb9kJdxmxjazm7VxcLH8HQsPcoHY3zY+/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5825
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_01,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310100008
X-Proofpoint-GUID: erESoOQS-Rb6LwPeRtuu8Txo_woctONI
X-Proofpoint-ORIG-GUID: erESoOQS-Rb6LwPeRtuu8Txo_woctONI
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/23 23:09, Konrad Dybcio wrote:
> 
> 
> On 10/9/23 17:15, Mike Kravetz wrote:
> > On 10/09/23 08:04, Mike Kravetz wrote:
> > > On 10/09/23 12:11, Konrad Dybcio wrote:
> > > > On 9.10.2023 05:29, Mike Kravetz wrote:
> > > > > On 10/06/23 15:35, Mike Kravetz wrote:
> > > > > > On 10/06/23 23:39, Konrad Dybcio wrote:
> > > > > > > On 6.10.2023 05:08, Mike Kravetz wrote:
> > > > > > > > On 10/02/23 11:57, Konrad Dybcio wrote:
> > > > > > > > > On 9/29/23 22:57, Mike Kravetz wrote:
> > > > > > > > > > On 09/27/23 13:26, Konrad Dybcio wrote:
> > > > > > > > > > > On 26.09.2023 01:48, Mike Kravetz wrote:
> > > > 
> > > > I managed to get a boot log:
> > > > 
> > > > https://pastebin.com/GwurpCw9
> > > > 
> > > > This is using arch/arm64/boot/dts/qcom/sm8550-mtp.dts for reference
> > > > 
> > > 
> > > Early on in boot log before the panic, I see this in the log:
> > > 
> > > [    0.000000] efi: UEFI not found.
> > > [    0.000000] [Firmware Bug]: Kernel image misaligned at boot, please fix your bootloader!
> > > 
> > > Isn't that misalignment pretty serious?  Or, is is possible to run with that?
> > > 
> > > There are no hugetlb pages allocated at boot time:
> > > 
> > > [    0.000000] Kernel command line: PMOS_NO_OUTPUT_REDIRECT console=ttyMSM0 earlycon clk_ignore_unused pd_ignore_unused androidboot.bootdevice=1d84000.ufshc androidboot.fstab_suffix=default androidboot.boot_devices=soc/1d84000.ufshc androidboot.serialno=ab855d8d androidboot.baseband=msm
> > > 
> > > So, the routine where we are panic'ing (gather_bootmem_prealloc) should be a
> > > noop.  The first thing it does is:
> > > list_for_each_entry(m, &huge_boot_pages, list) {
> > > ...
> > > }
> > > 
> > > However, huge_boot_pages should be empty as initialized here:
> > > __initdata LIST_HEAD(huge_boot_pages);
> > > 
> > > At the end of the routine, we call prep_and_add_bootmem_folios to
> > > process the local list created withing that above loop:
> > > 
> > > LIST_HEAD(folio_list);
> > > 
> > > This should also be empty and a noop.
> > > 
> > > Is it possible that the misaligned kernel image could make these lists
> > > appear as non-empty?
> > 
> > Actually, just saw this:
> > 
> > https://lore.kernel.org/linux-mm/20231009145605.2150897-1-usama.arif@bytedance.com/
> > 
> > Will take a look, although as mentioned above prep_and_add_bootmem_folios on
> > an empty list should be a noop.
> I'll try it out atop the series tomorrow or so.

I just replied to Usama's patch.  This may have more to do with IRQ enablement.

-- 
Mike Kravetz
