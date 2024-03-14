Return-Path: <linux-kernel+bounces-103113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 823FF87BB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B23284511
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C305A6E611;
	Thu, 14 Mar 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="Ax+GFc91"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA766BB37
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411766; cv=fail; b=fF1Gml/LdSNypfOXe7mEHrIA853nC5z0VPgI4xfOpc1l0QvzTgaWDdCPZAvG9yl3XT4hp+2bKYt3MobvqqPcAp77k8KuDy+7L7x42WlzVz3XeTUWwRVvlgQzNdAXgPJoLwWjTIW4IyDuIuITxTzB9rJqu0P5GqFgZqHiqnmcx+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411766; c=relaxed/simple;
	bh=BKrHlQnFKZM79ft3kNt9cF+qMRHxK8rwCEatqCS6Ty8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GhisxfgSWrywnQPm11SlNx5ON4M1guteHM62Z3djZnxZCyY+tH7+EilMhLF0A0visG/UY4XR/kTKzw5YUK2sn0/6KGl1cR2835MCO5oFwWytNSiRSfPluefwtLcvRvZhe2AOrMMA4HmtTUiI2TN2IssVoH7G0sF+oFZb5uzsj+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=Ax+GFc91; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42E6P3Ps002095;
	Thu, 14 Mar 2024 10:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=BKrHlQnFKZM79ft3kNt9cF+qMRHxK8rwCEatqCS6Ty8=;
 b=Ax+GFc91WI71jE26igUC5/8/WgFh2GzreNEgO5dx/I4R0NUyr7h6Hr8LwKijWchGzeSJ
 PyCDEL14PAYiReHk/ZBocq1onP4VY+f2+xOIBMqWAjUyd8csMpamlpIcsrAwI675rUFc
 I0xKqaI63QRTk2FWuZgpE+FiQpvZa+nOTEiKBflV5OS2WDMBqjheRLJ6W3ukTTU6Uj4B
 OaqlV/n8K7XEN252Ni+/WQa1WYCMHuF/qMeG5Tp7wavxB+AQ5Mejn7FGMrm8W9GxR9Kk
 /kl6eWf7pHkMClNvwCFNIbQ1izMdnozVQMX5gyhu42R5yS+Farzz4rm27fgfrWZwNQaw jQ== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2040.outbound.protection.outlook.com [104.47.26.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3wssmtc6gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 10:21:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/Bx28wIhuXmSAcnDyZDcOUCFgZUelQD2tgRn+fc2xvka6bMN/ZqBMSSsGhiSpRoXKOyIpV7IKjX1P+tvBtPF9KWqRKEXPeGk+/c7g/MhBnfGpbNvXHsdsOcxwlFdGXl1Pkz8NgYTjM0Ak0qglPc11qlqm5ZsKmTahJ9Oc9iAwjxnZeJSsZEzIKC4I34kCxIVUGeWUm5DQL4KOPp0zV0AoNusM2yHAs7YWYsMxY3IYsD2hCcmonObnedoCQ+BpHUtVWQ1HXU7DS9uNQ6exqFv+o+O6Wh+VVEjNGOIkKU+02l5pvsAE4GUrYgD+gDBFbMwbBjDMkB0rvZuCV9HrHyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKrHlQnFKZM79ft3kNt9cF+qMRHxK8rwCEatqCS6Ty8=;
 b=GZ7KW8h2LiD+4ASpxd+XBAU6hpD7kh4DS9cHtTzQ553rJ16uX3NQGMUork88/bcCKggQiZlrCl5dxgUMriHS9IzyOLQDZYrSPsfEAPuEngK60FULfPd8XLxElXqnvIaOsNasUYc3M4ZWbW7AaxW8UzWzzw4YA2yrYPhJIbCq9CT7yxk8W8QHe+aPacsMEmFRu0fqj2Y+2iPRhlWY4rkABTPlYN5bWGgN6SdIhfyOPo+H7wRjODjlqBnmpEMOsg4IcCWwk73kEI5/QqWHJOX/jH+x3htXOIks8dpP0+zKLBQpYMMI8v5TPFszdpMsyPgFHeTCr6IPuvAblBFM0aOBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by JH0PR04MB7202.apcprd04.prod.outlook.com (2603:1096:990:35::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 10:21:35 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::7414:91e1:bb61:1c8d%7]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 10:21:35 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "tglx@linutronix.de" <tglx@linutronix.de>
CC: "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "andy@infradead.org" <andy@infradead.org>,
        "arjan@linux.intel.com"
	<arjan@linux.intel.com>,
        "dimitri.sivanich@hpe.com"
	<dimitri.sivanich@hpe.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "kan.liang@linux.intel.com"
	<kan.liang@linux.intel.com>,
        "kprateek.nayak@amd.com"
	<kprateek.nayak@amd.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "mhklinux@outlook.com"
	<mhklinux@outlook.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ray.huang@amd.com"
	<ray.huang@amd.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "sohil.mehta@intel.com" <sohil.mehta@intel.com>,
        "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>,
        "wendy.wang@intel.com" <wendy.wang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [patch V6 11/19] x86/cpu: Use common topology code for AMD
Thread-Topic: Re: [patch V6 11/19] x86/cpu: Use common topology code for AMD
Thread-Index: Adp19U920kcxXebrRt2lV66ZeOjCxQ==
Date: Thu, 14 Mar 2024 10:21:34 +0000
Message-ID: 
 <PUZPR04MB63168AC442C12627E827368581292@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|JH0PR04MB7202:EE_
x-ms-office365-filtering-correlation-id: bd53a852-7136-4a0c-28ac-08dc441086ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 559rg+6qJ2iHWotoHV7TsyD2z1GfyCJAbNL0wpdW7UcPFBXLWrN+K7eti9sjXW9z11yQYCNqldPCXnGDNQZf6GPEX90TXgQxthFyWjio6s+Ul0VLEhrRN7LGE7Slh3XjHXlkJ8lLsiQdKopS5hLhwkT3txNX4oeCGpDw8rGv1HsNAnHE6ct2ENjVt1vDf7Pz9WPWQzEuUz1sIKhVbmHJvl+2U92Lb8+IHTSjzTxiTlk586PGRUKVf7JZEs39/0DcZTKOV3+xJFK8MaMxcGiOA5U1OCadSx34vYcj6Cq59eNbBB+LUGiQoZvPl7Q2M9VVH4goliRRKZ9xlibrD//ALJatQQS5Um+aVhHVE+RajvzJXIybPl6nEnSb/AT5PN6/PZYcHp0YLjYKKwyyix7fyk2ZXAlsvATOaPOy9e0yuPVJdPVJLkDQnc415tB3JDVxXmqlVzMwhCKcrULgx+RkzZiXQ40nIRG1vNdQHQ04TaA4mWwIQ6dpp90L4Mvbgli5wT4lWUikvK4GH2fLzkay6Rps5AgGfgT22jkGrLuezr1ZQFyxpW+oJtommIP0VoA++Cs2XFCaUOnrJEDQjk23LZ+ZyVTT4Wsb1oyvqXj0Lb+zmOC0fgy2RmOAriiRnS0s6816g08x5yYlNlhkS90Tg4A8PbV/UrvV3CnAGE1/OH32cPWr0pBdZ0QVkfJCIgxk8kyw5J9aBVswKOm/PluKy7M0t9SluSA1Hm8dB+Dor5w=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?aklJYXNDU2sxYzNFbmltZUNjMkFrL2NsR1lKWnVITitxa0dXZFB3L3hpTEtM?=
 =?utf-8?B?WG0wOUR6QWQ5WlphRFlUeUxtZk5MYStsQXBVRHRIMkZoaDR6UHhNcnhLdFhq?=
 =?utf-8?B?YkgzcVk0NFhHY1ZPMnUwUFA0ZzVWMEQ4NzlnQmZIZHAxU1dDWUE0RGtIY2dT?=
 =?utf-8?B?UjU0MitVaUZIbFlwSGo4UHZVWUtaRXhNYmVwT0xOK3phZjh2YWhZV2NRZGhM?=
 =?utf-8?B?dUFpK1JwbWprb055N2tMUkU0MmF1M0JlRXhyZFZ3Q0I1YU52OTM5L2s5K1F2?=
 =?utf-8?B?NklxYWVaNHZHdFQ2MWQ1Yk9YN3ljNi9sN1dtbThibVVsMmxlRlE3TTZWaE11?=
 =?utf-8?B?blRaMkNoSnJibEpseFZKY0p2OCtrUlIrNFhybTNHSGQ3ZE1ZVGJZZDJxaXl4?=
 =?utf-8?B?a1Q3aUpYZnRnUDZaRk1GUWFORnJsZVAzWWlYdkhqQ2dYNlNXaE9CSUllMktm?=
 =?utf-8?B?WlJITWlVYkxjTFd3cXJtZGlKMG5Yb2EwU0xub0xUZHBmalJ0VW16M3hPSEpa?=
 =?utf-8?B?cDlVVzJaQmp6UTR6WU51VGNBNW1hT1NqU0pUbkpFWG9XdHBhRGF0Sk16L3BQ?=
 =?utf-8?B?VjBPTUFWL0V6aGhyaVNBYzBrZENBQytrS04xd05KZHNEMWE1QzFBeFkvU0h1?=
 =?utf-8?B?RTUvV0xKSGlKeitZNC8vU2Vnd1hJYm92U0l5aFFsaTdqblVYSXF0alhDUzZZ?=
 =?utf-8?B?VVZoa3hTaEhLRS83MkgvS0dIZjVad2pjVVdiUVRKbU85Z2E1NHFXbm5rWkti?=
 =?utf-8?B?TGE5TWxIbTBaaEdwOVFzbWRnN05tOGNSWGd0MUlGQS9yNFVQZXBIYmJjTHFv?=
 =?utf-8?B?WlZWR3VWc3VmTSsvUXArYk1JQ2s4KzRra1l1RXdaZWVtK05UTTdWbFIrTTRZ?=
 =?utf-8?B?TlZoK1g3MUEzM09KUzFhY0E5Q243eHF0bHMrLzFPT215Y3lKM25WcTVJOGxC?=
 =?utf-8?B?U1FzWGZGMENObU1XLzlVRHA0RTh0QTJ4QlRNQ1lnQ3J4dXBaVkJwSFRGU1d6?=
 =?utf-8?B?bWNkS2syWk44N1RRczBpZm51R0NaaE5pTUs3QXVQTjNtblIwM054NGNnL3l4?=
 =?utf-8?B?QTF0emIxbk9hWERPOVdybVJiTjJBRmR5ZWZFZ0xROFNzVWlxVjFackdUNHY1?=
 =?utf-8?B?YjlqZVVpQmVhU2RKNFRqSnNJb1J3MWQvWHZGdXFQSjhUeVRaZG5zd3dpdng0?=
 =?utf-8?B?dnRyQVNPVElLZHBFZU1aS1E1RnNXNnNWblRveTIzZEhkd2JvK2paS1AyYTkz?=
 =?utf-8?B?TkJGbW00R2tmZEg4K2VBdXgvY1dGYmZDaDV5c2pFZmx5ZjZ5eFJCTEk3VHdE?=
 =?utf-8?B?eDA1U0xpYjE2a251MUJrL09WVzB1WVRsaVM0ZGRHMWhZbmRldjNmendrOEJk?=
 =?utf-8?B?NG1TQUxXNEFZTGVNem9pWVVwVkxHR0l0NmRvU0tOb0ZzTHNHcGhnR3lBZWFr?=
 =?utf-8?B?ak1COWtLdW55eCtqVmt0dVpseFFseDFsa1psQWlwRTd5ZEV5QzF5cnRodVhK?=
 =?utf-8?B?dzVPbmxJK2ttZWtsOHR3ZE91NGNObHgvZmNxZEhmcnhpclRSd01EbkhnMlpB?=
 =?utf-8?B?dVhRdWI2V3lQMUlKVnc5eG1DT1RVOWIzTy93R3F0NHo2bVhBVk4vZHJ3VDBj?=
 =?utf-8?B?S2dQNWdnckRmZFg3K3lEbFpsSEIzZDBCdHZFTFprcHN6YWxZcUxOczhaVk9P?=
 =?utf-8?B?ZFFkbk5rYnhuUWh6MHJmZTM5b0V0bEk1VVJ4c1RQdUhJVXJwajBQenliT3U4?=
 =?utf-8?B?akVwTGtmWVJQcFBEMUVZVjA0Yy95ZTArSmlxY3kvVXZQWEw1RVlsS3hpYjQ2?=
 =?utf-8?B?M1RsQnNOSEcrNmFWRHpQSi9xejRYSVUxcFBJaFB0ZzhZV2w1Z0JwNW5YR2Rq?=
 =?utf-8?B?V2tnTStSUVo0ZU1jZlpQNFM1cUdQK2Iwb3c4S2VZNDNEVXhSd0RpTzVZbzho?=
 =?utf-8?B?TlpyS0xKYmcxdGFPMGxid1dHdENlanU4YzE5VUdSV1Y4VHZSVU80dGErbzZP?=
 =?utf-8?B?T2lCUWZZMTNoZDFKdURYRDdzZWtzeXdRUm5HbjFydmF3VFJrVGpqblR4NE9N?=
 =?utf-8?B?aE04VldJa012T1A1YkpndCtwQlRKMHB4VEJ2TUpDVmZjZEk4L1FqZ2g4OEJk?=
 =?utf-8?Q?O+F2StYMJkQNJfnRJSA05+kh9?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	nfmAKacVsscIfM32c0KiwcqXgjx3T0uOjxVVUD6MDdSovfkkTY4jHWjgdFrDI9QhgoPVs/mr7fEVbXTQEqb9w7xo8qJKHPK/hlYpWrtVVELeYPUYngx+K4foS4/WLRVWtWR699SLz6IFqcSJUTnM64ByqW/hPDAn6dH4/qcY5oqXXH5zXXbgJnfQXCNaUcirElAZudvVyHbV5+4JmqBKrPT2gN2mAPd3ZdBerMUJHCm4gUqhMPKOpasZZ0uVBWs5fkSgtslWQJn5nAFtiIsy8exe7v2qxaGZXULWzPvDmPeGU4gNUDmVud18mr76qGG3xXJMFo+nYK9t5a4IVJ06lJFLBvwtXSQyX8Awzn8H/zphVA0luqwx5D9A6Ii5uHoXZBzmuNJOumuTzWOouClXz8U8hlzxB/qYpB037AvUchZbzy3B9KRoRn2Pm1U1zMkpZ2J9+3RnvXH5c+NjdySDytcOZFFMvBZ1t6GiJQiU5GxjEyl00mWrDi0C3WWCLc6wwTBsEu4/A9P8dBCluNhyzHSp1StfJUcXlcfX3ZH9ScNTDQF/hkcqQxQf8QoGRVL/1R7ANUKwH93Vku8oGK6tr+wflrsdcc3teG5N11sbcFmjktms7ePF9ZMjbRFI/rFC
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd53a852-7136-4a0c-28ac-08dc441086ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 10:21:34.9018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gJUn+LQrohNYF7kqC0TbQxMvyfKJmnIceKDQqPNyQFlQTAjcFRoSkbbt3BbbEZiSjt7GyOTk+6jhwygYO1+3eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR04MB7202
X-Proofpoint-GUID: 5HXJ2zGhKgVHzWqQQS3-8abFihZjBReE
X-Proofpoint-ORIG-GUID: 5HXJ2zGhKgVHzWqQQS3-8abFihZjBReE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: 5HXJ2zGhKgVHzWqQQS3-8abFihZjBReE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_08,2024-03-13_01,2023-05-22_02

SSByYW4geGZzdGVzdHMgZ2VuZXJpYy82NTAgYW5kIGZvdW5kIHRoYXQgaXQgZmFpbGVkLg0KDQpU
aGUgcmVhc29uIGZvciB0aGUgZmFpbHVyZSBpcyB0aGF0IHRoaXMgYXBwZWFycyBpbiBkbWVzZzoN
Cg0KWyAgNjQ5LjU5MDQyMV0gc21wYm9vdDogQ1BVIDIgaXMgbm93IG9mZmxpbmUNClsgIDY1MC4x
MzI5MjBdIHNtcGJvb3Q6IEJvb3RpbmcgTm9kZSAwIFByb2Nlc3NvciAzIEFQSUMgMHgxMw0KWyAg
NjUwLjEzMzQzMl0gTFZUIG9mZnNldCAwIGFzc2lnbmVkIGZvciB2ZWN0b3IgMHg0MDANClsgIDY1
MC4xNDg5MzFdIEFDUEk6IFxfUFJfLlAwMDM6IEZvdW5kIDIgaWRsZSBzdGF0ZXMNClsgIDY1MC4x
NDk0NzhdIEJVRzogYXJjaCB0b3BvbG9neSBib3JrZW4NClsgIDY1MC4xNDk0ODNdICAgICAgdGhl
IENMUyBkb21haW4gbm90IGEgc3Vic2V0IG9mIHRoZSBNQyBkb21haW4NClsgIDY1MC4xNDk0ODZd
IEJVRzogYXJjaCB0b3BvbG9neSBib3JrZW4NClsgIDY1MC4xNDk0ODddICAgICAgdGhlIENMUyBk
b21haW4gbm90IGEgc3Vic2V0IG9mIHRoZSBNQyBkb21haW4NCg0KSSBwcmVwYXJlZCB0aGUgZm9s
bG93aW5nIHNjcmlwdCB0byByZXByb2R1Y2UgdGhpcyBpc3N1ZS4NCg0KIyEgL2Jpbi9zaA0KDQpz
eXNmc19jcHVfZGlyPSIvc3lzL2RldmljZXMvc3lzdGVtL2NwdSINCm5yY3B1cz0kKGdldGNvbmYg
X05QUk9DRVNTT1JTX0NPTkYpDQpob3RwbHVnX2NwdXM9KCkNCmZvciAoKGkgPSAwOyBpIDwgbnJj
cHVzOyBpKysgKSk7IGRvDQoJdGVzdCAtZSAiJHN5c2ZzX2NwdV9kaXIvY3B1JGkvb25saW5lIiAm
JiBob3RwbHVnX2NwdXMrPSgiJGkiKQ0KZG9uZQ0KDQpucl9ob3RwbHVnX2NwdXM9IiR7I2hvdHBs
dWdfY3B1c1tAXX0iDQoNCmZvciAoKGk9MDsgaTwyMDtpKyspKTsgZG8NCglpZHg9JCgoIFJBTkRP
TSAlIG5yX2hvdHBsdWdfY3B1cyApKQ0KCWNwdT0iJHtob3RwbHVnX2NwdXNbJGlkeF19Ig0KCWFj
dGlvbj0kKCggUkFORE9NICUgMiApKQ0KDQoJZWNobyAiJGFjdGlvbiIgPiAiJHN5c2ZzX2NwdV9k
aXIvY3B1JGNwdS9vbmxpbmUiIDI+L2Rldi9udWxsDQoJc2xlZXAgMC41DQpkb25lDQoNCklmIHJ1
biB0aGUgc2NyaXB0IHdpdGhvdXQgdGhpcyBjb21taXQsIHRoZSBpc3N1ZSBjYW5ub3QgYmUgcmVw
cm9kdWNlZC4NCg==

