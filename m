Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B56784231
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbjHVNh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbjHVNh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:37:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D8CEC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:37:54 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37MDJOX3017344;
        Tue, 22 Aug 2023 13:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CmzO3k9SizCnF22VJMieFFVerEdHqS5EX+H/aC12h8g=;
 b=E1jNzDJd8iZSxsyKTj7AfX5ucMqSJd8RfHvFBKvBc7WBVOekcJ/xVOHuiCB+U6D9gdxG
 xbetViFkTNW0yusRG3NJ/U6D5zDagWGRv11G5i11E5dahqYQ3Z849Z8xoJvsVHfQmJhf
 3G9k74AvNLDVyI8vhzpKYx/EDlwDyOAQFNQlUXeZidWAvJy/8hxZIKnK3qT9tUWomNaP
 dXMaWxdTugcVStyo/VxPhdw5nAsoopqHSJPeEAO0J1pRtSwEFuW9wTUipx089N7+XFnq
 cD65W6IH6+wuZxWDnnkQayTKWdSE5yRk9ZhYY1xC/2FIR2JnFWIMeEXRP9dn3z2BQWQw oA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnscdceg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 13:37:42 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37MDXnk0025263;
        Tue, 22 Aug 2023 13:37:41 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm65chgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Aug 2023 13:37:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWkeYH1hdk+UflMEzF9M90n3nDwzymJP7RDWIlT1BA284uUIiTHIcS1uK6lFKU0Q6urV7/dy/m/MyruIm1ndsd6nznljU+omPsXMsiqRnzgm5+4xxspdPH8arrKT6tuHX5vb3t5wwQL0x68qAxXpXing6aFSml02JEUIH+FOMkK2WSgI6q1Kzlf48dU0d74iu4IQ2J2SmfmL3orNikqT0B658kUWueYsfr56i1hzqAZyQtrr9Z7Zv1gyAhyiqHvfP8gYb4fpKYfbG0wzYAOf6egdMXWLkG+MAQcwxpIkvSX5gziQ3nxknS4TElHEgnfIKMjO+le062uVtx0GwyKpjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmzO3k9SizCnF22VJMieFFVerEdHqS5EX+H/aC12h8g=;
 b=MeAjQ1F19IGboNegv0mCvPp7L9P+B9aTuLz3nyfcxmaRfyGktKT1KvYQRr4FiVgzYpjknBtgamj9GyO8ofQ2jkVJjqBTeuRHC2fldxxIaY0yfoxtDZpTUmfBUbLJLtPr9hSasQVDJWduxeQM0AnpEUY61+16pEgkdZD55E74ZZhWj9SqGzOrd+aV/aY4+UZ1uub+LsiOpZzOTxaoHUWt8skzeli/d/F9XaPvmrKKiKm4JbkCm/MmYg+vHbkQZrYLI8YWGWPGSF8lvcjO22KWgcbM4wvihqDTX/mmKTZxPru+qm0S1sHzYj90KlkbJPFtKyzhsKxYmGWKC/9dh5VySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmzO3k9SizCnF22VJMieFFVerEdHqS5EX+H/aC12h8g=;
 b=QenN9hpNNz1K304I+E17/BUGZtJjhJyCfOb8GCDDgGOfeD5NCT6i6Xh3Icn04S/qKE8Eo/cBjWjoaGs2cV9wy6hQznK+r92JYkMdwjWftOtSi3jrSqQDq1bRO03yJSPhOGFv8o6S4JjK4jbYgU+xc3/hVYH+3DN0MFGrCfreqEE=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by SJ0PR10MB4685.namprd10.prod.outlook.com (2603:10b6:a03:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 13:37:38 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::76c:cb31:2005:d10c%5]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 13:37:38 +0000
