Return-Path: <linux-kernel+bounces-24290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EE182BA6D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 05:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D72284F77
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 04:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700255B5D3;
	Fri, 12 Jan 2024 04:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AoDWyfmq"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F125B5AB;
	Fri, 12 Jan 2024 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJfvlObab/P5XkhZw1bw/8uLh4vpBmJo50/ci43jzE1M75OPjUWD9zEVRJPQsrWVJ8MroEM1SKJ1xcgNnQcrbvoyENq1xo6HTBc5ulrTeuEj5sXMU7CHlH5/zcWo8bJhATlPVQgKv9jQmOM4xXI6Ab8G4578It8KlsVvqG34KSV4UPADG/JHtOne+uSUzTA1HzbPp8arhjHw/qrovJGmM6FiqxiJg0rAeyvvEiWOyMs2vGOLi+25MMtga9LgXUOd9TKC+z5MOu4PAw0mWT1pxG86ngyFydGvovScgChno532qHvS1b90GT2miZI8dbaA6IGebJxMb9sH9s7IXSoxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRFVFXUeqQTlv5DAeePR88KqfV39lOKDw3hEiltqeY4=;
 b=lhC5m09jz3U+P14ITpppAh/ymzybnf9R0d8D5oZOHiMnVQM0Zc2/pHIG6VnT/+RjytW2ylU4eyZqnNAo2Y0/gmPxC24UDG7XNJ98vUIgYy6LCt6foKUsGwX4cJcEVUQytiYS1Al4RVoa0FPuLfhVgVwj77Sguaa3dJRVlTFL5//PLnz7jkcdsHXJNQpHFsY+t/TRdLwHlfhyByNgwVNsCgwy8zWQhO1bI4jgzhE+XTcg4GHmTuubyydKqMQmAf1g0gAL/0i8yFjwzLvxY7t9tnwh9bC78DgF3koJNG44ZIwy7kce7IgVt5nXKY4+Y9nwoOdx2t7jPo5ZRJnMWajKTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRFVFXUeqQTlv5DAeePR88KqfV39lOKDw3hEiltqeY4=;
 b=AoDWyfmqRTdvmgo8LovwioN2bp87KMVvutrpanPQ5iyDRnh7vDRhbWwxfq8Pt0j5Uziyx9SS6IMudqpMJ35wf2HzCsIm/pgwpSzN8O3wuQBNfY0Nca3QeOCXu4IHl8dZPL0AQHx7dL5lD/N9R+R0m9lTbYLEmvCH3A/wsfLiidjT+aTxkUjVJ/y0BE5nd8/8f8mJHiXINUwXhg9uFpzlWaWM1J51Gzg7AsgvKwxvY042mXARDGz0nEt+107re1wZ2mYlKMwcYDee8SbDhiTjBU4Gbkezu2rNHlqvfbtF1Mb6iuSM0X/dOp+3eij22aB+2dKfngDX/UkF5QZxfgYA1A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 12 Jan
 2024 04:34:42 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 04:34:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christian Heusel <christian@heusel.eu>, Jens Axboe <axboe@kernel.dk>, Dave
 Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
	=?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>, Christian
 Brauner <brauner@kernel.org>, Min Li <min15.li@samsung.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Damien Le Moal
	<dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] block: print symbolic error name instead of error code
