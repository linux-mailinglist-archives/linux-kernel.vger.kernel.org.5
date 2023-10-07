Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A3B7BC913
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 18:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344073AbjJGQbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 12:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344074AbjJGQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 12:31:29 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A134BC;
        Sat,  7 Oct 2023 09:31:27 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 397CClEV030451;
        Sat, 7 Oct 2023 16:30:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6SvxVYKhqVoG/EwZ2vzxJ6gpUI0z605cZ2GT6uV28KE=;
 b=qsj3Z/LIg+yuDk0tHXEbIc/8rvBa1f2bQUMk7OvkC2rnEuSXH+qux6BvOEM1wH7sH+21
 i5Vr/eaxt7cIhaEaHKcgTGiovR4MtL8ngV0CIZKZx73YADBKJq3iaxDlk1A7HMnv5nW4
 puh2jajLzFuy9CVzavtkQQrMmvV9HLgiTYfRnnvVKpsGHDjiaAw31rNFKOKinV0nEV9M
 rLxf8hv9srY9m1wef5oZVda5rr6O5SDtn67SkwTrqzt1flonC9hL1tUPTApl3F/mf4rp
 FgItZK+3e7MGL4gyHExMwBhgOBd66k2z79m7t3zxByHekRERjIThQ/tFsMI+utq+JKQx 1Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tjyvugj8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 16:30:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 397F8YhW021474;
        Sat, 7 Oct 2023 16:30:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3tjws90w7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Oct 2023 16:30:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y6BrS6dsXG7OxQh/fZzEHR3wjxn6+kR1IfxFLosfkDmn+0H3JDpRiT/VsqFIfq3b1X2fOfQ0d1m4adsO5vADGZbjPuGPNq8Oaz10EaBqH0OvPBa4u6yDiXnfaMYrHPLDDqrvn6243t0O9QjBy0vxyrQnMv91cye/a7gEOIN4s81wHT5ash7jgaGfYdQ7r+Y4fLI2kmr7T0+HxutGTqsQnW8T4SeW4eFmFf6Up9OVNRDVptIvw5fMTtV10Tkns1P5kCcN6hmexUMm3qOkq8eFNhZAc7NwLpb6Xru5tk1M9jgQfw20QLo0pgDx8dQrExwuF/Zt6RlPQgTaqWdLmQwUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SvxVYKhqVoG/EwZ2vzxJ6gpUI0z605cZ2GT6uV28KE=;
 b=Jw0XwjmZE4mNkWeGjkmX/kjBQu2/xGRjoa22BhnfGdNgDWQeul+vm7ot9ZVSaxAyBAFE0BYW5cvhSSIPyJbToRasTRsJMVsziIOVtBWvVHwCMBiSGM6a0SxdlLmXwRMXMOKn8Puqc30BjylXfwycb8Aqf5ip5FJwsHsMfBt9irfi238tjV6J0D2qRzQlGmxmGavOXhgR+FIXx2abcMbyFpgw7/tZcwsIDBaHCGX6exC5XxjBF+JZGoyy9uVupk9yOKMrcbSVsGgjY9P2IkX7xlKtGWeQdmkWUCW+YkJyMovUbjEAh2tNznZwAsb5G+njZE9A18ExOyaPNe+ng4xqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SvxVYKhqVoG/EwZ2vzxJ6gpUI0z605cZ2GT6uV28KE=;
 b=NBNCvro1i7UjqiT/AegKuYVGYqPtKaTMrSM2sZ6jip7V2os51u5n2He1Mpd3k6OBRMWSAgZ3rzYiDuq7oZYC29zmLT0jiJWpiQx2AC1waoYSLdO81MNLjW2pYg9EZ0ndF5SxrhKzCvQD6VP2gyJ/drUElA/Cnu4btuuTfk8yALA=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Sat, 7 Oct
 2023 16:30:37 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6838.040; Sat, 7 Oct 2023
 16:30:37 +0000
Message-ID: <5ae47535-b6e0-8b48-4d59-a167e37c7fcc@oracle.com>
Date:   Sat, 7 Oct 2023 18:30:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC PATCH] Documentation: security-bugs.rst: linux-distros
 relaxed their rules
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, security@kernel.org, corbet@lwn.net,
        workflows@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Solar Designer <solar@openwall.com>
