Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FCC8008BE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378377AbjLAKow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378333AbjLAKou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:44:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDC510FD;
        Fri,  1 Dec 2023 02:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701427496; x=1732963496;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Eoq0sCYkxxqFk7nbAkJWqFfGfsyAXmAvR4aHIdZ3nuI=;
  b=WRo3SQWPO6+Tn8UuXEEgjGUpqJViGDYBzn46R8crPWSzSgtoIN7gdWm9
   9CDiAhKtv1VFp0yMwJq+6M/yp7M/ULOmsiJFD2LdsgXCz4DMUz4PMe9nM
   HEUeRBxAsaPeNOAEikE1vtaJe2LVDZeAqmN14NJetR0lwsMfRAozO7zgI
   r7v/ufgwHSIA0d1nPCjbQjVRKjPQNXuZDYZ8Lf6edQLrg4PJjXJqggky+
   3xN8Dt7BupnLWsZSsc8RxnnCu+d2BoWvTmhpTpXhwgWpQqOgnvve5evwg
   IHRhqFg0Q7pYTtlA1jQq8g87/XypxrwZfd909RT3ji2NdmeodupWgBC4v
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="15023264"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="15023264"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2023 02:44:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="913542357"
X-IronPort-AV: E=Sophos;i="6.04,241,1695711600"; 
   d="scan'208";a="913542357"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Dec 2023 02:44:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 1 Dec 2023 02:44:55 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 1 Dec 2023 02:44:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 1 Dec 2023 02:44:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GdcMHvnz1obSAccrb8sP3mLvX/2neFJi5CDouxpu1eum/N4/5OQtEBRrl9HhXC7Nlgs6T9/ukUM3W8K2I/6MRCGC+sJH3mGx3DLQT3zjasp0Yam52HLKXhNM2wJExANV3JJoLscnM4Fgd7/8oo/qdMioZ7YR5yHMifleg/y+YlBkDFZbE/2P6rIyIvpwVZCGfPHoX5WuZAlVpQBEtVDORh6itFmrCbpQ/QBlT+2FvuZS3uLdR4Qteg+uKUUd0rHnXHXXijNebpGgxwe5ZV9JaS0dL/XON/ZAla+5YNyZ4rbOtdY1eyI0X0K1KyBzupsjafD2CIccIJ70AFQXokXVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vFfI2yaGAXaH9cvgZo1sR6vcezYaMaZQ3Dvsf2cRVo=;
 b=joNnN0xSe+GpKe4sA1KuybFHWlTL4FoK/Oru3u9mcHgix5ZrtdcvZB2YiPrHFMPNQSWaT2V+u/iZPptDrJLqB92jO0eY8+81d4+un+ycjuFiAEz1jWt8nhepK/7jjyTIwD7DQLWxsGGcFNYY6xtX+57PUfK229dQNzyyAxwxKCUlZVnrK5TEmHVF/tuMHXtrClG2qHWMRpo9IpSz7a8DOas1TJVyqD7yzgB4MBQ0ci4uz4G++yyGOIZbnJZJgYAa8KeIQH0Y63EFUyWEigjFfMq5UmPZZPem4ApaMTwCwNs0mdsfrSFG8x2PwDsHxKyCEp6wHqfByk4vW33kuSLM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 10:44:52 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 10:44:52 +0000
Message-ID: <bb7d635a-8cea-4fcd-9d27-fb9e3d82cab9@intel.com>
Date:   Fri, 1 Dec 2023 11:44:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH v3] octeontx2-pf: consider both Rx and Tx packet stats
 for adaptive interrupt coalescing
Content-Language: en-US
To:     Suman Ghosh <sumang@marvell.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <lcherian@marvell.com>, <jerinj@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <horms@kernel.org>,
        <naveenm@marvell.com>
