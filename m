Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DDE7A29CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbjIOVvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbjIOVvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:51:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000611AA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:50:52 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38FLNjgr011250;
        Fri, 15 Sep 2023 21:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=H74T6+1OtkwapfOHFrqHqwD8gPpXo2sFqK1QM65WfBM=;
 b=FwBVu5kauKO4gCRoAyEktngmNddZv+XH126szAneG+UT32qPERsvBp2STKdRWoMWwt0a
 j5udFaSrGHmhLHxLZywhY39RjFE7iOara2bEHxcEG6bqsTZrdOGHmCR5t/nsTSzFJEEj
 vZHfoSbGrYvrR/+BvtG248g5f/HBJwoc+6ALnXiNSpDiPBa2bcfC+hxl38N4GlvTgWvc
 4lafpovdGizOwVb4JhxIPcL+BxwwVtMzWWTbm0V7flPD1YT4Nb1rlEDty9sfsupBfy0h
 /5jRKb4dlQRnT3kuMTvVLQkspQut0sgV72Vv+h67p5wL7AgHJtfhVXz/jQc7unb7wRpF vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t2y7hgs34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 21:50:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38FKi69K036207;
        Fri, 15 Sep 2023 21:50:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t0f5gwnnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Sep 2023 21:50:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gbkv3D/qmdhLqZFkaPgcIQwzV2HplCBQU+oYlmxnOPvGEMUeTHGgKpnWaEi7gDdomQAd+2pi6Vy0A0aqgx14Rl9n6gZohiljDq34VkRMN7sijJqWeZ8vF8MqdIN0fwi6/ykwtfpUjzVjKowkYPj0hka8cTg84ufHa1zhYyJAAwe6sEgSNmGAvOKmBQlOFLFCeuip3vUWFBWZNMZEqO14XQ2//gsolU7zRPhvv81eeeGa7zZRX7UdNRpQgsiNq8m665sZGbwvpAkCMaeAUuMOBqWcjLztZGveGmLzAqrOCzPaD3Lyt1c6LfsgC3uCV8EJlZSczqfTvPuGQ3Jy5txLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H74T6+1OtkwapfOHFrqHqwD8gPpXo2sFqK1QM65WfBM=;
 b=PsqX3+vWjd2vIBcD/gjhAZ/BzHW+mv4+L6xyI54718h5UiyoA516o4RwFWF1Bcw/8jlclAhyIsbfaPSVXstIsDVYipce+AN0190uRX7kOLwMrhD7BJfUfjDVNoLIllAQtGmntr2iI8zNa2zOBAJHJvVPKEQrh6FxqmyIj8eXyTMBJKr4HaYmzm3dU6zO2lKKAgq1fNg2rAPwoS3zoEx8MPHviJiG0ln1J0eIkOfMRsDMi2td1BaFKuf+EHeuZBbrUVXeEwAYzv+XnGmC7ssujXv0YabIgstxlauDSAR4hjUIzgXbcuteXAiGeV5wRYvXdiYaMOS4F/kRu/2YtaeY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H74T6+1OtkwapfOHFrqHqwD8gPpXo2sFqK1QM65WfBM=;
 b=YcmPUdYQRAPVE68vvEea/kWSi663ISAo9m9Dx0saCHzwQbG/tEkRzJWBqc8JbEvoVsFdXuvV9kgK8uWJdjO8r3GSCuoDOqMlgj3jS5ZJJnnknkseBtXpsxLSHzVw3ZyKobKtqd0cRSm31Yq3Zw5fpa3a854OCOIsRSDqCxxSCUk=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by MN0PR10MB5958.namprd10.prod.outlook.com (2603:10b6:208:3ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Fri, 15 Sep
 2023 21:50:19 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::b5b3:e1e:eca2:7484]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::b5b3:e1e:eca2:7484%5]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 21:50:19 +0000