References: <20231007140454.25419-1-w@1wt.eu>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <20231007140454.25419-1-w@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0106.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::22) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|BLAPR10MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: ef20b1be-4446-4b84-2569-08dbc752b0a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9E6aYuqeXTCiHqYwTMqZlqkpGxBnkZM6eOMQ/VDbjZR9f8PeVe3nU0HT8WU09UA9swgnNNAc2rIJfL0/OV9a3s46A4FFX0aGzKy49o74S8b0aN4azPB+qxGbKSD33lNVv1FohKKN5AAx1b11LL/gWZWyD72kMGmWen6eT+FbTXZRvndKj3DutdkI+vR+2B1c3plUstwX6CGbi9Nwm92p2vynBRnS05YmAuhCiczUuHuyj4v0TiZcb+ZsKpt6m913d+rNfayFLLaqUfOTag9S1Nze1rfMXSJ5PwYixR76fC2Ih3OPkg5zImvN+hx+0IkSBtTzGppRndIs6xE9tXEAXase6kbLmclpLDjhSnLmPKt5uRyvISu6Fk6VopbmtAZcIh9hBp+mhbvsSg8isx5NQ6n8rMkl++Vb/C3GqEPp0uwuzadIt495x7x1JXXnaSIBc+MurzYcj1UZtsCd1QxN/urdKwMBHTs0u/hnAl5GdnV2zMi6qQ1bx7JZmPFNV5A0WWT5rPF4ZM171z19WU49IHlVzFZvmVSGRAOeo0BUaYf5m2L2dbIl7iPnMOzibKK9lOZTtfwPhCpidW0U6ihFCYH6mJNqhqf2tSl7v7j6I/LsUO65TaZK8Hlb1TVAikgAethtFWLyLhBQz9oyZ9D2MPjEUzz+75b12CX+Xs69EiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(396003)(346002)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(31686004)(15650500001)(44832011)(5660300002)(8676002)(2906002)(4326008)(8936002)(41300700001)(2616005)(66556008)(316002)(66476007)(54906003)(66946007)(26005)(6506007)(36756003)(6666004)(6512007)(53546011)(86362001)(83380400001)(38100700002)(6486002)(478600001)(31696002)(781001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjloOCtQS1BiMGZ1cm1vRm8yVTc5Z3pzRjlqTlVaOXNpQS96Tmw3ZmFTb0xq?=
 =?utf-8?B?clJ1NjdtZ0lOZEdhR1lQcFgzdFpHRVN0VGpYS0dOMVVEOHZWSEN2M2hJNDQz?=
 =?utf-8?B?MmkzVG9lV0k4MEdRVlgyeHNuMVZjcFhhOW1OZEtFMTFMU212RE5TU1dKaHpw?=
 =?utf-8?B?M2FRSXF1R1hyZ3drVXRDNE1uVW1iZkpIdk42cnhzT2JCc3Fvb0ZNU3VjbWov?=
 =?utf-8?B?NVY5NHB3eEFQTjRlMVQ2cGFXUDNidEQ4VkVsWjRrRHQvYXBKODEvdFVqUFFo?=
 =?utf-8?B?MmZ4VjdYYWxKSjV3TDU3MzN4SlQzdGRwYS9qdjJTaW5iUitmV2J5ZDJXZjJt?=
 =?utf-8?B?MUJSbjdnZEgxU0w0MmNuZzNxWDQyckxSRVdDZDZzZzJJVDY2eUdzcG50OWxs?=
 =?utf-8?B?TWFjWVpqVVdWR0QraEU4RjY4NmtUb3k1VUR4cVdCanpqVzJXeHpEM3ZVMHJY?=
 =?utf-8?B?MHVzQkFicVA2LzRTZzcvUTQ0a003ZGprWXpodlQ0SlVIeVMxaHdublFjU2dT?=
 =?utf-8?B?dlkvdUF6TlBSOFQxdldacWFoMGg3RXFkNFpRUjZlSVBOeUtMRkEwUlNjcHI1?=
 =?utf-8?B?NGtLYU5ScU42U0J5UHJZekJkU2FRdnFmV2l2UG9hdU41eUhUbTN5eUdXSSty?=
 =?utf-8?B?V0s3RlprL0NrMnhHUTNNbTlRTTQweGtkUFc0Y01rVHpzR0NzTi9mYUxvVTdE?=
 =?utf-8?B?R3ViZmV6dXArSHV1L1QzK0RvdlVTVlVDZVhOQWFNdWdOc0NSb1hoRnFXUUp3?=
 =?utf-8?B?MzMrbGVZYUNFYWgxM2tERUNoMFd2QlJXWUZqVWtqMTQzdjQ2aFZnbjFtajJj?=
 =?utf-8?B?UFowbERMUmxyTDhQUWREL1NPVmFnUlczSG9iVTFNNDVka09YaUtUczBiM0Ex?=
 =?utf-8?B?elZXeFlLTHd6ZEVvMkZiUCtsQjlrRzVEVlF5aVIxNGNxVHZFRlU2Z0xLR3lY?=
 =?utf-8?B?YXg1a24rQ0xTTG5WczdKbGhDakpqdVZMTUhYMDdFMVFHQkUxTVIvUE1SeTV1?=
 =?utf-8?B?Q2pwRHgwZ3lMUFUvd2xGYUVHRllSZkphNXg4OGpOTHAyTHF1Q0xDNXMxaEtK?=
 =?utf-8?B?VFBjVk5pMDlSVEI0Z1VnaUpEWTFmbjg0YitKV3BOZkowVDBYNnhsUHliZ0RG?=
 =?utf-8?B?ZWtJaXpTeW5sWVRyL2JzV0wvMGhVUjU2bkhCMnQ4VUM4d29obVRlRXZwS2w4?=
 =?utf-8?B?cU81U09ORU8xaUo1MjIxbVYvaXdFeXJYWWJIWWZ6MXRDQjV6anllblRQVldu?=
 =?utf-8?B?djdxc0tFNW5aTFJWY0lHeVB1MlZxQWEyMnpNR2tHNDhNaFZkRHVNeUYxVzNP?=
 =?utf-8?B?RGNKVStVNVh4OWhxTm11S0lMWis5QnF6OE5oRkVNZFdpTFNub215RzJyTktl?=
 =?utf-8?B?WGtoTytydzBZZEYxNTlsSjc3TjFVaDNHYVhaaHFDVXpyenFVcnZyWE8vQWNY?=
 =?utf-8?B?SmM2dXJVRkhDU1NzdVZtVkJWWmlZVHVGQ1YyS1Jhalh3WjRSbkNhV1dlM3Jy?=
 =?utf-8?B?UVBycGR1ZyszMlNHb1dCOStiTStPMEh5UFU4RjR3UGo3eUFSUU90bjJySFk1?=
 =?utf-8?B?MWk2b0k2T21pRTU2OW5ES2E1cVdWZkJ2YzFlZC9TeHpFV3lHQk9IUkpMUnF4?=
 =?utf-8?B?dk90bHYxRzRkblJnOUhMMis2YmNqZzRvSjBBWmJhTHNSaWZnOGlqSW1WS25P?=
 =?utf-8?B?ZVljYURPTDRLMEVrSFFkSUkyaGM5ZTdmNGR4bCtSWTQ0aE4rdzNSZ3ZidEdk?=
 =?utf-8?B?dU13QlJZODIrelViNmNxc2YzU1g0TWxlMHJ2blBNbzRscERLWFZ5dzRPaWM1?=
 =?utf-8?B?cVZWdHhodlNTZS9Sdi9IMWVWM0xvR2ZNTlZQUjBObi83S3VoTW5pYnBWcFBD?=
 =?utf-8?B?YU10Uk5QNlpJeDBJSFlXSUFxOTlKY1NQT1Rmdi9VeUhVVGsyOU5mVndmVEw3?=
 =?utf-8?B?RGxybEpaTXlzTWYxY1lieHBLTWZ0WkVqSXhpTWtNc0xSb1Y4N2JXeDZ3ampP?=
 =?utf-8?B?VU4xSlEwR2xaclV4b0krQ0lGdlQ0dUQvaDhZRGdiNW1yNElnYjhFZk9BcjZ5?=
 =?utf-8?B?Z0VYbU5mcUVLRENacEYwZEpwb3c0Um5hVXBhbmE2QlhIMjRQL3IrK0txQXBK?=
 =?utf-8?Q?3fOM4zs/M6JgX3pKd0iSzwWkY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TUNYSk95VHBDOHhKWGw1TmlTdEZOSnNqRkRkaG9wamtWaWJkUEgxMlVIZW1V?=
 =?utf-8?B?dFp1NUs0RVNRc3piY0hUQUY0ZThuTFZSZFFHcjhwYjBGVGFEcG5KT012Nyta?=
 =?utf-8?B?WTVyRCtxQVhQbXdDQzRORG1wOFJ0V0JiS1JLTjJIbmppWFFzcUg4YWRpYnlh?=
 =?utf-8?B?OFRqNXpHTW1sK1lDVVpYdDhFZjZVRkgwekV3ZERkeGZjVWhTeFAwcE1aaEhB?=
 =?utf-8?B?WWY2M25xM3pCdlMxZFhuUjN3U0JWZXhTRUhsYVhIaTgyekNpOXFxQVFzTEpr?=
 =?utf-8?B?OWNKU1JmVUM2MUZCeFBkU0FZNzRUSmptWHE3WExnd0xGMFY5NGhkZzZBTkp1?=
 =?utf-8?B?djc2SkdyMkFDZHpVNktqWmZpSWd5MjdGRGNueGV0NTJndWdrcGFQNklKOWdl?=
 =?utf-8?B?cGY1YW1NbzYxYkNZVlhKeTFYaWNzcGZmYjg2c3dkdFNtaFgzQUF4NER5ZWVO?=
 =?utf-8?B?bXpiTWxDWG51SWN0Q25JWmIrenMvdGtCd1hQSHpBU01la1FVbFRuN0dHQlJ6?=
 =?utf-8?B?SEIyQTlVZ3RSb2xtRncyR0pSVlphQlMxTVl4N3ZSalpVZ2xuaWttZmxhaC9X?=
 =?utf-8?B?dkNIb3dxTnVwdm5udVkvOE9XZUJ5eTRjSmhNWmpvMmYxMWY5SEZ4Y0VWU1Nu?=
 =?utf-8?B?RXRURlprd3B2OEM3UUkxMXlEYjVmUXk1c291cXBHdjRVNm1SdE5WVmdhMzBu?=
 =?utf-8?B?THBWUTJiVHpvYzR6bDNUZURMUm5MZmg4eWRwUnl5REFyMXFxNVZidUlYWFRw?=
 =?utf-8?B?SEJpWGozQ0tGRng5QSs3aVFVYkgwdlc3TnhyL0lUeWhBZUxncTZaczMzbnJD?=
 =?utf-8?B?ZXV2cFhNaHZnSFZjYjh4ZDBKRWdDamI2M1VmU244TFhNTDFJSnNieEd3NFcr?=
 =?utf-8?B?dG1jbTlrak1WRHpZV3JVcmhjSmw0TWZWdVcvUHR5N0FxeUFmS3gvS3FHcnJ6?=
 =?utf-8?B?dkhwTWordWd5eUR5alpwZXpGYkhET2JFNkRVeEpPS2VZYjlreElQNVM2czVt?=
 =?utf-8?B?T1JyUjlPa2ZPeUF5VjBPczlHelpib1hITndsVDF4S1FjZjgrZGlSM2JLRERY?=
 =?utf-8?B?R2RzbTVaOHh6UXBUSUd1THM2Ky9KazhQbm5RMGljNVVCUkZsandDQTVJZXgv?=
 =?utf-8?B?bHhLQ0pSMnBQZXNHV3RpY2V5SDU0dDFJNGZBK3ZBVzdqNU1pYm5JSmlOQU1o?=
 =?utf-8?B?YUlrWERqSGVOSmk5eVRnVXVWZU5lTHFib2JqTXJDQVVHWTNRVnJ4V0NwVFB0?=
 =?utf-8?B?UVJRa25rcUFQRDVUTEd6NUQrbjV6UDBRaGh4TndJSzc4OWxrQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef20b1be-4446-4b84-2569-08dbc752b0a4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 16:30:17.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUF1zm0xD60TD4T6ckHG2z9rHiBDmLIMiALkLcmScnRdRE9uuiMu1d3jq3vxWklsV/3fa3em7zJ+8vBWu2ArjQ0fuH6OGOsU9Ck7Tz6d52k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-07_12,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=602 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310070150
X-Proofpoint-ORIG-GUID: PuWMDfMoPyL-gRiyS37RzUv0evyNUZYA
X-Proofpoint-GUID: PuWMDfMoPyL-gRiyS37RzUv0evyNUZYA
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/10/2023 16:04, Willy Tarreau wrote:
> +As such, the kernel security team strongly recommends that reporters of
> +potential security issues DO NOT contact the "linux-distros" mailing
> +list BEFORE a fix is accepted by the affected code's maintainers and you

is s/BEFORE/UNTIL/ clearer?

> +have read the linux-distros wiki page above and you fully understand the
> +requirements that doing so will impose on you and the kernel community.
> +This also means that in general it doesn't make sense to Cc: both lists
> +at once, except for coordination if a fix remains under embargo. And in
> +general, please do not Cc: the kernel security list about fixes that
> +have already been merged.

I was thinking about this Cc: thing and would it make sense to:

1) have LKML and other public vger lists reject messages that include
s@k.o or (linux-)distros@ on Cc? The idea being that this is probably a
mistake -- I believe it has happened a few times recently by mistake.

2) have (linux-)distros@ reject NEW threads (i.e. no In-Reply-To:) that
also include s@k.o on Cc? We could include a nice message explaining why
and to please resend when a patch has been developed and/or a disclosure
is planned in the next 7 days. I guess the problem with this would be if
somebody on s@k.o does a reply-all which would add distros right back in
the loop -OR- a patch has already been developed and included.


Vegard
