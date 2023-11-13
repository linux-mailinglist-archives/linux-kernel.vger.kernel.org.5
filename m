Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D837E9CBF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjKMNJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKMNJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:09:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063F3D7E;
        Mon, 13 Nov 2023 05:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699880983; x=1731416983;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BlHXTJHQjr7yLZEg5wJ+Ke6O/l4l+x0J+eP5dSxaXLA=;
  b=eIWZQcRIpzO0xYbd4UKgmTYPTbQ9r1wJjUHHDsB2biR93NsOAHVBe+E5
   POOGowOv32Ta0lpLJl7lMcXVACx8H5PV6Cr9CwMHTF7pOJEM3KaZMYHmA
   yI4bIh5UhpswHZtdS/NpFfqM7IVRH+OAGvXc4KSskGs4x9ByFXuU4Xg8h
   p54OtFr+mOhB40CORZVGaMiu7+WvIhXGDwQsDdbU3zww+p9+I3u79aWLf
   U9YOho2M7xApNaiQlL3SKpNEmRllRmn6S4+Pq8mWaNcaFeog3LxeIUDFi
   bAOo+Ilka7KxNcLCJz4qWPW1uoajBQaDoK9C0Tm6Z6yf9jtXrBTYChppQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="389296289"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="389296289"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 05:09:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="799186031"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="799186031"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2023 05:09:42 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 05:09:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 05:09:41 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 05:09:41 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 05:09:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HvQqxpTz8lwQHXN3V8bmDCjuLBrzYXlK0rad2mfXeIs6MAMsQS86gjOQ70au1twiabmzFU+BMTpy5eSqEXrmoAciJnHhKKvOlBLCvX7i1LshOTyGscr3SDWdwTt9BnWJgaDDRcOCaHp719McRLISayEs+bVDe64z5ZSTmcGu5wcx5FRmGa8nTxaHdknAfN8A0CHqwjAUQCKqeuKDPV5343u0o1vgXcyi6LigYtu61zSmx+LtKH5W2dKgC86O+HyNy1HyBIHelVDZNAiS8rl4Ys21eDgdLvujtDxTlE/bnb2wYvB1oSmJD4RuHMxLxYebMpfBHyNt/P7Wvk+A5nr/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VUfxWp55ijqd2gKWiPtcUQxyCqogorwsIijB7vclkdc=;
 b=VQ0s5lhUFY7TKpZsofdk9W24mFjUJCfZTKVYXBeOnPHSnHi3cMaxwkcWJf/1h1GflqPa8QB6ELGx4S/6sqaVFoyrsTHG6OYY+j8ai01YRGp1DZTFUwn8B7qxz2mQu3sLW4GCM+dsPVBfn8cmtNJIWTztAHyHniEFGs7sYcGqHkmcldHAC2dTWACdvm1pfI/3MhfWQYBEb22rq9cglWlv/EtLF5rVXzNDV4RjmVvRz8xS/ku+QzMXlZDsRuF/vjMgZin+WXvi5mCAD/CU2NMKSZEWoXB8PGLQFri1ypUrhwLjYB3i9yIRA8r+jFFUg9or7u8r4aZ4cMwSyWUjyXPeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH0PR11MB5000.namprd11.prod.outlook.com (2603:10b6:510:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 13:09:33 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 13:09:33 +0000
Message-ID: <2e6ecdf9-1608-4e51-a17c-8c136e14a9ba@intel.com>
Date:   Mon, 13 Nov 2023 14:09:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next 1/5] i40e: Use existing helper to find flow
 director VSI
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
 <20231113125856.346047-2-ivecera@redhat.com>
