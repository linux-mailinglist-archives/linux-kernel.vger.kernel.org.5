Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1891177D633
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 00:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240434AbjHOWeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 18:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240505AbjHOWdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 18:33:51 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A36ECE;
        Tue, 15 Aug 2023 15:33:44 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37FLlqhv000890;
        Tue, 15 Aug 2023 17:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-id:content-transfer-encoding:mime-version;
         s=PODMain02222019; bh=yuVhO+gpyQzH9+qNdfGhCnCEUKtmOiPvZl4XpuHuq
        2Q=; b=WEZ7cOrRcVz9dbgdBDXk3UyfgVTUwlkZ8LtenDQ3/cSubehobb360v+8/
        miNjWmzSkIZimJe/ycAMfmwl6PaSSAhf3D1xhV0Wkco1vd2Q5zXCtL2urH7jZNl+
        xpn5jNcJDayXWsmwMS1LOejkPsx8p9d6JX3Yixj8bYk5N8v/PyoHYykuOvUIj3+j
        49JmTAZgz9RdK302cEDhC6Ao5N7glQRpLsnL/aTFo1JbwNSqKUcVa6hOvl3fRDet
        9fI3D+uAESPzdmFwDpHVzh4GBybjokWAMC3hmRpthFHh9LJA2dXGVDu1QEki4SQF
        xcIjwLOkk5K76XZXga/kAFOnouKzw==
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhkhek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 17:33:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMMDr0FHSshLdJxGGTAKm/wzhPk8RewM0mn3M8SW1s80quiuKfl+5M2ze1Nev5SbiBYls52Bhx7WnwjpviTqPGvygwoiQEvCrmUEcQONwMZfvZZeLTZ9mUgIzl3D5w1PbXT/iNY5usDG8h7MJ7izFWHpXl/JbBBKYw4/+wSS/g/D5d++P9KgOmonx88OjgDXZoP1OtYROMWdIcjw530+zp+HRPfcypX7hi2SgUd3GY1ZDfT5bp+R+vj6MZQV78J0Iq/eoXD8ZahFpMNwJJulFMYvRQD6sEjjMdkXjEGO/m/DkvBR5sVnRWBZS6nkHhWjPRdMWypuEAZ64uERFF8vOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuVhO+gpyQzH9+qNdfGhCnCEUKtmOiPvZl4XpuHuq2Q=;
 b=KUnvwlJlAkb0snsShoS2iAnez/lkg+GTWhkYxthYnUdL7d9fiLv8MSU+Lj+pgV9jDGEP0pmxd4hQI2sn+LJd5YCoquLqjW7X/j63BPaQ7K/c05+KO/sV5SMFvo4vgOWMmJunXrTypl2C7FaH35p428A8+XqpBHnmSC4ydp19oI1++timDaYlcwt5ORNovTcPJPdlgzo50NuCpIHC79UDWceONoVcVAHOMYUWhc9PD82i6VV2M1G/u8rJG6sGE+XSCu+BvfbmfoefKlbyigfm+qKl7Dsr0IsmzQAVASNqxLtz8Enmd/qoUC2FcPpzspeedKkGWp8UMLknFH23arDFbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cirrus.com; dmarc=pass action=none header.from=cirrus.com;
 dkim=pass header.d=cirrus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuVhO+gpyQzH9+qNdfGhCnCEUKtmOiPvZl4XpuHuq2Q=;
 b=uO7qeo0v638GA7Du8bj25ayFdAsUychfd5cQ3eQGqfZ1VhasAMsMPqeXejN9UXfOWrxV2dfictYZdcGcpRZPDpD/33Aa7KRLzvvaZNuv4QJsTqyt44oFkphN/RjrfC3WrBhUJ6aeayigbia6VsGIujPZe5YdUht5cu76pYsPVX4=
