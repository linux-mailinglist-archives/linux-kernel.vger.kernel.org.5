Return-Path: <linux-kernel+bounces-142436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 302568A2B85
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73F771F22861
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E3951C4D;
	Fri, 12 Apr 2024 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="hosywOeU"
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699051C34;
	Fri, 12 Apr 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712915244; cv=fail; b=UDd5EQImrwCZ4iUcpzFLg6eWxshCS72RaQj+r6pCvWggC9NUPBXsMIjpGebO+v0D6Esqho8llf3N5upRvuI6fqwbd0+4DiAd7EKImlToJ+gNrlpYPLByrobEVuipLOdCT3dEVU/Fpiv4lwGf0CUZhxgfp1fGhO9knTih5G6UIvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712915244; c=relaxed/simple;
	bh=2Q2lwN8+6z0pCYTu9qxSbpKUZzP1VcY8GYMsedZ6wgo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cyEjbLuSulMX8npyxKvZafGUyPd9RXtr4cKsKjoZr9hdBhTtpziFWwOFfSmpEu31G+hocYuxzoVHY0lgaMx1zlTKY3O0LkIjS3Fj4ZwtMcn+pBT6sUH1UkTpMcwNtNgAcotszy4TZYtzpMqcxnPucZHLW0cU7N+n1G5RYMN8KNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=hosywOeU; arc=fail smtp.client-ip=173.37.142.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=30517; q=dns/txt;
  s=iport; t=1712915242; x=1714124842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FAEPGblQ79FNQbgCcgC74gogRN7iQlvGI0s6PgSwxbA=;
  b=hosywOeUJpw0hA2RfDlZcLP/qmDcx6jn2pbW3JtjdJUqs2u4XsYH//TR
   FSptVZM+Hzew/UxPQFmXgyMmJngEg3/6Fi2/DkkqXtfPPoTqbN3+7k+a/
   HTWmSwZ2GGZwsoB0SpWaTDPtiDBJCRYuguTN9gBRUx+io+283/rbP8Y2z
   8=;
X-CSE-ConnectionGUID: d21ZRNYaSyqXnTQJXy8t8w==
X-CSE-MsgGUID: OmEdWGDMRs+Vhi4ZwKXL6g==
X-IPAS-Result: =?us-ascii?q?A0ABAADhARlmmIcNJK1aGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQCWBFgUBAQEBCwGBcVJ6AoEFEkiIIQOETl+GSoIiA4ETkC+MR?=
 =?us-ascii?q?oElA1YPAQEBDQEBMRMEAQGFBgKIFgImNAkOAQIEAQEBAQMCAwEBAQEBAQEBB?=
 =?us-ascii?q?gEBBQEBAQIBBwUUAQEBAQEBAQEeGQUQDieFbQ2GWQEBAQECARIIID8FCwIBC?=
 =?us-ascii?q?BEEAQEBHhAxHQgCBAENBQgTB4JeAYI8IwMBpRgBgUACiih4gTSBAYIWBd1+G?=
 =?us-ascii?q?IEwAYgrAYo4JxuCDYEVQnltSjg+hEMChBKCLwSBFIEeZYQmhHOCdkoRHWqER?=
 =?us-ascii?q?oEOgStIA4I4Pz5ohGlUfRwDWSERAVUTIQk6DwwaAhsUDSQjAiw+AwkKEAIWA?=
 =?us-ascii?q?x0UBDIRCQsmAyoGNgISDAYGBlsgFgkEIwMIBANQAyBwEQMEGgQLB3WBfoE9B?=
 =?us-ascii?q?BNHEIEyihcMgzMpgVApgRKDIgtCcYQgfANEHUADC209NRQbBQQfAYEYBZx9A?=
 =?us-ascii?q?YIMEVsGAQYOKT4TARsZFwkGKyEdGBUIDQQaCwEPDB4rD5JFCRE4gmKQCJ19C?=
 =?us-ascii?q?oEyCiiDa4wOiFeMfheEBYFWiyiRe4c2mGIggjSgVA0TDYUGAgQCBAUCDwEBB?=
 =?us-ascii?q?oFkOoFbcBU7gmcJSRkPjiwNCYJ6hTeaV3g7AgcLAQEDCYZIhCABAQ?=
IronPort-PHdr: A9a23:WKWXYhbi4AgS2y2QHtYdGk3/LTDlhN3EVzX9orIuj7ZIN6O78IunY
 ArU5O5mixnCWoCIo/5Hiu+Dq6n7QiRA+peOtnkebYZBHwEIk8QYngEsQYaFBET3IeSsbnkSF
 8VZX1gj9Ha+YgBOAMirX1TJuTWp6CIKXBD2NA57POPwT5DZj8mt0eev05bSeA5PwjG6ZOA6I
 BC/tw6ErsANmsMiMvMrxxnEqWcAd+VNkGVvI1/S1xqp7car95kl+CNV088=
IronPort-Data: A9a23:pdy9Za9KaSsgvVmrsDiiDrUDRH6TJUtcMsCJ2f8bNWPcYEJGY0x3z
 GIWDW2DOqzbYzTxctF/boS//R4CvpTQx9E3TVNrrXhEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmE4E/ra+C9xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4utyyHjEAX9gWIsbjtOs/vrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dgJtb
 7+epF0R1jqxEyYFUrtJoJ6iGqE5auK60Ty1t5Zjc/PKbi6uCcAF+v1T2PI0MS+7gtgS9jx74
 I0lWZeYEW/FMkBQ8QgQe0EwLs1wAUFJ0LOdeEqFl/2a9FzfQ33Q+tdeHREqbZJNr46bAUkWn
 RAZADkJahbGjOWszffhDOJtnc8kasLsOevzuFk5kmqfVqhgGMuFGv6XjTNb9G9YasRmA/3ea
 tAfbidHZxXbaBoJMVASYH47tL313iOjI2EF8Tp5o4IQ5kXf8yNd9YL2c+TVe4C4WuZluhiX8
 zeuE2PRWUxCa4fFllJp6EmEgu7JgDO+W48IErC83uBljUfVxWEJDhASE1yhrpGRjk+4RsIaJ
 0sf0jQhoLJ090GxSNT5GRqirxasuh8aRsoVEOcn6QWB4rTb7hzfBWUeSDNFLts8u6cLqScC3
 1uNmZbiAiZi9efTQnOG/bDSpjS3UcQIEYMcTSNeFDk/xejqm5AqvhTzd/RTAf6p3sKgTFkc3
 Au2hCQ5grwSi+sC2KO64U3LjlqQSn7hEFZdCuL/ADvN0+9pWLNJcbBE/rQy0BqtBI+dSl/Et
 38elo3EqusPFpqK0ieKRY3h/Y1FBd7bblUwYnY2Q/HNEghBHVb4JOi8BxkldC9U3j4sI2OBX
 aMqkVo5CGVvFHWrd7RrRIm6Ft4ny6Ptffy8CamOPoQWOMchKF/flM2LWaJ29z29+KTLufxuU
 ap3je79ZZrnIf0+k2roHbt1PUEDnHhmmws/uqwXPzz8jOLBPyTKIVv0GFCPdes+pLiVuxnY9
 s0XNs2BjX1ivB7WPEHqHXooBQlSdxATXMmuw+QOL77rClQ9QgkJVaSOqY7NjqQ4xcy5YM+So
 CHkMqKZoXKi7UD6xfKiMC4zM+O+Ackm8xrW/0UEZD6V5pTqWq72hI83fJosdr5h/+tmpcOYh
 dFcEylcKpyjkgj6xgk=
