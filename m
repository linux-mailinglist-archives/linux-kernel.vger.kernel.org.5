Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1407C42E0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjJJVqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjJJVqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:46:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE9C119
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:46:48 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AJi9cn027657;
        Tue, 10 Oct 2023 21:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=aOlG/NOPVRtDibkP5GpBwZlWY+uHwwt4ClHP6dUU1sg=;
 b=RqlH0P0L0jCck4CvOGNHjJIi6zEVZPMFhGzMzKHReQFk+b8Jvom1p38Xk6H+VGG0s8HW
 DQ3h4CL6eadh3ejiV3StnA52dEW7lA/KHM8K0r15dMMdYUh5OFvxEBKB602Ww9M/rn6J
 MRho2kImTl04CoRRy/cpg7+Fu+pqcXd2INAqMaoZdQBT1A0IsZLMIyD24kRvIetL9DPk
 /2kYDsAc1qBy/mb2lqh576T20f+gkYduJ+fazexkRFrI5+6PqcoHx77KT3zQTkZVmyni
 ikcSwZy2crBEZCAqSM1uTlfCHtnac+BlTLbxtheDF86wCEPxjorKvCUNLX6ZMx1QWOna 9A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx8cek2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 21:45:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKMcAg020782;
        Tue, 10 Oct 2023 21:45:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjwsd752m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 21:45:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fp/CWakE3lO/dZid66Oe3Wki2N5bRdEuql1x1eOTopUIScgF6Us6160s4idssf+MIwnfdjBUpN8dS+2j0MTe8NBA0Tzzx9y0MKujnf8VJ22c0dxNuF7Fxow+JqICNQIR7a9PuEPBFxrDpIAiRu+pbrQ+g8ly7sfb/H3JvsRE5xFQM2sGeazD7jyvltC1laiz4coabwzehMiwvMjyvW3Jip4BoGNZ0tgAfSkbDHNi4QPXyotsgPxFKttlnkWuMTCAIL7P1VVEpX4JQDAkSCHCCAIrxjC8fdPLp7ep43SLFYOIHaYP5IK3JTSQpv9Ybeu/x1lenozHZbe7Fd5IS6tLpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOlG/NOPVRtDibkP5GpBwZlWY+uHwwt4ClHP6dUU1sg=;
 b=ZX+boPPZrpy15VpvH7zieO0sfWebnxWdDikMynRxbNGkLipm44HKhkI9FD47wvK1+rnr6mhtABkYTFQj6Svub3+uGSL7tlw/m7afNSNh6uyM/0fuUK7l/jaAAe53nWmMdHcQhQWA5ePL/g52ZJiQwvS7TuNQVL9Jh31gbusBLejX7fvMORUiA0Ngrsh4X0jRPISAKSa2Q+YXvU+sGLQHyiJgKqABbY622djc9Glu7bKzRmQJyTPAIxYhRtcEmzVpQNN9byoLMjECskijNMYcCVVAKX/mPIBpiR20gQu+LYaIn44uF3Vw0WAHhLXy9PR5/G0TsusIxMeOugCoQ3BQiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOlG/NOPVRtDibkP5GpBwZlWY+uHwwt4ClHP6dUU1sg=;
 b=r5jZFieDQ64ZRnbcKQbcC7gb0c7tT3L3E8UNSDF8/qD+9JOKXInaywfANOhqVsQEorMETZaj8qUo0FwAHp6l01oyuGMpf3bR/B6OCpnJj3iTzhYYm9UwyZHOlbouM3PzqmIt+4kSp0Xzs/AQhY8kgt1ysqFZPrE4sOIuQQX2ghE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4299.namprd10.prod.outlook.com (2603:10b6:5:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 21:45:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 21:45:37 +0000
Date:   Tue, 10 Oct 2023 14:45:33 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
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
        linux-kernel@vger.kernel.org, Usama Arif <usama.arif@bytedance.com>
Subject: Re: [PATCH v6 2/8] hugetlb: restructure pool allocations
Message-ID: <20231010214533.GC279095@monkey>
References: <ba5a528d-7e85-77a2-5096-5a143a3b1606@linaro.org>
 <20231006030836.GC86415@monkey>
 <5d14b681-a2c9-4210-a0c1-bf38708b7998@linaro.org>
 <20231006223512.GC3861@monkey>
 <20231009032926.GA3376@monkey>
 <070bd916-d4d6-41c2-9f51-af35e80c96b9@linaro.org>
 <20231009150401.GA3846@monkey>
 <20231009151513.GB3846@monkey>
 <20231009170710.b52f5a6e57c23d5caecce8ab@linux-foundation.org>
 <6f381d4c-d908-4f00-89b3-ed3bcb26b143@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f381d4c-d908-4f00-89b3-ed3bcb26b143@linaro.org>
X-ClientProxiedBy: CH3P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1e7::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM6PR10MB4299:EE_
X-MS-Office365-Filtering-Correlation-Id: d60086ad-86ac-494d-a4cb-08dbc9da3d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YdhTSEuQabXcSn3RtfRfvJ4k7MqvCMMGx1+0fcEE0m8WzbYctYocktcY9nBHy1J6f/ZeuOyQ6lcNHL9LzKvTD2RCQ03+lYgBdJU/MDvSNjIB2EvCTO4i98Si12l/Ex9KLSuJafk0z+fJ7DoHRHlhRhOIGM3Ww3XEoy8yRzjGtLWxUv9Bg7iYJTMCZeNXwVT+TDmkpgxVP8dI5XSDKLxhV8i59z40czzi5sSGWbPn+3Nzp+BWJZMEXgod13YsBLAjTFzk1+oyK/5rNwMpD9fN3cRSiKFex5hqgKnJHcCzcPygYEP25Xc+snIq69udr5Lwco75xCgZfOgldQdzXPaZl9mG8v7EsyQmSllSapIxGVDM36CRbQ8eBGR5HzzxpaMqDz7od+zZBi9NME6t5+tg3TTgnICGH89HYMYgl73SkCw+SPq/SojiXPfpkb4hUi5ymUmt55bZE5fo5lYLImalDXYlOhBuKaSpeerLgjsvmb7u+c7R7Rmss4SzurwdLD8LTSifZDirr0C+y9d9ySUT5QWYB0AWRC1G9RSlcIRzsA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(376002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(6916009)(2906002)(1076003)(83380400001)(316002)(26005)(7416002)(66556008)(66476007)(54906003)(5660300002)(44832011)(4326008)(41300700001)(6506007)(53546011)(9686003)(8936002)(966005)(6512007)(6486002)(478600001)(8676002)(6666004)(66946007)(33656002)(38100700002)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aF8bFADsKLF3Yp8Zu6HdQKQm58k0f5GHdCOrLr3WeF1P72zKHTkHN620XGwz?=
 =?us-ascii?Q?k0PNaxZwcDlUqNVCjcSZQ8MCIwepQyT7cAXVdND7531Gfc+BWNJlGyhFAOzh?=
 =?us-ascii?Q?4BKl74pndMZS43dfSEN39/oDMNU3/W6wEvul2K22x1LXcUPgkuAkL1Mer/eu?=
 =?us-ascii?Q?UQoqC4RJh7gw9/fMMxlvUvdJvl3ke5BlQvMvaXlUD2qdTSPVizrunkPu+pks?=
 =?us-ascii?Q?6xpaAx3+tTsFjSs/9MyORf7jj++6Jn7ILZcAfSALMHOfwEXx98GSr+QyMdBT?=
 =?us-ascii?Q?OO0ghL0WtkC3FnbWJwS6/8HGlguoumSDJz7mRpXtgjWWOpkaQUMT76p5wG2U?=
 =?us-ascii?Q?HKmWOpzb3SkWTlliyEv9jiU9W3Y8nRjadnH6rAbDx/VLv2b6jFjEeMA6fFZ8?=
 =?us-ascii?Q?h2uxDvFvPpwflFy7/iSjSP8hJx+Rc9dw0HmSuzKi/x3ZNrNIKgN5cGHx2vQv?=
 =?us-ascii?Q?BguPSu2lYHGUzIODhUdMJloY7g6jm4WjkR8Wr2KU5wfFGq4b/tyCx5KkuVOw?=
 =?us-ascii?Q?scW1WGXJcPkDbPimap+gIrtcyTRmdFRnb76uaJJwSmq63ElrUelWgnoDj2sm?=
 =?us-ascii?Q?iogLIbfhOCwIvNfuK3eTDCCOdBiiukQWb8u/jLG+Wug+XWQ2EgtDGVgXsJ8y?=
 =?us-ascii?Q?24pPKiC0ubjR83CpKZ+tvdejupXnARfPsxdRTA4IeYwzJR9rM7YX8xG+MqWh?=
 =?us-ascii?Q?122nDwDaNgVQFK7dyXY8tYPwibsrqHs+Hf1sIZOpJb5uFT/eHb6UqS9UB0k0?=
 =?us-ascii?Q?OU1RCqzeHzfAkEYL7Lsk1set6lODUuNdVgHX9MujUFZYWIpFyNLMG+a43Zu2?=
 =?us-ascii?Q?jjwKZ9zZGH0qqnu0fZ5zcrqfiXGnKAyYsxpW/z7QAyhr6vMTKrdu7sRgxB9c?=
 =?us-ascii?Q?IgTRlTKj05y5ImRb5oxf8M90gMxjdF5pxeWWf/1cUCIaCH5OEN+k2wm7OIsu?=
 =?us-ascii?Q?qChDQOLNDVoNg3wEgiiZXPzxYjN8gW+0s6SDvSiUbks/eVWvbp9Ziq+G/AMN?=
 =?us-ascii?Q?NXYxZvtdTj7QbYmx8Eh5ozqMsxWVw6NK3wrdOlSgm5BoqtYnDfI8Dsbo5j2z?=
 =?us-ascii?Q?d9rmOOOB7njTIZbAGB6bxS8wt3DmsghCLWHZfZvG+wARWe0yCFsm5qkF3Z/x?=
 =?us-ascii?Q?suY32U3VaivJDe8Py6LhabM2VJpp/y2tiiDWsj/VCQmPWDfbGN0ewVqNIytN?=
 =?us-ascii?Q?TkgENFaph7505TeIyGU+f8i0dH2rhMzCr/bdvtjtGwnFxJFCX7Z1Rd8Yq8ek?=
 =?us-ascii?Q?Cj/yMeG703D0SvQaZFcmcbWXjjVugk7OAEosiKtubekyWyGjgqR6nmmaMCMP?=
 =?us-ascii?Q?NFLAUYEd1Jweq+dwGWw4JsJGqdtNle88/hCVOstZVWtc6N0QIGecsg+dpt61?=
 =?us-ascii?Q?f/YCxGV20YXVjE87+DY0/o8/IlGTqCoiawqfBUVosmHL6z5lBdxNYI5zRO92?=
 =?us-ascii?Q?vSzB/+ba3YcscaU34A/9p+yZEgkNt2a0KL1hJInCWTSFHINduF9rNyfDf3Oc?=
 =?us-ascii?Q?AE/R3Yn9T1iGV+yddQU7aM2GXB6R1SLwweq3MO7RXT+wL6uOBWXTCmpp8I1n?=
 =?us-ascii?Q?UoPQwt0XhkSCXgIavvEgHkGxpFaN+R+dcZjwzQSibYRDuAJ4HBml4p3JqAtx?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?yqVBS/i3uFHSF6hVnJ4yYYlvKL8ijl38OZvYUojLVUSopEX6eIIw5ssBiPFq?=
 =?us-ascii?Q?D5xBJ280CvkAEn4aZ1ZymfS6BM5P8AgTBx2mN94DTAXmxtrUGDVCBGKW3/Qk?=
 =?us-ascii?Q?ALE4iSyOL+9dh4YtcFg0QSZ6iWDRQvRrhd92zydOZJw9XbIcckYIbVIFWqfY?=
 =?us-ascii?Q?eZ6E0p1uFb55EaByr3ShnF7t/TBaZOSr6VA9GcDMNh4H13j+3kkUCUax4LsL?=
 =?us-ascii?Q?ZzWr0NGiMaSEaBUDe9arpop34mAmvkMJEAwDFMomxiKNWcOFp9WZDhXB69a/?=
 =?us-ascii?Q?sYAX+bkwNEa5frR0KuNfKayYZJFlgNsFwkneCZpHzr/XMk/s8/PQVVIyDOY7?=
 =?us-ascii?Q?1WZWIFlO+G3Nvdi73QkfqFfzz674PRYKT0xoV6YGmk2rAkyuUQYWQjGhIC0O?=
 =?us-ascii?Q?vtyf4vnNeqwYH0tmPQ6oDKQsnpP4ZOerEDqaOC2QERQQaKLf7Ts3TR/FuQ6Z?=
 =?us-ascii?Q?cLcIFWDGbWT+3VlbmR0dma4L4Tf8py9mKUtamkV2byLirusf0eiKPrHl495i?=
 =?us-ascii?Q?aM+Da4OfRuRT8f8VQwMyUArCO6kE2WTdmw4oiN3nClSBoKuG4jdgfiUQiyjm?=
 =?us-ascii?Q?0x50O2cq9T/JtfoW/8A1jZOZoDFZKfqWNTCX6/QIA+3R46QdK4FNS7NMZTIZ?=
 =?us-ascii?Q?y4NXw9ODUQVY6ci4+ZKWRyUGAafmx8noM+8S3yrqTDXendvE/WxC7nh8M4Je?=
 =?us-ascii?Q?2L0Ss/L81A3ricvGkUdggCgHqa/9fpq5PC4K6n6iDiBUcoeqAW3inYmsflB4?=
 =?us-ascii?Q?KaeH6iSj3JrRlJsw4EEYzIrQ5+dAEuGTAlf4cuV5ks00vg6ZAtydOKUvwZAk?=
 =?us-ascii?Q?qckcMf7tI+7mOPn5C6kLXVNwyHfvbksowZr8syBR3NsZsuXc2CnacoZQ3KKT?=
 =?us-ascii?Q?Am6IJrfJtwfDbG+YjZa1ZaBLS2oDwRaGo3xXH0VWNXhrLpOkZiSGOG4vlu7Q?=
 =?us-ascii?Q?XgpEmL7DSxqOdubFXJA4pJjSO/aHENcxo2eDBh0p+1G+Dl6H0f/Q8n3UG6sr?=
 =?us-ascii?Q?OS31gwmJj2OaXCVKAKQhXJ1aaTwnsk9co8dfjsBdZVGj4U9hE883KyLF4gFP?=
 =?us-ascii?Q?miGlXxT9il9aG8ebkYkoz7LdP6+TUdo+iP0LYI+G8snUDmid4CPSHK3ciM1e?=
 =?us-ascii?Q?KsF1LCeiAp4b/ItSb9AR52lGVLP3SXg6Sw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60086ad-86ac-494d-a4cb-08dbc9da3d32
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 21:45:37.1282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zt8lcCpcqxs2hmd1UIn4zqYPsVzuUjV9MeQpGn9C6ByCoOgJF+DGyPpH791u96P4OGOGyMk6zhW+Yz48Hjj6iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4299
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_17,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=983 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100169
X-Proofpoint-ORIG-GUID: Uc4st_M34mkvbV8tSM2h6XtOOJL5IDOk
X-Proofpoint-GUID: Uc4st_M34mkvbV8tSM2h6XtOOJL5IDOk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 23:30, Konrad Dybcio wrote:
> 
> 
> On 10/10/23 02:07, Andrew Morton wrote:
> > On Mon, 9 Oct 2023 08:15:13 -0700 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > 
> > > > This should also be empty and a noop.
> > > > 
> > > > Is it possible that the misaligned kernel image could make these lists
> > > > appear as non-empty?
> > > 
> > > Actually, just saw this:
> > > 
> > > https://lore.kernel.org/linux-mm/20231009145605.2150897-1-usama.arif@bytedance.com/
> > > 
> > > Will take a look, although as mentioned above prep_and_add_bootmem_folios on
> > > an empty list should be a noop.
> > 
> > Konrad, are you able to test Usama's patch?  Thanks.
> I legitimately spent a sad amount of time trying to regain access to the
> remote board farm. Previously I could hit the bug on SM8550, but now I can't
> do it on SM8450, SM8350 and SM8250 (previous gens), with the same config.. I
> have no idea when I'll be able to get access to SM8550 again.
> 
> I did test it on the QCM6490 Fairphone 5 that I initially reported this on,
> and neither booting next-20231010 (with your patchset applied) nor adding
> the below patch on top of it seems to work. I can't get serial output from
> this device though to find out what it's unhappy about :/

Sorry for causing you to spend so much time on this.

As mentioned in the reply to Usama's patch, the root cause seems to be
the locking.  So, the real change to test is the locking changes in
that thread; not Usama's patch.
-- 
Mike Kravetz
