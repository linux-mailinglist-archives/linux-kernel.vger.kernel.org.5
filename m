Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D487B8064FD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjLFCNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLFCNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:13:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BA5183;
        Tue,  5 Dec 2023 18:13:50 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B61xSph019621;
        Wed, 6 Dec 2023 02:13:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=n6p8sMxXOjXgklSXOVFNjwTl4YK3upcJyVLiTXAPjMw=;
 b=ABaD2qGdwCRljnL8KWn5zwNb6UTkkXSZ5svCezvm06Koe6uRLxbu7qUhwx/Q5upB1Zu0
 rIgdXJupwZ/cUd2oWl/weLIb0Dqxvlry489lgUMB5sK0hsbPCnizZIKuyQ4ALC31Q015
 zFRv3YH11xmrGY4VW2mtPYWwoUCFOIoXj3r9lR5Dd3mUfdEVPRSb+pPgMtaSNcvBxH1g
 usLgXT2e8h2NooAfiVNBo/I/tkJqa8TTglHm6L+R8yKCZ23caI8zBWzZ0jgPP4/uhCav
 omEL0e/wO4c87+uap841FXe9ZWk1sbQWbJuI6CAChOSQJ8sMNAeuWAcyWXH/dTVCCkV4 Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utd1g86e4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 02:13:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B607Wgx037857;
        Wed, 6 Dec 2023 02:13:40 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utanb4eht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 02:13:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7Gw1VZx7osXymdTB7SKuYTZvt8hHhyFUjADxBGE8I9xwicYLQHexONDUW0C4kjqSVRsk8gJHvMl/VH1yunEyKgyT5DV3zLMXixCWh0cSVP7NRZCb0FYrQ1d5IOIh9fB4hIOOO1t+I34GYcFx5+83Uq2aI1ZIaESTgLoap09IrPV2DFyitQwYAObxo84JLtGrxdNfzSha25kqs2sHxiwvM8PkOOOfJ7CL+IN8Gext1WZEUrJBcVIFR7lHWzXXTxLMMXnzgjuow4U6yyt+CYpDiEHiVBRiCE4mDZAMqa+WK93xkSep7TFaB1N77Se6SG0w4qSJvLacuIoVBJuocaTEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6p8sMxXOjXgklSXOVFNjwTl4YK3upcJyVLiTXAPjMw=;
 b=BUU4DESjLNJlCZ5/pimRxWhgxVbx1+Bro9ZTz2bi803dgZdZyfph4Gg6gmodtk7dmtNXbNKmt0hwGRebMQNSIe6goUg2v3recCv5Sn2J9ntSCD9xE+1b5tdyTSBKjEc8HLxDMFTo+CL8uU12qAsfeIobE9TZCqNG9YDgKUMneCmycBm0n8j3DkkG62rID8/KCw4ahWWWaHq6Jdm2ShWPjCpDCEmKtsW/zEOgYWV9v1ljJREz9r+lneEcWIcjQe6TPaHUmqa1hqVD6DnjJlu0GTbGgh2HO8KnkCcf1m8cjIaPRMsNzKrxm5icrZ44CjszJ/EhWlTGDVnXyX/aNCo/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6p8sMxXOjXgklSXOVFNjwTl4YK3upcJyVLiTXAPjMw=;
 b=oP0gf5f0521BE3QAK5VirP/oBB2E6mbjDnrUOaOFRAHaSyjXU9RE9p8VgkBG15NHh837FKE3suuQDJ2LBN+jDMd41w+IbRvUAYe2jiVDuAA1Nh6Vd+cOiJgigEsU4DoHGEyvLosE0hbQm/JSP7uOxj/8hCDjlgabQ+hAkZaiV6w=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6628.namprd10.prod.outlook.com (2603:10b6:510:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 02:13:39 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 02:13:39 +0000
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH]  scsi: isci: Remove redundant check in
 isci_task_request_build()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18r68nkn0.fsf@ca-mkp.ca.oracle.com>