IronPort-HdrOrdr: A9a23:bsslgKkELbN9iAk+ZxEQGU6TLzTpDfNQiWdD5ihNYBxZY6Wkfp
 +V7ZcmPE7P6Ar5BktApTnZAtj/fZq9z/JICYl4B8bFYOCUghrYEGgE1/qi/9SAIVyxygcz79
 YbT0ETMqyVMbE+t7eE3ODaKadh/DDkytHUuQ629R4EJm8aCdAE0+46MHfmLqQcfng+OXNNLu
 vm2iMxnUvZRZ14VLXdOpAtZZmxm/T70LjdTVotARkh5AOSjTWuxoLbPnGjtCs2Yndk+5tn1X
 LKvTDYy8yY3s1TzCWy60bjq7Bt3PfxwNpKA8KBzuIPLC/3twqubIN9H5WfoTEcuoiUmRQXue
 iJhy1lE9V46nvXcG3wiwDqwRPc3DEn7GKn4UOEgEHkvdfySFsBeo98bMNiA1/kAngbzZdBOZ
 FwrjukXl1sfEv9dRHGlp/1vtdR5xGJSDQZ4LQuZjdkIPsjgfdq3P4iFQVuYdQ99OaQ0vF6LA
 GoZ/usucq/fT6hHgXkl3gqz9q2UnspGBCaBkAEp8yOyjBT2Gt01k0C2aUk7zo9Hb8GOtJ5Dt
 7/Q+5VvaALStVTYbN2Be8HT8fyAmvRQQjUOGbXJVj8DqkIN3/EtpayudwOla6XUY1NyIF3lI
 XKUVteu2J3c0XyCdeW1JkO9hzWWm2yUTnk18kb7Zlkvb/3QqbtLES4ORwTutrlp+9aDtzQWv
 61Np4TC/j/LXH2EYIMxAH6U4k6EwhXbCTUgKdzZ7ujmLO8FmSxjJ2uTB/6HsubLQoZ
X-Talos-CUID: =?us-ascii?q?9a23=3AVJafM2rcI1xKhE/c2Wf3d07mUcx/K0/n6kbZGF6?=
 =?us-ascii?q?hOWBVcZ+lWA+MqLwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3Ah8Y3DA9rx25S/Z1y7qdryXeQf+BtzqiRJ2woq45?=
 =?us-ascii?q?FhcmFaR5vGAe50jviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
Received: from alln-core-2.cisco.com ([173.36.13.135])
  by alln-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:46:12 +0000
Received: from alln-opgw-4.cisco.com (alln-opgw-4.cisco.com [173.37.147.252])
	by alln-core-2.cisco.com (8.15.2/8.15.2) with ESMTPS id 43C9kCIC012279
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Apr 2024 09:46:12 GMT
X-CSE-ConnectionGUID: SCweo08sSRyUZ4jCbESzjQ==
X-CSE-MsgGUID: q+WUKTPHRrCMa1J2y3kZcA==
Authentication-Results: alln-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com; spf=Pass smtp.mailfrom=vchernou@cisco.com; dmarc=pass (p=reject dis=none) d=cisco.com
X-IronPort-AV: E=Sophos;i="6.07,195,1708387200"; 
   d="scan'208";a="27777001"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by alln-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 09:46:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1LWYwzJnYpgW5mCr+N/wK3QZvYnR8iSZcq/iXUwbcz1D8wsVigZHSbx6eYCwpR1tx4yDk1NJDE2k5SJOxbG9XEft4z/+65sia6yxUFSYRpKWXidKTPwE5I5/QrFPCvqluSZ2PdxJIsoyRKkqkxbUEqjl7OmrnYKfnHML+Bh+rMTIMIaeKHw9xqHJmsB9kI5r/jU8dWO44b2KE/IeEm1aSllKHCT1aJTt+i+Bc7L3jnSOu2MKMV93OY+pdjWH6YiVw3JDxrC7Ezn3HNuxhRo5UwXDnL9hSRKO3RKGN6tu4xQJM2CNQPWcbMyoRNxmviDfz0ShcjwgnxXmTiNl+lNLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAEPGblQ79FNQbgCcgC74gogRN7iQlvGI0s6PgSwxbA=;
 b=Ih9SYh6ZKxqFn6jf3iXeSrhlm21MeWvZqGWZQJAWaiGf9a8QCMCOdYCWohZgaU0SUl3+1EcpbjxA69JCOfL6ZVGryiDO3k9usqlx3Af4EyQOncC2woazDiNLOH71x2J9gtSVtU32AOD+Wq7AJqwDiYAJ4JTaN8DoOHWF+/QRx6e6QUnh9vSk/HsYUlnJG0QKiyHaWmcjmV1lyYTgybRxEanSGyT8FoXWKrpXQNC0zJ/6DA42x5XcHts4wc1EMTHch743yUD4o+HELPGBHb+oJKjMSghcVN7cxBLsF9E2rnZk38kHxoM3c1Vb6vP3a8oQRwp6g41dQcp9IIpmV/JfGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from DS0PR11MB7765.namprd11.prod.outlook.com (2603:10b6:8:130::8) by
 SA1PR11MB8373.namprd11.prod.outlook.com (2603:10b6:806:38d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Fri, 12 Apr
 2024 09:46:09 +0000
Received: from DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::d142:4626:e291:96cb]) by DS0PR11MB7765.namprd11.prod.outlook.com
 ([fe80::d142:4626:e291:96cb%6]) with mapi id 15.20.7430.045; Fri, 12 Apr 2024
 09:46:08 +0000
From: "Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco)"
	<vchernou@cisco.com>
To: Nicolas Schier <nicolas@fjasle.eu>,
        "Daniel Walker (danielwa)"
	<danielwa@cisco.com>
