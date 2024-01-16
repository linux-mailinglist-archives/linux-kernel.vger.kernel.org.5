Return-Path: <linux-kernel+bounces-28290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC3C82FC98
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255DE28D61C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E1E2D7A5;
	Tue, 16 Jan 2024 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlHmEvc7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4F5BAE3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705439824; cv=fail; b=l2o30GDW3vtJaS3XoD2o7Ci2cU1csXQkn9rqFiQ55ABbcjvqxkszAod+z2J55ZBDOxFOjqvFTbwIczZgg96HYyVcC0FePZ/VO6zBRAb13U2Z2noeyUIyj3OLoi5SqlIu0ajPllxa9oFi4kolKZXRMOttr38SumhEau69NhCR1PE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705439824; c=relaxed/simple;
	bh=X3eJHWZIu36LUZ+qmJlOyus86Ruyfj6a5DBWt0b64F8=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:
	 Received:ARC-Message-Signature:ARC-Authentication-Results:Received:
	 Received:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
	 Message-ID:References:In-Reply-To:Accept-Language:Content-Language:
	 X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	b=l1d9FBy0FT72r8AGLT3d98VSnughfRsTtdaXsFYYsBiOZ+P++lp5yIimZ8k5d4QIxjGRliHOOrPhr1+nF9uDwCfw2MFfz32fcyZULbeubiBAypG1yG6n3L/fLfcgvXxdvdJtlSLGKNOlpToeROvgCOrQbCae1UR+sjn1st3hqN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlHmEvc7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705439824; x=1736975824;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=X3eJHWZIu36LUZ+qmJlOyus86Ruyfj6a5DBWt0b64F8=;
  b=AlHmEvc7+YeUKhKtfh/O+UZbhtQKLx/QcL3Fxb2t51t9kH24i/Xgzl0n
   g0ESQDkRoOvRZG0cjME5qXXYrf+bstQ5fZLbmUlrDwhBSz1n+xEtKaKZw
   Gm/7Kl/uPN0X79Nd0XtkA4rVxi2gebRtUx26ygZ7sJEkTFHWbbfYsucsn
   go1PmZ0f1YbM4IOL6kNRcjgNEyRWqc7hoHwOGOxGGYcNSsCpmIsPBv0JZ
   Uk++JWnl0Sqb2lAbGyIrKfWdj/FXucOMcfmht55w13VNrMPkYOKv11tbu
   aghCDz036xBuaoj5oflkKm22Et0VqO/tdwNjbB/qk9PUlp3rs0ouMS20P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="7368496"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="7368496"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2024 13:17:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10955"; a="874598480"
X-IronPort-AV: E=Sophos;i="6.05,200,1701158400"; 
   d="scan'208";a="874598480"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2024 13:17:02 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 13:17:01 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 13:17:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 16 Jan 2024 13:17:01 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Jan 2024 13:17:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYM3a7sqk0oxiTGUEoWz20IZ6Rd2V+RbQMef6sohrBz/XO92nvfAihCGl9RLgeGgcKXIRe30xnAj6LJeGLPDE/IA2MzpNSZgjH5KvxdBGsSr/TpEYrqMB5CPNbUI+gaeEhefAqPbxuFLZtAlQmWdlolw9YoufjTTYS6scUg3XoBSd2SIJU6lflQv/YOXSyC/hrijVnRz9I1v+8ZscC8C19nIggkpBYD9kFrTzlX4dg4CY8MhZYWeO7tC3LPhkvUbMiy3DlfUdWK/62dRQ2StgCVLW0U+WI8J1+S/NIo6J81WMbHnQ/du4RCsg4qVDuFBcb1e/zZDP7wu/E0pGPQbuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3eJHWZIu36LUZ+qmJlOyus86Ruyfj6a5DBWt0b64F8=;
 b=fbRB5HfC1eyTUkqBGW5kAp6aZA0z2fUEc5lDCbZFEaTRruUQ5Nzyyk9uSa3DY+V23nTBdAz90SCSHCpa1bk/YoT7w2x+bbOCQms2c3N0QTK9bU8jWmrB9WWF3fMjIZxpdegzOGsfzlXiCN3SupJORX8FsyyjPQkSqve5J9Q+4y8iMyyBl3e4vB/HPHfaNmVThgYkcxqFWBvJyqhJ+bpvJ7efCRQzRT2dR+I5j+MFeLk4lqwOUWeWSpikwFktPjsMJ5yH+6MLWyc/NYCXYEzxpZ25DHulDqACHH5M1MGLQVhU7QWGzgZEGOS78yDn+mZnTQkYlGlzDKN3g0ssLPzJ/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Tue, 16 Jan
 2024 21:16:58 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7181.019; Tue, 16 Jan 2024
 21:16:58 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "Cui, Dexuan" <decui@microsoft.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"jpiotrowski@linux.microsoft.com" <jpiotrowski@linux.microsoft.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCHv2] x86/mm: Fix memory encryption features advertisement
