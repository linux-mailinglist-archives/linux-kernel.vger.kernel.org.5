Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D27ADC6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbjIYPzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbjIYPzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:55:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CF6BC;
        Mon, 25 Sep 2023 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695657303; x=1727193303;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l3/QCNVG8CCULKHKZa3ve9Y9Yvu9hlxEjPcTkkVmkxw=;
  b=nuj7qTUUw+vh3iD4f8QUwwpoboLNp3cr71+MtUfl1SsL05+QT6yzDAPF
   xp3hozdjAl93GJaYRO/SQaP9pgmQajngr6OTUBBrPpo5e94O4bDROYvqK
   V0Bda10AGg1OKwJ2lI0GbwoyM7hrEWH4wRrOi+BDiH2SuxXRPngClHcjQ
   MqT5iPE41+rZq9xmELguIQgaZznTYk0/afWk92+kSxQVlB6+hl3hou5vQ
   9xLV9hQqQWia0NLlCVBITuzkrcBlUNhx+YLMc0uAQv3FOI+9pVMuum5ha
   UUFKWz+BaqsutNqmEqEeyOCvlJMrpA9ocXeh4OuvH3xwzosbDXHfI5+xk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="361539473"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="361539473"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="891733491"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="891733491"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 08:53:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 08:54:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 08:54:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 08:54:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRPTQMLQRK/zTAsKnvOn6XucWU/7W5SxjiUkyBOenJOZRP9ffPevCxrqn7wAwnptHwCrp1yQVPsDRQw0FtjmVSSf98s2Qf+BUprL3lpj+hZ2j87lhsfvs+wQ42rzl5LSYHbyaBMgFqNZ4vunTVtR6ftvwSep5tHzWx829ymKL4bWHkkc1CdF7IpG4yOyoVbvNJEGbB+StFe6p+XRopwN9thjv3EyLiAIFuQRe2scwWox90K4GnpoB+2T29UAnqAploAZAjvMYmzXK25QoR08nL3ZZ1CQY4D3oT77z3Zv1iy+GxrA2oLC0dKiK0eIVXKNa56QXz5yhX8iUPS7w2buXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKo92Vri6lGqJmyv4jmo5/1rs2/j9ValLqeJhtX+IhU=;
 b=IgmYFmZSuqdpqDY+U44pdRvQxR6Su10xhLBgixzeY3K8S0BjGiGMWe38R1PeDqUjjjufyWtbF0svsA+4rGSGmjd672gh1y4d/Qxm4bGHv+qhvRwVXAxYk1cayaLKLSQU8wZzLZBJXf9+vreo4APVP/KPIqgZ6JPcdNp3U6cm1RA3OKOpk4HFuBnAuG5vXo/26HWQKGFJXkUgjJXU48+3VMplQz0ZYPqVoNTuP153xu9v4jaPMYnDAZHxBd8XfioarFs17dmZmXCM6u3xfZYi9Kxo6Z3t9niPAwa5Z9+lOEempsN0T58abyxA6vDhI/jcMe4X120DGcNaKEWgCmpNNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY4PR11MB0037.namprd11.prod.outlook.com (2603:10b6:910:77::29)
 by BL1PR11MB5304.namprd11.prod.outlook.com (2603:10b6:208:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 15:54:40 +0000
Received: from CY4PR11MB0037.namprd11.prod.outlook.com
 ([fe80::7de:e06d:bb71:4345]) by CY4PR11MB0037.namprd11.prod.outlook.com
 ([fe80::7de:e06d:bb71:4345%6]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 15:54:40 +0000
From:   "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: RE: [PATCH v4 4/5] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Topic: [PATCH v4 4/5] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Thread-Index: AQHZ62rbNkeZhAZZx06GIHaJQh/KW7AjypoAgAIVhzA=
Date:   Mon, 25 Sep 2023 15:54:40 +0000
Message-ID: <CY4PR11MB0037E70612B8067062AC1C40A9FCA@CY4PR11MB0037.namprd11.prod.outlook.com>
References: <20230920023243.2494410-1-utkarsh.h.patel@intel.com>
 <20230920023243.2494410-5-utkarsh.h.patel@intel.com>
 <ZQsE5hgm4qYpr/My@smile.fi.intel.com>
In-Reply-To: <ZQsE5hgm4qYpr/My@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR11MB0037:EE_|BL1PR11MB5304:EE_
x-ms-office365-filtering-correlation-id: 1d4105b4-8529-4fb6-d92f-08dbbddfba58
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5h38tNHDkmB+gOX8hjJPXg1BC/A6hzANUiu6bq0ilxhAFbh/RIGcfb0iZ8jLKVX2+qwuUkVj8tmXVWTDuNE8uOFELhacDzCcEIUx2G1guB1jsI3BbJg9bgTCgPHRgIr8n/qqJTco/siVmP345ssv88t/LXiPxHWgThHqxrCpTR/wUeAMfz86wTQ6TwOR4atvxUCvdqsjJvqyIK5zOOSAH/ppyzehS2HByzo0sNHLyVckRy5NIDbNnt4Oo1HKIU/H6dgJ3EjYcI/FKUQVHcEU9H2+ZsJ3a3uahHVfEyXO0uwNn80YxvO4nmpx4dtchFOKyxCYGH/p1v7gQXu4xzesm1ZNxsZ9ngSRIp8wbPG7AgQSENlaK6B8PCXmhmzED6N9p2cXNA+XQs156SJgaEO2d1VSi5dzok1QOmRqhmPxGhgEXT6X6GEq3ZP8YbkZCsn6cCK5aA1/Y8tM3JJTZvFURbIToD7qAfMuMeYkGsBitAxHUsqhC1fwFm7O1+9SSKfdNar4HK974cBK5X41r9CRsbWKpctxN1INqP8o+Bhoiac6skY+ArwuLh+eqjK9EJlUyqCs4iTvmRL2ClJqbs566R8y27YWATXbUimmy7gzeqYW5tNDNghR9onv9DhPH0j+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0037.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(186009)(451199024)(1800799009)(5660300002)(55016003)(2906002)(54906003)(76116006)(64756008)(66476007)(66446008)(66946007)(66556008)(316002)(52536014)(6916009)(8676002)(4326008)(8936002)(41300700001)(33656002)(86362001)(6506007)(7696005)(478600001)(82960400001)(122000001)(26005)(71200400001)(9686003)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AFY8Hf/L8MAVhqdATGg5XHdhNMXkaGnIhwe/FCarOmLYjjGbKMhekTxBxSn9?=
 =?us-ascii?Q?G/ZRYYybGCy0MDZMmKVx3bu3/ZtnOhasNClBxZWNW31fafQZ6Li/FlBh8Q+g?=
 =?us-ascii?Q?oVHZzaKecVnfbwJiNDVayPCvX/TQNsnKHWiE9gmr6iraHPqMSb9YDuiYfWCC?=
 =?us-ascii?Q?CAXlCiZ8eV/88K742nZTechsPrAefVPFtKKCvazt4S+wd4EDKA9AIUxHPE+G?=
 =?us-ascii?Q?/e6LZeSAeF5aiO5VDHINTxcb24loy/qKhcgCUtiJ+zTTn/bSwK38PY7VKVrK?=
 =?us-ascii?Q?igBco3jBLjC4DDk5PktdZhz1o+0k4Dy/2UZdu2y2PmfFKbBV/VbSTXsnoYVv?=
 =?us-ascii?Q?2+L7Vc3cr3uWGuwAqePmKNuK2DSZ6lRAptU0S2WqbRDNIWeH8huFNpZQnpo5?=
 =?us-ascii?Q?HhDC/XRohCCdCmuut6GbQJeX225Gre2JbUNPsW3h0afLCI5zQufw9MCR/+4a?=
 =?us-ascii?Q?AAKbYyXtqxU/W3vJejRgvn4LDepD7DMpAKnkYHPO3rAJHHSQ9RCavyr0XvtO?=
 =?us-ascii?Q?oY8xJrnZ216r97o5dFzwe5xxsLjcpdFsIdawVirLnJ3Tov7Fjug3LEi2k6Ck?=
 =?us-ascii?Q?qlwm9tcgcGeiTbZBGAhHnxaIb/xQ8/0vqsGu+zUv0ySGnnD02Iea02kwUbpP?=
 =?us-ascii?Q?p7Jx7Cilwa+k5KuhiMX1+dNYC+6ilUfks1WbPKOaYciwS3s87xOnDHZig4CN?=
 =?us-ascii?Q?zljaA47Is4BhxR2tw7R1K9J+bBIuNHJ+3e53fyviQPglI4m/S0a4s4dbPJyx?=
 =?us-ascii?Q?M6+JMD/3cM6mSiRz/tSmepu3yA6Qgy0FsqUmleCCoR+/QDe5CwMrgoux2fUw?=
 =?us-ascii?Q?0+yQ5fBzsl3XvzYuXkTtW155YYJudbsfgcy5bYJeeuxwUcFY9QWkop0ZqZPU?=
 =?us-ascii?Q?jga3uAueJ0Q33p3h72iwzT+SwTYerD+H3JN8Qh9KwcTnIigSkD5Oq8qeRJH4?=
 =?us-ascii?Q?dPvIVGod1NyzdR6UtNJufgaCVsDVFQ8Kg0fi9VmKcpERlqibbd0XnRWz6uVW?=
 =?us-ascii?Q?7Miuvgm9b7ZI6g5H49q5YGIyibDIVswc7VOAUDtMouIr5fcsdbIR1mZ2KSvI?=
 =?us-ascii?Q?Zi+T7xXk9U4cfidgTBy0UidTnUGoM6RfPRp3uUA9oJFLPJPCs+oGfW+xh9Ks?=
 =?us-ascii?Q?N+Bgm+WKxb0eBY8futlfAw353uy0mkRqhNaaftZhSqlmthKaySbsfN601841?=
 =?us-ascii?Q?+nT39HddvS0lGmtAbRnwOot9fEVz7+VfUq0/hHyRv2qp3uzwcZSV4u1tmM9J?=
 =?us-ascii?Q?77Dwhpu5kcbsQwJbqio0jaT1QWNUBy+YGT5iUgswQ8SVYmXI5O3dnlgwISJP?=
 =?us-ascii?Q?BzmkDIVbN+F41G5uLq+EWOGo2e3cOIBlZKjaP26FN9YRwwXNYha6O5eHRApH?=
 =?us-ascii?Q?6cj3cqDbQFNgSb5dtrjuNl/K6kFSTW5tVRBoX3CRvj++Ywl44ITtxvVIXd8U?=
 =?us-ascii?Q?yfMPNqJNb+xi9PDRw/hs6fuiMHuLDDyEHZZiDUctUwe2Y5KMjOJ95QpTPew6?=
 =?us-ascii?Q?9M9yBwfzzMdiilyLfBCl8ieYOuq9P4P2roEEeOel5ZmnUO20I7Lw1ms5xm8J?=
 =?us-ascii?Q?0Hz2ezVk5HvMxZUoJ1qwKbbzqxrr4eNcw9PepugZKF6renpG5VBmLpw3U9I0?=
 =?us-ascii?Q?xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0037.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4105b4-8529-4fb6-d92f-08dbbddfba58
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 15:54:40.4299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mxM73aHbLWMA8MOGxYgAWZVyPVlFirWhnKhA2imYW46W/fvP7WrTJaTWT/zjhoY5RWcrQJhfeYdBfEuGS+Pr/kccQynuAW7JJ2NZVpcrZ68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5304
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Thank you for the review.=20

>=20
> ...
>=20
> > +	/**
>=20
> Are you sure?
>=20
> > +	 * Get cable VDO for thunderbolt cables and cables with DPSID but
> does not
> > +	 * support DPAM2.1.
> > +	 */
>=20
> ...

Yes, there are TBT3 cables which advertise DPSID but does not provide any D=
P capabilities in the DP discover mode VDO but does support UHBR.
In that case, need to use TBTSID and use capabilities from TBT discover mod=
e VDO.

>=20
> > +	if (cable_dp_vdo & DP_CAP_DPAM_VERSION) {
> > +		dp_data.conf |=3D cable_dp_vdo;
> > +	} else if (cable_tbt_vdo) {
> > +		dp_data.conf |=3D  TBT_CABLE_SPEED(cable_tbt_vdo) <<
> > +DP_CONF_SIGNALLING_SHIFT;
> > +
> > +		/* Cable Type */
> > +		if (cable_tbt_vdo & TBT_CABLE_OPTICAL)
> > +			dp_data.conf |=3D DP_CONF_CABLE_TYPE_OPTICAL <<
> DP_CONF_CABLE_TYPE_SHIFT;
> > +		else if (cable_tbt_vdo & TBT_CABLE_RETIMER)
> > +			dp_data.conf |=3D DP_CONF_CABLE_TYPE_RE_TIMER <<
> DP_CONF_CABLE_TYPE_SHIFT;
> > +		else if (cable_tbt_vdo & TBT_CABLE_ACTIVE_PASSIVE)
> > +			dp_data.conf |=3D DP_CONF_CABLE_TYPE_RE_DRIVER
> << DP_CONF_CABLE_TYPE_SHIFT;
> > +	} else if (PD_IDH_PTYPE(port->c_identity.id_header) =3D=3D
> IDH_PTYPE_PCABLE) {
> > +		dp_data.conf |=3D VDO_TYPEC_CABLE_SPEED(port-
> >c_identity.vdo[0]) <<
> > +				DP_CONF_SIGNALLING_SHIFT;
> > +	}
>=20
> You can also make it a bit more readable with (use better names if you th=
ink it's
> needed)
>=20
> 	u32 signalling =3D 0;
> 	u32 cable_type =3D 0;

In v2 version of this patch I had them but there was feedback to remove ext=
ra variables and use them inline.=20


Sincerely,
Utkarsh Patel.