CC: Nicolas Schier <n.schier@avm.de>, Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Add MO(mod objs) variable to process ext modules with
 subdirs
Thread-Topic: [PATCH v3] Add MO(mod objs) variable to process ext modules with
 subdirs
Thread-Index: AQHah3oweea7kfF3nUimhkbf9/nABbFi+owAgABhnQCAACDwgIAA6GrcgAAHvRo=
Date: Fri, 12 Apr 2024 09:46:08 +0000
Message-ID:
 <DS0PR11MB776555B8AA40A9851261E677DE042@DS0PR11MB7765.namprd11.prod.outlook.com>
References: <20240405165610.1537698-1-vchernou@cisco.com>
 <ZhfLrGrED-ls6i5V@buildd.core.avm.de> <ZhgdjpE+yl3IYSzl@goliath>
 <Zhg5L2xO_lT4lLwp@fjasle.eu>
 <DS0PR11MB77652A4C98FCB671F5E5F3EEDE042@DS0PR11MB7765.namprd11.prod.outlook.com>
In-Reply-To:
 <DS0PR11MB77652A4C98FCB671F5E5F3EEDE042@DS0PR11MB7765.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7765:EE_|SA1PR11MB8373:EE_
x-ms-office365-filtering-correlation-id: 454b8cf8-12a9-405a-a580-08dc5ad56169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 suJQ9gnFCDXOVFCXsQVS5X++K3BhcUGjm88t8Jmmb4P2mhFbhAOLrLjFuJvxlfiX1TVOY0zxgJygI6icoknbOKDQRwZ+U/V3ZKGm+FPhmNYimAveFtvyKApq0+VoPTHqYmimcRabXI7SxUqOEXyqpiINcR/YGDwYCF0CGm77gQbCptSvuyBAlRDEkGZuZfqohUeYPMWx1eQ3/mG4jDE1ZsJovHk7XH1uswoVvhh+Av04X8DOp/s3bI5/JlkQg6mjBDUqH9JiEgRjkFl3RZJdenxnu2rxBmhwsFXW/wzX0MSI9QsHBomKGaFxAr7NJFC4XMyrd1U5ngGV9eIaOXPNF3l3GAy7XLoH6srj2SUqd0Y3uGQLKBQiF1iW6Q5RaNNOw5o95clFBjO1PnTV3UOzDZ2pxs2SIpNSkfY43XxWUgfY53QZd2JeBfP9Rj4QZDuzxltJluXzAzSKpUFbBk4Opl2b16AaQnDuBFtOgp4IB0nv0MqK+weHtmn2XqDA8XizqL/7bDyNEHabVTIWZna6gMvjRFdRbjLnmGYDl6PAiFLPf8qo+0dCsypFGPvXT8/0lzvHt2F2rHXonbiOefikob39gjgcjzE9vu5D49HeAIhBt0H18edG7juGuJpH5mcDQQwSbdcLPtcgNqAqnaBan9ij4lAQ4BxIzplcnB34dU8C3/WpfziPsxQediXseNX70zg1QWTg7FUnI41rp4kLP7dJP8VPS8aGUxZtQyTXkwg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7765.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BS9pXOkb3RFX5ky57bOlYS3wyN7Rr6xXw3v7LgnjD6OtzZhWv61bNMT5r/dM?=
 =?us-ascii?Q?SVz8Ro1OLzo7Q/PvPsQsFCfSHCumcdqsEeWo0WFDP52LrCkKRvJqGLPin5vI?=
 =?us-ascii?Q?HWGPrpA/USADKTIbMayNLQLYUijWCDEOpYCZX7jylTv34S0+GkRTjqghumFd?=
 =?us-ascii?Q?0DHzoEi91SGRWdcvu56VqsjcKZa6zLZZXmX6HSgsB8D4oOB1wSzvxo5ZfYKX?=
 =?us-ascii?Q?NWjMPEGQEyNGgH0d1OMl8G/ni16n22vSwrIrcN22yThzjvETStOWMOoLBwHc?=
 =?us-ascii?Q?BgdOYKrrCb1qj75tcFbNjKRCQouSyfBDD99oQDaoXcbs9ZfJ9SjLaAYZ4epO?=
 =?us-ascii?Q?9uq7o0a6ALiMHQsBd9rfsLmJfAd5VSotZthy8bUYz//Y8Wwrx+vHXYA7bB1Y?=
 =?us-ascii?Q?mpVIYdNKFltkOYBuZJhmmButPDlHFdbcU3DA3/0aFK90Vec7kmhly9SSP9ig?=
 =?us-ascii?Q?y9NIpobiqC09w2jXkRv8gERrDdbY6nTbYa7xDWTqxb59J5sj09YS1c10EsLw?=
 =?us-ascii?Q?nThADzlCpHrDDTqOx93jZZmJarw7ZsemtC+oI+XnsIZ3krDHfJMqITC5AgPX?=
 =?us-ascii?Q?sW7XICewTg1Q9kma8EQzqh6sg8Ub+0nT+NwKn3hHjCOH5Y8yLG5UQtUtSH4q?=
 =?us-ascii?Q?n+mcCop1jfo1QRHo+RNJN461ET5XbWl5w7d/aR7Sn2OhJungKivU6HyvP0x5?=
 =?us-ascii?Q?QFOVS3OBVG+zvL2eEx0tsHU5on+IvhHzgwmJqA4PnGvJ20dKpiiPWJkRy4P6?=
 =?us-ascii?Q?lMcEBvZFvA8A6SRYIjbNnpmLLqMlg/fIlg6McxMNsbwIpczbEPB8x3ZvMUm0?=
 =?us-ascii?Q?aXpdXPA77ci0WBKTIZOIYapdE/qOdjDmkxtTZM2QvUjcEmTuANE50+G1h5CM?=
 =?us-ascii?Q?BIJqWwk9O2xKHRq6ap0nFdWhw9hviKcqo3+5PExhd45Qkh55vM0D+IDOc81G?=
 =?us-ascii?Q?FijDWkCG0zCBaA0FtNxETWBA1W/NnKIghFuqr781i16S8HVx8tkLAQgvVVKZ?=
 =?us-ascii?Q?DXEPeKtiwWp82bUznbJtH6Jg9ATM84oLVeFJxE9YTrEY6WbJzkFIcqZjNEit?=
 =?us-ascii?Q?x3y1nTdx6o9j5GF5oQNOLrnUibLQok5zfkzHSlsuxmGOwEcTRHJM70MeH26d?=
 =?us-ascii?Q?+4MYMOI/ES1J9xVDQtCKiG1lDqP7WPWH8hjnXLBGJHv/3uOZCHEf6FTaT32W?=
 =?us-ascii?Q?gReC/JKlWs0dWjG259uf6N6DQOhD0UiYUAVARNruZbTCugoWEFaVsxJPBTc4?=
 =?us-ascii?Q?/hbYN+VB59VtK4fDNLG0aYemjX27++YHFgTU25iWfApyHGGHHr73KmY2x2CX?=
 =?us-ascii?Q?hXHmfWuNMHze1cNjqr0RhQDD8QhNuRZtaupp05/D4qpkGm9uvqsq/6pKT2KB?=
 =?us-ascii?Q?TCq8bIXl2+XeVC8nD4DvYSF4QdAPR7dISFlGBaaQmKh3fXPhZrhvvHVBRdYd?=
 =?us-ascii?Q?NbmCmL7Xb54dQEfipB4AXXBeu89/TCkj793OcX5sQgRV0hURnuO1f4hpwg++?=
 =?us-ascii?Q?piz5vImfPIt6HOh7r03bpJpsQHJ1bUzKnh4+R7IDS5/mxvDOQlREAKCFdgk8?=
 =?us-ascii?Q?Fo2ywTWPkB42sxLJqLfsaPtX20f5XvzHdU9bjY+VMH5XgrY+bXi64FaD4SVI?=
 =?us-ascii?Q?wA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7765.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 454b8cf8-12a9-405a-a580-08dc5ad56169
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 09:46:08.8390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qajdBqkSddhJqT/3HjDvEWnKEP/rZKst/aNa9VGDozFtCVCDvw3tRH7Dc3M0MmUO+9oga2SZERxsOxFNSsBJoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8373
X-Outbound-SMTP-Client: 173.37.147.252, alln-opgw-4.cisco.com
X-Outbound-Node: alln-core-2.cisco.com

