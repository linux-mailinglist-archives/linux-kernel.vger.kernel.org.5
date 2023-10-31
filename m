Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAFD7DCB56
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343905AbjJaLEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbjJaLEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:04:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44459A1;
        Tue, 31 Oct 2023 04:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698750277; x=1730286277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kugLGwh0Ns8eBDzJal7jyDbWe/DTDF5F81Es/LzThRQ=;
  b=RCkH0F+crZSxyBTdB8N7jdQF+eTYkbMDuC/2RbibD+cQoF8LJCk7u8ii
   dw4gBdF9tDK81DpzgATYFIpLquf67DzJblmCWqOeDQArGV/W6gmUh12hQ
   QgTP4fmNuzB1UTIAuVqrfnsL4tizcXuIW7uhtVTYRmVwo3wTBCd9cceAk
   6XPW0nUdFbOce84grS6I168WuxfrlKefyxBfxKw3J3NDPI0B9INNSUXeo
   ipNB4Jg/I6D6yjnoeiYaiRo/t0eOJ4Gkxa6nIhXkPgqSK8xtgb9ZJjfx7
   NP0h5RTFDTLtU9uIdaHeejToAzD/SS+kjS2sX35q7U10eddz5dArn/n2B
   Q==;
X-CSE-ConnectionGUID: Q3c262KkSLu4v14hWUosJg==
X-CSE-MsgGUID: mHg1zfI9Sn2tVgtaZPNhzg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="10885811"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Oct 2023 04:04:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 31 Oct 2023 04:04:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Tue, 31 Oct 2023 04:04:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGqc2wyvIwAKo1cyp6fnNt7z7kSyGw4z8ZESIG5wzCttnr8VZ7Jf29B6QF1SdGgRYqHMffyPF71rQ1gOforMUOOfgeDNTJFiOSdZNNmSaj+4utlpP6HZNCgCcAMPrP4leMlW215Uwv/LdhxvxVeEFhwEnfH+h39WCqFZ2BP26pn7iw7vFDijGuqHrGdSBHxQNho7/T1AhyvTVZGJL6ohnZFzp6v05DNtU6o4Yh33gb0TbTtasJHsxGdnA0fvNH3krcJjEZmWG+sKPhMRuL86UUpp93sM6jrcWr089mCttgb5KxZfJZ7UMT3TYNbSw+cw6JPUBtIRrWOK3VJEQyw3Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kugLGwh0Ns8eBDzJal7jyDbWe/DTDF5F81Es/LzThRQ=;
 b=O4LVyF+JEFzIeaTuFuSKfXTdAJo0SIsMDqZ+wqtMHgG8IwDrJoeApN6x8buDtAgcFLi0dakPLOb/Ht06e+Raryve2HRNYwElED5/6hfT4o/tPzubi1j9INbW7PKV65zDEItZtxbWH+brFpJtyUbG4uRpWpac6ZD/jsv9nFs97uAUtfysv8B6W2I4L00y7X4KLTvkGiku2ACimn9+3Y+elC8Dzv/MVtS9BJXowo6MXzrmTF/ejQVlqhJo3B6DQP5fg1fO/NaKiB/bR+yIX8AmmRL+Ry1a4l0kDeosmgajBk4xnOOa/aCc6LvlvDvswpR3iRLv9MC2oz5KM9l2GtmEsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kugLGwh0Ns8eBDzJal7jyDbWe/DTDF5F81Es/LzThRQ=;
 b=jFj0KiTE9snM0YpU5EyYpTiVafpX1e1OFe8shmJxnMLUl403ZbTaCuTrW5eYbAlMBWupJrDvPBvf/RW/tSmFGaZg5zQh8tOrm4xHzdl4c7XkMeJYtI9ZK9krfpiikOvus6MDgEWa+yFNsaDypgm6xfCef1fDTNdCRxaNhm5J7VI=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 CH0PR11MB5393.namprd11.prod.outlook.com (2603:10b6:610:b8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.19; Tue, 31 Oct 2023 11:04:12 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::595f:f69d:149d:510%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 11:04:12 +0000
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
Subject: Re: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Topic: [PATCH net-next v2 8/9] microchip: lan865x: add driver support
 for Microchip's LAN865X MACPHY
Thread-Index: AQHaBciCW59pjIMQmUKn/gKExYJHR7BYOXIAgAuO9YA=
Date:   Tue, 31 Oct 2023 11:04:12 +0000
Message-ID: <296aa172-404e-414a-a56a-ca82b3e90397@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-9-Parthiban.Veerasooran@microchip.com>
 <eee6df3d-5e6b-4b4c-bfcc-55b31814fb82@lunn.ch>
In-Reply-To: <eee6df3d-5e6b-4b4c-bfcc-55b31814fb82@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|CH0PR11MB5393:EE_
x-ms-office365-filtering-correlation-id: 5c6099fd-ebdf-4fbb-f1c4-08dbda011d22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +weD9SXrBFOE1EcXzKHNEOEoNUft+V857UmGqKJ1TrtcjcYxriizpBlQDeFI/3Um8TQkseZXNvvhasxqaWVSDEmRvoHmMSDgZb4sCsg7udjCb5WJqADCr5/u7WpVFoK300KCFS/nHSZn9Y0M77YNsu5kjwqnIKx8xnEgTlkG4UWFnXFz18jEophBzsDpKHAEQFGvhKZpc6mWaZx2N7V2wGO6mXLGMqk1qqR+IFg4oPA1+gFo1q7XI6U1iqVkTjhXrnlToCBbgsUCvY5Gx1b5+7mW3z2krSE2dCEs8sjlsmDYHeLYLWCfi8nzpxrfrymVQ5wAPPOns2N87rmMGmnV8CDk8F/W0VtkvCTdPrSE6o07EdOOw6FUUz8tSIQI9IpKQOpgaJtoSLsPOsKe5UVCH9HLEAcgJIAVqYEOrPkxuruFJKTxNYRLv19imvl22B3SRyuBsDVOxxb1znuZJSdEFLcXZppejEYbPj7NNoR9LOSJFVSvFcrAjx4POEVvG3BasTd4Fv1LClPPbLYzXk5sf/FggNemhdpD5pBBafVfU48FUUb6JqQJxKidZGrNtt7mWSSdSgWuKuMlkTW0W4w8Ec0CJOMV2+MZYFSmF2J/7e36uBeJhoIMJCaQZZZB/SVkxvpJkzEq3Fzl9ghW4XG+EP6bZLd8/eJMYsuYDS9mkjbv8q17KBdpe7NjFG2fR9EYRGIBSbyhhyggzdZ6ZpQVRWR7daUJl6cz+GRiAMtEQuk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(396003)(39860400002)(346002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799009)(64100799003)(66899024)(7416002)(53546011)(6506007)(6512007)(36756003)(31696002)(26005)(107886003)(2616005)(86362001)(38070700009)(71200400001)(38100700002)(83380400001)(122000001)(6486002)(2906002)(478600001)(91956017)(31686004)(41300700001)(66556008)(66946007)(54906003)(64756008)(66476007)(66446008)(76116006)(316002)(6916009)(8936002)(4326008)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2hGbUxNUnlIeWd3NEFKZENZNEYzNEpEVE14Q0JpdzdESk5lQXNNZTJWVEFK?=
 =?utf-8?B?QU0xN3JwcHBZRW0zcFZZMkN2TmZKbDJLNi9vYzNvakE2eEdpY3VxNkN2ZWl5?=
 =?utf-8?B?UEl2bGNad3pnY2NQcDFFRnA0ZlRqRVN4cVg5aUxFeEYxOTgycExXYWJSRjdp?=
 =?utf-8?B?SnI0blRLS1FLZjNRR0tqQ2N4QmhZZUhQb1V5SHRTUCttcTN4WmRkcjVuc2Uw?=
 =?utf-8?B?ZGJDN2JGNHRiRGw4RHVBcm1lNUpvVEMvMDdGbVNVUjhkV285U2I0OUtjWUdD?=
 =?utf-8?B?UTZkOFIzbG5NL2dRVmRqNmJ5NFRhR0FSbi9xT3BRRWxkL2Y0QXlXb09NeWVp?=
 =?utf-8?B?K1VwOFBtd05jT0tNaHpoZk9iL3luWmgydWhFNVFrMmlRRmxNWnNuNDBJS0xJ?=
 =?utf-8?B?eld0bjJqdlN2TVRxcW5ReDhCcmRhMVlyTHEzd3FvU0hFdys0TThZcGJmVkFH?=
 =?utf-8?B?OFFDK3pKdGh4ZzVydTBCL0xoVFAybTU0dVgvLzZ6TWwrTThNUXVGeFIxUnFr?=
 =?utf-8?B?NHNUK0k0MHR1UWNuTnRBNHlJbDN3Z2VtNExpTUEzSkxReXJiQXJkS1ZTVE9D?=
 =?utf-8?B?MFBDazQ0S2JWczJNOHhRQjdVcjNibWZUN05sUkNaaExSbkVQMHg1SkhHcUh6?=
 =?utf-8?B?T1BtZ2VDUnpBWG04NTBQbHZnd1YydXZqbzNScnV6RmljeXpmaUdWR2lHeGpp?=
 =?utf-8?B?c2UxUkJ5Qzg0RVpWYk8wQ1ZPS21jTENONjE4SmcvVDFEZnlnVms4MDB5M091?=
 =?utf-8?B?V1BJQ1d1eEk1NVRoQTN4bHNRelg0U2dwYUhLRG12Q2FjQkRFMGhtanUxVGs3?=
 =?utf-8?B?cnpRSkdXT0ZMMVRGUGZIbGhlc0FhZmRCUE9vbmFXK3d6c29nbUthUURLVVRU?=
 =?utf-8?B?aTBzZU80VWFNdFc4UmNCQklKbWdMUG1pSjB6eVJGU2QwNkFGTTRHeVRia0tw?=
 =?utf-8?B?bmllNFFxVUsydUROVXQ5MHZXSy9COHpNTlFvZlg5Y3Vpb3dUQkRkWnloT0FY?=
 =?utf-8?B?dElYZ1cvc3U0aS9kVzQ1OWx6Ui83QXZPM3VFcHkvUU0zbVVJUS9HOUFVMG1O?=
 =?utf-8?B?U0ZRKzJ6ajBrUEpoNThxVGRJMWx1TUVPa0FPUFcvZkczWExlVUc3cEQzR21K?=
 =?utf-8?B?ZGYwVnhkaXFLNy9qdnNKdE9oOU5lZjhJNUxMQUtqS3Njb0k5dWdsRWFOek1z?=
 =?utf-8?B?bHNTU2xVRE5aSFJLdUtvbDlidW9CaUpQVjh1MU9wWnJOOG4vUHBzZHhWVXY2?=
 =?utf-8?B?WDFnWFRmbnk5Zm1EWGxNM1NINnFzdUJiR1NkOHh1RzZFcVc5UkJDai81WXNx?=
 =?utf-8?B?alRQZUVtSDlGYTM0bFBLWFV3THJaS1ZkLzMwaUtTNGxGSEtMaXNjY1FzSDk1?=
 =?utf-8?B?dmZ5ekgyRytXaGRzL3VxRDAwcnZkc1grRTl0OTZrRGpITnlNQURoeTFTVUln?=
 =?utf-8?B?Q016OVozWE55QWZka29DMGVOQjRwMmRuejlydFptUnN0UW1aTm9VWWozR1pJ?=
 =?utf-8?B?bWQxc2xsdkU5ZjQxczk1UnhKSXFJekcrWWxlcU5DY2VTc1VIeTdWMFh1WmZB?=
 =?utf-8?B?OEd2UUtDb0pvSDFCMzNKdlk0eDRySzZMZDFJdlU1T0JnUzVOSmkvZ0ZhRlp3?=
 =?utf-8?B?dWh4T3dXL2w0VkJsK2dsdS8vMVJQNGVyTmR0OUpidkRHRTdqNE1CRStuQVhB?=
 =?utf-8?B?U1Y2N1FTdUhwZkQ4NzVCSnRGcVg4aENzdUtGVXFlTUFDdGFFb05BOHJJSE5X?=
 =?utf-8?B?ZU1KcXIvMGxoNlJDcjBrUEZYdHRVbS9rVm9qN0hSeHNpNXNPdHIrMnRUWEhQ?=
 =?utf-8?B?enVjdEZYcHp2MUtVVVRDREJGNnFqeGo4dThIS3ZLQmgyOHlGTUVDSjJpOEZN?=
 =?utf-8?B?VE9QTjFwRzRjZUxrT3lOQWVmeitKbFlUR21GZUlneEwrdW1uNzNOSHFCaWE4?=
 =?utf-8?B?V01pOFRidzU0WlBwNk4vN05PZzdFVFpJRGZrTEZvcC82UW5OaW5Fak1xRFNT?=
 =?utf-8?B?K0M0SitQSzFGK3QydS8zKzJkeTdMNDFRZ3VjMzE1eEI2QzgyTnZhWGtubXdF?=
 =?utf-8?B?Z2lZaWRqUGFvN2JwOWlSWHh4a2U5dzFTNVFEMTJZcUhpTWVENVlZaHpYVGhT?=
 =?utf-8?B?RnVuZnRpMytUNXVPcFFYRmxTcFcraFVVaHVFWGYrSmNaKzdSUFFTZk9hRFF5?=
 =?utf-8?Q?veZrHEh0jUtzn67vSuj2YA8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <534BDA5759B57D489ABDCC174540C9FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6099fd-ebdf-4fbb-f1c4-08dbda011d22
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 11:04:12.1452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXZDm90v/3Qj75pCwyD8ryfo/YvsrKDlYpixZ8SkpViF/ejXk7PyhbaH0BIkk5p0hV/3ssES9NPTibSIB8oFA+0brryp1wILOnWBDErh9BLdUpEHXYuSaodpTychCj2O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5393
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyNC8xMC8yMyA4OjAzIGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gK3N0YXRpYyBpbnQgbGFu
ODY1eF9zZXRfaHdfbWFjYWRkcihzdHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2KQ0KPj4gK3sNCj4+
ICsgICAgIHUzMiByZWd2YWw7DQo+PiArICAgICBib29sIHJldDsNCj4+ICsgICAgIHN0cnVjdCBs
YW44NjV4X3ByaXYgKnByaXYgPSBuZXRkZXZfcHJpdihuZXRkZXYpOw0KPj4gKyAgICAgY29uc3Qg
dTggKm1hYyA9IG5ldGRldi0+ZGV2X2FkZHI7DQo+PiArDQo+PiArICAgICByZXQgPSBvYV90YzZf
cmVhZF9yZWdpc3Rlcihwcml2LT50YzYsIExBTjg2NVhfTUFDX05DUiwgJnJlZ3ZhbCk7DQo+PiAr
ICAgICBpZiAocmV0KQ0KPj4gKyAgICAgICAgICAgICBnb3RvIGVycm9yX21hYzsNCj4+ICsgICAg
IGlmICgocmVndmFsICYgTEFOODY1WF9UWEVOKSB8IChyZWd2YWwgJiBMQU44NjVYX1JYRU4pKSB7
DQo+IA0KPiBXb3VsZCB0ZXN0aW5nIG5ldGlmX3J1bm5pbmcobmV0ZGV2KSBiZSBlbm91Z2g/IFRo
YXQgaXMgYSBtb3JlIGNvbW1vbg0KPiB0ZXN0IHlvdSBzZWUuIEluIGZhY3QsIHlvdSBhbHJlYWR5
IGhhdmUgdGhhdCBpbg0KPiBsYW44NjV4X3NldF9tYWNfYWRkcmVzcygpLiBBbmQgaW4gbGFuODY1
eF9wcm9iZSgpIHdoeSB3b3VsZCB0aGUNCj4gaGFyZHdhcmUgYmUgZW5hYmxlZD8NCkFoIHllcywg
dGhpcyBjaGVjayBpcyBub3QgbmVlZGVkIGF0IGFsbC4gV2lsbCBjb3JyZWN0IGl0Lg0KPiANCj4g
DQo+PiArICAgICAgICAgICAgIGlmIChuZXRpZl9tc2dfZHJ2KHByaXYpKQ0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgIG5ldGRldl93YXJuKG5ldGRldiwgIkhhcmR3YXJlIG11c3QgYmUgZGlzYWJs
ZWQgZm9yIE1BQyBzZXR0aW5nXG4iKTsNCj4+ICsgICAgICAgICAgICAgcmV0dXJuIC1FQlVTWTsN
Cj4+ICsgICAgIH0NCj4+ICsgICAgIC8qIE1BQyBhZGRyZXNzIHNldHRpbmcgKi8NCj4+ICsgICAg
IHJlZ3ZhbCA9IChtYWNbM10gPDwgMjQpIHwgKG1hY1syXSA8PCAxNikgfCAobWFjWzFdIDw8IDgp
IHwgbWFjWzBdOw0KPj4gKyAgICAgcmV0ID0gb2FfdGM2X3dyaXRlX3JlZ2lzdGVyKHByaXYtPnRj
NiwgTEFOODY1WF9NQUNfU0FCMSwgcmVndmFsKTsNCj4+ICsgICAgIGlmIChyZXQpDQo+PiArICAg
ICAgICAgICAgIGdvdG8gZXJyb3JfbWFjOw0KPj4gKw0KPj4gKyAgICAgcmVndmFsID0gKG1hY1s1
XSA8PCA4KSB8IG1hY1s0XTsNCj4+ICsgICAgIHJldCA9IG9hX3RjNl93cml0ZV9yZWdpc3Rlcihw
cml2LT50YzYsIExBTjg2NVhfTUFDX1NBVDEsIHJlZ3ZhbCk7DQo+PiArICAgICBpZiAocmV0KQ0K
Pj4gKyAgICAgICAgICAgICBnb3RvIGVycm9yX21hYzsNCj4+ICsNCj4+ICsgICAgIHJldHVybiAw
Ow0KPj4gKw0KPj4gK2Vycm9yX21hYzoNCj4+ICsgICAgIHJldHVybiAtRU5PREVWOw0KPiANCj4g
b2FfdGM2X3dyaXRlX3JlZ2lzdGVyKCkgc2hvdWxkIHJldHVybiBhbiBlcnJvciBjb2RlLCBzbyBy
ZXR1cm4gaXQuDQpZZXMsIG5vdGVkLiBXaWxsIGRvIGl0Lg0KPiANCj4+ICtzdGF0aWMgaW50IGxh
bjg2NXhfc2V0X21hY19hZGRyZXNzKHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYsIHZvaWQgKmFk
ZHIpDQo+PiArew0KPj4gKyAgICAgc3RydWN0IHNvY2thZGRyICphZGRyZXNzID0gYWRkcjsNCj4+
ICsNCj4+ICsgICAgIGlmIChuZXRpZl9ydW5uaW5nKG5ldGRldikpDQo+PiArICAgICAgICAgICAg
IHJldHVybiAtRUJVU1k7DQo+PiArDQo+PiArICAgICBldGhfaHdfYWRkcl9zZXQobmV0ZGV2LCBh
ZGRyZXNzLT5zYV9kYXRhKTsNCj4+ICsNCj4+ICsgICAgIHJldHVybiBsYW44NjV4X3NldF9od19t
YWNhZGRyKG5ldGRldik7DQo+IA0KPiBZb3Ugc2hvdWxkIGlkZWFsbHkgb25seSB1cGRhdGUgdGhl
IG5ldGRldiBNQUMgYWRkcmVzcywgaWYgeW91IG1hbmFnZWQNCj4gdG8gY2hhbmdlIHRoZSB2YWx1
ZSBpbiB0aGUgaGFyZHdhcmUuDQpBaCBvaywgdGhlbiBpdCBpcyBzdXBwb3NlZCB0byBiZSBsaWtl
IGJlbG93LCBpc24ndCBpdD8NCg0Kc3RhdGljIGludCBsYW44NjV4X3NldF9tYWNfYWRkcmVzcyhz
dHJ1Y3QgbmV0X2RldmljZSAqbmV0ZGV2LCB2b2lkICphZGRyKQ0Kew0KCXN0cnVjdCBzb2NrYWRk
ciAqYWRkcmVzcyA9IGFkZHI7DQoJaW50IHJldDsNCg0KCWlmIChuZXRpZl9ydW5uaW5nKG5ldGRl
dikpDQoJCXJldHVybiAtRUJVU1k7DQoNCglyZXQgPSBsYW44NjV4X3NldF9od19tYWNhZGRyKG5l
dGRldik7DQoJaWYgKHJldCkNCgkJcmV0dXJuIHJldDsNCg0KCWV0aF9od19hZGRyX3NldChuZXRk
ZXYsIGFkZHJlc3MtPnNhX2RhdGEpOw0KDQoJcmV0dXJuIDA7DQp9DQo+IA0KPj4gK3N0YXRpYyB2
b2lkIGxhbjg2NXhfc2V0X211bHRpY2FzdF9saXN0KHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYp
DQo+PiArew0KPj4gKyAgICAgc3RydWN0IGxhbjg2NXhfcHJpdiAqcHJpdiA9IG5ldGRldl9wcml2
KG5ldGRldik7DQo+PiArICAgICB1MzIgcmVndmFsID0gMDsNCj4+ICsNCj4+ICsgICAgIGlmIChu
ZXRkZXYtPmZsYWdzICYgSUZGX1BST01JU0MpIHsNCj4+ICsgICAgICAgICAgICAgLyogRW5hYmxp
bmcgcHJvbWlzY3VvdXMgbW9kZSAqLw0KPj4gKyAgICAgICAgICAgICByZWd2YWwgfD0gTUFDX1BS
T01JU0NVT1VTX01PREU7DQo+PiArICAgICAgICAgICAgIHJlZ3ZhbCAmPSAofk1BQ19NVUxUSUNB
U1RfTU9ERSk7DQo+PiArICAgICAgICAgICAgIHJlZ3ZhbCAmPSAofk1BQ19VTklDQVNUX01PREUp
Ow0KPj4gKyAgICAgfSBlbHNlIGlmIChuZXRkZXYtPmZsYWdzICYgSUZGX0FMTE1VTFRJKSB7DQo+
PiArICAgICAgICAgICAgIC8qIEVuYWJsaW5nIGFsbCBtdWx0aWNhc3QgbW9kZSAqLw0KPj4gKyAg
ICAgICAgICAgICByZWd2YWwgJj0gKH5NQUNfUFJPTUlTQ1VPVVNfTU9ERSk7DQo+PiArICAgICAg
ICAgICAgIHJlZ3ZhbCB8PSBNQUNfTVVMVElDQVNUX01PREU7DQo+PiArICAgICAgICAgICAgIHJl
Z3ZhbCAmPSAofk1BQ19VTklDQVNUX01PREUpOw0KPj4gKyAgICAgfSBlbHNlIGlmICghbmV0ZGV2
X21jX2VtcHR5KG5ldGRldikpIHsNCj4+ICsgICAgICAgICAgICAgLyogRW5hYmxpbmcgc3BlY2lm
aWMgbXVsdGljYXN0IGFkZHJlc3NlcyAqLw0KPj4gKyAgICAgICAgICAgICBzdHJ1Y3QgbmV0ZGV2
X2h3X2FkZHIgKmhhOw0KPj4gKyAgICAgICAgICAgICB1MzIgaGFzaF9sbyA9IDA7DQo+PiArICAg
ICAgICAgICAgIHUzMiBoYXNoX2hpID0gMDsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgbmV0ZGV2
X2Zvcl9lYWNoX21jX2FkZHIoaGEsIG5ldGRldikgew0KPj4gKyAgICAgICAgICAgICAgICAgICAg
IHUzMiBiaXRfbnVtID0gbGFuODY1eF9oYXNoKGhhLT5hZGRyKTsNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICB1MzIgbWFzayA9IDEgPDwgKGJpdF9udW0gJiAweDFmKTsNCj4+ICsNCj4+ICsgICAg
ICAgICAgICAgICAgICAgICBpZiAoYml0X251bSAmIDB4MjApDQo+PiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBoYXNoX2hpIHw9IG1hc2s7DQo+PiArICAgICAgICAgICAgICAgICAgICAg
ZWxzZQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGFzaF9sbyB8PSBtYXNrOw0K
Pj4gKyAgICAgICAgICAgICB9DQo+PiArICAgICAgICAgICAgIGlmIChvYV90YzZfd3JpdGVfcmVn
aXN0ZXIocHJpdi0+dGM2LCBMQU44NjVYX01BQ19IUlQsIGhhc2hfaGkpKSB7DQo+PiArICAgICAg
ICAgICAgICAgICAgICAgaWYgKG5ldGlmX21zZ190aW1lcihwcml2KSkNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG5ldGRldl9lcnIobmV0ZGV2LCAiRmFpbGVkIHRvIHdyaXRlIHJl
Z19oYXNoaCIpOw0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybjsNCj4+ICsgICAgICAg
ICAgICAgfQ0KPj4gKyAgICAgICAgICAgICBpZiAob2FfdGM2X3dyaXRlX3JlZ2lzdGVyKHByaXYt
PnRjNiwgTEFOODY1WF9NQUNfSFJCLCBoYXNoX2xvKSkgew0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgIGlmIChuZXRpZl9tc2dfdGltZXIocHJpdikpDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBuZXRkZXZfZXJyKG5ldGRldiwgIkZhaWxlZCB0byB3cml0ZSByZWdfaGFzaGwiKTsN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+PiArICAgICAgICAgICAgIH0NCj4+
ICsgICAgICAgICAgICAgcmVndmFsICY9ICh+TUFDX1BST01JU0NVT1VTX01PREUpOw0KPj4gKyAg
ICAgICAgICAgICByZWd2YWwgJj0gKH5NQUNfTVVMVElDQVNUX01PREUpOw0KPj4gKyAgICAgICAg
ICAgICByZWd2YWwgfD0gTUFDX1VOSUNBU1RfTU9ERTsNCj4+ICsgICAgIH0gZWxzZSB7DQo+PiAr
ICAgICAgICAgICAgIC8qIGVuYWJsaW5nIGxvY2FsIG1hYyBhZGRyZXNzIG9ubHkgKi8NCj4+ICsg
ICAgICAgICAgICAgaWYgKG9hX3RjNl93cml0ZV9yZWdpc3Rlcihwcml2LT50YzYsIExBTjg2NVhf
TUFDX0hSVCwgcmVndmFsKSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChuZXRpZl9t
c2dfdGltZXIocHJpdikpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXRkZXZf
ZXJyKG5ldGRldiwgIkZhaWxlZCB0byB3cml0ZSByZWdfaGFzaGgiKTsNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICByZXR1cm47DQo+PiArICAgICAgICAgICAgIH0NCj4+ICsgICAgICAgICAgICAg
aWYgKG9hX3RjNl93cml0ZV9yZWdpc3Rlcihwcml2LT50YzYsIExBTjg2NVhfTUFDX0hSQiwgcmVn
dmFsKSkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGlmIChuZXRpZl9tc2dfdGltZXIocHJp
dikpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBuZXRkZXZfZXJyKG5ldGRldiwg
IkZhaWxlZCB0byB3cml0ZSByZWdfaGFzaGwiKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBy
ZXR1cm47DQo+PiArICAgICAgICAgICAgIH0NCj4+ICsgICAgIH0NCj4+ICsgICAgIGlmIChvYV90
YzZfd3JpdGVfcmVnaXN0ZXIocHJpdi0+dGM2LCBMQU44NjVYX01BQ19OQ0ZHUiwgcmVndmFsKSkg
ew0KPj4gKyAgICAgICAgICAgICBpZiAobmV0aWZfbXNnX3RpbWVyKHByaXYpKQ0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgIG5ldGRldl9lcnIobmV0ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSBwcm9t
aXNjdW91cyBtb2RlIik7DQo+PiArICAgICB9DQo+PiArfQ0KPiANCj4gQW5vdGhlciBvZiB0aG9z
ZSBiaWcgZnVuY3Rpb25zIHdoaWNoIGNvdWxkIGJlIGxvdHMgb2Ygc2ltcGxlIGZ1bmN0aW9ucw0K
PiBlYWNoIGRvaW5nIG9uZSB0aGluZy4NClN1cmUsIHdpbGwgc3BsaXQgaW50byBtdWx0aXBsZSBm
dW5jdGlvbnMuDQo+IA0KPj4gKy8qIENvbmZpZ3VyZXMgdGhlIG51bWJlciBvZiBieXRlcyBhbGxv
Y2F0ZWQgdG8gZWFjaCBidWZmZXIgaW4gdGhlDQo+PiArICogdHJhbnNtaXQvcmVjZWl2ZSBxdWV1
ZS4gTEFOODY1eCBzdXBwb3J0cyBvbmx5IDY0IGFuZCAzMiBieXRlcyBjcHMgYW5kIGFsc28gNjQN
Cj4+ICsgKiBpcyB0aGUgZGVmYXVsdCB2YWx1ZS4gU28gaXQgaXMgZW5vdWdoIHRvIGNvbmZpZ3Vy
ZSB0aGUgcXVldWUgYnVmZmVyIHNpemUgb25seQ0KPj4gKyAqIGZvciAzMiBieXRlcy4gR2VuZXJh
bGx5IGNwcyBjYW4ndCBiZSBjaGFuZ2VkIGR1cmluZyBydW4gdGltZSBhbmQgYWxzbyBpdCBpcw0K
Pj4gKyAqIGNvbmZpZ3VyZWQgaW4gdGhlIGRldmljZSB0cmVlLiBUaGUgdmFsdWVzIGZvciB0aGUg
VHgvUnggcXVldWUgYnVmZmVyIHNpemUgYXJlDQo+PiArICogdGFrZW4gZnJvbSB0aGUgTEFOODY1
eCBkYXRhc2hlZXQuDQo+PiArICovDQo+IA0KPiBJdHMgdW5jbGVhciB3aHkgdGhpcyBuZWVkcyB0
byBiZSBhIGNhbGxiYWNrLiBXaHkgbm90IGp1c3Qgc2V0IGl0IGFmdGVyDQo+IG9hX3RjNl9pbml0
KCkgcmV0dXJucz8NCm9hX3RjNl9pbml0KCkgZnVuY3Rpb24gaW50ZXJuYWxseSBjYWxscyBvYV90
YzZfY29uZmlndXJlKCkgZnVuY3Rpb24gdG8gDQpjb25maWd1cmUgZGlmZmVyZW50IHNldHRpbmdz
LiBBdCB0aGUgZW5kIGl0IHdyaXRlcyBTWU5DIGJpdCB0byBDT05GSUcwIA0KcmVnaXN0ZXIgd2hp
Y2ggZW5hYmxlcyB0aGUgTUFDLVBIWSB0byBzdGFydCB0aGUgZGF0YSB0cmFuc2Zlci4gU28gdGhl
IA0KYnVmZmVyIGNvbmZpZ3VyYXRpb24gc2hvdWxkIGJlIGRvbmUgcHJpb3IgdG8gdGhhdC4gU2lu
Y2UgdGhpcyBpcyBwYXJ0IG9mIA0KdGhlIGNvbmZpZ3VyYXRpb24gdGhpcyBjYWxsYmFjayBpcyBp
bXBsZW1lbnRlZC4NCj4gDQo+PiArc3RhdGljIHZvaWQgbGFuODY1eF9yZW1vdmUoc3RydWN0IHNw
aV9kZXZpY2UgKnNwaSkNCj4+ICt7DQo+PiArICAgICBzdHJ1Y3QgbGFuODY1eF9wcml2ICpwcml2
ID0gc3BpX2dldF9kcnZkYXRhKHNwaSk7DQo+PiArDQo+PiArICAgICBvYV90YzZfZXhpdChwcml2
LT50YzYpOw0KPj4gKyAgICAgdW5yZWdpc3Rlcl9uZXRkZXYocHJpdi0+bmV0ZGV2KTsNCj4gDQo+
IElzIHRoYXQgdGhlIGNvcnJlY3Qgb3JkZXI/IFNlZW1zIGxpa2UgeW91IHNob3VsZCB1bnJlZ2lz
dGVyIHRoZSBuZXRkZXYNCj4gZmlyc3QuDQpBaCB5ZXMsIHdpbGwgY29ycmVjdCBpdC4NCj4gDQo+
PiArI2lmZGVmIENPTkZJR19BQ1BJDQo+PiArc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2Rldmlj
ZV9pZCBsYW44NjV4X2FjcGlfaWRzW10gPSB7DQo+PiArICAgICB7IC5pZCA9ICJMQU44NjVYIiwN
Cj4+ICsgICAgIH0sDQo+PiArICAgICB7fSwNCj4gDQo+IERvZXMgdGhpcyB3b3JrPyBZb3UgZG9u
J3QgaGF2ZSBhY2Nlc3MgdG8gdGhlIGRldmljZSB0cmVlIHByb3BlcnRpZXMuDQpHb2luZyB0byBy
ZW1vdmUgYWxsIHRoZSBPQSBzcGVjaWZpYyBjb25maWd1cmF0aW9ucyBpbiB0aGUgbmV4dCByZXZp
c2lvbnMuDQoNCkJlc3QgUmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPiAgICAgICBBbmRyZXcN
Cj4gDQoNCg==
