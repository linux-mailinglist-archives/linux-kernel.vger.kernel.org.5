Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE080176A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjLAXSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjLAXSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:18:49 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B749F4;
        Fri,  1 Dec 2023 15:18:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLpNllKLRkzav0JiuAkIUTD+2T3epPDCknoayCGuwIrRnBlSuN+dzt6qyZaSUmjHD3qHHs3G7NMiYdCQifFvdg0BMCCyVzTWdarsp3nyF0Fv1MMvMH/56ols0dGVXtAsIXO//kN1gpgpESz+vfgk27B0SdfkInGdQIL3ZlhhnxoJnRCAQGzrwSvX5ZESZbiGfYsBWmv7tjZeRex82ssSpd/s8P+aSZk+aj5jjFEbWf0wbZ6AqxdAvNNud2mCwWNM4w9W5E7YVcV424YGIaCIEYdYEFx+TQ4FNwDKmcfeEFEvSnzG2Ff1YLtatOGhbg8VI89F5MOnLlGLlx0XJ3fjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTu4pVTr8W2GEpiOqkiJsuUttop7QRbJUC70VbwpZIY=;
 b=DQbDKehzNvnW+eQUndKZZ17oVXhrMOI2UgIUgQTqooYRKAjdmx3klgtHwBi9JF0EThSulq7al4XDCuPe2F4d9C6H0WDjpfBndvz9USY3NKE4kS8NwZJLFVvY51uI+vibT8EdtD2CGLxQX4CAECIbnuBbKZDm+WYJwns8+KZRzBq10ooSt2tESUYtt0w3TET4PJyZBjG4PKlXp7my0Qu96JzLmQVzihRSjDMY57nZixkRHFetIfowHR46PebRRRe3KS2OUeVeIg9ebmc2dnK3eLRxirU7Iun9WDy3NjORa/fIg84m0D+c0S6CETil5bmVg0EdWg/mPIk+suwOcE2wgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTu4pVTr8W2GEpiOqkiJsuUttop7QRbJUC70VbwpZIY=;
 b=hT8lguX49iuVErXhEgJ60baaomRnFQOhFuBQqX1ag6Ls/D3imd9v8NSpFhFo0vWSDFHLFfDk8DEBNx5zP7NP9i9afKQQyqwRBe9wNokgiFzKeQRgEyREYvSidXdETiKj6XNe2j9aQ+jT0mtDp83NMjyhlN5O8NJm9u4+PGaavUE=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM0PR04MB6930.eurprd04.prod.outlook.com (2603:10a6:208:186::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.18; Fri, 1 Dec
 2023 23:18:46 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::34dd:289e:9e8b:9c9b%7]) with mapi id 15.20.7068.012; Fri, 1 Dec 2023
 23:18:46 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Francesco Dolcini <francesco@dolcini.it>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: RE: [EXT] Re: [PATCH v7 02/12] wifi: mwifiex: fixed group rekey issue
 for WPA3.
Thread-Topic: [EXT] Re: [PATCH v7 02/12] wifi: mwifiex: fixed group rekey
 issue for WPA3.
Thread-Index: AQHaIdVU9t1lQPz4s0eWS+tlGSPAM7CUOvWAgABQ5ACAAInHoA==
Date:   Fri, 1 Dec 2023 23:18:46 +0000
Message-ID: <PA4PR04MB9638065D9F32881A829DBD7CD181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-3-yu-hao.lin@nxp.com>
 <ZWmyQ9ilyAPGJmft@francesco-nb.int.toradex.com>
 <8d720940-5cd1-4d53-bdf2-97334069a5b8@quicinc.com>
