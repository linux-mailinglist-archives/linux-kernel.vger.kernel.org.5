Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D31FF7DC788
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343706AbjJaHof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343671AbjJaHod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:44:33 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D22DB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:44:26 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V7UIkw007101;
        Tue, 31 Oct 2023 00:43:22 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3u2a9f46am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 00:43:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvYmgVqxjj8MmJjcMbPm02gc3qKey0pcXwQyeQycx0iy2py8sL+9Ws6tIN6FOU0ywUFkk+EJgDcV6QGXD1+asBS9Yh7a0KfcIP4TEDNdE9TXIcs/jMprrw4pqXCCBjq06n2bRmu5JcUNKYqwadqx/YzIS7sOOsDS0IQUol1OSy5Oo7KCca+pv63ZUugRV0K9qd6gambiko1EJewT8m1PErbXXTgSMvh0MyqALYTnsz3/NpdFiNVf9XBHk/sfQrOn0QUDbv+OOUIltzDTqDbRPOj2+C95HDISyfNBPBLLsCR2dvq2+lvyZhQUWY4UIjsCN2+TocBG9LXSaunSCbzH9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6d81X6vmBOaP3/ttfnVAkMALBbgVGLMeSxNNoM32Bw=;
 b=GUVExltRKe5ysXBypJ8jBMJ3QgEUT/vAL04kWJc6o/6hyKQG4d9LvrgRusPCKrl5vCC5l2aNjMdZizfzBSYxqDIiigjwaIDuFd/ggl2SHcKnMWiKwFX1YoHaT+gVT4Gl/V2jXpy881qFAj4EZOLCssU3z9rMri7lqYxaEJ4tfHrIJxXD0I49g3sV7pf4oWWBOgSqeOsF7pxQIYNmQfupz8A+/NscF8OnsQiHRpwaTpRL5eFmams34YH8SXrRFoQgZFTZc5lG6Gzyok1Fp0vJIQVs1NE03paDfNAIiCZqCE900NPQLtzRnsWeL8hsN7wGJCQOt+5lnC6SPgV09ysCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6d81X6vmBOaP3/ttfnVAkMALBbgVGLMeSxNNoM32Bw=;
 b=FH7N6LoIqaQF/3eK2R4XpwNcrjYZ9Mo8XjV+qdqrvf01fJWtWquSp6e8WmTEkcwzczfMEG98QsagsMnAsEZ3SRoWUsG5UHvb05JlZBaGJcAib5NqYfCwKxYXVfPzdPT1L4tRbIre9w87d5GaP6dTQ9AstPdHLvdNbwKtbCpD8C8=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by PH8PR18MB5381.namprd18.prod.outlook.com (2603:10b6:510:254::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.27; Tue, 31 Oct
 2023 07:43:16 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::749c:1884:5063:581f]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::749c:1884:5063:581f%7]) with mapi id 15.20.6907.032; Tue, 31 Oct 2023
 07:43:11 +0000
From:   Amit Singh Tomar <amitsinght@marvell.com>
To:     James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        "carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
        Linu Cherian <lcherian@marvell.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>,
        "peternewman@google.com" <peternewman@google.com>,
        "dfustini@baylibre.com" <dfustini@baylibre.com>,
        "muhammad.zahid@nokia.com" <muhammad.zahid@nokia.com>
Subject: RE: [EXT] [PATCH v7 06/24] x86/resctrl: Access per-rmid structures by
 index
Thread-Topic: [EXT] [PATCH v7 06/24] x86/resctrl: Access per-rmid structures
 by index
Thread-Index: AQHaB23Hc1XjQl+V9UO5UAKnHmTqPLBjh4+w
Date:   Tue, 31 Oct 2023 07:43:10 +0000
Message-ID: <MW4PR18MB5084AC18E19386E5B83C0F0EC6A0A@MW4PR18MB5084.namprd18.prod.outlook.com>
References: <20231025180345.28061-1-james.morse@arm.com>
 <20231025180345.28061-7-james.morse@arm.com>
