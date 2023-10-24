Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8BC7D5119
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbjJXNL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233153AbjJXNLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:11:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9705C1;
        Tue, 24 Oct 2023 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698153109; x=1729689109;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hpdpp5mYC5WNPDwH2YRlg1YnFy/j/+krlqDkb44b698=;
  b=QZh7GZERx78u5T+XB+b9RRGHYHr4guJEP0cJZ9dsmCIkec42vk6xJLDZ
   MjtvOzZ83D1aWHuCeZQvav+GAMc7ZmKD0BVewsNviJpmmxheMzPwIU7Lf
   E1tphsG/rdSgoI6sueUCTpFRebgjwTJoCoUTxQXVRuam1iMumUy2Gu1k+
   d6kQgZTjePSrqHGBa2AiF1N5ypFkJvOlIMFJe6H/iEVn7mYXm6cy3g1pB
   kUaN8tIPrO1WUA920V6BYego92tmtxwNuWID0VUIlaC1xaFLYrp1WMcMt
   Z/tTqjT1BKsIPijU8/18RgVuJ8dBPlGfzE1rtIb87suAuN4iFD8vdP3/i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="389901956"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="389901956"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 06:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="751998224"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="751998224"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Oct 2023 06:11:15 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 06:11:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 06:11:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 24 Oct 2023 06:11:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 24 Oct 2023 06:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbmDElkvMH05bAsb86bTRfIPs2knsMlpiISMAvD9zN78YdohY9taCa6KXJwOXkMoITe2pnoHQ5gfI7jXM2rsVQntIny/eTl4mmsGUHSXdLhTCTY+eJfmsWQ+mvIV6kLMhHc+k0/LofsQtaW2d0Bfj8UBLjy1uN93RKjzGDz3qt7fDA810FOLgJVqvdcmdFWO/Hp+qq7i3NXjrmSqJ0G4df7VtSYqTzoZgHx4WUhaGJtgXHIqXG5rFUvc5SrUBtgXwH/Lh49kx6GgmKC1/issQy5k09VwI+efq78W+L5YNiuaf1WkvAxWjql7MtYZ/fw1wsLXwk/BN6KGc0jgJeKaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDq0rmibhifud9pJjCg1S5BNWokkKWSh3dcz+eZs0jw=;
 b=oY//+kXxwlZLZBFLqYE6lc0CeKzPBuhV0OrC9j2Fr3p+LAjxp3rAMJ0eE6Wl7mDxT8gBJJXct02qF292yGVz0gB5w2zLK0gYb1E6quGzF3CNOCehu/TD4UFERIWmy+vI9ta82AuH0TmZ8fr8WFjhP4E2M8zCUtxmbMXNLA9l8/uyqrhKHQvYL2Cn2Fy9Jwco+UHS+hoYVRwnce6ds+fZY4Dxkucyk38aGRycWeCL0HP+c6Vl/eIeDanUgr+YGrrvuxNQj/0stzLp0+OXOhP/rbMp1LaLFbPpRXpmQLdCzLoE8HRPcZHmHe9mO4TkHSN4K4Fxp3OqO89lsiJQKmRHKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH0PR11MB7562.namprd11.prod.outlook.com (2603:10b6:510:287::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 13:11:11 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 13:11:11 +0000
