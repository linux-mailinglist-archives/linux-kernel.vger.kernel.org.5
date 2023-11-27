Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BBF7F9D9B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjK0Kdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbjK0KdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:33:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A3410F;
        Mon, 27 Nov 2023 02:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701081210; x=1732617210;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hDyB3lKO0AlbP36eEmVTI2W17eAgM9sOxY9iAkcuNk8=;
  b=kK1Y7YEyDINWhGAClAohfK4WrZewJSfcqV2P/j041pacvOemfT+8YGdu
   hkVzgSa1I7L/Y9IvhmRUoUCTzi61KjtJ7qIfxtpybdfKlGEH13X7pd6TJ
   Eug6oWYgiBvBNCY6MptjnwDlZ1zkrpR+JBAIoVrn3CveKVoFWGe/u2BH9
   6uJZBqL2N8tjiE2KjLNMFtSi6+8wrZ0Eji1cuiid/BZWeYhLGhZYDG2OQ
   wKy8aDnS92Ewa//0BjLLAe83t0DSsAD2m6BiW22KMBvgHOgooeLjf9fPe
   CFRKwh7jiY0jaqNipFG0IOvJVmc2ygNXSA7DcbLdyWKIWrkbpMItGDwP9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="372836757"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="372836757"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 02:33:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="771882371"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="771882371"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 02:33:30 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 02:33:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 02:33:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 02:33:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 02:33:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEGjwmXHGsWfPLbtc0iEe0yF3AKcvmBedA4y8vsCZbHx5eUs0vkyoVxft2RlGkyMwwp+kC7K8uYTkccda1IFWarZZwVaceJF3xCASWY3lLID4ae/6v6VUwIB/rX6L2M+Pk/4d1xL1E+2j0Nq5YWFxyTc4lY9V7AnPoEbhykgbOJGzvseKMce/RJfYC09am8tIxofhviVf1jq/MJMH1W2Y9kpI0lnbgOT0BgEiaXhhOHZ+mFxxfY7NXQ5yslqkbtGNMoVVhIkOIpG0LavZ/LBuX7OzTJoqTCwgu7ADuf0/BkqNvImtMFY0fKPbEbuTJziyS4G6q0+G4D2sbbCHAoM8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bi/JuR5foWYnX1rA7rXtvvummW5LpfIhW6vRc/t8xpQ=;
 b=bB5rb1Z1RyYRU1PHOt7rR27CTRY3bo+lam2qE+MgXMUeSBjDBS6RM2YdMuAwUN/Rpb9pEsGzQuHYuig6z3SyMg+tv7HMgeIkKkqQte0Hx5Mby0y/fMEOcHoO3S4qcqDNsVaIQyNJiMyknDa5dzfLIqSWs4bwUAleSpOfqjlYhy8Ivxbm6zLlJ9H07dG/Fo8SV25U+oaTmDt6wAXsCUd22h76m7blREEVgCu55a/TsBFuJEUyKSHQf4BH1TQDzRHphSTlSJvQctdlzamyHTVoL+Y0tEJU5Z50gGEYHf4Gz3x8itor+sPCtbmZoOCR+xvaaKPdJDmak46Oe6xejxeBHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 10:33:27 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 10:33:27 +0000
