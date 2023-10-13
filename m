Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F227C8F88
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 23:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjJMVpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 17:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJMVpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 17:45:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C967B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 14:45:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DLIoDD012474;
        Fri, 13 Oct 2023 21:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=ykMYXH02FaCbu5FyxMiYPVEFX83g0yQ12T0tGpKOMSg=;
 b=dc15Y2Mrx/C7els6zoPtUKQRHvRWvGTLUf0dAoHCOBuIzvgF9TKkCfH88c/VmYX3s8Bh
 LLBfX+bHLVJGIq31VSjDUecExp20GCZllkj5sZcgbnpTLFgPqergXUM9n/dhKJWFAhhi
 /ZcLJdD8bs33NfxYN0SDVNe+hz/P/GipCC2NZtoQEvk95xLu+LRk6qXCs7SusrTYS/oC
 J35fp1O6F7jChAvy9PJHrOpDjMMcToNY9irqIhTqBXa2/forJ2jD8PIq1uiEKKSNVb3A
 Cfb/tYEYX3bkzBVyCFYRnu9siw8JrCd4v2A3B02AwjW02YLKo+jF4hu4nTXHzJ1n30Nr 9g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43wyre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 21:44:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DKtfci006094;
        Fri, 13 Oct 2023 21:44:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tptct0rs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 21:44:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9BcqDFLbgople0QBI9WlV5idJmUsS5zMKn5fmhMEfUFHFkAklymYFs3IsANvb8Xi2hu8EvkDWr42FqtNoUxsdEfLSBerTUd7YVB+Ljxgv662owrBkd2X8Mh8wq7BcMIHQQJlgiXKIocV8HsRsKdfyD/dDKIArJn9GHzwq7SfOYDUKpFNHp6kNll+dR+oMKs5bHh3/nWpoXnFQfHOXx/lHE7iinz6dFFQ4PpgqiPhusyKK0/Ud8gq67Zm4AAITMUXKSPc82lcAydY4euPrixuSRYCyQbLkVc4LciLQP270RXJadpwXVXhAQ+lTLoXl5eIxyCp+KuQ+EcvOcRzi0OCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykMYXH02FaCbu5FyxMiYPVEFX83g0yQ12T0tGpKOMSg=;
 b=esyvGQqyoHu29u1NOSH59lJEx7l1aWb65yFbquhcv8X4EHdNLjskcvU+92Hf8hCkfkD2WXABIJvs7HZCRkE51jemWbYis3qT57j1Uganl7umUubjhuzqPVpgI1GjQ8Udi03MxrvH2ep+ZVIQryGexEO59XoqKmrNULEiVlKOV5j+nEdo0B3kGbW3LCFrv6QlIb1WfM1DpO2Ie6QpN2WWUBdaR5bgelxDjqpklEICstahd04SN6tL1rZTUT1yElFrQIgdwYAouI422+XDTaOBjNxvJ1nkhqfIYeiPXJtpS1YvHV92RAXGWZXOk7RMyUPgHMpSaHF0JoP8cZvVWfivTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykMYXH02FaCbu5FyxMiYPVEFX83g0yQ12T0tGpKOMSg=;
 b=YD6+6zfsKDgsvYvUF16WhzJauHiOOszauWBI/ly3e47FNSNorUWoY+B+5ekf0+9wnaJNBMQoDw2M9t3QOL7YBr/NElqVqLcPfnjnMjZcJy/K0YXutSTN+lizoPxx3faa8OEw0ewgeNjJ4T8AjqUpm38fy9M2gljvuLqllCJynXM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB5794.namprd10.prod.outlook.com (2603:10b6:510:f4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Fri, 13 Oct
 2023 21:43:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Fri, 13 Oct 2023
 21:43:59 +0000
Date:   Fri, 13 Oct 2023 14:43:56 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Subject: Re: [PATCH v2 01/11] hugetlb: set hugetlb page flag before
 optimizing vmemmap
Message-ID: <20231013214356.GA245341@monkey>
References: <20230905214412.89152-1-mike.kravetz@oracle.com>
 <20230905214412.89152-2-mike.kravetz@oracle.com>
 <20231013125856.GA636971@u2004>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013125856.GA636971@u2004>
X-ClientProxiedBy: MW3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:303:2b::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB5794:EE_
X-MS-Office365-Filtering-Correlation-Id: 40606df6-f73e-4b2a-0bff-08dbcc358243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztvigTdqfO8W27yP4tisWYwRQq/BzVoktAsnUjrZIHGBA2P73/e7a7mw02pyxndAJ7sMgpyd6zfqFxKn5+9JywAyIe+TViVvspc7BH/+DAhtshmjdf4plKNOu0FY77NtWKE8NnUmTCBCBJsA3RZFmAGBCzgwrroumSzq1amhi4e4Rsn+wA8ocsJJxQBOlQGLLVXgCLYEmksb5zcd9LmpuPrJF1b2lBh9W7/1i4AIK8ptFNGP6G4f8XJtS2ik/nd+R1k08d12oh1pNPT0Os1fce5vpvdjA2rLAAeNPwih776H392jqDIZWucSWzBe0TGftwhb33A+civj4Okon1/tm0iZJR4XCSJG9lQ0oSHRqO2vNpN9nxi9ufhoOyC9BX3fKIoo+XoPIHeyX5lRmdM7/PAxezov/Medeh4nfiFNTWQogV9zTpBL00Qv6KcVLy7iHa2WPU1QXM3TaH1C3V+UU04gJ/svUj3j6skR2rHVHQNws6z/v5tx224gA7z7cBCrfg42E4Sp8qTkBLlpG7vWgo2/aJ36WMfrm/3zI08PwfRU0YWQtJ90NG806j9f3v37
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(110136005)(316002)(66556008)(54906003)(38100700002)(6486002)(41300700001)(5660300002)(44832011)(7416002)(66476007)(8936002)(4326008)(8676002)(66946007)(53546011)(1076003)(86362001)(33656002)(6506007)(2906002)(83380400001)(6512007)(9686003)(6666004)(26005)(478600001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?49wHEbTb1XOJ3PQmI3n/Vr4Y7oIZnK5iPIYZMcT/IP6kCqeDQJRk8OQwI/Ol?=
 =?us-ascii?Q?gIRBmNJNWT6+TeufFzSPx3no/RUoDTw+q5cuX9vOqlEiaaRHGqR7DwFw99U4?=
 =?us-ascii?Q?hDiOhzk1Fv/YpqzSY8E00sBSzimbYHt8ODwHTrZGrgkw/CM9+OcivK6fpCnF?=
 =?us-ascii?Q?VlTJENq2iqGgQzSLkwzutF54ioj9jo9SGWQBN+602yD93rVUfSTe+I65cFRd?=
 =?us-ascii?Q?PDcz6TcEHVQHx4AaQPylWke0T9TKOnBJVNTCpFeDG8UxvkYMzOub0Dczdoe0?=
 =?us-ascii?Q?0ShVyg2ZWXd8MkSE/vTEhXdOQD3Xckj0bBVznqgcBGsORym6kIZj0KXV1g4L?=
 =?us-ascii?Q?aiazEsoAEEf5vS12VRLtm+zFu8qNfjAw/A6EjMUWqgo6lV0W6cTsA62q/jtJ?=
 =?us-ascii?Q?4th4h72PLXkinKW4WzhbFwoTtrJPMzV/QaFc7kmOVi3nNZRTVMpWWDNqyrGh?=
 =?us-ascii?Q?7+K/AWWaxln6BbRyj2wmoHy9OHEXm9g0IS0WytR9Br58dfgbvkR6goUkh6yV?=
 =?us-ascii?Q?1x4rOgUOoh3iXkGNrsowjx0DUWkZQGZ5us2BeJE2g3rAbHlF7c9vV+3Hnxk2?=
 =?us-ascii?Q?9TVl0Z8/41vG+tW+wwWBcZ6s29OitQRnecAZpvg+6IRkxgr5wGOnI4WHU3TT?=
 =?us-ascii?Q?KxaSrRUqzNTUty8ycBQnGwRCGCXRZ+0N3tcLftEjzG2q3XL0GFG7Y26KaO8v?=
 =?us-ascii?Q?FbLTKO/nAnpA9vx9hzVgSJ8Js7Z7GKApKGiyhIZGVoZcHjAg3dmIVFxr9y5a?=
 =?us-ascii?Q?8CzQ3MryeNAd23pBzvLPG6haH5eCH2HAuqwdXM93HuEqIdmWLdoVhKqSPic1?=
 =?us-ascii?Q?5iEsTs/psN4EVRolIvX1CNAV9w+GtEc9gLsrS9rsbBrUpOTITPVardeO7ji1?=
 =?us-ascii?Q?L9tldLNMf/9GJgTPWBakUu72YlWHfMeRnd0hZVueO8G0KrtwF1UK4Juk8VVg?=
 =?us-ascii?Q?r8E2JvkezPnlsIJpkD+wrut2kxgoj3wTFgInjHsryHFSKRL7Tz+i4rHzJ/mg?=
 =?us-ascii?Q?7wtJp2bR80fDhcrzr0Gs5S3x518EkVIC5QOkzgOg79fhSYIIJ11PFy/YbpJR?=
 =?us-ascii?Q?gfrq1AADgM5LJAlSbTytTmzFSUqMIGhx5kb6SIk6SNibHValxUQ/7Qrm6Pwq?=
 =?us-ascii?Q?kEtEagOOP67OV5TFEJVqA5PbEwY5fH4Wle6wJt7e5XBG5xZsrqHsNQCw1dPe?=
 =?us-ascii?Q?wJErcB2+7d/+HquEhqcb/hOBxEwCT8AwWEyTkjqlvSvuMaCpBWBM0WsVhCbn?=
 =?us-ascii?Q?RvGnmkaezFONCVoHJfcylXx69UPSu4NoGoQ605hdyLcJnchsRszJ75vxdF7L?=
 =?us-ascii?Q?s+QB0W+OdRMfHvsCk5szJ4U6EwXljg+RPDRtfWElwpjXAtTL5bYzNsWJ2aYC?=
 =?us-ascii?Q?NWd09bcCtodCTXaqKlLLwe3sRzGLUYAcLHy9bHy73babDNVJ/KpTXSgb25kZ?=
 =?us-ascii?Q?XiUw6HH4Cp/o8l5WG5akKBo4K2yf8xIVmeGkC4GR5HgwLsqEvgYSJUyh8UnR?=
 =?us-ascii?Q?BynTbujLmcObsed2oI1z7T4vphM242xEubIvrdkrvaXg2zyFzegF3ydhUszp?=
 =?us-ascii?Q?fXdnAAgU+X+zo+i2L8G8Kif7jGJ4PNQVHcLoHAwS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VJkmTWwwTbXhMd5UQTvCosCc/xIJSL01NY3V0XtMoNSODY9uFVLP34qf0ncW?=
 =?us-ascii?Q?PAIr4RBgKMSOkhAG/KPsUlBjCpMQE6vnzazFa4VTkfwEAuxaj96Anll4DoAA?=
 =?us-ascii?Q?37tfggKh2OAclwTJi4KzVOVHSJQLY6gUSdREtAYqgsRLJgiI47I437+QxQ62?=
 =?us-ascii?Q?LIs5MNCstICxEM0OkdlHjbLm4nx5T8gYg6J81MpWN8+ZTAOPGdS+bPF96K2g?=
 =?us-ascii?Q?WMgWxCgKRAdGROSCfkUU1doMYVZEs747LWg6gP7InWVxXG+L9HmSyfnuuBHV?=
 =?us-ascii?Q?qcqQOn82D7y59m4KVZmkHZsNBD0bJ+cX/WQVQHe4arcbW7Uamu4YHAhTYU2Z?=
 =?us-ascii?Q?QDk3FWSMErg2PjC8uAx3R9Grprpm6l6Ac6Kz3Y54yCg0SiUl+FTF4NtVoAFM?=
 =?us-ascii?Q?0Mle2VSA2k1rlIMVcF+QmeNWmtQHsntPn7k8R3PLcaExpRruua1xD2ilIBWT?=
 =?us-ascii?Q?EA0b/drZEWHQ2Z5NVOtAhuTPQ/yrlVYklUkl79mTPA1Q2vpnZlD+7W3tULan?=
 =?us-ascii?Q?99XQgwZlJwUjzJd5dk5gqLcbw0/qDX9XEvsOA+AU5h88sXEB26MtAU8/cZeQ?=
 =?us-ascii?Q?xGPPGUVdqc2Jfe9InWUzFwFefZzW6V7IB0V2p3KbRRDtXkrh6x5YpKzD31tG?=
 =?us-ascii?Q?bxaNdL9DvOhYv2i3CpkkEhLVFjhjeA+HwOYNgeU4MPJWwY18UTCnWPZP/Qso?=
 =?us-ascii?Q?n7gcDWKmnNZmBEcjNAu8uGHLFbvAxSxZ3TOwxHp581bFCADYamoDZqWUQisw?=
 =?us-ascii?Q?5H/gQ5Gm8NjIbpHw5yNtAxQ7vl+yAQRLKOqV9/Oak7e6U538GSKLugS/3vFm?=
 =?us-ascii?Q?uIRV0X3i8zhmaeRDOmz3Z8CyeAenaL/rICIg0//GczzYyeW+MaM/ECq6yxdh?=
 =?us-ascii?Q?HnjKIisZZcksfEmixn30hmECD0jYMJMoryufRj6D/+4RbqzrKzt6VX7YpeCb?=
 =?us-ascii?Q?73IiOm9brTRmd1FhzFGLQSFxmn/nPnGJoo+/zhu3Rx+WGlpyFC7YpvNZ3TfW?=
 =?us-ascii?Q?JJfyDWPObYphE64cM+PFm4Eq6qgFj8wAHE1j6oldYDIihoQ3IVoAj+HMVRYv?=
 =?us-ascii?Q?z7tCvUizfpkROJjIFRB8go+FY+gLxm+D6SJpj/xodzlWaTtLizU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40606df6-f73e-4b2a-0bff-08dbcc358243
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 21:43:59.7301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTHHaY1xhphAqwhHClh5hOm2q8+jzJFLcXXYKTPiUKjnGqZ2lJgF9i0OCBxYW+liZ+n1yxly5aUg1MO0P6N7QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130189
X-Proofpoint-ORIG-GUID: dvxBJpHXLsHKe2VBRFUh64RwjNlA2lKm
X-Proofpoint-GUID: dvxBJpHXLsHKe2VBRFUh64RwjNlA2lKm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 21:58, Naoya Horiguchi wrote:
> On Tue, Sep 05, 2023 at 02:44:00PM -0700, Mike Kravetz wrote:
> > Currently, vmemmap optimization of hugetlb pages is performed before the
> > hugetlb flag (previously hugetlb destructor) is set identifying it as a
> > hugetlb folio.  This means there is a window of time where an ordinary
> > folio does not have all associated vmemmap present.  The core mm only
> > expects vmemmap to be potentially optimized for hugetlb  and device dax.
> > This can cause problems in code such as memory error handling that may
> > want to write to tail struct pages.
> > 
> > There is only one call to perform hugetlb vmemmap optimization today.
> > To fix this issue, simply set the hugetlb flag before that call.
> > 
> > There was a similar issue in the free hugetlb path that was previously
> > addressed.  The two routines that optimize or restore hugetlb vmemmap
> > should only be passed hugetlb folios/pages.  To catch any callers not
> > following this rule, add VM_WARN_ON calls to the routines.  In the
> > hugetlb free code paths, some calls could be made to restore vmemmap
> > after clearing the hugetlb flag.  This was 'safe' as in these cases
> > vmemmap was already present and the call was a NOOP.  However, for
> > consistency these calls where eliminated so that we can add the
> > VM_WARN_ON checks.
> > 
> > Fixes: f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages associated with each HugeTLB page")
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> I saw that VM_WARN_ON_ONCE() in hugetlb_vmemmap_restore is triggered when
> memory_failure() is called on a free hugetlb page with vmemmap optimization
> disabled (the warning is not triggered if vmemmap optimization is enabled).
> I think that we need check folio_test_hugetlb() before dissolve_free_huge_page()
> calls hugetlb_vmemmap_restore_folio().
> 
> Could you consider adding some diff like below?

Thanks!  That case was indeed overlooked.

Andrew, this patch is currently in mm-stable.  How would you like to update?
- A new version of the patch
- An patch to the original patch
- Something else

-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2312,15 +2312,16 @@ int dissolve_free_huge_page(struct page *page)
>  		 * Attempt to allocate vmemmmap here so that we can take
>  		 * appropriate action on failure.
>  		 */
> -		rc = hugetlb_vmemmap_restore_folio(h, folio);
> -		if (!rc) {
> -			update_and_free_hugetlb_folio(h, folio, false);
> -		} else {
> -			spin_lock_irq(&hugetlb_lock);
> -			add_hugetlb_folio(h, folio, false);
> -			h->max_huge_pages++;
> -			spin_unlock_irq(&hugetlb_lock);
> +		if (folio_test_hugetlb(folio)) {
> +			rc = hugetlb_vmemmap_restore_folio(h, folio);
> +			if (rc) {
> +				spin_lock_irq(&hugetlb_lock);
> +				add_hugetlb_folio(h, folio, false);
> +				h->max_huge_pages++;
> +				goto out;
> +			}
>  		}
> +		update_and_free_hugetlb_folio(h, folio, false);
>  
>  		return rc;
>  	}
> 
> 
> Thanks,
> Naoya Horiguchi
