Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA97D8C21
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344993AbjJZXTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjJZXTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:19:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCB3D4B;
        Thu, 26 Oct 2023 16:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698362357; x=1729898357;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Lmbe5uXb3R3X299n6z0o1brLoP8bfMlNKwpHSeA7rjo=;
  b=kVcd3m3FgMPq/J5mGcpQ0k2KvmkszcwFVIXXkGkexHOA3dC3N7tBw6n4
   o0FOOMkfPCIvDn+jtQmMvjxJ9Y8UPw2kY19RXbgl19K0e+/nKt7iaaSg2
   Iy5Nb38ADuhTMBlFLwQYXn8lVugPffu1Oe4IUavDheC9xs/QjX3y7mjac
   ZTMzjPYJiVFpgCvgzziSohkjUZCXx/aolBFny9e2pDY/4WaTrODkSKNgf
   VWjkpdNJRqsigA3JFqujt7WZfkzBoe1JyEYqEWP4RrkK4h4YaZF+glTxQ
   pJoHarrnwK+15CKwqnTOfJl/wCIvMw8LIK7p5pDonOAGAR85YvlFh4IIZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="367015797"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="367015797"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 16:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="788662516"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="788662516"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 16:19:16 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:19:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 16:19:16 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 16:19:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T49f61mmrzi2URu171+dpAotqT595x3EDnbgR6xYjKicaXj/Q7RqfqfTLl3Ng6TbbeMwE7em+48fxhQpohwaGb3bWzo36AcjJADR/75rO+/jXRSw7GW1CzSSkTr/fJ/MCBdem03fna4xFgO+ZnHstuqaFkTjI/eu09u6f2CAiPGRtaW28w8uBoyqipUXFsowYFLHC99fPVlffrgYrfIF121kK72g9e0FPkZRfUfBI5XV3et/IdaZ6Fo/8s/PfTlbOA16xhSAMp2Ih48MaoOhJFX19L9/DoGeY2UXbA3fXqqMuUrIALQZv7yf2F+L3TbjfSPmg46c/TEOy5+T6IqGeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh4elzl2Ezf3chzIJqGIEPt85CWQQccC6hnlSQImelk=;
 b=XnZtxUSznwNBO9yQKXF+SU0dkB0sK3eDbwboXzD4ZVYP6tqYcME+uWsM0x143c6HMopiDctNxuK/D2BleQqi4th/2mx+ICf4VjNcVc4tGr7CDLKAw++dukp4uxPTrPsQzagMJ39eSAN67nIVb8/hcjAH+oOw0wGhyAwzT8xFLmbhJnFE80GTCdhegog2HhbuaEB0mutv+uo+Oc/P89fvNztylg5RNjYSCFQwdJBYOTMGpgQnRBR31K6pvA2y6YXifTOuw5/GCwebNBUDc07lxiXhvXyxGCBzwD4eqyqTceKg2W9GSysGP2nTQ4ZSYpmk6bGDs6W81XyZC4xyqZBBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Thu, 26 Oct
 2023 23:19:07 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 23:19:07 +0000
Message-ID: <b331eca9-5345-49e9-8e44-7c18045ac7f9@intel.com>
Date:   Thu, 26 Oct 2023 16:19:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/5] net: ethtool: Add validation for
 WAKE_FILTER
Content-Language: en-US
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>
CC:     Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Tariq Toukan" <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        "Simon Horman" <horms@kernel.org>,
        Justin Chen <justin.chen@broadcom.com>,
        "Ratheesh Kannoth" <rkannoth@marvell.com>,
        Joe Damato <jdamato@fastly.com>,
        "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
        Jiri Pirko <jiri@resnulli.us>,
        "open list" <linux-kernel@vger.kernel.org>
