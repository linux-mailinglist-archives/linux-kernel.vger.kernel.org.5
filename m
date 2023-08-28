Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A616878BB92
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjH1Xgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbjH1Xf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:35:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158631BB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:35:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SHxFHj001074;
        Mon, 28 Aug 2023 23:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=di1FcbRgETftb/bTtpeGSLsGea/WQZvZtPke3PPpy/Y=;
 b=mcpXO549/ogzMhrnkAOLwoEwEP2JKb5nkrnGVHX5+J4DvNTERfbgmtkeOezjQDTo9vwq
 2c9eiBKV23beKYU0/Cm0i4OWpfAdFjOkouc2wqS+qWtHhCKM+AaWWKnHtZYJQ8KzPb5F
 03WgiU9yg0hgEBJNYG6Gbeb64RPGtFmmFE9xsGrJ6HIacj8jCLG+Cvrgxwayzm5x84qy
 OUzLLAukDBDpSOOgaYqT98V7wL2jdnXJ8L8vAin05LNAkSOoyM6mwB7sF59w8jrISXx3
 VU47FbdSwxujyqQgOXHKjC83jWJ13SgaekXW0KD8/7K1kTbkokmdEQrg+VxqxaIeaBvg Sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9mcktgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 23:34:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37SMATaH022944;
        Mon, 28 Aug 2023 23:34:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hmbt3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Aug 2023 23:34:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFkC7IKYPxoQWim+noVIa+gcyyxkx9myg0xgY97O/JX4semh9GOs/UvlMxqV2iUl7qFsrR/4CpcVEJeEhoc8Dp5kGjt9JV1tgMrvLIlfQAbBTXzaw5lAsjcBi/dx0efoU1TMk5W57uRRQe+SVVSAPtDJM0XZjl2wUC45pn9T+0QSTuWuxpiV8qWOhbzogJ1qAAi4HPxcJr8VeQ0mmPSVUUxUQ+AmdUyoLsN/ZAECn5GQ8g8zfBfXuBN6QQvsoACOdgCgMSXtacN1nNYScGiaXox+Y5/wJfqaYASoMQmA8o4MlJYk3+G5rfU7ZnKUJmt6cuttRK1nbPFoMmo6GyPIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=di1FcbRgETftb/bTtpeGSLsGea/WQZvZtPke3PPpy/Y=;
 b=nKTWy/I+FamKcjXNtukDeqySefhkrhPcxWHfYfPVvDNXsPTAh1LiE/d35pTBVNdYyMMF9YchJaL1AgSfrC3e9RiIBbJmFa5UBKNZaZy7650bRVu4i7X4AWfF2x79JMzl90Vkl+DXNr2XfiXtfW//6zYakIdP3P79kTNiVavNHnpM02BWkWj2my9Tx2nE55Xq6MxdWAa4fvXNtWBQKVhiQ6zNM02Ozf7zZNCQ4QmMyYFkYUqt0fftMlS5VnnlDY7VClYdSOFmzoDkIPXKbRphDgI5vUp25ocUCzyusJdiqXji270ZNsKLEQHl5ykgTavuSQNo3MQO00CtFYnf/4ZtWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=di1FcbRgETftb/bTtpeGSLsGea/WQZvZtPke3PPpy/Y=;
 b=b6x557cxBCNoDfozdCm98qA65w/aHbrprqt7sd52H31t7CjNzVDHefLSUrJ9s05RpuPS8MqckXlu2Cd+EMNRuDGp1HvhHH1VYIfU8QIqUdkXjNkF3aRJXtQKPmEg326yp4iMYcF4owC0jp2anuuuW2h+U5J0KB0tQbTFAuB9XEo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM4PR10MB7428.namprd10.prod.outlook.com (2603:10b6:8:190::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 23:34:51 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::92ea:33e7:fb66:c937%7]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 23:34:51 +0000
Date:   Mon, 28 Aug 2023 16:34:48 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Xueshi Hu <xueshi.hu@smartx.com>
Cc:     Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hugeltb: fix nodes huge page allocation when there
 are surplus pages