References: <20231128121159.2373975-1-artem.chernyshev@red-soft.ru>
Date:   Tue, 05 Dec 2023 21:13:35 -0500
In-Reply-To: <20231128121159.2373975-1-artem.chernyshev@red-soft.ru> (Artem
        Chernyshev's message of "Tue, 28 Nov 2023 15:11:59 +0300")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0426.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 7198b3c0-dd1e-4484-de2c-08dbf600f5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DsxHqmVGf6Rp8owCCWQVNPG5AjWevEGJQjf5a0qyd9xJztXfBMlX6ohm6PngM8BT7WwrNHniTGNMr/y4SXaliXp866XZg/WpWnu+zSrbtPsEGfviL3V4Ozv15exflgO4ERUi1Kan1BGLR44YPy76Eq99iVLnTyfgIt5KywJDzR5REfa0T7trBa8LL1+QuKw1PO8rWVhqbY3y2PxBJSSlLvx5BUjRcoDrKEJ9GLsJZTi+H6Jt8ZlOuwiEw8SmJoQnEp8PghLgGgaDcNWgKnXeCyeDskLnqj0SWQgnQnysrgGSyoGbhKFHiVb6Jq6nBF30w1lV2IN38hCEuRKtKHWR7mv88mdB3JDmlrpYbVNi34gerL/z6VserfKUbtjYvE2DhsTofSV/xSgHi+KLytonnOj0gHtBd0jODVjylMCbzuFFcV7jStJylNgOKgLsyYCCdLvCqmgTz0EYKEgB81bkKxHmIXwgFszT38v/YGra5tC11POUTY9Q6HkAvFkOPGALrtJHf6d0sd4WZ8R1gaipw7lO3cx4ceA0lO46+8gUm/j8JQ9zYev7EpIXZ2XQNfuB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(6512007)(6666004)(4326008)(8936002)(8676002)(66556008)(66946007)(66476007)(38100700002)(54906003)(6916009)(316002)(26005)(83380400001)(6506007)(36916002)(6486002)(2906002)(5660300002)(86362001)(558084003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6mEr1wzUQk1Fbr68ZLjJ2aWnorbwq0EXzMECD4VLFnsfyNRDSha3Dsa4i0Yg?=
 =?us-ascii?Q?U12bVjU6NbGD3HCSAKv5D0vwbUIv8V3Nou3AQVSMCjjWs/xwAoh4N/SMVO+0?=
 =?us-ascii?Q?F6GHUOFUW6Ee5lKukiJ9xbKGDjxjjUug12ahXm74NBQA6zp0+99qQk4wyhUy?=
 =?us-ascii?Q?SutS0bp1AHq7UrYq6hxmlAiP/jA7CHSDGrBL/cjpCFNvP9OziPJNNVZuv/At?=
 =?us-ascii?Q?xzysmWPDb8jPAU3C8eAPQEHMVLDnpquJfpbD2iOXkpoNR/zDm/LAiPb3zbCQ?=
 =?us-ascii?Q?m3he7h+xj3rXm5OTXae9QQ5PpiIH3h3FHWd+DJ6iQxhT65Af4kPEG1nCnyaf?=
 =?us-ascii?Q?DrGPhd6/Xv7/zHtno47RYmfChIaqNhnu59J//BX3Du//kyRcxOkX6rIH+Z8Y?=
 =?us-ascii?Q?w17OW8wcHS2Hb2APMsV4L0R2EeBHnqeK83YzvxmjAmVIuFDDtskAqb/z2TGD?=
 =?us-ascii?Q?39BXOtoJI1JfCk2t5vWDBPXXY7HzPNWTpUfHtp67DkAC/J8JjStXAAxHK/Fk?=
 =?us-ascii?Q?RwC7aVi12neJW5x43Z5dQGhG2hNcNj7RWqoD3d/HxWg/jNRg4+G4ePZKOc+r?=
 =?us-ascii?Q?a6YTZW8jQWSDPW4lOZ4FmoQXzlbhz0Ml9dBNUZVQiyzHuqHRGr7URy1gFnoV?=
 =?us-ascii?Q?Io9b5zAvwCfUjL2w+IyFGxeRlMVDGoeEWKPrzsSNt9MzvOKMIOPDrIAkvO58?=
 =?us-ascii?Q?eMlyVgdfrYNwCKmCA+pkO98/C3VYmeKDDGVJ678ELLpS2Jfx70TP36W15MJs?=
 =?us-ascii?Q?gB+HGYtw7xDdxtAlI/OrZsPBzJPVUlFaXeo+86WGemad342TpbbkK03UfdZW?=
 =?us-ascii?Q?eeCPj4sp/TawGsKnLAVExwyp/Zgxd/HoVTpgaRwKeVIsaAZxYNGTadVg2I6f?=
 =?us-ascii?Q?LOwdkqB1nrHlqwOINkCwkLoRvtxQtgB7Om9Ryegkg57+DTQw3z5RtZOTw6v+?=
 =?us-ascii?Q?YOYvGYxcRrJ+L7BqO8vCHJ6cT6h5FNLxAko897ry8drp2q76xf+g40/Et51f?=
 =?us-ascii?Q?J4L3W7A8Ff5/JH9BVZLIanodTj7tULhkvOBstVJfvGlOJewGyuxo6aTafcbo?=
 =?us-ascii?Q?szy9G7WmhZM9ZgbMPv6UpNfBcLNT/RJC6EvHco4rNWxwyzbw2L7lur4GbQki?=
 =?us-ascii?Q?U8IQJh4ueEtNSe5WPB693mNVKXUCfOnr6krxoS4KlGQrw1RkfHCDsTMsOv93?=
 =?us-ascii?Q?Ofo2Y9IXhy40iwDGmk/Vh3w9pqj8csxzE8RnL4cIrW0UkqOu3k3g1NVNYBsT?=
 =?us-ascii?Q?Ms9mjUeKprv0CdJvrpbexN22cGiqw59jRQ9V6HoYalhmOjdnxP7ZOSjio+D9?=
 =?us-ascii?Q?t+szzuIgXvhWL62ioEb80mSs96fr/SboFn9jHlYQwbsqGr8YVZBxZ2NH7gCl?=
 =?us-ascii?Q?VnBccXJjilk/Cvb5UPwXXYQAd4P70DSHNdfsPzrSK/OvwMu6NeovxsipkoHg?=
 =?us-ascii?Q?bGso/WulTAmpEvXXqj2ds6Qy8e8DWGhH2nIzsTLml1B/Le2Zpgcwm3vuH7Hu?=
 =?us-ascii?Q?ODwJs7gmsG9UAZURHq2ysbvU9hZfvoxmRnxs68hww4xn1YkhsoiQifb4iD/e?=
 =?us-ascii?Q?VItqBxZWCQcoSHztQFuZdCUFvJM1wxdV+m3GIvLcdPHueBDPGyhOnUC7CRpJ?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1MhhmB0cfgnVzAvn8/B4JdjR6z+o1886IFNoxLq2mIPNJD9ktjOVqtH0V+SxWFvikPem96k00F/f847Ds2tTFJ9YqgDQx+p7bFj4L4Ej1EAjCIPOlUdeO1FEETaDbfNaDWk9WzBhadgECOdud9EHyMANuCKIwbrcTnNm6eT+Hl2++nRCQJN6LKoJDi3AF2r7Vx4pCmuuJLx/MLA5BknBlPe5bJB1sB14GbcpbeXrsJpnOGpKSCw038aWd9Ykf2iQYc4rbRupQy6oVdJHeL2gctF8YbDD5BhkZrgRg/lmYrUthdJlOxbK6ogB8+bAWhmbZspYLcpnDhWt4z43jaEqblOFmWRB0xKOHj+5bftqx9sJQvtzIk2ltrae2zxi7AURbkYXzOntteu1928uXB0+m1ne2STcvDo8Wz56ebDcajmkC/lStIy2XIShOfCYj0PcucmuPAlKmvqzrT9QDDsL3jN2F8iWNhhc69hUv1GWASdW426mYMUeoR1ivXoyfLBAXNxD9Xd/XD/U3orpd/30GAhzITMKjZLoplNc7cQFbHSR8b5hfkja/br2w2Y3k5YZrRSrouSVAkjDx6cirj61WwZiZG/tupI8WjGvNuslAkFXqYoAx0niioxMz9mDg/zUAtpRvnlb0Xxz/Q7yQFpBivev1SPD9ZD4RzIbz0smrUhOQsesgvGrnfbuyzX7OATJi0RnizTXe+R0lZ+G4HzYFWbcCpwnlK9xQewW9HL/0CRYYQrZnq4YXOWwUAs3BW11VRaOyYzz0s16+5OTyfrt5sTxqgSvAUW7+2YoD5zTazFkimSRhzS5ZKpcfuMHF/dfAQ6mm3EPpsopeXkQRSnbVc99KSC/yKkNm8Ts2QeCgnP0W/4YEkYV3aW7j2nOPldj29CtMHByPM058lhbvBRaxA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7198b3c0-dd1e-4484-de2c-08dbf600f5f4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 02:13:39.1061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tNSzmCN1vqPebUC53es+/owZT8LpJfO9QkWJKiZ5UQ2zcJ3cm1P9OQa2+YMScx0ooDtnBaTuy1VY5G+1rrAUbkzNHhSKmVdCkf6uMdz1ppE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=761 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060017
X-Proofpoint-ORIG-GUID: 83HfRKX6-31y2prsL5MDIrTBJvzEA4S5
X-Proofpoint-GUID: 83HfRKX6-31y2prsL5MDIrTBJvzEA4S5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Artem,

> sci_task_request_construct_ssp() have invariant return. Change this
> function to void and get rid of unnecessary checks.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
