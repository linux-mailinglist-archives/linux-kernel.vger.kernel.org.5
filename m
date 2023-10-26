Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3857D7FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjJZJru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZJrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:47:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED0810A;
        Thu, 26 Oct 2023 02:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698313665; x=1729849665;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ENyEpaNuiRYBrG1K+VzxxlcXE2kaVE1CqBOTt9v4AMw=;
  b=eaJkd30EAnk8k27phAOsunOQ1Halprc7Hv+9gHf68R6kygLRJ7iAogft
   FHgOlYt/6RDKRWT2PIuoHHVqPMEYzl5ZVQtwD5YcJ86NmRHQQ/J8j4Rav
   O54vHIbDRwosS8g9zgcWPVNRW1MNTcAiLjbgYtu+mUx5b7Bc9Ua0+ylgN
   YKqkbjm1yEZW0sRnAXTT+YtB1mYkuBhEBzamn+Phk9D7Aaz6tdw25pCXg
   ef5slCwNgPGlOFP+02f/bKiLkKejC3HFLO7fg0miHgUYmzc5yeBxM8kQY
   ZX2u6sHEeDlZBtwel4PI5tHvoY3K2lF41HFK1GWiZnnWUhOIzLrb+m7qN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="451739953"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="451739953"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:47:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="829558303"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="829558303"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 02:47:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:47:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 02:47:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 02:47:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeRA7FkbPYSnu3ztApJK8ZHdlKobcXvy+yDH+H4w+ApboPchFU78vcFDaBOMgSRiZkoCBrS01vV1TyJD41VY4YqbUrufY+d1GZp5Ye3saBjiLqjkNGhxvAPFvS5e4hPLaR90YNloFon2BuMBORVWWTWFYA+ABVEx9WMALZ25gHpsuTEjSt3rJqJ9UVdfLSSGeLxzvw3lKaWvkgRg159+KAW/3UElbwf0fdU7z0IK8GkqKMJqK3gVzTVuv0iXAB+TTHJ8+ZWCBxNxXtx+RmMGaLP10NO4u2F5UlR1oNBMyUISu7L7YxQry02gh5DPFeYRHqXNv3OkLfjau0puF0fsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmhVwN5h+zHuaC6i4n//s1KUl2OyO6wa8zw52Hq9rzU=;
 b=kNF0pT4Vq0iz6PB2VuHHxFjDOpoBaBID8ykGRxFaZ0i60ilqwpZ+ftVUdtD+JhWTP8mx7Oq4B2Xn7fW369eiVV/3oZIBricVh/BSI9JktNc199OwfZNhiaOCOU8rvwnfyz5FdDKIhyxqHljriCXKLEx6LPfE/CzAXd3zcCmCuetC3qdBXRmdI5m0BSSSK82TL6EDWDxdGrTTUffopGPB+nT/d4b2h3Su5LolUb506u3KghZnpUYcr8sk6kdQa9GPP1C3xT2oUd4njvLKbImZ0j5dZ6x7Cuw1YlfppwIONlpUNyZCr7UdZzxUf5tEi4T8duL98WLXtgXN14Kmw4Jeew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 09:47:40 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 09:47:40 +0000