Received: from BN8PR19MB3057.namprd19.prod.outlook.com (2603:10b6:408:95::13)
 by DM6PR19MB3946.namprd19.prod.outlook.com (2603:10b6:5:22b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 22:33:01 +0000
Received: from BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8]) by BN8PR19MB3057.namprd19.prod.outlook.com
 ([fe80::7a8e:a98c:421a:c1a8%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 22:33:01 +0000
From:   James Ogletree <James.Ogletree@cirrus.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Fred Treven <Fred.Treven@cirrus.com>,
        Ben Bright <Ben.Bright@cirrus.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Jeff LaBundy <jeff@labundy.com>, Joel Stanley <joel@jms.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Jacky Bai <ping.bai@nxp.com>,
        Jean Delvare <jdelvare@suse.de>,
        Eddie James <eajames@linux.ibm.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Thread-Topic: [PATCH v3 2/2] Input: cs40l50 - Initial support for Cirrus Logic
 CS40L50
Thread-Index: AQHZyvU2Ki66M1P/ZUe1/Vm0xGH7Cq/jVVaAgAillwA=
Date:   Tue, 15 Aug 2023 22:33:00 +0000
Message-ID: <51826BD7-BB75-4D1F-B947-A7AC2C642F62@cirrus.com>
References: <20230809191032.820271-1-james.ogletree@cirrus.com>
 <20230809191032.820271-3-james.ogletree@cirrus.com>
 <20230810103005.GZ103419@ediswmail.ad.cirrus.com>
In-Reply-To: <20230810103005.GZ103419@ediswmail.ad.cirrus.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN8PR19MB3057:EE_|DM6PR19MB3946:EE_
x-ms-office365-filtering-correlation-id: e849a044-9606-42a0-d593-08db9ddf9539
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aVh4oVBWKqbYAqJ8fkHD8dIBFppYxu27v9VRckg7yx8isTws4iEX8KqM4tUxaNYHOZqrT2ouniffdhnvHI8KOAOcEtHKXrsVH+79tz8SOjoXFHm1GYQbUFyPRmPW4Z+LMWY3oeE8QGydKaeDXOQAONTHTm0m8au70dDuaDOjDPia0A58K2VdX4dvnKNaQWUqi7aobxGlDnp8liMS8JoFWimWOGiJjHOtwgL63xSGptCUa//heJKfpi+DTXp7ymSo1LdAzOndhfhmUCN0pCQTs/Nk27moIF08OQu85+U+JGSz849w1d4IaNEar1URNzk88ha2em820LDXw4u5i64Rr0QbjjX89Ep/uM1VJ6Z7hgKMOvlddJVOtXuJCfH5lhoOK1TAzcaX0XPYWPDboCh2LJ3N1f3s09kAhnEb5adoYu6Hip6Syc2Oob7BkWybrv8T6tsLvaPsZaCExlI1MvUHPmvkVo5nqEDtdwHRUNL1lMeXjLBG/fBxC3dU2HUWbFaA2dNCUmfwTBIYeXnko+RsIImBjsoVf55u6g5sVPYFaEpml9VsAIwJzib9hW3rJlA8+QIidtrbHjlYo39ZA8PML/20sfTwyuTTgQygafRlCTsfa8htS5YVcRpN253rQgEAb1GMvspWCuuzkfBnTNw7Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR19MB3057.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39850400004)(366004)(346002)(451199024)(186009)(1800799009)(86362001)(4326008)(41300700001)(64756008)(38070700005)(2906002)(316002)(478600001)(5660300002)(71200400001)(7416002)(2616005)(122000001)(38100700002)(33656002)(66556008)(53546011)(26005)(8936002)(6506007)(6512007)(8676002)(6862004)(6486002)(54906003)(76116006)(36756003)(66946007)(66446008)(66476007)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE5IWDBrNTU3c0VoYnYvMWY0OHRGd3cxODZJY0YvcGNTN25uTDFsd1VIekQ0?=
 =?utf-8?B?UERUY1NmYnJtaWp2VVhPZUJlbzQxT05BNzhqd3lXTVAvU2hOV2xQSnVsN290?=
 =?utf-8?B?M1N3ZW1aQ28zMTJaWDNEVm9QTFg0eENxS1ExWnlLblp4UFFrdlZCZVVlOEU5?=
 =?utf-8?B?cjAwVzMwK2krZnhYcjBOYnRoS2p6V0VjemRCb1hWQnpqcTFBVnNGdFpvdEkz?=
 =?utf-8?B?bjZ4Ympjb3NCYUY2ZEw2blFpYThYNFV6UE1FbW9IU3hzcDlOREZHK3hMdVlT?=
 =?utf-8?B?LzNIYmttUFhCNkJCZ25QNTh2QU1SL00wQnl4VEwwNXY5YWFvOW00blBpUitF?=
 =?utf-8?B?M3pwMDJLbmVIR2sxWnFWN2tWVVU2eGM2MWFTc3N1VkI5R25xYlF5YlFzanVk?=
 =?utf-8?B?eUZhMTZ2UUU1WjBZdTE1NWs5RWk0bGZyamcxTFVLYkdqTm5wT2NJQTc2QnFP?=
 =?utf-8?B?aWdnekFuak5DRVVscjd0eHBYUGFrNmlsNUtsVS84ZG9IV1ZvZW9naUFxWXBI?=
 =?utf-8?B?dDFxTmcrdi95Y2R1cWZqQng4aDdBQlliZ2pHWW9lVlZPeVN1VlRkbHBuTkJN?=
 =?utf-8?B?ZTV1N0dpc3dmWWxVVnJPaXdBRlF6cmUyZHlyNVFaTzIwYnY3bXZqczYrQVVQ?=
 =?utf-8?B?T3RBa045L3V5L0pJMWQvL2ZpaENCUVAwWGdCaDAzcGFlNVA1TkF4QThxNjNs?=
 =?utf-8?B?b0NZb3BzQjhES0JrV1lqOHNRcStzdFRUSTkzb3loemQ2SVRxckhBL0J0YkpT?=
 =?utf-8?B?WFlsTzdnbHJrN1FvZ0pjbndDK2hqZjU3TTdlcDVlcG05RlBVSjN0cTRxMWtm?=
 =?utf-8?B?YlllUEE5amEzMVhGblpZVzZZVUkwKyt3L2YxbGdWNlBZNXJoNzlXUStyNjV4?=
 =?utf-8?B?NHBqOGNuajdPellkZmJQNFVOdFdwaVNKY2pDUGZVTVBjSGdMRTBOVCtidlVH?=
 =?utf-8?B?TXN2eEhyY0RTVXB5NVZzZVlUTklRMW9BemFPdnJEWHo5VzVvd0lETmZpUXNL?=
 =?utf-8?B?Z0k1UTNzc0o5S3JMVC9GTmdGM3B2aVVwbWVUVGZVVy8vV21BREI2OEE0cHVR?=
 =?utf-8?B?WTE1Q3ozZUJsbFJxVk0rMmNxaFNFVDN4S0hTa2hwYk5tU051SWQ3YUEvUFph?=
 =?utf-8?B?MmJFRXVPRHNwOXo4cUNPc0lyaHlBcTdaUk1TUGgxSzVCbFQ5V2M2ejhHQ3Nt?=
 =?utf-8?B?YTJPcjhhU21Jc3NrNzJIb1V5MWlrUGpoZ294Z3J1cy9abWNwbSt0WEJVZXhj?=
 =?utf-8?B?UHR4YXgrNkp3UjBkNnd3WWt3WTdsejdNSWNaOEFGbFFqVmJ3YVpBb04wSEdQ?=
 =?utf-8?B?ZWdxNEFzYit6QS9na05qVXpCc2s3SVdIYUR2TXQxUTZZNm5kVWVDVEp1azM0?=
 =?utf-8?B?RDRib0VweXRtM1U0aHlobmd6YnRMdngrZjcxWDhtYjVwVWc3WXdpdFgwSzFz?=
 =?utf-8?B?Q1djVUpibi9NRlA2b2c0Z0NSUUF4ZGZtSU5INHBRMzZGRHdvVHZES0lCNE0w?=
 =?utf-8?B?TnhvZ0ExVXNETjFJOTZad0xDbUQ4akxSZHBLN010SlJyQ2FSaHNQY1JKOHVS?=
 =?utf-8?B?QUlHV1gwcGhxUjhUbkQ3d3ViNzdjakUvOWpnZlZlWkU2VU9Pd3czNkMzc2kx?=
 =?utf-8?B?VmN4bTIzN3BadXcwU0xDSCtJTE80ZmZsbFNJNkJWb3NMY2RqMWszeWd5anM0?=
 =?utf-8?B?R1hiVVVFYWJYNUdEazZzWU9OSWtNZFRzU2ZRNmRDdGZyek5qNWR1bWpIb2R2?=
 =?utf-8?B?QWRodENreFZFVmRaVy9ZQ252WTBnVERwTkZzVTdUd1dJYkFKU0tNb3ppclNo?=
 =?utf-8?B?elh2UDFlaHR4eGgwL05HMGhwWEdLT3NxUUZzQXZBamtWdm0zaWNHRlNJTmcw?=
 =?utf-8?B?ZGw2dmJLVXd5R0pxT1drd1hqZHh2bzhPdmkwVDMrMVk5ay9qa0hjR0o3OVZh?=
 =?utf-8?B?WnltdW1venRXM0NDU2IxM3R3MnMzb2lETk5ldE1na2prUmhzaUZWZ2liVE1B?=
 =?utf-8?B?dTJOcEkvMENZOW1KOWNqOWdhaWU5STlzWnpqNk1rSFAvdUJlSGV5dUxCTjcv?=
 =?utf-8?B?UnZ2cnRqeHZkWHppcFpCUG4wSkJ1ZDdneWNCRm1LRG9mYWM2c3p2RzU3ZVd2?=
 =?utf-8?B?SGZnTDNMZDIyMGt2L21PZ0U4Q2VwNFRzV3lBT2tRWUtYRFNiaC9MWlpsbVA1?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B341B900270C1440969FECD51EA66FA4@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cirrus.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR19MB3057.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e849a044-9606-42a0-d593-08db9ddf9539
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 22:33:00.9859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oc/Lkle0z8ReSz3ZNSIcADDCsrWT1yx4Wjfqctd0Je7Q90KuU9SjdnziG/+jBU60mbeHv6zVIwMujBA7aRd/VP4yzIU0GbzNNELeuSxsjqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR19MB3946
X-Proofpoint-GUID: qSSohQfo4hh1L4VBqz-S-AivlZAsfrrC
X-Proofpoint-ORIG-GUID: qSSohQfo4hh1L4VBqz-S-AivlZAsfrrC
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gQXVnIDEwLCAyMDIzLCBhdCA1OjMwIEFNLCBDaGFybGVzIEtlZXBheCA8Y2tlZXBh
eEBvcGVuc291cmNlLmNpcnJ1cy5jb20+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBBdWcgMDksIDIw
MjMgYXQgMDc6MTA6MjhQTSArMDAwMCwgSmFtZXMgT2dsZXRyZWUgd3JvdGU6DQo+PiArDQo+PiAr
c3RhdGljIGludCBjczQwbDUwX3BzZXFfd3JpdGUoc3RydWN0IGNzNDBsNTBfcHJpdmF0ZSAqY3M0
MGw1MCwgdTMyIGFkZHIsIHUzMiBkYXRhKQ0KPj4gK3sNCj4+ICsNCj4+ICtzdGF0aWMgaW50IGNz
NDBsNTBfb3d0X3VwbG9hZChzdHJ1Y3QgY3M0MGw1MF9wcml2YXRlICpjczQwbDUwLCBzMTYgKmlu
X2RhdGEsIHUzMiBpbl9kYXRhX25pYmJsZXMpDQo+PiArew0KPiANCj4gVGhlc2UgcHNlcSBhbmQg
T1dUIGJpdHMsIGNvdWxkIHRoZXkgYmUgc2hhcmVkIHdpdGggbDI2Pw0KPiBEZWZpbml0ZWx5IHdv
cnRoIHN5bmNpbmcgd2l0aCB0aG9zZSBndXlzLCBteSBhc3N1bXB0aW9uIGlzIHRoZQ0KPiB3YXZl
dGFibGUvcHNlcSB3b24ndCBoYXZlIGNoYW5nZWQgbXVjaCBhbmQgaXQgbWlnaHQgYmUgbmljZSB0
bw0KPiBmYWN0b3IgdGhlc2UgYml0cyBvdXQgaW50byBzb21lIGxpYnJhcnkgY29kZSB0aGF0IGJv
dGggZHJpdmVycw0KPiBjYW4gdXNlLg0KDQpUaGUgcHNlcSBjb2RlIG1vc3QgY2VydGFpbmx5IGNh
biwgbGlrZWx5IHRoZSBPV1QgY29kZSwgcGVyaGFwcyBvdGhlcnMuIEkgYXNzdW1lIGl0IGlzDQph
Y2NlcHRhYmxlIHRvIG1vdmUgc29tZSBvZiB0aGVzZSBmdW5jdGlvbnMgdG8gYSBsaWJyYXJ5IGlu
IHRoaXMgcGF0Y2ggc2V0LCBldmVuIHRob3VnaCB0aGlzIGlzDQp0aGUgb25seSBkcml2ZXIgdXRp
bGl6aW5nIHRoZW0gYXMgZmFyIGFzIG1haW5saW5lIGlzIGNvbmNlcm5lZD8gSW4gb3RoZXIgd29y
ZHMsIHdlIHNob3VsZG7igJl0DQp3YWl0IGZvciBvbmUgb2YgTDI2IG9yIEw1MCBkcml2ZXJzIHRv
IGJlIGFjY2VwdGVkIGJlZm9yZSBzcGxpdHRpbmcgb2ZmIHRoZSBjb21tb24gY29kZSBhcyBwYXJ0
DQpvZiB0aGUgb3RoZXJz4oCZIHBhdGNoc2V0PyBJ4oCZbSBwcm9iYWJseSBvdmVyY29tcGxpY2F0
aW5nOyBqdXN0IHdhbnQgdG8gYmUgc3VyZSBvbiB0aGUgcHJvY2VzcyBoZXJlLg0KDQpFdmVyeXRo
aW5nIGVsc2UgaW4geW91ciByZXZpZXcgd2lsbCBiZSBmaXhlZCBpbiBWNC4gVGhhbmsgeW91Lg0K
DQpSZWdhcmRzLA0KSmFtZXMgT2dsZXRyZWUNCg0K