Hi Nicolas,

Thank you for your review and comments, let me answer to your comments:

> Hi Valerii,
>
> thanks for your patch.  I know several non-upstream kernel developers
> that would like to see support for out-of-source builds of external
> kmods (and we developed several work-arounds at AVM as well); but please
> be aware that patches that don't fix or enhance the in-tree kernel/kmod
> build but only add feature for out-of-tree stuff, are rarely accepted.
>
> (Rational: better upstream your kmods to have them in-tree, especially
> if they are so complex that they need subdirs.)
>
> That said, I'll try to give some more concrete feedback below.
>
> On Fri, Apr 05, 2024 at 09:56:08AM -0700, Valerii Chernous wrote:
> > The change allow to build external modules with nested makefiles.
>
> better use imperative statements to the code itself:  "Allow to build..."
>
> Does "nested makefile" mean that you want to support external kernel
> modules with subdirs and Makefiles within?

Short answer "Yes". I tested my patch on couple of external modules with
subdirs(Makefile included into each subdir) and it working well for me.

> > With current unofficial way(using "src" variable) it is possible to bui=
ld
> > external(out of tree) kernel module with separate source and build
> > artifacts dirs but with nested makefiles it doesn't work properly.
> > Build system trap to recursion inside makefiles, artifacts output dir
> > path grow with each iteration until exceed max path len and build faile=
d.
>
> I think I know what you want to say with this sentence, but I am not
> able to parse it correctly.  Might you want to rephrase it a bit?

Could you provide more details what you prefer to see into patch descriptio=
n?

> > Providing "MO" variable and using "override" directive with declaring
> > "src" variable solves the problem
> > Usage example:
> > make -C KERNEL_SOURCE_TREE MO=3DBUILD_OUT_DIR M=3DEXT_MOD_SRC_DIR modul=
es
> >
> > Cc: xe-linux-external@cisco.com
> > Cc: Valerii Chernous <vchernou@cisco.com>
> > Signed-off-by: Valerii Chernous <vchernou@cisco.com>
> > ---
> >  Documentation/kbuild/kbuild.rst  | 14 +++++++++++++-
> >  Documentation/kbuild/modules.rst | 16 +++++++++++++++-
> >  Makefile                         | 17 +++++++++++++++++
> >  scripts/Makefile.build           |  7 +++++++
> >  4 files changed, 52 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbu=
ild.rst
> > index 9c8d1d046ea5..81413ddba2ad 100644
> > --- a/Documentation/kbuild/kbuild.rst
> > +++ b/Documentation/kbuild/kbuild.rst
> > @@ -121,10 +121,22 @@ Setting "V=3D..." takes precedence over KBUILD_VE=
RBOSE.
> >  KBUILD_EXTMOD
> >  -------------
> >  Set the directory to look for the kernel source when building external
> > -modules.
> > +modules. In case of using separate sources and module artifacts direct=
ories
> > +(KBUILD_EXTMOD + KBUILD_EXTMOD_SRC), KBUILD_EXTMOD working as output
> > +artifacts directory.
>
> That means, iff you use KBUILD_EXTMOD_SRC and let KBUILD_EXTMOD point to
> some other directory, you _have_ to be sure that your kernel supported
> KBUILD_EXTMOD_SRC properly or your module will not be build at all,
> right?

If you will try to use KBUILD_EXTMOD_SRC but kernel doesn't support it then=
 module
will not be build at all because module sources with "Makefile" located at
KBUILD_EXTMOD_SRC and "make" can't use this "Makefile"(it try to use Makefi=
le from
KBUILD_EXTMOD but it actually point to artifacts dir with absent or empty M=
akefile)

> >  Setting "M=3D..." takes precedence over KBUILD_EXTMOD.
> >
> > +KBUILD_EXTMOD_SRC
> > +-----------------
> > +Set the external module source directory in case when separate module
> > +sources and build artifacts directories are used. Working in pair with
> > +KBUILD_EXTMOD. If KBUILD_EXTMOD_SRC is set then KBUILD_EXTMOD is used =
as
> > +module build artifacts directory.
> > +
> > +Setting "MO=3D..." takes precedence over KBUILD_EXTMOD.
> > +Setting "M=3D..." takes precedence over KBUILD_EXTMOD_SRC.
>
> (Just a note, not a complaint: This confused me while reading it the
> first time, but I think it is correct for your patch.  Personally, I do
> not like the semantical change of KBUILD_EXTMOD/M and would rather
> prefer the introduction of some more explicit names like
> KBUILD_EXTMOD_SOURCE and KBUILD_EXTMOD_BUILD instead.)

Yes, this semantical change little bit confusing. We discussed this issue i=
nternally
(inside my team) but at this point decided to try upstream current patch ve=
rsion
because doing this work without this semantical chages require much bigger =
patch(maybe
even patch series) and will take much more reviewer time and work

