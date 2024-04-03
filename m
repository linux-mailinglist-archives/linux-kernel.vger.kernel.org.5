Return-Path: <linux-kernel+bounces-130499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DB28978F8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B7A32847F6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBF3136E1B;
	Wed,  3 Apr 2024 19:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="mR2IvEBX";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zYwkOnVi"
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D43154458;
	Wed,  3 Apr 2024 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172306; cv=fail; b=eR/DTIgBPSo/EurIIiC4qMVr4lRkv+MIOGo/R17M98e8Jl0Lalrz7a4LLnb5e9rKQ8qpWP6V+LcAGSHrmmIMm1CUrfaoOB1v66Kc2s21Zd2VH2Q6/sBkuk6b111kjo56g7WxC6PgM8P7hDd+yz0ATOJOKf7+JGqBBmR/SVXLPQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172306; c=relaxed/simple;
	bh=cIxsya1GzfPiFIWarViwohwIh6gqZs3VUgwjb7rBhWk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oTehnPEGxpdOWEUP//Xe8knDHzXG3+ODpQK9NHTLMivUfaVPU+fHFbBEePeMWBJTqqMz+IoMCetCfVq7VDoPQ/n3mrKm2TOroF1rOg4cDe8IIGWwaFQgPgEin8orYGT1U/MWoiRbhZ7gEkiHg2Svqet+4AapqgWVyZ2+6DhSj7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=mR2IvEBX; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zYwkOnVi; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712172304; x=1743708304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cIxsya1GzfPiFIWarViwohwIh6gqZs3VUgwjb7rBhWk=;
  b=mR2IvEBXZu0NCA2iXNUFZcERjMX/HVwSHLlaeFN+ltqMr797b4pegFkT
   IUF/MrhlfB0qLg5SOGEv6zh3PDLSRYrLLoIehTTKdAxhM/v6jWPO1y3IL
   o2HBP7HEgyqwbGG1xaE25lLhBRiNgQP0nKFCJ9KthOwHZM5+PupEke95T
   6f7KdRHwoaR/se56wFjIpKdZVy+sNcbuzc/XOoOKJERrjkQ+yUjS14AC8
   BLGSx3RFs++ov/fDkwqQPc0GqoISaJ5XuCutoMaad/CA/6OhypY37XLnO
   xxESu6IKBuIPqdB95hzAVn941GTZRGVBFD5ZLIupnVV7OhxiCN29pLCtL
   A==;
X-CSE-ConnectionGUID: lbPsIuslSySAaSy7Ryo8IQ==
X-CSE-MsgGUID: EGwpLMKSQN625586Odzc8w==
X-IronPort-AV: E=Sophos;i="6.07,177,1708358400"; 
   d="scan'208";a="12668461"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2024 03:24:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PC7xDQHL9+xOpnQZpEgY/jCtUFFIWFJp//tJuFqxp6rhZ0kXDsns+cpVvW0Q7LxLA6lhdh5MDxJQpALa7D7K9S3k6xJ/CelJecjRltatlqkeFh95AXYcmw+z4Z2atQ4IXJpWuX/ZNH9CfZ5zJz/rRIkAr29kEQKhvlFhyHR8ufUng7thAtkxUJN8uHHo0/5t7MHs17qYEPphMhm03rQOIi1j+NihkWwF8VlEbuN1LgO456/Lj6caXf1YAQLB+ooQSPftd+pvqDsnjCHgCwVQP9/tef7X7CJ0EK3TsiSHaWEsSf0a8sfiydOmjTomS+ROer00K0pjtryZe45tWG0dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIxsya1GzfPiFIWarViwohwIh6gqZs3VUgwjb7rBhWk=;
 b=YSRh3rPh/+VFLiwm4V5MpsrlWx+rIEb7fI+1OhB8GXpc8sCRx5IzCDF54NJQG9inK3aROowDtouLe9F+JJNX1aib7+0bADQJ+n/sU3enAe5jxuTiweQAketzcPy4nRbKOMt6OC8lsfIaTIImz5zHBINZKLoq48r8ND1AN42tsgW+clf08IPpoi0cgQJtp8Giox9BWSYZbBtO4OidO+oYOogkrJkUOxMIy/BwPYLyg7HNUIp2ThUxsXfLCHbmrzvIHnpNyAmUidliwbnIGDK/AF2K7jvFyu3MmisduU8VW1H7dxLcBa8QJ5xDVUnmyVaY/2fwe79LUXXkStNyPu0R3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIxsya1GzfPiFIWarViwohwIh6gqZs3VUgwjb7rBhWk=;
 b=zYwkOnVivOpGRTR/GtiwbQSFmI4N5/dM6vYCMs+wbfelJ1/Cz4aqlYAHYvNqXSNiZMbAeaOgpCGNsJc9jNKvdRyFNHS0gAPff72iEzu2jfqThE8VEVWOTJ4cDsD4rRIX8xHRmZN/4sn2QJgACpuhuvEwYnvE1yq3T5vOovpjvRk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM8PR04MB7960.namprd04.prod.outlook.com (2603:10b6:8:6::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 3 Apr 2024 19:24:55 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 19:24:55 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "James E . J . Bottomley"
	<jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: "hch@infradead.org" <hch@infradead.org>, Bean Huo <beanhuo@micron.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] scsi: ufs: Remove support for old UFSHCI versions
