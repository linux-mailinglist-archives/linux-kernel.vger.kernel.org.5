Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E334C7D43CD
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjJXAOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJXAOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:14:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0210A10C;
        Mon, 23 Oct 2023 17:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698106478; x=1729642478;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wFtxVfFyWUlAGg57dMJID/JUIl/3nMJ5RLlgDcADbnk=;
  b=QM4g906Ldkr0s0YJTes9q4XGP3t7CIla6sZwNXLN49xg2ctVot2iPCJb
   XVxugv+PpRpm1jIIi9hwMVG/HZ/YgjkLCwFFcsNr3eG7n1ET3MkKluqw/
   P8W5h4JnKnxsrVHRMkbEYrxBzaCCa3rJWB4LgIR5vmx6GDeMl1ETiQ5cy
   3VVwMD0+qrMEVyFsGGK9NmTRxIoeh86MOZvxg5jE+axLlQ3GIIDSP98dh
   OrdGtI9/Tgwsyfq6qlkdy5x7hQ7ycf84OmEnBZMQz+EEIjLK0EQvdmKs2
   t1/zy6WPptK/aS6otpMft2r68gLQYCBWRnzvOeFBiRw092FPG7jfpDaB0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="8506086"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="8506086"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 17:14:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758292263"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="758292263"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 17:14:22 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 17:14:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 17:14:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 17:14:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYcYrfv+BMBT99boJvj9LMKBpJIfrmJDr/HfwwxB7HCtlVoLK4StPfqJ2QW6zuPAp4KzN4VGF9VcAOFXprHfpMBTNYQhQq/nBvSeI6j2EbtCzgsfGsnV0q10U+JSa242eIlP8qSyl/A4TAG357FxrbwjnWlv850dvQY2/0cH0g8vDTOw7Urhw4HMJ7swmlkHo8ihbpXmx2q27CQpFP7jM6iObooHdqh4lBumlIr9yths8iFxY+mdjqFp1LjpXTzbwVMHuTATvuJcGKGE2lY09xKSNHqqHqyR0LjlcGcDL/V0NnRysCBH6DBejzLCkXyZitJ0jV06nOmfVnIM5AtD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlkyMrQFD50npubT5dAofisshMSr1O7rBIfo3iaU+t8=;
 b=Od53QDMwCBo++2IJqrkn8pKlNqwTy3Tg/CJ/kfXUaLehzMMRYN32Sg6+AKcZ4CRWzIMlwQOMdfFJS0zMUAntEgQpDy8PrDnLsfs8WeoXjYwrKgZ7pnEjs5A7DJtigflhvo+1QzORuetdDTfOQzAINfwqSa+SeruzHhpnYAvPPKg1sWlwyzYdL6eU6k0N0r+dmLEkoUaux4aI0f2Rpxo3sq90aHILhEmo/8VzSl3/Zei6losIorK7onzum5mFiaYStdl/aFQpVe8f3pA1gKeKdX8IVsKf/djn54wL7ZQFt+UBXQur1DqwzNqr2URk3XyBkM6N0XL7jO3aTJ2TRFwd+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV8PR11MB8487.namprd11.prod.outlook.com (2603:10b6:408:1ed::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 00:14:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 00:14:19 +0000
Message-ID: <97e1f76a-3505-4783-838a-10b9cacee8bd@intel.com>
Date:   Mon, 23 Oct 2023 17:14:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] net: ethernet: davinci_emac: Use MAC Address from
 Device Tree
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>, <netdev@vger.kernel.org>
CC:     <aford@beaconembedded.com>, Andrew Lunn <andrew@lunn.ch>,
        "Grygorii Strashko" <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231022151911.4279-1-aford173@gmail.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231022151911.4279-1-aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0339.namprd04.prod.outlook.com
 (2603:10b6:303:8a::14) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV8PR11MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 700b4814-7acd-41cb-f880-08dbd4262ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Ybn6pFDD/iZKtzpdGjmGFoTagLz2NBvVicpbtOQ5IV67QeBltK3vcuQTOFj5d+jbxJ1YMt88YnFbhnHY/Zn3kYyWDVXo2dcv2VP0ZwGzKV7/TwSJqFnTEjkY5Puwc1LeKrXTNcBsKBR5SLIFzjkIG/PPg25Xy02bCUNvjpiBQ48crTzMKZfRHxujngK6h9uT9ewrvbXVMv1w+hTALtMoD60ZooGl4djBwc+tvqqtFfOPqQKCp4swRMLfsI+4R73BEQF6kMDCWmrXWMFKZgodylg3HBpsoYzGgim9aQUAQewlvHifPYERcwWWnlOkiSF6UkzQSFeE0duJyPmesgZ0DqhCJ2RRJtEenVSVCs2iHDEl4ClL6yOkCk0/gbvkpMsX3TNGjgLhqyTwEOcnJyl9CplIfULbY0sxpRmSF1wNW/juxcNC3qv65hLYztr4GF5tcLWEy/j6GWkQWZ8WDXXZ2/GNpnxIKJj8MnLKqpcfYCNBbN2n+vDLTHNPxMSkwlbftDt5j8/Sq+UOEip5AmqvebaDeehiuRUxMlmuhh7l/uXCEqzW1gH55yeOZkhV9e4owAGrOwzNJuacldfP75o5ILH22JE2/szSuT0NyNx6tPLtggRpduhL808PTr6gTYZOtsiBgfctpLWe4PLuJslAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6486002)(53546011)(478600001)(66476007)(66946007)(54906003)(66556008)(83380400001)(26005)(316002)(6506007)(31686004)(6512007)(2616005)(4326008)(41300700001)(38100700002)(31696002)(86362001)(2906002)(36756003)(7416002)(5660300002)(8936002)(8676002)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0p5WmtkZ3ZHTWY4YVZ1MFdhbGNncGErZlFDSytzeEZmZXpmVmx6eDc4Y2RT?=
 =?utf-8?B?dGd6V3hkYWpRUDVpNi9FN1lyTDV5bmE2VkVkTmUyOXFmYWM3aVdyd091YThH?=
 =?utf-8?B?bk9OeTV4allFbjdXRmtHQytzdTBNdmc3c1V4QmdBeCtZSUlZeTArMDJMVXUy?=
 =?utf-8?B?M2xIUUwwT3dycFJ1QnhnRFR6OWkyUzJxQmdNOEhjMGZoVllHNkZYSDhRWkxy?=
 =?utf-8?B?UDdxaElsUW04ck92N2pNZ04wdTNDd0JZVThZem9XMjhBNzU2ZG1lTmphRnp2?=
 =?utf-8?B?cFQwR3VSVjU4ZlhxRDFtN0ROMnJCM2MxRmR6SHRoY1NZamtXZEJveGwweXVx?=
 =?utf-8?B?dElleWx0bEdPYUsrWlNibUVuSmp4MU43ZC9UUFdqQWtmMFROcHlVczNFTUJ1?=
 =?utf-8?B?RVN6L3h0a0x2dkRxSHpBdUN2Y2crbWw1dVlxUXhEbkR6bExnM2V4RjVRcnpZ?=
 =?utf-8?B?TTJWWVFxeU5XN0lMOVNNNkNUeE5jUkxTVjVaUytNby9MeEdtbjlYUWV0MDFY?=
 =?utf-8?B?eGM5Z0w3S3NrdzQ3dnhSQ2RkdEZyeCtMU25zMWdqaXh4eGF5aW5JRmJYN0F2?=
 =?utf-8?B?cnNNeVNLcjR5eUVKWmxQYmhabzFSYXR5dFN0anRURndyajNEcG5YRnFtb3lL?=
 =?utf-8?B?M3BQRVhUTDdSd0FxS0JjSmV1TE5MUHM0NWx1M2NzbHhOVXcxWFB2VWlpZEIx?=
 =?utf-8?B?aEhUcWJBUjFiZXhMeDNCWEJWY3plYjljTUxaWGYzSW9OMklpdzJ6ZmVKOVhC?=
 =?utf-8?B?SHZ0UDd3TldMZGk4NE9BOFp6azY5dTFKNk9OQ3krU1c4WW56OEMrM0FvR2ZR?=
 =?utf-8?B?WUcveXNXU0VNdmppVjEzZ2JoY3RsSDVtUnZaN3BCeXV5VnMvZjlkaFlXSGgy?=
 =?utf-8?B?ZGN5WSt4UDBZYkxBbXJ5L2tJMzNhbDRUY1FYd041NlJZUmZiODNBbEhCMzBj?=
 =?utf-8?B?c2xNUzl6UDlJclYrQ2xveEhDS1lFaWtiSFU4TGFiU0hiY3I3KzNDdjNpelRM?=
 =?utf-8?B?TE8zQlRWSHczOUVuM2FscEI4dGxFdm44RVh3ampRM0w0NXdZdGxHbEFneG1s?=
 =?utf-8?B?bnBGUXR1TmtBcXFFTGdmSEZlTE9DOUl0eXNLQ2dWZTY4djJlTGpybmZuMmsr?=
 =?utf-8?B?ZHJ2T3FQUzBVeDdoeVRuYjRHQXY3WHZRZ3JBN0IvRTl4N0U3ckRVVThLN0RY?=
 =?utf-8?B?R3VxeUNMSTdOQlZ0Y0VIMWZoK0pRTzh4UVVZb09oVTdRVVBWMW83TTZ4VjVx?=
 =?utf-8?B?QTN0Z0VENi9CVjBsRWtDd2tlbDk4b0NKTEN2bHhhUml2T3loU3FhU20rdS9p?=
 =?utf-8?B?VHcrMkEwdHJvK3Jlc3g0eFBnUjZYQnNzWlBNR2ozc1JES0NzbjhxOGNTdzgx?=
 =?utf-8?B?T3VvekhDWlBOeUt3eXVzY0dnV0lFY0MxMEVoVHJZekFCYjhXdTBmOHRwcjZa?=
 =?utf-8?B?SHpnM1RrVEFpWmZjRGtVT3k3UkcwTU95YU9VTStIRHNrRnFqR1FYRzQ5aDk0?=
 =?utf-8?B?VTRhQjh0eGMyTGNJbmRQM01xdTRZcHB3b0ZjbFlvQmpIQ1A4Yno1U2JWNWVv?=
 =?utf-8?B?dnN1Z3JmbjdNUXJiVE1tNi9WbUU0THI4VVRkTXJhcm15Z1pRNlpheXo2dXl6?=
 =?utf-8?B?Qzd0NFNkbTFNaENuN1MxWFFXWGlDUzFSMnhsbTJqQ2d4TG90OEJFbWZySm01?=
 =?utf-8?B?M25Td01kUzgzZTJ5U3UzUnM4eVVLWEo5cWFwTEpoR3g4aVQ5MGVzT2oxOHI0?=
 =?utf-8?B?S3p0N3JVb3lKcmFqY1VXbFZiVFJWTno0ZEszajFRd3F1U0c1U3BZL2ZsbVl6?=
 =?utf-8?B?NTM2K3pSM0JacW5WdVZjSEZwdFV2S012d0xLS2hla2I2Uzd0L2ZFZStHdGMx?=
 =?utf-8?B?eUZlSEpqK3BHUUc2TitmSmZML2JCUU1XSmRJVTRGV1hMTEsyQXRIaHNzbVhV?=
 =?utf-8?B?NnhOajcrSmh1MXNhNEkxMkxQemJEWFFHUVdIWW1UblpRemdLSUc2VTczM2wr?=
 =?utf-8?B?cHZhU0wwOGYwZUtIYzBZMzd4U3k1MkxaVjJsS2o2azlSOFB3cy9LRGhuTFFv?=
 =?utf-8?B?RkorWVNpS2JEZk5DeHR5bW1jSG9vajViRjNPcFNQb01pMGV2bFcxUjNVNWtp?=
 =?utf-8?B?amdUTlI3MGlBSEpSd0x0T3Q5M2JDRTNFU0MvL3VQSzI5dGc1TjgraU5iOEY0?=
 =?utf-8?B?YUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 700b4814-7acd-41cb-f880-08dbd4262ab8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 00:14:19.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUBrZBodKvy964KnHX+aOQt765caUUlyAA3m3EMXHVBBEw31Gwiy1jCwUZtfY+oTLqjnKxe3VTOFFJKS8TbFQPr74SAXrjLzTwcqv3SFkSc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8487
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/2023 8:19 AM, Adam Ford wrote:
> Currently there is a device tree entry called "local-mac-address"
> which can be filled by the bootloader or manually set.This is
> useful when the user does not want to use the MAC address
> programmed into the SoC.
> 
> Currently, the davinci_emac reads the MAC from the DT, copies
> it from pdata->mac_addr to priv->mac_addr, then blindly overwrites
> it by reading from registers in the SoC, and falls back to a
> random MAC if it's still not valid.  This completely ignores any
> MAC address in the device tree.
> 
> In order to use the local-mac-address, check to see if the contents
> of priv->mac_addr are valid before falling back to reading from the
> SoC when the MAC address is not valid.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> V2:  Rebase, add R-B tag, and post stand-alone for netdev branch, since
>      the device tree patch has already been accepted via the omap tree.

Looks like you didn't add the tag for which tree. Given the context, I
would assume net-next.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
