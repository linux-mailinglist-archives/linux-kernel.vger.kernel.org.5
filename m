Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CAD7DB3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 08:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjJ3HAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 03:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3HAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 03:00:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EAA91;
        Mon, 30 Oct 2023 00:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698649207; x=1730185207;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bMqFOOvotAUihvkOr52w1Zh5wtT4EUnBvDMoH5spaUI=;
  b=U/OMbwXweti7MCIGhOnJ/Ir9iZ1JZG4NBN4GgHxEDOmuak39aO9eGXPv
   ya6d6eWeAJIwTF++/95TuaHm24w7L4XF4LqQnBn9+12bIAPhe86FxuLOx
   uWlCE1IY6zbG8gI2J9G77C6woCplM9U43HUcFDvtbsyw9vZRM8lJPFR65
   dLq6Jlw+9F2UuuzpiXMG+zskdOr14zVdrmm/HJImDh/cdw7KH4D4zC3eH
   UbB6jc7/6q5RA/unrehwnvXVyKUWhWnwSzAROWjY5q6mB28UJoJDClLxE
   483bPn1ZupCueZJVYiI3GeaHU3dNiq/C6djWgXLmz3A/GSH+E8O44CwTR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="419132346"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="419132346"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 00:00:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="1091535589"
X-IronPort-AV: E=Sophos;i="6.03,262,1694761200"; 
   d="scan'208";a="1091535589"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Oct 2023 00:00:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 30 Oct 2023 00:00:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 30 Oct 2023 00:00:05 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 30 Oct 2023 00:00:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLETjnJR2BvKzqqBruqC6TPZpE22Cs0S+Vnh7WoKKbhJiRwtchuuwY3l6VEf916gg/CzqGQ4F5YQJgA/YUEwuZt21sEbIoSJpgz2J6uOcvC1W57zEv1eKF01hTUDI4h5vE51PBM7xE0KwQsgl/NkKP/jbNvp2Yj6tNgRSh9vZW3ikdD+XT5epPsgxEKCe+yCU0/iiUZokcfbl32Ub3pOC4CjVQbD1j1FKQY8BEkb+ZLz/pN/8tEpKFl/tUsXPNfNo+eQbfWFPu0rc29Y4EaElSIMQa3Yi6e1xzjTDbLCNi63yo4t7fIKWYjjNkiki5Nzu+T/AH459yxR9b1iLU0omA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUAvZZvx6aJ9NbpIQPvzItwl/rH8zYEEfD6IBE7JCaU=;
 b=LB0PuC1q7S/RrTqPJqICGJBb/QE/HNbRMsXKtDdm8sYuQy7n0XznSteXCDLOXgXqV996Mnoz9jPfESUONkGruzRUF81T0CiOvMkvZAo2eaefJaTclAEZF/8Ohdmq0n+4f+C80A7dKp+bMWQiT3FGM5dW2/3tIjlLvxCLXr0ydKRDRw7jAyTTU4gXxjJZ9e8bzOPU3pzGQQ9k8fZwAIZe/Xd+/P6KKxPBYypxEdNt9w/OuFAZYYAQ5uGSWAGmh8A9B1jTdIgTe9hloscmrKG73mcij/i6GKCrvrt+wurHfRbcBQB45LWSv/sSGJwnSHopUtoGnul8sEjR/+tao1RozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL0PR11MB3122.namprd11.prod.outlook.com (2603:10b6:208:75::32)
 by DM6PR11MB4676.namprd11.prod.outlook.com (2603:10b6:5:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Mon, 30 Oct
 2023 07:00:02 +0000
Received: from BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097]) by BL0PR11MB3122.namprd11.prod.outlook.com
 ([fe80::7911:8ae6:fc73:1097%6]) with mapi id 15.20.6907.032; Mon, 30 Oct 2023
 07:00:02 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-next v2] i40e: Delete unused
 i40e_mac_info fields
Thread-Topic: [Intel-wired-lan] [PATCH iwl-next v2] i40e: Delete unused
 i40e_mac_info fields
