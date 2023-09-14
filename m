Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9811C7A0D95
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240803AbjINSzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239351AbjINSzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:55:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925181FF9;
        Thu, 14 Sep 2023 11:55:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38EIeSMC025368;
        Thu, 14 Sep 2023 18:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oA0pqOkLTnYnZ2eqBKANlsyjRIBBYdt28FSOCGuL5m0=;
 b=cc5QicjT3XRnvbI54cD+3l7WqjMrLBAHFj1Altm7ff1F+HFvAA5XR/KBJsbUdT5lLMZY
 G5QCdjw5aNEWS83+/KqqGdcwQoPkqDm1Jh+MfSytFW5oI8095v9j/rtDT7s99fiSrxk3
 Bpl6ZVYlzu0z9cG7l4TPvBYh8X2rMnjQzUafM+QUaSYCmaIc2oU2U5n1XFGkJZSJt6Dm
 h16y3T5jmYqqquheiLiORPZv4QZhzACJ53mx+kqkXlW9NSSe0d/amm/cgapgIFURwQzE
 yuVF8WNfXrO0grLMXWfWIoFV0V7DfXvJAejExOCcDH2iBcwlGGeL9tWh74lFCAXgH67N iQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7pp53y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 18:53:45 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38EIBOET036205;
        Thu, 14 Sep 2023 18:53:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5fc56v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Sep 2023 18:53:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr1KrZoBeS+zcArULhG9wYz5+J4pu8Pd3au7gCVO50XtVekMD/K7LiXOmsPfgpBuOgB+WfHXiixRKJ2JbMzxUvMmV/Qc8O4tugUNeQI6x8+gbZxyomegN5RUwjTLf34k3BViw+YU9uveftAR8XS8Buvnz0bja0oRbyqEnzcMRZeZowhYAlpDkW/7ut4Y0TVO+VJcCpISt6xpvXmVKqJsHtWhs/ajZoJlAFe9qJO+QetVyGeXjbwBA5VAm/ZmU9qGvEj7pCCoWsplifDX2qI3Q3jApfnbaLP7w3zksqz1LvmiYj4ZhCDUOaMRnyZi8sGBi9Ykk4ytE2KQYlBH/BIHwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA0pqOkLTnYnZ2eqBKANlsyjRIBBYdt28FSOCGuL5m0=;
 b=lxE1iLSVDRQTPDduZB8L/U9XmukpSIKmoWHkgC60ednUHiuUo73WtygjT/prIDM/Oi43HI/u5IZzmjNWZJvvYp12sbXgZe/PCOBbY+rHprsenYcanY9Bcl4LpBhr4SH8gO/QNog+qk/LJC3VyI5yzFWbX4wIgFaLZFBWvJitgAM0YXxNsGBcd2j+2Ni3nMPCwBBlMmpJYSVZ/65Q6SfAee5b0VYxJK/m5fR8qFNYE2W5SpD6QyYqwr5mvGEs4xruPhDmvA2iVmZZ/0mZLkyCFABQ0oZNwh3hG283UI6QUNLUM/JUwqv2thhgZDkRqmvoYHCbjrAhBSKIFcXBiCY0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA0pqOkLTnYnZ2eqBKANlsyjRIBBYdt28FSOCGuL5m0=;
 b=TIt8pqBU8acTDEjJ9B1/cThBxeLAio7rFa/PZFxk5KrnFSH2/A8406Mm5y9agOIrTy7igAKdYYq0/QhW2/cC8m87N4mmUp+yPiXZJ4oO+bckWDabpIqAzjCbZS9lcUMKexO+sIIWcPVvpSZQQt8L9CJBXUEqXFg2tkVZ3mZs3FU=
Received: from CY8PR10MB7266.namprd10.prod.outlook.com (2603:10b6:930:7c::17)
 by DM6PR10MB4378.namprd10.prod.outlook.com (2603:10b6:5:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Thu, 14 Sep
 2023 18:53:20 +0000
Received: from CY8PR10MB7266.namprd10.prod.outlook.com
 ([fe80::d40a:3ab:a4a5:ccec]) by CY8PR10MB7266.namprd10.prod.outlook.com
 ([fe80::d40a:3ab:a4a5:ccec%4]) with mapi id 15.20.6745.035; Thu, 14 Sep 2023
 18:53:20 +0000
Message-ID: <0b4b514f-dea0-2cfb-bb44-eb6dc388563c@oracle.com>
Date:   Thu, 14 Sep 2023 12:52:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v16 5/6] arm64: dts: Add AMD Pensando Elba SoC support
Content-Language: en-US
To:     Brad Larson <blarson@amd.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        catalin.marinas@arm.com, conor+dt@kernel.org, davidgow@google.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, hal.feng@starfivetech.com,
        hasegawa-hitomi@fujitsu.com, j.neuschaefer@gmx.net, joel@jms.id.au,
        kernel@esmil.dk, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org, p.zabel@pengutronix.de,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, skhan@linuxfoundation.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        tonyhuang.sunplus@gmail.com, ulf.hansson@linaro.org,
        vaishnav.a@ti.com, walker.chen@starfivetech.com, will@kernel.org,
        zhuyinbo@loongson.cn, devicetree@vger.kernel.org