In-Reply-To: <20231025180345.28061-7-james.morse@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pdHNpbmdo?=
 =?us-ascii?Q?dFxhcHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4?=
 =?us-ascii?Q?NGJhMjllMzViXG1zZ3NcbXNnLTIwNGJhNWQ5LTc3YzEtMTFlZS1iNzJlLTFj?=
 =?us-ascii?Q?YzEwYzQ3MmM3Y1xhbWUtdGVzdFwyMDRiYTVkYS03N2MxLTExZWUtYjcyZS0x?=
 =?us-ascii?Q?Y2MxMGM0NzJjN2Nib2R5LnR4dCIgc3o9IjMxOTU4IiB0PSIxMzM0MzIxMTc4?=
 =?us-ascii?Q?NjIwMDEyMjQiIGg9Im9DQTJCM085L1p3cTdPdjIvblRzdmU4cGpsQT0iIGlk?=
 =?us-ascii?Q?PSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJn?=
 =?us-ascii?Q?V0FBQkk2c3JpelF2YUFZNU00bTIrOXVUTmpremliYjcyNU0wWkFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFIQUFBQUJ1RHdBQTNnOEFBRG9HQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFRRUJBQUFBOVJlbkx3Q0FBUUFBQUFBQUFBQUFBSjRBQUFCaEFH?=
 =?us-ascii?Q?UUFaQUJ5QUdVQWN3QnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR01BZFFCekFIUUFid0J0QUY4?=
 =?us-ascii?Q?QWNBQmxBSElBY3dCdkFHNEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQ0FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J3QUdnQWJ3QnVBR1VB?=
 =?us-ascii?Q?YmdCMUFHMEFZZ0JsQUhJQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJq?=
 =?us-ascii?Q?QUhVQWN3QjBBRzhBYlFCZkFITUFjd0J1QUY4QVpBQmhBSE1BYUFCZkFIWUFN?=
 =?us-ascii?Q?QUF5QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-refone: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdB?=
 =?us-ascii?Q?QUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0JyQUdVQWVRQjNBRzhB?=
 =?us-ascii?Q?Y2dCa0FITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWXdCMUFITUFkQUJ2?=
 =?us-ascii?Q?QUcwQVh3QnpBSE1BYmdCZkFHNEFid0JrQUdVQWJBQnBBRzBBYVFCMEFHVUFj?=
 =?us-ascii?Q?Z0JmQUhZQU1BQXlBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFB?=
 =?us-ascii?Q?QUFBQUFBSUFBQUFBQUo0QUFBQmpBSFVBY3dCMEFHOEFiUUJmQUhNQWN3QnVB?=
 =?us-ascii?Q?RjhBY3dCd0FHRUFZd0JsQUY4QWRnQXdBRElBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFu?=
 =?us-ascii?Q?Z0FBQUdRQWJBQndBRjhBY3dCckFIa0FjQUJsQUY4QVl3Qm9BR0VBZEFCZkFH?=
 =?us-ascii?Q?MEFaUUJ6QUhNQVlRQm5BR1VBWHdCMkFEQUFNZ0FBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFaQUJzQUhBQVh3?=
 =?us-ascii?Q?QnpBR3dBWVFCakFHc0FYd0JqQUdnQVlRQjBBRjhBYlFCbEFITUFjd0JoQUdj?=
 =?us-ascii?Q?QVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reftwo: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCa0FHd0Fj?=
 =?us-ascii?Q?QUJmQUhRQVpRQmhBRzBBY3dCZkFHOEFiZ0JsQUdRQWNnQnBBSFlBWlFCZkFH?=
 =?us-ascii?Q?WUFhUUJzQUdVQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1VBYlFCaEFHa0FiQUJmQUdFQVpB?=
 =?us-ascii?Q?QmtBSElBWlFCekFITUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBR2dBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQWJRQmhBSElBZGdCbEFHd0FYd0J3QUhJQWJ3QnFBR1VBWXdC?=
 =?us-ascii?Q?MEFGOEFiZ0JoQUcwQVpRQnpBRjhBWXdCdkFHNEFaZ0JwQUdRQVpRQnVBSFFB?=
 =?us-ascii?Q?YVFCaEFHd0FYd0JoQUd3QWJ3QnVBR1VBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdF?=
 =?us-ascii?Q?QWNnQjJBR1VBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJs?=
 =?us-ascii?Q?QUhNQVh3QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBWVFCc0FHOEFi?=
 =?us-ascii?Q?Z0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBRjhB?=
 =?us-ascii?Q?Y0FCeUFHOEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUhJQVpRQnpB?=
 =?us-ascii?Q?SFFBY2dCcEFHTUFkQUJsQUdRQVh3Qm9BR1VBZUFCakFHOEFaQUJsQUhNQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBR0VBY2dCdEFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-rorf: true
x-dg-refthree: =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFBQUFBQUJBQUFBQUFB?=
 =?us-ascii?Q?QUFBSUFBQUFBQUo0QUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QVp3QnZBRzhB?=
 =?us-ascii?Q?WndCc0FHVUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FB?=
 =?us-ascii?Q?QUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J3QUhJQWJ3QnFBR1VBWXdCMEFGOEFZ?=
 =?us-ascii?Q?d0J2QUdRQVpRQnpBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFiUUJoQUhJQWRnQmxB?=
 =?us-ascii?Q?R3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCakFHOEFaQUJsQUhNQVh3?=
 =?us-ascii?Q?QmtBR2tBWXdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFB?=
 =?us-ascii?Q?QUFBQUFJQUFBQUFBSjRBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBY0FCeUFH?=
 =?us-ascii?Q?OEFhZ0JsQUdNQWRBQmZBRzRBWVFCdEFHVUFjd0JmQUdNQWJ3QnVBR1lBYVFC?=
 =?us-ascii?Q?a0FHVUFiZ0IwQUdrQVlRQnNBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5n?=
 =?us-ascii?Q?QUFBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4?=
 =?us-ascii?Q?QWJnQmhBRzBBWlFCekFGOEFZd0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJo?=
 =?us-ascii?Q?QUd3QVh3QnRBR0VBY2dCMkFHVUFiQUJzQUY4QWJ3QnlBRjhBWVFCeUFHMEFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
x-dg-reffour: =?us-ascii?Q?QUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQWJRQmhBSElBZGdCbEFHd0FiQUJmQUhBQWNnQnZBR29BWlFCakFI?=
 =?us-ascii?Q?UUFYd0J1QUdFQWJRQmxBSE1BWHdCakFHOEFiZ0JtQUdrQVpBQmxBRzRBZEFC?=
 =?us-ascii?Q?cEFHRUFiQUJmQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0J2QUhJQVh3Qm5BRzhB?=
 =?us-ascii?Q?YndCbkFHd0FaUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ0QUdFQWNn?=
 =?us-ascii?Q?QjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdV?=
 =?us-ascii?Q?QWN3QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdCdEFHRUFjZ0Iy?=
 =?us-ascii?Q?QUdVQWJBQnNBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHMEFZUUJ5QUhZQVpRQnNBR3dBWHdC?=
 =?us-ascii?Q?d0FISUFid0JxQUdVQVl3QjBBRjhBYmdCaEFHMEFaUUJ6QUY4QWNnQmxBSE1B?=
 =?us-ascii?Q?ZEFCeUFHa0FZd0IwQUdVQVpBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZB?=
 =?us-ascii?Q?SElBWHdCaEFISUFiUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSFFBWlFCeUFHMEFhUUJ1?=
 =?us-ascii?Q?QUhVQWN3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnRBR0VB?=
 =?us-ascii?Q?Y2dCMkFHVUFiQUJzQUY4QWR3QnZBSElBWkFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFPZ1lBQUFBQUFBQUlBQUFBQUFBQUFBZ0FB?=
 =?us-ascii?Q?QUFBQUFBQUNBQUFBQUFBQUFBYUJnQUFHUUFB?=
