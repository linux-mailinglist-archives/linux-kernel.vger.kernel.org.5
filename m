Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626857F98E3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 06:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjK0FsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 00:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK0FsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 00:48:01 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDCF0;
        Sun, 26 Nov 2023 21:48:08 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR5KYok016146;
        Mon, 27 Nov 2023 05:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=f+BXbTkVCnXMLQ+fMLJIjlrFdKK5Psh+ZNYD6g3PGos=;
 b=cpBv4cgn/7ugoC8kZW9sbFyZlvkPdcc5HWHcduHEYezrFrpUSBqwpJXFgrMBmXMvZEFG
 IFz/df4+GhghKFjdwSpuqEBdk3Kg0dHT/rTO17h51CH9i/CHpRkT/l7hBQdNyLKqJdyn
 H7750bx/kGoVk9vng47uQh/Y2jW3ViVHd1ZPnPWMt6EQ+OjkWTedX9rgms6HTPI3+jgx
 YsiB0zN/vqxkxx4LG64IuPuL1mj/T075s+vWMBMqJPHMx9qAN9aQgDm4D9hCoBUw739m
 9ADzA7p5/MhBLfaoQwBBhWC+P1zUHLL+OEEowH+eHBF3Ftfq+GL1z8bLVb9aKz+m9wlO 3g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uk8tbt2q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 05:47:36 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AR55nWp002127;
        Mon, 27 Nov 2023 05:47:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uk7cb1jrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Nov 2023 05:47:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2678zcB9zlcO2T2d9t+YzbOW3alOeW9RRI1svOGWojR9/x5dTSRg7DF9nVKg1NyRE+0v8oied9hpt5DOinptiAZYgqh+Q5MLJV19Cs+mPpe4l9WH+u9bq8xNiH2sHoGTfBC3H00HFQ1WxvmRdScv4M9iBMB4+djnaMKEupe0gNuetwZtyEL2zbDLJXA5tVfnTml0t0LTLpA9DMponISrklLv4KytjfGkGGfehcGEPepMxINN6jm0o+7NEyDYWTzuWE2rzDg0shqU87BuZnlVyiVqVMvwxVkFWb7kmcJKXc4KTLFhC8LV9Z3j94ti6cVe/kUqFoI/isQnq7eRtNIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+BXbTkVCnXMLQ+fMLJIjlrFdKK5Psh+ZNYD6g3PGos=;
 b=MGLOTsM8mpmrhvI5b0nAClCXZqNewPdpbGBHc7W0bVLwkR6NR7RDTsAGeVMiQsY/9DH3qT622w5JM2ltAZv9+6/Dc6vePEfiybAbHWe+vI5xPb9JQQcNkeHFHhculz0x+HOxBiTm4CaZXHxM1yzXEyV6yYo4IuTFhSORjT6t6zV/jJDYUUT09usInVsSNYBef3DJHBcVltVkic1w3+/9M4TqX1Pote0Z8VVxuvckcsYbgggNnjK2VI/HetHJR7XOwJxfLOR2lOzJBP8uRQVXqxvhynW3dfV99EFSQ5707YKRp5sgkp9RsFy6wxUfrJDjcR2jWgOmDXCU6EFpIlF+KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+BXbTkVCnXMLQ+fMLJIjlrFdKK5Psh+ZNYD6g3PGos=;
 b=PqB/hsBfOQUBOp8As3q4Ob1dnfn9TGbLapG8j3D14KxzEo64toS5f3d5XSA53tHS+Ny0WypRKqbN+VIG0oyk5ktCxqqwGOr3iMGmqyy8VUO1lx91D4sI9/8up+Emtoqoxv/RdpEAMQGvNN15t1QAkhXFsnYtKfUmO2OH1NMBr+g=
