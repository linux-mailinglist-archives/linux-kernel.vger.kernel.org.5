Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D575F76C9AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjHBJoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjHBJoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:44:22 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5554E1726;
        Wed,  2 Aug 2023 02:44:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371KxOHu016418;
        Wed, 2 Aug 2023 09:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=si9T0G/cp1Uv1+z3kGDBThbPQFJrE7q0trNPHMFDGSc=;
 b=dNG1eDuN0lYMNvycJRKIpC2PHQL45S2so5rv980KFHq0g0TpTO4EpWXAm8ACLu7/HtzM
 tvpVHpIMwFqIyfSl+q4k8WB8gYG/uco1DZiqm/gGBGmSJO17PGIpsFAZK9ixQyvEilnC
 IGJ3+gnrydh/tOeRcXrMNwe6YzKmA2ROQPvg3w5JVRy3P4bbToujRDmPAqcCii6Ur/TS
 0rajc1U538D2NA0eFBfl3+/qH9DmHFjABk3zxIpz32n28KlEXdrytb2lhpy4rqGo18KR
 MxovSjel5KDvyPZSoK/68rJMnOn1fMF9h8Q5DdHNxiXHob7uyvbo8qxvlKts3cAGKoa6 LQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tnbeuru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 09:44:06 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3729ecOA006816;
        Wed, 2 Aug 2023 09:44:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s77qeh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Aug 2023 09:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHJcnXTWUx9h1mTrdKiNhOUCLi08rAuAIiD3wGR9E1yduEDwlbCTtrGDPIUGNbFCyJUL+2KNPodPK9WZRmOATiliHbuIQkMDSsG1zJWroB76vYwtgWgM+qq+tBrfNNdb6KdRlfb7I89V9vhge3fCMM4JmcES6OaQrNhzbD5frIAY6VAXDaXe4uh7eXjZ+cZF0jPex5AE807RGnnkNM90yuP7RBmsnaxgtI6MIyR0TT7tpq0KKRgzQPRXy6yzNrKnvd4S1dJxkaUtotux6y9CgKSbog22rkF1GZErqpVXNxvaoj6MPbA8IufThiEfpZFuE3xNzh/GJrb9YIgLCF3s7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=si9T0G/cp1Uv1+z3kGDBThbPQFJrE7q0trNPHMFDGSc=;
 b=MkDH8bkGiRxk2zzjnFd3qaY4SGGgnfHmG6YGD5hpt3U2HtfDDFMtoxD5XF+8BqH3rkxl4WjfrK+XMMd5SlNacqUNU63A1sLAfFceeI/B7CphDlBKn+dQLyYD7RDV8fZCMYnWiNq7OZRWJhYm5+dh3cz9x17dBPuQxRdqrCQon1TgQFoKbEwUvFWqCXeuyemxJFx/R0QzIVMXcdusGzgr0sj6RTSKMj0KrqRQ9eIAjlVCcF9P5zcvWs0OszImfdTzz2V7FHFtkigqu+GcvffQaYL9atLsesV4zwll8OL+eIHKU3BZofydnm8nJ9Zx7gIIkQvXGYlNFRa+GEznkUdZ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=si9T0G/cp1Uv1+z3kGDBThbPQFJrE7q0trNPHMFDGSc=;
 b=tCHjq2IOCvxO3/ym2odNqNnwzcBc7KQ/FrP1MFCI5PwrFhYDOZlEArYehT+5T7SJCrv2xnb6ss0sLY6ll9x9EqJwboMHZa9uDGdZN+8STmHiKO3rEZza6q9aXNvVFMbrJeVHWUykGaU6FnKQayptddbJQm3Kh78raGoCZSZr4Xw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7511.namprd10.prod.outlook.com (2603:10b6:8:164::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Wed, 2 Aug
 2023 09:44:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8072:6801:b0b7:8108%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 09:44:03 +0000
Message-ID: <b471c336-92dc-af42-dfd2-62831fd6dd60@oracle.com>
Date:   Wed, 2 Aug 2023 10:43:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/5] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
References: <1690525040-77423-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1690525040-77423-2-git-send-email-renyu.zj@linux.alibaba.com>
 <268b3891-be4b-5f63-eff3-7b6d83e906e9@oracle.com>
 <0801b73c-6649-8c54-8dca-276efc2a4967@linux.alibaba.com>
 <8e207c71-5400-5427-ae83-a1e0b8f95e31@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <8e207c71-5400-5427-ae83-a1e0b8f95e31@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0205.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: d874bfa9-5cde-46d6-14d8-08db933d018a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3aGXYFqc/6bZ7jHOEBcakDo7ybxzrlPgJQhnrdYn0b8AaA4isnasd0yDsb9zOvvaCz4da+DHCspdXsmrUWOjy2Qv4nshYLmLVp1xSMZY/wUSUzLYBZhGScp0g8jV6nJx7DND1CbID/6wN0hMS/Kvk8kmebCcVL1ICFRZzMv2awPmQ9u53zb6J+cToy9N9CmXBa3R4GozHQKUWRlG8gpms0XoIXH9JlVKm78qZLoROBQuEFPcbBZFVpL3e4vxPT7RAIHbGgsrrjyKEPdixKJtgzsE2VVtCLprlU13rdgGNNFIdqGqAWlQ8OG2zYMDxfYFJalhdWVytBL0JLPgeyyoxyIGBrgc7wnWIghlmCB3Z9ZtyJuRcGsz7cduvC/FyL/4OJ79lf9mft1Npl7cPIP18ShCMcEsG9pV0eHdDnhfGTDFfcnl5KaaokYJUCCuiA1XYNkXnAFJkyoJVFaOU9/la6c9AxMsysfadO3w4uX6t8ZlrnTbjNbwIfneTfGnHRCyQMfuJjbRc7woTTljzJxBtssgXABgIVr+q3M0Yijy8BjHWCq/vsE8N+b83rh0QBzOa7osOhn/cR5BP//rIQhhwzR6y0xk/kgQpW0FECF18MW967OgC/naXFeTuNvcqFrm3ARvP3+OFRtqiQrJE5tnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(38100700002)(36756003)(31696002)(86362001)(6666004)(2906002)(54906003)(6506007)(6486002)(26005)(8936002)(4744005)(6512007)(36916002)(186003)(316002)(7416002)(53546011)(5660300002)(31686004)(8676002)(41300700001)(478600001)(6916009)(66556008)(4326008)(66476007)(66946007)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHVaSFBtelJ4QXRWSTNZbXl5L3Bqdk5RemdjQkdyWlo1N1hHVjNPV0VhQ1lO?=
 =?utf-8?B?VFNiSXZ5K2lObnREa1RnZit0N09OMEtRQVBNOHZBUmhkdUsyZXdBNDc3a3Nk?=
 =?utf-8?B?ZERTa0d3Y3Zhc0pOYnJSNzQrRnVpRjFPa0FLcExDdWJnZm5EM2lIK0ZOMnJx?=
 =?utf-8?B?OG0xOTdXc1JGUUMwdVNlVUo3ZjU5THFhRC84ZkJSQ3N5elRkUUs5QjlQRWFq?=
 =?utf-8?B?QzlCS0pKRHJ5WFlaWVNBbXd3am1PUlM2VllXenVWaGVnWkVvYUVRUzJiTkRY?=
 =?utf-8?B?bGUzZ1ZKc2tGMGo2emVJQnl0TDdWSU5Jdzkxa2tJN2V0SnRTOWR2bDZ1bVVu?=
 =?utf-8?B?NVRROE0rTVdleS8remdoQ0FlY1hOV3VJTzlwemQ1alJhOUhJaW9GaWpYWVlH?=
 =?utf-8?B?VTQybHNaZk9aSmJEZEVlZTlxTW1DZjYrcnIycEIxVVVDdHBnVGUxdmliZExT?=
 =?utf-8?B?MUppcE1VcSt2WldDSFhUalRDWVR0WDZBYzRkdXNhakUzYzI4R202alpUMmtm?=
 =?utf-8?B?My9TbGpSZ2ZrNjhRdUk5Qnk0THNGbzFBWWNBcS8zNExmY1lnYXpVQ2dHYjVz?=
 =?utf-8?B?amJ2OG5QL0ZEaklQU3F2Y2lvejN0VlFQd3J1ei80dTB2VnJoRGFjYVhYdlgw?=
 =?utf-8?B?MkdRQUlnNWFVMnUrMUJGYmNyZlF5QUlPeWpnTFNybkFCbTl0emJ1V2hOVzk3?=
 =?utf-8?B?elpHU3MxdnBkUmhNeUdlRWtQZzNyYnFBdmc2aWlTMjVHUkhOS1BOUU5XMDhq?=
 =?utf-8?B?eWlhdWxiZXpOQ2F3amVtVExOSDlwZ29tSGIwbGcwamZJOGx3ZFdjcVdab2ov?=
 =?utf-8?B?N3B0T0NYVHV5dnF4bmNyMGNhWElHQitUQVhkTWt6MGxETURtNmhMcmNmME1l?=
 =?utf-8?B?Y21vN0dyMUU3RGpIU3Z6amUwazdtRHBTUkZtZ1RJaGRiYmFSaXM0SlhCSWRu?=
 =?utf-8?B?SjNwcHJhVGdLaFdqaU5UMTZuazkvQXk5emFMV3Q4ak42R21teXFEZFhyRzdL?=
 =?utf-8?B?M0xaRVgzK0o0eHduR0lMOHZZQTdkR0hoS2xXK3V0OW5DVS9HU29JY1VuenpD?=
 =?utf-8?B?UkRxWFFZQVBmTU13aDc4a2xFczI1T1VjKzhvK0IrTzdOZDYxNW44cWxDRHFu?=
 =?utf-8?B?c3VrUmQ3ZEpOdEVYdXhVWVozV0F1SFdhNjQwTGtFMnRQdmFVSm1EZkxNSExr?=
 =?utf-8?B?djJTOUNCWlAwSmdaY0Nxc1BjaEVjWGtzcy83blJSa20vWkV4SVk5ZWdtSloy?=
 =?utf-8?B?czZwZ1dQbzZIWG5Md2lTNkJEQnpHV1pZSTFjWitBbmgyZ1BlNDdoOXNDWlVr?=
 =?utf-8?B?b2dYRkM1T1AxYy9tWWpHQ2RabkxiNDArR3d2WVpYQm5CZlJRU3NkSkJiKytG?=
 =?utf-8?B?ZzVMOEdWMWhPU2ZzblEzMDFQV3hFd2pLVmZBMEp3UjJFbmZ2WGdFTkJnS0V3?=
 =?utf-8?B?QkxORnZqRGZocnJKTW1TK0lQcUF5aHc2OEZaWDl3TGVzVzVNeFI1Q3I5RElO?=
 =?utf-8?B?bk9ZbG1VNnhrZVdoNm1aaE5CbWUreTB3Sk5NcityT1VCd1JiNG02aDhEdG1T?=
 =?utf-8?B?aXloMk9sOWR2dmhxYkJYQkZrOEpOaWhGczhTT0RkakoxK3QrcUNzY050KzVT?=
 =?utf-8?B?SjRjSy90ekk4SEZCaWp0Y3NDY1pBMjI3QldzZTBtZUlWSkdZSERXeEVubEpL?=
 =?utf-8?B?Z3hSdUo4WTFyeEhBblhxc3VsSnpoNGNvdlZTZnh2b1NEVFJRbktPQmR4Z3Bv?=
 =?utf-8?B?SlFRNFU0aE4zLzR4ck16L3h0S2d4NGFselhWTzg4MVZMa1dLdXJNWDlLODZS?=
 =?utf-8?B?RWh3aG0wck1tMHlBZlVkaXZzYzlJTC9CMmd0K1NXZG9NNGxwU0ZQOU9KNVBX?=
 =?utf-8?B?Q05XdlJCTHcxNUZva2JIS2NMVXNoSTg5WDVxZUJVL04yanpyOEptZTcxYy9h?=
 =?utf-8?B?aVBDemtKSExNR1RpOGFkQWZpejM2cGNKdmRjYXphcC9ZaWxMaDRRek5pWm5i?=
 =?utf-8?B?blhWSHlEbWJvK1JjNDd4WDkyYThYWWFBTjJiT2JhdHkvb2lNUDdjNGc2Sk14?=
 =?utf-8?B?aGpQdnJKOTMvZ0NiU2FoaWFLZkg4b2w3Nmcwc1dMano5TzhWV0hnZTZ0WlVl?=
 =?utf-8?Q?ANgYHOoTpAt4Jd/uw+7el1NGl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZGlyUTJDM1FIVERiUk5Na2dZOGtGZ1UzSkhyK3c4eldVcUVjaWFMY2k1K2hL?=
 =?utf-8?B?WEFsUWFXR0trQkphdUMyV0N5TTdjWWcvdmI5RTkvdjR1enNTdzg5Mmp3S0x0?=
 =?utf-8?B?cHpyNzdYdGZJelhnMHF5R1FXOGNDRlBBWkRscU9rakVpZEdRWDZqZ202M3F4?=
 =?utf-8?B?dFQxSUw2eWZiQXVJNHZjdDlreC9UMW5JWWRob254U21CZnlLN3Z1K1NndVVW?=
 =?utf-8?B?RFQvNXpBNTJqVE5pNWYzY2ZhK3phQ1E0MGJseHdnS2xZaFcvSEo4NHJMeWU2?=
 =?utf-8?B?Y2R4SmtDSzdvb3B3RW1DYjU4ZVZtaC9qYWxDREFOei9YblRvY2V2Wi9LYUpx?=
 =?utf-8?B?SVI5bWZhQTZvTmhzZFA4Mm1iaHlGTWs0OGliV1crYnNMeUJIT1F6Rjd2N2s5?=
 =?utf-8?B?TUdsNVNxODBhbUFlMzJvOEtCWGROQ0JRdUtxczcwMGxFeXVWUVFkNFZKQ001?=
 =?utf-8?B?ZjhzSnZnWkZuTzNxaEJQVVpneERuQVBtcDA3ZnI5TVEvc050TWJ2ekdPN09R?=
 =?utf-8?B?RkFxN1NubHNaaTd1ZDR3Y0VFQWhhUGVRbmtTRGRRbGhQeTluT3g3NzJnNitt?=
 =?utf-8?B?MjFiZzFkbHZjMnJnMDFiU0ZPcUw4TzltRVJnRDJudFo2L3dqVTE3d0lHakVH?=
 =?utf-8?B?eTlGTzM1V25DUmZtYldMZWZsbjF1M2Q1Z0t4T2MxMG1VVE9tdWhRNTRpaG8v?=
 =?utf-8?B?ZHZnY1NUeVFDblRZVDVPWDVMTlpOaUZiR0xFT1V2anhnaHUwcm1sSVk1ODNk?=
 =?utf-8?B?aEpKSkZSSmpZWmQ5TE5FTmNpQWQwclE4RkxrRjlJNGUxbzEvbHJlakxqZ1U2?=
 =?utf-8?B?RmtUWk90WDBKeFRPYmJxd2hoaFNQTGxSVzhCS0tpTkh4TXNpNURzbzRMZ3pt?=
 =?utf-8?B?a1hINllSVlBJQm9DVVlhMWswRHdCZnlCT05TdlJEQS8zVldpclhGZ0tvcDZU?=
 =?utf-8?B?emJaSTQ1TXBKQXk4dDk1QjNaMWVPd1I4d3lYYkRwYm94MElwVWtmNS9mT2xG?=
 =?utf-8?B?bDkrL0cwWWZTRnlGSTAxenRoRUI3eHVLOWZQNEcvMVdNOFVzMUE2bkNqNHpP?=
 =?utf-8?B?cTNTVDNkR3B2c1NFdTExbldZVWNpd2tUejdsTk93a3ZlTEd2TXRRVzVuY0JQ?=
 =?utf-8?B?bzR3TlFMcTl0dmoxbUR1WkoyQndkZjhjait6N1lhNnZQN3E0T2lNbVZCM05n?=
 =?utf-8?B?bnVGeHZXM1owYXZmSFo0UFg1UjdNY3NBMi9rY3ZOeXg4U2NLSG9NMlFoZ3Bn?=
 =?utf-8?B?S1ZaUUFhUEE0YXNQYnZubjkrdjgxaHVZak1jZ1lGZFBibWQwNVBrR1hwWkFk?=
 =?utf-8?Q?s+cg/CRuwBHi3k84/LZS+TNXlw2Sj9TEME?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d874bfa9-5cde-46d6-14d8-08db933d018a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 09:44:03.3880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Y/wsrYCTR8DzyDI05mC5c3fEKX0xQB1MZo/7bXmwlHUBahyNNjX61zCOOQODJEEkjU1k+IplzBvfAx8ZTSnDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7511
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_04,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020086
X-Proofpoint-ORIG-GUID: 4sUxs4zuKa1Y4_No3-E2h8lx6mC56-oy
X-Proofpoint-GUID: 4sUxs4zuKa1Y4_No3-E2h8lx6mC56-oy
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 10:38, Jing Zhang wrote:
>>>> n;
>>>> +
>>>> +    str = strdup(compat);
>>> why duplicate this? are you modifying something?
>>>
>> This is really a redundant step, I will remove it.
>>
> Hi John,
> 
> I reviewed this code again and found that it still needs to duplicate "compat" because "compat" is a
> const str* type and cannot be used as a parameter for the strtok_r function. If it is cast to char*,
> using "compat" as a parameter for strtok_r is also unsafe and can cause a "Segmentation fault" error.
> Therefore, let's keep the step of duplicating "compat".

ok, so then please add a small comment on why the strdup() call is needed.

Thanks,
John
