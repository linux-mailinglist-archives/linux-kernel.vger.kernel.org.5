Return-Path: <linux-kernel+bounces-26051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF24182DA81
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644021F227CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A5F1755D;
	Mon, 15 Jan 2024 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="cUPhXmrL"
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005117546
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.168_.trendmicro.com (unknown [172.21.203.211])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 3CD8910001FA0;
	Mon, 15 Jan 2024 13:47:59 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1705326478.493000
X-TM-MAIL-UUID: 0ec476b0-0924-45b3-808f-7180926d3fb2
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 7875D10000E42;
	Mon, 15 Jan 2024 13:47:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0lZ2kDUdv7uNL4ESVF1haAJeKoct6yLUp1ji5ZRsJK1z1HidiJowcoll/GWjKFigIGuJIDniAK5ZfmaTpgee6fqJAZeBUxLVK6hgjRpqRCMdjqUP8WUv9WZ+8M6lGMz+Ezf2BQGN/M8ZCxY8+13JVxOrKGq8gbP1MA+LhGv4zlcnrV1BnkW8WJYfXYj7PfPXNqfEMOQzJisd6o9K06pCrNCptAcztW/x3Ss+eV+E7+3KhN5qfVpZQ+i4Su5+Rz0ug9VgOXql9nAsIxBQQl0IW2cfd84MfjTYGFMPXffjNf5LRUEhkJOI5l3Ve/xQdvn/E9hqQsxkHHNiEyN/cv7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PX7hMiwAgN2yoxYyC4aL79C73pQGqe0LsokCocL4p64=;
 b=Rgy2eIF/4elgEZrfesX2TZkoIsLUeFG4qfEatXb0ImwtPrZOajCuyS4jsmplwju9RxLJGtxHb9icGIt1z7dZaqy1XRAowqyhSrkE8/OGyJZLZ5l+2G6zpcdvND/TW8VL5buo/DgOrX29YZXIZ+vTY/zt+8x2t+S8XkemxnhucgrbJcjBFVVdRM5BU5m0N0ghfqU11R5QyCUiRYl34y991SsLWWgTkqK6W7VLXDlCGcU5GxUNgHPDEL9AGD9cHRCdBIWEEKMyawl8j0hErTFe8wnbQU6g5aryrg+seJWC5EpOMIug0umrUDsljSX0trtrBch+ofnTK2DXjG45UJ4qfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
From: Aiswarya Cyriac <Aiswarya.Cyriac@opensynergy.com>
To: Marcin Radomski <dextero@google.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anton
 Yakovlev <Anton.Yakovlev@opensynergy.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
	"perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, "vill@google.com"
	<vill@google.com>
Subject: Re: [RESEND PATCH 0/1] ALSA: virtio: add support for audio controls
Thread-Topic: [RESEND PATCH 0/1] ALSA: virtio: add support for audio controls
Thread-Index: AQHaRJL4RLSqE9IkI0CpBMXWFPV0yLDa54Lv
Date: Mon, 15 Jan 2024 13:47:57 +0000
Message-ID:
 <FR3P281MB252791030510D4334B3EB702E66C2@FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM>
References: <20230209115916.917569-1-aiswarya.cyriac@opensynergy.com>
 <20240111133320.2717702-1-dextero@google.com>
