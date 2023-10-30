Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70247DB5D1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjJ3JLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjJ3JK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:10:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990E28E;
        Mon, 30 Oct 2023 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698657057; x=1730193057;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h5kCL5SIvHdFILTDe27f1qX5MOYuloymMLmwptsxdQc=;
  b=eACU/FszF+Xert1ZZve18eK8bavJ7p4nSs71G5PjuNb6HeGCJcWl6dB3
   38zDm9iWJL/eZYY7Sv2Evw2Mhr+ODj1+iTF71zgyAXA0n612TkLXdfGrj
   FAa+TEy+8Zm8vYgerjqcXPQzAz+ZFA/snJR6ImJQh/MJjhUhL9kcBrijV
   zfBizg/mG/Wgmcjz5ai2ix7b6VRSvkFOeRtQ2KbqzKn7rFmI9CKbZsXgw
   RCPdCGQrRNO5GAkjw1efB6ewzC4cITnBGdjb5KCBe0z/arhXxuigTwlML
   Ehg/sIo/+eMaK4aS8b0W3QZfifJFIsREPhDACFR414HeD8mUV9wwGBSAA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373089627"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373089627"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 02:10:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="710046169"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="710046169"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 02:10:56 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 02:10:55 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 02:10:55 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 02:10:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 02:10:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNqgeVADsfiFO/0oyGz947z27Kdw44598y2/t9c6zMIRKobtd9ihhsmuw1uOb1Hs/koOxiDhAKwqv+eZG9+ZyROQy8LsvO4NP3XQw3X7O4z2Ppi+jIwm9pqhRw2gS0VeJwzh8tMBp/b9CDVjUUqLvPv8JnI+qrr0rF5linVQBFeyeoVe9uHxZPBjsBAMD3eXB9gUtRN3c9nw476ty2kESAGM2LEwzQo03rylUhAAmo5czzMGo2tc0SQPd9XKc5MvYnCyyZ0/WTx9pSvU/HfJQXQB8MnXdLQPXSq9oRsdp53HNDhvO+SvvTSrojon924rWmpk47YPgsTtB6XDDItJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ol0O1ObMOXh7TkNAZWvxVB+RH7WKtVXadDrd+GCaKPE=;
 b=S6EhUg2AquVQnV1Zx98xCKwXT1LOpTWQYbOTW6Bp8ADJMn+kYCa24w2TQVFQRcEeSXSiIvZF99iODfySHc/59tkH6jOZIldfjufjeqfX9rG1+HHP5XtyA9LTQjEvMGfHgEGfgybQzbvCaU9eMy4E+rkKFiPT+6EKQToFatlPa7Nrzhk6CHI3ZZ/OJ95nKEZ8CWUomEE3Wszze7kJq/LRWR4dC4++3MA29QPIBShDDy13rF0jJy0vF/T7Fn71QCoIWOzobc8xZOAtRnPQbotxvheuN6J/3g3mI3irwx9GOABAvtogc0L2YKY2CkvX1aTbdB9U2bmDHIP2HsiTrMLXFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by IA1PR11MB7856.namprd11.prod.outlook.com (2603:10b6:208:3f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 09:10:52 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097%6]) with mapi id 15.20.6907.032; Mon, 30 Oct 2023
 09:10:52 +0000
From:   "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To:     ivecera <ivecera@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "Drewek, Wojciech" <wojciech.drewek@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Keller, Jacob E" <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-next 2/2] i40e: Move inline helpers
 to i40e_prototype.h
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next 2/2] i40e: Move inline helpers
 to i40e_prototype.h
Thread-Index: AQHaBy7C30vC9mWizE67ZoeIHTtUx7BiEzTQ
Date:   Mon, 30 Oct 2023 09:10:52 +0000
Message-ID: <BL0PR11MB31225D9FDF8AE29BE5BC4AC7BDA1A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231025103315.1149589-1-ivecera@redhat.com>
 <20231025103315.1149589-3-ivecera@redhat.com>
