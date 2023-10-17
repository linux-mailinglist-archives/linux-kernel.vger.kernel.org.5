Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37AA7CC71F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjJQPKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235084AbjJQPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:10:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F005CD56;
        Tue, 17 Oct 2023 08:09:59 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HF435I031803;
        Tue, 17 Oct 2023 15:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=iw4XjgPaE7pc7E7/z8NWISGsRHI7lPLp6nPygZqDBIQ=;
 b=n5Ku3GIvcKR2Bu40Bwu8J+EbV3NeAR+kmiqc+zWia2PZLxTKge3gvUpv3uDuWCU6f8S/
 EIFAu0g4L/jrhibUEaj6TitEuSs9r3XDEgo+o/Fsi40QjbMK/fZceJAlEw3smMjE5Kd+
 MwpACOrgxYiUEj2kkHHN5479AgkYTQnoFh8IKQdDYdLbfm/L2NFHMdG0aU8fXylY/edS
 qmbC8Mu6gc+QdfC5BNAIAC7oDN1fhPGPneIySBQUPK0opDS8+uboFvfSgjLUf07/3n7M
 42CJh60FpGqBhnMPZHwVQRJYN/5ECxyqpTRo82TqGplTfSoP0BC3waaiTfpf/ZwPsxA6 aA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28nggp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 15:09:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39HDlfKT040672;
        Tue, 17 Oct 2023 15:09:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfymems0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 15:09:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VR6uL/ls3hcASJpT5TypbDctBU4Odwk7KlzV2pXfs8brAKEZPj/uhOT/Di/pAHJmLz+x4698VoRp96hROB7lzCw/0xa4S26zKOWV8CmXBzAjLWp8+ePz7NolxVIevTz70it2HjUSqhmDmA6gEqMyPgjCdQbiuv9B9tkXEH0+opyyO4wDZEj9Z67S6/QXOLtb+7vJX0IY9134E6P39p3BImlLfLp+u1FJV6CmacLBjKmLwc/4zuNysxAs5Yo+an5I0e2v2Ep+Mty4Qf+4cPfrQLCP9JKQD5XpEXFvjQpUnT3eFLJ8uCwDgKPwU56mWmMkCiNUdz4KifNNyYmK/765mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw4XjgPaE7pc7E7/z8NWISGsRHI7lPLp6nPygZqDBIQ=;
 b=OIoNec6DYqKKg7idKyfAHjBPnxR4/BthXWV+D24H9NrmswLWh/Ts1nvC2Q0LJEX7s14WEwll45UKbdzOMx3doUf3PWWqsxxzBb8EHBgUndrU077mJy/WSofsHeoBMcHksuK++sCVB1awjAuzDxM06ZAVqEIfmna6FqmkpcCLQBdXHW/nQWVGXl+b6WdquWGY6NGHUc59274f/NT/X018odXa5c47ptkQI167om2m41yIHV/L7Rzj963VRy2j9gQeJ+KtVCS2E3tb53ebR66gVldDD128bJBvh47xRES1tAwdOdiHuYGRDFayFQ2BFB+dR3TxRRI0ua0EqeFtTH9ENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw4XjgPaE7pc7E7/z8NWISGsRHI7lPLp6nPygZqDBIQ=;
 b=kCGa9OsfhsFzDUTEo+5Lt0qen+/aGaxApRzU7UkF8l1NgtZlJfqXhBhPY3Q7YC4XgQ1IxLEVgvsgWOE8UmKaq1ZGGCiUA448BB25DitXiNRxLfJw2f48DXuoNF0f2+dnDC3plWXpSIyooUWm4I70dgFX1l/ti9MBzGWvgJJO4kY=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by DS7PR10MB7225.namprd10.prod.outlook.com (2603:10b6:8:ea::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 15:09:11 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 15:09:11 +0000
Message-ID: <8cd1f099-b16e-4db8-91d8-ae1ad974bf08@oracle.com>
Date:   Tue, 17 Oct 2023 17:09:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231016083953.689300946@linuxfoundation.org>
 <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
 <2023101641-resource-scalding-3e1d@gregkh>
 <43ad9708-47d4-4113-ab05-6012cb7c4d6c@oracle.com>
 <2023101655-throng-rickety-ff79@gregkh>
 <fb1ce733-d612-4fa3-a1e4-716545625822@oracle.com>
 <2023101716-sporting-geology-2de2@gregkh>
 <2023101719-anteater-deviant-bdf9@gregkh>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <2023101719-anteater-deviant-bdf9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0066.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2ca::20) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|DS7PR10MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8b5966-3495-4289-35cc-08dbcf23046e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +SUMdgpIXzYG7ILXJQUcRCiwO5KfumZsbrK/1qU4ALh5/XQmx9ACO/KxcSyq3q9VGOhLnH/wqAfQTmPOKWvJsum1NHIJxNvHuADp7IFCeA1t7C1K2XnPaK3fXOmpsdJeWmeZFSHekxl5zmjilTWw8aYkUQMwOEDfGKpqcHUcDFhgzwFsw5BWwytuBRtGVd42Hv05qxnUNU+wCtscqb7lBOM89SAhGglUNeXWnEYxHn2jNhlQknmGWX8Yr0/QhoWZ3G6Cq/PJmVlb3B5JhHwD9UEHyWbqm4BHEhSIRV3ZEIIx+4PpqWXdkyEs0BBlCCHHeVagBPff+S4+CV8fqzeq0DpRzlLuFWWDnq6X2eZJS0rhzWQoUAP0Bi6FkWqdW/HdVglJYwf84NPEqfUPWZou9mX9yzuQsFlx5ltp1b+ut2h72w4IBnWxCudnuX5Y8rTe09TtlCWf6zEuIyrAcDDRr2NBMW3Xtcbz2KJOMDVgdq5158JXtHiFn6Vp4szgbgiQkpLAmkH9XGpA2seMFuJl6NZERId2+8izJgGYXKzgQ8H9Bh+T76E+ukQhX1njIWvQK8dCRuhr5jmsL9yvimikRX6nl+m6Tkm29Od/F7/UR2gxIQdZPhCh5gVuXYlR5JyPB/AnhjpO7TDCUybslVg4eA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(396003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(478600001)(66946007)(54906003)(6916009)(66476007)(66556008)(6486002)(6666004)(53546011)(26005)(2616005)(31696002)(6506007)(6512007)(86362001)(44832011)(4326008)(8676002)(8936002)(7416002)(2906002)(41300700001)(36756003)(5660300002)(83380400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFNmOW55TDF1d3orVHRvSFNBRmR2bFQwaG1QOFVNNHJUV1F3MVU5NlE1N1Z4?=
 =?utf-8?B?QUVyQUI2OFpNWklYOTg1bmNEVFVCMjdrMENFalVRZWlNTzFFY0I2MXNVU3A4?=
 =?utf-8?B?TTFzemlwbTFudnBIbm1mVUMwallEUStZWE02ZXJNL3cvQmNQUFFIcDM1QjRi?=
 =?utf-8?B?aE5nSEM1cU1pSFUxSzBIYnA3OWVnYk5nZXFMU0s0b3hjVU4rd2Q5MmFDclZm?=
 =?utf-8?B?MTlHS01iMGtHNWVQb1ZUZTZHMTVXeDNPWWIrSUJMbEdaZ1B3djJkZGVaek9K?=
 =?utf-8?B?bXF5LzB0elQ2NEx0cUpGUjJOaHFGZWsvaUc2dTRSN1lQUGNkYVZKSEorSmFT?=
 =?utf-8?B?OUZaMExkZDRsTmFnTUdyRmFNSnRDTDZaTDVVZ1N2QURTcFNjYmZZbnN0RW5l?=
 =?utf-8?B?VWExM09oSTZhbnAyY1BBWG9GNVN4V2tUakVSZXZ0VlV6dHg4QWsxTytXMTZK?=
 =?utf-8?B?U0w5dlJ5WnhoK25ua00zUkNkWnFuM2p0QjBNejNNa0htNXJOTWd0NzBsSDZW?=
 =?utf-8?B?VDB4NFpGbmljcms4MDBQaDgveU9ZTko3YWFSU0NqdzBLUHRZSlZodDlZVzg3?=
 =?utf-8?B?TUZNN3A0bTNWbzFOWnVKRm9hVzdjK2F3T3FtRk5pVjY2SDc2dG5wYlZBUEFB?=
 =?utf-8?B?cFBES0crS3hSK0tZQjRWdSt0WXBPWndqMzUzYXRyMktBVzRueU14WStHZ25q?=
 =?utf-8?B?VUpUZGtSUjk1dzJ0WkdaaUtIVFhCaFBXOUo1M2dLVlN0eHVGblQwTDB5blRo?=
 =?utf-8?B?T3ZEYjJpS2lGUGgyZU9BUjh2Tk00Sm96RERZMjVJZysydXZNODBXWEFHYVdk?=
 =?utf-8?B?K3hRZHdXM1E4em1OdGRkZFdlNWdnelJwdDNhWHhDNDRUYW1ORmxsRVJKLzBu?=
 =?utf-8?B?aklZTkl3Rjl5R3NaZWt0dXdWbFBHbDdCSTZsTFdYanBXS0FUQTE0VTBBNWRC?=
 =?utf-8?B?QjNJK0VqUEQ4UyszOGRjYjRxVy9BT2dTa0VpdExGNExKa3BhLzdmOUxLaTl3?=
 =?utf-8?B?RkJ2anVsWm1LQTZveUJjZDBpNGNHZ1ZJaGNpTklsZXdpdThRRWFGeUhkTU5U?=
 =?utf-8?B?RE5NTWJWYWZ1VkZLVlk2YnpFSTNUTkp4NGo0VFkvVmVkWG5pekZmTzd1WVZY?=
 =?utf-8?B?ck9scWNPRUVWV3JJYjROMTdjSmdaMWdkb2l3bVpPMmwydmlGeDVlUEdabVZG?=
 =?utf-8?B?U1dZSTBmZURDVzhhNU9CNzNZMDFkT2M3eWdMVlREZjdNVzl5a2tmYnZPNC81?=
 =?utf-8?B?VlRjT293RFUzd1VOMWJRaDNZdlViU21oU1YxYU9NeUk2bTF4cmora2R1azdE?=
 =?utf-8?B?SHFKNDhtREJubjVRTUZPRmYxUkF3MVZrVFBIVEhhb3dkMzg1SHBtUjVGUFhn?=
 =?utf-8?B?VDlUYW1jWlpCbUdYbG1ZTWFOWU9pVHVLZGxydTlHM0Nacll6bXhDWHJRQk4w?=
 =?utf-8?B?dEZXSFNRVG1rSlJwWVRSVStyUXQ4UlNCVS9PMjRlTjdYaGlXemw5QjBOUytt?=
 =?utf-8?B?WVd4NDY2T0RZUHgyZEJFRUEvczhBWSt1RllKMnpNVUtlZnVZMDNiM3lOVFd5?=
 =?utf-8?B?Nk04Wk9xZ2g4ZG1LUkp2OEZENUgyeUdHcUNnN0JWMTFPN3N0SVcxUThWcE00?=
 =?utf-8?B?WklMU1FJelJWZXViNlE3bmVwQ0dEVGRQazB3UE0rT1k4N1VNdXhHc2orUHU3?=
 =?utf-8?B?Q0ZWTzF3Zk9iSzNJN0l6U3EzM2VRODlYM0xQMGR6WENxR05ETVFKNTh3ZVlh?=
 =?utf-8?B?SWJDK25YbnpLQUNmS21XMGlEdjUxcEw0U0xNZEVCTVpMTDkyVis3anBPOHBO?=
 =?utf-8?B?NlIvaTY3b1dhY1Zlbzk3OTFmT2dHZ2hITTU1Mndpc0dMZVRuOVRmWnYxRmty?=
 =?utf-8?B?ZzhTVFFTQ1JVbU9ROGtOUkx3dUxZZnRYVno4MDhxdVh6TFdReVRwYVVzZGdE?=
 =?utf-8?B?aFk0NzBXL0Z1b09TUlhwSzlYanBjZDBRVHVudjdqdUpldjMvTCtTQVl4Mmw3?=
 =?utf-8?B?dHFyclAwREFUK3VLS2lVaEM2N3RHNE9uaExUQVZHQlIrdjNSWVVwQmZDUXlo?=
 =?utf-8?B?RVVpUktwbjJ5TmlsaldjaEtpeEp5T2p2QjNBeEMvTlhRSzRzTWZmd3JhRG9C?=
 =?utf-8?Q?tSYUmIamuVT7NA4i+cMPNXUwa?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?S29hSXZTTVNiZ28rOGlLK3ZXdytlWGkremFOM2dyMktGYU4zMDl4TWwwMmov?=
 =?utf-8?B?Vmg5clk1QVFaSnE0UDkyOUlDQVJSTzJlYlMyeWRVNkVDR2lsSzIydFRiN3A2?=
 =?utf-8?B?d3BwamMrSHV5SFcwYzB4TitEYXI3Q0ZHZGZNZHI5czBSNEwvODBSZitVaVlq?=
 =?utf-8?B?M2pyYklxUGVJenhWbUx0RkpEbSt1WVI3b0JIdDFjTzd4dUZYZ0tLcFNNTlh2?=
 =?utf-8?B?S2M3ejdwK0FWK1YxeWZRY2cyWDliTEpNSGRucWZrSjhDZlBrYzVjekRuUXRE?=
 =?utf-8?B?THVLTG5jZTc1MkJZQUhaSk5qMW5xazRvRVRoRmFUUGtpKzZXdi9LampWNDFO?=
 =?utf-8?B?Qjh1MnJGUXlIUlVIWHhRdVlaSUlmaUVTVGswWXF1WnhjeEROcENEZXRaR2tD?=
 =?utf-8?B?eWlwc2Z0RGZKVFhtNEdTZXJYWG9XNHlYT2RsTXk5N3RWekg1WVk1T3lSRUw5?=
 =?utf-8?B?RXVTN2JtYUpnTHBpdmpzYVg3c1A0ZEM3c04zZ0w3UW5VVkM2UmhpR1R1aG51?=
 =?utf-8?B?M1FXUEE1cC9WTWxaVTB6K2xKaFQ3WHdxOHllamRKbXVmSTNKUXlVL3pMVXBS?=
 =?utf-8?B?MjZTMmhUejFjQWdLSEx4djVVd2l0UmtvblZQVytSRkJ0ZjVPMVpCNFlZRDc3?=
 =?utf-8?B?Nm5SdnBhT1hIZGtIemQzd1FTd2F5YVFZb1pXbjZXZ1RiaGY5cktPWXR5Y01p?=
 =?utf-8?B?YVQ4VzFWbGU1WEpZV21OTHlSYnNsb1FnVUlhQTNSSWFJaXdNMTNUb3VLZ2Y3?=
 =?utf-8?B?ME1JUi9oYVdnbkhpWHJsVFlPN3FFbjI0dkVVVmVXWDg1bXBWSGpVOW1VSlk5?=
 =?utf-8?B?dXFueHp4NXFlMUFJQk5kc1R4Tkk5TmVudFdSbmkwV2ZHZElGNW9LS0twelNS?=
 =?utf-8?B?SkRDVWtDSHIzbmZwWEYwMHc0WTNFT0FjTlAyUGp6N3EwSkZRSmUzS3N5Tmpx?=
 =?utf-8?B?N1VNbW1JNkdNRWRhZ3B4OTM1Y3hxQW1Sb29VNnNCYVdOUm5hR3gyczNwSGJW?=
 =?utf-8?B?NUFMNXVCTEhiUHNrc056Wi9lY0xNTFgxbUg4QThTVENQWFc5SlA3bTQra1Ez?=
 =?utf-8?B?YVJ5SGF6SWhuZVQ1bXJsVzhNMEl3REJTSHZLQnFLemxNOEp6L2hya1Y2Zi9J?=
 =?utf-8?B?YjAxUFRRc0NYUjIyTXJtblZtQ3dYOWthT29uQUpaV25pNzVER1NaaTc0WENx?=
 =?utf-8?B?UHd1dGsyaWgzNFZ0ZnBJdU0zUHd4VVdtdXZaWmYyTFZKdUlhb0F5YWZnYXh6?=
 =?utf-8?B?OWRRSXl5YUsyQVpaWXVTR2w3c3AxUkNJN01UQkx6eGJqRFp2WVVLUHVCSzJq?=
 =?utf-8?B?aFdkRDRDN0xoemN5eEtZMTRTbUFpdjdRMFl6ZWcyTnFtYnIzK0dHUEIyZGRp?=
 =?utf-8?B?cG9DVFBiS21hYU1GR2FYUG5iMWM2MGs3WWtabE5Oc1ZpRXB4L0FackIvTk1a?=
 =?utf-8?B?T1MvdzE0cjZvNnJjL2ZMR3NjTXRHVmJkWXF4c1ZrMU1TbE12eVFmQUd2QU5I?=
 =?utf-8?B?S0dpN3ZQRDJLaXJXdjRTeklrV0daWm5rZU42UFlDb1Y4YnV0U09uaExRSDZS?=
 =?utf-8?Q?y7JFr+2rsLgqX+R7Emg140r3OjId0x3uJCSOyRyzYgG/Jw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8b5966-3495-4289-35cc-08dbcf23046e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 15:09:10.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lm90b/RDSxvFuiI8rWq+uMUhj4gc7IteX83/B2+pZS7XhipvW3pZ01vfuvsqZWNRXOCzv6d9An15wu85w/iU3ExT7TR58kqyN5At2O8U+T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_03,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170129
X-Proofpoint-ORIG-GUID: CI-KEqzC-oXF34XLgW3dF5e25xJOfHQe
X-Proofpoint-GUID: CI-KEqzC-oXF34XLgW3dF5e25xJOfHQe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/10/2023 16:08, Greg Kroah-Hartman wrote:
> On Tue, Oct 17, 2023 at 03:57:06PM +0200, Greg Kroah-Hartman wrote:
>> Sure!  Here's the output, good luck!
>>
>> $ make -C tools/perf
>> make: Entering directory '/home/gregkh/linux/stable/linux-5.15.y/tools/perf'
>>    BUILD:   Doing 'make -j20' parallel build
>> Warning: Kernel ABI header at 'tools/include/uapi/linux/const.h' differs from latest version at 'include/uapi/linux/const.h'
>> diff -u tools/include/uapi/linux/const.h include/uapi/linux/const.h
>> Warning: Kernel ABI header at 'tools/include/uapi/linux/in.h' differs from latest version at 'include/uapi/linux/in.h'
>> diff -u tools/include/uapi/linux/in.h include/uapi/linux/in.h
>> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h'
>> diff -u tools/arch/x86/include/asm/disabled-features.h arch/x86/include/asm/disabled-features.h
>> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/required-features.h' differs from latest version at 'arch/x86/include/asm/required-features.h'
>> diff -u tools/arch/x86/include/asm/required-features.h arch/x86/include/asm/required-features.h
>> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/cpufeatures.h' differs from latest version at 'arch/x86/include/asm/cpufeatures.h'
>> diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
>> Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
>> diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h
>> Warning: Kernel ABI header at 'tools/arch/arm64/include/uapi/asm/kvm.h' differs from latest version at 'arch/arm64/include/uapi/asm/kvm.h'
>> diff -u tools/arch/arm64/include/uapi/asm/kvm.h arch/arm64/include/uapi/asm/kvm.h
>> Makefile.config:1036: No libbabeltrace found, disables 'perf data' CTF format support, please install libbabeltrace-dev[el]/libbabeltrace-ctf-dev
>> Makefile.config:1062: No alternatives command found, you need to set JDIR= to point to the root of your Java directory
>> tests/bpf.c: In function ‘epoll_pwait_loop’:
>> tests/bpf.c:36:17: error: argument 2 null where non-null expected [-Werror=nonnull]
>>     36 |                 epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
>>        |                 ^~~~~~~~~~~
>> In file included from tests/bpf.c:5:
>> /usr/include/sys/epoll.h:134:12: note: in a call to function ‘epoll_pwait’ declared ‘nonnull’
>>    134 | extern int epoll_pwait (int __epfd, struct epoll_event *__events,
>>        |            ^~~~~~~~~~~
> 
> <snip>
> 
> Also, in Linus's tree, this works just fine on my system, but I get this
> same error above (and only this error), when building perf on 6.1.y, and
> on 6.5.y.  The perl errors are not present there.

So lots of those are -Werror things -- I'm guessing it's a newer
compiler/toolchain/libraries on an older tree. There might be some
commits in mainline fixing those... in the meantime, what happens if you
just disable -Werror for now?

     make -C tools/perf/ WERROR=0

If that doesn't work, maybe even:

     make -C tools/perf/ WERROR=0 NO_LIBPERL=1

There are a bunch of other options to disable various things, they are
all documented in tools/perf/Makefile.perf.


Vegard
