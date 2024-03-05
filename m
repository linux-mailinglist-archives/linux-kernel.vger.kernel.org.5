Return-Path: <linux-kernel+bounces-91861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E64871789
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB3D1C20E84
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0C97EF0A;
	Tue,  5 Mar 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FvPoGhg3";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="frjkH0kV"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D33FB1B;
	Tue,  5 Mar 2024 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709625815; cv=fail; b=TuNOCRyVti+ei3Jg5tW9oAud3VTHWlmHWpiVWtLIDwwSy7VsUmXQc2hVPEzJYCgs3fBdvfRu7rfdSOr6D4JGbsSwuftL0O4Y+0Xf29I/Fxs8UT3tq0WY4SHD2GrIWHmrF3GboxSQu4Ykl5621YCNqg6/lX2sb9ezTATOzLAu8t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709625815; c=relaxed/simple;
	bh=nN2T0U+N9m8mrwswwuA/s3SdDQ2IjZQg1lIJW7s2IBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OBkACDaPs0dJWgAm+Vg/aU78lJ4C1zwGx8KLPj4YiPl3mURSztDRKz5d30g2F0RvKVdokRELDy+APVWFvO0klSkBEJWWji2MBEw4JUc5d3nhEstzaH9tye0XhWYqYkmmR6FZN6I/pQ1qTd6tj/ejjvEl9Z6FO/GrzmmGa/0bAEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FvPoGhg3; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=frjkH0kV; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709625813; x=1741161813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nN2T0U+N9m8mrwswwuA/s3SdDQ2IjZQg1lIJW7s2IBg=;
  b=FvPoGhg3C4TWKO7g0HHJu7vmCzeYLEculcQ/LyXRdz8hKsbxbihjEclu
   /rF7qdH6+YG/B8z1N7MAtnGGzHVQkcxlPFUZartgudacQEYamlynLI0BI
   iWxVTzYm3g0BBuqvBtOW0PJHcBZna2sVlWv2mR8shiwapQSWoA5zacyhj
   bBF4aI5gz98j0R2WU6Pkh0SLBsUwv0zLpANMmZciurewYLxhGNNNoj9yH
   NID8l8ePqN490RTjrDCnRppowKyQpNUW20m1Wh9+EBDI6YkkQXri0IOdc
   fe46sZPGDVc5eiaSaFjIv3evdQoIiGKrCCdGG/Cyp0co1+AZGZj6gWxF2
   w==;
X-CSE-ConnectionGUID: z0+SRjbiTeasmqISzyc2cA==
X-CSE-MsgGUID: hcN6ANOMQ4STJc3Omo5KzQ==
X-IronPort-AV: E=Sophos;i="6.06,205,1705388400"; 
   d="scan'208";a="17201235"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2024 01:03:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 01:03:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 01:03:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwizQZDPGN4gdHMjRncawgEYNZTJX5F1+9xB/1pgjVhwpAdcS1O/0GHNwmx2lbcRkhbsXcqhjz/CEHfxe79iRn7wVSrdH02Ha5scwiWIVGRte8oqTiOhJS1lvyD/IvFtyX4HbAHTJGDCTXJr3dzc33iuQpe5d6PQq/UXPVblbOr6Nj14cNbVnSSZHpI7ZNzg6r6pGhBvioOFpsJoitEhyBvL8wsZBOTPlUFEeCazRm0iMPHUfRguwiuWjfZUZuhExmLI9ODm1yVzb/UiBXurrs1QjbrLU/g3d3Z3f50Eih7Ub8sAaPgGZMZgv2HM/2qU1pipng7N6dYgAxfo8LVbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN2T0U+N9m8mrwswwuA/s3SdDQ2IjZQg1lIJW7s2IBg=;
 b=bAMfes7LlA5jRigV+Ff72uSxn0mVkV2hZ7Vs7RhV0WWZkNWFJXRC/PeQinnZ0NI5kibh6K4RtuVCCW0oMruB44LKA08r8W0ZCfQjPf693Lb7vI3XxDFqtgcwjHaskyUkHjkKwL6TYUXs5Q7fUbYXueJCP1znf3YCmTjsJotG7v1MZPGiJNxmdswCo+pmEK3XudJU1FPYjrwRVEjve5aOa/jZO+3BoFuzXM+kEJZqQzyeyG9JfZhDs9LI1aYv/jxW+VLSykruR237pGz/6AOIrcoAXuEYlcW8QOW8FymxfS5r8QaakgTWMnwkX+8vreE/yIqeU59ou8zEi9fSn4g1xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN2T0U+N9m8mrwswwuA/s3SdDQ2IjZQg1lIJW7s2IBg=;
 b=frjkH0kVpksbV/XO1oYvWLd/3Zfpbs3wh0YU7Wu6gzTY5V/O0yYNZhmElJM59+l25hJLk8t+f3YpQZFcnk6ZPXCpchaIo7jneS41dti2uMrxPVpB65r1H//hYWVIXwd8zHSSOhy7qDp3v+/S5UAu8m1iZUl93MhBNnrj01h4kkEVQ8W5VOinNlHK6mqtecDYtgpBVaAtGyOPLdqvamFn14Eqy+e8yLPSx2KMayWpVfd32j2xuGCZZ11+bHJhM0Ec0tjIoiHQqbcpPdA8P+whAwlqjqSCXlglSCBCCgvyUjSKqkgAkvqmoL0ZFBpo7VjCEWYa49XPiZEqOJsdgs8N5g==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by PH8PR11MB6705.namprd11.prod.outlook.com (2603:10b6:510:1c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 08:03:18 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 08:03:18 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v2 1/1] net: dsa: microchip: make sure drive strength
 configuration is not lost by soft reset
