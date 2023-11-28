Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265EC7FC355
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346093AbjK1SeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234863AbjK1SeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:34:00 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C245B7;
        Tue, 28 Nov 2023 10:34:06 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHxGuB022216;
        Tue, 28 Nov 2023 18:33:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+ImlGaqUzzrfOnrfVusH4AjbK/E1C76Roq2QEw8gbUo=;
 b=iJGInZfbgZRhnlVL5T/XRwOBrGdtACVYE+KmVW8PvcNQl3vyjdIZMzEIeqEIxMxVyYrj
 EhPsTjwQ9FQoOtMKpds/WSF46QNLu3QTjXJeJOB08dGxB3qoVFLGbFOhOZ+YCJ4mudYj
 PkCis0WZwU7xHaGUP5zlyQLHl6/ewIdXLC5BDtbY7d2gna+UbcodFN1qgwDWrUWUnOrN
 9wEDklyIC8RokiEoWSRcsyml4cgKpGN7emyJCjh903HX5DS0apW8J+FyJBoLRXvnwQYd
 iBDIvTD0ykJeY3Q0LTfRneTfn/xpGq38CYiUzKjx0pAdDV9AQ+9grgMKfyGv7IpgB4QE mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk7q46my9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 18:33:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3ASHV6jf009292;
        Tue, 28 Nov 2023 18:33:52 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7c73b1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Nov 2023 18:33:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/LAYWfCYBe3MZwAVAHL0cbLFb6Q39n7YfRIh9Ru6IoGFo0L1WlAfUEALxWNNqSq9yhCmnAjeKW3jHuAeKxiPvelHgMOrxHtSpQJpJEBWEZYzzrkUd/zdaPhN+wLEv6bf16eHTlVi2V4oLKyv+SbyZOEoj9GuHGqDDs9zsgRyIJ4g6QFQddgL/YQlFgTcJ1YP0QBp3zB81LtTwb9G01Y53NslKI0FOMdOBAOKSzfN8AEbfByjNrB6xE9aTENcZ0hzZhhUMnWJNZk6XoEOt885OP51//7gkfjdbfscpXMuHTkv78VF4Z/SWKKCoSTl0B41b+qYsN5jJg1rze+rCSxnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ImlGaqUzzrfOnrfVusH4AjbK/E1C76Roq2QEw8gbUo=;
 b=KvKFn741np7KYdY4Zcq/6z6+HP4EO2x6BLwM6D7cKsFQjAKlMjAvxCxbG4uTIAnEQDc3Ntdwp7SyXjGLcGaebgHep5JQx0LlYtts3YKt8TSXFcKNVixFPvWjwCbxDdac4w9212zUZV+pzoT2JJb97ffHCwjpCnPHPthdJVdxtu2WNxfW4nKdbcOh8GLKvEjZSX7TNUBR7WS5nYl8mdZb4fNarNKpvX6cf43sfBoqGoJXJl6F9O0Qgci2xcNe87n3r4WNy4+JCY54EiYj0j2pFyfRwVPdBHyvMeQ/wkoXmcCkFr/md9cp+Up123ly3xMe27Tkn0Yy7gXFOJHkqqsC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ImlGaqUzzrfOnrfVusH4AjbK/E1C76Roq2QEw8gbUo=;
 b=jl4puvDSXM1rcuC4XnEXtrvWjI0jEDlnY0IRwLT02wcqUfT8jJ1CtZN2neKE+/l5FpGwiXRvAi9MJS7+2CRzG/LPGbEqXFY2sa9xuIV8SiOHxs99fl+/5KuRN9nXYHCClpoFO//hqtIu6LViKNvVCICS3JjFtWY/DJa9UC3QssM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by IA1PR10MB7286.namprd10.prod.outlook.com (2603:10b6:208:3ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 18:33:49 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 18:33:49 +0000
