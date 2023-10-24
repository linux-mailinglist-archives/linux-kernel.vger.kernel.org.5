Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662927D44B0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 03:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjJXBPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 21:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJXBPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 21:15:02 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7294DE;
        Mon, 23 Oct 2023 18:15:00 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39NNpPVD008531;
        Mon, 23 Oct 2023 20:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=TBFrBBVWguJjPuUpslpiw5wWohN3HpsR1u0dfOMdb
        qY=; b=m9q2JO0vDGv2gswmGA1zlnf6gVCG34wFLSHCz75SlWfzAsBTpRY5+hQrI
        VYFHLhVC1ktKPHeOfE0PYsWhl+9AeY6omUSmY6N3AsjNJnM9TkrB1oOdgW8Yt4Bv
        cvJmi+vrnP9K9ddDbCdj3RUBQxESB0+CplnSr1dboql5p1eRbIr39bQKv0WKJo8j
        4qaPjb04/srnOJar607PNYDQkPu8nh/+HDcwPTJVorwEU7fVPMoFbnIZ+SRGmWet
        LoZfArIA52Hi8iyg8dPzC6ZA/KgxvQY/s5vC3ekkIzNWI5LCz3XpnPqWgoHh8sQ6
        xop2bmzq1InOVXGw+JGLnt1N7OC9g==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3tvb2j2yrv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 20:14:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEvTHmJjXVek+s7lbszSyw/pNwl/TjVcHwWBCVU3xeK0KNAHCV9JsBV9HelkfZxH/0+io+379C6LOP0EPn9qZ/1XPBhw0WtxF1fY3YFgXVf+EAUuVC1TDmMgPb1FvrpIsS79zGxoEzj1Z0HJO/i2b2/P9fC3pOR5GmbJnRvq+i4drJLNP1Mure7JbH80eqHcVP3K8cMtNqvT4KkKIG+QfKuSbXHHwVtptBt9t5fyzVPI6oDOQi6Ob9astz8IGg5qDRE/HDbOv182MwqlBSY7e/3s9hmxs+v98JMxh4sQP/0k8RxFtpXyhMMVBuMuklElQUbuoBFhB6BZkzV6rwipGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBFrBBVWguJjPuUpslpiw5wWohN3HpsR1u0dfOMdbqY=;
 b=AztrvOjoAXJ2we4S9Z1Zf+csH41CkuzSIqdpdu3r+68rKXLBy11/dU4t6C9K6uaBrCq0Zxy3OwW94lg4XCmrs6rH3f6UqoCSMv8xGkSWT7ptlfnORB6FIdED+qgWMygBlZ5CV1m+YB1gCgRWflZfx/kiP8Z22Zv6FzdV/dVUtj+7YdJYAkzpMjbaeqIGPo/loAzGVliXpfe0oZrd8ND6gC/9nAOyV35HLVKoUQu1Yu1EYT2iMmLaF5XNub8UZd0sCW44ra7fulSd2tBqeMz+M+CHR1tAni+yzbUYQoe8NN1AL0sCZAeI0dXIyYgccPHZJ3HXZtokaU9haSyYh9TfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBFrBBVWguJjPuUpslpiw5wWohN3HpsR1u0dfOMdbqY=;
 b=vPmV5BXNsxRNtCZqWLaqk8r2PCo9p4S7BA7WTpAkncpMZbdKMKa4pCF+dvGiNlKHgl1Va8urnzTiu4PtGvBvupTH1VF9qQk5/4uYR76lavrmEzEv/+06jNlU+mPdlfUvrD6aBgVbVhnk3D6BFSWcfl0xaLL0Ta2Ylzc8zWlMd0Y=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by PH7PR19MB8186.namprd19.prod.outlook.com (2603:10b6:510:2f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 01:14:43 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::8a74:6925:435d:19a5]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::8a74:6925:435d:19a5%6]) with mapi id 15.20.6907.025; Tue, 24 Oct 2023
 01:14:42 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Lee Jones <lee@kernel.org>
