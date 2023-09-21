Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A767AA0F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjIUUwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjIUUvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:51:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4732D231;
        Thu, 21 Sep 2023 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695327933; x=1726863933;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FjaawV4eOwqk7xBHsT3QNk0R4ncRQwi5kQ7vn93XHAg=;
  b=YkV3hgrObBpAwSpLbnQbmiK+bbncV2oABxfyzX+aY9f3vy1Wq5+1b5RJ
   wziXEJ9/ONQrnbmTbtfKslbILBzZLoWQbo9b0lGG5L/Yom1dBPjGORclN
   tcK2l+2XeWAaGR3eNGWVcX7eck2ygKLKyiYseiFzto4Y22cMP/+vm+/dz
   vgJkoyD1cEHLwAU1mGPWVgqAAbs6U+5NxjhlzDPXquJeBoW5VWtsnB/Dy
   8VLNF+Hu3xrKDfthTGdQu1dcWK51ftaaDMJgBMyuZrqn+VPatP+jY81TX
   jSrYcTrlc+G6kFUO8IbsUNrHue6sLLHotgrLDg7cttqCl9/drBSaKdkuI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="444761146"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="444761146"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 13:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="870966811"
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; 
   d="scan'208";a="870966811"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Sep 2023 13:25:21 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 13:25:20 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 21 Sep 2023 13:25:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 21 Sep 2023 13:25:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 21 Sep 2023 13:25:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLYv2UDJYXLa0bCEnFY7++fRo4pMjYdfgOzxZMxQOA9gflU2tV89GQhvbZeINyQ+SwttC3SMr7+2XH3B8MtTygdEWrjVMed+KursO7NHsK0y4hDVbm5orG7Sy5Am8T9Zb0ozRZwtwDqtuSxEuN2MncORAJak1+q1QcCvPUxI0CIqT7EdLzOapNUbXzM/4KwriN19BsAvG8efy5AFWpgd2RiejoCabU1icHj+2xmgTXbBWD7aIuHq+lRmm5rMR1Iw+lpoTXov0oIrMsggD+teq2QECVsaeJJCmAn2pGr+EgQRioQ3FngEj2cDSHlNMb6GROLw6itXrg4pe0rXmPjwHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b1xvLWA/PORBwyIcLuPqUFqNsgyBL6wUC0/cKzTbDZQ=;
 b=XzGH5/3jB/lXSTVn0WpGCcwDeg5bk3/YR3V+KqEcy8VxK2Xx41BLFoHA5yB4OiYg+/nTf5G8vwzqWt+1M0up0SHKdwqLL5iVwo/ZjpbWBVtusMw6fcHzyaxtVzm7aAoOivS3Gx7ImdyLepHFqQ27RevNbUDD858b91tnzjP4HuPlCbb2kt+8eeg07qIuplJgH+JmxGAVvsB+QUr/Qm8kI1p+CGjIvl/YS7RwfqpBDTXtVvuvJsoV7472DgEZguRr0xR2yN8bzLCyXQoTSU1DqisecTZuz7/CiEIjOEbp6eR7V4V0ttTv1eMMiCQIoAoK+fwkOn6rSYHFR5uA1z8lDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8450.namprd11.prod.outlook.com (2603:10b6:a03:578::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 21 Sep
 2023 20:25:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 20:25:18 +0000
Message-ID: <873f07e6-cc99-1901-4d09-db77994d88db@intel.com>
Date:   Thu, 21 Sep 2023 13:25:16 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] net: stmmac: platform: fix the incorrect parameter
To:     Clark Wang <xiaoning.wang@nxp.com>, <alexandre.torgue@foss.st.com>,
        <joabreu@synopsys.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <mcoquelin.stm32@gmail.com>, <bartosz.golaszewski@linaro.org>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230921062443.1251292-1-xiaoning.wang@nxp.com>