In-Reply-To: <20231025103315.1149589-3-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|IA1PR11MB7856:EE_
x-ms-office365-filtering-correlation-id: b4bc1a91-96e9-4601-e755-08dbd9281df4
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YFV5Gf410HoKJoiE5fHrfNamBVEAnC4q07jaGY4lTFUIlFMAEVZT1tgldQ1GpOpogXs4RdHdxMSxER/JD4ljA85tYhld1SiT6OpsHNlPm0a7+TTwq92UX2C8YBAuRzrjSaerpik16VfXRb8oiVxEcKyFRe9fPZvEQJZJ0FANUKtuXFoCSj6cgRvupCKbAWMM+t6oahiaEtHh52GouurLhm+IuR/hlA2u49NxTisK3VBJyJVvntVnZ5y8M/jdZuTtMITLPU0I0vItVCe2IGNbG+/9KDBpLFD+qPEQSI4G55jns+QHdWSBhOZFkY6FM93pSeoitVtcBdQPLCsT/Td7v+qMB2MVqiMZIwwWIuA7U6WNaXt52VKyzXGhFsss9dazqvwCRECx4h6P0CA9uD6e9k3edrIyYXYW8RibTw8WbTNA8geL96aSs+7yWiaTAzgrGY74kEHqy9ZGR9nLtmH0sVLKiGVIW/hLb+w6QtmAIgCPTX9B7lvkHtGZJLuBZb/GYS9+7PKo3lkON8dvxPIuGzW58oyVUagArS8qB8urQ+vP5KRdE5/gTh3krlM3RUfFhdUToadfIfB5MjkoKElUTNI3AXh84O8ecEhE1/MYPtw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(55016003)(9686003)(26005)(53546011)(478600001)(4326008)(6506007)(71200400001)(7696005)(2906002)(4744005)(83380400001)(66556008)(110136005)(966005)(76116006)(66946007)(5660300002)(41300700001)(66476007)(8936002)(66446008)(52536014)(8676002)(54906003)(64756008)(316002)(38070700009)(38100700002)(82960400001)(122000001)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lw3I+PG+c5lgN73jfLq2icyKCMqy1hWn09M4sZHh0/J9mcyATZfBEyQq2HN7?=
 =?us-ascii?Q?sQdYm2ZWRwL/VxSmuJUBe13K7u8Vrql4B9KBixjmMCmyiGNJAEAmFUi2XRm6?=
 =?us-ascii?Q?Rq64I3sev8VDj2oUiRJlW+xs8/zs0395UcyyUcPiD7YjXtvoz+J4lb7fHMAz?=
 =?us-ascii?Q?rk+2eep+UCv4yF3wrZcEuEoscMeI7Eeflj/nZZ79aAmIEwZh3GzffUT8aygD?=
 =?us-ascii?Q?umWp2d8kKy/eJby2PhMXVAmVLxrCo/gy39jpayj7W89eLZpV0gHd9MCSElBk?=
 =?us-ascii?Q?hsUaeF3QkzKB3fkSXc4/fnXyiOjqxtyRTBHTR4hUd+eSq/knJZYuC9e/zMNg?=
 =?us-ascii?Q?udvk2NwqzZIves4SSdZIuToV9jqD4Ve7UOTn9rXnMQHYkXdJnh6pIM/dlDl+?=
 =?us-ascii?Q?Ij0SUkKfyOqqZ+9EVJ/AQatoMf1NygrHYPruICFrF90z73ri57MT5amEDRlX?=
 =?us-ascii?Q?MSmBqL4cJw+eEapQQuMsRTVhYhYtsNrOlQXl8e6QsV+mNQiTWCUU90wqXSg/?=
 =?us-ascii?Q?bpOhWNPu0/V/614LAr4d+Cgyy4YK5T90K7lkL24R1Ug/xJHL5gzzd29sGVc4?=
 =?us-ascii?Q?9tSUFvDRo6O6ix+LTDg7es6k3tA3l66Diy20mVzkxwjx9qFRJhJbVj8kn4u7?=
 =?us-ascii?Q?jkJ05WT+W7xJB62PmPQbaAaWHidZ1IdU2pWyuQ08PQjqluWo0zJb3GyN188Z?=
 =?us-ascii?Q?UK2vf0YS4claIiapvYCWJgxNyxkpf2SkFxqPU4xxQ0fTpgFl5gRSxqUPMQcD?=
 =?us-ascii?Q?JaE/4XL2hdgHVDonJ9MySoa8f3c9FliD6oL/8jcHvdNJaUfyBTX+fPBBmFIf?=
 =?us-ascii?Q?bRBUL9242IAftuUe5jZ3vVdW7IJKAV7G+EmH8Wkv2ZxI/h3+7PngZjUW8JkU?=
 =?us-ascii?Q?/LczObA+eS+kQL4lyT/2E/uuvReqEbnXT4Hbmk9+NRU198yOFyJsy9YntGFV?=
 =?us-ascii?Q?j37glITvLfjSA+bh5WRGNZWFoPXNqHHFzzfV7cYTiDrCA8P+MClbDjXXBk2b?=
 =?us-ascii?Q?QUhKkGL0I69ELtQEDIAvVB6FhkM9VqnWN3RpDu+uxUs3na/NVy5+y6LCUvxO?=
 =?us-ascii?Q?WcY62mlE0LniRKtwwEmz0CvaEAk0NQwhXpea7vyGIx3H04oRIA3DqGDmXbV9?=
 =?us-ascii?Q?yxiajuG/PWW2G/GQQY4WejEEYAVNd2vbb4PZ2GMLbKGaEHFE1wyrnw2zRl+5?=
 =?us-ascii?Q?oFQkWRSn+Nw25yuk/62UuG120GaVJ0us79rLoliVsmhBM8UQDmYZvYe3EIum?=
 =?us-ascii?Q?gaD2RAQ7cwa6h4zDZSrSpOhk7kiNH+OyQgJf27Vk3GW+BicY0TQkNbg7ZPao?=
 =?us-ascii?Q?IA9cZo/kHCriPaLWPhcrYSk6JC4UrM4d/MbgW+YJUI4A/ThMlr0v2ODM5Lqr?=
 =?us-ascii?Q?6+dfy2e8lzR4XYjrwz8Tl9x+QyOeq9ZtUWDy7XGxDdJ5y7Q6zPyM6MIWnqlt?=
 =?us-ascii?Q?d/6VRvXagdsDXWDAYhBRk6nWNCRP/afhKVc/KZikFs2tm8g3W8lg15/czhg8?=
 =?us-ascii?Q?qOQq0zQjZ+E9sxAdY8DEFR1XiCcr5MeZZtWleMxb+uitOje936uYn9qYVdhy?=
 =?us-ascii?Q?N6E4VFZdM0iHdXnbX7c+g3mkJLVyrqVX4H2nMNyFnMBUT8AEjGJbkKDSGfLv?=
 =?us-ascii?Q?8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4bc1a91-96e9-4601-e755-08dbd9281df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 09:10:52.7361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DI601Pt5otXkgrGk+C88MBrceGj6LRYP0HQCq3hTN/ssCU9nfPRLASNKulKU2opYdfPmW/qWkrkaJe3NCVO6erysfLR0LyRRsoCKwA0xFFMyPprKimweFMM7osHeYEVj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7856
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; intel-wired-lan@lists.o=
suosl.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>; linux-kernel@vge=
r.kernel.org; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <anthon=
y.l.nguyen@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>; Jakub Ki=
cinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller =
<davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next 2/2] i40e: Move inline helpers=
 to i40e_prototype.h
>
> Move version check helper functions from i40e_type.h to
> i40e_prototype.h as per discussion [1].
>
> [1] https://lore.kernel.org/all/cdcd6b97-1138-4cd7-854f-b3faa1f475f8@inte=
l.com/#t
>
> Cc: Wojciech Drewek <wojciech.drewek@intel.com>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_prototype.h  | 70 +++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_type.h   | 68 ------------------
>  2 files changed, 70 insertions(+), 68 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

