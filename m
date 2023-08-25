Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E331B787D7E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbjHYCEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234949AbjHYCE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:04:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B2E66;
        Thu, 24 Aug 2023 19:03:39 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37OJEQQM021979;
        Fri, 25 Aug 2023 02:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=F1grdFi/kUHRlAA4NGWyAukJdwU6YoryC9egXV1alds=;
 b=oxauOewwlsd4bFiu2wJ5Tf2ErvXg0Ugsx2BXs/bgkH9328MJHesMhxLXPJJ7QtlzcjUO
 0QxLBH+gEbcCcQ6EzOoGz/SYpM41usHrXLk/inl2we44IVHkTSsi3KxsYKHGr/rFqc2v
 FlTdxA7qSdn3Bvz2fTktpVnflzpxIr+Rg4JUlO57Pl1Krm2yavZzLCkKrnyDTOqM7gNu
 y+jZgLGIyu47kiC04kxj259cv1xUy8Gy1SMjOqDFK3xGRjIVNyl0aw8AO6j8iynBVv5e
 qzMChcrrRAig/xNzWSeimI6vVf3g5QYha5MyxG3pDxnJAmvhnqHjkxrAyM+odExSTgmr pQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yu5k7s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 02:03:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37P0M0eU033143;
        Fri, 25 Aug 2023 02:03:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yx9692-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 02:03:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlLenZfQ1dDoOYgD5nIJTddxteBrYJuuaNp6oH0WUEv73Hgz7HkkIPSaY5IqyY5k9+zow+GBa3biIh1tmWoHRKIijqOsfzaJB303PJu0dZvWiDjhgvXllaeuuIMoTebBRInDJgRjycAhB8zoXpI5SSqwccPjsf6oeI9Rl/kgKkGIV2vLHpx+xsi3SZbQ/XPZ5J5T9H0PSkMGjVmfv9O+s7uiRZH9UOFJ+siMNDRj8pHwToydraPyOhNq1/Fm0iXoAvtxUwrH7BTh3X2negwXu20PmBRXpKQlmYMtZW5ynAqyiUcWZ+J6I+eMsKTmvq/jCpHS4PtPuSQVkC0bOvcLrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1grdFi/kUHRlAA4NGWyAukJdwU6YoryC9egXV1alds=;
 b=U8zt9XCzOZDZejLAic0iiLBjLmjhXU0Vku0FdUuIy+JZLH/KRxDd8+nwAc7f6WkSKq9GpK15j93Fe+49sgZPPayA/TOITfqw53Ece49Dct8IQ7OqheHWIYeXlMmbS4lejQvsbFQJLOgZYO6uvN9ITw2A52/PFLrFyKmkrrfaXdZhAW1uSJsVW2vleVQnUI+FH7dEjuoUNREH0JQE2TQF0QAaXZivyx3jfqXM7ti2HL8SaHhMEeAYFmKZjHOw7rpzcm2p9V+WTrMMXXN8COI+21guyuMA2enz862G9s6568yRL1CNQwknHwZrLH3g5uv/ZmJ6usNhGORp8x+k71bbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1grdFi/kUHRlAA4NGWyAukJdwU6YoryC9egXV1alds=;
 b=u+KBrQmCM9NfkkT8yaINkyBZ6hq1HcYMOjMD4uJFxDRQPRPqZWiMWN7357LUF6wGSJdxrhjM+HH7Y1PjCwuqnit5JJs6yynUtxh3QdTdJJ6gTk5it6oIstyeMFS34zHKMarUA5l3JYUWEV7LgFROme3z60RM1//QNYbUaEZwP1c=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB5021.namprd10.prod.outlook.com (2603:10b6:5:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 02:03:12 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 02:03:11 +0000
To:     Zhu Wang <wangzhu9@huawei.com>
Cc:     <kartilak@cisco.com>, <sebaddel@cisco.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <nmusini@cisco.com>,
        <bvanassche@acm.org>, <dan.carpenter@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: snic: fix double free in snic_tgt_create()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttsn3mnz.fsf@ca-mkp.ca.oracle.com>