Thread-Topic: [PATCH net v2 1/1] net: dsa: microchip: make sure drive strength
 configuration is not lost by soft reset
Thread-Index: AQHabskmJdw9ZE4JnUWWiAJ3CfXms7EoyeQA
Date: Tue, 5 Mar 2024 08:03:18 +0000
Message-ID: <ba872ca08cba230cceeaab3e7a0b7724f639bfed.camel@microchip.com>
References: <20240305064802.2478971-1-o.rempel@pengutronix.de>
In-Reply-To: <20240305064802.2478971-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|PH8PR11MB6705:EE_
x-ms-office365-filtering-correlation-id: c2bf3184-e96a-49d6-f89f-08dc3ceab7db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SfbHRtpYYsGwn3L7pHycbXyJ99RQUTpgHocKo8PEVblw/II84IelBi+VuBYQSvJc7dgooSFnaZJuNwmOoaJ4MW/Au6TIKa2ZplTrdzHNcKxrM5Nd5TUMinRVUsX2LVavaKV6mdn/NVwrrtRKZCdi68XBre8LtDOqtQuc6CPDyUig3RqpmpgmMVTha2iMbEA5cej4EmVeSiuysgDDY/ivlG5Bj/5rGEyr40gth9FkMQoh+mI6Chl9clrQKwVIeWZjEgP1wQs/Kt0UZp5OT5nCdFi1rio4DdyzoO0jYFH2Cvy52Bufkm8Px5jSUI51Qf+iL27Y1TqAl5vHsYXx7Y7CyJmLckBv/gsPhnP3LZ82x66hVw2pU8/z+9ATF5GwQIH/7T788TK5A5TlpQkrVdZIGfqM9VT/JgdqtQIS6vFMaWANWg0vr4ta+tjTyPH6kVpTHW+Kml7hQxP2zrc8xhOMWkL43u+xDgIwSdhpJzqV4OM24KU3TRPm/XA9VWZ0N38N48C5iVOqBOr4Q1qsviV3hgQd+kkYWv9uRttnGaxFoo+pyQpcyug6gbNWDyr39mnwab4qxYlanM2gY8TuKK7knFyHWQ5ofdFEihyisJXzoo1gjzaXo1C4EI/kpRBH8ldsSJ7RZ0eHXJYZHb5tCK3NPHwVHn2QRzlL91z5k8EqJgbg+LaIT7gRWncmGGQsoyh3SWbuTfz9Brbb9W/3vg3AVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVEyODJWazFYQkJkRDBHRFNKOFBkcUVWRnpNSXREazM2SUEyMWNqN204K3VP?=
 =?utf-8?B?aVdFSjFtL1RMYkNkWTZ6V0pQVGVGT05wWTdzWlpaRkxrcjdSSFFVQ1dhMmxz?=
 =?utf-8?B?dTlENmFwb3l0UGdqaVVPYkpJeWYwamYvNVNRRlJtd3lRb0liY2xtMEZGcUFF?=
 =?utf-8?B?K25PTGV0TlBveDJLejZkVGc0aWRYa2dmdDAxOU5tYUpkUTJ1eTRybUFMUHRz?=
 =?utf-8?B?RWhYZ2JqTDhWYjVNb3lnTGZFNGMvbjhMK05aUkVYTk9FbFNZZzR0VmtSbXNM?=
 =?utf-8?B?bEZvTkVReGZTNTZvK3NpT1N2MU1QUkE1amw4K0k1M2dBeW1ZNW1WYXIxTSt6?=
 =?utf-8?B?OVVFQWl4UVNSSC9CQzVFTURMOFlCUGRvV3Uza3ZjQ2N6Q0Z3RFhRU1FZVk0w?=
 =?utf-8?B?Y1U5SU95bVFJNTlURHhDTUV1N0p1TVd6T3FDVkJwSE04aGNBZ1Rtcy9mNGlM?=
 =?utf-8?B?Q2Z0aG1JTC9zRnpTUGtjOEtjYm80Tnhaa2U4bXpyTkJqZ0tDTE5wWFFrL29r?=
 =?utf-8?B?SzhyaU1RdExnbENwWnZJUEZ0TmNjQ2JJYVdZRFhQSFBUTWQvVVIrTjlkbEtF?=
 =?utf-8?B?ZnQ3VGF5TGVjYWpQYkJMaURsaGNLY2JSQlkxb0ZmQ2hHb3J2M0ZtcVAwNVpp?=
 =?utf-8?B?RlIvUlk2SjVkN3V1aCtSY2NndDc5bkEyZkJscjVReTc3QjkwRTlScFY0MjJX?=
 =?utf-8?B?ZGQ1V1lMV21UQVRVRnhuMGlrWUtyQlRwcGdUelRQWHBtOERHQ0hlNXMxdkJ5?=
 =?utf-8?B?dCtreHdkSUM3S3MwQ0RLbjNKdjJ1c2o5TXFSeE8yQXp4T1FJVjhFRG9mWW1v?=
 =?utf-8?B?Yk1WRWFzTkMwcjBVRC9OVlRWbDVYNTJ1cnhhNjFZRnZoZ2pPcmo4b3hUOGpD?=
 =?utf-8?B?aVozMmtIQlR5Ty9FQ3czZzN6cW9BNnliVGNxbW1NN2wvbXZVdHNKNE41Z3Yx?=
 =?utf-8?B?eDUwRzFIYTJlWXJyYUJOUllFbms5NTByRHJnQXcvMDBXeVdGRFhhUjJzN1Nx?=
 =?utf-8?B?WjFPM0thMkU0QTFhQkxCNXFzT1QxQXdFbDI2TTZjUmdUclczWm9aNlZ3VEs4?=
 =?utf-8?B?YjUwR2l1Yk1oTmp4VHVXSkNJZHc3YzRqK1BLNVE0SWFCMTBvUnN0R0ZFL1Zl?=
 =?utf-8?B?a3RzNEdvVGNqc2dOSzhXMmVRajl5OVdqWWxIUGExK0wydzlQVGtqclpKV2Rv?=
 =?utf-8?B?dmo1RU9aeE1ZVWhyL21jSlZZbGZWeDlqN2JCK3hEU1pDR25YNUFxR29sRnJF?=
 =?utf-8?B?YVNNOVdEUS92Tng0endOOVpWbURPU1l1L2xCMnFJclNHM0lQMUFaYXQxTlpv?=
 =?utf-8?B?UzlYMjVsZUtxTjBhenhWRGVIeDJTUi9XdlNQMm85YjJUOVo4T1NjeGY1NUND?=
 =?utf-8?B?R2pKS2I4UG5HeElaOFVuQlZFN2RVMXRFL296aUtaRTF5enVvWlNyU3kzU09U?=
 =?utf-8?B?WW0yaDk2UzhvUERRdGJ3Nys4a2JCdmJVVTZ5Q1UyS0diZlZzdm1TcXJPRFRD?=
 =?utf-8?B?c3NrQzdsVUlLWXJXazhSam1VdS9GN3I4elkwYm1nc2VvK1Z0VmVHOFd0RHJR?=
 =?utf-8?B?VFNJU0kxa2w4OTNNc2FPeHVCMklSMzIweWwzdU1hWUQ5TmRpTEdOS0IyRWdI?=
 =?utf-8?B?T1gwcmtMZUZTWHhqZ1hwa2hOeE10TU5DUzBPbTdwYmZQYnUrb2EySGVsS1Ju?=
 =?utf-8?B?NGxEOE5kbXZVMzVLdVFwOWlhVzVPOVNUY1k3dEN5ZFhLb3RadGY1Q3ZEN1ov?=
 =?utf-8?B?aTBHSTN0d251VFZJbHFEN3pJZEI2Tm5OZVkza2NHWk1yWG9nOG5rVW1FTVFK?=
 =?utf-8?B?T3pScVFHVHNrdFV0a1JBTTZkRnhKK1hLQWYvVXpvaHcwWXpKNWdPdVd6V2JH?=
 =?utf-8?B?VEFNTGs1NldUWDJFY1ZGWHlwSEpPY0NIckZETGJrSTNCdjBlRFdvajNIU3h5?=
 =?utf-8?B?YUVsTXppZDROS1prMnBZSCtIUVlML2UxMnBVU01CbzBvQndoUmp1c3ByaHlk?=
 =?utf-8?B?a2hrY0xWWWx6SGtUVXJMSmVhS0hkR0FYa09ZY1JaNmxKM09zckxBanZKTnBi?=
 =?utf-8?B?S20zVXNnbWl0WXlZYXZxTENuRnlEMUF3c0dLdU85ZE5oaVNMN05GNnJmVzd2?=
 =?utf-8?B?dEtuaUF1ZDJDaUVkaVNTNDlOWjNNRXNuU2laWFFtbFJDZkZ5RXVNdm5KSXdI?=
 =?utf-8?B?dXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCDDECCF32085E41A32B7FF507666747@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bf3184-e96a-49d6-f89f-08dc3ceab7db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 08:03:18.4014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MkFp7Dx9lZJZ7x5e0oE3d4JHSMxhIj4rY7xAifRZ3+Fu9TBlS4KSFYD24hoLz9BZO/6dsnkGOfBtKypmiXIDlsaVv/m1Pq0PSEf15RRgImU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6705

SGkgT2xla3NpaiwNCg0KT24gVHVlLCAyMDI0LTAzLTA1IGF0IDA3OjQ4ICswMTAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBUaGlzIGRyaXZlciBoYXMgdHdvIHNlcGFyYXRlIHJlc2V0IHNlcXVlbmNlIGluIGRpZmZl
cmVudCBwbGFjZXM6DQo+IC0gZ3Bpby9IVyByZXNldCBvbiBzdGFydCBvZiBrc3pfc3dpdGNoX3Jl
Z2lzdGVyKCkNCj4gLSBTVyByZXNldCBvbiBzdGFydCBvZiBrc3pfc2V0dXAoKQ0KPiANCj4gVGhl
IHNlY29uZCBvbmUgd2lsbCBvdmVyd3JpdGUgZHJpdmUgc3RyZW5ndGggY29uZmlndXJhdGlvbiBt
YWRlIGluDQo+IHRoZQ0KPiBrc3pfc3dpdGNoX3JlZ2lzdGVyKCkuDQo+IA0KPiBUbyBmaXggaXQs
IG1vdmUga3N6X3BhcnNlX2RyaXZlX3N0cmVuZ3RoKCkgZnJvbSBrc3pfc3dpdGNoX3JlZ2lzdGVy
KCkNCj4gdG8NCj4ga3N6X3NldHVwKCkuDQo+IA0KPiBGaXhlczogZDY3ZDcyNDdmNjQxICgibmV0
OiBkc2E6IG1pY3JvY2hpcDogQWRkIGRyaXZlIHN0cmVuZ3RoDQo+IGNvbmZpZ3VyYXRpb24iKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+
DQo+IA0KDQpBY2tlZC1ieTogQXJ1biBSYW1hZG9zcyA8YXJ1bi5yYW1hZG9zc0BtaWNyb2NoaXAu
Y29tPg0K