> > +
> >  KBUILD_OUTPUT
> >  -------------
> >  Specify the output directory when building the kernel.
> > diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/mo=
dules.rst
> > index a1f3eb7a43e2..b6c30e76b314 100644
> > --- a/Documentation/kbuild/modules.rst
> > +++ b/Documentation/kbuild/modules.rst
> > @@ -79,6 +79,14 @@ executed to make module versioning work.
> >        The kbuild system knows that an external module is being built
> >        due to the "M=3D<dir>" option given in the command.
> >
> > +     To build an external module with separate src and artifacts dirs =
use::
> > +
> > +             $ make -C <path_to_kernel_src> M=3D$PWD MO=3D<output_dir>
>
> Is it really good to evaluate MO relative to the kernel source or build t=
ree?

 At this moment there is not so much restrictions on "MO" presented. You ca=
n provide absolute
 or relative path via "MO" and, yes, it is possible to provide some ugly co=
nfiguration but
 developers should understand what they provide to kernel build system, is =
not it?

>     make -C /lib/modules/$(uname -r)/build M=3D/somewhere/source MO=3D../=
build
>
> might accidentially lead to ugly inconsistencies in the kernel build
> tree (permissions presumed).
>
> > +
> > +     The kbuild system knows that an external module with separate sou=
rces
> > +     and build artifacts dirs is being built due to the "M=3D<dir>" an=
d
> > +     "MO=3D<output_dir>" options given in the command.
> > +
> >        To build against the running kernel use::
> >
> >                $ make -C /lib/modules/`uname -r`/build M=3D$PWD
> > @@ -93,7 +101,7 @@ executed to make module versioning work.
> >
> >        ($KDIR refers to the path of the kernel source directory.)
> >
> > -     make -C $KDIR M=3D$PWD
> > +     make -C $KDIR M=3D$PWD MO=3D<module_output_dir>
> >
> >        -C $KDIR
> >                The directory where the kernel source is located.
> > @@ -106,6 +114,12 @@ executed to make module versioning work.
> >                directory where the external module (kbuild file) is
> >                located.
> >
> > +     MO=3D<module_output_dir>
> > +             Informs kbuild that external module build artifacts
> > +             should be placed into specific dir(<module_output_dir>).
>
> What about "should be placed into the specified directory <module_output_=
dir>." ?

Do you think it will be better to use "will" instead "should", whole phrase=
:
Informs kbuild that external module build artifacts
will be placed into specific dir(<module_output_dir>).

> > +             Parameter is optional. Without it "M" works as both
> > +             source provider and build output location.
> > +
> >  2.3 Targets
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > diff --git a/Makefile b/Makefile
> > index 4bef6323c47d..3d45a41737a6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -142,6 +142,7 @@ ifeq ("$(origin M)", "command line")
> >    KBUILD_EXTMOD :=3D $(M)
> >  endif
> >
> > +define kbuild_extmod_check_TEMPLATE
> >  $(if $(word 2, $(KBUILD_EXTMOD)), \
> >        $(error building multiple external modules is not supported))
> >
> > @@ -152,9 +153,25 @@ $(foreach x, % :, $(if $(findstring $x, $(KBUILD_E=
XTMOD)), \
> >  ifneq ($(filter %/, $(KBUILD_EXTMOD)),)
> >  KBUILD_EXTMOD :=3D $(shell dirname $(KBUILD_EXTMOD).)
> >  endif
> > +endef
> > +$(eval $(call kbuild_extmod_check_TEMPLATE))
>
> Same checks make sense for KBUILD_EXTMOD_SRC, also if MO is not set.

Make sence, but it will require more changes with defining template
kbuild_extmod_check_TEMPLATE. Will update in next patch version.

> >
> >  export KBUILD_EXTMOD
> >
> > +# Use make M=3Dsrc_dir MO=3Dko_dir or set the environment variables:
> > +# KBUILD_EXTMOD_SRC, KBUILD_EXTMOD to specify separate directories of
> > +# external module sources and build artifacts.
> > +ifeq ("$(origin MO)", "command line")
> > +ifeq ($(KBUILD_EXTMOD),)
> > +     $(error Ext module objects without module sources is not supporte=
d))
> > +endif
> > +KBUILD_EXTMOD_SRC :=3D $(KBUILD_EXTMOD)
> > +KBUILD_EXTMOD :=3D $(MO)
> > +$(eval $(call kbuild_extmod_check_TEMPLATE))
> > +endif
> > +
> > +export KBUILD_EXTMOD_SRC
> > +
> >  # backward compatibility
> >  KBUILD_EXTRA_WARN ?=3D $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index baf86c0880b6..a293950e2e07 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -3,7 +3,14 @@
> >  # Building
> >  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > +ifeq ($(KBUILD_EXTMOD_SRC),)
> >  src :=3D $(obj)
>
> I would leave the 'src :=3D $(obj)' stand alone unconditionally, to
> clearly separate the oot-oos-kmod support from default in-tree kernel or
> kmod builds and in-source but out-of-tree kmod builds.

In case of separating in-tree and out-of-tree src processing it will be not=
 couple
of line patch :)
Main idea of patch is create some small change to provide required function=
ality.
Current processing of "src" do required work, it only need to have proper v=
alue of
this variable.
Also, please, don't forget that each new line of code require engineers tim=
e for
supporting it into the feature. My opinon - patch must provide require func=
tionality and
should be as small as it possible

> > +else ifeq ($(KBUILD_EXTMOD),$(obj))
> > +override src :=3D $(KBUILD_EXTMOD_SRC)
> > +else
> > +src_subdir :=3D $(patsubst $(KBUILD_EXTMOD)/%,%,$(obj))
> > +override src :=3D $(KBUILD_EXTMOD_SRC)/$(src_subdir)
>
> bike-shedding:  see below

I think it's a good idea to use next line instead of my couples of lines:
override src :=3D $(obj:$(KBUILD_EXTMOD)%=3D$(KBUILD_EXTMOD_SRC)%)

but creating separate Makefile and do additional changes it's not required =
overhead.
It increase code size and request additional resources/time on supporting c=
hanges

> > +endif
> >
> >  PHONY :=3D $(obj)/
> >  $(obj)/:
> > --
> > 2.35.6
> >
>
> Testing with a simple module w/ subdir, compilation fails for me:
>
>     $ make M=3D../stupid-multidir-kmod/source V=3D2 MO=3D/tmp/build
>       CC [M]  /tmp/build/subdir/module.o - due to target missing
>       CC [M]  /tmp/build/hello.o - due to target missing
>     scripts/Makefile.modpost:118: /tmp/build/Makefile: No such file or di=
rectory
>     make[2]: *** No rule to make target '/tmp/build/Makefile'.  Stop.
>     make[1]: *** [/data/linux/oot-kmods-MO/Makefile:1897: modpost] Error =
2
>     make: *** [Makefile:257: __sub-make] Error 2
>
> (similar for 'make clean'.)
> The test kbuild files were as simple as:
>
> .../source/Kbuild:
>     obj-m +=3D subdir/
>     obj-m +=3D hello.o
>
> .../source/subdir/Kbuild:
>     obj-m +=3D module.o
>
> Does something like this work for you?  If I understand your proposed
> commit message correctly, you have some working example with subdirs?

