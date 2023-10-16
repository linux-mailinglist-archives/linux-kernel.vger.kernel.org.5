Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A07D7CAB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjJPOTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbjJPOTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:19:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3782A9B;
        Mon, 16 Oct 2023 07:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697465970; x=1729001970;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qFfOLk5mzu0tbW+dRwdzDEpKQhRiQesSHJJgMnuPdhs=;
  b=RZi33rSX8haEvfAcA2Pk+Vhu8KJlTR5a5V+IG9blJ9V0TarZAUzqCvCX
   eJM09ITcjewMbARpj4LIIsx/8eAJJJMsMuEU719t+JJNaoEIJXcPIy7HD
   7JO5nQKS4vlSUknAF+e82qMgm0+mbHkN6VQgYGp8wbidBFKPEUbyKTqg9
   mOzShxQmaPDJilMIG/kgaIzslqNjZAnu+oseogyyO5jFqdinsLnJWKSPQ
   KwTeJhEgsyKHRqNCDNlhTw0ldIx+bkt+JvlOHidfTm/04+Cv7t2ke2nFi
   MpuB39CWWjBJ7P3p0dhmXeqQuV5PIyz3oqgfulAoE8Cf5G4iu0+BA3oWB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="4148540"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="4148540"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 07:19:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="846408063"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="846408063"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 07:19:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 07:19:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 07:19:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 07:19:29 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 07:19:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BhiNwIQ5GNHoCkuvhQDUSkTbtmh1BxVNDr+lNbakzT5oZCRyTilXV0KWHPiOyft5k51pGlXc/zaamgEkuoyC1EcH1g8U14MpUHhS4YBwZfG7FsI5tIO/ttdiarWaSbh5DLpbGp315FcvCfnUksRl99eR29d5pWAnG0LeX7Kteh4MmSv7LQxqcnmkbH0FJ10GMqdWA/Nfd3fdDl2HNLgsHKiJt2Z2F3wQ6hfWs7+4ZR9Yk3lVlTtcD/ZdTgwEBiiaCi5Yl28AfVMcF7p3/wTnjH6WVb0UGuyA28kN5lRJ8WimHAfKbGPyQmq5XrvLFpPt3Ek7UccaL4raNyr/WEF13A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U48qYpdpfWebwq0sl8Y21OdC1pIQv0Hp9KB0/wqJ/JI=;
 b=cAzHYpv4Hb5BtAvpFh5i/GRXFgsqOTcXcd3hU6dfLqGMFyr2AcMHa9PEe+JzP9x5KhlhPLcV3w7fBDruQvzIPW28ZlI12wbNP6Wh/WxuO1IVsFqRoe2zrAx9HrClx31k/ERIKMPLObgAEQ/uboAMcT8OqDBip5lzlrpQyU6CDYXDpI7fX8xEkE1xos2i3/dnV5snSpFmlBSJHYz2E1DdkjK1VZ6VrY8IKmQfmSl4YFJC6ej30OStJI/tyEdGl9FmnjMTXEeD4+7ZlULqrM6rRZEp9iAOiCxEnA0fYNkcSHh47SsQMSxslFv5VlCmj3leFf4Y2IRUCodCeyfdKYffpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by PH8PR11MB7072.namprd11.prod.outlook.com (2603:10b6:510:214::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 14:19:22 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 14:19:21 +0000
Message-ID: <78f321db-bc09-06e8-b4ef-ac56ab91e187@intel.com>
Date:   Mon, 16 Oct 2023 16:19:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] staging: qlge: Add bool type to qlge_idc_wait()
Content-Language: en-US
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>,
        Nam Cao <namcao@linutronix.de>