Thread-Topic: [PATCHv2] x86/mm: Fix memory encryption features advertisement
Thread-Index: AQHaRH8fDWK2kmMhZkC3EKr4wXoBC7DcRqMAgAAGUACAAKy3AA==
Date: Tue, 16 Jan 2024 21:16:58 +0000
Message-ID: <a95e410a9b5b9662c415774aa254d85324c0258d.camel@intel.com>
References: <20240111111224.25289-1-kirill.shutemov@linux.intel.com>
	 <2b171c78e3dbc33f6fcf015c14c9e84825776798.camel@intel.com>
	 <20240116105844.cjnwpzuywukfv5rs@box.shutemov.name>
In-Reply-To: <20240116105844.cjnwpzuywukfv5rs@box.shutemov.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SN7PR11MB6703:EE_
x-ms-office365-filtering-correlation-id: 603435ad-b72b-43be-d370-08dc16d87983
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HzVQHbAM+vw8EWPeGWGCvHRC6SnGOYZrABi5z+NaG3fzfKokcgyvGnnHIDADB8wMIZDFe0ZeIx52wT+8Izm6jkpyE2AYPzXWTXW0e3l1RS7p4hB9z8MQA9pVUISRVf+wnoJfPYLSKuF5hzTEsa5BNXHoh58mQJOC4/LShf1AoJ2dQe51Cs8JZ3uVZTWUTVGnh8dD7t5rUkAhjJXVGy4J/QiD5fBAUXX0YtmgkdAgLHIHxQzzwLRvOZHGwmbawhmrLmHVRNLlRRKDFSbf32X4RFhSI8w6Wio8V1frDHsROAWUTtd3EMO1/Ucjypqo376v3ywXldKecgcOFiw9JY1K5wJSUJ1R2Tj10lioh3Y0BAFcpsF+J3FBTt8hxAP2rZI19VdZbh0DOzWBqf9oPWnQrcCVZyr7zbiJbc6rDZauMdQMIvm1qAhdB/VREguFqhMMUQ8RBJjig/AwIhN81xLQDinnFA+/H3m8laxErzM0fPsbai/1lpFXPEX0NS5pvpdlgP3r4ZJSwHmwd7RqTDzLP585yJ5l1GieT0Jux1hyObDD6zb0Kw5Pv1/Fze+hRr9KJgw9//axUGZBxJ2FGbL9oV89NmDZvKqRsyfE71GrVu8ObS0MpIaomjzTzNEsVJdN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(71200400001)(2616005)(26005)(6506007)(6512007)(478600001)(5660300002)(83380400001)(2906002)(7416002)(4326008)(41300700001)(91956017)(6486002)(66446008)(76116006)(8936002)(6916009)(64756008)(66556008)(66946007)(66476007)(54906003)(316002)(8676002)(82960400001)(38070700009)(36756003)(122000001)(86362001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YjRvNStzS3ZSVGFMNy9mdFJnOHZSWk9iZjJtbFJLb0c2QlF4S3RkYitIdExl?=
 =?utf-8?B?b05FWE1BOE4xWW16VEIwY1J0MHY4c3JkWjVUUXk4TTJnUmRHeTFlcWNCYXc3?=
 =?utf-8?B?T0J2WnVmdjZCVU9Kb0ZjRWpiOTlQOXVXalp6U1h2UFJtdG1FR3FiYWp5ZkJ2?=
 =?utf-8?B?VHpuTjIwRFJKamJIdnlZMjAwSUkvaG4vQ3U0V2tCdlZYSjNBTzRvbCtaWUtY?=
 =?utf-8?B?MVc4bkJxU0o4b0xiQ0hjc0Z4dEdFand4cnNWRURPNSs4VWVTK0IwblRzT3FZ?=
 =?utf-8?B?Yko5bWJCTEovVXdEY0pQODJzM1lWTkkwUHc5ZzMxYmwyT1gwdGx5SWhDdGxD?=
 =?utf-8?B?bkxvRXJrZFZoSWl0ZDBrK0E2ZVZWK1pIR2p0UDFhcE1ub0l1RDFkbzJud1Rn?=
 =?utf-8?B?RmMxTWlJbDh5a0FZbHUrek9pUlJHTE14bktpMWdKRERkbVNtaEdoNVB2Myt6?=
 =?utf-8?B?Tlc0d0ZheWxZZkNaeFpDZWcwTUlsRklIczUwbnVNUjE1Mjg1aHA2Uk9Ra2E3?=
 =?utf-8?B?Z3I2UzlsK0JRT28vSm5ZTkNCS29YVG9SM25XTEtsY3B5Y1lmVGcwcDB0RHAy?=
 =?utf-8?B?NVR2RjNIRWExTUVZM0xTb2RudXJ1TlBMTENZOWRQTXA1enNlRENOTVFtd20v?=
 =?utf-8?B?UnBLajZnSS91Yk92dW4vekRZLzczNmxsNG9hMS9UdjFDRVVKYW5yWkhldEJF?=
 =?utf-8?B?cU9KdXU1aW13ZnJpUFpESDdOcU9hSGo0YVdUeWZHcVRLOEdod2krM3ZJS3Rn?=
 =?utf-8?B?S3BDUWR6WnkyaW9zTXFobmV5bDV6SVhybjN3K3VhWUJCMFNZcC9DZW01c0l4?=
 =?utf-8?B?V0lWZ2dIY1RWbkZiN1R0UHRPVDFqb0FOZ2dkQnlwV1VTaHE1S3pwYkVWcmxO?=
 =?utf-8?B?aDBjTjZneHUzTy9MSmRqR0k3Q2JRUDdLc0QzK21tNVczVlRvV1VTMDNDY2dZ?=
 =?utf-8?B?RFVlRkZ0Y2RXY3lhVlNtclZBNWZOZ1o0dFQrUm5lMStyZ2lETjVJTDdFNUhp?=
 =?utf-8?B?U0lHZFRKcUI3Szd3cU82Y1g3dnlYTXdlbU53MDdKNUpyWW1TTTJiVFpKZzBE?=
 =?utf-8?B?VFdlcm0vWGhUOXdMYm5BcXgxSC9KbXhlMUl0ekpsZnM1ejN1dXJlTFpZMTR1?=
 =?utf-8?B?eWZxNXc0aW9kYk1YK0VKYXVDdkJpVyttZGtoaEN2d0k0OWR6RVFEZHF3MmNm?=
 =?utf-8?B?L2x0a3hjUCtjOUMvMGp6ak5IcXFGVi84U0dkRnJRby9qZHJEVTVxQ3dSTUl6?=
 =?utf-8?B?VVdOUVcyK0ZGSDVFVWR1eXVwWnJTV2dHb3RkVER0aWV5R3RCclVLWUwvT2E0?=
 =?utf-8?B?ZU95WnVPVE1YODBNR2c5Qzh3S281VUYrOXhkNEZsU0QwU2grMUUxdmpaZ0dQ?=
 =?utf-8?B?WXRSNC95TXVRV2pXbENCRnhIRGR6K2JpN0JLaFpRUWxiU0dvbld3T3VZRGNp?=
 =?utf-8?B?OEh0dUoxZzhnZXBsMU1XdG1UMWc0TTcrQ3pWRko5Rks4azA0RURab3ZDUHJi?=
 =?utf-8?B?aWx1R1M4Ymd2OVp6LzRodllNbVMxRTVPRS9ZRUVaMlhwSk5oVGEvZWIrUXQx?=
 =?utf-8?B?ekZiT1RyYWpjajRQYnphL1lyUnNxWjhYRXhKZjduZ2txN2RMcXFCTXhFVHYr?=
 =?utf-8?B?LzFkK0tiak1TTFdWTElGYktmM2FhbzVudWxETFZ0SjZCeVBBcTNNbjExdGJI?=
 =?utf-8?B?WWEvS2poK2lRRVNhSWwwMnFKTjZVbS8wZjFPVjJhelhnMlJwRkI5US9LdjV3?=
 =?utf-8?B?bWFJN01qSklVRjF0bmhqMXpDUDZLY2J4OFFVUDlyZFM3TzZWYUx6aVdHZy8z?=
 =?utf-8?B?aUpqaHpIK3dvRmFCS3NOUURXZTkva1k3cGUyVjZVeWM5K2RmU3VVZHlnVHVn?=
 =?utf-8?B?RjgwaWpOcmFOOER0Wnd3SVNBdGdxUlNjSHhJSXd1MlNpZ0paWEtTampkYjhp?=
 =?utf-8?B?MGNiREE3eFFlZ1FJUTd3TzcyN1ZSL01XdTFqdWVjWjIzNUFvVCtnRjI4UnQx?=
 =?utf-8?B?Z2VzRldUaHdpWEF2anFiZG83ZExxbTFEempmNTZOM0dhbmVwanZoUlRuV0Y1?=
 =?utf-8?B?YXNaNjlqeE80U3NmN1J0TlFIZVdPa0xHNEFsYnJ0MjVmeE1DMEcrVjBzam9l?=
 =?utf-8?B?dTUrL3JnK05IL3l0dmpGTFpaRVNhcUhpN3VQTjdLTk9nMVR5UHoreW9Kdm4r?=
 =?utf-8?B?YlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <911A3DA06AF35A428499117FA1B28702@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603435ad-b72b-43be-d370-08dc16d87983
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 21:16:58.7130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7TOekJI/uR8zxYKZsaJ1iwroq8pCADKd39FI6lzOEjGvv28CZ2Ko6GUukKDVUq/bVfPRiMm9+3tebEwvP1H8Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAxLTE2IGF0IDEzOjU4ICswMzAwLCBraXJpbGwuc2h1dGVtb3ZAbGludXgu
aW50ZWwuY29tIHdyb3RlOg0KPiBPbiBUdWUsIEphbiAxNiwgMjAyNCBhdCAxMDozNjoxMEFNICsw
MDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+IE9uIFRodSwgMjAyNC0wMS0xMSBhdCAxNDoxMiAr
MDMwMCwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiA+ID4gV2hlbiBtZW1vcnkgZW5jcnlw
dGlvbiBpcyBlbmFibGVkLCB0aGUga2VybmVsIHByaW50cyB0aGUgZW5jcnlwdGlvbg0KPiA+ID4g
Zmxhdm9yIHRoYXQgdGhlIHN5c3RlbSBzdXBwb3J0cy4NCj4gPiA+IA0KPiA+ID4gVGhlIGNoZWNr
IGFzc3VtZXMgdGhhdCBldmVyeXRoaW5nIGlzIEFNRCBTTUUvU0VWIGlmIGl0IGRvZXNuJ3QgaGF2
ZQ0KPiA+ID4gdGhlIFREWCBDUFUgZmVhdHVyZSBzZXQuDQo+ID4gPiANCj4gPiA+IEh5cGVyLVYg
dlRPTSBzZXRzIGNjX3ZlbmRvciB0byBDQ19WRU5ET1JfSU5URUwgd2hlbiBpdCBydW5zIGFzIEwy
IGd1ZXN0DQo+ID4gPiBvbiB0b3Agb2YgVERYLCBidXQgbm90IFg4Nl9GRUFUVVJFX1REWF9HVUVT
VC4gSHlwZXItViBvbmx5IG5lZWRzIG1lbW9yeQ0KPiA+ID4gZW5jcnlwdGlvbiBlbmFibGVkIGZv
ciBJL08gd2l0aG91dCB0aGUgcmVzdCBvZiBDb0NvIGVuYWJsaW5nLg0KPiA+ID4gDQo+ID4gPiBU
byBhdm9pZCBjb25mdXNpb24sIGNoZWNrIHRoZSBjY192ZW5kb3IgZGlyZWN0bHkuDQo+ID4gPiAN
Cj4gPiA+IFBvc3NpYmxlIGFsdGVybmF0aXZlIGlzIHRvIGNvbXBsZXRlbHkgcmVtb3ZpbmcgdGhl
IHByaW50IHN0YXRlbWVudC4NCj4gPiA+IEZvciBhIHJlZ3VsYXIgVERYIGd1ZXN0LCB0aGUga2Vy
bmVsIGFscmVhZHkgcHJpbnRzIGEgbWVzc2FnZSBpbmRpY2F0aW5nDQo+ID4gPiB0aGF0IGl0IGlz
IGJvb3Rpbmcgb24gVERYLiBTaW1pbGFybHksIEFNRCBhbmQgSHlwZXItViBjYW4gYWxzbyBkaXNw
bGF5DQo+ID4gPiBhIG1lc3NhZ2UgZHVyaW5nIHRoZWlyIGVudW1lcmF0aW9uIHByb2Nlc3MuDQo+
ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNo
dXRlbW92QGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IENjOiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNy
b3NvZnQuY29tPg0KPiA+ID4gQ2M6IEplcmVtaSBQaW90cm93c2tpIDxqcGlvdHJvd3NraUBsaW51
eC5taWNyb3NvZnQuY29tPg0KPiA+IA0KPiA+IFNlZW1zIHRoaXMgZml4IGlzIGZvciB1c2Vyc3Bh
Y2UgcnVubmluZyBpbiBoeXBlcnYgZW52aXJvbm1lbnQgYmVpbmcgYWJsZSB0byB1c2UNCj4gPiBz
b21lIGVhc3kgZ3JlcCB0byBnZXQgd2hpY2ggY29jbyB2ZW5kb3IgaXQgaXMgcnVubmluZyBvbj8N
Cj4gDQo+IE1ha2luZyBkZWNpc2lvbiBpbiB1c2Vyc3BhY2UgYnkJZ3JlcHBpbmcgZG1lc2cgaXMg
YmFkIGlkZWEgYW5kIG5vYm9keQ0KPiBzaG91bGQgZG8gdGhpcy4gSXQgY2FuIGVhc2lseSBnaXZl
IGZhbHNlIHJlc3VsdDogZG1lc2cgaXMgbm90IEFCSSwgZm9ybWF0DQo+IGNhbiBjaGFuZ2UgYW5k
IHJpbmcgYnVmZmVyIGhhcyBmaW5pdGUgc2l6ZSwgdGhlIG1lc3NhZ2UgY2FuIGJlIG92ZXJyaWRk
ZW4uDQo+IA0KPiBJZiB3ZSBuZWVkIGEgd2F5IGZvciB1c2Vyc3BhY2UgdG8gZGlzY292ZXIgd2hp
Y2ggQ29DbyBlbnZpcm9ubWVudCBpdCBydW5zDQo+IG9uLCB3ZSBuZWVkIHByb3BlciBBQkkgZm9y
IHRoYXQuIE1heWJlIHN5c2ZzIGZpbGUgb3Igc29tZXRoaW5nLg0KDQpZZWFoIGFncmVlZC4gIDot
KQ0KDQo=

