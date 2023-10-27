Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA737D9B38
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbjJ0OWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235003AbjJ0OVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:21:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CBBD40
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 07:21:40 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDUskn003826;
        Fri, 27 Oct 2023 14:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=JKTYT5BxlbaGonAa2TnhSCzWkjaVv68+3ghGsHnInQ4=;
 b=zi6OOocedOWJLvt4qyLxfLtsG5lUFgVhEvCCY83mGWNYmy4RikYowQi54OmzH54izu+D
 V9lRL96KUtSIk4aO6J0+BF67irvlqOHTnxP8aAqL+H+T0J8SU2ZbbRWTVryseGmrYIZS
 DpDrCGHEVZB1utEwlKg+CDyMpbUUlLbzJMpQYODL4Fcg08/8mBIGIzu9ejX3ghCQoyd4
 CbNsB4WBE8T74cVhtOnVPS6X96FQreOg8QaM3jKneJRmNjXJHGeCukYVRhlAw54TA6Tq
 mxWRJ3sM2E9MYp+RRfKELwTvMNHu4dXODcleTfu7VvIBxMv5ldSLdy3hd8kxUqSLbUXU MQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tywtb9q03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 14:21:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39RDebOb008316;
        Fri, 27 Oct 2023 14:21:20 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tywqjkbfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 14:21:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGhAD4n5R3e6VUjC5G1MYVJK67yr4L0GSGg/LzKFNY7uCobspBaCe91H7TxQ6As9LuKC/5CITZe4isO9CEDemr5FaSuTepX3v5GcwCZOrhsH7rmno574D8//+htbU21Lvrpj13TK1BfZAeiQZ8Tu620tscVpDsGOL1otyXOeWqEVS4fOY76Mrw45W64DmZdZMtW1W+9CY9JHy2KRMSfqIcT5SZAq4Ml5BfDzLVv8MKxOFFwa07Zt+RtrvQaqOojpxtitTewCS0ErwD4/dYrzDgNd7iE/Wbdw/1eHQp+k9i5WfbBAaxc62lGectmelOIqGU4eKrTcEkj+AMDtbFWK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKTYT5BxlbaGonAa2TnhSCzWkjaVv68+3ghGsHnInQ4=;
 b=VXnvkKeqHY5P33Cmwe4KI1IBI9VyPsGKbci1R8FWNOPEHiKwnqONr49QNxpYtQGB4h/uYlZvnVrCAU1EoA/wWH82Yis9A6zL6IfGRM5Hn0bL/OyQV9YxHSValBhgMwNkIlX3wB/x5Rxm3JtlLjwi+6czRJYo1X9l4ftNvrmORlpJa4bMvIO4SC9eafI10EtlssQqo/wJlof0XvJwj5nDxMBHc7adJx9mH44m3AgEad7FtJsRZj7IDuojKPPBbzYBDKYSgxW4wErtM7u1ixHzXewHQFnPFaGM+EwtEfOPVMgKDVHLt9Zq8g2EGZaHfSllbPnwpehNkc+cUReveMrfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKTYT5BxlbaGonAa2TnhSCzWkjaVv68+3ghGsHnInQ4=;
 b=w+yqVY1o4izUQMo3yz5OeurYVXxFKvJk9S69j2B8GbeDw4HHfHimWtSi4bGLrK9dFCvncwzpMmoTsfWQsUvdXkFREA2SayR/VuLkgbXMJMe94gd9O+oglm45RO33g3VA/cbwuL2RWlYus1Z2HBx1l5bDY7Px7S19fXGCgdx6mAU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB6678.namprd10.prod.outlook.com (2603:10b6:303:22c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 14:21:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6907.025; Fri, 27 Oct 2023
 14:21:17 +0000
Date:   Fri, 27 Oct 2023 10:21:14 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] maple_tree: Remove unused function
Message-ID: <20231027142114.g4tdluquzzfetpfa@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20231027084944.24888-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027084944.24888-1-jiapeng.chong@linux.alibaba.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::12) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: b8e7ab29-1b1f-4284-7980-08dbd6f7fbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHszOOyrkBsbzBI2/mWpSLCesrZ2nG6uLKA7GKLWkI4NAW/lxU+W9bETX100xYAcX9guWgpOaCWSLf8AhXkU8Lj2V0ezxResTLhZQXi16LCYJua+XzT1OAz1vksXOBbOOch85QTmdhedkVMR6XqLSpENsLgbugPwe9qXliBQsMLB7cfrthBg+4RV8jDJmFmVlMMGjqZsnetGQdhi+CS/A5oPBziRHZ0cL+dXrWXv3G+aIJ1Tyk7xIEbnO4Yn+JGgN5QXRAYtssujiBiLMsTElrd8cJiiGKzZBNvkDpzhxRcnmt7bDlQnb/KmZde6PJIRTe2mD5+3/ndL9TSlLvOyVTGIcKh9cHU2b8p6yv1SWqgKs+plub9Vq/xzqs0DD+wvmpmwStsNbFOqSgy8hBeI8hxH1b1yzpGIgGT+4rFulS8KDJjvd8kig5SWUUFCZbjfgaW/TZQ8AgbsKTfd2Uy8TwugzxV2tHdMD/BQka1nAA+4x87stRpINflIyjGeaykbwhYihlfh/Y5nKiK4w2yc8tcYzLQwxAeVC74OO8643KdIPd8DHtgc7KXW2NI+OvprEed9hIBEADLB1vai6IbWr5Pb0aLNvvgoQaoEBHcLsfjVkP4bRxVTciPqp/HYJp8U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(230273577357003)(230173577357003)(1800799009)(451199024)(64100799003)(186009)(2906002)(83380400001)(8676002)(8936002)(966005)(4326008)(9686003)(5660300002)(6486002)(41300700001)(6512007)(86362001)(6506007)(6916009)(316002)(6666004)(1076003)(26005)(478600001)(66946007)(38100700002)(66556008)(33716001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B+NPScE+rdazOB4LB8cORaaPaZR/VQ0vrcovysaUucytOXSYY57+2Afy9AQp?=
 =?us-ascii?Q?yTh0MAUxViOEEvN5ZOw7vwXgQN4EwqiL/11D+zELDnj79NRyjO7dvYIR17vA?=
 =?us-ascii?Q?Ekw+9tYbJqjV3VgTLHf9+MYNcm3yHhgvIJyhbRaKDVpyGLa+aMV/2RmpVkJV?=
 =?us-ascii?Q?wvi5Q+ZDLLviMjTFthT9AGq+Et3WxhaloOPHT7V2xRePs/KcIXSDCJLiWhPJ?=
 =?us-ascii?Q?xvBUI8JG0QfZToHs5HtuGj3VC93uQxkwbfeAGrT0xyBN91no2GHFuM3J8HXN?=
 =?us-ascii?Q?tLcfIl3jXI44oAS52jrzxx9neiVtEtbWXs0hC9HlbIgEhvfQVSh7nmOuPgVp?=
 =?us-ascii?Q?3ymBAmniooyvalWW7Pb9ZkTvqskrSfgYTqe4hm95Wd2yRa/FpsRjgO/U1dSg?=
 =?us-ascii?Q?odMKO0rE60oDL6l/DxmZpZ8XE8PPi45m33JYS9mzHuGA2BEcCvTSLtmLDj8F?=
 =?us-ascii?Q?Y6dFujP14t0saF68ZwvXn22y62zDOb5TvSMGuDC6KG9D3NTby792ocbO47/U?=
 =?us-ascii?Q?LW1o2yTD1jLF55j+GKBCKuIW3qkbZHzy9Yqact8oTytAnJ+6EGbh41npwAxr?=
 =?us-ascii?Q?hJsqmvTkHSdCv/qFGxR1guvvfWp0jAZj+TRdXII79tkug3GQzwZ/t/cL8Tta?=
 =?us-ascii?Q?zyi6zywov7vI041trMe81rDehSh2NY3nok4KGp36aPGa40CaHKlhYcRyWDXd?=
 =?us-ascii?Q?/ycRQNLMsOEre3c5aQxsAfSvmhambH3kuvBxCNKVJnnSi48Cob2bB7aybZIa?=
 =?us-ascii?Q?AC5Y/msNzoKeiNXNN6PvuulpYXYiDHxjfzcrNQLq31X8JCeprEFT+XpVSTcV?=
 =?us-ascii?Q?7p4Hrci4g+IwpSmlrHRqTu92m7K3Xl3cJ9qo9BagG0K+mBw/GV43UNyTuDKN?=
 =?us-ascii?Q?DnYERfDMYJhvTV/fixaF23K2AI374AG6uh546dZSMfFEMQubCudHzo5ooS6I?=
 =?us-ascii?Q?TZMIBcxwcJ2F6elavSkg8S7J8yxYGhAlAZBTI/MvKv7uXSTmLKLNzfpY9/Oa?=
 =?us-ascii?Q?QNj6KeYpLMOhk8Ayt1e+ebIotChiPtPXCPG/tasB/obn1Pq1pfZWNvLpXkTr?=
 =?us-ascii?Q?0s1cxhAgRhootSjCXT5DAkYYVRDVN0ete+NXj4ID7GpCLRlm2CdEg+DPPrv7?=
 =?us-ascii?Q?5F36PVenLUHcdTlfE1p07/XpV05NUW5OMdj72YTJn7VSS1ICuEtg5IBa1ott?=
 =?us-ascii?Q?ChdzYrz/Kc5pXoCIbCcwjRu/rUiQLYpAXgOil27nKAHG7ueJ0izumYImwWJW?=
 =?us-ascii?Q?dF2fQyxnjhkiM/3/pDfj+kcSGHX4OpBoOGnWNiYhhKaWpG3Zj2HEnRBXiRJz?=
 =?us-ascii?Q?U2g/qUw8t8m/gE5NCTga2YJun7vPj8gdNGO4as6+XSHMb8FbJgHzoXWELYSV?=
 =?us-ascii?Q?tXJqLiOUW+hOqrwDlx2r/2du4xllo66LgUkbvZZfdPwRmxfw+LI3sTQsWsv9?=
 =?us-ascii?Q?UwcjnMxNUMU7uN4s9APGPQ/O3o2meuEun7xSdDT+ZDb86NgXqURYMqLogJDE?=
 =?us-ascii?Q?DBxZWzn+Lw9djQHnIxZMx4TLAYsSz7ni4c7qeHlclGwxfi7bcTQlGPW08U5+?=
 =?us-ascii?Q?05dYVo3TYJD93Bul7IDsYUrgFpkUpZuPLiTyfWCN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N0pdNxrU5gFXjnLsl0Zia7RgHy1+vYJraPJmvQDZ/SWvUoA6gutor3BteI7kAYNkdrZQCnT5WwZ5//kaLCcPWHTNxE3T+f9VvOgKVBCZjJazLJik0RZwso9OwTtNu8T+mHvw2wXxWrc+ew9ZnXUZ7EF6VY1Uk3TMKljT6tc77gsB9wAVXLWeMpfDt9uOA01ScwXl1Zfmr5LPONTOT63XYMK0gdyUv19rp82E3YU3RCvxm4sIDz6NwGJL4wiqsKBy8lHqodj/LZM/NXI73jcHemvLK+N1/p6ULWTXVha+j41XisHjhKsNqV0TUx2mkCSm8QzvgYI0HvbawV/BP3piDmCRTu52vjlW5ClsLe9oKsoBKpD9FkiY3qU0c3BcU3xVNH1QRIr7wwJw0m0WKO0jMPqQ7epHvbtOATm2PoS87j5CJhKSX0+dKOHLHHFR8y4FxeRTVomwfgX/OKTuHAd14rzn5RNsBFQ4dOvdNUTe5H30vTkwuv1uHoijLNGkLIjpJr1mK0J3zUPuPwwRwGZuxuB9ujdxIEybl5ro+ND9rdT5uX/1NSrNST4U9Wsyaz7xS9uVseT5B1fBy0+NBJ4vfkzf6Yoyw9BtZh+8VXsZSn2gOQk/q8YfDH1CXAVJ/VfemF7Gn5Km9DMXLhk/cd8xQ1GUVK+MayB74KR4Dkn35isO/nY+jVU/4Z811W56qgV5xgMwu1fMeM+dP50/ON1OUEnuJ9ecFtw7vytlJHk2jlHsuL5hHPrB0NR2QwzDDoxWQYyobI+wD4t4XHVPJeuUAUmNLTsLWkV/2A0UVFFIwqtJCJezX26ONVS8d7tC/QBFjLZXPwSAUq9TAifmiQYeQ9NCW1ZCuuKcoeLV2rT7e5ALiyD48naf4M/8EANYB2Q5kWQasxbx6qn2tthyCKki0Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e7ab29-1b1f-4284-7980-08dbd6f7fbd4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 14:21:17.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UB8SKOCUMqPslDfYB2xllEhhnmulWqlqgI4VyzsMwIREvUp3IUQRSKPbV4hu+K+oDv5bYEY1eDEuXwByDVjTIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_12,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310270124
X-Proofpoint-ORIG-GUID: JuA6HuNF8fg7riFtTanWr9_5tWsr6Pm7
X-Proofpoint-GUID: JuA6HuNF8fg7riFtTanWr9_5tWsr6Pm7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jiapeng Chong <jiapeng.chong@linux.alibaba.com> [231027 04:50]:
> The function are defined in the maple_tree.c file, but not called
> elsewhere, so delete the unused function.
> 
> lib/maple_tree.c:689:29: warning: unused function 'mas_pivot'.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7064
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks, this has fallen out of use and isn't used in the testing code
either.

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  lib/maple_tree.c | 29 -----------------------------
>  1 file changed, 29 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index bb24d84a4922..cf889aaa0011 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -679,35 +679,6 @@ static inline unsigned long *ma_gaps(struct maple_node *node,
>  	return NULL;
>  }
>  
> -/*
> - * mas_pivot() - Get the pivot at @piv of the maple encoded node.
> - * @mas: The maple state.
> - * @piv: The pivot.
> - *
> - * Return: the pivot at @piv of @mn.
> - */
> -static inline unsigned long mas_pivot(struct ma_state *mas, unsigned char piv)
> -{
> -	struct maple_node *node = mas_mn(mas);
> -	enum maple_type type = mte_node_type(mas->node);
> -
> -	if (MAS_WARN_ON(mas, piv >= mt_pivots[type])) {
> -		mas_set_err(mas, -EIO);
> -		return 0;
> -	}
> -
> -	switch (type) {
> -	case maple_arange_64:
> -		return node->ma64.pivot[piv];
> -	case maple_range_64:
> -	case maple_leaf_64:
> -		return node->mr64.pivot[piv];
> -	case maple_dense:
> -		return 0;
> -	}
> -	return 0;
> -}
> -
>  /*
>   * mas_safe_pivot() - get the pivot at @piv or mas->max.
>   * @mas: The maple state
> -- 
> 2.20.1.7.g153144c
> 
