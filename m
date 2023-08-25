Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357877890A5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbjHYVos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjHYVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:44:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3C12127;
        Fri, 25 Aug 2023 14:44:16 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PIEWoQ031486;
        Fri, 25 Aug 2023 21:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=xr1Gahl0eGfhb35fkT4+JLU/jGf5KqY5xjfZLFF8Q4g=;
 b=RUO/cKYZ+/UkPnSSnszFUANNbwjp7rI4JKBr9QVtYd/7mFGjdQOn14Y1mG/fiIv5w7O2
 Ika+2cS4A27Cz6vEBcdulbCH8COt/y8twRAepdXeeP5RGSjPMDaNxOe+cW6eOAtJGhCS
 GFGE6AmM0pkkEipWDaexzF9VR5LX8DnccznF3YCa3SQ0MxAInhBuvHcDjYrw42nNDk1H
 8viCGR7avOpM9pqFZ6Poj4FFkyC0CeifhuZ0gT47qnHWs6nxBMMPQcUHweSHRP3QLFM3
 BPee44vg+pZZm4TnVo3AU255edpOIDuq41zZ/JknlJiJKSskInC2HreJw0Ni2PwyWfNa ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20cq8cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 21:44:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37PLTkv9035838;
        Fri, 25 Aug 2023 21:44:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yrc7ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 21:44:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kPK939RoUCihUhAiqhX7EFe2kONblHtUgP/9nzT1bXMgGNp81L+oRAFighqu/c8LLUdZ3kFD5I6VNPWJjRmIQ1ETCp0FUc4glARC+wwQig7pR/uUi83yo7SbMeZEcMfThG36hzA85chjA/clxx8quvFpxqOgAzfyWlwUuW+4HXOgIAM43Qs3XU2RVSRrkprVZgj8Rdx/d5c78T82t7BV/UbRL6mLthDabE7em8/2CXIkbRqUbfLbkfWm8K8icGHS7VkUaItYB4BRZEEne+nL4UnKyBo2qazIKNonmhsFhqo18LAMRmfR9WJM+yzL3ERbzAC/P2Q1VL5OayNjh22nWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr1Gahl0eGfhb35fkT4+JLU/jGf5KqY5xjfZLFF8Q4g=;
 b=dB8jH90BG+Mk1UsxYciHVnW9sYgUvvH+RQsVcyHXlLyOv4BhVm0v6fbiR4ZC04xsgzBJHpvkF6J9RzhD9QKewF9kV3ES7x/hxHWZP5IJT2K/vcZ5sN77DjuT5NOcRMx8Ovp+cRkwZp46r6d5DyX0oTsbR76V2AmHVYC3zmJdGpCvK6q/H7oQZmeSwXy4uZydNHuVHIXBtWklFJFB9LaOtKBb5hSgciILqxPgxV6Wy8rUEc1JZqjvfduwjTNizy8tbr96FMaBHzN3/skaoVYhT00S03erMGhM48GrktKIUv9//wOKQnOEWAjoH1uM3FdmlPJIqeox/Xr2U0MnukslgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr1Gahl0eGfhb35fkT4+JLU/jGf5KqY5xjfZLFF8Q4g=;
 b=MTBN+g9bWL80Mys70uU4m/ulu5JGGEzoDvvXBbVIIexbJ8zjvmskvgY/mU/Gw7/g7jXOMm0/QnUBoVNnUNVYNqG3uqN72wk1fZkL1jU9nlCzoV45qRr0aQi/EzQaC+GgGZ3MXOdTPOSwNOjNJfGUBqXLLTHgTTG25Y0QgsVUJgg=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MN6PR10MB7466.namprd10.prod.outlook.com (2603:10b6:208:477::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 21:44:04 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.034; Fri, 25 Aug 2023
 21:44:04 +0000
To:     Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     mani@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, quic_cang@quicinc.com,
        quic_nguyenb@quicinc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V5 0/6] scsi: ufs: qcom: Align programming sequence as
 per HW spec
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6omztl3.fsf@ca-mkp.ca.oracle.com>
References: <20230823154413.23788-1-quic_nitirawa@quicinc.com>
Date:   Fri, 25 Aug 2023 17:44:01 -0400
In-Reply-To: <20230823154413.23788-1-quic_nitirawa@quicinc.com> (Nitin Rawat's
        message of "Wed, 23 Aug 2023 21:14:07 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:332::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MN6PR10MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b5d3123-c905-40f8-c520-08dba5b466bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TnTVBVzKm0So/2MzS5zlRPFeB2HoCYwcYk5jDak44o19ahia5TjOoGd7anpwcz4zFDoSS6vRna59z0DoPHnI+qdL0ZWZPO1Rxhgtc/rnOj+QSQcZxVwejU0uNQZq6rc4+p3cATmloYcqpWBb2OirAUG0epbeEQMVCzDz6gzKRMX5ZuaTQJQxBQqpbHe9CygboZiM3bhTp/jFdhLv5y5zopTyQBdU6UHRNLEpvm6fnTaNNdYIja+q29OAYGp+EIK3FUuXd9joQ4D6LxL7Gu5GqOqFNldIBhLu6pegLhbAmd0d06d7ttEPHDmOJ8NhHMa1pw68DKKY2bNiS1T3tUqw25J/TZH9m9WcZJlRXs/mvk7BFNV3NBk1EK6/DaveISw3febF7xJc7CdfrZ7hIVP3nHwrnuBpgRsEV/jDsp+ErLr71gYnYbhLl0ia2scBJ7QGSV3iYejB9XciMWQqisJcI+pAvmjC/dFDppMkTxiv2D3LYW+zURJ1PY04MTFVLdrZbJnAO61zR5O5lqzv5RYwUjubkYFeNtyt6uPMtq7W6fPqSb3IXxsAG1QJe7k1Fc1S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199024)(1800799009)(186009)(38100700002)(4326008)(8676002)(8936002)(6506007)(36916002)(41300700001)(66476007)(558084003)(6486002)(6666004)(316002)(66946007)(6916009)(86362001)(66556008)(6512007)(478600001)(26005)(7416002)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+eVoqRvvgT2ghz1lx8h+MbHw70mdPbzh1hgiSSwpqFVQQXE9Cp8B7f3cojWS?=
 =?us-ascii?Q?wmfeJtpkEAB7GcgcIrQfhBztgv9MykFYPemgHjdGG/G1m0ruax9zS8jGze8s?=
 =?us-ascii?Q?0kru/aRb2Nz9OJ+l0icKU5Twj4PusJl8vwgQHvy+iK3y4G9WrdkcYhI6YwfK?=
 =?us-ascii?Q?vCQOchHoRKVvjQM6JB4eeS6QdsEIVY/gec0q6OyUis+iBD9+DrN02vT1k/qL?=
 =?us-ascii?Q?klZoYqYb2rhBZGvBob0E27MBwYt/v5UOhI5bHAjE1MNW84orogmDqVmLArIr?=
 =?us-ascii?Q?uZHAUsWBgCrH9kMwx2RjaOlLKpr6coLhifJu7EpDRuNt6BpyhOrlko81qBId?=
 =?us-ascii?Q?N/knTOF9U5x5C2PBvGve2BXc4BNDFcgEr+HlK0JtpVopPhp65nFLwiOep5H7?=
 =?us-ascii?Q?xObymyqpDIm1+6Xtp8og0dW9zwgf5p1r/t0S2WeoCem32a1YTOyJLuNLyQ1z?=
 =?us-ascii?Q?YmT2dBEydnVNrFAgFdvr3fFJspwasVcN9VAevaEft1cs1TqbcfYbi8ELxqAw?=
 =?us-ascii?Q?Y4h4KGZlOD5N2zuHLezLHtDstPB5AX/a/q69pv7BQUhoY9YbLQEjxTvlzAPR?=
 =?us-ascii?Q?CPAC2VovFSPmYeNeldeih4qVn6B5dWU0QdGQ3Jzoa+prb7/omMHikYJ4cpid?=
 =?us-ascii?Q?5beYUUoMN5V/OFL7cdFVVK+pdA9AV3ogSUlxD9jyUygarzhy1M/8S+vpQrIc?=
 =?us-ascii?Q?25sp2ufOoUSF9FW1u1TJ4gm2CrPIuXB+X5/cPtyedJSh+bA1mMGlvrxUrPFW?=
 =?us-ascii?Q?SC2jQ5+XP9zx+3OYLudq2pnN1f/p5U1jnO8krEQTvsTEiiTB/2Z9MoRC/4Sn?=
 =?us-ascii?Q?YieoelB65YnGjLZjp7PXdYcsD/z+P6ycLGIZrckbKGSz5dtHq6L0MQee522g?=
 =?us-ascii?Q?6dEusrad15A1r15+B+0Vnx4YY3xezYzc7iCSLTdlbjaHz3LSBMie2TUmKllH?=
 =?us-ascii?Q?AN7SMt5eBzi8AtIDcATeUo1F7RUN52rX0+j/vt1XqIdT+Ww5tZFGk9Zk9lY0?=
 =?us-ascii?Q?DH6mvShhRO4vFkLAvMGVKalY0RLhFOiGTEWbpXDaxkAASKC6PkqvHsXtX6B/?=
 =?us-ascii?Q?CJy9CHLj4yqKbAXbbNoYUXC75HLjILlZegSuyseetMgjLVDA9hUDNJvV38IW?=
 =?us-ascii?Q?Xw30eVsMxKqvUmgOO2rH6y/pcrrU6fEaXFyRlIvegOIgmvmt0w/vWVAONvgS?=
 =?us-ascii?Q?0oUYtRLXRd70mLAhd25RTlR7UVJ4QcnZHfFP7gdHo1bY8Km6MQSnmHl872LM?=
 =?us-ascii?Q?kOixc3ZsH16vDpLuaX3/Z0rjvwLic3H62Wg4XZEZuGrclqv3dithiKzHMxsa?=
 =?us-ascii?Q?1fTALy3+z+3kSY7fCEDqi2f/VBtfbrHiZ9HM8cssAFPpdKiEUSoKsRelco7s?=
 =?us-ascii?Q?fw/fDawxNvCKZmi+OBRjVpH09YLrbpg4THapB/yCeDjAnf245y1RYBkgRLeT?=
 =?us-ascii?Q?/F94taX8GEWN5Z6DNfdsUQpbK4chh381F8paD4/MrlQUdyvaLHFI9Fc0bAuA?=
 =?us-ascii?Q?ygFLwdLBGp2rHt+px+kTRbCNmCMQb6h+Brq9LnmQ44PCS7L0cRp8leHD4K8e?=
 =?us-ascii?Q?OubmvzCBBKb9Sxs8/TCfn5J7vsZA/1s/lwxwlddFOYm60x0pAANgfoaaAcVa?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +M4G0TWN1gS/91bYx84hTsNTNfg+va31XCHTqY4Fu7uoGJmUCeX+28Bv9fsV70SlCLnQwDHn5iCbZ3+O4WFa8QNENEiBTTHSZ8n85OIF5+UlWSvNoJMU8kDmDxMNcqkEaszBtAA0DNE3jLJ5C8Ytyx8GUyCTPyNawxnxWIRtmfYLepxQTabq/RR5Hn1aU2NtPuePIvZwO94HidNPvTz4aTxIPVu7mX1HkfAZcZxUZxD57cnSo4YqDdLGOZknOsDXNJg9BWb2lTuUNsfD+ArdAuB71yhCC/usqsUU1IuzZNm4R0s7gx8ZTkgEDfDK9qnV9L7d1DCo8zbQI2fW1i8hHlbnfkgTlUbzSNzEUKRRRKtM850orU1b9tPxeFBbD7GOc1VmZUhMFGV+rNjXbEVd2Av/RezEOoWY8fuSFBFVR+G3p/qxlrzmtl8Vtct8P03FHWP7JFCB030YWRoHgFNK1WmNJu5PNo7sVw8wCrnbrXJC2ztcKyFcDYMyuGd+oFzpIYpQkSREuv2IsLSppHvDz26EQSesw4e5mYzFy0hFqS2IY+wgGyNHvIqEwMged436GJ8LoaPhmSDyjX2UiMAL90JUPRRbsrNXZ0aikNfrKuBfHH0EPiTaSGQzNs8/wm+pjr7Q+ibewt63SCTxgkqPKLZMWV0MYC72Sk2W1h1WhpC0D667sr5Vmgn/3Jr0I9EsOt+lzulzoh7J0wYr7NZLXLpgQTP+AHQR9Ketfc/Z5HVodGjXZ+oUrGH0p9Pun9Lj6EZHFB/lZhNCNeFCL6rldTVe/x044p/umu9KP7k/g+VCrUHfYwS1GGJ3NLqAztDJk9FyzHPTCZXLaF5SQhTlW9odxjahCGISGSaQ5mlhH0aTeqDZmZmO1EPu3U52pY5PSEl4at+HDEieoy9IJjIuIw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b5d3123-c905-40f8-c520-08dba5b466bc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 21:44:04.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ufc95U7jRGEAJPd5iJlgueIuufh2+XwF8xvXluOY+mV/D8JM/NawdJ6begaTkZnhuy7jkYwSa/d68evBGKB91AcaXmGJXPFqle9Ut9IWttc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7466
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_19,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=471 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250194
X-Proofpoint-ORIG-GUID: PkPKZCbSISpDJOEOplzv3pmsdPybDOb9
X-Proofpoint-GUID: PkPKZCbSISpDJOEOplzv3pmsdPybDOb9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nitin,

> This patch aligns programming sequence as per Qualcomm UFS hardware
> specification.

Which tree is this against? Doesn't apply to 6.6/scsi-queue...

-- 
Martin K. Petersen	Oracle Linux Engineering
