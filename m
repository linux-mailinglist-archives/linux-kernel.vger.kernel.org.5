Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561617E4386
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbjKGPcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:32:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjKGPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:32:41 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9CD19AD;
        Tue,  7 Nov 2023 07:32:37 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7EXHoO019105;
        Tue, 7 Nov 2023 15:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0Yy6D4dvT2wh1biSu29RWXoC0sZ3uSEJn9KL1i8ZZi4=;
 b=Cx3fiP1PO7FTy5y+kmFrYB/zxArOD7sg0ityItFrqGPviftZXwNqM4DlnSXoAUBwzh2J
 pkRq6jwuXyiArYWANXG16AHJGMBmW2eCrpqUrPK4DCbzegxoq/x+eJrs5mQji5+MAYui
 a0k1to6Symk2iVxQO56J5GTPsKJ++qs3wSaobeZc3/AvYiMeuG53WyAAJPAYKj2cac5z
 VhDCwRjrsL/WwGdPME+KD/Jf4sbod0/ec2AjQgb50j71OdThN3M7leWmHrZ5h1qZ0JL0
 Kh2Rz2h9EL8qXJi7TffF4bZBbzU6tKwnpITl+omGBCku9Po+3rX577Fr+Dh89gERxVwl 9w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u5cx16bf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 15:31:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7ETBSs026807;
        Tue, 7 Nov 2023 15:31:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u5cd6ys0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Nov 2023 15:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhtwGbP+2q7LX4qF3HMNBpNm1gmRtSpvXl6Ee4WG1tlaDeyMJlhtYfYpuF99uFcYmklYyGHTcQB0jN0Fy5Lt7FkAkREKDcrz4mevboTNGvTd1AOtCa4IkM+7DNVWfsKNWMfUBPkHnzGnbcEeeiNw52EYNeoKRfhKpbQzI95GEKz1Feo9PF1abh2DZ0clBHNhhpjimwTFB8eYBN5N5KeS/E8VWPtANb3ILXavOP/A6suMUenFX7em6cDcV2q5B7r5vucO+P2kok0baLeVj1R8INTQnRFDlXwXcqoKrBx+LOZHv/JCoO5hfAbXUSYVvngZWX5tHowESJguhe32lcFJWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Yy6D4dvT2wh1biSu29RWXoC0sZ3uSEJn9KL1i8ZZi4=;
 b=f/QuG1dolbTkjObIeJRxNxHQ0145yaedDCRHs6JkLpJHkkVlNN/xKmR10K716oY0MYkGxL8QI/nHSu4r+NnBd/K4Nd5/5rjmASGghFSRlmMnwbydl8z7OXTgoV89Zbf/26Q3wZ4LZkvH6220fl5hf+IN3XRpIO23kKYWPBrRo+gxREcSbLR4ifNNxSnJeX3P9XnisCtVy3JduQ8a4v9ZSInFNvtfw3ZNyM3FZ3aWUznpDdu4Iob9KLORkhE5Ckh/roFOLMRuYayDisWmALPTHnddWUe0HAN7D7aYv2+k4aazY8OETMaqAVlIRbZVcjte0aGBNUvTnHfl33I5cLAOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Yy6D4dvT2wh1biSu29RWXoC0sZ3uSEJn9KL1i8ZZi4=;
 b=G4tlqZoUv/mDUJEQs6s7dbXt6DNGd5w0XhJ1GUjNs9jWk/m4+k9bm5+cfDap+Kjba9vtlH6/6S224uu9TIkfvLKIY3dECqQH2x6ps7jYe8ymp7wc+TvcLRJSMRQuLjEEpcHnhMSvTXaW7KG7qIXtr6s/MNDdc4WF+j5k/3cBy9Q=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CY8PR10MB7339.namprd10.prod.outlook.com (2603:10b6:930:7a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 15:31:44 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::7e79:4434:561d:fe1f%5]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 15:31:44 +0000