Message-ID: <cb996bf1-8074-09a0-4fab-dcc243f45878@oracle.com>
Date:   Tue, 22 Aug 2023 15:37:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] pcpcntr: add group allocation/free
Content-Language: en-US
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
References: <20230821202829.2163744-1-mjguzik@gmail.com>
 <20230821202829.2163744-2-mjguzik@gmail.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <20230821202829.2163744-2-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR1P264CA0121.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::15) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|SJ0PR10MB4685:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b69a507-54a4-4a7a-6eeb-08dba314f336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xR476MwASgLY+it0QmwiCIkhg5FUQ/3fJUpDPc1nEnDTLDVgayTYI07hD4Zxdcr+AjLKDiHWEWGMsUKD3ZN+u7UIK0AqFX7ZDs76g22A8rz0a46gH8cDUcFjeIZpQj7EJh4/kOInyKCBXCq88Ofrm9lEqGaCPkJNdeYqijoPCXQR1fUpLQrKxIi9QYRCUeHQz+DTDqE7uIHtCA/xFhBDOQd4avQWgjO8Cy3uQPqZPKmd04PiaxEqjTRNv5O5UJ5iVD24e9eGzaU4YfS8wET6vAeOpWhh5p16aKbMR2uaHXR1SeATPxAy0/QiR3FfViCy3uc3/NGJeknLt0M4/tmEdaQcMJX4CakfdUYAQezSc8wI8iqyj0NHVFYMTeOmFs+bXjEtmAWRiDefsXFeN+VfcEYXLigf+o6O0pgSLxtbAmEEjeUFwojASXdEc8lRmngMuXP0zjRkPj6JfldXPz9uqwihHlzok0PQw4SPLkxMSGrOcPIKj2j0CL9oLEVqANiNas39FNvR8pNyrmf7/pBwV/6Equ1pqDszyTtXxN3KsIYkI5ILft00ozm/64Ww1MpNla+MXN9mV1BoeyhuofsUaIz/GHIIeTaruet7nbvwi3/+WL7cNtRY/vjGeZ9hA8946b9SgEdW5WrJE9SkNaJWgGyy9p/4TVX08/v7SzAXuXCUI2ARz4Oj2+jzF3zMtUXG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(376002)(366004)(1800799009)(186009)(451199024)(66476007)(66556008)(6512007)(316002)(8676002)(8936002)(2616005)(4326008)(41300700001)(36756003)(478600001)(6666004)(66946007)(38100700002)(6486002)(53546011)(6506007)(2906002)(83380400001)(31686004)(86362001)(31696002)(44832011)(5660300002)(26005)(133343001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0QxRnM0S3hmcXVxa0ozUjBIb09XNU9CVG5IUEhESUFiSXF1ZE9ZZ0VYcXdV?=
 =?utf-8?B?NTJpUTZOdkNwdnZjL1YzZ0kzbWVSMk9KTXZXSENDeWdidmJKYmJoWU84a1Fs?=
 =?utf-8?B?TTdubzgya3BXdVJhQ1pTSGRuaEZiVWlMY0NQNEZKeWVJR2JCNTZjelFnL3lY?=
 =?utf-8?B?dFBvWkMzUHRNRjdadWMrTjZ1Qzd5UDBMRWxQclBYQ3l2c1RFYTlUaGtoWkdm?=
 =?utf-8?B?aXVHNy9Fdk5WeTFBbEJuQ0grNWJXSzc2eXJEVXorbEtnbEc5NXNrdU5xcnpx?=
 =?utf-8?B?TWltNmVPYndsWkF5RjExa3VabGE4Qm9sNkFUcGJBaXBXM0cveHNhTkU2V3g1?=
 =?utf-8?B?eWdmS1pDaWUrUk5FbXE5UTJyckNneW5wZmI5UEM2NlVza3ZaSUMwL3hMWU9W?=
 =?utf-8?B?bkRwMEd6YUVJdXdkNWpZR2NDM2dKdUx2RDY3a0ZOU0tTNDJJN2QwWWxoMmRn?=
 =?utf-8?B?djNMQ3FEMVVhTmNlWnB0YWNWMHF6UTZxb2ZZc1RVUnJJSDFvZnh6L01NVlZW?=
 =?utf-8?B?NVRYU0RZT3JnRGVvUlE4RjBrQmxXZ0JMbHcwUzNxakozenlsMGRPNnNYa3h6?=
 =?utf-8?B?RVRQOVdPd2t2QWh6c1dFRlJhalFwY0ZBT3ZnbzludSszck92TDVtSWhvRHhB?=
 =?utf-8?B?YUZpVXdxTHVTbFVGT1NEYTQ4L2dPVllDbXAvbEFzTTlRZUVDSXJ0RWxhZW5Y?=
 =?utf-8?B?RzVvMXNnd0E5bTBabXpxZEcyT1JOcG9KY043L3lnTzZDa1hVeWZ5SnBFSFBT?=
 =?utf-8?B?NGNNMDltb3NxLzUxQVdrM25xUlUwU3V5cXdNb25kU095aVZxdGxVVUgvL3Ax?=
 =?utf-8?B?YytrT2QzNmZPK1o2Vm4vYW9QR2VYRXdLNWpHTkU2aFA5dzlRYjZpakV4OFNs?=
 =?utf-8?B?bTByRjBHci8xa1VydTJScGNFNG50c0RPYUxBWHovWmVVZjJhL1VrUUZ4eEFU?=
 =?utf-8?B?Z1ZVTDNHU3IwdjM0L2ljb09TNE9pVFhxWkdrTGVtOW5kTTFodlNCM1hZRFFT?=
 =?utf-8?B?R1E1NTNXMFZUUDNuT1lZZDVaNllNZzcvKzJBVVA0K1BCa2Vwc1I5dFBIQklO?=
 =?utf-8?B?Um1NZS9PT1hDejhEcGZmQWo1ZkpvNW16K1VOa0hORDMweUlSRzZSUVoxYWVn?=
 =?utf-8?B?TDUrdHdRUDF2Q09XdktwaVFMeEZ2NGllNzd5c3Z5dEdBZytJclRmdW5BRnEz?=
 =?utf-8?B?aVFqaVduTncvR0RQQldWbThnNGJrdVhaa2hMclJEcTlxSHRabkVFc3RvM3Bl?=
 =?utf-8?B?Y0FKNzlva0hUR0N0eW9nNlVHMGQ0YXVzazFLNWhQT2gxS3pDdlI0ZUxGOWlu?=
 =?utf-8?B?SENxUHRlK1V2eHdKUU1zWlR3VTFwRjFjSGlOc3plZmdFclBPWDJxOHZzdUlV?=
 =?utf-8?B?YTRydkwreEFZQ2ZCUE5YVEowMFVLQ2V3TFBYbDhYaUdRMnVzeU1CY2czZ2Uz?=
 =?utf-8?B?SkdpUDdCTi9Jays2TnU2YkZjcGtPcHlNdk9GN1pCcGRObXBVMlVJaFV2Ynpr?=
 =?utf-8?B?VFZZOXpGMDJEY3VINEgyK0VIVUxkSUlmZVp6UFRKN0JxRkRPNml1NEtrd0dU?=
 =?utf-8?B?Q2lVcThIZ1d1ZkFhanEzeWxhRlo2T1JPTU53UzhjbHJOeFB2Sks5OEQ0QzRB?=
 =?utf-8?B?L3U5MVptRU1ySGp5SjlPT2tWQUpMYjNUdWVZaG5ubUZDSnc0NENMODFoUWxv?=
 =?utf-8?B?YzZtMEdvclJpbnpFV3UrTDFoaHBoTlZoV0N1TWsxSVVERE5Xa1dmaUg3VDhu?=
 =?utf-8?B?REQ3VDBpcGdEeHVxTkVPOTRmOEk3ZGx2VnpTdVNhT0RpeE1TZUgrN24yblBB?=
 =?utf-8?B?eUVsM3VVOHh4ZVMvWVMwaUdCNVJhM2xVcU1qclZFQVU1L1lJNFBDSC9sOStL?=
 =?utf-8?B?cFEwaHdSd2MyNW1Cbm9BaVMzcG4zcExETEVad0ZPemhGdk1weU5RZE44L0gz?=
 =?utf-8?B?TEhJdEhTZXQxQVA0TURaYUZlUW5SYWhhSGxOU0ptZFdDWUVWRHhYalh5WUY3?=
 =?utf-8?B?bWYzUDlWRDVMSmpoNTh5MjhLbDJQQzR5Vnc5ajdqRmVlb2ZZbW9Gd2N6dVRj?=
 =?utf-8?B?SGkyUFRhRGJDeUlMaWo5V2NJcDMvcVRpZHcvRkx3UkVScC9LcEUxU1B1cmZY?=
 =?utf-8?Q?riE3+J0p3PA2yqt+Ywwb6mHC2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VmlZeDJTR0dsTkRiSnBoT3RpR0lsZWt4TEpNc05GN0FneEhxcWpjLzdvZWs1?=
 =?utf-8?B?eU5SaTlvdm0vVEpvb0xFZFNVTmRkVGdUZklLbXlLVDEvenZMbjVNVjRRY00v?=
 =?utf-8?B?dWtJS25XNjduQWQ5cmtaVThOYVBTOGk3cFdXNDZ0TEc3MVlFQk9aaDdSZ1VV?=
 =?utf-8?B?MjZyWGxQeVB6VlE0T28yTEI3OEZLNE1VZkhyc2ZEUExOOFlaeFczQjEydk41?=
 =?utf-8?B?azVDQ3pPWVhKNW55Q3VqMHFZV052eUR6S3RRYmI3SkRENzRDMkNGL0ltU1pK?=
 =?utf-8?B?dW9rcjViVXdtSlFNbS9DNHh6dHJ4dTdlVDRYOFpSTEF4UU5CQkdab2xadmhU?=
 =?utf-8?B?T1lRNU1yZnV6b090Rlo3Ym5MeFZzdjUvQ1BxemI5UXRkYUNhQ2owZzJjRGlS?=
 =?utf-8?B?RjUzZEIzYmJlMzR6WGdvQ3BRZDNKVVdmeE5pQkpGNG1manVBaWIwOVJUNVlz?=
 =?utf-8?B?RWsxL3Boa2RVT2g4ZWYwZUI1MFpwYjRjWU54WktmWDkwb0syTTJYa1BUc050?=
 =?utf-8?B?T2EzQk8xUDcxRHNJMHBRaGg4dkdFeXo5YmFnNC9CUnZ4OGxDQThXbldjMkkx?=
 =?utf-8?B?NG9VRHZheFZDalFRMTNjaFo1OXhQNWo0K0cvRVV3WVJ6UytaRmtnZzlHMWV6?=
 =?utf-8?B?UGZlZ0JzcDRPckVMWFFkZHVUVXp2TStybVhSNWNkYVFIdzNaLzNFY2FVWkR3?=
 =?utf-8?B?OGVTNkNiNmZpZ2VFLzFqUWhaVy9KVWlSNlNhSnZ6YmxrNHBDa2JZdXIzd0E3?=
 =?utf-8?B?UHpSYSs4NnJHS1B3M1VuOGIzRWQ2R0J5c1hCQUcwdzlZOVNwTm5TMHNkNlZz?=
 =?utf-8?B?Uytaa1FkdUlOblpWV1ZDVWxITDJIYmhqaVhCWUdqa1ZlZUxVcmdPbUNxV3Qv?=
 =?utf-8?B?bkhhSG9EUTlTNzJlbzduTzFPdGZ1RndBeE4wYm80c3VHVkRNN2pZTjlNclNo?=
 =?utf-8?B?aFV3L2tCMno1bjEwS0RHa0I5TExQQWVsRnVZQW5jMGZsNlpTQ1ZUT2hqVEdT?=
 =?utf-8?B?UUoweEJ3US9FeiszQzFGT0ZqQzYxdEowRHM4WFp0NTZJdzJFVHlKTlBYNklK?=
 =?utf-8?B?dWsyODNCdzJVcWhhQW1XTzNDWHg0b1Nna0VOYzIzdEMwNGppUHhPUW5JRWkz?=
 =?utf-8?B?Y29zdEJYb0xXaFZwOSs2cnlGS2wvK1ZFdDl4Ry9RSG9VNXBkMzNHMXBFTzU2?=
 =?utf-8?B?YWtZQk9DQ1UrQmE2eEdUT1lwaUw4Ym03TC8vL2JhNFQ1Z0RPbDU1RWkrM25r?=
 =?utf-8?B?YS9Ea3F6dlJ6RUlYYXFvM0xacVRxYUlDMS9wdGdWWkZjS2VSUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b69a507-54a4-4a7a-6eeb-08dba314f336
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 13:37:38.4472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSg7WMiBtAPLCqUv675a4YVDUxVf1sctoauH6+pZ3ZWQyn7S6DQO46kcDuzIWOZKK2cFT/WgmofQMnQ4BfARwKvZPXHnGRh6tDWrm8//Lvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4685
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-22_13,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308220102
X-Proofpoint-GUID: GH-oz7UIZzECoD5aKIwO9KblA3BmtAgl
X-Proofpoint-ORIG-GUID: GH-oz7UIZzECoD5aKIwO9KblA3BmtAgl
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Testing out a review style with very detailed comments. Let me know if
you hate it. Review notes:

On 8/21/23 22:28, Mateusz Guzik wrote:
> Allocations and frees are globally serialized on the pcpu lock (and the
> CPU hotplug lock if enabled, which is the case on Debian).
> 
> At least one frequent consumer allocates 4 back-to-back counters (and
> frees them in the same manner), exacerbating the problem.
> 
> While this does not fully remedy scalability issues, it is a step
> towards that goal and provides immediate relief.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>   include/linux/percpu_counter.h | 19 ++++++++---
>   lib/percpu_counter.c           | 61 ++++++++++++++++++++++++----------
>   2 files changed, 57 insertions(+), 23 deletions(-)
> 
> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> index 75b73c83bc9d..ff5850b07124 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -30,17 +30,26 @@ struct percpu_counter {
>   
>   extern int percpu_counter_batch;
>   
> -int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> -			  struct lock_class_key *key);
> +int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> +			  struct lock_class_key *key, u32 count);

