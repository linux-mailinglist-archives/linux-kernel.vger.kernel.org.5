Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405C2759140
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjGSJLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbjGSJLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:11:12 -0400
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4781735;
        Wed, 19 Jul 2023 02:11:09 -0700 (PDT)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36J8ck3S024125;
        Wed, 19 Jul 2023 02:10:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:references:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        PPS06212021; bh=J0A3+qU8ff5azVAzr/h5COrwHKoHILlQC0D5OZ5hlQM=; b=
        pX/DS2uN0m27rGTlUxbfTYYCSCj67Q0pCcFjrDK1FldzW5AvIP7825gUujTVYB/Y
        vF5D/evjF8p28I70eNSt6/m9cKPDPG7xha4wJ0dCtGurVn2PeEsSxvDKnumU1iID
        9MluzjQMMp6ux4+yl+3T5DRwn0jyoXZpY24acEIpSpbhM8UewGpKzR0/L9SLkW6e
        3YzDPwq6WW1nOIR+pk6M0mMQC7+E+OFCBXkMEzB46JXVDYdv/B0NUCf7rDp7sRBC
        XQQ5ch7UNuKPNCNBDTS2P85TiR1Itnu7DKpw1XNu8GQ2cUK6TM3oyFzdWz9zLJgz
        a63+8NmUCHWvFfjZEhSXsw==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3rutyeub3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 02:10:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+rbuvuZl0nQ0cWHkSam37IHHVkc874jJB8ejJ/OSQJXYIhhD2PzeZxo/55ZcTrwjeHULDbMBgZoB53dAahfyXKY+EaE93SySIMuYUyG3DHXYSoYjbE9lZfcXzdaIFTYc0xq2VY1Kp++v/MdwiwsGKGQTEu2yN1FNpvNTjcHxQI+3vYpe4CUDe3NWvl44Li/K5Q/qbWy27VEo0Fd0TiqBrpG7Mzitm9zBdnoD4ykK5iG2ga26fiYkb1+6A/pX4T+r4j5hQdvbynQ+omMSuXWGpQCTEBJYmNnA3kwYwSy5B+E0S+yieYwp7CcNbV0sg3ERc0/0YKo80gGIw7WFsRYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0A3+qU8ff5azVAzr/h5COrwHKoHILlQC0D5OZ5hlQM=;
 b=m5D8QOqnKJdy1Rb+dXMH8SySRIkjCBMjnM1easSSDF8fU1a0dQZcce3HiyGV6BjQaV0lrKRunH7g9GTC6coB1lbkeSxz1HnqP+r6nYRp7SnKx7bGj/WRF7jFXWULXJfbIcdIa//iR4M+VKJoySXCk92R9nQUhqYguRAmsB5GjMPzWqERlw+02aVkViF6eU+kbQYNiQwbV+u66IivfVaFNbIv42akJw0Z9HAXRoZU5O6XLpQWOX8iC5qFKyGyk6baO9qhKQXS/+1hSDIXEequAsfAYa0GqQb+Y9XQHqq1ROHWuK1x48jlUFhzqdiQlZ915bvRVnbewXnZow9dEG58UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH7PR11MB6980.namprd11.prod.outlook.com (2603:10b6:510:208::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Wed, 19 Jul
 2023 09:10:52 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::e4:3974:df17:77c9%3]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 09:10:52 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] usb: dwc2: Add platform specific data for Intel
 Stratix10 platform
Thread-Topic: [PATCH 1/3] usb: dwc2: Add platform specific data for Intel
 Stratix10 platform
Thread-Index: AQHZuex8lCCFj6hBJECqNS8Nyv3wmq/Ao7EAgAAjSXA=
Date:   Wed, 19 Jul 2023 09:10:52 +0000
Message-ID: <PH0PR11MB519152C26157460397FA73E2F139A@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20230719025509.3007986-1-Meng.Li@windriver.com>
 <20230719025509.3007986-2-Meng.Li@windriver.com>
 <ec93a939-883d-5778-2f32-69eb370c9768@linaro.org>
