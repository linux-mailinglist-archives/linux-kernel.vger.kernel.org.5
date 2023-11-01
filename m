Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7067DE41A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343683AbjKAPpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjKAPp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:45:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3C11D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 08:45:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1AuCdr012993;
        Wed, 1 Nov 2023 15:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=xtXlM0L7vKgZKz21BUlTsmGLPK0/xlYBB3fFcru6Luo=;
 b=rNBFC7r1+XWtzBgI5ICw9KgmYfXquaOynxQ+N5VJ223+UILfr4XmFPQaZm1hwlgECaNQ
 NTLgK2a9qgEkwuOlRRSLxdHn7JSC5fE8qXJXM4a+blhFWNM/QUSiS3O6USJFIg+YaW5c
 L04kvi86EJGj7YpjOqwIlH2DkglvzWnwPAS7HhqdvCsJg3gCmUGJiHyUJpGFO7SpVXpF
 DvfsTeibyG4wJ7nkGNG9am/eFjnwrTp8Ry6jpGmc+y4IDb2nek3NrgpejUo32dlkZCXG
 KvLi2y1pz+BRR8DPSmzLyYlSNUnciYb66nUJjtVYT4yWJuWkhVnzcxZ6pLEhp2sBDMTR mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0s33yw9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 15:45:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1FUPXn001029;
        Wed, 1 Nov 2023 15:45:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rr7jfmp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Nov 2023 15:45:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BtxpCtQXaN2aqK6Q/wG5d26zQPMCuBdI5Oh1RmoM7foG7OQ48QE6DBHbGhHww/517KhaOKFMYhi9TGm5M+uLc+lNWX5lF9vnZ9eFq/ZgYhFS9eKVd6ZE6LpsJJ525EuAMTQu9BD58x+WA1MjUyqVUwvfJKh3OGbYFy8u/udgNJe9ncJWKC3LYj/FL7r+2FEigMGEWwJTqfsvE4wbH1z9F/JJuFNT6XR7N99UwxfXozd3CLZbqFHwWX8dFIVoVIKVLpsmW8OO92t5UApLyJ94yDkvt/wiiKn+O0iyTUOdyslzLil94djDNfCgEp2Am1I777ZY76kpWcs3n0uXjq6L/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtXlM0L7vKgZKz21BUlTsmGLPK0/xlYBB3fFcru6Luo=;
 b=laPeWmAG8Ekrn0V0x6CIQQPTajOkLvP/ZQ2HKh1NY+dxZniLMAJU7qqMfpypGYs0wyKbducSud2cZ/OqOJiCXsjAWyVM8Qo68BrqhMA0DOAPn5mPWfavgyehkm2hi3t53UVsKzsrVBCQfPxDtgiSnbhysl2FzgjFanUOagPqSMWkpCMg5RAZrwt0bVcSlbPT/MaYH72MYwPJw/xDRAiT+jwtFc9k/4cIy3bLbahojz7zzpIT/8EcUNLFPve0uK+Qh/ACxDj9PTFlloOVPYlzmlYt7khabrHNuY6rN4T7mg/OBnxd3mHeT/rm5MA14XOrLWMITKmZYWkzGfRPIz5uFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtXlM0L7vKgZKz21BUlTsmGLPK0/xlYBB3fFcru6Luo=;
 b=CzwilG+4OP5/BiaAxTUcV1Q4zw1rV0pBthwRj2y7xS3N2Wo8orePQZNzjZCkSpcQeQpvSJt8Pja+kmRkSTMWaPjJWI9N4FUwyEu0KN+HdHuunvoIsQWlXGqnzWaX+aRXDMoLxNi54XQ9Bv+Hx44MfN1b5Nc2aqep12KXcmOF6EU=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SA2PR10MB4794.namprd10.prod.outlook.com (2603:10b6:806:113::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Wed, 1 Nov
 2023 15:45:00 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a946:abb:59d6:e435%4]) with mapi id 15.20.6933.022; Wed, 1 Nov 2023
 15:44:59 +0000