renaming and adding a u32 count argument

>   
> -#define percpu_counter_init(fbc, value, gfp)				\
> +#define percpu_counter_init_many(fbc, value, gfp, count)		\

adding a count argument

>   	({								\
>   		static struct lock_class_key __key;			\
>   									\
> -		__percpu_counter_init(fbc, value, gfp, &__key);		\
> +		__percpu_counter_init_many(fbc, value, gfp, &__key, count);\

renaming and passing count along

>   	})
>   
> -void percpu_counter_destroy(struct percpu_counter *fbc);
> +
> +#define percpu_counter_init(fbc, value, gfp)				\
> +	percpu_counter_init_many(fbc, value, gfp, 1)
> +
> +void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 count);
> +static inline void percpu_counter_destroy(struct percpu_counter *fbc)
> +{
> +	percpu_counter_destroy_many(fbc, 1);
> +}
> +

wrappers for the count == 1 case

>   void percpu_counter_set(struct percpu_counter *fbc, s64 amount);
>   void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount,
>   			      s32 batch);
> diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
> index 5004463c4f9f..2a33cf23df55 100644
> --- a/lib/percpu_counter.c
> +++ b/lib/percpu_counter.c
> @@ -151,48 +151,73 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
>   }
>   EXPORT_SYMBOL(__percpu_counter_sum);
>   
> -int __percpu_counter_init(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> -			  struct lock_class_key *key)
> +int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount, gfp_t gfp,
> +			  struct lock_class_key *key, u32 count)
>   {
>   	unsigned long flags __maybe_unused;
> +	s32 __percpu *counters;
> +	u32 i;
>   
> -	raw_spin_lock_init(&fbc->lock);
> -	lockdep_set_class(&fbc->lock, key);
> -	fbc->count = amount;
> -	fbc->counters = alloc_percpu_gfp(s32, gfp);
> -	if (!fbc->counters)
> +	counters = __alloc_percpu_gfp(sizeof(*counters) * count,
> +				      sizeof(*counters), gfp);

The second argument here is the alignment. I see other callers using
__alignof__(type), which is what alloc_percpu_gfp() does as well. In
practice I think it shouldn't matter, but for clarity/consistency maybe
this should be __alignof__ as well?

Presumably multiplication overflow is not an issue here as it is with
kmalloc and friends since the count can't be controlled by userspace.

> +	if (!counters) {
> +		fbc[0].counters = NULL;
>   		return -ENOMEM;
> +	}

Checked that __alloc_percpu_gfp() returns NULL on failure.

Checked that nothing else before this in the function needs cleanup.

In the old code, fbc->count would have gotten initialized but it
shouldn't matter here, I think, as long as the counter is never activated.

I'm not sure why only fbc[0].counters is set to NULL, should this happen
for all the "count" members? [PS: percpu_counter_destroy_many() below
has a check for fbc[0].counters]

>   
> -	debug_percpu_counter_activate(fbc);
> +	for (i = 0; i < count; i++) {
> +		raw_spin_lock_init(&fbc[i].lock);
> +		lockdep_set_class(&fbc[i].lock, key);
> +#ifdef CONFIG_HOTPLUG_CPU
> +		INIT_LIST_HEAD(&fbc[i].list);
> +#endif
> +		fbc[i].count = amount;
> +		fbc[i].counters = &counters[i];
> +
> +		debug_percpu_counter_activate(&fbc[i]);

Checked that this can't return an error.

> +	}
>   
>   #ifdef CONFIG_HOTPLUG_CPU
> -	INIT_LIST_HEAD(&fbc->list);
>   	spin_lock_irqsave(&percpu_counters_lock, flags);
> -	list_add(&fbc->list, &percpu_counters);
> +	for (i = 0; i < count; i++) {
> +		list_add(&fbc[i].list, &percpu_counters);
> +	}
>   	spin_unlock_irqrestore(&percpu_counters_lock, flags);
>   #endif

each counter is added to the list while the spinlock is held

>   	return 0;

Nothing here can fail after the initial allocation so no cleanup/error
handling is needed before returning.

>   }
> -EXPORT_SYMBOL(__percpu_counter_init);
> +EXPORT_SYMBOL(__percpu_counter_init_many);
>   
> -void percpu_counter_destroy(struct percpu_counter *fbc)
> +void percpu_counter_destroy_many(struct percpu_counter *fbc, u32 count)
>   {
>   	unsigned long flags __maybe_unused;
> +	u32 i;
>   
> -	if (!fbc->counters)
> +	if (WARN_ON_ONCE(!fbc))
>   		return;

This change is misleading, but correct; the WARN_ON_ONCE() is newly
added and the old check is modified below:

>   
> -	debug_percpu_counter_deactivate(fbc);
> +	if (!fbc[0].counters)
> +		return;

(this explains why only fbc[0] was NULL-ed out above in the allocation
function...)

> +
> +	for (i = 0; i < count; i++) {
> +		debug_percpu_counter_deactivate(&fbc[i]);
> +	}

Double checked that _activate() was not called in the cases where we
would return early from this function.

>   
>   #ifdef CONFIG_HOTPLUG_CPU
>   	spin_lock_irqsave(&percpu_counters_lock, flags);
> -	list_del(&fbc->list);
> +	for (i = 0; i < count; i++) {
> +		list_del(&fbc[i].list);
> +	}
>   	spin_unlock_irqrestore(&percpu_counters_lock, flags);
>   #endif
> -	free_percpu(fbc->counters);
> -	fbc->counters = NULL;
> +
> +	free_percpu(fbc[0].counters);
> +
> +	for (i = 0; i < count; i++) {
> +		fbc[i].counters = NULL;
> +	}
>   }

Looks correct to me; fbc[0].counters is the actual allocation so only
that gets passed to free_percpu().

> -EXPORT_SYMBOL(percpu_counter_destroy);
> +EXPORT_SYMBOL(percpu_counter_destroy_many);
>   
>   int percpu_counter_batch __read_mostly = 32;
>   EXPORT_SYMBOL(percpu_counter_batch);

Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>

In summary, my only slight concern is sizeof(*counters) being passed as
the alignment to __alloc_percpu_gfp() when maybe it would be more
appropriate to pass __alignof__() -- not that it makes a difference at
runtime since both are 4 for s32.

One other thing: I find it a bit odd that the "amount" parameter
(initial value) is s64 when the counters themselves are s32. Maybe just
a leftover from an old version?


Vegard