Message-ID: <c243936e-bda3-eb3f-1725-323772ad3a7d@oracle.com>
Date:   Fri, 15 Sep 2023 17:50:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/3] x86/xen: allow nesting of same lazy mode
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20230913113828.18421-1-jgross@suse.com>
 <20230913113828.18421-4-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20230913113828.18421-4-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0125.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::19) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|MN0PR10MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: 910c5d84-237b-4595-371a-08dbb635c0d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /jFAhKUISjzaSkLGoR7R1RJldG2mp2DanZDLamNPmezhxPUWE0bCuEIgtkjeJZONM4H4krGKDrspDMcKH01AqyvddtB8os/hgU9tvq9N9VjDlTMPjUebH478KOgayLvmUwXXS07dDZwotAOF8nfQMYbGZBozQ+Bu2vJbtNb5Xg+lpCwfKISey5KSBYsoNUVwQfwdUKmjPOyShF47dAFy64HZiNxx356yG8wMVWAEK/DZKSHCnlrV/U8wTE73o0RvExNBSXDSwbnleNQtiGaNRmVRN+FbyDyi4Y+SgZ2Z3u9N/CsIIKTNoscEj19b+ttXPxvQoNzVZLM3wESku/odOD7/mU7NyYvmJA8EX53D1en1bbFsCkK9qs+k9qZ2XOhe7JXN074z7ysLnVnhE+I1lh8wlDuHMJJeSd+zsG6T4yrswldN23ZQu8GHMbzlY5KknVXh0EUarstjS3+RwB4sP3ki4Ax3XQ+XSjJfitCobjKO/HSKfRUgXClKwBDuN/qZUS97M4ZQYCug6ua7szTso8l97NVwiGAs/j133lqfHD3CRNLbnCxIz99DMU9+8MbUc0EbvLhb61N1HJonEbf37QofTP+mr+kN+kxku+45hGsjkAvL8jkOdno4+E9XbMkk8fEUNMIto6hrh5XQEzQEXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(1800799009)(186009)(451199024)(53546011)(86362001)(83380400001)(6512007)(2616005)(31696002)(478600001)(6506007)(38100700002)(6666004)(26005)(4326008)(4744005)(8676002)(66476007)(8936002)(5660300002)(41300700001)(36756003)(54906003)(6486002)(66556008)(44832011)(316002)(2906002)(66946007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmRFekJKR2pkS055aGNxN0hhQXJ0M0orOEFhaFJ5QVJzRzlqbHJ1MWVCeHhR?=
 =?utf-8?B?SG1ZQUZQKzJpVUM2NWFHV1RCWS90d1YrNDRmOElJcWM1Zlp6a3h2dlVrQi9a?=
 =?utf-8?B?SmFrejhoOE8xWW0ya1JVWUd5Y29VN29zekdIVG9NdFY0ZGtseGpkMDFISUNU?=
 =?utf-8?B?UnBna0k0Ynd6cjQyOUNtL1U1cnlFaDFGUGkzdXp5TjQxd0I5dUt4azhwOWVV?=
 =?utf-8?B?SG5iMFJlME0welh2NlJtMjlRQnVLZEZ6TURHc0lwWTlwZ1orVzFMTXk5SVBv?=
 =?utf-8?B?WkhMdVo4WkVlT2lkUjB1TllWRGwvTmY4TlJoWEpJZ1psSGVDRzlHYW1sSGxH?=
 =?utf-8?B?dHMxVWhBZTRBWVBkTTU1V1JUQUMySUpDb1JialQ3ZzFTRDZueDZBNzRzV3BI?=
 =?utf-8?B?YkpVYytBbjdjMDN3aitHVWVicHR5ZWpIQVFTbGdSL1ZyUzRYaWkzcFlUK29V?=
 =?utf-8?B?M2hkaDg3b0NPdHJreitadk5mSGhMZEVYN1hjSC9DWGV0ZEs4cnh0L1NNZzdX?=
 =?utf-8?B?bWU4TG96Rk9xR0poMm5tQ0FLYjIvdkdqK3Q4S09LZy83ZCs4Wno5aS9VaCtM?=
 =?utf-8?B?Q3lnYUFndFQ0OS9FeGVTbjZMdnVBbVNkNHFWY2hMc0RJRlFYT1JIU3E5QWli?=
 =?utf-8?B?T3BudXhjc2FUQ25hZDF5ZnJQU1ZHK1AwT21YUm1tWm10dnFrRGdHbGxuZURV?=
 =?utf-8?B?Rjk2cjVMdTNaQ3d0bFozTmtaOHMzcmowZ1JzWVd0Wm95L0JrWXV1cVNYVDlw?=
 =?utf-8?B?YjRzOGdlVnk3UVVubHNtUUFHTnB3Z2QrUytrdzRzaHFucjNIdTF1NHowTXJH?=
 =?utf-8?B?RU9ta0FYUXEzK0QyL2pMeEdTVnBoTW1yQ2d5RFc1K2syVTJRZFVUUXZMZExG?=
 =?utf-8?B?S3FBU2I1d3J2bkVoUFlGcksrRm9SelFJRm5QN3NXdVd0Y3FmM2ZGSjZhVm51?=
 =?utf-8?B?dVUvUC9oK0V5SW5GSUdqOUVDTjd5eDU3M29oVStZd2NBYnNqREUrOUlKM1VP?=
 =?utf-8?B?bVlDN3BsQkNuNDkycmJpNG96T3pFdk1uYXlPZVliTGMvakJxUXRNTGRKVGhv?=
 =?utf-8?B?WXV0KzhIWFhNbGcwQW05bTVoSC9saDlpRE5XamhjeHRQTzNJMFNYOFZYMnV1?=
 =?utf-8?B?VkErQTJNazlUd0hWUnZYQ2dDWUgrRERtVSttcDd6LzZvNDc0VTBpRUJ5Ujhx?=
 =?utf-8?B?bS9VVkJOYzk5cTZoZFRuNXYyN1JPTUhRK3VHMmdwSmVFZDMvVUhYdjgvL3ZP?=
 =?utf-8?B?U3NkTXBGNzhWY3l0YkJuWG0vV3lSWWp4TXJTRElRcEM1bXZycHVBMis0OWZO?=
 =?utf-8?B?b3RWWWk2UmFvVWJkOXRrUEJQb3hpdWVRRHFUa1lKTkMvVkRWc2dDdUtyOFl5?=
 =?utf-8?B?c3AyZnBLZmN3cnUxMmRLVUJUZ2hCeHRBQksrOWl1UWhUR0YzUFpadjhPd0w1?=
 =?utf-8?B?dER3SktRNVlCZUFGNlhXOXpSRFZqWXlxaVVMcS9mYXIxQ3ZzV3JYZmdncjV5?=
 =?utf-8?B?TGdwRkc1RUZJSmR0T0ZVS1Mzd0g4SGhIL1MwellsanhtU25kWEpaQnBRQWNo?=
 =?utf-8?B?RG9UVzhTdDZMekVyWGRaQjJOWUZmK1RPaVg3Q1hyQVNlQ05Jdk9jZDhkU1BN?=
 =?utf-8?B?emUycmJDUU1rYU5xUzQ1dnZKOEpEdVphWXRhZytUREY2OUwyNUNLV1NRdm5o?=
 =?utf-8?B?aG5DalpSaHJTdi9PMmVUYndsalM1M0w2SzAxa0wvdHZMNnVmcnpQa1Mvayto?=
 =?utf-8?B?VG5wSERhc3FMcUoxcTRzSkZTa3o5YVdWOEI3VmMyYXp2SWJaZ2FWMlhvNTZW?=
 =?utf-8?B?bVNUUEZuVURwcVBhMkROd1d0cGJWeHhsYkxxc3NabkRuaEEyZVZ4QlMycDlm?=
 =?utf-8?B?c3NQQkhjd0pGdi83UUVGS0gyT1cwN1BSSEIrMlRyVllneFU3WnhqS2VGcmtF?=
 =?utf-8?B?aEEzOXI2YS9pdjFaZmFSR0p6WU5za1NoeXJlbVk2RDdOcjZKc3RNME93enVk?=
 =?utf-8?B?bkhzOEg5YnpOTHhrcXFOZ3NNNmRqcEg5OFNDYlUwTm44MkJ5enRsVHRoUVQr?=
 =?utf-8?B?bFFQRytNUW9wdXdCV3RPMThOQTJYR1cxcFZLUHE0eWxsc0NoR1d6VzluWlEz?=
 =?utf-8?B?YTFFMk0vcXlpTVdkMERmc3h4NEdkZitmQWpyYkxWSUowZnkxdUt3dFRicDc5?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MUlyd2lyNURLT3plajdaazZkUzlxUVZCMzBwS0hjUkF3b3drWWNYZlRoK2w4?=
 =?utf-8?B?dWJtS1NVRUVnL0c2MjBqeUUzV3drMzFveXdkWElHQkJoVVZQdXZvV3lVSDhR?=
 =?utf-8?B?U25zNFRSdHJaY014VU91MkdGajZESzVWbEpyclBjQWU3TXJVS1liSVpVSWZE?=
 =?utf-8?B?Skx2UUdFMjdscjJoLytmNWlmWHNZTXlhT0NYMkg1d25BblVOYTVzUVhTczhn?=
 =?utf-8?B?Rm1UdG8xNExHVHFZUlh3WUJDMWVscDFLei9rRE5LYXdncjFuWjZHT0xNYUhJ?=
 =?utf-8?B?RDV3eWxnQXJKa0RJZnoxdjA1TmtYMzFCOHYybWZFWUhEc204Zkx1aEJqWmRj?=
 =?utf-8?B?MWJVZXIrN1Zxenh2d1BDRGxoenMzVmFiTk9ONEdycE5DbkdhRC8reHZZWmUw?=
 =?utf-8?B?L2hCTEZkbTdLK1hZZCtyakdhdWxZTnJpWVgwRGtiVmpNeGZGMWNPdkMyS3dS?=
 =?utf-8?B?dU1KS1hvK1doVjh1VHRnMmMzR0NLRktrbk95eW9WYTFEQ2c4ejR2UFBiSmJ4?=
 =?utf-8?B?VjhvSU8wTkN2RFhLQjdQaGl3TU9ranBXOXJnSkdkdzIreHlna1lTeUpaSnIy?=
 =?utf-8?B?L0V0M0t0YnlYYjFOQk5OZFhCdUZEbnNEZ0wrYUdES2ZHU0kvU3cySHdkeXhP?=
 =?utf-8?B?Mlo5R2ExcEM2TDJIZzZ1ZHVreE5RNzdCb0h3WGdZMW9wY1piOWVUcnI3ejJw?=
 =?utf-8?B?RDdwWVBONGZqQjBySDk0emovZitxQXJFdzV2NkpxSGhPcithZjU5QTk5cDYy?=
 =?utf-8?B?MkpSL3EvWHYxckdxNTE0WkRkQkNjQlRIZEhzUzJDTVpSdTcwQkpyajFnSDAr?=
 =?utf-8?B?T3dnWEFrOUxyQll0dXIvMUovdEd1OW9qRklIYkdWa0NNd0dvVzFSaEE4MlBI?=
 =?utf-8?B?K3V0MUoyeE5NZjhjNnN1dzBBY1djajRIMmJIQ3JRTEwwTm1QM0x2VFNGZ29a?=
 =?utf-8?B?NnVwWHc2NkhKckxjZU9TL3hheDljcTRSTjFkNDhpaDJqTEVocVJQQjJkeTZq?=
 =?utf-8?B?OWN0clJRWUg4SEg3SmUzN3FESHV3NWk1R3ZyNFgzK3plNk56a1JOTXhLZUVO?=
 =?utf-8?B?NTBnTEFFaVN2RitkWFRTMzByeFc5c2R3d1RvTHozanpUR09ZaTBYM1VYSS9k?=
 =?utf-8?B?WU1yTVJzcW9najVrL1pMZ0wvSXBZbitlZ1hpUzg2dWZPY3VCaEZhejFVRzBP?=
 =?utf-8?B?aDVXRFBrM1haVy9tdU93MzZzbXV2dmx5SkhtNHRpaHF6RFZ2cmtiMkRkbDFP?=
 =?utf-8?B?d1dJU0xYZGx5YmswL2xwbHRDdG5VcWV6RTVvZktCd2t2TlhweU9HeDV0RWxS?=
 =?utf-8?B?MGlPMWdxdGxCK3oxL2RuQjYyMm1JbnFzU2crOVlHWmw3TnNtYThFQzNmWHFL?=
 =?utf-8?B?WDhCaE44Vit2dFE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 910c5d84-237b-4595-371a-08dbb635c0d4
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 21:50:18.9978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3Zk8Ym+H+T33pEGTo9Q3V46mGEpK5BDn1BymIYdAjFyczn4ebcqzNTgQm9MDMlfcyAZHhhQu2OMCVrQNTZXyP1eHPRKTiM+6c/966RC/tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5958
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_19,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309150196
X-Proofpoint-ORIG-GUID: ywDPsgA5D0aNXQF4bWb347M1NPXVVaYb
X-Proofpoint-GUID: ywDPsgA5D0aNXQF4bWb347M1NPXVVaYb
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/23 7:38 AM, Juergen Gross wrote:
> When running as a paravirtualized guest under Xen, Linux is using
> "lazy mode" for issuing hypercalls which don't need to take immediate
> effect in order to improve performance (examples are e.g. multiple
> PTE changes).
> 
> There are two different lazy modes defined: MMU and CPU lazy mode.
> Today it is not possible to nest multiple lazy mode sections, even if
> they are of the same kind. A recent change in memory management added
> nesting of MMU lazy mode sections, resulting in a regression when
> running as Xen PV guest.
> 
> Technically there is no reason why nesting of multiple sections of the
> same kind of lazy mode shouldn't be allowed. So add support for that
> for fixing the regression.
> 
> Fixes: bcc6cc832573 ("mm: add default definition of set_ptes()")
> Signed-off-by: Juergen Gross <jgross@suse.com>

For patches 2 and 3

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
