Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31562783448
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjHUUq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjHUUqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:46:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FE791;
        Mon, 21 Aug 2023 13:46:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxUhx009106;
        Mon, 21 Aug 2023 20:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=D9vtb4A3jZokcMy+Ip9Oq87Y31cr1MU5ftT1YLOEUnw=;
 b=mC95xNFYz3VafhVT1Qk3v+BYrdaPTTnluatgQjpiYICbvJf4VJ2IsZOGPq0UgFIGmAE+
 gNRf+jloQO2o6mWnWwvWvJqzGhwgSCzQEoFbnWF6kxykn1FoQHHYiujkFLZeHOi64xjp
 8w+yfHTNvdoLHiU9c07aAPueSdHUHuHvYdKiUa4kYEpLEq2UiX4GNmCpl40EY27JLH1h
 WGnU+1HN8h/hKWgVBYXQx7D49R1lMaf4wL5BSR60IG5RY0K0tT8wmsXSYgsK8fsqQCMc
 +EuRgm4B5/yySAIOIlsktCvNbtNtJ2/aWokzwwirgOd94SljHgpsKQxIgQp5BzMa82RZ 3Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjm5duwqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:46:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LKAB3R030368;
        Mon, 21 Aug 2023 20:46:02 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm63ycyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:46:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APA2Acqc9xD7Za97vv+Kxk5NoOSIanR3y4I9RYEBdNa3h2hW+2b4ZeK9mar9yjmXwDqC4phjDLiNnZH16exloxGM9ClNHpiOKtYNfa0XXkG0b7H+pBL0sjltWkNcYwPJ6MRkjd5/WjUvmAjONy5Tf59El7Tqs7sPP7vaqs/NZTfjuWNOF9v4qLK6RcS3XIXQlZrPjlrrewoc+qQROwcFa3MnkpvJiTJa4bxqLppsvzba3TO/JrzAgRD2NdnoVJNp3GpWyK90aOZWwctIMBPasAYbtE+FbPwZ0fhlAlzzEcgCyLIG2jhIudtp8F+D6XuaOMAZJJTNEHX1AtOB8UW28w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9vtb4A3jZokcMy+Ip9Oq87Y31cr1MU5ftT1YLOEUnw=;
 b=gCBEwVTb0GT+r+0R+QpmluTjFi7ZGo33jhuHH60sa5WDDS2kOgzeYO+kBemc2FI8csQkv6AlkejRtJYRBcY9EZhRmRcnJ2Pnh73Ib0d5GkfuYMcomTf0NbjY4sxGLaWl2KNZKUacdY0z5EWSVIqoB2Ht36Ye+tTIjfS7Gf173LJN5kf4XmbnwLqgKLj/FlnyYOsQQ0uhkk8l0/Qfj3NPD6oWd1Y9LhaQd3GpIldeKUd/eoHQctveQ2XKHIxlywzR+/Xh5yqpEfnD8t2OzMA/kB9f/3xdDclS/bt3AA0SXtchIFZfwMSnud659jTRL9krVANlLmIusacYN2NbHbnmlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9vtb4A3jZokcMy+Ip9Oq87Y31cr1MU5ftT1YLOEUnw=;
 b=FUvi6Z+zA/5qAgj92uoRFQeM2F4ZxoJ2qy+y0zfN18lTPz95ghJ2soNMWzUYqWwUf+M4qAnBKkMnnA0attamwZMnDzY/Mo2s9a2KLP3/T5PcGCpdG8FCSbAJ0zezHh48Mjeieh5jzqWfhnzTet2AediPDEVNuXKvTFLorSyrTAQ=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB4234.namprd10.prod.outlook.com (2603:10b6:5:21f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 20:46:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:46:00 +0000
To:     Brian Masney <bmasney@redhat.com>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hugo@hugovil.com, quic_nguyenb@quicinc.com
Subject: Re: [PATCH v3 0/2] scsi: ufs: convert probe to use dev_err_probe()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a5uk86py.fsf@ca-mkp.ca.oracle.com>
References: <20230814184352.200531-1-bmasney@redhat.com>
Date:   Mon, 21 Aug 2023 16:45:58 -0400
In-Reply-To: <20230814184352.200531-1-bmasney@redhat.com> (Brian Masney's
        message of "Mon, 14 Aug 2023 14:43:50 -0400")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:5:134::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM6PR10MB4234:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a18abb-fa05-4c41-5b6a-08dba287a098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kogL0iKvP9L6f4QFupyplcdDFXPHACsezLtRuaPyZfMbjI806AJq8DrRpNtHpZBDfIlHof2g4llyMVNQvjyR6QxdIVMQBlHag+bSFXAzduxXsyxf6aKos1pzxzakV87d2JZkerYMNqxkjzvTU2/esb6Opsdq0MK1nehZDzJ3+GUDDlqYknLV88lqS6J/fYFVk/rHJnptzpYN0kvDgAV3hYx4NShhuoVu62zeUIZmNLgsKrH2B5/VQvr66uiTZbfGAQnI+pZhKO2xLppVEXnT3JI/1JJ77FlYrf5otlFVP6LfSGiTyrAaHvZXNAHs1QM31zqaXw9dwTreIJJb0zSQe7h2ph3Z1jgGwr+nTlsnjzOzKSsPQxwIfimiGj7c/EVtVvm1lC26o+Qfk8WkWFUCpYIJfsJJyF+QTLxsX3PlhSQUviNCVZE4JHzAvyUKRlM67QU+87hNdrwOUxA6I9q0IlAnv+vUmX0TrZwbRKQBgPnclGqJALVp+ByprOMUo4RzudFfsNdyIMYwGD5/OkLH6yI+20B68mYWG4bMFwEKTRouRq0esLyClZQpZ5890LTC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(4326008)(41300700001)(478600001)(38100700002)(36916002)(6506007)(6486002)(83380400001)(4744005)(2906002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XtZAa9IVT/lFpciFMMX1YUWg1oGc5OyUWjLAp6noULnJKFS0HHluqJi14Q3j?=
 =?us-ascii?Q?EqERiKGWMnRNxam02N76bdclruJvzTY2TUAA7tIe1Kg63L5H4qDgv0BKVJI6?=
 =?us-ascii?Q?GP37gfY5NZ0RblE4BJiRbn1EHFN4v0aw0q1jB9AxdHRlUM1GBAW2dE5fF/p5?=
 =?us-ascii?Q?vmnlKqANt+qz/nEqjLArQIj2hjkcXITr4YjE8IWfYTFnrZWjk6RmRAyLU9i2?=
 =?us-ascii?Q?D1nWGWAMAtEIfevUGUQPWvLfTMu2/T3ULZobk07YnIsbKE2YpSY48IdFs82L?=
 =?us-ascii?Q?T/82aiyr8ODyyjxnnNkRSZf4S3Ntj/BLEQnevOTtZFMzPPscQr1xcjtQH/Dw?=
 =?us-ascii?Q?eFY5SDpC/+aKYZFFt9U5BPChbSqzjBzytjBqmdv6b1WwTVM5yjTIOlYbOyoA?=
 =?us-ascii?Q?yuCJkVfsmoNUbKI08Hjv+APnddTi5V7eQT9Niv/XY23RAij66oGuPxHmCbxC?=
 =?us-ascii?Q?/edYcmwzrHz71ZQ9fZLQsW42HU0dkDF2NcHQ72v2nx3y54Y1YseA7r8wIXor?=
 =?us-ascii?Q?edA6KfnVv7e5uMDa2FYkJBnUabbQ52bNWd1BcO0ICtrKYJgmr/2rDS6kYzfi?=
 =?us-ascii?Q?3AuH4ApISB7a+6xos9StplEXqxw7q25QnKKClm9BX73wwprOJQm88Pw18j8f?=
 =?us-ascii?Q?kr8g3yRvApirUnvLQ0bu72vWi2ifgkv9DhkBboXO1L3d1JLWOXLu2mp0gTar?=
 =?us-ascii?Q?PPQGnnPSe2GYg7S9UnBHVuJyjLi9RwapaLkBFOaUor3+n6IZP48HjaipwDpa?=
 =?us-ascii?Q?Coa3HRMK3pRbUC+znZAz4tUiHOssi7jbvoBRkWbpJ0H6uEYTXcRsaxbB04gn?=
 =?us-ascii?Q?YL+S4er5Z4/wx0lO1tU3orOC3ynkF1cfWCu5XtSgQmipoEuF6fKR2KNFD54y?=
 =?us-ascii?Q?Q2kjgt1pPlQRVbdqRQii3MBO7NVr1erFzNQ2Uhqzj+y0CjVdFib4RoJ5ROSi?=
 =?us-ascii?Q?rcwXYTAQdQW6Bl0/NFtosdsE50qhz0rX6Iy1IBEUKFeyYpoeO/1CIX6An4lY?=
 =?us-ascii?Q?9rBJ6TiW/7YIIYFpcDaYRNzUwhEEUnPhvqXiDfHpn6fXhtqJimbM/eDFlaPo?=
 =?us-ascii?Q?iCJcMVBdfrGjgFkyBJeHFigNa0Mi0qs2HzGQJWQlb/XmNOQsX9/5ND2+BMCX?=
 =?us-ascii?Q?HQOJDIsBSo0mA4maypl5JKdXZJCNddV2mQRc/IvBlOWUHreKHwNse4ZnttNY?=
 =?us-ascii?Q?YyGFdfGw9T1l99W/Sh9aKRKvT8KQZ9Whu9pI8blThe3A4zMIBSMXptqmSWau?=
 =?us-ascii?Q?OcjKtRTW1hpHoIrywxfiWV79GEc15dmLIy3Z2ty/+fBhFKrO+KKUH8ieWbRZ?=
 =?us-ascii?Q?eVbcOfkIINfi5l/RFh+avWTFCw2g4R/YMq1yDdPLkXEEURfmSr/hSsXtXHjy?=
 =?us-ascii?Q?TMnFzzn6qmK2nWHuZQvR2e5rS92ydSsk8FtIWRhR3cQYVsccnvrmZJ3NJ5i6?=
 =?us-ascii?Q?4s6g/eFNR4vSgWcq/f0mcsFigKfufcIToAqI5YsfEUaUW7BgCEgxZceeKztY?=
 =?us-ascii?Q?RlG6aZAhMuWBvZ0v+GNlgdxCRwIhAEmCyA/rIE+L+uxA6KPsC8MQWJwTGsED?=
 =?us-ascii?Q?uDmvsLTMWcMjhtuZvtooaROAgI225MbSjvc+Jy16zcAbIWKEkXEdkTtw33RJ?=
 =?us-ascii?Q?sQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dg66u0whtlQ7fYHqDlChxk5g7gKutXtPB9+XAcEPT3uWsGNj5owWsy9HvVCt?=
 =?us-ascii?Q?nPwKjOYE8+xWjdO9ktxoXfxglvtYCjYobrQAechYqzOaUt9Dr3tAOhcIm365?=
 =?us-ascii?Q?lkh0b1lProZ0TDtpAHOtu5sJ57tWbsOo0z6asFly6aQeuV/mBImcVWQ/q6/P?=
 =?us-ascii?Q?EzcEKgMgLkr9AA7wYkfJvP83msUl2RNzOz0xZhkRzxTlEHRt3HdnbAbDE2vf?=
 =?us-ascii?Q?hJEuT9DprUi92uEKUti36KW5bZYvItEyvVVhCnBmN50wHBWlZp6GPcFI/iaX?=
 =?us-ascii?Q?MmZuj7eEmM/KAi+uplkOPzuNINF57q16iHQq7Jy90T1UWO0wBqDFNShiux+J?=
 =?us-ascii?Q?zmypWM2rBwS+T0zHyIxN8KrrLPR4W2WTBNAdunqxjuoaDoxa2p2rl1BEtHD2?=
 =?us-ascii?Q?ISZMIz1YqcZGOuVtH7Jj5dwMkx40OoeRch+vHuNiJE2tTGx/SMCAHpfnmbXV?=
 =?us-ascii?Q?6AoPcaEvNAU55VC31KhAswxzGDFy5/GtUGFcViJ/KLBHGpavnVhOh97AJO7k?=
 =?us-ascii?Q?HnWHD5vewnWZqMtj7qxYPyqydOl+naX/82Saad0byqsXAJlXr7K2xGEtzmIi?=
 =?us-ascii?Q?uudD1rrPrYAY05bFsvrb6ynkldTitW/h0Evi/bSNYFGeMzx8Wlq2n3xGvNk6?=
 =?us-ascii?Q?qxBkk49d3MkYPKyU6mpo3F3yaLnO/QgMocQDckDv9fKmdUrm98RabEZZueU8?=
 =?us-ascii?Q?5C2LMRWPaT6bowRxA66b+Sn8toqdVzmHsrNiP8NegSIEG1UoM65AzE5otZQN?=
 =?us-ascii?Q?R3GexgRHQgTr5yh5vvYDxB00PumDoCKJtW0ZLYLH+A+iSDv+oZpPCDUagb/E?=
 =?us-ascii?Q?GFDVF0neo9RQNsW9YRGWJsvZHnCST/SpiOBtSXCIkQYlxOxga8BftV6DSEBk?=
 =?us-ascii?Q?fLxMYz4AxB6Ep5sXCybo7B3rKdNbmSOmoivyYTeQuSQjqAQi2957+xV9kRg8?=
 =?us-ascii?Q?cTYwfNLsnOWDVdGegGadOg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a18abb-fa05-4c41-5b6a-08dba287a098
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:46:00.3004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qA0I7O1c+aBJWXR5OsLzEtOPJq4jYmNqRQ8/eEidM7XscqgbwJIfquMnVP2AZV19i3e99nx1Tto7pcgXz8izDTgAYzKDvifFmMMPy7wcCo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4234
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=856 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210193
X-Proofpoint-ORIG-GUID: iF6NsizrAPlpP3-FTaFDLYqHKGxQQRMO
X-Proofpoint-GUID: iF6NsizrAPlpP3-FTaFDLYqHKGxQQRMO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Brian,

> The following two log messages are shown on bootup due to an
> -EPROBE_DEFER when booting on a Qualcomm sa8775p development board:
>
>     ufshcd-qcom 1d84000.ufs: ufshcd_variant_hba_init: variant qcom init
>         failed err -517
>     ufshcd-qcom 1d84000.ufs: Initialization failed
>
> This patch series converts the relevant two probe functions over to use
> dev_err_probe() so that these messages are not shown on bootup.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
