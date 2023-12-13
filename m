Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D858122DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442648AbjLMXbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjLMXbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:31:41 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5312DA3;
        Wed, 13 Dec 2023 15:31:48 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDKO0fL029009;
        Wed, 13 Dec 2023 23:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=fIokoazu1ryxv0KI/WTCwH+U/oH9p7fOQp/a25fsnUM=;
 b=fTEAQLq9nfxJjwRETBCAVW5IlW85ZmuOsZjC6L2M1q0QSLYjOA1QHuei3nadkxrPq08Q
 yvn6ftRUJwx3j17kAE++gw3O3Q050of64x5fnSvZ+uiahzWwTh+Q4idRDvaPBTSQ0gKn
 MHqevG3/S0AXlTL+0pk81L2rmjl0MRnLGZqFLVg7nhqqp6IM6UJdVGTp9wfbUt/etLuY
 icReRkcRoIoV6HEKQEEMEM40i4LBWtUoJ9o9jzTDlHzG92ZJb8F6mEC9yu8CcZ/sWVXx
 iHyHNPYxLgyrnpn8T2o/dLkvdu3+cX7nzjcImoQxtg/98hR3qm9FL0jFMU1tXqK3qXZO VQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uveu29ff5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 23:31:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDLe1NI003106;
        Wed, 13 Dec 2023 23:31:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep94e8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 23:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iZWOIG7Rv2O/lZkRBNYcNQXzp6Eai0dDy/f6SIG/OxFKmGA9kEoXyjU0iicXwnBMbfSltdRO10nauyaGlB/t4JSc4eqCcBWih4yxGsBactHWXig7i76ULbhEOEDQUGEdlIwbJhuBfuYy8VKqsdo5NM6jh9hKFmXIqluaSqHwCO4EykNQm+G1r0Tinl7dudUgE3QyFhDVg/YSHey46/wZchrBaJI3+ioJlOk1OmDCxQCOivGjzNDDNUwZZFbt3HbWpPwATmXU1V29odPi8lnzaqOlKAaDOyKnQCYodY/wlpuAOU38/TjPEHcMODrpsaXY3ZtSaGManTssCxc6/6Y+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fIokoazu1ryxv0KI/WTCwH+U/oH9p7fOQp/a25fsnUM=;
 b=Nz+ytTMxtEHViiz/uv01slSwuvuMKrBNNYcTXwS26DMLjWsLOrYYmzE/bxUfzALpOD8Ft0IKRA8OTpmZKtGMlVtGxzLw3fxy4IXRn8EMtjrVAQU8B/zZmLktn8lYwg7OOWEs+HospuM8SDmDaGyLVgrpivxOjXF5+jeuSQNHgbwmMiy7g/X3QESNK7dOqIvJv1fDdX2CVuRcOYlRazSRL68h73sCA09MmMOUAm6u0IODhAWb09DJXN61A/IIUTnYfRGXtRn9tf2QvJRVlfG2I0bGHVlMEX/tdRP6fm3Cnvwwmw+OiWVqeRk8U9YPJjwLIMU/igMqPKp2FFLI3Nr6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIokoazu1ryxv0KI/WTCwH+U/oH9p7fOQp/a25fsnUM=;
 b=nv59VMMXq32w5U6UB2RimCJ1LBuV0bINlxQSFH2VGUw6cgSJbGBfVMcNSlNCTZULiX2iLv+n5UfDf805sW/xZxJ+hh20q/sXqzELYmd2gqICs1d/v1hGKDBBSos1YWNo+DE/rAMJHDha8dm7iR6DPSheT3dODx48wy/uEvu2kKU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 23:31:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a5de:b1cb:9ae1:d0cc%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 23:31:31 +0000
