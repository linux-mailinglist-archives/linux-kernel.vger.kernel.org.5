Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6D7B82BF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242990AbjJDOxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjJDOxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:53:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8C5B8;
        Wed,  4 Oct 2023 07:53:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3948j0DZ011647;
        Wed, 4 Oct 2023 14:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=u2K8hSkMjUpPCRpuzDJZQ6yDORygIMdLHKKULi17Z/g=;
 b=aBTeN8t+Y8iRtfnBN7ByDvG4pSZZBw5GO0CsNkkGBQtWwbhRfaTuihcjYIrg0M2ruO3+
 CK3lQP9y37ls6ZWPhV+fSFthroc88+Fil8NmoHUeqUFQ2qnapz0kPIMgFMYcKrKuYPnW
 QHTwycWRyz4sBKjYmQdSG2rIjXi4gBE+5ggURHP+tbVcozz1r0Rd4J0c4FP76PO3KGBU
 +6JGwXFmxZRZHgRHPxrkqLiod18jn0Igu6SQpkgjTT2KKj1vmmnRCFxVXnjf2sL5WUft
 PQTrwCr0iXJH877k0/4XhqI0swYSFkcriNzGMsGIZDgqhtVpPUYhKTR5zbB9damkUx66 Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tec7vf734-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 14:53:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 394EgrPE008697;
        Wed, 4 Oct 2023 14:53:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tea4875j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Oct 2023 14:53:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpS6lKiK0F9rhYIAwBlawjnjOASkY8/Ep2Q8xI4pRVhOpjl6E3B4YgSBzwfZR9j+kbfmxMFk0pB6R8GFVWUfGL2ntSaQXGDHjIXpsb9NT7ev8yVVM/kjh8E/tP+tB7F5AnqcDNXFvKTnjZg09L2yjPXdsMbvK3+sqpD92kqiYwcemJpu43jXRSQVJv/agx8ZCAItu7cVjL8ZBaUJSvDJelgGNMFOtZ46bl0s4RhOhk6pcnXTDYbCvyWg/LgGwdoK13ahnV5X6fakQ1ilPDizn8NK6JhqjL3Wuw4CM64JJjV2aF0SJjR/QbRXZLi/Bm2lxvihen5KLlRzj83wKgM15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2K8hSkMjUpPCRpuzDJZQ6yDORygIMdLHKKULi17Z/g=;
 b=ll58Agsp+yHgn+0ZVV2AGrn1GERklGLO7KqIShmjCE1GKjdMZWZesuEJ1f4TQYCX7kE0xi5c5yiiEqLFCMUZJPWfHgSOMhhQaArZFwEA64bNPFV6pc2fvdDLSK1iiANv9nAUEttaB9zE1Y9FselaeVvC0JDrJtfD2yjZDvqSvJzlfLjiylVsk6t0J/RrBh0/ve4MZNVq2XEZGuQAyl5ih7uvD1d5cpcjsns0KxzgaaNvFC/jjgLyNw4BfJfyHqOIbPaC5qyl1zipZZfB1H85Ycl76crOQWLCFruF9/UHTTYv2INtNSKP1qOUity8qkolt9NAFP90MfNOPxGV3A/7TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2K8hSkMjUpPCRpuzDJZQ6yDORygIMdLHKKULi17Z/g=;
 b=EvOSCxIE0af2KnoFabLJTBte0ZTkDq+EWhQqHia39rXJuTuWOVE6R7i45AG5PfHrdTMPIsvmTvBmII/XqywESrq9eHYk5BwmJF6upimgq2V5D7UPd0z35YfTP8FFhLoCG8GKe4K9Xuv1jTS3jdlrIW+DfjtV5m3Y/47y4qufG04=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by DS0PR10MB6975.namprd10.prod.outlook.com (2603:10b6:8:146::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 4 Oct
 2023 14:53:02 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::1aa1:e3a9:cfdd:f48%4]) with mapi id 15.20.6792.026; Wed, 4 Oct 2023
 14:53:02 +0000
Date:   Wed, 4 Oct 2023 10:52:57 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        stone.xulei@xfusion.com
Subject: Re: Issue: Can padata avoid dealing with CPU-related operations?
Message-ID: <cwcbhk22vycf6di4d5x56l2e5sxm2o5s45v4w6abqggyluyzko@xhcveoev3vhu>
References: <ZRQtYnAhF2byr784@fedora>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRQtYnAhF2byr784@fedora>
X-ClientProxiedBy: MN2PR14CA0020.namprd14.prod.outlook.com
 (2603:10b6:208:23e::25) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|DS0PR10MB6975:EE_
