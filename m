Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423ED7E54AB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 12:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344389AbjKHLCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 06:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344174AbjKHLCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 06:02:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFBF19A5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 03:02:47 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8Ark4R021517;
        Wed, 8 Nov 2023 11:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=fYvEsFaeXTAMVfdPpDb30oubiJab3+rIlpq+B5Qqv8A=;
 b=vthqApkak0lK8hRWAf/Dkrv0cgu/2s0EOlUyERKGjm3AhSOxqGuW+5uV8lAWmC+FaboU
 eoQA+US6Psb0ScLGTHCnNvU2WVIqxpiwDqqAekWrhW9uOomNihBhJshNglcSfENV4CgC
 +8e5b6gPW0D1hLUzMue3iCLn+HquYEGiX1FKyHGKkbVGJrEiQqbEsED9IvRWRA1DGwOS
 4oFMkXkER3a8A/iBSxV7MdZhd7qFJgHsqwRx1aQDy0bMcxE0zzwVNyS7PZwpl70Pub45
 EtnTPPYXjkuDixHpQzZ79EPqjhRgSqTCH/zaLueb3/RhLI0zmH/moo7DdEN/JgIdu46s Eg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u7w221958-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 11:00:50 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A8AATAx010968;
        Wed, 8 Nov 2023 11:00:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u7w1uj6u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Nov 2023 11:00:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr26DPQmb8dVmgaR7EaXfzoTMMYZbNhgDUn/3+U4aoC1S+WM3WX/jqpQj7rTCGGSHrd/Agj8brwUvV7i/MoobGfFbaj7FIzuedd8213h2xGt9RvaeXEtE1uUsA1XLIUFpZp3DtHmQD9cbQktePXSjAjqsEkzROgb6ROboXxqnJSrVs8zYlOribJmNXjtqBbnbC+WVaqekfFuW4ov0vmDlpDPWuqeZVuyb1jA3WO+wMZ7IJYc6GMbEw0bQNaJx7nioxMDbMZHorz0emde9Zsy3xY951pd6210ZjZkB0HZVKOJnjC6QjxV93rHSgI7M42FYkZprF8nMCF+yTkAK0+LdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fYvEsFaeXTAMVfdPpDb30oubiJab3+rIlpq+B5Qqv8A=;
 b=cloPxWK9gTO3QGJykOKsfasAsYs/Z88LbUYMs+qLiCVHmnVgTQ3+LeoXI18k2qdfQhEJP4sHIe5p/7R+tyAOLLStgs5umR40inhxWvW2gkdhy4/4GTA2j7eekmwpK4XnQg3SPuwas41GFxfphyq+CiHjbwksLFmNk+0WAoSfYIiyZ5XGnpAIKsPZClHLAxqpRj4ATEUHjX+lf3LsCvUtJRgY6Niy9B+oN1Zrl/HSl1xcmAL9fHSc4SruVMdr3OMArRWh2C8/qVBg1RVyT3pGSCxTU/kYExh1IGN0A3qtsFJzwrtgye/GHArYcO5Lj5F178EZriM6/Mr0omNJeDYI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fYvEsFaeXTAMVfdPpDb30oubiJab3+rIlpq+B5Qqv8A=;
 b=iN/Fy8wdUvHHcAfJq6Q4gUWIk/o6oum2liBPDw0Doz6PSjCr/SxIlJTlB34c4uHrqROuUNaFN9GJdrX0Edfu9eqUuYVt5c6CvI2mfpu+O0+u65uATuxBweh7hks8IOQz1pT6Rcp5PKz2YJdsbEud7ueCphmRJRCDMqdq9wxnz+g=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW4PR10MB6679.namprd10.prod.outlook.com (2603:10b6:303:227::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 11:00:45 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::10fc:975b:65bf:1d76%4]) with mapi id 15.20.6977.018; Wed, 8 Nov 2023
 11:00:45 +0000
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231108085156.GD8262@noisy.programming.kicks-ass.net>
 <87bkc4lfxp.fsf@oracle.com>
 <20231108101330.GK3818@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, paulmck@kernel.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com