References: <20231026224509.112353-1-florian.fainelli@broadcom.com>
 <20231026224509.112353-3-florian.fainelli@broadcom.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231026224509.112353-3-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:302:1::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: ab76f118-b62d-4058-9f63-08dbd679f41a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B6OdZUotnloNsOHRtyN3Gm6jB6+mrFolsi8czlc9V5KC1mdRPhrnvRkaYeS7hTzT2wy/te3pMB2ikWGgfBLp+KNFx1dcRgpMdjC5KGlXOVhmNk5sgdSc2brBGmG48NVv9Ab6D3hjmpkSgQZj6QrcnJLPP+XeeljWZugvRE4C/Zh33uix8fzpv3Xvl/sEivMrjP0rUZ2EXMVnIYU8j+HVz8/3ljcWn113fjKCUpz/XmNw6tRsxg3bxI/a4VkZYXmx/r93LNj3gMs3qgZkwrCzLOh7yEZzKBsIRxzWfssACVP7qPYdSqfOVKpf+nARane0n8F/qZ6bl+rdg5jgn6B66Vx71zH8FrQ4RTBh9Bb/49JHPRL0CDB4QKExAmkavTek0+Is2bbp4M5GI5eQf9Y92743fmYdnYbD95hj3arLxSDmOjQZfskAzAn9SUa6aRcGI2whPFPDnj5hJsFmusfI/vjwdHB4GWsubQkwMWeFOo1SZsn67Dhy0PQCJDMmWuyCGXf2psNB0oqN80Na8is1Ca6re0vpROy/uoEf3K0Q/oIVKGUHBlUSy3glaHCh/j8cnKalZ+tpb3S5EMpJxjP1b0x9Ks1HwSKtUidd4uregx79nD1eE1+xNRL8wD6b+PxmuEaj8ci7g3a1MJV/dCHkrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(4744005)(41300700001)(2906002)(38100700002)(54906003)(316002)(66946007)(66556008)(82960400001)(66476007)(6512007)(53546011)(6486002)(83380400001)(86362001)(31696002)(7416002)(5660300002)(478600001)(2616005)(4326008)(36756003)(8936002)(8676002)(26005)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBKWmpicXdkSHJHSk5tUCtUaVFCRlBWRTRmQk1LSllJbU5sS0VIMWJqb1d1?=
 =?utf-8?B?bU9FYmlsS01NaTJoWVBEYVJ1VFUwMUUrWGpoSGd2ZWtkYlkyeEJ6Y0JBNlNl?=
 =?utf-8?B?S2lFdXJSWE90ZjdsTmppVWNNaVhPZHoyTExLU1YvVkV2Z1ZSRWptcEl0dW02?=
 =?utf-8?B?THdqcnA5a2Y4ZXlxOEt3MTRkYjhGeDFacThOc0J2R2VQMlFFZTFjQXc3L3Z2?=
 =?utf-8?B?akRMK3BFU2hFQXlmbFFtcnlWSEt1eXFuTHpYTUVkZmY5RzBERlZLZkRPNzlQ?=
 =?utf-8?B?ZkViNFZ2bDZ3TUhxQzBFeWREVncydVlEMmhwSzRnb05NSjV6bVhWb2IwN25a?=
 =?utf-8?B?bkdNUjd4UlhvbmN0MDhrNy9JMTVlUlpFZ2hhakxmVWI4d2VoaCsyL0prVGtI?=
 =?utf-8?B?YUJ2S3p6U0tXR0dUOThMcEZzZkVJVmwvaXp6N05MWHU0QjRINXZoUkZxcStN?=
 =?utf-8?B?WEFsbldzdi9OSHREcjlhZHhCU1ZteDRPZ2FkaUoreEVoRkE3VlRQWDJmQ0l6?=
 =?utf-8?B?TStMbm1qL0Y5ajBKS1VKYU9vWUE4T2xOVzlJampndmVJbWx4cFRVWFdiWWVB?=
 =?utf-8?B?MERCVkJmTkJhQ25DY1owUGNJNmhpTSswaHlhV1VFSXpPRTJNMVVNWXBRWFNK?=
 =?utf-8?B?Ni9iZHFMQjJJbmdjZXczSGF5TkNxbkkxZ1czRDhUMG9GbEJwQlI0Z0VUUkZh?=
 =?utf-8?B?Rkl2dWozUlp6UzN3VXlKUFhHVS9xMUg4RlZNai9hTURtSGRoc0xHMVZydGN1?=
 =?utf-8?B?TWxOb1A2aXNTOFJJeUZsOXFKZlJ4aUtzQkJpWExOWTE5TnFTWmZvcFg4akRP?=
 =?utf-8?B?RnIyV1NaNmYzSVNOcVVTdGpFU2VENDUxNWJ1UUZ0VVBVc0hCS3liSWJyZ0k1?=
 =?utf-8?B?MVRuWGJxak1ockhWVHJyYUYzQTZ1OTVQREZia3hlWThOa09ZRUNaWFRCdnVq?=
 =?utf-8?B?OFJZRmYyWW5MWEVlbWE3RGg0bFZod2wyY1h3aEprSmxYTytydm90TXhKWUxQ?=
 =?utf-8?B?ZTJROW1kOXZLN2xrNDBibEtxK2FHOUJXOFVZbFUyeDdqWEVMMVpwRVVldnRQ?=
 =?utf-8?B?ZmZaNmZoRVVmNzd3aTNCRnZNdUwzdWRBVUpCMnUyTDYzMG5oVkxpNUxzdjdy?=
 =?utf-8?B?cHJra1Vxd05iQWVEOUpqdmk1blJFNVozSEZOV3ZOZ3Jndk5QRCtJNjBRaHE4?=
 =?utf-8?B?eHYxZDBnZU1sY2tPT3BCMW1NWWRMUzZ0TDFEaXB5azFyeXRpMnVMWnB4RmVI?=
 =?utf-8?B?cDFyeld4RUtlVGZVSlB6bzlRZ2ptR2E2bW95Wlo4TUxIRzNubHNBbzBqR3py?=
 =?utf-8?B?NWxhNEVpaDQ4Y21mV294cURvbE9vODZGMmsrb0kxbE52TjdZdkg1WnlGZG9u?=
 =?utf-8?B?aTRucThNOVROVjRjdUczbzdQV2R4TnVwSVIxUlNSajVPMnQ2N1JzRFVWU3RJ?=
 =?utf-8?B?Y2RGQjJCK0ZQSTRFOFVuV2pwQXRza0dKcm0wK0hRQkJpYVpmOFFWVkNBNkxP?=
 =?utf-8?B?TVlYQzBWeU5Ua1N5dFRVMzd5SWF3b2ZKSHBHYU9JQVgxOWNoT1ZDV3dRNnVO?=
 =?utf-8?B?OE5FaHZhUXFJbkk3aUJ0b1pNNDFQdE1zL2JqWUZmOTBCN09wTU5FeFlOL2w5?=
 =?utf-8?B?S3NrS01WNEJ4V2E5czlHbnJSTk1YdWNOb1hjU2l5aTJiLy9RSlRUSlR2eGp2?=
 =?utf-8?B?TGI2REI2cW5kZ0NGUTRBbmhJSG01eER2ZnpFbEtKbXp4T0dtM0Z4WU1XQWZH?=
 =?utf-8?B?UG4zdXV2SkNITG0rTE83ZExDUnFHbFZqeDZsRk1RbjJnWHpGbm1sakhOU3pn?=
 =?utf-8?B?cm5YVi9TcjdYQ1pESTdPSFFuazBVZlQ0VDd0aVZSaEl0U0pOcXZZZ21XR1Zo?=
 =?utf-8?B?QzZoVklaaVNOTHpPUkxUVWtPeCtNaWtpcXZ1ZGZSUWhRSG9RUzUwNWw1UEU0?=
 =?utf-8?B?dkVqeGJsVGFMVzFwdnRjK0dtc0xBZFlLdVl6cnBJM2lnSmtQeUNHZnF4aWt1?=
 =?utf-8?B?K21OLzdtS2hzcCtZbWVKV2FOd0pxYVVZWW94VHFCcms3aUQwWi9VQVF3TzNS?=
 =?utf-8?B?a1VqM3NmTUNhQ25SZFdPbVVIZEYrSUZZc01RSUtkQ1BIclB2bnoxN1VUVmcv?=
 =?utf-8?B?YTVQZTJTbFZOTEIvc1BPRFhHaUg3VGRCdGdpRUpRVnhQM2p6UDAxaksrK3M2?=
 =?utf-8?B?VEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab76f118-b62d-4058-9f63-08dbd679f41a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 23:19:07.8803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WUh8bYZ4V6H7wnsdpeNqeDt3VKhN3tkSDF1FVmusZ94nYAGtrRRiRS6TYmc5rxqBF4pP1eNe7nWeCQGdhGg7XrXgsoT1uD3VrQCPdD9zUrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6180
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



On 10/26/2023 3:45 PM, Florian Fainelli wrote:
> A driver implementing WAKE_FILTER must first install at least one rule
> with RX_CLS_FLOW_WAKE for WAKE_FILTER to be effective. Iterate over
> RXNFC rules to validate that condition while trying to enable
> WAKE_FILTER.
> 

Makes sense to enforce this.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