In-Reply-To: <ec93a939-883d-5778-2f32-69eb370c9768@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5191:EE_|PH7PR11MB6980:EE_
x-ms-office365-filtering-correlation-id: 5e5d61f1-9a38-4d09-cd82-08db88380d15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /YNXPddSU41iqHOTsg9tBL4WxH7VRIr0BOUQtxbgSqxUe1GaWt+LnxqWKLrLZCW/moyUmYMxNGv1R6liy4dG6Y3YbP3vnPnAnlj597aJVgDI0FCdwvtKdot1LWDsqIwTI0Ebrg87X8xk92XYY5IBgKCbiPrgCCU7bD3Irp+4s8+fedn6bYZay0FPR7fiJAYlf1aYrOPlWVQ79JlxkM/ETcWTeqZioTcJI/RM/VdlMrqbGSoh++zeLuKA0aG2XKEsxYItRZSnAQ7XqZJvYv9go1bgrdiWVYqNR1Z+tKQpD9Dmgk6srZPSB1LRK+lI1W03PnlxzTqwUFI2hVbyK2pJfVh982IvtMsaA2G7HNGtEOJ0Uu6/dqiGGp22gqZShJ9q7U8gbs3f8shN6aveqzGZp3vonYvtNPFi3LyAqLbJSwwElC9WNhzNpNiQlYs2hc9LdOXrhAxoktfNo3vvFrW5Ql75JbYY3HsIbf7OpEv8Akyx+2Pe4WPeiVsnnu92lcS5wF8FGqYtjgCOEjd6jMr26qqpt3VZeoELqjOvNO5P2PkdHIdw97KZbn+Kk60IDqbPIfYuQ68gFUPTZHn7LNOaMkS1OyDayx51Jtoz1EacmRy4pcGQ/yaResqJVizczdXf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(396003)(39850400004)(346002)(136003)(451199021)(66946007)(83380400001)(64756008)(66446008)(66556008)(122000001)(41300700001)(5660300002)(38070700005)(86362001)(33656002)(7416002)(8936002)(8676002)(52536014)(38100700002)(71200400001)(9686003)(7696005)(110136005)(66476007)(55016003)(4326008)(478600001)(2906002)(316002)(76116006)(186003)(53546011)(6506007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGZWQU1mSzBhbzZsTHlGd0pQMTBwNEUxV21PK3dwbkUzb29Xa1ZQQk05bXRu?=
 =?utf-8?B?c0tPdUhLdXlTMCs1TmR1YStFS092Q0VyUzhZSEw1MkRpVkNkeXRIbit4ZmtB?=
 =?utf-8?B?cVczU3ZWWmFZWEdlc2FtQ2FmSlFzekNkY3dFL1N5czJRTHE5c2FreVR6eGk1?=
 =?utf-8?B?VjZxZDQ5VFNEU2VKREtKTE16dThMOEhCWWRCdExoMlpQQ1NtNHpTZXpzSmVh?=
 =?utf-8?B?bk81SWxQTGRIbnhjbzh5N2ZIcjFaaVJvSnZyeFdTbVF5K3FmU0Uxb1lFb21C?=
 =?utf-8?B?bEpUZCsvZFE4VnpHSXpnLzJPb2hhdndDeU5zeldYV09DV3ZXbHZBUFFRWFhX?=
 =?utf-8?B?OTAzcEtBaVdDcEpwc3lMTlBwSG1STnlvd0pTUXdWV0hEZFA3QkRPZCticWlJ?=
 =?utf-8?B?b0RPUmhVd2IwZ0V2bzVVUVhBVURSZnRsOTNTQy9MVjA5NHJ5aERQYzk1aHRX?=
 =?utf-8?B?aVVlNjNVZ2hTdHJ2SG13RFhRTVNURy9Ic3VCazR5RDZOR3hCeEsvd1Z0T3lH?=
 =?utf-8?B?UnI5OUNSSHJJWGNlZkl2cEZOV1ExUHRiZlhrS3haa2hKM0RPeklyZUhLM1Iz?=
 =?utf-8?B?eUtldCtCbDUzQnU4LytQOXFKSk1aZG9VWGJyeUpvQ1FaNTI2dzViQ1JDOS93?=
 =?utf-8?B?QWpOTnBrNWV5ZzQyaXFHTXlMdXVRZjA1bkZhSFRtZ1Mva3BDYXBsQStPNnly?=
 =?utf-8?B?MnhBQmsxV1pndkpmUDR2aXhLWXpUc1RjNWMrM01FMzNJTmoxeW84NDZSNzk0?=
 =?utf-8?B?M3o0dzhQV2JERjdOejB3K3NxWkNnSHdvMDBVbi9tNjdkU1BGb2F5RkJldUF0?=
 =?utf-8?B?MU5wSWFUUmo3aEJKR2NyQWlxUzZxRmIxbDhOdVNwSTFQT1NuSEJvOWtZZVlQ?=
 =?utf-8?B?S0VPaWJRNmMxRGovSmlJNzRLdUVYVWRrRjZyd3U3enJYcGdwbHV6OUhxejFH?=
 =?utf-8?B?b1lCTXBodTNVMlNDOWREOWRJM3ZhczJZYldPM3pFK3R1ZS9XS0dSNE5EK1Bo?=
 =?utf-8?B?WlRNT1JrYUxyaDZDU2g5d3huTnhic3JYUWN1cVBVWkNDNmJETDdUWDZPb1lE?=
 =?utf-8?B?YTJhcjNaKzlmaTlPbXhnVXAySjZYbkM5cVloL0M4R3UwYlV1RjZjRDVRc0Fu?=
 =?utf-8?B?bzVQeC8wbVo1d1R5MDFWalRSRXMzV2xPTzNRVHhoT2xKL2U1eGNrRUxCOXBZ?=
 =?utf-8?B?VEFNY2d1TUFsL2N5elpUS0V5aTk2c3gwdEZ4cjNDRzY5TW04ZzlzQXRFK2xi?=
 =?utf-8?B?bVhRU3NwN0dwN0Nhd0dJNnVobStYa3llZFArSTJqVzBnL0FmNWpBc29HQ2JR?=
 =?utf-8?B?b1ZhSmhHNWpwUHp1bFRNWkhpSkpIcnp6Y0QrWFdPcVc5alZRYVkzb2xpWno0?=
 =?utf-8?B?Z3lISFZubXUxZVBzVkYvUUVxME4vM2tIcThzWk80Y2pHeXluUTFNS0xtenBP?=
 =?utf-8?B?d2ZtanJRNHNEWFN6MnJVTGRtWW9EOHZ4Y1Rjc2orNkQvNW5hZkNGS0laRmlI?=
 =?utf-8?B?YVIrRjNKcEhvakc1UnVzbVZLQ2NNS1d2K3gxLzRTK2FwY0tsNjN5ampDRVFG?=
 =?utf-8?B?b0xPMkhrQjc4ZjdtQWp0ODZsWW5HVVk1eFRYN0V0Q3dkY01hNFNxR2t2cEww?=
 =?utf-8?B?cHJ3aHhEeFVNcHRLSTBwSXhUNlpScXAxc2swYjY3L1p2TGExT3B5dlFpVzc0?=
 =?utf-8?B?OGpYWGk0TUwrMXU1Z001dWNYWXBNMWpBTmFZQkFnNm9zRGlnZmplUjkzQ0U4?=
 =?utf-8?B?cDJVWDFsb2VEc3F1ZVplcTd2a0Q0Nmd4TXNLZ1BVYlRaUDRVNCtWSWx3clFP?=
 =?utf-8?B?ODVkalhEbStuUXpPcW11MFhqOXZMWlNyd3VjQ0JTQUZSNTlsUGIrWSsvR3cx?=
 =?utf-8?B?a0JSVXdYbldzb2J1L1dFUVVBNEhOeC93RWZ1UndoUmZVV2pIcGVLeTk1T0w3?=
 =?utf-8?B?ZW9ZRHZteWNXSnFpYjZ3QVFwaUp3bFdmSUQwRmwrNml3Yjhyc09ubU5aRVAy?=
 =?utf-8?B?NWZVMm8weGkwTUtBNTFxS1BJdHRISkxxQzVBTlNFU1pVdjkwNUd5TXRHemc3?=
 =?utf-8?B?VGcwa25WM2hpTmpmMjdYOWF2aFdFSXFLbHF5dFJ4Sm9OSFpsWDVUMElYekZD?=
 =?utf-8?Q?jX39pdg7mdK5SdA+hgeXBkfay?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5d61f1-9a38-4d09-cd82-08db88380d15
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 09:10:52.1737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ex6JLgTRA8xYFrf3kHZ2Iw/9SDZE0Ysqsv0Resz8mqEyZoruY56V0gv8F6uNsyt/1rzJgOJOVBkJ0KavYFbqBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6980
X-Proofpoint-ORIG-GUID: UOTMYGQXqDbZGefBGkjZntgZJrB0Zrqc
X-Proofpoint-GUID: UOTMYGQXqDbZGefBGkjZntgZJrB0Zrqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_05,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2306200000
 definitions=main-2307190084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEp1bHkgMTksIDIwMjMgMjo0MCBQTQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVy
LmNvbT47IGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7
IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsN
Cj4gZGluZ3V5ZW5Aa2VybmVsLm9yZzsgaG1pbmFzQHN5bm9wc3lzLmNvbTsgbGludXgtdXNiQHZn
ZXIua2VybmVsLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIHVzYjog
ZHdjMjogQWRkIHBsYXRmb3JtIHNwZWNpZmljIGRhdGEgZm9yIEludGVsIFN0cmF0aXgxMA0KPiBw
bGF0Zm9ybQ0KPiANCj4gQ0FVVElPTjogVGhpcyBlbWFpbCBjb21lcyBmcm9tIGEgbm9uIFdpbmQg
Uml2ZXIgZW1haWwgYWNjb3VudCENCj4gRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNo
bWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQNCj4ga25vdyB0aGUgY29u
dGVudCBpcyBzYWZlLg0KPiANCj4gT24gMTkvMDcvMjAyMyAwNDo1NSwgTWVuZyBMaSB3cm90ZToN
Cj4gPiBJbnRlbCBTdHJhdGl4MTAgaXMgdmVyeSB0aGUgc2FtZSB3aXRoIEFnaWxleCBwbGF0Zm9y
bSwgdGhlIERXQzIgSVAgb24NCj4gPiB0aGUgU3RyYXRpeCBwbGF0Zm9ybSBhbHNvIGRvZXMgbm90
IHN1cHBvcnQgY2xvY2stZ2F0aW5nLiBTbywgcmVmZXIgdG8NCj4gPiBjb21taXQgM2Q4ZDM1MDRk
MjMzKCJ1c2I6IGR3YzI6IEFkZCBwbGF0Zm9ybSBzcGVjaWZpYyBkYXRhIGZvciBJbnRlbCdzDQo+
ID4gQWdpbGV4IiksIGFkZCBwbGF0Zm9ybSBzcGVjaWZpYyBkYXRhIGZvciBJbnRlbCBTdHJhdGl4
MTAgcGxhdGZvcm0uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNZW5nIExpIDxNZW5nLkxpQHdp
bmRyaXZlci5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMgfCAy
ICsrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL3BhcmFtcy5jIGIvZHJpdmVycy91c2IvZHdjMi9wYXJh
bXMuYw0KPiA+IGluZGV4IDhlYWI1ZjM4YjExMC4uM2QwODVhZTFlY2Q4IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvdXNiL2R3YzIvcGFyYW1zLmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2My
L3BhcmFtcy5jDQo+ID4gQEAgLTI2Nyw2ICsyNjcsOCBAQCBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkIGR3YzJfb2ZfbWF0Y2hfdGFibGVbXSA9IHsNCj4gPiAgICAgICAgIC5kYXRhID0gZHdjMl9z
ZXRfc3RtMzJtcDE1X2hzb3RnX3BhcmFtcyB9LA0KPiA+ICAgICAgIHsgLmNvbXBhdGlibGUgPSAi
aW50ZWwsc29jZnBnYS1hZ2lsZXgtaHNvdGciLA0KPiA+ICAgICAgICAgLmRhdGEgPSBkd2MyX3Nl
dF9zb2NmcGdhX2FnaWxleF9wYXJhbXMgfSwNCj4gPiArICAgICB7IC5jb21wYXRpYmxlID0gImlu
dGVsLHNvY2ZwZ2Etc3RyYXRpeDEwLWhzb3RnIiwNCj4gPiArICAgICAgIC5kYXRhID0gZHdjMl9z
ZXRfc29jZnBnYV9hZ2lsZXhfcGFyYW1zIH0sDQo+IA0KPiBOQUsuIEkgYWxyZWFkeSB3cm90ZSB3
aHkuDQoNCklmIEkgZG9uJ3QgYWRkIHRoZSBTb0Mgc3BlY2lmaWMgY29tcGF0aWJsZSBlbnRyeSwg
aG93IEkgdXNlIHRvIHRoZSBzcGVjaWZpYyBkYXRhIG9uIFN0cmF0aXgxMCBwbGF0Zm9ybS4NCklm
IHlvdSB0aGluayB0aGUgbmV3IFNvQyBzcGVjaWZpYyBjb21wYXRpYmxlIGVudHJ5IGlzIG5vdCBu
ZWNlc3NhcnksIHRoZSBwYXRjaDIgYWxzbyBoYXMgaXNzdWUuDQoNClRoYW5rcywNCkxpbWVuZw0K
DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=