In-Reply-To: <20240111133320.2717702-1-dextero@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB2527:EE_|FR2P281MB2043:EE_
x-ms-office365-filtering-correlation-id: c943a15b-0e2d-4ac5-0bf2-08dc15d094ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5zQnSK+jlXxe5aiItfSjO2oopAA6/syOgdq/3REKzfyc0GI6GS9EvmiplI3MooZ1npZ8Ikc7JqBcsUgPmrmUi8h/tuzU6BCWuDfPiBIOUtS1gzUv2BiH4O00HAD+S+j5weyKQRWlNdGKvfFskc3zBFayDVoQWzgrJAP6PmlDg7qGkR0oaJBoMwFR/9/+uVG2teZvNVYvuBtPV5P/GRw2jWVpDx8qRE2oZY/WbJ1fkRfUGj8KBqbclocL01r0VQBi67BlUrhUUM8GWxyn9B48G+OrL4THUsh7F+YPTYVg2oa/8JIG8P2QEDRos2WzbN+aGt62e3EE7TqFEm0MJgrDciiiyN3XPYZ16XCZvg77Zv5msBMi86YK+KtVGW4i78uPoJ8Psxo9WdkcWtUdJdPe5Z7n22eMQSDC0xNnxhF6FTufbW0AVku3oYXXGrRGmKYr/RMi3npvHVnPI+kVshET8pf997j44K5SUvazLxDVvt4cw0PmGfmUzYiy2/41TLj4d5aLfpUd4IuexLo6rQNPAQ7/20SGDxY0im4dYCgvQBkrfKN4vs2rnZwXel2TClhUIIDs1zezynDejyP3QVtG3Uv0Bn0vOMAREeSr0wP9Lgc2XqVAyt2qeoR2qybo5gRiBGgeNm+wV9WFi6iORol9ng==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(346002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66899024)(38100700002)(122000001)(38070700009)(2013699003)(15974865002)(86362001)(26005)(83380400001)(42186006)(41300700001)(316002)(66946007)(71200400001)(54906003)(9686003)(53546011)(76116006)(6916009)(966005)(66446008)(64756008)(66476007)(66556008)(478600001)(33656002)(5660300002)(2906002)(4326008)(7416002)(8936002)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVBIQmtQWTFKR041eG5GYXlHZkNQR0g0Q1E1dGRhZEpCaC9pbHM3d3duenNo?=
 =?utf-8?B?Y21pVUhMbGZCU1p4ZTB2ZnNzZDgwa2FnSHNKRUxYM01YdDFNR1R0bHlUeGMz?=
 =?utf-8?B?ZEMwN1FkZ3phL21vc295cUFqSk5hd1RwYjB5Y0ZydjNHcnM5cDhOdzQ1TjBJ?=
 =?utf-8?B?UGNLb2w5UC9MVnBLdXRFU0htaGp6ZWFwZytNeFpwM0RFM09jeWYya0JiT0JY?=
 =?utf-8?B?eTgzMnRiWHlISnNyNlZ6clhzVlZSWmdVUVpvMklzYUR0OUFBbzVOY2ZtWHg1?=
 =?utf-8?B?U09pUC9VeE0xWWFjdDh2SVFQQXFIWTVHcW5LWDh4WEZsbE1JR3FJN2hxb294?=
 =?utf-8?B?Y2hxekdSSjhDb1FqRVVXNXhYNzlXTTRlVlRBZlNKOFlqNUFSYzkrZ1pqQ0lm?=
 =?utf-8?B?Z1VQZGZERXJMYmZ3R0J4N2h2cEhKWERsd3B5dDJsbU4zY013VWZySTZySHZ0?=
 =?utf-8?B?dENkRUtHdkp4VFMySkQ3VFRkRk05SE5qZmtVeW52enk0cTdpTG56UGZCMFZs?=
 =?utf-8?B?RVJzditXQjNxNVZyakVTM3FUalcwVDZhSlB1Znd2QlpUaGNsek54Y0RUaEN5?=
 =?utf-8?B?MFZmMzVXTy9MVktyaTN5SmVUdW1HNkprUUFBZ29jOGF0Zmo0b3cxUGFTdVVU?=
 =?utf-8?B?Qk5EdGlmM0NabkFTNUpQRndqUENxbUZxMk1GamplNzEwYzN4eklreGdPY2N6?=
 =?utf-8?B?WUpaUElxRjg1WkFtQkpmRkl4MkZQa21PN1ozTDVUV0RLbzBWYnZmQ0h3cTMr?=
 =?utf-8?B?SnkvcWFWSFJwdTlsMGF5MDhqSy9tZVluak4rZGE2VjhCUkZFaUtreUxEay93?=
 =?utf-8?B?N3BHamNycndXZmMyYllmZXo1cE4zdk9pck93WnNxYXFZSWVBZy9XcDY2MVpO?=
 =?utf-8?B?RkdROFY2dk9uaE9rOHlwNDNFRXFPK2hvT1FmcGVYS3p1N1VQaStWTDFXUlZo?=
 =?utf-8?B?SzdOOG1uaUhhbXpiTW9tQVNBd3dSY1RHWUxZSEFBQW5yYmppK1BUNVVSdUlR?=
 =?utf-8?B?NkRLSjBoY1hxME1vOEszUzkzbW9EWHNVQ0VHQ1BVM1BDYlllWEl4NEo5YkVr?=
 =?utf-8?B?MnQzT3U1WjlEQnBxU3Zsd0JWMnlUdXRlUEpBL1pBRDVhODFpR29UMGNzZGdF?=
 =?utf-8?B?UXlPT1BpRUVveGkvdG5KVGVmaGxxNWxVaWJIN3FtaEp1OEJPVUFGMm5hT3NM?=
 =?utf-8?B?Z205QW9EYWkzMWNHWEN3NjVnSDJiSWxzNjV5Rkc3bjhubUhjQXlYa1dhcDR4?=
 =?utf-8?B?QVNHNUNSL1lyQU9xcEJHY3d3L0ZqUzV1QWF2QVhiSE4wVG4xa2JmWG1sL2tZ?=
 =?utf-8?B?OFloZHF1MGl5aUVidFpvb01GSTAvRnpnMG1KNlZOL0h5SjNUT0xKN01LYVhX?=
 =?utf-8?B?bXBRNzdhQVJkamJBalNmUU9qcjNuUGs5ZVdJYlFyOVl5bGh6eE1kalcwR2lu?=
 =?utf-8?B?MmZkTVgwajZqT2tOUGhobjIrdGVjOE9rQnRJVjF5YVUrRE5ONFpMTjFMcmNi?=
 =?utf-8?B?NE0wTWx3WWZtSkF1WjZUeG41cFJsby9zR3Jta3Z4UEZCdXB0WWd0b05GcU1n?=
 =?utf-8?B?S3Q5dHNTTEpmaWUvVEhBWlI0ZGU3ZG1EdFR4QkNJeVExT0lMSTJyTTAxQVJU?=
 =?utf-8?B?RG9qMDRYLzJremdyRVRqMzhTb0VOM2NScG92dll5WGVXcnlyRXpTNHIvQmhU?=
 =?utf-8?B?V3k2VFBjMmFjRnBGUkQ2MmdLVkRBYUVtSlpnNjZzUEx3KzBXKyt1VUFSampU?=
 =?utf-8?B?cW9DeU1XdnpEalNjT01GWVZnbzMySjBhK2hOSHVQUlh1Z0xIcjg0ajQ2dHR0?=
 =?utf-8?B?QWdQNFR1MHZrU3h1WDlvRzNrcE9heFJWUlNFMy9DdXlPZmlXV1djWFdwalpu?=
 =?utf-8?B?bzQwemlDeGc5RGl6RDdJd0Z5QW85V1ZhTTVsNEhOSzRRMmhGL29DWnMrNFVp?=
 =?utf-8?B?UXZyMWUxK1FCZC9oRE05ZGVmS1JjWUJTM25aMUVmVzJvMzF0TENSclZ6WjJt?=
 =?utf-8?B?STJNRUxWTWFkTXMzNkl6VG0xNG1nSDI4d0VVOVZuUEpQMnRNaWJZVmdDaWRo?=
 =?utf-8?B?a2s5NkQ5OEUrZURVbXlNaW9jVHhJZUxVbXR6clZCVElUODNGZzh1Q3pzV1pG?=
 =?utf-8?Q?WjRM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB2527.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c943a15b-0e2d-4ac5-0bf2-08dc15d094ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 13:47:57.0744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D1n+ZBvcBPa4lMT2ThC6Tg8thbbU0HkRlQfuLo9ngBvOGWqh3XHWuyy9XpDjfaOIpJwPQsLRhGAwaHIylA5o2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2043
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1015-28120.006
X-TMASE-Result: 10--9.439700-4.000000
X-TMASE-MatchedRID: byfwvk+IcRn5ETspAEX/nlqQSvqaPnYDQahV9NsL7Q+6rP6I4JtCoaPG
	P5RJ5YgIPXUSCAF3o32jpqzOtfSNKEBAqYs8dAC5ugsKg3hgnMwwoEy+KKX0sulSG3LMOWfSChN
	NSoowYAcaBWDNP8bM82g9lCkO6GnTkBNX7ctPCHUCzN6q2KcSe16UsWSgw8xYPtCfWUwJAdj8qY
	Xo9dS9IQFotqoxYumbJufhTdofzCzXYXKnv16li4/LriVzPuf5OTa4xErHZffFy+Kv6e1n37asX
	TFkoEYA+RdGqwirhhKk2eYHfOQSdQAJWpjAfSOIJtab7uGKaWb4rwQRo9u0sq3/rEOakn8sP9OL
	H1rDZcJMf5hXxVDJJXkIQKrRR+YxmXejpL0l0EOpTAyXiqoTW7ueT4Q7MJk103HPJtwvmXfQEYQ
	l671XeiVNJxt7aXvghG2qikEpQGVMNQ905ddvBRivhRZCXQyQ3/k8QyYVYXjXOD3csUq+p0Cb3g
	/ewbHB
