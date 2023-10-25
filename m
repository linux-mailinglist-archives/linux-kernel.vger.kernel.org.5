Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FFA7D7225
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjJYROv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjJYROs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:14:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34BB12F;
        Wed, 25 Oct 2023 10:14:46 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39PEwltj004652;
        Wed, 25 Oct 2023 17:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=B7gkiIClLdE3NAwnwVlLo2d9ienEp733GA9+wCt2xSY=;
 b=13l7hRN3KNA7POdvd51G9zEs1i9FBp7d2vfGdYER/zG/cQq91i3c6t0uWyIAAXT6tqZU
 iXLsWqFlQsVuM8cUSGUYyrlda07CpE4Vd6FRkPtuIWcZq+Xl7wNGZ14jlq4xpbHs3gxf
 224JNw/9C+/wd3t5tlsErTE+N3K0CZxBhL4zheY0f8weqduwhyYiZ+tJfBgp1risSPmA
 KS0qmCjuXYkTX8zG5rzURKGSddxHbHOwwBCc3sfrO6QLG/zLif9xO+vLi0eiltApilsW
 uZV69h16QkWQuhZFlOehHKqVTlshkxpsA4s72VDbxXBA+F7Z0szENKN0Wt/2rFFl3Z3p Fw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv5e38a1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 17:14:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39PGYAAQ031116;
        Wed, 25 Oct 2023 17:14:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tv53df3n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Oct 2023 17:14:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHacjnZvbmSkZusbiSrSWA+/ZM0bzVA9G59vcs+DCukZpVIS40cvbVjg1fkZOaqvPcPWuT4Dwk1UJWcHUofBzioH8KioulVdJENMg+XKxH1XSTQspJu+mbYFeXl9bj01pjhCUQsDYt1vf1N3FrLOFRA4Q3Vzq2WxMcT/mW/WIJJRncJP+enFyTGTWkfL3LqdMdNSch7deVrljzS+coYb8ZmNNmHWRsx1W58aD30DdSRiiMcNewLvOSeMHejlgEX7+NXirhj+gfntsy6QbziS7/ysE+VHp+5SOYdFJjxECf5EQCqYBuvKTOzFR3WOD25Fva3CJnWyGHB8H/lpCJGHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7gkiIClLdE3NAwnwVlLo2d9ienEp733GA9+wCt2xSY=;
 b=lga7FqPt1DtpnmAfx1KLOHCUAfFoqo71U0OMw0YClXdDfhbk3hKw6Gk01ik0jkDF8Xhuxt7AslabJAmyCKv16AC40jQMXk6Z4Ka91A8nwhSTYjZIdheOG9bPbU720/q/UEJO8WgwIB4+X3daCx6fEv5RlAasIS+QiivYyV2+vLbBS1TtN8T0penwI27jkb6eh/VczVy684YqdK2DNiDRreV024o8EwTs//CZumuZpuOXUxLmZNimRlzXUIh98jWla7uoHn/0MQc3q6NKLDEhO3JsLjqxsduVuGAeOjMSWqYtWQVL9zWMDh/aoOSd+B4Rm5zXHO03f7N1L+c/+k5opA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7gkiIClLdE3NAwnwVlLo2d9ienEp733GA9+wCt2xSY=;
 b=x0UYKGC3pJDYy7LeN/8Fc39E9eY8I2NK4UiF9Rd6sEQhVU8pLYD7I1T0XU9egKNY49IRQwJHK5m/Hw+SBTkoWnJMRarCX/xvaCsBOPnjVxQNuom0fjVyOl47mKfouPfZB9wz/MaojGSc5EXZSFXwG986AH7zv6P5UnucN83xD+U=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by SN4PR10MB5654.namprd10.prod.outlook.com (2603:10b6:806:20d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 17:14:41 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::c0d2:a35b:46a0:d4ad%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 17:14:41 +0000
Date:   Wed, 25 Oct 2023 13:14:38 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stone.xulei@xfusion.com
Subject: Re: Issue: Can padata avoid dealing with CPU-related operations?
Message-ID: <zbsfmml2ssis4ubs5gn57hmyy6xqdtqmlapqe7cdppznsujvlf@ozwdvllrecjg>
References: <ZRQtYnAhF2byr784@fedora>
 <cwcbhk22vycf6di4d5x56l2e5sxm2o5s45v4w6abqggyluyzko@xhcveoev3vhu>
 <ZSDI34RMdJ7es7hj@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSDI34RMdJ7es7hj@fedora>
X-ClientProxiedBy: BL1P223CA0010.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::15) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|SN4PR10MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e598c6d-6535-4198-fc67-08dbd57de057
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/WKiTf6ax1+zalpVeex1NS4JXBnJfK3UI/tPX+JyEcPRgjzKPa7n4iP4/ph1xqQQrtgMS6CFQS8I95Khw197Z//BOPnWF9z1MLZuEsCLfFrh+ZvJIzaVyUITuZAu4SWHDpolBU0o0FQhLu9VR7R+jXfcLImEvQKw7D/pL6Hd8rrNqb+Q9ER0OWxuBgHEmPlww0sHX1aNoX9DQ/jcKMR+4l1mamFb/om7/tdWsaRT/VPzwgOgNaz/IqtXzAS4zifW3OsObRcU4eKiuqjm0rAxYA/VUO9KE7o8molgrgzQN6bwi/9jby+n8I0YS5t+Z5yhldP8/Iq4LjxXpmtLGI3mzHPL16XB3ww7sNzcuXaAscTt+kxi4xWED4eOY1JjGrEAA620t/PoCsMgPWG6HATSTi46vuysUzeFeWrRm06Uh4TKA+mpoWvimNnwEv7pD7NjoFbAr7zO6Ndlu4Pf7dM8GAuLIcl1xiKwogOaMGyg67qSOVr0MTTEmb0VmfzfdG5IJJ6IeUoX/DgJoiVDO+0/UO6uS6vhYgl5vSa+tIZpXs23ZnPnE7Hw3GubCbHnU0mQnbHBJCFxk7Gw4bwAAhz16JGAYhZ2Bvr/RkQrHXA2PE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(6486002)(8676002)(8936002)(966005)(33716001)(6666004)(66476007)(66946007)(66556008)(86362001)(478600001)(5660300002)(6916009)(41300700001)(316002)(4326008)(2906002)(6512007)(9686003)(6506007)(38100700002)(66899024)(26005)(83380400001)(27256005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z6Zq9I89bMSOdsW4+5b6AQAUbT1UkCDhMYx5/gao3sZTwp6r3jQZcYMBFBN4?=
 =?us-ascii?Q?Qp/fJ4MIuzKD7HFO2s/QT5LcBUipTw5P9D0zBxMrrY4uiYqJ6MG5CkwO0kg6?=
 =?us-ascii?Q?lXiXvQ2dvc0rI5j5EH12gzdmRaIENrJ54JMDbceVcqmk/J0/YsRxqfLlBTSS?=
 =?us-ascii?Q?7mbEikUZXEMpECvv6STgJ0tFR59EU9fBW1Vfmd6nmmqjd2oX+ie7HnXBkQlM?=
 =?us-ascii?Q?L96zj/rbfuExJN+hvOP75EAD6JU8/Wcqscxwvw/5cXuLSX42WCh8CdSXRe5c?=
 =?us-ascii?Q?YnXw5DPn+UFnHgqf9gAv2z5AFLf4RIgWpT/saQXJHagE/ZoMcL7IyyIBLhhY?=
 =?us-ascii?Q?5knwdEn5nmPrYot6F2EimYRpqELeBinhN4MKryKa/pppYnM/J+0xwAgzAr5v?=
 =?us-ascii?Q?z3PO0DW+LnvAVq13GptAR+pBub6XwJae7pMrpIZSisfcJE6GhRQstC1G0hoF?=
 =?us-ascii?Q?/DJyBKHbRuzmyJ8kE1gQWJ7CPmJGjIXAAFE2vFh6ugbGmkfM4ob7PqFevIuF?=
 =?us-ascii?Q?ZVeb3lQk/wvYTxolQHBj6EwYbGw2pNRGqcDI1AWJC/atSUpt7HXHTfja5VYN?=
 =?us-ascii?Q?/ZZqMKSqyRGf4917cfLk2Z9yrJeZ0eLoZaaBmx0+r2o62frQkjYgPU5ePIjc?=
 =?us-ascii?Q?WtfQigpBSAgTmte+2kyd989zFkjeXWiqAl4MM9SjUMcoTr1tb4V3f807uFrJ?=
 =?us-ascii?Q?qVqLIM4Y9JGHNgkN70S6Ko1v6adCAd1kv24CJTmrO2eYwh1OBZdH5EcMZt+5?=
 =?us-ascii?Q?YT199nXL/g2KSPdk6jPxV33Sq5xs1qEavLJFBXADbVuoTiK11hs12wZmEox8?=
 =?us-ascii?Q?W7LuVQwKFgoblXeZSF9ERHUKBrIFGLACDXpKHbi52JmdLcDaWPLHJP6cNjAd?=
 =?us-ascii?Q?vxOs/lFqe7LD97R7FN0IEuMOF1c1museMIIWd25j+N8uhE12pvbGypaPG5bU?=
 =?us-ascii?Q?9F2HpEgjSAWvPiWh//aDhpCWzzlz/BeZFbJdRcZmfjwHpSuixIxZam+eGVB0?=
 =?us-ascii?Q?VFTKr8rHUV2tOWj01w6E+uTAGVuIn8ST2tNj7wqzx4U9vtx21uIFq7+K+9mp?=
 =?us-ascii?Q?s0QtjrtgpkOddxGpwb8gD8tZglg7wceE8m843Ro6iU8HPXjh/uk97dUCfw3M?=
 =?us-ascii?Q?VCtO7QHf80Ie1g7IMk31pqtCzrwx1pcvShiibyN3KPxzZ124LL1iox/cyTxn?=
 =?us-ascii?Q?ZKjFxlXoSRBZZvIRFDbPh+8CAHzqblQjL5Ngnv+cw6YSGhjYoDddqkdJQaYY?=
 =?us-ascii?Q?XClK6oed9wFvxDoDCw/A7maUBYpvS50skTftNakt0wpxDCHN/HbBOzqO0ZR9?=
 =?us-ascii?Q?KGWbUmm/S6NaBhCxs6JzWfyv6gN5DJcnjfO0Wx9i84aVym2r8BxNv+0iVJG+?=
 =?us-ascii?Q?eF9BgzlJxq3ebbUQeyfULwUMU6Wg/sT9mHlMyHLy8xmwfqP+1GoJylWf7Svg?=
 =?us-ascii?Q?iiqMWc8m4ijJyprQifzXSvhURTB25bh5eZPdNXL0Hx1QIC1mqEuUUmEOzomU?=
 =?us-ascii?Q?16YM2F6VeBi6fOTsAhK1Dkns7iU+ID8AXZGFuOvCo9Nvxe88NVXZe+4Mk6Ot?=
 =?us-ascii?Q?0TVGVDYHyrn++ZrnyWO1ddcopdmOCj8TqRMT7fhp8z+B6xqx56VBM6P2sE+s?=
 =?us-ascii?Q?Aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TK5ZxJUuYAuvcc24NrPIbi38Yef2q2MQ8rmWKpc+TFRPVdDg+vljzSk1DmWX89KhgiQs3WsQnsMfxYps/sPJnqQ87+UoL+msBWHTzE7S2gcdqfiA6obnu8qEPLtRI1tK13WS8+9fOfAhcj6LB0Af163RcvhAys4sgqYZ5flk0f2jkgevG/EMc4oZ7gO9iPT+yOYKCO1vHA4poy8/0ZrDH2wtjVA06UgXuZugYLO1aNEZ0RIPSXgNjxw447tiFbtoQmkdtdX9PRxfEKrBV05AjzDCasAZ3ybxe2ffgzeX3gCQ1HFQU51dVLczyup9bIg1v1G8BiAO4Fyb2Q189jjxstVNPWlNGaocSu58xYNvk9UktmDysZ99/Im8A5VwAh90/ZnJyK80boOPQa8W2FD3jAejXb+xE9WXMRbNpPQEmg2sMYkVbNsIeOpYxzhrJeK+FM1itq3nD7AtHiov9HFT/pu0A66zeaR+hnWb2eQ7GBUI4v60ZQhmmpdm1qZ0rONixbxVmd3xDrVDgPhr1+HPdwDu51qS154Gx+yNreT9HVTNXtMQiq8DM1It3q2ktMwq5/hcHF9O61LpIa0a/2Idan/jsZOKGaQ5MTexruZ2PMaX2m32AxH1XzFum9Fe9mluTQ2+R8HAZa8d1+8I1IoB784PWa4ncBJUB7MxFvX4Kdcjhr54Uz6C/vYpJWCgN1NLUoGFV+LwPhNlJ4UPzeiu/n3YJX0DYqLsRaqfTM5hI1mvdKvt0M7N+DpLQ5unNHWGIBPRUv1w9ncsQW6a10WE6ewrXKWXIgsDNytZe/XHESB7QCLEb2RhJbjqRIy8CxD7g7I5FalAY28RabfbqBh0Rw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e598c6d-6535-4198-fc67-08dbd57de057
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 17:14:41.7299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAbcguzlQ4HdQjKAiy648qT2IvXYcWsYUylf9TTU6rTTK3pY2dKuqgnvyZB4gP+0ls11eJY3/gfK/enfSYicE0P8DhSCPb4GI4EuH/rFN4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5654
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_07,2023-10-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=884 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310250150
X-Proofpoint-GUID: ar-pTpHUSQ4fLEH_eZS2l2nfgS4kh4R6
X-Proofpoint-ORIG-GUID: ar-pTpHUSQ4fLEH_eZS2l2nfgS4kh4R6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 10:56:31AM +0800, Wang Jinchao wrote:
> On Wed, Oct 04, 2023 at 10:52:57AM -0400, Daniel Jordan wrote:
> > Hi,
> > 
> > On Wed, Sep 27, 2023 at 09:25:54PM +0800, Wang Jinchao wrote:
> > > Hello, I have a few questions about the padata code I've been studying
> > > recently:
> > > 
> > > - Why does padata use the WQ_UNBOUND attribute of the workqueue?
> > 
> > There's background in this series:
> >     https://lore.kernel.org/all/20190813005224.30779-1-daniel.m.jordan@oracle.com/
> > 
> Summarizing, the use of the WQ_UNBOUND attribute is primarily based on performance
> considerations. Is this understanding correct?

