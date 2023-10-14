Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D497C9466
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjJNLtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 07:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbjJNLtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 07:49:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA184AD;
        Sat, 14 Oct 2023 04:49:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39EAV5iO008923;
        Sat, 14 Oct 2023 11:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vZZlyaxg0xJ4c/wEf3XbGS+df/jGZtLB+IoqsLRMFK8=;
 b=FHTRThD5SJ7wfcmnUkdfqhowYxG682XWhCB9rAmH08XB9IbhKPdqMmEKjoavcE1oveE7
 EYjYwRkK7lnznRMsjtTWvpzIn1EPtlq229LkmcXYnnWC/GjCU9hCjuwXikHCJz7BQQof
 BIJsS9cryvIv+FFKpXvUplLlpjese4PhHkdE4Byr9OT7VvMzT151JUvF5ez00Nx8Ge1C
 Lqa50W891wfFAaZuZ5B2p1031zjiNqOCtkLfnPvbsmENX6iEVsFQqqG9Qz36MprKtmO1
 nm+s7irPOSxSxBLrdH7UcGCxC46VNIxsu/PQ8QAN02d4arFGpG0dBn1VNPZ/dHj+HSZq sA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1crb5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Oct 2023 11:49:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39E7rFsc034464;
        Sat, 14 Oct 2023 11:49:05 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tqhe2576s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 14 Oct 2023 11:49:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmNvy2LUBttQK0amw4MuTDA9bKI2t36vdFs1s/g+V2dbbkNQnm3chjBKxG1DGZo4R0qyYfsktgqgy0mtRw2dDej880qESk+P325Q+5Mkh1DVi0HkZmwR/OfrlIbFNYzG1c9awhK4bd+9RpqSXuzfnudlsQ/K24hhmqKeZ+AcAAIoY1Wu6gZWuIgimQaMZIBhXsUV7B2YoeGOxk1hjrI4DT1FPsNUqFnrZr5eZkX8YC4gxNfCQ8HQ2znzPQoh3KKdN47EztcED7omWsImzuw+DADX1eBr82NlorDNfYRmEkHNHks3Z+YoRz2kUkxhNXt3vlyQBTHoFZTq67RPP2OahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZZlyaxg0xJ4c/wEf3XbGS+df/jGZtLB+IoqsLRMFK8=;
 b=TIaSscD8wPl57Kq70Fahiyrws89fC+QFxwABBH8BKlDOftgM6gvMBlt6H1i1D+7OjzJJ60e2h9AZQRM+3Zi7SqJ/EGAs7iN52RHmh06u61/qK5CE6KRB6MwGwlaP214hb4I/9ZEEGJtOjk+e4sXvCOrS2WGRsNEg5SmuYLxBKK/mWBhVhBKNAPpDdY7y+wrkPPhR+RnT8Iu2Zpi+QfZX5vfE0yc3/jp86BfsApD0QFDi8EXf0cDyvUgCVzAjtK2qAPwh5Ye5jFmJcSCWztYKTB0uOkDJpmB1jMupcCvlo79slGIOTZiG3+Q/PAazw1LpTRWPmpgCfswNY3LnHF2tKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZZlyaxg0xJ4c/wEf3XbGS+df/jGZtLB+IoqsLRMFK8=;
 b=fHzXNg3/NkHxhIXreofoN6YVkON/MZPCbAa6UgU0/qmZCN5DeSImB3S4Ss1a5806CV2xy4cyjZ+n95d7maKZ69mCnEysu0RopjdRIIrzuUTNC5awUESN08ko3gb/faC0ad0iBW+z5fvoOwpXQnnoPiXCedtTBXI20NehLUzVnEk=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by MW4PR10MB6582.namprd10.prod.outlook.com (2603:10b6:303:229::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Sat, 14 Oct
 2023 11:49:02 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6863.043; Sat, 14 Oct 2023
 11:49:02 +0000
Message-ID: <12b082c8-908f-4de2-b0b5-4b638e10c402@oracle.com>
Date:   Sat, 14 Oct 2023 13:48:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: add backporting and conflict resolution document
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        backports@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Hutchings <ben@decadent.org.uk>
References: <20230824092325.1464227-1-vegard.nossum@oracle.com>
 <87bkdfg2ds.fsf@meer.lwn.net> <877cnu5jy0.fsf@meer.lwn.net>
 <83fd1a05-974e-4d91-82b0-c09cc2f8da1e@oracle.com>
 <20231014094320.GC20662@1wt.eu>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <20231014094320.GC20662@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:b5::24) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|MW4PR10MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5094d1-8cb3-4542-db79-08dbccab8f8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfaImDhJi/2cs3KiJteJkjOj84MGLGLNFqpaDXaUjmwAsgNDW8h8pTG7+UjNN8Ja4L4B8IQokqAAGbUN95y9IEIZZWfBWlrxCaIPkn6ASPkG3n1q0e6R3T1hbYp531SkQNXeoiC9tdF2Tt9UhceszfGHJOZmUulFxUWet8XSxRIYZVkSDcHefTuwP+CQeUAhoL+SubPz+Gh/NGjqQOG4YbtZJFkgo1QB8U+0lddc1D/JgzPxIv98w7GmTW83e3QZnBAfqKoyE6UgUDcqSCqNdgSoRBP4Czymcc53No9tehKqyWXudZIGgDuw2lUKUQGwNLXE8HJ68+dXjTtpbVGLakrMv4rZ19B4aVEtczu04A/TsP1ibwFaZzs69nCk1nXuaJK1yZbjssjS8hZfIbl5yrUufvCeV1toeP+RVOkI9jXhrUFcd2DsBt5j0fpL+s5ZfEskEq0guVP6F7jtoOgu8Fbo4hYCwa7RiafzXr1vlMh50nwWbTZAxEchwD65MqcPp/RYyblv8TerPmmbPzfhgUwfDQ1TrNati/Ms1agX2KrD8HWBLvZC6d+NlegGg5+nj4P1i8UwqOEUw9urFMhwLxmLDwoxII36KJw13IqBKW7q4N4P7xTNN2uZl89IAP3Q8AjitaLkh5ZtKzjRHJ/d/ANHeRADfY7gfS8pHOlc88fEbTEsLIPJyF5xjC5vLDQS1vU39//ROfB4U2r5wwuYL0SnywcrGNTIP/NlWlZMMH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6666004)(66899024)(6512007)(26005)(6506007)(83380400001)(53546011)(6486002)(2906002)(44832011)(478600001)(4326008)(7416002)(5660300002)(30864003)(8676002)(2616005)(966005)(8936002)(66476007)(66556008)(66946007)(316002)(54906003)(41300700001)(6916009)(38100700002)(86362001)(36756003)(31696002)(31686004)(781001)(15519875007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFkxYVJnWFZmSHM2dUdlZWtEZi9ER0FXWGRvWTBjOVQ1elAxeG41MmxHWmFE?=
 =?utf-8?B?a0tpa3VtQUxPQzhkSlFoeEpuODladVFBOXYwTmY4WHlNWjFGMGUzMFR6MHRS?=
 =?utf-8?B?SVcvTTJIL3ZoUGlyWW1xUU42Ujd0dlU1QWRiZnlEOFlldUNab0MzbXJzcWJ1?=
 =?utf-8?B?YzVKVkhtWmNuTUUxNTBteG5lTnNIMDRIVTl1bmk0c3YydHdDN2ltdHhkZ0JU?=
 =?utf-8?B?MDVBN2g1VTlqcmtCOGpJMEtDb0EwMGd6N3FrRXpDSFdWV0hBQ2swc09pbG4x?=
 =?utf-8?B?L2hOeVIvWFA1Qk1iVDZnUDE0S0NXQlgwakkzRWd2Mkx3ZjV5YjZWbDhrTnBj?=
 =?utf-8?B?SmRPZm9XSHlSb3JINHp3K1VrUWlGdWtKclE2S1dHSFJXdjhiekhHcEtOajJL?=
 =?utf-8?B?eHhZejhDeXB1aDgrNDJndzJQQTBrV3lFamNIYWNtLzVmY2pYVzRnUGN4d0Nw?=
 =?utf-8?B?ckd6WkJSOVN1bEFIMU1kYkhaMkVTQkppUm1SNERpNXdlTnlLSlNHNDBKOU5F?=
 =?utf-8?B?VFZuaXJyUnlkQzdtdlBxSDh4ekxhS2krY3dRNmtwVWFkWUhmalBmVHYwUUNE?=
 =?utf-8?B?Y0NQOEZjRFJCSktMbGJVNUdLYkRhS1JSRzBjai9icFNxZ01lYzEzTHNOTGhE?=
 =?utf-8?B?ZmsrMVcrNncvVlBWdVFVZG4vWXNXRHo1aURvbk1aa3hoRndpU3lMN2JTRGhw?=
 =?utf-8?B?RGZlRlJzVFlwWTZDYno3a0EwV0FlcnZyeFd3alUxYlVsaGI1eVF4TjhyQlZi?=
 =?utf-8?B?YXRjV3dsRG1qc2hTVng0SEpac1hqNXdhVWtCOWlGVTFDQnhlVFNrZGlSVDc2?=
 =?utf-8?B?eCtUNU1ISXAvSVJoSjQ0NHpWdXBtSi9NT01HL3N5dnBPWjdVa1RxeTArYVJy?=
 =?utf-8?B?Mkc4cEg0ckRZYUtaNVNnemVuaHBsYWdCa3puZExVSWlhZnVzdFEyMDU1L0xu?=
 =?utf-8?B?cEJlMkczbVM1ZUw0ekxaNTlITnR5MGpKa0JYbUVwaWFpQTJvY0lWdW1wdUpu?=
 =?utf-8?B?QzlmcG5XcnRUMzhFcCtBM2V4U2puKzB5clRIRHF4YTdsYkhBRWY0UzJIZ1F2?=
 =?utf-8?B?ZnFoa0pCeWE4cXpyTkpmbzdIRCs2SkNIcXJyQk1wZkE4QmdFREpYWG15Ry8r?=
 =?utf-8?B?S3A0NlhGWVI3RkpoMit1QkRLbks5R1lUbTVMbkI0RmZleWFoQjBuNEN1V1hq?=
 =?utf-8?B?K1hPV1VhbEhqY0VONDlBNk9CWnlqNGwvUlN5SWJwNTAyYVJNNFVJbWZla09B?=
 =?utf-8?B?a3V2RDVJbDl6d2ZPYXNGMmlkRGVpT3gvSnV4Y3JjK2tobWxhbEhDNStKVUtX?=
 =?utf-8?B?bVVldmd5SExiUE9mMUoxbUNMeFhvSXJMY0lNa0FSZkN3dnRXazlrQUtkWith?=
 =?utf-8?B?bDh0SVlNYVMzUFFIeGc4d1JMZ1FUemlvak1PZWhZV3RnY21INE5sOGtyUm9v?=
 =?utf-8?B?dUdOd1lRUkVlT1hFTFIzdTVSOU5SdHcrRzl4M0djRjZUWVZROTdEcjE2S0cz?=
 =?utf-8?B?M3BscU5ta0JKQm5JZGFydEZiTHFNTSs2d1g5UmJYTmpyOXZiNDZuVzhMQ0dr?=
 =?utf-8?B?by8vUmV2MnZsL2tIM0ZyUzdJeDdqWDY0TGR1Yk00QXFJQUIvb21NUzkrTUc5?=
 =?utf-8?B?bmF4WVpUUEI3K3NWai9MNWJRWThac0FLZ0M5S2NXcnhLRmRIQy9MLzc2emRG?=
 =?utf-8?B?dEhVbVJpODZNUG9VWmhHYTlKck1kVHg4aWwrNDdaY1RSY3VvRWd2ZWFuNzVq?=
 =?utf-8?B?Q0VrZGJuMTMya1I4aFAyMitDWnowRCtucUUrSVZVWHdRdWNFMHpEdVI1ZmEr?=
 =?utf-8?B?aC9yeDNrZzRTTWluTkViZVBXMXhxZWNBTVZXNnhSRDczU2VBZDM3RmF6YkU2?=
 =?utf-8?B?b1YwZjdZVHFhREtXR082MXFKSU5LZWNVeEx6cXowRlJXWGtIclI1TzRQMEd5?=
 =?utf-8?B?R0xjZVNGdCt5c08yTUcwaWVYdUwwNnlnVzQzNytyT3JUVzBvcHBmQ2dTL256?=
 =?utf-8?B?SVlEdXpaZ0lhRG0rOUhNRG1HVGV2RkZ0NmtjQmtodC9UU25BVVpXM0dKTTJk?=
 =?utf-8?B?TytWUWRoT3UwNGFUWE51aDA2ckZDbkk3c3o2YW9aRjRYSkh1YUhVYnoxYXdS?=
 =?utf-8?Q?pGb0CMe/o8l3UjkSbuXpduv7r?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Q040WFhCNG1yQmlaUjNVNVRSN2VxbjFzTWt3T0lJdjV1OFl3dCtvQmVLTXRa?=
 =?utf-8?B?OW5MWkRZczBTbTVvYWNJNEtwVGxvKzdZM0RQQ3RUN3UzcTdyME9ZaU9sSlBS?=
 =?utf-8?B?NU93WmFXN25KaTA4SXpJMWtFZElSNjJrNFNaTUduU3NSSVU3RU1ocE5kZjJw?=
 =?utf-8?B?MlMxUzRobjA3TmNFeFVyMFJ2cWN4eUpkY3ZpT2c5S29ZenJkVUhmMTg3RHQ1?=
 =?utf-8?B?aHE2Y1RiY2h4aURJNFpvVHIwN3d2ejFJb29VanU2TWVUVVRlVndwSFVwWVZv?=
 =?utf-8?B?U2JPUEhEOUxTVmtlWmVxdVhNZVl4bXRqY0lSWFIzLzRIa3I0Q2M5VGFZZUQz?=
 =?utf-8?B?MG5TZnlXK0hQUWNCUWZvM1YwUU9pYnZvK2JZbTZ2WVFweTNGYjVXZVo4Sll0?=
 =?utf-8?B?YmZBQmZIR1VYZy9NUWhjWnhPVWh1bXpyek9adElzWVVwNEN4cjRkbFJwYnky?=
 =?utf-8?B?NFlub1dVOHRlSmlOWnI0dWJ1Zk9zVFdIelA4bFpQek1nSkNFYWFsaXRwUE9R?=
 =?utf-8?B?M3hhRjUvTDZzTFQ2cEZzWTBZTXRvdVNmNXpPb2k4MzY5Yk4vRjNiVnZLcEk4?=
 =?utf-8?B?ZUp2VGlpOXE0Wk9oWU9VNk85UHY1L3NNU0VnQ1hORFVkZnc3RmhFS0k3R3VT?=
 =?utf-8?B?b2ZPQkVLbXNXS0pScXFaM2dCbE1RWEttbkR5Vi9idHNFVE90c1d3MFJOS3hp?=
 =?utf-8?B?eGlDU1d5UDZZVTI0U2ZKbG5kcHVVSmtFU1BpZXdJZkJvdGJ4aUxqbnZ0dVFa?=
 =?utf-8?B?V2Z0dzBYdjNSWlBBb1V0bW80WldoMFAxRS9yR2ZGczBBdkJxbS9FaGpJTDgv?=
 =?utf-8?B?aDZGSHFIcUZBNFBaZmpZajROQWFnTXhZYW50VGlBdVVVRFJIM1NSWldyWlRH?=
 =?utf-8?B?RG9iUG1rYS9zMWVqV3dENGpQZTZ5bERpbkFvdXdrbjFpb1kvdHo2MFlFVkF4?=
 =?utf-8?B?TWx1bCs4OFRMQll1VTI1cHhDRXc4UnpVdHZZWVdPdFdmODJ6VXVSdnIyVDMx?=
 =?utf-8?B?eTRKQ3d0Tm9DSFVrU2dLaXFmN04xNHdnQmhZMmVLb1o0Q2NTUzQzZy9tTW5p?=
 =?utf-8?B?K0tBVHVKVlQ1anA1V1NuTml5dE5tZVZxYWhJZElDaEhaYkJCTnJTTG9tMWJz?=
 =?utf-8?B?aTc2aGoxazltRW1KeVZTeXdDVklIaWVOanByNkY4b0JtOTAwSndPcmpFcHh4?=
 =?utf-8?B?M0FDR1hGRUxpR2tXYUxFNU92Qm1BMGk0RCs3ZUlJNFdJLzZ4T0R5ZVR6N1Vy?=
 =?utf-8?B?QXhjdHJjejY1MExIci9KNmRZWVEyaktXWmRXZzNXV0MyMjRBc2RmaWlLOEtH?=
 =?utf-8?B?cFp3bUo1RFQ5OHlLNkh4K0NWc0hsN3pwc05zMld2RUJ0TGhyT2dxOGRZeGUz?=
 =?utf-8?B?UVVndGQybTRYaGc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5094d1-8cb3-4542-db79-08dbccab8f8a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 11:49:02.5496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJmx+jCyGZORcVpjSThFV9VHMNCDFgi9oVkjM2a+WiIonrw1RIsuIjX+x21LcLMOrOJpIiSPFVTjksSxyrjbnTIMj2HQtrJR2+4pCD8ru34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310140105