Looks like working example, try to run next cmds before run build:
mkdir -p /tmp/build && \
touch /tmp/build/Makefile

Probably, this hack still required like into unofficial variant with using =
"M" and "src"

> ---
>
> Bike-shedding for inspiration:
>
> While experimenting with similar solutions at AVM, we did the same src
> override but also auto-generated dummy Makefiles in $(obj) with something
> like:
>
>     ifneq ($(if $(KBUILD_EXTMOD_SRC),$(filter $(KBUILD_EXTMOD)%,$(obj))),=
)
>     # If KBUILD_EXTMOD_SOURCE is set, enable out-of-source kmod build
>     # support, in general.  But do not disturb the kbuild preparing targe=
ts
>     # that need the original behaviour.
>     #
>     # Thus, iff also $(obj) is set and points to some path at $(KBUILD_EX=
TMOD) or
>     # below, we really want to set (override) $(src).
>
>     override src :=3D $(obj:$(KBUILD_EXTMOD)%=3D$(KBUILD_EXTMOD_SRC)%)
>
>     # Generate or update $(obj)/Makefile to include the original $(src)/K=
build or
>     # $(src)/Makefile.
>
>     _kbuild_extmod_src_makefile =3D $(firstword $(wildcard $(src)/Kbuild =
$(src)/Makefile))
>
>     $(lastword $(MAKEFILE_LIST)): $(obj)/Makefile
>
>     $(obj)/Makefile: $(_kbuild_extmod_src_makefile) FORCE
>          $(call filechk,build_makefile)
>
>     $(eval filechk_build_makefile =3D echo include $(_kbuild_extmod_src_m=
akefile))
>
>     # Clean-up the variable space
>     undefine $(filter _kbuild_extmod_%,$(.VARIABLES))
>
>     endif
>
> but we still had to add a dependency on $(subdir-ym) for all object
> files in any kmod subdir to enforce proper dependency handling.
> Fortunately, we almost stopped using such "enhanced" oot-oos kmod build
> things.

I don't saw any additional requirements or dependencies into my builds, all=
 that required is
processed by current rules into Kbuild, it only that required into my case =
it's provide proper
value of "src" variable

> HTH,
> kind regards,
> Nicolas

Best regards,
Valerii


________________________________________
From: Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisco) <vchernou@c=
isco.com>
Sent: Friday, April 12, 2024 11:19 AM
To: Nicolas Schier; Daniel Walker (danielwa)
Cc: Nicolas Schier; Masahiro Yamada; Nathan Chancellor; xe-linux-external(m=
ailer list); Jonathan Corbet; linux-kbuild@vger.kernel.org; linux-doc@vger.=
kernel.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add MO(mod objs) variable to process ext modules wi=
th subdirs

Hi Nicolas,

Thank you for your review and comments, let me answer to your comments:

> Hi Valerii,
>
> thanks for your patch.  I know several non-upstream kernel developers
> that would like to see support for out-of-source builds of external
> kmods (and we developed several work-arounds at AVM as well); but please
> be aware that patches that don't fix or enhance the in-tree kernel/kmod
> build but only add feature for out-of-tree stuff, are rarely accepted.
>
> (Rational: better upstream your kmods to have them in-tree, especially
> if they are so complex that they need subdirs.)
>
> That said, I'll try to give some more concrete feedback below.
>
> On Fri, Apr 05, 2024 at 09:56:08AM -0700, Valerii Chernous wrote:
> > The change allow to build external modules with nested makefiles.
>
> better use imperative statements to the code itself:  "Allow to build..."
>
> Does "nested makefile" mean that you want to support external kernel
> modules with subdirs and Makefiles within?

Short answer "Yes". I tested my patch on couple of external modules with
subdirs(Makefile included into each subdir) and it working well for me.

> > With current unofficial way(using "src" variable) it is possible to bui=
ld
> > external(out of tree) kernel module with separate source and build
> > artifacts dirs but with nested makefiles it doesn't work properly.
> > Build system trap to recursion inside makefiles, artifacts output dir
> > path grow with each iteration until exceed max path len and build faile=
d.
>
> I think I know what you want to say with this sentence, but I am not
> able to parse it correctly.  Might you want to rephrase it a bit?

Could you provide more details what you prefer to see into patch descriptio=
n?

> > Providing "MO" variable and using "override" directive with declaring
> > "src" variable solves the problem
> > Usage example:
> > make -C KERNEL_SOURCE_TREE MO=3DBUILD_OUT_DIR M=3DEXT_MOD_SRC_DIR modul=
es
> >
> > Cc: xe-linux-external@cisco.com
> > Cc: Valerii Chernous <vchernou@cisco.com>
> > Signed-off-by: Valerii Chernous <vchernou@cisco.com>
> > ---
> >  Documentation/kbuild/kbuild.rst  | 14 +++++++++++++-
> >  Documentation/kbuild/modules.rst | 16 +++++++++++++++-
> >  Makefile                         | 17 +++++++++++++++++
> >  scripts/Makefile.build           |  7 +++++++
> >  4 files changed, 52 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbu=
ild.rst
> > index 9c8d1d046ea5..81413ddba2ad 100644
> > --- a/Documentation/kbuild/kbuild.rst
> > +++ b/Documentation/kbuild/kbuild.rst
> > @@ -121,10 +121,22 @@ Setting "V=3D..." takes precedence over KBUILD_VE=
RBOSE.
> >  KBUILD_EXTMOD
> >  -------------
> >  Set the directory to look for the kernel source when building external
> > -modules.
> > +modules. In case of using separate sources and module artifacts direct=
ories
> > +(KBUILD_EXTMOD + KBUILD_EXTMOD_SRC), KBUILD_EXTMOD working as output
> > +artifacts directory.
>
> That means, iff you use KBUILD_EXTMOD_SRC and let KBUILD_EXTMOD point to
> some other directory, you _have_ to be sure that your kernel supported
> KBUILD_EXTMOD_SRC properly or your module will not be build at all,
> right?

If you will try to use KBUILD_EXTMOD_SRC but kernel doesn't support it then=
 module