CC:     James Ogletree <james.ogletree@opensource.cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Thread-Topic: [PATCH v4 3/4] mfd: cs40l50: Add support for CS40L50 core driver
Thread-Index: AQHaAeyf+2JrjyX4UUi0J9ryDkVps7BRTXqAgAGFxACABE1RAIABCngA
Date:   Tue, 24 Oct 2023 01:14:41 +0000
Message-ID: <DC6C1E91-BC15-47E5-8D94-E468188F58C1@cirrus.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
 <20231018175726.3879955-4-james.ogletree@opensource.cirrus.com>
 <20231019162359.GF2424087@google.com>
 <E3224624-7FF4-48F6-BA53-08312B69EF9F@cirrus.com>
 <20231023092046.GA8909@google.com>
In-Reply-To: <20231023092046.GA8909@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|PH7PR19MB8186:EE_
x-ms-office365-filtering-correlation-id: a0e2f92b-f0e6-4030-5efa-08dbd42e9999
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D3omZiTG9V2bX1bwkBLIKWaxcE8EcNt+/tzqAjNOPOMnOCgNFpAP7zSAuiMk16nG9ULEewrNbPvgypMSJQJRRfj4FwT8Xf6Wo7mxg40F3qvNGPN1V7Q1yTeG2ZpRU0Lg6WQ76adL1zL8h8VxgWi954AQf2DQjlTDp78DYKL+UQzLqP4zgQVr93Cc49YtUzTsYrrzZboJ6rmIViTe5ZDG914nSUo3CEOHkzzQhtsh7mozTaQgbDKlNsDXNo6JOF0yxj1YlbMQRzKB6wJX9Fid1zuzIxmio0KcohkUvrD7cnvyTopDvgTEsFq7VmsklPT9wfMwjIWgiyg0R5CrVKdoWWMrBN11Z7D2ZUGVCXao1ejf09s+FjavRN+z4WtLrlRT5NamegbrFidRmg3JG5K2Te/L3YWL8OLXDYsHURhhKJJsydMa7v1ra+PG86fyyvD5YKagJDIenSRUf0GJnY0qDBALoUgKEIcNuh7U/mMWCKebmPTF4fZnqGWqXVLT7XifV6BP8OlOJg4knz3hJd6Sl2MNAlGXJXbS/xTpdrTuwZjV2MvKSstRB0CV3ZurRc9m+IeA3D4BmYpyWG9op886nGnVaKMqlxUdOftg2kTc8zjvRmo3IKnWbmh+sGeK1I93l0JPGdPHbj2Wnd2SNR/dPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(366004)(346002)(396003)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(26005)(38070700009)(38100700002)(41300700001)(2906002)(86362001)(36756003)(5660300002)(8676002)(8936002)(4326008)(33656002)(2616005)(71200400001)(478600001)(6506007)(66946007)(66476007)(54906003)(64756008)(122000001)(76116006)(316002)(6916009)(66556008)(66446008)(91956017)(83380400001)(53546011)(6486002)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDRYUThkeWd5TWc1SVVBejN1MzJwSzcvV2NsbTRlS0xNL2pKVmUwdFFpMFAv?=
 =?utf-8?B?QkozUmtTTGZTZ1N6eW5XYmh4S3d1V2hPVUxlVk5EYzRnSER0LzhLa2ZrZ2o1?=
 =?utf-8?B?bUV3WWlIVU5XN0pMVitEK3BiN3NZcjZKQTVrT29aQUFaWlhOOHcwaGJNcmlr?=
 =?utf-8?B?Rnk3cGdMYUgyTVBwbjZPS1FLcTBhY0VRK01CMXlpUXR5UkZSbWtTdy9LbnI0?=
 =?utf-8?B?SGxTTTR6ZHNaaGFFbU5OMFE0QnVwc01GWDJXYTc4UkZrNmpWTi9wVHQvSnRQ?=
 =?utf-8?B?bHAwL3hSRmhwT2t1cEZxbU43Y0xUYmV6bi9FeWFOQlk2WlIwaFRsSUdYRmpC?=
 =?utf-8?B?QnJ3QWU4Qlo4a1VkL3J1QmhlYXVUQUgxdlIzeS9ocytjcHl5T2J1Smh4UEIx?=
 =?utf-8?B?SG9QdEkvNGNTcFQ4dEpNeEhYOVo1Vkd4RkNwRHAvWmRYRUs5SmVWWmhQU2dO?=
 =?utf-8?B?aDJCNWtzd1NoUzJ6ZWNtSTdvSUEwbGhtcGh3RUVpbjRZcWtkaWRVY0lVRXdI?=
 =?utf-8?B?a3d6MWdnaGIxb0grR0NUeEZ1emZhaFRjV045Wi9SQXdoWlZ1a3hUTTREUzRD?=
 =?utf-8?B?eUlWTXlITHRUUG9PQVo5L0hHUTBTQUFBdkxOSGpXWGtFU096M0NtQW9XaGg1?=
 =?utf-8?B?cDF5R1ZBYjQ5WnMwaFA1R2Rwb1ZKS1QralNNdW1FN3JROE4zSGpaMEdlMVA3?=
 =?utf-8?B?eXgzbjV4QUxwZ3JPU1lDeDZVYWdQSW9tUzh0eDVjVUtwd1J0d1p4QkFXZThT?=
 =?utf-8?B?ZTdGV1dWV2c5WTgzaE54YkM0UFQxMnFKN2ZaYkVSKzhndWN3amV2VjQxQzYx?=
 =?utf-8?B?R2N0L0ZadWZheGs0TUFjd0RQa3VLRlBCb0plV3FqOS9sRU90UTIyR2x3dlIv?=
 =?utf-8?B?d0RqQmQyZ1JQQjd1QVRXdHhpMXBxbXYvNnJtdHR5cUswTlViMnEvcFhLTXVM?=
 =?utf-8?B?Sm1RNXl0NEFyTWpvZStTZ2J3R00wdDZ4M3h5TkEraDVqbEVjNkgzUmhZU2Yr?=
 =?utf-8?B?bTdlS2tRYk92ek14S1l4cnhWaU9paUdOdjdaWUllOVl0TkpJNDZtdFdWOFZF?=
 =?utf-8?B?OFpqLzgvQ0FJbmYyc0F0UGpFcm95QmdxcGVHZWRsZVE5cDRCT0RCNDU1a2Rr?=
 =?utf-8?B?cC9VVThORTY3TkduZkE1eDNtUkJiYnZDWXU2U01DdnMrYkpJVXcvazlmOEtk?=
 =?utf-8?B?QTd2VFp2Tzh4N1pCUVZvRkM2WnZVd29FQWtZWDdLem82ZzNuUGU5UDNLM3dt?=
 =?utf-8?B?YXhEcTN2ckVrK3orR09VRkhuNTlsQkhFV0hkQTEvUHZXaDdaSHMxamk4V0lH?=
 =?utf-8?B?eE5rc2hOOGQ0L1dSMitOYmNWZU1LcU52NU0wSE9OczFwMis1UUZTRXl6dkZv?=
 =?utf-8?B?cXlnRE5BTXpaSC90NUZLVWk1WEo4ZlVnMWR2UWJwdXFUNTQ4OW4yKzJZUXZB?=
 =?utf-8?B?alBjZUpnMFJjYTN4RGhiQ2ZHM0Jpak45Tms3dlB6L0JTRzU2U2NuZ3MraEIy?=
 =?utf-8?B?cmFlOFVIQkhnZld0b0RGSUlzYkF4UHBmaDJuS1BnazZXT254bGwwRDdZNXVG?=
 =?utf-8?B?UU5qMU00SHl5L0RCaU1vaUVIM1BuTmNTWUZYK2FoWWVjTjh2U3VPSXRNK3VJ?=
 =?utf-8?B?dzdvOHFoY25pWVJXYkxycGRZREQ0WjZsM0laWjY4SmhjekRsMVduU0c3dXJq?=
 =?utf-8?B?eTFjSWptVXlkVVlxTEtpZzB5TXNuVGVDbFR2dXduVzF3MHFXYWlZa29MSzFF?=
 =?utf-8?B?MFB0TXFMTXpkTXllb3kwZHFublBEcmdrNExKem4wUmtFR2t1NjNvbWhPcXhX?=
 =?utf-8?B?V0NPWkI3ejVIbnFyZW9LWVJmRDZSOXNIU1dxaVNEMUp6eWhSZG9hMzlpaG5K?=
 =?utf-8?B?dDVLdUxHRTNlNVlFSUxTQzg0K2V3ZXhkMVcreU9USzFVLzM4c2p0MGpZT1Va?=
 =?utf-8?B?a0NXQm5QYkY3RTFkUkdPS0lZNWR1cjNOMTRBT3FRd3dGbEdpWThMeUR4bHF6?=
 =?utf-8?B?bk9GTkxBNFlYVVpSVmZMSGNzbTI0L0VZSXkzNGNQTnlYMUdITG5zZnNNUWpQ?=
 =?utf-8?B?Qld2Q2NZeWpuNjkzMG5ITkVqUHE0KzFmR0Y4V3BVUUVFMWZiYU1ydCtaMWh0?=
 =?utf-8?B?aEZsY2kwdGpISGhBYnAxSlR1eStqdVhJaEhrWVpCK2F3YW5WZkk0STN6SkY0?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1DA8C17A8D19A40891DFD0A0790D08E@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e2f92b-f0e6-4030-5efa-08dbd42e9999
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 01:14:41.3179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YvbW+AuZvj2vB4UVc7EmxWZ+FCu3SbFracLsqBixYmfYWBoZgumMIOpaX/8GaVx/KaLL0JkmUv/UVbUTMDnvX1od/speKGRPqCcgfURfGfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB8186
X-Proofpoint-GUID: C-tlzRx4bNYNWKW4UT4jbvBDIEm0nFoc
X-Proofpoint-ORIG-GUID: C-tlzRx4bNYNWKW4UT4jbvBDIEm0nFoc
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpBbnkgY29tbWVudCB0aGF0IHdlbnQgdW4tcmVwbGllZCB3aWxsIGJlIGFkb3B0ZWQgaW4gdGhl
IG5leHQgdmVyc2lvbi4NCg0KPiBPbiBPY3QgMjMsIDIwMjMsIGF0IDQ6MjAgQU0sIExlZSBKb25l
cyA8bGVlQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyMCBPY3QgMjAyMywgSmFt
ZXMgT2dsZXRyZWUgd3JvdGU6DQo+IA0KPj4+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBtZmRfY2Vs
bCBjczQwbDUwX2RldnNbXSA9IHsNCj4+Pj4gKyB7DQo+Pj4+ICsgLm5hbWUgPSAiY3M0MGw1MC12
aWJyYSIsDQo+Pj4+ICsgfSwNCj4+PiANCj4+PiANCj4+PiBXaGVyZSBhcmUgdGhlIG90aGVyIGRl
dmljZXM/ICBXaXRob3V0IHRoZW0sIGl0J3Mgbm90IGFuIE1GRC4NCj4+IA0KPj4gVGhlIGRyaXZl
ciB3aWxsIG5lZWQgdG8gc3VwcG9ydCBJMlMgc3RyZWFtaW5nIHRvIHRoZSBkZXZpY2UgYXQgc29t
ZSBwb2ludA0KPj4gaW4gdGhlIGZ1dHVyZSwgZm9yIHdoaWNoIGEgY29kZWMgZHJpdmVyIHdpbGwg
YmUgYWRkZWQuIEkgdGhvdWdodCBpdCBiZXR0ZXIgdG8NCj4+IHN1Ym1pdCB0aGlzIGFzIGFuIE1G
RCBkcml2ZXIgbm93LCByYXRoZXIgdGhhbiBhcyBhbiBJbnB1dCBkcml2ZXIsIHNvIGFzDQo+PiBu
b3QgdG8gaGF2ZSB0byBtb3ZlIGV2ZXJ5dGhpbmcgbGF0ZXIuDQo+PiANCj4+IFNob3VsZCBJIGFk
ZCB0aGUg4oCcY3M0MGw1MC1jb2RlY+KAnSBtZmRfY2VsbCBub3csIGV2ZW4gdGhvdWdoIGl0IGRv
ZXMgbm90DQo+PiBleGlzdCB5ZXQ/DQo+IA0KPiBXaGF0IGlzIHlvdXIgdGltZWxpbmUgZm9yIHRo
aXMgdG8gYmUgYXV0aG9yZWQ/DQo+IA0KPiBEb2VzIHRoZSBkZXZpY2UgZnVuY3Rpb24gd2VsbCB3
aXRob3V0IGl0Pw0KDQpXaXRob3V0IHRoZSBjb2RlYyBjb21wb25lbnQsIG9uZSBtaW5vciBmZWF0
dXJlIHdpbGwgYmUgbWlzc2luZywgYnV0DQp0aGUgZGV2aWNlIHdpbGwgaGF2ZSBubyBpc3N1ZXMg
ZnVuY3Rpb25pbmcuDQoNClRoZSBjdXJyZW50IHRpbWVsaW5lLCBhcyBiZXN0IGFzIEkgY2FuIHNl
ZSBpdCwgaXMgMy02IG1vbnRocy4NCg0KPiANCj4+Pj4gK3N0YXRpYyBpbnQgY3M0MGw1MF9oYW5k
bGVfcmVkY19lc3RfZG9uZShzdHJ1Y3QgY3M0MGw1MF9wcml2YXRlICpjczQwbDUwKQ0KPj4+PiAr
ew0KPj4+PiArIGludCBlcnJvciwgZnJhY3Rpb25hbCwgaW50ZWdlciwgc3RvcmVkOw0KPj4+IA0K
Pj4+IGVyciBvciByZXQgaXMgdHJhZGl0aW9uYWwuDQo+PiANCj4+IFdlIHJlY2VpdmVkIGZlZWRi
YWNrIHRvIGNoYW5nZSBmcm9tIOKAnHJldOKAnSB0byDigJxlcnJvcuKAnSBpbiB0aGUgaW5wdXQN
Cj4+IHN1YnN5c3RlbSwgYW5kIG5vdyB0aGUgb3Bwb3NpdGUgaW4gTUZELiBJIGhhdmUgbm8gcHJv
YmxlbSBhZG9wdGluZw0KPj4g4oCcZXJy4oCdIGhlcmUsIGJ1dCBpcyBpdCB1bmRlcnN0b29kIHRo
YXQgc3R5bGVzIHdpbGwgYmUgbWl4ZWQgYWNyb3NzDQo+PiBjb21wb25lbnRzPw0KPiANCj4gVGhh
dCBzdXJwcmlzZXMgbWU6DQo+IA0KPiAlIGdpdCBncmVwICJpbnQgLiplcnJvciIgfCB3YyAtbA0K
PiA2MTUyDQo+IA0KPiB2cw0KPiANCj4gJSBnaXQgZ3JlcCAiaW50IC4qZXJyIiB8IGdyZXAgLXYg
ZXJyb3IgfCB3YyAtbA0KPiAzNDc1Mw0KPiAlIGdpdCBncmVwICJpbnQgLipyZXQiIHwgd2MgLWwg
IA0KPiA3NjU4NA0KDQpVbmRlcnN0b29kLiBJcyBpdCBwb3NzaWJsZSB0aGF0IOKAnGVycm9y4oCd
IGlzIGEgcmVjZW50IGFkb3B0aW9uPw0KUmVnYXJkbGVzcywgSSB3aWxsIGdvIGFoZWFkIGFuZCB1
c2Ug4oCcZXJy4oCdIGZvciB0aGUgTUZEIGRyaXZlci4NCg0KPiANCj4+Pj4gK3N0YXRpYyBpcnFy
ZXR1cm5fdCBjczQwbDUwX3Byb2Nlc3NfbWJveChpbnQgaXJxLCB2b2lkICpkYXRhKQ0KPj4+PiAr
ew0KPj4+PiArIHN0cnVjdCBjczQwbDUwX3ByaXZhdGUgKmNzNDBsNTAgPSBkYXRhOw0KPj4+PiAr
IGludCBlcnJvciA9IDA7DQo+Pj4+ICsgdTMyIHZhbDsNCj4+Pj4gKw0KPj4+PiArIG11dGV4X2xv
Y2soJmNzNDBsNTAtPmxvY2spOw0KPj4+PiArDQo+Pj4+ICsgd2hpbGUgKCFjczQwbDUwX21haWxi
b3hfcmVhZF9uZXh0KGNzNDBsNTAsICZ2YWwpKSB7DQo+Pj4+ICsgc3dpdGNoICh2YWwpIHsNCj4+
Pj4gKyBjYXNlIDA6DQo+Pj4+ICsgbXV0ZXhfdW5sb2NrKCZjczQwbDUwLT5sb2NrKTsNCj4+Pj4g
KyBkZXZfZGJnKGNzNDBsNTAtPmRldiwgIlJlYWNoZWQgZW5kIG9mIHF1ZXVlXG4iKTsNCj4+Pj4g
KyByZXR1cm4gSVJRX0hBTkRMRUQ7DQo+Pj4+ICsgY2FzZSBDUzQwTDUwX01CT1hfSEFQVElDX1RS
SUdHRVJfR1BJTzoNCj4+Pj4gKyBkZXZfZGJnKGNzNDBsNTAtPmRldiwgIk1haWxib3g6IFRSSUdH
RVJfR1BJT1xuIik7DQo+Pj4gDQo+Pj4gVGhlc2UgYWxsIGFwcGVhciB0byBiZSBuby1vcHM/DQo+
PiANCj4+IENvcnJlY3QuDQo+IA0KPiBUaGVuIHdoeSBkbyB0aGUgZXhpc3Q/DQoNCkluIG15IGp1
ZGdtZW50IGl0IGFsZXJ0cyB0aGUgdXNlciBvciBkZXZlbG9wZXIgb2YgYW4gaW1wb3J0YW50DQpl
cnJvciwgYW5kIGluIG90aGVyIGNhc2VzIGl0IGdpdmVzIHRoZW0gaW5zaWdodCB0aGF0IGlzIHVz
ZWZ1bCBmb3INCnVuZGVyc3RhbmRpbmcgZmlybXdhcmUgYmVoYXZpb3IuIElzIHRoaXMga2luZCBv
ZiB2aXNpYmlsaXR5IG5vdA0KdHlwaWNhbD8gUmVnYXJkbGVzcywgSSB3aWxsIG1vdmUgaXQgb3V0
IG9mIE1GRCBmb3IgVjUuDQoNCj4gDQo+Pj4+ICsgY2FzZSBDUzQwTDUwX01CT1hfUlVOVElNRV9T
SE9SVDoNCj4+Pj4gKyBkZXZfZXJyKGNzNDBsNTAtPmRldiwgIlJ1bnRpbWUgc2hvcnQgZGV0ZWN0
ZWRcbiIpOw0KPj4+PiArIGVycm9yID0gY3M0MGw1MF9lcnJvcl9yZWxlYXNlKGNzNDBsNTApOw0K
Pj4+PiArIGlmIChlcnJvcikNCj4+Pj4gKyBnb3RvIG91dF9tdXRleDsNCj4+Pj4gKyBicmVhazsN
Cj4+Pj4gKyBkZWZhdWx0Og0KPj4+PiArIGRldl9lcnIoY3M0MGw1MC0+ZGV2LCAiUGF5bG9hZCAl
I1ggbm90IHJlY29nbml6ZWRcbiIsIHZhbCk7DQo+Pj4+ICsgZXJyb3IgPSAtRUlOVkFMOw0KPj4+
PiArIGdvdG8gb3V0X211dGV4Ow0KPj4+PiArIH0NCj4+Pj4gKyB9DQo+Pj4+ICsNCj4+Pj4gKyBl
cnJvciA9IC1FSU87DQo+Pj4+ICsNCj4+Pj4gK291dF9tdXRleDoNCj4+Pj4gKyBtdXRleF91bmxv
Y2soJmNzNDBsNTAtPmxvY2spOw0KPj4+PiArDQo+Pj4+ICsgcmV0dXJuIElSUV9SRVRWQUwoIWVy
cm9yKTsNCj4+Pj4gK30NCj4+PiANCj4+PiBTaG91bGQgdGhlIGxhc3QgdHdvIGRyaXZlcnMgbGl2
ZSBpbiBkcml2ZXJzL21haWxib3g/DQo+PiANCj4+IEFkb3B0aW5nIHRoZSBtYWlsYm94IGZyYW1l
d29yayBzZWVtcyBsaWtlIGFuIGV4Y2Vzc2l2ZSBhbW91bnQNCj4+IG9mIG92ZXJoZWFkIGZvciBv
dXIgcmVxdWlyZW1lbnRzLg0KPiANCj4gTUZEIGlzbid0IGEgZHVtcGluZyBhIGdyb3VuZCBmb3Ig
bWlzY2VsbGFuZW91cyBmdW5jdGlvbmFsaXR5Lg0KPiANCg0KPiBNRkQgcmVxdWVzdHMgcmVzb3Vy
Y2VzIGFuZCByZWdpc3RlcnMgZGV2aWNlcy4NCj4gDQo+IE1haWxib3ggZnVuY3Rpb25hbGl0eSBz
aG91bGQgbGl2ZSBpbiBkcml2ZXJzL21haWxib3guDQoNClJvZ2VyIHRoYXQuIE1haWxib3ggZnVu
Y3Rpb25hbGl0eSB3aWxsIG1vdmUgb3V0IG9mIE1GRCBmb3IgVjUuDQoNCj4gDQo+Pj4+ICtzdHJ1
Y3QgY3M0MGw1MF9pcnEgew0KPj4+PiArIGNvbnN0IGNoYXIgKm5hbWU7DQo+Pj4+ICsgaW50IGly
cTsNCj4+Pj4gKyBpcnFyZXR1cm5fdCAoKmhhbmRsZXIpKGludCBpcnEsIHZvaWQgKmRhdGEpOw0K
Pj4+PiArfTsNCj4+Pj4gKw0KPj4+PiArc3RydWN0IGNzNDBsNTBfcHJpdmF0ZSB7DQo+Pj4+ICsg
c3RydWN0IGRldmljZSAqZGV2Ow0KPj4+PiArIHN0cnVjdCByZWdtYXAgKnJlZ21hcDsNCj4+Pj4g
KyBzdHJ1Y3QgY3NfZHNwIGRzcDsNCj4+Pj4gKyBzdHJ1Y3QgbXV0ZXggbG9jazsNCj4+Pj4gKyBz
dHJ1Y3QgZ3Bpb19kZXNjICpyZXNldF9ncGlvOw0KPj4+PiArIHN0cnVjdCByZWdtYXBfaXJxX2No
aXBfZGF0YSAqaXJxX2RhdGE7DQo+Pj4+ICsgc3RydWN0IGlucHV0X2RldiAqaW5wdXQ7DQo+Pj4g
DQo+Pj4gV2hlcmUgaXMgdGhpcyB1c2VkPw0KPj4+IA0KPj4+PiArIGNvbnN0IHN0cnVjdCBmaXJt
d2FyZSAqd21mdzsNCj4+PiANCj4+PiBPciB0aGlzLg0KPj4+IA0KPj4+PiArIHN0cnVjdCBjc19o
YXAgaGFwdGljczsNCj4+PiANCj4+PiBPciB0aGlzPw0KPj4+IA0KPj4+PiArIHUzMiBkZXZpZDsN
Cj4+Pj4gKyB1MzIgcmV2aWQ7DQo+Pj4gDQo+Pj4gQXJlIHRoZXNlIHVzZWQgYWZ0ZXIgdGhleSdy
ZSBzZXQ/DQo+PiANCj4+IFRoZXNlIGFyZSBhbGwgdXNlZCBpbiB0aGUgaW5wdXQgZHJpdmVyLCBw
YXRjaCA0LzQgb2YgdGhpcyBzZXJpZXMuIElmDQo+PiB0aGlzIGlzIG5vdCBhY2NlcHRhYmxlIGlu
IHNvbWUgd2F5LCBJIHdpbGwgY2hhbmdlIGl0IHBlciB5b3VyDQo+PiBzdWdnZXN0aW9ucy4NCj4g
DQo+IERvIHRoZXkgbmVlZCB0byBiZSBzaGFyZWQgd2l0aCBvdGhlciBkZXZpY2VzPw0KPiANCj4g
SWYgbm90LCB0aGV5IHNob3VsZCBsaXZlIHdoZXJlIHRoZXkgYXJlIHVzZWQuDQoNCmRldmlkIGFu
ZCByZXZpZCBhcmUgc2hhcmVkLCBidXQgdGhlIG90aGVycyBhcmUgbm90LiBJIHdpbGwgbW92ZSB0
aGVtIHRvDQp0aGVpciBwcm9wZXIgaG9tZSBpbiBWNS4NCg0KQmVzdCwNCkphbWVzDQoNCg0K
