Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4267E271B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjKFOhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjKFOhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:37:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352EBDF;
        Mon,  6 Nov 2023 06:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699281427; x=1730817427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hXEnWFIyT5EoA0M5O2ixfZ/w0Ca2+M4QNQhSKthhhjU=;
  b=Pb6t93drO+bUkAOo4mlOFK0HWaFjTfzIW41oMPnDTVZc1KB5argjzae2
   vXhuYGgjctLvgGZ2D1unBsQhlcDFBe8jerLuTwZCyXaT63Ue4xLcRgA6T
   PJEqsjIqZnwaqHENGkd8vaUKhcDOPIQkYsPVABXkJvIl3nxtN37mY0u3d
   EVNUOi/3+ke8vVt3R66wRjs3qITDPjFWHuSw40EM3sBcCIEEYV3KeJ0zK
   eOZTp5N/JTSEuGb0+EZS+QrKnvnT5kgx28T2CxFSGP2EZjAsw03bTS7BI
   1yF2Pzk00b4csVX9Vs1MxU+S5hdkGxmKGSxwi3Y/m8SAu9RlbpEAqhd3s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="374319523"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="374319523"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 06:24:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="10095359"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 06:24:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 06:24:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 06:24:26 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 06:24:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbH9xLgUYI8+ee+Biu1HfhwZAQ6mj1seO9OuIu+CE30OHyvwIp/VR2K+5L7NvhEhYdHL59+n40mvtmvk+wcFmqShTFJ05cYH7TkwmduUD50RO2/Z5QkKohitdokLp/DkwqL53zVSFGVh/P6WTk56PH43btZR3s4hPq4CpsmkJg07S812z8JFd5m3dX+2HubiFoIyzaC2nTPMHi+fcoQUwNub++IkNElSHiqnixwueJ6QkE8LRpPmZD5XE1R4fcPx7xeuqpP+BKU/8X04kqhxqcSPYfzNlnO0//A/aCnRh2HeQT/Cnc8ehRHNeH/VXJ09OAW+5nJtqow9wZpghIdbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6bHDNSKEmA2PYWJadEKmuKhKPCf1Mw+kZWySjkVK2I=;
 b=RsmRQ+4cTRoSNrmpjv3LQX83UMxRxAN966dsCfHbMPysUtefZCa/AQNslO4mW9zbedOt9Doz1GB5ooPBkyz/nohQUp+nxl7Oe3qIWTqo23//M9uEVNGHo/hmFNcGVETojgGMfbhV5347FtTq6eurAGD4OAe/NNfYrpX/maxykPa7bH2qCB2DRWinXSifAf9w4qu0jncHubf94QljumqmX9DC4bdgGd21sGdpzOz3u0uEj+2URbc9BOyWDmL9bt7oTvm5GuH18DGlmjScmi+KWWvnpZQfduJRIcpFiYfYtvcUVBY+mE5Um9j6MP/iyzhQZ+DVHLbs4Fb0OZoObiQFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by MW6PR11MB8411.namprd11.prod.outlook.com (2603:10b6:303:23c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 14:24:24 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::1b1e:8472:f24b:6693]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::1b1e:8472:f24b:6693%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 14:24:24 +0000
Message-ID: <5e2b91e2-91a9-4b7e-a196-ae5b4a082490@intel.com>
Date:   Mon, 6 Nov 2023 15:24:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: bcmasp: Use common error handling code in
 bcmasp_probe()
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Justin Chen" <justin.chen@broadcom.com>,
        Paolo Abeni <pabeni@redhat.com>,
        <bcm-kernel-feedback-list@broadcom.com>, <netdev@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
CC:     <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@kernel.org>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
 <83b0921a-5718-4dbf-b9bd-5662e47e3807@intel.com>
 <2b5e219a-85dc-4347-b5d0-86059181be93@web.de>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <2b5e219a-85dc-4347-b5d0-86059181be93@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0003.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::7) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|MW6PR11MB8411:EE_
