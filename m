Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329427A6CF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 23:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjISVdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 17:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjISVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 17:33:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92179AF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 14:33:09 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38JKgbsP018515;
        Tue, 19 Sep 2023 21:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=mrFjzdXbPTYvyH8r2Jk869sPlCo/XjY9vpS20yH4az8=;
 b=U8ZsnK8g5UnFBoyNIMsN72uuf5fij7dsNNIOV2V978jGGglSlIB0fiXOrnI3JRnkJURL
 mDgrRN37Z5C1EoJeDf9PobZ0P+ZEyjqjTPnwMtx2OJdfoB5Lr/0I2zaKAqnE5JKiuSbe
 0wHIZWIpjDtwy5hvC8SrbwTjf/xEsLfJ/VhsEN8CCARhA96HzlYZoBiPzZJnLd1Ot9e0
 cAoQGaZStf9h20PqtZa4M4aydaFt2KoF4tgC0GhMbfW3xs+Tn/RCLB/r8FnDE1d+7l9g
 8A1usQSQOTb8zmWfGdcYRpWAS2YcIpoA92X5Pl14GLnQ1fJwFk8ZOqRmuKiQkjrHoZ3l Zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t53yu5x24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 21:32:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38JLU1Rb030051;
        Tue, 19 Sep 2023 21:32:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t67qg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Sep 2023 21:32:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4XXj9MGrNKlyi5hSAkFKKSFLBuq8wmsBQh5q087Zd9NUc+V5mGa1QSodXuZPvye4zS/Kl89e2OysaDUrofiNKCZUjuY0ytvL48AjB7LSmlXBcgqNHY0+EofjvN8UnxTSEZ+r5eiYHTaPERv623Qu9m8/6yGB1NYnFQf14jUMfnhBqvbjaN8uieAXAP7wCQLLZSAzdxrqh3EoUgFGSgugX0EuSN8rMYNf61fdzhOozACj0iNbvNymSUcC7K7Q9bVLSn6Bq3NMnFrUBHnG8Lvq3moaVXjbobLiw4Ul+Uhqd3qUnHMAyIOfvxX4ii5f1wDW1R/tHfviM7eUwvkycbOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrFjzdXbPTYvyH8r2Jk869sPlCo/XjY9vpS20yH4az8=;
 b=lgEWvF/2ZEmiYfg+hQpYDZKO8PrpyzJr7dfjXuXvT5zlqWyMTC2EjFIx54W5sU/6tq5x7nmgI8SrYRolVRmA0zKYS/IauYN8ReWiV3mVA5kP8sx0PhcpuVtnURI+Me3afnCQ8WIUXEDjyh0QmVb/LJ3WPeTi7JG96sI/D0kYzTE7AObiZeUiJCmrnqgMD+J4/rVzf1jagVjb6Bk4cVTX9qxiHVrcKZqLTyWa+0xQRuu5Ds0NyYnKRCGuSgy5MzkWyWlEwoevSBWMIk0etgg12eEqUpFqvFyM5Nfyasv40Ox7boSmBxrMEzT+0vS1SlvljiJOs/l/TucDPBBTVnGBGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrFjzdXbPTYvyH8r2Jk869sPlCo/XjY9vpS20yH4az8=;
 b=aGwlt2Op21ZusVBsjJIYsdTwJ3EI5Fe+EyZnpPj0wCvFj+OFt+0OG0Mus7YceIRR3BcwEwCConv8B8M1zn8obOwZ4BxfApvthSOOwnCZPxXRapo8/lIdctqNlFas372aIlct/CXUWyRZ62GOjB1QCBrEO53xBN2/yUts6KwXUv4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW6PR10MB7549.namprd10.prod.outlook.com (2603:10b6:303:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Tue, 19 Sep
 2023 21:32:28 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::c621:12ca:ba40:9054%5]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 21:32:28 +0000
Date:   Tue, 19 Sep 2023 14:32:25 -0700
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
Subject: Re: [PATCH v4 5/8] hugetlb: batch freeing of vmemmap pages
Message-ID: <20230919213225.GC425719@monkey>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-6-mike.kravetz@oracle.com>
 <9a716de0-91c3-5f29-4f88-391b9aaeb5ce@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a716de0-91c3-5f29-4f88-391b9aaeb5ce@linux.dev>