References: <20230913214944.59804-1-blarson@amd.com>
 <20230913214944.59804-6-blarson@amd.com>
From:   Rob Gardner <rob.gardner@oracle.com>
In-Reply-To: <20230913214944.59804-6-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To CY8PR10MB7266.namprd10.prod.outlook.com
 (2603:10b6:930:7c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7266:EE_|DM6PR10MB4378:EE_
X-MS-Office365-Filtering-Correlation-Id: 726b67c4-8256-4a6c-a2c6-08dbb553dd0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3/OpOtUTDc3l2yJDLdFIDkGJTmu09W+fcDTGkYYtwmOpGAUgSD4277Gou5OZ7dnnNav61ish2GK0kfdKqBd4nQLyQCzsDUrjHnF3jYUPnomwX3Qy8OqrSP44CWzwtQZwtnYyaPhiV3YuBmbSNGwDfLPpkDxU/Z/2Cuq7FqqWZS7V3cLR4BMLqUX3MNlGMShW3OJVTLbKMshn7uRKcs/geH+LXtPC1qQJvnhbJT2KnlwwljZpY0S1rBmxkvxnrPQ9B4lhd2sIiBqRqPdQiggvfnqCb1kE1+komnJ6XGs/fbSV35zoPdl9r3GOBiS5f6f4DZEq+2ixgopofC6bg8KLbF8SFPVpq7KjGUYgtRwy38Rxsm4BJM8AVElZGlOWexqUg9bKQ7IAnTl2MPEF3pHTa66azl1pk461q8YTF5PY7L+S18r1RAgwXmLpwINj3NfSHOsd9dhq247FAGNse/3jqJXrPKKfCJaqyEkfRAROMkeb2HSH0mY9K+ozYB/jrs5Y0S3tv2RLGoih1+OORC/bgpafRJVqpraNEkunsK5EO/7KZaXRFCgv9VephLkoxC/OEXYQL9X7SxK3ykKfToXU0jso2D/G7p0dO9V/BLgox/sFL3z8fR12HWeTScEvUpTmLAPL7soI4V6avfs3SVkjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7266.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199024)(186009)(1800799009)(31686004)(53546011)(6506007)(6666004)(66476007)(6486002)(38100700002)(31696002)(86362001)(83380400001)(36756003)(2906002)(30864003)(7416002)(478600001)(6512007)(26005)(8676002)(8936002)(2616005)(7406005)(4326008)(5660300002)(41300700001)(66946007)(66556008)(44832011)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG1McEY5K3BwbU05VVRBRTlVbUx3OERXeVUvSXp0TWRiTXIvTWxUd282bGJm?=
 =?utf-8?B?SlVPUXQwTEhFVEJybGpNV2tFZmZET09XT29TQ0laMDR3WDdROGpYeVphT29F?=
 =?utf-8?B?TUxLeTVmQjY0Wlc4cmFFR3hjSGdNSzJDc0IyQTlmb3QyNFhRNERobXZsUU5Y?=
 =?utf-8?B?Vi9hdmxxa29SdEpsSjhUbTMzeWJHYkhlRzVpckY3U2FiZWtxMDhrREVIUjF0?=
 =?utf-8?B?UnVoZzluOWpLV0o1K0hWZWNVYkJKSStYRWFnenY3ZzdnaHlDNEFYU2tQWHpQ?=
 =?utf-8?B?c2h5VjU1MVlsbnZHZUIrQ3hSZGtqYW9jaXI1b2s5UnQvblM5YU1GMjdncytD?=
 =?utf-8?B?Si8rNlJrUXdld1Y2ZldCZUNxREdiNEp6QVlCcDczdjFIVDl6Rm9mN0RlZzEv?=
 =?utf-8?B?TGxRNHJiMzIyT1RvU0MvOWNhQmlTYnFQWW1PeTNDa2xodnNCQ2FXd1dFMmxn?=
 =?utf-8?B?UWtFZEhrZldOcWZRUEMyOERuYXpKbXpPQ2RMbGhwdnRoSktkM1ViK0RsTEFn?=
 =?utf-8?B?ckpsVDNZaithYitRVlhlQi9FbERXdnRrMnJRdUlHdGY2TE9iSXg2VUNDUTIr?=
 =?utf-8?B?KzdqcHVmNENTajhlSlp2Q0w2TXNObGJleXdjblloN2pseUdubHl5NG11cEIr?=
 =?utf-8?B?MEhLNUJVNEFxRTUzMmVWK0puM2M3eUxJc2xIWkVuemZuY1QvbkV1cW13VVJC?=
 =?utf-8?B?T05ncDFIWStsODNrMDN6TjV6VDhFZS9DM1c5QUplLzJyOGgxaDJFSVBKZnQ3?=
 =?utf-8?B?UDV0TzVoRTcxaUhrTUZPQWlHWFRKRTI2WkZFcDBueFZhYnY0dm1ZdXBEMGQr?=
 =?utf-8?B?eGNUVlZOT0VQRTU4RlBvS3ZTTk81Y1BZQkpGaER1ZDhMdDVzOGxJVWl2SFJV?=
 =?utf-8?B?ZnZJUWhRSW1RWFdYM2ZweDA3dGhVbkF2RjFOeTlWd1Ayd2xyRVBqekhGWnJO?=
 =?utf-8?B?eTlacnZjSGM5ekxSM0FIUHVNd2VmTTlYRStwMFpFcFNMNTl4bm1FbzJWQ2hZ?=
 =?utf-8?B?NEwrQUhYL2hrUUpaaXRxcmk1QXhHZzBHeDVtd0ZScHVBYkVxSU5Vakc3Qy8x?=
 =?utf-8?B?cHRObWxnWFR6c29ZSm00Yi8yNkcrcGQxalR6MGJEMExqSXBlT2NMay9oQ2FE?=
 =?utf-8?B?TlJ2SHlvaTlVSGxqWUExeUE3WlZLMTZsYjdnRXZXMjZqc3YyQTZ1bllodEwz?=
 =?utf-8?B?bkdJQk9ENHg5R3pYK1FzZ040eDBTeXhnc2hJZE0yYWl4N2JJcytaL0VFaUc0?=
 =?utf-8?B?Y25pMzZHenFmWWpGdXM4YUU5YjYxNVVUSTdqNGpvRis0d1RtclB4ME9iTjQv?=
 =?utf-8?B?K2lTWmtyZTFwQlUrR1NpWjdOQjhNeCt4RE02amJ0cllKVjUwSjd2TFZVZzk4?=
 =?utf-8?B?V1JhUGJYNXVZTEtYa1lQMitmaW52TW9mcmpGVnRQbEhtdDlGbGFMd2FOdkNX?=
 =?utf-8?B?UURWdkxPZWJVbDFmVGUreHVZbXdIZUs1MWk4SU1BdWRyUG0xb0xnRUxhUGY1?=
 =?utf-8?B?bE1STFFrYkhqYWVDRUhFVG1ocVBaLzA0eU5hMWlpb3JFblRYQWhKajBpNCtJ?=
 =?utf-8?B?SFZXZ2M4b3pOMFdBbWt1OEZ5djluNEhROXFrTTc1SW85cWVrMlM1RGJ6MWJO?=
 =?utf-8?B?N3JsWkpDc0JldytpcXdqNkVqa29ocTRSUm1sSVd2eEIrRTdkS0JBd3ZOcC9k?=
 =?utf-8?B?T0h0eWNVQ1hKRDRSeWlPSy9IWEswbURKOGFGWUg5N2h5cmVOOEdpQ0JvZnNE?=
 =?utf-8?B?M213aGd6R1duTWk5UzIxOFVNVDJrYk1QMHJPVW1aeW9kYkRhMEs3TDA3M3hB?=
 =?utf-8?B?d0ZDTXhoRlZzUHBjZ0VJbGxUU3YwNk53aVF5Z2FoQURVTGJZT1RQaFdJSG03?=
 =?utf-8?B?anNsWTk0eE11V3lUNTRoUjVUN3ZJbk5sMlE5OWVMYklvSnRCaHpOdUNEa2Vm?=
 =?utf-8?B?K3YvbThPZ3ZSdXJkenc1dk41RmZuaEd0VlRBSHdBVU1aMklhTTgyRUdndXBj?=
 =?utf-8?B?MWg3WXJxWlJvOEp6aW43WkFNeFVDemtaekc5Z1JoeWxHK0c5THJQME1pVW5k?=
 =?utf-8?B?TitSczZMZFpaeENxUlVKNmxqd0hHa3lyU1plYVpHMXh3VEpTc1BxUWZocE1k?=
 =?utf-8?Q?tzaVEQl5lLaPl8caEk4VjGnrF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bDFiUTUvTWtOTW1VVEFFOVdVUFZudTVXTElIWXVZdVh0d1RWMm91UDNIVU1M?=
 =?utf-8?B?ekZoU0x6SE1tSm8xUis0azV5SzZiTm9oN1Q4S2pQOWRXdkNMLzh2LzQ0L1U1?=
 =?utf-8?B?bi9UcURiWEhDYjlWenIrUlMzNis1VGFKNjhSKy9oQ0h4VFFLQkdaRTRFVUhT?=
 =?utf-8?B?d3YybUJkUUJQbzYyck1nem5FcW5EdTJ4Q0Q2bU5SZmJTREJETHVVbSt5Tms1?=
 =?utf-8?B?bmJuSmN5NlA2SmwzZEFBb3JGdnpLZUwyLzNiNHZTRXY1RVlwdWhVSTVURTln?=
 =?utf-8?B?T21FYVB5WVl3VnFXSnVtcGM1TDVNdXB3bGcwQ2RWaWlHV2hIdEhxN0xQTEM4?=
 =?utf-8?B?Tll0OFEzTldmK2VNL1kvQ2xucWdaZ0hmMWZOSm1sdWFkS1pCR2wvZFNWTkJX?=
 =?utf-8?B?SUU3VnlXaERUUkJPU1RGRjNxdDBuSWU0ckVTL2NacCsvVnZtY3hUN3pJZEVY?=
 =?utf-8?B?RVlNQU9mbTlJSDhETk92MHM1a0ViNXNJaFp0Q25tWThmQzZFTUpsQ2VkcGM1?=
 =?utf-8?B?ak0wZ2pBQVB5RmprOUZSZ2dlb0o1TmF3VzNRUXRVUk9NcGllNkcrSTRoQXpj?=
 =?utf-8?B?RkZJSkNUcU85NG5ncnVPbmpmOVBQdnVUUlh2U1U5QkNSYng1WXJpUUM2OWVo?=
 =?utf-8?B?WmtSZlloSTdwU2txdnpNUkk3T2FZaHlyWHRwNHFocm8yUGFWdmhHaFdBMzZT?=
 =?utf-8?B?MlRxaUVOS2JTZkVoUUx1cWFZaTdhaFBNNlZ1VVFYLzRINHNYU3N0NEh3RnpL?=
 =?utf-8?B?alhiTlU5VWpXWkthNzBxTThlSmxhdTk4M2FTQ0phcWEva05jNlVNSGRPVHBM?=
 =?utf-8?B?cTNpbk80U3N4K3ZZRHoxZG1MVzB5VENuY2NEVUdLTjBUbWFWQnNvUGxxQnVl?=
 =?utf-8?B?dDN2dkRkb09mN1hjMG8xd0JrRFUyNDZFOThyZVU3VVFETitZNVplb0hmUUlF?=
 =?utf-8?B?SFNMMVQxR0ZUcTRNMkJvVlZqeG5WWk1xZUlJVmNxb0gxZVlJb2V0L2RyTFlM?=
 =?utf-8?B?R3Q1U1ppd1ZVL0Y3UEVsYVdKRFBBbWppRWY5KzVnK0N6ZHFUZmxGWi9zNUdp?=
 =?utf-8?B?YVFxTS9jME5NMlJVeWxtOWZMbXRXdVUxV05zVUNydk5VUEJQR2FFN3RTRW5N?=
 =?utf-8?B?WE4yZkp1aHpRd0s0SVlrMkM5dGI3Qm9nSXVZcUFqQVlGVldvSGIyYk9EWE96?=
 =?utf-8?B?ekk1WVZtdVZPa1p2ZENXV1FaU25YL09NcUxET0FVU2w5MUVLeUxsQXZlaDlS?=
 =?utf-8?B?bmtSTEhPVFJLaVRTbzNkVUNSVlZQOHNHNkExaE9qZGFIOVZ6UEFRM2tEc0NQ?=
 =?utf-8?B?T2ZTVWMxL3FyRmg4WmRyR09DVk5nbWlyNENoSVNwbHRIQk9NbnIxTDhpUTRP?=
 =?utf-8?B?eXFMRDFsNzRVOVhQZkRHa3VLZXB6bmR0Z094NVBxb3hMWEo0bk9oN3NNWHhJ?=
 =?utf-8?B?aVhmTVdKeW1NWEVoUXpXcVFCSkpDUUpFUnF2SE94c2c4M285cWt5eFlDMHlZ?=
 =?utf-8?B?Z2ZIaXp5bWhWNlRxKzlzSzFyUGF5NkNDOUMrenlJbFJxM1dqbFFFRStUTUtC?=
 =?utf-8?B?WVNjeU9DdFZrODdIZU1vdDRDcVVndDlJNHVUaFRTcFBZNGpZNVVwd0c1TjF0?=
 =?utf-8?B?Qm5ubCtLeDNNZ0tFZU9kOFdGcVh3RVdURDM0SFQrS25nNVUwdSt3dExIZk5Y?=
 =?utf-8?B?bkJLTzkxVVNhS1BMOEN5ZW9aTHdUWDgxU2tJM3J6U252TVNWUUk1TXA3UXh0?=
 =?utf-8?B?TWF4TFdsTmJPbWtSUFNZYlp4RWhnN0sxTkYwdnJGd0hXK1dFbCtkQ2M0L1pE?=
 =?utf-8?B?UFgxRWZTb2F0aGdTUWFhbnI2MnNCUVp6NjNNcHR5dU9hSFRUQTBJWFp1ZkZO?=
 =?utf-8?B?OXBSd3M0ZW5nWDR1NFlNY055K0h0VURaeWNOMS84NjcyaWlnc000bGhKQmN1?=
 =?utf-8?B?RGdzQWpaQVQ3bWRlS3RvVGh1VmJKRDBndFVWY0FiTEJBa0c1bWd2MzRjY1dn?=
 =?utf-8?Q?ZxQcG3n5R/NFXiJXAO+FVB8YJISd8k=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 726b67c4-8256-4a6c-a2c6-08dbb553dd0f
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7266.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 18:53:20.2836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOqJJhYPOdEYhX9xJtBXzy+MVhgwrqmz5CTqfijbLe9h2/GDXQZb6K1QmylBbWr2bsolrUsdfRL9H5E93R54eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4378
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-14_10,2023-09-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309140165
X-Proofpoint-GUID: vCZD_KquKRBSosNjFGO7UtxVfwk0fbJV
X-Proofpoint-ORIG-GUID: vCZD_KquKRBSosNjFGO7UtxVfwk0fbJV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Rob Gardner <rob.gardner@oracle.com>