Message-ID: <cdcd6b97-1138-4cd7-854f-b3faa1f475f8@intel.com>
Date:   Tue, 24 Oct 2023 15:11:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/3] i40e: Add other helpers to
 check version of running firmware and AQ API
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     <intel-wired-lan@lists.osuosl.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20231023162928.245583-1-ivecera@redhat.com>
 <20231023162928.245583-3-ivecera@redhat.com>
 <2aba9a2d-9dfd-49f2-bfec-1ff563a5f017@intel.com>
 <d71f2fa2-e5b7-4221-bbd0-86285b6c1c33@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <d71f2fa2-e5b7-4221-bbd0-86285b6c1c33@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::25) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH0PR11MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 731349e1-1e09-4689-edcc-08dbd492b1b2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RwRPAlEsNOrf2vBwxBv0KjiPhGADwdfo62mxh7u8AVTfJL+dkmFz6+H742iGFPBO2YzmOLmXCEdjizq+IHTZi7oP7AUsuFre8g+RSjNFHFKI6xkq2RhMKZPqhyFt4xL3IZdWgyvDoIa5T6S22/ols84vUV3ap7YO7Y/wlUJ/e5kWzQ9yyQhMu5Goe8cGJMWwhOhjKmjc2aaEIzsbEAiAcbU5SoGd0n26plI+AjtzOIwZvQI+0RW65IdYci3PKdvICseiSLwjNjolh06mFK5DsIpQlPaE3/4uU89/H1hKsgLkIAVVxEXqeqAidkdS1P8ZwtP3851SJzNrtuoEmTb2E8vkKPKeNVdDFW9Thv086b+5XkauOWHaeVN7LiY5oIvyK3YrpojqsrAP7ZMqQ2era07WvMfiIHmIB6oOvacPrk5bNrHgG0ha7KKG/8S+a96zAXf354EY4BIJxEc1g9civWa8t++m6AnQybmbunzpOh3TwHlZ0vQyWCfgWg7xbZIUKCDHL11nWzLSasHxn2iHJg2AYPbe/IumFowISRctEeFtaPsYLVPij4Ut42JlqKtBJK5pRYcr5JXf5PERipThef+dJgszgFT4C/do4QR2CHuTZzmTLJN7VVxVqjMZcmHq62OJJMzrUMVzAHBQYFuieg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(83380400001)(31686004)(44832011)(8936002)(4326008)(2906002)(2616005)(36756003)(26005)(41300700001)(478600001)(6486002)(53546011)(38100700002)(8676002)(31696002)(86362001)(82960400001)(54906003)(6512007)(66476007)(5660300002)(6666004)(6506007)(316002)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZEb2ZaSGNIbGZhVUNpMnJ3aC93ckthSHIxM2JBUDBLNnpHYklnb0EzUm90?=
 =?utf-8?B?aDZHcm1Tc1JwZ25WUEVUT1VlSzdyZE1nTkpUT3RXMldmY3JRK3ZUMnk3VjEx?=
 =?utf-8?B?VHdyUTdGOVAvdy9aQUtUY3FnanBJRHQ3YTNGU2pGdkh3dlhuaGhsQU9odTdx?=
 =?utf-8?B?NCthRzJXQ1BpM3FBVlBBWm03TmVtVmNMSmZ2d09wL1llNE9FaGF2bUlNTHRx?=
 =?utf-8?B?ejNQMGhEWHNuTGpab2pLa0JNSU1WcDFLVUtFNWVhbGN6NHBZWlU0WmVzNXhz?=
 =?utf-8?B?WEhXaUZMdDZsZ2FDUys1VnpROWYvT2Y0cGsyL1grd3pJYUx0ajNuSytOYS93?=
 =?utf-8?B?L1RBSmlZZThuY1NETWp4RXlvdk9VRFBsb25kZ21QWVgyR2ozY2hxdjY1TVVZ?=
 =?utf-8?B?R1VYVUdCT3o5cHp4NG8yb040UHRmUG4xNkdkNS9xcnRYSzNad1pNdTk0VERS?=
 =?utf-8?B?Q1pIUWh0Wm0vM0ZaZ0w3WDFrb01zRXp2L1ZxaWl2VGltZnM3b1hucmVIS0Zi?=
 =?utf-8?B?TGh1cXg4cVIrQnZLaDBwQzZhaVZsZXVrcitLdzlmZFBvOS9QaWVDWVp2S0NL?=
 =?utf-8?B?WjdTcmhPUkZYdm1qeitxNHNtSU12YUlUVkxka3R1emJJaDB1L1kwRElXcHBR?=
 =?utf-8?B?b29NaUg0VEtlMDQxQVVUODJjeFlQRTRsUEFRZkFBajZTeDNnMFVJdFNEZHF3?=
 =?utf-8?B?WWxmMm1YM1QxNldrQVFJTktYWFdZYU8wNTBDM1o5ZDhFa0Q0clVJUkR3SFpv?=
 =?utf-8?B?Zk43L3ljQkNkT2t0Y3NiTmZhL1RIN2FoTmErZVowNGhGQWlhSHZpMDN2T2FX?=
 =?utf-8?B?Z1lxUkUyekNGdjVidkp0a3ZsNGVjMlcxWHFPRk5SZS94QXcxenM5dGJtOHd6?=
 =?utf-8?B?NFZOalRyTE8rM1AyRTAvMzV6T2lWd0JkUlkwMGcrbEw1SDdNV2lOU0grcEdo?=
 =?utf-8?B?ZVh5NkF0MjJNZ1VPWVpTQkNEa0o0TzUvZnk1aWk2SE04dEdWOTlEWi8yS2RZ?=
 =?utf-8?B?RXE0YTZrQjN2eERlSFRHOFplTDd3TE9SdkN1c3ZocGFFeExRM1RlaCtUYXFu?=
 =?utf-8?B?a3hBSzNWeGFiamk1c0U5VWlDZ2hzUlZYdnN6TFhIelhNV3JQYzNCaHh4QUZu?=
 =?utf-8?B?bUdlNEhhOFZVMm4yczloTENhWldKUXNjZFVBWWhtM0N1aEFVM0lrMC9VeXpl?=
 =?utf-8?B?Tmtid1JMdzM2VjdpenppMXRKNjkvVngreHk0NjFxM0FjNnVsbU5zbSsrT29r?=
 =?utf-8?B?L3BFQStsMi9xckkxVkpNSnBoSEZ6d1hOTFp4QjRTbjNpWVFPYjh4eFFiSnJm?=
 =?utf-8?B?dlpqZWVIckNZWUw1Q0pva3hrUU94K05Fd1ZDNXlOQ0NWUEkrUTFrWG1iUWJj?=
 =?utf-8?B?QVZnQ3ZHOUxOQW10WlZFcFZ1Y2VPdnpaZHFFcVRnTnJobWZERkh3VnVpK0tJ?=
 =?utf-8?B?bEJQdGxBWW9Idkw0TnpJSTJaOUdPY3czUDZPT002OUNsUmhZT1AvUFNXR1Rt?=
 =?utf-8?B?emhyRlRjTHFiQXA2Nm5ENzBaREw5SzlzQW5oVko2L0xoeS9YUU9VVVN5R1cz?=
 =?utf-8?B?aTFSRHJ3WUJpcytpUWErdnRIbDRCeUNYR013RzYvcUNFVzM2TkY5eCsrSXoy?=
 =?utf-8?B?K1FXQVJqZUd6aHpzemhueFYyd0xsY1BzYXF1S3hGQVpaM2RyRVE1RjVRUmha?=
 =?utf-8?B?YXdJY2ptODFVNGxTUk0ySkxnMVBNcG1vU0xOcnlSbm9iMDRxdktoK2dTZ1BT?=
 =?utf-8?B?T1BLYVh2cmxER3dtMFpHbm1RMU1KeFpieXNIamt5c3QrSXliM2JyWHp5cDlu?=
 =?utf-8?B?RDI4bjlEbWlnQURtUkN0R3pkTXVXMElTZmFMWUxFOGFnSExsYU5jQ2lCbi80?=
 =?utf-8?B?MklwMHA4d0JxQUxEdU54RHpiTTNURlBESFIrWVpQd2RKMVlnMkMrM3l4b0g2?=
 =?utf-8?B?cnQ0aVZKc21yYU5QdU1FUG1ySGJiNWxkZWlwMkVKa1ZuYzd5YWtxZTBTNFZQ?=
 =?utf-8?B?OWFLWUZqMTlmUXdRNlZLWnVHRlNGb1pHcmFPWlc3Y2NnM2dHRmI0cWVWSGFL?=
 =?utf-8?B?NXo2R3kvQk5WY1JNeTdDbEN0bkF3M1Bvc3pCRWUxNWU3ZmRMTFNwVDBGYTl3?=
 =?utf-8?B?Qzk1SnllR0w2T05OS1VIUmNubG1OQXUrM2dQUlk3MWtoVmNPUUZrcVJ6a0Zi?=
 =?utf-8?B?cWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 731349e1-1e09-4689-edcc-08dbd492b1b2
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 13:11:11.7375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIs85IcYeCkvXp5ATfK1r23Dw+Kw911M9wEHY9BqoLhV7eAqIsCPQ5E2s92yR5gLUPnkPpCbVUSgxBzK1IB6SVfJoG4PDIAYD23pL+FMzJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7562
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.10.2023 15:01, Ivan Vecera wrote:
> 
> 
> On 24. 10. 23 12:24, Wojciech Drewek wrote:
>> On 23.10.2023 18:29, Ivan Vecera wrote:
>>> Add another helper functions that will be used by subsequent
>>> patch to refactor existing open-coded checks whether the version
>>> of running firmware and AdminQ API is recent enough to provide
>>> certain capabilities.
>>>
>>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>>> ---
>>>   drivers/net/ethernet/intel/i40e/i40e_type.h | 54 +++++++++++++++++++++
>>>   1 file changed, 54 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
>>> index 050d479aeed3..bb62c14aa3d4 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e_type.h
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
>>> @@ -608,6 +608,60 @@ static inline bool i40e_is_aq_api_ver_ge(struct i40e_hw *hw, u16 maj, u16 min)
>>>           (hw->aq.api_maj_ver == maj && hw->aq.api_min_ver >= min));
>>>   }
>>>   +/**
>>> + * i40e_is_aq_api_ver_lt
>>> + * @hw: pointer to i40e_hw structure
>>> + * @maj: API major value to compare
>>> + * @min: API minor value to compare
>>> + *
>>> + * Assert whether current HW API version is less than provided.
>>> + **/
>>> +static inline bool i40e_is_aq_api_ver_lt(struct i40e_hw *hw, u16 maj, u16 min)
>>> +{
>>> +    return !i40e_is_aq_api_ver_ge(hw, maj, min);
>>> +}
>> It feels a bit off to have those helpers in i40e_type.h.
>> We don't have i40e_common.h though so I'd move them to i40e_prototype.h or i40e.h.
>> Same comment regarding 1st patch (I know I gave it my tag but I spotted the issue
>> while reading the 2nd patch).
> 
> I'm sorry I already submitted v2 and helpers are present i40e_type.h.
> I would submit v3 but there is also i40e_is_vf() inline function already present in i40e_type. Would you be OK with a follow-up that would move all these inlines into i40e_prototype.h?

Sounds good

> 
> Btw i40e.h is not a good idea as this would bring a dependency on i40e.h into i40e_adminq.c, i40e_common.c and i40e_dcb.c.

Got it

> 
> Regards,
> Ivan
> 
> 
