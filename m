Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2A87C8881
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjJMPWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjJMPWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:22:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0284BD;
        Fri, 13 Oct 2023 08:22:14 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39DE0mpm009531;
        Fri, 13 Oct 2023 15:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=9X02jG5EwZ97F12RtNByci4gY1luSggkHorV1T0cbFA=;
 b=07qSeC7Y5psS8e/FuUZMvYf8kOblRzO4sKvQTip7P80S+isXgFrsIPBy0O3yVtOibrb2
 YvxJPkW5UIQBGIPdIYcFS02BgWdB07Hfayh5o1YbW+7iMs6JvaPqjZWAsxBPkAl0j5yB
 yKNN8lyqbk21SUXt385fDFYfX9DdaBf+GTr0dZT8FH64Zdz3DFi4fc6DiyCIynqPB8BK
 X1VHgXRkwPr58a5op/sSrvttcp3QICzaA+jVl50dnub+wuPDjK1F/KWjGxfmyLWhsFEw
 taGnAtE/KkSsjS+A/SWB/R8Ks4ygJQxSXU6KVHWJ/POEABFe6alzWMkSBCE8BY1Q0Zh5 4g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjx43w8qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 15:22:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39DF5GUL040284;
        Fri, 13 Oct 2023 15:22:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tpteaqxd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Oct 2023 15:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=heZGvDx+AWxj9FLwpQvHIgdOsumRPUGB/G4wrPABahpERdCsRBakxUokJ7euKuNSxknLiqtu4Z/CS0KbIO8nntkizTYVAKdyX51VRYMu/bJ5w57RnvjKw2vC6Yv0x/BnKa6vL67CTXF7cbFngdomoP+nymSqq6XEr/MbsclBcA00dcR9W4tLB1YnNk4m3wv7IV755FsLrj05EMN1TneQu30598KPjwL9R9eWHRMxMuIMI1bhY1oX5phWuJppagN285ootJ4uTA58Ests2fM80CnG1xWTLmEP6hf0facnGxBBgB5pnHLAycvIcgoYPg72gD+FFVMfu9q0j1yWILVs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X02jG5EwZ97F12RtNByci4gY1luSggkHorV1T0cbFA=;
 b=KFfBKo8ZzRb4Lfzb1GSbYsYoqCo5fyn40xMrBa4vwAkOL/pq25lyxbemnR9vDXPZKDx8vzkFD6Z9sMFHv00ebhBS+wiXqSdocoUxRWeVazcAfUjOkm5z3aqPS1Xr0uSBJQ3Ncxhhrb08BaFjfUp6CbifZ42cbgGMaY2FAEsTnKek40Kzq9CIufi2VhuaOCu6JbcGvn8hMgryU3rgUYm5bGjIixzmBAskEteWRiC4EzWYXPZN1SA/vimMZZG7jEmaZ54e6fzlhvDQZs3aCLStMDDx13ZyiZujoaao/tUShZJAv9yiROXOadQexmlE5WtwR1L4pFqF10zZoIkN2H+l1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X02jG5EwZ97F12RtNByci4gY1luSggkHorV1T0cbFA=;
 b=rmX9jGCR5UvEs4AG+ePlEwLzMnkaOtAUt/mWWRO8LsSewMV6JqUyfx14ljaUzsGzc63SKEpFMlecec8TSy47nONLGGZ1YetjRUcguh7y8o/h73oC4Phz1xTRfE7jGp1MIzr51czfmMnBcUB6ArJQzGPwZSAA2cHxgrVRO7FTh+0=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SJ0PR10MB6431.namprd10.prod.outlook.com (2603:10b6:a03:486::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 15:22:07 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::e277:20c3:200b:7790]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::e277:20c3:200b:7790%4]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 15:22:07 +0000
