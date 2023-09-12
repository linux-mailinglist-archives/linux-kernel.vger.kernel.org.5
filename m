Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB0879D14D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjILMog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbjILMoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:44:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAD0DC4;
        Tue, 12 Sep 2023 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694522668; x=1726058668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pSIegOY7xUWLy3kqa9b6gqNktLJoUzxAXCY1Hnx9/j8=;
  b=z0YMwY0xn8s7/ABgtGjfVo4XavC4kUfDvM8EHGS2TaHtyuJbeWDTB7Nm
   dKVgLnTk0elnld/weAy7IMO9oVUt6ONj1kMv+W2M5y7/ubyMDBDmuw9OZ
   xkMrXbx9gLKxKcD0mLubQXJrgZNzfqPd7ML6X2zT4jHkYcrf7aPf+KLq+
   B1GUC6dclZQgsDkS/WzbVok3IEYLAPNYvWOyO8HYfftraj13HIAPntLZp
   /+fGTGXW/grPSushS9cui4lAGYSVoSPQuC4pSDd16sT3WdtZHNaLZ/iXa
   DXh6Rh4SuR8k5vSdZyRZgn0azxUZUHtQdTI9zJmQLEt6y7rHo2zbhx89v
   w==;
X-CSE-ConnectionGUID: TyhfwFesQJGtxEuULbvpwQ==
X-CSE-MsgGUID: l+Lry/e+TwmW2AHPwEcN6w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="171182684"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Sep 2023 05:44:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 12 Sep 2023 05:44:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 12 Sep 2023 05:44:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TDMNqMq2yvWEhs/NzAHltlsMcd5lH63f+au1M5Bv82YEXtChJWs2tbNnmX/Oj88vZe/V/pUf5AZPJFJVuPBCho1VE6G8xF2xCXjyuovINpU1QOdIXhDUjWq8LCEC1qrzhK5MZWuekqpl6bOSaSZlaN228VkS/yjWgP7P9mntMSYNej8/9pKsR60o/r1uDc6X1bNl8u4uedizEcV9Lqmf+6TiSZnyv9/lWQiQIbzo8AlG6etmG+URZ4jNk6Dl6sUjVrQnSrobTN+m1h2ZEToNXsWX5zVkkIUKHMPFkkmIvZgH1tJSuuzwb+lFzStcBddQZnvCgqUGpD4wX2Iv7upx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pSIegOY7xUWLy3kqa9b6gqNktLJoUzxAXCY1Hnx9/j8=;
 b=Mzmg+5MWBvM4G373dhcaprl5p1DZA5ETu4GIToo4j4KZ/04R7zu6j8A5X6zzY8TIGfLZgK2VFJwD+qP2VXNihwTMqHzfvbzquHxMvLmeotbu/Yo5Sqzbq4Xl3LmMNK4vjPrO/d5aGqLlc9QrqYUj+TjJ7nF8yt8gccUhjwkK3d21uxAWqanP/QL+IJZe1aN1G99T6UhLSIwfo52KHgfkh5q3JPJmPaRKRAr5i3Le+YopBoeq+/k9ByaDqtlYagA00ljzWt7tHJgaqvyk6g7/80TKM92CJmrlEtfPHVXOXsCiWPE4oUN8SpYaq+hP0E9OjXP7TQ3wR2CXqT9Th70acA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pSIegOY7xUWLy3kqa9b6gqNktLJoUzxAXCY1Hnx9/j8=;
 b=SZpe7NQNVGh8ANHRuyjIYVY/RVi15N5kV3hxzwBoMNc1wuhIQOdMDROprdq+GXq+soAH6q1G4TXTvUC5NwCZr4dI+w++x/CpQOaWlqQbATdRWVw7I/kN/+5OMjzohJI045G8FM2VGrEJqPmsA4ba7ZeH1HB3CWzY6n4Q0VUwXH8=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH7PR11MB7429.namprd11.prod.outlook.com (2603:10b6:510:270::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.35; Tue, 12 Sep 2023 12:44:21 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::eb5d:6623:d0cf:d5e9]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::eb5d:6623:d0cf:d5e9%3]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 12:44:21 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <andrew@lunn.ch>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <Steen.Hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <Horatiu.Vultur@microchip.com>,
        <Woojung.Huh@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>