x-dg-reffive: =?us-ascii?Q?QUJnQUFBQUFBQUFBWVFCa0FHUUFjZ0JsQUhNQWN3QUFBQ1FBQUFBSUFBQUFZ?=
 =?us-ascii?Q?d0IxQUhNQWRBQnZBRzBBWHdCd0FHVUFjZ0J6QUc4QWJnQUFBQzRBQUFBQUFB?=
 =?us-ascii?Q?QUFZd0IxQUhNQWRBQnZBRzBBWHdCd0FHZ0Fid0J1QUdVQWJnQjFBRzBBWWdC?=
 =?us-ascii?Q?bEFISUFBQUF3QUFBQUFBQUFBR01BZFFCekFIUUFid0J0QUY4QWN3QnpBRzRB?=
 =?us-ascii?Q?WHdCa0FHRUFjd0JvQUY4QWRnQXdBRElBQUFBd0FBQUFBQUFBQUdNQWRRQnpB?=
 =?us-ascii?Q?SFFBYndCdEFGOEFjd0J6QUc0QVh3QnJBR1VBZVFCM0FHOEFjZ0JrQUhNQUFB?=
 =?us-ascii?Q?QStBQUFBQUFBQUFHTUFkUUJ6QUhRQWJ3QnRBRjhBY3dCekFHNEFYd0J1QUc4?=
 =?us-ascii?Q?QVpBQmxBR3dBYVFCdEFHa0FkQUJsQUhJQVh3QjJBREFBTWdBQUFESUFBQUFB?=
 =?us-ascii?Q?QUFBQVl3QjFBSE1BZEFCdkFHMEFYd0J6QUhNQWJnQmZBSE1BY0FCaEFHTUFa?=
 =?us-ascii?Q?UUJmQUhZQU1BQXlBQUFBUGdBQUFBQUFBQUJrQUd3QWNBQmZBSE1BYXdCNUFI?=
 =?us-ascii?Q?QUFaUUJmQUdNQWFBQmhBSFFBWHdCdEFHVUFjd0J6QUdFQVp3QmxBRjhBZGdB?=
 =?us-ascii?Q?d0FESUFBQUEyQUFBQUFBQUFBR1FBYkFCd0FGOEFjd0JzQUdFQVl3QnJBRjhB?=
 =?us-ascii?Q?WXdCb0FHRUFkQUJmQUcwQVpRQnpBSE1BWVFCbkFHVUFBQUE0QUFBQUFBQUFB?=
 =?us-ascii?Q?R1FBYkFCd0FGOEFkQUJsQUdFQWJRQnpBRjhBYndCdUFHVUFaQUJ5QUdrQWRn?=
 =?us-ascii?Q?QmxBRjhBWmdCcEFHd0FaUUFBQUNRQUFBQWFBQUFBWlFCdEFHRUFhUUJzQUY4?=
 =?us-ascii?Q?QVlRQmtBR1FBY2dCbEFITUFjd0FBQUZnQUFBQUFBQUFBYlFCaEFISUFkZ0Js?=
 =?us-ascii?Q?QUd3QVh3QndBSElBYndCcUFHVUFZd0IwQUY4QWJnQmhBRzBBWlFCekFGOEFZ?=
 =?us-ascii?Q?d0J2QUc0QVpnQnBBR1FBWlFCdUFIUUFhUUJoQUd3QVh3QmhBR3dBYndCdUFH?=
 =?us-ascii?Q?VUFBQUJVQUFBQUFBQUFBRzBBWVFCeUFIWUFaUUJzQUY4QWNBQnlBRzhBYWdC?=
 =?us-ascii?Q?bEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFISUFaUUJ6QUhRQWNnQnBBR01B?=
 =?us-ascii?Q?ZEFCbEFHUUFYd0JoQUd3QWJ3QnVBR1VBQUFCYUFBQUFBQUFBQUcwQVlRQnlB?=
 =?us-ascii?Q?SFlBWlFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHNEFZUUJ0QUdVQWN3?=
 =?us-ascii?Q?QmZBSElBWlFCekFIUUFjZ0JwQUdNQWRBQmxBR1FBWHdCb0FHVUFlQUJqQUc4?=
 =?us-ascii?Q?QVpBQmxBSE1BQUFBZ0FBQUFBUUFBQUcwQVlRQnlBSFlBWlFCc0FHd0FYd0Jo?=
 =?us-ascii?Q?QUhJQWJRQUFBQ1lBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFHY0Fi?=
 =?us-ascii?Q?d0J2QUdjQWJBQmxBQUFBTkFBQUFBQUFBQUJ0?=