References: <20231201053330.3903694-1-sumang@marvell.com>
From:   Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231201053330.3903694-1-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::15) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 420cbb20-e3ce-4f5c-0c82-08dbf25a8cb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YHxf2qNBQAug3szDu49UGNuFER+rT0924GPE26OeFQT0Ts8cWF75h1fXvUSwTeL3jylXbobiP42TizFgpS2+JkagdTXfZ9ltlXTUGJO1xjbyb5+XxPDVR5bWe2JEQsbnF55qfA2xt1vTAX3+JKWAURofS0ejXJrJghxipd5AIDAJQBZuPcoDiCqlplGxo4nVf+tliooTZnOPhDCwHyT0R5AuOKmrfDEn+HqrZ7amGAy8jlvlWCjluHHARS8hImJn6njkRHOC99nN4aupZwseMjmajerK04CvJk3eqhaYdwShdl/nRpQzx+B8/uXkKQKhd/iMXepdwBnI8jQ8tUNrl515QWqbLwzwkeSZZFFvJ7QrydvXNY0onI2/AH2J22sGkyaH/Hvkmp8f3N2JDJ6f/+RoMOYS97sXNB6qt2dqryOws7M2+mSY8zZ6FkazL0362FFixHLLOggV8eoGhHQ4SSOVbZ338Ifk7wkoJFL5FjsxAumlcxwcv8L/ceSy85W1es+JRAQtjiwtTz+jdSIwvmdI1Y9Vih+cv/k2z6+FJwRejQ/W1JDz7Zn/w6EiNMD6b9wYwjh6XK0dj9WBHRIjG6XbbqGaot6sB9qgYx/JDVfWt8iyMkXiRih4mLi7bpY6ZXENgIiGuXEc2bhrLGQaU1d40oS7V8hRMdD5q97IqY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(921008)(86362001)(66476007)(66946007)(82960400001)(38100700002)(36756003)(31696002)(83380400001)(26005)(6506007)(2616005)(6512007)(6666004)(53546011)(2906002)(316002)(66556008)(8676002)(5660300002)(8936002)(7416002)(478600001)(44832011)(6486002)(41300700001)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1kzYmFVbENvUHh6UE55UzR5SThPeHZ3OFowamF5QTZBMitMRUdMaCthZmFB?=
 =?utf-8?B?MzNrUHMvNEVBbE5HWkg4d3dybnpvZ2dlc0R1TTBJV2V4bFVQV09Oc2JPTUZQ?=
 =?utf-8?B?N1VGeHk4MEZ5SThCbkErS2VpKzYrV0V4akREamMxQ3NucFBHR0VRbnpkNVJo?=
 =?utf-8?B?bWx0NFRFa1NRMHhyVE5sVHB3QTFTTWdGTmM0eFF6VDZHOVhhMUg1M0Z1SDhM?=
 =?utf-8?B?akU5N1RyaklSdnI3dnJlMzN0VVpRZjRKTjRqdjd4WGNaL05yUE1Ed3Nkb3Ba?=
 =?utf-8?B?ZnpwenRUaFFET3VPcklnM3VwMHo0cWJlNUlzWmdTYmpkVVBhOStWTE14NVAx?=
 =?utf-8?B?VExxNHQ3NCtidGt4TlduVFBqek1PZUJteHpiNGtmdzZ6THlFV3ZXUW5GZ2Fo?=
 =?utf-8?B?Y2FHNnZHcGN0dGNlL3V4S3hxMlJjdVQ3MXJhQnJ5QnU1OENYdnJmZndVS2Rz?=
 =?utf-8?B?cm14ckd4cmNzd0RVOWJaUFM2ZVBXS24zVXptYlU4OFZ3UlZUd3VZUEpWTnhv?=
 =?utf-8?B?MW5NWDV5K1RBNFBERWxSdEh6MUx3NnhVeUViUFBXaTdnT1IzM3p5cmZhc0Q2?=
 =?utf-8?B?b1ZVZVpsOUxmODFqK1Y4dEpEbHhZNENQSnVnWmxrMzRRWFp6ejl2WWUxV21o?=
 =?utf-8?B?S0RNWERGS0JjcEhzdEEybHFNbW03TXI2a2dkWDJLbEdoZ25Ja2t0a2JScGoz?=
 =?utf-8?B?Vncwa3JwZHdkVFVLci8vNXJoSFBERVBiZERUb0xkNGpXcDEvVm9tbVA3ZHpa?=
 =?utf-8?B?aVdBR0dnc2cxcnQ1YUNJUXBVckN6UFV5VTRzV3RjTXpTcXhQMS84bEVKbWdN?=
 =?utf-8?B?Y2lsZ0dlUzd0MzFTdUhjd3RjNGVkTzRmanBFUVFZU080TkhaWXJTYnlCeVRp?=
 =?utf-8?B?YzZPazBtc1BHT1RuL09mbmZEeW1FbWxpcUdNUEtxNlZaODFIQ0RPamUxdEdV?=
 =?utf-8?B?TDVZeVZiMWt4WExaNnR2MlhZY2NncVNIZ0JkUDlKNnJKMFZHV2pWbFBjRVBh?=
 =?utf-8?B?cjlqRUdTL0RXS0JqUVhyeTkvVTdkUWFYUnVGdnI3MFZmcEpLZnpndXMxVEdk?=
 =?utf-8?B?clU4ckRCU3dwa1QwTW15TG5YbjgrVXJiZ3ZEQ3V0THMzWmtiSVRiSzdLNkNG?=
 =?utf-8?B?SC9YQ2twcG1PclZYb2UvZVpGRUJaN0Yra3I4a3FsOUgzQ2tVcUNwTTJJaXJk?=
 =?utf-8?B?YkFhR0ZRMmlqYzd2ZFphbm9oQ3huTkhjQ1Y2anFZMUM1cC92UEdWdDVmbzd3?=
 =?utf-8?B?dmxLVDdDNUZsU2VnN0kvek9vdmcxZXRrdEZqaVpENE5UN2UvY0xmL0haNzhB?=
 =?utf-8?B?TDJFWlEvZDlXOFhrcEduaEdCZmNlVVd2SjlMNXlDakszMzVBbnRqZk1hNFhi?=
 =?utf-8?B?RytZWGF5dkRPVjNKaHA3Y0piMUNPMkhZVUhUdXpMc3hmSU5BMVpUai9NRzBk?=
 =?utf-8?B?QjczaXFod1lYMmtuZzk5R29UZXN2WVZkSWpOcU5pTWVsbTJGSHRYZ1FBdmwx?=
 =?utf-8?B?Rk9qeUlsVVFUVHdEY3AwN0t2RWNvV1BlQ2toR1RCOWwvaFBXb0lqMVhIc0Va?=
 =?utf-8?B?dDJLZCtmbmdOcXFHUEs3MTlFdTdscEN4U1Qzd29Kb0t3RGhtNHBUWTFOSjE4?=
 =?utf-8?B?MXhpV1U3Q3pZS0Y2TmhrWnB4RDJXNGRZT0w2UDBlN0twako3dVVmV3k2UE0z?=
 =?utf-8?B?Wk5lZjkzeXFXd2t4V2w0SGEwcVBqZmVBQmFoZk5IcmwxT0tHdC9BY3EzTDRS?=
 =?utf-8?B?Wkt4Sk91K1Y3UUNaajhNUDg3SU1seXYzWW9RQWtrZms2dVNVSnJRSEZxZU1U?=
 =?utf-8?B?K1RSUkd3WlZ4dkhxWThJamhrU3p1aEwvNXdON3hsTzJQOGd0VUJ4dmkwa3FY?=
 =?utf-8?B?ZlZyenpBb2F2QklBbzdHanZOU0JibVNJOWtKN0Z0TitTVjMvUWlUdlVqZmNZ?=
 =?utf-8?B?ZlkvL1BLSlpBVGFMdzVGYVJPb1d4eUFNMXNnRU5HYmZUeVZpVnFPWDFsb0Iy?=
 =?utf-8?B?N0NFVGZmTnlFdmhRMERseUJEYmlMM2NxeGRIcTV3NnJXakRZOWUyQmlYT1NM?=
 =?utf-8?B?NU5od0s5REJRYVlBcHZPRC9xVi9jTFliUENpWDV4TTRqc240NVFxVUhPNktq?=
 =?utf-8?B?QzlMMWt4bmh6cWFqOTBicTVjQllyamJLUmYwck92ZGpIQXJweUF0NFNTRE5R?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 420cbb20-e3ce-4f5c-0c82-08dbf25a8cb8
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 10:44:52.7214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYSc/oQfEeyuGdLKOUc4FvLA/Y1p5AGWxk6CDwkX7wOJIhz431HA4ueMDFjznmircHXjON0i8W89ockECVnHWYyT+oRGctQ0eEUylY6ieVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8739
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



On 01.12.2023 06:33, Suman Ghosh wrote:
> From: Naveen Mamindlapalli <naveenm@marvell.com>
> 
> The current adaptive interrupt coalescing code updates only rx
> packet stats for dim algorithm. This patch also updates tx packet
> stats which will be useful when there is only tx traffic.
> Also moved configuring hardware adaptive interrupt setting to
> driver dim callback.
> 
> Fixes: 6e144b47f560 ("octeontx2-pf: Add support for adaptive interrupt coalescing")
> Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

> v3 changes:
> - Updated signed-off-by signature.
> 
> v2 changes:
> - Missed adding the fixes tag in v1. Added the same in v2.
> 
>  .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  9 +++++++++
>  .../marvell/octeontx2/nic/otx2_txrx.c         | 20 +++++++++----------
>  2 files changed, 19 insertions(+), 10 deletions(-)
> 