In-Reply-To: <8d720940-5cd1-4d53-bdf2-97334069a5b8@quicinc.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|AM0PR04MB6930:EE_
x-ms-office365-filtering-correlation-id: f2fb17a3-7175-4a41-ca6a-08dbf2c3de12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WIvJXfa+61FfeQFe8j52CTAOUw+ls9+jJHD/G4EywHxmPBmFkAFoFiCSdYzhpd1RcZ9Zn1bSnuYXVBd1LnLvk19SRUxlYAA4NZt2717bnNJy6zfd2nr1zVst98YV0q96jDYIN884U+vHvvrR5rD1xXJMuI+5R+ZZwkvFG2cFefjPs3T5FIL4+gjHhQewKCHy3VYOVo5PZTR9Wq2JhcJwx0VIiBy94mgDgymOHfiLSvp1ifye5S1jcidnWOBNsGHcETEpAtEHWnHV1SO246R4VrG1JY8Od+iQHPMjWit1i4MWprnn768fFH5Yh6NhFTn1v0HQBwP+FOQWZQ708CCqY9uegEEEvZzDaWUefH2JFZGvkpLodYWp2hZrzxw4Juv7ZCM1ZHjM1AWW9O25RvB5yv4B/91bNV/oK3R5uSCc6yRWS3JSy4hU9myVagolurW0SChPxD4jZNihtySJteAWXA5ujLnizEdaIRjE+QZJ8FcmUeLCsqfvvonw/JBxqu2A57KchvUa0N+XEBSZ9ZfhSzDc5jzsSxfv7vIDFMkTdc61VsyhY9uPw/Wguy6Boz5CXQX6PtWYOm7WhXAFE3TlN192pvm7oWjKR6+7SCCyRGFQymNhcKAdZs0Tsp5B8UFiTCrOzpEkgXO7VyfT5UjjNIXhVeiX6HBLM0g//0QmiBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(346002)(396003)(136003)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(55016003)(110136005)(54906003)(316002)(4326008)(66446008)(64756008)(66946007)(66556008)(76116006)(66476007)(38100700002)(41300700001)(83380400001)(26005)(8676002)(8936002)(33656002)(7696005)(86362001)(52536014)(71200400001)(2906002)(38070700009)(122000001)(9686003)(478600001)(6506007)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWlXYldadnJkL0trQmRnWmZray94azlsYU1FSXQyZFdleDF3MDF4YmRmRjRi?=
 =?utf-8?B?YnhzWHFVYWFBdk5VakV4Z3Q2YWFIUEQvM0ZORXhOZDVIM1l0Z294c1M2ZjBa?=
 =?utf-8?B?MFdXWGRIWWNqeWhla2RwbzJTV2ZyVndtbm02ZUJCMmxkTnFGNVZyWEI2Q2Rq?=
 =?utf-8?B?Z1o5dzhBb1JpRlM5UW4yaTdPUnRGT1hTQkRTYi85SnlBa3lHazEvWVFoRUFn?=
 =?utf-8?B?K2dweW8xMVZ2blY0enVCbEFYb3czQ2J1NVFCM0FkSjhSMU1La3V3M3RhSlFa?=
 =?utf-8?B?eEtHbVJxYlgyRWhSQlM5WkZMQkhDQlpIYWIxRFVmTUlyakJ5V0ZaMmR6b0Vn?=
 =?utf-8?B?bGhMSkd1c2tmdzF0eVRJL3czNVRUZm1EQWw2aUxmSnplSUlvMEhGNFpwUW9Z?=
 =?utf-8?B?RXRubDgzLzlUemMybGI1dyswcXppdDEzVmFDMG5GT2I3MFo5eFN2UDVRcWVs?=
 =?utf-8?B?aUxBaHhtUk1EM0oyeWNxdGVUclZGUmxsSURJdzV4ODJXYjhBektJNHVZbVdQ?=
 =?utf-8?B?YnB4Q1pFejdjM0VvWjFTelBkOVJ2dGtNVTBkbDJGclZpYXRwenJEREgrUC9i?=
 =?utf-8?B?WnJmZE13NE1JbmlsZlIyRkNtTDU1b2czS2pqNm5SQmswUjU3OEtTQU9mZ0pp?=
 =?utf-8?B?eFRsWFhJWlY5eldtcTZpK1lCcVQ2TC9XUDhyWWxNUW9ZbVdnelROSGtBelpr?=
 =?utf-8?B?bXpHcGFrYVV2TDNwczFYVW1tdUJoVDdPaEs5T0dJRHV1ZnFwaEdib2xRTEVW?=
 =?utf-8?B?dzBLQjk5ZmdTNWNhN2NxT2FpaVI5TFBHVU1kRUNYQ2pIZWVKRytIWWxwMmwy?=
 =?utf-8?B?cDFneDY4RUg4N2pVNUFhRFZsSDF1ZmxJTlFvWGgweGRIMk1HU2srQk5xOHU1?=
 =?utf-8?B?dlU2YVZvQnEwWkNmTEhkZkJQZHdEYXZQcFlnWnpURFFFOGhnK2hsd0pBMDhn?=
 =?utf-8?B?cE9udWFwMHV3NEh0ZXFMSCt4c0tNSGp1V1lTcHNqdjM0alpXT0llMnlSZzN3?=
 =?utf-8?B?NXFTWTFMVzV1MlZKTk9rWklEcGlSdUZVRHY0eC9LWlZxeW1xdTBBbjhLVDJp?=
 =?utf-8?B?Q3graW50WFhGNWh4RW5VaThYTzYrdlQzUVRkaEU5TnBHVXNLQWxYZ3p0WHhD?=
 =?utf-8?B?aUh3SUNuSUxWeEhlb1hOWGRKTUlhOG1WdGtSTmlRMVVIQWgyNmdRTFBiRGZ3?=
 =?utf-8?B?SGhibU1MQ0Jmb2lXT0Rvb0g3NmFhbEVPRDltbTYvR3p1WUxvV1Q1UGNhZXhh?=
 =?utf-8?B?NmJaRlV1UmhYZEwxc1BweERqYXJ0T3NHNFpVQUJyOE5uM0tGZ043dGdhNVpa?=
 =?utf-8?B?RWhuK2RWSjJOQ201eDNWUzQ0VkVVTHVCRXVXcnVKTTh5UUNwdWwzbU9Ja2kv?=
 =?utf-8?B?ejQxMzhCQ1NZeDFVanNOZVFqV3VWWGZWaUNSVTdKNzRwVnIxY0NDSUtlY3Jm?=
 =?utf-8?B?Wk12QVVnN1Axa0xwTm5lZ05WZVNoYncwY3pEY0NoRE5jSktsUHlVV2tTUjJL?=
 =?utf-8?B?TlBjTGpXMWV2Q245dmcyNTdadGNwYlQ5TnAzSXdVYm8wVDRoK3o1eG9nSFZI?=
 =?utf-8?B?cTladWgvWUFyNGhjSHBteDV5SzF6ZUQvT1ZQY3ZCQm1ua3hsUG9mTFJoZ0x5?=
 =?utf-8?B?WS95VldtNzFacUNaNDJhUDV5bWwvR2ZFSXhLTTZVbkx3S01JT2dtK0EvYnZs?=
 =?utf-8?B?QTljMGpSOUhRRU9LdVFVbDluTDE3QWNuMmNoK01IQjY1TDNkc05XS1h4VnVz?=
 =?utf-8?B?dFZBSGkrRGxuRXRsZlh0ZkREUnpIREZoTW54azN0cmg0bjFZcjZwQ0JyQ1hz?=
 =?utf-8?B?NE1TcnhqL2VSSXV5ZWpCRGd2ZVVGTndQMGtIcDRpbC9jQlpSb2pmdzhoK1NH?=
 =?utf-8?B?TTgraXFKSXlnSE9qdHBOSVRaYy9ER0lTaTJHRmVsbGR2ZVl0ZHdwcmoyQ2NH?=
 =?utf-8?B?bHA2Vmt2M2pFZW5jZjBaN0NBOCtXWXdicnBJdWFGUkl6Y0V0QUtieWNIRUp3?=
 =?utf-8?B?T01EOS9JZG9zNnk4NVAxWmJ4NWFCQ1Buc0tnYXIwK1lWUVhzUGFPc1hRSnRo?=
 =?utf-8?B?UEpwbC9Qa1UrOExncGpCd291RmZSR0M0Q3NQbmhvYkNwRTFHT3FnMzlVYW5B?=
 =?utf-8?Q?6T7f6Kibd6z66SbbmqEVVZyYl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fb17a3-7175-4a41-ca6a-08dbf2c3de12
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 23:18:46.1073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6UfAGhqt9dQf40FMlhm+P7FIrlgK7+9Obo+CZ82P9je9l+SPWj3mGLlNTyGVm21m5Om4KokOAvz8OI/g3A5eSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6930
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKZWZmIEpvaG5zb24gPHF1aWNfampvaG5zb25AcXVpY2luYy5jb20+DQo+IFNlbnQ6
IEZyaWRheSwgRGVjZW1iZXIgMSwgMjAyMyAxMTowNSBQTQ0KPiBUbzogRnJhbmNlc2NvIERvbGNp
bmkgPGZyYW5jZXNjb0Bkb2xjaW5pLml0PjsgRGF2aWQgTGluDQo+IDx5dS1oYW8ubGluQG54cC5j
b20+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7DQo+IGJyaWFubm9ycmlzQGNocm9taXVtLm9yZzsga3ZhbG9Aa2VybmVs
Lm9yZzsgUGV0ZSBIc2llaA0KPiA8dHN1bmctaHNpZW4uaHNpZWhAbnhwLmNvbT4NCj4gU3ViamVj
dDogW0VYVF0gUmU6IFtQQVRDSCB2NyAwMi8xMl0gd2lmaTogbXdpZmlleDogZml4ZWQgZ3JvdXAg
cmVrZXkgaXNzdWUgZm9yDQo+IFdQQTMuDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVy
bmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3Bl
bmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5n
IHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IE9uIDEyLzEvMjAy
MyAyOjE1IEFNLCBGcmFuY2VzY28gRG9sY2luaSB3cm90ZToNCj4gPiBPbiBUdWUsIE5vdiAyOCwg
MjAyMyBhdCAwNDozMTowNVBNICswODAwLCBEYXZpZCBMaW4gd3JvdGU6DQo+IA0KPiA+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L21haW4uYw0KPiA+
PiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9tYWluLmMNCj4gPj4gaW5k
ZXggZDk5MTI3ZGM0NjZlLi4zYmViYjZjMzc2MDQgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL21hcnZlbGwvbXdpZmlleC9tYWluLmMNCj4gPj4gKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvbWFydmVsbC9td2lmaWV4L21haW4uYw0KPiA+PiBAQCAtODAyLDYgKzgwMiwx
MCBAQCBtd2lmaWV4X2J5cGFzc190eF9xdWV1ZShzdHJ1Y3QNCj4gbXdpZmlleF9wcml2YXRlICpw
cml2LA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgImJ5cGFzcyB0eHF1ZXVlOyBldGgg
dHlwZSAlI3gsIG1nbXQNCj4gJWRcbiIsDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
bnRvaHMoZXRoX2hkci0+aF9wcm90byksDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
bXdpZmlleF9pc19za2JfbWdtdF9mcmFtZShza2IpKTsNCj4gPj4gKyAgICAgICAgICAgIGlmIChu
dG9ocyhldGhfaGRyLT5oX3Byb3RvKSA9PSBFVEhfUF9QQUUpDQo+ID4+ICsgICAgICAgICAgICAg
ICAgICAgIG13aWZpZXhfZGJnKHByaXYtPmFkYXB0ZXIsIE1TRywNCj4gPj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgImtleTogc2VuZCBFQVBPTCB0byAlcE1cbiIsDQo+ID4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGV0aF9oZHItPmhfZGVzdCk7DQo+ID4NCj4g
PiB0aGlzIGlzIGp1c3QgZGVidWcgY29kZSwgYXQgYSBmaXJzdCBnbGFuY2Ugbm90IHN1cmUgaQ0K
PiANCj4gbm90IG9ubHkgdGhhdCwgdGhlIHVzdWFsIHBhdHRlcm4gaXM6DQo+IGlmIChldGhfaGRy
LT5oX3Byb3RvID09IGh0b25zKEVUSF9QX1BBRSkpDQo+IA0KPiB5b3Ugd2FudCB0byBkbyBlbmRp
YW4gY29udmVyc2lvbiBvbiBhIGNvbnN0YW50IHdoZW4gcG9zc2libGUgc2luY2UgdGhhdCBpcw0K
PiBhIGNvbXBpbGUtdGltZSBjb252ZXJzaW9uIGFuZCBub3QgYSBydW50aW1lIGNvbnZlcnNpb24N
Cg0KVGhhbmtzLiBJIHdpbGwgZml4IGl0IGZvciBuZXh0IHBhdGNoLg0KDQo=