Content-Language: en-US
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230921062443.1251292-1-xiaoning.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0269.namprd04.prod.outlook.com
 (2603:10b6:303:88::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3e74db-0fce-4a91-7184-08dbbae0df39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y6U1LYUw5fUsR1SB7k1983OvOsHCkQQYuqdE8il6rOjGRhTnYJEKHgva5bGx+nNAzBNHSJdXHcvONDTpoICfOFKzDw2k8XBlr6llI61I+0fvehuZmBEXjQIcp/1srBclKNLbCRQ+WRrEOk9amaeMnqFqsPk00VbuReV0lPWy7tkF7LgbcWnQCERlKKRGAZyZhPe9mmqAj/7kcPP+qwniOOMnK6X+8BRhpT9H4ji5AyXLPSLtvJrBcdXN/OCH/IL1vdP1tfPbUDZADBxYOuj2jLR7fABxbcEUsjbw5OBnM7o2skWesJ7YjAbJ70wnU9O2UED19Co6q7rfCL94X65CiZwUOgvIaRj+/pJkVoPYlzHDhAb02UN/jtWAfN6u178/kW76s3UYOBmSj5c7Uz/aAADL+u0c9yyQW4Kk9E5TVHpA1FHPaLmSn/bKY87Jpci7rctNOROOveMrmlORHJl2h9ev21XwnoMvLBErMSPT3KcmlUCNa56kSdwonkhvu4f1Y44iyHjZMx3UYBTQ4ppvUTbXQRCVucgfZGVM0XLywq31bPEuREwDQ6qV06/+s7Jk0RIv3fV7bsydMAEhf8dQ9ZYaZwnr8UUrkryB5SzghvZdCrZlCKa7TdMv9r5FGWA+rPMLD/s5715wid29aZ9Imw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(1800799009)(186009)(451199024)(478600001)(53546011)(6486002)(6506007)(45080400002)(6512007)(83380400001)(2906002)(66556008)(66476007)(4326008)(8936002)(316002)(66946007)(5660300002)(41300700001)(2616005)(7416002)(8676002)(86362001)(26005)(31696002)(82960400001)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L2VlYkN0ejFKS0F2WHRQYWx1cXE1cVpoT3lhbE1xNDFQTDI5UDZ0ZlYyTm44?=
 =?utf-8?B?RXN0b0taY3IwdHd6Y2w2a2x1dDZiaFFITFlFK3R0NFNnRzZjc05yN3lxNXRr?=
 =?utf-8?B?dnorYXNRTjR4MjNWQkhFcVpaNTcyTGh2Rk4xbXZiYUdvSXNiOFp4dE1FcUhS?=
 =?utf-8?B?NkxVbUd6ajN4M2V5ZkRSVVJkYmNjT3N5cjdmbHNDWFZZTHNhMnhreEdlVTc2?=
 =?utf-8?B?bkFybXByYy81ZVlyYXdwWHNaVkF6d3RldDRwcmhBK1J6SmVKVGlNcGxkckov?=
 =?utf-8?B?YU04bDRMYlpBWHBiZVFIWGV6RkNWeFpiM1cxcWt2Y1A0MXhTSnVseHVIL0FE?=
 =?utf-8?B?Z0NYc0VmalQzdWlmMkpzSUQzL0tOK2pSZEMrTHFKNlJNUDlnZTVjdDVYaEFE?=
 =?utf-8?B?Qkl1OGx6YU5qNThVSWpQUkRsRklOb0JoN3dIdFVoZmZZZG1xTzA1WFgxUXor?=
 =?utf-8?B?S2cvVlhLZ3hjQ0UvQWxKZStrSzdkU2JSTnRiUjdMMVlVbmE3MmNiaEFBSmp4?=
 =?utf-8?B?dkNyc04vVVJ6ZEdtdk56NnM0dWJ6bDIyWDlLS1RtaWpiWUh0YmNIdm1RcGsx?=
 =?utf-8?B?NFZjQjVDN2Q0VWxQS05VVzgvZm8zUjRTMmdMSVpzdU9uVUpPMFo2emZZbU1F?=
 =?utf-8?B?SWl6MDdud3B6V08rRWdkenh3QTlWR1IxSDVnTkxaTlR4M3l2cytGOHE4UGFv?=
 =?utf-8?B?MlYxZWZmZEFJOXVEZ0M2OFJ0dW9SWm5KOEg4bkQyS3ZtTzJ2MzlNYVBwaVB5?=
 =?utf-8?B?cGFyWldKV2tHMVVyczhFZnJhQVpNazliZEcwanVCTGtkMmpuNW1mWWFkWFlx?=
 =?utf-8?B?cUxWWEltd2pSZmNxRmJxckZHM1VaSTRqZDY5VTE5Yk1PYmk5blFMYVp4dUJ0?=
 =?utf-8?B?TUxJTFAxN0diYkNwM1FURm1kTC85cFpFTUhUakMvUWhRVXpXSEJqMHEvYm1o?=
 =?utf-8?B?MDg4bDlnd3FUWXpHZFlMTFVjSUJTMnQ2M1I4MFFvSmJmdUJwb3NLRmQzQVdI?=
 =?utf-8?B?UjlqaGZIdllCakR3Wkd4TVdtTS9wYVVnYmZOUlZJTFJuTGtySUdHZm1NT0cr?=
 =?utf-8?B?NnV5ZHFpTmpYOVIvRTlGeVBGNnhrYTFmOWJWNkJoUlBwMkhMN2cyR016a2VU?=
 =?utf-8?B?NVRjMk9LNXVXdi9wZDAxSmFkcDlQN1dKcEJRQWYwcEFpT051cUxtOStra0dT?=
 =?utf-8?B?WXVqZ1FRMmU4TVpMeTJ3QjRQaHV2OW9VYy82UDRvUDZSekVXZTZaK0NaQXV2?=
 =?utf-8?B?M1JmT3ZSa29xaGI4aWlnY2xvNE5mdFdZeEtSTlVDM1FaRDcxdzU1U2xvY3hy?=
 =?utf-8?B?bXdYTFEwcnFCLzQxdG9OcXpRYjRaSVRWM2Y0ZUxjVE9FQVZzS3U0YzFoa3V4?=
 =?utf-8?B?SGFIWmNJRkhlZ2w5cGxqbzUyNFdubzZvaFYyVThOTTRTa0xlOFp5Y0lsYXhT?=
 =?utf-8?B?VnQ5Y1E4K2pkS2pMNzQrZXNlbHprdWxXSHpqcHdsT2UvSkxZODBlR0RtaEJm?=
 =?utf-8?B?MTRKbGc2Y3NZbjJadVBSU3NnandRd0QxNWowbXVFcFFEeENGOXpiWjhNMU82?=
 =?utf-8?B?b2p0a2JJZVExOFJ6bW02bEZJL2VCakd2czNsSkhtbUxLQlZCRGpyNko1ZnVS?=
 =?utf-8?B?V3JrRUlRaUZIVzlIOFJBMGdGSDVFSnZONExIaTFydnNReVkydENxRlRrN3Aw?=
 =?utf-8?B?MnJGVm4yR2t4U2NyemxYQVorUnduQVFYQmtDZTd1WUN3RVlUZXNmM3RjK1d0?=
 =?utf-8?B?cjB0NjhFRllJdnFDOVQ5VmU5RkJQaGpKSk5kQmtpUEZ5cThQR2x6dFI1cHVo?=
 =?utf-8?B?bThpcklxNExJZ0pRejhmQVk3VmcwTExSYnFUVDhleDRIdUwzUGdYNnlremtr?=
 =?utf-8?B?ajRPVGh5SExNUVMwWDl5Uy9nTE5ZNzZWd2dpTWVzRmJncldBcm5YV1ptVExt?=
 =?utf-8?B?MitjZ0l5N1hNYjdxalJxSGl2dUhQTEUxaTZrUm5OdFlPRjlhbFZDL3l4bU11?=
 =?utf-8?B?VTZBYWEyRGh1T2lLNDdSM3dLTy96WWs0bTlJTG9Yb2NyejlCM3VnVmJKVjFn?=
 =?utf-8?B?WGViSncrYUM3dzUzV1RGeFlOVWMxcWFSalBYZmhuZlA4STJCWEZRaTdkdUVu?=
 =?utf-8?B?Z3htYmZ1Tzg0bnBVM2t5NXpVS1A0UDErNUFyQjBTKzh3eXF5MG5lZWRKc1F1?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3e74db-0fce-4a91-7184-08dbbae0df39
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 20:25:18.4461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +EcIXmdAhTAz2t3+j7RESICjSIMvUXa1sImnipnZlYNbxTg5thCLQ/y92uQicJFl0CaLey/v6tzD6pmN9D1UfZLsCxCZgVrs4qGw9Q9OHVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8450
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/2023 11:24 PM, Clark Wang wrote:
> The second parameter of stmmac_pltfr_init() needs the pointer of
> "struct plat_stmmacenet_data". So, correct the parameter typo when calling the
> function.
> 
> Otherwise, it may cause this alignment exception when doing suspend/resume.
> [   49.067201] CPU1 is up
> [   49.135258] Internal error: SP/PC alignment exception: 000000008a000000 [#1] PREEMPT SMP
> [   49.143346] Modules linked in: soc_imx9 crct10dif_ce polyval_ce nvmem_imx_ocotp_fsb_s400 polyval_generic layerscape_edac_mod snd_soc_fsl_asoc_card snd_soc_imx_audmux snd_soc_imx_card snd_soc_wm8962 el_enclave snd_soc_fsl_micfil rtc_pcf2127 rtc_pcf2131 flexcan can_dev snd_soc_fsl_xcvr snd_soc_fsl_sai imx8_media_dev(C) snd_soc_fsl_utils fuse
> [   49.173393] CPU: 0 PID: 565 Comm: sh Tainted: G         C         6.5.0-rc4-next-20230804-05047-g5781a6249dae #677
> [   49.183721] Hardware name: NXP i.MX93 11X11 EVK board (DT)
> [   49.189190] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   49.196140] pc : 0x80800052
> [   49.198931] lr : stmmac_pltfr_resume+0x34/0x50
> [   49.203368] sp : ffff800082f8bab0
> [   49.206670] x29: ffff800082f8bab0 x28: ffff0000047d0ec0 x27: ffff80008186c170
> [   49.213794] x26: 0000000b5e4ff1ba x25: ffff800081e5fa74 x24: 0000000000000010
> [   49.220918] x23: ffff800081fe0000 x22: 0000000000000000 x21: 0000000000000000
> [   49.228042] x20: ffff0000001b4010 x19: ffff0000001b4010 x18: 0000000000000006
> [   49.235166] x17: ffff7ffffe007000 x16: ffff800080000000 x15: 0000000000000000
> [   49.242290] x14: 00000000000000fc x13: 0000000000000000 x12: 0000000000000000
> [   49.249414] x11: 0000000000000001 x10: 0000000000000a60 x9 : ffff800082f8b8c0
> [   49.256538] x8 : 0000000000000008 x7 : 0000000000000001 x6 : 000000005f54a200
> [   49.263662] x5 : 0000000001000000 x4 : ffff800081b93680 x3 : ffff800081519be0
> [   49.270786] x2 : 0000000080800052 x1 : 0000000000000000 x0 : ffff0000001b4000
> [   49.277911] Call trace:
> [   49.280346]  0x80800052
> [   49.282781]  platform_pm_resume+0x2c/0x68
> [   49.286785]  dpm_run_callback.constprop.0+0x74/0x134
> [   49.291742]  device_resume+0x88/0x194
> [   49.295391]  dpm_resume+0x10c/0x230
> [   49.298866]  dpm_resume_end+0x18/0x30
> [   49.302515]  suspend_devices_and_enter+0x2b8/0x624
> [   49.307299]  pm_suspend+0x1fc/0x348
> [   49.310774]  state_store+0x80/0x104
> [   49.314258]  kobj_attr_store+0x18/0x2c
> [   49.318002]  sysfs_kf_write+0x44/0x54
> [   49.321659]  kernfs_fop_write_iter+0x120/0x1ec
> [   49.326088]  vfs_write+0x1bc/0x300
> [   49.329485]  ksys_write+0x70/0x104
> [   49.332874]  __arm64_sys_write+0x1c/0x28
> [   49.336783]  invoke_syscall+0x48/0x114
> [   49.340527]  el0_svc_common.constprop.0+0xc4/0xe4
> [   49.345224]  do_el0_svc+0x38/0x98
> [   49.348526]  el0_svc+0x2c/0x84
> [   49.351568]  el0t_64_sync_handler+0x100/0x12c
> [   49.355910]  el0t_64_sync+0x190/0x194
> [   49.359567] Code: ???????? ???????? ???????? ???????? (????????)
> [   49.365644] ---[ end trace 0000000000000000 ]---
> 
> Fixes: 97117eb51ec8 ("net: stmmac: platform: provide stmmac_pltfr_init()")
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> --->  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 0d9b2138b60a..3c6fd9027934 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -900,7 +900,7 @@ static int __maybe_unused stmmac_pltfr_resume(struct device *dev)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	int ret;
>  
> -	ret = stmmac_pltfr_init(pdev, priv->plat->bsp_priv);
> +	ret = stmmac_pltfr_init(pdev, priv->plat);
>  	if (ret)

And this compiled because priv->plat->bsp_priv is a void pointer.

Makes sense.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  		return ret;
>  