will not be build at all because module sources with "Makefile" located at
KBUILD_EXTMOD_SRC and "make" can't use this "Makefile"(it try to use Makefi=
le from
KBUILD_EXTMOD but it actually point to artifacts dir with absent or empty M=
akefile)

> >  Setting "M=3D..." takes precedence over KBUILD_EXTMOD.
> >
> > +KBUILD_EXTMOD_SRC
> > +-----------------
> > +Set the external module source directory in case when separate module
> > +sources and build artifacts directories are used. Working in pair with
> > +KBUILD_EXTMOD. If KBUILD_EXTMOD_SRC is set then KBUILD_EXTMOD is used =
as
> > +module build artifacts directory.
> > +
> > +Setting "MO=3D..." takes precedence over KBUILD_EXTMOD.
> > +Setting "M=3D..." takes precedence over KBUILD_EXTMOD_SRC.
>
> (Just a note, not a complaint: This confused me while reading it the
> first time, but I think it is correct for your patch.  Personally, I do
> not like the semantical change of KBUILD_EXTMOD/M and would rather
> prefer the introduction of some more explicit names like
> KBUILD_EXTMOD_SOURCE and KBUILD_EXTMOD_BUILD instead.)

Yes, this semantical change little bit confusing. We discussed this issue i=
nternally
(inside my team) but at this point decided to try upstream current patch ve=
rsion
because doing this work without this semantical chages require much bigger =
patch(maybe
even patch series) and will take much more reviewer time and work

> > +
> >  KBUILD_OUTPUT
> >  -------------
> >  Specify the output directory when building the kernel.
> > diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/mo=
dules.rst
> > index a1f3eb7a43e2..b6c30e76b314 100644
> > --- a/Documentation/kbuild/modules.rst
> > +++ b/Documentation/kbuild/modules.rst
> > @@ -79,6 +79,14 @@ executed to make module versioning work.
> >        The kbuild system knows that an external module is being built
> >        due to the "M=3D<dir>" option given in the command.
> >
> > +     To build an external module with separate src and artifacts dirs =
use::
> > +
> > +             $ make -C <path_to_kernel_src> M=3D$PWD MO=3D<output_dir>
>
> Is it really good to evaluate MO relative to the kernel source or build t=
ree?

 At this moment there is not so much restrictions on "MO" presented. You ca=
n provide absolute
 or relative path via "MO" and, yes, it is possible to provide some ugly co=
nfiguration but
 developers should understand what they provide to kernel build system, is =
not it?

>     make -C /lib/modules/$(uname -r)/build M=3D/somewhere/source MO=3D../=
build
>
> might accidentially lead to ugly inconsistencies in the kernel build
> tree (permissions presumed).
>
> > +
> > +     The kbuild system knows that an external module with separate sou=
rces
> > +     and build artifacts dirs is being built due to the "M=3D<dir>" an=
d
> > +     "MO=3D<output_dir>" options given in the command.
> > +
> >        To build against the running kernel use::
> >
> >                $ make -C /lib/modules/`uname -r`/build M=3D$PWD
> > @@ -93,7 +101,7 @@ executed to make module versioning work.
> >
> >        ($KDIR refers to the path of the kernel source directory.)
> >
> > -     make -C $KDIR M=3D$PWD
> > +     make -C $KDIR M=3D$PWD MO=3D<module_output_dir>
> >
> >        -C $KDIR
> >                The directory where the kernel source is located.
> > @@ -106,6 +114,12 @@ executed to make module versioning work.
> >                directory where the external module (kbuild file) is
> >                located.
> >
> > +     MO=3D<module_output_dir>
> > +             Informs kbuild that external module build artifacts
> > +             should be placed into specific dir(<module_output_dir>).
>
> What about "should be placed into the specified directory <module_output_=
dir>." ?

Do you think it will be better to use "will" instead "should", whole phrase=
:
Informs kbuild that external module build artifacts
will be placed into specific dir(<module_output_dir>).

> > +             Parameter is optional. Without it "M" works as both
> > +             source provider and build output location.
> > +
> >  2.3 Targets
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > diff --git a/Makefile b/Makefile
> > index 4bef6323c47d..3d45a41737a6 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -142,6 +142,7 @@ ifeq ("$(origin M)", "command line")
> >    KBUILD_EXTMOD :=3D $(M)
> >  endif
> >
> > +define kbuild_extmod_check_TEMPLATE
> >  $(if $(word 2, $(KBUILD_EXTMOD)), \
> >        $(error building multiple external modules is not supported))
> >
> > @@ -152,9 +153,25 @@ $(foreach x, % :, $(if $(findstring $x, $(KBUILD_E=
XTMOD)), \
> >  ifneq ($(filter %/, $(KBUILD_EXTMOD)),)
> >  KBUILD_EXTMOD :=3D $(shell dirname $(KBUILD_EXTMOD).)
> >  endif
> > +endef
> > +$(eval $(call kbuild_extmod_check_TEMPLATE))
>
> Same checks make sense for KBUILD_EXTMOD_SRC, also if MO is not set.

Make sence, but it will require more changes with defining template
kbuild_extmod_check_TEMPLATE. Will update in next patch version.

> >
> >  export KBUILD_EXTMOD
> >
> > +# Use make M=3Dsrc_dir MO=3Dko_dir or set the environment variables:
> > +# KBUILD_EXTMOD_SRC, KBUILD_EXTMOD to specify separate directories of
> > +# external module sources and build artifacts.
> > +ifeq ("$(origin MO)", "command line")
> > +ifeq ($(KBUILD_EXTMOD),)
> > +     $(error Ext module objects without module sources is not supporte=
d))
> > +endif
> > +KBUILD_EXTMOD_SRC :=3D $(KBUILD_EXTMOD)
> > +KBUILD_EXTMOD :=3D $(MO)
> > +$(eval $(call kbuild_extmod_check_TEMPLATE))
> > +endif
> > +
> > +export KBUILD_EXTMOD_SRC
> > +
> >  # backward compatibility
> >  KBUILD_EXTRA_WARN ?=3D $(KBUILD_ENABLE_EXTRA_GCC_CHECKS)
> >
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index baf86c0880b6..a293950e2e07 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -3,7 +3,14 @@
> >  # Building
> >  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> >
> > +ifeq ($(KBUILD_EXTMOD_SRC),)
> >  src :=3D $(obj)
>
> I would leave the 'src :=3D $(obj)' stand alone unconditionally, to
> clearly separate the oot-oos-kmod support from default in-tree kernel or
> kmod builds and in-source but out-of-tree kmod builds.

In case of separating in-tree and out-of-tree src processing it will be not=
 couple
of line patch :)
Main idea of patch is create some small change to provide required function=
ality.
Current processing of "src" do required work, it only need to have proper v=
alue of
this variable.
Also, please, don't forget that each new line of code require engineers tim=
e for
supporting it into the feature. My opinon - patch must provide require func=
tionality and
should be as small as it possible