X-Proofpoint-GUID: a_uH7VecOy7E21WyDd8S_eQiM37PBEC4
X-Proofpoint-ORIG-GUID: a_uH7VecOy7E21WyDd8S_eQiM37PBEC4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/10/2023 11:43, Willy Tarreau wrote:
> Hi Vegard,
> 
> On Fri, Oct 13, 2023 at 05:24:31PM +0200, Vegard Nossum wrote:
>> I've now added Steven Rostedt and Willy Tarreau as well on the
>> off-chance that they have something to say about it (Steven presented
>> his conflict resolution method at Kernel Recipes and I think Willy is
>> experienced with backporting), but this is in no way meant as pressure
>> to review this patch. Here's a link to the top of the thread:
>>
>> https://lore.kernel.org/all/20230824092325.1464227-1-vegard.nossum@oracle.com/

(Adding Ben Hutchings to Cc as well for the same reasons.)

> That's a very nice description, I'm sure it can help (and I learned a
> few points there already). There are a few points I'm not seeing there,
> though, base on my habits:

Thanks for the quick and comprehensive response!

>    - in my experience, there's a huge difference between backporting
>      code you don't know and code you know. I'm dealing with haproxy
>      backports several times a week and I tend to know this code, so I
>      use my intuition a lot and have no problem adjusting stuff around
>      the conflicting parts. However when I was dealing with extended
>      kernels, that was not the case at all, because I didn't know that
>      code, and worse, I wasn't skilled at all on many of the parts I had
>      to deal with. While it's OK to take the blame for a failed backport,
>      it's generally not OK to expose users to risks caused by your lack
>      of knowledge. In this case it means you need to be extra cautious,
>      and very often to actually *ask* authors or maintainers for help.
>      If maintainers do not want to help backporting some patches to an
>      older version of their code, usually it should be perceived as a
>      hint that they'll find it complicated to do it right; then take that
>      as a hint that there's little chances you'll get it right by yourself
>      while ignoring that code. This may imply dropping the fix, documenting
>      the area as broken, or asking for help on various lists until someone
>      more knowledgeable can help.