Thread-Topic: [PATCH v2 1/1] scsi: ufs: Remove support for old UFSHCI versions
Thread-Index: AQHagBbadNnO08pKSkSNxLt/0+cGXLFWx02AgAAuM1A=
Date: Wed, 3 Apr 2024 19:24:55 +0000
Message-ID:
 <DM6PR04MB6575BEBF605C9095E62F49E3FC3D2@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240327071714.757-1-avri.altman@wdc.com>
 <20240327071714.757-2-avri.altman@wdc.com>
 <66431679-26f0-48eb-8303-35e151481292@acm.org>
In-Reply-To: <66431679-26f0-48eb-8303-35e151481292@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|DM8PR04MB7960:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0B9uxZ+FcuQAGnAG30NZXGBw+1vPbvt9xmNAaka4N+f/EA+eBzgjbs6MARsCIBw4/NEvWXFpmSBnxxBGlgATRWHHqJoSqReqajno5Kwr+88vtlSe6w9S40nHwOJsgnlLq2apte8ycNwFLMuqItHLWVqRkWZPUBBAQzqqMmdnyO6fxTDV/ZegDi8BXfbbSBxjHRK0ZbVCxUp9jIYBIju27uPWN74OWMBgOkRCBxnMsQrqGbC3G2IT6V6OaU7VWGeqlr7w5zjXU8GgEV/AvEXZsg54hKkbjN1t8hZERv2MCXhsRyQvVen53aU6nnAOD/t4Q+VR3kLn6yt5/6d+j0tlXvLWtNkMEOe+lRWfEBrSvT6Qqqoc+LespE9i+If5Xj3Lk5M7V+sD69WPi+O9z6L/XrjXAWhg9rC7e/sSjmroPX9kExSssNyZ7OOW33Cok5Yi7MSat0xpPB9U29jlPejRdeXIfwuunMpaGzt7cxWEmfJkMVFMSkU+qlJYI8wC+e9Rf3nzyK9F4JC0+GG3Aks3v5RHkB1LLl2RWSDem7wPBY8PSPLPDfzBj5SR5bjVq+ZLkgnzBdxlaE+LoyiQkJMTThLa1QwyyUd3LSuIxstgTwY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Sy9McTY1TVJvZkNSS3MybVhyd2JwRUplNDVWdlpoSVMwemo2R1QxU2RRR0k4?=
 =?utf-8?B?MkFtTkNVTldkU1VGMC9DcVdXVjVIdTlJbGlXaTVqNzN0QzgwTHorcUxKQU5O?=
 =?utf-8?B?ei92b3JSR1FTUWE5THl4d3E0RmN0MmhJUFhGR1pHNWNWZTdkSzNTa0JPUjBo?=
 =?utf-8?B?aEpIZER3SHhqaWozTFVYRExlUDNOV0R2MnFPVi9BYjRHalJDNGdlaUFMbmFZ?=
 =?utf-8?B?YWlRa1hTRWx1VmR6TWpSeHRUQjVzTGthdzFtQTJ0aThuQVBpUCtUN2hOREdn?=
 =?utf-8?B?MUZYc1ZMR3B6Ui9jNHJRRUJOWkVuR3Uramo2Y1ZFYkZ0R1JqYVowaVVNdVdZ?=
 =?utf-8?B?Y0lneVBSSzU1QTZsQzR4R1g0bzk3MXRsTFdOMHgrTkhoclVCTlVVbHZkR3R4?=
 =?utf-8?B?R1hkNjc4NURITE9pV253SEdyUHRuNENDeklWZGdGQnUraHJhQXNDSXR4azNo?=
 =?utf-8?B?YmRzRFl2ZENzUnh6bFJoVzBCRG1kaHFRTHpwYWVxVXZndktiZjBtWTgwMWpS?=
 =?utf-8?B?YmVwVEVtVm94KzVaTUN0eXAyeUxhMHJmWlU3cy9xZXVWRE1vblRueWJBMVFY?=
 =?utf-8?B?dzJuZkhuenFDRjkzdTl5bTlkNUg0aFBTdzhMOXZra3VITWVLUHh4SmFRU1J1?=
 =?utf-8?B?QlNRaVFpK0FLdDE5eTRDQWNybGlWTHhFQVpULzdDd0FIQldoMjBTZWt0RjFE?=
 =?utf-8?B?aStCL3dNK2R6cjVBcEFXQlMxcDZ3aGFKYy96V1hqVUNGa0creUhiRXhRRkZM?=
 =?utf-8?B?ditlR25taHVnb25aUUw1ZGN0Ym5VWmtjelpPRi93UjkvUnZDb1pFaFNhQStM?=
 =?utf-8?B?SFhPRGxZdjU3czRBc01kNDk3Mml5ZDF4OVFwUmExbmhKdUlLZjFZZ3VSTFV3?=
 =?utf-8?B?K2hsRExYaktEeXMzTEtlYUd2Sk9wam51VWEzSktSMFhwbnZmRXprTWdBRHpo?=
 =?utf-8?B?NGpRVENMdnlnV3lsOXYrWlVMTlVzMGJaRXQwdDhpb1A3cituRnAyOHUzZ2Yy?=
 =?utf-8?B?dUlrc0hEcGFFbEVMaXVBbjFtL0NXZnRhTXNxMm1EZVVNNXE2ZjA2OG13MEZ2?=
 =?utf-8?B?WVRJYU54UWZmcXRJRnd6YUFhMEdUR282ai9tdnA1QkhYZGpxTFhNVWp0MFZn?=
 =?utf-8?B?UC9VZ05PM1F2SUpGeUk3R2QyVGJuL0FFUHlFcnJMMElmZE1zMVcyZC9ZQnFH?=
 =?utf-8?B?aG82U1E2ZzZvY0RXS1EzNmF4VERJS3o4UFAxK25ZRFAyMTVhelh3ZDVZWExz?=
 =?utf-8?B?WnRYQ1IxOTN2dGpjSDJBZXpVNUUzakcwWHRQYVVHVG0xZHB6eHJzclJPWHpX?=
 =?utf-8?B?ZUdMSk5PcTdkMEtMNU1pOEp3cGZYZEt6aEhSUG1uV096TzREbTZlZnMwOFpZ?=
 =?utf-8?B?NnRQQlNLMWRzUU5aajdTRzkvaVBzcmh0d28vaWVNZDllKzRuSmdMMkJnWTRI?=
 =?utf-8?B?VmtoZTRQTkhEaW9PMFRwcDFSUDlLUkdEQlpHK3VaZnYzSndITUJPQXNyNW1Q?=
 =?utf-8?B?R3JtNHVrQ0oreTgxMXZJQ2Z1b1FWWm9aY28zbVN3VE85SXBpOUJsRXFOanNF?=
 =?utf-8?B?emhodkF0UWlGdS9FNjIrdjc3dnhvZXg2OHFtd01RRmxWd3NXSkdyMDJPQ3Vv?=
 =?utf-8?B?VTBHdGlobHRXZDU5YndGckw4blYwOHRHRi9LcEZkcWJyeUpaMGZEb0o5VGpE?=
 =?utf-8?B?cE8xclBONEpyL0pQKzE0eVRIQXZ3MFJkYzVhY1RNdHkya2tMUnd2a0UwSFJw?=
 =?utf-8?B?NmRSQUlQRk5VVWloWXNpdy9mTi9ibWdQZkJoMWh2eWg5WmcwbFp4ZkM1WFRu?=
 =?utf-8?B?R29Ia0p2M3ZXUDllbGtNb0p4S0dSZEhVZDFhQkQxbFJWblN6eXlqdVBsMEs5?=
 =?utf-8?B?bC9Jd3hnM2ZzY3ZpdStUbnljR0tLdGM0UXhWcW1BVkovY2hvUlVXdzlWRUFZ?=
 =?utf-8?B?cS9PaFFkdllLcFZUZHppN1YyU3FjM1ZidWZXSVZjemt6Q1p5eWthRVpsK3hL?=
 =?utf-8?B?NTRtYUpHZkhjYTA5czFKNG9laUVHTXJwT1RDMG1aeHZINW84WDhSejJabjRF?=
 =?utf-8?B?RHJTK1VQTlNIZ2h1L0VMdGZoWVpteXFLREorUVlUYVlKRTlJSnB2cXVmallD?=
 =?utf-8?Q?QP4EBpggwsuOFhmUXY6Xqb0u7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IAGlAGOsMdQVKtXsfsQqRJ8CvUwzmYgJd2l78t7N28LERq6WMHiYHCONANacIJI3ul5Sma/Fdez65W5Y10XqDjYym3PXw5Uq3mpm17jH8XkeIt4/1TCKPVIemYLmu7q7xeeiQRSC0uy3d5/23Ptx1wC9tfzNbJM+vEFIDsq+oDJeKI42AM9Wb8PcjStib3+YbQ8cMShmkFHdRV1Pnni6G66ITaaipvvibMVGMuuN5+OKOGRyHA3lPIWYIhPOIqw6aJG5XU961VE3XduPuVIeBK+Bhgxm6bJ0mVNDsv4H94qfvfVw2Z4gEAbolBUEkgLd61KyDkmQNHxnWf8Ivhy9URFSbtZr2fC3WkzXMOWXkRCnoNuA2ZKYTAr0NH9wD4QyiQcUxqaI7SncXNEF/N9jjdF/z5L0UahS1ZUrsi3TunYe9KFn7kc18AWUu+Cn/wU3nJnYq9SWz5QKErVCN9yWvur7a9k16ubDu2mIwnis/xF3H7nBVvoJV2G72lOBUJxwIb/YYEBSU3hsk1ZWDyo1P3a8OGkif7smO3LvFSaj4beJVM3wKe6K4EsPWipkEs2HG1l4M14P9RxDIYmKrYdbSVUcKjipNM9FTNJi92M2avuZsJhx19FClavbv5JMvtY8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7be477-2153-4036-9316-08dc5413be41
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 19:24:55.2800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 41j8NZdIZzsdItkgqEiMmv6/kyBR5NNsxDANMq0YoRhEH+4psGdh+mPHabYkWo9/G3zrPBrJCP/uryphAkbbYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7960