Subject: Re: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Thread-Topic: [RFC PATCH net-next 2/6] net: ethernet: add mac-phy interrupt
 support with reset complete handling
Thread-Index: AQHZ4mEM4q/YL0tg8UaR0849XBWWbrASgTgAgASnrwA=
Date:   Tue, 12 Sep 2023 12:44:21 +0000
Message-ID: <2db21ee1-17ba-b7ca-bcfb-110c0f66ef93@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-3-Parthiban.Veerasooran@microchip.com>
 <28dce908-3a87-48c8-b181-d859697c0152@lunn.ch>
In-Reply-To: <28dce908-3a87-48c8-b181-d859697c0152@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH7PR11MB7429:EE_
x-ms-office365-filtering-correlation-id: 85e9608b-08b0-47f0-8217-08dbb38dfc84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gKBAuOCmy7DC1EiaMlZjAO4Tfmo+3EQUDJk9AlD/rTHXIujFBElVC/scdHwrhKZiTTxAaYkptp+6UUrvCWzJsz2erhJe3Hs7AW7qCK0DBw/nnUJ5K2Bf4f5Ru+NJ09H0GO6+JCFZyQr2bpQIoLDxo7VDpPv2I5VDSxfmiZ/MEVM9s6jVVtHxdBvlL8aVmhzlHew4tGMuFFzONnO/FaK/Ormr+64XeG9LdDHJdbBAml8JxTf1wp7TyJpoSva6Cmc9k3JgrkOunjL4A13dW8fWgrmIgm7P6xTGuckCkOec3UvmpTPRZj32cxvD/g5D1nIiSY1mdMAR/xvG5Qe27+xi8C3S1qxQksbs4WfUXe4h/3WS86/U4gmu2QFaJxL13HSYVoADTJLNrFtUOSLlpqu/Gj9GTEAf9t+f4YbtKuA5rmHwPnAS9BJ7LrI6oYfbIZv/W8XTG/aRAwp/MmameF+H2zzltWY5TBIZoiiOKmf6FhVTqmmNwipccmN7I4NDc4+YgonL5TBQ1erg/3ctRFbJpcl8xm5V47+H6oJJRsIpP2idNwKpyk6FQ+4vvKJohHD9oXBSF4bz2Gwfoa0VnjVHwkmr+KV5TUU6IPRt59n6kuVL3NGdEN2IU+1iUUFU/ogPL4LYkR3HRvPkobpMWnicEHylRrtEZaZUz3iw3YTMx9+/4+/zj1B0nZ67SXLIZNKt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39850400004)(366004)(376002)(1800799009)(451199024)(186009)(2616005)(107886003)(8676002)(71200400001)(6506007)(53546011)(6486002)(478600001)(83380400001)(6512007)(26005)(5660300002)(8936002)(91956017)(7416002)(76116006)(4326008)(66446008)(64756008)(66556008)(6916009)(54906003)(316002)(66946007)(66476007)(2906002)(4744005)(86362001)(31696002)(36756003)(41300700001)(31686004)(122000001)(38100700002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RVdMZ2d4ZnNPOFJWbG9CTE9ybUE2NmFWWkF2K0xYZnNyREtteE1aeGlrUDJs?=
 =?utf-8?B?NW5oTm5KeXQ2MHJzSTE4L2tCVjNCZ2xCMXN2bklQNnBkb0VsSks1ZmprNGZj?=
 =?utf-8?B?Mm4vSE9WUzVDRjRvdFJZcjk5VnRlTFdsVGczdHErb25wOFludm9SdTd0M1JQ?=
 =?utf-8?B?NTdCa2pYN0E3TmFsZDNveTRPaCtoenQ3eGk2WEVmV3dpbTFNYnBIMytRbXZ6?=
 =?utf-8?B?SWp3M09kRkhkMmFqME5odTU3ckE4WS9jbktZaitDVGVGeldtMWZ1YXBoRGRi?=
 =?utf-8?B?eDdDaFZQK0dSZE9VcVFKWHhNRkRlOXU3VG1MWE5DZ0xzVlUxZXNWTlBkOHdE?=
 =?utf-8?B?MXJlczEwa1FGbWdZZ0ZHQjJHV085TXNBci9SNmRSS3o5QncrOUtYNnk1RjJl?=
 =?utf-8?B?a0k2cyt6OS85MkJxcVk4T3NDR3VxVmZjLy81N3R1eHlGaGc4Wm91VTFTeXll?=
 =?utf-8?B?VGZOd3ZCRmtBQ0RnL2ZaQUhZL1piVWNoM0lCZUlmL1FBeklucXRSdG5iK0kx?=
 =?utf-8?B?dmVQTlk2RmR1OVdrMzY1d0pSRElYKzVsTkRMblRoNUZId3NXZ0N4KzRoR3ZO?=
 =?utf-8?B?eFdUc1hEYlNqSjRLSEx2TDFnODVzTXo5cG5RUHh5QWxDR0k1TnFXWDJuRUFJ?=
 =?utf-8?B?UkdkUkJ6QkZPQ3Z6WUpKRnQrUmZuRytFbjJYSmJaRjFxN2d6L0dMQS9nVDdL?=
 =?utf-8?B?NzVsV1lxWTRya3dxZ1YxUkYwNWtuUlhHR0hFakhKNG9oK1hqdFJNbUxrRkNI?=
 =?utf-8?B?TlhxTVJjT2hzajYxdFgrREpkVGIwemhPZXV3Rkt4c2RNZnUvU2ZJWUFtNkt1?=
 =?utf-8?B?blFLbFREWWZqK2hVdFNlcHFaM2JiakFOMW9Vd3l3M0JHaGZObnI5SGhBekxi?=
 =?utf-8?B?enFjNXZEcG84andmeUthNXVUQk5LNGZiTEVGcWdSUllzcElNUEdMRktzMTlp?=
 =?utf-8?B?UXdRbUtKUGdlNEFCZ0kvY1N4bW05ODFYOWJ0RkZwejl4NkpkenV1cTdIeGRi?=
 =?utf-8?B?NjhYWno4aUxCR0FSWVJGMFlOTGs5OHhLMXVTUXVaK2ZOcVF1MHRoVVZmdktw?=
 =?utf-8?B?ZGNiWGVhZlZhRlFnTVo3aFZ6eFZaTFpNYSt6dTduWGY2UUZDUS82KysvdTdm?=
 =?utf-8?B?RThUcGlwbE5xZ09oQUZmLzV4RjNQTnZxU3QxdUkrMXl2NmVpRkFLSXhlTkZz?=
 =?utf-8?B?dzE3Sjl0QllsMXVtSE5DSFpLUmlhMFhUQjkvWFJwOFEwUTBTOC94c2JMR1lw?=
 =?utf-8?B?ejBvS0diSFlBbktsREZEVVdoYXk2ZWpTNXoveXd5RlNyVkhmLzFBUldvRStC?=
 =?utf-8?B?VXdzVEQ3eTBGcTAxT2IwMTMwMzZPYkg4ME52QnQxVmdZdURPVVB0UTF6MHVi?=
 =?utf-8?B?RkVsdkRIc1RHL1dDR2g0Qk9ZMVkwTGxwcFk2SFY4SHJyRjFud2xKZFpkZzAz?=
 =?utf-8?B?N1RFN1l3M290YnpIM2xIMitXbWx1b1Jhc2RiVXlISG9hbUN5ZVVhbXZ2Z3Nj?=
 =?utf-8?B?eHc1aU9VR0pTRW1kRGtxUE1zcW1DOHpYZWtEZzFxdVYyT0lZbmxEZ1F2dTdP?=
 =?utf-8?B?VGZlTmZpeVpjSWt2eXJ1bEx0a3VPZmdxUXdyZGQ5ZWlRUHNEUkNRbnZmWG1W?=
 =?utf-8?B?MUpXaGR1RTBGalVwZk5ZbEF1OGx0cEpsbTB4R2RkUDY2bFhRVTlpdGswODdB?=
 =?utf-8?B?Q0RkOFJSd2doVUJFTDZDVTRBdklpc2FQaDczYkZkVXJBTm5QT2FGam1zMzB0?=
 =?utf-8?B?bGRDODc0cHMzNWlHbEN1YmdQSnAyUFN0aVVpdHdHdytJbHFhcGRIWEJrVjcx?=
 =?utf-8?B?SmNhN3ZLZkdPR2w3Z3pTUm5tOWlQZThaY3MwMlh4VmowMEZVVDhqQ3F4Qk5y?=
 =?utf-8?B?c1VIRWRJM0tDWVZHSDZTdjBqNkphQVVHb1RlYThvSE1BaS9lTXViQkhJWlM0?=
 =?utf-8?B?MTFXdE5CcjA5WVczakZsOHljeFVWTW9LVGNNR3F1Q1cxNFdLV1c4RmxoaUkv?=
 =?utf-8?B?c0xYUlZaWjMvZ0RyRUZsV2o1UlNYMUZkVkJpK0NOSlNNRFltbGJVZzZNaSta?=
 =?utf-8?B?eloycXlhNEZUU09xVUZ5Qko0QXZzZFY4QmJ2TW9CYlFsd3Bna3VsL2d5K2hk?=
 =?utf-8?B?OUVERjVKRFJseXB0c2JxUENIQkZOSkhYQjJXK2lKMzduSEErQ0gwZmRqNVpM?=
 =?utf-8?B?cFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <98DF036B5271984E8F467C6288F23AD1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e9608b-08b0-47f0-8217-08dbb38dfc84
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 12:44:21.0761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WWLa17LHIoWNqcC+PJIXrQglGeIOfueJcV9PMzckQBOB2mrTF35jIPPo+Jtynh8JDKrF2hMmj0eLa9rb5x4OzSrqMLCf+q2Yy9tLdJEg4DjaDoyQ56jPwU2GuQfzFD1J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7429
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFuayB5b3UgZm9yIHJldmlld2luZyB0aGUgcGF0Y2guDQoNCk9uIDA5
LzA5LzIzIDc6MDkgcG0sIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4gDQo+PiArICAgICAvKiBSZWdpc3RlciBNQUMtUEhZIGludGVycnVw
dCBzZXJ2aWNlIHJvdXRpbmUgKi8NCj4+ICsgICAgIHJldCA9IGRldm1fcmVxdWVzdF9pcnEoJnNw
aS0+ZGV2LCBzcGktPmlycSwgbWFjcGh5X2lycSwgMCwgIm1hY3BoeSBpbnQiLA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB0YzYpOw0KPiANCj4gSXQgbG9va3MgbGlrZSB1c2luZyB0
aHJlYWRlZCBpbnRlcnJ1cHRzIGNvdWxkIHNhdmUgYSBsb3Qgb2YNCj4gY29tcGxleGl0eS4gTGV0
IHRoZSBJUlEgY29yZSBoYW5kbGUgYWxsIHRoZSB0YXNrbGV0IHN0dWZmIGZvciB5b3UuDQpPay4g
SWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgSSBoYXZlIHRvIHVzZSBkZXZtX3JlcXVlc3RfdGhy
ZWFkZWRfaXJxKCkgDQppbnN0ZWFkIG9mIGRldm1fcmVxdWVzdF9pcnEoKSBhbmQgbGV0IHRoZSB0
aHJlYWQgaGFuZGxlciByZWdpc3RlcmVkIHdpdGggDQp0aGUgZGV2bV9yZXF1ZXN0X3RocmVhZGVk
X2lycSgpIGZ1bmN0aW9uIHRvIHBlcmZvcm0gaW50ZXJydXB0IGFjdGl2aXR5IA0KZGlyZWN0bHk/
DQoNCkJlc3QgUmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgICAgICBBbmRyZXcNCg0K
