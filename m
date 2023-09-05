Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092C379269D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240580AbjIEQJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354641AbjIENMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:12:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C109E19B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:12:33 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Cu22I018760;
        Tue, 5 Sep 2023 13:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=mfQQlOjOG2JGMDWae8WCt+2X1/8NVDYFV+HqSf0LkPY=;
 b=KxILkhFbytr6evVGnId9BgO68phC/SFw999WiqbEnCG69b1gOIs+vwtxuYyftYWww7Hc
 cCK4eDYKP+hnESwI76SfYe6JopkzKPC/XhNSDMobgrX82kY5OkQLzlOpjOXYG7cba0pZ
 sujrjkttyiRHFjDQf2EQcRKuzkapz/fecmK5unIuLfB4c11EAjHvXnEPdDaLGHMvMEjR
 JB+W0wUJA0kp2T/BGxuukWXzrTfqTP8juLhLSRftjItqV08Yu83zPDTcfxZwXiY4W2BO
 /ESqjXgUmBp8DlzCK+owIHJQ16WeSfCXvXCHiEfJZf1G+x2il391hB+/y7SHuEVniRtW bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suun1nbhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 13:12:16 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 385Bonub037080;
        Tue, 5 Sep 2023 13:12:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugayv62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Sep 2023 13:12:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ETYqf0229PL2UlYm5+6lRDhHTM4a087MzMeUJP43HA2g/xBqqB6IV7LMM64BNO3FCAcxVW6jM6e2060RriOKlhb3C6sA2bO1GbwEAXMlJ3XZ6/4DhsTDlPZ/iuxR+bcNvQoCeViinfwLZ/5Xa0fabGGcxL/QMy1V2GEm9zKn2krtRHp1xtkOwur2Bf7QLlg1ig2MAOsYak9rFOL4CidK39R7zUfssoynyZM8lX2+nc32rvJI95piNoG/JYeYJd5DquK6jhwiHponVmVRkUkbRuvIhITp/cEGpS5aIZgTi11+h2tEmW7CaaBrInzCry9KHS/W8h9/zhbi08Pw0IRIIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfQQlOjOG2JGMDWae8WCt+2X1/8NVDYFV+HqSf0LkPY=;
 b=D1k4V7jxGqzwlvMp5ABxtU8H+4MKXIrHH6TJ69mpL3ZPhyLRmlrWPWlYnh9JwwxcnLddyNiqFqfJ1/QZQcpiS+vT9eyKH1zkEmF835bvpAMD4SMlIe58AsMO2U3Not1U/vtkd/drijuvXk4ygDRHrwNRDflpDDOwBgWy+enj2ydcJs4jKtCTknbDOY6CvJqGgNwfao+Zb1vZ8yqhtJEq3Von5jHwu5bMXDElBBxSD4PNRGWrdQBZ46O+82gsZArw3GxC2WIU1BY4ZE8hSbiRMQVXn8BPAHaIo+JhNdWtwPyS/oqDbVuFLW2gAgx5zic7oSOmLcluVp+SfoaKVRvJLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfQQlOjOG2JGMDWae8WCt+2X1/8NVDYFV+HqSf0LkPY=;
 b=NXdxlLqLum2gIaG+y3kA+HMKOmmk+Y8XHaiRpBdx6sQoz0rljO/gsx3cMpFPPEZ8dx82iZXr47lvEQgGt6PxlBNGN1FdFlePnAi/ikjQoCs6pN5TINR1cA3Q7mEPdy2ttwQqXOOkpwgo807J5h18fLcLeKVSlVYIUmiQQX8Id5U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4148.namprd10.prod.outlook.com (2603:10b6:a03:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 13:12:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8979:3e3f:c3e0:8dfa%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 13:12:12 +0000
Date:   Tue, 5 Sep 2023 09:12:09 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH] mm: fix unaccount of memory on vma_link() failure
Message-ID: <20230905131209.4xacdbisz4hvj2cf@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org
References: <20230830004324.16101-1-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830004324.16101-1-anthony.yznaga@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MN2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::23) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa726e1-e570-48e4-a5ef-08dbae11b799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ppYVi0pnCpCR+eingPKTUxlvNqWW0t+EwgAA1PmOmf2xSg1OMz/hbsdv4i6jvtDQXQyzjDo2Gtj0ZuWOUvtKO+UPliWouDraDbSLuTz+W3A8gIG+cJIsE6ltyP8g9WXeCEA8l3vkaodltzhFIXZbbkcbaU6p7kiuZ0hoyZfuwr7Q+5cyO72tyU9VuEeJbf+2QBUJahuOzAMeZWlb0v/zZDndkL2N1scAOQkDaUmRpOcnyabQ8htlrRr3IPIM5xTordhNt2qpTCFPS/6TPBjAxHeIMZquYo8O5pGBFiG98ZwheOkiXWQX6h+Qt5VQgiLLAp67j/fueXXn5YJYqlBkx/7SLgwwPyWgVYpAX5YnUQYZ+W6IdHZ5Qoe9S1w/2idLbitDdL2sRK++ItpmHSQVUXzW08T2C9Nj8OT8MCoHgWi96jhuHb0oez8Gl2gpch29kdfyOzGzJk7j52UB6FNl0gdbDk/OoAk5Y6859Z3YwUnodv7T3H97UWbpyKLRGEWju7NNcBpxny3KYV2LxbPzQVDMV1l58/yoTKP4iNRPxhxQOUWRQarWLXQ7sWEl/diK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(366004)(346002)(136003)(1800799009)(451199024)(186009)(86362001)(6666004)(6486002)(6506007)(5660300002)(1076003)(2906002)(83380400001)(4744005)(26005)(9686003)(6512007)(41300700001)(66476007)(66556008)(6636002)(316002)(6862004)(4326008)(8676002)(66946007)(33716001)(38100700002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?px4c082+DEW5C4xicBAAgpOYdN7qFcBB4RiwEvulOxfDkDDK53BIyDkiWYbV?=
 =?us-ascii?Q?4g1HMzASS/uyBrSz6O3NPwKi5j8jpwe6SSQQgTZ+8V2VOMMQCd3Tl3vFIAMO?=
 =?us-ascii?Q?bwy/GyB5PgXoBl7RGRAju4J7fVrWQKvgY1cUr9xBmARNscsE5+gbxP5mBTW7?=
 =?us-ascii?Q?n+8xsWfaz3ccFwP7slLZnlVNJUQZVzwpFnJNLMkbpKfDvWDnPVGF9euLxEI2?=
 =?us-ascii?Q?m0r2kbg0BLt3Nl6WOvflpw6oE615iF4hdHPDQzmDBfI7f+Aoleqvl5j/Q9K5?=
 =?us-ascii?Q?kHx+TxAGRR4TgOD1sP+w3sZ+Ztq/lrSh7wzSJ1WC59SgAQfM6aPoICxv1IgT?=
 =?us-ascii?Q?TywFChj/GsT8cSRCuMylRFd8/biCrux2q1eCU5IsoTJMxBEkRL6IBKNH0kPX?=
 =?us-ascii?Q?kvjRs/FcdCtx1DBk6SpfwClIGo+tVtaeBzqGBvEym30fdW6qcFl+Eyhv22MA?=
 =?us-ascii?Q?lG7VcNUw/d1zZspJaKy1brmQ/cavIXLXkXNR4RvdwLwANReub6IimjXtyIyg?=
 =?us-ascii?Q?YaTMhAXe38IFH2HGtqrMe364EXasNo5XDDg3yuMnRneM9dXDsQ12GoCPzDA9?=
 =?us-ascii?Q?kzSTBNPHkZ1JdDPsqrDgNyj4qhZXSu/K0H8kpZVll9T1QeNpTPKViQrXyfir?=
 =?us-ascii?Q?MmZWwgTRnlNvwYOVMnhpBJi5c3SQahJHOtQKy3n1b7X+awca+F2pSpZlLTAe?=
 =?us-ascii?Q?L9yJwoGz3tcrQ/A7Kq2y1b5F5P3IWoOaB8DZEJrzNkQV849bfKUavygbjVBT?=
 =?us-ascii?Q?lhXnoVO337/Wwdxf03pelRkU5O6KUVllMKF1XeJaeKg94jqvR2dygnXaRW3f?=
 =?us-ascii?Q?YteqZaohsj5CtRtdGUjqLM+Ku0nyTci6ph2V3/cBe/E+5Hb/ywG6stTUPz4/?=
 =?us-ascii?Q?Mjq2i7Zg0RMyF0wTnmVcJWDYgKQ+zUH4/4ENEhM0gOXbUlFOcSJYOrHgnewD?=
 =?us-ascii?Q?Hx0Lukw+h+1PNEqvC3VMglggU3t6TP7zSN0ECz7VElPhFxf8XN8tXAq0on4P?=
 =?us-ascii?Q?f+RPNCXpx7Y0BQ85XllXziT+ADu9e3gZpHGteU7En3TUrXc4PKDHgXVzmugr?=
 =?us-ascii?Q?CXMSxTZCh2uM3vG0xEQA04A13xZWiUQidhMayFzG5n6ifrWhif1OEKyVX6AE?=
 =?us-ascii?Q?VrcrDNQNakOdz9mmjWIRLlV+brr9Z9/r0d9tFz2qC9JxYy2RSyMlAU2anQkH?=
 =?us-ascii?Q?Lw6Q0mTQafWC9xSdrHwnawYHxVO0NXsgGgYHtre06avqGzh0wDScMrkivuru?=
 =?us-ascii?Q?FhUA2/5xgENr90EBn2c78j6t6tUsVbXFkS6eirJMsl+Nj6IYLzmZHBIJd307?=
 =?us-ascii?Q?ex3AoNaytrpYw0Z8bYqXayLYj+7FSMTJslXAi+buun2d612aNInBfJVAqp3M?=
 =?us-ascii?Q?pu3Epi+VaPmMr1ZxQIEZazBMvaslufyQ/tYg4HQBbEa+pOOpo6RVgN5ylBva?=
 =?us-ascii?Q?9JX/5a8vWFOrfnO34dv4qGUt73C6AR7lqfGCybL328qs950o91c5b0IxbmHL?=
 =?us-ascii?Q?NgE8PalJxLfwSHlDTBF/Yg8i+6uce0ScqDda5XCyOV8JjMZc2mSI7BbVW9dR?=
 =?us-ascii?Q?ZRen//zxUGvXTZI5kavLU4WBeTgMdUA/mrISLFmO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QbWNfBufy0LO1tjiHzJipg70vS8EvDcmSEn6ye2GQ8OWiUX03AZ2IHHlEfq4fI/6BmwnkG57sEUDH6Q3JMhfcUrjRZHVivZEGBFy+aziCuNyMNdRhDQa54LUOGa2sSXi9KJ8hfrqwgmaKz6glDaXp8FeyGhOHlTRzVjBBS7ZpjmBF+EH2Oz3HjwSF0qOjpzjbkwl9uLQOSwYUyjw9RLQWd84FtyqFmm3emXbFkg0tECUPoOigtSrcNUQ+vuZg9UjHMZQW9RCoHfXregdZ3R3W71YXeBV1CSrm+yFJ34nsdAS1CnsJAFDYUKAenaNfinaksIlt1PwhQaITOfv9DBBLeOzs/UkV4xRPHj5Eq4FStoPKNI6xoi/YxjTwodWsI6cXMH9UAm/bcTsiin9afl06ohYWcXDknwZUUFfoO1ArWCRQUu/xSZot/yYGdq+JCMSotXalbjPGfMaNuLuzeJ1EPl1Wua9t+aZuRg+Zy1YwHXwotuHfxCOLz7zkhwCdR/XpBBqOM73ySQyn5sHNMPdrMOA46nfA3l8wTFwpl9fc888URh5s/9ZCPiZ0K7XwO+3YB/qCfynLL6Y/aQaPCVpFgFSDgKIOGzOS9IvAHGglTLo80qEZ8uuudQY2S8ficjHN+j5suTybJ0awf2MkjvL3lqlHRwT2TP6+Mov/HU9GxI7LhfYo2Hp7Zq7qhdt0wihdR3txt+5bke5C/EfTxY2lJcjlvGdVlKow4K0dlhFK4UcFfYrxo/vQ/qwNcGf5UC4w5Drhh/ZibSwzlBfQ+32X7TE16pvUiQB/m77lY/aURFLSNTq38AtxzPCpNpE04TooMmQlLLpnTIrl2xp4u99LlNuWvoY1PAhBMvU3quuYrdZW9wetMCDp29AW1fM0YOX
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa726e1-e570-48e4-a5ef-08dbae11b799
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 13:12:12.4109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0xLPCx24GeoQjw5gcDpbPLizkbnowgJlSHcdfdCLX+Vee+JVFP3IIir7SkSUtHEG6IkLtmYxn/Nxb1V4Vl1Dcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_10,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309050115
X-Proofpoint-ORIG-GUID: wcFq1ksjFHPNeo434llya3hqbJuAZuJi
X-Proofpoint-GUID: wcFq1ksjFHPNeo434llya3hqbJuAZuJi
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anthony Yznaga <anthony.yznaga@oracle.com> [230829 20:43]:
> Fix insert_vm_struct() so that only accounted memory is unaccounted
> if vma_link() fails.
> 
> Fixes: d4af56c5c7c6 ("mm: start tracking VMAs with maple tree")
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 514ced13c65c..f8c084017757 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3278,7 +3278,8 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
>  	}
>  
>  	if (vma_link(mm, vma)) {
> -		vm_unacct_memory(charged);
> +		if (vma->vm_flags & VM_ACCOUNT)
> +			vm_unacct_memory(charged);
>  		return -ENOMEM;
>  	}
>  
> -- 
> 2.39.3
> 