I agree -- backports ARE very easy to get wrong, EVEN when you know the
code well. This is stressed several times in the document, especially in
the last two sections about build and runtime testing, but also in the
section on error handling.

However, I'm wary of being too stern as well. There are already a
million ways to introduce subtle bugs and put users at risk, but we
rarely try to put people off contributing regular patches (at least in
this specific way :-P).

Did you see this meme? https://i.imgur.com/yk5rf13.png

I think conflicts have a bit of a bad reputation exactly because you're
presented with something that's hard to make sense of at first sight.
I'd like to dispel this myth that you need to be an expert to make sense
of conflict markers. I think with the right attitude, the right tools,
and the right approach you can go a LONG way. Also, nobody is born an
expert and we should encourage people to gain experience in this area IMHO.

With that said, how about if we add a short section near the end about
submitting stable backports where we encourage submitters to 1) approach
the backporting process in a humble way, 2) describe the reason for the
conflict in the changelog and their resolution, 3) be honest about their
confidence in their resolution, 4) ask relevant maintainers for an
explicit ack?

I'm open to other ideas, I just want to make sure we strike the right
balance of encouragement vs. discouragement.

>    - the tool that helped me the most in resolving rename conflicts is
>      "patch". As you explained, "git am" is a bit stubborn. But patch is
>      way more lenient (and will often do mistakes). In the very old 2.6.32
>      I used to rely on "git show XX | patch -p1" way more often than
>      "git am". For a rename, you do "git show XX -- file |patch otherfile".
>      It works the same with file-based patches or mbox: "patch -p1 < mbox".
>      Patch however will not place the conflict markers and will leave .rej
>      files. I then opened them in an editor next to the file to edit, to
>      locate the area and copy the relevant part to its location. Emacs'
>      ediff is also extremely convenient to pick select parts of each file.
> 
>    - control the patches: after I'm pretty sure I have resolved a patch,
>      I compare it side by side with the original one. Normally, backported
>      patches should have the same structure as the original. Using whatever
>      editor supporting a vertical split helps a lot. Otherwise I also use
>      "diff -y --width 200" between them to focus on differences (typically
>      line numbers). It's not rare that a part is missing, either because
>      I messed up, or because I forgot to process a .rej that I mistakenly
>      removed, or because a file was added, I reset the tree and it's left
>      untracked. So any difference between the patches should have its own
>      explanation (line numbers, function names, file names, occurrences).
>      By the way, it can very easily happen that applying a patch will work
>      fine but it will apply to the wrong function because some code patterns
>      especially in error unrolling paths are often the same between several
>      functions. It happened to me quite a few times in the past, and even
>      a few of these persisted till the public patch review. That's really
>      a risk that must not be minimized!

