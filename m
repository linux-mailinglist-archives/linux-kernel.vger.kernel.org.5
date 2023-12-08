Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BFF80AA04
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjLHRGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjLHRGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:06:06 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E2910F1;
        Fri,  8 Dec 2023 09:06:11 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8GDsGT029048;
        Fri, 8 Dec 2023 17:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=nmJ6aqolCK34k4SZzmceo6IarpFhXmBH804uTL3upuM=;
 b=CYLFIIRTQsJEkCGyvNT6NlfQybloVoYxLAm3SR1gwljbWIAoz8knYUFyppvFv5wQrG3B
 yHlFv9Fj4xT3Chibm5QTY7U95HgQ0wb5vqHoFzVd4qan76C1QE5y2UxS8zMES52YSO5u
 yY1wkkPrZy2jAepiOqLpFLHseJuvDXCeUpvteT10dJsw3AlxaY81aWC2iVcdjfIND7bq
 d+MfeAthlawPNEZrm4UtDDnpcIqp3jFoOeTjHXRlcxvF6JF9eHYpv3Cp6FClbIo6ZI0h
 pqJa95xd9ER+YRQtc21JkAUI3umxgr3KRASasZZX6CsYkfNpC5UgdPT1YHx2yKETwkIi KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3utdrvpgq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 17:06:04 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B8FjS2w037465;
        Fri, 8 Dec 2023 17:06:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3utan9563p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Dec 2023 17:06:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DX54WwBIOKuZ/OKkdjGkuV0tD1tjxmwcVJHqHeW+c5kKLSP+Ig3V0+QF/PPMmX8q334tJJY5GXkEL8dxN/LbJLbAsjzPWHZDo4PwAOdsbaaFTVHH6LtHjDK/S6qSljf3T2rzxP6PYo6f10iBcPsdDLLGUFbCoA1/+T2IdtxpPJlTy4HxEhfoAVIH9rQzymG5EEchUBUpb0WoV2LGu5nx7gkZF576Dw7ydOPI6le1M+q1PkwR9CY7/jhCPF5fsvFyl1t+wocfwoXOw89egs632lIgl/xVDvqEJWnRDON/vd2CoeHb8tG//GYCVU3/cCb9kDf6iSH54NY0I0KR41MUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nmJ6aqolCK34k4SZzmceo6IarpFhXmBH804uTL3upuM=;
 b=frmKUm9zE0mO+aotcGBfKtQ05MWdt1ZtZs635XJ9Tm6St+Mw2ge7yoK0nLuoeXxrifManF2JhFIU65MQN7QtBtk7JlIv0mhXZO3ml1IyocbW4lgln8HBlJFnz5pOL7L4Cc3nJAAGKZQwULDVue5Y9Mhx6FEZhf3gTE5HZZauYYUdz/xsJpq4fEfFQGv2BqgTBiPJCLDeM8rgSf7w9upSQqtSyO2jYfn78U6gIFSVU1S+PJPJGfIDW1z1ZXV9C6Nk3suoOoIxLuAQKUzPwKzKfH31PsO9iSoi75XriQWpo1q61n3BPpHHtRCIWkDE4WH2gBqqt2PmS62FR9x7FVdp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nmJ6aqolCK34k4SZzmceo6IarpFhXmBH804uTL3upuM=;
 b=ky3NW/+Nzu6El5IcNKBBI7+u3xpBNxGHGe7Taew5zyz0wfHu5hZDkG+w3at+gvNDkRZuDQpeg8Dz8zgyq0E6dbQTHtW5ktqIO9tEnrDw3s2I5xHkYHwhmbyadkngzZAOPdbGDjjiwZpzIkm328Mr+80W2wfxsolFp2tr9t97Uxw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5065.namprd10.prod.outlook.com (2603:10b6:610:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 17:06:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%3]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 17:06:00 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chandrakanth patil <chandrakanth.patil@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ranjan Kumar <ranjan.kumar@broadcom.com>,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mpi3mr: fix printk() format strings
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a5qklj5k.fsf@ca-mkp.ca.oracle.com>
References: <20231207142813.935717-1-arnd@kernel.org>
Date:   Fri, 08 Dec 2023 12:05:58 -0500
In-Reply-To: <20231207142813.935717-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Thu, 7 Dec 2023 15:28:06 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5065:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b62773b-a40e-4e85-7ddc-08dbf80ff3eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yOF9AGH69F3Pa+p8OMFhLwxi64cCO/10oOjAzgJEXEsACH9L2Y128jyK2CjVVmiDY7kN8K+MrJaguXCTjE4HNRTYIxAHjRzFHQjxB6QcgAP4FzFFo1emtNQrkdhM+suWxj1oGaQ9scW0b7HYLLj3XI4a71Ts/AKJKebd7PANGSAYuOjFXv1ApJtfGLbcCKdeTkim8RFGtgwO4PXk+hAv5Wmy6NBdE3yNVdVG2jxkdp+SgRKpZeOkSsiR+oIjN7pfAC+RMFNlKjqp5zcXRD6EOZmnIEWSDwjy9GSYhl+zRxY9hKLaMj4eJLffOSb/xfHhHgJKdMn3zNwICmcFJSB9Ael5C1xoE0ePCxjPbm71ql9me4PndDBfs3JL98EIX7xd0YStpfzPgU9gQsuOsPKICjgBEEm2m21F8/KL1jPHLbbXnz/1DLr0qfHF9NYZS4OKtzGuD9cMou23rF0oYpAPAV6/kxRHMsjJLDZ5LXhJI3aXc3+UXTbs1eoDhPOMnFHmVGg911M8FpM+i1ZUiYE+A8wphlYNHpT6jkdWt1vmfgE3WB7FeModdbuMjkyCpPbFZrXqaVvBjmbcBnQIBBeD0f5eBb+xouQf0A82OJwy20=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6486002)(478600001)(66946007)(66556008)(54906003)(66476007)(6916009)(38100700002)(6512007)(83380400001)(26005)(316002)(6506007)(36916002)(8936002)(4744005)(2906002)(8676002)(4326008)(86362001)(5660300002)(7416002)(41300700001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EKBzfgFDBsWxoMXQ11jck7dFvq4yagvC1mvw4eXiuqpPFG07GsYS0+MPo33r?=
 =?us-ascii?Q?RXIxeD8xjEtmtoy0aDPwA657DRzOh+CxyMGg83FKutEhDpMcDh6DpI6OiPik?=
 =?us-ascii?Q?X6u5bly8DA0Bglva7R84Cv9ANQdrRWxf6dPi0V1v7fW/Jhb3rI6+lsAdEuYr?=
 =?us-ascii?Q?Y10CQvPaVwW+3kEo3CvNB0p6e9I0Z+QhobQVtMHFXZmMBYMO1y82WC6j9enU?=
 =?us-ascii?Q?5ClSzrX8Of8lswM0RrbsRioGf4pNKE7oqFWyOsUZVhRqWCBnK/Xn5cC6riPf?=
 =?us-ascii?Q?dcY/0qDDfqkrnDtfuQf4TtE8uWQLdTdGAHqKUUfxpwhFXN9n+SjfXlnuYPmf?=
 =?us-ascii?Q?2uaFxUYV8e6Cjs6x9WjygNEhj8B7Z9rm08qJbTtnUI1WV3E7e50bfYJ49xJf?=
 =?us-ascii?Q?wBXjJceMXmQxwv+Upktmz1lG24TbbyEMfsYcR5KtVWXucAbSluMMnpMQJCgU?=
 =?us-ascii?Q?NgTCNAnd3XjjmZGwLzm0dnlB/r6sAr7FOQ6Ec5LB0bLcoq6IhoNWhgK4gETB?=
 =?us-ascii?Q?TH1aeGTtITI8h5q+bgRQg5UbAnR6nQ4qCZv06mEa67PanM5sItXSBb6FD5GQ?=
 =?us-ascii?Q?7UnPELmKdEbKaX2MrAFisXknckj6YJgUyQIC9B1B4H9w/2JjfIqg70CZq8es?=
 =?us-ascii?Q?Zf/yx6MbE5nZKP4aKd1kqdaMFh+jKjxvz5YUfWuB0x4/H6/inODBwNe4WHLw?=
 =?us-ascii?Q?guSGxiiqtG1f9bDF4SjmPmZKoL/paWoy0qRRWH4v3VyGiQawylm50ZBWAb9l?=
 =?us-ascii?Q?1lyQ7FUFBWDLtQ9dpCvZup2i72M8QD9QUNBlHrmVoBG0nkFpM5tSlkIhKWno?=
 =?us-ascii?Q?dlwZWe7RmXeFFehLlcVfhRM12DBEWLIY8y9kpC/KxfipsD5SULpbRqMCGXOs?=
 =?us-ascii?Q?8mAQJ5JdeofUIcJ1Krkk2faUbvzjIjGEHoGB9ncdytiRiDkm/8gq1LX7Z+Nv?=
 =?us-ascii?Q?r2ApeXgaW7I87YAim/jeD8Yu5sJCiQ7O4FVtHiaLuUHw0QDQaFwu/Zn3ec6G?=
 =?us-ascii?Q?K1Ci88q0FKyTSjxkEtD7i1zhlOmYcXn+2LkOqbxViNtxc6QKRcSQrXqfwN0e?=
 =?us-ascii?Q?VzPYEVKF4XX0WcMJ4kBGlLSiostQ1oJMqVp0vv7O3bKTXrUc6OYOotBtP2kL?=
 =?us-ascii?Q?wGVKVY6Lm3cg9mEpk+weHBIDf1hrQALiWVNHPE74NKfxkYUPVrdFZKGdH0+O?=
 =?us-ascii?Q?6g2o+55UlL2prnQK6/umhwwVbLDElzZVzUi67Gm75t0hh7A1XHCtGsaB8hUd?=
 =?us-ascii?Q?GESWeFzmAyRDMspETUf/ILAylF+bwdFVi8iwoTmlXmAGmstbOjgVxGm7xuDn?=
 =?us-ascii?Q?IYyxBSlKjyQYxTMWXQTlePT7hHHE11uq4A3Vl86GFDOmHVV4O84Lljcn3N2Y?=
 =?us-ascii?Q?3SX/omH+JSw7p7dfrGXP30AsD7sNUkBDRGAJVTpx3bJNKRVRKmKjRZQ4e2Fh?=
 =?us-ascii?Q?jOLodD8wkMsWJ3EHKnJFFe7pRQaazqaCfDrTQJBE783Bqyk3KKGIGZdMNEwn?=
 =?us-ascii?Q?fV5OG5wBS1Fwe3iRx6FX7sl2CYvM6L8CfnA4Q9tPd764zC2vD8ftW9dZDt5h?=
 =?us-ascii?Q?sDS0LECaTxuwmAYr98YIahAbP262P7U/NXLhvN7dyPaDniXWVMvYWgZ3+7Fx?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: b6vnSBrfYeNfjXv/7F7LOy8MZNGfUUq+aKU5MzV1WLQ77LI95tYc5ArlaRMGBB82ieE6OriYjPGTrWfy2kbazc4il2QCYOctMJ3k8IHwgO3p7wyEROeBAS91wy85oQwxv3KUEwJryXaTgCPASHpcPLSbAxnEu0thZkvLQITwyJERUEMPNn8bomvyaHYQTN2xrmE+R8Kml64tmx+5ZoHWrOYwELQ/sU6XFUS0VUK2TtCyU2fYMUiurkICNX/yPyKaGbG26f3lRRRImHMNTnXF9M+taGqLQ7Nbct+GT8jWOeTJo8I65pt7FzQBcfaJSR4xGHjxOPrbcOmkb7JovPOWBIC7Y+W7nEJNZ/CMzzjf8tLc4+ayU5DxGIvXOt+dpeRw3IC/Vcyh5iK3019zn46HJDGOK43HvHYNtvCVhUr5CK3MrXd1R3kjFnPyuWJtg4G221peAYc2FGGVoWS1bub8UAEvmONDpVvsLZYQzBghUgBW7vlt2zoINr2FRIF0J3Z/+XWgdkeMjPyVRyK+SfJFlbo1JHd9aySY3hZ+Nr5B6r7C+3HjBQLLUXh+nkI74VvWyUE6pXB36d1EVjZ300tRYjDgJyWP8vWu7Rl/O+SQ398mQe/C1y/o2PLj2rHDd8PN/BfKGX4cpE8At1bB2W1elvEL+uzUPz2/Vcwa536eFb4/a4TGmiIVZzgCPCOt/yFQCf45mSG3aOD8lLqeYzFas1tiojfg72Uvsoy/76zQbraU9kfhTfl2QaWx7qtjXiPDuFHnMfpzheh8WDfOywIcsZU/gy7xHHMgvK71O8YWxnbNKlaUVxhsGmpX4Kuj6kXzKynAt+Y6qkb/avF/uMyPtfUrl/MUMDn9NHhOurqMvoUfBYlAEjvDC5Jf6sYrxuGyWoOamj/rbb6jWgNOg4nRn5Z0YN5fkoCawmCPWeVReQQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b62773b-a40e-4e85-7ddc-08dbf80ff3eb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 17:06:00.4836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPaYZHxgrjVznv9PqB+bxjXe2zzRGWxcIjLjAWvzrI8O3cIdsAnQvkieopYE5+Ul5o+FVUtW9QsVbIU66TAxSzL6uDmOQKmGoR4YfRPecsw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5065
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-08_11,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 mlxlogscore=812
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312080141
X-Proofpoint-GUID: 7VdGC2CasttcW0QDbzp3BX8aajsH2djY
X-Proofpoint-ORIG-GUID: 7VdGC2CasttcW0QDbzp3BX8aajsH2djY
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> The newly introduced error messages get multiple format strings wrong:
> size_t must be printed using the %z modifier rather than %l and
> dma_addr_t must be printed by reference using the special %pad pointer
> type:

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
