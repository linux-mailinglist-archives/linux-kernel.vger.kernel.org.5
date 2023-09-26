Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723197AEFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjIZPbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjIZPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:31:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2024.outbound.protection.outlook.com [40.92.107.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5307110E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIzUMZdjZywyl/nxlgM6GnPk6N4iNIuDjgES+oltAeJl+BfaA0Of0djA3FtMoU6+M06cRVfKGpjyAFliesh8Ae5qIQdN3AxLj5HSVceKlZ9HftrFHOWCdSDEsOkM59s3EVUMfsEfCxJ9hqB5oetL4Jowdr1qf1DRxYn06K7O/AqcnG+rgzl2tm81C9InNdCjTWIUCGV9RqeRr0k86IxxcHBTSdYR+6tZsc2xrxeoLfLQsC8KPXnl8Kn9pKKYa93kGUlncO/2bnhZGRowoTlENk/FabIJNaxFTOvtqMoRGd2FR73uP3UA6WFBCoV8GZaIzk9tmHRrxP4R2MjYwS4f3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5duConcDc5v5PrqD9rj2FcBos83TuUJj99xueLIuSI=;
 b=Z2jRiVMu6jY4G0qU+t6Sd5n9kKZoHRCSbudlBt5kayyP7+h595rjg1ss60As63ZG1PEpHoV5Y7Xq+9xc2hVAi0NUn/PZMqJb5PgV+jf5yOPf+tWNzourh13zhYUZiCePsuI+mGmFeob0LNKDpUB80pcEXi0P0AAMnlawP4pwZoWbXXZocIRrPQdCw19FVS4/sjc4n/4hSk8TZO0va00+8KTAS1ULyq0qgB/WtwWfB42KVs2NaXolvHXbbuLrRPPyVokT92GdAuAzZk+gqQAnPkCpxYBZ3ZfNAf8HY0wfI/mCDdZniWxVSPic3kRLrAkocuJzRqOUEr0aHqaZuqKp2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5duConcDc5v5PrqD9rj2FcBos83TuUJj99xueLIuSI=;
 b=J0j4+1KONJfDbQjgftMnEa6BNLVj7iA8jSQmMTa1rPBWFc7PSfYXxYSSh2qmjfP9JJWCWxEFKO8R2F4ORELepzdeZbYi9xyJnUmTNWeCZ8T4ag1fyRKyRMvF8cJUyXdecCBbm6viQJ/q08PXce2udwz0svCSRHdTdvb14/XErcx3VfPlkZobICCaLzooRahO8ZJ3xbT10VO0vO7VR2vWkpwZ9nsKdhwmPE+UWTiVu+wy/WuDLcVdPCjbF8hqA5agZaD4VH92RzZxkHDo4/UKdMRareQKCZ0gFWB074LqtsQk973GsmJXaKc0J2I/dJhUf7UzPBXIZzAbfXxgKgrMww==
Received: from TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 (2603:1096:404:e5::14) by SG2PR01MB3658.apcprd01.prod.exchangelabs.com
 (2603:1096:0:d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 15:30:57 +0000
Received: from TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 ([fe80::61:7bba:9541:ee98]) by TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
 ([fe80::61:7bba:9541:ee98%6]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 15:30:57 +0000
From:   Kelly Devilliv <kelly.devilliv@outlook.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Thread-Topic: dma_map_resource() has a bad performance in pcie peer to peer
 transactions when iommu enabled in Linux
Thread-Index: Adnwi6tED85f8R9dTdOgKGNde2BBRQ==
Date:   Tue, 26 Sep 2023 15:30:57 +0000
Message-ID: <TY2PR0101MB3136A7480B842E009BCBDA8384C3A@TY2PR0101MB3136.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [Jj0Uji2ci3knWBrIEbIpIf5pnaSqlFAc]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PR0101MB3136:EE_|SG2PR01MB3658:EE_
x-ms-office365-filtering-correlation-id: e3f8adf6-6606-4e8e-e579-08dbbea59476
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IXFFDe7aJq/7S4R0zYmT1c/F5Ml62eTDJEh6gdWTYLMoV5OTnPhj2cSEG4SnA7/047P01nTRxOO1IaaGob2uqhEi6f1zMQjtrvF/GXq4fh7m8HD/4oMTkRbhdRb5eJ91hPQWreGPrFJtfFR9fRvUu9vN31hFn4XF5lGCIeipP3zAsM3XDJx5AB7Hz4qDZzNvM8aXt1fueM8juRIKiZ0VxVsb0XaBKpiQiUjFXHWIiSkjwrwbpGK964+l/t4Vxo8iDwJLtYROr/WR5UxE9syaZ1XErYck2wj1ij2I3PgnNkhqCW1UWSSn7fylwZF21KWh/5eggRO07eeCqYrSuPZVxmqd2MabsQNPfj/O67mMghuMLhLYRHPkoox3zxMdBDK+cNfuAKNld644QL3MMg5wm0dDO2CPEm2e53TNAINrut1aqcqufQBrdbtk54HMTUk5FT28DdfwezOcI+0azg/2j85PhHOpnA2Sb4T+aem98Tfah70zwz3FwThFTDHPeGSLjVKaOe3TNLFfkoTcqhKX6v3b9W6PeDMlDNTeYaVQ5P6ItfCgbyG1k7/KKoFFmPMs
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlFQWEdGMGh6bW81SnZPLzlJZzYybm5PVVIzRDJrNFc4L3pxQU5VZlhrQ0Zt?=
 =?utf-8?B?RFQ4VU9EamtYekRpQnpxTGFFN1VOVjVVc3ZaNmp3Q1E5SXVBazlyejVjQisy?=
 =?utf-8?B?cyt2N2xGL08wQXVCN2tUNkdnemMrblc5L1hUamVIM1VsZWRGVWxvem5KcnQ5?=
 =?utf-8?B?OXlCYkFPSVhhL1l0VDF0bHpoY0M5VHJJMXRwOG9xK3BKYkpCTHFIQmkyQXlV?=
 =?utf-8?B?ekRmNFFIcldmWkE2NkIzSUl5R0Z3c09zLzlLcUp2OFdhRUZIUldXdkFTWmIy?=
 =?utf-8?B?K2RlVTBpUm8vdXlYR1ZoV2l4b3hHWmJ4YlJZQzdEcVVFc1JId21mVWRxVWlk?=
 =?utf-8?B?bTF2MU9laGJNWGxQR25IS2JEa1hJV2JOUXFmZHlCRzVUcDhIcHlBVW5VLzQx?=
 =?utf-8?B?R1lQM3F2MlFjRWtKM2RlZ3N5RjlwdWEvY09QdWY3Q3NzUjFOS0tvekdTUEN2?=
 =?utf-8?B?SW5MeStaSG45OWQ2eGRxVTJVZHduQjMrMk9ERm5DenBXNTVnZzkyemQrRWYv?=
 =?utf-8?B?M3JOL3RscGJkNWtaOWgxakcycnhjdTc4WENlOUhmQk1jVFRMY2F6aG1qbmUz?=
 =?utf-8?B?L0tjaXBsMmc3dDBsNDZsV1lLb1NiVERYRXlMbXI3OTJsK3dZbEdhUWxEWDhF?=
 =?utf-8?B?VmhVTkpROCt3NzcxU2hxMEdTT1ZUYS83dEhNNmRxZHhMZGhXYThQMnNieGVw?=
 =?utf-8?B?S05acnRtSkFJaG5LM3NHcmpCbmtSTkNkNEpldjhvT3JZSDlJekR4ejJnYkVu?=
 =?utf-8?B?TGhZSzFYOElqbkQxOFNNNDNMeDI3WVROemJFcld2OHZCV3pKYlFIa3ZNRk0x?=
 =?utf-8?B?SWFpbW93bG1TbFNRY0gxdCtTelhoeWVOYUFFNzB6a3d6cE5CYzVsNmNGNlds?=
 =?utf-8?B?R3kvZzZqUzdoUnlvZk9QVXd6V2NvWFpzS2s2TU9zV2hpSFZGTFE0TGdscW00?=
 =?utf-8?B?dkNoYmpSM2ZLdVpVSTE1VmZBK3RkV2lYWEJxZUZYTzUzQzltdEx6VW1oVW1G?=
 =?utf-8?B?SWJCd2o4ZVNwaXdJNFpQYUpHNG5ieUNIMW94UW9Rc1RwQ3JERStwYVFIV0Q1?=
 =?utf-8?B?b3FKbGFEbXlQRmRHaUxvbnc1SnNRaHFPM2s3TzBiUWpFZnkzbEYvRFJnVGQ3?=
 =?utf-8?B?R3NqMEpmL2k2anBDTmg4MGVyc0l1bGpnWXpvVDFQamFuSnU0c090L2JvRjZv?=
 =?utf-8?B?N2liWUtQcGVYVzlYclZ1YkdFVlFOSkM4WlovaTB6M09EbmdUUFRsQVVtWGFy?=
 =?utf-8?B?MXIraHo3Nm9LL3ZMdTRWNmhvWG5jaVF3ZUF2N0pXSVZ5a0h4R2hLSVlrS2tG?=
 =?utf-8?B?Z0ZlMk1KbjNjcjhiOVRld1I3YytDM1pKd3M3RGpnVzVpaVNHeU9ZcnFQQzNz?=
 =?utf-8?B?WmVzMUYxaGpVTmVNRG5yeXJ1SU1UYUhJYnVFVGwvSWg0QWladVJ5a3BVVFJG?=
 =?utf-8?B?enNGa0F2ZE5yU3dkSnQ3NW5qakxobEtreVN5cDJCTVhSd01TY0JiM0trK2JL?=
 =?utf-8?B?SU9CK25CMUdmamtoVnFYVmg5OEdLS1p5dm9NWTVNV0xBcEJTbjB0TytQSnVB?=
 =?utf-8?B?OWluMXRFWnBzeENzdW4wdytSUGxUQmlWRlRjSGh4M3hrQnlPbWcvSy9lQkxk?=
 =?utf-8?B?V2hTQXBoSDRMdFZLbnlLNmtEM2M5R1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR0101MB3136.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f8adf6-6606-4e8e-e579-08dbbea59476
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 15:30:57.2749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB3658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMy0wOS0yNiAxMzozMiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToNCj4gQW0gMjYuMDku
MjMgdW0gMDY6MzMgc2NocmllYiBLZWxseSBEZXZpbGxpdjoNCj4+IE9uIDIwMjMtMDktMjYgMDE6
NTgsIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6DQo+Pj4gQW0gMjUuMDkuMjMgdW0gMTY6MTcgc2No
cmllYiBLZWxseSBEZXZpbGxpdjoNCj4+Pj4gT24gMjAyMy0wOS0yNSAxOToxNiwgUm9iaW4gTXVy
cGh5IHdyb3RlOg0KPj4+Pj4gT24gMjAyMy0wOS0yNSAwNDo1OSwgS2VsbHkgRGV2aWxsaXYgd3Jv
dGU6DQo+Pj4+Pj4gRGVhciBhbGwsDQo+Pj4+Pj4NCj4+Pj4+PiBJIGFtIHdvcmtpbmcgb24gYW4g
QVJNLVY4IHNlcnZlciB3aXRoIHR3byBncHUgY2FyZHMgb24gaXQuDQo+Pj4+Pj4gUmVjZW50bHks
IEkgbmVlZCB0byB0ZXN0IHBjaWUgcGVlciB0byBwZWVyIGNvbW11bmljYXRpb24gYmV0d2Vlbg0K
Pj4+Pj4+IHRoZSB0d28gZ3B1IGNhcmRzLCBidXQgdGhlIHRocm91Z2hwdXQgaXMgb25seSA0R0Iv
cy4NCj4+Pj4+PiBBZnRlciBJIGV4cGxvcmVkIHRoZSBncHUncyBrZXJuZWwgbW9kZSBkcml2ZXIs
IEkgZm91bmQgaXQgd2FzDQo+Pj4+Pj4gdXNpbmcgdGhlIGRtYV9tYXBfcmVzb3VyY2UoKSBBUEkg
dG8gbWFwIHRoZSBwZWVyIGRldmljZSdzIE1NSU8NCj4+Pj4+PiBzcGFjZS4gVGhlIGFybSBpb21t
dSBkcml2ZXIgdGhlbiB3aWxsIGhhcmRjb2RlIGEgJ0lPTU1VX01NSU8nIHByb3QgaW4gdGhlIGxh
dGVyIGRtYSBtYXA6DQo+Pj4+Pj4gICAgICAgICAgIHN0YXRpYyBkbWFfYWRkcl90IGlvbW11X2Rt
YV9tYXBfcmVzb3VyY2Uoc3RydWN0IGRldmljZQ0KPj4+Pj4+ICpkZXYsIHBoeXNfYWRkcl90IHBo
eXMsDQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplX3Qgc2l6
ZSwgZW51bQ0KPj4+Pj4+IGRtYV9kYXRhX2RpcmVjdGlvbiBkaXIsIHVuc2lnbmVkIGxvbmcgYXR0
cnMpDQo+Pj4+Pj4gICAgICAgICAgICB7DQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgIHJldHVy
biBfX2lvbW11X2RtYV9tYXAoZGV2LCBwaHlzLCBzaXplLA0KPj4+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfaW5mb190b19wcm90KGRpciwNCj4+Pj4+
PiBmYWxzZSwNCj4+Pj4+PiBhdHRycykgfCBJT01NVV9NTUlPLA0KPj4+Pj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBkbWFfZ2V0X21hc2soZGV2KSk7DQo+Pj4+
Pj4gICAgICAgICAgICB9DQo+Pj4+Pj4NCj4+Pj4+PiBBbmQgdGhhdCB3aWxsIGZpbmFsbHkgc2V0
IHRoZSAnQVJNX0xQQUVfUFRFX01FTUFUVFJfREVWJyBhdHRyaWJ1dGUNCj4+Pj4+PiBpbiBQVEUs
IHdoaWNoIG1heSBoYXZlIGEgbmVnYXRpdmUgaW1wYWN0IG9uIHRoZSBwZXJmb3JtYW5jZSBvZiB0
aGUNCj4+Pj4+PiBwY2llIHBlZXIgdG8gcGVlciB0cmFuc2FjdGlvbnMuDQo+Pj4+Pj4gICAgICAg
ICAgICAvKg0KPj4+Pj4+ICAgICAgICAgICAgICogTm90ZSB0aGF0IHRoaXMgbG9naWMgaXMgc3Ry
dWN0dXJlZCB0byBhY2NvbW1vZGF0ZSBNYWxpIExQQUUNCj4+Pj4+PiAgICAgICAgICAgICAqIGhh
dmluZyBzdGFnZS0xLWxpa2UgYXR0cmlidXRlcyBidXQgc3RhZ2UtMi1saWtlIHBlcm1pc3Npb25z
Lg0KPj4+Pj4+ICAgICAgICAgICAgICovDQo+Pj4+Pj4gICAgICAgICAgICBpZiAoZGF0YS0+aW9w
LmZtdCA9PSBBUk1fNjRfTFBBRV9TMiB8fA0KPj4+Pj4+ICAgICAgICAgICAgICAgIGRhdGEtPmlv
cC5mbXQgPT0gQVJNXzMyX0xQQUVfUzIpIHsNCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgaWYg
KHByb3QgJiBJT01NVV9NTUlPKQ0KPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB0
ZSB8PSBBUk1fTFBBRV9QVEVfTUVNQVRUUl9ERVY7DQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAg
IGVsc2UgaWYgKHByb3QgJiBJT01NVV9DQUNIRSkNCj4+Pj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBwdGUgfD0gQVJNX0xQQUVfUFRFX01FTUFUVFJfT0lXQjsNCj4+Pj4+PiAgICAgICAg
ICAgICAgICAgICAgZWxzZQ0KPj4+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHB0ZSB8
PSBBUk1fTFBBRV9QVEVfTUVNQVRUUl9OQzsNCj4+Pj4+PiAgICAgICAgICAgIH0gZWxzZSB7DQo+
Pj4+Pj4gICAgICAgICAgICAgICAgICAgIGlmIChwcm90ICYgSU9NTVVfTU1JTykNCj4+Pj4+PiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBwdGUgfD0gKEFSTV9MUEFFX01BSVJfQVRUUl9JRFhf
REVWDQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8PCBBUk1fTFBB
RV9QVEVfQVRUUklORFhfU0hJRlQpOw0KPj4+Pj4+ICAgICAgICAgICAgICAgICAgICBlbHNlIGlm
IChwcm90ICYgSU9NTVVfQ0FDSEUpDQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
cHRlIHw9IChBUk1fTFBBRV9NQUlSX0FUVFJfSURYX0NBQ0hFDQo+Pj4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA8PCBBUk1fTFBBRV9QVEVfQVRUUklORFhfU0hJRlQpOw0K
Pj4+Pj4+ICAgICAgICAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gSSB0cmllZCB0byByZW1vdmUgdGhl
ICdJT01NVV9NTUlPJyBwcm90IGluIHRoZSBkbWFfbWFwX3Jlc291cmNlKCkNCj4+Pj4+PiBBUEkg
YW5kIHJlLWNvbXBpbGUgdGhlIGxpbnV4IGtlcm5lbCwgdGhlIHRocm91Z2hwdXQgdGhlbiBjYW4g
YmUgdXANCj4+Pj4+PiB0byAyOEdCL3MuDQo+Pj4+Pj4gSXMgdGhlcmUgYW4gZWxlZ2FudCB3YXkg
dG8gc29sdmUgdGhpcyBpc3N1ZSB3aXRob3V0IG1vZGlmeWluZyB0aGUgbGludXgga2VybmVsPw0K
Pj4+Pj4+IGUuZy4sIGEgc3Vic3RpdHV0aW9uIG9mIGRtYV9tYXBfcmVzb3VyY2UoKSBBUEk/DQo+
Pj4+PiBOb3QgcmVhbGx5LiBPdGhlciB1c2UtY2FzZXMgZm9yIGRtYV9tYXBfcmVzb3VyY2UoKSBp
bmNsdWRlIERNQQ0KPj4+Pj4gb2ZmbG9hZCBlbmdpbmVzIGFjY2Vzc2luZyBGSUZPIHJlZ2lzdGVy
cywgd2hlcmUgYWxsb3dpbmcNCj4+Pj4+IHJlb3JkZXJpbmcsIHdyaXRlLWdhdGhlcmluZywgZXRj
LiB3b3VsZCBiZSBhIHRlcnJpYmxlIGlkZWEuIFRodXMgaXQNCj4+Pj4+IG5lZWRzIHRvIGFzc3Vt
ZSBhICJzYWZlIiBNTUlPIG1lbW9yeSB0eXBlLCB3aGljaCBvbiBBcm0gbWVhbnMgRGV2aWNlLW5H
blJFLg0KPj4+Pj4NCj4+Pj4+IEhvd2V2ZXIsIHRoZSAicHJvcGVyIiBQQ0kgcGVlci10by1wZWVy
IHN1cHBvcnQgdW5kZXINCj4+Pj4+IENPTkZJR19QQ0lfUDJQRE1BIGVuZGVkIHVwIG1vdmluZyBh
d2F5IGZyb20gdGhlIGRtYV9tYXBfcmVzb3VyY2UoKQ0KPj4+Pj4gYXBwcm9hY2ggYW55d2F5LCBh
bmQgYWxsb3dzIHRoaXMga2luZCBvZiBkZXZpY2UgbWVtb3J5IHRvIGJlDQo+Pj4+PiB0cmVhdGVk
IG1vcmUgbGlrZSByZWd1bGFyIG1lbW9yeSAodmlhDQo+Pj4+PiBaT05FX0RFVklDRSkgcmF0aGVy
IHRoYW4gYXJiaXRyYXJ5IE1NSU8gcmVzb3VyY2VzLCBzbyB5b3VyIGJlc3QgYmV0DQo+Pj4+PiB3
b3VsZCBiZSB0byBnZXQgdGhlIEdQVSBkcml2ZXIgY29udmVydGVkIG92ZXIgdG8gdXNpbmcgdGhh
dC4NCj4+Pj4gVGhhbmtzIFJvYmluLg0KPj4+PiBTbyB5b3VyIHN1Z2dlc3Rpb24gaXMgd2UnZCBi
ZXR0ZXIgd29yayBvdXQgYSBuZXcgaW1wbGVtZW50YXRpb24ganVzdA0KPj4+PiBhcyB3aGF0IGl0
IGRvZXMgdW5kZXIgQ09ORklHX1BDSV9QMlBETUEgaW5zdGVhZCBvZiBqdXN0IHVzaW5nIHRoZQ0K
Pj4+PiBkbWFfbWFwX3Jlc291cmNlKCkgQVBJPw0KPj4+Pg0KPj4+PiBJIGhhdmUgZXhwbG9yZWQg
dGhlIEdQVSBkcml2ZXJzIGZyb20gQU1ELCBOdmlkaWEgYW5kIGhhYmFuYWxhYnMsDQo+Pj4+IGUu
Zy4sIGFuZCBmb3VuZCB0aGV5IGFsbCB1c2luZyB0aGUgZG1hX21hcF9yZXNvdXJjZSgpIEFQSSB0
byBtYXAgdGhlDQo+Pj4+IHBlZXIgZGV2aWNlJ3MgYmFyIGFkZHJlc3MuDQo+Pj4+IElmIHNvLCBp
cyBpdCBwb3NzaWJsZSB0byBiZSBhIGNvbW1vbiBwZXJmb3JtYW5jZSBpc3N1ZSBpbiBQQ0kNCj4+
Pj4gcGVlci10by1wZWVyIHNjZW5hcmlvPw0KPj4+IFRoYXQncyBub3QgYW4gaXNzdWUsIGJ1dCBl
eHBlY3RlZCBiZWhhdmlvci4NCj4+Pg0KPj4+IFdoZW4geW91IGVuYWJsZSBJT01NVSBldmVyeSB0
cmFuc2FjdGlvbiBuZWVkcyB0byBnbyB0aHJvdWdoIHRoZSByb290DQo+Pj4gY29tcGxleCBmb3Ig
YWRkcmVzcyB0cmFuc2xhdGlvbiBhbmQgeW91IGNvbXBsZXRlbHkgbG9zZSB0aGUNCj4+PiBwZXJm
b3JtYW5jZSBiZW5lZml0IG9mIFBDSWUgUDJQLg0KPj4gVGhhbmtzIENocmlzdGlhbi4gVGhhdCdz
IHRydWUuDQo+Pg0KPj4+IFRoaXMgaXMgYSBoYXJkd2FyZSBsaW1pdGF0aW9uIGFuZCBub3QgcmVh
bGx5IHJlbGF0ZWQgdG8NCj4+PiBkbWFfbWFwX3Jlc291cmNlKCkgaW4gYW55IHdheS4NCj4+Pg0K
Pj4gQnV0IHdoZW4gSSByZW1vdmVkIHRoZSAnSU9NTVVfTU1JTycgcHJvdCBpbiBkbWFfbWFwX3Jl
c291cmNlKCksIHRoZQ0KPj4gcGVyZm9ybWFjZSB3YXMgc2lnbmlmaWNhbnRseSBpbXByb3ZlZCAo
ZnJvbSA0R0IvcyB0byAyOEdCL3MpLCB3aGljaCB3YXMNCj4+IGFsbW9zdCB0aGUgc2FtZSBhcyB3
aGF0IGl0IGNhbiBiZSB3aGVuIElPTU1VIGRpc2FibGVkLiBTbyBJIGd1ZXNzIGluIG15IGNvbW1v
biBwY2kgdG9wb2xvZ3ksDQo+PiB3aGF0IHJlYWxseSBtYXR0ZXJzIG1heSBub3QgYmUgd2hldGhl
ciBJT01NVSBpcyBlbmFibGVkIG9yIG5vdCwgYnV0IGluIGZhY3QgdGhlIGF0dHJpYnV0ZXMgaW4g
ZG1hIG1hcHBpbmcgb3IgQVJNIFBURSBkb2VzLg0KPg0KPiBUaGUga2V5IHBvaW50IGlzIHRoYXQg
bm9ib2R5IHJlYWxseSBzdXBwb3J0cyB0aGF0IGNvbmZpZ3VyYXRpb24sIHNvIHlvdSBwcm9iYWJs
eQ0KPiB3aWxsIGZpbmQgbm9ib2R5IGxvb2tpbmcgaW50byBpdC4NCj4NCj4gQlRXOiBBUk0gaXNu
J3QgcmVhbGx5IHN1cHBvcnRlZCBhcyBhIHBsYXRmb3JtIGZvciBhbWRncHUgZWl0aGVyLiBFLmcu
IHdlIGhhdmUNCj4gc2VlbiB0b25zIG9mIGJvYXJkcyB3aGljaCBpbXBsZW1lbnQgdGhlIFBDSWUg
c3RhbmRhcmQgaW5jb3JyZWN0bHksIGlmIHlvdSBydW4NCj4gaW50byBhbnkgdHJvdWJsZSB3aXRo
IHRoYXQgeW91IGFyZSBwcmV0dHkgbXVjaCBvbiB5b3VyIG93bi4NCj4NCg0KVGhhbmtzIENocmlz
dGlhbi4gSSBhbSBnb2luZyB0byBkaXNhYmxlIElPTU1VIG9yIGRvIHNvbWUgdHJpY2tzIGluIFBD
SSBwZWVyLXRvLXBlZXIgc2NlbmFyaW8uDQoNCj4+IEkgZG9uJ3Qga25vdyBpZiB0aGVyZSBpcyBh
IHdheSB0byBtYWtlIHRoZSBtZW1vcnkgYXR0cmlidXRlcyBtb3JlIGNvbmZpZ3VyYWJsZSBpbiBv
cmRlciB0byBiZSBkaXN0aW5ndWlzaGVkDQo+PiBmcm9tIHRoZSAic2FmZSIgTU1JTyBtZW1vcnkg
dHlwZSwgd2hpY2ggb24gQXJtIG1lYW5zIERldmljZS1uR25SRSBhcyBSb2JpbiBzYWlkLg0KPg0K
PiBXZWxsIHdlIHdvdWxkIG5lZWQgdG8gZXh0ZW5kIGRtYV9tYXBfcmVzb3VyY2UoKSB0byBpbmNs
dWRlIHNvbWUgdXNlIGNhc2UNCj4gc28gdGhhdCB0aGUgbWFwcGluZyBhdHRyaWJ1dGVzIGRvbid0
IG5lZWQgdG8gYmUgZ3Vlc3NlZC4NCj4NCg0KSGkgUm9iaW4sIA0KDQpJcyB0aGVyZSBhbnkgY2hh
bmNlIHRvIGV4dGVuZCB0aGUgZG1hX21hcF9yZXNvdXJjZSgpIEFQSSBhcyBkaXNjdXNzZWQgYWJv
dmU/DQoNClNpbmNlcmVseSwNCktlbGx5DQoNCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFuLg0KPg0K
Pj4NCj4+IFNpbmNlcmVseSwNCj4+IEtlbGx5DQo+Pg0KPj4+IFJlZ2FyZHMsDQo+Pj4gQ2hyaXN0
aWFuLg0KPj4+DQo+Pj4+PiBUaGFua3MsDQo+Pj4+PiBSb2Jpbi4NCj4+Pj4+DQo+Pj4+Pj4gVGhh
bmsgeW91IQ0KPj4+Pj4+DQo+Pj4+Pj4gUGxhdGZvcm0gaW5mbzoNCj4+Pj4+PiBMaW51eCBrZXJu
ZWwgdmVyc2lvbjogNS4xMA0KPj4+Pj4+IFBDSUUgR0VONCB4MTYNCj4+Pj4+Pg0KPj4+Pj4+IFNp
bmNlcmVseSwNCj4+Pj4+PiBLZWxseQ0KPj4+Pj4+DQoNCg==
