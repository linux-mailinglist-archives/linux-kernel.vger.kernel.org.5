Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C35F775063
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 03:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjHIBcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 21:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHIBcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 21:32:32 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2089.outbound.protection.outlook.com [40.107.15.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E8F19AD;
        Tue,  8 Aug 2023 18:32:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xa0MuK8U4ww0REWqO/5fWRiAt3Qy/homrNV5wE/uW5L3jWjrG5xGbdggDxpeOr8pHV4k9c6OXvc+kbdo9rwVT01Qt0VPWJzd9/XIy5pd9ggerQrrNxkMmUVIgVdRIqQJ08mLwCJW3aCXXaSwazK0GNBx9q5CWSB2LSVezbby1I0fycwgws7Do77dGFp/vaWJMc0qyfpaHOOkMG1V9l99Jhzz66MY51Ct9Ijku9aw7AyohudTpcgHRChiBb3z5KC+Qe65mlTDo/C0Hh4FNo85ugm4J3081Cwgy5K1yJDo/k+Wtkgq9RGYIoZoZ7Sk3Af67lksV9fSo1MkN9OM6rZ3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/XsZ4qib78RikoUGqknd2CPlmiRSFfM7H9jqmgesoY=;
 b=MU0gDm83KVIlj7PBw+n2ML0GwiidcgK/YFwt8OkTrYvL0n3oM8duPgw8vLKRxKhQogGZx9zfEn57XIfDuelOuxLdRkgaR9pXcREiuNBpkX5uD/wcql+j+XmbE0eOj/QWIyrkHl0Bz4LzOd+hY4cPGc3xJOBCSciemAQy8dSFN6CiTAEDTrAX4vfGsqXGVHp+VwxMM9HQquYsyZAfk4G5F4D+0/CibODUfKKJ9qALPDuo8mh37Z0hgPJ7s0GwkzWG6ahOLFw4gxDKYAkZNGsKSvAgRWD3qNmd91cjSAt37K3WYjk8dBfFHT7AviBl7d4Nf/WZVznoLzjIUnQ1jotuZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/XsZ4qib78RikoUGqknd2CPlmiRSFfM7H9jqmgesoY=;
 b=FkyMEvZu70B2OVPsVV2xN/nKhQ9hWZ/i8wpTL9Ucr7W/3PyBabo1Si7ylBHCVfsq51Z+oliUVzACacE4NEFQ8qdf4OVLIWFyC+S8WPQ9lbprL1BWlndRZvS3i6nXpSmg6bbzDsQ7J3T0ntOgGW5Baj1FJ8DgPocaf9L37RepV1Q=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9381.eurprd04.prod.outlook.com (2603:10a6:20b:4db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Wed, 9 Aug
 2023 01:32:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Wed, 9 Aug 2023
 01:32:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH V3 0/8] genpd: imx: relocate scu-pd and misc update
Thread-Topic: [PATCH V3 0/8] genpd: imx: relocate scu-pd and misc update
Thread-Index: AQHZw3pAwRLZKsnCKEK5kGU0ZLb5Wq/ginYAgACwMuA=
Date:   Wed, 9 Aug 2023 01:32:28 +0000
Message-ID: <DU0PR04MB9417E648E4442FE8518CFB9E8812A@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
 <CAPDyKFqvP71ZDcamFo5AijhTXEJKHUPNE=-dOvXYw3pr4XxK6A@mail.gmail.com>
In-Reply-To: <CAPDyKFqvP71ZDcamFo5AijhTXEJKHUPNE=-dOvXYw3pr4XxK6A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS1PR04MB9381:EE_
x-ms-office365-filtering-correlation-id: 6391d531-cbf5-4992-c795-08db98787e6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCdyX9Wek7I+7XsnxqJvM5aZ8THHeMXTKRjEMIVfwYnqExMpBJUjw4aDN0ZkdaUH0vtaCsgVjaNjQgVlK3GReF6e50Ej5+BZxdneh+BUQ/KbW1bEDYn0MP4Ph2ISCVcRArRf5oNDJUy05+AA+EXODCSjukoroqDuWEjYV1cG6dJlXn5KWukXcsJLaBN+Rcg2oK2E7GjD+tkJax9v2dS0byEhz4yrlsCf6aTy509/wyVa/BO+j9TUawMR5KetPniF1HfWyJcHTn9Y0kHTbZdaMAi+AxnxMUg7c8R/8zkzK3/UT0NQ4zcrJTqyRWh5c4DeTSz5qdNAdhzcg7i5lR3W3YRJu+BymaLQ8iWvxC1k00x7rYcP/4PJIP9Rohivm5Yt6gkWXZNsKPGJtncltsx7SYFVOyzIn1A/VfiTiN0GMIvm0T4ryWI1aiy5Xei0wzL9GOXYQZqp6U0n3Q1ooc2+7ylSvC2LNJfKn5QS+Ki5dAWSlnLYIes0b7k7BDYVx6S8TjM8J8vWK3cgYnteYFoc41/QUwCUMLIzPl35ThcAqKLryZfazHRGPNiaQ768CueZv1jXdrKVHhktw6ohd5B+XsY1ej6faT6k7iY7TE0v2+X1LvER5tYH5HAHLIcJPMQz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(186006)(451199021)(1800799006)(122000001)(478600001)(83380400001)(55016003)(9686003)(33656002)(6506007)(26005)(76116006)(66476007)(8676002)(316002)(8936002)(4326008)(66556008)(15650500001)(2906002)(7696005)(64756008)(66446008)(71200400001)(110136005)(54906003)(38100700002)(66946007)(41300700001)(44832011)(5660300002)(38070700005)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEJ1c2ZEUlZKOTFKZG8rcEM2bm0vUjFhRm54dEppb0Z0SkJHZXZ4Q2pYdDFB?=
 =?utf-8?B?OURCaWZDa0dvWG05RjBVbFo2Q0VtMWdySE1rcTVLK3ZhY1JuOVBBZzlyT2ZB?=
 =?utf-8?B?cFpQK2NUc01kUmVBSTFzZ1pYUTR0Z1orVG5ka2FabE5QeTNTUnpFaU03NG1M?=
 =?utf-8?B?VzVZRDVoSVU2Mm1yT0ZsSklqMDhwMjJHSThXRktpN1F1UlY4ZmprSStNZzQ0?=
 =?utf-8?B?K2pvZ1dNU2ZnRlp5R2lEU3FFK2JJZlkwSTczNmMvSWdVMURvMXdzQ25DMFl2?=
 =?utf-8?B?R1ExYTRXMnpXdjNaTzRxcm1EcUpZNlh2MWNLVW9QM1IxaWdCVlJlVUpQVXZi?=
 =?utf-8?B?R3Y4NHRaaFZramZHT1BvTFNBUEVqeGZiRER6ekR1R2U4VFRWQnErRldhaHBR?=
 =?utf-8?B?Qzlkc0EyRWljczVYWllaQ05xQkxRdStKalNKR3Ixd1h0ZHpMMytFdWR5VmVs?=
 =?utf-8?B?UlA3SkN5TngzMlY3QVlyWHkrMmIwR1Z1SVRjMmovakxrMmZqdTRHcVJWeGpS?=
 =?utf-8?B?aldvdHVyRXZVK3YrdTVFYk9GdGhtZUp5RTNTK3ZCRzJJYW5wQkVkSG5CZkdG?=
 =?utf-8?B?Yjluemd1WjhmaGVPSmhTV3M5d29tbWgvM29HcjZnNExTcjdqTFpBMy9DbHEr?=
 =?utf-8?B?aktxNnhWNHUyTlBSVFhHKzVrQUIwc1MzS0U4elZNVS9JN2pueVhxNnpYM2pS?=
 =?utf-8?B?OGJIaTNBTHVwMFBGL0d1cjNabUpTc2JKelZPbjUwb1hWVEZycytrWitGblZP?=
 =?utf-8?B?SEtJUGNvQ0NIT1FjTmRBVERiR1YyVjlKbnd3cUEvaXgyeTM0bGpCNURMQTNw?=
 =?utf-8?B?eHNTSWZ4aFpISHg2VjZnbXJXOTVjQi9hczRNNGJsdlhkbjdoMUNmcFZKMXJ3?=
 =?utf-8?B?Tk5rUWNENXpsM1Y0RlN6M1BtbitlTkh0MFV0cGFZcVZ5ai84aUZpUEdXT2Iv?=
 =?utf-8?B?TW5uVTEyR0JOakx1YnJVbzhUeHdlQjdPVzc3bGcybVhMRU8zOHRtWmFwZUky?=
 =?utf-8?B?TGo2b3QzaE5CUVo1L1ZXNDh6YVVscThsYzNGK0hwNzc4VjI4dnpyUjQxMlhl?=
 =?utf-8?B?am41WUtNN3pxdW1QY1NRbGFWTVVBbXN0Z3VveWJQV3JMbFlHSG12YUV6a0tV?=
 =?utf-8?B?U3dUcjF3V2YxVi8vMGh5c3JITW00V01zTC8yRmw0MVZSeWFIOFdKNWZWQ2FR?=
 =?utf-8?B?N1RsWW9aZXNFdDBnOVJwbUZrR1pOL2tRU3dxSldCa2RicHoveHhmTVB2UEov?=
 =?utf-8?B?eDdnT0gvZml1MlR4dTBmYVpsb1pKMWVZK0JmcFU3TGNNeWJTTkNFV2FJV2dF?=
 =?utf-8?B?ckJYMGFjUDIxRCtGY2Fmdi9pT25JQm1hSHFUbk0vYTJOSTExMWN1clRjRlI1?=
 =?utf-8?B?V1kzMXl1M1N2amdwWlJtZGRBM2FUemc3a2FJdE1vT0VsZFA5OHdZRXpxSTlZ?=
 =?utf-8?B?S3N0VnQ5N25BVjh2ejRoQTFwYzVMQ2xhV2VoMG5PcWZhUFdsVWd3MENsQTZY?=
 =?utf-8?B?anQrOUVJSStXaWhzZCtRMTBKZmlmaGxYZlpoRUtaOWY4Z1VCMjRGZDdSVlQ3?=
 =?utf-8?B?emVuL3hBVWJNZUNkQms4T3NDOWYyRmFjYnFOcy9yL3ZicWowakhEM21QRG05?=
 =?utf-8?B?aGQ0RVA1MVFGVEpNTEVyU3JzbjNITlg3Mk05RUF2ajJKYytqUkFRSDNRclVJ?=
 =?utf-8?B?NnI2STIzYkN5TFNqM0FsckxiZTV0c2RvUzZlVElqeVpCUlBsTEI1eFdWNW11?=
 =?utf-8?B?Ujh0VTVoNWZkYU1ySmR2V25BR0VCdC9tOWNpSXNJNjBDNXR1U1pCZk1kMUNs?=
 =?utf-8?B?RUg5aHUrUlRMbERCUlYvTmRQMm9nRC9uNHpIQXV5QjVZS0FUR2grUFFYOEwz?=
 =?utf-8?B?MHJpbDJ3b1BpWXdmc2h5bTZqU2E4bmRDMUFKTUhqclRtQ1QvTnBaK2t3T1hj?=
 =?utf-8?B?eHI4QVEyUno0aEJwdndaS1lrZi8vemxYcnVaODVlcDRWdnlMMXBZdm1Vbi95?=
 =?utf-8?B?d2ZDTHo3c1VZYUhWby9yUGNKaXQ4dVFSaUdQdVBMYmgwZnVPckZidVBNOS9k?=
 =?utf-8?B?Tkx5SXdtdTJtNXVDemdVbU9EdFFYZHBiOUpReHlram1xSWtXd1kwRVNEb3Fz?=
 =?utf-8?Q?OY0o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6391d531-cbf5-4992-c795-08db98787e6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 01:32:28.7730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHvE9nwPqD8+8S1YugDTjOhJYNH7+DBFicMPoH8j2oEwjsOFm6k4gcV8Rw2nj88sgtF14CGNCa9oNmOpp88j7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9381
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYzIDAvOF0gZ2VucGQ6IGlteDogcmVsb2NhdGUgc2N1LXBk
IGFuZCBtaXNjIHVwZGF0ZQ0KPiANCj4gT24gTW9uLCAzMSBKdWwgMjAyMyBhdCAwODo0MywgUGVu
ZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5ueHAuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEZy
b206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVjM6DQo+ID4gIHJldHVy
biAtRUJVU1kgaW5zdGVhZCBvZiByZXR1cm4gMCBpbiBwYXRjaCA0DQo+ID4NCj4gPiBWMjoNCj4g
PiBNb3ZlIGRyaXZlcnMvZmlybXdhcmUvaW14L3NjdS1wZC5jIHRvIGRyaXZlcnMvZ2VucGQvaW14
DQo+ID4NCj4gPiBUaGlzIHBhdGNoc2V0IGlzIHRvIHVwc3RyZWFtIE5YUCBkb3duc3RyZWFtIHNj
dS1wZCBkcml2ZXIgcGF0Y2hlcy4NCj4gPiBwYXRjaCBpcyB0byByZWxvY2F0ZSBzY3UtcGQgdG8g
Z2VucGQNCj4gPiBwYXRjaCAyLDMgaXMgdG8gc3VwcG9ydCBtb3JlIFBEcw0KPiA+IHBhdGNoIDQg
aXMgdG8gbm90IHBvd2VyIG9mZiBjb25zb2xlIHdoZW4gbm8gY29uc29sZSBzdXNwZW5kIHBhdGNo
IDUgaXMNCj4gPiB0byBzdXBwcmVzcyBiaW5kIHBhdGNoIDYgaXMgdG8gbWFrZSBnZW5wZCBhbGln
biB3aXRoIEhXIHN0YXRlIHBhdGNoIDcNCj4gPiBpcyB0byBzdXBwb3J0IExQIG1vZGUgaW4gcnVu
dGltZSBzdXNwZW5kLCBPRkYgbW9kZSBpbiBzeXN0ZW0gc3VzcGVuZC4NCj4gPiBwYXRjaCA4IGlz
IHRvIGNoYW5nZSBpbml0IGxldmVsIHRvIGF2b2lkIHVuZWNjZXNzYXJ5IGRlZmVyIHByb2JlDQo+
ID4NCj4gPiBWMToNCj4gPiBUaGlzIHBhdGNoc2V0IGlzIHRvIHVwc3RyZWFtIE5YUCBkb3duc3Ry
ZWFtIHNjdS1wZCBkcml2ZXIgcGF0Y2hlcy4NCj4gPiBwYXRjaCAxLDIgaXMgdG8gc3VwcG9ydCBt
b3JlIFBEcw0KPiA+IHBhdGNoIDMgaXMgdG8gbm90IHBvd2VyIG9mZiBjb25zb2xlIHdoZW4gbm8g
Y29uc29sZSBzdXNwZW5kIHBhdGNoIDQgaXMNCj4gPiB0byBzdXBwcmVzcyBiaW5kIHBhdGNoIDUg
aXMgdG8gbWFrZSBnZW5wZCBhbGlnbiB3aXRoIEhXIHN0YXRlIHBhdGNoIDYNCj4gPiBpcyB0byBz
dXBwb3J0IExQIG1vZGUgaW4gcnVudGltZSBzdXNwZW5kLCBPRkYgbW9kZSBpbiBzeXN0ZW0gc3Vz
cGVuZC4NCj4gPiBwYXRjaCA3IGlzIHRvIGNoYW5nZSBpbml0IGxldmVsIHRvIGF2b2lkIHVuZWNj
ZXNzYXJ5IGRlZmVyIHByb2JlDQo+ID4NCj4gPiBEb25nIEFpc2hlbmcgKDEpOg0KPiA+ICAgZ2Vu
cGQ6IGlteDogc2N1LXBkOiBjaGFuZ2UgaW5pdCBsZXZlbCB0byBzdWJzeXNfaW5pdGNhbGwNCj4g
Pg0KPiA+IFBlbmcgRmFuICg3KToNCj4gPiAgIGdlbnBkOiBpbXg6IHJlbG9jYXRlIHNjdS1wZCB1
bmRlciBnZW5wZA0KPiA+ICAgZ2VucGQ6IGlteDogc2N1LXBkOiBlbmxhcmdlIFBEIHJhbmdlDQo+
ID4gICBnZW5wZDogaW14OiBzY3UtcGQ6IGFkZCBtb3JlIFBEcw0KPiA+ICAgZ2VucGQ6IGlteDog
c2N1LXBkOiBkbyBub3QgcG93ZXIgb2ZmIGNvbnNvbGUgaWYgbm9fY29uc29sZV9zdXNwZW5kDQo+
ID4gICBnZW5wZDogaW14OiBzY3UtcGQ6IFN1cHByZXNzIGJpbmQgYXR0cnMNCj4gPiAgIGdlbnBk
OiBpbXg6IHNjdS1wZDogaW5pdGlhbGl6ZSBpc19vZmYgYWNjb3JkaW5nIHRvIEhXIHN0YXRlDQo+
ID4gICBnZW5wZDogaW14OiBzY3UtcGQ6IGFkZCBtdWx0aSBzdGF0ZXMgc3VwcG9ydA0KPiA+DQo+
ID4gIGRyaXZlcnMvZmlybXdhcmUvaW14L01ha2VmaWxlICAgICAgICAgICAgfCAgIDEgLQ0KPiA+
ICBkcml2ZXJzL2dlbnBkL2lteC9NYWtlZmlsZSAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAg
ZHJpdmVycy97ZmlybXdhcmUgPT4gZ2VucGR9L2lteC9zY3UtcGQuYyB8IDE5Mw0KPiA+ICsrKysr
KysrKysrKysrKysrKysrKy0tDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTgzIGluc2VydGlvbnMo
KyksIDEyIGRlbGV0aW9ucygtKSAgcmVuYW1lDQo+ID4gZHJpdmVycy97ZmlybXdhcmUgPT4gZ2Vu
cGR9L2lteC9zY3UtcGQuYyAoNzAlKQ0KPiA+DQo+IA0KPiBNb3ZpbmcgdGhpcyB0byB0aGUgbmV3
IGdlbnBkIHN1YnN5c3RlbSBtYWtlcyBzZW5zZSB0byBtZS4NCj4gDQo+IEV2ZW4gaWYgd2UgY2Fu
J3QgZ2V0IHRoZSB3aG9sZSBzZXJpZXMgcmVhZHkgZm9yIHY2LjYsIHdlIGNhbiBjZXJ0YWlubHkg
cGljaw0KPiBwYXRjaDEuIEVpdGhlciB3ZSBjYW4gZnVubmVsIHRoaXMgdmlhIG15IG5ldyBnZW5w
ZCB0cmVlIFsxXSBvciBpZiBTaGF3bg0KPiBwaWNrcyBpdCB1cC4gSWYgdGhlIGxhdHRlciwgU2hh
d24gbmVlZHMgdG8gbWVyZ2UgbXkgaW1tdXRhYmxlIGJyYW5jaCBbMl0NCj4gYmVmb3JlIGFwcGx5
aW5nLiBJIGFtIGZpbmUgZWl0aGVyIHdheS4NCg0KVGhlcmUgaXMgbm8gcnVzaCB0byBjYXRjaCB2
Ni42IGZvciB0aGlzIHBhdGNoc2V0LiAgSXQgY291bGQgZ28gdmlhIHlvdXIgZ2VucGQNCnRyZWUg
Zm9yIHY2LjcgZnJvbSBteSB2aWV3LiBBbnl3YXksIHVwIHRvIHlvdSBhbmQgU2hhd24gdG8gZGVj
aWRlLg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPiAN
Cj4gWzFdDQo+IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC91
bGZoL2xpbnV4LXBtLmdpdCBuZXh0DQo+IA0KPiBbMl0NCj4gZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3VsZmgvbGludXgtcG0uZ2l0DQo+IGdlbnBkX2NyZWF0
ZV9kaXINCg==