X-TMASE-XGENCLOUD: 1206b4b9-35eb-43ee-8504-c898865337b7-0-0-200-0
X-TM-Deliver-Signature: 51743A03635F30AC53171FD2D8C2EF29
X-TM-Addin-Auth: b556KGzdewcOIz/saonBDlrSi7Rf19pLy+KNKmPYayF9ILgFvIE2qYNjAaQ
	vjyujrAND2ePo1xPyJ/XbSnkhKLtV5+axGsoAVpQ1oQcTRX8qlW6N0PvU6aKffm9RloQ7AfhVv0
	31oQBKBU+nHmx7Ei8xWWMjBWyQZhT/vNlh9pDHRVlcMd7SgQft8i6JbnjRsedc4lJOH4+2OeLNZ
	5VbGDnXSbaHRngCdPgxGh315ff9Qn4P5dfEYsqTJ2CeUS/vFFhHuzc0C2e4LXxXbNVF2JtDYVgr
	DypAsgFjUSEq4fzw0yNLiYSlkdpgzkgZiLPR7tbfPHjAaknK9CcabXmm/g==.oi+tHB2pO17nYD
	PZvXUtk9FeLfc20nZ32Oqpyr9cnU7Bw/CLxXHfWEtVLbmr4vcsem8pkCnCF+uCL4mPTHRo71lXn
	muKhKiz2FZs+zEUJ81Jy+GP8dz7qLm71xVGQV9ELLDTvoa2lGVYIuRK3CPt5j/MhmkrZIwMiYzk
	wCPxS/uZgzY/A9Gsx+4LNfXk+blpHL8IuefgwpfnGJywmMk3i5lYjwamsEJtgmAmlRzWam8cGgC
	SRiThMQzcav3tXdWT78hzK9A2GXxJC3yDkYDFJHBrpMh9QOsAd8x7heDlWhUEPJA0IXX+KUNsuC
	bw73wKp/K7mwh63sfGKUpbGkO+Dg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1705326479;
	bh=PX7hMiwAgN2yoxYyC4aL79C73pQGqe0LsokCocL4p64=; l=2136;
	h=From:To:Date;
	b=cUPhXmrLAkfOAUgiX0DsbM6zC78trz58qqCPndvjewbJ1xDQF8RwvtEblsgKRuONT
	 u3Z+U2eJcoHFkUmXUgAwRnlwpIRCA9+IiFmqdkbyEJMAoe5xCP/dpWzenGsva87CoE
	 UZx1rIAY92S+SbScsSwnZWuNWlH8Lwf9nQiF4SddiW25Lt2kI9UnjTDDTfC672+JoO
	 8o7wWgCPYPbimosAFcKIz61UfWJeAGRXuHr3yWs8tZNp3YlOlWHs8cRiBkJZYu4aih
	 tEUGWVrbbVdmIwY/tRveUaZxITULRQZ+tJDdxuIojrJ2wnn13v+INb7KypU0rPJShh
	 n38AHvzykOCWA==