x-dg-refsix: =?us-ascii?Q?QUdFQWNnQjJBR1VBYkFCc0FGOEFjQUJ5QUc4QWFnQmxBR01BZEFCZkFHTUFi?=
 =?us-ascii?Q?d0JrQUdVQWN3QUFBRDRBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFI?=
 =?us-ascii?Q?QUFjZ0J2QUdvQVpRQmpBSFFBWHdCakFHOEFaQUJsQUhNQVh3QmtBR2tBWXdC?=
 =?us-ascii?Q?MEFBQUFYZ0FBQUFBQUFBQnRBR0VBY2dCMkFHVUFiQUJzQUY4QWNBQnlBRzhB?=
 =?us-ascii?Q?YWdCbEFHTUFkQUJmQUc0QVlRQnRBR1VBY3dCZkFHTUFid0J1QUdZQWFRQmtB?=
 =?us-ascii?Q?R1VBYmdCMEFHa0FZUUJzQUY4QWJRQmhBSElBZGdCbEFHd0FiQUFBQUd3QUFB?=
 =?us-ascii?Q?QUJBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFHb0FaUUJqQUhR?=
 =?us-ascii?Q?QVh3QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFCbEFHNEFkQUJw?=
 =?us-ascii?Q?QUdFQWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElBWHdCaEFISUFi?=
 =?us-ascii?Q?UUFBQUhJQUFBQUFBQUFBYlFCaEFISUFkZ0JsQUd3QWJBQmZBSEFBY2dCdkFH?=
 =?us-ascii?Q?b0FaUUJqQUhRQVh3QnVBR0VBYlFCbEFITUFYd0JqQUc4QWJnQm1BR2tBWkFC?=
 =?us-ascii?Q?bEFHNEFkQUJwQUdFQWJBQmZBRzBBWVFCeUFIWUFaUUJzQUd3QVh3QnZBSElB?=
 =?us-ascii?Q?WHdCbkFHOEFid0JuQUd3QVpRQUFBRm9BQUFBQUFBQUFiUUJoQUhJQWRnQmxB?=
 =?us-ascii?Q?R3dBYkFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3?=
 =?us-ascii?Q?QnlBR1VBY3dCMEFISUFhUUJqQUhRQVpRQmtBRjhBYlFCaEFISUFkZ0JsQUd3?=
 =?us-ascii?Q?QWJBQUFBR2dBQUFBQUFBQUFiUUJoQUhJQWRnQmxBR3dBYkFCZkFIQUFjZ0J2?=
 =?us-ascii?Q?QUdvQVpRQmpBSFFBWHdCdUFHRUFiUUJsQUhNQVh3QnlBR1VBY3dCMEFISUFh?=
 =?us-ascii?Q?UUJqQUhRQVpRQmtBRjhBYlFCaEFISUFkZ0JsQUd3QWJBQmZBRzhBY2dCZkFH?=
 =?us-ascii?Q?RUFjZ0J0QUFBQUtnQUFBQUFBQUFCdEFHRUFjZ0IyQUdVQWJBQnNBRjhBZEFC?=
 =?us-ascii?Q?bEFISUFiUUJwQUc0QWRRQnpBQUFBSWdBQUFBQUFBQUJ0QUdFQWNnQjJBR1VB?=
 =?us-ascii?Q?YkFCc0FGOEFkd0J2QUhJQVpBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5084:EE_|PH8PR18MB5381:EE_
