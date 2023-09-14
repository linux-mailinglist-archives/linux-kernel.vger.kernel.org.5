Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFA079F643
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjINBVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233549AbjINBVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:21:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EA91BD0;
        Wed, 13 Sep 2023 18:21:27 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38DL44F0030430;
        Thu, 14 Sep 2023 01:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=59Ot1RCBvZP3JQSqSDtWYCRsWda/v6Ffj6MQak5ATIw=;
 b=S5ku4aPi6iukB3q2bJDqsxXGCQzwsXYSbB56qT+9iJs3gPfE7UmFXVmEEPEXj+nWgwxu
 RaObtswlhq5kgKQYb7fYSN1cGHq7TapbLBREF67Vrszh+4FZh+P1YD26XCp9227FLKRr
 6z9tBQVlfj0EmwALc2WIrK1lSQ3bJeY4cibxlg3s97YjF4D5O/fcuWzLepLivqfPaQ9z
 0z3BItLiuzAf1EEnhEKjhjMJRnrim0Fn1XsBgU86x9Ik65tDSEanYLe2oY6pDOesJLt7
 PK3gzZxOjvsSXuCGUT0/AibMeax1YyWWuQEhB5OoF5STw2HIBNLHEbq/Rjm3vVLLeaXR /Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7rbqep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:21:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38DNPwZn032969;
        Thu, 14 Sep 2023 01:21:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0wkhaad8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 01:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij7kvV4mwe3viwwrjeqHitiDZ4+pVPyp3GlClhSh2Dy4Wt5wEcCODmFe6u6azLL3PGhdNo8IDI/oVFbNPcvfX5Ar33YdbQUn1UKAnBSWaSz/2FJjorMNpvpidGoR/tx4A0wKcv7un82EuuZdGHWMpEiD3I7zbH2kouXfPjtos8qSleWdMa/Jgnat3pRK4cXC9q37ko93afKBxOSP9ElxMgVaQ6OuophIOY8K8gqNDsY5BYEc1UeDKcqCaQqkZdvyrbkEa4d7UwK1JO7Ba7x3P+FT8wkFUfgsp0JMJXyBV+7ozpNq3Lx3yYeQ7P5C95ugMOLpoNfNMG+fLXB/ioarKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59Ot1RCBvZP3JQSqSDtWYCRsWda/v6Ffj6MQak5ATIw=;
 b=ayO0/hWUhtUCS0wTRgKVH/zbIkjpGCQx3TUGaciN++miXbR6eNRgY9wkKnSwrWX+ovWvzg5AlohAA62bTlXTNbS+qG7erDsyIG0wSDu1MRillyZuEc9g2g/oDIs/LDprLMpbPSlgNpUxZ3VkDh6iD7U9AYz4NceB5ZCvgTewCELzcOL+C/Q1ijUaD1UlMJwEPSzeHTb3pqaevkktQ6nI+LL7dAug4u2kpSM4dz90pv7DZEXJRg0rageFYq+bXA5BxNEjXPUwSvYOcwp+FlL1bg81yVXUloiirPjO6MEe/X6nRQ/6dMgzM/7ULZzxavE0IjzMIOkvAUNFq9N4bIFPTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59Ot1RCBvZP3JQSqSDtWYCRsWda/v6Ffj6MQak5ATIw=;
 b=SVzufwTcP5M2tFmOyHHSwHS7TxFpxlX1tlJ8reLcvPwVK/seMrHkIynpLb8hDjEL2p/bqcZ0C3hs7sxdMnSeTOByEr87GmAVUGJ5E29C7Zg4Qgo3oh6HRmGJe894ulN9QBu8/tt+OAZt2vaBI2WxclOlE++Q73586e5957FdYGA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4589.namprd10.prod.outlook.com (2603:10b6:a03:2d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.36; Thu, 14 Sep
 2023 01:21:12 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6792.019; Thu, 14 Sep 2023
 01:21:11 +0000
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, bvanassche@acm.org,
        avri.altman@wdc.com, alim.akhtar@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nitirawa@quicinc.com,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: ufs: ufs-qcom: Update PHY settings only when
 scaling to higher gears
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs3heeiu.fsf@ca-mkp.ca.oracle.com>
References: <20230908145329.154024-1-manivannan.sadhasivam@linaro.org>
Date:   Wed, 13 Sep 2023 21:21:09 -0400
In-Reply-To: <20230908145329.154024-1-manivannan.sadhasivam@linaro.org>
        (Manivannan Sadhasivam's message of "Fri, 8 Sep 2023 20:23:28 +0530")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR06CA0076.namprd06.prod.outlook.com
 (2603:10b6:5:336::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4589:EE_
X-MS-Office365-Filtering-Correlation-Id: cc7abc67-45fc-489d-4d72-08dbb4c0e1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhilduL5SbE6afCYTrjqFifGaUQ0RMZrbdQhDEgUU+ijufXqrQocgWK+a3ObAeD60Vqk3c88sC1Oy51KqpxgK6HG9NJoNmClvHt5DkGDbOFSfc/Oz/DUQrzgpzY3HrvxXe7zEpUhmVt2mroxA6gqrBd/61BQTELYJ22C7kq42BVg+551BHg2yyxZRHWw6Vriyw6ilYoM99BVoPUw8vpfQGSWnm5pzOVPKskfBaQITFi43i8MMe07X5lLd1wf7MJx1Vb889W3kpjF05A3ER2iYr+/KrHrldL3SrHr2WQjdlHb8tna4cFZ0X+oSzVDjyUFtj7yQRzXbCBYqrcmHap0hYwupodNwEnDo2aw/GxNctHVjafGjl3HkIJBpYdjwbYWFugPER67cwjvXqvWOzpwEgl2uu8zp1V66drKoXsRTSO1hIu86jrTb35pqY0TCWMy1Ie/Ags/OWfDHAm2KXgWBL9DlA+trd2s9C0akDcRh8tt7rQQjNWJq+aarxIUPR/6BOJZ2wNvF9hRgDtDK0kGjRduMc4uiAvWzd+2LvT+nI0KelzKcI8LyxoeVuOep0Uo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199024)(1800799009)(186009)(4744005)(26005)(316002)(8936002)(8676002)(4326008)(15650500001)(83380400001)(5660300002)(7416002)(41300700001)(66476007)(6506007)(6486002)(86362001)(36916002)(66556008)(66946007)(6916009)(2906002)(6512007)(478600001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ACIZ2pt37DNEy1LalzBedika+h4O2O1Fpm3iiHX51qDv9hFeFnNens0xNn/?=
 =?us-ascii?Q?QZeAfel7bL39mhqn8gQpQN5+0ShiG/sgoqPcqoqeUfHdRxxKvH7YhrUKziO6?=
 =?us-ascii?Q?SC01qkCBSXnc1KKXdD1FM2RbaiOc9FeA4ho95dQac68v1nEJkKzlPIHv0wBy?=
 =?us-ascii?Q?aUqTMctXdc9MEsoqT9T9UnDmNpObyITQJxpTnAGxTF7+ZYKd9+yvDuA2s2sr?=
 =?us-ascii?Q?aiyOtQAMsbazWALIvz5TFe2EcqI4fiqgvT6fPqkOZJld0yuaX6c53iOOEw0I?=
 =?us-ascii?Q?0nTU15HiBbT7YOjc0BqyUXVuRFiKXylFu3XbCIgT0PmrtHraGH2MnmnpCI0n?=
 =?us-ascii?Q?FICUKe8UdB9pSEv/UD3AwQME40iuA/D6m8/yThXl9SA68wo4lM8E1OGvk5pi?=
 =?us-ascii?Q?SWRR6fo98pl0f1Pl3ghlEr7hzX3uXjgYH9eZRMBGGAh/hSP/I3tfv3V5jf4u?=
 =?us-ascii?Q?9B9v3imha+qiHs/RrzfFxXDvdhUBw9H8MwYvdBvn5H/0Xjms8NAiG0Djjawj?=
 =?us-ascii?Q?OkNLSZXjZ4MbhQ8zY8eZXyaQm5p5fpqrOIvZCp/y0PFmu+Z9QUvA3JHnERZw?=
 =?us-ascii?Q?m4PXwKDZBNnPn7fxfuquOx/IIy8r3Z0CskX4r7trATPbcvEcpQDQ+f5KoGz0?=
 =?us-ascii?Q?9oEirGt3UVANypCgaP8HIMcX3WhijiVeGkhFl2GKpQxKkCa8qVti7ZGeb83Y?=
 =?us-ascii?Q?+DxUsif0vKQH17z+4xik1MnNbpYEBLrylesQPtC0/4yLh3kXf7XleMrZ2AUF?=
 =?us-ascii?Q?BuCBMNJsMTc/j4G0dAlTCRjji+6ZOe52ml+oysd/vIqgdlwYN1i1IRxnAJZY?=
 =?us-ascii?Q?5QqXEaqd6OLQzfIqItJkfampS9BfuZjMnNDDWHRN/ge0Yu+OZqG31Vc0ijPv?=
 =?us-ascii?Q?s1wyUhVqxu9Lv5akthV31LS0J+fkB1Mjr+J1Y/1Nf4c4rt6ptDKN9II7iSbH?=
 =?us-ascii?Q?jV5x+P/GErMSsBmjNWHSCTggsqwkUm1HM9edcWMPD3UBrymwvuBSUc0px4gF?=
 =?us-ascii?Q?2P8i46qJ/VFxH1SwkGXSYbfrStBr1+UU9PZRuqJu+aR+AcFPHHYzPrA90Io3?=
 =?us-ascii?Q?/Spy5mrxpGvYXLt1sdzp3iOO+X0vumKJ2qc+eNqBfCdqljQor1Kd339+1JWD?=
 =?us-ascii?Q?O1N/32wm0pCprwmIKdZuMBmptM2mcezdAeuKeudb4v+sQjSYRcUcfE5KMrLI?=
 =?us-ascii?Q?2IgrJEqEzcazR4l8FGunUtxd9skZVJzn3YZzEGQj36BO6ptu78xiOPalG+rP?=
 =?us-ascii?Q?m3TVNDQzSMymxCG32r0vBgHmia/ihdenRuNquIynYDUld+EeFCBoz4Sy/LWH?=
 =?us-ascii?Q?7URmWeCBF2c7+IV2q35tMT/OZI5fs80hAjGq/zWHGDQTvbewkk/nCWnpxf/E?=
 =?us-ascii?Q?y+dvGncryPU6E1XOroWKOLcAs2YW84SwoCFELBNmt3LUbNfO8S6lXka3rtZd?=
 =?us-ascii?Q?GcJyWskFyki9H6ustFmVYLa8fqpKcpriAOStd1++ZZndE/kOT4Cf8OcsFTJ4?=
 =?us-ascii?Q?5SWpG9T7/uXR7sLVVcYZrG+94Y/lkVDL/Q+5WuU3QR4lHs2qjrqNmbgaRynd?=
 =?us-ascii?Q?NRxud7TZjdiMClQnd3TDsNb2RsjRvezI6bEezy3LTQvTz3vyT8Ux5ssI2rlj?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7ymBRzIB3L9Qvn5LwrddfUXUR1Ef3rlzEdciWgY0osmMC5qYjBZMQQl1ZdIP?=
 =?us-ascii?Q?QDOYxqBiF0/WN/4TGoIpmkC8zLh4MasbiiaGkZkbLoA77prruI2/CsKmLW7l?=
 =?us-ascii?Q?9x9JA0rzBztlOe+Kzw41N2BOtZm/i7Q836ISn4kQNnlJvzXAdHiQXjD/tZAC?=
 =?us-ascii?Q?TR9yd7PgC3vz3In3Ux0fg0mSORC8yNk5H94xPU2nAwS2w7avm5LXZJqj7K6i?=
 =?us-ascii?Q?am0Ysae6MRIV6zYO0ZDu1EsOlrJK8SBiRCgs+fgtC7U5Nnzt03uAdZb6KfHs?=
 =?us-ascii?Q?XKtFIp4r1wPmylxgw09Xc1XyFA2OW7t20OXBhdB+H2YQ1/8QUtF8CCeCbJIo?=
 =?us-ascii?Q?mDxA67pXDOgYJNQieiAAA0XQbdzSttDI9HjYrfeOgZWmw5svaAMMz0AFwq50?=
 =?us-ascii?Q?Fgg2g+Yy8YDePQ3loxgXCeFH4J6zaXa4vcFuQX2iDrRE7nydnReKmc+drNcQ?=
 =?us-ascii?Q?3Vu70t1ZJ3XclHSKf2sPh41WHyKVFc/Rbf8DYZOVPFilOV3iMlc5pNUvG1kc?=
 =?us-ascii?Q?rhELXrzq62S8VAGdcD8hRLQxPK5q5qFjQtOLmBYPIznPjJQnNBbfzS7KEGQI?=
 =?us-ascii?Q?b58ti0fUKGdcyuhSRdmqKyz1Yu/tw9fwCvwZrXtFYjMTzU3fxOROqOn26O8x?=
 =?us-ascii?Q?hj0cBnGMhJT87WbgRxPvnUOdg7Uiov+7ci93CKnOH2hymjb/iH7tiLnbXnlY?=
 =?us-ascii?Q?RlQrLMjwqbjDWPR7KSurEmBSzUSXzxCHITSFXxKPk/4UjYYUnvElvhY1buww?=
 =?us-ascii?Q?Xn9MXrXjr76eqhqbY+5jV2PX+hSu38o6Q5NreWwYTlsGSMhnNcjL86RmJ0/R?=
 =?us-ascii?Q?DxOhQoEEr8qs7b4PrKaAQuUAd1vcpayuX7rJyhOLRpQmYWbOUtSlNT6GEAXF?=
 =?us-ascii?Q?VbU7tE5w8sqUkWK8/lwNENtpTQBbmICOJWklBooD7ZGRHC7gPb6Xtl6MNSpG?=
 =?us-ascii?Q?bIW1JwKu+THT9/ZcnXyzJw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7abc67-45fc-489d-4d72-08dbb4c0e1d1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 01:21:11.9434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Rzx+9zpXhlw2/oyzDsxcxVH4RRIFx6LbGborMYzh76lhQzDEgUrBvi+Eyd7J+Q0L9eQ8qediuadNDDj7bFU/7BExvhlPoCxp5E/dsceIpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-13_19,2023-09-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=878 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140010
X-Proofpoint-ORIG-GUID: 0hRu-h21bYYf5ZPvPfXGGch4oksE8Ul0
X-Proofpoint-GUID: 0hRu-h21bYYf5ZPvPfXGGch4oksE8Ul0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manivannan,

> The "hs_gear" variable is used to program the PHY settings (submode)
> during ufs_qcom_power_up_sequence(). Currently, it is being updated
> every time the agreed gear changes. Due to this, if the gear got
> downscaled before suspend (runtime/system), then while resuming, the
> PHY settings for the lower gear will be applied first and later when
> scaling to max gear with REINIT, the PHY settings for the max gear
> will be applied.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
