Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D49478E431
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345459AbjHaBMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243118AbjHaBM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:12:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1706B1A2;
        Wed, 30 Aug 2023 18:12:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37V0DvDD025866;
        Thu, 31 Aug 2023 01:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=J/P3CQhE5dLtcLpBkNv1jWQNoSEGu+gNk02JFVCkffk=;
 b=rZ+d8rxX3eBL49+O2SfLazpXzJMt8dnZM3mhwr7t7uISLZtVe9b7c7imA8S0VLmjVivA
 Qq8bu3/Txm7VwE/UR2tdvQd6oY40vCW2OH75tO4SjAsTucF47qpenL35s7KPlsMXYgfe
 K8agZ4mWHwmp2x7dAhvi2qU0WhMx9vCxyAxB6N8aFLGAd3P/Tx4XpZpqmS3sDIXYgSYT
 Sax1+VX5qx0wqpxVIhdvTMHwQAWOgW9wla7F0Yzvg5x84MKxgRZBPk6zwFTHAikyJcnk
 aa0snbpG7bt2i8bPM3vl7ByA5j5dZD4JFy6mu6LpCKNXHJMEUGTcb5D2oEnNmvjFbWdG LA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sq9k68rd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:12:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37V05bpa014331;
        Thu, 31 Aug 2023 01:12:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sr6hqa00x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Aug 2023 01:12:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0LbP085lNT+k+Ef06B2xTMe7llLdoEbHD2ojAKwn0BMBgAu25bcog7leGkyrPwgiAcSGV2kxOVM98BXPvXNRa2XupmXLhaH4RBVrmp3SusVhDCBkbQvcv/yYqyypTkrnsAQAUlDIJUyjf99FWnjeroES7QcPpkH7Ihv2uM2LH5poezRZ0AjKsGBOf3BvBcA1oGaKAQqKyhkWQhth91hIVjUCUfkuczrNv7qtFX9S9X29nhwlQwjB6Kr4ndIjXHmxTfl4/yNg+5EcmoOlsbG2gUtyBFbhbWQ6X3paCI1l9MvkeMMz5iaLg6V/2Qy2H37oJ/nc7lwpdH3RDO5PkVkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/P3CQhE5dLtcLpBkNv1jWQNoSEGu+gNk02JFVCkffk=;
 b=neQ8mz/Mcno3izi1/d4liUHyUVjVnIMODHxfQbb03hHRCGqMPcFfbXsskY5sM87uQKf+69DJTx/zx5qwzfdhSZTpiWBeOJA/RL3Ld75DFfPWTN9FUyVeb3SL5W0nUFFzKUC2gGETBXbyhQbJpGDPGjLt9CV9b7GvZWKLkwoYwhvKd3UsLWiecvfvXr1xlWttbSJLCo2P///EttI6CWaB6aMqU0sH2/qKypDzpf6hbsSkjz8TZuWlXrKzhZ1ESeyx2f67lAImbW6p/bsK2HuW4AT2PjXknjgIYWpD9JJfHWCX3pykR5lNeezwi42DG4FYINspnzs+FYFBLdsfaxjKPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/P3CQhE5dLtcLpBkNv1jWQNoSEGu+gNk02JFVCkffk=;
 b=oCh1ohUq3NUwIEfADD06jLagtflnVKkhGqEuxiBPuLXGxAfVEc6vY/7zB4zeNN1xQoL1GAtsWAXWsIhQvk8MtUy05c3Z878xGud+hXCk9sIIaUoWweA9CNVUGz8kTNLZ/wzyT+oNiWiI+gnhgteoS0VxzHzU4nKPJxL8tj65FVg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.36; Thu, 31 Aug
 2023 01:12:18 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 01:12:18 +0000
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] scsi: fnic: Remove unused function
 fnic_scsi_host_start/end_tag()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1msy8uiae.fsf@ca-mkp.ca.oracle.com>