x-ms-office365-filtering-correlation-id: db3acc66-f748-4dbd-af35-08dbd9e50818
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /vQGL51AGdyf9z36M+aD38kmrQVb9oAVg9gon0nGuYq5MD4lUw+/mz85KnJsgEiZZZUjgJbIngXE1GG7gZ06EJLVY2MTVxk+P9NuKN/ax7OzEOaFFH2Ozcu4aHDBaYMoBrsAaSkdRFSOqAmkgNiE7KFqYCOQEDOsUtHxZm1G0pvG6K74I9LPfv0G7EzyDmAzrkDz+Ry8un3XAoGqNaFvftH5rbMsKkprj2fvJm7zgeuss3FA/0xMLyyWzEgQ5nOTSdm5WZPhqWWcN0/Lt4fISnEvUuJsZG7RFqzzuiRtQz+yvcio9pijjp2GDrmGnZcGf0JSqwcUCElZZcpDdhsXhQExKQp5VTsQnAFY8N9Z/zw0ROB/P+lGlYOxRUSe6as3p9JWqsvK1ly559jg3Ak4k/G1SJCMusXFcRcmy6WhM1zncfKaB40n4esMVvwVknvp13FpVKp0j4x24iC+xGilA9AksXOXQL8KtBzIxQhVM1TS2ptiGeyeeZ8JxAR3Sza8CsaLjKyczKsHECyx5fjiO0iLeyZ015GSDsV53UOkVztAwj8lstGrMhD8j0quZEWO9OHtnV4st8+pSO27Ez5241+7vJhpauBTvHgueNTqFpu7wwU+Aue/tox2D01R+bhxVOXg+D4rGvrZVxV73UHkHQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(230273577357003)(230173577357003)(186009)(451199024)(1800799009)(64100799003)(30864003)(2906002)(86362001)(33656002)(41300700001)(7416002)(8676002)(8936002)(4326008)(52536014)(5660300002)(38070700009)(110136005)(478600001)(966005)(55016003)(9686003)(122000001)(6506007)(38100700002)(7696005)(71200400001)(53546011)(316002)(64756008)(54906003)(66556008)(66446008)(66476007)(66946007)(26005)(76116006)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ekRDr3Y7qlSXtLPPw4xGzCLV0ZAkj0sVZ288TdN/IySLV35gyBNtd3nBWan?=
 =?us-ascii?Q?CJVuM9GIe3Hh+9ndA7sc7zV3Z61CdIkVOU56DS8JMQ20TKAklh3PhWQAydBC?=
 =?us-ascii?Q?7MewQ+8AGeQixJP3hYfT51jVI1K3ky+7Xv309RrdHZLKk0Wjs5fiBkwMDI6F?=
 =?us-ascii?Q?DNGNHXUqQBg/VPchN4fqENiQpJF3a28EPiWOZsoaTFuhwrYTWUYAli2p85Zl?=
 =?us-ascii?Q?X/IP/8eIWFoTLpv9b2xce1QkhOav2eb2+GoudDBP3h1KQj5AZn6M7XJXsbK3?=
 =?us-ascii?Q?5hjRFSJjbYbQ3gbFLFWIPqk/6e+P5Ec8487CTQCmJQLWxvfYc8qs5vQxyxp+?=
 =?us-ascii?Q?67RHfQuv63/bBrLbR1MrTY50uP0SD98XW69XfJ9a9NINiP5CKqxWp5CefG9c?=
 =?us-ascii?Q?FxW3fCRvQ5IdzliIHpl0XPRnU/pQs/RH4XXQrRMiR8badmTJsQ5cm2ZzJUcb?=
 =?us-ascii?Q?MEfLJ8ZblcR8a56W8QdHkOoCpGn4MIeLoIcI9MzeE8YJjiQMtuLqNofZy5NF?=
 =?us-ascii?Q?MU2KCUIcHlz4G1jvDiNQTjJJJXDuznEKM8VwC2cKHnnpjgqT7lESdv55OLm1?=
 =?us-ascii?Q?esScb9j4oTFW7dys9aIc8p9JMZgIq3F8NacWYlDVsksoJoJGoXfYRBWVyZyn?=
 =?us-ascii?Q?v9UNbIpUygRdGwYpmNBbhzkwhLYFDpegbYDkj53s379NNaGQ5DOZWDXUG1vM?=
 =?us-ascii?Q?giyGq/ZpD8RweD/rKDWR9oGMdGtcnfIW0XQe77Ry0XvHypoyc7OJpDC83nfF?=
 =?us-ascii?Q?Jao/iBCTuuM9TpL/5DVXfVI3Hn0CFwIXgkKyO2EEgaZItQLXz+Yy6M0qalWD?=
 =?us-ascii?Q?h2kzCZRCOWsF6KCfZzCTn9DYZ6301fRXIEyw4hkTd5eiLWxDdyvBKbrsvHZ/?=
 =?us-ascii?Q?7pJ0Aub+38reNghoIsLj8T6IGxYqtNBOv69kEpwD8O+Fc4fc4XvuwAdjgzeo?=
 =?us-ascii?Q?Otro++9OMstLCCCjsva/5t6H0eH2LsFmtfXoHay/NBjslIwspnrsB8cdbmLl?=
 =?us-ascii?Q?bxkFplMTCJxVD2WavbXoRUskYzSBhx5SlHEcebbTn9v9nutLACoQYISIkhjt?=
 =?us-ascii?Q?H3WNl1H0MD6jQPhn1C2GyBSHsJaz4DlHhm+JAQFapi4Oi7/8YeEM8lCBkCLb?=
 =?us-ascii?Q?NrjVk36fPoZFM55eZj1081KG2IYjRX/t6pJOwfGjkGlLQ+OlYdEI+PtKFwC5?=
 =?us-ascii?Q?GpVDWcwHW60Fy0O8mAKUYycJMq3S65B65sXxyUNmAJA96tgFF2GsgtNOh7G2?=
 =?us-ascii?Q?s0rNXJA9ILBh/vPshjWkQ/sameJLrpLe+YMEdsz3CuZhDV1S2MrUW1GFY+g5?=
 =?us-ascii?Q?dEIRQzCiE9lwmpm/x7xkNkcJB2j6dlQGoUFwtUgT71d2xBt0r0wrXfKJOu1W?=
 =?us-ascii?Q?djbKyI5AcdDdgnwDL43JIYrQB3w1ootZxql0hb+jhVYO6MUDLso+sFJ1PbhV?=
 =?us-ascii?Q?ewC24v+e1ZpRuHDIi8XCP9u3gRJ/iabdd+9xLr5BUGFiQR65eKg/xLY/6bvg?=
 =?us-ascii?Q?UWgcFOiibMgDms1M/5eQsRG8uqYUV8/I2QFmJfcDH0XtMB/GE7KhOpT8l4PL?=
 =?us-ascii?Q?2od8+N5H8HViEPe1CpYm9PhAmNU+oO7MhSImDNlQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3acc66-f748-4dbd-af35-08dbd9e50818
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 07:43:10.9460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQxhrG6B5A454cRJUkvxT7cloBCfl4x252FTejF3J1nDxztGJCWuudmw4Dt8bdS9Q2U3r8wN4rAQZMC+mjKy3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5381
X-Proofpoint-GUID: Fg6jbEbNDluGon2Ufwz5ytQtlxRA4UbA
X-Proofpoint-ORIG-GUID: Fg6jbEbNDluGon2Ufwz5ytQtlxRA4UbA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_03,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

-----Original Message-----
From: James Morse <james.morse@arm.com>=20
Sent: Wednesday, October 25, 2023 11:33 PM
To: x86@kernel.org; linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>; Reinette Chatre <reinette.chatre@int=
el.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.co=
m>; Borislav Petkov <bp@alien8.de>; H Peter Anvin <hpa@zytor.com>; Babu Mog=
er <Babu.Moger@amd.com>; James Morse <james.morse@arm.com>; shameerali.kolo=
thum.thodi@huawei.com; D Scott Phillips OS <scott@os.amperecomputing.com>; =
carl@os.amperecomputing.com; Linu Cherian <lcherian@marvell.com>; bobo.shao=
bowang@huawei.com; tan.shaopeng@fujitsu.com; baolin.wang@linux.alibaba.com;=
 Jamie Iles <quic_jiles@quicinc.com>; Xin Hao <xhao@linux.alibaba.com>; pet=
ernewman@google.com; dfustini@baylibre.com; Amit Singh Tomar <amitsinght@ma=
rvell.com>
Subject: [EXT] [PATCH v7 06/24] x86/resctrl: Access per-rmid structures by =
index

External Email

----------------------------------------------------------------------
x86 systems identify traffic using the CLOSID and RMID. The CLOSID is used =
to lookup the control policy, the RMID is used for monitoring. For
x86 these are independent numbers.
Arm's MPAM has equivalent features PARTID and PMG, where the PARTID is used=
 to lookup the control policy. The PMG in contrast is a small number of bit=
