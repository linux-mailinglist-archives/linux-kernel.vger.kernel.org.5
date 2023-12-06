Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E678064FA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjLFCXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFCXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:23:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B772188;
        Tue,  5 Dec 2023 18:24:00 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B61xkV6001904;
        Wed, 6 Dec 2023 02:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=JEeqNHTK5hc9HYSuXhQ293KZYA7L1SphhZkbuxd6evo=;
 b=BikERVW95Akj4SBUoKcJmXoqqAl9mAav1WjeVWjDUdJjCdfisf6Qj9f9FhZYrDbuRp0d
 uGTf0dEczvrtsGRHjeECXwrzXufs1k0ikKmp1okD2l5Wde3RYDCoomBSknO3J3k3Q3Ew
 IBkeyBREgP+bE2fGbL0AOZTsIw/Ime3/cUr/AZkNYEwZICScdAvnNpkwsqtTP9idNMse
 qOqh7l2ugL0xDZAyz8vv6+0R5NwVWSL8Q0Ql9LEd58k2gSTqEX9Bg4keuhMqAx2Cxl3U
 Ppew63OkFVEQY71xyzm0p3sPAOM9ccZSSSLGtgHdWMMMSIG1oYc9DCjl57vM2AmsQycE 9g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvg4sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 02:23:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B60A57J037899;
        Wed, 6 Dec 2023 02:23:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3utanb4rvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Dec 2023 02:23:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a55OCtaxqktx1y6ElVjagawQZjFg87UKXJzggkUkDDp++Mlr6wNcSEHs/ekVE0djOmjdRUup7PCS3TyXd3ffCNz3OQtN2CkZ2J986SWbZxIt5t3KCKzxhsxfPPiqEjGuMd17WAwLqrGxon9TMOl85ohj/SXnw7zgl0rhJpnIi4pYg7DUhopwKP4v8FkLwzyF/Yq6VH+RPtLaJscMKbDpWqwzqg01IyaKXj3qyIwrTA86LgpTg15yRIS1bbYdX05sTox17uCYbEK2pUK7UofA6cT54Jo3EpjKvMULOLdzsOM0hx09gB04CrRH8YyW309P2aG9jDq5zCWgaGL7aGm4sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEeqNHTK5hc9HYSuXhQ293KZYA7L1SphhZkbuxd6evo=;
 b=dWI8KTDwKaxoIeHJOyVWxijsK3P+UzmGPyMUad/7G7lfb0MbkJ+lsh/IcfN2oKdZEWXD7bIi1UTM/9eLMG7yatpQFNXORjI9KXcf9HrX0imTrOnOTpiEV0QLV5CTYfbJsAKfgGtG/O6dqCAmbeizEUAdQnX29QVVONvIwqfovouCz1sYFYt8yALILPTp56W/Gr7Ku3oBG6t9r0H3xG3Ntb5VHrQkhx2afHAp7YNsDhfT02i6Hb7ucRWjOfa/jojngC8M8bD/Oh1M1geR+gjLE0kbqRv+FIk1GaMbe+LJHLR+lIXpJN4TyocToU1uKUGptCzdhhwdFznJuSi2GtEGgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEeqNHTK5hc9HYSuXhQ293KZYA7L1SphhZkbuxd6evo=;
 b=E6rCbiI0M5INEIYbvlL/dzHXi2ZJAN4d7KV7lAjD3OyHeFIsNyt0Tr1qu0d8igPy/EGMNY0uIBSuUm3vLE6CJQHhQ6NR75dOUS1kK6UxvG20kURXHicXnrz98dAqakyQW3SyjJQje1kU2yLTwYhCvJjyB+htekfipv8srmkUvIQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB6361.namprd10.prod.outlook.com (2603:10b6:806:26f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.26; Wed, 6 Dec
 2023 02:23:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 02:23:48 +0000
To:     Nick Spooner <nicholas.spooner@seagate.com>
Cc:     "john.g.garry@oracle.com" <john.g.garry@oracle.com>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: libsas: fix whitespace formatting
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wmtsm5sv.fsf@ca-mkp.ca.oracle.com>
References: <CH0PR20MB381839E1C7FCA1F477D7823D9C81A@CH0PR20MB3818.namprd20.prod.outlook.com>
Date:   Tue, 05 Dec 2023 21:23:46 -0500
In-Reply-To: <CH0PR20MB381839E1C7FCA1F477D7823D9C81A@CH0PR20MB3818.namprd20.prod.outlook.com>
        (Nick Spooner's message of "Fri, 1 Dec 2023 19:38:14 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::6) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB6361:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d6c8ba-3bac-4577-361d-08dbf6026117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JAeeChdiziw81HXrs/zTqcXNtx0lCCor9mQA2Fr6kGmYaZeXz1o+vwddBAbd2V8SLjdlwIuB7PaP7JqSuxCPz2VHbh8cmLQ1jKEhstG/RXQu7q4n36FP/UdqxEgaoffwE3h6AKNGsH3F2/pBSASvWT9ozFk1ry619uNoRqNXcYAV0UB6AMe5oVr71L8VjRPXcvhy3Gxla4hiV+28dTuOKxUBHmfzLfvBq1APOJZUqiGXcEWcD9hzS2a4rS5kXbjjOvVeO/bAdvlzReJVfp1pXsHXaSOPQYpiT9SmwYDeGtBDCthUFYdqtht+8HP4JCnoEgtf+wqGTunuI+agWao5xQKcKJgmCzIAl8r2OPfLMeyi/f11a97+LVQwQ4Pa7Ial+VwhCWoRrjDAzaoCsVc3UUgcVRakuwsmHlTwt2/a8koD4tazNGyfIc84Pbo5I06zm3PdxVyef7GPXGkArzBNFNGVTu6HEGXQL7dsGKrolbmdKCwoC5AQQ0TKHSOmaVZX50MM+DyWlDL1kzt4EHnj65KalaJT577DMNTwKpQFmH/tV8f0Zqt9l6yUE3Jd87veskynT5YiNHMBzgpaj9ezPSXT5G4B6qWn2evik1BsHCk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(66476007)(41300700001)(86362001)(316002)(5660300002)(2906002)(66946007)(6512007)(558084003)(6916009)(26005)(6506007)(478600001)(4326008)(66556008)(8936002)(6486002)(38100700002)(54906003)(8676002)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JmyObtF5wo1ZgkHvnlC74xWzNXrL6OpN7jwGmzA6wGpF80f4q1C0pwXUb0EK?=
 =?us-ascii?Q?U0ADRqYfBO9PBjL1YJuYw9VFXOeLnSxFGZf543lXzbiQvRK2xCBMl7mkqaPp?=
 =?us-ascii?Q?vc3txL0FuPRquB0yXAfnkWTZQRFCaAhZgem5QdoIytm55cva7ie+gox9Px7r?=
 =?us-ascii?Q?9+XqTMNtId9VtqnTBuYmrwq8ErV4KOXSKBAezNy2vjOkwZ/tztJf7jSyaR0e?=
 =?us-ascii?Q?U7Zkk+iy1glTm5RW7SSanHsTeg28ynv6i6H1ZMkokXVuu3mmq+SUWhzWxkeY?=
 =?us-ascii?Q?BMFmotmhXN90s2G/3y0Wcz0A1eBI9+1sCaZT3qFRKIk2ujJvkceFSAg9nWBC?=
 =?us-ascii?Q?51b5iBKuOEzXBgM8usix8ZBsafID13hxphpaEF5rHuNwDOLmxcdwNiCbixI0?=
 =?us-ascii?Q?cD/xDlAc0PbzlcAVUKM5+0C8+wmcZKt6Oobglq5aVOcQhRqfZIoJyD64UT5T?=
 =?us-ascii?Q?A0KHnhNdA4iqqavFAtRYkkRYChsL/00p+nrOHTEaQC071x1zfH+62yPgja3n?=
 =?us-ascii?Q?kR6PRIffhs7L1FBsoA5xg6Ajjk/ap5XjX0jMt0GKFDWO8qF2iWLqGkW2/BBM?=
 =?us-ascii?Q?c2iKdJkr3ohrhTE/6i6ei7mqGbvk8MmyTbTN/1+vqWK40K6BkmarlSEo8nT1?=
 =?us-ascii?Q?jHAzU+SD1sc9ZSn5kUN/9nxAz6vrhWWNRGRE1cdXaCaK2AfESjIYOkxaMNvJ?=
 =?us-ascii?Q?bYTs/3VDlu9H5yRW+3WTbE1QRnBPOw1DsJzqw4tyn1tVje0TqAjhMJQZUirr?=
 =?us-ascii?Q?2zQ1eYPQwByA8iCIpBeaq9LqQqkitZ+06YyEZaSsi9Bu3y1Uu9Vi3vymA0cc?=
 =?us-ascii?Q?SrRxa7OzLDM7eurZoeh8EQ5E0ePg53+RPD1KDRRzifQ6/BV0MQgKd5hDvcwL?=
 =?us-ascii?Q?f8vVpjMUfUIWkj3wPDHdMYGKbKZLRuXDBtjaurjbL8ypSn9DPIHPMrmTLtoN?=
 =?us-ascii?Q?0Nvzb9/3iE50ZRTSz/r05TI5ytORNQbqKdLsLGaXqhNnaQUvnGfcbihNyAB8?=
 =?us-ascii?Q?y0XTdIZEN6pC0MLLrFhHSlJec/ubYa5StkvOwsREkeim7ZQJKIdNq+QNBqpY?=
 =?us-ascii?Q?PHgxVNJywIeqBL4zqxv0k0S2QSpn6rS4OyZEqQ+z1g1TtOyKv05/pxt/D61N?=
 =?us-ascii?Q?lOTdbRXgUK7+vztGYys2VuWiBwJ8szVnuPW+zLWHf0pm/54OdFSpb2zd+hpq?=
 =?us-ascii?Q?Yd+Vv6rPF6VQARg5NeFj+XbZp6bIHdOPmHVINledwxfYk88FH1hkcz1G1AS9?=
 =?us-ascii?Q?E7ZjIROfUiEpL+PtulaQxLBWVsMBVC00aaD1nisrJPYGzuodNK1L9xdc9AWZ?=
 =?us-ascii?Q?syZGCqP+NHZgtk5vvFXFMtM0Q4bfN8AQmfMUtqpglcy0TEzML68AhybFM0dg?=
 =?us-ascii?Q?Gwndh5HQTsTQG3PbDB89apM/B+q7TL4ZgsUuOp4za/OncyI7/rH7vLQ3+SAS?=
 =?us-ascii?Q?lkueWM9la0FYB/Isme46+WrwQB8oyVpyF2NW2MLz0kUMcmn+AcM4hjBe39yn?=
 =?us-ascii?Q?lLURJAhmst8SzYkqqcuWVVU+Gwd9EJCD9wI+8ra5RigDEBwzvNsT88alc2tZ?=
 =?us-ascii?Q?bCTNjYGduZP96AwPon4fsv5EBf7c2wVLxbUP+c5vpyHElh39i625PIMzKLvj?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZzMnCRyRdYXcf7td4QGktFNZzzrsEWgHalUwKg2ccWQjSuSWyMa6C1igdOHGiNB4YsL5MuVDsHrAM+q0Fb0YXHcdympx/0VM2J3WCEeHldP+dOtmPgOq24iXBLmHoaTfkh9sana+BOMVAyiuU53kLYJycCGDVgsNLNeCzYxcTMpAX1FIIX/ToCjKfmD812zjWEszawOHtQOKJbEwYKsVUeQH/chONgbRSf2nBinNrizuIN1wqQV+ASyHQWmx/TDDzM+hy3bfHLf4yqvEZMI7BDQ23Yk8z/QRW1M2/Jrqwb5n8rs4DKmmoJoehVNEbt1jNWIa/YJ2VwuAJpR9kybKDw5rok6bfQgAvYpgvJGJW6NKS/DgmGhRvut7IhrBdH0nf2cdA37obwCLW4NcpsKUygZ9FVIqLpLQKFbVJmfY6NZEZS3zrfJnIiY2FpvSApMSCJbSwvLzYjEWkRLv4nc7Gpf/OephG7JGc0qme1Gn+JwWGJFZ2zTUg+8lbDUVNu//0KKfLGihCgT2okCIEumBZQ7PJ8sKE6sqFF12fMNbfZ/tpXnlUR3KtBNn0E4i+z6dd96mUVmickuAppdkDB38vcT5uAIjx7AkyhQce2CQUQUuYjMmxPXn9XZJdza8XMxE3vLK94t1zcXuZY0E5GpAnM5tGspstk9QpaqGmBasvi4qHwmIB85KvZa0/+tK5cR/mhqc4hOE1tnaA4yZEc/XEkfw1yeb2kjVWN3VFoDDi+0OTgmiaWIcoScQN3izEfnSAtv//3Sk3pmXHEIa6lLwEErSEOCFDTFTgkGnqpaghTEaaP4tGl3MldGM327Oqr9/FLxtdQd3dKONiQ243tXpvBAWvmKtiUz0awDcT84soRDgV+Pleai+y0OUcynQkG4XaFjqOqx383yW7xPN1dj3h5h3PIvwXPtVddUZ6+ITskY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d6c8ba-3bac-4577-361d-08dbf6026117
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 02:23:48.3486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gUYXvNcqR7PGh53vQDst6dN66fL+Cbn8UqyVJdQ89aLAWxyeUha7sykNzeVRZ6kUS27ZXxipTf2vEYZCn6X8pXOPn+DxZ002oWrs3+u2tYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_01,2023-12-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=768 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060018
X-Proofpoint-GUID: JGAAbPamXumOfk_q60fyXyzgY5kQopeT
X-Proofpoint-ORIG-GUID: JGAAbPamXumOfk_q60fyXyzgY5kQopeT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nick,

> Resolve whitespace issues reported by checkpatch.pl:

checkpatch.pl is for validating patches. We only adjust formatting for
existing code when we have to change the code for functional reasons.

-- 
Martin K. Petersen	Oracle Linux Engineering
