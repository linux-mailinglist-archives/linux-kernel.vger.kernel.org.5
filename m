Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847CF7EE0C5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbjKPMhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345160AbjKPMhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:37:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD1DD;
        Thu, 16 Nov 2023 04:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700138248; x=1731674248;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fFBogTCyM70rwCUlyLHT9DRWuq/T0uQW+pogtaY4H74=;
  b=lzWdqfzRTLzOoJ3Nv1yf1OCHUEYfP91ppCtHXrryt5DamcjCWOWiOsf6
   IocUR1B2GEJSpjJaE1awdN3viStG9TddzGwcJe8+mIOfwcJtCTRwGTSxn
   4zjZZ7z8NB2qA3hom0RZ4hi5QUkGDKhIBX71LGu8g3kKgyjiliZHfs8qZ
   Y6KXNBeag/q/BJWgfKfAUg4K8r4zHknaSBU6kUcEa2rhHylbUj2Ze29JT
   Wk8r9FNl3GUDNgDK5tBT/eSnASpjz7/CdF+fyRnLz+TW8+SFTc3J17k5v
   OSW/+acHLvTrXllQn4M0LyZAyWW3jCJJTlS2UyHtt6G+eqXnqbQulDYdv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="370437464"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="370437464"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 04:37:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1096772843"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="1096772843"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 04:37:27 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 04:37:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 04:37:27 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 04:37:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxgQg7cgvEwnecyg7569ABan6xSijN9PSPQRxZt6r8Sqsbhp1mH2DTkwq1qxUrWiK+wWAp7YoeECkNLRlDkqoPRk2eJtWCeMvtPFQ/h8QkpW1OCO9wv68d8STJmBHFMJJtwOuoVdo5YdQFIoKFhtdR2k25X5ikI6jjviqbjgO4CFI8us7Y6j3X4LpUTUP7546GU4F7mzntW8zwSAPkuI0T5X/I896QGnyjpoDgURTqpqK+sihNoynrwz2LilWIhS03UYbY658zJwJL+7gEMlvBzkALg1hpR6ESDbbMJzYS2dX3BBHSpcuTQdzwW/Ti3F5kpn5UrtfNwJdFSr4IqYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX75N3m5w/aLHtlU5Hxw777ooOex88bFKYI0j/JoRHA=;
 b=m0JpIrm0wsqFi3mwm0MZmhQscUpezGfstrf758ksBMIow7RHZEveTvLO4DxQzxULFqmdA9+dWE/xo+QyPLVFDPSkNerZyxOPS1sygYl8Z2vrkBMNTM6VEBkeKEylRv93SMjvDUOx4NOonaf5ZFEsDYMVQru7asx91DCRF4i9qfrt7WreVxikjvmSPGDuDJCZ5vk3CZcb2SS6u8veMqZtbc5FjLKDmOBISEznW/lwMvW1TKszQOf0bWt/ywTRiobkkbuEtBDdnwxxcHc8aPKOP0lbxD89vFLBvPp1yKT2JcPKvPwxTQWfeTaIDsbN9VIfE7DS/ZA4r5er9ppNvHFo0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW4PR11MB6571.namprd11.prod.outlook.com (2603:10b6:303:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.21; Thu, 16 Nov
 2023 12:37:19 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 12:37:18 +0000
Message-ID: <72250942-17af-4f8d-b11f-ba902fbe2b58@intel.com>
Date:   Thu, 16 Nov 2023 13:37:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 3/5] i40e: Add helpers to find VSI and VEB by
 SEID and use them
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>, <mschmidt@redhat.com>
References: <20231113125856.346047-1-ivecera@redhat.com>
 <20231113125856.346047-4-ivecera@redhat.com>
 <3c640be7-8f1e-4f9e-8556-3aac92644dec@intel.com>
 <36889885-71c7-46f7-8c21-e5791986ad5a@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <36889885-71c7-46f7-8c21-e5791986ad5a@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0379.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::11) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW4PR11MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e51bd3-16e7-4da2-875e-08dbe6a0c589
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jKSFS/E5QFfKGkQMFJEWXbxRcux3J4dvySUYX/97pkhmN5lCl84DetdS2ugmdTa/+L/Irxp0ZFAZVi5UqQfCcKCVZaD8ihm/WbCf/kfwNpNo69NQ/B6oCrjk+BGIeZdzAfN5zYGy3AqbpQU6xwd8kQLsI8LLNhHR25pVohKD+6SSvhQzqRQM2IJOl7JbyVWXVhknDzKbij8ti/7d+U80xgmc2k2HzkSmX9EY89M8sgs/pKEmcRZ3hJKygk6xcHwoI2xi16q1xEsSNN64FAw3n9BNP5ujTXYGC2mN1UiXXpjSqi+Nf7Z18JMH25nozMS9M6uu3vxLPWIgV+ymNFC78Z00cT2P1HB1Bhq/XFttIaHuKmKkdj2R0VNskmSXP03J2+biz2cqONKYLW4UBbUPMeP1hOOzrrO/GAVmIFqttGRsBLh10/T8uvQnIMYcmCdEXEef5YD9Dh9HsTv7omUoU9MZNkK0nrck/5lenrMNp3fyDR8Lg9zq76NzJqsDam60JEA78DaNrHxZan7bddECrJS9Umk9D6vDJzx+mTT9OiPiH9Nr1yo3XsCmo8WQMoyZpWynqJULkWt45nwbgxFBbiJDEoigA7klsEV8E3J9XpVeMHEsDeLy1FsVctkztXBwbegebujNHjM9dIHSzmZTJV/KvhWlSYvIk0w9otDRSPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(54906003)(6512007)(36756003)(316002)(66946007)(66556008)(66476007)(26005)(2616005)(6486002)(478600001)(6506007)(53546011)(6666004)(31696002)(7416002)(5660300002)(86362001)(82960400001)(38100700002)(31686004)(2906002)(83380400001)(41300700001)(8676002)(8936002)(44832011)(4326008)(37363002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2hYbkdmVWVpenB3SkRhUlNqYjFrN3pVRWxsNXVTOWxPYlVrN0F2YTZpbVAx?=
 =?utf-8?B?K0t5MGpKbWg3VUdaK2EyY0t6dnJsVjVsSzJJQ1g0VHFBQ2F3cWlVUzRVV0pT?=
 =?utf-8?B?bjY1RTBHSDVndTBQMnE5YWJ4ZDZqY0JURGIrakpNTFZqY2lQL3drWDRRUFE0?=
 =?utf-8?B?ZTRVWldFSXVMbGI4V1BnSDFNUDYzVFFmbDJIK1J4U0ZiTXFuRkowWTkyUnY0?=
 =?utf-8?B?TTZic001WjU1NExrRFF3eWhNaVBGc1NJeVZQRUY5UXZKNnJpdVBPNDZoMEsw?=
 =?utf-8?B?WVdlN013eHdnQzFnUC9rM29kVEx3MWxvZk9JWTVQU0twYTg3VHVGa3hGeE0w?=
 =?utf-8?B?eHI4NTFSb0Z6ZkZJSVIrMEhmNU9yZFdja1czUFh5UVU0L0VJeWFsV0ZBR0Q4?=
 =?utf-8?B?ektEV0trQXM2bVREbTZVWnNKSTRqckU1MDJxbUozdDE4bWYzNURYazVOK3lR?=
 =?utf-8?B?RmVweXFMWS9pK01uS3AvdE8wNXRMRkJNZUpKVU9ad0VSaFhpMUlFM3hma1Ja?=
 =?utf-8?B?elZ1ZkR2UGREd0lrSG9KMWY4amZQNVBYV1l1WEUzZWhTVUZ5TGpHM0NBajR5?=
 =?utf-8?B?S1V1MFZrTkpESnNVODJUemprRjlCWTczcVRWOWZhRHhNSzROSVNxc3JxbFJV?=
 =?utf-8?B?NE9sdUlpVGEvczV0NUpra2hzZjV3UmZUbGtxT2VGZjJDUUxVNmxWMHVRUW5E?=
 =?utf-8?B?SHlLU2FjYkc1VTRiMXZiZGlyeDlEU3hBY0JQb3pVYysxS0IzeUQ4dDNiTHhJ?=
 =?utf-8?B?VGpaUzZ6TlBwYlpaM0srUGp1SFYvdFc0ay9XenJjdWlTbElKbVFxWm1xTmkv?=
 =?utf-8?B?a29DTnpOMFNoSDQ5UTdzQWpsWkk1OTlVUy8xK0hGbFB5c1pSZ3VnTHBiUUdy?=
 =?utf-8?B?dTJiQzVvQ09SOUVudnJUc1lIdjNrRitKQmRwWXY5OHVDWC90Y1Fpci96OVZB?=
 =?utf-8?B?MVU2K2xZbllHUU9pei9NMzFITHh6OW5xaVBQcEw3Q0JWYW1HNVg4Q3A0VFF0?=
 =?utf-8?B?OFEyUXN1aE40NHBxa3IvWnJyQk45ZWNINjh4ZW50U1VVRTI3Z3pRenlTdzlu?=
 =?utf-8?B?blpDeEhTL2gzR0RDV3lBLzJWMkdKdnErM1hZdGszYldDQ1BBSVZEdWZ6WFFD?=
 =?utf-8?B?VG8yRnE0ajBuNGxTbzRkRmZIWnhsYWViMzByWllHVmdSaHdKdjJlTG9EV0h6?=
 =?utf-8?B?TU1vbUhYWHJxd0F5c0xScVp0Q1ZoS2pXRXNwR1hFUmVBaUlXbDdUM2lSbUpL?=
 =?utf-8?B?eGdjV1FhYmw3VGJDcEtwS0JnTE1xYnloc1hMVFF4ZWh5SWUrTnhEdTRYS2FG?=
 =?utf-8?B?Y2lad3Jpb3VlU2R5N1hSZlU4NHZ2ejNMSyt4dnJERHJkV3AyYlBycmJYOHcx?=
 =?utf-8?B?YkFEM2pySWxRc0hCemhqQTdlN0NyN3Byd2RCWk80ajU1Mm1WYzlhME44dEI3?=
 =?utf-8?B?OFg4ajdFV2krcjd1SlRkbUdxdTlhNWJXSW1TSFRGdGE2QWdqVm5BcUE4a2JD?=
 =?utf-8?B?cGJKLzQrNVdPcURkeFJEVTlzWFRaNHJDdE43QTArcHZMZ1VvTCt1NFdGOEpU?=
 =?utf-8?B?eGowUkxoTXZ2a0FkM3BVcWJuN1B3Vms4dmNIMGJ2Wk4yY0lXajdYVGllUzQ5?=
 =?utf-8?B?czQ1bDRMcS9qSzNMamZwVEkvdEpBQnRJcVhIWWJDVnBxQVJaVUMyNDJuVE9r?=
 =?utf-8?B?cGJYQi91UmNtUFVuc3JLL25xeWJXMVh6MVgzWit4NWlBMkI4UGJsbUFhcXc0?=
 =?utf-8?B?TVdHWEtnOUIrU2wvTk90SVhKUFhFbmFYTVRtYjBTc1lqQzNtYnZhNTA3Ritw?=
 =?utf-8?B?SFp3d0I3Q0hXWGF5RG85eDJtMFIyV0UvVStSN0ZOWlNMcGtaRXMwL3M0MUxZ?=
 =?utf-8?B?K1hBVlkxai9WYjZIK0s4c2RkUjdsRlJRM3dNRTNUNzFqc1pOUnZlWEhieXJz?=
 =?utf-8?B?aEpSdHNJVUkzenV2Vmd0YitUaTR5OWQzVW5STEZ6R3EwQW1ZK0pJRi92eTVw?=
 =?utf-8?B?a3lodG9KR3lpMTkzdGVkaWFqY1ZrS1RDNm9DcU1Vbm1jcHZHTmpHWk13eHdR?=
 =?utf-8?B?UHZyWVJRK2RzcCs5Y1dLL0FBQnQvekl1NGRDU3QyYkxxemFMbm5oWlZxTHF0?=
 =?utf-8?B?LzJWR3ZHdGpmV2NWSUpId1Y3aWxoSThEZkZVRE5mMHJrcVZoS2lSb0lzL3Js?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e51bd3-16e7-4da2-875e-08dbe6a0c589
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 12:37:18.8882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BurzLGhDLg65QyP3u6PgSJp8N5YmVVRCPHYCIq2pZJizonYXWG3IgH6LuCrV2rLXEsKlCMIAMJnSpl/ewIg/cHPCOUx9BxKDXLvRXwHagM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6571
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.11.2023 18:01, Ivan Vecera wrote:
> 
> On 13. 11. 23 14:27, Wojciech Drewek wrote:
>>
>> On 13.11.2023 13:58, Ivan Vecera wrote:
>>> Add two helpers i40e_(veb|vsi)_get_by_seid() to find corresponding
>>> VEB or VSI by their SEID value and use these helpers to replace
>>> existing open-coded loops.
>>>
>>> Signed-off-by: Ivan Vecera<ivecera@redhat.com>
>>> ---
>> Only one nit
>> Reviewed-by: Wojciech Drewek<wojciech.drewek@intel.com>
>>
>>>   drivers/net/ethernet/intel/i40e/i40e.h        | 34 +++++++++
>>>   .../net/ethernet/intel/i40e/i40e_debugfs.c    | 38 ++--------
>>>   drivers/net/ethernet/intel/i40e/i40e_main.c   | 76 ++++++-------------
>>>   3 files changed, 64 insertions(+), 84 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
>>> index 1e9266de270b..220b5ce31519 100644
>>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>>> @@ -1360,4 +1360,38 @@ static inline struct i40e_pf *i40e_hw_to_pf(struct i40e_hw *hw)
>>>     struct device *i40e_hw_to_dev(struct i40e_hw *hw);
>>>   +/**
>>> + * i40e_vsi_get_by_seid - find VSI by SEID
>>> + * @pf: pointer to a PF
>>> + **/
>>> +static inline struct i40e_vsi *
>>> +i40e_vsi_get_by_seid(struct i40e_pf *pf, u16 seid)
>>> +{
>>> +    struct i40e_vsi *vsi;
>>> +    int i;
>>> +
>>> +    i40e_pf_for_each_vsi(pf, i, vsi)
>>> +        if (vsi->seid == seid)
>>> +            return vsi;
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +/**
>>> + * i40e_veb_get_by_seid - find VEB by SEID
>>> + * @pf: pointer to a PF
>>> + **/
>>> +static inline struct i40e_veb *
>>> +i40e_veb_get_by_seid(struct i40e_pf *pf, u16 seid)
>>> +{
>>> +    struct i40e_veb *veb;
>>> +    int i;
>>> +
>>> +    i40e_pf_for_each_veb(pf, i, veb)
>>> +        if (veb->seid == seid)
>>> +            return veb;
>>> +
>>> +    return NULL;
>>> +}
>> I would prefer i40e_get_{veb|vsi}_by_seid but it's my opinion.
> 
> I'd rather use i40e_pf_ prefix...
> 
> What about i40e_pf_get_vsi_by_seid() and i40e_pf_get_veb_by_seid() ?

Sounds good, my point was that I prefer to have "get" before "{veb|vsi}"

> 
> Ivan
> 