s that are used to subdivide PARTID when monitoring. The cache-occupancy mo=
nitors require the PARTID to be specified when monitoring.

This means MPAM's PMG field is not unique. There are multiple PMG-0, one pe=
r allocated CLOSID/PARTID. If PMG is treated as equivalent to RMID, it cann=
ot be allocated as an independent number. Bitmaps like rmid_busy_llc need t=
o be sized by the number of unique entries for this resource.

Treat the combined CLOSID and RMID as an index, and provide architecture he=
lpers to pack and unpack an index. This makes the MPAM values unique.
The domain's rmid_busy_llc and rmid_ptrs[] are then sized by index, as are =
domain mbm_local[] and mbm_total[].

x86 can ignore the CLOSID field when packing and unpacking an index, and re=
port as many indexes as RMID.

Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Tested-by: Peter Newman <peternewman@google.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v1:
 * Added X86_BAD_CLOSID macro to make it clear what this value means
 * Added second WARN_ON() for closid checking, and made both _ONCE()

Changes since v2:
 * Added RESCTRL_RESERVED_CLOSID
 * Removed a newline
 * Repharsed some comments
 * Renamed a variable 'ignore'd
 * Moved X86_RESCTRL_BAD_CLOSID to a previous patch

Changes since v3:
 * Changed a variable name
 * Fixed various typos

Changes since v4:
 * Removed resource parameter from has_busy_rmid()
 * Rewrote commit message

Changes since v5:
 * Used RESCTRL_RESERVED_RMID in clear_closid_rmid().
 * Added comment against free_rmid()s index comparison tricks.

Changes since v6:
 * Added a newline between some #includes.
 * Juggled some plurals in a comment.
---
 arch/x86/include/asm/resctrl.h         | 17 +++++
 arch/x86/kernel/cpu/resctrl/core.c     |  5 +-
 arch/x86/kernel/cpu/resctrl/internal.h |  4 +-  arch/x86/kernel/cpu/resctr=
l/monitor.c  | 96 ++++++++++++++++++--------  arch/x86/kernel/cpu/resctrl/r=
dtgroup.c |  9 +--
 5 files changed, 94 insertions(+), 37 deletions(-)

diff --git a/arch/x86/include/asm/resctrl.h b/arch/x86/include/asm/resctrl.=
h index cc6e1bce7b1a..db4c84dde2d5 100644
--- a/arch/x86/include/asm/resctrl.h
+++ b/arch/x86/include/asm/resctrl.h
@@ -101,6 +101,23 @@ static inline void resctrl_sched_in(struct task_struct=
 *tsk)
 		__resctrl_sched_in(tsk);
 }
=20
+static inline u32 resctrl_arch_system_num_rmid_idx(void)
+{
+	/* RMID are independent numbers for x86. num_rmid_idx =3D=3D num_rmid */
+	return boot_cpu_data.x86_cache_max_rmid + 1; }
+
+static inline void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid,=20
+u32 *rmid) {
+	*rmid =3D idx;
+	*closid =3D X86_RESCTRL_EMPTY_CLOSID;
+}
+
+static inline u32 resctrl_arch_rmid_idx_encode(u32 ignored, u32 rmid) {
+	return rmid;
+}
+
 void resctrl_cpu_detect(struct cpuinfo_x86 *c);
=20
 #else
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c
index 0056c9962a44..fc70a2650729 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -589,7 +589,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resou=
rce *r)
 			mbm_setup_overflow_handler(d, 0);
 		}
 		if (is_llc_occupancy_enabled() && cpu =3D=3D d->cqm_work_cpu &&
-		    has_busy_rmid(r, d)) {
+		    has_busy_rmid(d)) {
 			cancel_delayed_work(&d->cqm_limbo);
 			cqm_setup_limbo_handler(d, 0);
 		}
@@ -604,7 +604,8 @@ static void clear_closid_rmid(int cpu)
 	state->default_rmid =3D 0;
 	state->cur_closid =3D 0;
 	state->cur_rmid =3D 0;
-	wrmsr(MSR_IA32_PQR_ASSOC, 0, 0);
+	wrmsr(MSR_IA32_PQR_ASSOC, RESCTRL_RESERVED_RMID,
+	      RESCTRL_RESERVED_CLOSID);
 }
=20
 static int resctrl_online_cpu(unsigned int cpu) diff --git a/arch/x86/kern=
el/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c836e3294e12..97ec24f91ac4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -8,6 +8,8 @@
 #include <linux/fs_context.h>
 #include <linux/jump_label.h>
=20
+#include <asm/resctrl.h>
+
 #define L3_QOS_CDP_ENABLE		0x01ULL
=20
 #define L2_QOS_CDP_ENABLE		0x01ULL
@@ -560,7 +562,7 @@ void __init intel_rdt_mbm_apply_quirk(void);  bool is_m=
ba_sc(struct rdt_resource *r);  void cqm_setup_limbo_handler(struct rdt_dom=
ain *dom, unsigned long delay_ms);  void cqm_handle_limbo(struct work_struc=
t *work); -bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)=
;
+bool has_busy_rmid(struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);  void rdt_domai=
n_reconfigure_cdp(struct rdt_resource *r);  void __init thread_throttle_mod=
e_init(void); diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86=
/kernel/cpu/resctrl/monitor.c
index 2a0233cd0bc9..c02cf32cd17c 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -149,12 +149,29 @@ static inline u64 get_corrected_mbm_count(u32 rmid, u=
nsigned long val)
 	return val;
 }
