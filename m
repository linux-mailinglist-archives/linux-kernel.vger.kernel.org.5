Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070807CD6EC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjJRItw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjJRItu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:49:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7B6FD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:49:48 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I7496F017042;
        Wed, 18 Oct 2023 08:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=aQ/30rBsDFYNImEneQ+xxvc58NDoQpLHQJ9H0NIv6IA=;
 b=dRrlHsAtTfxbm0ytlzZ/LjlUEZlpnhqrkbYuepM4mzTNC1607D/x7ZqKBBO2Fqa5tvy5
 krYUPZh29zyIl/lZXzV3s3eT0ZwP14vxpVp29tT+RFT3ZJRbppIHvHNnW4s8j0rg2xvm
 vGbhothnrpxqoPMqV/sUiGkEDD7IRSDukzCUcH/3MY4Y/UFSLS/A1dS+8BMKpAeHVqru
 2RLWp5UtEfnJNaMNNnYLHa33c1z9PxZyomd5tOaQlh1mAbQqWaxrx9qI59XFPoBGXMsB
 /8BfkyZxNixbqeQXLF3JQLk1pqPLbmqXZ6yZ/WcvQJboTh7snxb9lhciboBpX9R+Y1u7 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk3jq1q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 08:49:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39I6UkWj040556;
        Wed, 18 Oct 2023 08:49:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfynes5r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 08:49:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxD1ohJ7F110Jh1uXsq8r9S5ZbW63S1mJ89z32hzZXfjgK4jhWFvmaExxLAxNUBrSh6PIlaF+/yb2PhywdxDUtKbVc53f8AT2dIY/UFf1AAwtFzKwKp6IaD/T+ZxdgZ5Zjc6VfOH50KspOVQI0uTwoEszfB68eqtyim9UhF3wqNHbD4fDR5ga44SRAfNtcfDtoEQ90iM4pgGQwgs4nfw+8vtZU6guN4MdfZVwhdMTLgZ/ixWygw4tiWP5yPBL4yoTOvP7NgJUtcpM6CdoDIcMfxGE0e+oxVYwG4XUcKZVdPYyiyQYeOsjBpV7fbJMHEH6uCXvE6umBldK7JGq9VTrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQ/30rBsDFYNImEneQ+xxvc58NDoQpLHQJ9H0NIv6IA=;
 b=W5HkvHk/YC8ZqLBM19EUx7pLWiopWB0KMZIwPTiENzGnErhyax1T4RlzWXXNGAUHF0x8snUzItw82djzO061bNpA5qgeq3Jn9Ct0N3SEGht4X3thS0N+CBRfhZokLihHFsAY3dKm99LFflYFZcktZ/GcYitlpGqMZjbFMEk6MdrnEkP2opCgzfc4X7D3HM1RrbcmSjRteDnlAjAP5FM2frLW6Te++T7C7I64Z5VRHjBnRp3WfmczY4tQuGSK4wxuDc/wbYjeAplbS0Xww38vzyUIfi4f4SVf0GWGeXWNAjJ+B+csWuCqRpBxcHIc49bl4Gk1jTbK2LJHe3coIxNFJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQ/30rBsDFYNImEneQ+xxvc58NDoQpLHQJ9H0NIv6IA=;
 b=n/JoJVDniMuo6IoAcFWM9sc8XblNAZBEF0/1YZ/N6U7qdCtvP1mErulTT9v3+TWmCCuoHLUSRjYUknlCkvraqIDp9Xk3ZVzo3TYHKRy26Na6tNm3OBe4TiYpHVaAiIiCm+gE4HIJv8jZyeset25lD/wJ848On65QIOw2aMhehhs=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by CH0PR10MB4940.namprd10.prod.outlook.com (2603:10b6:610:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 08:49:32 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::5393:c70f:cefa:91c1%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 08:49:32 +0000
Message-ID: <d2b52f01-3d00-46ad-b58e-e23fd8a49e87@oracle.com>
Date:   Wed, 18 Oct 2023 01:49:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] vhost-vdpa: reset vendor specific mapping to initial
 state in .release
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>
Cc:     Eugenio Perez Martin <eperezma@redhat.com>, mst@redhat.com,
        xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1696928580-7520-1-git-send-email-si-wei.liu@oracle.com>
 <1696928580-7520-3-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtkcyC54M_8A63uBEYjJP+EinLzTk3gP8CQ_rWs0Omt-Q@mail.gmail.com>
 <1bd79050-8eb5-49f6-9e58-6c7eb3fcab3e@oracle.com>
 <CACGkMEt_zvBM=ysbXZJEC1sdbCk=BpcWvtjeuP_L2WH4ke1dWQ@mail.gmail.com>
 <CAJaqyWf0AhsS6kaGUMVCosDjuRoeCAqO3OTVC=veqjV3jCqUjQ@mail.gmail.com>
 <8f8c0c28-59a4-489b-9276-fc3b5cfa8faa@oracle.com>
 <CACGkMEs0W1joaNh0-a27Nekxn8V8CmGgr99p+r60dA6sQeys5g@mail.gmail.com>
 <c9c819b9-4a63-4bb4-a977-881f6e653ed8@oracle.com>
 <CACGkMEuX8-T6BhbiqkTfF3NBoxS35zQ=k6Th=h0G5sDz4DV93Q@mail.gmail.com>
 <CACGkMEtZ_oEydqsvJh0-eaDh4q_KHq9fLPg1uy-W1m7K_g+1-w@mail.gmail.com>