Thread-Topic: [PATCH] block: print symbolic error name instead of error code
Thread-Index: AQHaROQ4iiiYWV5HGEmk27T6wIwMurDVl4iA
Date: Fri, 12 Jan 2024 04:34:42 +0000
Message-ID: <624aac65-6162-4ba7-b891-694c6044d235@nvidia.com>
References: <20240111231521.1596838-1-christian@heusel.eu>
In-Reply-To: <20240111231521.1596838-1-christian@heusel.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BN9PR12MB5082:EE_
x-ms-office365-filtering-correlation-id: 056813d5-9cb6-4626-2265-08dc1327cbda
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 onxnG/UgyOmMEc8V/VB8D+bv1FAQdYTut8kBbZThhItUtEMEojiz2xGAdZIfiASHnVVR7CPpNElfLnhKWyshWGbj+pyIUUlaFq6r9hf28K2+88iJLRsfSRazBfdFnUUziAV+5nCQ6AWoUxE/BTy7lec2xYhiDh5/NuxZiQqC68Ddu6WosQOstZtqQgaE5PIXfgX9Q5Xr33UUNxKdZcj5MgjHGRQJMQ4Q1azH42vcPo3DkR156SkO9Xtt7p9DXSZmMnArcEUzr46uVXQ1xnCnYo0lW8wNexY+omPMmYb+L0/wJfF5sSTFF0ho0nG4ANUu30HE+vwi+A23m23VXyT1063wQJKZ7K6//WH8n1n5pYUQvlLb5K0H5gZWymF7QeC39mPK/3oj/1IlKekx3/M0/dZrcBBcBpzx0jA9UteTqaIodb4hKL0IOocwhXt+ui1bbjz1l/rK04wbZA7HchqLI4yP3yFir1qNxXU3YKPXD75uKDQTQGDke75pVghmeMda5V5Mo09eyqlEXpgTY0PWZwuXb8PqaRXgrj+nOZwkcMt/EdNVk/E4h7j8ZdK2EyICIaCxYmdKkChzmpi8f+PntL5xWzl/JjXhEb+GmsmRRtPS4wKDd8vM5vrnX9JnGgo1+bw7rGM1FJ9RXUygl40QTnro4zVagDM1QqNGBs7rgHlBh/wAWow1WJKHwInda3eMwSysCRT0/yn0mNU+ne+QAWSmW252xDlsA/ZBWEU8rwg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(83380400001)(64756008)(2616005)(6512007)(53546011)(38100700002)(66446008)(122000001)(66476007)(6506007)(8676002)(7416002)(966005)(8936002)(4326008)(4744005)(478600001)(66556008)(71200400001)(54906003)(6486002)(5660300002)(2906002)(110136005)(76116006)(41300700001)(921011)(38070700009)(36756003)(316002)(91956017)(66946007)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVIxSVRzVk84RzEwWExta01NRjNRVzYvUWtOQTc1dWxCWkxOOUp0ekJ0REVn?=
 =?utf-8?B?VDl4bEljWnNqeGZ6Q0QzcGoveXVRZU4rTXlxK2NlT0xUU095VEl0K1F2M2l2?=
 =?utf-8?B?NFdmT01OQnV2RHhKQ2ZnNnhPV2ZJRStOVUFMbUl0aTA0clZ3T2I4dzhFVG1P?=
 =?utf-8?B?bDI5d0tNdks2VUk2WjNyVlJLTVljWkRvNUJCZGhEVGtEVzQwNXFDN0tIWkdW?=
 =?utf-8?B?WnpsMTgrK2lpUkxJb3RmNU04elRKd0VrVmhmbjZGM0NXVU1xZU0zbmNpQnNC?=
 =?utf-8?B?RmY0WjNEZy9CV1U1bkl5T04xeng5NitnTUxmR2hzTEkwN0JWaG5HN2VoMmhx?=
 =?utf-8?B?TTVWUUY2bHk1Qk5ZK1dCMWJWK2VUWlRVbUJjZEdSMk9SczIrVTF4RVVLVW1D?=
 =?utf-8?B?U0pCWE5DRnoxZ1BRYm13QXQ0MWZjT1VJQXNEYXNvNjREdllIMmlpa1VKeUZx?=
 =?utf-8?B?eXdQREh4V1NzRkd6eUUveTgzVWlZUE1LQnlwYk5IMTFZK0h4emNDZlhIbW5x?=
 =?utf-8?B?MjgzVndlTmlSNHRJS3ZCcjZHQUt4NldKdUZVVVFUTE5raTFOcllFL1V4bUlL?=
 =?utf-8?B?VGczTHJLcWJsZlJMUDloMktCRS9DNytmTTRQWWJ0NUdXcUpXaXFBdzBLWFQ5?=
 =?utf-8?B?TTlkM2IrNStrN1JFV2lLVkxhOUZMRTBtcFZuNlNxdmVqNUh0MmtwZkRWdnpX?=
 =?utf-8?B?UmRqNzhIbXZGbFdGMzFzckQ3NFhjSCtvdmtMbHMyMWR6RXRvcUIvRnkwcE1E?=
 =?utf-8?B?NWRRK1pSMmNxSm0zeDdCZ2lhb2VWWnRZMURnSDJyK0R1a1pYdzlOMWxISXlv?=
 =?utf-8?B?NGFtQ2lka0s5bDM4RXBVOVplNmJlTzlvL25GWWhkZ3A5d2tuWmQrK0pFZXRL?=
 =?utf-8?B?RHRKcWorTEo0dGFNUjFUZ0hFUG50b2tMYllMODZIOUw2VllLbTA0MTNYMkFr?=
 =?utf-8?B?TERtUlNiWUM5SGtoNU9Odjd4UzRma3BCVGNzQStGeXBKOFA1WFpsandWcFc1?=
 =?utf-8?B?aGxtYlJMZG10NjlPd3Q1emVFY1FoNUQ2a0ora05sdUVxY2tqVFZTd00vT3hC?=
 =?utf-8?B?cEowTzVIcUtQd0hucVl5STBYVExjZmwyM3p4L0JBQjQrQ0VSblM2ZTJDejk0?=
 =?utf-8?B?NVdkWVhsVFNwOWp3bmo3VElWRzlhTVVEVE8rTktPNy9pYUc0MzU1bUQzQjMx?=
 =?utf-8?B?MWFKTzFwVzFjRnVFZ09yc2RqTFdhM3NIcmR2dEJDNEl4UGp2amlsZ2wreFRL?=
 =?utf-8?B?OG42SVl4QWRiVk1KUUM2T2E4dDZheVVuYjVjd3NTOTc0YTBBRGtUS1ZtY1dk?=
 =?utf-8?B?Sk1wNkpPMmRuS1lOZTMrMnVTQUdVM2svS3V5cC9ZM1I1b2dvV01RRk00UnJ6?=
 =?utf-8?B?M2RSUkI4UEIzSGlXU2lUSVN0eVMzZHVQQ05ueGh5RGxxdlZ6cWRyNnVsSWg4?=
 =?utf-8?B?Wkh1RHlreWRSQkZkSnRGbjIrUDlsaGwrYU52UDliVHQrMFNzSlZnUkl2SVJ5?=
 =?utf-8?B?V09CdGZmdW9oanhkK0lwSk5ZR3YrNmNRZG1KelREWkNkcHUvckZGWjZGeTNS?=
 =?utf-8?B?bUhoWVVjNytNN0FoQjVSVVE3SFpIZjZQSzl2aGcvV3RrNGU1Um1yM0ViMnp0?=
 =?utf-8?B?Z2JXN1Y2VFhTcm9SRTJhN3Q5THRZQXhIV1VNM0xFMFl0RkVQMEx2SFlGaU1L?=
 =?utf-8?B?M2hqYnZSM3BWQ2NlL25vQTNyN00xZDlldTVyMzhxREdYQkk4VGtEQUJNbjdC?=
 =?utf-8?B?OUJabHBURnQvZzNsUHVlZUxWNXZSQ0JiVHZtVWd5RjR2V2pLcFl3Q3JzM0dw?=
 =?utf-8?B?RUF5V1Zva2xyOERqOWdtOGQ0ZTZXU3FaZE5pbmNmVFFFbGpKbkZ6Z0J6WW81?=
 =?utf-8?B?VDJETEpRSUs2Y1FDbmpaNXQ3eENDK2w4T3lmNUF2bC9KZDVncWU1b0dDRE1t?=
 =?utf-8?B?akRSL1FmdEpEenhMK3F3TkIyNENDYnhsMW5JOVdRMUxUblIwTGEyYWFuckJO?=
 =?utf-8?B?Uk90ajBZT3BNLzNYdURQMDJ6Zmx1SmdvaHVEU2FCb1NxSnp1a2JvZzF0bHd4?=
 =?utf-8?B?OUx1N1lLVURsL0lRS1dPS2Z6dFRwY3FYSGlrL0VrYWpyMzBIR2o4VnkwaHRI?=
 =?utf-8?B?QkgzWjN6SU4xY1B4NlI4cE5lVVpjWEFKaVQzaEZYS0VPNHBCZEluZFZwOGpn?=
 =?utf-8?Q?Y8udu0jVZw7yjFYqgGcpT/PX38qXagNk+IgXnG1p48tC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C97770497820CC4C8C66ACC316F1991A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 056813d5-9cb6-4626-2265-08dc1327cbda
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 04:34:42.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ryKGzVxDwBrSLOEhOSLDrGGWz4i4K/uou1q9zdi3nN3feIyN1vc5QEgoAPZwlSiVfxZH//a1UtoU0HMgUfM1bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082

T24gMS8xMS8yNCAxNToxNSwgQ2hyaXN0aWFuIEhldXNlbCB3cm90ZToNCj4gVXRpbGl6ZSB0aGUg
JXBlIHByaW50IHNwZWNpZmllciB0byBnZXQgdGhlIHN5bWJvbGljIGVycm9yIG5hbWUgYXMgYQ0K
PiBzdHJpbmcgKGkuZSAiLUVOT01FTSIpIGluIHRoZSBsb2cgbWVzc2FnZSBpbnN0ZWFkIG9mIHRo
ZSBlcnJvciBjb2RlIHRvDQo+IGluY3JlYXNlIGl0cyByZWFkYWJsaWxpdHkuDQo+DQo+IFRoaXMg
Y2hhbmdlIHdhcyBzdWdnZXN0ZWQgaW4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzky
OTcyNDc2LTBiMWYtNGQwYS05OTUxLWFmM2ZjOGJjNmU2NUBzdXN3YS5tb3VudGFpbi8NCj4NCj4g
U2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEhldXNlbCA8Y2hyaXN0aWFuQGhldXNlbC5ldT4NCj4g
LS0tDQo+DQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

