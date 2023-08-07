Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C6A771D0E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjHGJX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHGJXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:23:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C613BE76;
        Mon,  7 Aug 2023 02:23:53 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 376LvxYY003906;
        Mon, 7 Aug 2023 09:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=SUTjl8smYhiPM20RhlAf4gzeReRXozpqahReX0XlDFY=;
 b=Y5hj6qhHxhq+AwHrN8lze3MVenjCR1nYqqBYx3gQbNNeNEF/sgRh3Gn2mhe1+3vVJb2q
 /K3ktGr7rGz3uL/4G30YTtrF7L8PuTBOMyrM/a9gv2PhC/8wmjbmacKU7JjGnHOZGvVE
 MY1lu8boOengNXiY0zdVzinkrW1oOIXTnBqYxrGHGcTIoaGYDnsicEgQbPT9lbqNswOC
 lG0aAsFu3+Z/5ihrnHRGhUhRbLsHoOuHqJFBJxCLCCXMHWhRowK7uFVuYC+4ghLAZ4d6
 8FSRf6m6IQHp2A8Ap4KgwBrua76/FVcRQlOPTz42jlZj8Iv19IIm3uYBNje2cSUJAwzb 0g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eyua92t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 09:23:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3777HklO021503;
        Mon, 7 Aug 2023 09:23:22 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvarxs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Aug 2023 09:23:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzDgJv344Zb9hPLhnnYNGfJnS+xVsy5Ill/8n2agsGCW/sWIHxfrlvzmJy2EfGO1un2vxQH9kEIG3O4vqDribKB/nKGXoPlxClqUQVMw9a1Js8h364NjxsGgSK251LPN72ikxctWMOhe+EFcLuwR29j3lEspIsODpiuf/OMYo+j+OcLpiR4dlJ9t4SoazGcVjpWzdwIDMTmjGzFBgnQ4S0zTN0vMuuzBctzj3aFu2evgSdSDa6BUUe8LE6FdU3Kj58U9lNN/ucTHZzU78f/kNAATaDsZNzWtZArT+kA5bssKjhHX/yQziJBYMh9IWXp9G0/jZzIEpRCl3MZZLcnEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUTjl8smYhiPM20RhlAf4gzeReRXozpqahReX0XlDFY=;
 b=gFTQT6DUNOubDQckDd8fKLQmjslnoWrph/Vj2IWxZKjN/flO5UwRU/dmgMQpDX8iIZZ9xpe/u6R+wfQg5Ju4PwV70hJyRF1BjedVsonfO3PSEafs3eNBIBux2j/E9RoEPbfC9K76esPmWMfNUYouWXisMzz+ABWkDNVMqmsKXNd6e80l3w917nNv2GFsSQBva6TwcYr90qZzZ6st3o360PK32jyLfko2cY/4odVs1nqvss4qVq89Mh5R+Q/V+6tg69nSUdw8TOuWtS1ptiQuUFb2epxeTiCvGpieTzeky/oh3r+5uzi14ehvKPdG/nGnH6ig2/WB1Il6zuuPi8qytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUTjl8smYhiPM20RhlAf4gzeReRXozpqahReX0XlDFY=;
 b=ORn9aha1tklmGxBomMy0C73LQRm+rddLn+llF0e6ZxbeRgIY0YZiAwF7f+yz9xiWjfdfmrEfztBQn9bqSFx1YD80UVzFvCUkh6OBcF93/7ou8OThk+L45JCBugov4VGQvg5wa73z2AEL4aq/Y9ubj6gcDJd5au+o862YcMptKJg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB6916.namprd10.prod.outlook.com (2603:10b6:208:430::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 09:23:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 09:23:10 +0000
Message-ID: <c81cd933-dc8e-6a37-809e-2dce9c88aedd@oracle.com>
Date:   Mon, 7 Aug 2023 10:23:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 5/7] perf test: Add pmu-event test for "Compat" and new
 event_field.
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1691394685-61240-6-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1691394685-61240-6-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0038.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::26)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 627e8b2f-085b-4305-29d9-08db9727eb12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2skSgADE7O0iupuC+DpPa/BQrqNaavMwTkQ2kTgMtveLMaA/aUvEq26Bog3CyYms99nhrtQpJEny24M+NdnEMlU8EXBeRlBRVah6gM0sGkCehSFvQx3QN8wZnyUBFSc3bgoPAnwE1LUSSiZANuFKkL9gvf1nUtgjNpD+cn25vDP2crOnlm5NrDsqJlfPtaJd9Am6XkaI/ijlAR5sHvC41LfdMZziXvhKIhsej5c1tqytHaX0VYGsVkDB/p8Gi4DJfNFHuFq8BX3KAvOi2FXK1NDYB5s+JvvNA1/sGF7DFvtu6tfwwPS2n5y3e+ov1FDUSpv7+wCglXKONvMd1Prm0DeXa6XDxjB1DIqCbizjBficbNN1uYJn1GYQhH0f9+gFRvtZSj600QJIHXJGvDzIeAwK9e+Y17HRJFmUto2JDMluQTb4P0aqiLkN9rAuh8XO7wqWaxp/FCko7GXD0PdBCnJqPbvjhV11UD4yd93PUuMlkuIhL6q5Wf4//lFN1v8Aoj53V5FuEK1yyQ1rRGqvCe7r5s8VP78szuEMsEr6eZyvfg9Ltf33EsFx+NJiCezAvAUef8chO3kD9rD3NzgTjpuA/UMLMW2EAGbJTnuuqT5rnnApSWHRI19EeMIuMlgQ4aJXfCNnqNzWFWSgR9QsMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199021)(186006)(1800799003)(2616005)(36756003)(6512007)(4326008)(316002)(86362001)(478600001)(54906003)(110136005)(38100700002)(6666004)(66946007)(36916002)(6486002)(66556008)(66476007)(31696002)(53546011)(6506007)(41300700001)(26005)(8676002)(8936002)(4744005)(2906002)(83380400001)(7416002)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzBTbXJRVlArNjMvUnJ4aDZLQzUyRGE2cVh5YkNjNkVWWmdHSWMyaFhVaTRW?=
 =?utf-8?B?OEIxbldTRGVCam15cWJnZlUwdnJiaFoxS1ZaSWxhZWtLdE5zVEpDU2tWbnhC?=
 =?utf-8?B?YUJ2Q1R6dDlPa2ZESzdvbGFzUHlEdjFYME1RV0NKV0x4MnpySHdUSzZGSENw?=
 =?utf-8?B?MkpXSjJ1UnA2dkpRaTNXMkQ1RC9zTmdxUW01dzVQdDFlVUp4OFNraUZicUNY?=
 =?utf-8?B?Uk1FNjBubjM4R2hGVlYvcGFrQS95NUJFVzFTaTJaVnAyNjZtVkVBV1Rhd0NK?=
 =?utf-8?B?bE1hNzU4OTY3N0lIMElEdkN5dU9teWpSVnBkcFg3ckhkSlF5bzVIYldBZlpi?=
 =?utf-8?B?dXQ2Y1hpOHdMY3k2MlhZZ0s2RWlZTWdIOGtCdDhSbUFQSDE5Vit2cUYwekc1?=
 =?utf-8?B?WE1CSWJvOWdtNFhmVVkrK0dpY3ZINlVqYjl2aHFvY2tnalNSY004R3FCZVFj?=
 =?utf-8?B?eTVPTTNWVFFNZStWNTFxWERueHZHRGlyTUVjQVUwMjVtd2N1ZW1wQVJ4cVhF?=
 =?utf-8?B?T2lCalZUYWNPSzZ4OFVYdjc2ZUhyNXhJRXQ1TzVyWUR0RTU2VEJtVk0wNnRW?=
 =?utf-8?B?Mm8wS29UbTlKWVIxa0NpOUdPYkJ2RERMRUp5ZVJRelFjamxoUHFSdDZ3dEFF?=
 =?utf-8?B?ZmJwWE90dW9iemFCZ0dId2Nkbyt6Tkd2YUMrRGF1V05BbjByNXBxVVFiY1JT?=
 =?utf-8?B?V1l2eVQrbkZnSEdibUtQT3NMTzZUdGxxK1FWbE1NY0hXYmFmOVNjbkJ6WDd0?=
 =?utf-8?B?S204cmM0dmx0ZmxlaWdXaFZJMkF1b2d5Q295YzNBU3F5UmZXcjJZdlRESHhq?=
 =?utf-8?B?Q0VQckIyWk9aMTZDYXZ1UDhyckg3Y3hkS0NNanpsVGdQZXRoM0s4dm1mUTNS?=
 =?utf-8?B?dkFRcHRDTmVDNWFkL0tHKzU0NkViTk95ZC92dkdaNmZGLzFuZ3pTUXZpdE1y?=
 =?utf-8?B?cllDTFM0clUyLzlaNm02S1V1S25KeldadkpsRUdhcDh1Q1FhaXRVY2owMGkz?=
 =?utf-8?B?ditFWnJiSnM1V3hyUWZZb3BnWjhrRnVOWkNZQ3krbGQxY1c1WCtCWkhnWUJz?=
 =?utf-8?B?NnE3cFN3cVh3eG9wY3lvdDlGbEV5dEs3YUNUR1VnK1ZQU3lTYk5IQ21leVcr?=
 =?utf-8?B?c3BCaUFjSTM5TVhydXFxeWpJS0RqQ0E4RWd1dDJ4N2RHc2tiZ3I3TS9TeU55?=
 =?utf-8?B?dURCeGh4NHl5amt4azR6K3dkOTUxMEx6MDJid1RpRkdiL3owdDJOQ3NvV1A0?=
 =?utf-8?B?d0d6K3U4aXphNVZlQm81aGRXU2pWVURiMDN4UTJIVXV6MmR2S0VpRUpSWGVI?=
 =?utf-8?B?a1lWamdpSDRna3NPQU1SUVZWMFlJZnd3dGpOS3FPb21PTmhZTFpvbFV0OUl0?=
 =?utf-8?B?TEVUYmk2NmhDcXphSld5aVdjSlUyS0RZV2JnbHBEZ1JNVVVSWkREb3M0cGRF?=
 =?utf-8?B?YkY2MXpVaUNBZ1BNZmk2UVFJcFB3MmFwc0RTVWNwOFNOeWpEelhORnZaRGpn?=
 =?utf-8?B?MkZCOS9UczBhU0lmK3U0bnlPQlFQUEF4NU5IMFRnT3BZemN1Umt2ME1yOHBz?=
 =?utf-8?B?QWJZY3NvV296NjZncUFBZTBMUTNzQlc4czV4MEVWeVB5YzFhMERpWlBoNVo1?=
 =?utf-8?B?RVoxRWgwcHZzZXp1d0lBOGRTZS9Jc0xXWklORVg1MnlCdmRWSzZLZk9jMTFZ?=
 =?utf-8?B?ZkkvdzAyemluazg1UmhHYnRpODBFaGFsMVVlTmpFbWZEdGJ4cEl6WFN4UnR2?=
 =?utf-8?B?VjhDRGE1YytPckRaWUFWa1NiNmdmdEZPbDErR1NKQXJHcDRadTBvVW5CZXZN?=
 =?utf-8?B?NDJCN2IwM09vNkM5b1lJOWVValNCdVlBVDNtamlCeXhMdzljZmttcG5MVkNW?=
 =?utf-8?B?alRwanV5TkJlU2hoY2wxWFhWYVp5bFhNWEJHTDhOSzNtYU0xS3FQcFd4SXg3?=
 =?utf-8?B?aktEK0lqUGJjdnM5amVrV3JaaTBRL2hPd1c1b3d1VzVsa1YzaG9Wb3JFT2xN?=
 =?utf-8?B?c3BLb1U3a1lMZ2RIbjR4Z1lwN25oV0Z5YnVlYkkrT0JldlJNWDEyNlEyN0FZ?=
 =?utf-8?B?bDRHWFFuK0pWQzNFRDFzVk0zK21MOEFpUm40NTNIV3FqT0FsNzRiempSakJI?=
 =?utf-8?Q?M8subccOogwKQhW6WkcXCH4lK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a200S2xHTWNIUGZSZjNMNnpodHpWVlVIbXRFNnc0dFZTOXRRRzQ4dkt2WjFx?=
 =?utf-8?B?TTFmYnJZbDEwZ0dEc3F3NDJXY2pzMVFvVWJkUXdoVGlQYytnTGFvQmRWMTNi?=
 =?utf-8?B?V3ZsbmJ1WGxmeXBNVWYxdXAvSnM5YXlaK1B1K2d5bDBNN3REUUsveFBjNHJ6?=
 =?utf-8?B?NWlVRThkbzZHVERSUlE4czNKb3hmbVRWaXkyTk91SFQrVEhLMS9yVDE1YUg1?=
 =?utf-8?B?T3lnL1FGZFF0NjRaRWdhNWthSVdlajZTR2VsaXUxZnppNVU2dkFpd1pnYnhZ?=
 =?utf-8?B?K3dBT0tnZFVqNlFDaXJuNTU5R21vVEtRME1xTEFoK2xZbjBoOHQzWW9OMGRY?=
 =?utf-8?B?V1VxUUorajEwb2k2MTZsS0V6emovTmxmSlA3bTM1V1R4bVJFWUZ1cEVTbXdq?=
 =?utf-8?B?Smh0S3YzcDFLQU5UZCsvU01OUGlzN3pPcFRPNnpxOEptNnF4NnRCZXBJd3ph?=
 =?utf-8?B?OE5OdExJaEdqVU9Sd0I5a0pQbEF2TEFLTkZnSTZvbGNmRVpKdGRYZVlhMHhI?=
 =?utf-8?B?c2tNa0IrbVRmaGdJOG0ya3ZWdEVBUlFyeHlEWHRLUzc1bTZheGdRRmxNc3ht?=
 =?utf-8?B?Q3dzNmo5d0hoNGt6Qkd2SU5PMTJ1QlQ1d2FKbmhCY0Q1V0c4aEJPbEJBN1FG?=
 =?utf-8?B?a3JETkRVcW5pQXBDTVpkUVFDaW0rRlh3SXJ5MVE4MFQ5bDZOc0dERnI2eDEz?=
 =?utf-8?B?WEQwamxweVByOFBudEtoRHRsMGErcnNvOEZ3azBrZFB2ZzJZYXVWT29WeFlw?=
 =?utf-8?B?citYWUQvTE1vc0szVnFoZ3F1RnZXTk9lc3l6SUFTSFBvZUpmbkVzdDVzN2VG?=
 =?utf-8?B?YS82Ulc2Yll2SHVFbXlBcEJ3cVlIVkRlaTREZWRDaTNnWHhOdWcxVDN3RjZR?=
 =?utf-8?B?aUs5bzFvbDNlY2RDVUxEKzI5WTd5MDBKUU5mK0ZsNVRmZFlwdzJmdTJEbnM2?=
 =?utf-8?B?cHFBV25FdXdkTnhvWHZteFZHWFFDMlhQMmU0WnhmV3Z3bmpPVVZsbkszbjdI?=
 =?utf-8?B?MnIyWjlkaS81SWJ2bWNhK0E0MVlpRFpZN0hITjRlT1pmdTk0RU91V3QvUEVB?=
 =?utf-8?B?MGVqWVZEVXF3cEhKOTJOWGlSOTJzWVFDbi9rdXBOTHJBb21MNng5Y3d6dkRp?=
 =?utf-8?B?V01CT0UvNFZzNTRlcm1zRmpsQWR5TG1RSVpJelpaYnBkVjNMSStJUitIQ3Zx?=
 =?utf-8?B?NGloQjc3Tm8vSTJQNlpvd0RFdTNWY3ZXYURJNUNYUDhGK3RnNUp3WDF6TTBs?=
 =?utf-8?B?ZmV3cWJ0M0dZYlJtdnZzRC9lTUNLRVVSRGJTK0l2NW5Ha1ZOcThGU1F5N3JM?=
 =?utf-8?B?WFR0SlNGc0d0TVdBWUxDQmVKbFkwV3FreXJ0V1huWlJRZlhqN0tYdXFmNnJN?=
 =?utf-8?B?MzVHNUR2WjhzZU92NnNTS3M2TldCeU01V004OTBtbnpzR0FLZjc2bDNKNlYx?=
 =?utf-8?B?bjlTaWswWVlBMGhyREVYRjA1cE1Wa1BRc3ZpeW1LZU9CckVOcllMeUZWMnBW?=
 =?utf-8?Q?z7/oyk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627e8b2f-085b-4305-29d9-08db9727eb12
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 09:23:10.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3G1TyXs4MWP8Pwq+SzTUaBd3DDNxU2TifnNiXE3xH+Dc6xEtKn59cpiGNsE+R4NqoDpmnu/j5FrnZDbdlSCPVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_08,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070087
X-Proofpoint-GUID: 00xUzZynM-b9Rm7R9Fo8XUWIq3pywlUe
X-Proofpoint-ORIG-GUID: 00xUzZynM-b9Rm7R9Fo8XUWIq3pywlUe
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 08:51, Jing Zhang wrote:
> Add new event test for uncore system event which is used to verify the
> functionality of "Compat" matching multiple identifiers and the new event
> fields "EventIdCode" and "Type".
> 
> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>


Reviewed-by: John Garry <john.g.garry@oracle.com>
