Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFC580CF79
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbjLKP1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343917AbjLKP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:27:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42FBD6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:27:13 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBD1Kcf032698;
        Mon, 11 Dec 2023 15:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=0pGNPKfCVR8w1RN0KM+bKwt9klNiq9XlOdTWaaakMhQ=;
 b=m99cURhQdNKyT8b0l3qJ+M0o+nYY73b4OmlUglUv49eArdsR6Q/1mgtfqNeKCXjsvyNX
 /gYAtRDa5LGjmiXPlzr28tTvNS5nYCuKoueheWIBBW4CYoMDCAffLwK+dkUCAgfrrXMT
 GTjM9QVupzsv8/RRmTS+OMDc2B0TQ0jVyusx9gIruzUkcTA9jha+lTvjkxaD5DpWvNy2
 xW1mGGX+av7aAg5nPfkXc+j0Tbli5BFaCiUW3fNU8+BlkkKLRyA9mCS4EFyCNL7HrLk4
 EJ+vwC84++lNgtPqTG2jYxSyiXW4WCSuQaQ2iQiN0jpiuj2TM7GyOCsrFAIngQdPKcZU 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvg9d3911-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Dec 2023 15:26:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BBE4Z0q028533;
        Mon, 11 Dec 2023 15:18:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep53gun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Dec 2023 15:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWAPUARHodJSqtNlL5uGOGeiytJK4KHVnHyF/uci14+aDOdnP7cGLLhO3H3LAPxSVkIOIWLd+fIEa7mkwvnftwX591sOA4D/R6wxa3SRU2S/YuRp3y60CemU37ubfeBBWH8vFKhCoF7AeAtedgvPX8Pulv9A4vtKJy8Rh42QZFn5yDZTeLD9wbPqk/x9CHsngLhQ6tuifGdCT3Z/4UKApKyT574W33tqdcMlu9pUysPUKcjIkcQYc0ruE6HzIUdU5vQRKWVb4ILdLnDRfop80AfysbwoWRYioVBt+wxEkmLUu0K9NEyIxKvyxwvKyAd69+6D4cCTnTADGqWHLAjLRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pGNPKfCVR8w1RN0KM+bKwt9klNiq9XlOdTWaaakMhQ=;
 b=ejuH+YUO6w/m4PtAfmiFHC/JIuRPKjS3wwHoslOiF/IZXyzgkQHDyoMASGe+9x4zN0kxH7ws1oaZftt5Wc4UK3IA+f9K04B5bfNX1L9q6eNnXA7QlG0fxF/ASA2vrYcR0uPvLFoQfKFpE/aDG6mFl9W1W9f9Pd2ZI5OX0oVyuaWGweVK/XjZ9pUymdZsGbLYXZDvEgFO1+fNDDd83d0931JkrXwSsw3llxzJlARWHDVRE1qCcTTZRYPJ2YGiClwy2Lsdnj0U1c1RbXISmXLguTjW/k6RvWikF2EsS7cKCuqYMLrQk49GU1SVRIW2l3L459QrsjPmNbJTn/dMfpTegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pGNPKfCVR8w1RN0KM+bKwt9klNiq9XlOdTWaaakMhQ=;
 b=ZgvsXisQiGyrGgKUvLbrl7pXPDqne5LrBJiUSF9Rq7f1BmaT4LQTXxh4xcw0oDCyKYmyNIlyyo1W/qPcyQMyXaBeAIdMK+ly1neHZL18wddoaYdF9VDpLrSKf6eK9kZexCB4RCgGlhymEUkkBJO7wQaYK3HYMEXaGa6JimzLOgI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB7131.namprd10.prod.outlook.com (2603:10b6:8:e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 15:18:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 15:18:50 +0000
Date:   Mon, 11 Dec 2023 10:18:48 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] maple_tree: fix typos/spellos etc.
Message-ID: <20231211151848.pr6xa5ksq4kwudmc@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org, linux-mm@kvack.org
References: <20231210063839.29967-1-rdunlap@infradead.org>
 <ZXYp60O0qxvPmuHu@casper.infradead.org>
 <20231210145601.177b543ca2ed28b9551575ff@linux-foundation.org>
 <f4a56419-088f-42e7-bf50-4afbe7c8f571@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4a56419-088f-42e7-bf50-4afbe7c8f571@infradead.org>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::25) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 153b768f-7843-43c1-6d15-08dbfa5c7aa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IZZGsTCXJllM2zYWEqjFvOC+HIqOsbAlEC93KQ/ipezOKbrKfxtN/Y01tRYrtUE7Kk9jtt8SE5YIw4izl+3KB+/LQswHTdLMOSQBHtDWNcRGcfJhT6qqQpOi+dyRyPo1T3nyvhW+iLUokP0BztPsWRnFy45z7oGx38V7zZ5RYaXy1f/8l5NEoxI2rcV3kfP4Y//JTb9lofYYB2jNLpankIaYuEoi8uW+nGXC81nohTKs4DA689cG6m04i9CfnZyVoQnMBtpF+iyKkifQn/Bs+VJa7W4RcICuSPyolwEtopCu5j57qqplXKX2QIl1lFryX56LPOT8bmjIibyxkWfbTpkisfmbsx/1IyPWaul+j1mo90wyOoTUoJjjayXVFhOMF2yW90yNy+GlNpFk96q4kNeovgdhKaGLpe9ekztonjJd5KI4rSP17JY6iGX3o1n355c0SoPDfGgTHr+577rXqif9NjgXIJFZlTI/MWmKl441VFLiik0JgKnZy8GCMoY8fX0GrhKMTYdVZ5bBsxpcMWTyqO7uS7eEOVBnp+t8t9tRd+IzkQMhmYLweXu63FfG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(6512007)(6506007)(2906002)(54906003)(66476007)(66556008)(66946007)(6916009)(9686003)(53546011)(38100700002)(86362001)(4326008)(8676002)(8936002)(316002)(5660300002)(6486002)(478600001)(41300700001)(33716001)(26005)(1076003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qv+PseofUspfceyh8Q1w6WH2LQ18Rfj0Fl9E0ip0FZPfAua0msJZ86V7RMyA?=
 =?us-ascii?Q?mL53S0aPSdQyFPEILpv9O6CbwFqilQNW2KkaFlHdM4JWBn/mjBdnrwyWlX4p?=
 =?us-ascii?Q?ZaBEwJz5bk/Y2PoXOinIwpuOvmSeWMSnlZYUvKOP1KnwTaHLJqG16Bb87ZSe?=
 =?us-ascii?Q?iIE8KXujN48AKUu+vDyhWcA1w3oTshrc6/w2NK3y0x8DwhHHQ2YkyL12LmP3?=
 =?us-ascii?Q?kb9Ok247h3QZe38E0tv0FLBjyBJW90Qwij+cMHRat2f/Z2lu3xQhCTHWJLjt?=
 =?us-ascii?Q?hqqE1h5Q8JSrtU+P5S9B8BbiuD4PDDeOwn4IuAKdak25iJlWRXW6HNdECpuj?=
 =?us-ascii?Q?1u6kkcaunPZtyqFbeb1u6G6OoNAtgTpwZhp40adg3f20V12Vysza8Pehc44K?=
 =?us-ascii?Q?fc4vJaxqu1cj5flXvEtMe9zlagUj2tDMWj5Hf9DZi0+TmA8qF4e5ABW02vu/?=
 =?us-ascii?Q?ewr93MAUuqFM8T0M+7n9DeDTicOJoQ3aHVn+KLlb9jTCkW2Eb+xTOL1nfpOd?=
 =?us-ascii?Q?OUFr344PBCt11QXtP6mem/gQs+9xLpERhXJfFz3RzyD+QMRkBTIsQCBm83QH?=
 =?us-ascii?Q?YHWng/j3LSf0w4qDled6U4Tj/hipwthesEjznyf9MOQL97Ig/Ic6b05COAzM?=
 =?us-ascii?Q?VvrswwEJxVN6C8PGEjuoVFQFyhtJQE8LoG4F+V8jsKwP+vZwteM3cbnw32ew?=
 =?us-ascii?Q?tomTyJfBb4lkyRB8dIpQERSZ9MxG3iYHNm2sXUoSdOLHaNx8CZO6dzCQCNlc?=
 =?us-ascii?Q?UmjCDRsN0bpl2tZSq3AP8j5YGmrF0ZKpUl2EFF9vXhtEK2AFI6zOi6AfXb3d?=
 =?us-ascii?Q?BPskS0g8V1ZjSXpRmdcFj+HE0aWOshn+GslOUh5TFmf8e9+5g1jbTnfOQdX8?=
 =?us-ascii?Q?8n52vHSgnmEKyFKkj7027k4TKDiy2tZ+Db76L75vYaJvIEizqblXXnWsMV7X?=
 =?us-ascii?Q?4ihpFioerlMU5Lbb8c52kvPmQs+7kvcIJmWISSJqW2qcL6DT054N1t3mZfai?=
 =?us-ascii?Q?0yOkW1d6QnxOcFELx3VKGJvDTBt5YOVxQ++TcYkyszGO00jKYZzWAmU3Kwin?=
 =?us-ascii?Q?mtBzo4jxetidvNUVyq3gZW76WhfK4UfTqmttipR+iIdRny3/+Xy+SdJsPR0q?=
 =?us-ascii?Q?Bsex1siAjGQVBunmzxc8zb8lqPTFnVpcWN+byM8+AjvtMazkpyQMxNBGNRtm?=
 =?us-ascii?Q?5QDQg6fuxwqvu8gi7F/McUo5+uCJsVwh4Jeb6HaNoZXx1jpls73FIEj83je0?=
 =?us-ascii?Q?2cxO7vsLWqZWGXsb1RZwg47JUqjbbs9YHl8UlDNmp8jnPmxugVqNskjOtyRr?=
 =?us-ascii?Q?iXiCKD3xmyG/DnC6GEzimE3qbJLFwl9SMp/A/cwgJvfKSnTS4ULA86Rmckne?=
 =?us-ascii?Q?uAYWxgpa933nEQa9CM0SsEALvPj7dkRP+BO8nDx1MMYh1hBmiUxrnJ2Ecd9G?=
 =?us-ascii?Q?aFsKrSQKFdkG7+Y1LzrD1xDMnv4rjcHJcTw3+WvFfiGyCJY6icnOLi8WvcHe?=
 =?us-ascii?Q?gvD5G1T+y0mZgM65BaCthycqZjcnpQo5yxE6rEX2Xw/3BDXE0mswCCGwEdEu?=
 =?us-ascii?Q?jA/3sf+pbKT2O0WXduvnyRC9Y8Pvbxe38QV1ZR4z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BkHVXt6SyXJHV6KGwPNgAIcbd6sFzSitMTXCLl3MFGaxBfdtIDEMtWC0bMt4?=
 =?us-ascii?Q?z64DpuoLU+7TdK4USZd9oYZshbEVhfH3UMuvg57RRxWLzTw8vFkmsVTXlF6C?=
 =?us-ascii?Q?d+ZLX0TkPizndtzTH+brVQze7zUtnpoYWiPJMLDN5FbdY6eRVijyzXAQTPIP?=
 =?us-ascii?Q?C+cIh/Vnu4AvL2nOiAnAy0ngEksZgG7QUz99zu56YQf6YN027zt534oPxEF2?=
 =?us-ascii?Q?IuqpIZ7+j1ySr4ilhbL++ymJJcd55i7ElFUZEUHRJ6RW8UOmWtLqp5XKdgps?=
 =?us-ascii?Q?O85kzvwXae4fAFM1pFzJg/nHxxlQ3oEuI4L8tfEEDBZBHCjrBy8WkRyB4O1R?=
 =?us-ascii?Q?ms1SEfYtWo/OWSRIbLO7bHiIhCN98TPoaIiHnxfe9Ui5weTEnliPSpRBrYXh?=
 =?us-ascii?Q?A9SAd+7G14sH6kAawfWsuaHgwlGriFhH9Sr+aUZufYOSxkSCLNpyb03uYeVe?=
 =?us-ascii?Q?g+M2NEazf+T+PmkfXrvwMwQd9hj3TnCQ94CNoVeL151IW3sgV4plLVaq8S0s?=
 =?us-ascii?Q?282L18bEiVXnkWCcM7ctVvntoxV24i7bnYTcPDFvSNawWj1wXoR0n4IF//Cb?=
 =?us-ascii?Q?g/PdTYa3//Ivtkr/Z0sJx3me4iM4OkjcrAlozgj2/alQly5H3kw50WLOY7Jc?=
 =?us-ascii?Q?Vj9umtA5+GhHv4oRDsjjiqpUB4hWrlD5ws/gqSJKhjxWER+Btow7/fcFZEU0?=
 =?us-ascii?Q?Uzr5sl7pfhBnYxfvbVSODJJiEbpjWcYvzWj/9xMF5YDpIV/5AJt6M969wj7S?=
 =?us-ascii?Q?A91NloODWE2bVLCANIJvyHAuphWljWPWBQ9eOU3wIjqR5kbuJq1Sz7LDNkrR?=
 =?us-ascii?Q?UHGL/n5J5oHUjeQVux314+RQn95EwP5MxtBswTqqnwjAhA2Xw7y97KZ2l+On?=
 =?us-ascii?Q?umasPXhpfBYl926I8MsHWY/pU9C7wRvxokZ7y6qg2koqI6MorepGdMegVqYZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153b768f-7843-43c1-6d15-08dbfa5c7aa1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 15:18:50.6226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMCivPHMb+gJp9BCDdGJZ9QhE/srgCo0EGzWXH/5hNhAtsNBtQ+fuxNIxNMX/dHb7o94iTdrmiDt/ATQ75/IXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_07,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312110126