CC:     <outreachy@lists.linux.dev>, <manishc@marvell.com>,
        <GR-Linux-NIC-Dev@marvell.com>, <coiby.xu@gmail.com>,
        <gregkh@linuxfoundation.org>, <netdev@vger.kernel.org>,
        <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <ZSoxLxs45bIuBrHg@gilbert-PC>
 <20231014065813.mQvFyjWb@linutronix.de>
 <20231014071423.UgDor1v0@linutronix.de> <ZSpIPippZFtMw2aG@gilbert-PC>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZSpIPippZFtMw2aG@gilbert-PC>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::12) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|PH8PR11MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: f823b14b-8004-4c64-0bdf-08dbce52e371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jb27g0GFfsgdwSKFSyt83tNaxT6ZiP7w7ByXL2TjAWpqgBOodntMJS3oZKvb9u/hTd0BU+IaVp8XrKkPtFT2jNPnMO4E/Mhr+ymIBtUdX9tMpWRcr2GpHABaWFdoliB5+zyytnfAWKrYLEOnpAhaNIqHjsr7SpTUfiEG2naT/wPgYEBCxrrs7mVrMdYz2/iQy7Ru7NmJDVVjUSOYG9LcO+OdHQts2Z4Vg3blPvB1jDbPcjpXocLSmQiOfIH7S+4emCandaSJTXDH9syDaQfrbxeycYEwXTdNRKf3rgPtjdaYXt50msRxBWWcjfiTQFtE7ekMKlpb9FHbU2Kc06mVgR8rha0cf9sdaLXjgHtsvXd051bnRRP8/tOKSrzVx6C+nBBRR+hsChNpcL8i9xKuQz0GNLLVDSPwOwGpmhuSsd0+mDeFLwA7Suq1Put4aldB3fu10daebgEwdkBCh3vfatWn8z2ecgk/9KFSXIPTjBrJJF1aHFUvKF4Wf18EHPkKADmNYcbbjQeyatq0tMv7zvKDwemiJEYW6bb9jqmhZ75F9uPNf4noASMYgng4GSinq+ewO47CwejdAuBLWzDP/Uz0ZNIxpn2CkHiFhVPnPaeF9Z9QSmQhbgrYAPgaBdotfwSizsoKV+p3DSzpnqalpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82960400001)(26005)(2616005)(8676002)(8936002)(4326008)(5660300002)(38100700002)(83380400001)(31686004)(41300700001)(478600001)(31696002)(86362001)(6486002)(110136005)(4744005)(7416002)(2906002)(316002)(6666004)(6506007)(6512007)(53546011)(66946007)(36756003)(66556008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmJkdWNSM3MzRm5IcW9WZnlsWVFXcEFOKzhHckdIYTBPSmJReWNxWTJrK1c1?=
 =?utf-8?B?QzArZEx5Z09GaEtCZm9MdjdQMHhxOUgwSHhxZHpONVVhU2NFZVQ0MDVzVkNP?=
 =?utf-8?B?VGtYSzhINWJYeU9NT0liWUFHYm8yMmh0TDNVSWdsL3VWelRmeFg0U0Z6N2VG?=
 =?utf-8?B?QVkzUlJsVkhudUdGMGQralV2YlA2MlhTd3ovRENVbEFtWUdua2xEbFppYVc5?=
 =?utf-8?B?SFRKdTA5Ym5YY0ttK3dZK3dRV2lQVEcyZHErdjBNOWRsNFAwMjh1M3NBWXVx?=
 =?utf-8?B?b2p5Y0FGTzg5R2RRK3cyYmR2REpRTDNrcjdaN1E4bWhtN3JHaEdHVGVqRW5k?=
 =?utf-8?B?YVNFS1lyL2N5bHVwcnNPb0hUYUJPT3RHWkdaUjdxY2pDdjYvMjBWNFJOb2sw?=
 =?utf-8?B?cHZYazNMTlB3M1VYcDBmeWxCS2NuSWQ1OXAyUHVldWtkT2ZxQkZLbUNBOG9Q?=
 =?utf-8?B?R3E4c09ldkZoSmtoWStZNkZCN255cS9PSURxcTh5TGtOaVRlbFFtWldjUHNa?=
 =?utf-8?B?dnBNbGlndjFkdmtQcHVUODdkcEdOZVZBamsvWjJpN0ZTanhGOWxSSzc0Um1q?=
 =?utf-8?B?NStWNHhuQ3JGVTZSL2RyTmszU3dNdmV2ZVl0RHk5cVcwb0U1Si8vSDhqTkpF?=
 =?utf-8?B?RVl4T1FtZUUybW52Ym92c1lqcjl4YUpTZ1dKbWxJd1QzVW12TndBMlMwUEhY?=
 =?utf-8?B?LzREdk1pa2t0NFcwK1ZJU2hNN05hQ2JnWXAyOUs5ZTdaemNEeXZqalhHNjJT?=
 =?utf-8?B?eHBJMk80OUtRaVkvZit4RU4yVHluY2hqWHJVYWh2QkRUd0o3eFJ1ZFhqK3Jx?=
 =?utf-8?B?RmVWS3M5TEVMRHNuc0I5bEkxNmNQRVJraWJBSWVGRUhHa3FON0JuZVhYSDQ4?=
 =?utf-8?B?Tm9jTDU3ZzhKWHcrSHpYNEZ6QTVzdUpoRCt3WVpvMktEZFl1ZXNBNlBsY0da?=
 =?utf-8?B?cFU4aWZ6eWZ5Y3dZUzJvbGFKUjVQcUsxMFkvN0xyc2p5VWJmTjZtc2Nzckds?=
 =?utf-8?B?WVdtcU8vSitUUU1xcm1JV1Z1Q0J3VHlkbUNxL0tkenRNV1doTTNtWHlUTlRE?=
 =?utf-8?B?MU94Q2Q5VDNnMmxMNnNUbUtKdE1MWjZsSXRhRDRoeE5VVmJuM0Q1Y1NWaDZw?=
 =?utf-8?B?bVo1djJidTZJNWhzeVdEWEFORXdCSDUzWWxvVVl5L1ErdmRiZVhPSjQ5cGhC?=
 =?utf-8?B?NTFmaGhibnpTaGVmTGFKYjJkRjVRd0kwenNTR3llT3c3RndncWNad0Zwb2xJ?=
 =?utf-8?B?RmF4TVpxSkI0andKc0Y3a1V5MEI3bTN2aDhuVVJxSWNlVmI3UFdMOTkyMkdK?=
 =?utf-8?B?Wk5zdk1hQ2h4M2JYY2JtYjZiL1BPcW5TRW1oUDhkUkkySFZkZXd6bnpKSUk5?=
 =?utf-8?B?TVBndmhwQ2l2Q1BNUkl5YWt0MktUc2ZtWlZjTE1CTUdyTWlFRWkrYjByUjJ4?=
 =?utf-8?B?cml3VGFkQVRReUFMVjBqclM5eUxrbndJSEpTZDg3bk1FQkY2MzlHQzg4OVRk?=
 =?utf-8?B?SnhQaVdzOUdjMGwzMUs1alpsZWN1RmpLZWRlV2ptZGpMd0JhZXByNjZMRkxw?=
 =?utf-8?B?U0FXSW11Z2MwSmFJWlh5SkkzVDlXeTJ2bUxNRVN1VlVqVzZRUXF0K1A1Uzlx?=
 =?utf-8?B?dmNHZUV2OWxjcE4xdXcyc3hwamFCdFMvc0pvckdXNE5SRmpnNUZ2K21mTkFr?=
 =?utf-8?B?Vnd0aGM3K3I5czZkNUFtL1JWd0VDUjlnRHBTU1RmSExNcDIxaGZDb1dpWTdJ?=
 =?utf-8?B?eFdyNXlCUm9FZmFuU04ycERTMTlCWGJlSmdKUFhmWUNYNTNFY25lelBCU0cv?=
 =?utf-8?B?ZWU0VDYrVmpnQWM1bGgydXpTVEJYRjZsK2ZzZHp3UGdzTmRZS1ZuOXUzM3g2?=
 =?utf-8?B?TzFKWjYyNWl4VWs5SEtsUzNOVUN5b1Y0ZlBHem5mbklsNFVFSjVxMEJZQmVp?=
 =?utf-8?B?RWM3RUoyM3FTMGpBSWV2UkIzbklqT0N4VVJxbDRVMTVvTzZkNTNYbTcwRkdB?=
 =?utf-8?B?WDI5UUxCcldoYzE3b3ZuVGx5VlZCSVVjT0g5MFY2a1Z1c0ZnMlZjaUZ5ZlQx?=
 =?utf-8?B?VWtXVWxLOXZuSGpZOXZGRjFRU1JPVTBaUDBYR0pJd2xha3NnN3pXSEFlcE95?=
 =?utf-8?B?RFdkamRaV1daaDdMK2puVGs5R0NCczRJYmVoN2c1czE1T1JpMjZ0dTZIVnpq?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f823b14b-8004-4c64-0bdf-08dbce52e371
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 14:19:20.2313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/RdUhL1IwH6ANKrs5mfIrrIMreNl8rc6f+kB3cmxy3ML06St56oWZl+BEyndr2OHHITa+77ccnpxw13HGZTWeFakNV/GHILe/UoVcCsjLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7072
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/23 09:50, Gilbert Adikankwu wrote:
> On Sat, Oct 14, 2023 at 09:14:23AM +0200, Nam Cao wrote:
>> On Sat, Oct 14, 2023 at 08:58:13AM +0200, Nam Cao wrote:
>>> On Sat, Oct 14, 2023 at 07:11:59AM +0100, Gilbert Adikankwu wrote:
>>>> Reported by checkpatch:
>>>>
>>>> WARNING: else is not generally useful after a break or return
>>>>
>>>
>>> What checkpatch is telling you here is that the "else" is redundant and
>>> can be removed. Although your patch suppresses the warning, it makes the
>>> code messier :(
>>
>> Ah wait, after reading Julia's comment, I realize that the "else" is not
>> redundant at all. Seems like checkpatch.pl is lying. So ignore what I
>> said.
> 
> Thanks
> 
> 

Could you consider fixing checkpatch instead?