There is a section on this: "Verifying the result", and also describes
doing a side-by-side diff of the old and new patches.

The bit about applying the patch to the wrong function -- I doubt this
happens that much when using cherry-pick, since it knows both sides of
the history and can tell when code moves around. You're probably right
that it can easily happen with plain git am/patch though. In my mind,
this is an argument in favour of using cherry-pick whenever possible.

>    - something quite common is that as code evolves, it gets refactored
>      so that what used to appear at 3 locations in the past now moved to
>      a single function. But when you're backporting, you're doing the
>      reverse work, you're taking a patch for a single location that may
>      apply to multiple ones. Often the hint is that the function name
>      changed. But sometimes it's not even the case. If what you've found
>      looks like a nasty bug pattern that looks like it could easily have
>      been copy-pasted at other places, it's worth looking for it elsewhere
>      using git grep. If you find the same pattern, then you search for it
>      into the tree the patch comes from. If you don't find it, it's likely
>      that you'll need to adjust it, and git log is your friend to figure
>      what happened to these areas. Note that git blame doesn't work for
>      removed code. If you find the same pattern elsewhere in mainline, it's
>      worth asking the patch author if that one is also an occurrence of the
>      same bug or just normal. It's not uncommon to find new bugs during a
>      backport.

Very good point.

