Return-Path: <linux-kernel+bounces-26516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A18B82E284
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673C91C21FA7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 22:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB921B5AC;
	Mon, 15 Jan 2024 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JIs35CAr"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19EC1B594
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 22:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBqMei+besKrp8o7jQo5H+yXaCUbqhkJHEb0fnDQi+PUJAS6+qfkxqgU0FMFtbl61pzSrJe8zJ6e62/hlypCe2LjeubZRR2eNqN2vGjC4tEc4XjRmwGbArZzTdtsT/rd5Cxg5g+KhJq6r3ZiXOlneS19ihOFkIh38Xbv24viC1hV6E9xqk1wuZzJhpPMismawRL9XfnhavauLMQ6FQOJc+g0LgLnTinpCMoNRf5cn6utEhaMqzNJCSyqTt4JfeTUTiNvDT+PMQFfiuwh6IMUfLK+Y3fq/9KTsumyuyZmNQuOW3p+JM2hRtp4Fw82WbVnlYArwOpBGyvhyEyviVQorQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcopmWtmMCH8X+j/MARcFexlGZH4XRb7EfSKKH9TfpI=;
 b=HSMvqWO4oWthQOW16Z/3fHe73FJ6PRNRIWvZtwOKqYkjTcURHqfcBdXqpRo8uffJ4lB3mh/x7mTg5Tp7C6CvWQd1cDcytO6t/p+rSfQ8WWClTpu3EcymNCoN5WggvHt7Fp/Gu62llA1Cnp4xqPSLnb1CtvvHf/ocgRgvkKs9VNX4G4EgpikansHp/aP3STrVKZqhVzIwsj6AVSYAfTCsa3YH/SkB7r/AqDFrMA+XFERFtCVl8VruJ6Ktx3osnmaCyBip3Sen/cuO97Gm5aXjvqH5N1h7kI7KmC5UeSm2RLQlZQ/QrgJrjKye15N9ISWVE0dowFEsvsyhMCIBH4cXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcopmWtmMCH8X+j/MARcFexlGZH4XRb7EfSKKH9TfpI=;
 b=JIs35CArE397HTHM8OS9C8qIgI9HH9zpirK7PCKVxh51ttJN6/CyMBWBrr+3X8Lc7uvM5z6+GR+udhc/BalWLEP4l2X/0NEflcq7OdBleHHVftSq2gG/XnIwlDnUxK25TuS5fyi7Vy8sBXfWtbdEyR67uyCGaJyVjLVZ7vVL4XFacd2yLN5HkbZku30+YeTh4A5vP5phyfBDWXc6Oz4JEXexPjT41ci0dM2jCPICEgfcJ7SSPwg9lamEPcr1d76ZCSU1fv3sgjAkJWABP5QmmM4zedEkjbyf2CjSwO1Qm29Zg+xvkc8ku8b+FhdIs/QIEIuuEUlyyAyFT5ziGVFSHQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA0PR12MB9012.namprd12.prod.outlook.com (2603:10b6:208:485::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 22:21:31 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7181.018; Mon, 15 Jan 2024
 22:21:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: mengfanhui <mengfanhui@kylinos.cn>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH] nvme/auth: optimize code redundancy and provide code
 quality
Thread-Topic: [PATCH] nvme/auth: optimize code redundancy and provide code
 quality
Thread-Index: AQHaR3+3CIbqlQixikeiAyuDhyxwSrDa1CmAgACfNoA=
Date: Mon, 15 Jan 2024 22:21:30 +0000
Message-ID: <a60bf7f7-e520-400a-ae68-73f448f0e3f9@nvidia.com>
References: <20240115065231.12733-1-mengfanhui@kylinos.cn>
 <4ad9d0a8-00b6-4970-9127-ccbe1d2f26bf@grimberg.me>