Message-ID: <20230828233448.GF3290@monkey>
References: <20230826035748.891697-1-xueshi.hu@smartx.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826035748.891697-1-xueshi.hu@smartx.com>
X-ClientProxiedBy: MW2PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:302:1::36) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM4PR10MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb7b7e5-f85a-453c-bf8e-08dba81f6022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nzEFFVzhNGxApr3DUrdmp+HbhcLkVFzNY3YFciIiT/oiIBz5oTpxH5OCFOIBEgyNtVP/BaV9ccFoILSrFLPXAxwQTY2Elj0hdvjG0c6Yk/FWVvtoBEAytOl2HCUKAO4ZEfc52hsGxGAhzD7ov8CgDrjjBPK6C4KvwJQk5gBlLzDjQ71KzircJ5VSu45WXsGAd625S+ktD6HNcvDL7Oy0V4rw30s0thmwFeYldcwyold7wMYgUF0j8uhynGBVY52asJYwXCSB43XP04vdNXqPiw1YxIfeCJ2TM/5XmdjWC5VV7tIS6rt8I2IV64aNq9ZO0/Yqbk0GMmy9uWYBM4f/4XsU6NspE0ehAewt5+4SGxY3LeOuzInnFbsLD2Pvv4TumxZIrLbKxe3+T9OEwmxL8byqy+7aGJ51psQGR4c+Ln92uTKXBrpZDs7V8PkEFXA9zeb4qivZ3sDFyfmMcrn8duvSrQTZfxr07Yqm8dSjPMJrIM5qUm5O5HLEUn1xHqgBMo/hVv0WwRlLFO/MfHAMqImrfTWkzbVwuoqdNp9qkgt4/K0VjHpmypXyQl08AzpI/Ey3KOHZLVbUUYp4ZKVz23H0j/+zEmEi/FKGCcmyiws=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199024)(186009)(1800799009)(6666004)(6512007)(9686003)(6506007)(6486002)(33656002)(86362001)(38100700002)(1076003)(2906002)(26005)(83380400001)(53546011)(478600001)(54906003)(41300700001)(66556008)(66476007)(66946007)(44832011)(4326008)(8676002)(8936002)(5660300002)(33716001)(6916009)(316002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bg5PGlV11RKfzGDa2i8802HlLo7/VNrzYiYiPxQeQxS2eQMRU0DQfQq6DQfE?=
 =?us-ascii?Q?A5w+D8KkmbmSkP5n6XoE0V/MHo2xTEKINNq+zGmF+Jh5fVpl4nkNukGQjZ85?=
 =?us-ascii?Q?syk2mc/+Q4cChLW396BD1hAKnR+8iasvEjrtaiP6ECzlOV33nZYF+iXNdYqd?=
 =?us-ascii?Q?4hVsaecxpUhAxHiDukMvcBA02AGY2H4KK76o/TDSxlMogVChvxFKAjrkrq+5?=
 =?us-ascii?Q?IbXwqecVrtYRtUMNNrv/4+w0XrUS2nOGjMlm68KjycKnfkJZCvEAtyAwOwXn?=
 =?us-ascii?Q?EuwElGoOc6RmZcFXLOnKvs/H0M7zIwabK87Q50ckl77xj2bJy+5DNoEhmKNT?=
 =?us-ascii?Q?vC7Hl+eJTzPsExi9bL78q3EcDUzcbjsEpBLcsrN2BfOOJPd3mashxbVJr2Ds?=
 =?us-ascii?Q?8J21/CTTO5FTs5A3CO3QOkt//hrLli+7pmfVBCdwD4UnX/SCpx7kNXNga/jw?=
 =?us-ascii?Q?tc6a18huOuGu1MzvG0Sss8r147wGp0O67xNMYuHRpqR8QaehPhnlHwZZY50z?=
 =?us-ascii?Q?CsKD6SKL/tEvygFyTwcFp2731hHrfdyter7JdbN4RU8gM8cjz6wr5yRNfmwx?=
 =?us-ascii?Q?RT2HDCzbkYHGnDVsV6D1XIHpIy02fSgK+K/6KKRYpflEMgTCJfYRmU/GIeWA?=
 =?us-ascii?Q?IDDqfJCyr5VE3ZuexIfchyjz/DH81soyc0bY1idruKCjy9pgMJgfaCOanCmc?=
 =?us-ascii?Q?8i9cq3MjShA/W3CaSjErXXe7FUhTQs5TXSWTjXORxOOmJSg1PF3lEE7S+AAY?=
 =?us-ascii?Q?ODrUBmWIwND+2eAqqYYIz3aMBA7DD8YGaOcUsv17LqSrltyw9UL+fj2j8ro5?=
 =?us-ascii?Q?KaBSR0zLWJ9JoAoPVtBwgyCR3DrNqIDWI1wNnFlRoCVKChyvhHUZ8l+QFrNv?=
 =?us-ascii?Q?M+D8WyWwMDUCXKGbTEa3WmZYtX6WvrxdvkFm61B6138uNp7F5Yn5424bhCQX?=
 =?us-ascii?Q?3gklUrV5HC0W/+okaJXgX6PcpjV/IJtSzLLryd9NJ9XYZY9GCG4Ss/A06rbd?=
 =?us-ascii?Q?F0DZkuqrQnCLf9yplC2SHl/ETZOaZcBJan/Q5xLmDWnDlRrxddXrj226QEiX?=
 =?us-ascii?Q?gqsxEwWKiAtQ4eiZ+o3lCZcb8ZDnMRiFeQLH3CMqDYD15TSwEabAjteuG7Wl?=
 =?us-ascii?Q?Rgr7g0vDL9Z6S22yA5wmtbUOztzYetrPiZQOFaUJTAMXRySZEhRPCdPKT48R?=
 =?us-ascii?Q?LS0P/z+Lb+/vCdVRIY2oiItHhoJl+lIMucHwdEUV9BD2E+eelJKUWyfLaI9l?=
 =?us-ascii?Q?wmh6ZgEBIscBHrzL0rumRtni0CG6bHkKEG7g2O6h9v9liE85lwhQlKgMtGFI?=
 =?us-ascii?Q?EwwOwvidkSsFV6U9hE6bvyYU/WQfDcsDNQGEKoOx1pBvYLFTcfG9n2+dXx6C?=
 =?us-ascii?Q?IZQHrF5qoCNNp9YIBUdbPPu4eS9LaATchWN9jw6W5w6u9mS8kzRM9bP7NHrf?=
 =?us-ascii?Q?BgNIOuymf/W8S0nLU3tVgew0NVGhG3RSiiOw89m0yf1zj7XHCRsR+694QU2k?=
 =?us-ascii?Q?LnHEI/XO5KGj5dtH8Rw3jZAHi6hkKK1zt7T8MRyrTRmnyI6Jalei5TvKdegc?=
 =?us-ascii?Q?K/wrm0zB1ufpH46VZdBw+4wrSTEUDB8am7llw0CKuEwxoAcfXuHu38VAe/29?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?qFjV7D09IgaeP9r8EM8vbC4CtZlvlFm9iCwAgRejuidrG9CQErG0Fh/fNEMo?=
 =?us-ascii?Q?zVCox7ZAECz5FU2NIhBd+ePON0N5FN1//JcPGhsYAZy2hJRB2eTwIkmNvOaj?=
 =?us-ascii?Q?+0xpm9tKEKjZtZ/BdPb/QWlUTbF+o1mzw+4xmkps3AaOHOE1E1d4zMOjVJKi?=
 =?us-ascii?Q?H8euK9lV6W6/KRmVY1Yz5g+Zdg94YzXgJhiNbpIbZcrxv5HSU0nT9XAzwWoO?=
 =?us-ascii?Q?BkhQupIUJemdkloZd9xQpK+tBXLdxKvPgwn5yQ3yx8PDCmCJdHbeoexVBQRm?=
 =?us-ascii?Q?OffqCfP0oZuJu1y8aI978kBkeJTBWN3a1BTe5UXKfnYuBMY6M8PwZ6iCM800?=
 =?us-ascii?Q?aN52KmahV0ad5Eaa3IYMU2ePy5ZqWVdNf9PQEczYfbkSIFg6XvBN/DQbL9Wq?=
 =?us-ascii?Q?JUcfIJmgxmhPXEUD/H+I2vSKfo/nA3oORGFnhtoq1h9crnkDVEi5RbFi6upL?=
 =?us-ascii?Q?KoqArsAx3o4yMcVgOVh5gLDEsCebPQZnIpDPH611Fejo/BNV04S6Z4eY/i3U?=
 =?us-ascii?Q?G364A8+uw6d/AVn4ePqF3S/4PfYLTx1BJR+keaH3j5KOvvtXVWxjhMphElvN?=
 =?us-ascii?Q?jZUUhBNyqO1XsGAk2/+ve8/67nzFc3QwSQOZ19dvL7rELlQs0Kr8rQiPPKqC?=
 =?us-ascii?Q?UVWRA3n1EF0mcVK975UKp2YGQ7vTwG3sLbtl74+WDvdM3AhjUaAavM1fyzfZ?=
 =?us-ascii?Q?hI6UJ2HeJa+3OjxsA4htEEnHfroq8egowwVRplMErMHEnoPIr0bsAn3+h7s9?=
 =?us-ascii?Q?LkOuHkP41vbnez6tPD6y0ZRByFPDcWYKBpRx3ZJpiK5dgk9FlcDGow4uKJnk?=
 =?us-ascii?Q?0tPRf2k6MKBfykLePzqKNXwgtb5oKcvjBBa499R49NApg07PS3O24EhiU3tx?=
 =?us-ascii?Q?XzwJnqGx/rE3sCBYRJne76KzZFQZmph8A7G5LZz1jp5u6uANQ60SWG9tr8As?=
 =?us-ascii?Q?4Ub+p2hF5ZxhkfpjSETNuw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb7b7e5-f85a-453c-bf8e-08dba81f6022
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 23:34:51.6440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 94HFGafURgIELC8bX4PGlJBR4J6/x1S/qqwOjC7eqdqNntY1SZtHmC1ifn5Ft3/MLyfOD4m6lwsp9CLnVNB/Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7428
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_18,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280201
X-Proofpoint-ORIG-GUID: rf9NJILxvhbM-J8Jx1jCfcHeE_4kxvZP
X-Proofpoint-GUID: rf9NJILxvhbM-J8Jx1jCfcHeE_4kxvZP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/26/23 11:57, Xueshi Hu wrote:
> In set_nr_huge_pages(), local variable "count" is used to record
> persistent_huge_pages(), but when it cames to nodes huge page allocation,
> the semantics changes to nr_huge_pages. When there exists surplus huge
> pages and using the interface under
> /sys/devices/system/node/node*/hugepages to change huge page pool size,
> this difference can result in the allocation of an unexpected number of
> huge pages.
> 
> Steps to reproduce the bug:
> 
> Starting with:
> 
> 				  Node 0          Node 1    Total
> 	HugePages_Total             0.00            0.00     0.00
> 	HugePages_Free              0.00            0.00     0.00
> 	HugePages_Surp              0.00            0.00     0.00
> 
> create 100 huge pages in Node 0 and consume it, then set Node 0 's
> nr_hugepages to 0.
> 
> yields:
> 
> 				  Node 0          Node 1    Total
> 	HugePages_Total           200.00            0.00   200.00
> 	HugePages_Free              0.00            0.00     0.00
> 	HugePages_Surp            200.00            0.00   200.00
> 
> write 100 to Node 1's nr_hugepages
> 
> 		echo 100 > /sys/devices/system/node/node1/\
> 	hugepages/hugepages-2048kB/nr_hugepages
> 
> gets:
> 
> 				  Node 0          Node 1    Total
> 	HugePages_Total           200.00          400.00   600.00
> 	HugePages_Free              0.00          400.00   400.00
> 	HugePages_Surp            200.00            0.00   200.00
> 
> Kernel is expected to create only 100 huge pages and it gives 200.
> 
> Fixes: fd875dca7c71 ("hugetlbfs: fix potential over/underflow setting node specific nr_hugepages")
> Signed-off-by: Xueshi Hu <xueshi.hu@smartx.com>
> ---
>  mm/hugetlb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thank you!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

A note about the Fixes: tag.  Commit fd875dca7c71 moved the root cause of this
issue (the line changed below) from the routine __nr_hugepages_store_common
to the routine set_max_huge_pages.  I believe the actual issue has existed
since  commit 9a30523066cde that added hugetlb node specific support way back
in 2009 (2.6.32 timeframe).

If 9a30523066cde is used in the fixes tag, there will be some non-automatic
backports for releases where fd875dca7c71 does not exist.  I would suggest
changing the fixes tag.  We can ignore the broken backports for older releases,
as I really doubt this is a real issue for many/any people.
-- 
Mike Kravetz

> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6da626bfb52e..54e2e2e12aa9 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3494,7 +3494,9 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
>  	if (nid != NUMA_NO_NODE) {
>  		unsigned long old_count = count;
>  
> -		count += h->nr_huge_pages - h->nr_huge_pages_node[nid];
> +		count += persistent_huge_pages(h) -
> +			 (h->nr_huge_pages_node[nid] -
> +			  h->surplus_huge_pages_node[nid]);
>  		/*
>  		 * User may have specified a large count value which caused the
>  		 * above calculation to overflow.  In this case, they wanted
> -- 
> 2.40.1
> 