Message-ID: <8ae4a3b1-288c-4739-8a75-f0fb275c00ae@intel.com>
Date:   Thu, 26 Oct 2023 11:47:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] iavf: Remove queue tracking fields from
 iavf_adminq_ring
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>
References: <20231026083932.2623631-1-ivecera@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231026083932.2623631-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::19) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA0PR11MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: 067d7974-3544-45d8-e47a-08dbd6089816
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4Tfl+7ZdFRUDDud/L8kuTcD6bSYDDxBPlcgTvknSRE53DR9QvaiAybl3k+yYEPaplboIaFUUqDvW7jgZP3yNro5TgCZVadvpmLb1CyovHxwK4hw8cn0kxF2MMyKmgTs1o64Wg2DVoR+N3w1hEO0+VjQdQqA4r2WqJjB+TTnyDYlE/KutUkMAc/IgFPU5vKBeBzuyFL46MnAmprinL7cOLIM1jSfoeobzR+8qY9tFOFaoRGyHwJbht4h3WXbAcuH4SJVF42FaeeK/dbyeWtta8r+EuRwU5FZSfCC6XqKSHFvcLGOueLW0OL/tRK0xJva9fiwwh/ZOv8QOcQDFo2QEFzcvkPRw3OPUH8WkLBb1GS/Wq5VdiUetFrTLiaTGjppMlXTOl4Mb9ObV4V+IRLljyipaznEeHB/O5oLGpvGkRMytF7ObKmCLDMPHkgdZ1X1Qv7LvvqnwGkfiAapq6qLeoq8Ea2SOxGkP3QswYutcmT8Ewzg0GVq+91pDS7720hV64KCneG5WIawgGVVBqMWRs8pXcTEzuuyiEy1wuq2Zhv8/iZq4CY04qOmyRa/eRNsmDZPo0gWV7ZpTw8yC4B6IUgEVoEHYHUwL8M1T5ARVIFQKPo9elo/YKhG62gf0Vd+6SPFr2ggb4glNvCygL/T2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(31686004)(30864003)(5660300002)(41300700001)(44832011)(82960400001)(26005)(38100700002)(4326008)(8676002)(8936002)(83380400001)(107886003)(54906003)(2616005)(66556008)(66476007)(316002)(6666004)(36756003)(6512007)(66946007)(53546011)(6506007)(478600001)(31696002)(86362001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWE4SGoxMlY0K2VQcG9FV0Z1eGxQSG9jVHFCWkNHVUwzYVJScHY2V1lKOHZz?=
 =?utf-8?B?NHlTWVllYlZkcVhQQkh5ZkFiL2ZlT2dDYit1WW53a0VEYVZwZmRKTG9jUExY?=
 =?utf-8?B?MDNFeU9lZ1lyZzVJWU9VMHY4RWpWbXFBRzVlaUNWVDlFK0VodU1Mb0FkcWdS?=
 =?utf-8?B?R2tEMXZCNERZUFYxRzNyYkY5RjZaMXM4QlAyNkRmY3NoZ2F0RU5oYVkzUi8x?=
 =?utf-8?B?VFltQjcvVUVQZ0VFbXU2Zkp5ZGJncnhSZTMybXZ6OHF0ckM3bnQrV0Z3TnFD?=
 =?utf-8?B?aGxZQUNhNzFVamRnWU1kVVdWSXZLalBOdERtU0FnTzZyOEZaZmUzd1U4SkJO?=
 =?utf-8?B?Y1ZFSmhiWmwvbFlBUmJXMTRpSTV4NXNTRDZ5eXNCYS9wLzlmeVZjclEzRkJX?=
 =?utf-8?B?WVQza0V5UVVFcXJsYStSK0JVT2tFZlhQbGtBL0V5UWNrcUJVSjhyemszUjlh?=
 =?utf-8?B?S29UNnBibzlML2hLMXFudDU4NnNhRlMvMWRzTDVIVWZkS0pXN0NyMDRPMkpI?=
 =?utf-8?B?ZDh5RUJnV01oaXh0Y21Cd0FKa0E2OHNzL1kvaWx0UlVtaXlwU2RJNkk3QXlh?=
 =?utf-8?B?UGR0MEFuZkViSzExcmhlbG45WlJTRUFralpYSG9scVhoZVpGcVRZMWZZN2py?=
 =?utf-8?B?by9EMDhrNVMrbUtzYmFKZ2YwaTh2Wm9iZnJEOEw2OWlyQ1NCeVo3Sjgvb2lC?=
 =?utf-8?B?Z0Q0VjM4WTcxeEszbFpINVUrK1VGKzBLTVVOQTRrUkFtLzBSZmsyYk5GVlJz?=
 =?utf-8?B?dzZJUndRZVpSRkZ2UVIxdE1uc0psOW9RdGxwaWk2VHk1bUcxRGNrcCtjUnBY?=
 =?utf-8?B?c1JVQmRUbVpIWkpmZ08wSmdTTENCc0l6ZFZYU1hSNUl0a1pJazZZeE9sbHQ5?=
 =?utf-8?B?UkNtcXowcFc2L00xTloxa0NrZldEUTcyYlFwVGdwaURwLy9Samc2VFNEQ042?=
 =?utf-8?B?a3YzV2xmMVMwY2NFZXFpREtHWUJYOWpkd2ErRW9taDRXbnBseFovUlI0dEla?=
 =?utf-8?B?SEx3WEhua1kycnRycTF6VmxwSWFZTDlzR2dSdmJXeUdOVTZvMFdXVHRhT0N4?=
 =?utf-8?B?SGxYd3l6YnNUSHU1ZFgzbG51cmx5VUxnRWthRXZQT0YxVDhwUVRTV1p4cnlu?=
 =?utf-8?B?STFTeFdqd1BPQmhHWTZNVGVFdjV5RXZvM1Q4VEhMVzA0dXdrQWdLVFJtVzVS?=
 =?utf-8?B?N2MrL29VT0xLdTZxQXZSQ1hPL3gwR3VGanJDcFdBOVN6Q1hLc05KRE5aNlkw?=
 =?utf-8?B?V2MrVjllK1dyOVFHUDRZNkVxUEx1MTVFd21aUzNKSzdwTmFzSDY3ZVNPdWdU?=
 =?utf-8?B?MzUxZTFLZ2Q5WmVPbWZJUEhPanBNSlAwVFpoQWV5cGVabVZlcEdRRjl4RVlH?=
 =?utf-8?B?YWxHUXRBemdtOGIvck41WURzd3ZOT2FXV3ljWGpPSG9xTUxlelhiRmdwVW9H?=
 =?utf-8?B?ME9jeGYrcW8wQVp4dnNrRk8yNUNlNW1KeHl5bDBvNTY5d0Iwbjd4TXNudFhw?=
 =?utf-8?B?UlNPSjFheGQzeHBYRWU3ZXpnOVdwSTQ0bGpHWlA3dHZYeGpkTkJPaUkvTWpG?=
 =?utf-8?B?cldzSW95RnVCVERTVEJVbGNoRTl5L3ZtMkxnRDI1UDdKUHdBUHp2MlNhdVhv?=
 =?utf-8?B?NlduNFZ1bHlmdExmZW1tYWRaYlR1enh3TXRDMDJESDdXK2FoY1dMMWY3dTdq?=
 =?utf-8?B?dy9TWGVaeEVqU3BCWUtVQ0RUdGkxREtvL0hkQkhQaTdmOWVtV1RTOXd6c3Y0?=
 =?utf-8?B?TUpNSGd3VlpGY3kyTExTM1lCM01MWjA1MGVqRzlXQXpsMTVrT0V3eVlBcmVO?=
 =?utf-8?B?QW43WmJuaUphSjVuU1NCaXRnUzdrN0tyYVNjSzRBeHRzM0F3QWYrRFNxYi9k?=
 =?utf-8?B?ODYyd3Nqc0x4NWE5OXgwYlB0clNpUG9KeVRabWdFMkFlK01OQVhQa3ZiSFBu?=
 =?utf-8?B?MVF1cVM2aW5zaXFJUG96S1J2eThhQW5oYWc3QU5FNE84UU1xVFcvNWJhL1k1?=
 =?utf-8?B?b1hIMHJlY2wwM2g2OGVLdSt5bU9LbGNUWWIrSm1qcXd4OWZVdW5yejllRnFY?=
 =?utf-8?B?ZG9IRlg3UThDeE1PUTkzdTY1Mm1TVFhBMUgzRzY2ODEzQW1nQ1dCelZLb1E5?=
 =?utf-8?B?Z1hucUEwdWdXbktwbXQ1b3JsdEtjM1p2TzdFdW5hc09oOTFyVU9MUTJ1RlBF?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 067d7974-3544-45d8-e47a-08dbd6089816
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:47:40.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU4iBq4T9+AW4+4AEZzdotjMCLqiGz8rEP17AbQ8L3u2FFa4Cxk77QZvgtddRAVhcGmYrxKSgOh5DmTjZ+9NodniQHyRjxC35MBTTzoFp8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.10.2023 10:39, Ivan Vecera wrote:
> Fields 'head', 'tail', 'len', 'bah' and 'bal' in iavf_adminq_ring
> are used to store register offsets. These offsets are initialized
> and remains constant so there is no need to store them in the
> iavf_adminq_ring structure.
> 
> Remove these fields from iavf_adminq_ring and use register offset
> constants instead. Remove iavf_adminq_init_regs() that originally
> stores these constants into these fields.
> 
> Finally improve iavf_check_asq_alive() that assumes that
> non-zero value of hw->aq.asq.len indicates fully initialized
> AdminQ send queue. Replace it by check for non-zero value
> of field hw->aq.asq.count that is non-zero when the sending
> queue is initialized and is zeroed during shutdown of
> the queue.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/intel/iavf/iavf_adminq.c | 86 +++++++------------
>  drivers/net/ethernet/intel/iavf/iavf_adminq.h |  7 --
>  drivers/net/ethernet/intel/iavf/iavf_common.c |  8 +-
>  drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 +-
>  4 files changed, 39 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
> index 9ffbd24d83cb..82fcd18ad660 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
> @@ -7,27 +7,6 @@
>  #include "iavf_adminq.h"
>  #include "iavf_prototype.h"
>  
> -/**
> - *  iavf_adminq_init_regs - Initialize AdminQ registers
> - *  @hw: pointer to the hardware structure
> - *
> - *  This assumes the alloc_asq and alloc_arq functions have already been called
> - **/
> -static void iavf_adminq_init_regs(struct iavf_hw *hw)
> -{
> -	/* set head and tail registers in our local struct */
> -	hw->aq.asq.tail = IAVF_VF_ATQT1;
> -	hw->aq.asq.head = IAVF_VF_ATQH1;
> -	hw->aq.asq.len  = IAVF_VF_ATQLEN1;
> -	hw->aq.asq.bal  = IAVF_VF_ATQBAL1;
> -	hw->aq.asq.bah  = IAVF_VF_ATQBAH1;
> -	hw->aq.arq.tail = IAVF_VF_ARQT1;
> -	hw->aq.arq.head = IAVF_VF_ARQH1;
> -	hw->aq.arq.len  = IAVF_VF_ARQLEN1;
> -	hw->aq.arq.bal  = IAVF_VF_ARQBAL1;
> -	hw->aq.arq.bah  = IAVF_VF_ARQBAH1;
> -}
> -
>  /**
>   *  iavf_alloc_adminq_asq_ring - Allocate Admin Queue send rings
>   *  @hw: pointer to the hardware structure
> @@ -259,17 +238,17 @@ static enum iavf_status iavf_config_asq_regs(struct iavf_hw *hw)
>  	u32 reg = 0;
>  
>  	/* Clear Head and Tail */
> -	wr32(hw, hw->aq.asq.head, 0);
> -	wr32(hw, hw->aq.asq.tail, 0);
> +	wr32(hw, IAVF_VF_ATQH1, 0);
> +	wr32(hw, IAVF_VF_ATQT1, 0);
>  
>  	/* set starting point */
> -	wr32(hw, hw->aq.asq.len, (hw->aq.num_asq_entries |
> +	wr32(hw, IAVF_VF_ATQLEN1, (hw->aq.num_asq_entries |
>  				  IAVF_VF_ATQLEN1_ATQENABLE_MASK));
> -	wr32(hw, hw->aq.asq.bal, lower_32_bits(hw->aq.asq.desc_buf.pa));
> -	wr32(hw, hw->aq.asq.bah, upper_32_bits(hw->aq.asq.desc_buf.pa));
> +	wr32(hw, IAVF_VF_ATQBAL1, lower_32_bits(hw->aq.asq.desc_buf.pa));
> +	wr32(hw, IAVF_VF_ATQBAH1, upper_32_bits(hw->aq.asq.desc_buf.pa));
>  
>  	/* Check one register to verify that config was applied */
> -	reg = rd32(hw, hw->aq.asq.bal);
> +	reg = rd32(hw, IAVF_VF_ATQBAL1);
>  	if (reg != lower_32_bits(hw->aq.asq.desc_buf.pa))
>  		ret_code = IAVF_ERR_ADMIN_QUEUE_ERROR;
>  
> @@ -288,20 +267,20 @@ static enum iavf_status iavf_config_arq_regs(struct iavf_hw *hw)
>  	u32 reg = 0;
>  
>  	/* Clear Head and Tail */
> -	wr32(hw, hw->aq.arq.head, 0);
> -	wr32(hw, hw->aq.arq.tail, 0);
> +	wr32(hw, IAVF_VF_ARQH1, 0);
> +	wr32(hw, IAVF_VF_ARQT1, 0);
>  
>  	/* set starting point */
> -	wr32(hw, hw->aq.arq.len, (hw->aq.num_arq_entries |
> +	wr32(hw, IAVF_VF_ARQLEN1, (hw->aq.num_arq_entries |
>  				  IAVF_VF_ARQLEN1_ARQENABLE_MASK));
> -	wr32(hw, hw->aq.arq.bal, lower_32_bits(hw->aq.arq.desc_buf.pa));
> -	wr32(hw, hw->aq.arq.bah, upper_32_bits(hw->aq.arq.desc_buf.pa));
> +	wr32(hw, IAVF_VF_ARQBAL1, lower_32_bits(hw->aq.arq.desc_buf.pa));
> +	wr32(hw, IAVF_VF_ARQBAH1, upper_32_bits(hw->aq.arq.desc_buf.pa));
>  
>  	/* Update tail in the HW to post pre-allocated buffers */
> -	wr32(hw, hw->aq.arq.tail, hw->aq.num_arq_entries - 1);
> +	wr32(hw, IAVF_VF_ARQT1, hw->aq.num_arq_entries - 1);
>  
>  	/* Check one register to verify that config was applied */
> -	reg = rd32(hw, hw->aq.arq.bal);
> +	reg = rd32(hw, IAVF_VF_ARQBAL1);
>  	if (reg != lower_32_bits(hw->aq.arq.desc_buf.pa))
>  		ret_code = IAVF_ERR_ADMIN_QUEUE_ERROR;
>  
> @@ -455,11 +434,11 @@ static enum iavf_status iavf_shutdown_asq(struct iavf_hw *hw)
>  	}
>  
>  	/* Stop firmware AdminQ processing */
> -	wr32(hw, hw->aq.asq.head, 0);
> -	wr32(hw, hw->aq.asq.tail, 0);
> -	wr32(hw, hw->aq.asq.len, 0);
> -	wr32(hw, hw->aq.asq.bal, 0);
> -	wr32(hw, hw->aq.asq.bah, 0);
> +	wr32(hw, IAVF_VF_ATQH1, 0);
> +	wr32(hw, IAVF_VF_ATQT1, 0);
> +	wr32(hw, IAVF_VF_ATQLEN1, 0);
> +	wr32(hw, IAVF_VF_ATQBAL1, 0);
> +	wr32(hw, IAVF_VF_ATQBAH1, 0);
>  
>  	hw->aq.asq.count = 0; /* to indicate uninitialized queue */
>  
> @@ -489,11 +468,11 @@ static enum iavf_status iavf_shutdown_arq(struct iavf_hw *hw)
>  	}
>  
>  	/* Stop firmware AdminQ processing */
> -	wr32(hw, hw->aq.arq.head, 0);
> -	wr32(hw, hw->aq.arq.tail, 0);
> -	wr32(hw, hw->aq.arq.len, 0);
> -	wr32(hw, hw->aq.arq.bal, 0);
> -	wr32(hw, hw->aq.arq.bah, 0);
> +	wr32(hw, IAVF_VF_ARQH1, 0);
> +	wr32(hw, IAVF_VF_ARQT1, 0);
> +	wr32(hw, IAVF_VF_ARQLEN1, 0);
> +	wr32(hw, IAVF_VF_ARQBAL1, 0);
> +	wr32(hw, IAVF_VF_ARQBAH1, 0);
>  
>  	hw->aq.arq.count = 0; /* to indicate uninitialized queue */
>  
> @@ -529,9 +508,6 @@ enum iavf_status iavf_init_adminq(struct iavf_hw *hw)
>  		goto init_adminq_exit;
>  	}
>  
> -	/* Set up register offsets */
> -	iavf_adminq_init_regs(hw);
> -
>  	/* setup ASQ command write back timeout */
>  	hw->aq.asq_cmd_timeout = IAVF_ASQ_CMD_TIMEOUT;
>  
> @@ -587,9 +563,9 @@ static u16 iavf_clean_asq(struct iavf_hw *hw)
>  
>  	desc = IAVF_ADMINQ_DESC(*asq, ntc);
>  	details = IAVF_ADMINQ_DETAILS(*asq, ntc);
> -	while (rd32(hw, hw->aq.asq.head) != ntc) {
> +	while (rd32(hw, IAVF_VF_ATQH1) != ntc) {
>  		iavf_debug(hw, IAVF_DEBUG_AQ_MESSAGE,
> -			   "ntc %d head %d.\n", ntc, rd32(hw, hw->aq.asq.head));
> +			   "ntc %d head %d.\n", ntc, rd32(hw, IAVF_VF_ATQH1));
>  
>  		if (details->callback) {
>  			IAVF_ADMINQ_CALLBACK cb_func =
> @@ -624,7 +600,7 @@ bool iavf_asq_done(struct iavf_hw *hw)
>  	/* AQ designers suggest use of head for better
>  	 * timing reliability than DD bit
>  	 */
> -	return rd32(hw, hw->aq.asq.head) == hw->aq.asq.next_to_use;
> +	return rd32(hw, IAVF_VF_ATQH1) == hw->aq.asq.next_to_use;
>  }
>  
>  /**
> @@ -663,7 +639,7 @@ enum iavf_status iavf_asq_send_command(struct iavf_hw *hw,
>  
>  	hw->aq.asq_last_status = IAVF_AQ_RC_OK;
>  
> -	val = rd32(hw, hw->aq.asq.head);
> +	val = rd32(hw, IAVF_VF_ATQH1);
>  	if (val >= hw->aq.num_asq_entries) {
>  		iavf_debug(hw, IAVF_DEBUG_AQ_MESSAGE,
>  			   "AQTX: head overrun at %d\n", val);
> @@ -755,7 +731,7 @@ enum iavf_status iavf_asq_send_command(struct iavf_hw *hw,
>  	if (hw->aq.asq.next_to_use == hw->aq.asq.count)
>  		hw->aq.asq.next_to_use = 0;
>  	if (!details->postpone)
> -		wr32(hw, hw->aq.asq.tail, hw->aq.asq.next_to_use);
> +		wr32(hw, IAVF_VF_ATQT1, hw->aq.asq.next_to_use);
>  
>  	/* if cmd_details are not defined or async flag is not set,
>  	 * we need to wait for desc write back
> @@ -810,7 +786,7 @@ enum iavf_status iavf_asq_send_command(struct iavf_hw *hw,
>  	/* update the error if time out occurred */
>  	if ((!cmd_completed) &&
>  	    (!details->async && !details->postpone)) {
> -		if (rd32(hw, hw->aq.asq.len) & IAVF_VF_ATQLEN1_ATQCRIT_MASK) {
> +		if (rd32(hw, IAVF_VF_ATQLEN1) & IAVF_VF_ATQLEN1_ATQCRIT_MASK) {
>  			iavf_debug(hw, IAVF_DEBUG_AQ_MESSAGE,
>  				   "AQTX: AQ Critical error.\n");
>  			status = IAVF_ERR_ADMIN_QUEUE_CRITICAL_ERROR;
> @@ -878,7 +854,7 @@ enum iavf_status iavf_clean_arq_element(struct iavf_hw *hw,
>  	}
>  
>  	/* set next_to_use to head */
> -	ntu = rd32(hw, hw->aq.arq.head) & IAVF_VF_ARQH1_ARQH_MASK;
> +	ntu = rd32(hw, IAVF_VF_ARQH1) & IAVF_VF_ARQH1_ARQH_MASK;
>  	if (ntu == ntc) {
>  		/* nothing to do - shouldn't need to update ring's values */
>  		ret_code = IAVF_ERR_ADMIN_QUEUE_NO_WORK;
> @@ -926,7 +902,7 @@ enum iavf_status iavf_clean_arq_element(struct iavf_hw *hw,
>  	desc->params.external.addr_low = cpu_to_le32(lower_32_bits(bi->pa));
>  
>  	/* set tail = the last cleaned desc index. */
> -	wr32(hw, hw->aq.arq.tail, ntc);
> +	wr32(hw, IAVF_VF_ARQT1, ntc);
>  	/* ntc is updated to tail + 1 */
>  	ntc++;
>  	if (ntc == hw->aq.num_arq_entries)
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> index 1f60518eb0e5..406506f64bdd 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> @@ -29,13 +29,6 @@ struct iavf_adminq_ring {
>  	/* used for interrupt processing */
>  	u16 next_to_use;
>  	u16 next_to_clean;
> -
> -	/* used for queue tracking */
> -	u32 head;
> -	u32 tail;
> -	u32 len;
> -	u32 bah;
> -	u32 bal;
>  };
>  
>  /* ASQ transaction details */
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
> index 8091e6feca01..89d2bce529ae 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_common.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
> @@ -279,11 +279,11 @@ void iavf_debug_aq(struct iavf_hw *hw, enum iavf_debug_mask mask, void *desc,
>   **/
>  bool iavf_check_asq_alive(struct iavf_hw *hw)
>  {
> -	if (hw->aq.asq.len)
> -		return !!(rd32(hw, hw->aq.asq.len) &
> -			  IAVF_VF_ATQLEN1_ATQENABLE_MASK);
> -	else
> +	/* Check if the queue is initialized */
> +	if (!hw->aq.asq.count)
>  		return false;
> +
> +	return !!(rd32(hw, IAVF_VF_ATQLEN1) & IAVF_VF_ATQLEN1_ATQENABLE_MASK);
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 6e27b7938b8a..146755498feb 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -3253,7 +3253,7 @@ static void iavf_adminq_task(struct work_struct *work)
>  		goto freedom;
>  
>  	/* check for error indications */
> -	val = rd32(hw, hw->aq.arq.len);
> +	val = rd32(hw, IAVF_VF_ARQLEN1);
>  	if (val == 0xdeadbeef || val == 0xffffffff) /* device in reset */
>  		goto freedom;
>  	oldval = val;
> @@ -3270,9 +3270,9 @@ static void iavf_adminq_task(struct work_struct *work)
>  		val &= ~IAVF_VF_ARQLEN1_ARQCRIT_MASK;
>  	}
>  	if (oldval != val)
> -		wr32(hw, hw->aq.arq.len, val);
> +		wr32(hw, IAVF_VF_ARQLEN1, val);
>  
> -	val = rd32(hw, hw->aq.asq.len);
> +	val = rd32(hw, IAVF_VF_ATQLEN1);
>  	oldval = val;
>  	if (val & IAVF_VF_ATQLEN1_ATQVFE_MASK) {
>  		dev_info(&adapter->pdev->dev, "ASQ VF Error detected\n");
> @@ -3287,7 +3287,7 @@ static void iavf_adminq_task(struct work_struct *work)
>  		val &= ~IAVF_VF_ATQLEN1_ATQCRIT_MASK;
>  	}
>  	if (oldval != val)
> -		wr32(hw, hw->aq.asq.len, val);
> +		wr32(hw, IAVF_VF_ATQLEN1, val);
>  
>  freedom:
>  	kfree(event.msg_buf);
