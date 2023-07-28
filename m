Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F797666D0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjG1ITo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbjG1ITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:19:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2A0211C;
        Fri, 28 Jul 2023 01:19:08 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S2BWSZ016305;
        Fri, 28 Jul 2023 08:18:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vchEZkV61Qv/6MiRS/kfpiipeOl9n5cwm8FkcealJXo=;
 b=0BUOQOffTmT12kpP74vdTxo89L5kftBBy8thGEhEqZJKWMo2E04xtmpwDpKpmFgsMqOl
 Zd9o7go1To7wP1lL4Mtq58LIJlPFJ6rInN6vsG7cjSZXQbBoPLTpWGkoxf9XQrI8SyW7
 ptcgGDRetm7sEaCSkPX0bJvL6PLKP2ADArKHJQwcEP/wvNO85ft5APnNX7nwL0WDdDbR
 sJ+TL5ACVCu3N+hIqvAEzVZH/x6FeD8KbpiOhVUEU/Gkk10q1q4MbcZgXSseDtQy6urB
 K9Jvh/X4NPnmI/MRxWw/4bma8qJ79rJf1p51Ck6TvKaFugcdl6c2XHQERtFZGxW8lI1c Dg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qu3cqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 08:18:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S7JDxG033337;
        Fri, 28 Jul 2023 08:18:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jf1m4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 08:18:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWvFC81PZuxKP43uZqSIhJqcVpT6RNpgYi5o7E5uiu9FtLrdTmqipw/179jJk5kHLT6Ff/slxjZ3X79bMjrpf7q0FCFYwOC7Cdgwd4EebHns2aZcI1GRGintZ0MPyG3fiC3efvYrVlztH/7nFFk6sshlNcsVzikjbARf/+zRVEvyFkeSjoF75P1VFu/9cECU8meJ7GrjduPhWK2RUFV2NIhML/OAk458Y34ICK4kB0oFXt+gnyoyRufr8UwgqMGzAE7pEIWXJVMhp5xsIPI0p2inb9QRbL+5LBwUcXJL1N/baLQSPEHOSqSxDyCWjmSFr/CMKZ/bdbPJUH7GalY3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vchEZkV61Qv/6MiRS/kfpiipeOl9n5cwm8FkcealJXo=;
 b=fTmgJQYaM52crgEyE/t9YXnuWODlPBdD5+ZBUNmsL0V64ClagDGh4ZrciX2wL30EG05THd4NrO4a1pqEsCX4yG/yNh0yNzUruW0ughz6Y/cHXu7vd74/LQNCWP/MGzUt8kniCoghUAauA/zdvg9tiOsFtio9X2cwjJHYRVBOnwYEbG2sRTHuxgLnGES9EDuFv5T5xLbwchu9VOTpiV72bsPdHQuzL2tNEbC+vd+CdKFjd9KaSMJtqRuAXdI/6eKudS7siEa8vWpTx65qHy+Nr93lTWbu3wCtUuJDstrmELwBi2ddEWD5BoeM+LBQ3jq78MRiPRlVzuMbs5u++bN/8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vchEZkV61Qv/6MiRS/kfpiipeOl9n5cwm8FkcealJXo=;
 b=XwIwdCGyOXGlnrULaLweBXkfFrbDHG2Rklkpn7tGHAj4a5c9x53O8PA/NQpOq9/tHwFeDBbt0UsqnjnekGbw+2NN8FcuMz+UDX0bDURcR3zUBFwmRxq43OYSvy5mLjEUXAfxOpw0TF0CfT6Ev+PJncCaYqZh9CREQya0AOKFmPc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB4886.namprd10.prod.outlook.com (2603:10b6:408:114::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 08:18:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:18:51 +0000
Message-ID: <4b2db6b2-bbb5-77d9-4e7c-148b33882a85@oracle.com>
Date:   Fri, 28 Jul 2023 09:18:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 5/5] perf vendor events: Add JSON metrics for Arm CMN
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-6-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1690525040-77423-6-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0092.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: 95b8bae5-2bba-4d84-402e-08db8f434652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: noSDIaVLKUyyRcAqpcPO6EiVoEE0YBvn2cmaWbQ1CogXY8wF9jmmqmRFW8l41oBgBvsKUJYSyjoNDPv17Fum9lSM3Dr6VzzZdmJLZWlt7hdSUzjUJzMTk9U3YvWeSNUsk6VeL27Gu211pu3p0bMmxKVsSn/UIBNSCPUNtCo5SyQiqwhfQdcrfUGpcAQfExvzkwSFytOJDN1AlfjdGtl5grjDhl4Ndaj9EWvx62jl4GabF1Gv8OmQWPRAl9QdbVm/ZOVcZhXWAWaRcyEoIS1URfQ2B76SQtBMjLZEzz0vdyoK792W900aYWKf7eQKM28ofgm/R8tzAfG2TBa8Q4Y6aPD00FZzaqAR+Ha78auuxGz5gKU6Xhpvz7Nh6jTNOLpcAN7dqBX62MEcwjTcxfP1C5qUPNOnm6JLIznEPdj2wL4ImMnsJlW/tA78DPwqrjxkIuKpPbLPs+YthTv7ZZhu/5bIQMeBYBzfGCPZtSkbQNsUuOdnV5w3jvAvzkBxg7gy+NqhtNgHmz7jD7r9AwZa99NhNBRjfXAbHueE+VIJ7l96HIMsvEzE+WNV1HWo+pUIqTw2om4nMtCmj0W5WKeKSxf6Qgphxc3P+2CdWqydoZwubuUSKNynpcQQnzdyms80WNHsDVGggoUgg7czZ31jsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(4744005)(54906003)(110136005)(6666004)(36916002)(38100700002)(2906002)(6486002)(478600001)(7416002)(316002)(8936002)(8676002)(5660300002)(41300700001)(36756003)(4326008)(66476007)(66556008)(53546011)(66946007)(31696002)(186003)(86362001)(6506007)(26005)(2616005)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2ZiNE55SmR0bE5BdFI2bWNEdlNhRmN0MkxheDRiS1BQemowbXFTRVE3K1E5?=
 =?utf-8?B?VDY2OTlxb3hCRDFwTVJzc2pqOFpvYnFQRGVvbDMvV3BRL0gzS20wNXFsZXlL?=
 =?utf-8?B?cXRoblZkbUwvZlFNbmNranErUzJqZWhmeWowLzh3L0Z2YS9NdzRZTU1wWjly?=
 =?utf-8?B?L1lKd2hmVngyNDVJNHVNdFpyUDhsa1N0eVhFUTA5TkJGcnBvbGdpSE0wUkdL?=
 =?utf-8?B?Z0dHeEJiWnlXaVlEak94U3lEU25PK1BhK0ZjQVRMMWRBZXF3bEp3WXVWdkJt?=
 =?utf-8?B?ZDErbjZvOHd0UURFSnFkZGtuZ1ZCdmxXa0F2UTBNQjNibERMNnRJekN5Vnkw?=
 =?utf-8?B?Z3JZbjc1QlVHQjJzcU81TjRXUUFnWTlhY2pibCt1cThoVkJtRmd3Q2dOMTkz?=
 =?utf-8?B?eDNSU05uRXVlZUVHTWJlRTZadFloWEc1YTg3Nllac2lLY2NpUkVuYUZFczJs?=
 =?utf-8?B?QWpIOGZteXNjVFJvK2Z0QjNmb2swRHN0Rittb0M3MElKZXJOdW9ZRktydVg5?=
 =?utf-8?B?UWc4aXkrcjhHVkc1dHFGSC9rNmlrSTBqMkJrZmhDRlQ5V0ZqNFhnQzlkR2xa?=
 =?utf-8?B?R3QwOHdFYWtQZlkxY3lQUnZYMGtUUGNDN2ExSkM2bURGQ3BSbGM4NGZYcElq?=
 =?utf-8?B?RUQzbUMweWlyRXV4cUZZdEVMNjVDYXNYdlpCa1JQNlhuQ1EzMVN5eVBIb1RS?=
 =?utf-8?B?SjVqQnhmdEsyNVpIaHYrQml0U3BQUlRMa2xnY2wyL1VPazVHSWMxR3JBRlN4?=
 =?utf-8?B?N1E2aUNmSUZQRlVEL0VhS2s0N2RQVDh5d1dXM2M1bi9oWFVLbVlVaUs1OHpt?=
 =?utf-8?B?bkxNNk5UZW5PMDBvOWxHVk1KaEJ3R2x5dGwyTU55SHYwYTBIcmJmUlBjR0J6?=
 =?utf-8?B?WWhyemZHMDNNQ1FDZndlN3MwcThicHRrV1dSUVFBMisxdXpXVHQ4cWIxYzVw?=
 =?utf-8?B?NnBYeXd5bHdjVnI0YkpkK0tSeTgzTDRDM01MS2hyRFZXUXozRE4wSGc5YzY5?=
 =?utf-8?B?V1N2NERhN0NqbE0zQlo5Q1g2U3pSMXlZek9JSmsvWUNJYnhpYWlUSkVyS2JK?=
 =?utf-8?B?bmxpRFErMWxTMEhKWjQwYzN2bHFlN2d2WVpOSVBMTnBWaTQ0NWdGUUV1NUoz?=
 =?utf-8?B?OFgvWnpwUWhPbXpOVGt4WkhCZngxVDFXOUFxNE9ZNitNeUFFSmwzcnloaUNF?=
 =?utf-8?B?STBpWEtpYlh2dExMbDFuZ01EOCtob0NuTjN3ajFva1Bpbk90U1BjdTYvLzVa?=
 =?utf-8?B?SHVmVHBGOUYzbi96UW1PRFpsMGhJL2o0ME40aWdoWGtNL21IZ0ZabVQ2VDlI?=
 =?utf-8?B?dXBldVZTQW1YZkxtTlJqQ1MyczB0STQ2TlV1N1RvOGFSamZnYUFUMlVvYU40?=
 =?utf-8?B?NWsrZnZwanArMzE4NG1xM3BoWklqZGhmeTdPZ25sL1J6T1FpOTYwaUhubkxQ?=
 =?utf-8?B?bXlFWWF4Z1FVWGpCNUNENllIQXFWQlhVVnBHZkJ0UEtSUHJQRlZXRXBKOFc3?=
 =?utf-8?B?Ly9QL1lub1U5dHE1UFJWK3RtQkJUQ2NBMU9iUkVJQTUwOHZrNFdkNXpuNHJw?=
 =?utf-8?B?Y2N5WnNTZWgvNUhMU2J2V054QllxdDlLdEtja3ZjeDAzKzJ0TEtJSExkWDhD?=
 =?utf-8?B?eWJqTVZYeXJBSWVTUFlGWnBRL1dWVFIyRHdSVkpzeERxWWJXVXZlb0FDNEZp?=
 =?utf-8?B?NUh4RkVtdmJVY2FvdkpLQStkeHJ2M1k4eHFFQUZURkhRU1ZsYUErcWk3K0k0?=
 =?utf-8?B?TEZVVEoxNlZVVEtQUFk4M3NCSlRWU3o2cUMxVmdBUGJucWRJRENEaTlPS1Ri?=
 =?utf-8?B?bk80MVQ2OVl0RndLWWh5Q201aS9OWkMwc3hVVFBCTmdPQ2VOTkdPOVlJaGpz?=
 =?utf-8?B?MVpCazBIOVNnWnpmZkI4YmVLaWFZU2lJd0NGbGEwSlgzWVQ1NDFWVWszWFkz?=
 =?utf-8?B?dGlFTFdUMW9oRWc4MW0vNlBNWXZNMkRPTXUyRWFZa0ZrRlNOaUhKLytMcW9O?=
 =?utf-8?B?d0JTWVdvNVFualJPMyt2THBzajJta2xkZDlKeXAydjJvenZaejFoakhmdXFu?=
 =?utf-8?B?NnBrM2tsWG1BTVVDU3M1akRuVHgxSFQvM2t3UnpzeUcxRUpyNnk3M0FkOVR3?=
 =?utf-8?Q?NCEb+HarXYY4gm3zFTkgZCuMI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZS9UaHRzQThucnAwOUNFc3lwalBJYnlhaTVZeHoyeHVLb1ZmMmdtS3IrZGlG?=
 =?utf-8?B?OXdJcTZrTGhOaFlRVVA4TitVeUVzVWxDL0tnNHROODhzR09WQVNJYWxKT1pC?=
 =?utf-8?B?M2VEeDh2ZG9LTTcwRExzTURYdXk3Y2x1MjNEQnRvNmkxcDJDYkhhWmVudzhF?=
 =?utf-8?B?Qnd4WnVnVTNvMmlreHhWOFJubnBQb09OcUNkempWRllWeWQ1amJsY3BDcTNV?=
 =?utf-8?B?QU84c1JnTGVzL0t5endEWDl2QThxWUxGYzcvNUJIVW5abW81QWdIOHFTK1ZC?=
 =?utf-8?B?VUluRnFQRjdWMmVlMEVrVEhNbFE2MUlYVmlXN2hHeVJnQVVuRGsyZlJGdkoz?=
 =?utf-8?B?Vk1mRXpnV0VTTGFoZ2RyaENYcndLSHU2Tms2a2VxS3NaOTB5OHVpTWZRMmhS?=
 =?utf-8?B?eG9HTlJSUVpqSHlzcFFreVBHMTkyRVUzaTJjekcydE9QbTBESkQ1dHhvMzFy?=
 =?utf-8?B?TmxlZUFrNzZUaE8rYVNFNElaZ1Jkcnh2SXNDMytlRmJJT0dsU2diSHdSYXRz?=
 =?utf-8?B?bWRCU3BzRWZsVU0xQjBBWjlQMCtwSkg4MFNwNjZjc09qSGhzWm9yMU5Ya3Mr?=
 =?utf-8?B?NnBRZnJ2QUJvTmRTZmNCblk2VWpsS2lJRVpiSEw4aWdzcUowVkNLREE3T29v?=
 =?utf-8?B?WHRQOCt6M1ExdDJFdGt2YkpiMzIzQ1kzaWZuOUVwcGNYcGlrSjF0aG1NaThw?=
 =?utf-8?B?S0VOSDV2VXVLaytKODV0bmJNU2VYdExpMDZKMXprWGM4OStEZy92V0lnTGg2?=
 =?utf-8?B?dEI4U204czJydlUrMFZXWmY0clJkMnNUcWJIcTFpUXlpZThtQXFkcERndWdB?=
 =?utf-8?B?THFsMFFRZWZOaUZtRWxiamFsc2gzVXMxdHRoRkxldGVXUFBrbDZnOE9sOTFO?=
 =?utf-8?B?T20yZ0FBQ216V3F6bVJwUy9EVzIvOUlOdTQxbEVRUjFpRzlPUFpOY3NWVVg4?=
 =?utf-8?B?eTBKY09BNEI1SGpvaXBmUm9hcDBNZlBENjUxRlZHV0RlZnlaYS9oNjBPLy9I?=
 =?utf-8?B?RzVKYzFiREVjdVRVRVNyNklaVTJ5QXg4Mnk2VFZvdERXQ0Y1dTlsOGwwbFJT?=
 =?utf-8?B?Y2xRUUMzK3NnRUNoTkxDcWpIclpCK3FVOUMwdVNoN2YwajRuWkRyOXFoakp3?=
 =?utf-8?B?N2NoRmxPM3dZNFF4VTBRdUpmM3lhWnllcjJQMjQ1ZGwyR2xqbzBtSkhzK1dJ?=
 =?utf-8?B?MklhSWcvMzd0UVcwcGZ6UlZHMUNQR1BZeVo4VWM2NXR1SnNwYkxkbThBQ0to?=
 =?utf-8?B?WmNoVFlHZWtCQjVtTzM5VndyVkFQR2J0dW9sM0doWHF3bUFiY1RkVG9YUjBK?=
 =?utf-8?Q?/SN9yR2wwNkr5VrlVf2LL2da816ZZHmKIk?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95b8bae5-2bba-4d84-402e-08db8f434652
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 08:18:51.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dRlXNJ4zX1ojAqCeEsiGbtakgvwPbsbKJtD944B6LmW0dv7uUOIkN89lS6fduEIVwMQSoTKdWtFEDguPxHmWwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4886
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280075
X-Proofpoint-ORIG-GUID: z_jadhjSK55JMRqIFAhU7b1Pg4OWy22k
X-Proofpoint-GUID: z_jadhjSK55JMRqIFAhU7b1Pg4OWy22k
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 07:17, Jing Zhang wrote:
> Add JSON metrics for Arm CMN. Currently just add part of CMN PMU
> metrics which are general and compatible for any SoC with CMN-ANY.
> 
> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>

The same comments apply here as patch 4/5, and, apart from that:

Reviewed-by: John Garry <john.g.garry@oracle.com>
