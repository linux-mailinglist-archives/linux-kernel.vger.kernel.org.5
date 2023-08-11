Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7292D778B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHKKLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbjHKKKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:10:36 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA1B4218;
        Fri, 11 Aug 2023 03:09:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AMieiv003165;
        Fri, 11 Aug 2023 10:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5S81AEJEtZFPKIcudQIjhHkxek8Ko1BRJ0a2jSTnNpc=;
 b=W+um5UnaYUCVVXq2B3FaGONn8maoCpU7+UpCBSHLaeSE6b9tBOi/u1FCWLxje5LZuEqC
 Wd8QfhtFtZIw0r9r5Ji9ZuBvl9lJX9F3E8ow4MncgTt0hwSLEfjqJH6T0Dbr0Es5hCED
 pA4miGBow4V6EWPBHo+wkwwWbekfTIFPZ8PQLDccmBe7NXypNUFjCPIGhSbzMjEU4BWH
 YI0lRnq1/nmmzhQvO/xzVVkybTnJzSoeDHedkCkw/YEF0vJRajvI/v7ob11fMjXII/r5
 ThqU6Q/8EzToPy7kIAueWoFPp59qgbAXIxvDDkkrn+7aLz651/DxR4qcImgIjly/CPZ8 tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8y5gr8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 10:08:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37B8rUXO016412;
        Fri, 11 Aug 2023 10:08:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvg65ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 10:08:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tffc3Qld+I/UPJFB7ZudJoRIlCrrPaBheuaFZA1v/EEDpNPBQI4/KJuWFqB4CbrYQ7Pa1HrJtZUNqeWV7HBG68rqOW1QbWRFGFJp/jV/FgLuvwFleCyx4g1nVY4SgWqOlCZWQ6Ol3FmvSqxqJvg3ThDOVEG6qvCbv+v+rYmLt/YRBukEn2CxBcoWpP36C1DtwyaFoTSi7T1WJFmY0rE1zVDw6bH35tGRz1csz3d175N1toBDKSzlFt5sGvYjBDcQQd0BjDqPXXqAoJmE6Cj17cRKK12WSX/v5hF3vpA7xgvpNh4l6lytIy6zZmsoys2vT0dLaB7t52c4BQPUfAH+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5S81AEJEtZFPKIcudQIjhHkxek8Ko1BRJ0a2jSTnNpc=;
 b=RZkTZZWlUrgBQ+h8vrRb47/7DbKbohCysEWZY4S4ucTwp6zisFztli07cz2mY7kRFebG0sT5AZZ2DBqQPSf9zPYafuI2NZGtrcg3PbPP6ZQPcU2Ck4ovJpfu/1RccO2BIa9hbxiDW8g5fSeKFm3Iqcn/lHuDhlBFWD9xnCFhuqpW0prsE8spiw5TUjTOTCN62tHWR0GYzeoYb/sOB1HKmJGJUMlbI1WX1ZQMK4RBpR1t8VuHC/c0gl6fPslxCaQTHt7aTRQIli9TIyjvIUdNzAOIWeRmqvX4qAy5Wp4swsWqCXewnQplRXT45XV83Ho2DvNVi5Df4JjtWY7zZKr2wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S81AEJEtZFPKIcudQIjhHkxek8Ko1BRJ0a2jSTnNpc=;
 b=BZPsMKcXhwHECObXFRhahPndHAATf2OCsvsB2acZ1dK34tlpDgeqfks5C4t6fZs9PxjmImdx3kvDKFDhayQO4u4Q+jDmx8cVVksqdfIwZ2hm2HbvKFPcac06dcDCN1sfvk8U2Hrm0SWlNa8Wp5unq6xntfuv5Unuw0z67WYZHrA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA0PR10MB7275.namprd10.prod.outlook.com (2603:10b6:208:3de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 10:08:42 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 10:08:42 +0000
Message-ID: <b99d2ac9-e6cd-9cea-a8a6-79c21d756139@oracle.com>
Date:   Fri, 11 Aug 2023 11:08:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/4] perf vendor events arm64: AmpereOne: Mark affected
 STALL_* events impacted by errata
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com>
 <20230803211331.140553-3-ilkka@os.amperecomputing.com>
 <b690cae6-ee9c-2c6b-a19e-60088cb8cb19@oracle.com>
 <d3da2a30-9e9-73c3-b1aa-aca508bd259@os.amperecomputing.com>
 <265ae2c0-d355-f282-4463-4a677d9969cd@os.amperecomputing.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <265ae2c0-d355-f282-4463-4a677d9969cd@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP265CA0465.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1d4::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA0PR10MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: 70bc3f6f-c589-4adc-3669-08db9a52f099
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9FxE6tshfpsSOio/Wufs2+/1U4DZKTvg8ec7lOcKfhmJrQ1WKKbEDx22vkvBtbpcOSo/pdDIw7Jiq//QznG2rdWxqu4MEFz2m3Qs30Erc8uIgHmJy5XIgr3rWQafOtBe1XaGDclPCscac3Yw0YZJDoilP6SbXA/sxUOPZ3j5r6Ob8vfe1mTNO+hKmNqMtSBDPbxhvViQXlDnxfC22t31vyyddY1hKcrYqFENFDQmYqu/BzucOTOGH1IhX99uBWfuq7RsALdm8dPEhqCpJ0CRKxAtl1lmUvSBZgx8Pv1AE74ARo5kc9NwOXD9U30anc4m0gww9k2yugAq0ZqILLysLAtf72Xl77jmePCu1KFiFGfzMEffhv5BjTH2/dmp0sniLuffjQqyd+LjrOuRwbRj7Ot6qoxs4GoCZqH7+zQpnu7AJDMist7Gsf8qpwPxcomgYM9EqmxTBQox07esR4zSL9W3rAgC/mYkFAxve15SdVW1eOyDL41SkG9gcgtrJHfUJdZsexSKCbYwGL+aDAggmg8l9kSAJaYssNiBFkzsoReQIw+wyAgck13p4zt2h96U5kGx5fTu1wVvofPq9juGW1s9DvTBhlYfI2Q2zJCSaFbB1uXEnj75PHOvQVNmJgdPweqQNa2aYNfqIsq4uOKy0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(186006)(1800799006)(6666004)(4326008)(36756003)(107886003)(26005)(2616005)(53546011)(6506007)(8676002)(7416002)(8936002)(86362001)(41300700001)(316002)(5660300002)(66946007)(66556008)(66476007)(6916009)(31696002)(54906003)(478600001)(6486002)(36916002)(6512007)(2906002)(83380400001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHY5eWVGdzYrVlhrY0szZi8zRFJpdzZFY282U3FyOVNpZ3NiRnhHRTFMRFhV?=
 =?utf-8?B?ei9EbmRHTHM1RzVFQ2dMYWtmb1kyQXU0NWMwU0NmQVNBR09oZG0wSDhDY2gx?=
 =?utf-8?B?OTJYaTZ1ZjBLSjh4S1V6cnNYTXhxRVZ2ckRyNU9HaWZlZ28yZ1VzN3VuNy9m?=
 =?utf-8?B?RHlDWmYzMGtxT0owRTREVEpzTjBXMmJMN1E1OHFMempFY3p6UmhZSHhxeU80?=
 =?utf-8?B?THN4MmFiTFRCWGJ2NGx6eGRZeVFsRUFqdnh6dmkrSEwvaTdOOXk1RTJMY3VZ?=
 =?utf-8?B?WUFoNVdZZzRXTnlhTzZWTzIrR095TC9LMURQT1JMNUR4OEw4RXIrWmxrbE03?=
 =?utf-8?B?ZjZYSlBnV3ZnTEd4Rm90dUZCdXdJRmg4KzFiK1hoNnd4UTZ6anNBalFyU3U1?=
 =?utf-8?B?UExqdXZUTWl5eVNoaDVGK1Y0Q09HTzdTWjg0UEpEWVJzbGJRR0RMbndFS3JQ?=
 =?utf-8?B?QkplK08zckhlZlVDS3laSVRpOXNzQXNTdk1EWEFDU3Q1bXY4SUY0ZE5KVFZy?=
 =?utf-8?B?bzVIb0VndGtpVmMzMWpaUVltcFZEZG1scXBBUDlEQVV0ek9yT0EzaU0vaTdT?=
 =?utf-8?B?d05YQzZaRlpiOEZQQS9PaTRCWWZKR1hDaEhpUWwxeHlocElVcy9DRVRkL3JV?=
 =?utf-8?B?YVRYcVVIZXVXeXNUTkxHUUR2eTlValNybmRCUFBhMU04ZDdwYTBOY2ZieW1H?=
 =?utf-8?B?cGd5dS9qZFE3eDNaaVZ6b1hKOXdXZjF5a0pBWUo0Tk9MRFNwd1JXRlJoMW40?=
 =?utf-8?B?VU1FL0UrWkUzTXZZYUJRcHYrekhDaE1acEFpbHMxSXVpQlJYY3dNcFVXRXZy?=
 =?utf-8?B?UVJCRHdoQlJsc3lWeFUvc2NPWkRCcUdKNG91cE1lWGkxVm4rbXZhZTZYbUFZ?=
 =?utf-8?B?RDNGd0hVaStSMzl5cjhkVERWTTQ1d0RVRDI0dnlTdWxtUW1JNVI1Z1ZqK3BC?=
 =?utf-8?B?V3JQK2xyR1NhT2Z4ZjdyMmVLeWw4RktKNkR1L0VDWGEvVHNIU3hyZHJIdWlN?=
 =?utf-8?B?WDFpWkFyV1p3Q1liV0dQcForQ1BMT1diVFYxSmZKZWYrYkpsQXAwSlorcGNY?=
 =?utf-8?B?emhSU2kvSWpKMGVPRXpIdCtlQzUvclROOFVLQzVmTG9kMS8wUHgrd0FIUlRM?=
 =?utf-8?B?MmJBNDdPQk5lQmxkMkNUaFVIL2N5U1hNYnhMb2xUQVd4NXpZVEg4NUM1cWRH?=
 =?utf-8?B?N05OUVlvRVdxcnhSZGtGSkFFcEtGNW9YNDBBbVpta3Y5Y0RsY1FQNUYweDhR?=
 =?utf-8?B?RTlMTHVKbjlMSUsvK1ZOL012cHUwcGpPZ3htbDYxM2Y4ZEszUVI0ZGdPNys1?=
 =?utf-8?B?Y0dDaERUQ1pqYytOeWNJN1hscWxMYmp2WmFwV0grelJKZWVOd1p4RTk2UlFn?=
 =?utf-8?B?ME9nK0VLNEp1T2hoUHJwd1BNczlLRFBNSUFHRHN0RFYvQU14Z1FOeUFENnBF?=
 =?utf-8?B?UlFQTWI5eW5ieFpRT1hERlZZZUtrTWVqYjRiRmFFR0w3TmVUU01MZzRvVDJS?=
 =?utf-8?B?VlMzd0d5ZXVFb2QxQmVIUXFNSkh5cXVjMURXNFNUWTc2cVNlQ2VUVDFSUzRL?=
 =?utf-8?B?SjlYam9jZktpOU9zZUg1OU5vdytlTmF6Tnd2WlQvcTF0UTFUcTdnOVpmWXdD?=
 =?utf-8?B?OVJtUDYxNzVIMGVGQmtQWEtsQ1c4VnJobVVvK2lWZkZzbDBLd0ZaUHlxNXZW?=
 =?utf-8?B?M2QyMEFpcU05Um03WkpDalB2NjN1ODJkSWdVVmQ2NXVURUlTYldJaVg5UDRt?=
 =?utf-8?B?OFluV2JReUt2TC9ZMENVc3hEOXdWbGRHK1dKbE1DVEh5MXBzL0JndWxJeHpY?=
 =?utf-8?B?cEtZVWtjRnJEZjRhTU9XQ1Rqb3NBMzhZalYzSUVxL2kwbEl2QVpYdUxjZ1o5?=
 =?utf-8?B?MDdGT3JRTXA2bllxTjRNSlQ2L0c2NEE1OVBLNlAyM2N0dXo5Smw2dXhJbWVy?=
 =?utf-8?B?cUZrUXMzSVFya2FRaVVZcTZPaG9mWE15bktwYnQ3TkQ2VXZoSGw1azdLdmE2?=
 =?utf-8?B?SEp2c2ZvcFZqdGgzZnNZcmdjQ2gzQ0Y1VWRLQlhrWTFmNUxlTGgycitKdWt0?=
 =?utf-8?B?VWZoMDFtRFNmY3JoZVVOb3djbkl6Q2pmVlFYOVhRZ1FJSk9BZExqcXRBK0ZK?=
 =?utf-8?Q?W6wWVf0B9sZGiJvxO/1f83z0a?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bmR4cElVOVdMNzVLUGl1M1hSQzhBQWJ1Z0VrOWJsSHRUcjhERTM4VXNSbXpG?=
 =?utf-8?B?K1ROVFJneTJaN3pXejF4SkVVY2NjcEtJUW5SVmtnME04bDFDYmNRd0U2ejNx?=
 =?utf-8?B?ejYyN0NXYTRmek1TdE5pT09TNGFWcUUzQXo1clVtMS9lOFRyZ3JjcnFRUExJ?=
 =?utf-8?B?bHpiUXRYNDNiWE9kbTJOV3hVbTdtbVJEN01pL1M0R0g3ZWF4c1ZqUjR4aThV?=
 =?utf-8?B?TG5XckNudlMxSnpHM2xlR05sb0JXV3JQcm56L3QzNVF0WW5icXNON3puOWlI?=
 =?utf-8?B?Z3BmWUN0YjdtVzdzd2o0MWlvNzUxQVBIM2JDRWhFS3dZeTdwUWFoRTlBQ201?=
 =?utf-8?B?WjA5V3ZUSWtHZW9DeWJucXNhYko0emQrK0lvSHliclMvUmY2WXZDNW9jTjVB?=
 =?utf-8?B?ZEVqc2ZzdDhyd0VwTGxzYXVpSEpwR0dSOGd0K1FuUFNFWWd5NlNmTjFZNXZW?=
 =?utf-8?B?QWRuV2J2QWkxQXRGellweDNvYlo0cWM1R1dMYmNjTFZjLzczaWV6TjZUL0Rw?=
 =?utf-8?B?aXlRKzlOcnVtVFZ2bUs0dVoxK01OMTlSVTFwdlpNVjhEKzZNN0Z0Sk0xanZu?=
 =?utf-8?B?dnZmb2xQMWkzUmVMMXNXZkhCdmV2cUFScHdMVXAxQytybkEvYUFGcXl3TzFH?=
 =?utf-8?B?N1owN0pHZEljZjlDcVIrRWE5TWF1WmVqM3ZITnFQWXpFZ1RJSGFKZ3hXUGpQ?=
 =?utf-8?B?eFV5RjNNTGFUWEFDa1BFVHFQY0h0UzNBcG9wcURpQWlEbHBOUmU2bWN2SzFO?=
 =?utf-8?B?SHgvZ2pYMG04QWpGcnZSdEdoeEF0MHluZGs1S0s1bHppK0ZJT3NmYXpHOGEw?=
 =?utf-8?B?bm5QckZuRGxlSCt1Sys1d1pqek5aOVlaUEZwMVFxeFhXZzZpNk1JeENnREN6?=
 =?utf-8?B?RzZhempRem1zYTZsQmduM0pUcjdiVm9qdS8zWmErSmpJeTNtc21FdXg2MVZN?=
 =?utf-8?B?UGJvZU8xQlZXY0xzRTJGaWVjbkl4K1FLYU14bUlWd2V1ZCtjbmVJMVpkMW56?=
 =?utf-8?B?R3ZjMExXajRWVDZVbXJYcmliNGpHNjZvUUJVUHZORzI4SXJuVUk1emtGSjQz?=
 =?utf-8?B?SWNXdFJndk1tSUJwVEJJdWlscHdMRnF0dVhaUVNLeTYyUUMzQ2hxMEFOZW94?=
 =?utf-8?B?WGR2QktrVHNmMDdBT3dCOEh5S25JNW5nS1Z6YWRUblVDZ3lOaEtCbVlkY1kw?=
 =?utf-8?B?dHZDdjFCZGNHMUJ4QXVNRjdJYUo5cGFma1BqcStMbTNJcE1vL0s0Wk5kU09C?=
 =?utf-8?B?S2ZFY1J1Q0xnMmx4WXRyV2tLL002NjR6RTVwb0FtelZzOUJDVFE3Q0ZKR0lV?=
 =?utf-8?B?WkZ1MGVHSy9qVWlJbGd6MStLUUlkNzcrN09QaFl4RFk2K3dXdEduUXg1MWky?=
 =?utf-8?B?dytiSUpUZlVTbzhYbktpNlNaMkZhSCsvUFhWQVpIZ21uSGp0NlkzRFA0YkFk?=
 =?utf-8?B?OE5rcWQ4K2kyZkdFeW00UWpUc1QxT212V25ZKys0UmVrN21oeHBacFVzbHN0?=
 =?utf-8?Q?z62rCC+GGYjejlfgpgB4sjmRurJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70bc3f6f-c589-4adc-3669-08db9a52f099
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 10:08:42.0342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G0BUyTE44bVxbJAlkw1+jwcB/1r7LVAvbRcXDBY2my2PukY668ewjcTu8SBXTxM2cx6dpru9vChNEvhTS8W6JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7275
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_20,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110092
X-Proofpoint-ORIG-GUID: tzc2NkiEUWUysDqpAlbRfrPhlx1SB7RL
X-Proofpoint-GUID: tzc2NkiEUWUysDqpAlbRfrPhlx1SB7RL
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2023 23:38, Ilkka Koskinen wrote:
>>> why end with a '-'?
>>
>> That's a great question! I wish, I remembered why I did that. Looking 
>> at other events with Errata field, they use '.'. I can fix those and 
>> submit the patchset again.
> 
> John, I took a look at it and it seems that if I use '.', perf will 
> remove it. Here are two examples:
> 
> metrics.json:
> "BriefDescription": "Impacted by errata, use metrics instead."
> 
> # perf list
> [Impacted by errata, use metrics instead Spec update: Errata AC03_CPU_29]
> 
> vs.
> 
> "BriefDescription": "Impacted by errata, use metrics instead -"
> 
> # perf list
> 
> Impacted by errata, use metrics instead - Spec update: Errata AC03_CPU_29

ah, ok. I am not sure where the '.' removal is coming from.

> 
> ---
> 
> So, I believe, I probably used the hyphen to make the 'perf list' output 
> a little "prettier". Well, I just change to dot and it's fine.

Fine. Or we could consider changing the 'perf list' formatting code to 
add this '-' or similar automatically.

Thanks,
John
