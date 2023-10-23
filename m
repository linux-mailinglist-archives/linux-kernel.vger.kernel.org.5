Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4667D2D4F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjJWIzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJWIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:55:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF996A9;
        Mon, 23 Oct 2023 01:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698051343; x=1729587343;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sYKwJPxO+I+TU4bpV/SrOipL6y4HHRdoSrq6X8At8VY=;
  b=DEW9LZTTZjHyegRF/FOqKdjiTqzV6MWeoV3AJdRoZnx/Jb1+7I/v+8Qd
   Ok7cqxL22uAk7vEE85YNvHzlfdUkUK5OBUuAYfna979JYmaZgcE+4/nbw
   tuYyVkufX12bwzDfMaMQfLlb27OBblwWA2nIvuOz6Q9sjv+E5f3aidzlV
   prctc8PlNzMtz8WyURqV9UQu35V7x6MGP/xC6LfCVEExnG3btjl76NsMH
   GqRad/seeUFtOThLsD4MNztnlkEhaZ2B7V60Y9q3o53diNqdCfDDfwm9T
   jvUrHj+NhRUrI1//jotMFDaXmyzBuGVssl1dAfkb+B5+euiGnvWPtdves
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="367027585"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="367027585"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 01:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="1089405861"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="1089405861"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 01:55:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 01:55:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 01:55:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 01:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obO+60wM4keCUv5NJH2JLGyKcoTi8swLT1gBN9U8vH4xDoIOASmokg6uUytC4HtsptbYY3VcDccMiee4OPsJCziExlcua5OWGmjJPJ1cc9h8mbazlgGn01uMfIKI1oyjh2gs0pRruvF+jqlPg/0zRAVjC2GGKHwLDRZXn6ZcdB5B8T5ZfD+IjUP0aZWJt/Kk0hmgQGbX83C1/4Ipg8FAApwddezjh63EqRzpGj0KsxHHecpPHjdZxvRtTkg/IlTl8KTtzpi+ssHZkLBzs/DVoSFmS8ITnWopUFUIOHLQ5BkvUOhb2634tNqEs3pGbM+lwfiAiYrqiT2ZjUrv/IgPLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kfsqnD9BQcMWn8yBdRFwHa0LGezkFVpGzz2EWqyEuA=;
 b=ZDI1mDfZ80GuVdRi2r+QkcbHDORiO9wBti3KN2g6ZEuoqRD+ZgJqesVobnN4tUTYfeu91qTWU6cNO6x4fYm8f6YILGRmKQAOPxk1UxMWdQw9xKUNsrzfmZ+R8NAKYDlC1YNGGDZbQoifm0NsEXgI3VtHtOdfY5ixZqgUGCPXye/u1SMsWKcCh3tQYBxikTXb9UoGF+OrDVsA/FG/yi3HV6ngSGPuPMzdi192UOtW9BPPju7y7hUzcvKBhQ0j8YwpATG7bgnji5eKfLGMleU90Ctip1ko+R/nrceta0v70s/JPHYqixrt+Z6TY7ehmlhSVhcS0iB2QuRFqJulmcZlfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by PH7PR11MB8123.namprd11.prod.outlook.com (2603:10b6:510:236::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 23 Oct
 2023 08:55:39 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::2ec0:108e:7afe:f1a4%5]) with mapi id 15.20.6886.034; Mon, 23 Oct 2023
 08:55:39 +0000
From:   "Drewek, Wojciech" <wojciech.drewek@intel.com>
To:     Jijie Shao <shaojijie@huawei.com>,
        "yisen.zhuang@huawei.com" <yisen.zhuang@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC:     "shenjian15@huawei.com" <shenjian15@huawei.com>,
        "wangjie125@huawei.com" <wangjie125@huawei.com>,
        "liuyonglong@huawei.com" <liuyonglong@huawei.com>,
        "chenhao418@huawei.com" <chenhao418@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: hns3: add some link modes for hisilicon
 device
Thread-Topic: [PATCH net-next] net: hns3: add some link modes for hisilicon
 device