X-Proofpoint-GUID: WcMfs9fUZZsDR-srGgQNemJwJSKHisWs
X-Proofpoint-ORIG-GUID: WcMfs9fUZZsDR-srGgQNemJwJSKHisWs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Randy Dunlap <rdunlap@infradead.org> [231210 18:54]:
> 
> 
> On 12/10/23 14:56, Andrew Morton wrote:
> > On Sun, 10 Dec 2023 21:13:15 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> > 
> >> On Sat, Dec 09, 2023 at 10:38:39PM -0800, Randy Dunlap wrote:
> >>> - * mas_topiary_node() - Dispose of a singe node
> >>> + * mas_topiary_node() - Dispose of a single node
> >>
> >> That's all well and good, but how do we dispose of singed nodes now?
> > 
> > Lol, this is my all-time favorite typo!
> > 
> > 
> > hp2:/usr/src/mm> git log | grep Singed-off-by | wc -l
> > 59
> > 
> > (sounds painful)
> > 
> > hp2:/usr/src/linux-6.7-rc4> grep -ri singe .
> > 
> 
> Current linux-next shows:
> 
> $ git grep -iw  singe
> arch/x86/events/intel/pt.c:      * In case of singe-entry ToPA, always put the self-referencing END
> arch/x86/kvm/vmx/vmx.c:  * evmcs in singe VM shares same assist page.
> drivers/input/misc/yealink.c:           /* Combine up to <len> consecutive LCD bytes in a singe request
> drivers/net/ethernet/brocade/bna/bfa_defs_status.h: * NOTE: The error msgs are auto generated from the comments. Only singe line
> kernel/trace/trace_events_filter.c: * struct prog_entry - a singe entry in the filter program
> lib/maple_tree.c: * mas_topiary_node() - Dispose of a singe node
> lib/maple_tree.c:       /* New root needs a singe node */
> sound/core/seq/seq_queue.c:/* enqueue a event to singe queue */
> sound/pci/rme9652/hdspm.c:      /* Changing between Singe, Double and Quad speed is not
> 
> but there is also "unsinged", "assinged", & "singel" if the -w is omitted.
> 
> And somehow the two Chinese translations of submitting-patches.rst contain
> Singed-off-by.
> 

Nodes become singed, especially around the edges, when writes are too
fast.  We have to replace them with fresh nodes, otherwise tasks can't
find the VMAs in that area.

I will have to research how these other people were able to implement
'unsinged' - maybe there's a way to reuse these singed areas more
effectively.
