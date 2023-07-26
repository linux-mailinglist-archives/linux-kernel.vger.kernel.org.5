Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7039F762867
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGZB4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGZB4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:56:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C910188;
        Tue, 25 Jul 2023 18:56:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJIo1m029454;
        Wed, 26 Jul 2023 01:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=Pu2nl006GX0pXgxRmrsvgPaXPdOxpPEvdyzIduRf78M=;
 b=bOKG4/1eLhHzG+DiKJpfOSGQce6zfDqtADPccQ60Lr0Gx/OsfymJL3vQIFm7HzOoGz5+
 MM2WpCyjCp7yyd/1/Glqnlls7vESkUXmKc3OQmQ0Cj0rx/l3o/wpJyTQY/dDMhbCbBih
 aNsgbP1P+IPkFVrP60rs2sAB1byPSz43/Qs7zt5gGycZZEzd0B7u4eUcdpPy2F45i5c1
 C2+QOBIZAdbjnKgc7aCIyfrRENOyEva8jrhgQKQSthDOKbGxcwIDaEz0W7NmQUrFB22X
 WONoMQnwnARN4YO9QIb7a1lTBrYlSVTQg+Y4+/dax3s42NeH/l/erlq2AZGc8abraXxG jQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1xeum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:56:30 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PNdcfH025372;
        Wed, 26 Jul 2023 01:56:29 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j62be7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:56:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEUBR+gqb9MG5urBzhZ8EmWpRUkubErzckmc6xLAeRhU4ScHCdOMo99IP1iQqMm8vp7zcbaftAd/xnv0iMgpURm54LOcGyqeSK3iwl/yupdfTs67QwOpeHiENug0UpX1fsKQZ5uK52ddGNyIMq2zveYzTVnAaWdZvpxxP+QKjNJMWBVVeAR3suUU/KGSXIjg8N4kzLStqmuyK/aCR36rshz6Kag2llsp/n3Y17bR/SYd0jG/VYq/d5+Tg5ATmFPCIOlLqM7PAILt7VIzffRUyVmkdTfYevVxxnsq2f7Pk/u09LOdcX4lP2bRtR5H/6WWQMedQl2jiyt3scSl1N4b4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pu2nl006GX0pXgxRmrsvgPaXPdOxpPEvdyzIduRf78M=;
 b=KWdiRa4s6tYRhmMPWcdeoZuKtZusmsiVh+N4jnVCm+pDVljK+osNshs/Tx3ejTQ4ZhJgPRG2fNRJBBbdcPQrUfWBxHHcyLpkcLPMok+xpzs/HGjIyIkSlK6ODd97Hf3wYKImPN/RSJK+QlH3oSuonTzgFYDRfyvR2ZLuHdG1xDXJqnzQO3mG1rNbCeiuotRgyryFHsyY01z1gq74fOiC5P9Akqq74KM8yyVV2KhhLcYUqPZhdRX8iry05jo/jg2wakzq35wXsKmGMRVgjCShIktny7V89LWApTU7CSVN+e/STz2ZGZ5Swvchc0Cjki0S6Qwy+NFE1AWemND4Eax/0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pu2nl006GX0pXgxRmrsvgPaXPdOxpPEvdyzIduRf78M=;
 b=lwu7cmCt2fnqG3lsA9AWGo5qj/HmHfQUi3Myjl9taM2GdTF+Bwk1Fqqsg+lymUMoaD7eAZWGVQkXpVnhk6+VKJtUx4/sBgWgf7mksB9gnxs9C3KS0MwL8eSEbZ2+Hr8LhquLWjZxNLyqZjIOXk0eFvOfCzz7qSBnHx04Uhd0iO4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4332.namprd10.prod.outlook.com (2603:10b6:5:220::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 01:56:27 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 01:56:26 +0000
To:     Lin Ma <linma@zju.edu.cn>
Cc:     lduncan@suse.com, cleech@redhat.com, michael.christie@oracle.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] scsi: iscsi: Add strlen check in
 iscsi_if_set_{host}_param
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wmynxwow.fsf@ca-mkp.ca.oracle.com>
References: <20230723075820.3713119-1-linma@zju.edu.cn>
Date:   Tue, 25 Jul 2023 21:56:20 -0400
In-Reply-To: <20230723075820.3713119-1-linma@zju.edu.cn> (Lin Ma's message of
        "Sun, 23 Jul 2023 15:58:20 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0074.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM6PR10MB4332:EE_
X-MS-Office365-Filtering-Correlation-Id: a621f4bb-57ca-4c22-b7b2-08db8d7b8571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePIMU/bN9Zz7VnVy4kd3+tlKY7/SoKP9TMws/K6MJpBoJFto65PM80kytfVi/SfMNdJiJCwj5HghAzCaI1dbs+AUnYDlOkgzOggpwGvhL8TWRdLGN8RmsyIhozuCkvY+RPPK38XRBL/LStMszH13Ri5U+PpYOL5VLKbU9lneQVzmd9PmgSVZVFM6KXkoZmlRc8zLcDp7iD0c6+Hu2DjQv+yU5gWJquu3UXS0l97dfbu8XqkrvjT7Kzgr/M07ZrKaQEj9qnKp69tyK4CALdNRwCFVzTbdLaOkD6KcjD8AcFiAq2DppdVE8VMGwm8EKO/HGqc/WRqiK0gnK5SBrL6uSKSu14usjzjcBDcNGtce1b8oe2uoTlUcsc1+UWDq7EgUm1FEj46CUUSEHdqKHK+UWbaX7CkCZOorE+Y41zJMqubVKpdvgZlZfBCyPt7F1+xGUPwfYA9LDzvIZnWgws02NnPKc+cl21xsN0v2JKCcf3nwZF/s5lXGBLaXhfTTPevh2kjeQ6TZ5SKPX0crZO1fgAgHQbVdSVlXNvPzsi8jU4cCCwUZDpBrS0u7wUU3r+fc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199021)(316002)(66556008)(66946007)(66476007)(6916009)(4326008)(36916002)(6486002)(6512007)(478600001)(186003)(26005)(6506007)(6666004)(2906002)(558084003)(86362001)(41300700001)(38100700002)(5660300002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SkLZSGYIKW0gB2wROtIApvhS7drdoo/XhYgjd8y3FQhkZaW9D5hbBfaZdLhx?=
 =?us-ascii?Q?bvXdo+5FKgg11SDvT7Pm74YRes7e9NDNA16XVdaFdXA5Cvrz7q8b9wPUxH7A?=
 =?us-ascii?Q?ua9FCunQZe85djPv7/CrMVND/wI3lJl5VSjEIOTaGss0D5i8v9u46nizbCWt?=
 =?us-ascii?Q?gKbLFA3fvTAlUk7l/ekUBsTKZNF6mEWwo0sp0vsZJZb0etPd9NbXJm25og/s?=
 =?us-ascii?Q?51pBP2IwnasZu5QnlWRsYyvAbso5dBKDdk2jJkrAZHuotpqCQDnPXxPi0p+1?=
 =?us-ascii?Q?gYv9+196mAx7002EWQi1dvVKgWsQfWeCHL8Jve7IN2fAnXt0V7hHhVTro3OI?=
 =?us-ascii?Q?NC2Eek8NwuN9BQ0KVTD7vX1grLhi+Djey8MsD9itjNb3Jw2B0B/B0haLQIV8?=
 =?us-ascii?Q?Zs5PYIXaRCIDIHmpHE0Qn/BD6QDHChRwDD+aL5IhQixR0afXSMEFDgRzsmBz?=
 =?us-ascii?Q?xOA+ZyF0/5lpZZhsuy7n0XAnPbuAhHES8wSWSk7CSJZpSUeSS2Bc9GGPNaTI?=
 =?us-ascii?Q?RNWnA+/uN1KimWV2PMfJe70KNqshlk4m8le4yG0CNqeRztpITjEmQpxXYJHk?=
 =?us-ascii?Q?Y4GQAKrhWqplJ3weN8etckbdD8wM+z52stflk3cD4Ik7j5MpBcIoqpj0q4jQ?=
 =?us-ascii?Q?mjxhmqb2KlWcDJhdSdVmkHnpRbMCeYemUmj6huGUi+0SsTEWPRqJp/ytq3T2?=
 =?us-ascii?Q?jIOBqNgeRHZ6In7tSChUhB/8XsWPj26shIt36f2689ABZr10sQHH6ifUeVY0?=
 =?us-ascii?Q?5rUYSF2mh4eIKF9EQTLGw4D8Or7XAmFr2vdrBcH+B2FNckxl3nq650npt3Rd?=
 =?us-ascii?Q?jxYqHCRHHcFyhe+pwqf60AntxAWRYIi+x2XSfjRzpHHrj3xgr0wAwDOt9fSs?=
 =?us-ascii?Q?J/w4lUIfgkfwZzPmHhrzU/icTy4q9NDZHuMpgdOTuAMOysmgNHC0XMDbHdby?=
 =?us-ascii?Q?/zN5oxBPaCGVJbx4gyx4NH189Qn4iMqRD+7agpaT1/VOMckI8Kfe46FVMMUz?=
 =?us-ascii?Q?SZtbAGq8CRTbeRDEkh84nfYIT4cJe/aWtVvXIl8yjHz1LKxoi3DElxo24LQA?=
 =?us-ascii?Q?tiCpL041kea2dbmvAAoINSWMREIrZHSWDjwdDYUxnqopQrHnGhNTLEASblCf?=
 =?us-ascii?Q?WLWhxYueQoTroO6sEPzCnc/ZNPqrxh/RF1Mt75/Hcx/HMJCKIowhM1OTYstN?=
 =?us-ascii?Q?OgRQKAsk8el990z5zIQTOjtIn0J9HNc3wXmjwpkl88DcdT2CxwnYYx0yLkTJ?=
 =?us-ascii?Q?jK995PDJT0ZiH5jWGjkge0E1ojOpFx8pW06DafzkiWRdwE6v0vOE1qMt+4sr?=
 =?us-ascii?Q?hIw3sJzn3fQtvCB+8GK+KuC0U5GyY2KvzMbjS9abGG5W9c8PlmZEADRqQi0U?=
 =?us-ascii?Q?+SXLYg430MRDem9/9hW66GaggRJwX12PnoduGzuGCSgyDAPDkkf3fUPMCNep?=
 =?us-ascii?Q?CBRmkPUjlrSAUiqsnOFC1jJwV2ZAsOB2ejV7gYx9aAWrIVoup2ztza36CYV4?=
 =?us-ascii?Q?Wmurr0EO6hoz4xIgzAOhoHcXKwYLINi2i56asDLebSvTq5+3Uj4OJk00LcxG?=
 =?us-ascii?Q?nTjiugUS7f4NZ2Y3ELCLJ0eZXGNL1CULS22Nt7x8mnYXX0GA+SBakzFI6+uC?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: apR5nScK4gTKWLkGA5mnPov+/o2Tjgzsf3zK8x5EKWuSMZuF2e6v2DLURgognfovyiujeYBpk638Ro+EMuNnxTYbrB6qNt/5YgH6DDGIHC7knvlQT6+4U5paedNeg9Ek23ONdfvH8jss9KYgPyhjdaExMPOTNGrzgvzE3veGFACPbUVYKtMKKPZHEbYM1ja7ZWJRjK0C7yqKQItGUoptU+ks5rgH1U5Ij/CBGKigWpXsYZhxHhPBMmK4GHRt92UBeWpYaZb0BY+lUZavG4btBFUGf2TVFtA496yJUoZf4iwV2viiEfVb4wy1Qs9fCs67lFy0RkQqJJ1inTKStzK+vnAVWYQdO2j/7qRnR+jopFYkwD1WmXrssm/Yz4ZOk3ZzPcvKuI2rxrwmcTt7egLOJDMeIPGV7Obf3AKGU4zZVC0bNErf+yUF3q2c9kgKhT9gX7A/H80UfaSHGhELMrPox74QVCSLNoM6p+ibtuoX3/pvcJ5sfV8xvcXKEtZI6Ib/Mi9IR5BNjaKxU4A2P2H9IUPv5khjbRm/i/nzzHFiGl39aqSKWz/xucdi7Yj3lm/PHLBjoklIKgLqFg5V6TpyNRp17EG7WzfD/fiXnhuWg0Hb265TN++8ia24s57AiHXWXf70C/H/WK5rTdkUc97xPL7GWg/e1Wu/VsSLcWko133AwAicbWbNkh7aqi+3e2BHKFZoP/JGylXJb59+4sOlregXJgimeqgOlu16vBDd8UNbUE3hrwqH3y4ngf/KDbcgUkkwQmtW0RNoTycmFkkQXDWaA1XcwkVuvSMplvSTuMSPhNPmzBncaX6iDd1lN0OaFgNrbO39zIRh5LsCV3ViKBM4DtLrzyrMxJnmD9Nep6WppsgDf8zHd6W5hW3Ixzrk5Nj3rab02uMcWpbiVOH8WRW8gBAobiBWBbB44lpFuCk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a621f4bb-57ca-4c22-b7b2-08db8d7b8571
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 01:56:26.3995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBF2aRne59mJYPF/VOR8OS+vN8w6N9DcArnFli0GrZOWELhkiuyMQ48mUV/F0eAJeK7zoKTGrMNDWhLeByV7Ww7/KyI1WyFIarZhPvx8cMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=855
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260014
X-Proofpoint-GUID: SUKTxCbJOFHr8nibe_mJ11WjSecrUrFw
X-Proofpoint-ORIG-GUID: SUKTxCbJOFHr8nibe_mJ11WjSecrUrFw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lin,

> The function iscsi_if_set_param and iscsi_if_set_host_param converts
> nlattr payload to type char* and then call C string handling functions
> like sscanf and kstrdup.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
