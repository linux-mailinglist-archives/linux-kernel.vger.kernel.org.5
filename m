Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDE57AE1BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjIYWg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjIYWg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:36:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65CA9C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:36:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PLOOg0001745;
        Mon, 25 Sep 2023 22:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=fzSlIez99URvoPn2m1WhgUOTD3784jL0YTdsfPwKjFA=;
 b=PEnu01iTFRtK5bA5OLNzAL1Ji/LRt3Ll2LSM738ZK6W8xHhuDLI7/fcqC39AEIVtSKyo
 K7lABr1NlIaXQrA8kouCsePoIIVwcQR4zwXJ2FsbpqCm6UfAptodWiNnoM0p+ddfaJhC
 oJiLd2vA8WDy0aslBxQohun1qJpmtQ50/3Cxii0CW/+jlEe2sFfebw9GKr8gbonbYRIs
 az+QNCW8fG2JyJ/EmujJUVzpp+1VmCn7mcVq8oNOUO3w4waLcxNiXpkfJ2tpTIh/s4jF
 TOGh/MTTcudmnGJL3OcWawFtoE+eRrnUTqvsJNpMQYsSsh0uFGjEjyRnZ9DiXcXWJUvU yA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pt3n3t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 22:35:42 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38PLVKma030822;
        Mon, 25 Sep 2023 22:35:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfb8q7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Sep 2023 22:35:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4MKpcNrMleCuaD7dI3p4FS8hLZjIrxmxmmJMS5bAKFqOBn1xNQ1G8hzJ6cLHRIpl0/T3zGVcf4zAnfxxSPRAx0yX/DAAsczYjD9ZcWwV+CRvfRO8PYB1Erc8tGvwmFso+qDX49gyIgNWLzw/3EcIPCdZKkdxkLKoOVj9oOfv7X9gQkV1odDJWP2UYBK7CzRHEHTacj51H//2GeYieeHquiZ73oYbAjjSmqaBhEac0q1psRKTwswE1X6aYpvpSykUdyGxiMqYMvLkxINWB0SOhNlG3oDWHfL64ah7X9+i3OsXrtqUA16Kfu+GPPmF+lpiSQq1p92FstVv/hSILl9Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzSlIez99URvoPn2m1WhgUOTD3784jL0YTdsfPwKjFA=;
 b=Wur0tg5Bl0KGK3kDcoK/aoVppr2Z/gcPizQhHtpEBFbxqozuvUw6KUyA6gybkaxIZg8A/HhZdKGd/Pmw11Ehmc3RpXVsVlGmlAkFkOiLr6m2kEF9PZZJy8vuH6/ZDnbHIZB0mT1nhEGK9Rrgbp1JznYARGJQAbQZdPqmzz+lOChNnClV4tF3t7oEvNMHhzJdNV6y0Sh+MdbDzT7WHrWj3v2oTG2S5+YCzQM3myjHWTYplDu6V/zQ7iRsg4Osvs8sAC6O/UDGSUiDwQ23j8eHdIx0N2IJYqtPIHjc0xbwwloZhShDFl2V4uBZAtm2ZMdWzeDd5PAUpT9109XB8mzAbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzSlIez99URvoPn2m1WhgUOTD3784jL0YTdsfPwKjFA=;
 b=OWKQjklGfb4YYKZxouEyZnaM478VjfN3jliyBMD0b9aNxNNfq4twqTcWJYDn51/DkVg6nHvvMo/WPLf5grqRa0R3SWuI0XFxFCKT1PKZopOLv2Ip7IxVatmt1Po0vjwohVsCpW4Y3ugpTe38N1RiGmg1J0MCEvKCEMAsFxXzY0s=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA0PR10MB7601.namprd10.prod.outlook.com (2603:10b6:208:48e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 22:35:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 22:35:39 +0000
Date:   Mon, 25 Sep 2023 15:35:36 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Muchun Song <muchun.song@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 4/8] hugetlb: perform vmemmap restoration on a list of
 pages
