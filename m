Return-Path: <linux-kernel+bounces-81379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623CD867518
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867271C252B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83217F49D;
	Mon, 26 Feb 2024 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b="PzkkvZun"
Received: from mx0a-00007101.pphosted.com (mx0a-00007101.pphosted.com [148.163.135.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F2EC7;
	Mon, 26 Feb 2024 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950879; cv=fail; b=pvA5MsRFWIYXs/0CeRBwit6GlXCYjq56Ri2nmK395GyYgSpMRR1xAqik+GxXd7rpuaM0yLZ9Fr+xGxfMpkpKuSYZ36AOOHMx9tS6bE6nQUygoGHF2/nI/FI4gIJunAaZIPxnIY0KVRQV3iufD2mu45zIQnb+PrNJq/RPLn6hc5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950879; c=relaxed/simple;
	bh=Z8iw/51lyZltLfFy9vetlHn6YtiWXC6hAhvIoLRpAOQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Us3pudL5XECsrwDalLlHNfNrHdj2P5rqCssTY+B9p8zayTxazTjyEGbGtMp1SV/WkwR38SheCvuUC7Etkj3+3+NcucWJL9UoYPFKWdDogcMwXRCfjvWE8va5yf7bYUzQe5LQ6gPnbiAFsoqL+fQVzhXll/rm3pQrdW3OOdnshXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois.edu header.i=@illinois.edu header.b=PzkkvZun; arc=fail smtp.client-ip=148.163.135.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: from pps.filterd (m0166255.ppops.net [127.0.0.1])
	by mx0a-00007101.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41Q9XMKh013546;
	Mon, 26 Feb 2024 12:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=campusrelays;
 bh=Z8iw/51lyZltLfFy9vetlHn6YtiWXC6hAhvIoLRpAOQ=;
 b=PzkkvZuns2tUexGm6WAip5jsmeU0eQbL9qsyYyu6Xwc6YjrsJa/YEMckT19NLhvLZgLn
 6UO75bLmAeru0pTlzsmcV1WC8HpIIYUwD8yf18bpzsRz24Ra4wv6COx8PuOJLG/4fB1X
 H6TBJjcOJhJjhvsj9CVZecp+IFQpbRLiqdNS1b5B6uILwQZQVf4GOmFd1FmbPqJQx1cK
 4tBefuzroLYEvDd93D2tCLqz1Kz3vWCqNMu/NVYGBeFxdVEIAfvWk19ey4qecheYEui8
 KzZdmizcjFSFZFGfPjH4f8UxdqI0yOa/wbJzh9LzGFge2YfHa9dJYItV/P1sK/t2+Cmn 3w== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-00007101.pphosted.com (PPS) with ESMTPS id 3wf6y0v0ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 12:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKuuYerxD0te03LzAzwdAXa784Sv1kEdFkVzFgZNZc8w7ACrkL1GdPKjwzOnfUlprHdz3lI02inzrovdYPB0E0ciRuHTc68KGNxfOdW0EU+vk9QzQ51NRupBDS8MkCNcA586MRUAaJYIoawU0qr0T8oXXKIcYylNqXuO+0zdT8+Ho7huiN4eqojLYfo7ONL6BrLKyxbntwX0MN4ZQmUkFpvF8OAoOcTBAv8Kvtd6fQvTJ6CX4ZUYjq4aCsLYXmI6hHN6X1oa2RpxoAIMbe4AhmFk7W5UdETFyV3y7DK+LkQgpgU1umkPdyCMrEQNIlJLR5UpZqh6v5uRoFK4akJ8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z8iw/51lyZltLfFy9vetlHn6YtiWXC6hAhvIoLRpAOQ=;
 b=CzkTCVPRswWcZqLhdcI7yXZUTvXVe+uPIPsv8uOiiWzo3HqcAxjJPatcC9qWE215/OmAzsFiNmblHK0V+jVKHJnI2EA1p2Co+Sq2FgpNha+Zoa+8jSajMGRn8BfwXPtN1IDM8BblU2jI6tqLoqdpNNtD7UmXRqLJyFIrMJGYX4AoN674wVBdmQ1QUgR2kxVnmYd7rBxCdbwXe6xKs0p38pp7HzNLoHfBJAEDTY6T2a70iFpHIhMit4WIMFS1K7YfF/7QiiER465Su32F6YHZQgzZO7j1tWOkeroSxVCeXug4gzazZD3BSUVD6c2Eu1DQK7hCFvU0imHbVApWQF58wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=illinois.edu; dmarc=pass action=none header.from=illinois.edu;
 dkim=pass header.d=illinois.edu; arc=none
Received: from PH7PR11MB5768.namprd11.prod.outlook.com (2603:10b6:510:131::21)
 by CH0PR11MB5250.namprd11.prod.outlook.com (2603:10b6:610:e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Mon, 26 Feb
 2024 12:27:18 +0000
Received: from PH7PR11MB5768.namprd11.prod.outlook.com
 ([fe80::3fae:5e3f:9709:dc2c]) by PH7PR11MB5768.namprd11.prod.outlook.com
 ([fe80::3fae:5e3f:9709:dc2c%7]) with mapi id 15.20.7339.023; Mon, 26 Feb 2024
 12:27:16 +0000
From: "Yang, Chenyuan" <cy54@illinois.edu>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "jani.nikula@intel.com" <jani.nikula@intel.com>,
        "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Zhao, Zijie"
	<zijie4@illinois.edu>,
        "Zhang, Lingming" <lingming@illinois.edu>
Subject: Re: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in
 cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
Thread-Topic: [Linux Kernel Bugs] KASAN: slab-use-after-free Read in
 cec_queue_msg_fh and 4 other crashes in the cec device (`cec_ioctl`)
Thread-Index: 
 AQHaOS3lbHvq7Jnry0+S2folBlrDv7Dg7XiAgA77AQCAArhcAIAUcEOAgAE90QCAEAxSgIACE8sUgAIYTQA=
Date: Mon, 26 Feb 2024 12:27:16 +0000
Message-ID: <7E36CBBD-F2AD-4D98-8D4E-F52E62C3E812@illinois.edu>
References: 
 <PH7PR11MB57688E64ADE4FE82E658D86DA09EA@PH7PR11MB5768.namprd11.prod.outlook.com>
 <f985d664-d907-48ed-9b3d-dc956c178b88@xs4all.nl>
 <526380BE-57AC-493D-A7B0-B8F0ECC0FE0A@illinois.edu>
 <f1855145-9562-4bef-800f-43bcacff6fc8@xs4all.nl>
 <2e5f1e92-7fad-4a74-b375-1e194ff08ce6@xs4all.nl>
 <F8D4A291-8CFB-4A25-B296-3CA07B56F459@illinois.edu>
 <49a68c10-9549-4fd8-b929-d4c7a9c8debf@xs4all.nl>
 <PH7PR11MB5768B0BC3C042A6EA4EC1EF0A0542@PH7PR11MB5768.namprd11.prod.outlook.com>
In-Reply-To: 
 <PH7PR11MB5768B0BC3C042A6EA4EC1EF0A0542@PH7PR11MB5768.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5768:EE_|CH0PR11MB5250:EE_
x-ms-office365-filtering-correlation-id: bb8b8ae5-b163-4afe-68fb-08dc36c644c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 78qZ77Pqf4lKSmBqhwygKK25cmsqiEea5a4krrokDtboOsTkbdPuYclXAB/p41PohtO5mRkFSBFH08c59Ab1vVne9OYEko2MxWdt4fp2g5QSd2g1PtMm6hH6l+O4cEpSQHdulNqRr1usoKS/ajHmvMldF21WGy9FE5Zlr1CLYDsFSWmuu6X9K6Bq6N8qvl/nDrnEuU2/YLom+k5blvD1ziUGw1VmtkP7gwybUtP8ixNZsfOB+2QHhpYdvra2wf2v/iXnLZMkjGVG7GG7ZbLvrfwm7vfmW2+/WTEH6IMgEu85yrgRctuKgq5Ypejw79kTUQxrx0Rw6CEZSUo6VfjtPNe3iqiW3nWm6k0X+8R+qPAq+36FqE+W33/bwjWPMg3usL+L8a/Mky2v9pPh+uxJSd3vRJTNtyDDAFFTa7dSYlN1+2FEOYDFq+hl1mfxcoADt1ircLxIkC1XJkCGlUoxWKW6+pD2LtweF/Qx6nlPVNg43ptxDt34ZYRvSRUHXSJzkd16fFyBDdQB0EzqCv00wfgMXu+pDPsxM/m8oP0d/W2RSg9a6PVUavSjKzkVIPGCa+y31f9HSjZaxfJtyPi6mbUDzgaxkKoRIRbpawMDwnY2rKF3T59YKqLHQoyILCwqQNUyov99wvt/lw+nxNVyLmdX/4jWgFweK1mmAtK9bpbaxztSWSC09GJotWhcbzTWKAe3FO/0SWfelFvNl8R0Kvmj2r496hHV7jP/ZR2Y2JE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?cm5Pa2dCTlRGKy9YSlI2Mi9qT0xNeit5VlNMT0VtWEdhUjJzalZnM2w4Vmor?=
 =?utf-8?B?a2pHNS9JU2xRNlJBMjZrRlk2MWQ2eERuVDJMM0VTelRVOG1kekVhd3RHN1Zk?=
 =?utf-8?B?eXc5WnlDTHJGQkdUUGxpMGZsekxSWlB4UXlkdDRlamlmZ3JyUTZrQ09pV1pl?=
 =?utf-8?B?V2JGQ3E2ME91bDdiaW00amEvMjBIbTcrY3czWm1EK1Z5VkNxWGJkazhnOWxQ?=
 =?utf-8?B?Q3FVVnV0eWhNN1NFUis0QktSQ2psYmFwTGRaTVZLVDNrN2FrbllaVlhxZWZD?=
 =?utf-8?B?VUduTDczMDNIUWFoY09FUHlVSmUvaVJ5UXdpUzhwc043OGxlWGR1b1kwZFR0?=
 =?utf-8?B?cVVUbDZXNG9rZERIUFlGZTJ4QVVraFFEM3BHd0lHZUJRS00rVURQd093Yktn?=
 =?utf-8?B?YmVwVG5EMDBDSTlKeDVMbHJNZHZML1F0bHFpaUhFSVl5TGYxdzM0b1ZnbzJN?=
 =?utf-8?B?TndwcGxKYkJNL1dXQ25SRDRETkh1Zm54MGJMeGdKbzVCU3J6UnNlYXlTWlJV?=
 =?utf-8?B?dmJHSUVDcS9RWE5VZm5tT1hvd1cyM1g1R2N6QUNuazZkOU55UmNldjR3ZU9Y?=
 =?utf-8?B?NTZydXZ0WTUvcFJuVTFSdjlBeWNqTDJjMGQ3MUlSRE9QUE9vQ3NXUjEvalgy?=
 =?utf-8?B?bVE0SEo5YmN1MUc0bzltM2NwSlJqaWFuaThoVFZBUnR2LzRJMHlud1o4T1Nh?=
 =?utf-8?B?U3NWdXZ0OG5LSDJlazFvb0M1WThwTXYrakZ1YzRLQjJkNUFnc1Q2Z3krUWRi?=
 =?utf-8?B?T1hEdzl1azJ6RVhwWjdJY3BPYk1LN0gyZVZvZVhYVlFlMzF2bEdDVllDZGlr?=
 =?utf-8?B?TWVmQ2llSGJscXB6bWhHK2lDNStYczlOY1R5bUZWNzFjaGoyUCtmUTNaVS9F?=
 =?utf-8?B?amRUY2hJUUlQb0k3RjErdXBucUZNWE03bEF6S0JDSEQ4dnJFc3pZZldFZmQz?=
 =?utf-8?B?UzJmaE5FcDRYSkhORlJVSGRRMDN3ZXgzVVloaWdLQTRqLzJ3dFY2MjcvRUdq?=
 =?utf-8?B?T2laSXo4dERVcS84UUQ4MFNtK1RzZ2tzdGxDWGZSRE5rZFZYMEZxMHdWaE0v?=
 =?utf-8?B?b3ZsZ3ZLemg3UXZnZ3RsN2FDSDU2Y3FFK3pTcy8yaTVEckxqdWVFamE3SUxs?=
 =?utf-8?B?VDRkV3JKc1lPMnRZMGQrZkdFTUFIZHVFYlpMQ1pMTStGWGh4ZGNZUzA4dG4r?=
 =?utf-8?B?bjNLQWlUWWM0OGo0SC9NU256Yjl0V0RHbTRuZkNETitvWDMwRHh6ZDdZYlNO?=
 =?utf-8?B?UTMzZklkY3dBOTZaQlJhLzJudDQwSlhIWnlIckNGY3dIN3FPRk5OcUQyblJw?=
 =?utf-8?B?c2VLNVA2dFUyYVZMQklWUkdheEZBUlZnVmdHN3FYeTlDWllBUi9yb0MvbDNS?=
 =?utf-8?B?Y1FMWHArZ2NBbHBwd0pFVGMwdHlGNDJxZDFrTmRHK0JHYXZFWVVsOU4vTnpi?=
 =?utf-8?B?NjA1MFl1UmM4MnZxUFQvUE55ZFRsUU1OM00vekVzckZ4QlZXb2tTVVEyREJo?=
 =?utf-8?B?WVh4OVJ5U0ZLdVhMQS9QRzNHeEk1dUhpYXBmVjQ0L08rV3FKU0Z0Q0hDQ3dF?=
 =?utf-8?B?WVgwQ29Hbk9TR1Fxa1BxRnRkaEI1Mis5dmRNbEpreDVVR0ZHOCtSSTdBQTNr?=
 =?utf-8?B?R2RFL042SnQvbnkzQ29wRVdwMThLNHNQZHNrQlVVNXova2dQMWxWQUtZRUhv?=
 =?utf-8?B?WXRWalMzMFQ1V2xLRGV1ZlN4TUNlTjZVcjFhYmJXYUxHRW9vUnMyaWxlZnZO?=
 =?utf-8?B?bWJpOWFaUW12SUFlU3AyVWJiRVZkTzRxclJlZTlhZnhoVmdObDBIQTZGbUI2?=
 =?utf-8?B?ZjdYVFhDaEtjcHJ3SzZ1ZjdYNGNCS0l0Y3gvUnpMYlF5Z2UvVk5rUnpWVHc4?=
 =?utf-8?B?cHdYZ2QwaS8xOW1QcGxiWFF2UVVYMXRqWFVjOW9zVnVqMXZnTVdnblQzb3Ji?=
 =?utf-8?B?b3dxdW1qejIxWTgxQmlJK2pVOW1BUDkxTVl0N2YrOWFmRHN4VitmMU9wRUZk?=
 =?utf-8?B?TnZpdDNkUU95M2JMNFMvaTEyM1R1d2Y5b3BNdHhVSjBDQ1BPWjZYcUR3djdW?=
 =?utf-8?B?VnZlVnZ1ZDg0c29IeVV0ZGlWaXd5QzlsVG85QmN3Z3ZaamxvUnZCWVhGM0Vx?=
 =?utf-8?Q?JboQVWcp9OuHPf3ZpsNQop2g8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45B1B701B29E404899F1A9AF6C1904BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8b8ae5-b163-4afe-68fb-08dc36c644c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 12:27:16.4307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QktIxF8plhtgBRch0601vieeqiGQ4oRkRloZhvTWlu+JJBCTpOA0YQ5rDG5kKbLeY+nDPSxtSdOgSDWBZkrqoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5250
X-Proofpoint-GUID: kzDKo-mvdxYo9VBZ7GPVdTn3QPSux6_X
X-Proofpoint-ORIG-GUID: kzDKo-mvdxYo9VBZ7GPVdTn3QPSux6_X
X-Spam-Details: rule=cautious_plus_nq_notspam policy=cautious_plus_nq score=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1011 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260094
X-Spam-Score: 0
X-Spam-OrigSender: cy54@illinois.edu
X-Spam-Bar: 

SGkgSGFucywNCg0KVGhhbmsgeW91IGZvciB5b3VyIGNvbnRpbnVlZCBlZmZvcnRzIGluIGludmVz
dGlnYXRpbmcgdGhpcyBidWcgYW5kIGltcGxlbWVudGluZyB0aGUgbmV3IHBhdGNoIQ0KDQpSZWdh
cmRpbmcgdGhlIHR3byB3YXJuaW5ncywgdGhleSBoYXZlIGJlZW4gYWRkcmVzc2VkIGJ5IHRoaXMg
bmV3IHBhdGNoIGFuZCBhcmUgbm8gbG9uZ2VyIHJlcHJvZHVjaWJsZS4gQWRkaXRpb25hbGx5LCBJ
IGNvbmR1Y3RlZCBhIDQ4LWhvdXIgZnV6emluZyB0ZXN0IG9uIHRoZSBDRUMgZHJpdmVyLCB3aGlj
aCBoYXMgc3VjY2Vzc2Z1bGx5IGVsaW1pbmF0ZWQgdGhlIHByZXZpb3VzIGhhbmdpbmcgaXNzdWUu
DQoNCk9uZSB0aGluZyB0byBub3RlIHRoYXQgdGhlIHN5c3RlbSB3aWxsIG5vdyBsb2cgdGltZW91
dCBldmVudHM6DQpgYGANClsgMjI4MS4yNjUzODVdWyBUMjAzNF0gY2VjLXZpdmlkLTAwMS12aWQt
b3V0MDogdHJhbnNtaXQgdGltZWQgb3V0DQpbIDIyODIuOTk0NTEwXVsgVDIwMTddIGNlYy12aXZp
ZC0wMDAtdmlkLWNhcDA6IHRyYW5zbWl0IHRpbWVkIG91dA0KWyAyMjgzLjA2MzQ4NF1bIFQyMDUw
XSBjZWMtdml2aWQtMDAyLXZpZC1vdXQwOiB0cmFuc21pdCB0aW1lZCBvdXQNClsgMjI4My4wNzM0
NjhdWyBUMjA2NV0gY2VjLXZpdmlkLTAwMy12aWQtY2FwMDogdHJhbnNtaXQgdGltZWQgb3V0DQpb
IDIyODMuMzczNTE4XVsgVDIwMzNdIGNlYy12aXZpZC0wMDEtdmlkLWNhcDA6IHRyYW5zbWl0IHRp
bWVkIG91dA0KWyAyMjg1LjExMzU0NF1bIFQyMDE4XSBjZWMtdml2aWQtMDAwLXZpZC1vdXQwOiB0
cmFuc21pdCB0aW1lZCBvdXQNClsgMjI4NS4xOTM1MDJdWyBUMjA1MF0gY2VjLXZpdmlkLTAwMi12
aWQtb3V0MDogdHJhbnNtaXQgdGltZWQgb3V0DQpbIDIyODUuMTkzNTcwXVsgVDIwNjVdIGNlYy12
aXZpZC0wMDMtdmlkLWNhcDA6IHRyYW5zbWl0IHRpbWVkIG91dA0KWyAyMjg1LjUxMzU3MF1bIFQy
MDMzXSBjZWMtdml2aWQtMDAxLXZpZC1jYXAwOiB0cmFuc21pdCB0aW1lZCBvdXQNCmBgYA0KDQpC
ZXN0LA0KQ2hlbnl1YW4NCg0KRnJvbTogSGFucyBWZXJrdWlsIDxodmVya3VpbC1jaXNjb0B4czRh
bGwubmw+DQpEYXRlOiBGcmlkYXksIEZlYnJ1YXJ5IDIzLCAyMDI0IGF0IDg6NDTigK9BTQ0KVG86
IFlhbmcsIENoZW55dWFuIDxjeTU0QGlsbGlub2lzLmVkdT4sIGxpbnV4LW1lZGlhQHZnZXIua2Vy
bmVsLm9yZyA8bGludXgtbWVkaWFAdmdlci5rZXJuZWwub3JnPiwgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCkNjOiBqYW5pLm5pa3Vs
YUBpbnRlbC5jb20gPGphbmkubmlrdWxhQGludGVsLmNvbT4sIHN5emthbGxlckBnb29nbGVncm91
cHMuY29tIDxzeXprYWxsZXJAZ29vZ2xlZ3JvdXBzLmNvbT4sIG1jaGVoYWJAa2VybmVsLm9yZyA8
bWNoZWhhYkBrZXJuZWwub3JnPiwgWmhhbywgWmlqaWUgPHppamllNEBpbGxpbm9pcy5lZHU+LCBa
aGFuZywgTGluZ21pbmcgPGxpbmdtaW5nQGlsbGlub2lzLmVkdT4NClN1YmplY3Q6IFJlOiBbTGlu
dXggS2VybmVsIEJ1Z3NdIEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIFJlYWQgaW4gY2VjX3F1
ZXVlX21zZ19maCBhbmQgNCBvdGhlciBjcmFzaGVzIGluIHRoZSBjZWMgZGV2aWNlIChgY2VjX2lv
Y3RsYCkNCkhpIENoZW55dWFuLA0KDQpIZXJlIGlzIGFub3RoZXIgcGF0Y2ggZm9yIHlvdSB0byB0
cnkuIEkgdGhpbmsgaXQgaXMgZ29vZCBmb3IgYmxvY2tpbmcgQ0VDX0FEQVBfU19MT0dfQUREUlMN
CmlvY3RsIGNhbGxzLCBidXQgaWYgdGhlIGZpbGVoYW5kbGUgaXMgaW4gbm9uLWJsb2NraW5nIG1v
ZGUsIEknbSBzdGlsbCBub3QgY2VydGFpbiBpdA0KaXMgY29ycmVjdC4gQnV0IG9uZSBpc3N1ZSBh
dCBhIHRpbWUgOi0pDQoNClJlZ2FyZHMsDQoNCsKgwqDCoMKgwqDCoMKgIEhhbnMNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWVkaWEvY2VjL2NvcmUvY2VjLWFkYXAuYyBiL2RyaXZlcnMvbWVkaWEv
Y2VjL2NvcmUvY2VjLWFkYXAuYw0KaW5kZXggNTU5YTE3MmViYzZjLi5hNDkzY2JjZTI0NTYgMTAw
NjQ0DQotLS0gYS9kcml2ZXJzL21lZGlhL2NlYy9jb3JlL2NlYy1hZGFwLmMNCisrKyBiL2RyaXZl
cnMvbWVkaWEvY2VjL2NvcmUvY2VjLWFkYXAuYw0KQEAgLTkzNiw4ICs5MzYsNyBAQCBpbnQgY2Vj
X3RyYW5zbWl0X21zZ19maChzdHJ1Y3QgY2VjX2FkYXB0ZXIgKmFkYXAsIHN0cnVjdCBjZWNfbXNn
ICptc2csDQrCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCsKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfdW5s
b2NrKCZhZGFwLT5sb2NrKTsNCsKgwqDCoMKgwqDCoMKgwqAgd2FpdF9mb3JfY29tcGxldGlvbl9r
aWxsYWJsZSgmZGF0YS0+Yyk7DQotwqDCoMKgwqDCoMKgIGlmICghZGF0YS0+Y29tcGxldGVkKQ0K
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZk
YXRhLT53b3JrKTsNCivCoMKgwqDCoMKgwqAgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZkYXRh
LT53b3JrKTsNCsKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygmYWRhcC0+bG9jayk7DQoNCsKg
wqDCoMKgwqDCoMKgwqAgLyogQ2FuY2VsIHRoZSB0cmFuc21pdCBpZiBpdCB3YXMgaW50ZXJydXB0
ZWQgKi8NCkBAIC0xNTc1LDkgKzE1NzQsMTIgQEAgc3RhdGljIGludCBjZWNfY29uZmlnX3RocmVh
ZF9mdW5jKHZvaWQgKmFyZykNCsKgICovDQrCoHN0YXRpYyB2b2lkIGNlY19jbGFpbV9sb2dfYWRk
cnMoc3RydWN0IGNlY19hZGFwdGVyICphZGFwLCBib29sIGJsb2NrKQ0KwqB7DQotwqDCoMKgwqDC
oMKgIGlmIChXQVJOX09OKGFkYXAtPmlzX2NvbmZpZ3VyaW5nIHx8IGFkYXAtPmlzX2NvbmZpZ3Vy
ZWQpKQ0KK8KgwqDCoMKgwqDCoCBpZiAoV0FSTl9PTihhZGFwLT5pc19jbGFpbWluZ19sb2dfYWRk
cnMgfHwNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYWRhcC0+aXNfY29u
ZmlndXJpbmcgfHwgYWRhcC0+aXNfY29uZmlndXJlZCkpDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm47DQoNCivCoMKgwqDCoMKgwqAgYWRhcC0+aXNfY2xhaW1pbmdfbG9n
X2FkZHJzID0gdHJ1ZTsNCisNCsKgwqDCoMKgwqDCoMKgwqAgaW5pdF9jb21wbGV0aW9uKCZhZGFw
LT5jb25maWdfY29tcGxldGlvbik7DQoNCsKgwqDCoMKgwqDCoMKgwqAgLyogUmVhZHkgdG8ga2lj
ayBvZmYgdGhlIHRocmVhZCAqLw0KQEAgLTE1OTIsNiArMTU5NCw3IEBAIHN0YXRpYyB2b2lkIGNl
Y19jbGFpbV9sb2dfYWRkcnMoc3RydWN0IGNlY19hZGFwdGVyICphZGFwLCBib29sIGJsb2NrKQ0K
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgd2FpdF9mb3JfY29tcGxldGlvbigmYWRh
cC0+Y29uZmlnX2NvbXBsZXRpb24pOw0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bXV0ZXhfbG9jaygmYWRhcC0+bG9jayk7DQrCoMKgwqDCoMKgwqDCoMKgIH0NCivCoMKgwqDCoMKg
wqAgYWRhcC0+aXNfY2xhaW1pbmdfbG9nX2FkZHJzID0gZmFsc2U7DQrCoH0NCg0KwqAvKg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvY2VjL2NvcmUvY2VjLWFwaS5jIGIvZHJpdmVycy9tZWRp
YS9jZWMvY29yZS9jZWMtYXBpLmMNCmluZGV4IDY3ZGM3OWVmMTcwNS4uM2VmOTE1MzQ0MzA0IDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9tZWRpYS9jZWMvY29yZS9jZWMtYXBpLmMNCisrKyBiL2RyaXZl
cnMvbWVkaWEvY2VjL2NvcmUvY2VjLWFwaS5jDQpAQCAtMTc4LDcgKzE3OCw3IEBAIHN0YXRpYyBs
b25nIGNlY19hZGFwX3NfbG9nX2FkZHJzKHN0cnVjdCBjZWNfYWRhcHRlciAqYWRhcCwgc3RydWN0
IGNlY19maCAqZmgsDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgQ0VDX0xPR19BRERSU19GTF9BTExPV19SQ19QQVNTVEhSVSB8DQrCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ0VDX0xPR19B
RERSU19GTF9DRENfT05MWTsNCsKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygmYWRhcC0+bG9j
ayk7DQotwqDCoMKgwqDCoMKgIGlmICghYWRhcC0+aXNfY29uZmlndXJpbmcgJiYNCivCoMKgwqDC
oMKgwqAgaWYgKCFhZGFwLT5pc19jbGFpbWluZ19sb2dfYWRkcnMgJiYgIWFkYXAtPmlzX2NvbmZp
Z3VyaW5nICYmDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKCFsb2dfYWRkcnMubnVtX2xvZ19h
ZGRycyB8fCAhYWRhcC0+aXNfY29uZmlndXJlZCkgJiYNCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAhY2VjX2lzX2J1c3koYWRhcCwgZmgpKSB7DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBlcnIgPSBfX2NlY19zX2xvZ19hZGRycyhhZGFwLCAmbG9nX2FkZHJzLCBibG9jayk7DQpA
QCAtNjY0LDYgKzY2NCw4IEBAIHN0YXRpYyBpbnQgY2VjX3JlbGVhc2Uoc3RydWN0IGlub2RlICpp
bm9kZSwgc3RydWN0IGZpbGUgKmZpbHApDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBsaXN0X2RlbF9pbml0KCZkYXRhLT54ZmVyX2xpc3QpOw0KwqDCoMKgwqDCoMKgwqDCoCB9DQrC
oMKgwqDCoMKgwqDCoMKgIG11dGV4X3VubG9jaygmYWRhcC0+bG9jayk7DQorDQorwqDCoMKgwqDC
oMKgIG11dGV4X2xvY2soJmZoLT5sb2NrKTsNCsKgwqDCoMKgwqDCoMKgwqAgd2hpbGUgKCFsaXN0
X2VtcHR5KCZmaC0+bXNncykpIHsNCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCBjZWNfbXNnX2VudHJ5ICplbnRyeSA9DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbGlzdF9maXJzdF9lbnRyeSgmZmgtPm1zZ3MsIHN0cnVjdCBj
ZWNfbXNnX2VudHJ5LCBsaXN0KTsNCkBAIC02ODEsNiArNjgzLDcgQEAgc3RhdGljIGludCBjZWNf
cmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlscCkNCsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBrZnJlZShlbnRyeSk7DQrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQrCoMKgwqDCoMKgwqDCoMKgIH0NCivC
oMKgwqDCoMKgwqAgbXV0ZXhfdW5sb2NrKCZmaC0+bG9jayk7DQrCoMKgwqDCoMKgwqDCoMKgIGtm
cmVlKGZoKTsNCg0KwqDCoMKgwqDCoMKgwqDCoCBjZWNfcHV0X2RldmljZShkZXZub2RlKTsNCmRp
ZmYgLS1naXQgYS9pbmNsdWRlL21lZGlhL2NlYy5oIGIvaW5jbHVkZS9tZWRpYS9jZWMuaA0KaW5k
ZXggMTBjOWNmNjA1OGI3Li5jYzNmY2QwNDk2YzMgMTAwNjQ0DQotLS0gYS9pbmNsdWRlL21lZGlh
L2NlYy5oDQorKysgYi9pbmNsdWRlL21lZGlhL2NlYy5oDQpAQCAtMjU4LDYgKzI1OCw3IEBAIHN0
cnVjdCBjZWNfYWRhcHRlciB7DQrCoMKgwqDCoMKgwqDCoMKgIHUxNiBwaHlzX2FkZHI7DQrCoMKg
wqDCoMKgwqDCoMKgIGJvb2wgbmVlZHNfaHBkOw0KwqDCoMKgwqDCoMKgwqDCoCBib29sIGlzX2Vu
YWJsZWQ7DQorwqDCoMKgwqDCoMKgIGJvb2wgaXNfY2xhaW1pbmdfbG9nX2FkZHJzOw0KwqDCoMKg
wqDCoMKgwqDCoCBib29sIGlzX2NvbmZpZ3VyaW5nOw0KwqDCoMKgwqDCoMKgwqDCoCBib29sIG11
c3RfcmVjb25maWd1cmU7DQrCoMKgwqDCoMKgwqDCoMKgIGJvb2wgaXNfY29uZmlndXJlZDsNCg0K