From:   Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CACGkMEtZ_oEydqsvJh0-eaDh4q_KHq9fLPg1uy-W1m7K_g+1-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:208:160::37) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|CH0PR10MB4940:EE_
X-MS-Office365-Filtering-Correlation-Id: fb451e97-d788-4c4c-c0df-08dbcfb725db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fk6xdurA3F8UaKEvqZ5vbg6PMak2Vfha2xd9CXBtr9EX3R81I8bIX7sdmDq2lNgiX21NGmn1Hos95kfT8YQzeus1RBebQUlRmS1qF9tyC32tTpSfNnm5P67AWFKtQZtdC5fz0IUzQQuMPvKdOAw0/DMOs4LDPN9fW0x6eVxIwEddv108sSE1Vb7TLLorsZL+Q7g6dlQc+3EMcn31XJlQSFjr8livsTfuY5wQsIvqL/sC4JZkGjsGPJcppPLnDNN3f8OH7H6VJY7ljdkH16e7FLh4XEGCGUpqYeFMWHmRnLFh5YEBLojg2eLg43oMGQC6jv/Dow8O4dp7KWfepxOcY5O36Wpmciz4P1VpdPQjZ7Pgo/vMz0gPSOtLYqvf5yeClZ76aGsZ012ELF9mA0OWtBf7aHm7qQ+9Oa63zqtA4sROXD2QjIIdGI9WOsRvl+5b1NBF812xtJ8C6mInuIyYG5zkT/IDqKs+qqYsPUK6HYmXY5U3GQ9D1neA52ch1O0bcr2WXunKJzNUlrp5FagXPYoPN1EdiKCuvVnWM0Xp8RZCij1DHN1HIWHdYLtuK1eufQbtZa9AtvlUd36cZZl26I+X8TNRtLTHyn+1JKJAZb9udPSrbo2TjilwTvaerEDa8pKh+8yddPTqk+fkls78NLSLClz1WtIlF9UDHqprMtw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR10MB6535.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(6486002)(478600001)(66556008)(6916009)(41300700001)(66946007)(316002)(8936002)(4326008)(8676002)(31686004)(66476007)(66899024)(5660300002)(36916002)(6506007)(53546011)(86362001)(31696002)(6512007)(38100700002)(2616005)(36756003)(26005)(6666004)(83380400001)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFpudGp6Q1BVM0ZCQ1p6ZjJMTXNENDFwM2pKckdSQ3hqY0ZHTTRITTBEMGNu?=
 =?utf-8?B?dXJaU0JRczBMSmc1d0d1aEhKbXRSVXpDc3NJUUxZcC9sRktoNFVydGhScmtY?=
 =?utf-8?B?QXF1Rlh5bnlxNmZXT09HMWxKTHNZVnlXZmdxR0ROMVFDNHRXMXRyVU9lZkxT?=
 =?utf-8?B?RDh5YjVITEllM3BGd0NyMlM5T2htNTN0Wk82bTVCWmJVNmJPTkE1UUNoWTJq?=
 =?utf-8?B?emFBMmR1WGROYXIrdUVEUm5RRlBHaWMrUERFZDU3c0kzNmxKSGVaZ0RZNERM?=
 =?utf-8?B?UXY5QXFwd2ZySHFPOWtjaGpmSUVkM09vVVluQ2RpNVVyeVFwMWRXQlUza1Vk?=
 =?utf-8?B?Q0pQQlY5cVh4VHlETm1kOFNwYTNydkZWdktycEVSYWltbVJucnpCMndQR0Yy?=
 =?utf-8?B?ZityV09UcFM0MVpFRDh1Mm9BbWMyekt2cWtsbVpaZkNrSXZua01raUFUMkI3?=
 =?utf-8?B?MTc1MkFEZHQvSS9MYVpFSnJoNlpEdnFGNWVoS0M4eHdkdzluMmNNaXRSQ3pI?=
 =?utf-8?B?WVR4Y0NDbElrY1J5YmI0QzZ6TWZOaWFveHVCaXZnTzRaK3JyZTh4bGNzdEFV?=
 =?utf-8?B?cThUUTcxd0tld0lRa1hGMFVpYlVleGxpSDF1U1QzMHpRcHJZaXY2M0NVajRC?=
 =?utf-8?B?eEgrQzVVV21ycld6cU9BNjFLOG1oR2FJcWI2YzR6K1hzM0JPdXVGU05mbCsv?=
 =?utf-8?B?eGlDbXZwRTJsdWlXeDcvQlpXNXd3UXNhT1FsSXlCSlFhRW1MVlkvbzlzTjI4?=
 =?utf-8?B?QzFrSkZkeXhSbGdIalVzeWN5SGRzcit6aEZCRSthK2tjUUpNN0JUQnd3ajlS?=
 =?utf-8?B?K0c2Y0VNaTArazQzUVRGSksycTFEeXlWU0EwSytMR3VzSzVkaEowUGljWkdm?=
 =?utf-8?B?Z3ZTWWppd0k0cURYWEJrQ2k0NlpRcVBETHVrWWJaQmFpb0dIcTJTZ2s2Ui9Q?=
 =?utf-8?B?VUU1ajFlTU0vT1A4emdYaG1LWG02UWhoand1clQwVisxdXMwK1BnQ0RkUmFJ?=
 =?utf-8?B?bFZ1a0tYM3NOS2hZWHhpdjdncHBmdy9paXgyQWFhOFBUVTZ1c0F1eWtkZzh2?=
 =?utf-8?B?SHdDWlFaK1E5bFQyL3U4MjhVdW1RUXkrWCtGRSsybHdjbUx5Y3hRcFFodk9W?=
 =?utf-8?B?d1lsQXNBRmZWSVBxcU5McmY0MVV1Q0VtNjNKdEVGaDVhU21YUXRpem4vd25r?=
 =?utf-8?B?WXZ5dzFNc0prV05jY0IvdVEvaC9XSUU4dlVTTDJ1bm1CaGcvZDZVUEpJdWxo?=
 =?utf-8?B?K3NZaDFHc0M3YUhadlVJUGpta3RBLzBMNk9nTzZxRGVyY1ZYbDM4SmF3b0s2?=
 =?utf-8?B?ZktjSWpsTy9tT05kM2Z2NmdJWGdTS2hydjVhTlBNSmt6cHU2bHZUdVBIM0Jh?=
 =?utf-8?B?d0pHN2RzTCtqRGhBdFRST2YveGtZTVA1dm5DV0JtZ2xVTERHeWNYU01kUzZi?=
 =?utf-8?B?Yk9iTEN1K2FVQk5yTkhzUGtTcGxiSFp5OE43dVhQeWRob241cjhvZkUyZ1Rj?=
 =?utf-8?B?WDRrZkw5WkdtaW80dVJhVytNRXhMM1pYRGdDL3o1YU9qMGxTeVFhNDhMeUxR?=
 =?utf-8?B?M0crMS9UVVpuaEVwajNsSFJDM2dsc1dQWnhocUlhVXVTY3orTEtSckFRN0xl?=
 =?utf-8?B?eklNeHNtTTZmYW54WDhsMDNsYUxOQ3A1eHpBRGtwc29sQjAvL21RY05ZbTdU?=
 =?utf-8?B?dTBlZGFiaFJzMWhWaFNXR0dFdUdCQlp4a25oRVlzNEFkamZ4dFZuSjBvZmg5?=
 =?utf-8?B?UWRhS1BQY0hPdnR1cE1PYXIzRmdBVTBEbUxURHNBdStDbW5BSzhMaWJKWDZH?=
 =?utf-8?B?OXFhZStXd3RPNVlhOW5xeXhEd0c0OFA1MG9UbGo5LzUxYlNPV1RGZ0FiU3Qx?=
 =?utf-8?B?WGdwYzlsdUlyMEFId2x5RzNsa3NqV0JBQlNMMGJNb2QrdkRiNW9TS1BjTHJJ?=
 =?utf-8?B?bm1rN0IvMEFFenVLYktwRzc0eVdqeSttMDMyMWYxd1IvSzliMmx6RlFySUZq?=
 =?utf-8?B?RFFHbnR3akREVDc1QmRXL0ZBL2RacCtXY014cU1ZRHRxVnNFK0pBYUw5VkYw?=
 =?utf-8?B?L2xLalBjODVITHFvSmpDZ1Z6YS9Id3ArNGloMFM5MXJpWDhDVWYvS1k4alkw?=
 =?utf-8?Q?wZRxZfNZl9Us4KIL3xrK3BTmV?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?K2hmcVpua2txbDlJSDh3aUt6dVVsRzhERE1Cdko3RnlNY3NsS1greXBaNTg1?=
 =?utf-8?B?eTdJd0lDTUdMSnBSKzNSWkVaR2JhTXBOTTNoUWpkL2c3bVplZnZOeUduWDdL?=
 =?utf-8?B?Z3Z5UlFmUDY4NmN2RXd3c0FVU29kc1lDdExoZUdHYVRoK2lrTFpTQm0xZ1BZ?=
 =?utf-8?B?QTh6RGNaSDZYWEIvRTl1V2tsdWRFNWZxUlhlSi9IeHlVMGxaTmxMLzFxOCt2?=
 =?utf-8?B?NHJGQTk0TGd4a0hLZlJ0TkV2T1g4LzBoOVFmVGRIVU1YV0s1Q0ljYmo2NDF6?=
 =?utf-8?B?bDF3M2xuV0U4THFkMmhVSlNGZmg4N0h1cE1TcFlPWVFhUzFXc29Kbk9SVDNy?=
 =?utf-8?B?ZU9udlFRU2ZsOWtsejJHbXFqMlRJcGVSbEJYSXZCZDBCeWw2NWRvdTlBT1NE?=
 =?utf-8?B?ODZDYk92aXpUUHRTUTRuY3gzcEdtSzJnQmxLWmVBTXhhakxCZkJ5ek54WkNF?=
 =?utf-8?B?MDQrN01GVld6cXhzYm01VG1NcWxnZkNuYWUrcFVOSG4vSk9COTVxVmZwSTlq?=
 =?utf-8?B?MUIwWFBKNk1OSW1TelNqU2xua2xRMFA0cnJPZGozWjhGRjUwQmUxLzU0Z1A5?=
 =?utf-8?B?d0J2N3JXd01tazdIR082bFpUUW9wVUJMajlLcm16aVBkNHR4S1JseDVibS9R?=
 =?utf-8?B?Vk43RGovSVA3RTBJdDVJSWhmU1ExSDNRK3kralV4SEFuNnhBdEJqSnNpdWUx?=
 =?utf-8?B?SVpSR1dwK3ozSGR2cHJlL2t6VFVjelVlNEUyYytlZVRRYSs2eFh6ek9zSUQ4?=
 =?utf-8?B?dUZMQVU5ektZb21LTDVlY1ZldGxjWnBQTlc3dEU3akxaNWtyeC9HMnpQK1cw?=
 =?utf-8?B?YWZLbzBWbXU1RjA3K3hYdDhieU1Zb1YraHREaE81dGpXWjY0YTBhaThETERF?=
 =?utf-8?B?aGNiVkwzVHFpN3I5STBib1lySUowZFU2KzBhd0gvclEveS9BemFrSDRNcmNa?=
 =?utf-8?B?SGNnQm1WbFMwRlVlWkpkTDhIU0F4dlZpWDlId1hueEFxMnlxRUovZ09pd3pC?=
 =?utf-8?B?NWYyTXRYYzJSbENPSFF1ZjN4QlJKQSt0bGZJQlAvYWRKaXlodUZJeDNDK1RG?=
 =?utf-8?B?NW5UVS94b2Z5aUM1NFVCTFFzNUVXOEFtWUt0dlVxQ0dhRDcrNXZRTzY5S2VG?=
 =?utf-8?B?NzhUelhKMW44L3NNaUN0TUNlbFV3QUJVK0d4VXlkczA3cG12QTc3N3hYRGEz?=
 =?utf-8?B?Vk9HL1FwSkRtRSsyemkzeVRXck00S0hnN3dDb1ZmLzF1RXNHV1hWdTNpdmkz?=
 =?utf-8?Q?Ckn6+jkpjYmiKe+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb451e97-d788-4c4c-c0df-08dbcfb725db
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 08:49:32.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+Q0NR0ZZFx5Rb96YzKIHxo1MM4tdxlZGB/RdTGKpA76xvNq3LRmcuQ1XUoBP5CG02w4JqgWA0rbrO/Sk/SzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4940
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_06,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=838 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180073
X-Proofpoint-GUID: 6ARHR6jR_RkyXyJjSkrZL11eZsZDJmzG
X-Proofpoint-ORIG-GUID: 6ARHR6jR_RkyXyJjSkrZL11eZsZDJmzG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/2023 12:00 AM, Jason Wang wrote:
>> Unfortunately, it's a must to stick to ABI. I agree it's a mess but we
>> don't have a better choice. Or we can fail the probe if userspace
>> doesn't ack this feature.
> Antoher idea we can just do the following in vhost_vdpa reset?
>
> config->reset()
> if (IOTLB_PERSIST is not set) {
>      config->reset_map()
> }
>
> Then we don't have the burden to maintain them in the parent?
>
> Thanks
Please see my earlier response in the other email, thanks.