Message-ID: <20230925223536.GA57727@monkey>
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
 <20230925003953.142620-5-mike.kravetz@oracle.com>
 <b271ec48-cc64-6cf7-d8af-395d0f7fdd1d@linux.dev>
 <20230925171242.GA11309@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925171242.GA11309@monkey>
X-ClientProxiedBy: MW4PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:303:8f::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA0PR10MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: b076e8de-2edb-4f60-d22e-08dbbe17bec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dTycE2VK2K+FX56zLgwhJsc5ONm5trs0sjp2h+bqLh+XRk6qQM+T042kYB3+w8WyPwzO4UEkWWesg7EjZatVG0dqONNEaYIq8D/XymiLidkEsfKO6pvmfk589lRUcBZnJ+9r4hjUV6jY5PSzxgdH+yml0PU8Fk576DCJtGS2/kWJFyCu2whIC5kT4rIHS8MKZsX8B1EZPYD1Aqy1Sb7wWc0g6xYyJ8eAMPgkL8CkTfSg6YheBUwpP5G1o6PVaU52uwJU+N4fNfy84B8usfTZgf3Q9kxVOTd8jLiGWYNH8+72Kx3J+utMxnd81xgAmfSsx7u8ddQ2mOH7HcLqXbbIgnQkoLjBLdvny1AO0zf8QfSew7XDxqUEaOq5giCbc36p7kUt6+M7Dyy8/XeKWTJv4wZUXBssiX2f3hsiQLr8b3oPvt3E+UAmrAiwKAXgq66ZrzPTKMADLbEzd/q20myY1pn6gN0vBzHPCtQ+OQCzcgeLujr9MivOylwThYXDYIigHs1PBv+1ooxZFS4biCMkbs0PUvFzJWNgGwj6qCLtBIwQCes+DmjXYEjyLMl39GU2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(186009)(8936002)(8676002)(4326008)(26005)(2906002)(44832011)(478600001)(66476007)(7416002)(41300700001)(66556008)(316002)(6916009)(54906003)(66946007)(5660300002)(6486002)(6506007)(6666004)(53546011)(6512007)(9686003)(1076003)(33716001)(83380400001)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mhcJBqeUXJWxNUYmjC2igwMIRjZh4J91XUFY/+1nfaHSUoV6pabtzeENWXEW?=
 =?us-ascii?Q?ol9entsORXABiWLjLXRa2D5Mpm8n50aLvhKkRzbtp2RC67ZGhjBpPl64m9mx?=
 =?us-ascii?Q?5c+NDc5NzB15/j6ywCeb5qPBcnocItYVjvzCFoJgxxtCiZ9r7XjlU2gYG5nJ?=
 =?us-ascii?Q?Ba3+gxpJj/yTQezfSpI2y8WX3wtpXERJ/wUOC+qH7SH5sF/NPp/ZfDZz1Dcs?=
 =?us-ascii?Q?g9/8YetgEQULiMZup37Rh5bDCQuthLuEsemY5JPkByKe3t6h3RWZAT/MHAah?=
 =?us-ascii?Q?yHtbJ3LPiV4V9MixbyYSpCR++m7pw8VF+UiaTpxy9BXWBIif6+tJcoQOdjr8?=
 =?us-ascii?Q?IBHZ2IDghGAgNP6tRi+LqrxtqjteleiQvY0+WvJnEDKoTIGqIBlXzwu+gpGA?=
 =?us-ascii?Q?l9GGOW7yaxTPUmW9bZeqme3QSarqenvGqETEqpTOFv9CyMWcZgPe1mq6Dr3X?=
 =?us-ascii?Q?DyNaa6JbR2q8YJphnMpbewZb0mc8slN61xot7WLHTnNYEuL9ZSm5/nYFIEcm?=
 =?us-ascii?Q?+lrTz6FDcpZR6KzGH/1tgP/9xbWhbgEbjgeLfnUhpq0CuU3W2KSH2xOwiESN?=
 =?us-ascii?Q?zPw0qyLmXf3RlXlpCf+UKRg+cHlJKzYdeLoy2YmShBvyRn6/2dn+9Wi54Qz0?=
 =?us-ascii?Q?3fHXP+XL6QZ7PD62+8oJHKrZMQoACZ1XG8LfZ+u6UY2H9Y3AgsE1INRlph50?=
 =?us-ascii?Q?d2FwDK8YAHDxuZTHVFo9//+0guRgEv/uY1LlANWnIzSg+fbHnaJh6kVMtgwv?=
 =?us-ascii?Q?DOrLxNAbcnGzqK2z3kQEwUcUKo1+PaHarQLRa2R7ji0O2PhJy721W6C27cqE?=
 =?us-ascii?Q?+E4TRNcvN8ZWaWswaSE0Jra40CwkhggzkFUYJfZoDL9Lcpj1ZaG3fF+h4Fyv?=
 =?us-ascii?Q?fX9+jqGAxiKwrfCmHsJtnK23fMjMVjy+5pJgO9/5bvOsBMvBkmucU0MUK1Is?=
 =?us-ascii?Q?CW644OubERQduUtyeiwOxRt7fW4/MjOgrKdJgaIHDFqRow/Wqkc31kcMeAxR?=
 =?us-ascii?Q?n9PNqECEy+V3Jxdi1Li2xiOlTu3srJqYQ5Rva+eKvELyVckqI0458YUwSyEx?=
 =?us-ascii?Q?md+4ud607NIYVFtNKaS1ypGakjS+3/Ynz9Eo/wMRdRqyuPIJaJJ/ohwog0p+?=
 =?us-ascii?Q?aYRofjAbe23rpquC+YuWQ/dXc7t58/GkURXwOJqDGeZj9bSiFKoTszeGew2K?=
 =?us-ascii?Q?MKS8uZGLyInfozd/CJn1kq9RNY2iX/FDiZ9Ng2UDHWagmTUdrxrkwFCCk6EJ?=
 =?us-ascii?Q?tAr1P3dLkMffqbipLrSVRiIA1dcNjHz1wuiYZVGKMLR3jJrm59bxK4BNRN7c?=
 =?us-ascii?Q?mC3cBRbiUhUian3rQyZZk0qmXR9/rPqTfU+M56L9LGQq2X35dTvkhd6OK5+Y?=
 =?us-ascii?Q?qsQoP1BeQNz127tpHmSP5b3d9IJlG+4jswdqajA364RkF5SUv6kddRsyZzjx?=
 =?us-ascii?Q?tw/lO839bUHzpYLX1XRgIEVHIDpyrLLjhfa25Pzmif56cmv2GpCAtndKOYWS?=
 =?us-ascii?Q?BVNEOEni0m2LZyTNaAvte7IlJ6VMUTJ24Zw8+qKBAp2W71E/hbP49VPYCiHa?=
 =?us-ascii?Q?76IVQL57r4am9fjc/zvKS0owOBmz3CEIv6/jiFUgy4qTM+27C4ooPOcQof23?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?9TknA/b0KIjm9pL16r242exPGL3iQB05SQMpWRiat/AWU/ZAkY3wcf+Z8GPO?=
 =?us-ascii?Q?zcw2J/AE571LtffWbo1j1UsWrHvy3wUHtwAxmXe4BZFxaN1TUQ+mEbOHmS6k?=
 =?us-ascii?Q?iJRseOB1vWTVn6BDIZgH4Q0sDoKA2YQErHDb3NqKqoW7nXapk1TFRJpM6O8y?=
 =?us-ascii?Q?i1qZzxjAAk68yMjOK+4NMhMGMKA2nbU0b4oHw1nJ+Cp51Afuq2PTL89cy2TN?=
 =?us-ascii?Q?gj2gESuDEqDjTV0DfAchOtmFTRfciq7NdbeAQo9b3cMb/t9EAyECBKNLgUX9?=
 =?us-ascii?Q?3awHv6UGzsquizAuUheNmRxZ+7KEmnDk/R80WjQa1htMD/6c7oHGvwphD39a?=
 =?us-ascii?Q?kWW6yQirro6YvxrJ0q57IYiwwJ2mWhAaQCFCNZknpLjXY7jfIfRToqjRjGMz?=
 =?us-ascii?Q?4LEZ2VNx/+M0dH0J7N6Iqi6+jpAHmZs/YinGpGZb2PnAbo0L1CfRG4O97SZ8?=
 =?us-ascii?Q?tDizjBbHORX27O345/OSwdbv3KL58lTliErmEnWlf9Kez5hK6JfCm/fl6EXp?=
 =?us-ascii?Q?VVpctsrRdHM/CEvh2zJDpjvx8fEjv9/Quuq4dpJN4R28l0uLmqQSY/EqFwSj?=
 =?us-ascii?Q?IOUvalMTY5HMtm12aCN5zTv0sJjQn8lHF7iTn6bqPA+3rKNStqmkOsYo1WVg?=
 =?us-ascii?Q?yiPWzYZgaHJ3Ow85LvzQ3/TTEUTWoLEJBljcEQz0HkMauLQJe5sl73S8vai6?=
 =?us-ascii?Q?lRkN49L4JLZpqwPD9iR75JPJ/zz9t2CvtQetqup0TjRUZ+lUrD+z+cBozFd+?=
 =?us-ascii?Q?Ko15nLbS95C3NDugpPxCTK98inpn/Igkj+3KNP1N/VvfW6ti9lMJJzC9NtRH?=
 =?us-ascii?Q?9B6cBXZo8imwvOtOtw0v2FmyqPVDdkpSXqvfN1PyUI5CebaRZ4SYgyEECnnm?=
 =?us-ascii?Q?HyQwNwC7qDTiFCAhPegg+MztF/9fd6YcfaDvsF1sehOcn8ogcydecqNwO/A9?=
 =?us-ascii?Q?kHfhUy1z8aTripqcI5jRBP0SOqgLh3KhCcnaOec+ZMIrn7wujRrii3Im1QNI?=
 =?us-ascii?Q?N77cavjoqGQQSZkaM0g9QSNhEOyCaqnEe6JSDXkqNbQmyybRJwTvdJRoDtl+?=
 =?us-ascii?Q?IbyXQwtoSYYuMMd2JwP+vuSQnJAypnhJTWviVRL6iPyXkyyA5LaOFXn01hVT?=
 =?us-ascii?Q?A9d8rog/v6mv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b076e8de-2edb-4f60-d22e-08dbbe17bec9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 22:35:39.9305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FJH9IC2XAO/tFVtN0T8VkI8EkmFNlSyjudnfmkX4OJjBuN6s1jCCHwfWaS4MibvSLFoX6k+thFT0MvJPqMUkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7601
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_18,2023-09-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309250174
X-Proofpoint-ORIG-GUID: B-f2mrj19SdcTVP0gGdYJcOZk-tKtGlJ
X-Proofpoint-GUID: B-f2mrj19SdcTVP0gGdYJcOZk-tKtGlJ
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/25/23 10:12, Mike Kravetz wrote:
> On 09/25/23 21:54, Muchun Song wrote:
> > 
> > 
> > On 2023/9/25 08:39, Mike Kravetz wrote:
> > > The routine update_and_free_pages_bulk already performs vmemmap
> > > restoration on the list of hugetlb pages in a separate step.  In
> > > preparation for more functionality to be added in this step, create a
> > > new routine hugetlb_vmemmap_restore_folios() that will restore
> > > vmemmap for a list of folios.
> > > 
> > > This new routine must provide sufficient feedback about errors and
> > > actual restoration performed so that update_and_free_pages_bulk can
> > > perform optimally.
> > > 
> > > Special care must be taken when encountering an error from
> > > hugetlb_vmemmap_restore_folios.  We want to continue making as much
> > > forward progress as possible.  A new routine bulk_vmemmap_restore_error
> > > handles this specific situation.
> > > 
> > > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > > ---
> > >   mm/hugetlb.c         | 98 +++++++++++++++++++++++++++++++-------------
> > >   mm/hugetlb_vmemmap.c | 38 +++++++++++++++++
> > >   mm/hugetlb_vmemmap.h | 10 +++++
> > >   3 files changed, 118 insertions(+), 28 deletions(-)
> > > 
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index da0ebd370b5f..53df35fbc3f2 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -1834,50 +1834,92 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
> > >   		schedule_work(&free_hpage_work);
> > >   }
> > > -static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> > > +static void bulk_vmemmap_restore_error(struct hstate *h,
> > > +					struct list_head *folio_list,
> > > +					struct list_head *non_hvo_folios)
> > >   {
> > >   	struct folio *folio, *t_folio;
> > > -	bool clear_dtor = false;
> > > -	/*
> > > -	 * First allocate required vmemmmap (if necessary) for all folios on
> > > -	 * list.  If vmemmap can not be allocated, we can not free folio to
> > > -	 * lower level allocator, so add back as hugetlb surplus page.
> > > -	 * add_hugetlb_folio() removes the page from THIS list.
> > > -	 * Use clear_dtor to note if vmemmap was successfully allocated for
> > > -	 * ANY page on the list.
> > > -	 */
> > > -	list_for_each_entry_safe(folio, t_folio, list, lru) {
> > > -		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> > > +	if (!list_empty(non_hvo_folios)) {
> > > +		/*
> > > +		 * Free any restored hugetlb pages so that restore of the
> > > +		 * entire list can be retried.
> > > +		 * The idea is that in the common case of ENOMEM errors freeing
> > > +		 * hugetlb pages with vmemmap we will free up memory so that we
> > > +		 * can allocate vmemmap for more hugetlb pages.
> > > +		 */
> > > +		list_for_each_entry_safe(folio, t_folio, non_hvo_folios, lru) {
> > > +			list_del(&folio->lru);
> > > +			spin_lock_irq(&hugetlb_lock);
> > > +			__clear_hugetlb_destructor(h, folio);
> > > +			spin_unlock_irq(&hugetlb_lock);
> > > +			update_and_free_hugetlb_folio(h, folio, false);
> > > +			cond_resched();
> > > +		}
> > > +	} else {
> > > +		/*
> > > +		 * In the case where there are no folios which can be
> > > +		 * immediately freed, we loop through the list trying to restore
> > > +		 * vmemmap individually in the hope that someone elsewhere may
> > > +		 * have done something to cause success (such as freeing some
> > > +		 * memory).  If unable to restore a hugetlb page, the hugetlb
> > > +		 * page is made a surplus page and removed from the list.
> > > +		 * If are able to restore vmemmap and free one hugetlb page, we
> > > +		 * quit processing the list to retry the bulk operation.
> > > +		 */
> > > +		list_for_each_entry_safe(folio, t_folio, folio_list, lru)
> > >   			if (hugetlb_vmemmap_restore(h, &folio->page)) {
> > 
> > IIUC, the folio should be deleted from the folio list since this
> > huge page will be added to the free list (the list is corrupted),
> > right?
> 
> Good catch!  Yes, we should remove from the list here.
> 
> I did exercise this specific code path and there was no list corruption.  In
> any case, I will add the list_del().

Correction.  My testing with simulated errors took the else branch here.

-- 
Mike Kravetz
