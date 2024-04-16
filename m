Return-Path: <linux-kernel+bounces-147744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ABF8A7876
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 368261F22069
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC3813AA56;
	Tue, 16 Apr 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eOfYWwfd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133B2375B;
	Tue, 16 Apr 2024 23:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713309117; cv=fail; b=jFRE6SztX9e5FO59sc7UW5r80cnvOnqok30C/qv5nFMO2mm0Cu0DrgGbO4/Xxf3YDWlras9QcH2Bo8gueszxMi1NLlCYP3Hr0cB4r3NP2V4HcRvHRPrwDAMkhQQ2ZHIN3ybPxAAOriGHkY8wAKIlsDvTh9/ogzxZTOcP5OSQABk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713309117; c=relaxed/simple;
	bh=qEkKHUwV5jGatM3QdKIA5AJj+husC7sqWxD/laf9XTQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tRqil9vI5oM5fxuEviThKnJIwdMowWlrf3xB001fm+W7BghQTEi1qd4352s4cSxk8bXUYOYHmlNJ0t1K6zrGw0p6fwAeCjsd+BFiky4w55kW0vfCMy352odJqNesE4GAL+mHiLidjl1e1yQAVkrT4rzjgq8JjTomgGwDszJB5TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eOfYWwfd; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713309115; x=1744845115;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qEkKHUwV5jGatM3QdKIA5AJj+husC7sqWxD/laf9XTQ=;
  b=eOfYWwfd7UzpwKMsl8d6+S6AK8oUpNjsgAF/ggQybXcwejwBcGv62hiV
   /B71Os83vLoA5ZhlkMbLFH9C17+ObYMDjOwd0NdOD+okOQ35b4N9Xe6WN
   odbCr0OLIMIUaNSsCO6E5g3RkUpGZPT0nTMouIaRtmBdH97RCqHz/OOzg
   38PMy8twsciaoIFd6WrmS+mpLbGloIR3zeVfkDIEhpkKWhpThcDBJwxle
   EICnMzMEa0lXUoLFs+QIB4oogP/l9eScO31WxahCRGhWhH1vijyEoMmLu
   QM6pMLZksuAbLaRgg8Ec1vTLC7PUm8vxqJih+LuL3wwm3DetH1YgT6QJA
   w==;
X-CSE-ConnectionGUID: 65p37w3+SXWymZva4CJwXg==
X-CSE-MsgGUID: CBj3JuV2THeZHYzLl2zEqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="26292729"
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="26292729"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 16:11:54 -0700
X-CSE-ConnectionGUID: y5pV9CKsQX2a47j636nkjQ==
X-CSE-MsgGUID: B6AwO1aoSQyvjMkPEILXbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,207,1708416000"; 
   d="scan'208";a="22474941"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Apr 2024 16:11:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Apr 2024 16:11:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Apr 2024 16:11:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 16:11:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOMtixRUHv+fnucDPRAxPFPo9ymt6xKZYXEUahOe0wOZrnSJmVK1ZsgNJU4uEOCq4bDuXg5wwdgVuYt2LC6fmSI89br5Y97Vyu6M0xSUX7NZoqU3QqWKi23QEcj9Qn26y3SD3CX1WprzNiKpVn94I58SfpCYGu4mir2QOYeUc6X77JS4M/0wjebciLH32UqaaGyaXQIftK5HMbWAhtRcVnNRC4MpcPIjIxT0c3CXN5+twueK85yCFUrLXiev1f5MAtlPVZKjR7WP5HNBba8Tb9gkQkcm3XF4d0E3IPb7g4/xmHVhKfTdD+CxdHLh1TMYx/2Mcc+fBkzoIjQrykgmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmEfj/BFbOClSJxLsKePDBiv3d45Jkdxf0xqvuNd/K8=;
 b=aSw7ODCiZo2JgP3RlpRaTfbMXh1OfWfPro41rEaWcqktCn7cjEFbvNZfCmsGoWFrfHZvdW3aB6x6UXs2UwZGoTlcfPHXKUc01X2tWB4aeGs78HAps4MPi8vij9+E1fMucY5AUkFnFSkLOg0TXQVfNrJWxAYEUaHAZRUF9hv/REf1EnGNK7hu48ihwPdPj1TQ/Qo/ym10EfQFTrAji/TG9m/SPYx+cpav1p/i02i37Jy3wFTQGETQr/9u5Ry0epXDUvAzUvxBRxFOZ/JYcRXEjzGvwfICHxr7gPmDtC3TKMwiB1OEQqgyxL7lwlSQCYiEMCvBxGEDLhxOaoaSrkL4ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8115.namprd11.prod.outlook.com (2603:10b6:8:12a::12)
 by IA1PR11MB7823.namprd11.prod.outlook.com (2603:10b6:208:3f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 23:11:48 +0000
Received: from DS0PR11MB8115.namprd11.prod.outlook.com
 ([fe80::4cbc:6f18:8a83:eba8]) by DS0PR11MB8115.namprd11.prod.outlook.com
 ([fe80::4cbc:6f18:8a83:eba8%3]) with mapi id 15.20.7430.045; Tue, 16 Apr 2024
 23:11:48 +0000
From: "Brelinski, Tony" <tony.brelinski@intel.com>
To: Erwan Velu <erwanaliasr1@gmail.com>
CC: "Velu, Erwan" <e.velu@criteo.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net] i40e: Report MFS in decimal
 base instead of hex
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net] i40e: Report MFS in decimal
 base instead of hex