Thread-Index: AQHaB1JrXltoG8XcZEOpdN8gkzD+tLBh7dlw
Date:   Mon, 30 Oct 2023 07:00:01 +0000
Message-ID: <BL0PR11MB31229E718986D5F0F7C7098CBDA1A@BL0PR11MB3122.namprd11.prod.outlook.com>
References: <20231025144838.1827302-1-ivecera@redhat.com>
In-Reply-To: <20231025144838.1827302-1-ivecera@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR11MB3122:EE_|DM6PR11MB4676:EE_
x-ms-office365-filtering-correlation-id: 5bef2ef7-e95d-468a-2456-08dbd915d661
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPtkoKOjGgHKneyJg50stc79QUBPT7QJzGFKPpsLJ7Hqijz3ftJoFKU8pVlxJxt0kcPm84HQrTHQZ6hIM+zTpTgBltJoxcTomZ4V8YbRxBURQBecjD8L06QekJVaOrGn6/KZxZXjWizpSsJCP26eLOvLCNCZY9kz38lpn4zm5lcgn7qoJz+pJNPSarYvI6ZAkMqqm325BKRa/yjTglFBsub0J5jpPuViH3bfvp9/6T0W+4cxNjOng2aEKsk51wGeP3o+ANKZCCswXCIYrYQJl1MfRsD13ZCHqYk9KcurrJdMNioyHX2ZtyfqgxgSg7kU8YEA4PVl1aLUv/aKggwOFT5LqOWnnujnCHacqRlrZ37vIb3aLUiNuDbfgrW83FMHQcBaFKKoaUyXqEjiW3S26uryB91pncAR1YZvDIQi2nJOoNRWjO67d2jc2uOqmSW3MlvA2O5GF0A+ba0w4bBbRkKvOy5/tOoZ7lH8DRq0GwsLMqo4wwzBIp7Ui++V1UY9PyMKd4kFqecjI68qrNJ2oF0D7yIvWQyGg22UwsNLxZGzXx9jT7fNQw3bmz9ylTdFIsqvsEOBz0M/ZtaQvxLvBkckbXLLLQZyzROXEkHnzJM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR11MB3122.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(316002)(26005)(66556008)(66476007)(71200400001)(110136005)(66446008)(54906003)(66946007)(64756008)(53546011)(6506007)(7696005)(76116006)(9686003)(4326008)(8936002)(8676002)(5660300002)(52536014)(41300700001)(33656002)(2906002)(38070700009)(122000001)(86362001)(82960400001)(83380400001)(38100700002)(478600001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2/sWxQwdIIBCk+W0fRH2zrTLYeGokGwIipaK2FPYqy4OXvKj/ziSHxphdhdL?=
 =?us-ascii?Q?PStPUpW8/Z4lnawKNPrSeioTxHekKGFTYQB493di0RiQMXd4qPL1IGRYuJkp?=
 =?us-ascii?Q?V0ffQWXq6tW/DV8RS0LxvU77GVdO+b/DjYUYx+SI+NU+txyo2jJQbyLEk+2G?=
 =?us-ascii?Q?qOGlqUXkyiK6NpJFNcb3rhrdQznXMhZ3foaSweJId0sMzP3P8pSFdhYT9zPI?=
 =?us-ascii?Q?B7yvgdG3l+A7NQah7P+3eqnG/f4l1ADQYMzmhqlAPUH/fldusP2ppNAYGUhm?=
 =?us-ascii?Q?sm+7KlIeX+tCufKuCqcMeg7KpHD+mLsg7YLqwIbpPWj6MeIvAN0vTZi7y3/T?=
 =?us-ascii?Q?BIFsIcj3QxMS76S4TxRU7Y8L1job/5CPnItKhopKMbXA8B0ABD7CbYIpcdFm?=
 =?us-ascii?Q?4rGo/64DEwcKfy5E8hqgP8FUkY1yr7KGriy6zheCBOI/rRzDW20oxILgBhAr?=
 =?us-ascii?Q?EmQWz6DqQALCzboIwRXsQmtxzIiB6EBiJSOo7Y+KoLUW/e81HAS5dsH9cwyg?=
 =?us-ascii?Q?LBbux/+yhJujUP4Ev9PyCxSE4EIq5iXgEGZspF4z/BfTe9Yp2bQgtsoqdUNY?=
 =?us-ascii?Q?dUva8Z1XzcMYvOAvSvEIMuLbk/PF/QSphHPIi3Ww1E6Cw3i9Yo3ad+5QUlkk?=
 =?us-ascii?Q?OyWSy8S/dfKeZDqo1jZmwPSwZt+Bbc7MKi+OxIsH5tialss+GyVqfp21wxW5?=
 =?us-ascii?Q?FDciKjKpfII+LisQNYEk3IH6kUgOD6C29oDGayoYdXavU70b4wREYQag6sFt?=
 =?us-ascii?Q?R3JVQbL0ckOf249XwFyWYWfUk65IcDYZCbMX1AHnCp5a/HbTlhM6ciPN8hxE?=
 =?us-ascii?Q?/pncCHTMcgGPYY1jXYIC1hk4lBdvFVaDseG/GOosVfrHH5ZPwT4dkglREYcJ?=
 =?us-ascii?Q?JGmWSk43EeQr2uzLRkbXiEF8g92dYe09KBK/HlxXcqAjG/RtO6ZpS3Wu9eXw?=
 =?us-ascii?Q?I22zd6kjMjMo9GBM/5PlL/UcmKCFR20ddePos09eJvCYOJWxtWF9QQacSIj6?=
 =?us-ascii?Q?Mmmz5Wf/L+FOj++o0Cymfhr2xtVJ4B07xpiwpsqiomle4bZ9i1QiT4pinPTX?=
 =?us-ascii?Q?rPep5fMk2a58bU0RontkQvUCfvMU9PORWeYEYt8MHxwBry9GNkQsFDIYJ3YM?=
 =?us-ascii?Q?4bDiR6idg72Ib0PsHrCc8sJYnq9Y26aHazXjqIJ0X9nPtXh7IsiQ7RziSDzk?=
 =?us-ascii?Q?HXNIokkcE03/HEorSG6Jh3mxKwlP7sKEY3KLBMjw0zS6sgWxk/hJJPeIajiC?=
 =?us-ascii?Q?FqdB+Vkb4hNkPMkPnLfyN7cTO547I3nX16PsiU88XgYb4OMeX7icH3gPLJ+U?=
 =?us-ascii?Q?KbxACaCK4ZGsDKfrYEjTdVGeOGo9dmYfxKJGZxGoNso0sqU37zk+9XYATucl?=
 =?us-ascii?Q?5c13E+q1Cz0Xl6QmMdUTTbfKYIaRVTLksrQZA6OwYEY3ASTid+aIVdXKJfDT?=
 =?us-ascii?Q?ktqNrapCpn/CHwEdJbYNrxD6ceP5ylAttXcsA2askI7+iUl7lE9+BRpZqyNm?=
 =?us-ascii?Q?EqqqbYEhcp2iOtY9d9tNc4br8TIA9rPQXB9WXL7KzjvXkh3Gzw5Lhx8WbU1T?=
 =?us-ascii?Q?cNPV/9AlWCrz6GhWxB2MG5EUOQlLdHm8JL0eIJMyHojyusII89MvK1CLn4S6?=
 =?us-ascii?Q?MA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR11MB3122.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bef2ef7-e95d-468a-2456-08dbd915d661
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 07:00:01.6700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hY2v+BCSoO/YqNbgrkj235ZjMgRYCUHY/BfPFTUQ0AxsBuavNRCdDu2iUxEWFLShJR8nV6WI1twD3WKqnj8go30YOI3cPf2RNidpNlbHKl6qVAje/5NQBEyFIunUHso
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4676
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
> Sent: Wednesday, October 25, 2023 8:19 PM
> To: netdev@vger.kernel.org
> Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; intel-wired-lan@lists.o=
suosl.org; Brandeburg, Jesse <jesse.brandeburg@intel.com>; linux-kernel@vge=
r.kernel.org; Eric Dumazet <edumazet@google.com>; Nguyen, Anthony L <anthon=
y.l.nguyen@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>; Jakub Ki=
cinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David S. Miller =
<davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-next v2] i40e: Delete unused i40e_m=
ac_info fields
>
> From commit 9eed69a9147c ("i40e: Drop FCoE code from core driver files")
> the field i40e_mac_info.san_addr is unused (never filled).
> The field i40e_mac_info.max_fcoeq is unused from the beginning.
> Remove both.
>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb_nl.c  | 5 +----
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 3 +--
>  drivers/net/ethernet/intel/i40e/i40e_type.h    | 2 --
>  3 files changed, 2 insertions(+), 8 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)