Message-ID: <77274590-9efa-4af2-bc38-0b0043da86c1@oracle.com>
Date:   Tue, 7 Nov 2023 21:01:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 00/74] 5.4.260-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231106130301.687882731@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:3:17::16) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CY8PR10MB7339:EE_
X-MS-Office365-Filtering-Correlation-Id: 7224de66-5ad4-4e26-f9e3-08dbdfa6a57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LG+V2ooCbh1v/uIa0VPcEEX+2dRFAN1NMhXyRLGRz90pFJjFdJnvbE792oim216BHdeG+7dwPvmVyiU5o4sersocClg6socxz8qfZHAKO6IiyB0RhGDBQSjjk2D7I/IFY3scv+nFMTLwdBY14X1RNnobeqVOdVPwDrUrOfB9QKH0tqLWB9iqIa9zzftCsi4kVxJWocRgR0VwFsXSCsrJp9RRaz73h4zRbJrVha4PB8tSxT8r/ByUiBayW1vbLRgEacfxmNTVlZlphuliGU1mfcBoMOxWF8xj1CzOTor/onVUkwamOZr8wPM28i48rf2GeJFrmbvFDs7qtL7uIvP6O2isICaxI7o12eL/Qb81TzTZheNLn4as4xCPEeZo+MC8rD6B/GqZDVEF1aQH+flS2j1hiv3Ep4NkzBLj0sXuSBnWIxwoE0xmeBWmcp4tzTLsI5xoFsSfqg+TspIKVhtsAPKxinm5bYoBrh2WO/TXWWjolbF7henJUSwZZTDs7GaatW9S5Z2ueZf29QRGs47XKZ4SVqTUwxVRqbDs6/N6EyPeLQHimOkX/WErVDKj0uX93DLS6qM9cST5jI1rAjbcLHWALy9o0ePDCI273YTLDSHT4mgd291gghrlyGy2nOX/UN/+RxMQx1saa93H844eEA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(478600001)(53546011)(38100700002)(966005)(6666004)(6506007)(6486002)(26005)(66476007)(54906003)(6512007)(66946007)(66556008)(107886003)(2616005)(7416002)(316002)(5660300002)(8676002)(2906002)(4744005)(36756003)(4326008)(86362001)(31696002)(8936002)(41300700001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1NGVld5eTY1NEl5blVZa3dtV3JTc1pwRkFWeGNPL2FwbzBrbWZiQ2hkWFEr?=
 =?utf-8?B?eVAwdkgvUXZxRDFwdTdmbjBsSXNGdkM4UlFTUko4a0daWGsxQWN1QUhQQlhi?=
 =?utf-8?B?QmtnNlpyeGJGOVo1U0FQSFZKcFVQWDVLUkxaTTBqUHZIQmlQMDJUR09lSlhY?=
 =?utf-8?B?ZmR6WnpIbzVWazZJbWVGdWNVcGxyakN6YS9RV1RGbTJ3aHNwVEJCQUFFQ0pL?=
 =?utf-8?B?amJEQlNHSEJUbXg3b3JYeHVTVzc2SFE3eTJDRGZkZktrWGd3ZVV5ZjNkZlAy?=
 =?utf-8?B?cHJNWE1mcHY2QWc3cHlFUlU3NnQ1MjVVNmNJaU5FRFczeWtidFlUUTZ5Wmxn?=
 =?utf-8?B?RGx4cmN0N2t1VEgyUzZBMWpxOVRGbjdOVCt1M3UwcFpQSlFKcVdHYjNQand2?=
 =?utf-8?B?UFcxeVlBRzlxemw2ai9BZGRoT3FvVXdKdnJMOXE1NkFyQnJoVTFHUTdONXdG?=
 =?utf-8?B?bVlRd0VoOGVIQXFwT2ZSMGExdWc4d2daOFRsTEV5T3luRWI0b2ZNOTZOdFB4?=
 =?utf-8?B?VHNZbmN1L3Z2ZktxdmlINVFBVUp0Z0JvSVQwTER0TER6Mk96cXVFS1ZydlRL?=
 =?utf-8?B?RjZEb1lKbitpckpLaXNWek5EWXVWeDM4WFM2aTlmRjNLUHNQdStTVGlWbXg0?=
 =?utf-8?B?alJlSDNvS29rbmdkUWJQMkVpOFRHdzZrR0k2THZpQWdDL3lhRFhPbFVTR0Mr?=
 =?utf-8?B?ekZJVDFmSWRWVFh1bXp4M3FTaCt1NEJFYjdSeWt2aXo3R3dGeUNCZ2tVNHI5?=
 =?utf-8?B?MlcwS3dDRkU1R3NPdHc0ekNwc0xXclBLZ3JYaUFGMG1tTHIrcG8zbWNqK25k?=
 =?utf-8?B?Mit0RGxjVmtrOUZ1Si9WcHFtMzFJOXFUcElEU09MbFZBdnlMcTZBVlVYYzMv?=
 =?utf-8?B?YkgxUjdpYk11c0p1RkhGUDM5cjV2STNoWjhVM2RJaDRVWXliRXllbnpiSW43?=
 =?utf-8?B?d0Q5ZlIvWDNENDR6TCtyZzhOSTUwM3lMK0FDdldYcjBhamdDZEpnc2FOdEo5?=
 =?utf-8?B?bEZBa1NpZUpFS1FIeEpVMG5YQUhTai9ueVFEUEkza2grNi9PQ0tCWE1QeDdx?=
 =?utf-8?B?dXQ4T0ZEUHpudTVhZjdQMWxxWFd3RXREcDVwbSs1cFVlRUMvS1hqcmJDSVIx?=
 =?utf-8?B?TDV2MU5kWWlQWnR4VDl6SlpVVVk1MnlxTGV1Vi9JSm5VZXIrWFJhbm5MOUJ1?=
 =?utf-8?B?bm5PMXRvYk5oZERCSFRyUStkWUtQQ3R3ZDd3YysySHpBQ05LTll3b2lkRG5p?=
 =?utf-8?B?ZHI3R2g3bzdENzJRRDRPb1NzY0tVR2tuZitwSTNjeWpEeHlWTTFzRmNuRFZX?=
 =?utf-8?B?elVrbXpGT0dtQWZLUEMzM3BHbnJOM09NVkh6Y1EyS0YvMTJzZGRvV1NlWjYy?=
 =?utf-8?B?cUlOdTNENjVvWGxqcjNFUjVHbDR5K0tFY2Z2YmhIRTcwZ1RTNmkwTmJrQ2xk?=
 =?utf-8?B?Zy9JOG53bWdlbnl5Q2ZiTnRqVUtPY1hlZUtTQkZqY3JsWEZMMDdyakVHc2Vr?=
 =?utf-8?B?UDE3OTgwUmNCNVVzbGhzL2l2VzhDTVl5RW1qWWVEWDZlS1NUZGFNdHhROStD?=
 =?utf-8?B?ZyswS1gwNEhzenZLZEEwRnQwUkFGQXVhY3QxYUVQUzdXblJ3ZVZSdTU4L04w?=
 =?utf-8?B?RmlvdFl4WlBYTlpPaGw1QytGSHdkQVluZG5HTUNHclZ1Z0hFM3NLRDRwdDhB?=
 =?utf-8?B?d25lenRjNXJORTRySW0vdmRjMG51dUVNZW5HdWlSMkl6VVZkQXJ3SHE5Nmkz?=
 =?utf-8?B?dDZrTWR5eXgzNFE3LzdMWlJUTHJheVBCQW9aVnV2dGtaZDZldFJnT24xOFRq?=
 =?utf-8?B?bEVWcVFwVW1ndUswS2s1eXlVTHFRSDVyblZNa0dvNUxzUWJId0hLRDBzR2NY?=
 =?utf-8?B?eUc0N2lMRFRXZTFielhQVXFTMDd6WGVaTDBGaTJUcitCeEJmOXMvWk5nUHdR?=
 =?utf-8?B?czhnc09uS2dqSUVIZC9HZ25Pc0NtSzZUelk2RWs1UmFScWFZOEhiSkwwbWZM?=
 =?utf-8?B?bmhoOG5SR1FGZlFMdThLM0labG4xbFUrdGt4OEFJa2xOZnNsWWw3QlpDRnRC?=
 =?utf-8?B?ZVQ4Rm12SG81SVlCVTNQVVYrbjdxQnZmZ0R1K3lPelIyb1FJWmNkZGNWRkFI?=
 =?utf-8?B?dGY2UTRJblg3R1pNWCt6ZUdHN01lUnFLdmhDa0xZbzJRMFREeW1ZR3I0VmFY?=
 =?utf-8?Q?fzIIeSOOY8dtjxnBdkZLOT0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?T0lsUDVTakFzQ2lIOE03a2ZTQ21NNVVPOUFPY1lrSWxZaVUxQktDaHpWTFRB?=
 =?utf-8?B?WWV2d2ZYblhVMlFzNXJOZzVUN25IcDE5ZVNrbW9Od0hZNVVKM29za3Z5cmFX?=
 =?utf-8?B?OGRxSXc4dDFTOWhEbXc3b0NzbzQ3OHNaRk02Skt0eG5pVzhYSGhvY3NZMloy?=
 =?utf-8?B?N2VHaDBRTmpSL0NPaXNUQzB2TFFmNDlCYnM1SUorL0dqRFpMRnJmcjNKTTlS?=
 =?utf-8?B?Mm5URVN3SlZHd0JZM1pQaHdiNFllZmwzQWozcGZEbTkwS3gxSWxJV2FMS3Fw?=
 =?utf-8?B?M0dFVlNoRHExSWlCREhCcUlYZFh3bVc1YWRNOEtSbDlNdWFOankxUllHRGdq?=
 =?utf-8?B?ejhsOUxockh4bmpVcjlnUGlmcjRGR3ZQdERGK0dyQ0x4emVBTFhRTEhKNk1B?=
 =?utf-8?B?Y3Q0S3ZCaDl3MEI5ZnF2aVg0bDZXU3B1aE1BTGkzLzVWeTkvaFVrcnI5M0hY?=
 =?utf-8?B?NXN1RnFVRzFIajZDa0c4dTFrQ1Nobm4zbTM2bnFGNkRCanJRWDhJaUgvL1ZS?=
 =?utf-8?B?WGNScUI0UGMyWjBkb0ZwMVpCbTVYRFBVKzNvZzkrTUM1VE1ONFdydktpckNp?=
 =?utf-8?B?T2pta0RLL2dicGlwUTFxTWlvaW4rNzRKeWR5ajhLdVZDL20xU1pha21KeUJS?=
 =?utf-8?B?N3dqazJZZGpnZHJJVys5SEd5SFpYUXpOOUZLNTU1TGh0MDdoN3FKRzBLeXY5?=
 =?utf-8?B?VTlacHdseEpnejhWQUZGYURCRnlYNHVEWVRwaVUxdmtNOURxM00zSEZMTmc4?=
 =?utf-8?B?RjAydytJLzdUdXNqOVdiUWljOFpOWHZpZm4wcmFDZndBaXlCaXhNZCtZOHNm?=
 =?utf-8?B?RExHdldUdURQdVN3M2pjNFBWMXQxbVZ0UzdIbmhYWENsWW1ha1pUYUFsQ1R3?=
 =?utf-8?B?eHZ5aUhkaFpNYlBZWnJnTnpxWW9veEMyZjN2TUM5emtxYlJiR3AxYlZ3blJp?=
 =?utf-8?B?WDdmck00T2RzQWxjYmN5Rmh1ekJ5a1dHN0RINkpkSUF6UGZmMExOQUVNOGpk?=
 =?utf-8?B?SWFRT05kTXEyUjhXckRYMncwMFBHSnRNeEZIdC9nenZ6WmkzU2gvNklHbmlP?=
 =?utf-8?B?V3h2UXdEYUhkcmZDcGNZZGVkcmRFNWVrVVFqS0VUeUtadGNsKzlRWnZUdDMv?=
 =?utf-8?B?cUk1UFFPd1NYclV1Y2UzSDl0Q1VrZi8yeGlwd1RraDd6NWhxdWl0ZU9Rbnhz?=
 =?utf-8?B?dW1LcWQwZXo4S1dEM25mSW9QOGsxd21lcGpjME1rdkljNWx1S003UGQxdnla?=
 =?utf-8?B?bzRxaTlKOVZ0b2dTbVQ1TkVLWTQ4VTlvSURMR3ZYYUpFMHR3bVc3L0FzRU9o?=
 =?utf-8?B?MXV4SURST2dLaGdDc1dPK0hPcEJCdmZubkVTZ3pCdnNsTFlCeDVMWm1qdXY1?=
 =?utf-8?B?SVo4REJ3aWR5ek9MVnRWQUduMkN6T3YyWUJ6YjM3anpoSkRkcGF4N01GeFc2?=
 =?utf-8?B?Nkx4QzhOMGV6aUxzdm9NZERQampZd2VqTVhBZlpSRzk3NzdsL1A4dnJ2Tkh1?=
 =?utf-8?B?MlVkK3pVNnVVVE9CWWUydStvYXVtYmpZazdoWS9DbGV4RHNZeE43ZFpyNWY3?=
 =?utf-8?Q?tixm6txfIXIJmfmgVf4ahjPd+kYkcVP2A+oy1RPCDIzZxf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7224de66-5ad4-4e26-f9e3-08dbdfa6a57d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 15:31:44.0319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HlW5z/yAJoKaLOvNv4rEkVuLXdgdMuBti3WmGK53FFsVdxHcCVMKNeRkE0Nm6H0hVGrAQqcdKDBQZ4+kDFjHo3F0eWs0zEf/Tzcabo1DR35VI5O75IityYl8chLeLpax
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_07,2023-11-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=984 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311070128
X-Proofpoint-GUID: Dt1dA77JvmVxlkRX7u47oZmGOW5Rqyj8
X-Proofpoint-ORIG-GUID: Dt1dA77JvmVxlkRX7u47oZmGOW5Rqyj8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

On 06/11/23 6:33 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.260 release.
> There are 74 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 


No problems seen on x86_64 and aarch64 with our testing.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit


> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.260-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