----------------%<----------------%<----------------

First, the ideal fix would be to leave this reset_vendor_mappings() 
emulation code on the individual driver itself, which already has the 
broken behavior. But today there's no backend feature negotiation 
between vhost-vdpa and the parent driver. Do we want to send down the 
acked_backend_features to parent drivers?

Second, IOTLB_PERSIST is needed but not sufficient. Due to lack of 
backend feature negotiation in parent driver, if vhost-vdpa has to 
provide the old-behaviour emulation for compatibility on driver's 
behalf, it needs to be done per-driver basis. There could be good 
on-chip or vendor IOMMU implementation which doesn't clear the IOTLB in 
.reset, and vendor specific IOMMU doesn't have to provide .reset_map, we 
should allow these good driver implementations rather than 
unconditionally stick to some specific problematic behavior for every 
other good driver. Then we need a set of device flags (backend_features 
bit again?) to indicate the specific driver needs upper layer's help on 
old-behaviour emulation.

Last but not least, I'm not sure how to properly emulate 
reset_vendor_mappings() from vhost-vdpa layer. If a vendor driver has no 
.reset_map op implemented, or if .reset_map has a slightly different 
implementation than what it used to reset the iotlb in the .reset op, 
then this either becomes effectively dead code if no one ends up using, 
or the vhost-vdpa emulation is helpless and limited in scope, unable to 
cover all the cases.

----------------%<----------------%<----------------