Thread-Index: AQHaBU9pUcvtIx+BC0eks2ud/zch3LBXDbaw
Date:   Mon, 23 Oct 2023 08:55:38 +0000
Message-ID: <MW4PR11MB57763C8FF069B2A567EDCC85FDD8A@MW4PR11MB5776.namprd11.prod.outlook.com>
References: <20231023010836.507078-1-shaojijie@huawei.com>
In-Reply-To: <20231023010836.507078-1-shaojijie@huawei.com>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5776:EE_|PH7PR11MB8123:EE_
x-ms-office365-filtering-correlation-id: efa2bb8d-fc8e-41a6-9086-08dbd3a5d475
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WWi15g6r+nmMxXQxrC32eFkwVQzQoDwUJQlYUyrdL7qVqy7qrlQxSanJ1PjRAw4qOecPwYgbBEoWebADaqPfyWQ5b7R1tWejgzCrlNPx7kAH5pdxcnKigrB1SRjG8Z8s3TfZIu5mFANu1xZleocfhs9Q8lJozLbX2bC6+vToSQODXbapcsHH0G3ATehKX/6R4/JO1ji7WnOJiRwk+DKw90Hu3qDkDtF4UW+haNqjzFxl3z6lAqY2Z1yA5dEIh7GCZ+VnnMrkOkrrLlsyOW/td8LuIWRskDU5khbOsqW0OnFIwQC63B4yaRqtoDQrG5buNjEt+gK1Vp+1z9a3l/ch/mVz3E7Ti/Spwc2Lk306cYEMUAvwgoPqd1GrA3dDILVP/s+8jsYwoGSAXnHuTHF0U3FBcpVGa/i9g17B7wButljlk5fFuZVv/cfZvOPZ4L+usnErA5LRe9NwVaJj03dNShjye27X26RZs72L1MtaHuna1iBwF59o1DRF8v2eQans/Mgz5WPSWOcVQO+yzENnBq2QyNJIyxQzMW/jzxZgEuWwkDskQhy+AWLVxg+cwdb5KmymUx7PCN7uK7QF+/FmzFmqhv0mJ3T0/5i6bT2JBQoi2oBG95fBe2WfYoNZgwrj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39860400002)(396003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(122000001)(38100700002)(478600001)(7696005)(6506007)(53546011)(33656002)(26005)(82960400001)(83380400001)(71200400001)(9686003)(8936002)(5660300002)(52536014)(8676002)(66946007)(4326008)(55016003)(7416002)(76116006)(38070700009)(86362001)(66476007)(66446008)(316002)(2906002)(66556008)(110136005)(54906003)(30864003)(41300700001)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SziPNMRYNlcDfJn8Z03TIQ4lZN9hi+iRjJ0iLXXVPMXYrvKWg6wZi0785QT/?=
 =?us-ascii?Q?Rmk1Awl7g3J4YErUbbGrPcxLDMaFFN4jy5SowqR9FJy8Jfdah32hEW4wSe8E?=
 =?us-ascii?Q?/iLEmTe+UOfg3Hzs2CywwrutEhv2/512mr6bgxvFfKrf3+vJXK43nYjgA/ZZ?=
 =?us-ascii?Q?NEq6QeK2w9euBD809Bu8FyJoaDQS6id3rvHMwLu76F29NUclXl6fHNBaaJbg?=
 =?us-ascii?Q?PVySDvL382l+VQ9EYJYxdfdJnEM20XsihdcRiXy+AxbBm1pNsYJcl+2vH3iy?=
 =?us-ascii?Q?PGFs/J5OUQ/JtHdelnZkRj8QrwZ5mi/ABtv+eYKdt+S/3ch0RDZRHqlo8sZF?=
 =?us-ascii?Q?LVcmY8WjZugx9KbnbIdn/h7rBJfLKA2zTHA5qOwap8dLVQzZRQruXpfrSPnO?=
 =?us-ascii?Q?ZGAr1+XHRII79YCma6AOlhAW3de1g1wiUdYLjxDo+DRP2VGkiVK3ynms3+E/?=
 =?us-ascii?Q?0PXRw6HkSWlqpFb1EsboD2SygoSy7+mvg39RKf60rM6OLtlXIfZe+20dhkyR?=
 =?us-ascii?Q?WiZKeJd5E/TunViJGTs1bIgmE0s/S7W3YhBc4HG2+zbOIhTHo+0llKxfRL3b?=
 =?us-ascii?Q?n4caNo6zaA6L8+DCUZSukqkkhXtOdlawaVLb+yBMrY6BuXRkEnClELLee4sE?=
 =?us-ascii?Q?r+IRk0dTyt8xqHoUV6V2FRKWR1lqWvyfXsHKpipO9mRquT0d+QsiTu/Oa0EX?=
 =?us-ascii?Q?+6WlM7bLK33e4xPrljihqlJDebi6Qs27D4RE+09OEvMFiC09b7FFCOBjdU8q?=
 =?us-ascii?Q?F8tDMbI1CXnv7d/vIzBy8zWBcGk58CPuNHe5fpy+4hZw6NgWT1GDexXPF9pz?=
 =?us-ascii?Q?XOoyZm5gfAjS2GnPKEt+KTV2MEavUuMkDrUK5vjx15ODreoXVqnP7hy0odrV?=
 =?us-ascii?Q?TDb+YESJz4GgFNqwgUK6JIWj6PaE3kjyA/847GmX8SiqnnncvXQ5nXuQ8EkI?=
 =?us-ascii?Q?AutZZLJ0ACR0H+S8csWhv5kkwNreIb1TOdnikF+pp2W2+JMVQDGC9a8Suzp6?=
 =?us-ascii?Q?tRSUQiKoRpCLBOK5RBedD3bEvToozg8SzrfWC+Iu1WsTU0dkUpNhLI/kfg+X?=
 =?us-ascii?Q?l5PeTcdhBigJMDtAsE2Vx4xC6gEBhqwND2fGdv355rXoAQny1BUhr0QAWJ07?=
 =?us-ascii?Q?WKeZiZG0XDhtpvSUJZ93bZ6PxaSAHGpGRXEAwdVFiPJdB1YfIQOp901Itfdj?=
 =?us-ascii?Q?0t0Vb/CRVko5HAVWL6BAhnr6BRzXXo/Xup4rH2Xro2S0DlcrwOldFUZQzNJk?=
 =?us-ascii?Q?oc/FxhgNQwKDxcY3V8XNc3jp2tyH21bcnOsBfvhMLIe6G9xFXbIK2JMm9Uwm?=
 =?us-ascii?Q?gypCWqOIq5slsqwHh1znKMDpEW0JQaASo3rX+UiTOfUwmvo2vruvo3cW9BH0?=
 =?us-ascii?Q?PxFMM0nmxsGTWv70NjxRcmARotkyDXmO72AlfBhzZEzcOCWdbr83ccBoFcFO?=
 =?us-ascii?Q?lIgN5XR5daraurjsMzbwZbsub0lGQCw5v4ON++e2SwIX8Qa3yhGS3IZgsIkk?=
 =?us-ascii?Q?kGB4gtMMTgXLMncRfoiHgAr3BMcLNLsdgGX85mBSisTBTiA0kd62vp3I0tPP?=
 =?us-ascii?Q?LIWrWS8yHYKL+Zm2iKmZisfH5WNZ5DS6fyxlGSVk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa2bb8d-fc8e-41a6-9086-08dbd3a5d475
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 08:55:39.0280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7Hu72LCJSo/873HfAQBW4m2fi+7UYrDvls+NA4qlstfRqlDUGwHfg+xoGvzpqAQkwVDnrkn3Fo9SIqGuB20MYw67iJaruFur8UeB+/UAsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8123
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Jijie Shao <shaojijie@huawei.com>
> Sent: Monday, October 23, 2023 3:09 AM
> To: yisen.zhuang@huawei.com; salil.mehta@huawei.com; davem@davemloft.net;=
 edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: shenjian15@huawei.com; wangjie125@huawei.com; liuyonglong@huawei.com;=
 shaojijie@huawei.com;
> chenhao418@huawei.com; netdev@vger.kernel.org; linux-kernel@vger.kernel.o=
rg
> Subject: [PATCH net-next] net: hns3: add some link modes for hisilicon de=
vice
>=20
> From: Hao Chen <chenhao418@huawei.com>
>=20
> Add HCLGE_SUPPORT_50G_R1_BIT and HCLGE_SUPPORT_100G_R2_BIT two
> capability bits and Corresponding link modes.
>=20
> Signed-off-by: Hao Chen <chenhao418@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  .../hisilicon/hns3/hns3pf/hclge_main.c        | 162 +++++++++---------
>  .../hisilicon/hns3/hns3pf/hclge_main.h        |  16 +-
>  2 files changed, 96 insertions(+), 82 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/dr=
ivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index c42574e29747..d5ba56854ec8 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -881,8 +881,8 @@ static const struct hclge_speed_bit_map speed_bit_map=
[] =3D {
>  	{HCLGE_MAC_SPEED_10G, HCLGE_SUPPORT_10G_BIT},
>  	{HCLGE_MAC_SPEED_25G, HCLGE_SUPPORT_25G_BIT},
>  	{HCLGE_MAC_SPEED_40G, HCLGE_SUPPORT_40G_BIT},
> -	{HCLGE_MAC_SPEED_50G, HCLGE_SUPPORT_50G_BIT},
> -	{HCLGE_MAC_SPEED_100G, HCLGE_SUPPORT_100G_BIT},
> +	{HCLGE_MAC_SPEED_50G, HCLGE_SUPPORT_50G_BITS},
> +	{HCLGE_MAC_SPEED_100G, HCLGE_SUPPORT_100G_BITS},
>  	{HCLGE_MAC_SPEED_200G, HCLGE_SUPPORT_200G_BIT},
>  };
>=20
> @@ -939,100 +939,102 @@ static void hclge_update_fec_support(struct hclge=
_mac *mac)
>  				 mac->supported);
>  }
>=20
> +static const struct hclge_link_mode_bit_map hclge_sr_link_mode_bit_map[8=
] =3D {

Names of those arrays are a bit too long. I know this is a standard here bu=
t I'm not sure if=20
"bit_map" at the end is necessary.

> +	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseSR_Full_BIT},
> +	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseSR_Full_BIT},
> +	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R2_BIT, ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseSR_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT},
> +	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT},
> +};
> +
> +static const struct hclge_link_mode_bit_map hclge_lr_link_mode_bit_map[6=
] =3D {
> +	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseLR_Full_BIT},
> +	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT=
},
> +	{HCLGE_SUPPORT_100G_R4_BIT,
> +	 ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R2_BIT,
> +	 ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT},
> +	{HCLGE_SUPPORT_200G_BIT,
> +	 ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT},
> +};
> +
> +static const struct hclge_link_mode_bit_map hclge_cr_link_mode_bit_map[8=
] =3D {
> +	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseCR_Full_BIT},
> +	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseCR_Full_BIT},
> +	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R2_BIT, ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseCR_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT},
> +	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT},
> +};
> +
> +static const struct hclge_link_mode_bit_map hclge_kr_link_mode_bit_map[9=
] =3D {
> +	{HCLGE_SUPPORT_1G_BIT, ETHTOOL_LINK_MODE_1000baseKX_Full_BIT},
> +	{HCLGE_SUPPORT_10G_BIT, ETHTOOL_LINK_MODE_10000baseKR_Full_BIT},
> +	{HCLGE_SUPPORT_25G_BIT, ETHTOOL_LINK_MODE_25000baseKR_Full_BIT},
> +	{HCLGE_SUPPORT_40G_BIT, ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R2_BIT, ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT},
> +	{HCLGE_SUPPORT_50G_R1_BIT, ETHTOOL_LINK_MODE_50000baseKR_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R4_BIT, ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT},
> +	{HCLGE_SUPPORT_100G_R2_BIT, ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT},
> +	{HCLGE_SUPPORT_200G_BIT, ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT},
> +};
> +
>  static void hclge_convert_setting_sr(u16 speed_ability,
>  				     unsigned long *link_mode)
>  {
> -	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseSR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseSR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseSR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_200000baseSR4_Full_BIT,
> -				 link_mode);
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hclge_sr_link_mode_bit_map); i++) {
> +		if (speed_ability & hclge_sr_link_mode_bit_map[i].support_bit)
> +			linkmode_set_bit(

Checkpatch complains about wrong wrapping (here and in the next 3 functions=
):
CHECK: Lines should not end with a '('

> +				hclge_sr_link_mode_bit_map[i].link_mode,
> +				link_mode);
> +	}
>  }
>=20
>  static void hclge_convert_setting_lr(u16 speed_ability,
>  				     unsigned long *link_mode)
>  {
> -	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseLR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseLR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseLR4_ER4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
> -		linkmode_set_bit(
> -			ETHTOOL_LINK_MODE_200000baseLR4_ER4_FR4_Full_BIT,
> -			link_mode);
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hclge_lr_link_mode_bit_map); i++) {
> +		if (speed_ability & hclge_lr_link_mode_bit_map[i].support_bit)
> +			linkmode_set_bit(
> +				hclge_lr_link_mode_bit_map[i].link_mode,
> +				link_mode);
> +	}
>  }
>=20
>  static void hclge_convert_setting_cr(u16 speed_ability,
>  				     unsigned long *link_mode)
>  {
> -	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseCR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseCR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseCR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_200000baseCR4_Full_BIT,
> -				 link_mode);
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hclge_cr_link_mode_bit_map); i++) {
> +		if (speed_ability & hclge_cr_link_mode_bit_map[i].support_bit)
> +			linkmode_set_bit(
> +				hclge_cr_link_mode_bit_map[i].link_mode,
> +				link_mode);
> +	}
>  }
>=20
>  static void hclge_convert_setting_kr(u16 speed_ability,
>  				     unsigned long *link_mode)
>  {
> -	if (speed_ability & HCLGE_SUPPORT_1G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseKX_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_10G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseKR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_25G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_40000baseKR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_100000baseKR4_Full_BIT,
> -				 link_mode);
> -	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
> -		linkmode_set_bit(ETHTOOL_LINK_MODE_200000baseKR4_Full_BIT,
> -				 link_mode);
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(hclge_kr_link_mode_bit_map); i++) {
> +		if (speed_ability & hclge_kr_link_mode_bit_map[i].support_bit)
> +			linkmode_set_bit(
> +				hclge_kr_link_mode_bit_map[i].link_mode,
> +				link_mode);
> +	}
>  }
>=20
>  static void hclge_convert_setting_fec(struct hclge_mac *mac)
> @@ -1158,10 +1160,10 @@ static u32 hclge_get_max_speed(u16 speed_ability)
>  	if (speed_ability & HCLGE_SUPPORT_200G_BIT)
>  		return HCLGE_MAC_SPEED_200G;
>=20
> -	if (speed_ability & HCLGE_SUPPORT_100G_BIT)
> +	if (speed_ability & HCLGE_SUPPORT_100G_BITS)
>  		return HCLGE_MAC_SPEED_100G;
>=20
> -	if (speed_ability & HCLGE_SUPPORT_50G_BIT)
> +	if (speed_ability & HCLGE_SUPPORT_50G_BITS)
>  		return HCLGE_MAC_SPEED_50G;
>=20
>  	if (speed_ability & HCLGE_SUPPORT_40G_BIT)
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/dr=
ivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
> index 7bc2049b723d..ef530b84eaa0 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
> @@ -185,15 +185,22 @@ enum HLCGE_PORT_TYPE {
>  #define HCLGE_SUPPORT_1G_BIT		BIT(0)
>  #define HCLGE_SUPPORT_10G_BIT		BIT(1)
>  #define HCLGE_SUPPORT_25G_BIT		BIT(2)
> -#define HCLGE_SUPPORT_50G_BIT		BIT(3)
> -#define HCLGE_SUPPORT_100G_BIT		BIT(4)
> +#define HCLGE_SUPPORT_50G_R2_BIT	BIT(3)
> +#define HCLGE_SUPPORT_100G_R4_BIT	BIT(4)
>  /* to be compatible with exsit board */
>  #define HCLGE_SUPPORT_40G_BIT		BIT(5)
>  #define HCLGE_SUPPORT_100M_BIT		BIT(6)
>  #define HCLGE_SUPPORT_10M_BIT		BIT(7)
>  #define HCLGE_SUPPORT_200G_BIT		BIT(8)
> +#define HCLGE_SUPPORT_50G_R1_BIT	BIT(9)
> +#define HCLGE_SUPPORT_100G_R2_BIT	BIT(10)
> +
>  #define HCLGE_SUPPORT_GE \
>  	(HCLGE_SUPPORT_1G_BIT | HCLGE_SUPPORT_100M_BIT | HCLGE_SUPPORT_10M_BIT)
> +#define HCLGE_SUPPORT_50G_BITS \
> +	(HCLGE_SUPPORT_50G_R2_BIT | HCLGE_SUPPORT_50G_R1_BIT)
> +#define HCLGE_SUPPORT_100G_BITS \
> +	(HCLGE_SUPPORT_100G_R4_BIT | HCLGE_SUPPORT_100G_R2_BIT)
>=20
>  enum HCLGE_DEV_STATE {
>  	HCLGE_STATE_REINITING,
> @@ -1076,6 +1083,11 @@ struct hclge_mac_speed_map {
>  	u32 speed_fw; /* speed defined in firmware */
>  };
>=20
> +struct hclge_link_mode_bit_map {
> +	u16 support_bit;
> +	enum ethtool_link_mode_bit_indices link_mode;
> +};
> +
>  int hclge_set_vport_promisc_mode(struct hclge_vport *vport, bool en_uc_p=
mc,
>  				 bool en_mc_pmc, bool en_bc_pmc);
>  int hclge_add_uc_addr_common(struct hclge_vport *vport,
> --
> 2.30.0
>=20