PiBPbiAzLzI3LzI0IDAwOjE3LCBBdnJpIEFsdG1hbiB3cm90ZToNCj4gPiBVRlMgc3BlYyB2ZXJz
aW9uIDIuMSB3YXMgcHVibGlzaGVkIG1vcmUgdGhhbiAxMCB5ZWFycyBhZ28uIEl0IGlzDQo+ID4g
dmFuaXNoaW5nbHkgdW5saWtlbHkgdGhhdCBldmVuIHRoZXJlIGFyZSBvdXQgdGhlcmUgcGxhdGZv
cm1zIHRoYXQgdXNlcw0KPiA+IGVhcmxpZXIgaG9zdCBjb250cm9sbGVycywgbGV0IGFsb25lIHRo
YXQgdGhvc2UgYW5jaWVudCBwbGF0Zm9ybXMgd2lsbA0KPiA+IGV2ZXIgcnVuIGEgVjYuMTAga2Vy
bmVsLiAgVGh1cywgcmVtb3ZlIHN1cHBvcnQgb2YgaG9zdCBjb250cm9sbGVycyBwcmlvcg0KPiA+
IHRvIFVGUzIuMS4NCj4gDQo+IEFjY29yZGluZyB0byB0aGlzIHdlYnNpdGUsIFBpeGVsIDEgZGV2
aWNlcyBoYXZlIGEgVUZTSENJIDIuMCBjb250cm9sbGVyOg0KPiBodHRwczovL3d3dy5nc21hcmVu
YS5jb20vZ29vZ2xlX3BpeGVsLTgzNDYucGhwLiBUaGVyZSBtYXkgYmUgb3RoZXINCj4gc21hcnRw
aG9uZXMgdGhhdCBoYXZlIGEgVUZTSENJIDIuMCBjb250cm9sbGVyLiBIZW5jZSwgSSdtIG5vdCBz
dXJlIHdlDQo+IGNhbiBkcm9wIHN1cHBvcnQgZm9yIFVGU0hDSSAyLjAgY29udHJvbGxlcnMgZnJv
bSB0aGUga2VybmVsLg0KQWN0dWFsbHkgdGhlIFBpeGVsIDEgaXMgYW4gZXhjZWxsZW50IGV4YW1w
bGUgd2h5IHdlIGNhbiBhbmQgc2hvdWxkIC0gDQpJdCB3YXMgYW5ub3VuY2VkIGluIDIwMTYsIHJ1
bm5pbmcgQW5kcm9pZCA3IHdpdGggYSB2NC40IGtlcm5lbC4NCkV2ZW4gaWYgeW91IHdvdWxkIGJl
IGFibGUgdG8gZmluZCBhIHdvcmtpbmcgc3BlY2ltZW4gb2YgdGhhdCBkZXZpY2UgLSANCkl0IGlz
IG5vdCByZWFsaXN0aWMgaXQgd291bGQgZXZlciBydW4gYSA2LjEwIGtlcm5lbC4NCg0KVGhhbmtz
LA0KQXZyaQ0KPiANCj4gVGhhbmtzLA0KPiANCj4gQmFydC4NCg==