In-Reply-To: <4ad9d0a8-00b6-4970-9127-ccbe1d2f26bf@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA0PR12MB9012:EE_
x-ms-office365-filtering-correlation-id: 7198286d-c3de-49cb-7e47-08dc161852c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 l2X5erMELGBWYAsbHD+AiZ0B5itVpFQCykkk8OJZMmnJ8UpFgLuF/Lc3SxEX5C4SWpHtJAZdl3xKZHaS22naU66RxkzuLFkPuD5rvwRsCCX1fDIiLC3J8hIacZWaZxuxpnGzJRSa83UmdbI50OUQZagbMwVOkDK8M0Rz8W4RknyPvd7FHCzhrb2y0dVkwozLeWF3GBLQ5xfqhKE63305btSU8nY2RW+eXPQWfjtmw2P1/DvovuTN/Y9IoX9KtyykQ9XZkl2xyYPncK4K1w7I1puXxGKA1llM5SP3UuepcdwjFSrVincbCtGJcLNAAGJEPg+Mvjl0YO6HYNNYIvr6XnfoZcsvIq3E1XgBEymAHwYfPL0ZXWW/unvRtUyT0FGlTBPMkENp4sOnAhU7H6E4CkLSbfkqxedonc4cmKPFxjsquY0aZbDulxDyRqc/lL12bTgiuvKex/f069cz5Q1xRp/ZTeZ/21KI3hhFDU/NMyEuYAoaADCfjWWdXX6g9x+MqKzUU03Dyp1KvAXyo77MnIpEIKy7ULdIb6Iy+Xcb7SuEsHY3DPh2TPef3X1bUz+9xIIZ04Xh3gRwfw0uemYcfMUzu+8o3JpgluxIY3fRLP+7Xj3BVJ5k8O3dkoI6/eRHxfoi6czZmqeFVU1TeRoE1k3BUCzB7SmsaJ/sghdEgS1Ek/3mJCFbcUWEvjuUjiqG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(31686004)(36756003)(6486002)(38070700009)(66946007)(558084003)(64756008)(31696002)(66556008)(76116006)(66476007)(66446008)(6512007)(6506007)(122000001)(478600001)(86362001)(38100700002)(91956017)(8936002)(5660300002)(2616005)(26005)(6916009)(8676002)(41300700001)(4326008)(71200400001)(2906002)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TEQ5VzBGUk9SZ1BhRzdablRISnlLWDdBdWg1SndoNlhoZ28zRmtDcTBxMWM1?=
 =?utf-8?B?ODFGaFRhZUYzbTlWUjNyaHZIeWpaNXpKdEVMVXZPc1VMbGl1T2phSkJBY0JD?=
 =?utf-8?B?ZkpFSmxCN2s3UVBYWWJUMGZLSURKcHEydWpDL3l0QXkvSWgwS0dtSGJ4RFJy?=
 =?utf-8?B?enU1OVYvaVVSTE1NUVllSXBwOElHYmNqM1Z4S0ZWeTRuSlVEbldtN1FjZTZ5?=
 =?utf-8?B?dkhWUkIrQXNFYjdqMWdNWGkzV002MFlnNFNyTXA4bk15NWdVZnIvSzBTUFpV?=
 =?utf-8?B?cUFVV0ovN0ozNDNmRXJ1SWgwU2E5LzlETUIyMG5PRHN6eDA3c0lyZngwWk12?=
 =?utf-8?B?blF5SDAzZzVhc1NDZVIySFdRVktFQ2tNQnJqMnROSnBDNUJKWkJjNXR1b0tE?=
 =?utf-8?B?YVJXZUhzRjRYZktsU2xmc0pFc2VqcDF0VTFZNUxCT2txMVFtQlRETnRDU25a?=
 =?utf-8?B?eEpnSEF5bFduQXVoak9zTWtCeGJLVGVBSnh6UU5RQ3lFUSt3WDdwZ3ZDeFA1?=
 =?utf-8?B?Z1V6SlVWYlE4VEZUb0pGK05pWEgwY2FlMVVHbTlxd0tGY3FBamx5VXQvb3cr?=
 =?utf-8?B?YkJVN2xHNmE2cys5UmpwSlo5bnNoRkpsQjg1QkpGbjVaOVI0a0dUcmc1NFVF?=
 =?utf-8?B?MGFkVXZscTdWMGFnbDhhcGNvL2x2L0ZYYkxaRXMrOTd5VzJPRWpMM2svWE9P?=
 =?utf-8?B?Y2hyZU1SOEhQdHBsYkRMbEl6QWxTZ1crTW8zb3NramlhcFdmUXN0aDcrMVhS?=
 =?utf-8?B?NGMvSnZtRHF2VkJmVSsydTEvOGlESmcxcFJQN0lobTVOaDJ2czZTYlovQ3pS?=
 =?utf-8?B?K1d6S3FxTjBCMnVtZFpQSVlTZUhxeDRTZlR5UVFPNFczY2MwRWtkNkd5OEJE?=
 =?utf-8?B?alFsVUpyMmloMnNSd3ViNDlPdkxuR1FqSjZ1WDJuNTAxM0REWTcyaCtQSGxJ?=
 =?utf-8?B?Q1ZkK2tVZ0dnaUZjTFJvY244dVJPMlpzUWo4ZUlNQWxKTUs2VlF4N0pIdlk3?=
 =?utf-8?B?VXJ5amxBWGg0MzY3bldpQUozR0pYREhlRHF0MGV3bWNlTlVZSEx6SytGRDF1?=
 =?utf-8?B?eGVlTHNJQTcxQjAvQlpIK3BiNlF6OWcySWZSbFFQMTR0ZitxaUtobzdPeGdr?=
 =?utf-8?B?eCs0VEtpbnlHQTNxNEdJaWEwalZsRDlGUVdoSlY4UWd5TC9LQjNIc0VBTEVP?=
 =?utf-8?B?ZE0zREx1OUhQRm5lVnY1QVNOS1JlcHkwcURBK0lBV0dBY0ZZZng3RzZnb2Zm?=
 =?utf-8?B?NFZlODlqa1gyZW03bndMU2xTQnE0S0d2UkdtQ2FQZWd3eWU3VFdiclNUQ1Fk?=
 =?utf-8?B?RzRxd2xvamJUTXQzN0lDVmk2S2V2MkFkSHNJZnE4K04zMUpJaVZieTVDM2JE?=
 =?utf-8?B?akdHYzBqMGkxYnJMNm5IWlZubjBZUi92QVQydi9RUVJpVzRhRUF3WnZnOUl3?=
 =?utf-8?B?VFBOWkwyeUxTSmNtVm1IOTNsbks5L3gyRERxcHU2UDJtTTdlbkoyK1MwdWVw?=
 =?utf-8?B?MTBoVUJXY1Jlb3FrUk1OOTFLdU1MY2JRd1RkT2IyUEV3SHdwWHZxUUJjK0Y3?=
 =?utf-8?B?bmFyRU96NXVRdHpMMktMakxKTkp3TXpidldlNTNPaUtqZjZ4cWxKc3dMd1VJ?=
 =?utf-8?B?bkVFcUwyQkVYVkYvSmI3b3BOekdMaStnVEFvdE9pbXlPdXZwYy9NSUNtZ2ZI?=
 =?utf-8?B?ODAyRGNTdHEvL0pvYWUwOEZtOVF5eDR4azc2a1lVV01kVmxzNmlOZ2lBaXpD?=
 =?utf-8?B?SmF3ci9WNGlueFdkbGtQSWVJbm1Lc3hWRWxhSVNsRTFsUFNRZ21OZmFZb05p?=
 =?utf-8?B?RFE2bm9UMnVxVGtpM1RPTnUzc3NtSDZPalViSW5OV2xTbm1tLzd4aTdlakJx?=
 =?utf-8?B?SEJEYXd3aEJlWDFBaUlKcUpaN2NXRWQxbkQweGc0TUtScExoWjRxSXFkRkgy?=
 =?utf-8?B?anZUZTJzOFZCUGZOc1lrV3pud2ZBTStiVFVxR3dGNTJSQnZkYWU1bUdHa0Z4?=
 =?utf-8?B?MVFpanFKUTduOG5IS2ZFbzBnVS9sN3B4b2lGQ2RTYmIyekRoaXNuNytQVzdq?=
 =?utf-8?B?bzJUSDJueHEvTktZeHIzYzFXZ0JWWkJxNU5YRzBGcWE2YklxNitqUnpmQm1O?=
 =?utf-8?Q?mG8B9/aQSgAWiGMG6I0FvWjje?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F9BE269A0A12049A2A9433493FF7D52@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7198286d-c3de-49cb-7e47-08dc161852c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 22:21:30.3038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3rJjA6KfBSTpWXhwPXD2GMxHgRLY4JAs9upEgh4SW53kb2iszCfRUfgZzYMz/Fz0uNS0eB8nHt9/ab0SZHROA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9012

DQo+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHRyYW5zZm9ybWVkX2tleSA/IHRyYW5zZm9ybWVk
X2tleSA6IEVSUl9QVFIoLUVOT01FTSk7DQoNCkkndmUgcmVjZWl2ZWQgbWFueSBjb21tZW50cyBh
Ym91dCBub3QgdXNpbmcgPzogaW4ga2VybmVsIGNvZGUgYXMNCmlmIC4uIGVsc2UgaXMgcHJlZmVy
cmVkIHdheSwgbm90IHN1cmUgaWYgdGhpcyBpcyBhIGdvb2QgaWRlYQ0KDQotY2sNCg0KDQo=