Message-ID: <f712f111-bbad-4032-beca-eb9f4b5c3da6@oracle.com>
Date:   Wed, 1 Nov 2023 10:44:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in dbAdjTree
Content-Language: en-US
To:     Manas Ghandat <ghandatmanas@gmail.com>
Cc:     Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com
References: <20231017120356.55322-1-ghandatmanas@gmail.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20231017120356.55322-1-ghandatmanas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:610:1f1::24) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SA2PR10MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: e7545b7c-4fad-4f24-93b6-08dbdaf18152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EXmT6iMrwKWiodHpmy/q+UTWmJw9rw0O/Uit3zQ3e4MnP77Ly0QF9utZTVqTb6fu6sVHYYDnpzMkfmAOwbkPd/Ewowc89UJvckDbAyACNqdqnUgPwQet1pFKDVQruUQNBS3dKDblPDW3Y+pGU7/Yisx3by/KV+Ei+3GBmpddhsULBFl8TnsoWVoMP0rFK5dPOXtfC9agESyhsT5jF4TCyVoMIqcNw0yV2Hvf7CpBHDkyo/BMt1tVqg7NdunfOHs5vJP0iXaDkkUqXHV7UIhW/9WaFMv4Oi+77JR2ZUqkYBXH5cNnAbruY0ehJ9FI3s8zjUfj+VCxQ7+LlNnNUuzcvszCbhs8wiDzgKQq9jPBGMRU5IYJfGN65teAMa4r4pqJoAZMEh7KqanXra/vayHeqdJ3dp+XSO4lgcMYQyXozroVTT2qCfix6nv5EVIdxJx41wV6LlwKJYqBqkMLLin3Gq0xlFksVqw/QZZ6lw5Ngc5gtMwm9XkF4MJ+/1vgD1M0dyb5JGGlNBbqx/rC6oqjMCm5mtXnpjplXIyu0REdwCsLCESimgf0HhWApRjgOfZKg42/BfG2HIRARoBaeSSgVLTgSV+ndcuVZW+ZuJcgXnCNHzlo9VcIbSKs9byJoJ8dcfOGE20Smg/nlxuHGWz0E1qlDiAPWwwOeMVQWNairZAIqXe6AbByP4uJ6IKS54eVSk/7SFXIS0brtlS4E3k6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(6512007)(6916009)(44832011)(41300700001)(5660300002)(316002)(6486002)(8676002)(966005)(4326008)(26005)(8936002)(478600001)(66476007)(66556008)(36756003)(66946007)(6506007)(31696002)(38100700002)(31686004)(86362001)(2906002)(83380400001)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFZXbnpmT2s2Q2NTU3NPV0NMRDZ0T2U3ODZaQTNtem91bGh2aXUxVXpFdEZG?=
 =?utf-8?B?Z0tMeU5YMzc4RWo4Wm5PTW4wSGh3RkZzZjBMUXhGQ3hJRXMwR0ROdUdwWHR1?=
 =?utf-8?B?ZlJ5bU9qQjdwMEM3OHd1R3lhNi9GaVhKRE9oZWlEYS83M2ZIVjFkZkFoMjBl?=
 =?utf-8?B?M0Y3L1k0ZlAzRkR3YUtGalkzM3hFUE1Wc08vWEtNNjZWaWo0N2JrYzFaUnRr?=
 =?utf-8?B?UE9xb2pYa2Fod1NBZFgybnQ1dkdIRVU5ejBzdFMzOXM4eExXdStGVFo1S1Fm?=
 =?utf-8?B?ZHdmZC9jTGtjVndZYmFzai9pemZWdVFjV3J6QWVYdVBQeU16UnFkcE5zM3Rq?=
 =?utf-8?B?dy9BbVFHTFdraGt0MDg0UUdPVnJOa1Z0VnJabmlQcHAzWFJaV1oyTEVVeUp6?=
 =?utf-8?B?MjFNZEdxMXc4YTRFQXRnOVl2OVdwSEZTR0hpbG5XUFVuQ3NDV2t2NDFZcHZh?=
 =?utf-8?B?Y0xmblNod0wrd25nK2ZkSU1KcVVHR0o5c211REsrd1Y5KzRyNVRWbXB6VUhk?=
 =?utf-8?B?UFlnSDBVdHdRUlJqVjNPdk9XWHk2QkFJRkdlVm8wTW5sSFBEWWFkZTNWUFo4?=
 =?utf-8?B?R2hIWlRkOStJYzZpUzB6VmFicy85RGc2R1JTSXhXU1NrQnFNd0w3YVZ0eWhD?=
 =?utf-8?B?MWhaUHJJWUFSTWhyVUZDT2RuWXF3bGVHSHl3aVRtalV2WnUwbnN3ZmRkcjMz?=
 =?utf-8?B?ckhjTm54QXdaQmdsbUJXT2RXSVJNcElQYnJMQTNQY2Q0RWVDc2FxeHdJbG82?=
 =?utf-8?B?TUxuKzVRWjRleit5RHF0eS9VQ2c5N3lTbGdTbWNydXJ2RHdyeUc1NGt1Vjd4?=
 =?utf-8?B?ZHF4V0ZjdVB5MGdFZ2ZOYU1Nc3BFR0dFVlV3YVFwYmplY09UajNiL1BkWlph?=
 =?utf-8?B?M3N6aG1DMFk2OEx5TUp2RzFOZFFkcFlxTGg5RlF1V0VmTENyZnJZcWc2QjB1?=
 =?utf-8?B?UWlUd0JWQmE0WkZJVnhQNm5QWkViblZPRk9RcHNDOGo5K2M3QWM5OHFhZFNH?=
 =?utf-8?B?MzlkY29hMS9ZZ1Zxc040YWlvZGx5cnYrWnFJL0xrQUxvSUN2cEhTVWF2a3du?=
 =?utf-8?B?WUY3RXFvRmUwMkN1VUdZNWZHWTFoMDMyVURNcmJteU0xZTE3dVdSdzFZbVBP?=
 =?utf-8?B?ekdyaXpnd1Nka1diY0lIN0VVS2lZZTUrcVJVWG8wYXRKZ2ZLc0paMldZdkZ1?=
 =?utf-8?B?SWlZa3FKZS9rd1N3ZFRCa3dsYW1FSFZRVTUxdXZFcUJFdVJ1NmwrUzYyaUdu?=
 =?utf-8?B?b2tyaWd2SGVhaE1PWHZUWFF6VjNxdW9EcktxQkRtYmRyMDQxR1R6YkVLNXYx?=
 =?utf-8?B?UDJVZEF3UHFLdGljVE1aOEdTVk05RmZVb3g1WThYT3hISHJPRHIvM3Nub01a?=
 =?utf-8?B?OFRNRjdyNmRpUmlBWW80RDkzWmRNMHFTY2tuamFvSlJ0MVZYSm9wS1NVYy9l?=
 =?utf-8?B?bkxjMVFxYnZjZU5vbU5Uc1hjb0NpZDhOS2RoNHUwcGdKNURFWmhvc2I2emhF?=
 =?utf-8?B?Sm1BakVXZEV0MlpPREZJelZsZS9qK2dzRXdmM05ZckZWNDFLbnJhQU5MU3c5?=
 =?utf-8?B?WmNnY0hDOXd1NncvTEoyamQrZFYwSVBSc05JdVRnY3lTOEtsK0RqdzVGNFdx?=
 =?utf-8?B?SFFPc0dyemZmYVZ3b3RoR3o2T1I1dXMxdUxXOXRMWXpRcWMzMzRPcWVZcVN3?=
 =?utf-8?B?bTNKR1R1M1QySzFOMTFrcWU0Skx0UkR3TnNrdElxbXVuVDNQeklPUFpUdmc1?=
 =?utf-8?B?UWVnR3FiUVYwTmNHNkZaOUR0REptTklTZitiSlYycEZ0VEsyNXRhcHBzUTNU?=
 =?utf-8?B?L25hS0dzRkV6TXlTMDF3Nmg4Q25yWVVUK2VnZCsxNEtjRjIvcmE1RXA2ckg3?=
 =?utf-8?B?S0lPaXZtN3RCQmdSNUpjUmRzYlFJNjRrTTRTVWRTdVc2V1lRQlpuN25tVHdm?=
 =?utf-8?B?aHJTQ2FNaFhHVjBza2x6V0NiaENkODY4TEdmK00xVDdwSzJ4eTYvM0M4cTlo?=
 =?utf-8?B?VWVzVHhST25rYlN4Qy9wNFgwejV4Y3FITDA2VDlVR0R3dHNseTgyOCtOV05J?=
 =?utf-8?B?SmlZbGNJOThUaCtDZGFFeVo3SGtDTzJ2dmtGWGtRSHhTaEZwSS9GN1ovZ3Vz?=
 =?utf-8?B?ZnJIL1pTbEwrVWdRUkxLMyt3RVByTXdadmdpZUQ2alB3SEVDSFRwVnhTRHNh?=
 =?utf-8?B?eFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Zk1YUnk2dmIyQVBSYmwwQzdtV2syUTMyZkpxZHJraDlVUVRoalZrVHBrRE13?=
 =?utf-8?B?RWV4WnBDVTA2dTVuWE01UnZtZVllclI2Sjh5RHVNank1WjlNQmk0UlhERVVS?=
 =?utf-8?B?QjNicng2T0E2Z0thbnlrR3RGRzVqb3pIcVZ3Y1RJQ01nZUlKRmJ5UEQySEVl?=
 =?utf-8?B?OE5xL3BLeFlvN1RFQzZ3UkNGbmN1RndUejVhYmhzbDRGbzl0WEJUN2NIaUUz?=
 =?utf-8?B?TWY1L0lxWU4zWUZFMGZBT3dGcS93ZFViZHRqQTNZZ3J2cGRQV1dXbGg4Qnc1?=
 =?utf-8?B?T1g4elp2VklvWVFHQVdHRkMycjVLZmFWdGdzU2IvNGRtV0w5Q05CUjlkZW8y?=
 =?utf-8?B?SThQc0lGTDY3RTdESU1Udm03NVVLMk1vaEtuS29ZVlNhMktKdmVRdHp6bm5H?=
 =?utf-8?B?aFpwek1XWEZzT0tvYytuSFNoMUVQYzE4eXQzbThZOCtMMWFST1REUUNnK1Vz?=
 =?utf-8?B?UFo3OVF0ZUFHcXdCR2N1alpESTZBLzg4NTFTaHZuNVVMSDUyWExaQ0tDT0V3?=
 =?utf-8?B?cU5weElVWkF4Nmc1SE44RGR3RkpnTXhRSExhN3ZILzVCeEptc09SK0RsOVMv?=
 =?utf-8?B?ZkQ5dURrR1pVWHU3VnB6Vk1FRmYxL3paTFlxUkwwOEp4bTJmdnVjU2tDNHRO?=
 =?utf-8?B?N1l2amdaNXRBVnFwekpHWDJvUDBZOTNhUnk1S2Jqekt0ZDF6cm1IZG5zcUhw?=
 =?utf-8?B?eEdRSTB2bmFtQ3ptNFh0N1lvQ283OEF1aWFXQ3hVYnkrdVJwcEVnL0tXK2xO?=
 =?utf-8?B?K0kwNU5KM1ljR1VNSzJYVy9XTm8ybVNWL2ZGbUdkYk11djJ2T2MxODM0bzRw?=
 =?utf-8?B?enh4RFUwbHBBaVdzbDBlSVBzTmU4cE1aZm1JcWlxN25LQXRLaEwwc0xwWVVQ?=
 =?utf-8?B?SEFnTVFtc0JQVlFaOHdFbzM3WW1rYzNPajRBTU1ORDJWVmNpaDlvTTNLcnVL?=
 =?utf-8?B?M1pjUzhmbTlnTEo1c0Q3a20vdHVpeGU5d2twWndxRzRmSU5rTUpPRTVDd0Vn?=
 =?utf-8?B?Z0RVRDFlOWxNWTdvN3NVS29Ib3ovdUZUOUlxckFldzNLaEpNRm55U084VVU2?=
 =?utf-8?B?a1NVcjhLc05OL3dGQnN0UWhQUzBXaHJidXlEUnRTcG05OWoyV2tHa3NMR0xD?=
 =?utf-8?B?b2RPVjRtbHJBYXZEZGJNUzVLczU1RDhTaGhhdWNzdXdkNWxNb2pvaE9FUE56?=
 =?utf-8?B?dTg5SUJFQ3Y4aFVraEhqckltb2xSdnVuYjdkZm8raGc2Z2hXMjNmNlVGTnYx?=
 =?utf-8?B?N1ViNVBRMWNrVGhMbUtZREJlakhTMk83SllCZ21qMllkSDJRN1dTeUNyYkxM?=
 =?utf-8?Q?Tuup6xp5/mnis=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7545b7c-4fad-4f24-93b6-08dbdaf18152
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:44:59.6045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1yBNEgmdLO81hvNnpNVFJgqjt1/8XGP6nd2qVpbquMuWtRjRynWF+ZO7aP1ZU8CACQcrFE6COusXZRjNDvnYejkMi62BRx6C1qnaAyN2Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_14,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010129
X-Proofpoint-GUID: vfdo9pFFEfBp8k_qH2nKcC_17n-BKhSO
X-Proofpoint-ORIG-GUID: vfdo9pFFEfBp8k_qH2nKcC_17n-BKhSO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 7:03AM, Manas Ghandat wrote:
> Currently there is a bound check missing in the dbAdjTree while
> accessing the dmt_stree. To add the required check added the bool is_ctl
> which is required to determine the size as suggest in the following
> commit.
> https://lore.kernel.org/linux-kernel-mentees/f9475918-2186-49b8-b801-6f0f9e75f4fa@oracle.com/