Received: from SN7PR10MB6287.namprd10.prod.outlook.com (2603:10b6:806:26d::14)
 by IA1PR10MB5948.namprd10.prod.outlook.com (2603:10b6:208:3d4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 05:47:32 +0000
Received: from SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::7295:59ac:ffbc:e40a]) by SN7PR10MB6287.namprd10.prod.outlook.com
 ([fe80::7295:59ac:ffbc:e40a%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 05:47:32 +0000
Message-ID: <862d80bc-961b-4ef2-8f91-441325427ae0@oracle.com>
Date:   Mon, 27 Nov 2023 11:17:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.14 00/53] 4.14.331-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231125163059.878143365@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231125163059.878143365@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0154.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::22) To SN7PR10MB6287.namprd10.prod.outlook.com
 (2603:10b6:806:26d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR10MB6287:EE_|IA1PR10MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b73b9c6-76b4-40ac-3d93-08dbef0c5932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ghVC7vAG4ks3O5RuZmylxtTsBE9uUcDadcH/iRsvP9QFbq0Ru3U+IVLDUB4HIwwpcCEzCOLOpQPmpTuwWHwV/yDBVZvMCfVHQy577LzREWz6zTJ/EG+8i/girZIHrEOHD/VJKgKw7zLccpPiLKvOXdhfTbbWawYhMdiHOXkS3khzJGItzW+mwHqPG/KrT85msZ+TFxaawIQNMChtcUVejU27iW2IQGRciCZpi3njgLXiGEGEW3gZc0+9EloCmWVfk6EercJ3HkI62AwRqxuOesNVM+4PP1lP/+TEK8ekwbmJn2YMcy7Cw4USa4lOwL6BFCXURQcZPGDEU+zM8YLTvQE4wrxUBp3/FOnk0mKnF0saxJxyJLmdkBU7WhJBuvFHWysTWnZ+rzMMgMxeVOcXMIRMr908BIe53gATLJD1FZ8UHWArXjqsgHnP47EV+0Z1DT8qWzNb49N74gXaF7NZXg6cnbjVxMz9O9RV3rNHehvnMl/mcmXe1NzKPdCWKFujzNCEV1d0DWkHEEVTw3yaCMMesKbiSKsYWMBA45auu9wtUnr4vF22LxJiSb/HnDfLVe1G5yzi6PijSMbElcqHI36CFb7psBKuV5WY2yNXyWELNiu8Fyoo6U4Wrdp45cMADcspFBp6bMoQfxZFF19hqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR10MB6287.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(2906002)(7416002)(4744005)(5660300002)(6666004)(6512007)(41300700001)(478600001)(36756003)(4326008)(8676002)(8936002)(966005)(6486002)(38100700002)(2616005)(53546011)(6506007)(86362001)(31696002)(66476007)(66556008)(54906003)(316002)(66946007)(107886003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2xXQmIvV0xnV1p0T2IrS2llUE93WHVVYjFrckcydzM5VkMzZWN1bDNlT1F1?=
 =?utf-8?B?eVB3a2dSZ0M0TFkrY1gvRjBPRmxVc3A2NXlVSUJ2SWZRTlVqV2xPR2UyaGo1?=
 =?utf-8?B?T0pYTUZwbzdZN2FaTXRWTzAyb0w0K0lhS0NhQzRWQllJVEw5S0cvaHdTQ2J3?=
 =?utf-8?B?MXNlcFVYSGpTbG9aMTVOY3NuSDB3YUJOOWFJdUI0Z1lRMU96dTJ0VFRXTTVR?=
 =?utf-8?B?WE9NbzZnazZIRVU1MkNNVFZHTnlkZE51cmNQNTFxY2lDUkxraysyYWYzaTUv?=
 =?utf-8?B?c3lJLzlyTTdSTjVnOE5UT3FIZkRVdUxQNUFnTjVUSHhjRnZxT1NNVjNUcmJU?=
 =?utf-8?B?TGtFMjgrVmtpZm9SdUFYV0U5MEU1cHAyanBqQUdLQTVJY0NPZU0yWUZBY3c1?=
 =?utf-8?B?S1pXV0Y0WkozOFJ0VWJUQmliL0w1NVQwYldhVjRiRjB4bm1MUENVN0llVzQx?=
 =?utf-8?B?R3prNXFqN3VpaUtuVzNYTGxlUW1KRE5CK0d1VVVmVnhzYjJDcUF2UUdqQUt2?=
 =?utf-8?B?Qk4wM2xKVDFlM1BoSGFROHpiLzQzdW96V1lWZzBoSzJqWTZZSGl3Vy9IK2xZ?=
 =?utf-8?B?TWtKdEhCekN3ejlPeC8yVlRMVW1kTjR0OUUrOU44UEVGMmtoTHA0NFlXV01T?=
 =?utf-8?B?YzgvNllyYXprNmsyaWpveGZGdExFUUg2YitaSHc0dFBrYTBEV2hzVGpHU1pi?=
 =?utf-8?B?Y0NNcHZFWDBhNUxHQUwrMXZoYVY5SmZJZWVaTGd5SjVSTW8rQVk2NmxDbmY3?=
 =?utf-8?B?OXljemlndXBCNEdGMzdFY3NZa2tZZ2VURTVYYjhXUjVoYS93RXpsdVpYUmh3?=
 =?utf-8?B?bHIrTC8zSHkzOUpLNW5VYVJTcGV6KzNBTXRGbVlMbEZ3Tm11Y29DVG5ubEdK?=
 =?utf-8?B?UVNzbUVyRXhqa2NhWm5zOHR6aU5SelMzYmh3WG12MkFxTzNhT21vT3VGbW5m?=
 =?utf-8?B?WHNOZzdsOEtGbTFETytyWjdKQ2JEWUgzUzNyM3ZFQlJOUmQxVUlPUllDa2Jw?=
 =?utf-8?B?UXhqMWd2L3dKbXp0TkJpMDFNUlhUU0VPV1NkUnIrZ2ozekxIazFzV1N2aDlm?=
 =?utf-8?B?TnI3MDRsaXJicDBQRTRHS3JpQlNQVnRPaWx5enJ5enRDVWliYmM4cEFnWjAy?=
 =?utf-8?B?WTllNHh3VzFYODNDYXFmeXVBR1pKQlNWYlpRNGxpU2ZwVDJDZVlyWHpQMmZl?=
 =?utf-8?B?UWUwUlJyQnNDS0N6eDdabU40a0FPTUVaaGM0TjYvT255anBsVkJwditVdDU1?=
 =?utf-8?B?aWt4ZThvQzhRZHhPQ21qMU9leG9KWGVRcXIvWS8vUStVMG5IVzlQVUdqVm5P?=
 =?utf-8?B?OFl6RVZQaFhJUlQwdVd3VTVBaTU3VUs1TWZxQys0aXFSRmRLZzNXTnBicU1B?=
 =?utf-8?B?WDdzNS81TG5IQ3EwWWdvcXVFZlJCckMyMGFTS3lOY0p0WWxDWUlYQUlUYmxy?=
 =?utf-8?B?UFhmSHVwdVQ4eEo4ODh6VllqTXExMUJXV2wzTjJnSE96cnN2ZEE3OGVRKzFF?=
 =?utf-8?B?d2oycExubnM3bE5EVnlKSEVLMWVVZGc4TWlWcU9ycXdlTHpvVW96VGwybzV5?=
 =?utf-8?B?VUVvRE40SXVlVUJEeFVsQzFPcEtnUGpNb0JabkJZNDl4ZllKWHUrWFkrQ0hP?=
 =?utf-8?B?Mmd5elptc0YzYlp3NWY2TlRyeHF6Z1gwc0p4eUtEelQvWnhxREYxTUg2OGJ0?=
 =?utf-8?B?dVdNLzd4U24raHpaUkkzQ0lMUTQrOXRoVVRaNzRtdXdQWnJ6b0l6MkdjdUpW?=
 =?utf-8?B?SjdkN09vMzZuR3psU3EwYTR2MmxaWVN4S2ZXL0VSMGx2MGNTU1FTOHRuQ0gy?=
 =?utf-8?B?YmJXVUFsSDZ3ajdxV01EK1hsdXoxRFJoWXVBcUFNd3o2VnZ4N1I5UE1JaXZJ?=
 =?utf-8?B?VDFoRHBSZmwycmNxMFNleVl4emhFeEY3SzdNNzJCSzJ5Zjl5eDZtK0g0K0pQ?=
 =?utf-8?B?WmpaaU5kS2JmVGlKbXM5NWxzWm9GOXZMQXlLdHB5V2xhZndoL1h1ZFNvbkIv?=
 =?utf-8?B?VzM5bTVva3o5V3VLbFQwMEt4Q0lhRjM4SitMVEpJSkZOUFlQS0xHOEdrY05H?=
 =?utf-8?B?N0N5S0swenh3azdwSXBDRXEwckJjcTlRRXFpeTNrUUNaTzhXUUg0QVJQc0hH?=
 =?utf-8?B?VkthZ1Y1VXBiTktPUEUyakpJTVNxSnM4Y2N1ZFp3cmFsbnp5VG9SMWxpalRK?=
 =?utf-8?Q?sLgBHDCXPG/iF2VQKcqUaSA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ajlJWnZzeUFGTDA1T3FmMStVWEdBUndlREF1L3d5ajdrTmhXSU51Q2psdSta?=
 =?utf-8?B?bUJ6eGZHbTVCNDduSUJOb2ZSaXB1SVlOL3UzaHpMV042cXNMd2EzMUN1YUpL?=
 =?utf-8?B?cWw2YWk5dzVQR0VVcWdzQnQxL3FWRTdYU01JVzhPd29Mb3RaRlpxc3VBMng2?=
 =?utf-8?B?ODFGTDVBY3N2U3ZUVkQ3UTJGYnhCcWxzcUhwZklvY1hHVllVQWcvbTFNVktm?=
 =?utf-8?B?RjJjUzhITDRtc0JnM3hjbUlGTWVRcnc2Ylp4cmdYeGdaTXRxT1BqK016M0dE?=
 =?utf-8?B?emRtc1pzaEVzaHQzdXBiUUVyWGtvYWVVeGdoODFwR244ZnZSQVl5MkxMcEpp?=
 =?utf-8?B?dTZIalFMM0NBclV5dmNyRVZtWXhJTEczenRONjVncnBJK1RIUFozOElVYVFW?=
 =?utf-8?B?cVROQ3dRV3NrRHBKQ3FBeDVBTTFqNFpMQjZEOS91Q3p5dm1qOVJFSDR0K0Fn?=
 =?utf-8?B?K1Fqam5rU25Tc0J5S285SXQ4QWZuRG5LaVNZV3RHblV1TkczTzIyemJaVVR1?=
 =?utf-8?B?MUdKcDYzQ0cwUzh4TzhiUUVrc3poM2lnangyeXZRUHdjTjlGSzJBVlZ1dmMw?=
 =?utf-8?B?aWpRRmpHK1EwY24rN3F6MnZOSE1jWWgzaXFxTENuZnNPaXRFSjNkMzNXZ2RH?=
 =?utf-8?B?VWZwMEs1L3VWSjlHZitnSTRWdFRaejFZUnFpZyt0RFlLcm56NWVHV1RuNXF0?=
 =?utf-8?B?QzhwRHQ5Qmx4WHl0dnpET0RlQ1ZkU3NkT2xOYjFGRTdCSllqSlhCa09OUmNT?=
 =?utf-8?B?ZjZlWktBaE9meXBHdXFyajNwdUlXU0VIQ2dCaUJrTXFtcW9Id2ZyaUdLVktE?=
 =?utf-8?B?bkdKaGNKbWkwcEFnR2JVM2FaendwdG45K2ZPd01wZGRUTElWMkY2NGFpR1ZW?=
 =?utf-8?B?aVlzV1U1M0dLV1NYandER0w1WXFKdGtDcU85UEovdVU5RFdRT0xySUNLa1A0?=
 =?utf-8?B?eVdVenNDNUNDQ2VWWUJZOWF1VVBNakNUUkt2bStncWozZTI4cEIyVUc2UGUy?=
 =?utf-8?B?OGtHT1UzVnVFVzdpWFpZVDg3WW1XaE04VTBXTHczWkhGeVVpa2ZSTjd1bW9G?=
 =?utf-8?B?aldQU2czSERDWkJIZEtQWkNCbVZVdjhOMEtMbTA2NkNkR2hIeUZORU9DZU13?=
 =?utf-8?B?dTd2aTEvekhBMkdDQmNpcldjTGlTL0JjbUxGRHpwdlh1YVZKeVZvazVMZ2VW?=
 =?utf-8?B?cTFYTkpQOTQzQURnaU9KcTR0eGsveGVRVUowY2RRemM4OUdvUk9rMnlCbjVr?=
 =?utf-8?B?OFJNMi9CTDVHZFg3WVJPam92N0VCbXhlSmdmK1BRVnpCNjAyd1Y2OUhiUko2?=
 =?utf-8?B?dnVvV0U5eXBqQnZBeGw1VnFxenpsMjdjdDBTa1JBa3JyR3lPd0Jobi9JR0Rh?=
 =?utf-8?B?d1NGTVg2dlhWMWlvVXVMUWdXWGVzZmdVTVdnVE15U29reXA2VFR6d2Q1REV5?=
 =?utf-8?B?ODhqMlRkL0htUStMV3lFaFpnc1ExZFJvb2cweGdIT0JGSG9ZWmYxaEV0NHdL?=
 =?utf-8?B?R0xpRG9ERHNqek9MRDdEL0dhb2tRdzdnL3YrRU0yQnZKdTgyL2dURElFc1hk?=
 =?utf-8?Q?MdRoL1d02wKNE/UXvl7wUZNMqrFwJMXm2G1Ap2chX8pzWh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b73b9c6-76b4-40ac-3d93-08dbef0c5932
X-MS-Exchange-CrossTenant-AuthSource: SN7PR10MB6287.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 05:47:32.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh0rof7urfzsFdcQZdxzD8cUA9tV2KWwuOLIj8dyKxna1AulW85/gjQvB0uj2//yytf0bM7xCwZXmtocKlcr7qHuFZMLnFz8VO0fpSGifNZ/mwmbQ+y54+6/RsIA6mOt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-27_03,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311270038
X-Proofpoint-GUID: bFQwvxqhEWhPy7Ou5HrUn_hp9CL9gGwO
X-Proofpoint-ORIG-GUID: bFQwvxqhEWhPy7Ou5HrUn_hp9CL9gGwO
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/23 10:02 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.331 release.
> There are 53 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.331-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
> --------
