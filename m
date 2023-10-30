Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC287DB5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjJ3JJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJ3JJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:09:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF918E;
        Mon, 30 Oct 2023 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698656947; x=1730192947;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sgMyyWSj3yKoypIkqcOsGd58fOW1oAV50svosHvNn4A=;
  b=PHr+ltU3EjyBRAPFNHg4EtVNo0gi9eAVZaxpGDOOfHHPOEiqzPDHd5uH
   BiPV8csiZmazaqIXggrlo1iYe4AFxP4DijqYwmIvzSUYpVHEFAI+OkmK6
   cZxbEe4zsS1wVx7pkwO8eRAkKOfe0b5joCTbY+TVNbjIpQ2IQXLSTCJ6P
   K4pp/E8HrdR4r6Z9Rc8LRwGAP2zT8BFwbj5FPD4t9+c25cUs2aNdxELir
   UkmuyN4Nck/szj5ripHouFAiYkS1BHeLUdHRM6ECe0nGZuNn2BgmJuK47
   iLFTfJ2tzm7pOYjGUNGklZqs8fzE4DKWYZiGr7fsqKl0+ojaWDWJvx/Wa
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="419151404"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="419151404"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 02:09:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="850852730"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="850852730"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 02:09:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 02:09:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 02:09:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 02:09:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBFDe8pAL/l4MscfXCSOEiuJo4mf4Ds8/2caFVoJEm46nO/KR7WDgVM3dZc7H13SIVfWfH3BrBNMa/sgLG5WB8kf874trSSo5i9as6EAbJQD8Uo+G12jAxmlHgQfiLt7LorI4Tlp6wwhvSS42Y01eg8+bk5OEkn7GajfcYW12QoQei/wJVIh+K5203XYuvpUVmicfJ+UAC/ehWosIPkPP1cSGHWUX0/n5pzJPtRkl5XbwaexB5UPDeB/F2tE7AEB2eAHTO1ZR8qoi1jyHzKvq379mDPNtExfebEF9qMXd9NC6Mzlxj9mOGcRBQQyuPFNL/95KopVxOgLPozvIglsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMHy1MRv2WwgRzNnqgp/45kFOSgJOOd3bAuxef8jGrU=;
 b=e2XOQuwci18h8N58bJu/b/Tm1GQZuSVGBHAKF0TC6uANr+VVprZGBTc6znD13i3lliA+o1daPivg03HJjC1VsWn4eD8rltKKqgaT7cbGcBUPicP2Wki5VB2zCRXSoPqUEFG6c1wsCDetecSuHdC4xSJQtLlUGgEP3Qb4y9I6/R+SyEXxTKoE5zlBk1u9NVU5K0fGh9GqlW+MF6/ISixQiQC6i7lDOqrCoG6hCyS0ebvev4sGd3Ob4h9nERzy9PpYf3X4L/NNwKXnuriC+E4Qk2V5oVMM56X/VM6RsoTOG5VCoWMV8vZhsGsN3jdAPTskiieyp4JqmZ83/b3LdfkMgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 09:09:02 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097%6]) with mapi id 15.20.6907.032; Mon, 30 Oct 2023
 09:09:02 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 1/2] i40e: Remove VF MAC types