=20
-static inline struct rmid_entry *__rmid_entry(u32 closid, u32 rmid)
+/*
+ * x86 and arm64 differ in their handling of monitoring.
+ * x86's RMID are independent numbers, there is only one source of=20
+traffic
+ * with an RMID value of '1'.
+ * arm64's PMG extends the PARTID/CLOSID space, there are multiple=20
+sources of
+ * traffic with a PMG value of '1', one for each CLOSID, meaning the=20
+RMID
+ * value is no longer unique.
+ * To account for this, resctrl uses an index. On x86 this is just the=20
+RMID,
+ * on arm64 it encodes the CLOSID and RMID. This gives a unique number.
+ *
+ * The domain's rmid_busy_llc and rmid_ptrs[] are sized by index. The=20
+arch code
+ * must accept an attempt to read every index.
+ */
+static inline struct rmid_entry *__rmid_entry(u32 idx)
 {
 	struct rmid_entry *entry;
+	u32 closid, rmid;
=20
-	entry =3D &rmid_ptrs[rmid];
-	WARN_ON(entry->rmid !=3D rmid);
+	entry =3D &rmid_ptrs[idx];
+	resctrl_arch_rmid_idx_decode(idx, &closid, &rmid);
+
+	WARN_ON_ONCE(entry->closid !=3D closid);
+	WARN_ON_ONCE(entry->rmid !=3D rmid);
=20
 	return entry;
 }
@@ -284,8 +301,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, stru=
ct rdt_domain *d,  void __check_limbo(struct rdt_domain *d, bool force_free=
)  {
 	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry;
-	u32 crmid =3D 1, nrmid;
+	u32 idx, cur_idx =3D 1;
 	bool rmid_dirty;
 	u64 val =3D 0;
=20
@@ -296,12 +314,11 @@ void __check_limbo(struct rdt_domain *d, bool force_f=
ree)
 	 * RMID and move it to the free list when the counter reaches 0.
 	 */
 	for (;;) {
-		nrmid =3D find_next_bit(d->rmid_busy_llc, r->num_rmid, crmid);
-		if (nrmid >=3D r->num_rmid)
+		idx =3D find_next_bit(d->rmid_busy_llc, idx_limit, cur_idx);
+		if (idx >=3D idx_limit)
 			break;
=20
-		entry =3D __rmid_entry(X86_RESCTRL_EMPTY_CLOSID, nrmid);// temporary
-
+		entry =3D __rmid_entry(idx);
 		if (resctrl_arch_rmid_read(r, d, entry->closid, entry->rmid,
 					   QOS_L3_OCCUP_EVENT_ID, &val)) {
 			rmid_dirty =3D true;
@@ -310,19 +327,21 @@ void __check_limbo(struct rdt_domain *d, bool force_f=
ree)
 		}
=20
 		if (force_free || !rmid_dirty) {
-			clear_bit(entry->rmid, d->rmid_busy_llc);
+			clear_bit(idx, d->rmid_busy_llc);
 			if (!--entry->busy) {
 				rmid_limbo_count--;
 				list_add_tail(&entry->list, &rmid_free_lru);
 			}
 		}
-		crmid =3D nrmid + 1;
+		cur_idx =3D idx + 1;
 	}
 }
=20
-bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d)
+bool has_busy_rmid(struct rdt_domain *d)
 {
-	return find_first_bit(d->rmid_busy_llc, r->num_rmid) !=3D r->num_rmid;
+	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
+
+	return find_first_bit(d->rmid_busy_llc, idx_limit) !=3D idx_limit;
 }
=20
 /*
@@ -352,6 +371,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 	struct rdt_domain *d;
 	int cpu, err;
 	u64 val =3D 0;
+	u32 idx;
+
+	idx =3D resctrl_arch_rmid_idx_encode(entry->closid, entry->rmid);
=20
 	entry->busy =3D 0;
 	cpu =3D get_cpu();
@@ -369,9 +391,9 @@ static void add_rmid_to_limbo(struct rmid_entry *entry)
 		 * For the first limbo RMID in the domain,
 		 * setup up the limbo worker.
 		 */
-		if (!has_busy_rmid(r, d))
+		if (!has_busy_rmid(d))
 			cqm_setup_limbo_handler(d, CQM_LIMBOCHECK_INTERVAL);
-		set_bit(entry->rmid, d->rmid_busy_llc);
+		set_bit(idx, d->rmid_busy_llc);
 		entry->busy++;
 	}
 	put_cpu();
@@ -384,14 +406,21 @@ static void add_rmid_to_limbo(struct rmid_entry *entr=
y)
=20
 void free_rmid(u32 closid, u32 rmid)
 {
+	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
 	struct rmid_entry *entry;
=20
-	if (!rmid)
-		return;
-
 	lockdep_assert_held(&rdtgroup_mutex);
=20
-	entry =3D __rmid_entry(closid, rmid);
+	/*
+	 * Do not allow the default rmid to be free'd. Comparing by index
+	 * allows architectures that ignore the closid parameter to avoid an
+	 * unnecessary check.
+	 */
+	if (idx =3D=3D resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
+						RESCTRL_RESERVED_RMID))
+		return;
+
+	entry =3D __rmid_entry(idx);
=20
 	if (is_llc_occupancy_enabled())
 		add_rmid_to_limbo(entry);