Subject: Re: [RFC PATCH 00/86] Make the kernel preemptible
In-reply-to: <20231108101330.GK3818@noisy.programming.kicks-ass.net>
Date:   Wed, 08 Nov 2023 03:00:44 -0800
Message-ID: <87leb8ik6b.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0273.namprd04.prod.outlook.com
 (2603:10b6:303:89::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW4PR10MB6679:EE_
X-MS-Office365-Filtering-Correlation-Id: 856e6f6e-5d32-48b7-c1f5-08dbe049f4fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyGK+r80Y4U5hjcAbzwZJN6ACmgXAZXhgkhPABN68mzVk+F1AhzfZXWT2SSpEEzegBwcpkpQBiNkJ+UWSsF6kwG6JoqXNOBW08AgHwuBDevhGjCMsVgkQPOg/GhgKpVfkreQf3my5InbBTHBgUPgapeuTS5hq7ED8RHjqELuFBSqwlFv6F3zYOse7XWo3bTxtqzISFUcmYuRgbRx1T2kGpf0/uDFMMZi75VRLQTjUZPoqX2SX4F/jhWOEjwgoMn1/F+6rHoGTshKFeaie8zMeLKsj4XyaoeTW6VgZGSEpyaljOSiQmtq1ZzJAi8BzFTQ14Co1b+nPn56wvpwAwkWpDYhgoRZwqMDNTmt8j4FXBzX18pkBK880z7Pe3lyiJsvkG+RGeUOgEZC0rF8zUTX6aOR4doX5LlXawL9UsyOC99xp73eDJxcsgLrTS7YWkDx7GQh6/KkqZTVC68ZzK4IBFcFVT0WFujJw6Himk/X2+I7AdEP7c8LZsrRNw8BnZV35hwQMOQn3fmBVV6cdbQqjSe/iW4RW/9mRr9x2X01aCRvjBzksF6lo1CaCFD6rYpC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(2616005)(41300700001)(6506007)(6512007)(26005)(36756003)(38100700002)(86362001)(5660300002)(7416002)(7406005)(6486002)(2906002)(8936002)(8676002)(4326008)(66556008)(6916009)(66946007)(66476007)(478600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fxF0UoM7hO5PWGkvsw5UHFiYPpD+DEvVBbvW3f4K/F1f/LnEC4GIgzm9Ek1z?=
 =?us-ascii?Q?yzk5v5zfumBW9Huhk0ap8nH9Sc9kpThKQyMHxv5xZB5WS6HeYy127mUuXJIO?=
 =?us-ascii?Q?sbL9hR+jJCRlhY2GJvqs0d+sGUZwyq8lPALBE4uZCZ9q892+oWfApMmLNivk?=
 =?us-ascii?Q?eFuOpK1iY6aEHoXBnisEudJrg23h1NGZ/BkMfxaejr++bbzA/T5mi9KD9Dc+?=
 =?us-ascii?Q?0B2xP2aQYvnq/XNOiCFqM8BkT6I0HHf+3EHbeFKkK3F4D48qfh7R0SPqJP85?=
 =?us-ascii?Q?9VuxuovE4mjk3S5JNDtRPWhtHYhMvags6x1UgfYuMbxo2LUiQDy6sf3xgpNL?=
 =?us-ascii?Q?SOGssrB7pcMvZ3CaF1CfPTSYWERIHiHXmD3vxpxgTNjEe+fnivykKoaMgNbv?=
 =?us-ascii?Q?fbv2PCIq+jzPP+Cp6vcgypnVUp8Db8y5cRYmidvUBUW/uWAqdt9apSPOSJt4?=
 =?us-ascii?Q?+ytFrwH4avJO1GHwQVBXxctwPLxrlWOVPzyChQKVGz1h/jURt0NfEhobyHJE?=
 =?us-ascii?Q?alSnHPxqjzUlUtn+HTDKYpr4baooKySI6QPPmouwYLCE7s9c4/NgzCE+0Qv6?=
 =?us-ascii?Q?kChKPBbHcJ0Ip7NAYVHPoqEBCQtfOXdpq5PysPe7ryzqVAcsliZ0+Gtk1S+T?=
 =?us-ascii?Q?6eOiUL5vgzns45Vr6nbZAPcsdY5Lc9OM9GrtUxqe45M665t39c6wql5P9tV+?=
 =?us-ascii?Q?dLfn+W9d8I2TMlOgaix5juhpARJexKl3ryH3b7YtEPng0f9vEJR+2DRG1O1C?=
 =?us-ascii?Q?9K80izHcaS8/eypLUr8EfKNYCNVOCItAr7C4wrdGwACMKoG/DWxUmzxJDwTa?=
 =?us-ascii?Q?k6vZE8Cyy3lw2/wuXbtBk7Sw276sMydBtRgBb4SCjpOEkck7LrF2EzyHE85c?=
 =?us-ascii?Q?rN7wZXnpdRH2NIG6xqiAa8mPQDOhr+kPfYAjfSvizIgo3ZjBaF5W9e4R/mR8?=
 =?us-ascii?Q?0XKSRgb2cnMoQGdqpr+rTcyOdnvAMNu0X/5t9ZI+sBlX++Ys0v1X3KsHmfjM?=
 =?us-ascii?Q?Ua9QpQCeqr//9LklendD5eSC5z4Ig11ekFY8VKiUE7f/OoYC5J9WpDlX+Lmr?=
 =?us-ascii?Q?Q4eaNvdZ4YkJpXOy6qolAOfK3Z+t6agjKQU3IQmz05Cm2lRCsG2TGNt3qmNw?=
 =?us-ascii?Q?TPWHhVHNnDqKDCwa6gg1U/5/v8sWXRmOZHaO8aKD3+vZ+l8FJYIhgyObLbSt?=
 =?us-ascii?Q?9Ps981nz6s1Hu6mD26sGKPnNxecKX/osJ2ve3ZV14PbtuKQ5RF9M49EKmrm1?=
 =?us-ascii?Q?l2HZ+h+9m4TUeVE3N3B8goQJqVPE5Hn71+qEEEpTVfIPZpcmgyy6V61LuT9N?=
 =?us-ascii?Q?pGvnMPubf3XpbjV/vC25W5ZA4OOjvjrdfqaKLNgsPNH96DhcnmHsAz8gyjtG?=
 =?us-ascii?Q?iK2OqQJ8i/sjZRFoGQMimuwlRHyxJo+dInyzz/TAwlT9DzyQnKQ+0xw6pYeK?=
 =?us-ascii?Q?pZCLQk+1gfWBQVo8TsmgQFwggPIwtXX2iEaHUuLT5FQ1jIxYRo56802WRa34?=
 =?us-ascii?Q?fZWk5o407jpVbJCk+r8OV3gg1/9Df0G378MtGTJyBIB4NWbr8VtIxo0sWh0m?=
 =?us-ascii?Q?dSnKpQWG2v1bUkxOVT+7LLOsfwC+3WTWEkM8RahOmQNIbcf1p/qn45UIS3Y6?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?/sMHF4HWJmqMsGejtEZ0Lvp4m2L1P82gPmEcPkQ17kogMFb57Je9jBUKeFg7?=
 =?us-ascii?Q?SB4tR7dFrSte6HEVvD2WsWJO5MNL6pjnCpCkayXLYy5XtWgVjSTTSckyfLtV?=
 =?us-ascii?Q?owJf9CcVIeTTlvop1gxPp1FR5CKkxZ4Ai+rY+FXYDJBzedKQdFtBPMFsBqA1?=
 =?us-ascii?Q?+3nWJeun7mQhnd6ZcF1+33L51QVVc0++jpIzSeJmaJC1WUnqGnFE0yClfmB0?=
 =?us-ascii?Q?YunVMobJiGA0aSV4NbIbUa1YnbJZEQ4dW7BWWG4AzHzUdY26kXmv01IPsh+J?=
 =?us-ascii?Q?ePS8ygHd0pLGEdX5S/K0DyuNhdb4oB4/A3z/CR7P7RPqYZEl/k8CfC+Z5omQ?=
 =?us-ascii?Q?BtL72yxC6B/Gzj5hJtxyL5L22A62H/ZCbayWMP7/keXkdUQbN6VGyzdDjuTA?=
 =?us-ascii?Q?1yHhLRVq2Ro0VnWQ3UBqV4B+0GlESq7O0DNnPZRCuxxqUTe8zfAqM2jqIL7d?=
 =?us-ascii?Q?4aVFswiv4Z83rj2Jl0w29Mqcl0KCjUWbL8pPIl2T6vxRI4wEqDywBOs648um?=
 =?us-ascii?Q?gSA1frdrhpE76WXkwa7BibLSPFfHKPRsuvJdxsZTtfVqXyek8KOQgnLJwziw?=
 =?us-ascii?Q?qhWNilRPHmGxV682e/kGtYThYEdzZqIQosZERVYPbC1Qp5WRh2bUUy0aXe+q?=
 =?us-ascii?Q?ufO2Ia06SgS/1gJMhqCZ0B0DnDCqsxd/2AO1Jvz9AKRn2gvAoT6d1+m348DB?=
 =?us-ascii?Q?ExkmZ0tFJwLL6UwYB4IH+i/MlTClAOwSOelJerJe50Cy9a1bP1wyMVBMKkRG?=
 =?us-ascii?Q?NUt6IoeTLofDzrstVjCS2gT8mIfQNpQHimKT0wV8VARMlzMOmGrZGEuLajL3?=
 =?us-ascii?Q?M8PTsbXJrwyf0YWuYOrYNjtvzti/hoFmuYa6IwroemJkxXARQ1fSm+9Rrpf4?=
 =?us-ascii?Q?qTlaD2agsr+sTLKa4yrOqAipe3GzruDZC4GjuQfQ3VhMd3QErFh2FD7CKsRP?=
 =?us-ascii?Q?vGMmQcc7QEWWjR3UBm9894oOixyody5lbsNTWvuW1xRwc/PRfmUJgu/J3Yhu?=
 =?us-ascii?Q?kh8SP+tPtbIvVaq5NUw1DSTNrL670MU9pyg7CkeLhewCK6/2GRmhgJas0Bjf?=
 =?us-ascii?Q?Un9B+7V/DOX5nuGfWTMvVm+aIkcNrLrAQy/BZ/t47VwSX3EXoy9K9Zcish2D?=
 =?us-ascii?Q?a1LNy0oB3T07JOllEwX+v+jNY/aY638XUNhGITNN5oH+w3FGE1Ps8ZBEr9q8?=
 =?us-ascii?Q?abS/j7s4VuNkQIFMC2vkk4BQt9qIXMZOCKR6WoevfCcf7oGLxEdiisEq4TaO?=
 =?us-ascii?Q?1l4hK1w/Bxh8VJobIq4jDSbPpxZDdhMTvfZFj+Ve/sWW0RlBu8FaQ+19W1gi?=
 =?us-ascii?Q?0j8M54243K3pharrwLJDEVDj3wI6uxf5smaMLE1oaw5AENiwbKlZDRpBKjM8?=
 =?us-ascii?Q?6NSn8Z57Fn7om5WAv9Cfm+9C6k+OkXMSuwR+LLVfcX+A8lU8uR4OOxDeHkXZ?=
 =?us-ascii?Q?CksUcFQz6nRz+gq5FzsFFa8Mf+4EpRf2e9psKwvt58/SOb6soUmPfCehkJaU?=
 =?us-ascii?Q?B1rCMlT9eCLT/laFZsObOByWefP2A2h4MEhsjJ+372G2CZnfqp2cvDcUnQ?=
 =?us-ascii?Q?=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856e6f6e-5d32-48b7-c1f5-08dbe049f4fb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 11:00:45.1930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pp72e9wDo4cbYaYx4iMF+dr4m/2dqfhRMx/XZhyU0tT6m8kvWsXTVlvEhP+evNwlkGWtrfas7lf57OMSdv8NQJ5eNcovyQVuuIywcuAOww0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6679
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=545 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311080092
X-Proofpoint-GUID: hB7dt1idhhj4o7wGp_6Orbl81NNCGUsf
X-Proofpoint-ORIG-GUID: hB7dt1idhhj4o7wGp_6Orbl81NNCGUsf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Nov 08, 2023 at 02:04:02AM -0800, Ankur Arora wrote:
>
>> >>   Revert "riscv: support PREEMPT_DYNAMIC with static keys"
>> >>   Revert "livepatch,sched: Add livepatch task switching to
>> >>     cond_resched()"
>> >>   Revert "arm64: Support PREEMPT_DYNAMIC"
>> >>   Revert "sched/preempt: Add PREEMPT_DYNAMIC using static keys"
>>
>> What's the best way to handle these? With the lazy bit, cond_resched()
>> and might_resched() are gone. So we don't need all of the static
>> key inftrastructure for toggling etc.
>>
>> The part of preempt_dynamic that makes sense to me is the one that
>> switches dynamically between none/voluntary/full. Here it would need
>> to be wired onto controls of the lazy bit.
>> (Right now the preemption policy is controlled by sched_feat in
>> patches 43, and 44 but sched/preempt is a much better interface.)
>
> I'm not understanding, those should stay obviously.
>
> The current preempt_dynamic stuff has 5 toggles:
>
> /*
>  * SC:cond_resched
>  * SC:might_resched
>  * SC:preempt_schedule
>  * SC:preempt_schedule_notrace
>  * SC:irqentry_exit_cond_resched
>  *
>  *
>  * NONE:
>  *   cond_resched               <- __cond_resched
>  *   might_resched              <- RET0
>  *   preempt_schedule           <- NOP
>  *   preempt_schedule_notrace   <- NOP
>  *   irqentry_exit_cond_resched <- NOP
>  *
>  * VOLUNTARY:
>  *   cond_resched               <- __cond_resched
>  *   might_resched              <- __cond_resched
>  *   preempt_schedule           <- NOP
>  *   preempt_schedule_notrace   <- NOP
>  *   irqentry_exit_cond_resched <- NOP
>  *
>  * FULL:
>  *   cond_resched               <- RET0
>  *   might_resched              <- RET0
>  *   preempt_schedule           <- preempt_schedule
>  *   preempt_schedule_notrace   <- preempt_schedule_notrace
>  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
>  */
>
> If you kill voluntary as we know it today, you can remove cond_resched
> and might_resched, but the remaining 3 are still needed to switch
> between NONE and FULL.

Ah now I see what you are saying.

Quick thought: even if we were running under NONE, eventually you'll
want to forcibly preempt out a CPU hog. So we will need to have
at least this one enabled always:

>  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched

These two, it might make sense to toggle them based on model.

>  *   preempt_schedule           <- preempt_schedule
>  *   preempt_schedule_notrace   <- preempt_schedule_notrace

Anyway let me think about this more and respond tomorrow.

For now, time for bed.

Thanks for clarifying btw.

Ankur

> Additionally, you'll get one new state to enable/disable the LAZY stuff.
> Neither NONE nor FULL want the LAZY thing on.
>
> You'll then end up with something like:
>
> /*
>  * SK:preempt_lazy
>  * SC:preempt_schedule
>  * SC:preempt_schedule_notrace
>  * SC:irqentry_exit_cond_resched
>  *
>  *
>  * NONE:
>  *   preempt_lazy		<- OFF
>  *   preempt_schedule           <- NOP
>  *   preempt_schedule_notrace   <- NOP
>  *   irqentry_exit_cond_resched <- NOP
>  *
>  * VOLUNTARY:
>  *   preempt_lazy		<- ON
>  *   preempt_schedule           <- preempt_schedule
>  *   preempt_schedule_notrace   <- preempt_schedule_notrace
>  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
>  *
>  * FULL:
>  *   preempt_lazy		<- OFF
>  *   preempt_schedule           <- preempt_schedule
>  *   preempt_schedule_notrace   <- preempt_schedule_notrace
>  *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
>  */
>
> For the architectures that do not have static_call but instead use
> static_key for everything, the SC's are obviously static_key based
> wrappers around the function calls -- like now.
