Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FD07B0959
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjI0Pvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233052AbjI0Pv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:51:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5454D5B99;
        Wed, 27 Sep 2023 08:39:51 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RDSsDg010570;
        Wed, 27 Sep 2023 15:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=5u/UQtXnsXrTMpuoQCxYo2HBBkwzx0mzUD8ZnAYJPj4=;
 b=XshgQfbbDdz0pnxNSEFMtC6IOkZkilX7NJCUcrQFWKdNL2u72LB5p4aOnbtMsQd0QepF
 yWis78Uu61/1V5GEDaXDIwWUTMOKwMNVJBXMmJFI7DceaoSGM0iH/gUTruA/5fmEmjrR
 phEz2sSz7Ve/rdMtzoypsX/R5NDlFDxJU9d4132E/qgutd7oOk1Umzt6agSkeo8JniOn
 OM9hwDi2sWoVtFEPG4jmivTK6d5XnifTE8PhWVbWqwqdWmGJrQwsY+Oupcrm7aH/r1BF
 vxbkR7YFz6Ae0aH6BQRYDlZpPBLfjvzvtjvWI0Wil18DPaHHhSD35XhJfJGzkzB0LRPr lw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9r2dj086-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 15:38:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RFOt69017984;
        Wed, 27 Sep 2023 15:38:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfe3ehj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 15:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD0UZ51S+GAkOdT/gGWFHBxBhl9OiOUHXhIKyvjWccMuZT96hK7/b3mr59vGsSPup1zR0p2e7WDdVbdJi0k83QbdD52Iugk5EyXS5g0FxKgC8caZvt42IwKE6aHHVYHPPIPe+YlWkZ9nQw2Vi8Uj1/4CFoc83EiOLfRS1h59k2I7ko6nr0hMmZNc+HUFVAOG/9e4Q/yZGUg0a0HQv/Q+4KgR9RBWDHMK60IESMifnTys0EaC+XwHisWqmlhbbbdaSg6DEzlsHKS4UQMfn+ihbf642J1RC41rJ2uMsH5F+irSsPWkoWS5I1hqx62wfvDCP+YekmYQi06etK+rEJTSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5u/UQtXnsXrTMpuoQCxYo2HBBkwzx0mzUD8ZnAYJPj4=;
 b=OxBCJydflxH7O+cG/xoLEPHIK6SPu3qd84LcLqonq19p3iZpXUumAwAnkQ+MOw07ko3v3tMUcbDoiRkxDgvvos0sYHtFyjeOdpp7y2JTX+hbEF7DZodYCKKCvdTdrLsI0fdnFkwmCFlBLCD+ckwDD8+N3+3joY45vwC/xSyg9jE7jLgzQnaZmSh8METbSUnyCVZbRuxyk2BdrsHqLG0j/W9dDlROePpQADRmysB31/hvFwpMKaaE4FsIo5krqDKBYAoHxNRYyZmplVOJo1mml4tOwYgtCunZEPyFyHatNDHEbBxKS+8j/vK8F46flfLy7RM4b14gfPlfC6e3YJqTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5u/UQtXnsXrTMpuoQCxYo2HBBkwzx0mzUD8ZnAYJPj4=;
 b=XM8yr+Oj6EI9bt4hHMIS/LraKPHbNNweLhBAF2jKrJQTIIadmqeSzcjEWlkH+kHGNEmoe2EEj8ao9SwkKqTnyoZr4jGqF6+wILI5ajRxluCxCPmV4FZzqpgp6w7lnBffin6SoI1v9bF1MSVtRzv3OuwWNOIEzhB1qlHbh68YT9U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB7347.namprd10.prod.outlook.com (2603:10b6:8:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:38:25 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 15:38:25 +0000
To:     Douglas Gilbert <dgilbert@interlog.com>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>
Subject: Re: [PATCH v5 00/10] scsi:scsi_debug: Add error injection for
 single device
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttrfzkz5.fsf@ca-mkp.ca.oracle.com>
References: <20230922092906.2645265-1-haowenchao2@huawei.com>
Date:   Wed, 27 Sep 2023 11:38:08 -0400
In-Reply-To: <20230922092906.2645265-1-haowenchao2@huawei.com> (Wenchao Hao's
        message of "Fri, 22 Sep 2023 17:28:56 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0052.namprd11.prod.outlook.com
 (2603:10b6:a03:80::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 244d9ff5-73de-42ed-0aed-08dbbf6fca21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzmXchTVTIPjEO5FJwUy9B6yjTOCCbL0j4np08FUh59WmBp5243gpWQ2LQzr04zIMaACt3x7W4ryaTI9Ovy+cHge0epQFGpvO7LmsG5KGB0ZaGne3YCw/zX1MiTdGmFPO0GeW8QV4NFVeGeB0c3f0FFWZAU+OvEllcekJYMwTUxSPzC104xptOcoCpPvh89I0Ep2Fi7VlbAxx1wiW9ngEf54RKvBqrPKhGIY0dxOU7F8MlYSvlf8iPM+9Kt4/dx0Y28N88R7KpKg7UIqPM2BWFO2eQgNKSNqCOQfDiY5GoouSZOsU0lnbiTbqIECl/2Nb0cd6ZxdKKyTByT1vlcUg0RhYxaeEDhBmrxzespYOShH3jiWRTJTOXTH9nHNlmbpWjgWZO4pkWyCdiudYM0Eoyl5Nmjnj2esLa6nsZe0hfQsByD6x8bJ3WtWsFsvVaYTdYIsV5FYS6llqHxpFpwN3oKzqqguN74LgFIsnMENIlY59C5OheRmszOWQNgJ/G7oZ2cWI3ghKKWNJhwfIp19PPfLTsNPkC21wZkyOY6LJetzy2fXeS9kvKM6yv9RzPUf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(86362001)(6506007)(6666004)(26005)(5660300002)(36916002)(66476007)(54906003)(478600001)(66946007)(6512007)(6916009)(316002)(41300700001)(66556008)(4326008)(8676002)(8936002)(2906002)(38100700002)(6486002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y7svNWbei4AjmKVYkGtWZjBdv7AL67kBurmWOeC7ARCe/9C7VibjH4YkYlHc?=
 =?us-ascii?Q?5Yc1UBeWC6tFPjHCwvYoxq0u4L5JJXDRxte/L118p+Aga3G7V1Wdb6eYQp4m?=
 =?us-ascii?Q?2Zl42eZzwJaNnogebEte1C98V22mgdU1QbDzPQRpzD0EU3JiRfsO7Oe6Wy23?=
 =?us-ascii?Q?3L4hW8aUatAONKozTOA0uQ3551zroZZEws+jr1cbl88sIjioKIAT/BDjf1yQ?=
 =?us-ascii?Q?4zVKaZSsMEdQdHbXEpa+sL3W4rkbzCjQRFngA8c+lzuLyRFUTc0DFaPDfu50?=
 =?us-ascii?Q?c5HluhPX3MIyFR6W7jSEPF9uKSTjsjjeD5ChbQ0tUdotNkUQmlJIVARQkGXT?=
 =?us-ascii?Q?Q6sjdUM40LJl6lovCQ85r8jQx6VNnSQFff5AhdZyxXmzFzDTTafvdCI8RKLT?=
 =?us-ascii?Q?CJAYJz8Gff9+WUrIaZlUpEfZOOgKpqVyALfDpaD/jtIFcOWX/k7U/DfghmPy?=
 =?us-ascii?Q?Q02vwZidkjgcUmWKtRIPaP8JJfQUUkaAqo8k+ugbG2J4vWcpAMWNhNIJre3+?=
 =?us-ascii?Q?TNLE57pP3YgmUvwizTwnqojUflgOsr3Smf3WPppQYPu8zm+UyNkJbi05VZ8F?=
 =?us-ascii?Q?+wWT24G/86eCVRUn9ZkYPr6Gx8ImyN5wrQy8XQwX6kgqvs/sbTt8FfqiQtqe?=
 =?us-ascii?Q?mlfhQQCn7rgU0jzZGAs737/+eGSLLNGD6obKvXjoU+ahmceFfLI3YsjuA9No?=
 =?us-ascii?Q?g6I9UiYQUjPvEiDjRNx+Oy8kIvnszpc7/LUPiR5Phdqk4DLbC0skI6zMaFLM?=
 =?us-ascii?Q?YzSOMreespWBVfuS24TondbWpsKDwxt64jyb3c3Akd5bRQ8+cdayJXixq7+m?=
 =?us-ascii?Q?Agim9eT2cfcG94leNPv01P77ahghbw/9lZIRFaRwn9m9niT1mymDW89km+/7?=
 =?us-ascii?Q?NepAv9GvIcBua5p/ta5cb9doW/eQzeRqh4+kuPucd4iRBtLcs4ukiMkSFWv7?=
 =?us-ascii?Q?tPp147kgqPYD6+8Gp8bD2WAcmuaWM8fZpqaUgX9YF827SNRlQcd/nBU16bHs?=
 =?us-ascii?Q?jSy/w1uiDq6O0gUf3MSSC/Ao1YVOdXIPKR2Ntt1a0cwrp+sH7n8sJPKb8gLa?=
 =?us-ascii?Q?4oRqc62MmmzzCbS0Lz+Ls2vVzOQ3usLXN3sYUgjbXLoIlVTQd8EYVRPJw6SA?=
 =?us-ascii?Q?7Ty0JxWIFgbManl+8mEGM/C2pT2YsiR9VMUHKLjUBpW+Mhlrq7eCePZjPSen?=
 =?us-ascii?Q?yAt7AK2WJUGZUFaYo3ohyBlq27fzbkVf1e3bpUS9E69GC7Sz/Hi5xPCkL5n0?=
 =?us-ascii?Q?ykhS8t4HXFA8UWpFlen1tyruDpxKdFG4VP99ElwAQz26MD847Bhh2NU8thHv?=
 =?us-ascii?Q?EPMxEMYPlny62bl5wYFou/AVuXEglv8VrE1opv8ajUph7VI0Q2vWG5HA5h2V?=
 =?us-ascii?Q?0NGItpqCy8ZRp2NqULvvgbgPiqiW2hau8ep8bt4AHS9RXMfbuhJYQYpvMIZC?=
 =?us-ascii?Q?J+6I3MGikFrX+3yVa7fiRjWUICKHHgYymHDbraMue4+IXrEoKYz3p3Y0nF9M?=
 =?us-ascii?Q?C7hSUQw+k9P7GL6j63dZbIsbuU0r8nZG4N9zR+m5BDiof44laVFNN9lRbfYx?=
 =?us-ascii?Q?/pBnRqwj/5MsPCFonaT7SpvA0kM74JLYOPlMy2lAmrvukgobxxkXo5Jx9Yqw?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2XVGZXrIuzZaQDyFN2yDmPe0KL5d2DER5ceBNjPpYp+8kG57RCTf9xIWmeOtdG2lQGDwEV//cfnVhX7P02ledyZvatEkJPTLJO6GF40IXYDOYcNfGydygk5QCkV3v2rAS3/BnaXb96AM9HKiIJofHBpUkL3wj6BfEQwe86uPpiWoRfpc8GKaFzdKEOJGGkBTeyaYpL6//lR0VpweGEEYMwX0ABzW0ZSl5NAWjbU+Ic9XlnYNoWOAkkaQBFJMkRdO4Pkk3dhrWeGzkBvQ7eYa8JuzFgyS9SwdLkKBq5N91xZVov0flugvkMzWj33jzTK03h/sqsiO/IpkiomMC6XY1FLn9nzWY2AXwdMYeCvaqobSFu/pKkiGiRm4oocL9mavQjQHXU0anneOI2FGs5M8v3YOvHVyVJIw/M3NNGhYMfZ0G90l7E6A+nGQaZCioPYqDAzQwlW3z/IPcpeYrnaNaNeGXyZ0Px7pXsfCTyuSbyi61bvC5nSLmhz1x6LTNsfcoEBd2kZGefKuj/69zmqsb5TxamottC572bxLvqT3Jbe2piVMiEiQsHl6lqpeDkt9eVUVCkEeNHPZASGdJYN/+3AxiqPb5zZEOXmr04xn4tOLU4QFF87DOLvs+lfgW9FSUd+iIHTp1doByxiuvIveyFGNqvGBViLai6bDK679GTjD02bVtCsrcUEicjXUI0T9VtIrS8ddG0BBHHfjO/40WyQNqQlRVjX5hwKtLZ2rA5Ry7irvmjLntfM9sW9AqG+vdclOwoWARIgBRs2kpaWDYiw0gUNtBTGf3G37yXk/fK+RkuSiQSZlbc6zebGhACrovJv9RTufuZzy4pQRDUQ9ohfJ8rnRRonVWoAZuZm762BNLn3Mxa8vzoQojU5d154L34ajs/yigQpI3IEWjXALTQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 244d9ff5-73de-42ed-0aed-08dbbf6fca21
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:38:25.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PAU3ECQhUUdS5J8a3cvRgz4hJSOr0MnMw467NCaQmxcZPtM1lnRGCSd7+C2hmM6cGXfZuX2oWFZ/GTGfNiDnuVDqSyQZH79fK8ybUlmX6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_10,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=899 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2309270133
X-Proofpoint-GUID: nJTObV3WQU8LXk4Bic0V9BdhUiNHUWVk
X-Proofpoint-ORIG-GUID: nJTObV3WQU8LXk4Bic0V9BdhUiNHUWVk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Doug,

> The original error injection mechanism was based on scsi_host which
> could not inject fault for a single SCSI device.
>
> This patchset provides the ability to inject errors for a single SCSI
> device. Now we supports inject timeout errors, queuecommand errors,
> and hostbyte, driverbyte, statusbyte, and sense data for specific SCSI
> Command. Two new error injection is defined to make abort command or
> reset LUN failed.

Please review patches 7 through 10. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