On 9/13/23 15:49, Brad Larson wrote:
> Add AMD Pensando common and Elba SoC specific device nodes
>
> Signed-off-by: Brad Larson <blarson@amd.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>
> v15 changes:
> - The first cell in the cpu reg property is always zero.  Change
>    address-cells to <1> and dropped the leading zero from all cpu* reg<>
> - Added read-only and spare partitions to flash0
>
> v14 changes:
> - Fix dtbs_check l2-cache* property issue by adding required
>    cache-level and cache-unified properties
> - Observed the issue after updating dtschema from 2023.1 to 2023.4
>    and yamllint from 1.26.3 to 1.30.0
>
> v11 changes:
> - Delete reset-names
> - Fix spi0 compatible to be specific 'amd,pensando-elba-ctrl'
>
> v9 changes:
> - Single node for spi0 system-controller and squash
>    the reset-controller child into parent
>
> ---
>   arch/arm64/boot/dts/amd/Makefile              |   1 +
>   arch/arm64/boot/dts/amd/elba-16core.dtsi      | 197 ++++++++++++++++++
>   arch/arm64/boot/dts/amd/elba-asic-common.dtsi |  80 +++++++
>   arch/arm64/boot/dts/amd/elba-asic.dts         |  28 +++
>   arch/arm64/boot/dts/amd/elba-flash-parts.dtsi | 117 +++++++++++
>   arch/arm64/boot/dts/amd/elba.dtsi             | 191 +++++++++++++++++
>   6 files changed, 614 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/amd/elba-16core.dtsi
>   create mode 100644 arch/arm64/boot/dts/amd/elba-asic-common.dtsi
>   create mode 100644 arch/arm64/boot/dts/amd/elba-asic.dts
>   create mode 100644 arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
>   create mode 100644 arch/arm64/boot/dts/amd/elba.dtsi
>
> diff --git a/arch/arm64/boot/dts/amd/Makefile b/arch/arm64/boot/dts/amd/Makefile
> index 68103a8b0ef5..8502cc2afbc5 100644
> --- a/arch/arm64/boot/dts/amd/Makefile
> +++ b/arch/arm64/boot/dts/amd/Makefile
> @@ -1,2 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_PENSANDO) += elba-asic.dtb
>   dtb-$(CONFIG_ARCH_SEATTLE) += amd-overdrive-rev-b0.dtb amd-overdrive-rev-b1.dtb
> diff --git a/arch/arm64/boot/dts/amd/elba-16core.dtsi b/arch/arm64/boot/dts/amd/elba-16core.dtsi
> new file mode 100644
> index 000000000000..568bcc39ce9f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amd/elba-16core.dtsi
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +/*
> + * Copyright 2020-2023 Advanced Micro Devices, Inc.
> + */
> +
> +/ {
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 { cpu = <&cpu0>; };
> +				core1 { cpu = <&cpu1>; };
> +				core2 { cpu = <&cpu2>; };
> +				core3 { cpu = <&cpu3>; };
> +			};
> +
> +			cluster1 {
> +				core0 { cpu = <&cpu4>; };
> +				core1 { cpu = <&cpu5>; };
> +				core2 { cpu = <&cpu6>; };
> +				core3 { cpu = <&cpu7>; };
> +			};
> +
> +			cluster2 {
> +				core0 { cpu = <&cpu8>; };
> +				core1 { cpu = <&cpu9>; };
> +				core2 { cpu = <&cpu10>; };
> +				core3 { cpu = <&cpu11>; };
> +			};
> +
> +			cluster3 {
> +				core0 { cpu = <&cpu12>; };
> +				core1 { cpu = <&cpu13>; };
> +				core2 { cpu = <&cpu14>; };
> +				core3 { cpu = <&cpu15>; };
> +			};
> +		};
> +
> +		/* CLUSTER 0 */
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x0>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x1>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x2>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x3>;
> +			next-level-cache = <&l2_0>;
> +			enable-method = "psci";
> +		};
> +
> +		l2_0: l2-cache0 {
> +			compatible = "cache";
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +
> +		/* CLUSTER 1 */
> +		cpu4: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x100>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu5: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x101>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu6: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x102>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu7: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x103>;
> +			next-level-cache = <&l2_1>;
> +			enable-method = "psci";
> +		};
> +
> +		l2_1: l2-cache1 {
> +			compatible = "cache";
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +
> +		/* CLUSTER 2 */
> +		cpu8: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x200>;
> +			next-level-cache = <&l2_2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu9: cpu@201 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x201>;
> +			next-level-cache = <&l2_2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu10: cpu@202 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x202>;
> +			next-level-cache = <&l2_2>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu11: cpu@203 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x203>;
> +			next-level-cache = <&l2_2>;
> +			enable-method = "psci";
> +		};
> +
> +		l2_2: l2-cache2 {
> +			compatible = "cache";
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +
> +		/* CLUSTER 3 */
> +		cpu12: cpu@300 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x300>;
> +			next-level-cache = <&l2_3>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu13: cpu@301 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x301>;
> +			next-level-cache = <&l2_3>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu14: cpu@302 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x302>;
> +			next-level-cache = <&l2_3>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu15: cpu@303 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a72";
> +			reg = <0x303>;
> +			next-level-cache = <&l2_3>;
> +			enable-method = "psci";
> +		};
> +
> +		l2_3: l2-cache3 {
> +			compatible = "cache";
> +			cache-unified;
> +			cache-level = <2>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/amd/elba-asic-common.dtsi b/arch/arm64/boot/dts/amd/elba-asic-common.dtsi
> new file mode 100644
> index 000000000000..1a615788f54e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amd/elba-asic-common.dtsi
> @@ -0,0 +1,80 @@
> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +/*
> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
> + */
> +
> +&ahb_clk {
> +	clock-frequency = <400000000>;
> +};
> +
> +&emmc_clk {
> +	clock-frequency = <200000000>;
> +};
> +
> +&flash_clk {
> +	clock-frequency = <400000000>;
> +};
> +
> +&ref_clk {
> +	clock-frequency = <156250000>;
> +};
> +
> +&qspi {
> +	status = "okay";
> +
> +	flash0: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +		spi-rx-bus-width = <2>;
> +		m25p,fast-read;
> +		cdns,read-delay = <0>;
> +		cdns,tshsl-ns = <0>;
> +		cdns,tsd2d-ns = <0>;
> +		cdns,tchsh-ns = <0>;
> +		cdns,tslch-ns = <0>;
> +	};
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	cap-mmc-hw-reset;
> +	resets = <&rstc 0>;
> +	status = "okay";
> +};
> +
> +&wdt0 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	rtc@51 {
> +		compatible = "nxp,pcf85263";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&spi0 {
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	num-cs = <4>;
> +	cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
> +		   <&porta 7 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +
> +	rstc: system-controller@0 {
> +		compatible = "amd,pensando-elba-ctrl";
> +		reg = <0>;
> +		spi-max-frequency = <12000000>;
> +		interrupt-parent = <&porta>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +		#reset-cells = <1>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/amd/elba-asic.dts b/arch/arm64/boot/dts/amd/elba-asic.dts
> new file mode 100644
> index 000000000000..c3f4da2f7449
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amd/elba-asic.dts
> @@ -0,0 +1,28 @@
> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +/*
> + * Device Tree file for AMD Pensando Elba Board.
> + *
> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
> + */
> +
> +/dts-v1/;
> +
> +#include "elba.dtsi"
> +#include "elba-16core.dtsi"
> +#include "elba-asic-common.dtsi"
> +#include "elba-flash-parts.dtsi"
> +
> +/ {
> +	model = "AMD Pensando Elba Board";
> +	compatible = "amd,pensando-elba-ortano", "amd,pensando-elba";
> +
> +	aliases {
> +		serial0 = &uart0;
> +		spi0 = &spi0;
> +		spi1 = &qspi;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi b/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
> new file mode 100644
> index 000000000000..9bffdf23511f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amd/elba-flash-parts.dtsi
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +/*
> + * Copyright 2020-2023 Advanced Micro Devices, Inc.
> + */
> +
> +&flash0 {
> +	partitions {
> +		compatible = "fixed-partitions";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		partition@0 {
> +			label = "rsvd";
> +			reg = <0x0 0x10000>;
> +			read-only;
> +		};
> +
> +		partition@10000 {
> +			label = "flash";
> +			reg = <0x10000 0xfff0000>;
> +		};
> +
> +		partition@f0000 {
> +			label = "golduenv";
> +			reg = <0xf0000 0x10000>;
> +		};
> +
> +		partition@100000 {
> +			label = "boot0";
> +			reg = <0x100000 0x80000>;
> +		};
> +
> +		partition@180000 {
> +			label = "golduboot";
> +			reg = <0x180000 0x200000>;
> +		};
> +
> +		partition@380000 {
> +			label = "brdcfg0";
> +			reg = <0x380000 0x10000>;
> +		};
> +
> +		partition@390000 {
> +			label = "brdcfg1";
> +			reg = <0x390000 0x10000>;
> +		};
> +
> +		partition@400000 {
> +			label = "goldfw";
> +			reg = <0x400000 0x3c00000>;
> +		};
> +
> +		partition@4010000 {
> +			label = "fwmap";
> +			reg = <0x4010000 0x20000>;
> +		};
> +
> +		partition@4030000 {
> +			label = "fwsel";
> +			reg = <0x4030000 0x20000>;
> +		};
> +
> +		partition@4090000 {
> +			label = "bootlog";
> +			reg = <0x4090000 0x20000>;
> +		};
> +
> +		partition@40b0000 {
> +			label = "panicbuf";
> +			reg = <0x40b0000 0x20000>;
> +		};
> +
> +		partition@40d0000 {
> +			label = "uservars";
> +			reg = <0x40d0000 0x20000>;
> +		};
> +
> +		partition@4200000 {
> +			label = "uboota";
> +			reg = <0x4200000 0x400000>;
> +		};
> +
> +		partition@4600000 {
> +			label = "ubootb";
> +			reg = <0x4600000 0x400000>;
> +		};
> +
> +		partition@4a00000 {
> +			label = "mainfwa";
> +			reg = <0x4a00000 0x1000000>;
> +		};
> +
> +		partition@5a00000 {
> +			label = "mainfwb";
> +			reg = <0x5a00000 0x1000000>;
> +		};
> +
> +		partition@6a00000 {
> +			label = "diaguboot";
> +			reg = <0x6a00000 0x400000>;
> +		};
> +
> +		partition@6e00000 {
> +			label = "spare";
> +			reg = <0x6e00000 0x1200000>;
> +		};
> +
> +		partition@8000000 {
> +			label = "diagfw";
> +			reg = <0x8000000 0x7fe0000>;
> +		};
> +
> +		partition@ffe0000 {
> +			label = "ubootenv";
> +			reg = <0xffe0000 0x10000>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/amd/elba.dtsi b/arch/arm64/boot/dts/amd/elba.dtsi
> new file mode 100644
> index 000000000000..674890cf2a34
> --- /dev/null
> +++ b/arch/arm64/boot/dts/amd/elba.dtsi
> @@ -0,0 +1,191 @@
> +// SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +/*
> + * Copyright 2020-2022 Advanced Micro Devices, Inc.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "dt-bindings/interrupt-controller/arm-gic.h"
> +
> +/ {
> +	model = "Elba ASIC Board";
> +	compatible = "amd,pensando-elba";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	dma-coherent;
> +
> +	ahb_clk: oscillator0 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	emmc_clk: oscillator2 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	flash_clk: oscillator3 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	ref_clk: oscillator4 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a72-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		i2c0: i2c@400 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0x400 0x0 0x100>;
> +			clocks = <&ahb_clk>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			i2c-sda-hold-time-ns = <480>;
> +			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		wdt0: watchdog@1400 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0x0 0x1400 0x0 0x100>;
> +			clocks = <&ahb_clk>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		qspi: spi@2400 {
> +			compatible = "amd,pensando-elba-qspi", "cdns,qspi-nor";
> +			reg = <0x0 0x2400 0x0 0x400>,
> +			      <0x0 0x7fff0000 0x0 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&flash_clk>;
> +			cdns,fifo-depth = <1024>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x7fff0000>;
> +			status = "disabled";
> +		};
> +
> +		spi0: spi@2800 {
> +			compatible = "amd,pensando-elba-spi";
> +			reg = <0x0 0x2800 0x0 0x100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			amd,pensando-elba-syscon = <&syscon>;
> +			clocks = <&ahb_clk>;
> +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			num-cs = <2>;
> +			status = "disabled";
> +		};
> +
> +		gpio0: gpio@4000 {
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0x0 0x4000 0x0 0x78>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			porta: gpio-port@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				reg = <0>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <8>;
> +				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-controller;
> +				interrupt-parent = <&gic>;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			portb: gpio-port@1 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				reg = <1>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <8>;
> +			};
> +		};
> +
> +		uart0: serial@4800 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x4800 0x0 0x100>;
> +			clocks = <&ref_clk>;
> +			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +		};
> +
> +		gic: interrupt-controller@800000 {
> +			compatible = "arm,gic-v3";
> +			reg = <0x0 0x800000 0x0 0x200000>,	/* GICD */
> +			      <0x0 0xa00000 0x0 0x200000>,	/* GICR */
> +			      <0x0 0x60000000 0x0 0x2000>,	/* GICC */
> +			      <0x0 0x60010000 0x0 0x1000>,	/* GICH */
> +			      <0x0 0x60020000 0x0 0x2000>;	/* GICV */
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			#interrupt-cells = <3>;
> +			ranges;
> +			interrupt-controller;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			/*
> +			 * Elba specific pre-ITS is enabled using the
> +			 * existing property socionext,synquacer-pre-its
> +			 */
> +			gic_its: msi-controller@820000 {
> +				compatible = "arm,gic-v3-its";
> +				reg = <0x0 0x820000 0x0 0x10000>;
> +				msi-controller;
> +				#msi-cells = <1>;
> +				socionext,synquacer-pre-its =
> +							<0xc00000 0x1000000>;
> +			};
> +		};
> +
> +		emmc: mmc@30440000 {
> +			compatible = "amd,pensando-elba-sd4hc", "cdns,sd4hc";
> +			reg = <0x0 0x30440000 0x0 0x10000>,
> +			      <0x0 0x30480044 0x0 0x4>;	/* byte-lane ctrl */
> +			clocks = <&emmc_clk>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			cdns,phy-input-delay-sd-highspeed = <0x4>;
> +			cdns,phy-input-delay-legacy = <0x4>;
> +			cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
> +			cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;
> +			mmc-ddr-1_8v;
> +			status = "disabled";
> +		};
> +
> +		syscon: syscon@307c0000 {
> +			compatible = "amd,pensando-elba-syscon", "syscon";
> +			reg = <0x0 0x307c0000 0x0 0x3000>;
> +		};
> +	};
> +};

