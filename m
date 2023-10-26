Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9A77D7FFF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjJZJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjJZJum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:50:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EAD9D;
        Thu, 26 Oct 2023 02:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698313839; x=1729849839;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6dEOkJjrS/A5JphQkekqZnATQD/zANOXTraEJyvtCMQ=;
  b=MC9//nnliggK31MTaEAysveR0kuBn99gwF+TyW2IbXjBq5nygcqw1wAg
   LmBt4Qmi37fp4SV03wXmuAsZg37XO42CcM1z0Du1jZkgWib+9fttuAa25
   gmbl1aYvMXjoVtS8T+pnYmtJDT2DNEzwoSmlcJCo8x9juxEj8P1nWyMkC
   5+yr2tCSSjhgfA6DAQR4LpuyijGTwsVEIZu/7X0JbGcQ2Ga8DbcPo0c9O
   RIlDcUOpoLQfdb1S+UnwMkDJu1HTwYuNFT1atLeuJ7xEPFUVsEewmQaRU
   Vsnl6Db3hkSRUxN5ofOmkrqbzRoZRBbMoX4UmXteRBjTNvp7kqHj1NjI6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="453973758"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="453973758"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="875873626"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="875873626"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 02:50:38 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:50:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 02:50:37 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 02:50:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVYtixr3q6JRj52GFMVf2SQgRPFbTReB+dnxJAoypmOFg3PeXVcs1b6zcJm33hraV7w/gLZmS4TgK7oIuQBHVjiHlnSOpXsSC7D9DUQ/qmJuIWNn2e9/H2cN75pso2CgoPHuXNCCXdalhgILCAjlCXRc2ZjDHs+riGEWq10kXa/SqDXMlXbImQHVllxcnXoTfqs/dEpxo3Ia1SihGzmg/h7n17HL/bdNldAx6IDkhOfWACJ+7Un3jeTImAGltGXcKQQi/tD2wZ6Eq1c3D6RoPIdr+tcZRGHAYpcLSBKIAuA5Vdm86K//NeiJsG9N5CP3g8v/t9EavEDOXIMzjOlhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZFGnOfrAy65hcYtXj9jdF4mVOAcvT9KUCARTRjZkbM=;
 b=YNCAe007uVJI5dnV+M/b8az7vL6INYvffDeUg7ryjrQLL8dOot1nm+xWK4VzgR9PiTV2BtvgWFhsW7ZlN95vMuOQmd6TuLvmZveHZS7S0V/RKXkgOGcyd6W/f65JFOGmVC3Ue9q2e6OBj+YDG9Q1IDJxuOvEpZXWyRX13doZqJYKl80ysGoGqtM8uil/FDq/JF7FvBwcsXZL0QeYfWR6bzSds6Fi5LpC2pKvjHAyjVHwaa49tEutk64ZDhvJy3JD4Yoe3hneaY9BWSSgp8a+UhMDYm6iP7OoY9ybIqVEdVk6TLavwHxrHT88S9F2WOHAMVjJBJXzUG1GoyRqW+i45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA0PR11MB4670.namprd11.prod.outlook.com (2603:10b6:806:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 09:50:28 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::71a7:70c4:9046:9b8a%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 09:50:28 +0000
Message-ID: <37d9ee0e-fcb6-48d6-b1dc-a41110277fc0@intel.com>
Date:   Thu, 26 Oct 2023 11:50:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next] i40e: Remove queue tracking fields from
 i40e_adminq_ring
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
References: <20231026083852.2623216-1-ivecera@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231026083852.2623216-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0012.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::7)
 To MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA0PR11MB4670:EE_