I think this fits very well alongside the sections on function
arguments, error handling, etc. since it details a specific thing that
can go easily wrong.

Can I take what you wrote above, or do you want to submit your own
incremental patch? I think we could insert it almost verbatim.

> 
>    - color diff: usually I just rely on:
> 
>       [color]
>           ui = true
> 
>      But I also recently got used to using diff-highlight that will
>      highlight different characters between lines. It's nice for complex
>      "if" conditions where you don't see the difference, or for spaces
>      vs tabs:
> 
>      [pager]
>          log = /usr/doc/git-2.35.3/contrib/diff-highlight/diff-highlight | less
>          show = /usr/doc/git-2.35.3/contrib/diff-highlight/diff-highlight | less
>          diff = /usr/doc/git-2.35.3/contrib/diff-highlight/diff-highlight | less

Right, git log/show/diff --word-diff=color can also do this to some degree.

There is also core.whitespace/color.diff.whitespace that will highlight
some common whitespace errors.

I haven't used diff-highlight myself -- I'll give it a try.

In this case, I was using colordiff specifically to do the side-by-side
diff of the two patches since it handles the <() shell syntax _and_ does
the highlighting of differences between the patches.

>    - git add, git add and git add: when fixing patches by hand, it's very
>      common to leave some parts not added (especially with | patch -p1).
>      It's useful to work on a clean tree to more easily spot untracked
>      files with "git status".

