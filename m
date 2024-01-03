Return-Path: <linux-kernel+bounces-15286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 845548229B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1872850FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 08:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F72182A2;
	Wed,  3 Jan 2024 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=micron.com header.i=@micron.com header.b="FVRaWZdd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87AD1804D;
	Wed,  3 Jan 2024 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=micron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=micron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJK9T3iqDr4KvjMvCq74g719+ulMV670tyNryyyV1aJluBeaqFAmgiPsg42xXdfHQY58LExu7IkF/44iAAopJ/yhT4wQ+2/TUOMfF/7u1pgOkeSFe72ud21jwsfF0OZoJr/58bx2CAcW7nBNaqXs8ID9Z26XDsMn32lms7yn8W9tfHkUSvqDVBMw+pgJC94NN8xbF/HA9gqonRt7z+ROMPuxSpdUx9cw4qJn09kWyHKaw0g2NjTUOeT8ljteAbW4Uym5koNAqOkyKUjHntjy7zTDf8a7bY4xBB1UumKm5FgWk64c78TV7Z8WygM9CtXYMt8YI9Xl6qrJRjqX62Nt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEsXh66kM8P58ua7Lkwa03E9wD/Yvwhy5j+i02EIsPw=;
 b=EA4QB3edw10nD4tDjNjR/7rtJqTQp+QbRJvLLlVRefUw89ZIu7AlepaAKbYSo263oihZxT7j3kVUWFLQ+kdals/Km14n7DPtorCAEZ96oJiseeaiWQD5s1zaimt7m21k4wdWpO6Fbo05L+BMj4EW/FdoR+I0OyrniJLCnI5M9iOo09mYvNf+wTl/pfS0eWdFpl1bp4+xAoWp8pFWscEb1REYqXa0QUdeZu2La1tIse84eh80g4/qel0JWMCm3KYmsjmWanC6p4v7rBb2TVxh1EcTEdIME/6nnptCDnierOOKJ6stx+3lkZzXovSORQhwkKyYZQkz4fDEcT4K7qMuOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=micron.com; dmarc=pass action=none header.from=micron.com;
 dkim=pass header.d=micron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=micron.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEsXh66kM8P58ua7Lkwa03E9wD/Yvwhy5j+i02EIsPw=;
 b=FVRaWZddT9R/tpJ9GOcRTWsrl7/IGe2EbO/IHVxLe97fNHxTITCUnSml8E2Kw6vNASfEgXfEFNrHhI/WvVwWyDxDb1bv574Lag1yO7oRYgfmKe4xzXQuJ72J40D3f8ZuFw+mhqqfVgMPDa+zBE9dGtn3P1dM5aTfAKLQmVpScshaa4X3012NFkG0V1eUGmzTW+qOIjfcqogOpsN1j2B9ZwnQzpwaNGSstLlWXLeksZKnALb1/3QjuAZuBf+zWBwhALVehVxqxqOkVSdQFZZKaa1CmBFLY9nmt24HFz/HtqT6DbrPjAxYlwNbWabmIyKc5FWbyisKqe9LDi2sbBEidg==