Message-ID: <d1e672e3-c306-40e1-a8bd-0468b3ea4856@intel.com>
Date:   Mon, 27 Nov 2023 11:33:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] i40e: Fix kernel crash during macvlan offloading
 setup
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20231124164233.86691-1-ivecera@redhat.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231124164233.86691-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::17) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW4PR11MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 63b8865a-2a29-4836-ddb7-08dbef3449c4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R8ZjazWCiVxBPPH1KBkNeMGoxXH9YHKHK0/QG7qrW5QinFXHzCha5NLlFlHCLskkBSfGC1LtPduR+vO2Bp8q+dk+pC2oi4QQsXec18EY+vLIsQvmW6aX0P+jmkW+69a7IR++Hc12/f6YEl6JM4EY40SRdujvag8ufgdaGQo6SK/YJQ6XLMjT0z+cusa6lon6IuD2zh8GvQ99D+IaiZii9xk1oqoNPDkUp5BS9fquKdGN2BMo1ZKGIOd/hS8y3F6+/pezpMlyn99pffXlxNTxG/USgL7kLmgC+HJc7SZ2N/CCOzqQpw2ItjbO8QzgzMAJh/7LApdCjBgLwDNumJKyFyn09GQnzhQfOOkLV3hc2qf3qb+r9ay02MhvdGN4ghwJ9B6bOwQbkwX2SgrAldac5yJrWNAVz5FeeD0mfq2IySMdzpbuEWNix3r5utmyRbVsBfEVFt53zcYJjs+lzeATW6rIJnipFcKxgRKVvs/4CkATj2wj9hJ5UZti/w/uMKCgQ2tlH2Qz1J5DjcaL1fxZRjTGZ6ok99Tz/ZVeG7ZSAjX8ekACPTJD4UBJkgAc0x4ynfdzGzYiUxl3DhVS7SCWm4znZCnEhFEaZhHcncGHIFNDvyBDek2otbdChMLYDzW4AbDCGK9nWvQYw//wnKWOgg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(44832011)(4326008)(5660300002)(41300700001)(31686004)(26005)(8936002)(8676002)(2906002)(478600001)(6666004)(6506007)(6512007)(53546011)(2616005)(38100700002)(83380400001)(316002)(54906003)(66476007)(66556008)(66946007)(6486002)(82960400001)(86362001)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlBqam80d2FHemJoN0JCRy94aXA3T2lWZmk4MzZBZDFIYzhVNHl6K1ZKSWtL?=
 =?utf-8?B?R0tYaFRyRzdKQmJGbWNEYnd6d2pYcWh1d2psQWlaZzVUc0JCdDQrdkZvTE1x?=
 =?utf-8?B?dEtWaDRDclFMMGxpeFpHSEV4cm1uRjN5RUp1S0IxMWFVZUpwdHlMOGdtZXlO?=
 =?utf-8?B?UzBSSzVyU3R6S253bDZmVUVwRS9Ua3ltNVNzRFFadGcwdERUN2ZwNGF1SGRJ?=
 =?utf-8?B?aUlXbEtyVEVRd1FEUlZPNUkxVVN6WVlhSjF5NER2b1F2QnJXdnRGRWd3cGsw?=
 =?utf-8?B?OFFHUWE0N1Vqc2ZaYXhyMzR4UmljMSsxdVVMcWFaSlVpZ0tjOXBSUGF5V3cw?=
 =?utf-8?B?R3d3ZlZZcGNWZUxXWlZQcnAzTGxPbjcvQkIveC9RbWlNSFpTSjUvNlJpbHBU?=
 =?utf-8?B?QlRPTmNGUkxBVVNnay9lQzNsL21KVlZoQmw4OXdoRWE3WG5BWko4TFV2M2lp?=
 =?utf-8?B?MUh5Ny81ZUNaaUlQNDNKR2dCVkRicUFWTnlvS3ZDMXVnV3dEb1JReEdCMi8w?=
 =?utf-8?B?RldES1NadjdqVXVBOXJTNEd3NHhmd3NQTGo3T1JqSXRrWkprM3dOTFp5M2cw?=
 =?utf-8?B?Uk9TaFJ1ZWFBdGlRK0ZXOEQ3cmRkcXRLeTZQSU1QRFhMNDk1MmpGSmpGUmVD?=
 =?utf-8?B?eHFrTEVmMmlFTTB0c0VZbGJGZnBUamFvQmF6Ryt1Sk91R0JVV2tkMVJJL21M?=
 =?utf-8?B?YVEyLzFZa1MxTFVPcmg4T0c0NHhGK0kzSFVHZGNuWkM5S3RDYWo0TzNGbHA0?=
 =?utf-8?B?UFlnN3RlZDl0djFZdE5Fb1JONDh2ekQ0anFIVllFL1pMRjYxOFFVTXRhU2RU?=
 =?utf-8?B?THVUZmU5KzU0ajNyNCsvbG1WWnJpSTlxMGZ4eHJDd0ozVnVMMndFd1ZBWlpn?=
 =?utf-8?B?anl0MWo1V0pmUDNqK3NGSTBRczNhUi9qM3F2VHpHbnloRzJEMzczN1FZQWwr?=
 =?utf-8?B?VG1nN3ZnVkZzY0ZRYnlmTVJwV3NPdmhsM2lCUlBrVFFKTDZRTStrTkttSFgx?=
 =?utf-8?B?a0lKM2hMTHpGNUlvMUFqeG81OGRqbm42amlPa0FEYzhkT1J3N2E0bWcyVTlM?=
 =?utf-8?B?N1phcmF3OWs5Z3dhQy9QZjlhdUg2M3RFa2tLc01TT0ZoMEZZYmNySnV5NXVU?=
 =?utf-8?B?dHlRNDEvenJaUlliSHBVYyt4amhHVGxZNTRCL2ZoellZVmNFUUFPY2Nwbk1t?=
 =?utf-8?B?cUJqdTg3MG1wZ2MvcHhIK0hsWTVlaGhaK2txVFovOUJ4V2xaZDg5Y3p1aUhP?=
 =?utf-8?B?eWMzUGhXOEpXaW1PV1ZrVDVPMUJNdTdPM1lZVmx4TlpCSHphK1ZmK0N6RjlZ?=
 =?utf-8?B?Tk5YcHMwWUlWL0pmd3NYNDFMM2g2Mzc0Q2V2eTZoZXdUODNkS3FCN1pFMmJD?=
 =?utf-8?B?Q1dianJjVzM3U0RlQ3lsTnVweTlZWVBGVGxQMjZsZXR6bmVIUGk4YityWWRE?=
 =?utf-8?B?VGZGb3JMQkZmSE9qSkhxU2tDQkJVemFzVU96M05BR2VuOW56cGJZNmVJRll1?=
 =?utf-8?B?L1J0UlMxcS9ZRjVCeFRxZlk2T3VTMVNjSFlwb0VBUStLRkRwT1dKc3JqbzRv?=
 =?utf-8?B?Y1QvbmFYRExmYmtPaEc3TlFMT3UyakNnVk9XYzZMdS9ybmM0Zy91Mmg5c2pX?=
 =?utf-8?B?SCtENmY3cndWR3djajNHSVJnQjUvZGJNQU55bVFtNGlSSjFIRFF3eE5sR1Zh?=
 =?utf-8?B?a1kwTjBBK200U0Zzdnd4STdPZDFrNmREd1BMdHJjZUpwYnc1NWhQOFUwREww?=
 =?utf-8?B?cTZZSURaMnNvMmVaS2xVTmJIakdiejVMS09PN1hBUjRwZlB6a3cwdC9RZUtX?=
 =?utf-8?B?TWV5MDhpb3FmS004emRhNWRoUHBYa1o4TENJNVpHMk83LzdYanl1QVFwUEF0?=
 =?utf-8?B?bVVObVRNb09QUEw2SzJVMkNFY1VXUmdsSDBMeVZNb2dMWisvSncvcGJhWGw5?=
 =?utf-8?B?T0dMQklWVjRFelR4M2djVk52cXRuaXgwL0MyUWx2S2h0bFl3a2VoRzdIRndi?=
 =?utf-8?B?WDc4dmg2Mk00bjk3ZEp3aE80OG1KMmg2RGJzdFhCTTBNa3BybCsxTUozaUFO?=
 =?utf-8?B?dVpUNXliaVlvME9EQlQwWHk5S2FjdUF2NkRGTXJPVlljYTZSRHUwUm9HeVJ6?=
 =?utf-8?B?R0UwSXpzc0xoUjllZXRsOVhROEI5RlIzNjVEYVpjR0JpNTBPSkIvMnVVMUtK?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 63b8865a-2a29-4836-ddb7-08dbef3449c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 10:33:27.1486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnxFz7WNmvhtKk+eMPnSu5GrexPGz4cB0VAY9v1YECXw3mG02BCsCTfRsEWjDe6PBczrGDez12xuPvWOcuUjA6aM/tutTEG914otVcFAKes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6738
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24.11.2023 17:42, Ivan Vecera wrote:
> Function i40e_fwd_add() computes num of created channels and
> num of queues per channel according value of pf->num_lan_msix.
> 
> This is wrong because the channels are used for subordinated net
> devices that reuse existing queues from parent net device and
> number of existing queue pairs (pf->num_queue_pairs) should be
> used instead.
> 
> E.g.:
> Let's have (pf->num_lan_msix == 32)... Then we reduce number of
> combined queues by ethtool to 8 (so pf->num_queue_pairs == 8).
> i40e_fwd_add() called by macvlan then computes number of macvlans
> channels to be 16 and queues per channel 1 and calls
> i40e_setup_macvlans(). This computes new number of queue pairs
> for PF as:
> 
> num_qps = vsi->num_queue_pairs - (macvlan_cnt * qcnt);
> 
> This is evaluated in this case as:
> num_qps = (8 - 16 * 1) = (u16)-8 = 0xFFF8
> 
> ...and this number is stored vsi->next_base_queue that is used
> during channel creation. This leads to kernel crash.
> 
> Fix this bug by computing the number of offloaded macvlan devices
> and no. their queues according the current number of queues instead
> of maximal one.
> 
> Reproducer:
> 1) Enable l2-fwd-offload
> 2) Reduce number of queues
> 3) Create macvlan device
> 4) Make it up
> 
> Result:
> [root@cnb-03 ~]# ethtool -K enp2s0f0np0 l2-fwd-offload on
> [root@cnb-03 ~]# ethtool -l enp2s0f0np0 | grep Combined
> Combined:       32
> Combined:       32
> [root@cnb-03 ~]# ethtool -L enp2s0f0np0 combined 8
> [root@cnb-03 ~]# ip link add link enp2s0f0np0 mac0 type macvlan mode bridge
> [root@cnb-03 ~]# ip link set mac0 up
> ...
> [ 1225.686698] i40e 0000:02:00.0: User requested queue count/HW max RSS count:  8/32
> [ 1242.399103] BUG: kernel NULL pointer dereference, address: 0000000000000118
> [ 1242.406064] #PF: supervisor write access in kernel mode
> [ 1242.411288] #PF: error_code(0x0002) - not-present page
> [ 1242.416417] PGD 0 P4D 0
> [ 1242.418950] Oops: 0002 [#1] PREEMPT SMP NOPTI
> [ 1242.423308] CPU: 26 PID: 2253 Comm: ip Kdump: loaded Not tainted 6.7.0-rc1+ #20
> [ 1242.430607] Hardware name: Abacus electric, s.r.o. - servis@abacus.cz Super Server/H12SSW-iN, BIOS 2.4 04/13/2022
> [ 1242.440850] RIP: 0010:i40e_channel_config_tx_ring.constprop.0+0xd9/0x180 [i40e]
> [ 1242.448165] Code: 48 89 b3 80 00 00 00 48 89 bb 88 00 00 00 74 3c 31 c9 0f b7 53 16 49 8b b4 24 f0 0c 00 00 01 ca 83 c1 01 0f b7 d2 48 8b 34 d6 <48> 89 9e 18 01 00 00 49 8b b4 24 e8 0c 00 00 48 8b 14 d6 48 89 9a
> [ 1242.466902] RSP: 0018:ffffa4d52cd2f610 EFLAGS: 00010202
> [ 1242.472121] RAX: 0000000000000000 RBX: ffff9390a4ba2e40 RCX: 0000000000000001
> [ 1242.479244] RDX: 000000000000fff8 RSI: 0000000000000000 RDI: ffffffffffffffff
> [ 1242.486370] RBP: ffffa4d52cd2f650 R08: 0000000000000020 R09: 0000000000000000
> [ 1242.493494] R10: 0000000000000000 R11: 0000000100000001 R12: ffff9390b861a000
> [ 1242.500626] R13: 00000000000000a0 R14: 0000000000000010 R15: ffff9390b861a000
> [ 1242.507751] FS:  00007efda536b740(0000) GS:ffff939f4ec80000(0000) knlGS:0000000000000000
> [ 1242.515826] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1242.521564] CR2: 0000000000000118 CR3: 000000010bd48002 CR4: 0000000000770ef0
> [ 1242.528699] PKRU: 55555554
> [ 1242.531400] Call Trace:
> [ 1242.533846]  <TASK>
> [ 1242.535943]  ? __die+0x20/0x70
> [ 1242.539004]  ? page_fault_oops+0x76/0x170
> [ 1242.543018]  ? exc_page_fault+0x65/0x150
> [ 1242.546942]  ? asm_exc_page_fault+0x22/0x30
> [ 1242.551131]  ? i40e_channel_config_tx_ring.constprop.0+0xd9/0x180 [i40e]
> [ 1242.557847]  i40e_setup_channel.part.0+0x5f/0x130 [i40e]
> [ 1242.563167]  i40e_setup_macvlans.constprop.0+0x256/0x420 [i40e]
> [ 1242.569099]  i40e_fwd_add+0xbf/0x270 [i40e]
> [ 1242.573300]  macvlan_open+0x16f/0x200 [macvlan]
> [ 1242.577831]  __dev_open+0xe7/0x1b0
> [ 1242.581236]  __dev_change_flags+0x1db/0x250
> ...
> 
> Fixes: 1d8d80b4e4ff ("i40e: Add macvlan support on i40e")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/intel/i40e/i40e_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index c36535145a41..7bb1f64833eb 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -7981,8 +7981,8 @@ static void *i40e_fwd_add(struct net_device *netdev, struct net_device *vdev)
>  		netdev_info(netdev, "Macvlans are not supported when HW TC offload is on\n");
>  		return ERR_PTR(-EINVAL);
>  	}
> -	if (pf->num_lan_msix < I40E_MIN_MACVLAN_VECTORS) {
> -		netdev_info(netdev, "Not enough vectors available to support macvlans\n");
> +	if (vsi->num_queue_pairs < I40E_MIN_MACVLAN_VECTORS) {
> +		netdev_info(netdev, "Not enough queues to support macvlans\n");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> @@ -8000,7 +8000,7 @@ static void *i40e_fwd_add(struct net_device *netdev, struct net_device *vdev)
>  		 * reserve 3/4th of max vectors, then half, then quarter and
>  		 * calculate Qs per macvlan as you go
>  		 */
> -		vectors = pf->num_lan_msix;
> +		vectors = vsi->num_queue_pairs;
>  		if (vectors <= I40E_MAX_MACVLANS && vectors > 64) {
>  			/* allocate 4 Qs per macvlan and 32 Qs to the PF*/
>  			q_per_macvlan = 4;
