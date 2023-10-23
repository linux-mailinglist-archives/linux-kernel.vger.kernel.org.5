Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531CB7D38A7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjJWN7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjJWN7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:59:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F150D68;
        Mon, 23 Oct 2023 06:58:57 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39NDSprr028469;
        Mon, 23 Oct 2023 13:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=t+a/F6HLTZLr8QMWM4d8hU19xWHbpG+qdOi9BR1Oqhc=;
 b=oedIN9hVtKgilWyCUKdZyxeY1NkH6vZZiyl7Oor1yB8o3vSxItt5KEtHOHGJJBxjaqk+
 lMKQonNfEk/NV60avRQF44nbY//8fBui8UwFmIPsNuDQ4v/Fhnq8GvI109l68l9FRdY6
 qij1d8r6Yy4vSbiopKZO7xXwCX7HVPc1OOLyQ65s87WHQKZ3c9W8JqWUQ4oGSErzW9z1
 cUoABmY7Ro4lqABvPA8ga0dGdv2FL9xwVLZCiCi6FoMAZtvqCGIMGpA49/MLdIUYMwsh
 YGTYggGUhnlx8v4UNbye/S3nwvlIRxaUHZ16FNxRHsZpi0jKhrMzdZO6ZnABYF4MEmVh rA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e335bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 13:58:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39NCUKh7015128;
        Mon, 23 Oct 2023 13:58:37 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv534033d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Oct 2023 13:58:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOdmEq5PB/5nJXtxUm+qKHZSvu6EdxveaqyPQUi2vqW+cJvzBQhGleJUrMsNflz+vxoaS7RTNgM8tz412+JqN4CYQif2u2gJRqm2+CuWWH8faTPv3a/+U1zpIEtnjdaOR7M/WAzEaWEXQUvov1GGvoFUOJpLFeZkvO1JmvbF32NMp7yDB/jiCzLJfJ2R5z2Ia1j70t87GjGFyPnrycjt6FgeDB8ZQF4se9WkkeAz7YeUtUkdge5gFiBsivplDsnZF69G9UV5DL4M7sREpj+51f7X92drB2SlyGoCSwL10NXG01Z3KcMXvB0Llp/F2gVPZhoKihZV2CcnDSbEeJPC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t+a/F6HLTZLr8QMWM4d8hU19xWHbpG+qdOi9BR1Oqhc=;
 b=FX7NYAEqRB/C+A8lO2O9XJ8AT9ldnWhIRwjy0m21d8yUtaUFhkwnTYvQu3PW2NtvsCbB9ImbOwD/SO0NEF2wPN46jsNuKfcdakg7i/kj/nVu1uWb4GSFPa+Ac0XKjX1I1foWAzohDvLR+Qb3k57Qo12GfcqB/qme09siuZJkl2ZuHAJzpSo0a6BdyzBZRx2RDTQ1xLrqzg3/6r9F4RNJ0GiE9tiguSy6+eyQRBjlg4mvHaCrVGU4uY9yasBDAoSHWd8YYVqebtANXGaxQ0Cn5yh3DpWuyUcERDI2B8oQMtygDE604fxWCH/PgdWs1J2VGjdiZMtE3B7HJP2bSfCQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+a/F6HLTZLr8QMWM4d8hU19xWHbpG+qdOi9BR1Oqhc=;
 b=sS8oRUZ8juKvq+TgH6bIkBCrsk6FGLmdkPMntEg0sksaingxpOILu8ZVFCpYBGGH8hnQQse8IG2bwvGoWdNzTOp8XbBYrQAy1qz4mJk0pAyPP8JoQ39Hl+4mAW0pJg7Q9SpjV6Fk0lLkuompy2JRWM+yPglPRqxCKMZ3EnOOVjo=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 13:58:33 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad%6]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 13:58:33 +0000
Date:   Mon, 23 Oct 2023 09:58:29 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     WangJinchao <wangjinchao@xfusion.com>,
        steffen.klassert@secunet.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, stone.xulei@xfusion.com
Subject: Re: [PATCH v4] padata: Fix refcnt handling in padata_free_shell()
Message-ID: <nqc5zfj5hjgk476o4iyehhmyadxvzjkz76ama72fzaasxjrpk3@liejkxexgg35>
References: <202310160854+0800-wangjinchao@xfusion.com>
 <ZTIKP94KBuqhyj/k@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTIKP94KBuqhyj/k@gondor.apana.org.au>