Received: from PH0PR08MB7955.namprd08.prod.outlook.com (2603:10b6:510:11a::17)
 by SA1PR08MB7037.namprd08.prod.outlook.com (2603:10b6:806:1ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Wed, 3 Jan
 2024 08:47:58 +0000
Received: from PH0PR08MB7955.namprd08.prod.outlook.com
 ([fe80::5049:9abf:ad65:9974]) by PH0PR08MB7955.namprd08.prod.outlook.com
 ([fe80::5049:9abf:ad65:9974%3]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 08:47:58 +0000
From: Srinivasulu Thanneeru <sthanneeru@micron.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: gregory.price <gregory.price@memverge.com>, Srinivasulu Opensrc
	<sthanneeru.opensrc@micron.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "mhocko@suse.com"
	<mhocko@suse.com>, "tj@kernel.org" <tj@kernel.org>, "john@jagalactic.com"
	<john@jagalactic.com>, Eishan Mirakhur <emirakhur@micron.com>, Vinicius
 Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc
	<Ravis.OpenSrc@micron.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Wei Xu
	<weixugc@google.com>
Subject: RE: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Thread-Topic: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory tiers
Thread-Index:
 AQHaLe1WCWEmLbBSRk2O5Sdey42WeLCpzLPHgADTuACAA/H6xIAZGhOAgAAO84SAABl24IAADebegAACPiA=
Date: Wed, 3 Jan 2024 08:47:57 +0000
Message-ID:
 <PH0PR08MB79552F35351FA57EF4BD64B4A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
	<87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZXyQIJOim1+tE0Qr@memverge.com>
	<87fs00njft.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
	<87edezc5l1.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<PH0PR08MB79550922630FEC47E4B4D3A3A860A@PH0PR08MB7955.namprd08.prod.outlook.com>
 <87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87a5pmddl5.fsf@yhuang6-desk2.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ActionId=e613c07d-f699-4fa0-baf6-de8be7204408;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_ContentBits=0;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Enabled=true;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Method=Privileged;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_Name=Public;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SetDate=2024-01-03T08:40:17Z;MSIP_Label_6fdea275-d6f3-438f-b8d8-013cab2023d3_SiteId=f38a5ecd-2813-4862-b11b-ac1d563c806f;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=micron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR08MB7955:EE_|SA1PR08MB7037:EE_
x-ms-office365-filtering-correlation-id: 10486dff-c85e-4e7d-d593-08dc0c38af60
x-ld-processed: f38a5ecd-2813-4862-b11b-ac1d563c806f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 n7TFjNhhXtHjZ01LKBy41yEOuJ25kUParIstsChmAg+3A3ct7wOOLVXiOWtHKI25MW8v5jpRvZq9ynRsj5B7RzxKwW7NJWoThsMTJReMmyN98/Rlq4zG/Tc/3TBxQDoMJshF51eOpeMA1d3i+q4Nb7enNTYfrWoIBEor6JpAbkm/W92CPY7mVKKAo72/et6J7xFSFGB4+J0LjzODKW0ZoElSF0JxT/HV98jXE6DtC0ueTjXHZx4AzY7YQ7eaVw6bxptqs4birrW9Czy3oKCkAzXl7mwGFhlpBl3DaurmVnAZ/vkFC5FSp0TzMe4s5C57o8LfHUvdqr6yJbTArYm66YwJ8jhLEUbNL9VAxFg3KpO4ejHXS4zYiN883E0/D7MBuWhPQsLlNYd5yHjzfVYZM9/Q/f4MyjBiAUpcbO/AC/o9wIfNUT5q34+TQ3DEJ7DA7VjUxTg+UV+hduLsXaqho9D6Qxf5caP2Y+SQ/+Yihfk5Vcs1CoLWXnUB6btsjGGuLVj/9be18tqfzywTOohyf9BPwpDIqJuIEK2P91vjLBe4ZZvtUkLsIe1u6J6z+Due8TBlejffF5NdrHPE6JWlZHR7fZlHs32Qhlz9lllcN3rm/Cpe6vZC7FREkVXrzaFJDsr3V0WqGFbrafuKy9K5WA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR08MB7955.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7416002)(2906002)(5660300002)(41300700001)(478600001)(86362001)(966005)(122000001)(38070700009)(38100700002)(33656002)(53546011)(83380400001)(7696005)(6506007)(9686003)(26005)(45080400002)(71200400001)(52536014)(8676002)(8936002)(4326008)(66946007)(76116006)(316002)(66556008)(66476007)(66446008)(64756008)(6916009)(54906003)(55016003)(66899024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BbblkOtCN8FComOX3V9WdhuOZoA1BAyeinBOxMkKsflwx+RgAPVFgC2qnU+O?=
 =?us-ascii?Q?k+9F1/XlivEKAUpeP091V46h2R3lQSlF3niE1aLX0+qn71Hfna02RqpIBr0x?=
 =?us-ascii?Q?20qexyoMgWcITUCusoYJcmnkuWIq18VBwH+7rBWoYTA3KihegIFWZkJ3VVIE?=
 =?us-ascii?Q?GOnoEBV/vX4MELIn0P10HfnMtlkduikFIA6DwzpB+fZyGcQDOv3ZT/s9VOjl?=
 =?us-ascii?Q?njc/+ftawCCFdbGXsrNg0NIUGF7rl99nI7JjJiRm0nxxiOPU9kTNjT0tavHt?=
 =?us-ascii?Q?O7mS01rRvXn730Kd/nslwfpFYqDFuNYojc1a0kLzsQIDcShfUpLSArE5eXL+?=
 =?us-ascii?Q?VP7HjRi/8H3heCIfzzbGUOXiQCwDH18MYq9cVV7+CeJbu+nbE/kRJSrnWt5z?=
 =?us-ascii?Q?06/zI4C0xWMW2PLoJCx5XEls2MXzuIl7l44L4HFWbRmqlBBQUWCEyVFtUv7Z?=
 =?us-ascii?Q?9chcfMU0vjqnDH2rKb3Z5tKR8L2jvYAjgLEOy+q7lI1BpCE2Y61aTiOk9mdy?=
 =?us-ascii?Q?54A03BOu07k5O24OTKtTsi6BA/iu+JkvZPkSTpzPWK3iQ3XQIolOI2O2iyC4?=
 =?us-ascii?Q?AOuJEEbwdU2jRdqCqAOofQxNwJPS9jIEqW6izYZEgbAflB1JoLRCF3qZcuyM?=
 =?us-ascii?Q?NdH2lQeFOkES2KOF0pVPa2U9FIl4BTt8sNDGvVnmYjxk6GxWdYN8TmI8MpuB?=
 =?us-ascii?Q?YMT3CnxZwbtsGADVO2NImlVTYmNspl+9+KDm6gWYIlJ1asMnFVsz7p84zLPy?=
 =?us-ascii?Q?8OMJYww3oMvWLtYW86fBUYz0jB4NRuGvSe5YeZa/uXJv9QXz0v+oBtK+zeFO?=
 =?us-ascii?Q?A+fNWhMv4BDjIKjESzOrfk70kRU3TND2Tt2hCJn2fFPK+D30pDblrSsosbu2?=
 =?us-ascii?Q?O46GD+twrpf5/jvt5w5i7PwmPQOFYo70z7VkEhOhz7FhfW/XBJ/nz/GwhOC4?=
 =?us-ascii?Q?o9AP3Md3IMFcV59fsOXONvNobvYgYOXeSIxzfwNYj1uOUQ6ZHLkv/F41bxOm?=
 =?us-ascii?Q?3pVRdxrCztYACndZ6vQQIAMpV/p4yOkc1E2G+uAMUlTB/yEh53Pk81DVoc8i?=
 =?us-ascii?Q?2OLnqjHhKYp3nqjTi1ZMVosAh17iYr6X/Ukr0p57qtjggwlhFnADGhqShV/D?=
 =?us-ascii?Q?guJeQwCmV1lJYGYSKtTzmhKS4+txRFzM1ejJSC65J6FW+u7ue2LfpAEDyDpb?=
 =?us-ascii?Q?RG3EYnf8l/OsI51tq9dmhwfUO1SoVBGT3xjo85hh0Lu3LplpGKN6HkQKJ3KH?=
 =?us-ascii?Q?wI6xpYWx9ck2AikzL2S4uQ433FzdCSax6QKtgTZQtroe/neMYD45vtL2NM9Y?=
 =?us-ascii?Q?CHDSlCJeZpmcwMgwwg1ZEJKDTueYJlvgjVREmoENfrjhBOwA6ZiSY4eFsvFW?=
 =?us-ascii?Q?XY2sObk/dzdhk2wQTMCI/GTC2h7KcE7rXfFOFd5TUvb0N4SpzycMne6gNESA?=
 =?us-ascii?Q?j2ZhgQ62n41qFzEoPz+DuDQl/tSCZRznj5rZBwYR2mK5RbO8D2IVhYumKfbX?=
 =?us-ascii?Q?/GWoRfdVux/9L64ofsKdnlWAkgxMjiGBE46TE8azh45wUDlnGSDco6Jgq+Fl?=
 =?us-ascii?Q?lDhlC+sQ5nIbysu2909CQk3FdoMgSAnefhlY/iGK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: micron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR08MB7955.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10486dff-c85e-4e7d-d593-08dc0c38af60
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 08:47:57.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I2r0iPMTDICvM0MvrFOjwQRtceRFtBE9PZq2sXVJ4ePZS5MQy4XNSE6VqC8stDm7ULK8477trrV5lw0Qz38MhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR08MB7037



> -----Original Message-----
> From: Huang, Ying <ying.huang@intel.com>
> Sent: Wednesday, January 3, 2024 2:00 PM
> To: Srinivasulu Thanneeru <sthanneeru@micron.com>
> Cc: gregory.price <gregory.price@memverge.com>; Srinivasulu Opensrc
> <sthanneeru.opensrc@micron.com>; linux-cxl@vger.kernel.org; linux-
> mm@kvack.org; aneesh.kumar@linux.ibm.com; dan.j.williams@intel.com;
> mhocko@suse.com; tj@kernel.org; john@jagalactic.com; Eishan Mirakhur
> <emirakhur@micron.com>; Vinicius Tavares Petrucci
> <vtavarespetr@micron.com>; Ravis OpenSrc <Ravis.OpenSrc@micron.com>;
> Jonathan.Cameron@huawei.com; linux-kernel@vger.kernel.org; Johannes
> Weiner <hannes@cmpxchg.org>; Wei Xu <weixugc@google.com>
> Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory
> tiers
>
> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
> you recognize the sender and were expecting this message.
>
>
> Srinivasulu Thanneeru <sthanneeru@micron.com> writes:
>
> > Micron Confidential
> >
> >
> >
> > Micron Confidential
> >> -----Original Message-----
> >> From: Huang, Ying <ying.huang@intel.com>
> >> Sent: Wednesday, January 3, 2024 11:38 AM
> >> To: Srinivasulu Thanneeru <sthanneeru@micron.com>
> >> Cc: gregory.price <gregory.price@memverge.com>; Srinivasulu Opensrc
> >> <sthanneeru.opensrc@micron.com>; linux-cxl@vger.kernel.org; linux-
> >> mm@kvack.org; aneesh.kumar@linux.ibm.com;
> dan.j.williams@intel.com;
> >> mhocko@suse.com; tj@kernel.org; john@jagalactic.com; Eishan Mirakhur
> >> <emirakhur@micron.com>; Vinicius Tavares Petrucci
> >> <vtavarespetr@micron.com>; Ravis OpenSrc
> <Ravis.OpenSrc@micron.com>;
> >> Jonathan.Cameron@huawei.com; linux-kernel@vger.kernel.org; Johannes
> >> Weiner <hannes@cmpxchg.org>; Wei Xu <weixugc@google.com>
> >> Subject: Re: [EXT] Re: [RFC PATCH v2 0/2] Node migration between
> memory
> >> tiers
> >>
> >> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
> >> you recognize the sender and were expecting this message.
> >>
> >>
> >> Srinivasulu Thanneeru <sthanneeru@micron.com> writes:
> >>
> >> > Micron Confidential
> >> >
> >> > Hi Huang, Ying,
> >> >
> >> > My apologies for wrong mail reply format, my mail client settings go=
t
> >> changed on my PC.
> >> > Please find comments bellow inline.
> >> >
> >> > Regards,
> >> > Srini
> >> >
> >> >
> >> > Micron Confidential
> >> >> -----Original Message-----
> >> >> From: Huang, Ying <ying.huang@intel.com>
> >> >> Sent: Monday, December 18, 2023 11:26 AM
> >> >> To: gregory.price <gregory.price@memverge.com>
> >> >> Cc: Srinivasulu Opensrc <sthanneeru.opensrc@micron.com>; linux-
> >> >> cxl@vger.kernel.org; linux-mm@kvack.org; Srinivasulu Thanneeru
> >> >> <sthanneeru@micron.com>; aneesh.kumar@linux.ibm.com;
> >> >> dan.j.williams@intel.com; mhocko@suse.com; tj@kernel.org;
> >> >> john@jagalactic.com; Eishan Mirakhur <emirakhur@micron.com>;
> Vinicius
> >> >> Tavares Petrucci <vtavarespetr@micron.com>; Ravis OpenSrc
> >> >> <Ravis.OpenSrc@micron.com>; Jonathan.Cameron@huawei.com;
> linux-
> >> >> kernel@vger.kernel.org; Johannes Weiner <hannes@cmpxchg.org>; Wei
> Xu
> >> >> <weixugc@google.com>
> >> >> Subject: [EXT] Re: [RFC PATCH v2 0/2] Node migration between memory
> >> tiers
> >> >>
> >> >> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments
> unless
> >> >> you recognize the sender and were expecting this message.
> >> >>
> >> >>
> >> >> Gregory Price <gregory.price@memverge.com> writes:
> >> >>
> >> >> > On Fri, Dec 15, 2023 at 01:02:59PM +0800, Huang, Ying wrote:
> >> >> >> <sthanneeru.opensrc@micron.com> writes:
> >> >> >>
> >> >> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> >> >> > Version Notes:
> >> >> >> >
> >> >> >> > V2 : Changed interface to memtier_override from adistance_offs=
et.
> >> >> >> > memtier_override was recommended by
> >> >> >> > 1. John Groves <john@jagalactic.com>
> >> >> >> > 2. Ravi Shankar <ravis.opensrc@micron.com>
> >> >> >> > 3. Brice Goglin <Brice.Goglin@inria.fr>
> >> >> >>
> >> >> >> It appears that you ignored my comments for V1 as follows ...
> >> >> >>
> >> >> >>
> >> >>
> >>
> https://lore.k/
> %2F&data=3D05%7C02%7Csthanneeru%40micron.com%7Ce9e04d25ea7540100
> cf308dc0c366eb1%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
> 8398675187014390%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdata=3Dk6J1wxcuHTwR9eoD9Yz137bkn6wt1L9zpf5YaOjoIqA%3D&reserved=3D0
> >>
> %2F&data=3D05%7C02%7Csthanneeru%40micron.com%7C3e5d38eb47be463c2
> >>
> 95c08dc0c229d22%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
> >>
> 8398590664228240%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> >>
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> >>
> &sdata=3D7fPxb1YYR2tZ0v2FB1vlXnMJFcI%2Fr9HT2%2BUD1MNUd%2FI%3D&re
> >> served=3D0
> >> >> ernel.org%2Flkml%2F87o7f62vur.fsf%40yhuang6-
> >> >>
> >>
> desk2.ccr.corp.intel.com%2F&data=3D05%7C02%7Csthanneeru%40micron.com
> >> >>
> >>
> %7C5e614e5f028342b6b59c08dbff8e3e37%7Cf38a5ecd28134862b11bac1d56
> >> >>
> >>
> 3c806f%7C0%7C0%7C638384758666895965%7CUnknown%7CTWFpbGZsb3d
> >> >>
> >>
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> >> >>
> >>
> D%7C3000%7C%7C%7C&sdata=3DOpMkYCar%2Fv8uHb7AvXbmaNltnXeTvcNUTi
> >> >> bLhwV12Fg%3D&reserved=3D0
> >> >
> >> > Thank you, Huang, Ying for pointing to this.
> >> >
> >>
> https://lpc.ev/
> %2F&data=3D05%7C02%7Csthanneeru%40micron.com%7Ce9e04d25ea7540100
> cf308dc0c366eb1%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
> 8398675187014390%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdata=3D%2F0AW8RYpTIa7%2FiScnkzmmTeAE9TYqjsuWWjTuxBPptk%3D&rese
> rved=3D0
> >>
> ents%2Fevent%2F16%2Fcontributions%2F1209%2Fattachments%2F1042%2F1
> >>
> 995%2FLive%2520In%2520a%2520World%2520With%2520Multiple%2520Me
> >>
> mory%2520Types.pdf&data=3D05%7C02%7Csthanneeru%40micron.com%7C3e
> >>
> 5d38eb47be463c295c08dc0c229d22%7Cf38a5ecd28134862b11bac1d563c806
> >>
> f%7C0%7C0%7C638398590664228240%7CUnknown%7CTWFpbGZsb3d8eyJW
> >>
> IjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> >>
> 000%7C%7C%7C&sdata=3D1fGraxff7%2F1hNaE0an0xEudSKSUvaF3HgClMkmdC7
> >> n8%3D&reserved=3D0
> >> >
> >> > In the presentation above, the adistance_offsets are per memtype.
> >> > We believe that adistance_offset per node is more suitable and flexi=
ble.
> >> > since we can change it per node. If we keep adistance_offset per
> memtype,
> >> > then we cannot change it for a specific node of a given memtype.
> >> >
> >> >> >>
> >> >>
> >>
> https://lore.k/
> %2F&data=3D05%7C02%7Csthanneeru%40micron.com%7Ce9e04d25ea7540100
> cf308dc0c366eb1%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
> 8398675187014390%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> &sdata=3Dk6J1wxcuHTwR9eoD9Yz137bkn6wt1L9zpf5YaOjoIqA%3D&reserved=3D0
> >>
> %2F&data=3D05%7C02%7Csthanneeru%40micron.com%7C3e5d38eb47be463c2
> >>
> 95c08dc0c229d22%7Cf38a5ecd28134862b11bac1d563c806f%7C0%7C0%7C63
> >>
> 8398590664228240%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> >>
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C
> >>
> &sdata=3D7fPxb1YYR2tZ0v2FB1vlXnMJFcI%2Fr9HT2%2BUD1MNUd%2FI%3D&re
> >> served=3D0
> >> >> ernel.org%2Flkml%2F87jzpt2ft5.fsf%40yhuang6-
> >> >>
> >>
> desk2.ccr.corp.intel.com%2F&data=3D05%7C02%7Csthanneeru%40micron.com
> >> >>
> >>
> %7C5e614e5f028342b6b59c08dbff8e3e37%7Cf38a5ecd28134862b11bac1d56
> >> >>
> >>
> 3c806f%7C0%7C0%7C638384758666895965%7CUnknown%7CTWFpbGZsb3d
> >> >>
> >>
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> >> >>
> >>
> D%7C3000%7C%7C%7C&sdata=3DO0%2B6T%2FgU0TicCEYBac%2FAyjOLwAeouh
> >> >> D%2BcMI%2BflOsI1M%3D&reserved=3D0
> >> >
> >> > Yes, memory_type would be grouping the related memories together as
> >> single tier.
> >> > We should also have a flexibility to move nodes between tiers, to
> address
> >> the issues.
> >> > described in use cases above.
> >>
> >> We don't pursue absolute flexibility.  We add necessary flexibility
> >> only.  Why do you need this kind of flexibility?  Can you provide some
> >> use cases where memory_type based "adistance_offset" doesn't work?
> >
> > - /sys/devices/virtual/memory_type/memory_type/ adistance_offset
> > memory_type based "adistance_offset will provide a way to move all node=
s
> of same memory_type (e.g. all cxl nodes)
> > to different tier.
>
> We will not put the CXL nodes with different performance metrics in one
> memory_type.  If so, do you still need to move one of them?

From  https://lpc.events/event/16/contributions/1209/attachments/1042/1995/=
Live%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf
abstract_distance_offset: override by users to deal with firmware issue.

say firmware can configure the cxl node into wrong tiers, similar to that i=
t may also configure all cxl nodes into single memtype, hence all these nod=
es can fall into a single wrong tier.
In this case, per node adistance_offset would be good to have ?

--
Srini
> > Whereas /sys/devices/system/node/node2/memtier_override provide a
> way migrate a node from one tier to another.
> > Considering a case where we would like to move two cxl nodes into two
> different tiers in future.
> > So, I thought it would be good to have flexibility at node level instea=
d of at
> memory_type.
>
> --
> Best Regards,
> Huang, Ying

