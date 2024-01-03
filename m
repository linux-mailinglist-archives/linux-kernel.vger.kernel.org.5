Return-Path: <linux-kernel+bounces-15205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12DA822855
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:19:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCD31F23B98
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0274C182A3;
	Wed,  3 Jan 2024 06:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kunbus.com header.i=@kunbus.com header.b="1K6Ll2e7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2081.outbound.protection.outlook.com [40.107.13.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0469179B1;
	Wed,  3 Jan 2024 06:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kunbus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kunbus.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GevC1aVkzDJxzyhNh4LsDxZwtAEgHv8GWIcYBOOSI1+LsF0vyGciJkxV4hV2UL6EIKkO0VeFk3LtPoB8ynz/pBJCfsl0wOX68/4CiELKGVJNlIHqUKH6ZBawHGHknIuar4ZXceqYVCM6HMSoAh70p2TksTaEvK8QulbLIrGcH0qJ2yNUYomRDV6Mjq+GvKJObQS1nrjXKRxwuC8cmeHZwy6Ie0RKARo9uXELdtBq7ZHT9wgziLroNuklR12P3RUnoOSpgvtQ6Ji5L6o1s2ZGDh2GVV0fDKrnvqQ+v0MhH9Tn/h4VbIP58XIb2aAhq4ejlfvBz/6s0ozqxHc4EdX1Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WJ96peUnX/AfmbbyHNhv4J8A1BryIIvMGB2j/GpC8Ow=;
 b=cqOftn6O10FeWWEb6r3sQ6apP73B+P0xrNtRW7ilTrxTH05Xs7nah8kBvgWO1W6jHmHjbtcAdcwXHtkoVh5TxwGkYBWeMVxXSBWX7fjsQDopIIrStAEufak19NPatzQbFwDHMZ4g1kBEmwnXTyZYCjQf6X1A6hiEPlwd6UMMQOoHph/npykaMzGunSpURCGiggwBOrGREFqcSTLLHDNYnFnQz/sNpzlZWZIIIqYl1FsRmxpsL4V2cyZrocbV3mas//NNBoUS8s0SB41sqPbxHYOvz2T9rsf5xunA1uR/T5PKemMCZ6g8g6pdhNwHt2mCdp+yADtzfJnZip3pokaPzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WJ96peUnX/AfmbbyHNhv4J8A1BryIIvMGB2j/GpC8Ow=;
 b=1K6Ll2e7YoLBKXc0QGoqpnrt+QXH+rI8hEj5KD6aMoY+6uVVs1lbcLZ1rHX7jGxYBPj+0+0+qEXXEz9KITAnyIbJrDum7qE/wNw9abPZXFUDfIJYMZfyee9GXURLhwyTT8Ii32TPGAwvysSedJjHdXGOe8HmdEKSt4oFsSXPb0Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by GV1P193MB2245.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:19:09 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::67b0:68bf:2582:19cb%6]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:19:09 +0000
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: u.kleine-koenig@pengutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	cniedermaier@dh-electronics.com,
	hugo@hugovil.com,
	m.brock@vanmierlo.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	LinoSanfilippo@gmx.de,
	lukas@wunner.de,
	p.rosenberger@kunbus.com,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v7 0/7] Fixes and improvements for RS485