SGkgTWFyY2luLA0KDQpJIGhhdmUgcHVzaGVkIHYyIG9mIHRoZSBwYXRjaGVzIHdpdGggYSBmaXgg
dG9kYXkuIFRoZSBmZWF0dXJlIGRldmVsb3BtZW50IGlzIGNvbXBsZXRlIGFuZCB0aGUgcGF0Y2gg
YXdhaXRzIHJldmlldy4NClRoYW5rcyBmb3IgYW55IHN1cHBvcnQgaW4gdGVzdGluZyBvciByZXZp
ZXcuDQoNCkJlc3QgUmVnYXJkcywNCkFpc3dhcnlhIEN5cmlhYw0KU29mdHdhcmUgRW5naW5lZXIN
CuKAiw0KT3BlblN5bmVyZ3kgR21iSA0KUm90aGVyc3RyLiAyMCwgMTAyNDUgQmVybGluDQoNCkVN
YWlsOiBhaXN3YXJ5YS5jeXJpYWNAb3BlbnN5bmVyZ3kuY29tDQoNCnd3dy5vcGVuc3luZXJneS5j
b20NCkhhbmRlbHNyZWdpc3Rlci9Db21tZXJjaWFsIFJlZ2lzdHJ5OiBBbXRzZ2VyaWNodCBDaGFy
bG90dGVuYnVyZywgSFJCIDEwODYxNkINCkdlc2Now6RmdHNmw7xocmVyL01hbmFnaW5nIERpcmVj
dG9yOiBSw6lnaXMgQWRqYW1haA0KDQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fDQpGcm9tOiBNYXJjaW4gUmFkb21za2kgPGRleHRlcm9AZ29vZ2xlLmNvbT4NClNlbnQ6
IFRodXJzZGF5LCBKYW51YXJ5IDExLCAyMDI0IDI6MzMgUE0NClRvOiBBaXN3YXJ5YSBDeXJpYWMN
CkNjOiBhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmc7IEFudG9uIFlha292bGV2OyBqYXNvd2Fu
Z0ByZWRoYXQuY29tOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBtc3RAcmVkaGF0LmNv
bTsgcGVyZXhAcGVyZXguY3o7IHRpd2FpQHN1c2UuY29tOyB2aXJ0aW8tZGV2QGxpc3RzLm9hc2lz
LW9wZW4ub3JnOyB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZzsgdmls
bEBnb29nbGUuY29tDQpTdWJqZWN0OiBSZTogW1JFU0VORCBQQVRDSCAwLzFdIEFMU0E6IHZpcnRp
bzogYWRkIHN1cHBvcnQgZm9yIGF1ZGlvIGNvbnRyb2xzDQoNCkhpIEFpc3dhcnlhLA0KDQpJIHdh
cyBsb29raW5nIGludG8gVmlydElPIGF1ZGlvIGNvbnRyb2xzIHN1cHBvcnQgaW4gTGludXggYW5k
IGNhbWUgYWNyb3NzIHRoaXMgcGF0Y2ggc2VyaWVzLCB3aGljaCBzZWVtcyB0byBiZSBtYXJrZWQg
ImFyY2hpdmVkIiBvbiBwYXRjaHdvcmsgWzBdLiBJIHdvdWxkIGxvdmUgdG8gYmUgYWJsZSB0byB1
c2UgdGhpcyB3aXRoIG1haW5saW5lIExpbnV4LiBJJ20gd29uZGVyaW5nIGFib3V0IHRoZSBzdGF0
dXMgb2YgdGhpcyBzZXJpZXMgLSBpcyB0aGUgZmVhdHVyZSBzdGlsbCB1bmRlciBkZXZlbG9wbWVu
dCwgb3IgYXJlIHRoZXJlIHNvbWUgY29uY2VybnMgdGhhdCBuZWVkIHRvIGJlIGFkZHJlc3NlZD8N
Cg0KSSdkIGJlIG1vcmUgdGhhbiBoYXBweSB0byBoZWxwIHdpdGggdGVzdGluZy4NCg0KVGhhbmtz
IGZvciBhbnkgaW5zaWdodHMgb3IgdXBkYXRlcyB5b3UgY2FuIG9mZmVyLg0KDQpSZWdhcmRzLA0K
TWFyY2luIFJhZG9tc2tpDQoNClswXSBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2pl
Y3QvYWxzYS1kZXZlbC9wYXRjaC8yMDIzMDIwOTExNTkxNi45MTc1NjktMi1haXN3YXJ5YS5jeXJp
YWNAb3BlbnN5bmVyZ3kuY29tLw0K

