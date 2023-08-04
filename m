Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8264B76FE2D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHDKLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjHDKLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:11:05 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A250D49C5;
        Fri,  4 Aug 2023 03:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thO5sufyAcYut/c1bA8T8ksP4yjpHWPxWdQcW/bveic=;
 b=1PZa2/ZcZFEg2E8DV5KGfXGcfn0Ot93aYYmpKYz138/Mm7zO3iztmbnDakz390xEIWeyhamRUqThgk6RYfbGIQGA0uV4wVIS2WIlTIXcc05+C3W8dlOOcXbiPTQMsZZSkjIrPMLu5wGtEwQEuK7yzfLGXEfTMKrTkDM/6Z1BFYE=
Received: from DB8P191CA0018.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::28)
 by PR3PR08MB5708.eurprd08.prod.outlook.com (2603:10a6:102:84::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 10:10:51 +0000
Received: from DBAEUR03FT021.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:130:cafe::5e) by DB8P191CA0018.outlook.office365.com
 (2603:10a6:10:130::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 10:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT021.mail.protection.outlook.com (100.127.142.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.48 via Frontend Transport; Fri, 4 Aug 2023 10:10:50 +0000
Received: ("Tessian outbound ba2f3d95109c:v145"); Fri, 04 Aug 2023 10:10:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4dfb057899f2df6d
X-CR-MTA-TID: 64aa7808
Received: from 34b7aa734e3d.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8AD29A02-7E8D-4D9A-81DC-04EF3A769AC1.1;
        Fri, 04 Aug 2023 10:10:44 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 34b7aa734e3d.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 04 Aug 2023 10:10:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4lCTnaQR5XEaT6pVLzywVqfNt2z12+Y00QhQfJE5HlGG9e7uMa1eJPVuLx20WDOqVFngr8TwfaV6MT7fSiZvmRnZ4ZhaGysndbTqI6qX4vxO7NWba2z2wR6UJsTwTCsz8vbEteHFk8uBfVn06fnKmP378pFdmw0HjnbLqNLFZJNCJLoW8b46tOdIMqfO0GtGmn9wP/3VT/uQtEjtNti+1lzby+P+nj3UpK0l2O+J9dAVwvcBBTML47IbCYe9YrkNw3u7wR/oQS+NmeFndggj5cs2WedE1XBAj74/3THJJdNyv0Ir0FzjmSMt4LHJBAHKEjeezHa6oltjfZg9baE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thO5sufyAcYut/c1bA8T8ksP4yjpHWPxWdQcW/bveic=;
 b=AknU7snjRUctQqHOO9Zl0ho32WaZxziBdHzyBn0yxPoN6YwemUuiHoCFguK5MmUfSZVa+JIKq88EKiTJpTVMjl5aBdbRYn/RGt8KT8F34LJpTi8E38troK3lj9/zO5uLkPxFUzj2TLdnSA3AZQW/UEZ9+J0Wtm6tvFB1gsdMjUGcg1DixAW/4YaV1xm8lpZ5pNRSorFMA7wfw/Qy0R0JEIYYfZQ/4ofx36KTZDxvMWDcWAzkMqlZLcrGWiXwIX2GKdbgYmwLoaZLYgD2bW2lMlKy8WR1Nb5lBADr1TOl4HukHNxsCI/kQWy75LieEJ88nCdxCB1i5s8oPDC22r35Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thO5sufyAcYut/c1bA8T8ksP4yjpHWPxWdQcW/bveic=;
 b=1PZa2/ZcZFEg2E8DV5KGfXGcfn0Ot93aYYmpKYz138/Mm7zO3iztmbnDakz390xEIWeyhamRUqThgk6RYfbGIQGA0uV4wVIS2WIlTIXcc05+C3W8dlOOcXbiPTQMsZZSkjIrPMLu5wGtEwQEuK7yzfLGXEfTMKrTkDM/6Z1BFYE=
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com (2603:10a6:10:303::14)
 by VE1PR08MB5869.eurprd08.prod.outlook.com (2603:10a6:800:1b2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 10:10:40 +0000
Received: from DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::9ea7:8451:f005:704d]) by DB9PR08MB7512.eurprd08.prod.outlook.com
 ([fe80::9ea7:8451:f005:704d%4]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 10:10:40 +0000
From:   Al Grant <Al.Grant@arm.com>
To:     James Clark <James.Clark@arm.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Mike Leach <mike.leach@linaro.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] coresight: etm: Make cycle count threshold user
 configurable
Thread-Topic: [PATCH] coresight: etm: Make cycle count threshold user
 configurable
Thread-Index: AQHZxo7SJwk5KsJnwEOgjuWw4bjf06/ZxJDAgAAOZwCAAApygIAAAVYg
Date:   Fri, 4 Aug 2023 10:10:40 +0000
Message-ID: <DB9PR08MB7512FB7B20A3320856A7E9D98609A@DB9PR08MB7512.eurprd08.prod.outlook.com>
References: <20230804044720.1478900-1-anshuman.khandual@arm.com>
 <DB9PR08MB7512B9A03A86B8983884B1C98609A@DB9PR08MB7512.eurprd08.prod.outlook.com>
 <92a176f4-c8ff-2ce0-c667-b134436452ee@arm.com>
 <2934f97e-bea8-42b0-c8f3-22340ddf3c85@arm.com>
In-Reply-To: <2934f97e-bea8-42b0-c8f3-22340ddf3c85@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 00F74FBF2DF2EF438184FFD248EAA7E3.0
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: DB9PR08MB7512:EE_|VE1PR08MB5869:EE_|DBAEUR03FT021:EE_|PR3PR08MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: c110467f-363d-4e5f-08a6-08db94d314b9
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: u002hGAPr8PWUUUjvaGt6qtTmTceFlFveP3KY2GX5uCSxfFvTvImkLIaeMw6WGtu2dxDHJy70iz5hTHfFwi7fO7vpriFHQi5QbWln1omu6aElV+pKlaCufBbEbtlhph12K7iPW6jWmPjNbLxOIVVCwN7rSDDPHZBtb7QZF2WpMbk7ZWtewOjzT/OxdezTCRYK72BiuklDeYNFOqSudQ3yy6P+lCInk3aTswpGMzWxFxOt0X+eudDAafJQpPpXK2YYy6i36sEihhoAA7LR4hpX1vpAWv9T58g+tpWg3l09u3kXgitNRQ1mvHeu/TR6JzugJlg5vmpL3OOjqJMUmrw700QvE2gqu7WvoLmFMO2WC5vKfdkHudtGiGmjesLd6aGmDJUtvuJPOKgIG/P1HHWaO1B1riMTyBLk5K2pSmbvNv5O8Xu9B+JRgy+ow1AyFY6aL9e9ShtLOZFg1rXVObNqsyWS+hdbzdS/QJeuUsG1D3jyMvV8BHtBSyJCCge/BDviwDseQ7g1gw+Thnp/cFvvp89SEnrvTWeyGctJEkwd3cWuyQuJMd+gjF6KDUfvoWhEkbLg41vIXNWGaLu02HBSNNcQ3aRcJpHao2fNW3OfNnkMd007EGOEqGeM0SXCvgh
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7512.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(451199021)(1800799003)(186006)(66446008)(66556008)(41300700001)(316002)(2906002)(76116006)(66946007)(64756008)(4326008)(66476007)(52536014)(8936002)(8676002)(5660300002)(122000001)(33656002)(26005)(38070700005)(6506007)(53546011)(83380400001)(86362001)(38100700002)(7696005)(478600001)(9686003)(54906003)(71200400001)(110136005)(55016003)(66899021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5869
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DBAEUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: a3c55f85-9daa-4870-fa0c-08db94d30e9f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Okzw0Jhx9tqlkjPARR6uELffp7m0eLn4rR0+DXUWhH+DuwiNrp9QsC72rm2m4SYMbYHlGfcMYjprUtrdP0cEMNLGkWH24bOoSc/aMO1YSyW/bYICpYyFsdnrr18I5co4hlO4QZimSnZTFbatuUC6SNQYCJgooPqSECp6E5CghMTJrImdX5KsI5OXpZM3CF2Cc+WAudcrkOjGz/OVcT5/AW3wmwFWMSA2MIs5vX3G6CwRYMEDV0RtyzxGBJoTy+3Edsn+s9WPJhkA6EbdLNUd4qraidmzrxfCYBhu3qN7u5Es6tl2z19nkig3hUEpXax5jv14+5JXw+JD14N2L8xZoGoZmUUovKvLuNVSnQg2ILmRczFHbDNnawvupSERrMRVNxY0GuVjnTAfym4bwdSQSk/us+3PxKnJ+em2Up8oeD/1jLCNkOyp7VDCtHqR71fl22sRjT8LD+dWv7CsHc4D1E7OhV0ssyaTJe5w9hWyegvRh5QNxHZNwW06zh05x4lLmtqi3ByAagGg6aCqRU+VIvi4c5rjCHu49rqUuea1FswkuJm6qD9oVyDLiiUjP+POdh+EU9hL0vmeBpo4jk1zm6MFJgZ3cOyWlBcEMmPyNqc/DHxy6Q2vbvAMVEQAWeFR7XU3s1VcDvm5l8CuvLu5N9ONlUZMYuNWjpzXqLf8GCeQ9ruQgEvbLSN4XdR3PfFS7f8dW0YNvZML26Km5YBfwcbC7aAPOgFQp0mXnj14cL57YlwIUO5Hl44EiRVlYCp
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199021)(1800799003)(186006)(82310400008)(46966006)(36840700001)(40470700004)(40460700003)(81166007)(83380400001)(336012)(53546011)(26005)(6506007)(47076005)(8676002)(9686003)(316002)(36860700001)(2906002)(70206006)(70586007)(5660300002)(4326008)(450100002)(41300700001)(8936002)(7696005)(52536014)(54906003)(478600001)(110136005)(40480700001)(55016003)(356005)(33656002)(86362001)(66899021)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 10:10:50.9581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c110467f-363d-4e5f-08a6-08db94d314b9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DBAEUR03FT021.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5708
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSmFtZXMgQ2xhcmsgPGph
bWVzLmNsYXJrQGFybS5jb20+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDQsIDIwMjMgMTA6MjMg
QU0NCj4gVG86IEFuc2h1bWFuIEtoYW5kdWFsIDxBbnNodW1hbi5LaGFuZHVhbEBhcm0uY29tPjsg
QWwgR3JhbnQNCj4gPEFsLkdyYW50QGFybS5jb20+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcNCj4gQ2M6IE1pa2UgTGVhY2ggPG1pa2UubGVhY2hAbGluYXJvLm9yZz47IGNv
cmVzaWdodEBsaXN0cy5saW5hcm8ub3JnOyBsaW51eC0NCj4gZG9jQHZnZXIua2VybmVsLm9yZzsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBjb3Jl
c2lnaHQ6IGV0bTogTWFrZSBjeWNsZSBjb3VudCB0aHJlc2hvbGQgdXNlcg0KPiBjb25maWd1cmFi
bGUNCj4gDQo+IA0KPiANCj4gT24gMDQvMDgvMjAyMyAwOTo0NSwgQW5zaHVtYW4gS2hhbmR1YWwg
d3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIDgvNC8yMyAxMzozNCwgQWwgR3JhbnQgd3JvdGU6DQo+
ID4+DQo+ID4+DQo+ID4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4gRnJvbTog
QW5zaHVtYW4gS2hhbmR1YWwgPGFuc2h1bWFuLmtoYW5kdWFsQGFybS5jb20+DQo+ID4+PiBTZW50
OiBGcmlkYXksIEF1Z3VzdCA0LCAyMDIzIDU6NDcgQU0NCj4gPj4+IFRvOiBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gPj4+IENjOiBBbnNodW1hbiBLaGFuZHVhbCA8QW5z
aHVtYW4uS2hhbmR1YWxAYXJtLmNvbT47IE1pa2UgTGVhY2gNCj4gPj4+IDxtaWtlLmxlYWNoQGxp
bmFyby5vcmc+OyBjb3Jlc2lnaHRAbGlzdHMubGluYXJvLm9yZzsNCj4gPj4+IGxpbnV4LWRvY0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4+IFN1Ympl
Y3Q6IFtQQVRDSF0gY29yZXNpZ2h0OiBldG06IE1ha2UgY3ljbGUgY291bnQgdGhyZXNob2xkIHVz
ZXINCj4gPj4+IGNvbmZpZ3VyYWJsZQ0KPiA+Pj4NCj4gPj4+IEN5Y2xlIGNvdW50aW5nIGlzIGVu
YWJsZWQsIHdoZW4gcmVxdWVzdGVkIGFuZCBzdXBwb3J0ZWQgYnV0IHdpdGggYQ0KPiA+Pj4gZGVm
YXVsdCB0aHJlc2hvbGQgdmFsdWUgRVRNX0NZQ19USFJFU0hPTERfREVGQVVMVCBpLmUgMHgxMDAg
Z2V0dGluZw0KPiA+Pj4gaW50byBUUkNDQ0NUTFIsIHJlcHJlc2VudGluZyB0aGUgbWluaW11bSBp
bnRlcnZhbCBiZXR3ZWVuIGN5Y2xlDQo+ID4+PiBjb3VudCB0cmFjZSBwYWNrZXRzLg0KPiA+Pj4N
Cj4gPj4+IFRoaXMgbWFrZXMgY3ljbGUgdGhyZXNob2xkIHVzZXIgY29uZmlndXJhYmxlLCBmcm9t
IHRoZSB1c2VyIHNwYWNlDQo+ID4+PiB2aWEgcGVyZiBldmVudCBhdHRyaWJ1dGVzLiBBbHRob3Vn
aCBpdCBmYWxscyBiYWNrIHVzaW5nDQo+ID4+PiBFVE1fQ1lDX1RIUkVTSE9MRF9ERUZBVUxULCBp
biBjYXNlIG5vIGV4cGxpY2l0IHJlcXVlc3QuIEFzIGV4cGVjdGVkIGl0DQo+IGNyZWF0ZXMgYSBz
eXNmcyBmaWxlIGFzIHdlbGwuDQo+ID4+Pg0KPiA+Pj4gL3N5cy9idXMvZXZlbnRfc291cmNlL2Rl
dmljZXMvY3NfZXRtL2Zvcm1hdC9jY190aHJlc2hvbGQNCj4gPj4+DQo+ID4+PiBOZXcgJ2NjX3Ro
cmVzaG9sZCcgdXNlcyAnZXZlbnQtPmF0dHIuY29uZmlnMycgYXMgbm8gbW9yZSBzcGFjZSBpcw0K
PiA+Pj4gYXZhaWxhYmxlIGluICdldmVudC0+YXR0ci5jb25maWcxJyBvciAnZXZlbnQtPmF0dHIu
Y29uZmlnMicuDQo+ID4+Pg0KPiA+Pj4gQ2M6IFN1enVraSBLIFBvdWxvc2UgPHN1enVraS5wb3Vs
b3NlQGFybS5jb20+DQo+ID4+PiBDYzogTWlrZSBMZWFjaCA8bWlrZS5sZWFjaEBsaW5hcm8ub3Jn
Pg0KPiA+Pj4gQ2M6IEphbWVzIENsYXJrIDxqYW1lcy5jbGFya0Bhcm0uY29tPg0KPiA+Pj4gQ2M6
IExlbyBZYW4gPGxlby55YW5AbGluYXJvLm9yZz4NCj4gPj4+IENjOiBjb3Jlc2lnaHRAbGlzdHMu
bGluYXJvLm9yZw0KPiA+Pj4gQ2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
Zw0KPiA+Pj4gQ2M6IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gPj4+IENjOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBBbnNodW1hbiBLaGFu
ZHVhbCA8YW5zaHVtYW4ua2hhbmR1YWxAYXJtLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIERvY3Vt
ZW50YXRpb24vdHJhY2UvY29yZXNpZ2h0L2NvcmVzaWdodC5yc3QgICAgICAgIHwgIDIgKysNCj4g
Pj4+ICBkcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LWV0bS1wZXJmLmMgICB8
ICAyICsrDQo+ID4+PiAgZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC1ldG00
eC1jb3JlLmMgfCAxMg0KPiA+Pj4gKysrKysrKysrKy0tDQo+ID4+PiAgMyBmaWxlcyBjaGFuZ2Vk
LCAxNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1n
aXQgYS9Eb2N1bWVudGF0aW9uL3RyYWNlL2NvcmVzaWdodC9jb3Jlc2lnaHQucnN0DQo+ID4+PiBi
L0RvY3VtZW50YXRpb24vdHJhY2UvY29yZXNpZ2h0L2NvcmVzaWdodC5yc3QNCj4gPj4+IGluZGV4
IDRhNzFlYTZjYjM5MC4uYjg4ZDgzYjU5NTMxIDEwMDY0NA0KPiA+Pj4gLS0tIGEvRG9jdW1lbnRh
dGlvbi90cmFjZS9jb3Jlc2lnaHQvY29yZXNpZ2h0LnJzdA0KPiA+Pj4gKysrIGIvRG9jdW1lbnRh
dGlvbi90cmFjZS9jb3Jlc2lnaHQvY29yZXNpZ2h0LnJzdA0KPiA+Pj4gQEAgLTYyNCw2ICs2MjQs
OCBAQCBUaGV5IGFyZSBhbHNvIGxpc3RlZCBpbiB0aGUgZm9sZGVyDQo+ID4+PiAvc3lzL2J1cy9l
dmVudF9zb3VyY2UvZGV2aWNlcy9jc19ldG0vZm9ybWF0Lw0KPiA+Pj4gICAgICogLSB0aW1lc3Rh
bXANCj4gPj4+ICAgICAgIC0gU2Vzc2lvbiBsb2NhbCB2ZXJzaW9uIG9mIHRoZSBzeXN0ZW0gd2lk
ZSBzZXR0aW5nOg0KPiA+Pj4gOnJlZjpgRVRNdjRfTU9ERV9USU1FU1RBTVANCj4gPj4+ICAgICAg
ICAgPGNvcmVzaWdodC10aW1lc3RhbXA+YA0KPiA+Pj4gKyAgICogLSBjY190cmVzaG9sZA0KPiA+
Pg0KPiA+PiBTcGVsbGluZzogY2NfdGhyZXNob2xkDQo+ID4NCj4gPiBXaWxsIGZpeCB0aGlzLCBi
ZXNpZGVzIGRvZXMgaXQgcmVxdWlyZSBzb21lIG1vcmUgZGVzY3JpcHRpb24gZm9yIHRoaXMNCj4g
PiBuZXcgY29uZmlnIG9wdGlvbiBpLmUgY2NfdGhyZXNob2xkID8NCj4gPg0KPiA+Pg0KPiA+Pj4g
KyAgICAgLSBDeWNsZSBjb3VudCB0cmVzaGhvbGQgdmFsdWUNCj4gPj4+DQo+ID4+PiAgSG93IHRv
IHVzZSB0aGUgU1RNIG1vZHVsZQ0KPiA+Pj4gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3dHJhY2luZy9jb3Jlc2lnaHQvY29yZXNpZ2h0LWV0
bS1wZXJmLmMNCj4gPj4+IGIvZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC1l
dG0tcGVyZi5jDQo+ID4+PiBpbmRleCA1Y2E2Mjc4YmFmZjQuLjA5Zjc1ZGZmYWU2MCAxMDA2NDQN
Cj4gPj4+IC0tLSBhL2RyaXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQtZXRtLXBl
cmYuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy9od3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC1l
dG0tcGVyZi5jDQo+ID4+PiBAQCAtNjgsNiArNjgsNyBAQCBQTVVfRk9STUFUX0FUVFIocHJlc2V0
LAkJImNvbmZpZzowLTMiKTsNCj4gPj4+ICBQTVVfRk9STUFUX0FUVFIoc2lua2lkLAkJImNvbmZp
ZzI6MC0zMSIpOw0KPiA+Pj4gIC8qIGNvbmZpZyBJRCAtIHNldCBpZiBhIHN5c3RlbSBjb25maWd1
cmF0aW9uIGlzIHNlbGVjdGVkICovDQo+ID4+PiAgUE1VX0ZPUk1BVF9BVFRSKGNvbmZpZ2lkLAki
Y29uZmlnMjozMi02MyIpOw0KPiA+Pj4gK1BNVV9GT1JNQVRfQVRUUihjY190aHJlc2hvbGQsCSJj
b25maWczOjAtMTEiKTsNCj4gPj4+DQo+ID4+Pg0KPiA+Pj4gIC8qDQo+ID4+PiBAQCAtMTAxLDYg
KzEwMiw3IEBAIHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpldG1fY29uZmlnX2Zvcm1hdHNfYXR0
cltdID0gew0KPiA+Pj4gIAkmZm9ybWF0X2F0dHJfcHJlc2V0LmF0dHIsDQo+ID4+PiAgCSZmb3Jt
YXRfYXR0cl9jb25maWdpZC5hdHRyLA0KPiA+Pj4gIAkmZm9ybWF0X2F0dHJfYnJhbmNoX2Jyb2Fk
Y2FzdC5hdHRyLA0KPiA+Pj4gKwkmZm9ybWF0X2F0dHJfY2NfdGhyZXNob2xkLmF0dHIsDQo+ID4+
PiAgCU5VTEwsDQo+ID4+PiAgfTsNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9o
d3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC1ldG00eC1jb3JlLmMNCj4gPj4+IGIvZHJpdmVy
cy9od3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC1ldG00eC1jb3JlLmMNCj4gPj4+IGluZGV4
IDlkMTg2YWY4MWVhMC4uOWEyNzY2ZjY4NDE2IDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9o
d3RyYWNpbmcvY29yZXNpZ2h0L2NvcmVzaWdodC1ldG00eC1jb3JlLmMNCj4gPj4+ICsrKyBiL2Ry
aXZlcnMvaHd0cmFjaW5nL2NvcmVzaWdodC9jb3Jlc2lnaHQtZXRtNHgtY29yZS5jDQo+ID4+PiBA
QCAtNjQ0LDcgKzY0NCw3IEBAIHN0YXRpYyBpbnQgZXRtNF9wYXJzZV9ldmVudF9jb25maWcoc3Ry
dWN0DQo+ID4+PiBjb3Jlc2lnaHRfZGV2aWNlICpjc2RldiwNCj4gPj4+ICAJc3RydWN0IGV0bXY0
X2NvbmZpZyAqY29uZmlnID0gJmRydmRhdGEtPmNvbmZpZzsNCj4gPj4+ICAJc3RydWN0IHBlcmZf
ZXZlbnRfYXR0ciAqYXR0ciA9ICZldmVudC0+YXR0cjsNCj4gPj4+ICAJdW5zaWduZWQgbG9uZyBj
ZmdfaGFzaDsNCj4gPj4+IC0JaW50IHByZXNldDsNCj4gPj4+ICsJaW50IHByZXNldCwgY2NfdGhy
ZXNob2xkOw0KPiA+Pj4NCj4gPj4+ICAJLyogQ2xlYXIgY29uZmlndXJhdGlvbiBmcm9tIHByZXZp
b3VzIHJ1biAqLw0KPiA+Pj4gIAltZW1zZXQoY29uZmlnLCAwLCBzaXplb2Yoc3RydWN0IGV0bXY0
X2NvbmZpZykpOyBAQCAtNjY3LDcgKzY2NywxNQ0KPiA+Pj4gQEAgc3RhdGljIGludCBldG00X3Bh
cnNlX2V2ZW50X2NvbmZpZyhzdHJ1Y3QgY29yZXNpZ2h0X2RldmljZSAqY3NkZXYsDQo+ID4+PiAg
CWlmIChhdHRyLT5jb25maWcgJiBCSVQoRVRNX09QVF9DWUNBQ0MpKSB7DQo+ID4+PiAgCQljb25m
aWctPmNmZyB8PSBUUkNDT05GSUdSX0NDSTsNCj4gPj4+ICAJCS8qIFRSTTogTXVzdCBwcm9ncmFt
IHRoaXMgZm9yIGN5Y2FjYyB0byB3b3JrICovDQo+ID4+PiAtCQljb25maWctPmNjY3RsciA9IEVU
TV9DWUNfVEhSRVNIT0xEX0RFRkFVTFQ7DQo+ID4+PiArCQljY190cmVzaG9sZCA9IGF0dHItPmNv
bmZpZzMgJiBFVE1fQ1lDX1RIUkVTSE9MRF9NQVNLOw0KPiA+Pg0KPiA+PiBTcGVsbGluZyBhZ2Fp
bg0KPiA+DQo+ID4gWWlrZXMsIHRoaXMgZG9lcyBub3QgZXZlbiBidWlsZC4gU2VlbXMgbGlrZSBJ
IGhhZCBtaXNzZWQgdGhlDQo+ID4gYXBwbGljYWJsZSBjb25maWcgaS5lIENPTkZJR19DT1JFU0lH
SFRfU09VUkNFX0VUTTRYIHRoaXMgdGltZSBhcm91bmQuDQo+IEFwb2xvZ2llcy4NCj4gPg0KPiA+
Pg0KPiA+Pj4gKwkJaWYgKGNjX3RyZXNob2xkKSB7DQo+ID4+PiArCQkJaWYgKGNjX3RyZXNob2xk
IDwgZHJ2ZGF0YS0+Y2NpdG1pbikNCj4gPj4+ICsJCQkJY29uZmlnLT5jY2N0bHIgPSBkcnZkYXRh
LT5jY2l0bWluOw0KPiA+Pj4gKwkJCWVsc2UNCj4gPj4+ICsJCQkJY29uZmlnLT5jY2N0bHIgPSBj
Y190aHJlc2hvbGQ7DQo+ID4+PiArCQl9IGVsc2Ugew0KPiA+Pj4gKwkJCWNvbmZpZy0+Y2NjdGxy
ID0gRVRNX0NZQ19USFJFU0hPTERfREVGQVVMVDsNCj4gPj4+ICsJCX0NCj4gPj4NCj4gPj4gQ29u
c2lkZXIgZHJvcHBpbmcgdGhlIGNoZWNrIGFnYWluc3QgQ0NJVE1JTi4gVGhlcmUgYXJlIENQVXMg
d2hlcmUNCj4gPj4gQ0NJVE1JTiBpcyBpbmNvcnJlY3QsIGUuZy4gc2VlIHB1Ymxpc2hlZCBlcnJh
dGEgMTQ5MDg1MyB3aGVyZSB0aGUNCj4gPj4gdmFsdWUgMHgxMDAgc2hvdWxkIGJlIDBiMTAwIGku
ZS4gNC4gT24gdGhlc2UgRVRNcyBpdCBpcyBwb3NzaWJsZSB0bw0KPiA+PiBzZXQgdGhlIHRpbWlu
ZyB0aHJlc2hvbGQgdG8gZm91ciBjeWNsZXMgaW5zdGVhZCBvZiAyNTYgY3ljbGVzLA0KPiA+PiBw
cm92aWRpbmcgbXVjaCBiZXR0ZXIgdGltaW5nIHJlc29sdXRpb24uIFRoZSBrZXJuZWwgY3VycmVu
dGx5IGRvZXMNCj4gPj4gbm90IHdvcmsgYXJvdW5kIHRoaXMgZXJyYXRhIGFuZCB1c2VzIHRoZSBp
bmNvcnJlY3QgdmFsdWUgb2YgY2NpdG1pbi4NCj4gPj4gSWYgeW91IGRyb3AgdGhlIGNoZWNrLCBh
bmQgdHJ1c3QgdGhlIHZhbHVlIHByb3ZpZGVkIGJ5IHVzZXJzcGFjZSwgeW91DQo+ID4+IGFsbG93
IHVzZXJzcGFjZSB0byB3b3JrIGFyb3VuZCBpdC4NCj4gPiBXaHkgPyBXZSBjb3VsZCBqdXN0IHdv
cmsgYXJvdW5kIHRoZSBlcnJhdGEgIzE0OTA4NTMgd2hpbGUgaW5pdGlhbGl6aW5nDQo+ID4gdGhl
IGRydmRhdGEtPmNjaXRtaW4gaWYgdGhhdCBpcyB3aGVyZSB0aGUgcHJvYmxlbSBleGlzdHMuDQo+
IA0KPiANCj4gPiBJIGRvbnQgdGhpbmsNCj4gPiB1c2VyIHNwYWNlIHNob3VsZCBiZSByZXF1aXJl
ZCB0byBrbm93IGFib3V0IHRoZSBlcnJhdGFzLCBhbmQgcHJvdmlkZSBhDQo+IA0KPiBJIHRoaW5r
IHRoYXQgYmVjb21lcyBsZXNzIHRydWUgZm9yIHRoZSB0cmFjaW5nIGFuZCBQTVUgc3R1ZmYuIElm
IHlvdSBhcmUgdXNpbmcgaXQgeW91DQo+IGxpa2VseSBuZWVkIHRvIGtub3cgYSBsb3QgYWJvdXQg
dGhlIHBsYXRmb3JtIHlvdSBhcmUgd29ya2luZyBvbiBhbnl3YXkuDQo+IA0KPiBGb3IgZXhhbXBs
ZSByaWdodCBub3cgSSdtIHRyeWluZyB0byB1cHN0cmVhbSBzb21lIG1ldHJpYyBmb3JtdWxhcyB3
aGljaCBoYXZlIGENCj4gd29ya2Fyb3VuZCB3aGVyZSB1c2Vyc3BhY2UgbmVlZHMgdG8ga25vdyB0
aGUgdmFyaWFudCBvZiB0aGUgcHJvY2Vzc29yLiBJdCdzIG5vdA0KPiBwb3NzaWJsZSBmb3IgdGhl
IGtlcm5lbCB0byBkbyBhbnl0aGluZyBhYm91dCBpdC4NCj4gDQo+IEluIHRoaXMgY2FzZSBhcyBp
dCdzIG9ubHkgb25lIGtub3duIGVycmF0YSB3ZSBjb3VsZCBhZGQgdGhlIHdvcmthcm91bmQuDQo+
IA0KPiBVbmxlc3Mgd2UgZXhwZWN0IHRoZXJlIHRvIGJlIHRoZSBzYW1lIGlzc3VlIGFnYWluIGlu
IHRoZSBmdXR1cmU/IE9yIHdlIGtub3cNCj4gdGhlcmUgYXJlIGFscmVhZHkgbW9yZSBDUFVzIHRo
YW4gIzE0OTA4NTMgbWVudGlvbnM/DQoNCkl0J3MgYSBjb21tb24tbW9kZSBmYWlsdXJlIGFmZmVj
dGluZyBzZXZlcmFsIENQVXMsIGVhY2ggd2l0aCB0aGVpcg0Kb3duIHNldCBvZiBhZmZlY3RlZC9m
aXhlZCB2ZXJzaW9ucywgc28gdGhlcmUgd291bGQgYmUgc2V2ZXJhbCBNSURScw0KdG8gY2hlY2su
IFRoZSBvbmVzIHRoYXQgaGF2ZSBiZWVuIHB1Ymxpc2hlZCBpbiBlcnJhdGEgbm90aWNlcyBpbmNs
dWRlOg0KDQotICMxNDkwODUzOiBOZW92ZXJzZSBOMSwgZml4ZWQgcjRwMQ0KLSAjMTQ5MDg1Mzog
Q29ydGV4LUE3NiwgZml4ZWQgcjRwMSAobi5iLiBzYW1lIG51bWJlciBhcyBhYm92ZSkNCi0gIzE2
MTk4MDE6IE5lb3ZlcnNlIFYxLCBmaXhlZCByMXAwDQotICMxNTAyODU0OiBDb3J0ZXgtWDEsIGZp
eGVkIHIxcDANCi0gIzE0OTEwMTU6IENvcnRleC1BNzcsIGZpeGVkIHIxcDENCg0KSG9wZWZ1bGx5
IHRoYXQncyB0aGUgbG90Lg0KDQpGb3IgdGhpcyBpc3N1ZSB5b3UgZG9uJ3QgcmVhbGx5IG5lZWQg
dG8gY2hlY2sgdGhlIGZpeCB2ZXJzaW9uLCBhcyB0aGUNCm51bWJlciB5b3UnZCBwdXQgaW4gY2Np
dG1pbiBpcyB0aGUgc2FtZSBhbnl3YXkuDQoNCkFsDQoNCg0KPiANCj4gPiByaWdodCB2YWx1ZSBp
bnN0ZWFkLg0KPiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQo+ID4gQ29yZVNpZ2h0IG1haWxpbmcgbGlzdCAtLSBjb3Jlc2lnaHRAbGlzdHMubGluYXJv
Lm9yZyBUbyB1bnN1YnNjcmliZQ0KPiA+IHNlbmQgYW4gZW1haWwgdG8gY29yZXNpZ2h0LWxlYXZl
QGxpc3RzLmxpbmFyby5vcmcNCg==