Date:   Wed, 13 Dec 2023 18:31:28 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: linux-next: build failure after merge of the mm-hotfixes tree
Message-ID: <20231213233128.vsg3ktm7num3re4r@revolver>
References: <20231214091831.70cc51e0@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214091831.70cc51e0@canb.auug.org.au>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::17) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6974:EE_
X-MS-Office365-Filtering-Correlation-Id: e23957f0-4f2e-4e00-34e9-08dbfc33a313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/AKqlwx5Xp0aREnAVN5GRf5QBMVk+ldNpxDGrs4rkH1ixpbkVxZOyIxwEjpSdVSWaKuRZN4HN159MMKQVsq4NPIn0k0Dm1M8owZ8JjH+9zS3S6BAvSKJOjpo/R4LEREPAHbNcUTbbY6G4iOGCizCvYi6tvy9Tjfmc0fCjUYKxhzqSKI9Al3A4t/3/Bjta6+ELTgtM2goiIEi8oVIr36sb1MCOK+ur5M8bmB56Q+8gI5t5yzR8sGQj/OQOEHtzFv3OE/utheEnWxeFKpOm8WmU2108JeKX2nGyqPalszBBVQAizc9KswbYwrktysVmIiJzB10/ytkGFBBb2BIuM1OUH2yU4+jcHi+s6Olpbku4p0ffx0q9L+2xBMbXekQmHIYVtagFcrrkdsqUF/1uZ+wv4AKuwAu6s4d1jpF4E3V9+zsoN+YLL+DU6dZ23Ek2vleKtOxVyrIps5lLTdLF3X+mb+nZB7phiIPh7NqTPxp7oLrQqXXtccNUE8+MUvATtIbz2RCdMz3KnMOPlL++AuOlc8Hwgedb+th0fhM2W4LvA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(396003)(346002)(376002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(6506007)(9686003)(6512007)(1076003)(38100700002)(5660300002)(4326008)(8936002)(8676002)(41300700001)(4744005)(2906002)(966005)(6486002)(478600001)(33716001)(6666004)(316002)(54906003)(66946007)(66476007)(6916009)(66556008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oB2pxIryo8yJpCNqcAF2N8FP+UtXfA0iKRkNG8wEoiiwqyhMPBzRMDchBdHE?=
 =?us-ascii?Q?N1ZvSi2YQzbPiAnC9Aik39xhOU8AeUUGiDBnOPUWYiO7xHoMP4n8QvKdGDHX?=
 =?us-ascii?Q?H4rAKUJJ7s2Pk3v65n3SpbyobX6ijrkDo9JtaIwd4vCSOY0oTY4UUOvnexxu?=
 =?us-ascii?Q?hcz7TVNJupQyiLwJfxs54QCYeyakF4opV0oT8fb574QIhSQ/RrDPNANzGYOn?=
 =?us-ascii?Q?+y1JJ2jcSlFXNK3o/+LwfHobjg9BbeRQgtmMWqKsLNx46H2EM3pYfMAaTDhV?=
 =?us-ascii?Q?bU4nxmcqsZC9momHpvD83D0nRJ/yb7MHSxKP5J8Six8/b6fWpjrS2Q7dEAlx?=
 =?us-ascii?Q?LnUdzarNTbN/EX7dPYgkpP0W7XjMlymM7xAH1Fu6/B+1Z8Z4LurAifJUy1bv?=
 =?us-ascii?Q?MAH7tZzSQIoMqGzCKHDa9vBgYkO+mGR2/fzoOTSBhfuChMZFzTrYVyS1Mf/L?=
 =?us-ascii?Q?PKyHUcNyG7LaS8XPS60243yB8Wv3NM9FQkAeIERK9mO+cLolRZ9yeB4gH5qz?=
 =?us-ascii?Q?yDHKNE79NsE5N5ubEIeyLAjdksc+mqXujFQr3LB1mdwCW+QZEs8VX18aSImR?=
 =?us-ascii?Q?HtY+dDbjdTPFhTM/0IsGCU2/+fu+TxF+MeTgigPiMH1PoQskqx/P/2TisxJf?=
 =?us-ascii?Q?OPq6yNuiVoyYLo44s+7e5v9PMOlQKaUZpS4NJp8c+7v771YhvmkERt5mLvL2?=
 =?us-ascii?Q?FD5um+ZIe2bIkcDikY6/a+LS9Qhn4oAKmM7eAuzaJOUgir9pZQtbpE3Fafil?=
 =?us-ascii?Q?nWX9hIP+jpIV+2AGqmX2b1hhbVmvt8sKcxOLlMRvXIFTnoIV9ABbFfqVeLmb?=
 =?us-ascii?Q?7l7lk5Ytf0Vxwf3OCpyEIzIs1RLgRxWV584UJN2Z59duSbOOxv96bblv+2Fp?=
 =?us-ascii?Q?n15aOAtL3qoq52xCmw2CcXesgDEpe/dni67xbSROACXfWnv4Dg7AGWtSLUuc?=
 =?us-ascii?Q?SEgdRlwCV12sQMTsd4QF2WxRCMTW+M8uTc0p7S97wNRmAmzZ3StSeN+IZRIN?=
 =?us-ascii?Q?MVhLg9+tqBwjIOSybU0Vxo1EG124/eXRWSiwFpg7u6Y+ZmFKPz25EClBYy+s?=
 =?us-ascii?Q?/5sgZdFsac0DJ65+9UaxslCDa+A30oRqZe70XbQsMFWukvLOI8sLge491QXC?=
 =?us-ascii?Q?iOr28gSJRXb4SJks4yABXb5E1VkYsGO/8BwKRLx2L4BYvgsi8ufz6NuD3rWM?=
 =?us-ascii?Q?5HxftFt4ds2YIy6Ry/8gxnGD0DOpDRjyF9OWxUNF0cUNr7OoCBG2ZJY0k1Ey?=
 =?us-ascii?Q?LHAMb/ER1R9IOyM6UioztFQXoCJ6VgzyZ4BrQFJPSJUnDsAsnLdFRVgmilLm?=
 =?us-ascii?Q?Jh5juygaFW+cUJ4fOq4NQf4YNCvywjIb6uf6RyFCx0U7JKbX0yIkLZ6k78OF?=
 =?us-ascii?Q?dOtIeUfyct+/Qy1Q2SI4/kW2leuF4Ed6qgru3WBk+QsTa5PWsuZIGdSs45pL?=
 =?us-ascii?Q?hWv8uWQIyDkQv5ah6z9L+zN09G8PlcQmkwt0qBuzymFgg3C76C4fEeq7sUET?=
 =?us-ascii?Q?rZg9GLywKujawwxdseahrPBmA/PRk7QqXxBcbAiTIDSSCOHShe79DpQ7TNFK?=
 =?us-ascii?Q?Lh829DAWvVClVHg38T5fNy2moTtGVE137Gj4v8Fd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g/YJu3Ubn9IZu0QrQ8lW8N8I/h0jQoCn44MZGcvDQjRlvxyr5H3IOZnlWclZsfORT48YYAAVwfbN3QWhDetzPritfsfNt4AldzOt+6uI3bp/MrXqHueMqJzNxSYoLGilv/I8LTWoZ96+jin06Gvm2x/cOivyGexW12IgCjK5fcVSxT6J7s9XxH5REeEqvH9F3phx8VMEPMcFTNXXSBGp7Oz0OI9oPtrPULvgP7gfbd2JYC36HFKw1Z0vMV8ohHnf4ClOSygoXt23FSulkhk2w0Lk0WErsVvF1IrreBoUaz+IaGmRBViAS/KgB0LlJE5sG4lOlCQ03sfzyDLDOm1Q6/NzmLAGMec31ZxlETbOghRCmcGvcT7IRcBXiKVNG/L2GhH7/P2hZf2Ke+x+187NgyIoaxXFTWNu+QXVYwrilopSnuPFG0JUw03UGO15voCuVG92uP73QV3ocDdjV82ocBKStAkoBdvODYD43DjcmUt1eVspC8IJS+ROddNEtWvqtUcPrOBRk+OYvJxsBn5yU7+Wva447mfnHsTGcaApj//l+oAhDPzF7sD9SXt+M7GlJubtUhr2eEB0asjRcXxgo6fy7qZe7m6sAuMU4mGPqBQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23957f0-4f2e-4e00-34e9-08dbfc33a313
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 23:31:31.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HVSEr4gKnuiTtfVcIgTQ6usCnZJSjN3PxCksdEZ9G7coQWs6WGtfAvsAfJdr4y7Z5O4y9R+2adi3Pmm34w0GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=739 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312130166
X-Proofpoint-ORIG-GUID: 4EoSVkj7zBbEi5kLDW2qaZqRxJ9qzFt9
X-Proofpoint-GUID: 4EoSVkj7zBbEi5kLDW2qaZqRxJ9qzFt9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [231213 17:18]:
> Hi all,
> 
> After merging the mm-hotfixes tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> lib/maple_tree.c: In function 'mas_preallocate':
> lib/maple_tree.c:5506:30: error: 'struct ma_state' has no member named 'end'
>  5506 |         if ((node_size == mas->end) && ((!mt_in_rcu(mas->tree))
>       |                              ^~
> 
> Caused by commit
> 
>   84bda0b24555 ("maple_tree: do not preallocate nodes for slot stores")
> 
> I have reverted that commit for today.


No harm in leaving it, but akpm made a 'fixlet' for this [1].  The word
fixlet made my day.  I assume this will be fix(let)ed tomorrow.

Cheers,
Liam

[1] https://lore.kernel.org/linux-mm/20231213130923.cc00317b4ebab1b0864d8b42@linux-foundation.org/