Date:   Fri, 13 Oct 2023 11:22:03 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stone.xulei@xfusion.com
Subject: Re: [PATCH v3] Fixes: 07928d9bfc81 ("padata: Remove broken queue
 flushing")
Message-ID: <tgveetqzkm4if3kkq5mzhgfetbm4nqe5coegphdtyye3xul6r4@5cr6uvfrinow>
References: <ZSDWAcUxXcwD4YUZ@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSDWAcUxXcwD4YUZ@fedora>
X-ClientProxiedBy: MN2PR19CA0006.namprd19.prod.outlook.com
 (2603:10b6:208:178::19) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SJ0PR10MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 32cea3ad-8a26-4660-0357-08dbcc002946
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zu95X7JT7NT49gopiBX0/VkT7ZL5hUuxq6G7qA9UceUnG5nZ2f9xRoTKiq9F1oi8ABi/8MlPhr1kqtVODEgXe1zKGpodNzv1K9dmXlDpry5u5UEUi0+dWvjipDVkLdyCHZs6gBJhuZgO3w6rb/DyEAiPkKuFkJdzmADv8Bbwaw8nmyIbetfAGrA7EQ5n8qVoOK7Rjz7v+GHkN7YcP3vNdcM8YaJDHP4kliFmxXdbyswn4xiwxGkzMq86BshlCltry/v3YD0tippGzIOdh8yrlI18bsZOTO1lzY1t0Pb8f7F4NfNu029rqns7E+5+gykuwkw81NSkpJ9EHbftqd7rObVr/OXFgLZhIDon5F06Op/KIl/6XUEACPrMNl+bsDByFDjlonmFcuGASCGR6aPZS0elcTEoLKKuyL4NQB8ECMrZDv+5qzFy7HSHn2SXb7T/1CkzGynR5RlcZYOsvS7iDMsjyTHpGOWNmxcG5tBMG55qn3HHVHrh/k6CzhEw/RoD1gtA2MmMn24oTSU+GmhSrNL32kks6Wm5mXHgq/GN2uyPhAYYQtKwGeEAFxMbugUMkMfyPlNsDEn6vGdvAwNE8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(366004)(136003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(966005)(41300700001)(316002)(6486002)(6916009)(6512007)(8936002)(478600001)(8676002)(4326008)(66476007)(66556008)(9686003)(66946007)(6506007)(33716001)(38100700002)(86362001)(83380400001)(26005)(2906002)(5660300002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NzZBC3nkU9vxCCLAAEw7HWMkYFQlworLiKwbtp0v+BLoBubrcFgKGyD49Cs8?=
 =?us-ascii?Q?z63b8GUVeQtyLLKNiuMvGd7fTK0Lof+64Oz/7ui7iBMOtxN0eR2H8S7XVNXt?=
 =?us-ascii?Q?6V9TpYu/12uqEcHyBFZNWzARi9LwHU5LaCiUTAd1MQVLkntELZVzcAUgYpP0?=
 =?us-ascii?Q?oB9wPmV9TkbOjYrPpdgtj9w4IpzwF1SZZezDI1X89HZjuIfGL4R70W2EkP//?=
 =?us-ascii?Q?jWYeLNLrX1AmO7QuxLZ2KnjteqCwzE+gsNReaO5U2+rcictxdruQRdD4C1Px?=
 =?us-ascii?Q?ryo8+NtObi7ZOhltSOkB5679FZlq9jYz0b4yNpXzvhNkNTyl9zHMsjXSa0Ow?=
 =?us-ascii?Q?soUYvtJGE6lTgaWndGGjJYuPVHuJgCaDIbZZ5uAq8/Bu66o/KuyKNngw2aAx?=
 =?us-ascii?Q?QOfMnhIPG2guyfSq7iNTtB/Mw3UKVPIwWlnyhXPHw/9JMef523mjQdkVW68r?=
 =?us-ascii?Q?iKDmtpWXyhDSWBuk597vpbERvOXq5W8FXxMzp4u+H5ZASIhliJcja8zbo4LE?=
 =?us-ascii?Q?QCoF+q55ppyMgL7VkyzRLfUdUqZANUnobEiKle8IjH7wFaIIk0L/EGPHFMDp?=
 =?us-ascii?Q?KGwWGvAK9X1X3Tz1n2ibHd0YFV9atHkYEs3F806o/4DfWAYH5FFA1kX8Rg5+?=
 =?us-ascii?Q?Og6SrHPJqOy2/stS+VPuldpI0pR8OBl91SV81+KG9rClRWPhHg6YmHCF2gHw?=
 =?us-ascii?Q?maUzUbFa3l3ShOVgIAWvsxmmmVUWLIxqNFYs2x6SFr85s8LTEHP06NAaXt8o?=
 =?us-ascii?Q?CmiVCmYnK0EusvE5jtOdIJJzPUBb/qKTIiDeB0j7iBTLjsJtuu6tvdHKbyaw?=
 =?us-ascii?Q?GTvgUoFNiliYS4VYbg2/xMNiwO9J7XOwK448ouSxZLf75Hr/Zi5EPDGyw7so?=
 =?us-ascii?Q?raIq6w/xqHDtPOm8OBuyaJl8hJcuFrQY2vfrPjTe4aRaEuLrih3cNeqk8dUF?=
 =?us-ascii?Q?AYKb/iHDhvKAKlbujss6DqAXikXlBxObWaDh1O0ZZOQva84UaMmUksaE9RK8?=
 =?us-ascii?Q?tZql9hVZGpXbi9BQ4rcNyZPyHaGyrLqDO5r4VZWNdf9TQCIriYdlhwkIID0C?=
 =?us-ascii?Q?T5VaqSFm4Zg+gIZpZTP/U70FRGDsohnrpQVbaBKaAgXQXQkkekG616xk2VAm?=
 =?us-ascii?Q?n1eXuximIX8c/xy5A8oI3f0dox9NXjrZd0mzT9EmeJBaupx/qOdi33Mxg8gd?=
 =?us-ascii?Q?s+kYO1T3E/AQp7P78OcRM8sGyYxNiZK58+RuAiZjne2RB+KtUvgTWm1Bhj++?=
 =?us-ascii?Q?K3LlyUr8HYsWcNsIldCbrc/W/qej5cV4CijSjH3adU0YILlDMY4c4NWvOm+j?=
 =?us-ascii?Q?pMinHEN5NGvAuadA+riUR5W3+aGC/oQ3w0ZMvkTvJF+j87E4u7kqKylskyAB?=
 =?us-ascii?Q?seYZuRbkBavuQDXguqcfd3dZMvEKGTgJOovXVMiLcozFlSMeAzT5NhYMyRBf?=
 =?us-ascii?Q?ltuL3xIzTMwzANban8BKdtgkbLU/jHj4dcfFOh26Ka5zinHfjvi6buthvZZl?=
 =?us-ascii?Q?TWbJjKm+UDiV4Ukg0Y97tjDD2LcVY9ytPSwht8qaM+4orji1uSnRV6lpD0+x?=
 =?us-ascii?Q?IdzsKtui9AsAi96cCL9FBcy0hYguRm340BBb7IEDXsmvhQY8kYzsp1haJZPk?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kr6rRn8icO8jOMc+1fB68wgaGABeKHTA0sGNz8ktuRCA17446ao8+vkm0YbNk5vhANpRHwaVqK3805lnHuTkxSKfBsvh0lHQApiMRkyPaFvAY8aN556BHR1j80eRvaDl13S1+w0k9rmp+/pDw1wEDsesyxzUMyRSGRUOvwIMb6+AnkriLiWrucg65Bb26qTj/wQiJo2BeZZGczJuUyoO2pFlSFk7107GJvc8mYPOFXDJI+Ehg0mRt5e/NiJI28wJ6HIvKcw2gcUqZJ5cmFXE2aBZ0V9QlHdYrf0X9NgD0hbjbxkN+RGXYAb7dkXhV/jWX7UapSQdOmM1a+5x/yTcswyj94Qa3InFlUr/oOgVkOq+/0WVHZ6FqZg+H7EpZFYn1ZEXBpS2PhY7jXFcpDJncLs90RGrHE7mcHK+PF35zTZb9tpdmWZVEx709QJU8ty6xQ73+1PPX4UxROlec31lmrkL5QOLyY3BODjJ1KuigC645xhx+LQWavq0YOjNWxOTgpBxVPmXpBEOhfSPRbR+Enw0/9g8GvLiCsfEq9G1LI/pxnTyNeSm7BpDVnvWGicKdcVeIvL2OsphvO4v7AiIJnUSG1Q410ZVBGnzBj8fKgKCc3fohMkmuLeQg5kPfB6uqlUjRvqb9NS1aeisPu0jtGzkMdhSCswK7+Gq7zn1V85ugv8CnuI+pV1WlBWP4ka9nRe2OZ/CoHNaJygtzCzpM4ek0UvdbdLMsmQrykS7o004T0wK+PXYBfYhXJ+YiuISAWhZWZXCPRiV3u11ESB4Jx1gAoFx8qyvIES22oOqoazOds8YkeUS7Ld7sahDYR0+E/hIuygB0D3x8jGYeZkqeQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cea3ad-8a26-4660-0357-08dbcc002946
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:22:06.9899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRizX9fcqvpyUCcF8p/ARRwu/PLIkjbHKyj+DdGPpoT/3yzv9//OvJbj7LBIlaxUCUwQ6fXsIpxd6yvH/hQeaI/Ff9mu1GjBspXtBpo5qx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6431
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_06,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310130129
X-Proofpoint-ORIG-GUID: pfl5vkIFMdGLZfW_lM1aEH-jN3APvVBT
X-Proofpoint-GUID: pfl5vkIFMdGLZfW_lM1aEH-jN3APvVBT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Oct 07, 2023 at 11:52:33AM +0800, Wang Jinchao wrote:
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>

The Fixes: tag should be near your Signed-off-by:, and the subject of
the patch should be something descriptive like

    padata: Fix refcnt handling in padata_free_shell()

Here's some documentation about this:

    https://docs.kernel.org/process/5.Posting.html#patch-formatting-and-changelogs

> Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> ---
> V3: 
>     Include Daniel's ack
>
> V2: https://lore.kernel.org/all/ZRTLHY5A+VqIKhA2@fedora/
>     To satisfy Sparse, use rcu_dereference_protected.
>     Reported-by: kernel test robot <lkp@intel.com>
>     Closes: https://lore.kernel.org/oe-kbuild-all/202309270829.xHgTOMKw-lkp@intel.com/

These two tags can also go near your SoB.

> V1: https://lore.kernel.org/all/ZRE4XvOOhz4HSOgR@fedora/
> 
>  kernel/padata.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 222d60195de6..79d04a97ded6 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -1102,12 +1102,16 @@ EXPORT_SYMBOL(padata_alloc_shell);
>   */
>  void padata_free_shell(struct padata_shell *ps)
>  {
> +	struct parallel_data *pd;
> +
>  	if (!ps)
>  		return;
>  
>  	mutex_lock(&ps->pinst->lock);
>  	list_del(&ps->list);
> -	padata_free_pd(rcu_dereference_protected(ps->pd, 1));
> +	pd = rcu_dereference_protected(ps->pd, 1);
> +	if (refcount_dec_and_test(&pd->refcnt))
> +		padata_free_pd(rcu_dereference_protected(ps->pd, 1));

As Herbert points out, this version changes the code by
rcu-dereferencing pd twice.  Usually previous acks are dropped when
introducing new changes, but you can have it back by only
rcu-dereferencing once and addressing the other comments above.

>  	mutex_unlock(&ps->pinst->lock);
>  
>  	kfree(ps);
> -- 
> 2.40.0
> 
