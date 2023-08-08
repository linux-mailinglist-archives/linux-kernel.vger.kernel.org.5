Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC90C7742BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjHHRt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjHHRs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:48:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C1DB0E09;
        Tue,  8 Aug 2023 09:21:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3781i8J5009931;
        Tue, 8 Aug 2023 07:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=VQ9fpNsGy4ecyU6Re2JYL4rpF4mLDYD8kZUx6bWsr9U=;
 b=3vPtjlgru56VyBjIdsYL/mdpUu3hFC4G+JMXJiUkE+Em1suiKvtuuFyc3yOBeD/DN4DC
 BnQ6pF6uhxfSiiMZHCqD3iRR0FCl9KcVQnF6xMaw3kX5mJ//FWLXjnV4hqVKbHFmVd7r
 V7+z6Fx85iBio3S+Pw8k63M9e2GwB4ntubQA9/keCDmuQEnk0HrNUhu2XaFhObsjsFO1
 umP7d8eXVxr/fEZjAiLjWBe02VzGdSSAMMxXKEqxxjdOKhM7uZakZB1eJYIhRDzuhym4
 cFab4S0EXvoB1bNxI9gu9snCqEZB21FncdmsDd9eF6VIxwLTXOPmMLx59U7tfz6uzVxl ug== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9eyucgh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 07:36:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3785jPpK032920;
        Tue, 8 Aug 2023 07:36:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvbpdwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 07:36:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7Ppszao2bNiDykqZHLA2BwseMt4zeBTcL6iEZtPZehZUvSR/JNpozNsSLtv7k1F4f9wZXrPl7Ih07x113F6Nph433WG+0w8Iq7RUPWhH0dqMAUybvmJ1JZHlqUckcK9vGbdpqyWp0jKJk3PtWXHdNJKyjgEdVFY2AhYzPrrbgKWVFCPpPqi7NfQtnV0DT7SpBzon0l5bdMf1i/d0GpkFFZ/zBKZb6ueKP0Ga/T/fnGV6sX79utQK7amti3ZUi6cf3UTcRLD+BpWygQ6BB+cZ0tFnryw1M6by7HsAT0SPGE41T9u5jAuNxHY5Wd/i5fy3ZJiql4eWCccVdLExbUb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQ9fpNsGy4ecyU6Re2JYL4rpF4mLDYD8kZUx6bWsr9U=;
 b=USJDy1aVlMDaxIGXDkWWj6Z7bASClz5Lzt3O9amuqwPT2j/+thBSzaaR2eEMLJc/G1SMmipkYvyVd3IRfdoB3EPLFYgEtNROasgTf8oTNTuaFHnasG1b7WaHvlfs3xY9zQRcQ3pZPsOM44dEPBPHxhgTmdn2dF2b5LSUvVsKh9ECeZXA60OpeflG2wALYHsmtyYqEc2khGfQeOInM94NksTvLow/6U0os0un1DbJ7k2/ehJeJzwnAREOuWuWWwtChAGaxkXEukAhoyfEgeIGsrbvVoyd20vQo26nXBR7mhyvUT1cYJIP2OrmDPWA6HHzcZ3ngXpbaNuQxcEvGmau6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQ9fpNsGy4ecyU6Re2JYL4rpF4mLDYD8kZUx6bWsr9U=;
 b=zfsmf9LwrY3bERblb6JPstcAw5WwmKZ9MsRB0aH2uKZEzmSKHkqJ9u/f1oU9tNy+lHb8XK2pe1CnUrLuA33S8tmuxpnRP75aR49DE3H5rN+B6Sir1DCeeqsxb1+CsiNYre/M4FZKPElZt5t2x3M7MZ4SaVyBeEWefxeg/wQzOy8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6660.namprd10.prod.outlook.com (2603:10b6:930:52::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 07:36:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 07:36:35 +0000
Message-ID: <b60e7be0-c49c-d6e2-d88d-64d3b82a7b90@oracle.com>
Date:   Tue, 8 Aug 2023 08:36:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 1/6] perf: cs-etm: Don't duplicate FIELD_GET()
Content-Language: en-US
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
References: <20230807142138.288713-1-james.clark@arm.com>
 <20230807142138.288713-2-james.clark@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230807142138.288713-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0111.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 14100b56-0b71-41a3-0fc6-08db97e23127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDNDR0XF+e6hEwVSzhT1SJ0BVaWJi80w3IlZqF7FzczUgMFEh682b1346SqwvEaNhfUJ8YxxmnLdkccAHc9ZGrnSJzSMUq0sI82YxxQSmnzzxMPwq+SC6hPDIQU6nUlpqBdqrM2Yrqyq8NdOpb1zzi4/oEtI0BHoKQTuaBZQWnrHmMErdMsdmRiOqBHUORI9ZYPpTpa62eHyl5CrLFY9Sr6VESwXnWp31/icrV70B7jqu2T3CXy2/bU/xoeEsmlLSsg890We5TrboGmvHBJ1V44zDDKwPnuICO3HApuz8++7GriT7xfu/aOj1HveouR7XO/YNoLQt/WVWnVs3KGkQzfOqUw4pxO+TkJtS6aZ9avXC/OQJ1N6FOJ0yyu/sAP+YBpiqblKfeRHI7vynsQ5sBHN10ChIrBasqYuYw05T6XJAB2WDVLEqyRX3hobJlujgpkuTkVvLN+1UT5nmMkUX7feM11An3+nC9ItVjm30by2qMKw8pCOy3g63M4akcHIFmsxxW3ZFtEj2OAK+i9vMKPKUIdgwk2zG/McH0tGILquCqeIEtCFbBaDzEpobvrBIhCcb7k3tf8UmX7cn35mCa+boj0W27Al9eSdjiu5cy6Rc8sH46+LUt4M+PhlvCNA6vfSOQYGCjHmnB55opaaYrBmV3r9zipN2tomQQhDpzaN1xX5WrvhJoHoBA+taOnhWi5T8MlDd3XHXrxoFuZkvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(90021799007)(186006)(1800799003)(451199021)(90011799007)(2616005)(478600001)(31686004)(83380400001)(6486002)(6512007)(53546011)(6506007)(26005)(66556008)(41300700001)(66476007)(316002)(8676002)(8936002)(31696002)(4326008)(2906002)(36916002)(6666004)(66946007)(36756003)(54906003)(38100700002)(558084003)(86362001)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjRmblBCVjRLdXgyNm5tZ3crZFR1KzZJcTRzTGIyVWFyNU5wbGY5Vk5xbTM1?=
 =?utf-8?B?NHpKUi8yYnIzWUd1T0FvOElVbEp1OTFZanY3Y1hVWmlIL3JUZWJnMjZPV2d0?=
 =?utf-8?B?ellQRGhYd0ZwMncrRlU0WE9CeFRjRFU4RzBsUWd6TlloQitaek1TdlBkblJ1?=
 =?utf-8?B?V1RieHdra2poM2dmaElTbnFTWGFzL0Zvd2dXNGVyQ212V05MTkxBcDkxbWti?=
 =?utf-8?B?cUhvOVpXYThTRnlUeWZjRmtNTm44UnNHR3l2WXcrWmNKSjE3S2lCd3BwdTNp?=
 =?utf-8?B?ZTJrZFFhZ1F3TXU0WlBrS256cFVGa21vSThWbVI0d0lYRmlNMFFSbVEwbHhQ?=
 =?utf-8?B?aGF3YmJoT0hWVWxqQnJURGowNURQNHJwcXN3NXN6OG4vZ2JXRVJHS1hJYlli?=
 =?utf-8?B?U0RHOEZCYmFVR0NIdUdMdTg4MHRUQ25ka1Ura3FXRW1zOFNpVlpXcWNxUU5m?=
 =?utf-8?B?KzNldmFDTTdZdGpxcCtMcGUza1laaGdWQUdDZ09HT0w3d2VyWFd5eldyL004?=
 =?utf-8?B?eURKQTJYL3lueGttVTZqZzh6YlBPTElVVnpWUC9QODFvVW1rY2lrdjNIcklz?=
 =?utf-8?B?ekUzTUZjVG9lay9UZG9DZWxZd09PaU15aVM4bWN0eDlLM3pRZmJ3RmZGTXl2?=
 =?utf-8?B?UGhMWjZRU1dNbUFSS2JiZEFXNHRZYnJ3dWZJdXhORFBSZjNQRms3RDVZdUs5?=
 =?utf-8?B?VXZTNkV6OGlsU2Z0STcyUHBSazUvTmRhUkppN0VoVWlNRStocVBpVjhud1FK?=
 =?utf-8?B?RlFFZG81VWE2dXdhRlFyQzZUVTJHY1RxOWJuRUR0Rk5oMFRUeXUxQmY0RTVp?=
 =?utf-8?B?THZLbFYwdHpOTmNLK0FId3E5akZlMGMxVFY5WkY1WmFXcnBHZC8rVktQdVlo?=
 =?utf-8?B?RWJpeUNGeVNrK09yN1NQZjhGRS9tWW9VdWU3aFUzMER1TzhzMGxnL1c0dTRH?=
 =?utf-8?B?eWc4b0dqZ1B2NUdCc2ZEQ2x4dXB2UWptcjBxQy9nd3ZyYTBPOFNXUXJMcGpl?=
 =?utf-8?B?aTN6QlgxMnFFOThyelUxNXM5ajhxOGVVcnpqcDZLd1pUMVY1UTh3Q01tWHcv?=
 =?utf-8?B?SWdWaDcrdGhtVWdRNjFyZnVNM1Fsa2REM2FvUDlORFhlVXZkRXBYZG41eHBs?=
 =?utf-8?B?RHlpQVBiS3VkbXRENGxxKzhDbDZBRndpK3hhZ3grdGxwa3d1dDczUktKN0VG?=
 =?utf-8?B?TUl5WDVTTDZSNGIrN09ibkVYYXZoMWg0US9QN3Z4bzliK1FEK0syQ0RDWkJp?=
 =?utf-8?B?ZW1mZzhRTGJORUhTSlhsZHBPNDM4R2JTR1ptYU5RNGN2Z3d6SlBQTGZXNm5m?=
 =?utf-8?B?NkUzT1BwbEM4a3JMNTBMc2pScVhmN3FNOUFVYXJ2RU5wU0RhdUh6RnFFN0dm?=
 =?utf-8?B?QjhtRFNrRlhseExiNW0vT2w0c1BHYUJHM0JKM29vejJieTFqeVlxOWdONVJj?=
 =?utf-8?B?UXJtNS83SkhLVUxLV25GNy9TMVZsaU9qOVZFN01IZ3FzS3laQ2UzcDVZWXRt?=
 =?utf-8?B?bWJuQXFFQ09XSTA5TFFUM3N0Z0NMaUd4T2srcFZXS0tMOGdmSVZzOWtqdldW?=
 =?utf-8?B?TFRpQnBtM0pxT09iak4yTFZiYW5yMGNRa1BYQi9rQTE2YzN3Qld5Umh0cFk3?=
 =?utf-8?B?anFnZk9LemdWYUVja3g3ZEdZS2pLREd2S2U5TnVpU3plZXFzK1c1RktJb3Vr?=
 =?utf-8?B?Qk55eUc5U2IyV0Zsa00rWWxsN1FJcnRkS3UvOHdxTFRtT1k1bEhzNnBmNUh6?=
 =?utf-8?B?azFDdm1XRlJUR3YyN1VDSU5LTG1wUGVwazNKZUY2OEdRQWxIeUVHcEFkVUNq?=
 =?utf-8?B?OHd1RnZnMkJUU1R5VTlBeXZUd2VKTnUybm1FMktIVlZuTm0wT2RXZlkvcVBH?=
 =?utf-8?B?L1gyZm1kRzlmbGhBaFlTNEoreFRob1VlcFc4NzZkRXB0SituY2pDUVplNnlX?=
 =?utf-8?B?YzFVaHpMZE5sNFFia2ZXWk94ZFhrNEpNamVRTDByVDMrZUZZWHdpbGhhTm9i?=
 =?utf-8?B?cGV1VWQzdGxXZndrV2ZiQzJBTDlQOFMyZW9lL2RjTHFDZm5CZnhSaU92cnN3?=
 =?utf-8?B?TllPMHJ2WmdFb0JpZ1pENFV5V1pPdSs3SDFkQ0NTZ1pIb1pHSno5V2FndUFF?=
 =?utf-8?B?QXliS0dsamd6b2pYMXZTaXd2RXIvUklHYkQ2QXZXM0tMSW9oeE5EdUthcllN?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?cDYvNTBjbjVpT3EzNmNQNG03YVFvcVdWeERHdkZ1VEd2eWFtMGRxRy9yeElx?=
 =?utf-8?B?djlVM2FpejFUUzdaR3J4RkhHdWFacS9nQ3J6S3lPYnd1K3hKay9CREV3QmZl?=
 =?utf-8?B?OVQ2VGpsd0d6WFNmUEJzS0NtbTdVcVkzWS96QTFTVDVYcXJoU0RDMEFmeHRE?=
 =?utf-8?B?Ull6MDloOUsxMThOTERhOWkxMThWTUk2WWZzSHNZbUJXM21zT2UvOE4wMWZx?=
 =?utf-8?B?VEN1ZXdyNWhDaHM3WWN5dkdFU3YxaFoyUkp2Vi82MU1zWElyYlBodUhDTTQ3?=
 =?utf-8?B?N0JzdTFCejI2Y29Nei91SXc0MjQvUDJmSlMxdTVxay9pNHF4M3F0dWJ1VzZn?=
 =?utf-8?B?NElZTllWY0F4T1IvSnRXQmVrVjJiMTdhVWxMSTZ4dzVOU0kxWURwc05yenVU?=
 =?utf-8?B?bm1YTUFUU1ZHVzZMVHVISnNlbWNHOER2eElEd1BySjY2SEJQZ1hzdEpEOXEx?=
 =?utf-8?B?RmJnSWZIdHJ3MHJxMzJsM091SUQ5SzN1OFFPS3ZqT1d6cmhQa2Z2S0UyVHVk?=
 =?utf-8?B?SG13OHViOEZlMHlsd2NvOVBRYjl4QkVqcStKSzJCR0VzUk9IZ0ZrSU01TVU1?=
 =?utf-8?B?THNOWUxMRHhvNXNwaVdWbVB5MEV3VmxUbDl1Sjc0djFwZGhSbE00TWRvOFpa?=
 =?utf-8?B?UVZSTEFRdi9sSnQ3dXRzcHFzekpwMkl5VUtlM251b2dWK1VEK0NMVkh2WmV5?=
 =?utf-8?B?V21YZVBmbjVSNUV1Zm5hNkg3dkxId1hzN3pRWXBySk9wOXFqR1lMYzdlV2Jr?=
 =?utf-8?B?aW9nbllQcGhHSWtjb09SV0FKS3JxYzdxUEY4bFVqdGJEeGtCdDR2c2ZRck1P?=
 =?utf-8?B?ZndkY1pFV0JHdmUrYmdQejNVVXJFcHQyQWhNY1NJQWtyaW9xYlUzNVNKVXE3?=
 =?utf-8?B?eFc2Q0N6TEhHVVR6dEJWdjlSZ2g5ZkNaNUtVUlkrT2VJS1phRldXV3M3RzEv?=
 =?utf-8?B?MGk5UzdWSDZEVlZZRzV0YXd3d2xOb1BmU3l5amtOUkI3T04xVnB4ZDlKTlA2?=
 =?utf-8?B?SzluYThTNHM3MlV1R0tSM2NBYlhHYVdzWFlnbVBvcDRoQ01oclo5aXdpRTlF?=
 =?utf-8?B?RlJPV0xwYm00YUlUN3hyNXQ5T1pnOThTQllnNWVDSkE4U1AvaGhXRklJRTFk?=
 =?utf-8?B?WTdaY1BveDRHUmMzdFpwVDhHSTU3dVRuRVhLVnYvZFp2OWF5QXVVWFoyYUxD?=
 =?utf-8?B?Z2RKcHpQd1lZUi9vQzY3ZTgydWVzSHZ4S0lHb21oTHZScno0Umw5ckoyQXUv?=
 =?utf-8?B?TU1pd3JVQitvMENqYnFneFBHa2o2UnVVaVZnR1g1WVNBU2tGSFlUUnBnZlJx?=
 =?utf-8?B?aTVUV3BzVXR3RlEvVUp2TVUzWVdNdENYWUM3MExLR2lUc3JUejgvVjRIVkcv?=
 =?utf-8?B?REhqTE0wN0JJRzc1VVRYWjVwVzIweTRsUXY1RjVhYmRGVWpXMGRKNGhXbnFM?=
 =?utf-8?B?OEpZdm4wTDlRU2ZlMmpCSm9UM01NQy9wQTMzOUtzMGR0WEZESnAyYTY5Qlcz?=
 =?utf-8?B?WjQrUXN6T2xYbk5rWG90WjY1RjdaTVN2N25qOUQvZnk5VGpDcWEySVp1aEl4?=
 =?utf-8?B?Wkg0WUdDNit6M0VSSld3aStIZDBOZ0NzWmsvUmJ2aURvVnNEZW02bFdOeEZy?=
 =?utf-8?B?T1d2TzVSMEpvaGZFNlZ4b1huVjA4Vmc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14100b56-0b71-41a3-0fc6-08db97e23127
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 07:36:34.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oNseRWVIaZPseth0YIU2jSsHRUDLtU/FuJsPaVGey5fd+urshTEIbc4el9a1+a7trzwla7ydbvjzNg3ohB48cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_06,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=993 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080067
X-Proofpoint-GUID: 2z3jYsySFlLc5kjJxaK_fqAd4f90S8eM
X-Proofpoint-ORIG-GUID: 2z3jYsySFlLc5kjJxaK_fqAd4f90S8eM
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 15:20, James Clark wrote:
> linux/bitfield.h can be included as long as linux/kernel.h is included
> first, so change the order of the includes and drop the duplicate macro.
> 
> Signed-off-by: James Clark<james.clark@arm.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