X-MS-Office365-Filtering-Correlation-Id: 0287da71-7f22-4d64-3944-08dbd608fb80
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QgxmDOg5N1Ln3Jj/34Z8/Ht7KVVMD8ioyMnuC/DXi97UMpg6a0i1w9wQ0sEjp36wc5gJrLv8GU7nKdECLIfQVttB+KrSg/Fcdau2vJDedWOKULbOpBPzc0RnJRABCXWbzEZc/o+pnGkWUVeLWM7PG41o5DW4NrGCWW+GH1Yu5BibriZjKJeMCWCmn3u44kcnSsZU18C9N6p2VHMIXeZkIlhzzw8mS8vxi7nAUF28l9ACjchJolBsTsFEtTSNLTz+gizjFOk7JpGPs/qskdJv/BWazwDQ1SSeL6oonQyMXIOMBCRJ/y+Vdg4Y0ODESZ1CIkgDAayHY5pgnKzt4NHnO2wovQaH4Z2ReV8YIo8j1GXXE0EWr7C64U7FtQqWhRZLIsRxoi+3LiuwsGZVO54Ur05lNUsgFeU+y0ohfBYn20NhlV5aN71grqtPvgqfKTicKGbZ6O1rPIG/RQkzvip0qpoEUg8G5JAGfP0cC8A4A1dMQ6DBDC9HWf88RDy2JS4PuuJOHH8ZmXePQJDRLe8p2wg1NqKXx9fbVtJsazE67fFRneoOCDaaM2rlnYunATtwoUR6fiP0QcQdan3UnsX/RkFwC/UvwfqLtQwsv68C43Ynaykw52nrA4LTaPoZcmn5/LaK4EyZPIgfm1i6crs3Mg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(31686004)(30864003)(5660300002)(41300700001)(44832011)(82960400001)(26005)(38100700002)(4326008)(8676002)(8936002)(83380400001)(107886003)(54906003)(2616005)(66556008)(66476007)(316002)(6666004)(36756003)(6512007)(66946007)(53546011)(6506007)(478600001)(31696002)(86362001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkZwS0Jibk1Ob2V6ZGhXTVNoY2NQK1JsbUJPeFNHeUJudVpXMDl6YVJ1STd0?=
 =?utf-8?B?VmRHOXpRcEtTMEVHMVJVelhIdzREV0RITk1lNzRsUCtKaEV6ekFXV2tNTTAy?=
 =?utf-8?B?eUJtUm5vVmZhUXNWcFBaRVZHMjlBRzVXRGtHOUFlK3pocTVOSnU3TWpOYkpC?=
 =?utf-8?B?U3YwQiszbFRibXZrZnN1M0tudDdUZjVzK05VbTUrNEx3TFlsSWNZRkE2TnNH?=
 =?utf-8?B?VlhSV0JJQlRpc28rcC9aR1hiTk1rT1RpTVduZERra0wvaGZJTEswWmJ6bGVz?=
 =?utf-8?B?dm9QODZMUEd6bmJQUnVMREdDaTZEeHdqZDRPVVppMnhLK01FQnE3d3J6VEI1?=
 =?utf-8?B?VEkxTDI4VUVoS3ZNb0ZzdnBtN0xWSXJUSUhVZG1TU09yT05DRGlDUG5lZnhi?=
 =?utf-8?B?dWhoY01GTUhQV0NFdXBydDEreDFoUDVRcUNIS094UVZBdVJUb2E2TkhZVGQx?=
 =?utf-8?B?NzhjWVFzWmMwc3lNR0ovQWxiKzI2VlJ0U1pCYzFYVXRlWDBqc0kxeFpXZ2Zl?=
 =?utf-8?B?N1lmcWRJcHM1MjBIUVdWaGJtTGlVbkU0UmhPKyt1VllRRUJDMXFIRGV4dkI2?=
 =?utf-8?B?Q01tNjNvdTBPeS9oWitINE9QN25yOWhjUWJicEFKdnRUWTJhVFE0NTg4dG9E?=
 =?utf-8?B?Vjc1L21kaUVsalYxdDZVdldmY0xLT2dCWk9VY1gxM2E4c0NYZDZLbjJZTTZa?=
 =?utf-8?B?MVJLcEZIeVdhTG05WmxjZHUzRHFGTkNrYjZNTm0yTUJRU2JPRllCRHEzZEs2?=
 =?utf-8?B?MXg3YVh6WTRYWGdNcHo5WmxhcUlBajNQR3pBaE5FWWhlcjhMM0JBQ0owaTZ6?=
 =?utf-8?B?S1NLeUZsUlI2MDk5a0dUNlRaUmZzYnBuemtQbDMxVDAxV0FNRzVDcmkyWjgr?=
 =?utf-8?B?Nk9ZVHUwRVdJb2tJVmVRSHFCM0ZUMmdZa0pMOUVJV0xXazFPeHh6cGJYbzVU?=
 =?utf-8?B?LzlOWGxHRGlpY1Y5eUZ6TWV1N3BZQ28wT2U4S3A5MU9GR3dvS2IzNlVtUy8x?=
 =?utf-8?B?L2hzcENwTXpCWGlNczVRUXRCRDF0QVVmSWZzOEtHWSswS295M3RlWGVQWm5v?=
 =?utf-8?B?bDY1RU5RNEFQeXUwOWZmV2VlNGpGczQ5VlI0b2w5dUxPN05iVEJKakZITXEr?=
 =?utf-8?B?TDNZc1MveE1saUkvZFVpblRUcm93OERCemtJK2hPS0VURzB2aTNKcVh3TzZm?=
 =?utf-8?B?dUYvOVNYMThkZDUyUFMwWUljZU5hZENFR25SOXpOR1ZUd3VSbHAwU1EycEFL?=
 =?utf-8?B?aURRYXpWQ1duV1dyS0dCN2FFVXI3VU5HN0hvNlBVN1VleHM0anBkOFdjd0FS?=
 =?utf-8?B?d01HNFp4YTlaSksxQ0N3ZFdTaFp6ekVrU1l1ZkJPZFp6Mjh1bmdPNzRUYklw?=
 =?utf-8?B?TUZZYy9FY0xiek5RT1JDK3dURE9BMCtzYkhpVWEvcEtnSEVzcmtFNVF0K1l6?=
 =?utf-8?B?MHZvZDh4WGk3VldxakRMbTRtbHVoSEJhNkgwSkViTnFSN3JsOEdhM1dQaGN3?=
 =?utf-8?B?MWZKZDVjK3Q3KzBHdTNiaURxVWVGOEdFTzZIdEluNzNGbmErZDFtU0N2OUxk?=
 =?utf-8?B?c2ZEZ3pMbmF2M0xWNXFDZnJtTXdiSDBZNXVNalUwdCtQdzBmdzJDejBCdHBn?=
 =?utf-8?B?aVk1d2JhQmtGa1VvaTVkRjhUelM5Skg5UHlORFVFc2JZSG44YjBZNjZJK3c0?=
 =?utf-8?B?ZzYzNFdUZlVnZ2xmNXVqQWVPSGg1K3orQUpyVDRHcmVXRTJpekV4TXcyVk4z?=
 =?utf-8?B?cTJaK2taSlBMejNTSG56RXZ3ZFhBbzA2dEZ6VEFUYTd5blRUMzVRZVlKaVpL?=
 =?utf-8?B?a2JZdzdISHJJZmNEa01NL3o4QUtPL2FXNG8zVGNVUnJtK1Q5VXZUL2lFaEFM?=
 =?utf-8?B?TnkyU3FJN2tXQW50SUlqWnByYjBueVk1U1hhREM4M05YYTZjeE5OUnZFSVZU?=
 =?utf-8?B?UE9uemIza21SQ3VSMlU5RjhlL0w5RHU1NFlsQmIxbFlFTkZ3cDlpYzVPRS9Z?=
 =?utf-8?B?WkxLMlkvcm9Mdlo3dWVsaHcwa2xtWVJWTG0zVU04MEp5RVFqRVhkZXRqWW12?=
 =?utf-8?B?OGprZTdzVlBlUWsvOXN2aW5zZzVPTVZEeks0MDZZN0VmODJYSkhKYit1VHYy?=
 =?utf-8?B?b2JFUU5KRjBhSHFpdDVnbENwMzNaWVp3TElMT2ZUNXRWUlI4UGxkU0wrZk5z?=
 =?utf-8?B?RlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0287da71-7f22-4d64-3944-08dbd608fb80
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:50:27.9908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYAryivh2DjC6Pliv6DVd2tLq5TpmC+GqTJeFJO+T4lZF7XIhtFj7kFNPQ1G4kt4CLXvBd5KbOo24Q9qMAyvGv2O1O/Rm2/6p/5P2sOkLE0=
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



On 26.10.2023 10:38, Ivan Vecera wrote:
> Fields 'head', 'tail', 'len', 'bah' and 'bal' in i40e_adminq_ring
> are used to store register offsets. These offsets are initialized
> and remains constant so there is no need to store them in the
> i40e_adminq_ring structure.
> 
> Remove these fields from i40e_adminq_ring and use register offset
> constants instead. Remove i40e_adminq_init_regs() that originally
> stores these constants into these fields.
> 
> Finally improve i40e_check_asq_alive() that assumes that
> non-zero value of hw->aq.asq.len indicates fully initialized
> AdminQ send queue. Replace it by check for non-zero value
> of field hw->aq.asq.count that is non-zero when the sending
> queue is initialized and is zeroed during shutdown of
> the queue.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Hmmmm, I have deja vu XD
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 86 +++++++------------
>  drivers/net/ethernet/intel/i40e/i40e_adminq.h |  7 --
>  drivers/net/ethernet/intel/i40e/i40e_common.c |  8 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  8 +-
>  4 files changed, 39 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.c b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> index 896c43905309..f73f5930fc58 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.c
> @@ -8,27 +8,6 @@
>  
>  static void i40e_resume_aq(struct i40e_hw *hw);
>  
> -/**
> - *  i40e_adminq_init_regs - Initialize AdminQ registers
> - *  @hw: pointer to the hardware structure
> - *
> - *  This assumes the alloc_asq and alloc_arq functions have already been called
> - **/
> -static void i40e_adminq_init_regs(struct i40e_hw *hw)
> -{
> -	/* set head and tail registers in our local struct */
> -	hw->aq.asq.tail = I40E_PF_ATQT;
> -	hw->aq.asq.head = I40E_PF_ATQH;
> -	hw->aq.asq.len  = I40E_PF_ATQLEN;
> -	hw->aq.asq.bal  = I40E_PF_ATQBAL;
> -	hw->aq.asq.bah  = I40E_PF_ATQBAH;
> -	hw->aq.arq.tail = I40E_PF_ARQT;
> -	hw->aq.arq.head = I40E_PF_ARQH;
> -	hw->aq.arq.len  = I40E_PF_ARQLEN;
> -	hw->aq.arq.bal  = I40E_PF_ARQBAL;
> -	hw->aq.arq.bah  = I40E_PF_ARQBAH;
> -}
> -
>  /**
>   *  i40e_alloc_adminq_asq_ring - Allocate Admin Queue send rings
>   *  @hw: pointer to the hardware structure
> @@ -254,17 +233,17 @@ static int i40e_config_asq_regs(struct i40e_hw *hw)
>  	u32 reg = 0;
>  
>  	/* Clear Head and Tail */
> -	wr32(hw, hw->aq.asq.head, 0);
> -	wr32(hw, hw->aq.asq.tail, 0);
> +	wr32(hw, I40E_PF_ATQH, 0);
> +	wr32(hw, I40E_PF_ATQT, 0);
>  
>  	/* set starting point */
> -	wr32(hw, hw->aq.asq.len, (hw->aq.num_asq_entries |
> +	wr32(hw, I40E_PF_ATQLEN, (hw->aq.num_asq_entries |
>  				  I40E_PF_ATQLEN_ATQENABLE_MASK));
> -	wr32(hw, hw->aq.asq.bal, lower_32_bits(hw->aq.asq.desc_buf.pa));
> -	wr32(hw, hw->aq.asq.bah, upper_32_bits(hw->aq.asq.desc_buf.pa));
> +	wr32(hw, I40E_PF_ATQBAL, lower_32_bits(hw->aq.asq.desc_buf.pa));
> +	wr32(hw, I40E_PF_ATQBAH, upper_32_bits(hw->aq.asq.desc_buf.pa));
>  
>  	/* Check one register to verify that config was applied */
> -	reg = rd32(hw, hw->aq.asq.bal);
> +	reg = rd32(hw, I40E_PF_ATQBAL);
>  	if (reg != lower_32_bits(hw->aq.asq.desc_buf.pa))
>  		ret_code = -EIO;
>  
> @@ -283,20 +262,20 @@ static int i40e_config_arq_regs(struct i40e_hw *hw)
>  	u32 reg = 0;
>  
>  	/* Clear Head and Tail */
> -	wr32(hw, hw->aq.arq.head, 0);
> -	wr32(hw, hw->aq.arq.tail, 0);
> +	wr32(hw, I40E_PF_ARQH, 0);
> +	wr32(hw, I40E_PF_ARQT, 0);
>  
>  	/* set starting point */
> -	wr32(hw, hw->aq.arq.len, (hw->aq.num_arq_entries |
> +	wr32(hw, I40E_PF_ARQLEN, (hw->aq.num_arq_entries |
>  				  I40E_PF_ARQLEN_ARQENABLE_MASK));
> -	wr32(hw, hw->aq.arq.bal, lower_32_bits(hw->aq.arq.desc_buf.pa));
> -	wr32(hw, hw->aq.arq.bah, upper_32_bits(hw->aq.arq.desc_buf.pa));
> +	wr32(hw, I40E_PF_ARQBAL, lower_32_bits(hw->aq.arq.desc_buf.pa));
> +	wr32(hw, I40E_PF_ARQBAH, upper_32_bits(hw->aq.arq.desc_buf.pa));
>  
>  	/* Update tail in the HW to post pre-allocated buffers */
> -	wr32(hw, hw->aq.arq.tail, hw->aq.num_arq_entries - 1);
> +	wr32(hw, I40E_PF_ARQT, hw->aq.num_arq_entries - 1);
>  
>  	/* Check one register to verify that config was applied */
> -	reg = rd32(hw, hw->aq.arq.bal);
> +	reg = rd32(hw, I40E_PF_ARQBAL);
>  	if (reg != lower_32_bits(hw->aq.arq.desc_buf.pa))
>  		ret_code = -EIO;
>  
> @@ -439,11 +418,11 @@ static int i40e_shutdown_asq(struct i40e_hw *hw)
>  	}
>  
>  	/* Stop firmware AdminQ processing */
> -	wr32(hw, hw->aq.asq.head, 0);
> -	wr32(hw, hw->aq.asq.tail, 0);
> -	wr32(hw, hw->aq.asq.len, 0);
> -	wr32(hw, hw->aq.asq.bal, 0);
> -	wr32(hw, hw->aq.asq.bah, 0);
> +	wr32(hw, I40E_PF_ATQH, 0);
> +	wr32(hw, I40E_PF_ATQT, 0);
> +	wr32(hw, I40E_PF_ATQLEN, 0);
> +	wr32(hw, I40E_PF_ATQBAL, 0);
> +	wr32(hw, I40E_PF_ATQBAH, 0);
>  
>  	hw->aq.asq.count = 0; /* to indicate uninitialized queue */
>  
> @@ -473,11 +452,11 @@ static int i40e_shutdown_arq(struct i40e_hw *hw)
>  	}
>  
>  	/* Stop firmware AdminQ processing */
> -	wr32(hw, hw->aq.arq.head, 0);
> -	wr32(hw, hw->aq.arq.tail, 0);
> -	wr32(hw, hw->aq.arq.len, 0);
> -	wr32(hw, hw->aq.arq.bal, 0);
> -	wr32(hw, hw->aq.arq.bah, 0);
> +	wr32(hw, I40E_PF_ARQH, 0);
> +	wr32(hw, I40E_PF_ARQT, 0);
> +	wr32(hw, I40E_PF_ARQLEN, 0);
> +	wr32(hw, I40E_PF_ARQBAL, 0);
> +	wr32(hw, I40E_PF_ARQBAH, 0);
>  
>  	hw->aq.arq.count = 0; /* to indicate uninitialized queue */
>  
> @@ -608,9 +587,6 @@ int i40e_init_adminq(struct i40e_hw *hw)
>  		goto init_adminq_exit;
>  	}
>  
> -	/* Set up register offsets */
> -	i40e_adminq_init_regs(hw);
> -
>  	/* setup ASQ command write back timeout */
>  	hw->aq.asq_cmd_timeout = I40E_ASQ_CMD_TIMEOUT;
>  
> @@ -720,9 +696,9 @@ static u16 i40e_clean_asq(struct i40e_hw *hw)
>  
>  	desc = I40E_ADMINQ_DESC(*asq, ntc);
>  	details = I40E_ADMINQ_DETAILS(*asq, ntc);
> -	while (rd32(hw, hw->aq.asq.head) != ntc) {
> +	while (rd32(hw, I40E_PF_ATQH) != ntc) {
>  		i40e_debug(hw, I40E_DEBUG_AQ_COMMAND,
> -			   "ntc %d head %d.\n", ntc, rd32(hw, hw->aq.asq.head));
> +			   "ntc %d head %d.\n", ntc, rd32(hw, I40E_PF_ATQH));
>  
>  		if (details->callback) {
>  			I40E_ADMINQ_CALLBACK cb_func =
> @@ -756,7 +732,7 @@ static bool i40e_asq_done(struct i40e_hw *hw)
>  	/* AQ designers suggest use of head for better
>  	 * timing reliability than DD bit
>  	 */
> -	return rd32(hw, hw->aq.asq.head) == hw->aq.asq.next_to_use;
> +	return rd32(hw, I40E_PF_ATQH) == hw->aq.asq.next_to_use;
>  
>  }
>  
> @@ -797,7 +773,7 @@ i40e_asq_send_command_atomic_exec(struct i40e_hw *hw,
>  
>  	hw->aq.asq_last_status = I40E_AQ_RC_OK;
>  
> -	val = rd32(hw, hw->aq.asq.head);
> +	val = rd32(hw, I40E_PF_ATQH);
>  	if (val >= hw->aq.num_asq_entries) {
>  		i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
>  			   "AQTX: head overrun at %d\n", val);
> @@ -889,7 +865,7 @@ i40e_asq_send_command_atomic_exec(struct i40e_hw *hw,
>  	if (hw->aq.asq.next_to_use == hw->aq.asq.count)
>  		hw->aq.asq.next_to_use = 0;
>  	if (!details->postpone)
> -		wr32(hw, hw->aq.asq.tail, hw->aq.asq.next_to_use);
> +		wr32(hw, I40E_PF_ATQT, hw->aq.asq.next_to_use);
>  
>  	/* if cmd_details are not defined or async flag is not set,
>  	 * we need to wait for desc write back
> @@ -949,7 +925,7 @@ i40e_asq_send_command_atomic_exec(struct i40e_hw *hw,
>  	/* update the error if time out occurred */
>  	if ((!cmd_completed) &&
>  	    (!details->async && !details->postpone)) {
> -		if (rd32(hw, hw->aq.asq.len) & I40E_GL_ATQLEN_ATQCRIT_MASK) {
> +		if (rd32(hw, I40E_PF_ATQLEN) & I40E_GL_ATQLEN_ATQCRIT_MASK) {
>  			i40e_debug(hw, I40E_DEBUG_AQ_MESSAGE,
>  				   "AQTX: AQ Critical error.\n");
>  			status = -EIO;
> @@ -1103,7 +1079,7 @@ int i40e_clean_arq_element(struct i40e_hw *hw,
>  	}
>  
>  	/* set next_to_use to head */
> -	ntu = rd32(hw, hw->aq.arq.head) & I40E_PF_ARQH_ARQH_MASK;
> +	ntu = rd32(hw, I40E_PF_ARQH) & I40E_PF_ARQH_ARQH_MASK;
>  	if (ntu == ntc) {
>  		/* nothing to do - shouldn't need to update ring's values */
>  		ret_code = -EALREADY;
> @@ -1151,7 +1127,7 @@ int i40e_clean_arq_element(struct i40e_hw *hw,
>  	desc->params.external.addr_low = cpu_to_le32(lower_32_bits(bi->pa));
>  
>  	/* set tail = the last cleaned desc index. */
> -	wr32(hw, hw->aq.arq.tail, ntc);
> +	wr32(hw, I40E_PF_ARQT, ntc);
>  	/* ntc is updated to tail + 1 */
>  	ntc++;
>  	if (ntc == hw->aq.num_arq_entries)
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> index 80125bea80a2..ee86d2c53079 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
> @@ -29,13 +29,6 @@ struct i40e_adminq_ring {
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
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
> index e171f4814e21..bd52b73cf61f 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_common.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
> @@ -195,11 +195,11 @@ void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
>   **/
>  bool i40e_check_asq_alive(struct i40e_hw *hw)
>  {
> -	if (hw->aq.asq.len)
> -		return !!(rd32(hw, hw->aq.asq.len) &
> -			  I40E_PF_ATQLEN_ATQENABLE_MASK);
> -	else
> +	/* Check if the queue is initialized */
> +	if (!hw->aq.asq.count)
>  		return false;
> +
> +	return !!(rd32(hw, I40E_PF_ATQLEN) & I40E_PF_ATQLEN_ATQENABLE_MASK);
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 69dafdecb243..91563512b2bd 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -10141,7 +10141,7 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
>  		return;
>  
>  	/* check for error indications */
> -	val = rd32(&pf->hw, pf->hw.aq.arq.len);
> +	val = rd32(&pf->hw, I40E_PF_ARQLEN);
>  	i40e_trace(state_arq, pf, val);
>  	oldval = val;
>  	if (val & I40E_PF_ARQLEN_ARQVFE_MASK) {
> @@ -10161,9 +10161,9 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
>  		val &= ~I40E_PF_ARQLEN_ARQCRIT_MASK;
>  	}
>  	if (oldval != val)
> -		wr32(&pf->hw, pf->hw.aq.arq.len, val);
> +		wr32(&pf->hw, I40E_PF_ARQLEN, val);
>  
> -	val = rd32(&pf->hw, pf->hw.aq.asq.len);
> +	val = rd32(&pf->hw, I40E_PF_ATQLEN);
>  	i40e_trace(state_asq, pf, val);
>  	oldval = val;
>  	if (val & I40E_PF_ATQLEN_ATQVFE_MASK) {
> @@ -10182,7 +10182,7 @@ static void i40e_clean_adminq_subtask(struct i40e_pf *pf)
>  		val &= ~I40E_PF_ATQLEN_ATQCRIT_MASK;
>  	}
>  	if (oldval != val)
> -		wr32(&pf->hw, pf->hw.aq.asq.len, val);
> +		wr32(&pf->hw, I40E_PF_ATQLEN, val);
>  
>  	event.buf_len = I40E_MAX_AQ_BUF_SIZE;
>  	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
