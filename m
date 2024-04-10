Return-Path: <linux-kernel+bounces-139103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B689FE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3FB1C233BE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDD717BB3B;
	Wed, 10 Apr 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VtkQZYXf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="a5EFFFOO"
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D417BB27;
	Wed, 10 Apr 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770341; cv=fail; b=NdYlMYhJmePiQQOB2R+aUyvkyd0g9McfGZc7Rc8hq8RFk8c1tYWTXNJPdWcZlqE5ymvWfe0mvCELhFO80qB2YSjt5ndHN+gggaxxHfNDTxkrMVxnz93pFlmreIi0jVcAR/JORibxx6gUnmdvfrOnA98/1Qae9X530PuqOHTo1lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770341; c=relaxed/simple;
	bh=jp0RGr4RkEoWdTJYZj7X+HS3y0hA143RDdPzxsx/bPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VgV25dEC0B61lKADWa4GMpZyzSDTiarwU1xyO1d0koZIHEI26s3G1qXvtyRizeMZjKhU+S63+BdY6VS/lEyq7mRQWa/VBNPmV3+e040hgwtc0vq2aP0Bjw6m7oCO3AfpLeLZ+tDm0hiPrufOoE4Du0E0thUUeaRypeyWLdUBjSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VtkQZYXf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=a5EFFFOO; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712770339; x=1744306339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jp0RGr4RkEoWdTJYZj7X+HS3y0hA143RDdPzxsx/bPU=;
  b=VtkQZYXfHkfl/DywDHajo9EUPdJkX0RxrgzczhjS2Hmn/tOk35xeGn7Y
   nV0L0RKCmqo2v//sxnyuLcPntz4n+GLdJUenfp3QKsUj//j+1iDLBFByZ
   nFAxjzQZQnQ0xXAm39/P9z/iFvcJ2BDfzxH6+Qt+mxkbDLMivp20jivh/
   lr9/rHqq4Iq/jhRLKRvmaqn8MacEsQtRpG9UGn8gsZDTFC5my2OzbCs10
   FyG4og8bAyDWbeNLb25F3Sa3sOOj8ISI8JEQ4+dRaYI1JYG6DHOAxzVf5
   RGaZnudOIGgAHVYOjEv56S2t9+pFevj9lN6vlRp+YzwcteNDShavXgj00
   g==;
X-CSE-ConnectionGUID: 3qovEnvCRUW2/x5UomnHVA==
X-CSE-MsgGUID: qpeBPRXiSL2wjwyhJY3q8w==
X-IronPort-AV: E=Sophos;i="6.07,191,1708358400"; 
   d="scan'208";a="13703239"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 11 Apr 2024 01:32:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0N8LvRCrFaWO4r/d0H9RCs6nDCW4Is1B8gqRU7IDeadDwhF1YSqdNxClse7gREkuJoa9Eej2Xwhs8ZZ+vkMd9gewtYZuqBxf9IsXE/lC5nPGg6gIlXuMvVJQNuejW61l/+8Nj7lSWvB9DTqQdGClARjC2+CiOd/crb/h4DRSIntPgemvAY7RacEBsU/evriksWYYNcvTmnJMYB+O0AebPRUeA1AwBv3AE0crE/gvjjnOX/DFxVCrXsJoOa0NNKHnLzFREc4RKHJ3Iv++4HqTSYqQUq+iNf4y49OeH/Ab6uB0IJXXZCbtGI/xcLKhWjSnMM2aOMQZukAeiQrloINqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jp0RGr4RkEoWdTJYZj7X+HS3y0hA143RDdPzxsx/bPU=;
 b=jZV9Cw2sACHMjlSQcgduaCcfCfiDSygqK0eQlW5gKdLl8xaZa7+KIYN37pc1GwZQ6hLwkSslRL9KiviF34KW0kwffdgP1RABeSJ/Iam3XWO+uXd19s/2yhhX0uTkiAfq6jTPH5iqBBwsuvCVJMmDxE80+MN8kitTOKszsITSKB8BjYUvGH6sqxD+6VElnH2ysi4bJ0j3HaA3StLzNgqt6MYUQJNvOgPXOUF73UPME7CLiLO0scDVUBnh5iVHmeuAo1J67UWAAQYWnn5WbY3VwKMP4U6oPquciYwIawoncXe76aP7Gg3GYRS1XWB0os9A4elRIBDbHRipcAGziSl9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jp0RGr4RkEoWdTJYZj7X+HS3y0hA143RDdPzxsx/bPU=;
 b=a5EFFFOOtBS71SOLdiyWE9807jP/TiFh/NmhHntnzOzpYZzODJJ+JOHbd3LpICPMcro2QTFHLwkdb+QZKIbdQYHcGC82OJGURGs3yI15fGEKd3kMZOhhXQZnuGz+u/6oEneok8k0c8Dtj6IG99S3RlvJN9OLrH1cThouhsr7RpY=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB6855.namprd04.prod.outlook.com (2603:10b6:610:a2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Wed, 10 Apr 2024 17:31:58 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5395:f1:f080:8605%3]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 17:31:58 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>, "James E . J . Bottomley"
	<jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