Thread-Index: AQHaBy7IFFl+HOqgok+vgSyUBngox7BiEspA
Date:   Mon, 30 Oct 2023 09:09:02 +0000
Message-ID: <BL0PR11MB312295F5DC3408006E5820D5BDA1A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-2-ivecera@redhat.com>
In-Reply-To: <20231025103315.1149589-2-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|IA1PR11MB7856:EE_
x-ms-office365-filtering-correlation-id: dc83b69a-1d75-4230-1e90-08dbd927dc1f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X6dXW8j6gvZrlgMAKs/QzvoAl4eBrjyVKCXJJqu2RyK85PYhyvUOgDKBrHtiK1KSexTWSMxTQVB1CGw5SbZt+UQTKcs/CSD03vb/jMZ4yTy2bgIT2KvKzD3EnonWx1yUJKi1Cn1vsztKVOo+2xL73wPwjS7cMGBSuOIfj9fKLCBmdxCMB+Nui5UFIxwAGVVq7pBvBjxZqR/euPxZCGWvgMQ1pSrFo6AAA48Am+eyGU1AnCZjwYbuuFkEMIQDPRbdWkhVK0sqrelZgq5amyEt1b3am6X+tR9whmy/FNDKUhxt8b8jKFr+wVd3TJYaO8YknQYe6yaBBiAJUfOX561//G1zx+K2B7FqmER9twzfZgR1MYmWSvEdWpvRO6TwbjwAoFqicZOTSTNQzIDIY+/ZY2W2xmbvS0n5muXpv/C15RyaMYR8dWY0TneUcu3oeDd9mHgubZq2dT5WC7Uea1bFjmGZjZOMvFJy5CChPXWEdzRC2S6BWyDt7F359sxZ9pxZ2pORlVKtYEj++fHA6B3RV4YhWY1tyRVAt+oiRfZYVnT+MrV/X0d95z5ETMpFlsVDdJWwTMYuFE4hj95iepQPEDerzpSFI037l7Uqit0dGfrzwNWjYCgLBjF1pc7xw3Gy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(55016003)(9686003)(26005)(53546011)(478600001)(4326008)(6506007)(71200400001)(7696005)(2906002)(4744005)(83380400001)(66556008)(110136005)(76116006)(66946007)(5660300002)(41300700001)(66476007)(8936002)(66446008)(52536014)(8676002)(54906003)(64756008)(316002)(38070700009)(38100700002)(82960400001)(122000001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A0nsjOpA/FASk44CYE/B2+vWgLALd/4WKdh8m1Vg/T6KA9PZQ6JJfMP7kf0c?=
 =?us-ascii?Q?GjOP4qsd9Yktf2hy9Tj8PCHHtRXHadA9tToPTrvbkFeVOLZuqhfGOF6wFr7c?=
 =?us-ascii?Q?1Zbtp7SEHIAPf42rUToESnpzsFHzbXKXd8KTRn64NWXO/RE8UEDS0NFMw9Mc?=
 =?us-ascii?Q?oDttl7Y9OwZdK6U7q4SjMo/Tay/8DfMhWj4LQL+JiQA3v3TFIgk/+eEZR4pW?=
 =?us-ascii?Q?8PZ0FM8S4DeGhX+coRnHhRxvXpy9N0b4hz6nDMPsImjpGDCIXJerXU+ZeHYC?=
 =?us-ascii?Q?0KB6+Iq8j6bNt7MO4ksvIukV175N6gjbxkEm3AYnlBpjp/WMN0Mtc/tLM2gj?=
 =?us-ascii?Q?XGR7vmod8zpMAk6Ur4poflNDGq31+C+T+Q2Fknj+8hjoU/XPjh2SOIfQz8Vq?=
 =?us-ascii?Q?6ZyFD5Rm9kB8j0/dDFCsigL/A2o6ww/+ockP8OLgB6UuSeZWCc8GGsfMOpAR?=
 =?us-ascii?Q?sRAcNxFxvnbefwHWUQ1ikipmd9fCU0LWonwjeRGwphdxPDpR6MGVSCqp6UC2?=
 =?us-ascii?Q?tv4yncEMVPcPwdaVaM03I6iBqu4gSyfh8YBaN/mkWCGvut7+vyBi4rLjI5O9?=
 =?us-ascii?Q?pzuZ307jOSt2xvAzUHAEk2dwIDD+H7V2g1E44fz+vn56COfQo3m3Oa/OLB3F?=
 =?us-ascii?Q?Kdl/4iHgoy8oIGmcTP7k1AGf+LiuRX2S2Zo5RtqUakLsdbinAD2lCpEKS1Px?=
 =?us-ascii?Q?K36KaTKgFv+l2zCfX+c3TivlSeKItyYcCfPZrUYZooly8IByykdXbiWhosb8?=
 =?us-ascii?Q?4Ao98ZyWkOVyrDAYVM7QOiv3hb+O3El7oYfReTy4nKUbkFXJ3ywjztM2K/rK?=
 =?us-ascii?Q?tRHskB6zwDkomGMJ9h6MdE4M+sDmRbmGBNchFtLpnK7Ayje0YMX/WvSGn/WC?=
 =?us-ascii?Q?rza28I47Qjn+AjkxToBDYPg8FT39F7LuzdnVbPEaDoYUe5lbr1clFJO1gF9E?=
 =?us-ascii?Q?keE8kvAafktgb9m9r/4Ox04o2K1+QRmGBjAdcreU4N+/5mUP3jYkw+c1gNKl?=
 =?us-ascii?Q?/EVRU7ObGDBePCRi9qwL+SOp4mKmyrGJy3Dkt2jEjxlBH5lQqWnkc7ZqskoL?=
 =?us-ascii?Q?/xfJ8Ro6c5g9cZylPP2IXqFQWrAhmEpxUdgaQ6wDLmQPGw1CX3T31izTiZAj?=
 =?us-ascii?Q?FMFy5HZGiNcn+FRECSsOOd4V/GoKIyjhRqnDUy5DAOQMN4Kx3MMWMykxxhMS?=
 =?us-ascii?Q?iPeVE9nZdRx949tlnmblaU5YMF8ESF2qvIgj98W0ZMr7HGZSyef7aM4h3ybv?=
 =?us-ascii?Q?pmmKZwI8v57Z8PqAq7yH6ItUC9TbHlMlSAkEHF+FTUoKA9gUmtliuD4eO+Qd?=
 =?us-ascii?Q?n47YcUZODg6AZwFGACaIaX/NI6sE/mzcmLfoDQj/xffZY5W4fLy4ENPu3/lo?=
 =?us-ascii?Q?A3ld0ukiGDtAYF3s78xddvMPZSD8MCUMS29gU7e9KApYc1cBgJc+5MoNjshc?=
 =?us-ascii?Q?oZ/4Klo+mlhNhhjjHQNWqtQBwr6WYOWIk9ZApyF3ArlmVWsK6qztTLO4NuI2?=
 =?us-ascii?Q?+CJ+Tne4mCIyKVhK9++iofJZVka4KTcdSbSPBRGgiE8mlu5Yj0Yq3CsizT8r?=
 =?us-ascii?Q?I77bqr6SivlZ4USlm56s4tcHWatWSo4Gs1J6a+uwSqNVlryedKpJ/emDpdAk?=
 =?us-ascii?Q?Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc83b69a-1d75-4230-1e90-08dbd927dc1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 09:09:02.2527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 28Ti3jrX7P9dGHvfehqnvrPQ1N5xdNh7IP1tWUfPfFTomYlUG7q6lZzxDUpDaoxH94Q4Aoojx2H1u/hQSD8Lv8bpKnYGD/c42VhsIsu4DM6Sh2/yUaLHORYUNR0tPJ0B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of I=
van Vecera
> Sent: Wednesday, October 25, 2023 4:03 PM
> To: netdev@vger.kernel.org
> Cc: intel-wired-lan@lists.osuosl.org; Brandeburg, Jesse <jesse.brandeburg=
@intel.com>; linux-kernel@vger.kernel.org; Eric Dumazet <edumazet@google.co=
m>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Keller, Jacob E <jacob.=
e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@=
redhat.com>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next 1/2] i40e: Remove VF MAC types
>
> The i40e_hw.mac.type cannot to be equal to I40E_MAC_VF or
> I40E_MAC_X722_VF so remove helper i40e_is_vf(), simplify
> i40e_adminq_init_regs() and remove enums for these VF MAC types.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 33 ++++++-------------
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |  8 -----
>  2 files changed, 10 insertions(+), 31 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