Thanks,

Made some minor formating cleanups to make checkpatch.pl happy, but it 
looks good.

Shaggy
> 
> Reported-by: syzbot+39ba34a099ac2e9bd3cb@syzkaller.appspotmail.com
> Fixes: https://syzkaller.appspot.com/bug?extid=39ba34a099ac2e9bd3cb
> Signed-off-by: Manas Ghandat <ghandatmanas@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 57 ++++++++++++++++++++++++++---------------------
>   1 file changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index 88afd108c2dd..57fba21994c3 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -63,10 +63,10 @@
>    */
>   static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   			int nblocks);
> -static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval);
> -static int dbBackSplit(dmtree_t * tp, int leafno);
> -static int dbJoin(dmtree_t * tp, int leafno, int newval);
> -static void dbAdjTree(dmtree_t * tp, int leafno, int newval);
> +static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval, bool is_ctl);
> +static int dbBackSplit(dmtree_t * tp, int leafno, bool is_ctl);
> +static int dbJoin(dmtree_t * tp, int leafno, int newval, bool is_ctl);
> +static void dbAdjTree(dmtree_t * tp, int leafno, int newval, bool is_ctl);
>   static int dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc,
>   		    int level);
>   static int dbAllocAny(struct bmap * bmp, s64 nblocks, int l2nb, s64 * results);
> @@ -2096,7 +2096,7 @@ static int dbFreeDmap(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   		 * system.
>   		 */
>   		if (dp->tree.stree[word] == NOFREE)
> -			dbBackSplit((dmtree_t *) & dp->tree, word);
> +			dbBackSplit((dmtree_t *) & dp->tree, word, false);
>   
>   		dbAllocBits(bmp, dp, blkno, nblocks);
>   	}
> @@ -2182,7 +2182,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   			 * the binary system of the leaves if need be.
>   			 */
>   			dbSplit(tp, word, BUDMIN,
> -				dbMaxBud((u8 *) & dp->wmap[word]));
> +				dbMaxBud((u8 *) & dp->wmap[word]),false);
>   
>   			word += 1;
>   		} else {
> @@ -2222,7 +2222,7 @@ static void dbAllocBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   				 * system of the leaves to reflect the current
>   				 * allocation (size).
>   				 */
> -				dbSplit(tp, word, size, NOFREE);
> +				dbSplit(tp, word, size, NOFREE, false);
>   
>   				/* get the number of dmap words handled */
>   				nw = BUDSIZE(size, BUDMIN);
> @@ -2329,7 +2329,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   			/* update the leaf for this dmap word.
>   			 */
>   			rc = dbJoin(tp, word,
> -				    dbMaxBud((u8 *) & dp->wmap[word]));
> +				    dbMaxBud((u8 *) & dp->wmap[word]),false);
>   			if (rc)
>   				return rc;
>   
> @@ -2362,7 +2362,7 @@ static int dbFreeBits(struct bmap * bmp, struct dmap * dp, s64 blkno,
>   
>   				/* update the leaf.
>   				 */
> -				rc = dbJoin(tp, word, size);
> +				rc = dbJoin(tp, word, size, false);
>   				if (rc)
>   					return rc;
>   
> @@ -2514,16 +2514,16 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
>   		 * that it is at the front of a binary buddy system.
>   		 */
>   		if (oldval == NOFREE) {
> -			rc = dbBackSplit((dmtree_t *) dcp, leafno);
> +			rc = dbBackSplit((dmtree_t *) dcp, leafno, true);
>   			if (rc) {
>   				release_metapage(mp);
>   				return rc;
>   			}
>   			oldval = dcp->stree[ti];
>   		}
> -		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval);
> +		dbSplit((dmtree_t *) dcp, leafno, dcp->budmin, newval, true);
>   	} else {
> -		rc = dbJoin((dmtree_t *) dcp, leafno, newval);
> +		rc = dbJoin((dmtree_t *) dcp, leafno, newval, true);
>   		if (rc) {
>   			release_metapage(mp);
>   			return rc;
> @@ -2554,7 +2554,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
>   				 */
>   				if (alloc) {
>   					dbJoin((dmtree_t *) dcp, leafno,
> -					       oldval);
> +					       oldval, true);
>   				} else {
>   					/* the dbJoin() above might have
>   					 * caused a larger binary buddy system
> @@ -2564,9 +2564,9 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
>   					 */
>   					if (dcp->stree[ti] == NOFREE)
>   						dbBackSplit((dmtree_t *)
> -							    dcp, leafno);
> +							    dcp, leafno, true);
>   					dbSplit((dmtree_t *) dcp, leafno,
> -						dcp->budmin, oldval);
> +						dcp->budmin, oldval, true);
>   				}
>   
>   				/* release the buffer and return the error.
> @@ -2614,7 +2614,7 @@ dbAdjCtl(struct bmap * bmp, s64 blkno, int newval, int alloc, int level)
>    *
>    * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
>    */
> -static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
> +static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval, bool is_ctl)
>   {
>   	int budsz;
>   	int cursz;
> @@ -2636,7 +2636,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
>   		while (cursz >= splitsz) {
>   			/* update the buddy's leaf with its new value.
>   			 */
> -			dbAdjTree(tp, leafno ^ budsz, cursz);
> +			dbAdjTree(tp, leafno ^ budsz, cursz, is_ctl);
>   
>   			/* on to the next size and buddy.
>   			 */
> @@ -2648,7 +2648,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
>   	/* adjust the dmap tree to reflect the specified leaf's new
>   	 * value.
>   	 */
> -	dbAdjTree(tp, leafno, newval);
> +	dbAdjTree(tp, leafno, newval, is_ctl);
>   }
>   
>   
> @@ -2679,7 +2679,7 @@ static void dbSplit(dmtree_t * tp, int leafno, int splitsz, int newval)
>    *
>    * serialization: IREAD_LOCK(ipbmap) or IWRITE_LOCK(ipbmap) held on entry/exit;
>    */
> -static int dbBackSplit(dmtree_t * tp, int leafno)
> +static int dbBackSplit(dmtree_t * tp, int leafno, bool is_ctl)
>   {
>   	int budsz, bud, w, bsz, size;
>   	int cursz;
> @@ -2730,7 +2730,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
>   				 * system in two.
>   				 */
>   				cursz = leaf[bud] - 1;
> -				dbSplit(tp, bud, cursz, cursz);
> +				dbSplit(tp, bud, cursz, cursz, is_ctl);
>   				break;
>   			}
>   		}
> @@ -2758,7 +2758,7 @@ static int dbBackSplit(dmtree_t * tp, int leafno)
>    *
>    * RETURN VALUES: none
>    */
> -static int dbJoin(dmtree_t * tp, int leafno, int newval)
> +static int dbJoin(dmtree_t * tp, int leafno, int newval, bool is_ctl)
>   {
>   	int budsz, buddy;
>   	s8 *leaf;
> @@ -2813,12 +2813,12 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
>   			if (leafno < buddy) {
>   				/* leafno is the left buddy.
>   				 */
> -				dbAdjTree(tp, buddy, NOFREE);
> +				dbAdjTree(tp, buddy, NOFREE, is_ctl);
>   			} else {
>   				/* buddy is the left buddy and becomes
>   				 * leafno.
>   				 */
> -				dbAdjTree(tp, leafno, NOFREE);
> +				dbAdjTree(tp, leafno, NOFREE, is_ctl);
>   				leafno = buddy;
>   			}
>   
> @@ -2831,7 +2831,7 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
>   
>   	/* update the leaf value.
>   	 */
> -	dbAdjTree(tp, leafno, newval);
> +	dbAdjTree(tp, leafno, newval, is_ctl);
>   
>   	return 0;
>   }
> @@ -2852,15 +2852,20 @@ static int dbJoin(dmtree_t * tp, int leafno, int newval)
>    *
>    * RETURN VALUES: none
>    */
> -static void dbAdjTree(dmtree_t * tp, int leafno, int newval)
> +static void dbAdjTree(dmtree_t * tp, int leafno, int newval, bool is_ctl)
>   {
>   	int lp, pp, k;
> -	int max;
> +	int max, size;
> +
> +	size = is_ctl ? CTLTREESIZE : TREESIZE;
>   
>   	/* pick up the index of the leaf for this leafno.
>   	 */
>   	lp = leafno + le32_to_cpu(tp->dmt_leafidx);
>   
> +	if (lp > size || lp < 0)
> +		return;
> +
>   	/* is the current value the same as the old value ?  if so,
>   	 * there is nothing to do.
>   	 */
