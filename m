Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7173C77F3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349834AbjHQJwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349841AbjHQJwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:52:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1261C98;
        Thu, 17 Aug 2023 02:52:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37H9O5wl011158;
        Thu, 17 Aug 2023 09:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=k7i5XvL7fYKceqIm+0mq9Ax8m2Y85yrSfDwWfMwx/ns=;
 b=QV3DG/bEOyOqDqMc2+jDx++3ws55BaohtpeCpiT4bMCszJl8f0XcMtihSl+5D4RNCpc8
 k80tNkvbRbYHbJCkUPTMW45sfsEDtiesYEA6rzr3fayf6GF7OBNHYKQUwNdKZhXRahaa
 ds0E1DMBzXxj3qvuVQPQBOeloa7yaA60gZCIJkfHJbrquhM47FPLumE3VtkTPFA5iz8h
 87WzrDumEsxF53T1O8PGfvxyojakA/KBu7BpcAqKxLfZVOfvTbmXmraI6KiTn53Xvtxp
 Suhw5eiQjan7d4yLwKjiJNc2J0cfZwSLv79/E1E4wwEojyAgBCJjT2JDaM13W+Y5sYQm Eg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se31495pr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 09:51:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37H9CIoF019785;
        Thu, 17 Aug 2023 09:51:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3xw2wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Aug 2023 09:51:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxPZudh7f1Kavudcj3RbKIagzZr1a7MmyH3JmuD5HNsbQjdIpIRoKRV1f1JUM1jFKqTf47xyLY048+Ha49Ozp9Brl763zUOhYhwv3/KiYSRZRJqBrjut02zycJmSjpxxnSEC1bWM2hCXSI/rWfCnz7D1fj4BM1U+i+ZLdmu4vAdVc3FfT4DBTFnJXwkZA3Tn3IN4/oj0D5aEofvvJ+gOjRbcsaG6QwXKPGenXYkGcLs/DGoenmf01Ij3ilskNciXUUBjPfE4sGrjIFRpD8qelF3WRDhKI4ym0rRX4A2rmIOcCjOtkr7BnO9nM5+7gAC7PMTc50Z4zfajiJUG5i+SWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7i5XvL7fYKceqIm+0mq9Ax8m2Y85yrSfDwWfMwx/ns=;
 b=Y0U7RXPQI0X6ub7VWji/GfTaz41FlFgTosMSTU1V9we2KUIWRqgNG/ucy+ssH7xBDZRyQ+DRMb7UlWtSvN2BsOmsWGSz+9/8JrbDfbpGpP8cv/R7ATNSm6I+q6zO6QAMEd7Q87e3MFZBes9DUq6RMkM1znEMQ2QpnMR7UmRXhG2Ub/deMjyG7HP31/w3jSBtL4+k+OY7xmgxZ3DBwAfh5vjEW8L0yR+b55LojYfOQE8hS6VOy8nl+z1Tpv9a55pL/CCkF+vJa9YRY9bH7RjEUwJQ+m8OmyvC6N7QbfFTnKfe4hDnApaY7cmNhPV6ZAcGjTgoTXXtpw6+O0tDX16eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7i5XvL7fYKceqIm+0mq9Ax8m2Y85yrSfDwWfMwx/ns=;
 b=WMMHtGcsZ/Zo4dirByzU+j6BxgTsQOJRkL4pYhjCJfsGYclbdb1Kfun8QfoSbWP24EYAegCpIlZIyRE1mtsfadksD3MeOg3+Cwm5wvjtKaB3H6EPPevgElaSsUykJAYRp5Mbg48ebuT2wqab/1ZVazOTu7wJe9mC+6lfmELE7/4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7956.namprd10.prod.outlook.com (2603:10b6:8:1bb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 09:51:18 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 09:51:18 +0000
Message-ID: <80846ab1-1257-bcca-cf43-1a314275762e@oracle.com>
Date:   Thu, 17 Aug 2023 10:51:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v6 1/6] perf arm64: Allow version comparisons of CPU IDs
To:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, acme@kernel.org
Cc:     Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haixin Yu <yuhaixin.yhx@linux.alibaba.com>,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Sohom Datta <sohomdatta1@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230816114841.1679234-1-james.clark@arm.com>
 <20230816114841.1679234-2-james.clark@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230816114841.1679234-2-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0154.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7956:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae30a25-d075-49c0-258f-08db9f078119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jAibCjZwLF8ARCiMhJbGuI61gJnYGUr4Iop9G2U51A4XtRvg7YZ8PdakgPnEwpl/8EydoUzBB5dlRMD6u8x2/94xWXjDMH14/uCW+vS6EAzxn0oyMPEdAyIVYOR/Mv2K3qwFPFJgn8jifsv7J0/uru2KvtXl756UnpJfOWLior2NPsc+jF4DDfdWy1wJAy/Bs4nwAEd385L0dr/jdz4yHEYtY7yapIDMIfhTvRWkaYO+s8XAn7WRJcbfO2PcI/aG51AX1xTYlTdVLbA5KpLPbWrUzLOWyPTP75TucP4TYk5t2EPqAPLCu1ej5ytKuShAhO6cmW8DRqTbN5ZiSIN6H2vU5RqCTQiJN6ux5U2/n8EamR8fLqZMgFPkUydRK8DCSMoLFK7xT/gTu0qGqCKtS8OsXGF5X59alZ65saQ4cZILBjzaFr3uIC4Cl3LYK1/wRVXxP1jqz5mRBdyLSf/LFXIyxBICEJhLsTgE9zJNQVnDuMRjh6HUOkokp0/Van017LCgB3e/tGN6aBnTXWun9MVWSy0JHnC0a0FkmtdVcBTQFA202Yn6Z6hdVUOqiXH2jvMlxsEv5wB0K/XuRC46Pl0SqzYXgO6lofkxtT48nqU+fFnHTa2kZzRGRXQrXTSwAc12jeVHk7hdjCJcZ35zjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199024)(186009)(1800799009)(66556008)(54906003)(66476007)(66946007)(5660300002)(2616005)(41300700001)(4744005)(2906002)(316002)(478600001)(7416002)(8936002)(8676002)(4326008)(31686004)(6512007)(6666004)(6486002)(6506007)(36916002)(53546011)(36756003)(86362001)(26005)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWV5MkVtKyt5MDlSRWgrbEFNM0h6S1NUMmZSZzYzSzhZVkF2cHhmZlhoWFZF?=
 =?utf-8?B?M0hCcDk1Uy9nZDhaTStTNUQ5WjQ5MWRVRzlMMDdpNUVHTzl5NHBLeXFBOVFR?=
 =?utf-8?B?aXp2TUFFVjZoc1lyTTJ0ZWswMTYzNSs0dnQ3aE4xemFHTUhOc1lpNUFwc2Rv?=
 =?utf-8?B?bzI0UFBzU3p2TG5CMDREUTZldUpFRlg3WmNZb1VKUFJtVEo1eDlQRmc3R3oz?=
 =?utf-8?B?VTZhdGxyQnpmcmF3OE4yblcxazhtbGlMV3JsZjVuTkdqbDFVelk2em5sakFj?=
 =?utf-8?B?aGQ1djcyb1h6UjBXQWp1K2h0WDViK21XRVkxUHdhWXZxUS9SZmx2bW83T2Nk?=
 =?utf-8?B?THBhZ3hObk10dTNvcnZVdStDRWVRWEd2WVNmTHExR2x3WWxuNWNvNjkzZS84?=
 =?utf-8?B?TkZoVlBXK1Vma0FFTTlxK1RuZG05NUMyMkdVWTdQcnVudXhxbXpOWWhWL2Y2?=
 =?utf-8?B?U0xwVEd5SzVMbC9VSjBQRlYrTlowRkF2UUNrRVZFaW5YY0cxSjZGQ1BmUktB?=
 =?utf-8?B?ZVlqYkEwVTB6T0xpUXJBVktoc2Y5cnhUTWlwalVad1VXNlhMU2xZdjlWVnl1?=
 =?utf-8?B?NUFKc3FGTmZEMGgwNWhmcUw4aUd3aW9YamtzM2lxbVArOVRqTy93M2JZWHA0?=
 =?utf-8?B?UTlJVksxa0hlWU9EaGhqZTlaV1JuT0pJTFhKVE51QjdJK1IzdlgyMmFFY3hp?=
 =?utf-8?B?Q0Q1clBvZVM3T2I5ZmJjekY4OWJFNnRoVmVaOWRUQk1KTjAwWXhKYWFBeTFN?=
 =?utf-8?B?akljU2I5NUJzRjNhRHJUY2l1WE1hUFJkRUQzU2RiWnNyM3lxSGhUY0E2NGF4?=
 =?utf-8?B?Sm5SMGx0M25XbmQwRk9MLzNMTnphS3h3MDFUZnBGZlB0YjhLbDJNZHR2V3pJ?=
 =?utf-8?B?OEMva0lzeGtvczZDdUkxTnZ5UWFiZHBLQ21ySUsvbVNraitLMzk0WGFQWkJl?=
 =?utf-8?B?NlNwaXNVUzg2MDI3VTIxRGRlOGQ3MEF3YXl1K0ZaUGc5TW9iTGsxNjRFQkZp?=
 =?utf-8?B?dHRxaDUvdFRSZzcxUXZkUmk2V1l4cmhxUzBFaEJWVnd0aTV1Y3U1M2J2STdr?=
 =?utf-8?B?NzRhcndZKzdFQlgrTnhHZHAwMWhwVWE5RVAvRGtOQ05tYVNQNWpMOGd4emJ4?=
 =?utf-8?B?UVczMlBhRHd0b29qeUhlYi9nSnlJZ2c4aVlYc3NCdXdwSGIrSEVxWmRhbmt1?=
 =?utf-8?B?YWRBZHZaNXFBMm8yeDBXQU5rMkhUWU40dDlJUzBRUlhidHZWNGxGejZUNWxa?=
 =?utf-8?B?VnVTNWtwVjZpS2ZiZHRVdWVBNlQyMHhHNWZxRW1FNVV1dVZvckFpMFdQWWlJ?=
 =?utf-8?B?eEIxcmM4czJDaU4wU09yZ040UjdVSGw3a1NpVlhhUkdpdkx2ajdqamU2ZTk5?=
 =?utf-8?B?ZGZTdHhBOXl5VUZXa29VdzYvU3QwOENMTHVVUzJlZXNrM1pTb3JpWXZLVnZp?=
 =?utf-8?B?cnZhVVFHUnMzRWRVT0crNnRWOC9pSHhjSU14ZzNHWmZRanpRTUZaVklrMStz?=
 =?utf-8?B?QVR6UnJwQ0JvZ0IvQmp4eWtIVklMaU1HdERVNGJBbDUxMVZEVlZnT1F6R2hi?=
 =?utf-8?B?WEhmRHhXUUd3Z2ZRZk5jRXJmY1hiWEQ2NjB5TktwdGxQdytLYXlVMWtjdXFk?=
 =?utf-8?B?WTJuMklqV2RqUmRHWFBRTERLRHhZclJkdEpROGFqQmtoVGI1V0pYeWV6WEVY?=
 =?utf-8?B?Z3VzTXZtNGVaUi9ld2VNWG5MTHJXbHVWOUhXVnhlZVhUTXgyQkhCUU85K0Jh?=
 =?utf-8?B?UWdzczVYQ0ZGdDQrMGM5eEg2aW0zdkE2c3RYU2hTb3JJSVlNdXNyeHQ4QjU2?=
 =?utf-8?B?TW5nYmNRbnZTcisycFd3ZklTeVlvL0lOa2ZnUEFwbnFvWGpJNFR1R1VwdGpG?=
 =?utf-8?B?ZTJEaXpqY05kNy9GZmd4RnRlQWZlUSt5TTFpbmw4V0hCOEkyKzdaS0lnZEFI?=
 =?utf-8?B?Ny9QQlNYTFdnR0RRUWhCbFNmTVZmbmpEYXNGVml4WDR6OWpLSnJvN00rckx3?=
 =?utf-8?B?NVpuR21OZ1NCamtVWTl1VGZLUndaZGZjMFdqVWF4OXBhMkUzT2R2Y3M0UEhk?=
 =?utf-8?B?dDJtN3g5RDhRdGFsYUR6SlBpN1NhcStkRUdFMU5mV1k1R01vdEIveGxKWjRY?=
 =?utf-8?Q?fGEpHra36LB33uO1V293D8LA0?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QWh0Vk52ZW1hY0hxZVBVQlVJbHZCTjFmdmFtVHlhUnByTkdJZlNoTlpvNHBL?=
 =?utf-8?B?NCsxZXFDenM3VWZSTEx6N1BjREdCbDlqKzR0UzA2dllFbk1JREhZQXg1ckFC?=
 =?utf-8?B?Mm1TcFhwUU5ycUg5cE5OWDZXZTl2M1BYd2FxRTNubEhVRm1UM3FyV0JkbFp3?=
 =?utf-8?B?Q2Z6M3dHdkMrSmY0Z0VuRFkveEJxVXA1YTVEc3VZNWZtUjgxYmpzQjhPQVJr?=
 =?utf-8?B?T2JzLzVtNEttaWRqaUJRVmphdzhkZnYzU2dNRVYwK0UvZkx5Z1ZCcG1DQXVx?=
 =?utf-8?B?WWpUUEtRdGExWnBXc2Q5bXA2RE1rbzhoMEVWMmF5RXR3dyt0b1QxMkdXQSta?=
 =?utf-8?B?RDNLS0ZINzNjMlBkQXZWbzNhZm5aaVhMSXlMTGdoSXBVYVE2cjZZLzMyYll5?=
 =?utf-8?B?a0xaNXVUa0RlSzJ6Kyt5akZZU0l5V0oxRm1XV3dlMXhVUWp4VUVJSjlUYWoz?=
 =?utf-8?B?bGdoYllMT1pzRFlzdDBlRitnS21wRmpKSXhkb3B4aVVhcmRyek9aUmhuREsx?=
 =?utf-8?B?MUcrL2lPNlpMeUMreGZwL2pzL1RRRmExa1hmSDRyQUpYWE5hR3hmYkYyN2tB?=
 =?utf-8?B?b1BjeW5XZitVQTBVZXVXajZQak5oaUZTYzNFQU5EakRYVWliTk5YUjhlV0Fw?=
 =?utf-8?B?R3lLd0JQbFFoTDJzdWpLdGxDMjVTK0NJbmdaQTJsQUdTeHkydzlHMWZHWisy?=
 =?utf-8?B?OVRCYzVNNjNJYmFZMXh5VTQ1ZWZWYjVmRlB5WlJBTyt1eWtYT01GMXpIeVVK?=
 =?utf-8?B?S0lVbW05YlhEVnhEQTVKRHRacUhVZkYwOG8rUWZzVGxRNDk2MFBVcjJUOHc3?=
 =?utf-8?B?bmNkSndZU3JxL2pXaTYyYVRnZWpxOEdza3pBVHNBd0dydlAvbjhOYkVqYWk2?=
 =?utf-8?B?aU1aTjZpMENDbXlUYkRSbHZUWjNmVHcxK0tuMmIrc3pqaWVMZHZDV3Y1NGgy?=
 =?utf-8?B?aUlrNWpnenBEcTFoOXJyeFI2dmNXdHlLcFBHVUJ3b3BjelgzWnB5N1RLeVY3?=
 =?utf-8?B?bW9mRDl5TUdUN25vdWM4MFRQR1VLS2l0Ri9XSmtEalVOdWFUbDROa0wvdXRW?=
 =?utf-8?B?Z2cwLzc2VW9RbkdLSVpLbnBySDk1NExoK0o5bmoyUW5TOHB6U2dyUjNnM2lu?=
 =?utf-8?B?T0w2VVB3OU1IYUJtaS9UcnRteVk0djhMYXoybXhsS1ZmdU5CMStrMzBaUy8z?=
 =?utf-8?B?UUtES1pJSDFvN1VxeW8xYWVXNytmTG5GRkpaMEhMU1RvclNHR0hRcVZEa0Nm?=
 =?utf-8?B?UllqK3BJbDVsM3F6MWlTb2pkajlSblEwWFdzVDBUY3kySkVjQXp6cTVLaGRC?=
 =?utf-8?B?REFTQlE1bmUzM29Ia0tjeTF0VFlZeXdqNnBQaVVaSUtVT0U3dVkzd3Jjb1A3?=
 =?utf-8?B?cDlXMmhsNWYzd0VtNTR6cWduQ251ZzhKTmdNY0FrZkdXZGJyemR5L1hnSSs1?=
 =?utf-8?B?cFFZSjNUSlpFam1odDVwRU1Td2hCc3RZNlZQNWsxdDVRaUExK2lmMjNSUmdV?=
 =?utf-8?B?T2tiSUxwRURkQm02NG43MW5yN3BMbS9jVlMwRGhpWE5VWVBNbFlsdUthb2Vs?=
 =?utf-8?Q?7VUWDEm2WOg8rTAu9hj7ovvlk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae30a25-d075-49c0-258f-08db9f078119
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 09:51:18.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: abzD5cVK4KeNsbSqVVADIxcZP6GuNIZoK9fd0wA2fbcJyfY8JMhWimlB1ERxfQP5e7TkHjtCjgV0UR42frjBdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-17_03,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308170088
X-Proofpoint-GUID: g9Am6rWLDGQ5rsyYMwnpZQpiODEsLm4L
X-Proofpoint-ORIG-GUID: g9Am6rWLDGQ5rsyYMwnpZQpiODEsLm4L
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 12:47, James Clark wrote:
> Currently variant and revision fields are masked out of the MIDR so
> it's not possible to compare different versions of the same CPU.
> In a later commit a workaround will be removed just for N2 r0p3, so
> enable comparisons on version.
> 
> This has the side effect of changing the MIDR stored in the header of
> the perf.data file to no longer have masked version fields. It also
> affects the lookups in mapfile.csv, but as that currently only has
> zeroed version fields, it has no actual effect. The mapfile.csv
> documentation also states to zero the version fields, so unless this
> isn't done it will continue to have no effect.
> 
> There is an existing weak default strcmp_cpuid_str() function, and an
> x86 version. This adds another version for arm64.
> 
> Signed-off-by: James Clark<james.clark@arm.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