Thread-Index: AQHaegg6neZffGD5e0S+FmrljmaqmLFrshmw
Date: Tue, 16 Apr 2024 23:11:48 +0000
Message-ID: <DS0PR11MB8115E4BC956EDCC0EF61DB7B82082@DS0PR11MB8115.namprd11.prod.outlook.com>
References: <20240319141657.2783609-1-e.velu@criteo.com>
In-Reply-To: <20240319141657.2783609-1-e.velu@criteo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8115:EE_|IA1PR11MB7823:EE_
x-ms-office365-filtering-correlation-id: 118f9975-ea25-4651-65cf-08dc5e6a97dc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HrkfOHg11hw2mRRKbQxawqsyA6z+ROrVk230k+NPfNOxmmwoIEX1Jxa0g/bQaxmbyM9LLi5fwq8VN4fD63yAyopiPC49KGFZxJj0kPoEVy+n5eVOIGOm8vCAJn1L1EFBcVtEC273uBjy7CeBZQCRvBkX0TkwbImsMZRNwVR/WT2Tn0VBkcQVxk/qVzi1xglqltO+wZT9EtycjWN9PytbHHkqKKqyCBe+JB67zp6x6PF5A1+X8CkYdj37dLngE5tXkLs8EymuCnKrsZ9YFmELKnL9DHhfUiFMN4HVEWK0P1WonNIE65wpbjjNT37atgLloOAi7SE9Lix9rh1bmO4+ltB+mhb8wuAeJ2RjVBjQmijLBziWKjST79Y1MLez8ouqpT5OTzjCWVuqdG6HbyK5rTgItAd06pv36VU1Pu+OHwbAtL7/OF75QtmYghXCUeNnI413gS/+VHypKMfel5C7zqYiTp6H4efJ2EuxblosOtcuBQlXwPK4vOks14IUqf0U+LTyefZywItx5D4839ad1MzaY842vE9GvKj4gPrqKs75Y26LA0Yit5zd57rylbj74/8zYRRoXZ9uMjkew0ZtpZWqi9M7ZivFux9aVKyfn2DmJebz65v3XfV2yvX5/O6bQgRbr+6/vSrQyR38gsFEEZxv8fIRPkruiKJjedLd+eFLeGDBp+DXUQ3ggyQa9+gx3W9Vfbbzq+xPrrJZOTNthw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8115.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ptnzhPTpFZ+CKZJ2BdTs+JDZgEEwF1sUnkAYm/M5zz1wehb2Vv7udF6PB44C?=
 =?us-ascii?Q?vb8uQEmkDbFMGy+7L1X8ymUNHaPB2UElti0j0nzGNr7CutP2XTG731jRG3Bd?=
 =?us-ascii?Q?4E5xOqO6RSORORxafHxh0G+RdHCb0ufk110IrcrVakGaJH6GDiOX3F04E4SD?=
 =?us-ascii?Q?cMOOb4IF3Ix9SpqccAYg3YgbY0Eb3OuNEoI8CpGLG0GIJ49IG+L8Pu1zNM4V?=
 =?us-ascii?Q?z+L7deN4IgHk5I+5VBAxN9alaa+aj8r2hBwlU1+86Hs8HQP5xWTlD70obP7l?=
 =?us-ascii?Q?K+GkjUXbaUDdDJ8x99TQwhc/vb5lODn6tLQvomTs98VT16Ku5JiS3r9yhoU6?=
 =?us-ascii?Q?pLiMcilo5nuyelU6G9nVWhHthDk1nmyj8FfHti2lrExzxxnFkM7rG3juT1vJ?=
 =?us-ascii?Q?coyVRC6SU4CVI6ObqAgZCMhs+OC//JX/kfxt3cA8g3ci1ojfHAkaZ3yDxUqH?=
 =?us-ascii?Q?RzwAk8dl92My4/n7QD3XmqmHcw1RzKaaJoyjREHfEdNsKPHgLjG8eqwqSEwJ?=
 =?us-ascii?Q?tj4rB+vKQDqAkjV2qPvG06KQddKf9Ad6GM1A+W1fBdjKXHXb2YVMcQXLC4ek?=
 =?us-ascii?Q?LtJ98Y3uFlzMPZmQBxp/2ng/D/tg3gi/Lj44uRhugIAQH+mFp64sMAAx12tH?=
 =?us-ascii?Q?5Uc9Qi1QU2JtX9pI9kkZEXByK+0KjojSAowIXHJJZb/ogUCiUJ3soCy5GKUo?=
 =?us-ascii?Q?yUER743JMZRZkxBnRGdotZhXLIFefALbOjXD+iRIBYQks/iYURD7nrkjTE/B?=
 =?us-ascii?Q?d/jHrBLnSnarSnknV1HOyn9Ya+y4ykNcfX+nZh1ZbdMoi7P5cCZ0vzte0r9m?=
 =?us-ascii?Q?zS8UtF/OAjdC8kbb/w8w22QSmH07YEMLNZCRCUum0J80AzvM/S0nQLVCkRYw?=
 =?us-ascii?Q?sd7Rc0FuqXfUnZzl2/JrsOJqH/CncSvwUN2Ppol5mFl5XpIALWDDD1i1iSxK?=
 =?us-ascii?Q?YBT3EvACUNtvRfhCBfIn/uPIxrtFlzB8y90bl14yLEYv0nVDELQdmZyOa1yx?=
 =?us-ascii?Q?FAqt04ztwvIzHXogQmmbSvz5ZZGyLZADx43EDHYqO754CI2FTyq5wsD10Kj7?=
 =?us-ascii?Q?0DdJ1r9PhB6wMe+4mVbZonVgIH021zPyegTgapdAlayGtXeQpTkgDcwmqok9?=
 =?us-ascii?Q?oTft/VE9ePUG4lGJCZlH05oRh+ertpQJAXipqgDeHkhSAWMhRGfXg5Z1mpFs?=
 =?us-ascii?Q?QMmKvm9MDtC/YtY6UBQDjKCwE7ZvNWCWR5+9j6vwornVCU8iBmBFsEOUq6r9?=
 =?us-ascii?Q?BUNkEE02JIFCl1l4wfACGhUrSDAIwePYIf3ay/UKSLs9Mq8Cn338JED8bkj3?=
 =?us-ascii?Q?iXUzbpju9IcxdhcgZlHI/8AziDWeaRUy8QcLug8MGYhI/M4JEdz0FLZH23P7?=
 =?us-ascii?Q?UFQXu7beU69Cgm1Nx/ZUJeMpaoI3ouS5K5zd3j1PLeIsPonOKPPV4nmCh4QN?=
 =?us-ascii?Q?k3JFoKvk9Bb4y0L36kD4S2RcwgJ1Gno7yUFeeKF0o9DdwSDbmTdCFkMpuKwh?=
 =?us-ascii?Q?4KnHzKnci3paNg6FHopLhLd59vBrQLHoil5yKoOXJxw7zD+P0EZyShJfIk3r?=
 =?us-ascii?Q?IQJUL8WTubAhpYsZNkFLiBNueKVFKf8FUqfhS5AO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8115.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118f9975-ea25-4651-65cf-08dc5e6a97dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 23:11:48.6926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hkh84HHn7oyJHkRj6fNYKPVH2ziXZxLV2VdNm5QNRQPeUuHLqBb51VoHPESRmokkGiAHwAH7IRw7qOYiiBE9agJtdekMroeEzjkH+QF/Mqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7823
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Erwan Velu
> Sent: Tuesday, March 19, 2024 7:17 AM
> Cc: Velu, Erwan <e.velu@criteo.com>; linux-kernel@vger.kernel.org; Eric
> Dumazet <edumazet@google.com>; netdev@vger.kernel.org; Nguyen,
> Anthony L <anthony.l.nguyen@intel.com>; intel-wired-lan@lists.osuosl.org;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; David
> S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH iwl-net] i40e: Report MFS in decimal ba=
se
> instead of hex
>=20
> If the MFS is set below the default (0x2600), a warning message is report=
ed
> like the following :
>=20
> 	MFS for port 1 has been set below the default: 600
>=20
> This message is a bit confusing as the number shown here (600) is in fact=
 an
> hexa number: 0x600 =3D 1536
>=20
> Without any explicit "0x" prefix, this message is read like the MFS is se=
t to 600
> bytes.
>=20
> MFS, as per MTUs, are usually expressed in decimal base.
>=20
> This commit reports both current and default MFS values in decimal so it'=
s less
> confusing for end-users.
>=20
> A typical warning message looks like the following :
>=20
> 	MFS for port 1 (1536) has been set below the default (9728)
>=20
> Signed-off-by: Erwan Velu <e.velu@criteo.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