X-ClientProxiedBy: MW4PR03CA0076.namprd03.prod.outlook.com
 (2603:10b6:303:b6::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW6PR10MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 09db1f95-8d4d-4021-7d78-08dbb957eca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwNyDp28hQwq8bzB6JYSWpUbqXBG2MtS3rRiyohsSMFARHL/ZQ5RncmY6c5j9o7ahrwkgKjDVSev+sZ/VEuKUyI1i6h3L7lki8e1JFxGKtk+SvlS5Aapv9yD7F2HZkp1fSAn7bv1qJRuLLX+NUgjH4f6KW6cHEnsXX9AvsnfHf+LO0yGJcq8j4rLOCARnXfe6COBGxd+GIdsTjlhdbUDhNY87PXBBEPApR9F2ZNMbT9ZOiFojqgxIhXq6rmL2crC7Kv+WK/2tsCCcUHkiVyyxyGtC9b1UdAtDyErJaCMLOuznEJDPHFDytU2oy0FXRQeZDhLDSQfxXbjvil1isDqAWaGUw/hHmP83hi6DUOmtI65155wExkHvOXqs3Bxgr96hWhY/Mi7IJtdT9xFHrvFQcF+05WpT1JikaUN97a7YIWoJWGvZb986EuAUGjycq6qIrM0Ioxjmwn30SW1NvRoUzFEm91P98pXfB/uLMI1KlDjzguKXQhb4Iajx6zdVeyXibTjd4nPcvz00h87tkFSFgNOgPGDSWIP3mU9WEX306Gnqx+YGDTWt1sN3NKH6hB6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(39860400002)(136003)(376002)(366004)(186009)(451199024)(1800799009)(9686003)(6506007)(6512007)(6666004)(53546011)(83380400001)(478600001)(26005)(6486002)(4326008)(7416002)(5660300002)(2906002)(33716001)(66946007)(66476007)(66556008)(8676002)(54906003)(41300700001)(44832011)(8936002)(6916009)(316002)(1076003)(33656002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?13s7fl7f5szNNb1ItwytGU5kwc7Gg5zZrzXG7Wb3CPr16hDfW6uThP2ou+V4?=
 =?us-ascii?Q?6GGMzW2tgmssC1p6M3kWMJW9FDAJShn2Lx/3WwfN7aBknHkiurxwqZ/4XXUw?=
 =?us-ascii?Q?hYzHG444BikdyCC6QKLMV9XGY6YUw6SVQH5TkSe99R2PkcAQUb3S4kc62IqN?=
 =?us-ascii?Q?VPbrIMX7WJJUOPNO5WcFjU2+smyzjeJ2AcUeCKHL9PN0wTDhXuipzGHRShQF?=
 =?us-ascii?Q?bCosoRW/o+cUWo87thc/P+lJGb9Hh6Q4zeFWqyR+4a2ZLNpeAgGGF2ZALWTH?=
 =?us-ascii?Q?uUbM4ZE95K2UBmDer9vlbEYdN34VsAUZ7S3pHSUENRQ+NBUkODI+WVYCZau8?=
 =?us-ascii?Q?i7CHQTSz6aX3yQkMppAPFVmTWstO2Bwqg6KrhJEIF1+OH/9yNI6Wr2Fz4UjO?=
 =?us-ascii?Q?blHKdKNfuoiHt+75JaYMvUkGu0HgtMqq9jlwgxfbuBR41Hz0ywf6OBZ8seE2?=
 =?us-ascii?Q?UlwzQWNYCtBmsA7Abf/VUR6vr6V9lPr/WycSvVde4+LcV+r1+uB5KlyBVwzD?=
 =?us-ascii?Q?OLS6pwvLzf+B9Ykt6bCofwYfItknunDXoYwNNUyfKrZ4q9W4WPMgOtY/bOzf?=
 =?us-ascii?Q?Ou8IWK6+tONoVDg2xZkLPLooZuYbMsZ3W4aI35F47h5jVddfKH4mKSYXXUmI?=
 =?us-ascii?Q?Pc6gVPstpKfyah289xhMpBBJ1JLpJ/YtEjoihiy8nTpvT2mGi1KWtt9q07nS?=
 =?us-ascii?Q?s5nb6tbZAokaRc4jmyQDFipjBhJHzk3AKcW62tM/GnkxPFZXRjNHF4LWVt3X?=
 =?us-ascii?Q?eL2DVkafvEbS5jp4AxHeGVxfs06R9Le5nsFh6fnrtQgQNzsn7FukucA5LUOj?=
 =?us-ascii?Q?F/H8+ANH8hpIzwzttW4f1b7cW5H3KDgvZki4d6a136gNqfLUbhTUaXGW4eYw?=
 =?us-ascii?Q?TudojbF0khoR6nCP8u0nm8UEUfSA34z1RBkEcQbWywJWHXIkjEFY2FN35ILL?=
 =?us-ascii?Q?DQDFeIXrzGV16+QUxGP3pvtDtojUt5BasK2ldtZitaB0YqYMj+SL67++vAzB?=
 =?us-ascii?Q?595OFTM5k8RcArizuOoYVsJRnCMLzRgFpAoEt0vw1/nPeEn+mpbgAlJPsw5H?=
 =?us-ascii?Q?D19+n77UvvtIkyNNc0U7EIS+CZ8RfOvRUEqbfYSHkXF+rd4tZHvEBM+BDgD4?=
 =?us-ascii?Q?VaykJdd1z2xmtcM8TWFQDVdmhpl4W+7OpJKHxvlU3WKub/mfQKflRidKkz6W?=
 =?us-ascii?Q?4e8vHROrolE1Xh8zIg3siDkqiTXpUUFm7AhpYCNZsjYdJMXSTJ7+f9RDGWcs?=
 =?us-ascii?Q?T6whNPAjr5AwTnWQp8oNGXzmcjiZky0dhQoKLG1XEBVUTvGfBxyDAoKlfG1v?=
 =?us-ascii?Q?15WlQbGsB2jjWovtSUqNGFVbTwrhZ5mRGXe+IRZ9BqQUJ9w/kdouFnwunZET?=
 =?us-ascii?Q?hVknkkPwpgPBK57ua9emDz9AIgXa4dOg2l29obTItdF8M8BR6bzqag2JB0Eo?=
 =?us-ascii?Q?31Gn9/cVqkaLQceMz8hXt+KYmU60OsCMg3Sma6+HHKIl78Q53RNK2CzJ0kxc?=
 =?us-ascii?Q?35VhrjmnYfZ3m5XJ07WON1knjS9fTXMbvUsZysENgcc9se9/HAo1oSaHOhnY?=
 =?us-ascii?Q?DowndPPsmPQK9L3uUAl9bhYxFNuTuWV4y9wPV4MPBntdS0OKnQ4loRYSXIsa?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?MnUmcjgdhiy23sYtNW9FLhFW8OipDYg1OlniNfatginUPYhfnXQemFFnKhSo?=
 =?us-ascii?Q?ido7sx/KimIvmjyoH6FWtWvYvA03rQvygG+YBd85kNbET879uDTOFz6lafK9?=
 =?us-ascii?Q?kuLruuXptIWjk2VGIoPvYfRtWmcbzc/6P0vxSfGEqlRIUwd9nqLTdJyt+iKQ?=
 =?us-ascii?Q?inGbDBBYn11U+aMqR2dKq2r/juvsOYvLcOv7C5Ywwus0UYHD1e2/yOJ+87M8?=
 =?us-ascii?Q?8uDBj4I5BkY8BN/RNffblhK0zcvshb5onUmIJNmn1TDFX92XQh8eY38Eb75V?=
 =?us-ascii?Q?bZLtMJHKgP83EGnkzXdbwoh6T/cfUHYzerOqW1tWMChTd4aUqH3g/cDijhOA?=
 =?us-ascii?Q?Vr2dGYvCD+1NMPp/06s0LaqT/oe/GdEAi6jV4mpSJtEZlmKJOgQ7xR7ExDLx?=
 =?us-ascii?Q?58nrVMlicVS4io8PVfdXNdsSWFBg0s6GE9jz40qef5HUTpD5UHcKUpqV4e3q?=
 =?us-ascii?Q?DsALlQ5fAYePYsEPh0hKsha9CdHY00ImSC4ooIPaa06Q9AmPw1L4r1HWYpQy?=
 =?us-ascii?Q?BjaSTjoP7lqVOHcTn5cyJne1FcojMT5DVZAaCuxAWFq+uDKYEQ2ZosBkofDz?=
 =?us-ascii?Q?G2rSoR9nKBqM0tMbD+eYv+maTWSg8m8jTJsRPiTom67ikTA7koBCJmo89Y8c?=
 =?us-ascii?Q?G68a2C32OLTIqp/K/SDxR5f5233GDcSEyO5EA6udcnQaB5QReBzMoB3NhONI?=
 =?us-ascii?Q?LcsFWlI3l6o5yDP2zPpIfS52zrwvSZdj2jLAzauyf368d8adzGqwn0PwZg1R?=
 =?us-ascii?Q?qAy0KNhfeasI4gzps3ohldww22RXadEd1B/gkuEbyAugRUKECDUpp01x4qNV?=
 =?us-ascii?Q?fgecWXKBdDLhT+/NmH2e8dyDPUv3dJ5KPdvzppmDIdAzqgmu2VMh0Map/2yy?=
 =?us-ascii?Q?gOn/cnQTytooUoSbAo6vcMqX8afYMrW6V7Q2lyzPuKCYQHj7THifOujCL1BO?=
 =?us-ascii?Q?/FDlQff5ESpFzwua+bZA7qIQ8x2JxdF0UOEX+FNjd+4/htzzESshsCmbF/A9?=
 =?us-ascii?Q?FVot9HPRqrJRL7b9r24B4ZSCeMOLW4XyhPavzdyGz5ImuB7RI1XU6MlDtnoq?=
 =?us-ascii?Q?eZiS26T0ev3+z6LVUkkSafrAhm4Kmen7KzF5R58yW+l//fKZQANWhRhYbeWu?=
 =?us-ascii?Q?fWvGKDvvqqJB?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09db1f95-8d4d-4021-7d78-08dbb957eca3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 21:32:28.8194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faq3aZENbz80spT0XJZ+LLX/MUKGhrqVR0U3LTdGgVpBS4zcNwpGgEfjOcTcDC0j17x3HCjYYWfBhMa1d3iLIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-19_12,2023-09-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309190183
X-Proofpoint-GUID: J_vn-9MfJdp6xD82v6eHonKF2cZVrDVW
X-Proofpoint-ORIG-GUID: J_vn-9MfJdp6xD82v6eHonKF2cZVrDVW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/19/23 14:09, Muchun Song wrote:
> 
> 
> On 2023/9/19 07:01, Mike Kravetz wrote:
> > Now that batching of hugetlb vmemmap optimization processing is possible,
> > batch the freeing of vmemmap pages.  When freeing vmemmap pages for a
> > hugetlb page, we add them to a list that is freed after the entire batch
> > has been processed.
> > 
> > This enhances the ability to return contiguous ranges of memory to the
> > low level allocators.
> > 
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> One nit bellow.
> 
> > ---
> >   mm/hugetlb_vmemmap.c | 85 ++++++++++++++++++++++++++++++--------------
> >   1 file changed, 59 insertions(+), 26 deletions(-)
> > 
> > diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> > index 463a4037ec6e..147ed15bcae4 100644
> > --- a/mm/hugetlb_vmemmap.c
> > +++ b/mm/hugetlb_vmemmap.c
> > @@ -222,6 +222,9 @@ static void free_vmemmap_page_list(struct list_head *list)
> >   {
> >   	struct page *page, *next;
> > +	if (list_empty(list))
> > +		return;
> 
> It seems unnecessary since the following "list_for_each_entry_safe"
> could handle empty-list case. Right?
> 

Yes, it is an over-optimization that is not really necessary.
I will remove it.

-- 
Mike Kravetz