@@ -402,11 +431,13 @@ void free_rmid(u32 closid, u32 rmid)  static struct m=
bm_state *get_mbm_state(struct rdt_domain *d, u32 closid,
 				       u32 rmid, enum resctrl_event_id evtid)  {
+	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
+
 	switch (evtid) {
 	case QOS_L3_MBM_TOTAL_EVENT_ID:
-		return &d->mbm_total[rmid];
+		return &d->mbm_total[idx];
 	case QOS_L3_MBM_LOCAL_EVENT_ID:
-		return &d->mbm_local[rmid];
+		return &d->mbm_local[idx];
 	default:
 		return NULL;
 	}
@@ -449,7 +480,8 @@ static int __mon_event_count(u32 closid, u32 rmid, stru=
ct rmid_read *rr)
  */
 static void mbm_bw_count(u32 closid, u32 rmid, struct rmid_read *rr)  {
-	struct mbm_state *m =3D &rr->d->mbm_local[rmid];
+	u32 idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
+	struct mbm_state *m =3D &rr->d->mbm_local[idx];
 	u64 cur_bw, bytes, cur_bytes;
=20
 	cur_bytes =3D rr->val;
@@ -539,7 +571,7 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct=
 rdt_domain *dom_mbm)  {
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
-	u32 cur_bw, delta_bw, user_bw;
+	u32 cur_bw, delta_bw, user_bw, idx;
 	struct rdt_resource *r_mba;
 	struct rdt_domain *dom_mba;
 	struct list_head *head;
@@ -552,7 +584,8 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct=
 rdt_domain *dom_mbm)
=20
 	closid =3D rgrp->closid;
 	rmid =3D rgrp->mon.rmid;
-	pmbm_data =3D &dom_mbm->mbm_local[rmid];
+	idx =3D resctrl_arch_rmid_idx_encode(closid, rmid);
+	pmbm_data =3D &dom_mbm->mbm_local[idx];
=20
 	dom_mba =3D get_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
@@ -670,7 +703,7 @@ void cqm_handle_limbo(struct work_struct *work)
=20
 	__check_limbo(d, false);
=20
-	if (has_busy_rmid(r, d))
+	if (has_busy_rmid(d))
 		schedule_delayed_work_on(cpu, &d->cqm_limbo, delay);
=20
 	mutex_unlock(&rdtgroup_mutex);
@@ -735,19 +768,20 @@ void mbm_setup_overflow_handler(struct rdt_domain *do=
m, unsigned long delay_ms)
=20
 static int dom_data_init(struct rdt_resource *r)  {
+	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
 	struct rmid_entry *entry =3D NULL;
-	int i, nr_rmids;
+	u32 idx;
+	int i;
=20
-	nr_rmids =3D r->num_rmid;
-	rmid_ptrs =3D kcalloc(nr_rmids, sizeof(struct rmid_entry), GFP_KERNEL);
+	rmid_ptrs =3D kcalloc(idx_limit, sizeof(struct rmid_entry), GFP_KERNEL);

[>>] Is there a chance, it could result in "ZERO_SIZE_PTR", and we should g=
uard it against ZERO_OR_NULL_PTR in the following if condition?
        It might be related, while testing the snapshot[1] (and subsequent =
snapshots has similar change) on x86 platform, Zahid is seeing Kernel panic=
:
        https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tre=
e/fs/resctrl/monitor.c?h=3Dmpam/snapshot/v6.2#n695

 	if (!rmid_ptrs)
 		return -ENOMEM;
=20
-	for (i =3D 0; i < nr_rmids; i++) {
+	for (i =3D 0; i < idx_limit; i++) {
 		entry =3D &rmid_ptrs[i];
 		INIT_LIST_HEAD(&entry->list);
=20
-		entry->rmid =3D i;
+		resctrl_arch_rmid_idx_decode(i, &entry->closid, &entry->rmid);
 		list_add_tail(&entry->list, &rmid_free_lru);
 	}
=20
@@ -755,7 +789,9 @@ static int dom_data_init(struct rdt_resource *r)
 	* These are used for rdtgroup_default control group, which will be
 	* setup later in rdtgroup_init().
 	*/
-	entry =3D __rmid_entry(RESCTRL_RESERVED_CLOSID, RESCTRL_RESERVED_RMID);
+	idx =3D resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
+					   RESCTRL_RESERVED_RMID);
+	entry =3D __rmid_entry(idx);
 	list_del(&entry->list);
=20
 	return 0;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/r=
esctrl/rdtgroup.c
index f64c13fe22d7..22dbdfe569a1 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3894,7 +3894,7 @@ void resctrl_offline_domain(struct rdt_resource *r, s=
truct rdt_domain *d)
=20
 	if (is_mbm_enabled())
 		cancel_delayed_work(&d->mbm_over);
-	if (is_llc_occupancy_enabled() && has_busy_rmid(r, d)) {
+	if (is_llc_occupancy_enabled() && has_busy_rmid(d)) {
 		/*
 		 * When a package is going down, forcefully
 		 * decrement rmid->ebusy. There is no way to know @@ -3912,16 +3912,17 @=
@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
=20
 static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domai=
n *d)  {
+	u32 idx_limit =3D resctrl_arch_system_num_rmid_idx();
 	size_t tsize;
=20
 	if (is_llc_occupancy_enabled()) {
-		d->rmid_busy_llc =3D bitmap_zalloc(r->num_rmid, GFP_KERNEL);
+		d->rmid_busy_llc =3D bitmap_zalloc(idx_limit, GFP_KERNEL);
 		if (!d->rmid_busy_llc)
 			return -ENOMEM;
 	}
 	if (is_mbm_total_enabled()) {
 		tsize =3D sizeof(*d->mbm_total);
-		d->mbm_total =3D kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		d->mbm_total =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_total) {
 			bitmap_free(d->rmid_busy_llc);
 			return -ENOMEM;
@@ -3929,7 +3930,7 @@ static int domain_setup_mon_state(struct rdt_resource=
 *r, struct rdt_domain *d)
 	}
 	if (is_mbm_local_enabled()) {
 		tsize =3D sizeof(*d->mbm_local);
-		d->mbm_local =3D kcalloc(r->num_rmid, tsize, GFP_KERNEL);
+		d->mbm_local =3D kcalloc(idx_limit, tsize, GFP_KERNEL);
 		if (!d->mbm_local) {
 			bitmap_free(d->rmid_busy_llc);
 			kfree(d->mbm_total);
--
2.39.2