Message-ID: <4b715de8-f815-4768-a817-f558ae375955@oracle.com>
Date:   Wed, 29 Nov 2023 00:03:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/sysfs: Fix calling kobj_put() with
 ->state_initialized unset
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20231127072558.2999920-1-harshit.m.mogalapalli@oracle.com>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231127072558.2999920-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0041.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|IA1PR10MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: c7779ab4-1e7b-46de-6fd6-08dbf0409034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 89eSlZ6dA6qkKXKAxOg6uF0D/IAsfTSYj4k3iSfHc6wCIs2f6qH8b7zI25wDrmMNOHGEJtXyu5a9ivBYbxYX/hQTyVh3wEcUT2s/mLK350qtQZ1af6KUQvYHEErF6In9fhGWJZgBwqZvB+mjntPs4tuc7oZCf3tSLwrmdlj1NchZJYhd5IBUJyz8vRrcxFTQ+xunasaMWAnz8fwaC5gw0hFspxQr1mwkecD5S1DH/7EazDVWqRIABZhW4sy92wFozgTfesl6G2eOndSNtidkrKEa2DNEDz6s4/j9V8YFbn0JyzUYT+SoAVB5mKoXpvImk37n1K78lor0uWPxnSVpPJR/ZUUZQgxYV0E+p9CJ6zfhRu7dOYIFDll/45t1KbQDaBEuAg2Mul0iFRW+Dj2zE/aVf5kmx8sM5m16lYILx4/daHmsEcvDMZFZDBd1WUVUBlOp2zd8ryX1YBTjRtRYqikVRgwqiB6zCUcXfXo7khMxZAH7tWR8JLYieFMb+2HG6d+b2jr2a51IFFr6Tds5m4TZhTIwVeakWWRKfYvYQzRc53p0ThuaQQ24jjTNxftYbedd5b931qqwJ4iBEC/oVFmRE5Gc/8nzYBnstMwKTirtc0/0yGe1Ev8AOrlSi9RQgxjVTnLAG2lxA80/DXX5ZDRiRVbE+6XGYL7W9Qcbu5FHuUowGDQpjcVsUaar4woZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(26005)(6506007)(6666004)(6512007)(53546011)(8676002)(8936002)(4326008)(6486002)(110136005)(86362001)(478600001)(2906002)(966005)(5660300002)(31696002)(316002)(66946007)(66476007)(66556008)(38100700002)(83380400001)(31686004)(7416002)(41300700001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0FXQ1h4Ti92UXdCV3krQk1GSVJlV01iaUxMSHFmdHdTVVdoakE4S1NpVVZx?=
 =?utf-8?B?b3BIQlJBdVErNDJ1V29kdExsMTBaQU5XK2pOMng1dlh1VDdjdHpYV1lMc1dh?=
 =?utf-8?B?czluQXVDaDdseWh2STcrMkpGM1RuMnJhbng4REM0RzA0WWZ3Nm1RdXQzYWlU?=
 =?utf-8?B?eE5sQndjbXpEQXNJYUlvbW9vOEp6ckxPTG5lM2pFTzhZZ0QycG5GV0NYWEJ0?=
 =?utf-8?B?Wm1DbENXZWFCeElkRVJmSEZ1bm10Vy9UQ0JVSFVOTWU4aEJUN256cEowTHNo?=
 =?utf-8?B?YzZoRmJLNUFuUEwvS2UwZ0o4NkwrTWZsZkwwWXVReVZiTDVONnd5M09meFVZ?=
 =?utf-8?B?OTJDb2VuOXIwWTgvMk5RTnFzV3d3L2I4RmFJSnhPZW1ZSGZoYzVUb1M5SjBl?=
 =?utf-8?B?OGdudTdJaVpoam9tVEpnZzZoejdnWjQ2aC9FQkNpdjFyMzBkYm4vSnJZeE1u?=
 =?utf-8?B?MHViemZ5MkM0amR1U1Z6UUVCUGxFL090dE1mOThYMzRSSXNnb2Qwd3lZUVpE?=
 =?utf-8?B?RUNXYVB5UXY3SlhpRG9MTFZOcG11U0xrbXp1VGYrYXhZYkFEbUVnaHltTGcz?=
 =?utf-8?B?bzlpQVdOWnlrYTdlWVJicUNjWXdhalpuOUZ6dDJYUTFITjlKOG4yVzFHWmla?=
 =?utf-8?B?YmtOYVdsclk0c1dDeTRodWNCYlVVNGUyVG1VL1hVVUZtMzZTR3BKcURKb284?=
 =?utf-8?B?a2RydVEzc21EUzNCakZhRWRaNDdhejhVQjN5L3AwWEFhQithNUtINXFIdURJ?=
 =?utf-8?B?U0Z4VGNPREpTOGRtenNLYzhFRVZpWVBvQmJubkt2clhPa1NxVC9YbDJMZ09u?=
 =?utf-8?B?ZkkzRW8wSFhLa2JqeEhSUC9NYzQwd3RpUWFyQ004WjEyYWJuTFJIS3ZOWDFU?=
 =?utf-8?B?UDVyRitPYUZEdXpKNVVRbXdwM1hOc2ZzN0pEU1R2QWhMVllaZHJhdGxVdzZZ?=
 =?utf-8?B?bXNxbzkrcTFvS1ZZMlZ4V1RxZ0hyUE5FdTR6ZUFxRU04V29TQWprV3RjdjVL?=
 =?utf-8?B?aCtLQWlLMHhTaVd1aHJnT3AvcVJIdEk1RHdvaVU1ejhVRWxkSHk3R1F0SERB?=
 =?utf-8?B?ZXJqb2RJYXVhaHA5ZUs5SUdQNDZFc2JWeWFLcUp6bDB1OWMraWpJVENXMmtP?=
 =?utf-8?B?OHhlYnh2MEZhVlkvU3d2dEZtUWZadmFETit1eEZkYTNuZkRqb1NmekFRcnRl?=
 =?utf-8?B?MjBBazVzV3BSWFJJRnBicExVeTRXNEFkWWVDNHkrNGU1TEpwT2NETjA5NVpE?=
 =?utf-8?B?cXl0L2U2TGR3WEI0eFVCcnZDMXFiQkpPMlZZblBCczZvZ1E2MkZiQ0piR0Nv?=
 =?utf-8?B?VkZjWkxiUDM0c0lyM3BpSFpMSEpWSEVrNE96NjFCQk1JNGV1dG5VVHZqRGhK?=
 =?utf-8?B?WkFOZ09rUk93TG5kelUyK2poY1JxUUpLK3BvQzc0NFRZRWljQ1pCQTA5a3BI?=
 =?utf-8?B?elVTNWNNMzBuR0hobEw3QVRBczRTQUdrc3dVV3QvM0ZIZER0UTNuMnJlK0gv?=
 =?utf-8?B?KzdqTlFOVEhRaE5ZYzl5TXZvdytsMFY0TlhoM1NmNTdIbHJ2TThxU1VST2F4?=
 =?utf-8?B?RXRvVXNsQUtTWVhZZ3lUOFFhd040VjhILzJyaWluTG5XMHlsQlJFeWVQVlBp?=
 =?utf-8?B?Y1RKVGRqZzZjbVpiU0RpdVhCQWoxM0J0Zy9kd2tBNTVhSTBPVC9CUzdIV1V4?=
 =?utf-8?B?QXdxTFpBOHkxay8vdFd6aEV6WWdsa3haNTdYc3VOK29EL3hHYjFIS3pqQlll?=
 =?utf-8?B?K3o4RXR3bWEwWXUvTzlGcHZGY1BhQ3U0RlQxZVpxNGQxbXYzY0VGSjVrT2FT?=
 =?utf-8?B?MHhhMWxjNDdaOEZhaC9Md0V2TmRCMjcrTHQwbkZHTG5xa05UTVprdnJZWElX?=
 =?utf-8?B?VENQcjRoZzYxQ2IrQXBLNU5tK0tOMUh0YXR2Y2tIMkRpY0tLekIzRDJHVlNr?=
 =?utf-8?B?NWJ3MWZaajRURm5MSHBUWGxPNm9rWCtzRHdES2k3Q3JDWGRJK1phenhwU1ZP?=
 =?utf-8?B?VVQxSmFieGY4cTNjQ1dLdGJ3ejZTSUhtdUkyY25tYmc2SGM3TEVpM3llejd6?=
 =?utf-8?B?aktncms1UTIxdW1rZDFOTEFJZmNlTDNtc1RzbCtBUFpFZ1BEMXpOQitXaVA2?=
 =?utf-8?B?WFM3c2JQQnd3cHpNak44SmlkbkF4eE5Wa0tGdElKUjdUQ2xFQTl4clpjTCtF?=
 =?utf-8?Q?a8wnjlW6qCwSP+QX+5MoSWY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eHhMMCtqcFVEc3A3emJtN2pnbEozZVVyVUF1UUMxYVNWY3VlcFJtZXFhenRv?=
 =?utf-8?B?WHp5SThVQ2JEVkZ3ZXYrSTYxWmt6OStaTnBkdmE2ZitlSTQ5NlNKMElUVEs3?=
 =?utf-8?B?MWh3Vm9OakVTSEpHdnp4MnpuMkEwVXVKRmtiMzdFcHZISCt4YjZDd2d6dEpo?=
 =?utf-8?B?NEV5WCswNDNBNXFCVWQyR1JsYzE2dDZndmFLeUZ1VFYwNXh1REw3bGhuOFNt?=
 =?utf-8?B?NTE0c2ppbkVkTmdHTUpncGpPTGZvRGwwZFhFQ1grby9pZjRIZXZBMTJPUGdF?=
 =?utf-8?B?ajFabkJzS3pmbVBoYkNCLzdYRC9QNjJUSWp1eEtTUHYwSVo2U0VIYll3dXQ1?=
 =?utf-8?B?QzNadDFwWlk2NzEvSFIvZjB6dnlVejF2eVdLOWNRN2doQVk0SW8vdEdIR0pR?=
 =?utf-8?B?VW8zVndBUGhXTlhqTHRnOWFGOVBJdUtBQm8ybGUxbHZ3U0NzbnR2U2NialMx?=
 =?utf-8?B?T3J6Y3VnNEtPTjYxb05NcW16RkhCRHd3dTlBNUdFN2dFS3hkMWg2VG5HeC9o?=
 =?utf-8?B?eTRsSlA4VVR0UlhxZDZXQVNlQUZZc2tLWEpGU2lQeDg2anlrckNTTnRrbDhp?=
 =?utf-8?B?a0Z6Mk9xdHJScml1dy9XcjUzSVptY1FJZGZ0QnRYc21WVmF2WExIcXpjY3JQ?=
 =?utf-8?B?LzJSeWx5YlNlUHBkcFIwNWFtbjlKamdqc2JFc3Iva0YvWFg1MUVGRTJUY2tl?=
 =?utf-8?B?Q2JVbFlaNlRzMHVGNjV5c0RuVDk2c2hDMXNPU1VmRk04TG1RUWVyb2ZESWRp?=
 =?utf-8?B?b0NPaGJpamdSTHp3MldMZXFUZVV0d2ZSU3JJRG9TUlZRcENMbFRuZmtwOXBz?=
 =?utf-8?B?L0tDSnZBMHB1U1U5VEIxT2NWeVhGSTFNWjRHbXczNG9pbk0yYnZ6MXNYYjRu?=
 =?utf-8?B?R3hjR2JvaUVNWjBlNkdpYjREa1pMWkx6Zmh6WEdocWQwQ3BOZGs4dGFFMzF2?=
 =?utf-8?B?ZzFQRTE2NlpuVGh3eVBqc3FLZGtjcHArNlJISEJXK0tHYUhlbVV2M1c3dXFY?=
 =?utf-8?B?UDFYbkJDU3VJalMrZjIzOU9xRU5HTkNOKys2bjVCUHNKUW5nTHVvQ0MrTDlk?=
 =?utf-8?B?UGdQWTgreDlHNUVTL01LbVFjZXhQZ09CMjFPR2hTY3VIOWhZdFpCanQxREtw?=
 =?utf-8?B?ZTcxTjIyL3pUWGZzYkcvdlMzcFFOekYwMklXSGVoSlNXNDE2U2IxS0Q2a1B0?=
 =?utf-8?B?bWhwRXZIc3ZoYXlxZm5qRSswWU1MdTBHQzV2R3JVa0NsaWE4OHV0Nmw5TWF4?=
 =?utf-8?B?S015SkwyUTYrSWQ1cnhuODFCMTZNcnB2R1NvNTNLT0JSTjFIYVRFRDFIWHlR?=
 =?utf-8?Q?/V9V0aoR1tpTI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7779ab4-1e7b-46de-6fd6-08dbf0409034
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 18:33:49.5764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vQas2srM8+hdSq4O/Cvt12SX0ZffbMey0Qq1rkAwgbeXsBeUfFVlC+ykNSAIdS5t6QZaRRzlS88g3frEGqYuS4OnxMv5nOFvOO7AGuT/74mPouR7mnR/cI0syNiCnc4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-28_21,2023-11-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311280148
X-Proofpoint-ORIG-GUID: qnO4o9NV645PYViXHonGZlC_SylId2gE
X-Proofpoint-GUID: qnO4o9NV645PYViXHonGZlC_SylId2gE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/11/23 12:55 pm, Harshit Mogalapalli wrote:
> In edac_device_register_sysfs_main_kobj(), when dev_root is NULL,
> kobject_init_and_add() is not called.
> 
> 	if (err) { // err = -ENODEV
> 		edac_dbg(1, "Failed to register '.../edac/%s'\n",
> 	                 edac_dev->name);
> 		goto err_kobj_reg; // This calls kobj_put()
> 	}
> 
> This will cause a runtime warning in kobject_put() if the above happens.
> Warning:
> "kobject: '%s' (%p): is not initialized, yet kobject_put() is being called."
> 
> Fix the error handling to avoid the above possible situation.
> 
> Fixes: cb4a0bec0bb9 ("EDAC/sysfs: move to use bus_get_dev_root()")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---

I have sent a v2 as a patch series fixing two very similar bugs:

https://lore.kernel.org/all/20231128183037.3395755-1-harshit.m.mogalapalli@oracle.com/

> This is only compile tested and based on static analysis with Smatch.
> ---
>   drivers/edac/edac_device_sysfs.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
> index 010c26be5846..4cac14cbdb60 100644
> --- a/drivers/edac/edac_device_sysfs.c
> +++ b/drivers/edac/edac_device_sysfs.c
> @@ -253,11 +253,13 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
>   
>   	/* register */
>   	dev_root = bus_get_dev_root(edac_subsys);
> -	if (dev_root) {
> -		err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
> -					   &dev_root->kobj, "%s", edac_dev->name);
> -		put_device(dev_root);
> -	}
> +	if (!dev_root)
> +		goto module_put;
> +
> +	err = kobject_init_and_add(&edac_dev->kobj, &ktype_device_ctrl,
> +				   &dev_root->kobj, "%s", edac_dev->name);
> +	put_device(dev_root);
> +
>   	if (err) {
>   		edac_dbg(1, "Failed to register '.../edac/%s'\n",
>   			 edac_dev->name);
> @@ -276,8 +278,8 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
>   	/* Error exit stack */
>   err_kobj_reg:
>   	kobject_put(&edac_dev->kobj);
> +module_put:
>   	module_put(edac_dev->owner);
> -
>   err_out:
>   	return err;
>   }