X-ClientProxiedBy: BL1PR13CA0166.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::21) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SJ0PR10MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: b836bcd8-3c3b-49e9-1948-08dbd3d02533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpL3KEbZmaDJCZTch/iWKLtK3D1e6FM90Xj81KUbrLPTfWGm6Cqb8r1SzYzFMOmuC83Bjzw+a9rQGBA7H0fKe6ig2r+tAhusRbywpe9hAyTIU03zqoYOSfCeKNkwjeIoPopoedLWssp0A963wB8J1Hp4L1WnavmyJPm2ZAvMly8n4hsuNoFMU2OlP1Ijad/PWvY+/LjyH/bxlWY7LdwgSPIR5iVOJ2WZDpk71P2XAf6LRocETuhBWZmqDnJpG7zGXL5nCIGQr/n+KnGDXQxSNPp20LEyWIWmE6Cx+4S2reHaQjyU1qR6/mGui2VEj0S8+KCzoah9OfIWjyRkWtVJhN316s3I8REcKzhdDbD1ZslM8pRIRbmrPYQrlTW0yfqWK+O38blIpbEE2ev0fo8Rz7vptPcXDPl3+BaY9yxUVZVxocsr+Puz6O8L0254AGm78E7sNA9vhSctOV4IkvmoIJQGrHqwgX43dlWHmhPWQJGDd3nDXRqhVnUgC6yqZjp3K9RdpwWbBI/0DD1dJXZz9SRxFuJiKFwclSnvnaCp1E0nsRUGQP3UZraBmUDgyAWX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(26005)(33716001)(38100700002)(2906002)(4744005)(41300700001)(86362001)(5660300002)(8676002)(8936002)(4326008)(478600001)(6506007)(6916009)(66476007)(316002)(6666004)(66946007)(66556008)(83380400001)(6486002)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MsIgK/xJHmyRpUWPTp8PdGjwAp9GwxfdHe6bicPnJxX2jcmKIOczivRmj6m0?=
 =?us-ascii?Q?OEXm3pR0vaSKYdkwdzWpWctv54SjoRkku4qloNLTuAbPmkX87SILVDtfMZzi?=
 =?us-ascii?Q?m2eUoWd2CpV5H4XFDJietFkCggDbemdtoHrqs6+mKwhAcH6m0sYiZkd2UcLt?=
 =?us-ascii?Q?SQmL69fRYdiP4r5DFullF13Lsl5QB8fjIsWC2eyVfO3dAfoZIcC8CxgwThkb?=
 =?us-ascii?Q?lVKHKucwsLk93lnx98gnypLWRZNp0UI1PvJrfQj6K5bwFA1L8wvutZeFh9mm?=
 =?us-ascii?Q?iiUwZmd3WFX951P5rXYOR2pHR3FYh84n2DY/55eqka5C7xEDAO2JC/GIEDZE?=
 =?us-ascii?Q?11DcCcASQ5gyMESmwaaQxvED8WmKcu+gUEK96EaubOHc012CpvdIlX6g31/d?=
 =?us-ascii?Q?nEz6wJaaYmr/r94rqBrb/2pJDOw/ZJ57q64s4g3lOjugWGnKzRIqTH1jjiL9?=
 =?us-ascii?Q?Kxz0Nn2aEW8hibjad4U2TzVw6oB8oXKd5a18PVB9Xf7G21ZlJfbjGl59w/Kg?=
 =?us-ascii?Q?KC0X/4U1ZdAzO5qxedEHI19QJdqCukS92+sSfVL7vnKOfWip5u4k2Vq/gC5Q?=
 =?us-ascii?Q?+6XHvPAe84WwlpKYfCftGoPcziR+mrssHeHdreOmbNeMecLcrNAoBD/AYSGB?=
 =?us-ascii?Q?faNINcRgohLz4KMQSSyYVOMqcIj+bLV8T0dGNK+fxKc/RJ1c9R1Wst1150+S?=
 =?us-ascii?Q?aIRMuyPrSSPa9Q3STfFLx5vTT2s5GTQoUO8dVJmMX1ShIUjW+3G3RT4bLvcJ?=
 =?us-ascii?Q?u9+sL1GqIGufIPLbt0vHRLhZhujaaA3aBfwWGsBTpOJGLUDCtdyRJgMXsyJO?=
 =?us-ascii?Q?kl1+1q0yXkDpAoVRvq77Aj+ZOQN7dFbeFDMlvExgbeJjvQurHsbX6kfC3cgn?=
 =?us-ascii?Q?Qe3F0ytKtMq2tCd+/hKjZjj/2qhpl4C+l9Lm+tzu0F1acblhsLlXdEUPgIxc?=
 =?us-ascii?Q?NjfXqDKJzGbAyHdlGPWUagPk6sW8Rh5xOVX9i7wtA9oHyajITDHcUz4DWCb4?=
 =?us-ascii?Q?o4z1Ejj+qxkjdCPtLQMc3UdCJXNK/SCf8KGgVXBT/sK7fQ04bAl6GkF5uJlO?=
 =?us-ascii?Q?KHlSjiRG9ZKAlBWjwauUSiYXjc+V43MRx1/R8ql09YdZhDxISqtJwxacmINP?=
 =?us-ascii?Q?L+KOci02naSP6IJMTD3F6s88DN1y4YWgwbHi/Bx/s/M9mjCeS1cl7Y/BtHLG?=
 =?us-ascii?Q?NtE4rMFkxanK50QJ2orbs4CrHt5Odotikt+ZJm1b2sWLO3YTuRy91yj4gTRd?=
 =?us-ascii?Q?6/jC113720yuZXGtpL9vyzKAFhJZmfAI2Yh/IVV+OCZBytHYX6HjyR/MoZzk?=
 =?us-ascii?Q?HqnfqwQHBfiegam/bfVrio6OGFfat/a2AvcjPSVj4zmB3xPKMdAaI1/yqr8A?=
 =?us-ascii?Q?lfbnBjA3pVxyATxGpy9aAmsjvfdFUxed4jLJXR4nUwus85+BJ+XPccWwmd8x?=
 =?us-ascii?Q?UCV+0zA9Q2E/uPb0TOuX+z+Qy2i+IyOkxTHqkaJ9JDMnR4G7t8+t0FhUrus2?=
 =?us-ascii?Q?Op2l3wKBIgqUAB5LEh/UDz03gI1X5oSuLdC7M1jLfEdngVRjudITxXlgXCHT?=
 =?us-ascii?Q?gw683rj7EPDyC29DnkJqF3Q51IlGBWMT5VHgJ5z9v5Evb42pwXAl6PQBMFLi?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: iObDny2ZKWvZlo2KWNCSbE0gqtDoHowgxBQGJShRZx+s2AVBTOnXNMON9lqTg2LTILnrCzzMn37JgAPB/py3QogMuDVISn0OMXhw+Srk/aanS/B+WN3gz2Bps+fAH6ESlpWx4HM5N4A/7xwRBK/dGSUDE4NPebBl3hXkBc1/auIPXvcl4FNI2NxhywjTQYx8V1WkEWwYB3yu0wTDLwRMj6yK0EZoUKUzYarRhMwdO3d9vnF/sHxHGceFVj8gOTUV6djuzpxHJ7sDeuiaUIXDKqrMVSiSXqufr8lPnqx4PXX0Ie2sLk7cdC2Zmay9NIkZqf0kLIOR+T5PWOx8nR6t5M+9uE/WXz6zm/JFALegAUhVmpoM8x3HypoyGJ8683H1/+4uW+xnB3aSSZLBG+mDxOmT4vQvJmy8WeTMIsFujxKpPcZh1SwMKYJYs4nbAqIXaz03s8EHaIWbl0TtvNPQ+K1utaGaJs1HEwKDu6zKDR0/9P9xa1O+eyxN4tuQKXaPXq+cCRFlDD6Ieu4ZeIGpL5MaB0Ibq07/boUm7IrJKK0G4RvGAb6NFhfYlWD1H7pliytBBopjnBY5Nm9+kMSQIL3hPadwRdRvCyIClGOr75P+WN27FqR51O9davQMXU5Z/OKgB7CSYQQSUNFYaEn/bds6IDSrVIIFbDlxbXKliBTiep48m/eb4zU4m3+40bjpzm3onf7zDhJYPjZSCGWrpl2aLrGTdo13s8//UX6uRTIk0xzVf0hqo2fZXzzojsHf/tihwUYOBvBGQBiAfgyfuEWiRN4iz68mOFzLedzMCLDo76XdCWZrG5fd8jllxrX7bSrB6v5Z28F8wiVEicoZVzFZa8ozmre4odgQmpQlMh1cuEM0lY9+4PJlJ9eW+k0A
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b836bcd8-3c3b-49e9-1948-08dbd3d02533
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 13:58:33.6026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rgxt629Nq80tjikfrsjCpcahkI/mUk/Ni95v0j0VAydTOv92MmEwDa8O19KKaR1+VVeyJ9mErHr62/AbGexK1lHwzEScdLxFCpRUm+DfQxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_12,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230122
X-Proofpoint-GUID: ALoZDMAd3qPrD4GekJ7wCwUNfNFnFVoq
X-Proofpoint-ORIG-GUID: ALoZDMAd3qPrD4GekJ7wCwUNfNFnFVoq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 01:03:59PM +0800, Herbert Xu wrote:
> WangJinchao <wangjinchao@xfusion.com> wrote:
> > diff --git a/kernel/padata.c b/kernel/padata.c
> > index 222d60195de6..73108ac75f03 100644
> > --- a/kernel/padata.c
> > +++ b/kernel/padata.c
> > @@ -1102,12 +1102,15 @@ EXPORT_SYMBOL(padata_alloc_shell);
> >  */
> > void padata_free_shell(struct padata_shell *ps)
> > {
> > +       struct parallel_data *pd;
> >        if (!ps)
> >                return;

The \n after the declaration disappeared in this version but would be
nice for consistency with the file.  Maybe when applying, no need for
another post.

> Daniel, could you please reconfirm that you're still with v4?

Yes, regardless of above,
Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
