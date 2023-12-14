Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234DC81261E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 04:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjLNDwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 22:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNDwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 22:52:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB7D5;
        Wed, 13 Dec 2023 19:52:29 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0S36b016940;
        Thu, 14 Dec 2023 03:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=U5wyHRtkS8sC0wqSnJKjoG0pM4qIX9397g21nU6Pv88=;
 b=dw8XzgK3nHcRapcO/ZZ/zsvnQoEZcMRhLbNKLFksEDnkk9guWwPbftmR26JoRmmr/znN
 QawifZxry1I2pMM9hCZx+hQdcRXrVm7TxYQ/qlZ50jRlUjMjCODYkou6KmkUZ4jat0a1
 lwUouK2mtP2gnz5aQv36zl1m+zjySju6HcnM8v1vZWFCAwggqFFuwtKIssVAQ0X54wD1
 RSlYFgsu/6uMpQ8cLUQcAjisyDlHe3W7U8HgtMvUj2NT0I/zKyZkdbEAmPO2E8Bqa+M8
 XMXwPrpSTnEzgAzMg1MVmuO/uyXCqPyIAxgu9npWdypK0jWuLU2sigie5JXJWsR93Kc1 Uw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsuhtc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 03:52:09 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE3nHj5012900;
        Thu, 14 Dec 2023 03:52:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9f6a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 03:52:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMyGf9DT7hA4qpih1f3NuXS+cf8xjrs5t90LDLk/o37p68ht5tch2YMwkg7hsOfSM+oIF8E2+fZjMq+3/iau9as20Q57ocEXecd7k9eXOkyriRCYLvVlSKsp8zoBFETa4b8XxlvFPZOm5BxTYHjsze1DymxxBV6qhzTKWbqoHyRt2xhREn/RdCTVn4D3csguMKBejhFQheNDB2NgtMLuc67B8XG1Y07YEKCLfPUPTdh2EV0moH3k4swZJCwY6vQ4ama6uHadBtAWyGG6vRWJ9Ez/DNOgVcE5vHmncC0v17pgEUl+jeIbGs/+umKY7VQkpmQqkdpOhDZ3sACxesjxHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U5wyHRtkS8sC0wqSnJKjoG0pM4qIX9397g21nU6Pv88=;
 b=aT9n+UNSFqRl8NnQczhvW4+boktlIg2kL2tpDMyT6WBqmKfKWnOJa3c12GFtg7oH3jr40IlkbrccTMhGp0n8ztrQ/GjnrpMT4AEW7teFMBurR9jEs0gb9PotJ6mrbed2LTCI5Gtqz9y5ETAZ9jRgIND5qxjKjzoW6K3oTH/rL+IgjYqY5q2iOYlhnxrtaPlr9DNC1olbetC+YiuGG6Ka1oGz0KTh/J9KQ72RdiHni74fXwV2NnNybmT2yviV+MZM3H51r4+XkLuysgYRNtdFDqSjqzbwgIwsuJzC/+8TiSNxomQLajcma+pZyste09CHsHfFAkJdRcmg6PnQQMV1Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U5wyHRtkS8sC0wqSnJKjoG0pM4qIX9397g21nU6Pv88=;
 b=vAGadKAabbZYfY7XTzPIELVYbcOnEmtMiDjUFYjVGC/W5j0ilOfu1KwHAZ5/eRPNt9bVTs8rRcJp911+Xjgqk2Yb/FHwaYK5zrN0/bcodCwFynnzqEy5aJaI+2MhYH0Eo6jC7wJyp1RYHiT549TEk3/wpzeS3tQ/8/isRh53Jx4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6460.namprd10.prod.outlook.com (2603:10b6:510:1ef::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Thu, 14 Dec
 2023 03:52:06 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 03:52:06 +0000
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nitin Rawat <quic_nitirawa@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>
Subject: Re: [PATCH v6 1/3] scsi: ufs: qcom: dt-bindings: Add SC7280
 compatible string
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1a5qdh25e.fsf@ca-mkp.ca.oracle.com>
References: <20231205-sc7280-ufs-v6-0-ad6ca7796de7@fairphone.com>
        <20231205-sc7280-ufs-v6-1-ad6ca7796de7@fairphone.com>
Date:   Wed, 13 Dec 2023 22:52:04 -0500
In-Reply-To: <20231205-sc7280-ufs-v6-1-ad6ca7796de7@fairphone.com> (Luca
        Weiss's message of "Tue, 05 Dec 2023 15:38:54 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6460:EE_
X-MS-Office365-Filtering-Correlation-Id: 169d6a94-b5cf-45ca-0204-08dbfc580a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txWYz3vtgF21+Exom9e5oPmnblgcRuvWlyOU0fc23gzg2ld9j003m01G7XV1uYLb0CJowTKrY/hiWM84vjWZnjczwwaE/JoGFu67PC5kv1hp91qf0y2PzuD5oBq5qStg8dJLXQIxj9ibuZHtrvRz6lz0z98LhI1IsGdIfe5B/jzRWnf7nZAubptGxmvXWukJsuIEXd8wJCKvYCDkTWtxrEqtZqosEl2NERp/roLhqwP6JRzQ4yvAMKM3SlAHaOJsB8hDyXNiAdmwmbQsrQejE0YNHRSq1vneD+cicoZgOIgoWTDU6Lfbkn0P8VxaZueRQ7Nyk62nw3c4ELtls1suElqokIklr19ZuFWbIVVHqiicntX1dudFN/1Bpkx4Ckf40EVjFYAxsKA5L20W9FsJJkFgEVy4ZCIWuAddD4QGPyWjW3HLJwXvANUkhPdGtCsAI8mAVj0Zv+s/n+uPkNKcKdWfRM9lK6glVVw2DBDKpBni9jtPoIRxvuSDS4QamshFJ8D5NtnFkHLKPefCZhVZxYJ5Am2/12Uzl/5bHRqZNkQ+USBwMKfbKr6tvb42620Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(346002)(366004)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(36916002)(6506007)(6512007)(4326008)(5660300002)(7416002)(8936002)(8676002)(41300700001)(2906002)(6486002)(478600001)(316002)(6916009)(66556008)(66946007)(66476007)(54906003)(558084003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MenglfALd0OyX/8nbiq5iSpexJ8sAzPoCEZLqCOucJF4dTT7fiU2HEhjNzzR?=
 =?us-ascii?Q?Fg9X17mt1xLpFNVQQCCvT0fhG3fbqULD3aZoN818LxCWkZKdRwnYaVEHCnaR?=
 =?us-ascii?Q?f7H3h9muHW+CR9hg7uBbTBR1TyU5SVsOIoa0e/s0SELP5C7ofQcdrzPJtJ0D?=
 =?us-ascii?Q?sjSnfLoO6WRCRgSasnJ/PMmsoz8aAKZrGXcc89kJTWj+88sRnE5XkGOE9Oof?=
 =?us-ascii?Q?+YDlUyX2EFSByDSiZLIQluPBuPR7uokuBAsRzfIeumAsm9tkDAqYCfR9zwO6?=
 =?us-ascii?Q?7J+5bd6k9Dgruqf0u9IlKLj2iO59hENxbO4jssqI/t4WR1XjI5ZNup8hNOVg?=
 =?us-ascii?Q?yUEvp98jVjjF62XpTeHWBIyAhGGy7PYTo9VNLiawCjw9hTPpu4YX9GzDBN0s?=
 =?us-ascii?Q?IN7YdXfRYnER1hxWMCLUJM3VIBGEyNZzgnjpDmZEJW4QhMAmGqOR21ZnZwYo?=
 =?us-ascii?Q?cy2YHFOAM+tGjf61drbNGwVDW64bWFmUk59dvV0uOz9jNKZCOiOA0gdMK1oV?=
 =?us-ascii?Q?rIYNIdLpWbJiKWfcysgx5H2nGzW43p0rUlINH/Qnu/JzyVR2Vttu7o6rPFO3?=
 =?us-ascii?Q?2wpN1uXVt/IUaYWIcJqkWBNpxVlBXUgEEACqfxbU+CnWM9AoCBTXQZVsFyjs?=
 =?us-ascii?Q?3Ps/64nqymYeD0Bp9twT3GyqrD0+lyIlQTYPFi64Sv6gTKmzgtCBGV9UMZgV?=
 =?us-ascii?Q?t9fgCvKz6p+pgpnvzK5o8MFJf34Hahx6jSx9ex3Sef8RmfH90z27jJfepqxt?=
 =?us-ascii?Q?Yq4rZTYXrQKxtXWPmAdjeH7R7bEKb+oAZWf3PZUe8sLuq7XQGWYh4bHFvMOr?=
 =?us-ascii?Q?xDfHxXF34Ur5jDu8BsbmgJwUiYWAHB+J2TXDv1Akfywp5AKAq/Row7cnc7sd?=
 =?us-ascii?Q?MC9u11eUFRckDxlGQxRgzvvADkHRMjz5HrNd9SEbYGQJ7DQycnVs62x4i7CL?=
 =?us-ascii?Q?RQE/XzBZBuj9QCUvoj2stg+HooEkJjzUsNgDshlnyV/BVsvJWuiva6RvMI71?=
 =?us-ascii?Q?wjPzjXZWrap+cABNtEhY1xqV2DKRjLR+VM4Py8a8FTvWt8DFX+V90WiVFbDV?=
 =?us-ascii?Q?S6ww+DRD8WN5Vd/AK8vf8UeD/tA9ANm7ia4ZxjneynNchxO2RzKxt4fgBwBC?=
 =?us-ascii?Q?j2Gm8//zaZeXFz/Q32fuzJSz6i0L7+czGZ+NmvbFYxcMu7neDiHLYrZu8KoJ?=
 =?us-ascii?Q?Yc6z88QkO3e1McKaKt49fRr9yFXMoxu4V3v3M9r1rlnU4wcuxJUbZIikl3iQ?=
 =?us-ascii?Q?ifET4PMCHIu0l+y7+nVY6iMZtohgUxyrRYwwv2SgeNOPfTqZonaA8vefQaJj?=
 =?us-ascii?Q?MP90wfSRG7k48/TGzs2sFv6+5LUrqx0nLKdypUTBPntYyfS/aYgrIVVy2UAJ?=
 =?us-ascii?Q?lCLPAIhly3fRYwvgSeOHRiWOzJbwJaY2iWunKmX/NMmJSBDNRY7jgXqDSdEP?=
 =?us-ascii?Q?9DF4tjMFjY6oQaEquuDM/AVAU/YjJjiiGBuXj4KnxxatXPAO1sieLZNVjqoj?=
 =?us-ascii?Q?nMzj/KOhv4iQbfm2wMZt5LSpJuTcR8qRcxCSG9bILJjxmL2KEwaZPp9k3eDI?=
 =?us-ascii?Q?ODckT6gfPCtt5gUQnz4wO8RG1eKBrBi/CSo2FvGMX1PSUpBlRFE99NyLFzeV?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ts5MqHhv8AE+80UKKzmuz6lwTIkLhXMicrGYAnlTF1pOljfzqHW2hAZVG4njhcTgsIkibGYIyV03OlIITNn6wmdE2GXMz0AJ5HxYMYXA8N4vP+QeujVT+Qc6dLqSaRByxZ3AL31P9/jJ/GFs9hTKpcHB2k4M0OHjwMQzDSZ2q3nTqb4D/Dp+lChfObzkfNjTpEdqAE3EC0fbnTCkeDUFcN6hnFWRsgMrR+GB6pH0uLRTDse2YVcEnntRfpN8ZPoa+yn5Wk7xWqveOoadRaKoH5q0eHaxVzrsU4c4RBdNIaSC9x6LBwHyOBISkIdGxd48C1K0tT/E3UUM0ZKnX168T306WlYhx67g9KBGft2p9f1m586PNowsUNRXvQkf0LpEtgsWxbKXGj2k0BhfahoQWBZYPzfj9UzNyLMvayb7WS9eAPOAJDSKcB/U9F+oUF36xnxghUSP0NhOfmRcJH9u5dFv6DjUq93kue4/G38a4DDyqzQgDEQpQY8n2+CrjUqTh05uy3oxJZUmVcvnnDBu1g6NSe/hLddT1UGUoU5+f5ZorFSWutReSmhhKNGMI/GxEPbuXkoQ/YyeGZOHr8hyvDIepis0ciFicYAwc/f01V0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169d6a94-b5cf-45ca-0204-08dbfc580a56
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 03:52:06.5019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZlJU3cxloqv7ua3InQskdEdl5pNa7PbfdS2YRd/Vu0DDKgXHcchwkQ0SfGjZ4SvZNcTxF+NCJ4UiECiZOOWPYq+Z24vVjLOu18HWKQGnlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6460
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_16,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=960 bulkscore=0 spamscore=0
 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140021
X-Proofpoint-ORIG-GUID: t31EZs3sr_3xa2C4_i_DQ9dv1kjtXP_X
X-Proofpoint-GUID: t31EZs3sr_3xa2C4_i_DQ9dv1kjtXP_X
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Luca,

> Document the compatible string for the UFS found on SC7280.

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