CC: "hch@infradead.org" <hch@infradead.org>, Bean Huo <beanhuo@micron.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/1] scsi: ufs: Remove support for old UFSHCI versions
Thread-Topic: [PATCH v3 1/1] scsi: ufs: Remove support for old UFSHCI versions
Thread-Index: AQHaiLFx8LxfQ5dil0mKLRXAtAu0DLFgmbGAgAB/P+CAAK7yAIAAAJxw
Date: Wed, 10 Apr 2024 17:31:58 +0000
Message-ID:
 <DM6PR04MB6575A2115B4CD3CC11BCBAA2FC062@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240407060412.856-1-avri.altman@wdc.com>
 <20240407060412.856-2-avri.altman@wdc.com>
 <37c51970-1408-4a71-926a-780c663e5572@acm.org>
 <DM6PR04MB657551A7FAB39883B3D890F1FC062@DM6PR04MB6575.namprd04.prod.outlook.com>
 <8b3fd7b3-3fad-4baf-8df5-55fe0fdc9438@acm.org>
In-Reply-To: <8b3fd7b3-3fad-4baf-8df5-55fe0fdc9438@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB6855:EE_
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1837RhqL5S6N0j/N+8Rb5i8JL/fdkOUzdZf21yeEaSCtJgWJVkwvluLbieW3kB3WolGLNKO1a2m469yk8ngsmst+P+ZLeWdqBOCSL0LJth8P38rhPrGj+stlWvFN7swYk179CIpARzBDWTRR6tO0RJ7RyFBjqAkBLuLgkfLsbNjFF/l4GYRqy2JfrCZAOturxwQhzAJdDt713IO9HzXO20GrWYbAEbJIyWSzn2A0zqC7irb5ztyCgc9wdVojlUVrcD5t/Ud0oJBZ7HqsOT9sAgujajFf89bJBfop+wl0erG3DxejoaPEOjn0hUS6VLf2fW++tWCxCD7SmExYwEpB9WB+mheYsvPRLUNoyjvf2TlBpo8GGJr35pHn1EOrUZDJKyzONxzT+LWcHRUkEpGh9OWexfPCRjmcdxwgyK79sTB4bHsvQyrIj29B3GBpYoUeEb1jszl4XseLRD4Bq7O9OD+4P1Eu8TU8e0yTXhoaa6GmUTUGIDgbs0VnwLf3MHrFOhHr+US+/Gaq7k+wPeo/VoVKxj9PFC7y7nICQnVK3jVqQdCjMMgsEbljpDu2pCTP//TKuS5IHgLR89Hdm5vHSN8CnFPaXABfFBUMpq5gOC+x/oGJSHcTRtGUQxx6mqRKnPDKM6hJPIqWt0YIlFAC+PRUNlHYwLwhxtBHXrwT2vA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ekVTZTVmQ3ppTWROSDNrSzdaQmFUS2RzNEhaSkZvVEUvL3dNamxGcGo4Zk5u?=
 =?utf-8?B?QmorcUczSThRVnN6S3hyQXFEWUNuUGZhOHVIYzFJK2ZhSkcwSE1kTFBjQWRi?=
 =?utf-8?B?THVPd1ZMSWlvbmZDN0pmTXBSTHZSTnB5eS90UmI2cGIrYkRhN281TlJRWE9M?=
 =?utf-8?B?YkI4c3BPVGJOZ2pxSUZOTjh4YlBOWDIzTGdTdUtQOENVbWIxN2xDU2hKWEFZ?=
 =?utf-8?B?Z09HMmN5MU1JRmp0dklnVGtIT25JYllNKzJKZzl0VjVkcWFoWWVvSnNVV2kw?=
 =?utf-8?B?bys1WVVYNENnVDBKd0YwbXFqQVJLOTdqNnpGUWpIMHBkVVN3cE1EdlpGd1pJ?=
 =?utf-8?B?ejlLcXVnOWxhSHpHQTN1Z3lEQktYaFpYNlJFZC82ZWx1VTdTTXhtVGxCK29Y?=
 =?utf-8?B?dTFmVmFGY05zRERJblJxSW1UV244aExJc2pGaDlRdm5EdXFlRi84SHdDb3Vl?=
 =?utf-8?B?bWI4UTdITzV4Y2FLRTZqejlSR1pOUk9PbnRVNXRUVTVaZklEUldVOEd0REh4?=
 =?utf-8?B?MEVnaDJmSlpMb3N2cnVaajZvVFdOK3E4Z3NWdU1ueWNLcXRNSHZHcnpuSi9G?=
 =?utf-8?B?bXJGR3lDNGxTQUFnVERYS0JMYXZWZWlPN29heWVSbW9jYzZHZG01U1F0UHFw?=
 =?utf-8?B?Q1dGQld2S2dYWWczWlNTSnAyR2tVZVNZNXRHZGE3OHA4ZWMvdVpaZXV1eGFv?=
 =?utf-8?B?RzYvK2xzalcxQmVTUG9nYU9oU0k4MTJnYUlSK1JGekc3a3BadzdteEJvb2Q4?=
 =?utf-8?B?S2JkQkw2QWVtT0JrR2Ird1RWKzJyYkE2b1ZoaHk1ZGtWcjc4Q0J0NUFQRWlG?=
 =?utf-8?B?cWlCZk9WZEVaRW9GZDVUNTg1UnExeGR6WExodEt4OEg5MWRST3dsZjBWdnEy?=
 =?utf-8?B?V2xpeFFzOXA5WE5vSVM4eTRoMTc4REFCU1ZHQ0hHS1JTWXloQzhZaXFmbVh2?=
 =?utf-8?B?OEUyaXlpK2IzbURaMUc5NFZ6aXd0VGN1NzFPS3RTbFpML2pyWjI2Y09FWjZk?=
 =?utf-8?B?Rzh2QlBrQXducUErKy9TUEtXZ3V0aVVFRjBBSGg3a0lUNmlRWUFPTU9WaDB1?=
 =?utf-8?B?WUZxd2tqM0tIWHBTRXF1ZXE2TGtSOW9lOHFDK1RNT0ZFS0FELzJhejJSdUdZ?=
 =?utf-8?B?VThXZjlPMkdsS3pkeFdVMjJWWkJxRHNRTFdON0VmczRKS2xFaXVJTWFtbFI0?=
 =?utf-8?B?YnZyTEdtNDJ1Q0p1Nk1DMjhTS3Y1a3Bjd3YvQUtYdlM5SGh5bUp2d1ppMnZ2?=
 =?utf-8?B?NnJjNnltMnFSUmFaNUhwaE82TUVBaUs2M1hNWWRMMEtNcDRwb00va25oWC9P?=
 =?utf-8?B?SjlVbFRiVzUzUm94bXN4ZGMzRGhocG53MzA0d25jbG4xMVkyTXNTYjFKdEc1?=
 =?utf-8?B?dWRqMmVJQWZZZVluMDNCVkIwOTRsOXJIU3haUmdrdFdrSS9IVmNtdHJySGxV?=
 =?utf-8?B?Q2Zhdlo0amJUWXNvS2Z5NnNDSHlhblhqM2RvV3RNZXROaUhJMi82cGNlTmg0?=
 =?utf-8?B?b2x0TGhHYU5kaHdrUENhWlZtejRRWE5NRDJIaW1rUGE1Y1o2THFDcjBtK1Bl?=
 =?utf-8?B?dk9kS0dsMVVwdWNhYlRiQko1aTVYOFhtaTNYb3k2YXdGdnF5dUYzc0tPOEpW?=
 =?utf-8?B?ZG5VeEp5Sk9OQ1gyeVNqNTdyTEE5RHdGU3l0V0dIT0N0SFF0Sm1icC96L3Rr?=
 =?utf-8?B?d1ZTaGUzTkxPYjNyU0cvZE03SlpsVjdvR05XQTd6YjF2RmIwWU5vc2pYVGFh?=
 =?utf-8?B?cWIrRU5TUXdLUXQzaHZoNENHTjQvbjgwZkFSenlIWDdjS0FJc2djVEVBSUdx?=
 =?utf-8?B?WUhPeXlHY3BxazBVdE5rbWFmZFduRmRnTVlDSmdGZHNlbXpVUGlqaEE2SzFk?=
 =?utf-8?B?d1h2ei8wOU1ZRVJFalI0QXR0VDFrWVNGUkR3QzlGVkhpdk1FWkVON1NVcW1q?=
 =?utf-8?B?dTZYeHVGQ2Q2SGYybXhvVlNNZTRabDVtWTVzSVE5N2RxZzc0MmN0MVhUQUNY?=
 =?utf-8?B?NG1qUVluYnlkbjVnZ1hTYXhvVlRuNTVpRUhuWE9wb0xHbUVCcUpRVkVuTkIw?=
 =?utf-8?B?OEt4VENlVkJPV05YeTIzNG43VzlUZlFYVUl6M2luVlM0dkJMU2VqTDhTR0VM?=
 =?utf-8?Q?cbh5/rGMhwMVYTeUvqPXxUvmE?=
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
	QnlLi/T+NvKgJl9i1FvryzHXVIyB714+sD9jduD/kUbhS0TtW/Gb+jLgHgTgD4leV5QUE44o0pIhRhvASJHGiAnfd9rqivynG8n95WJIUdVKoQslnAmRLzPLT6Tleoj3Kvp8TLjDbkGt9K+BI0B2Wi+BsV4+nBT7xTXCorpa2HwpqsT4khKCnZBNFzDNTVyjpg75pSTxa0Arhl3coAHOmo6qYcnbBcjpQGcedSU5IKtKgH+L32CSHzbCubjRGXesQ/x2p7SoVno7gxO8aIbwOXV4dRG6jdKfp89Nx2UnXt4uJ53IuMe9clYI08GkV1tXcRGpEC4+u7d6VPStD2ZQG4jzmPZfcEOUXh1FvYUVza1ZUTGhlC1FDu1joSooEY43Mx42mb7/jiFNS+zu1QH9Dj6M61vJSqeeofMmtt6PK4i4IQU92Pp8l3dcIcBsR6+79w98sL20iDKoy/vFzsPSxPxaLC+Zu33hS8RrsGJZ1zmPMtXZFKrv08ij+9MtZXWNxQeH/i9DV6BMyaXtES5thQM6F/YwdSQibKz7MaOg34q9XbU5253fOA4Iyau0QgfpN3b/+H/MFcj5lZrvYas0+ndcXIWxZt8DggcyU8MEYKgF2SVppgAUWnn772Czgjab
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cde30655-f4c4-464b-1707-08dc5984200c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 17:31:58.7641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZlCCBKqLnyCjns4Q9VABA817stKjaasa4o5B/O6oi3wbsJu7R0T2ctoLvBD2LJW2Ie8vna6ctf7tYdX6HgvJOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6855

