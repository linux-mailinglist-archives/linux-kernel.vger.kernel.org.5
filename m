Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869E77D04E5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346646AbjJSWei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbjJSWeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:34:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867FFA;
        Thu, 19 Oct 2023 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697754874; x=1729290874;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=A0XFem5vMm4y02z4YMXpyVI5b9YO00nsiF2ixiblVQM=;
  b=MXXaYCpptezmChGFnGKvUgDm8+6jAkjZhjBVj2mIJEBOLiZ3K/GRx3Qt
   uW8uU9ql+1H16mZ5CpltHiGdIoY/G1bAs+14+pZgZys5geYjvrZL4nKa3
   rxAm3gVOsjPpMznTzMpj6nifyym6GEpMw0dAzecDmu1CuubFuZsTHFhvu
   qEOOfVb37QSlOH5QKxpv0QISvBAnk2gIYyaLqzNplKi4bZBWvDczDKbFx
   4uf9zcVCdKz6WBPLWtyt80BWiv2dhr6+aOOJa771aZsHII4G0JsG/rUSO
   XUBjo3mfO7ENxr4sJledVqH1vTZdF/iPKBGL0X6kFk8k16Gywi4b4Xq8W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="376762910"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="376762910"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 15:34:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="792176302"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="792176302"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 15:34:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 15:34:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 15:34:26 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 15:34:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUZUkPGtU9PGmfkXjG4I2zOCPIyWoVy01c42rwSdl6BtzcQEhMVdwBW1OEYvIFObWukPaZe8BJo+WQp355XuEeCNJig9zI099MHHQNoaw/dl6GDhorWT7AMr1Up3Kky9W9VLyETbjjTsfNY4subFaPmPWuz4zwlXLSqJS8ijzWo8hWLf4Gj6N2yDI48um61eJ0Sx12pN9FS/itoGNDHqbIDYSWLt3/3jflnZ5GEOPkh4KPooNafpfvJqPxOwAsF7dWWKbAEywWdiXPJdb26WFP5Sb6CWX+8FIRaMeQtWeLUT1Sk9h04aycYbj28GQFmqAjHfAnT0r9ifhpbNKEtLPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qpu+Adru4LRSDOljY1F5Lrv55zOEm++gfzoXJm5f9vc=;
 b=QKEslR8yqz5C8DsMECSotdGzNz7RNDqlzLm+YT0ziTo72kywBzPwxcSXY5oC8o87Wbt7SeTVpitkAj/91l7SFp2SdmZ+KbN7wMAgEXldAxTVimhiR1cG0L6+MdZwJevUl5+9tK/mT8Kb075/1X2RgtAZFjHYA13PQd5Pf2EScRM4QeNmLFD0mX+lDASAQ0m+8EfcicxP4SISyrlBN7/2JNeExzvpjxFIyw+OYm0rL8iFlb5yidBPRcMML+/99V3oDG5WEEnWWd0fpK/BBJAHzB0yvshwp0ddkParHFt9hDNMIor6TEOjkzWTS2tFyotOah54EetgOEr6GdJt/UDXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BN9PR11MB5356.namprd11.prod.outlook.com (2603:10b6:408:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 22:34:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::34a7:52c3:3b8b:75f4%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 22:34:17 +0000
Message-ID: <0a94de85-1e83-405b-bae8-559e0b64f9c1@intel.com>
Date:   Thu, 19 Oct 2023 15:34:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: Fix I40E_FLAG_VF_VLAN_PRUNING value
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>
CC:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        netdev <netdev@vger.kernel.org>,
        Mateusz Palczewski <mateusz.palczewski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231018112621.463893-1-ivecera@redhat.com>
 <4bedad2b-cdf6-471e-a8bd-51ba3564aa6a@intel.com>
 <b0bd5678-44cd-47ca-aeb5-33735100dbdb@intel.com>
 <CAAVpwAu9KmuHFOGXWd9b2hgxeXfs6_Dy7APuwZhHzqiE0hNFqA@mail.gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <CAAVpwAu9KmuHFOGXWd9b2hgxeXfs6_Dy7APuwZhHzqiE0hNFqA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BN9PR11MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ca049d-60b5-400a-d763-08dbd0f38751
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hH7YHm19tYMe4bOsqCa8XVEjCkfHsC5LVDd962yms0EokQaXY6Ivi6j0T+65E5YQhn/VpJuaw+9JlE3eXjLzgY3MCKnh5X55W0tJhf/gqCdQPOacgceAyj/5E/eLwLXBDVyAFd6NejC7xgOOQfFZ/8AgzRMmG5xovYByDKnsMHpWy3ieSkFexAVadn/vgti5uGGGoweUBEZpbvU8snd0Jg4+W+mJ9wUsxfHm9gQIYGxUwSpY8SLcvF1RlZJOxc34VAkBdXzjdxU32kasMJk7zQN4HYQS6woZ41CwRvD4R6kYSo89GUTQ4VaeoVcSwVviB4oz83tSzFJPGlP+oiHBZLVQHbFJ2RVq4LiytZDw53KfVcJy+GW9avy1E1V5fP4BxM09fWmVe9Ik/ZvghJV9eJbeKzF5Gxu+OgSXWirupenZeLb+h1MBJQ/tzicS/IGAOE8dVa1c7UXSqdme9h3pZcueheUEwsJqzYi59L2CnS4sHGK17zjkEx2ESxtku+oTeQbK+ZIpfjH3hOUHFE28bxqlaom8h79ayfvgcUfJddtARHKvVQMJmPnzrauguf0np5+O28M8dahN+TKmJeYEW9Bw6pS4ddRYBZlPwXNxhqdINGxQIolMoItSdEKczxWeIbO1qPeK0dauzxPulYAUnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(4326008)(66556008)(8936002)(66946007)(54906003)(66476007)(82960400001)(41300700001)(316002)(6916009)(8676002)(31696002)(86362001)(36756003)(6486002)(5660300002)(2906002)(66574015)(83380400001)(38100700002)(53546011)(6512007)(478600001)(2616005)(6506007)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZE16aHhKa0g0OWlqL2xuTFYyTmVsbUkxcEIvbnF4ZU12NG0wcmxqN24xMFpG?=
 =?utf-8?B?MC9UbytzT3VQU0dGTCtVaUMwSjFJTGRQYmY1dnVCWHl6OXkvRU5iNkhucmdC?=
 =?utf-8?B?VjJiOEg4SkRGeS9LWHVnUEt6WUtBNW40TTB1Y0YrVTkzRGY3Vm9hZE9aSWlS?=
 =?utf-8?B?Z09pbkZhNDh0YnZoK1VYWmVOckZtczI1QXI2U1VCZVpKSFM5Mm45MWlVTGNU?=
 =?utf-8?B?TDMzQVJwTzBqQ3puV1g1TGdyZ2wwcWRPb2hGLzBVcmhuZlBSTEErQzBRU2F1?=
 =?utf-8?B?bVA5blhFWUt0ZkVxSU5UTzB0bW9sMjAxU0NNNUVjN25ITnQxanlKUUtHNC82?=
 =?utf-8?B?bUlwbGxabzlXeGpmdW5vZGxPYUtGazIyMEJndnNrcnVOdytCb3FWTkgzZnIz?=
 =?utf-8?B?Qit3S1Y0SlNvN2cyRmJJQTJIcDl6LzlkaS9HVFR1MTRSVmVyc0cyS1dkWS9C?=
 =?utf-8?B?ejhyK3BNVHJsb1V4ck5XV3J3WGNUd2oxcDAxL3NIVnFaK29OQWFZc2o5TVNG?=
 =?utf-8?B?bzRiZTRFOEtiT3dqdWFXYVBZTXZrNDdQSE9kRjA4ZjlhRmtlS1dpQnJJb1c4?=
 =?utf-8?B?aGhqRXcrcHdZRjJmYkhydWp4UjVzU0FISmhRZnZxcEdoak5ENmZ3YTJvWW44?=
 =?utf-8?B?Ull6ZFZkbnBid2tzamhwTEhySU8zSmFmQWl6WFVNSjJwQmZ1czhNT1p1dlB4?=
 =?utf-8?B?K05VMGk5Nkp1RFZxUHlhYmMwN29TbFdac0ZaaXIxdjJURUFGdHFqSVcxU014?=
 =?utf-8?B?dndzaWJ0RCsrVDdlMzNNVkxQSC9lSURSR2k3NVhjZFhqL0p6YnlVaENwdTRO?=
 =?utf-8?B?MlNjZm9ZRk44UnJFYjhoem4zL3VZSzhCaUcvdmdpWnZ1Qm9SY0QzWU9vZ3Bt?=
 =?utf-8?B?aUlVOHZUWm9qNjlxYkx3L1BQV0gvaTJSVnVkVWVRUytxSHpiZHFDMGhQNlcw?=
 =?utf-8?B?Zy9JdmViTStWUzNqaGdNM0dmRjE5OWtZM2Y1VitPYlNKM2xkZ3lxQ0FOOEtN?=
 =?utf-8?B?K2ZUWjRDMDllUWdVaDZwbndjMVdwMmN0QWs2KytPVHZpVnFORHpWTEJPUVo2?=
 =?utf-8?B?U2piVXdkWjJLQXFDZDFVKzM4anYyQ20yYWE4ZFBxZUMvektoTHY1TjYwejV2?=
 =?utf-8?B?aXYxRW93aHhkeXBsWHNSM3V0ak5QV1BYZmdxNHNXcUdsY0Q3US94ckhuK2Q4?=
 =?utf-8?B?VXpKclVaZmZaLzU1V3RnWHIrcW5qc0xtTHEvVzhvSUlxVnQ0R2REM0p4a3Vp?=
 =?utf-8?B?ODNURHNqWnp5UWNXVGozaWFLd3E2UWZYbW5YdVFJV1pSOHRsdUFTZTF0emEy?=
 =?utf-8?B?TkIraEZvNGU0REp0VmVnWUs1Z283QXpOQjc2d0RBWHlzNVZiSkFRYTNaYkx6?=
 =?utf-8?B?ZDh3MU8yR0Y0Qm9vYlgxajBzM2Q1NGlRSEJXUDZIWEhHTnduaWVTRzJMVVJx?=
 =?utf-8?B?Y1E4MFV5NWx6T3Z6SldiaTU5NDEvTDFkc2g5TjlWK3Q4d25zd0ZMVUFCSGg5?=
 =?utf-8?B?cnNadi9FTDRkc0xDS2RMUnV3Q2hwVWl3eklOQjVOQUUvbEpVdThXSWRrN1hu?=
 =?utf-8?B?Ym9iaWZ1RHJhRldzTjlpc1Y4ZXlkdVpVRDE5OCt1cE15YVljOGpaL1FsajNi?=
 =?utf-8?B?cm5VWmNpcXpoY0ozL0ZDQTh2MzFLTHdSQ3UvS2RVeUlZcUVtWXVpZmkxSEp0?=
 =?utf-8?B?OTFXbmRnTDlDZktmUURSd0VoY1hpbDFDTmFxY0FoRHJuYkhISkk1TkJDUExu?=
 =?utf-8?B?azFwdE92STZ5ak9WeC9Ga2RiSnhnL3VYbUlRZElIUE5OTFQ2WldiK3k3RmhY?=
 =?utf-8?B?dm9aM2srVHRXUFZ0OE1UaDlYZ3Vmb2hQSlQ1SkxuaURiUElidXo5bzNBMkhD?=
 =?utf-8?B?V1o2czBJTGdJSWl4Ykt2TGdYWWkzckxEaVZ5c2hGNG9MSDQ0R2krckQrSkZC?=
 =?utf-8?B?enhja2JmWHBwMGZoWFdzbmVqQnJVR2l5bVRCaE1tRlllK2FtWmZCelVmMDQ4?=
 =?utf-8?B?WFdMck9aS0NlS095NlNVTTVBWDdBVWFsMXpYQkxUMWpTcTZyVEZjUnBaWmda?=
 =?utf-8?B?UitvclhzMjF0cmJkZTFjcHh5cjIxZ3ZtL0ZVbXBnVG85dDZ6NUtZM1dnazZ3?=
 =?utf-8?B?ZE5QV2VIMHlycHkzOXZ1YnNGSVhxUjUzVmtrRWt4ZGNrdkM4c0hzQWVsWXVj?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ca049d-60b5-400a-d763-08dbd0f38751
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 22:34:17.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJbg8+qI0vyADqAAI0QDArstRZ3aEeAPCcRvjyN0fv/J26gt8yFeS2Amjc8KPVBZvRT4S8ADcCQalpbkZnTcBiJpfkJDtO2EB/bAlURNag8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5356
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2023 12:48 PM, Ivan Vecera wrote:
> Dne čt 19. 10. 2023 21:24 uživatel Jacob Keller <jacob.e.keller@intel.com>
> napsal:
> 
>>
>>
>> On 10/18/2023 5:30 AM, Przemek Kitszel wrote:
>>> On 10/18/23 13:26, Ivan Vecera wrote:
>>>> Commit c87c938f62d8f1 ("i40e: Add VF VLAN pruning") added new
>>>> PF flag I40E_FLAG_VF_VLAN_PRUNING but its value collides with
>>>> existing I40E_FLAG_TOTAL_PORT_SHUTDOWN_ENABLED flag.
>>>>
>>>> Move the affected flag at the end of the flags and fix its value.
>>>>
>>>> Cc: Mateusz Palczewski <mateusz.palczewski@intel.com>
>>>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
>>>> ---
>>>>   drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/i40e/i40e.h
>> b/drivers/net/ethernet/intel/i40e/i40e.h
>>>> index 6e310a53946782..55bb0b5310d5b4 100644
>>>> --- a/drivers/net/ethernet/intel/i40e/i40e.h
>>>> +++ b/drivers/net/ethernet/intel/i40e/i40e.h
>>>> @@ -580,7 +580,6 @@ struct i40e_pf {
>>>>   #define I40E_FLAG_DISABLE_FW_LLDP          BIT(24)
>>>>   #define I40E_FLAG_RS_FEC                   BIT(25)
>>>>   #define I40E_FLAG_BASE_R_FEC                       BIT(26)
>>>> -#define I40E_FLAG_VF_VLAN_PRUNING           BIT(27)
>>>>   /* TOTAL_PORT_SHUTDOWN
>>>>    * Allows to physically disable the link on the NIC's port.
>>>>    * If enabled, (after link down request from the OS)
>>>> @@ -603,6 +602,7 @@ struct i40e_pf {
>>>
>>> such mistake happened only because list of flags is dispersed so much :/
>>
>> Better yet if we didn't hard-code the bits, and instead defined them via
>> an enumeration so that its not possible :D These aren't even ABI so
>> there's not a backwards compatibility risk either.
>>
>> Thanks,
>> Jake
>>
> 
> Hi Jake,
> I have been preparing another series for iwl-next that covers this
> conversion. I will submit it tomorrow or on the weekend.
> 
> Ivan
> 

Great, thanks!

-Jake

>>
> 
