Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE447FD902
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjK2OLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbjK2OLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:11:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BAADE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701267095; x=1732803095;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nK1JhjO8XnybpvUauLWu9vT6ty58ANUOMn6ZA6THLhE=;
  b=R4Sryw+B7L5y7YROGaHLeAfJzWBTG8IDKHR4S5Kevm5BIoJ7e20L0cBo
   Fygm+RlGEOsweCy2Nujja+NBaKd4MgVxFjIPSbIE17oHdUNsHOiMDq5Qe
   oltEZhTdQg2aIKOkxBoHZe3GeWdW8iZk4e6BGmhu9ajg+uXNZNSggW77s
   PInceFOVF6s3OJlwk8gUXViTAaC+WryzRIUFXPHGM5qOd2wHmMN9EjhUD
   mxqqji8Zi1fNEnQofpBqrkJ/4r/YQ3hNT2XeKcFSS1BPKXwymFDbuzHri
   OpsOpOxlvWGw1lC0S6B4rk6nYCr7mO96dX0m4HU683VDAzoY5NuTiZd9H
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="392032086"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="392032086"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:11:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="892462033"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="892462033"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 06:11:34 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 06:11:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 06:11:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 06:11:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAW65RDZqFwRLrKYN6/W5dh77XtV1r1mc5ynN1nSVdfRsDAz8lFdFs9QnNcQ3R2V7Q1p+405PyuILLVLzbG0y2Cdqkpo3diZT2s+r3e1kb/VUq+eAWEMTxyUlrAaBJ9rIR9r65DZxTmsxSBsXE8LoVL/ooIyyPpbfyI6k20upe0RiH9L19BG0kOp8sO5KQezBW0fDJmczavbCELtaHNPgrSJJEnCHpXg//Spqr0KSz7XKVlbBEhYOIlOlS9ZIEfjUfwDl/7mrGdVvYEGN0y37un2jNxkzrvmUgmxcikK7gB28UqLNYFu4XZozSqWUaAqYRDfFreRL8dXRIUU9nBZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bFxEB7+7g2L6ixHoZnmFGBqeXPF4zHOpjh5d9WuFPBE=;
 b=U0++sbZov3Hrjp6pvWphHW1T1DpU85Oen/PqpnwGLR5fhDO2CZUuDsya3RP91chcKx2Gh5iYQE5Fre4OmfIkafsWNNWUZ1/7lwZi8tLDy+AOdGEImvgIBNJupv+tyVavboLhjLeBgRjBbcWfAkmj/xg3RzPsQAWpgnlU3HxUdY247MZY51YlckeT40M6eo+GgLYzr0FXf5MC5gU01GucRkq4O6Q6eiK3TyL4kY3BDlQXWwZkbhW+hkRw2XS5Q9pkFTDVq6WDkSgRNHSPngSSnS8bp36BOim/UxFG+8gNGZ+YrYpAdXpSUzwdowedR7uJoMrX8g401jR4VJVIdew7Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB4316.namprd11.prod.outlook.com (2603:10b6:5:205::16)
 by SA2PR11MB4857.namprd11.prod.outlook.com (2603:10b6:806:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Wed, 29 Nov
 2023 14:11:21 +0000
Received: from DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::2738:cbf0:1b80:8a78]) by DM6PR11MB4316.namprd11.prod.outlook.com
 ([fe80::2738:cbf0:1b80:8a78%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 14:11:21 +0000
From:   "Wu, Wentong" <wentong.wu@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Wang, Zhifeng" <zhifeng.wang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] mei: Add MEI hardware support for IVSC device
Thread-Topic: [PATCH 2/2] mei: Add MEI hardware support for IVSC device
Thread-Index: AQHaIfdexoS2VwuEC0a0G/ZumI2RtrCRCGqAgABLeyA=
Date:   Wed, 29 Nov 2023 14:11:21 +0000
Message-ID: <DM6PR11MB43169C037DC770A0941BF7E78D83A@DM6PR11MB4316.namprd11.prod.outlook.com>
References: <1701174846-16316-1-git-send-email-wentong.wu@intel.com>
 <1701174846-16316-3-git-send-email-wentong.wu@intel.com>
 <ZWcD18B916Xs1JiU@kekkonen.localdomain>
In-Reply-To: <ZWcD18B916Xs1JiU@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB4316:EE_|SA2PR11MB4857:EE_
x-ms-office365-filtering-correlation-id: c6f275e5-293a-4c60-cc6b-08dbf0e51022
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AeqkAGCG3V5HxwT4//WP5xrpaVfagh/F3IhWq9t5GgCEmA1GSVLKLjFNoWIo3vFJeiSBBje3U3r9zzpBKRgngFKxK2twYBqhehsPgZKVJUkoFuhe8bjJLJ4T3vstfmTugGi88eNAc9z3gaIV+PGfMwyzVvSNZVquHKVXVKjUIV5+G2sCZTyHA0F9YPf3B8+/tx5O5GYHzq90uFyrHeL0L73toq0uEGnmQBJZz7L2YkMcZAAuMRvQgJoE6lDmk/QrFbao662Dq/SeUHZPuGcApWibGra8/033il9mlMM4QCq5ATQ1xyQUOLtM0jqYLNTWzzvUWK6qHPj72YXolU4XtEThvhaSWD9SrGbjZxDYUenI+r4valc6ufDAlC4LefHUNwWwTyGgBln6sCQO63AwfQl+ipZTTgWrAPjYUiaynBCNm92anIPac4NK02yVoUI7ud+QwA8OSyomehzNO7kQOE9KNio92lztsAYqrwaV2L5EYnf2TmIm5R1JFIfBVtLHygR3pnIY4GbXLyTFuHY/rB9iLf3AXPd5yK1fALhNFIdOBMGeZigG6FGPvhjxBYpV6BEy2GOzhQMLhMnShwANmC+/TW8vPd2lRuCENEsc7mZtVr5miFTwvi+lTZrjetcG/YBqAETIInTnr61yJjTQBkE1f3EOjhE6h5oLPzjAoZw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4316.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799012)(64100799003)(83380400001)(38070700009)(26005)(64756008)(54906003)(66476007)(66946007)(66556008)(6916009)(316002)(76116006)(66446008)(2906002)(4326008)(8676002)(52536014)(8936002)(5660300002)(86362001)(7696005)(41300700001)(6506007)(71200400001)(9686003)(33656002)(478600001)(82960400001)(122000001)(55016003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lV0qQTM3wsYl6an8yZ4N/JYlPV1PQciIiWh7vgMPOyMHrxVbNsXkfYyKBiFm?=
 =?us-ascii?Q?OpCLY1sbiLcVib+1zW465SoxF9FgIHDDnXffg3e5bWFzmzNiA5M9m5kQ7WSz?=
 =?us-ascii?Q?WMG3KVS3AGsHook0vVJe4y+w/+n7cLP6jymKZM/dpF81tS9QylbkSPUM8O/y?=
 =?us-ascii?Q?VAbsQjcr8cOapqySAZvPQ6d76XokJ1RwBQQ/NwdH/wFDkUXZ/dDcc/HTVhnd?=
 =?us-ascii?Q?NDydyxKi/+2lfQkvIJnERT0ihsDK+Ip2xHDd9UdOTpuxv+aE3ZmocwjT2wje?=
 =?us-ascii?Q?hoxL91oyV1aQuOUgDvxDrRYX7mJtXNP0JsKC9QYJORccNxYHTBZ/2Ts4K9G4?=
 =?us-ascii?Q?iHsdmwum16Pyy0DbD8zU/24ZbkoobHHeGXfZBDgSvMTCMH7OCmbf3f2/uHEy?=
 =?us-ascii?Q?DVZfl0twU3iS290cVHworEAZC3qdpMWuVhm8/7vVKvaFMo2IfuT/aDw9QTXD?=
 =?us-ascii?Q?oPVwqfPc9OSKCtSx5+NwIEAd/OjCZATxsyULAbkTDk88EpwoGVoV/bt2a7zU?=
 =?us-ascii?Q?v4PIkUkEJ1Yp2h4LvpG6AUThrOHFjRyg1Bu8zU9w3eoeVJiXrObfYk9JOtrR?=
 =?us-ascii?Q?69/b1SR4p5V2xg8x08rTW9gKAHK5DW2bnYPXwEFFO2QlwodlwVmwIofeutCh?=
 =?us-ascii?Q?eK90xPym+/FzCCEn4rUhCjjJMWI8pYW0NiT+Cm6Tl0biQ+KPH6Qw4QluUJBy?=
 =?us-ascii?Q?S0mMtncY97ldjU3NwcDvmvViRGZh9IrGGReukrF8E+Z6DvvVprb2mHQM5dQw?=
 =?us-ascii?Q?0dkeOz1CD2ovuJlNoG5KOWbIkvyGhypJqNbCndl+i7I6WkbtMFCVHwLd97EQ?=
 =?us-ascii?Q?+127AuocNWebXPh5r3nfE8gBB0gZ6hhkUE1rx5clez0ofPOh+XMAvYQH4N/N?=
 =?us-ascii?Q?JDHcrcT5zO7XUKeUPDGkpcSvfzV2e8Hf2LZ8Z6qxY2BybJN6v8/QS3bdGPXQ?=
 =?us-ascii?Q?rXA63YrUKZwf36mEiePGP2d5bXaMlNEx5bE0WlQqWZdxClXheFOWykxYNlsQ?=
 =?us-ascii?Q?pjYDYVmrSOajlVwdJyeUdJnEWszGE4aqnjbhqtqiwMsv2PkUJEXJYETD8320?=
 =?us-ascii?Q?CsTDFRDPFyvQSxsXFf7VZRLyJmdjoclH92NrR6OpL5takJ1skv9kcK711LYU?=
 =?us-ascii?Q?sMFD4C3ExF2uF5mFBo1zZ5uYmo8/3BNFbKMS/cRD5/c5s+K3ZT1EC7bOIgD9?=
 =?us-ascii?Q?oIY3AQi+LNnn80NEkd/b9ZUjpL/Lr6n/VYql9s4wrukHjG3Tly2BDhNrV801?=
 =?us-ascii?Q?sCtxe3yjR9L8DMRMKFTpw6fFG/Lu7SHBCQqabd4SEDkqu9Yn4aF/JDAZywAe?=
 =?us-ascii?Q?RjmYbCFRSoMbwvtJx6akGkrxLSRp7WYMeoUSEsHDOabL84BGl0NpcefDExd1?=
 =?us-ascii?Q?WFhrvv8+qBdFfHoLR25kgpAhxzwcdlWmvNkyGKarJLm7uonBvR6NQfYkQ332?=
 =?us-ascii?Q?4WPKyvW6+qfHcdj5XR4mmarfi3HFkcYOID6ItM9ir73XHoMf7pk/J5K4vDLn?=
 =?us-ascii?Q?gadH8VXzoafLIwRrrHBOB9bEm8CoeB9lSTegtNC+4t+/PtMNxzZt4GayckKS?=
 =?us-ascii?Q?DyAEJlAWeGE7sH7Va2df6t0OKW8EtxrAf62Sghh2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4316.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f275e5-293a-4c60-cc6b-08dbf0e51022
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 14:11:21.1656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F3stY+MnCpjAm/2ZQa0pdjfWQPpghHroar/3xJiIDJPoWxWOns2NUkoD7eI053uQN5Z5EkA3M1WmhtGBWQaBIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4857
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

> From: Sakari Ailus <sakari.ailus@linux.intel.com>
> On Tue, Nov 28, 2023 at 08:34:06PM +0800, Wentong Wu wrote:
> > The protocol used for the IVSC device to communicate with HOST is MEI.
> > The MEI hardware interfaces for the IVSC device are implemented.
> >
> > The APIs are exposed by MEI framework to mei clients, e.g. mei_csi and
> > mei_ace.
> >
> > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>
> > Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > ---
> >  drivers/misc/mei/Kconfig        |  13 ++
> >  drivers/misc/mei/Makefile       |   3 +
> >  drivers/misc/mei/platform-vsc.c | 442
> > ++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 458 insertions(+)
> >  create mode 100644 drivers/misc/mei/platform-vsc.c
> >
> > diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig index
> > 470957a..2c5312b 100644
> > --- a/drivers/misc/mei/Kconfig
> > +++ b/drivers/misc/mei/Kconfig
> > @@ -71,6 +71,19 @@ config INTEL_MEI_VSC_HW
> >  	  This driver can also be built as a module. If so, the module
> >  	  will be called mei-vsc-hw.
> >
> > +config INTEL_MEI_VSC
> > +	tristate "Intel visual sensing controller device with ME interface"
> > +	select INTEL_MEI_VSC_HW
>=20
> Changing the select here to depends on addresses the Kconfig option
> dependency issue=20

Yes, this is the plan to address the warning. Thanks

> (as select just blindly selects the options while ignoring their
> dependencies).
>=20
> I wouldn't mind having a single Kconfig option for the two drivers either=
.
> They're always used together, aren't they?

Thanks and yes, currently they're used together, but we may have more
flexibility if keep them separate to cover future hardware which may has
different transport layer.

BR,
Wentong
>=20
> > +	depends on INTEL_MEI
> > +	help
> > +	  Intel MEI over SPI driver for Intel visual sensing controller
> > +	  (IVSC) device embedded in IA platform. It supports camera sharing
> > +	  between IVSC for context sensing and IPU for typical media usage.
> > +	  Select this config will enable transport layer for IVSC device.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called mei-vsc.
> > +
> >  source "drivers/misc/mei/hdcp/Kconfig"
> >  source "drivers/misc/mei/pxp/Kconfig"
> >  source "drivers/misc/mei/gsc_proxy/Kconfig"
>=20
> --
> Regards,
>=20
> Sakari Ailus