Date: Wed,  3 Jan 2024 07:18:11 +0100
Message-ID: <20240103061818.564-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|GV1P193MB2245:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bad0d11-fd5c-41dd-358f-08dc0c23e53c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ub71Cm0x9qp1mPmiZ04lKhTmW9cc87OzyrGpLN/NMUTU8UBS/whM7xIJ2fyTQ2do9U1tMGiAHTMCrk3jI3z4TPgVSVxV0Vxt0ci7sKHBbpcffk1ji/vIP3gx2hZMhY2hbILJAyoBAgwiUwGZCs6Y3H4v91VdrV5rMrrO4cVn6wRlBCnJJx4T/1+LAF6u6hjo4i+GsN7r5dwUGxmDc2fCEf85R+b4Qi3sAQzXveDT42Ecmd9lreUyH71/HvgMWOiCNLoR32WUI5OA99+eOiY95WZRqYHfaJaqpFUWM5JfUeF56Jto1PBuCyL+s/XqRpjoISvBz1C1H+3ArEQXmqBJkbSG5HZc1xBfXMMDmHLvwERAMeQgzG/t3qGZmm1GdiN5H4b5Kk1qZLd6PYxy9ZfcMwJLP9OHBFrcJVfpP1Gmt3LAkPUJOzC4c+7yXHPeZ9DRMaDTvIXiXFhRT/Nnf+txGaBPXkEG9O1QDC2WEZebcQODWbIN2VJKbBTiIlKTqZZup3c8rCTWkt+/xWgwWoamkH1RMyztgA6FYM7zyy8/nruaVKCGqIeu6hPaK3WBSvCC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(136003)(39830400003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(66946007)(66476007)(4326008)(478600001)(316002)(8936002)(8676002)(6486002)(83380400001)(6512007)(6506007)(6666004)(52116002)(1076003)(107886003)(2616005)(7416002)(5660300002)(41300700001)(2906002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UE1YNFUvMVdlYmxsTkJvWGdjRnZzVjJEUU9hc0VKdEFyaHNpeWZGblhRWCtq?=
 =?utf-8?B?UW4wTlJCM1BnaDIyT2d0TmJKTVdzd0hyK3h5aTlEb3dBdkNPQzVNQ1NadkVu?=
 =?utf-8?B?cXhNNUdtUGwvUlQwM1dDRFg0UHArYlVhODFDeDQwSTJVNURQdnI2aUZJNjBI?=
 =?utf-8?B?TmZReUlWbFh4TUYyN2FGYUVIZVR0c1hLQXUxZk9HY1d6clNKdndka0dicEpj?=
 =?utf-8?B?aU5ZUFRxck5nWkIwakdwdXREdzZ3Uy82SHFpeDhhVlMvYUxLblc4TFZ3R0l6?=
 =?utf-8?B?MUdvb2Q2a3Z3YUphNE8zYXFDTzZ0YzZsNnVkampGbi84SjZFNjJFLzFDNXpr?=
 =?utf-8?B?akJzTEE2NUlCaEJGRHlzeUF3ZVRxZlF3cEUxdGRBbmYwbDZtdHgydWthd2p1?=
 =?utf-8?B?Tnl4MzdiVGVadG8vNzRaMk9kYytqMTZFNkRkRURMaHhaSFZPWmlmb1R6WmRE?=
 =?utf-8?B?bkNZYk5QODg4VlhOWm43ZVNuQ0w4cTMxV0NkUXc0UDFqR0NFOTJ4SUhoZ2x3?=
 =?utf-8?B?ZnI3NG5lTm1UTmVZWnF1WllqdFdyK1FsNW5DY2h4c3RobitzZGtiTVVZK0NO?=
 =?utf-8?B?QVVQeVB5V2F4S1JqbGVGQlZkVHhnMjA2M2lrc3NWNGlucVlBWFJVSUh5ZUl5?=
 =?utf-8?B?ay8wUWdJSm9IdE9lcmhBcHI1QnR4VTlTNFZvMEFtdjlmWXdIUVV0WlJQMHdK?=
 =?utf-8?B?aHNRbmczWmJLOFVnNm1KRGFocC9Idm9ldWNCUEtOYlFKNzBMdzZNbHpmRC9Z?=
 =?utf-8?B?cTZqNk5Sby9PTE1TSW1SOEVzT1ZkamxlZktwVmV2dGIrV3d0QU5RelNreUN6?=
 =?utf-8?B?UVlqTnYyWFZEQWlGUmJBVlZkV250S0ZkeWFITE11bGppTXdpOUxSY2Nxcnpx?=
 =?utf-8?B?bFd5S2pINHBxc0V0MzJIdmtFbzVFMVVDQ2pHcnJiK3p6RGQ5M3pqNmpka29r?=
 =?utf-8?B?TzhJYS9FejdZK3BTTFRyOFhTSFdWeTF5SXVSYVBPbC9taEdudEtQY0FjNFY5?=
 =?utf-8?B?cURtR1dZQmRac2dNU3c0SU43SEpXbzR3aXhqM2JQTlIwbUNuWXE3WEV6ZUZh?=
 =?utf-8?B?TTJ4aytzNEdnanNwTTBqNkNXanNOUlNnOXA1dXVVSTJlSzlLanBpMS9iZVNU?=
 =?utf-8?B?cGI1aVZrMGFTK0NCc211bGludVRsQUVQcnBXcU4xRzBtMTgwWWdORXRybDVL?=
 =?utf-8?B?SmUwTCtUdzkvYllyMEdXb2puSjBJSFFDQU4zekNJKzJhWUlDT3RPZmJidkg2?=
 =?utf-8?B?cm9ZTFVUMkpyMDVSaSswSHdsYytFSkM4dEx0SEpKaitxSWdCNFB5M2NyR2I3?=
 =?utf-8?B?em9ubXlaYWRUSzZzVWZUUXQyWG5EcENqdy9lckpVekNBUE5kSVJJNlNYOXEy?=
 =?utf-8?B?U1VUQ3JxK3F4UFh0NlhJRkhwUmtGWC9aT2U5bmkxaUhIdlpvSGNDZ0xwaGVm?=
 =?utf-8?B?R096a29YbWZvdDd1VWxEUUVPenF1cTZvcjBaanBwZ04xcFQ0NTdmcEFzcllS?=
 =?utf-8?B?eXMvREw2VE5jRTdWWmNUNGt2Q3BNWVJOVnF1dThScDhMYzZ0YzJ2Nm1LZjZ6?=
 =?utf-8?B?c2w3ZERHckNBQllTQ0ZxQ1NGMURweWl1SWpoTWRGNVhncmQ0VmhBVkJOU2Nj?=
 =?utf-8?B?d2ltTGwvU1JEalh0OXdzV0NGMVJQdDFQdFhCeitGVlRkM1NyWDhkZmc5WE00?=
 =?utf-8?B?SU5VaW1pSkJwbk5sdlQ4OWpSa2UvQm93WHRvOWhhY0pVRml0WlpCdHFYWnU2?=
 =?utf-8?B?UEtDT3JCanBYQWFteFNBN0NpQ3loRmpDeDJMcWNpbDcza2lheEhwYXgzUWx2?=
 =?utf-8?B?M1Z3M3JiNDA5M1N4eXN3RHpSUFozZFNOZkxHV1czejdyUWZ5VU1PUkUwMFky?=
 =?utf-8?B?bjRNT3crOFJqRzVIV3lYUGd5WDcyRXJvMUEzMHlsMllsN04wbkhxaGtWYVpO?=
 =?utf-8?B?ekg2bDdzRkhGS3BFRDNza1BDNXFXOUJmdnVuU2dtL0RYdmNpSnV1YVVXT0dK?=
 =?utf-8?B?Y2VEMkx1TE9nR09HOWhKQ0FiUWhSR2pOYi8zVklLUUJjQmZ3TFVxNGdxR1I4?=
 =?utf-8?B?Y25LOG5tOHVXL3l4WWI1ZlhTTUxSd0NDSkZscjk4V2pETVFaUENPTFYvRFR4?=
 =?utf-8?B?SkkzZmxaTGMxNjdiNmFzTXNwT3RnUUtpWXpPdnUxU2Fjd1F2Z0VERExpd0M5?=
 =?utf-8?B?Y0JaOFVyUmdaNmJkTnhRaUZxWUFBcWlDQmdzR0drVXRCRnlrakxPVk5xVkI0?=
 =?utf-8?B?eU9qRTNUMzNVbk9GSFpwNFpnQWp3PT0=?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bad0d11-fd5c-41dd-358f-08dc0c23e53c
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 06:19:09.1898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lqLa1tpFgPIUM3K1tCH7YaGky4sBEWN+86qFQTctdvI6MZZq888gWspeBZHB5xIxqmxw7PImSF5JJxZ+JlhSYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2245

VGhlIGZvbGxvd2luZyBzZXJpZXMgaW5jbHVkZXMgc29tZSBmaXhlcyBhbmQgaW1wcm92ZW1lbnRz
IGFyb3VuZCBSUzQ4NSBpbgp0aGUgc2VyaWFsIGNvcmUgYW5kIFVBUlQgZHJpdmVyczoKClBhdGNo
IDE6IERvIG5vdCBob2xkIHRoZSBwb3J0IGxvY2sgd2hlbiBzZXR0aW5nIHJ4LWR1cmluZy10eCBH
UElPClBhdGNoIDI6IHNldCBtaXNzaW5nIHN1cHBvcnRlZCBmbGFnIGZvciBSWCBkdXJpbmcgVFgg
R1BJTwpQYXRjaCAzOiBmaXggc2FuaXRpemluZyBjaGVjayBmb3IgUlRTIHNldHRpbmdzClBhdGNo
IDQ6IG1ha2Ugc3VyZSBSUzQ4NSBpcyBjYW5ub3QgYmUgZW5hYmxlZCB3aGVuIGl0IGlzIG5vdCBz
dXBwb3J0ZWQKUGF0Y2ggNTogaW14OiBkbyBub3Qgc2V0IFJTNDg1IGVuYWJsZWQgaWYgaXQgaXMg
bm90IHN1cHBvcnRlZApQYXRjaCA2OiBvbWFwOiBkbyBub3Qgb3ZlcnJpZGUgc2V0dGluZ3MgZm9y
IHJzNDg1IHN1cHBvcnQKUGF0Y2ggNzogZXhhcjogc2V0IG1pc3NpbmcgUlM0ODUgc3VwcG9ydGVk
IGZsYWcKCkNoYW5nZXMgaW4gdjc6Ci0gZml4IGVycm9ybmVvdXMgY29uZGl0aW9uIGluIHN0bTMy
IGRyaXZlciBmb3Igc2V0dGluZyB0aGUKU0VSX1JTNDg1X1JYX0RVUklOR19UWCBmbGFnIChwb2lu
dGVkIG91dCBieSBNYWFydGVuKQotIGZpeCBjb21waWxhdGlvbiBpc3N1ZSBzcG90dGVkIGJ5IGtl
cm5lbCB0ZXN0IHJvYm90CgpDaGFuZ2VzIGluIHY2OgotIHJlc3RvcmUgUlM0ODUgR1BJTyBzZXR0
aW5ncyBpZiBzZXR0aW5nIHJzNDg1IGNvbmZpZ3VyYXRpb24gZmFpbHMKKHBvaW50ZWQgb3V0IGJ5
IElscG8pCi0gZHJvcCBjaGFuZ2UgZm9yIHVhcnRfZ2V0X3JzNDg1X2NvbmZpZygpIAotIHJlcGhy
YXNlIGFuZCBjb3JyZWN0IGNvbW1pdCBtZXNzYWdlcyAocG9pbnRlZCBvdXQgYnkgSWxwbykKLSBy
ZW1vdmUgdW5uZWNlc3Nhcnkgc3RydWN0dXJlIG51bGxpZmljYXRpb24gKHN1Z2dlc3RlZCBieSBJ
bHBvKQotIG1vdmUgYWxsIFJTNDg1IHRhc2tzIGludG8gb25lIGZ1bmN0aW9uIChzdWdnZXN0ZWQg
YnkgSWxwbykKCkNoYW5nZXMgaW4gdjU6CgotIGRvIG5vdCBjb21iaW5lIHRoZSBmdW5jdGlvbnMg
dGhhdCBzZXQgdGhlIFJTNDg0IEdQSU9zIChhcyBIdWdvIG9yaWdpbmFsbHkKICBzdWdnZXN0ZWQp
CgpDaGFuZ2VzIGluIHY0OgoKLSBhZGQgY29tbWVudCBmb3IgZnVuY3Rpb24gdWFydF9zZXRfcnM0
ODVfZ3Bpb3MgYWZ0ZXIgaGludCBmcm9tIEh1Z28KLSBjb3JyZWN0IGNvbW1pdCBtZXNzYWdlIGFz
IHBvaW50ZWQgb3V0IGJ5IEh1Z28KLSByZXBocmFzZSBjb21taXQgbWVzc2FnZXMKLSBhZGQgcGF0
Y2ggNyBhZnRlciBkaXNjdXNzaW9uIHdpdGggSWxwbwoKQ2hhbmdlcyBpbiB2MwotIERyb3AgcGF0
Y2ggIkdldCByaWQgb2YgdXNlbGVzcyB3cmFwcGVyIHBsMDExX2dldF9yczQ4NV9tb2RlKCkiIGFz
CiAgcmVxdWVzdGVkIGJ5IEdyZWcKCkNoYW5nZXMgaW4gdjI6Ci0gYWRkIG1pc3NpbmcgJ0ZpeGVz
JyB0YWdzIGFzIHJlcXVlc3RlZCBieSBHcmVnCi0gY29ycmVjdGVkIGEgdHlwbyBhcyBwb2ludGVk
IG91dCBieSBIdWdvCi0gZml4IGlzc3VlIGluIGlteCBkcml2ZXIgaW4gdGhlIHNlcmlhbCBjb3Jl
IGFzIHN1Z2dlc3RlZCBieSBVd2UKLSBwYXJ0bHkgcmVwaHJhc2Ugc29tZSBjb21taXQgbWVzc2Fn
ZXMKLSBhZGQgcGF0Y2ggNwoKCkxpbm8gU2FuZmlsaXBwbyAoNyk6CiAgc2VyaWFsOiBEbyBub3Qg
aG9sZCB0aGUgcG9ydCBsb2NrIHdoZW4gc2V0dGluZyByeC1kdXJpbmctdHggR1BJTwogIHNlcmlh
bDogY29yZTogc2V0IG1pc3Npbmcgc3VwcG9ydGVkIGZsYWcgZm9yIFJYIGR1cmluZyBUWCBHUElP
CiAgc2VyaWFsOiBjb3JlOiBmaXggc2FuaXRpemluZyBjaGVjayBmb3IgUlRTIHNldHRpbmdzCiAg
c2VyaWFsOiBjb3JlOiBtYWtlIHN1cmUgUlM0ODUgY2Fubm90IGJlIGVuYWJsZWQgd2hlbiBpdCBp
cyBub3QKICAgIHN1cHBvcnRlZAogIHNlcmlhbDogY29yZSwgaW14OiBkbyBub3Qgc2V0IFJTNDg1
IGVuYWJsZWQgaWYgaXQgaXMgbm90IHN1cHBvcnRlZAogIHNlcmlhbDogb21hcDogZG8gbm90IG92
ZXJyaWRlIHNldHRpbmdzIGZvciBSUzQ4NSBzdXBwb3J0CiAgc2VyaWFsOiA4MjUwX2V4YXI6IFNl
dCBtaXNzaW5nIHJzNDg1X3N1cHBvcnRlZCBmbGFnCgogZHJpdmVycy90dHkvc2VyaWFsLzgyNTAv
ODI1MF9leGFyLmMgfCAgNSArKy0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAgICAg
IHwgMTEgLS0tLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvb21hcC1zZXJpYWwuYyAgICB8IDI3ICsr
KysrKystLS0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jICAgIHwgNjEgKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2Fy
dC5jICAgIHwgIDggKy0tLQogNSBmaWxlcyBjaGFuZ2VkLCA2NyBpbnNlcnRpb25zKCspLCA0NSBk
ZWxldGlvbnMoLSkKCgpiYXNlLWNvbW1pdDogNjEwYTliOGY0OWZiY2YxMTAwNzE2MzcwZDNiNWY2
Zjg4NGEyODM1YQotLSAKMi40My4wCgo=