References: <20230829010222.33393-1-yang.lee@linux.alibaba.com>
Date:   Wed, 30 Aug 2023 21:12:16 -0400
In-Reply-To: <20230829010222.33393-1-yang.lee@linux.alibaba.com> (Yang Li's
        message of "Tue, 29 Aug 2023 09:02:22 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0044.namprd08.prod.outlook.com
 (2603:10b6:a03:117::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH8PR10MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 8317e1bb-b534-45ca-2b45-08dba9bf5239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8gnQKpCzoP6Potn3/46CjcsxbXGczyekh6uHFjGuWRi/dgZOGiPGC++5IRpI3JqoQJ3Ivzyv4kHZFCjmlDZhpPV4Ow5IfltNlO8ZG+5f8Rqua5k/vRpqrGlRxQkcml5nR7gTWalEgkdukiHW1aiEyo0wPMGT9ah9iDg2cazNDvqftyJIiA12JE1jncVvj+ekCUiawWeg0wbyGi4I6bgov1I3t71tUlvMFltB4pgAlb4YDgfABL+PmbpcDu+SWd/0uRyAdpoIXNoelmjO7B8ri6MFxtUQzNKjTYsjpKzc5k6DzQkZOcLZk6jm2CtoJDgjmTxumvWlNRMywZ7ZBlBzSC2uuafRFypNhGNNHYIr7/g0gQBn6dB21k0xFMQ2edTHT5oxJxLBqfosDSbZzunZsl4dfk3ue9HE5mTajTvADuWZpNsu6CjLwKhkrfVS1IyiTe25VCsfOYrcoZA8k29+CBAYhqjV+ie3dSRCA6hfvHJ9yxGTBzqadFVtsXjjAfENWctkpEkraYnWFz4WlHa+UTwfo3kyZMAbT/JkuOyTy7kLCYKqC7EKTy+Rc8gSed2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199024)(1800799009)(186009)(6512007)(38100700002)(41300700001)(316002)(4326008)(2906002)(86362001)(8676002)(558084003)(5660300002)(26005)(6916009)(8936002)(66476007)(6486002)(6506007)(66946007)(66556008)(36916002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aTvkVnq4snAdcZQbri0zL5rt+MIOagq1uFSRCQ9isRlo1/sU42uSOYA5KHuQ?=
 =?us-ascii?Q?P+lokq9N5+bLy2XZrmTAAgLbpJp8dyCiCPF8uhs5/fUbTG7I0upTOqbK81uT?=
 =?us-ascii?Q?UZMLGCoioI349/9n4vGAl/208izAV57IVQANiIkfOuMbMak+P6PPZajB2Xk/?=
 =?us-ascii?Q?AzX3Q6CVONMbEzOgWYPbiy9aqa09eP1SAyXVLUgShrpma2FGnz32G8E8+IEH?=
 =?us-ascii?Q?RWGJ8LpzOQnXI2WHadvozZzbt3EeB7hOtBLM0qd5CM+QNGfMqgOw55M6N3eZ?=
 =?us-ascii?Q?LuLcNtalM/qs+xwEt1WhjSvpDjTd0F/wZ5WfDLzPNufjG1v2ZzFTRDPnP8FX?=
 =?us-ascii?Q?pqz5cUtAiVRevATZ2e+QUiEbuhr4NTz04A5zvak3U2ZZUj1VB+dgVG4kam3t?=
 =?us-ascii?Q?pdiWf+hx2J4lJVnGqvn1PsFHdAN0HhbiU8W+2bziGLahwUaX+Zf2cAT5j7Ty?=
 =?us-ascii?Q?JVY1x4DGAQaCg+l8CqKyY5v2saW8Z9UjCb+8pFoZXWmIX632W8/MEsCxzqio?=
 =?us-ascii?Q?PVAXe6XRyi8pGwjFcR9p/XGXsTP74W/LsU6TBSGISXRCcKYorLcB/T3+TC37?=
 =?us-ascii?Q?4L7vchT5FV0kdbtIbEgZ0CyjM2qNi3nOMNvLElwDeHXHpxaSPQnX8/YKvvfO?=
 =?us-ascii?Q?jyPP9yjM2ygsrRTrn8rHA4FU2jaq4o2hvppP+AAPnxz/7nNo5asqUWjzYNGW?=
 =?us-ascii?Q?1CwKroyP3/PCuvPVVKVvwSRdN90h+r4+vnlMj0qiv6BmrCWPP9/RS+nf2WUH?=
 =?us-ascii?Q?ODQvr0oowFg9Vt5Lq9WUk/W3Zur6xVvYMSlfwT399SVwcqD6Cig2f6ffa51L?=
 =?us-ascii?Q?swZcGjWIGNtBUCehbsO8vBcEySEwYNewrhDj1nkJd0IBU279gy0a5CCNV9Yd?=
 =?us-ascii?Q?hQh1mMKXFpySSHwM4VD99otP3hTfstxdCywZPR5QOU0v+C4HpLZxuaHrhPmt?=
 =?us-ascii?Q?XVYRhCSvMXgLw5Mg5ZihGFmwfdkqV1oZgUxGRw7EqL7G8a6sq7sAjqb/Ut1/?=
 =?us-ascii?Q?VFas++WykQx8nrRQjnHrpKocNjs96702RkB2McTQ3JNf0VqfWuoqWzxH6hGr?=
 =?us-ascii?Q?wApQWl2DSrJRhTUGdNdUqsDeAoNXxCS8q94n3xgp6aNRcaQf6WQaEykyQFHJ?=
 =?us-ascii?Q?pL/9FiLsr/KwsPyPW5uvKuvoa/bjykqHxHiU0WH2MPdnHaOOCa3i+MFXxyGP?=
 =?us-ascii?Q?f8fSC/7sS0qyC8WKnQVjrrgsNexxX5gtsMauMimOq0P+VVM3p/V+8/XDcUFL?=
 =?us-ascii?Q?9qboY9AymI61qbLvDCxkgX5CWotM7wHFexucHgUigsGIbVRAx82cXFQIqhu7?=
 =?us-ascii?Q?bczbEVNiw75mooGbtuJsVDndh5OKOQC6ppw1LRUBtxF/xit0Sma0yb0T/PUT?=
 =?us-ascii?Q?SzEv979C0wwWMIQ9dvGSTa9xEwcUJBWthB1PKbiBwMOvRQmKlU3/KuwT8eMU?=
 =?us-ascii?Q?ck1e5s7o1+Giu2zvG01AceH5XlrPlJ40IH8iBKlahdSADnRsugfoq7RewabC?=
 =?us-ascii?Q?ZtKIV4e1J2T1QT3XeHVOBT/SRv3exxRLj8ePxwKiJex4xBhVXHnxW73/bQam?=
 =?us-ascii?Q?vUh+lmexFueV3avvxlXDuKqmB3AY+zQkwPfI+nrGPSGGNrk5MlNlTBcZtlFi?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Q5i/7ub915JlnHNmJTGt+Z3N3Drho7AHSZm/NLoCxKObHyjVQIRlJYXzWw/oX3wZ/y3GCSBvnkstpzOkvvn9iB9QS+oJ3Wuo7hIFj4/oWqoKn1E/O7Je0VeTYtbRjnxiJwhOgYY36uuJJ2b32xZrHAtLEhc+h99xabI/2/WzkOygnL5lEF9gwozwjwalBihl13Y9M2Hn32Z+oOhLJAZAFJOVtBTbvBRi8/1O7o4CrzuFKL7UvUNZlcSDaV5HQr/XC4vkLwLQC18PlzaKDR2izsrn26fRuE25eNX071rZ0KGvpPOrGs39xVsr1dwE/HbksfJRnEdYhQv+Y7kROtD4/qSUio8ySjTT5IHiyx4nYbnEVdzCbQU/W7xGmFnA4k0KsAQK4w43WImnL0rw7gQC9c/aiwPvIC2ted33z7Z5sL10petFkMfyWDvUj+L0R6ONtuvnaYWkAT1km1uyIG35KdNd3i+JMcvIrxmzm7m4jn07rMyfDX981SSksnCrf+WIIuS78UYB/boHgKijlEvT12UlmdmSi7vv5YodbLnEsSkkj/JXkFthXBQK8BKgW6ve1GoDSlPO3LBOFu5ibhHua+4OWzQ92O61j67/HHQXnJMyJJ204+k5I7yUzfr+8QyxeUpeHxOlv8gTNwYNrVnWjAvJ7E5sX5bX2L5298n2cHGAaHmUdxsGs6ecuvNI4sxwVvFtb7iieAoX7KGx4TTLDld7qIKDKNTP1fKIW/W3Ko1HJXf7XZIMUrfqFswJyYWPLas3bGm1ZjvnpJ/AOjsdfTbP+Dpv/AiB9TqR0tquXuEkV8BaQ2ed94VFKDkqP+ERug2NrqZo+D1eyT8hVy4rRcDGSD2UTrd/bqb9uXoQMDa26nT/+C7hy5cRw367R7SG
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8317e1bb-b534-45ca-2b45-08dba9bf5239
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 01:12:18.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYQDwVUQQcdukufTrHusPe3p+whP+SrqL8u/4tngPEvC7rzihu/xGWLUqYTBJtX1qHQ0Ol95N3/gyG0rKzNbzshGusqk/DqnhEpkeYGsUhk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_20,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=731 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310008
X-Proofpoint-GUID: EnzZ-H8PBJUn3epVHm3rPHjlB0hhYFxp
X-Proofpoint-ORIG-GUID: EnzZ-H8PBJUn3epVHm3rPHjlB0hhYFxp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang,

> The function fnic_scsi_host_start_tag() and fnic_scsi_host_end_tag()
> are not used anywhere, so remove them.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