X-MS-Office365-Filtering-Correlation-Id: 1db4adb7-c051-4a1d-caef-08dbc4e99b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 04LhJ2PhD0f2zvNmboizzfdBk6OJK/2onWXBXWPoHfQYgc/XqUDx2pj0mfmfLWASW2PmvSSDhYOZ1Yp2jm37WgjFQ143p3kMRIDKGd98jnAihjZdPEadhA/avtt8rvUv4f9jEB6RgcG/bbPGHzIgguwb+VTSxYbksYllYA+02CvJat50BXk0C/7p8iB64VQ4sai4lLzgzQZEAZMwAxEClnsoJLzGkmzedLZ4Hdv3hR+jZ8QJs2YXvspF/NyIpFVEEkpLTbc0AW//YHlQRo5wO5sM0PgOu5RA6cUshsog+KB/7Djd4+WYwvt//I00NDsiO36ec4E2jnXHs2NPvoSfleUcWpc8uGxJ9jXEBA+zCWqCIyEk13wzF6DC+DPfkuUSRvCoHXCBE4wzKfrqY0U5UGwAcIaWgt1nwzlXGe7kI/xUdn10ggDwY/bgxSdxggsDrn9Jrr2VUKiu9/xIR74PMzSL405ya+hKrY1iOSBsvZuNGYeDIXSbuls/kL8YcE/d+XloNmQRHLUWFqbMQ9/EdrJy1I3O200TC5xX3f0TxAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2906002)(86362001)(33716001)(5660300002)(966005)(6486002)(6506007)(66476007)(6512007)(9686003)(66556008)(26005)(4326008)(8936002)(41300700001)(478600001)(8676002)(6916009)(66946007)(4744005)(38100700002)(6666004)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8RrYws8OIR5KirZSrpVNKbNEWkLh8WxPHPApBw06DfZkDUWLOEwSrLCReu1X?=
 =?us-ascii?Q?RyHuh17FG6dX+Cg2YaBDK7UdxFcb/HkgPE6vwwHLE/ybxBMvD1lY7U9TRydM?=
 =?us-ascii?Q?PFN0skPmIsw6lQy4yg+UkGe5Y67+jxLp1X2Otjsgmn3rDntbZ+DQUfkVTVjm?=
 =?us-ascii?Q?BHwfseem00w9VtJdbkdkhy6ZQUoXPSbQ3XOUuV0X+JW8ouASJwcAD+4hJw8Z?=
 =?us-ascii?Q?Zue3dXvTnthJCKburcn2SifhJqbPNo+nH0ApuVl0spm0rj4gPPWLhZmloXWx?=
 =?us-ascii?Q?Wk5xdkGKv+eRUZ6+qtN5O9usUCTUXdi0e5pMjgbZJTmVD4g5uJC0kKU26qzl?=
 =?us-ascii?Q?/RM+RquJ6qNlv6+6Ep/vWT6byiWm7BefrrSZ7P/vRfdMgSXNClHXt2LdBxu4?=
 =?us-ascii?Q?R3XA9gFzgygnjmO03Z28RE9/1Hy64DS24OKdtaTffuSoWq/a+jCkU6GA8VUJ?=
 =?us-ascii?Q?JMboFsGgLTXoRYE9y2pu4/94ly5icrkRH8v9YVY4YP9RMicfADyrABvWqd37?=
 =?us-ascii?Q?244oHc3NbW3eICwuOiLaUE86OT/g8sFJjnrAlAQlfpF+dp9pb0sxdMiei2eo?=
 =?us-ascii?Q?+X3QkXncKqm2FNlpVDxMhLrShtUWIC7UsPrQGpwB95X2LYIy4U+u/8PBZbwf?=
 =?us-ascii?Q?p7WWbLF3IUMT6Jtbn0sjfVHgRXTzYW5bIhoDoj4xLLUDWT/W3hCZFlTXQeXt?=
 =?us-ascii?Q?XQnWih9m7qKsT4Jl9ih0RUR2BAUHwP1vpuemJ9dzgO/3FnCcVQVgQQMmJDjG?=
 =?us-ascii?Q?+X0UJYl0ON4REG0Iapk+fTsMqLpu/rBOtPJUZMzarnqTr0lttDvoLJ50+jBw?=
 =?us-ascii?Q?U0kTQ//lOFudYicp1Hzn8FzdJqZsSmqiU/0y4GlZm1cSGmtke8eMbJwVv0gu?=
 =?us-ascii?Q?MQ2GL+BlnOc3bmHSW3MKhrbXCJMUMdTwgYcs7BK+nVASonDm398shdPGFdlC?=
 =?us-ascii?Q?wDDVDFW3+VwRJcNqGYy+XFEzjnT3oh0LRMtRjyd7Ol/YaF89bV1CrR0Psar3?=
 =?us-ascii?Q?PL2AduRe/bOZgdDmXBXjsv/BXbrsKQK8QHIpAxZkosl/3sDegYu6Jr4fl7D6?=
 =?us-ascii?Q?yUjaxxlCO2m+VpA37LeOXCugBGFu0SQVcRAqlGhm24L+0e3UaTbEx65H5MJe?=
 =?us-ascii?Q?C6d73V+5o1B3hCOyBZ9tlAxs6DWrJYDjqnxgDyZSYK9rQnwgsNk7wsj9f26O?=
 =?us-ascii?Q?cSPXxf9MBrb39gdkqGVOYdw7Z89e5MaVMhN/QFWnGEUCoLK1ZSIjdSFehRCO?=
 =?us-ascii?Q?68oRSAOKdEPg01OAuJ7BgjItpVXx+RBLcPwnn4wx+tsnpu4riQvZpWmi9y/D?=
 =?us-ascii?Q?uxAND/YmhVh1WJwJjgcGceocKaXRdZyaEihxb3s1tQSyRZJpcLtgU9SGtIo0?=
 =?us-ascii?Q?VBtY9PghWKkGrJpdwlc73A4YngveH3Kuqqotps2cUNeAHYYNg6pb2i30atlU?=
 =?us-ascii?Q?Rit9cDEuqnH0PK69J5uhrK1TvgVbe0Z/7msmngZGHGU/x4ocqmW8Y6dLRRtw?=
 =?us-ascii?Q?KY3S+zpQEgBs7sbbA00dmXHAIqCvAcLfTqvPVS+llHyyB9053WRGfevBGQjL?=
 =?us-ascii?Q?mY+xdgY4BMz6LNyoim+tMwcirLKAYnVHMENmGy/yNa2+Ym1VAIEZlNG1GV58?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CL94ZSqRBsVNekHK1IPPcP1Avo2RJ04NT4ciMGaDiVtzze/Q/v/RB3ugoCzCbaB8yB36D9gdV5Sh8xBfRtIGW+LGTFSTvzmhC218pZhCsBO8Q8jV+bXoqFMrMsShHHv9h6EX0OErTIf5gwWAJfI4gUO/Su824QT95Iddrc4WLq3dpsrPV6HRaXDXFUgdzFb/oWN0KI6q8O0zmo1Ro4vHvBQAW7Mq4JrI4B2mSUWe4DwHrlZBDtsb+09hLUZg/W+vy1hM1j4qdHjIXbJ2xqM45v7Iw2C9+CJOrQZ+2QrNSILPTEiqqxQELyoBazovyTuMyoXFpvIfkYpv0bDgAq/5sZSGGZSa2SjaGYp2uNMAREUV5K2YuD2uj+YM9nWrjX+3AOsdOOaOHDr9N+OJ6pD2SooqhYK9Np6yYb3X/BKO1zjZBJ0fGC2lsQqFWTA+OJai9CRAiWaB0D6SOk6zoCpFrJspg+I+IJ6GqhBH1JzMec38SORP5aP2c9EEal3vC+b+5iv7PTQPMuCqQSXxymGcKsyHntw0g+6PRc9U69JtbK8jRHAyTJmKp3RQ01X4YZGH+FrrSFnbqHD5AUnQXr0gXVg+8yp4Lmp7GzkENwXlbNjE56yQHfOvbZCYA3fAu/ldZhTnbUMlnBp/jTSnK4ykzTPPimmD3fBsupSxUIjERaAcoS8zc359Z7L4q7sIosDTW0n9wa9fMco9Ggf6S/RreciCMwmV3k4gCBxc7DKpoNeg01ooIFoCG0Cybsr/kgi7a01TyinJPOIdHs7M8s/caQR7PimzciFzUy0LiqVNEyNA90+Kxsv6zTAAW50VVOZ9lU+FNkVvF1KekO1aA2z7ww==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db4adb7-c051-4a1d-caef-08dbc4e99b6e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 14:53:01.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Es4y1zTJYyBIHIaTEN6PVEZylU5JF4VinhvhSr4+VM8tmWybGiqqLNa6MHqNfDClakts6i0OCp8wAAyOmglRgzkC21d5iphuXTKdQn/S4gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6975
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-04_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=954 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310040107
X-Proofpoint-ORIG-GUID: X8QSzxZQ2noNwg-1qui_9ACEHDbuu0FO
X-Proofpoint-GUID: X8QSzxZQ2noNwg-1qui_9ACEHDbuu0FO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 27, 2023 at 09:25:54PM +0800, Wang Jinchao wrote:
> Hello, I have a few questions about the padata code I've been studying
> recently:
> 
> - Why does padata use the WQ_UNBOUND attribute of the workqueue?

There's background in this series:
    https://lore.kernel.org/all/20190813005224.30779-1-daniel.m.jordan@oracle.com/

> Because I've noticed a significant maintenance cost related to CPUs.
> Are there any specific benefits?

Aside from what Steffen said about serialization, the pcrypt cpumasks
can be set from sysfs to control where parallel and serial jobs run.

> - In what scenarios is it necessary to specify a CPU for serial
> execution, or is ensuring the order sufficient?

I'm not sure that it's necessary.  The way I read it, at least, it seems
pcrypt uses cb_cpu to load balance serialization across all CPUs allowed
in the serial cpumask.
