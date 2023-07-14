Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93EFE753A46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbjGNL72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjGNL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:59:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B955430C6;
        Fri, 14 Jul 2023 04:59:24 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36EBwnjr011968;
        Fri, 14 Jul 2023 11:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HR1xvYIHFYT8e55HWATK5FC1pmrgRRe9EUjl1GfFiF8=;
 b=A5TKs3Z/uudZs8icax+GUe2JmRfmnFBUFBBZ0r4O/62gD3/Ca67YcmUWI7mNLTRTjs1Z
 xWgRJRrI6Rb/QzWAbr4MW1AYn9JjL+6Yw61Hy+5LbC3YlXnZiEaIZUWkw0VOCSINTjsg
 iomORAHVdCy9mcBaEkzwoRBOBKD6NLWMrvxL1vaIFh/MRx4n00SwGZ4r3U/xQe5xLld5
 SPJ3n9CIKoYSJmNpUBA5WDo+mys4YtJ/2S40YOlfFlAhx+R3eHK2xyFJZ6HLF1+422iC
 BwA8E/x+ntOBfsGKbrZx8pWpKzXynMAHDsXyhcL32P3BnZD1aXuvYOXY0WZi8mgX+D2X BA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rtpth1bvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 11:58:49 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36EAZoLP002103;
        Fri, 14 Jul 2023 11:58:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rtpvx1unh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Jul 2023 11:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnaQjKqjiu56jNJQbV5bk7BaYGw/Yh+lQsNg+Z2XSqNt23AqDB/uV4g/bVaZ7o6+JpHRQaOZotT9KFYaRDvFxaBKnNy3QZzHFwCmEARBgOSk5zHN8ABeMu2RMZARwngAcjP82nD4vf4J7EtQE3D1PhGuRg19k+lOTw5WJpzPPhH+AKDiqvwUXAnsdw5tr1KBrSCYETRE+B4kJUmPa78h7uUcq8I3vBYn1Rxp5WRGs9ZxzfOzo+F1WLLmIJvRy51IwgsMGUuB68cTVQFw8NtMMk4Nm8+40g59nidVjslsl5QFDzRQVehf+liCmctQkE22ZohMO4C2o4e6lRrHZUjSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HR1xvYIHFYT8e55HWATK5FC1pmrgRRe9EUjl1GfFiF8=;
 b=Z9QBwmZWeg239MoTZGIQNCEVb6nkugUKsYStjrc/Rj2PEctCxRJ3sjAvMa4ewonZP6kRHslulOUeyHZrcUzUfS0JADEWkDc4xkYGxYqRUyrBU6bsVTlEo/hfPyGJu+JvESVMeS1mrt3V+vOR8fTT6zgEfMAmRW90Wt5TihirOpGwlYp2uCD9Tro+PZVlfsWHA56VtEb/io4xnyw7203ea5PrNUHPLdN0mRcfZKa6Er/XUv/v3xedZHrItp8pHRRsvJ8B1iz4xcNPIudV52meXLmCb9h2tjtomVBjbHSEaNVQig0/FO7cjLDB+Elhz/Ayu6sllUuRz8n7W4HDwCOmZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HR1xvYIHFYT8e55HWATK5FC1pmrgRRe9EUjl1GfFiF8=;
 b=vOUQk9gzXxdrer3VKydLryWj6gje1zcObYk/npc/C6Z0D42kv4n4THKQ/D0Mn4WovWcrEOYnTvs31HLcOqFM7jRMAs+du9CWPDY+9B0WnyWcZI9ZXj5hhweLcDUefjCUn1VvBTW7dWPCBD3YY0VCxPpKj5qEOQ1xLE1/qW7VLPA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7189.namprd10.prod.outlook.com (2603:10b6:8:ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 11:58:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 11:58:42 +0000
Message-ID: <eb011f48-b953-3647-4699-734ebdf1876a@oracle.com>
Date:   Fri, 14 Jul 2023 12:58:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com>
 <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
 <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com>
 <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
 <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com>
 <CAP-5=fX+rz928LtFs2MWYUH=6Mcvz0XQcLRkO-n9BnVnX4RYWw@mail.gmail.com>
 <297ddf04-9b35-7613-8efd-2857668b6835@oracle.com>
 <CAP-5=fXSQVyqCfrBJFjHkrRdANuQC=TKR-HHi37hLaQ91rPQiA@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fXSQVyqCfrBJFjHkrRdANuQC=TKR-HHi37hLaQ91rPQiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0046.eurprd04.prod.outlook.com
 (2603:10a6:208:1::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 627ea8ec-73b3-4003-86e6-08db8461ab21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kZ/4338pGmtBZK7ufAoRLzYegh9Mvi5AXd+7tuZq/D0zfUcTt0fqKkJJXY7Xv3Dui77AGweJ5rikSM50Z2kjgfl+2ULs2SCrTISFgCQg1meda7tDHoutoICUVhipKB8nAs3Q/zscV7fQ32/2aJ3E2CxufhnL4XULop4Znsky/w/8CjzDd+39AoZUphoJz0kfblpjOVlEZQ5tPQMEU8OISzTFGGiSTfP8cOsyTTcApJDhQwa/9FH3pn6zYhzjZBWpvftGTRBVhWvqkPYufygkT1UT2ihpEwY/evVIqYehlVv2ttFnp7k9gsFHfh7o8y3SH9+VQxv7N0A5kHVOqxsw0wLuEv9bAH/yC5B6fbir4dF7PoEbohpoOf+bA7LO1bGQzshTb3bNEltccxG2t4PVEiHimsgT0lR5iEfhOXp24oZnImDqdKLBrvWy0Pj6bUdwqBsbFB25SL93ofA4aIVAYbI656M4LOjFCfFEyUoLViQ8NOJGVRO5uIOyzUqbGoUlT94i5gD8McZwtrukeVAg7gjFE7Ucsd8kFc7JBE/4qZj24mqdiVF1NeT7HhO/QH06OYFKKd/2Po07yWYTyzkPOYjMPOhWehPZ3BgtREDkyvkK8MV/B8mUEJXmJDBJhzWgjaNiqMhrh3G6R03BsvV7Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(31686004)(2906002)(478600001)(6486002)(6666004)(36916002)(36756003)(8676002)(8936002)(7416002)(66946007)(6916009)(41300700001)(66556008)(4326008)(66476007)(316002)(6512007)(83380400001)(38100700002)(31696002)(6506007)(5660300002)(86362001)(26005)(186003)(2616005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjluVHpZbGNTVDdpd1hWUldkSDV4SnMxL01VL1Rtb3I2NHpUb3FpRTYza2tQ?=
 =?utf-8?B?YndURSsvTW8va3Fxanh4bm1xVVZzT1NHOXNoOGM3eXBXZkNQY3NZczVCemhN?=
 =?utf-8?B?OFpPMUVOeFNtdWNHSWxYSHhZYUdJaFg2TnB4c0RrWlJDcHR2cW1WYWl2Tk1m?=
 =?utf-8?B?dEhWRzBaZWFIQUNhZ2VsZjZ2OWJFYlUwWS9MY0FjeXpIbGNZU0Fuc1Jub09G?=
 =?utf-8?B?cjd3NUV3NjBKb3lVL2ZOMURPcjZ3OHJUTzBmckpmcFltVVdPSHl0cDZyL25q?=
 =?utf-8?B?eUs2Q0dVd25pc0Vnd1FIOEJWbUhTR1RDaVk1K2RXdTlOQm1pS1ZHWi9vTGFS?=
 =?utf-8?B?dXVYQ3BMV1BSWXk0Vm82enZmUnVGTzRIRW1LeWQ5Zks5eWtsWUx3NU5aWXRE?=
 =?utf-8?B?ZWlvN2ZxZWxwbGw4bDhPK2llQTdXUGtsaTg2NUpXcGxmNG45QlE0c3dUY1Rn?=
 =?utf-8?B?Z1VYd3p1d0hEeFN6NFp5cEE4cW5qZElTRVhVRE50aGJJSkZhQWpMbVZtaFhP?=
 =?utf-8?B?YzFJNjQyZ1FDbWU2NW5hN1lEazNla3o5bkMvQjB2dmxpU1ZuTGpsK0txc21a?=
 =?utf-8?B?S1QyaU5aS2liRzFFb0pwTE52VUw5TkIra2RORVRoTnBRdWJJOFYvb0hWRHZ0?=
 =?utf-8?B?bDJOZFp2eGlJMlM2Y3YyQklWRXU4SERlOXJGRHRGYXZQRkdtVzNFZktLV2lu?=
 =?utf-8?B?S2RzSEVhQlNZaXZoVXAzMXZkWWJudldJcFBWN3RoR1FEY3NhdzhPNmRUaXhK?=
 =?utf-8?B?U3RjcXNBWG40THNYbGdCcmY4SmJrRFpqQy9RNEdLZk00cnRyc1QwK1JCL1FZ?=
 =?utf-8?B?ZVFOMXFCYWxWcnR0Mmx3a0RnbUtJTDNDREc0SFlZNnVSYkU0dXIxWU5ueTlE?=
 =?utf-8?B?cUVtOW9XUWdtUzRzMmlmaWxFYjkxVmpFYmxua040T0x0N3ZHRDJ5bjEySDY2?=
 =?utf-8?B?ZEJQcHJSQkNQNitCWXRpQWc4TWdTTCtLREhLVFNlbm9xbWZTVDE0NE9mU1J3?=
 =?utf-8?B?NHY4ZkVCSE1OOU1FVHNxTVh1MkphWkZWSXZzeEpqZTkrUWk4OEs4L3NCZzZk?=
 =?utf-8?B?QW4xdmdReTExZ05XWlZ6YkJnTi9YdlRzT2FPMnd1QWtpV0FWZlc5YXAyS3pT?=
 =?utf-8?B?d2M0b0pKbjZnYTdYbU5Lai9QcHIwNHFWUS8zRXBCdGFjRC9ZM0NLZWNJUlhL?=
 =?utf-8?B?TWZFVmQ1R3RGYWRLV2FXR0J5eHZyU1BQaVBudGplMUVYbnBoYjlRaUZHa3Br?=
 =?utf-8?B?ZmZNRG9UY2FWR2txelhIV0lHSjN1VmtvQzFxQno2NHlCZ3NVT1FYQjFiVFBl?=
 =?utf-8?B?VmNxeUJwMm5Qb3VWQmlzZ2g0YVB0cU81OXJ2Y1VvSXhWZGFEV0dKVnFOMDhG?=
 =?utf-8?B?OUk0WHVyVWZLbzMzY1Jud0Z0UDk0WVZBZys2ZFJUQ2h4UXpEV0pHY2lXYU51?=
 =?utf-8?B?ZU5KREhVQUl2c0IwcFJHZVJqcWY2K1ZzLzVBUGxlYnNxeEZKdzB2aVpJdjg2?=
 =?utf-8?B?dTBrKzQ5Z0NMbHdJdGptT1ZmQ21TYWlRSEVEVWhjYWltNFZNTko5ZEhrWDJm?=
 =?utf-8?B?bnR4SG5WOFN3ZHZQOUlodkdTa3VEZGJBdVduai9hdS9BOHBCODY0UmJSc3A0?=
 =?utf-8?B?OCtka2x1Q0luVEw1elQxMTl3RzA0S25jM3pYMGJKZnBBNFA0YTFLUVhpY0hm?=
 =?utf-8?B?T1J2VzR2dUZtMHIzNHhXTlJvWHRWV09QSFlGSUg5cVY5ZGdtTjV0WnVHMDI4?=
 =?utf-8?B?OHFFNlB0c2ZSajA3cnordjkvL2lRdXJiRVFYV0laY0plV3JCbzhBeXZBUlNq?=
 =?utf-8?B?VnBwcElzQytpRGVZZFlIQTd2Z3NFb1FKdmd4RFNjSEF0N2k0UGIxbDRyamZ4?=
 =?utf-8?B?Y1JEWHJUbnQwWmdwU3lkNzlTNXFzOXViaFlLTUE0OUlFQVloRzY1MXdkNGJ1?=
 =?utf-8?B?L1NKVXFPYkc5QlNBa2QzY29KTjEzOFdBNXFQY2h0enJYU3B6ZHMrNlQ2ZnVz?=
 =?utf-8?B?c1M0eGRYZXFodVJyT045SndUandBa0J4YjlkVG1XL01RWkJWckdpdU1TN0NR?=
 =?utf-8?B?dWo5R1JwUEl5Vmo0MGxRYjhoYW13eHVTVE9ySHljTGpDMjhNcjdZOVg4WEIy?=
 =?utf-8?Q?V63tmYRPeCVwryybyHQi+UFY9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aFlHeUEwelA4OThVRVhady9MTjI3VTRKeVFsdW5Iem5HV09FQXBLRlFTdkgw?=
 =?utf-8?B?M2QraUlaM3IzNlZ5OUlpTmhGNzk4eWNSc2prU3Q5dzlXOFJGUGhPVkpxcnZn?=
 =?utf-8?B?K2dYMVpIcUJGM2pldC9HQ1U2Y2R6Z2RreUM3RjNtS0xXU0dLRDI2dTZ2WmRv?=
 =?utf-8?B?MG1DRTVsOWkyT3VBOUZ3aVJQWFhscDVHMk1BOGczY0owdzRPWE5UZk9FY2dJ?=
 =?utf-8?B?TnlPR2ZkT01tenh1SlZ1SHAzbFZEbmZaaGJVWGVKbXdmcGFOcnIwRXlvTXQ2?=
 =?utf-8?B?L29rNDN6RzUxNWNrZUVrVjdBNE41Wi9uY3I3VnhIT2dtSVNWZVpySWtlZWU0?=
 =?utf-8?B?MHBwUTZrYXRuUkZCdm4rZUgxOU8zdk5uWWRmbXdqMTFCYmdtamhwbjNjZTRH?=
 =?utf-8?B?RURoeFkrNzJXUkFINFZRcmx6VStWU1FzcUFqd20zejhPS3EzeWw0LzNsaVVu?=
 =?utf-8?B?NnU5VXdEQkZOUHFocU0wMnZ3c1NpaUpTUUNOZEw3SzRZb0kwZ2dQcnJTUE5j?=
 =?utf-8?B?QUxDdEtQMXBrYUlWN0oxb0xiQk9VVC95NU1HM1BRZTFWUGQ2RVlDbGRpNDFN?=
 =?utf-8?B?U1JsRTZ3d3gzWU43RFM0VlUyTzd0UnNmV2ZERGZGQXhpYnArQzJvMk1RZ1ZO?=
 =?utf-8?B?aDBPbUhRSm42TkF5U0FvZGdjZHBlamxlVyt0QmYwVE9UUWZDZUNoTjRKdDBD?=
 =?utf-8?B?eFJwR3RGV0ZhV3pTNVlubXNIRWhiSTBKSnJBeGd1N0M4eWp0VUtyOTZlUkdz?=
 =?utf-8?B?UFNkWk1OZkxMeUpSWjJTb2o0K0Q0M1ludkFLR1Q3M2lRaUxWOWtGam9tT1p0?=
 =?utf-8?B?QVdFczQ5QWZPM0M3SVdmbXpvNi9ueUlLL0VKWlZ6WTdjY0pqVXVCNW5DeW8x?=
 =?utf-8?B?dUtGRlJvQTZ5dGtVRE1pRnpYMzBseGcvTEZWM2syMFJ1dlA2RmVBd3lWUGha?=
 =?utf-8?B?RVZWREtSMUtoMTFDUVY5QTN6VHd0UHhXOFZ1YXllOGJpNGdIY2xadHBMKzVU?=
 =?utf-8?B?TXJpUnVubk9wWDhUUkpOcHBlMTZLTHJ5RUZyTW5YVEVhK1FVVUdWRVNXR1M4?=
 =?utf-8?B?WHB5RkVzWDd5aW9rWDJOc2oxQUVHWUxIbDdnVkxpV3l5OGpkM0ZjOVkyUVVT?=
 =?utf-8?B?VHRJbndiSnBuWjhHVFpGMjdKclRPSzUzZDc4RW16c3llQnRLTVc5eGMrZlU1?=
 =?utf-8?B?M2lER0NUTlhmNHRLSXQ1dWtKUGlqdlpRZHpZNjljRU5NV29NaWVrcUlCZVFE?=
 =?utf-8?B?SE9iSnFlc3UyNlQzL3NuOTJMYmc5UE43ZWF5M3pRMGRHTTRyc0FQY0NtT0pD?=
 =?utf-8?B?aTNSQ3RFNjgzdWpUUExsQXZyZFdYc05zY2pLa2hjaDRMOEdpU3h1N0JkQXpw?=
 =?utf-8?B?K1h5ZlQrK1VwdFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627ea8ec-73b3-4003-86e6-08db8461ab21
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 11:58:42.3900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqatH0ZmL0hlzyy6g+mVve0X9Z3Fmg14zQ98TYJKJCWi2xaxBFHyJ/FaannNh3GBUhN3k0BxDgQA575dpEORiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140108
X-Proofpoint-GUID: bCSHQZKfmRIT_tNVLXkXGkJHGiSbVmJT
X-Proofpoint-ORIG-GUID: bCSHQZKfmRIT_tNVLXkXGkJHGiSbVmJT
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 22:35, Ian Rogers wrote:
>>
>> {
>>                  "MetricExpr": "pmu_unit@event_foo@ * pmu_unit@event_bar@ * 2",
>>                  "MetricName": "metric_baz",
>> },
>> {
>>                  "EventCode": "0x84",
>>                  "EventName": "event_foo ",
>>                  "Compat": "0x00000040",
>>                  "Unit": "pmu_unit"
>> },
>> {
>>                  "EventCode": "0x85",
>>                  "EventName": "event_bar ",
>>                  "Compat": "0x00000040",
>>                  "Unit": "pmu_unit"
>> },
>>
>> And we have a pmu with name and hw id matching "pmu_unit" and
>> "0x00000040" present, that we select metric metric_baz for soc_b
> Not sure I'm fully understanding.With the sysfs layout we'd have to
> have a way of supporting CPUIDs, we could have a mapfile.csv style
> approach or perhaps encode the CPUID into the path. It is complex as
> CPUIDs are wildcards in the tool.

I am not sure why you mention CPUIDs. sys events and their metrics are 
matched only on Unit and Compat.

Furthermore, my solution here is based what we have today, and would not 
be based on this sysfs solution which you mention.

> 
>>> I think Unit may be useful, say on Intel
>>> hybrid I want the tma_fround_bound metric on just cpu_atom. Currently
>>> the use of Unit is messy for metrics, ie uncore metrics are associated
>>> with core PMUs, and what to do with a MetricExpr with >1 PMU. I think
>>> we're learning from trying. I'm just hoping the migration to a sysfs
>>> style layout will still be possible, as I can see lots of upside in
>>> terms of testing, 1 approach, etc.
>> Do you have an RFC or something for this "sysfs style layout"? I think
>> that it would be easier for me to understand your idea by seeing the SW.
> When I get a chance 😄 My thought is to first extend jevents.py to
> have a second output format, so sysfs style rather than pmu-events.c.
> This way we can merge the changes as a jevents.py feature even if we
> don't change the perf tool to support it.

ok, fine, but I would still like this progress this work now. It has 
been sitting around for some time and was really difficult to rebase 
(since I was not tumbling my baseline).

Thanks,
John