Yes, it's entirely based on performance.  In the tests I ran, padata did
a lot better when it was free to run parallel works on any CPU in case
some were busy.

> > > Because I've noticed a significant maintenance cost related to CPUs.
> > > Are there any specific benefits?
> > 
> > Aside from what Steffen said about serialization, the pcrypt cpumasks
> > can be set from sysfs to control where parallel and serial jobs run.
> > 
> > > - In what scenarios is it necessary to specify a CPU for serial
> > > execution, or is ensuring the order sufficient?
> > 
> > I'm not sure that it's necessary.  The way I read it, at least, it seems
> > pcrypt uses cb_cpu to load balance serialization across all CPUs allowed
> > in the serial cpumask.
> 
> I recognize that the key issue isn't the capabilities it can offer, but rather
> the underlying necessity for these capabilities. If the need isn't particularly
> strong and the cost of implementing this capability is high, should we consider
> omitting it?

Well, yeah.  In this case, I'm not sure it's necessary--it looks to me
like it's not--but Steffen might have had a reason for cb_cpu that I'm
not aware of.

> As previously mentioned in another email, I'm seeking guidance on how to effectively 
> evaluate the timing of padata serialization in a network environment. 
> Could you provide some insights or pointers on this matter?

It looks like Steffen has given some hints on testing with IPsec in
another thread.