X-MS-Office365-Filtering-Correlation-Id: 139b43d8-92f7-4a2d-e100-08dbded41324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aO41/Ulq5Q19JsT3f4jnpyBn4+h/o5Id28UM3cYQ6PTsyfEJRl/n+1zy89Y+U0BTwAXyNA+AKRvhEC4SAaFKu+bGokjlJHafrUL70YsXXdK/YujhTEEDbJRSFd5EMcg4NotEbNoxmgshsAImzUjYHXpRXvLxgvz5bRj+FADUwOaa24V6NiaNgHHbEuYEgDCwik3AaH00u3KPdIpfNl8Ezo+0hpnyO2BrWil3q9gRiqZb3WnttR7YKoOiuNzJ0QKWJRvsjr1FCG60rysF88P5yPh84IV56kdCCPEsNNvjrV+Eolvym9CEiC02ElS9CVDKA7DaUrMKRxl0M4QPliORdgZrkN6NmsN9jQ5HjCRei6WxBdNg4BItLFiS3TB8v4I35alJtxsslmp39mflY+wzYhfL9ZqFxjjaep1tYSv4lj6tpr8NzpqM6zoDH3YpG3GirEp6nZen0sOuqPW2cO+TZ1v4GSiPBZZRktmLpyHF2RZGqQ0Ua9OHEMNZ0Y2RKiAIr0jc+55VV7T1twOxxp2/hbIa8mvuZTTCDx/vvl9RAP1Gv4OuPH/dZKS5neUA7HWAOvHTHIxGhwf+qR1vDJK80COpoADR2HcJezxNvtvDXL1JspMe1OfKMTIShYEr5eEPR0uJE6tK+R7ZHyC7TG0wFdgOvtFO4FVIXWLANESZcvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(31686004)(53546011)(2616005)(41300700001)(6512007)(6666004)(6506007)(26005)(36756003)(38100700002)(82960400001)(86362001)(31696002)(5660300002)(2906002)(6486002)(7416002)(44832011)(4326008)(8676002)(8936002)(66476007)(921008)(54906003)(66946007)(66556008)(316002)(478600001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1NScTZoZUFlR0p2VlUwY2YrNnhOZVlLUk1KanFmc1hMOXoxNVpzMEFGMjJl?=
 =?utf-8?B?QjJmVURLcWN2SFFXbjJwU0h3ZlhVei83Y251M3ROVkowME5kL3F1TnNZY2hL?=
 =?utf-8?B?ZmFUTmRDU2VpcmVQTFZnN1NiUHF4Q1NwRjU1MUcvT1psVUx0WHhKRnJHMnFV?=
 =?utf-8?B?MVNqZnFwQkRVcU51Mk11Q0FwVk5Yby9sZkVkLzNoQUNSTCszVURHOE1jbytL?=
 =?utf-8?B?cXkwNkR4bm5kV0pOUkhwYUE0Y2NFU2wrdnhZRllzdzY4Z1g0R0lXTWlDaHd0?=
 =?utf-8?B?em9ZdGdMd2NCSWt4L0l3ZnhseVU3alFldW1jU0ZBOVE0VXpuS1JNQmttTkw3?=
 =?utf-8?B?QU5VcEJxbHR5c3NRb3lSR0dvRjZnZXdYbkluRmdrU3VaSGYzS1J4emVST244?=
 =?utf-8?B?dHZqdVo2WTNkK1VndHJ4RHZZNTVaR3Rzb0Y2Tk5NTmZkSkdscXdrWGJyZGdn?=
 =?utf-8?B?Q0FGWU1VMGc5N2FwYy92MHJOUjlnZTJIQ0dBZmZzaURWMU92NTM4a21wMmhw?=
 =?utf-8?B?WFRrVWo1bERvZ0kwU1ZFNGI1TDR5VDRqMmovQzk4UGNDY1dyb3UvWTdlS3Vu?=
 =?utf-8?B?TXFCTUVSeXRMYVNPazhJL0RIVjRtMFZVcTNVUDBXUzVMcWVncllBV2dReEcz?=
 =?utf-8?B?eFhjdVRWWDMzaVlQVDg2NE9hVi9ha2lvbm1PTmtHVlh1bVlOVEU1UVlsL09s?=
 =?utf-8?B?NWlYd2h2YXhGaU1DaEYrVmRWNmZkVlJ5S2dBdUU0TzFaUk55a3VFSEVvOG8z?=
 =?utf-8?B?WUtOL0pNR1hsQk52RW45a0tIWnY5WGZ6SUZSZHVSWU1xWnYvTG1sV0JNNTVx?=
 =?utf-8?B?d01hODBYSDZPSUI4TjYzVHpndTlXMisyY3ZHc2lHLzhDbTZheGZiV0N2ZHJq?=
 =?utf-8?B?T084MGFRR1FnWVVLVldYTFlpbXJ0c3cxbEZhaWpIcVR3dFRlUU9Vdmc1eWJm?=
 =?utf-8?B?WmRlbFBwUG91Wjlna1JEbFVvQi9nOGlCYnlQMnBSem9qV0RIN0VsWFQzbXQx?=
 =?utf-8?B?MTdjUDFjcU1UQ29hdDIxNS9EODZBSzlTYnJadEFSRGIwc2RrLzRYSUZYcDBK?=
 =?utf-8?B?YzljcnREMmdxbmROcU9oN2VieXAycm1IaVVlM3FPYnhQRENsTTM5TlkzM0Jp?=
 =?utf-8?B?RFk1QnExVDVBZmpIeVNKdkRaei9xWmFOZjZyckN4YTNiOEpOY2g4OWtLQ3dL?=
 =?utf-8?B?NzFUb0dLQUpFMHhUWkhrUDZrRmZSODduSFlxcGRPU3NiS0RuKzNSMW1BUE5H?=
 =?utf-8?B?ZnFReGR5RUZBeERNOFhWWmZtcDlTb1kxM3JIclVlUFdMandhVStHY1g3Z3BG?=
 =?utf-8?B?NmcwRzRyM25rbW54KzBIdHI3Z21qYkdjREJEaVhiWDNYSi9wMk5SRFNQQ3dY?=
 =?utf-8?B?bHY4ZVozOXNVYXBsQVdseGxvTnRZVnhZY1BrOTdDc2V4TkErbnBWMFJhYmU0?=
 =?utf-8?B?TEFac2lydHNpeFlpUzREdEJmYTR6dWJMSjdoOURndlFoVTNtOXYvNWNPVEE1?=
 =?utf-8?B?YnhDdThBY20xaEt4dkNEejFCU04yTzhzb3dqWTFZaVlQZzBYaDZtTXhsdjV5?=
 =?utf-8?B?YkFYWmlKekYzMjFZQStrNlJNSjhqd0pXMGNNMy9adzlCbUhwbE9ZMytqSFI2?=
 =?utf-8?B?WGYzL2RFQm02cDFuUTNWRFpFV0hualRrS2pCRWpMNDZYbUlEdjBSMHRTdW8y?=
 =?utf-8?B?aHRwTk9IMzRKdW1PcmNzY1RzYURiZHNyakthWGVZTTV0UVR1NUhJQVJ5bXFt?=
 =?utf-8?B?eVl0MFJwcmFFTDZwMklmemo1cVpRQXBKSUd2a2lXRUNMNjJjODdaclFXN2Z1?=
 =?utf-8?B?R1h4WWd2TlhDeVpqMzRVSDBxMExHcUg4QnVYVGM5SjdQNy9iSjhnblpjNDJG?=
 =?utf-8?B?UzcwV1pwT3lWQkl1NEhXL1Q4aElRS1NwRU5oSEV0cTNWSlI2WlRtZUl3bUxJ?=
 =?utf-8?B?cWZyVVFnZHQ1WFd1dHFkMDRLd2txb09YNU10eVpjZFh1Y2lEN2VDVkUyalBl?=
 =?utf-8?B?NG80T1BCaUxrYW1UOGRFek42UU1aZHp2ZE4zN2VtMGIvZVNWUGJGOFBpeXVY?=
 =?utf-8?B?T2ZOSnVCL3I2a0MwYVM4dXFGZGF1YXhqMVAwZ0UxYm5ibHp2YWExNEhQdks3?=
 =?utf-8?B?RGFHNURhQk9nckRhMk1XMnpUUFBTWjNMREpibzQ0YXoyWndVUjZaR1dyVDNp?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 139b43d8-92f7-4a2d-e100-08dbded41324
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 14:24:24.1869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tjbdCkvedDiA/UFqXIgruyVAg9j1ZYdQxRQw6EGsxQum3SsTNXXQJbL9ELjwYzNj1kFG9bmfT9/yUfNqGNTlSyRswnE5kr/DQZNdQ05Wt2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8411
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06.11.2023 14:55, Markus Elfring wrote:
> …
>>> Add a jump target so that a bit of exception handling can be better
>>> reused at the end of this function.
> …
>>> +++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
>>> @@ -1304,9 +1304,8 @@ static int bcmasp_probe(struct platform_device *pdev)
>>>  		intf = bcmasp_interface_create(priv, intf_node, i);
>>>  		if (!intf) {
>>>  			dev_err(dev, "Cannot create eth interface %d\n", i);
>>> -			bcmasp_remove_intfs(priv);
>>>  			of_node_put(intf_node);
>>> -			goto of_put_exit;
>>> +			goto remove_intfs;
>>>  		}
>>>  		list_add_tail(&intf->list, &priv->intfs);
>>>  		i++;
>>> @@ -1331,8 +1330,7 @@ static int bcmasp_probe(struct platform_device *pdev)
>>>  			netdev_err(intf->ndev,
>>>  				   "failed to register net_device: %d\n", ret);
>>>  			priv->destroy_wol(priv);
>>> -			bcmasp_remove_intfs(priv);
>>> -			goto of_put_exit;
>>> +			goto remove_intfs;
>>>  		}
>>>  		count++;
>>>  	}
>>> @@ -1342,6 +1340,10 @@ static int bcmasp_probe(struct platform_device *pdev)
>>>  of_put_exit:
>>>  	of_node_put(ports_node);
>>>  	return ret;
>>> +
>>> +remove_intfs:
>>> +	bcmasp_remove_intfs(priv);
>>> +	goto of_put_exit;
>>
>> Why is it at the end of the function? Just move it above of_put_exit and it will naturally
>> go to the of_node_put call. No need for "goto of_put_exit".
> 
> I got the impression that the call of the function “bcmasp_remove_intfs” belongs only
> to exceptional cases in the shown control flow.

Ah, yes, you're right. If we move it above of_put_exit as I suggested then it'll be
executed in successful path as well.

Makes sense now
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> 
> Regards,
> Markus