PiANCj4gT24gNC8xMC8yNCAwMDowNiwgQXZyaSBBbHRtYW4gd3JvdGU6DQo+ID4gQW5kIHRoZSBj
b21taXQgbG9nIHNheToNCj4gPiBUbyBiZSBleHRyYSBjYXV0aW91cywgbGVhdmUgb3V0IHN1cHBv
cnQgZm9yDQo+ID4gVUZTSENJMi4wIGFzIHdlbGwsIGFuZCBqdXN0IHJlbW92ZSBzdXBwb3J0IG9m
IGhvc3QgY29udHJvbGxlcnMgcHJpb3INCj4gPiB0byBVRlMyLjAuDQo+ID4NCj4gPiBJc24ndCB0
aGF0IGNsZWFyIGVub3VnaD8NCj4gDQo+IEluIHRoZSBkZXNjcmlwdGlvbiBvZiB0aGlzIHBhdGNo
IEkgc2VlICJsZWF2ZSBvdXQgc3VwcG9ydCBmb3INCj4gVUZTSENJMi4wIGFzIHdlbGwiLiBJIHJl
YWQgdGhpcyBhcyAibGVhdmUgb3V0IFVGU0hDSSAyLjAgc3VwcG9ydCBmcm9tIHRoZQ0KPiBkcml2
ZXIiLiBBcHBhcmVudGx5IHlvdSBtZWFudCAibGVhdmUgb3V0IHJlbW92YWwgb2YgVUZTSENJIDIu
MCBzdXBwb3J0IGZyb20NCj4gdGhpcyBwYXRjaCI/DQpXaWxsIGZpeC4NCg0KVGhhbmtzLA0KQXZy
aQ0KDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBCYXJ0Lg0KDQo=