Yet another reason to use git cherry-pick instead of manual patch
commands: it keeps track of unmerged files for you. ;-)

So I'm a bit torn on this. I think in this particular document I'd like
to encourage the use of git and doing things "the git way" as much as
possible.

>> I feel like in the worst case, somebody sees the document down the line
>> and vehemently disagrees with something and we either fix it or take it
>> out completely.
> 
> No I don't disagree and even find it useful. If at least it could help
> people figure the pain it is to backport any single patch, and encourage
> them to help stable maintainers, that would already be awesome!
> 
>> I'd like to add that my impression is that a LOT of people *fear*
>> backporting and conflict resolution -- and it doesn't have to be that
>> way. We should be talking about merge conflicts and what good workflows
>> look like (one of the reasons why I was very happy to see Steven's
>> presentation at KR), instead of leaving everybody to figure it out on
>> their own. This document is my contribution towards that.
> 
> I'm not completely sold to this. Yes we should teach more people to
> perform that task themselves. But there's a big difference between
> backporting a few patches and feeling like you could maintain your own
> kernel because now you know how to resolve conflicts. What I mentioned
> above about dealing with patches you don't understand must not be
> underestimated, that's the biggest challenge I faced when working on
> stable kernels. There's probably a feeling of shame of not understanding
> something, but I can say that many times I asked for help and was helped
> even by top-ranked developers, and nobody ever laughed at me for not
> understanding a certain area. But doing that in your garage for your
> own kernel or for your company's products is a huge problem because it's
> unlikely that you'll get help from the maintainers this time, so you're
> left on your own with your own understanding of certain patches.
> 
> Thus, yes to backports, no to kernel forks being a collection of
> backports.

Right; almost every time I talk about backporting it's really in the
context of contributing these backports to stable. I'm not in favour of
forks either and I'm not trying to encourage it.

Let me try to come up with a specific addition related to the changes
you requested above and see if you agree with the wording.

Thanks,


Vegard