References: <20230819083941.164365-1-wangzhu9@huawei.com>
Date:   Thu, 24 Aug 2023 22:03:08 -0400
In-Reply-To: <20230819083941.164365-1-wangzhu9@huawei.com> (Zhu Wang's message
        of "Sat, 19 Aug 2023 08:39:41 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB5021:EE_
X-MS-Office365-Filtering-Correlation-Id: 901bfe81-15e5-4226-bc06-08dba50f6f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOYsmu8j9w/AJj6ptFBuI2Qy1ZI2sDUKXCHzlAZPo/FkLfFlv6up2QldWLLzx6BOu8ou2x+aL/mODxwLqoJtdiYsXz2iKcOTy8bGRMfKamXlM0sbWupPg4PUo0RA1DopkDD0ImvEjkefqFyFyEqvVnnfrONAsHvksQbexZzMci+0WNH6rpjWI+DB9E/l7o2tWPqh4JRVCxlECMxdTjXcSFAZu1KKr1DYSQ2kAAcXdKqPCPVl80dH/qfvYDIwaoxaMu8PLocXJgPvrOfTz10GoCBd4SNW/Tdo8+guQP5DBpJ76z6cyNqTZ6TU4B7bbIlrRXmD5ntSyAJsaMhMliIoty1bLXoKRr5Ef5AEynwQs6hLnZXWYikPuK4ZGFV9xPw8Tg9HFBZZpkRvdu6IoZF1y/DV0AntFld+lXW0kAueX0wedhNwTzbY2t7qGN6f6PTlT0z8wfMnTONJnJ2/iXfvrYG34fwuZ7xCQQqTNj736kSmWGceCzV3+yGUWvMkG3IeEfbQRPsnOfTpcsq6ZPLlG4L67SksUiqZdvzsE2pEa1oWwXfC/63gK4nCU8hwp/u2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(186009)(1800799009)(451199024)(5660300002)(8936002)(4326008)(8676002)(4744005)(26005)(38100700002)(6666004)(66556008)(66946007)(66476007)(6506007)(54906003)(6916009)(316002)(478600001)(41300700001)(2906002)(6512007)(86362001)(36916002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AGqLc5w8tVvKKkbuFzcYcM+X0sIj15xDBlAedFYKWUHg97vYAc/uqRvEzySl?=
 =?us-ascii?Q?6XDubQFeN7ygrNYifEF4S7pbCLG5p3ELcbqCzKdsCsONeaUVXvsxjN+eORSq?=
 =?us-ascii?Q?Ve10EYzbqs4zcvX0goRv14i4gDakheSQ7YcH4FA1CHOZlVzZZJc4TXLgdKwD?=
 =?us-ascii?Q?bJallnSBM+TDVvdP70t8WRbRaw6OsGPXVqSmzP+rDWj2i3629CUTavhoEnfI?=
 =?us-ascii?Q?OpN/BvzbWT4FIM9CEcbVpZFY1W5qZ7cPxlcQapCsU5opDZJWGk5od1osCI/e?=
 =?us-ascii?Q?x7BRAZYYtgLNa1cgZncJFnOZdKl5jK13nXwlNlN2jeNlYgGtZ+qQ3qdlrapU?=
 =?us-ascii?Q?PeaFrONeEKxJxH7+fwncyVVugPl7GquulJ10aOgWrtahzDBs3JY3eIndpM54?=
 =?us-ascii?Q?ruMiBOyd/J5irXtfBIa8gU+THL/i3hasUcZHCI4/q0/akOVi83Jfah7vBP3N?=
 =?us-ascii?Q?l/x8aOX2eSSblIuCq57whKN59VOWc7aCOUJXtO+eOX/nGge4JWua2oD22RPL?=
 =?us-ascii?Q?rB2G9VOHuRzpFLtOCo0JjSCJ86AUZ9xJgYwGUI7apGqdWZ9993p7nMeJtVvC?=
 =?us-ascii?Q?GiqEfROJNyh3ebkCwOAHwkSZaswEBm9cq6N91CEVfLO0oDPiIf1HrjIfk2fb?=
 =?us-ascii?Q?c6AXrKlY3AxAP9oueyM6CcZoKywkev1aiDSQ7TDWPFVw26fsvXAsCEkBPb67?=
 =?us-ascii?Q?wqUzQSVJioq2JO/aOCmPwyLBIQS9AG6K4dsQm4m1LceGIeKcxei6nCXbLX4y?=
 =?us-ascii?Q?fr9Chcu9SayNWXcVjWG5tImuk3D7SMJY83p9GiVdlDo3AENHf6xB2gqqtWzI?=
 =?us-ascii?Q?41yO73vK+DOejK+oa4DFqko1HB/xx/aQL+hF2OIynPle6fo4uiSDe8hPXHZA?=
 =?us-ascii?Q?RSJOzQXtSBHe3X+REBUa3JnftrT26ERvOMZqe4HNaUHba8wgn9Mdh2RwY/UI?=
 =?us-ascii?Q?O5ieHcheoMJoWw97rXTyFEUaFR2n4UrKJMyVKa0wUQ+DzW9FDWC+pkelbGZF?=
 =?us-ascii?Q?MtDvPKfhPVxeIJw7OJe3dMcksrymveT9oixlmLBS8EvZRG03T0wePVpgQa9T?=
 =?us-ascii?Q?GleHNTq0/5wcTqtAiug4J7vzUnUimHV3tXtAeYjbLbcZXcHdqBpix4EIRO9w?=
 =?us-ascii?Q?tJQZt1IK9F9AT1J1UQ1ttjkP6aFbP26mzPX3X5hi/LRfOc55H16w4kXHC2Id?=
 =?us-ascii?Q?5+V2zpg8yEkzdWBRYZCXucHR5260j4XKEHb8Mq5no6SqVT4ZWm5f6SkJrnGr?=
 =?us-ascii?Q?m1e7oBlC4Rnz1Fghoiy2aa+g2Aey6vnJFhahsswqARr0c8ZweYUt2FbQ0um4?=
 =?us-ascii?Q?5faOrU4RBROaV7lMjznfRgs7H7p4K8eA74KzjQIOmZLLFJq/oz0RoiRq6oA+?=
 =?us-ascii?Q?zQxFRjYWr0BSro7mDSd97/goiq+5BPDgTK6CzNCATTcUxpA9i1MAJLEwBDEU?=
 =?us-ascii?Q?WQv55BAOK3MG0e8mJfb5swxOCm+nUIWKirE3uSSbgLzDQOoigD6PxgSeEBYS?=
 =?us-ascii?Q?qWBLvWwxLtK1J7ysFBuboAmEt4cte/jAEjp0JcEFqyp/XJm1Ou7VFTmnb0+D?=
 =?us-ascii?Q?kYVOK7CIyUw1ikmiPcBXtW6Vq+7XjXTBdDHLRtQi8oWyrcOAehpAqVy69asa?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CppFvtI5herwraB1MYCfqiLwVEENNHctapoBmcciaojgB8l+65/5N6+fDAGxQL/862GBr92vE9pAckkRz3drjlr0U0RcrNjPq4UVqqBjwPjU5Ca+senpqOj3yDmLma8BDFJ/A6uxkAv2yAtueMB69t2/uz4MxXflGDsX8lIwfGpIS8em8WFwEMWjzjutSuXt/Tzn4u7MG2Ra4rqb0HaiUtkm/MHNJOxa/wOKrlcn50QNYpLYh6016eAMw3ztWBtTow9j5ODPvLY1o7Dj60XrJIvhwpaXZ1pVfimyGNYY0IbdiTIXBNKLJZFKXBw1rLasdNOKR/IWsA5dwaCYnC7galU0FoBQAjt2jOFBR4DNTDB/hXtGiM54dx4WuZ025ElvIa0iXSZUtAkBc5WrU8vNHKGsefCIsLsTLX2wvqFXXfBwZbvJ3oZOPvEbwD7U7hMQyDUku9EVg2JksqEwVqgYioA/Uvw7rNys0oXdw/V+4G3UrDmrG4yHT1w9SR3t9hwlPAiicFu3HENJDO+/a1c6wHqKFXFt46C1JtmeS9ntukf609YK2IaUsx0aWdUTXA/OgBGRBatnuB72tuJsiSsDJSRhfYm4QkxbQx1cLgDem5D1Wvz5hVUIq5yaoL5JRRm3doWNpGzLp3YT7c+Ep1b18lSs0EIfYqNf1YHTyHgPSgx60w4jNEbtX5fP/VYrhScdKdNnJkC2FYNCvq725ug1RRRKNPyoVRb1weg7/7ixzLL9bBAD8YTAfCzbtTR4/sth0k8lCSIQJXnHUsrk/Rv2gYNP+lVopCy6kwBi8f9ZlojwpzKA4REv0c8frGzWftc6KJv0x78kElNqpvWGUdYHGQ8L3P0DFEtzkHLeiLrW3GbRYsRHMVsYMKeR+hzf/XuH58mywg0EGoZXzrDwVbgMJQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901bfe81-15e5-4226-bc06-08dba50f6f89
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 02:03:11.8358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z22yQcYqam//GhHB+vtkHTTOoKSMfUjAVltyfcRwG7SxZteVMuCvcyTFWRYPL1O8vEKBOmv7D33fVjYXhyuf9d1ieNKhcLQfJQJRF7PLMdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5021
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_01,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=724 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308250016
X-Proofpoint-GUID: WKGgGMKdlNIFtjkCY1GKpa8KcHQ5j2eR
X-Proofpoint-ORIG-GUID: WKGgGMKdlNIFtjkCY1GKpa8KcHQ5j2eR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Zhu,

> The commit 41320b18a0e0 ("scsi: snic: Fix possible memory leak if
> device_add() fails") fix the memory leak caused by dev_set_name() when
> device_add() failed. While it did not consider that 'tgt' has already
> been released when put_device(&tgt->dev) is called. We removed
> kfree(tgt) in the error path to avoid double free 'tgt'.

Where is tgt freed prior to the kfree() call?

-- 
Martin K. Petersen	Oracle Linux Engineering