Content-Language: en-US
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231113125856.346047-2-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::18) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|PH0PR11MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8bc8d0-7190-4a3a-8311-08dbe449c708
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tb78H2F9gPgAgMzflgnvJcSmr3CGNcXDHPrS9DNC8NR1Fw4a0Q9qpFlwwPOwrTn1SMvtK1yEDlTp/m9PiDqrxeu7rYRGpS5KeDY13vYsUc6wVSQSGJSPQN3fhp4XDQ/lhDj2INrBjvIV5HLtG60WpvGWMg6Fw4DdUYqvsq5YuyNKhPqhvymRVhKHYdqTl9dDActDzXiO8S+8jIvoCQX49hu5FrQGzX62KMxC/WqDckLPyg9UOURT+uZsM+A9YcvUHSG5P8evj0mWUvpQN0E3etTcUrnGiQ78XRnTD2O8C+6H7nPBRsWnipOBsdI3A5G3Os/38GNQ9ltuQpArHSiJGZRrSmhb8wtt/1Om9ePindiX7EQv+o6gOCz4zC3gyt3AXVNi2NdZcNzn3uigdFYerGDC9Xi7oeJMjH1yJ5zAwQY2PCl3V4njOsU3Ijo3d12s+3DrLnnSzb1y2xR6npFKar+AFklxIl0ZmGxzz+oSdF+5JhhhFdt03cDH1fVxyUZkL1n5w+D2t7p9/LRo6vhdlUi0AU2h2SH+iCb7TmD5JCEsPzReoMhWHEyk7xFvz9kwqO4GhZivg9XtjDz2rCrSP/5Qcgio/oHJgqZnVd7oJpObsjLN2CnjpY5a6lK7T+WalQNANRBJaXH1XIVyftwAojVEJ5+sP77W91nmbPPrnWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8936002)(4326008)(8676002)(316002)(66946007)(66556008)(66476007)(54906003)(2906002)(41300700001)(44832011)(31696002)(86362001)(5660300002)(7416002)(83380400001)(2616005)(82960400001)(26005)(38100700002)(31686004)(478600001)(36756003)(6486002)(6666004)(6512007)(53546011)(6506007)(37363002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3pBcjRhWmdQa3VDdjF6UUhPRXkwQUVUMlRxUXFxcFhsZ1ZkZE9YZkpoU3JC?=
 =?utf-8?B?MmpBQnhGaENjRUFVd0s0dnVUNzliNjU2K3kxTlRnSDlJM2xKWUtpcWtGS1U1?=
 =?utf-8?B?ajMzUThvdVdaZER3dEZWN2F4dW44MjZzbDBTQnk4WDl1dnFKYUxTSG53aEoz?=
 =?utf-8?B?QlpYalBicGRublZwVE1KMFhYMVVqZ1U2S2pqWDd2dTJsdVN5c1lUWHErTWcy?=
 =?utf-8?B?OUY1ek1wSDJWKzRNaFFVYXlVS1FGeUNyZ2NKZzhIM2pmQzNMdHNsK3phOXYv?=
 =?utf-8?B?QVE2cmY5STY2dHZQT25rVHg5N09GSyszMVB0RUM5MDBBdm9BRzJodUdXVzhR?=
 =?utf-8?B?VWd3MytraGRvQVFwdTZqa210elJRb1NQY0tWd2h1MElLcEZPem02ckUyVWF2?=
 =?utf-8?B?ZU5SN2xOQTBWRHc4WXFtZS9wSmNZMzFCeXBmdjMwVWEvTkY4c1BxTEtKY3g3?=
 =?utf-8?B?a2M3L20yekx1VUFaNk56Ri9YSWc1elRBVHhpL25OKy9LZDcyRlpUekNWR3lI?=
 =?utf-8?B?WHg1dTBYNXNpdmhUMnNodTAwa3R2R1M0VzNmdllsNlNUenFSYkt2ZlRlNmFS?=
 =?utf-8?B?d1hmNGdQcStYN2NJNXBncU16L3Jzd3JXbnBaQlJ6NWZUZGYxK0xCSForVmts?=
 =?utf-8?B?U3hURVMzdDRmOXQ5WUNMVDVjYUdtL1ZkTURRRFZRbktQdkI5Y29MeEVFMVpz?=
 =?utf-8?B?R3kvcjZoWm9rck1FZFpkUG9HbndIUzZWTTFoa1R5dU40UlBCc295dklOZ3NC?=
 =?utf-8?B?UGhBeHpLbzZTcUIwaDFpc1pEQjdhWXl2QTJFZDk3ZUNlWXJ4UzgzNVRQM3lh?=
 =?utf-8?B?YnhZWk1DSkU1K3lkanZ2WEpVUldLOUxaSHlyS0oyVUttcVpnZEY0WERQRktP?=
 =?utf-8?B?dkIwY0t5d0JWclJvWThteWdXNk9pMCsvNFVreW84SzZzSWthL3RPK25jUDJW?=
 =?utf-8?B?UUgyeHZYNGJXcnJzTG1jbVZSU3IwOTZoQ050VXNjRFFoN0JpY3Z1aVZKeldl?=
 =?utf-8?B?Z1J0b2ZFV2ZONzI3TjhWWVhXRThsdm5WcTlmYTYzM3lqREpaKzhYcVZxOXVq?=
 =?utf-8?B?VVhSQWp0TzZ5N0x1dXZsc0FZOENDMVBiSitaUmJ4dGgyRFk4M1VsVWkwSjEx?=
 =?utf-8?B?Ky85T0RyVy83TEswOWNFQ25WTU9zK25QSlQwdlpKVDNiVG50YW90dVFUT092?=
 =?utf-8?B?UkgxZnpkUlVsQ0tXNDRXM0dkTm12bEpxZjRuallFN1BLQ1VBQTlqVnhKZ1Fn?=
 =?utf-8?B?Rko1Ni9GbkNrQWh0UWxZYlAxakRXc2g2YUFNcmFhYkhMaTJ1aFVUb29rQVRY?=
 =?utf-8?B?dGFQSGRGNW9hQm9iK24zSUFnR1ppQzFzSldDRTVMUSs0ZHRsQURVRS80eEdo?=
 =?utf-8?B?OEFkck02S280TDVadGY5Z21TMk80dGw3NDgxa2k5UVVVa2ZRbnV3NlZWTERM?=
 =?utf-8?B?Tm9vMWlpaEYyUGZ2ZTliTlVSTkQxdy9qTXlxcFQ2SG5BL29MKzVkMWxwcytr?=
 =?utf-8?B?bnErMmplRytna0JJaXFnaDRUSkZHem5QS3hWZy9IYzNMYlRXWkRLdXFrOXBq?=
 =?utf-8?B?TDJOUWl1UkpFZ2JUK0NYbE9sVExrbnBrMXhhRktCdkpNMitHMlpYemRqUXR4?=
 =?utf-8?B?VHBQTk1mcEE5ckkvbVdPV0p4YkNtZUxBTUdnalhjcko2endLczNEVFBvWGFW?=
 =?utf-8?B?MVpUWkxpYkxROTNvaUovYkpuOHBzOHRBaWhIZkNIY2tHR0NvazNmY0RPbmZQ?=
 =?utf-8?B?c0loenVySmJ4SUZ3QzVOMzd3Vk4xOHB0ajB2NVdPVVNjVWovbll2Q2V5NEwv?=
 =?utf-8?B?UWhleEtoTEZYM1FMcjVpb0cybm5MeVN3MTRpbnE4ekRsa2dpYlZFWDBKV3Jk?=
 =?utf-8?B?c1FGU2JURDZYMGtzWHhIMHlmMHErUEZyQUtVNXBGMGNMTjlzbHI4bEVvL3JS?=
 =?utf-8?B?cFppeGFEVTk4OHlwRjVwRlE4YStXUFE2V0NpOEg3TUQ0YjRrb3RlbUNYR0Vo?=
 =?utf-8?B?cU1oTE9EUVAvbTlxTWNMSlBWM1gzNU4xZ3dOOVRoTWw1NnhhTmdqeEJlN3N1?=
 =?utf-8?B?M0tmZVpneW1WTFB0cWdxZ2F0M0FZMTFLKythaThpR3RtR0dWNEE2cWRwNkwx?=
 =?utf-8?B?Y3JzUXRnQy9TNkN6K2FmUkNHL0Z6WGZtdzJvWkpUYXBIczdUTmFTSlh4OGRm?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8bc8d0-7190-4a3a-8311-08dbe449c708
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 13:09:32.9417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZqY6lKZXlh/sZLzO47ldX9Tf40gMmNMI4GZV+Ct1/ISN8WmFOTzcRGa8RTAehl0PyX+bR4T1ImLN36lwa6l6KAcoDUJnZD57XYOwNQ27fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5000
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.11.2023 13:58, Ivan Vecera wrote:
> Use existing i40e_find_vsi_by_type() to find a VSI
> associated with flow director.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Thanks Ivan, nice cleanup
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/intel/i40e/i40e_main.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 51ee870ffa36..90966878333c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -15645,6 +15645,7 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  #ifdef CONFIG_I40E_DCB
>  	enum i40e_get_fw_lldp_status_resp lldp_status;
>  #endif /* CONFIG_I40E_DCB */
> +	struct i40e_vsi *vsi;
>  	struct i40e_pf *pf;
>  	struct i40e_hw *hw;
>  	u16 wol_nvm_bits;
> @@ -15655,7 +15656,6 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  #endif /* CONFIG_I40E_DCB */
>  	int err;
>  	u32 val;
> -	u32 i;
>  
>  	err = pci_enable_device_mem(pdev);
>  	if (err)
> @@ -16005,12 +16005,9 @@ static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	INIT_LIST_HEAD(&pf->vsi[pf->lan_vsi]->ch_list);
>  
>  	/* if FDIR VSI was set up, start it now */
> -	for (i = 0; i < pf->num_alloc_vsi; i++) {
> -		if (pf->vsi[i] && pf->vsi[i]->type == I40E_VSI_FDIR) {
> -			i40e_vsi_open(pf->vsi[i]);
> -			break;
> -		}
> -	}
> +	vsi = i40e_find_vsi_by_type(pf, I40E_VSI_FDIR);
> +	if (vsi)
> +		i40e_vsi_open(vsi);
>  
>  	/* The driver only wants link up/down and module qualification
>  	 * reports from firmware.  Note the negative logic.