> > +else ifeq ($(KBUILD_EXTMOD),$(obj))
> > +override src :=3D $(KBUILD_EXTMOD_SRC)
> > +else
> > +src_subdir :=3D $(patsubst $(KBUILD_EXTMOD)/%,%,$(obj))
> > +override src :=3D $(KBUILD_EXTMOD_SRC)/$(src_subdir)
>
> bike-shedding:  see below

I think it's a good idea to use next line instead of my couples of lines:
override src :=3D $(obj:$(KBUILD_EXTMOD)%=3D$(KBUILD_EXTMOD_SRC)%)

but creating separate Makefile and do additional changes it's not required =
overhead.
It increase code size and request additional resources/time on supporting c=
hanges

> > +endif
> >
> >  PHONY :=3D $(obj)/
> >  $(obj)/:
> > --
> > 2.35.6
> >
>
> Testing with a simple module w/ subdir, compilation fails for me:
>
>     $ make M=3D../stupid-multidir-kmod/source V=3D2 MO=3D/tmp/build
>       CC [M]  /tmp/build/subdir/module.o - due to target missing
>       CC [M]  /tmp/build/hello.o - due to target missing
>     scripts/Makefile.modpost:118: /tmp/build/Makefile: No such file or di=
rectory
>     make[2]: *** No rule to make target '/tmp/build/Makefile'.  Stop.
>     make[1]: *** [/data/linux/oot-kmods-MO/Makefile:1897: modpost] Error =
2
>     make: *** [Makefile:257: __sub-make] Error 2
>
> (similar for 'make clean'.)
> The test kbuild files were as simple as:
>
> .../source/Kbuild:
>     obj-m +=3D subdir/
>     obj-m +=3D hello.o
>
> .../source/subdir/Kbuild:
>     obj-m +=3D module.o
>
> Does something like this work for you?  If I understand your proposed
> commit message correctly, you have some working example with subdirs?

Looks like working example, try to run next cmds before run build:
mkdir -p /tmp/build && \
touch /tmp/build/Makefile

Probably, this hack still required like into unofficial variant with using =
"M" and "src"

> ---
>
> Bike-shedding for inspiration:
>
> While experimenting with similar solutions at AVM, we did the same src
> override but also auto-generated dummy Makefiles in $(obj) with something
> like:
>
>     ifneq ($(if $(KBUILD_EXTMOD_SRC),$(filter $(KBUILD_EXTMOD)%,$(obj))),=
)
>     # If KBUILD_EXTMOD_SOURCE is set, enable out-of-source kmod build
>     # support, in general.  But do not disturb the kbuild preparing targe=
ts
>     # that need the original behaviour.
>     #
>     # Thus, iff also $(obj) is set and points to some path at $(KBUILD_EX=
TMOD) or
>     # below, we really want to set (override) $(src).
>
>     override src :=3D $(obj:$(KBUILD_EXTMOD)%=3D$(KBUILD_EXTMOD_SRC)%)
>
>     # Generate or update $(obj)/Makefile to include the original $(src)/K=
build or
>     # $(src)/Makefile.
>
>     _kbuild_extmod_src_makefile =3D $(firstword $(wildcard $(src)/Kbuild =
$(src)/Makefile))
>
>     $(lastword $(MAKEFILE_LIST)): $(obj)/Makefile
>
>     $(obj)/Makefile: $(_kbuild_extmod_src_makefile) FORCE
>          $(call filechk,build_makefile)
>
>     $(eval filechk_build_makefile =3D echo include $(_kbuild_extmod_src_m=
akefile))
>
>     # Clean-up the variable space
>     undefine $(filter _kbuild_extmod_%,$(.VARIABLES))
>
>     endif
>
> but we still had to add a dependency on $(subdir-ym) for all object
> files in any kmod subdir to enforce proper dependency handling.
> Fortunately, we almost stopped using such "enhanced" oot-oos kmod build
> things.

I don't saw any additional requirements or dependencies into my builds, all=
 that required is
processed by current rules into Kbuild, it only that required into my case =
it's provide proper
value of "src" variable

> HTH,
> kind regards,
> Nicolas

Best regards,
Valerii


________________________________
From: Nicolas Schier
Sent: Thursday, April 11, 2024 9:25 PM
To: Daniel Walker (danielwa)
Cc: Nicolas Schier; Valerii Chernous -X (vchernou - GLOBALLOGIC INC at Cisc=
o); Masahiro Yamada; Nathan Chancellor; xe-linux-external(mailer list); Jon=
athan Corbet; linux-kbuild@vger.kernel.org; linux-doc@vger.kernel.org; linu=
x-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Add MO(mod objs) variable to process ext modules wi=
th subdirs

On Thu, Apr 11, 2024 at 05:27:42PM +0000 Daniel Walker (danielwa) wrote:
> On Thu, Apr 11, 2024 at 01:38:20PM +0200, Nicolas Schier wrote:
> > Hi Valerii,
> >
> > thanks for your patch.  I know several non-upstream kernel developers
> > that would like to see support for out-of-source builds of external
> > kmods (and we developed several work-arounds at AVM as well); but pleas=
e
> > be aware that patches that don't fix or enhance the in-tree kernel/kmod
> > build but only add feature for out-of-tree stuff, are rarely accepted.

"out-of-tree stuff" was meant to be "out-of-tree kernel modules".  "Rarely"=
 was
chosen in explicit contrast to "never", but to hint on my personal expectat=
ion
regarding the probability of acceptance.

> If that were true we would not have driver/uio/ for example. It seems lik=
e
> Cisco and NVM should work together produce a solution.
>
> You could run into this issue even with entirely in tree modules. For exa=
mple,
> we may have a v6.6 kernel but we need some modules from v5.15 for some in=
compatibility
> reason in v6.6. Then we may build the v5.15 modules as out of tree module=
s
> against the v6.6 kernel.

If your in-tree module in question does compile and run properly in v5.15 a=
nd
in v6.6: why don't you just compile it in-tree in v6.6?  Which driver/modul=
e do
you refer to?

> You also have just normal developers making kernel modules which always s=
tart as
> out of tree modules before they are upstreamed. Those modules could be an=
y level
> of complexity.

I do not agree, but there is no need to convince me as I am not in the posi=
tion
to decide between acceptance or denial.  I just thought it might be fair to
warn that I do not expect acceptance.

Kind regards,
Nicolas



> I don't think it make sense to view this as strictly enhancing large of t=
he tree
> modules with no upstream potential.
>
> Daniel

--
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
? gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

