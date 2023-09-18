Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19207A40EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 08:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbjIRGOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 02:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239820AbjIRGNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 02:13:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81897118;
        Sun, 17 Sep 2023 23:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695017622; x=1726553622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tyzApPxOtrd77h/IznBFp0G6m3IR8Ai4Ai+BlLRK8/s=;
  b=H1xJuVxvCMxAjInr7h3PTgT+Z8mU6iUwvAD7ELkxTyP48uJcdy1pG87M
   f59yLIMNRosopIjEsWXjYrWD3H6kso1Nvgq6h809hIR2qBzRcZWUDVpML
   sIx7ukwx+RDQ84XTi3Hh74aXe0ajm9r0TqtNJvSAt+75RUjsVAomw2N59
   jbrARRVMBr3nmDb3PpHBXJ8VsZw0l4h87M7poHxwlGL3HkElX11OPMgsk
   ZT21Zk6NHAsFz5CiT4rLSPOg8yqJ8zCpOKInCa60hwV6MLgGNypI7LTU8
   WiXMOOdh79TOGyoybAnztJqalcjlw2EG8KPLNUmgFnNrYJqB0oYmhWTKj
   Q==;
X-CSE-ConnectionGUID: iy9Y5HBdRw+zYsrFIKKHeg==
X-CSE-MsgGUID: VKpx78f7QumVSFE+gF9yUg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,155,1688454000"; 
   d="scan'208";a="172166171"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2023 23:13:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 17 Sep 2023 23:13:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Sun, 17 Sep 2023 23:13:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxA1X5OyteRFCP/rPP8ErRiDlDMBaB4L/5nIsmq/NCXba3aTxBapwQzYO5DLyllYUFIUrwFa9c/cMU9UE78YwI5lajuJWFQhdHxa9gd3Qsgd2pzWaqyU0wcIpx3GoGb4E4pwAmDzEq3Y9Yf2My0QvLEAfFGKn9oFLF60Bn7XX+/BbHuMcrKiNc0qkMf9bIahvToVNi38kcmmbeabg62NLf3SyP+82KS8c3roun1BH7YxJn56O1esKKc5qJh9Lbun9/124RKiJclGEclg62qSY5uXLBA4MpwNBw7amsvvBL7MUB1aEzxxv/51s1SkfoT7EVJlG4I/yDL9KeYlnwgfww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tyzApPxOtrd77h/IznBFp0G6m3IR8Ai4Ai+BlLRK8/s=;
 b=NWzkMt/hJ3wb+Ufv6/iQFbQpeBEgnS8fDz2gEDkkASOo2xrMXi6+kzk+D08g9fimn+DWUdU+ZCtReMTHc1QRnwP9j7WIem0qcL66liHUwf0XKeaB51tuePs+AWhi2MtsyXj8i3ai+yPQB0C7/MN80ZfqIaF6I1mcyBkZ8rsBKIzxiIWoF/wBOsX+TIoBYIrm0IS61wDIHaGgE2ITrMva0FmwsZKnPODkGSrDlEax7ObnV5AKUT3+dnxL/YU+y8yXa+0CSHaKyQ54qwO8HP0lhvLraMQAzE8vxBXLlovsi7sqWu3izyDle3+83UuoVT0UETUJnEGEB2RSqjpsVCrAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tyzApPxOtrd77h/IznBFp0G6m3IR8Ai4Ai+BlLRK8/s=;
 b=hKS7p9JKDwgSOq3qBh4e29ANJnNd3hq84V78ovWQwc5vnDsfiLYxSCEj1MlGqe8MVVjRK/2xxZec1+aaC6AEStLE4p5wiFJ3cfEa2l0cfK/4zC9iqdYlLsvEzGbx+bDMLIPbTTUMXKQ+gwrU89Sdw1CzuNjp56wgIVTcx9CIQ7k=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 SA3PR11MB8073.namprd11.prod.outlook.com (2603:10b6:806:301::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Mon, 18 Sep
 2023 06:12:57 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 06:12:56 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <ada@thorsis.com>, <alexandru.tachici@analog.com>, <andrew@lunn.ch>
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
Subject: Re: [RFC PATCH net-next 0/6] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Thread-Topic: [RFC PATCH net-next 0/6] Add support for OPEN Alliance
 10BASE-T1x MACPHY Serial Interface
Thread-Index: AQHZ4mDzB/QUuCJz5U6/cDo3W2/tF7Ab9DuAgAQ1PIA=
Date:   Mon, 18 Sep 2023 06:12:56 +0000
Message-ID: <79a32553-3926-e3b8-980d-351d94fc063b@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230915-wizard-junction-b58f2aad64c5@ifak-system.com>
In-Reply-To: <20230915-wizard-junction-b58f2aad64c5@ifak-system.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|SA3PR11MB8073:EE_
x-ms-office365-filtering-correlation-id: 0230ce5d-e03e-45aa-3f03-08dbb80e4d04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: grcrc5QgGqLgfUoQ9OFVsJURrxG10a070H5frv9zJGcon3PLNh/oNxT/fTvHq4UPSRvpHOO3c9j4zcdYhLNjtecJwS3N5GTVVCvUTA/VydBi6aR9bZWRmAfClnNO1ppHkhgrao2/gQX+CTVRhJ9szX52r3NbU6GuDK4Q3x+uA5LqtdUx7Vno4m0Qp7VEfOJC+hvBmvfOaisCG1SSJkBJi/JF7cnyPx5Fo5B2DI6hTQofnmZTFe0hT2QKi6wb/12S8p7bciuuL+XJWHv+SCgze5GbTC7VBWAyrnFKEl7lT/nGtJFbKt+MBlmxDjwhc8MKBu7oZ6XssFRHu9RcxRORevaFiev7BI3+VdV1nIM/paPXJRPBOTMxh5yHh9Fa3yO9wV4JDU7bJHsMasXs6ILkLT1Y1W1LmalCsV7AMN/VO8N1k3d//7ap9+/h/ZtopYhaLEtSG2DH0QYLAm529h92ooFmplmo8tZqPoPmrsTF70SVDbFRUZYZv7n9s/PoPBMC+o5I6rAznxEcMduJHMpX3DoP7j76kC6737IoybcChShSb/WCojNCTLCPkhdOYzHnCaEjZ+Qe2LTLohOL5cod2I5crLaxp6WS5ZyK9wB7ZpJIziCpOlPDrUfCfks/bS5JRlBgCVUlN02OxJCjED6AINN0IfuET6c6ph9pKTnl1ww=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199024)(186009)(1800799009)(2906002)(5660300002)(26005)(7416002)(41300700001)(316002)(66446008)(54906003)(66476007)(91956017)(64756008)(66946007)(66556008)(110136005)(76116006)(478600001)(8936002)(4326008)(8676002)(966005)(31686004)(6506007)(6486002)(71200400001)(53546011)(6512007)(2616005)(36756003)(107886003)(122000001)(38070700005)(38100700002)(31696002)(86362001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE9XcjFDODFtbzVjaDRSdmxPRmhuQTZ3Y3ZERzhhUHQ4bVZTNnFsUVRBWGRG?=
 =?utf-8?B?WHduSGwxbGx4M2NUbXNnSHhqdXZtWTVMNkN6SXB2RmZnQWU2MlYzcDVzWi94?=
 =?utf-8?B?dlZGemgxa1ZwcHU2THdoQlhpaURWTm1qckExYmVkTFg3QlpyQ1plZmJBeUdJ?=
 =?utf-8?B?LzVBNkxCOHlCT1dDZWh0eXV2YXVlbEpSZlhQN0RDRWMyalRTNEtCbVUvNmxL?=
 =?utf-8?B?ZGlTRVJNMkNnYTF0SHc5bURiN2NzSUJWejdYSGZvZFVMYit6RWx5cWFLMEM1?=
 =?utf-8?B?L1UyMmdvVU15TGtiZWV5ditJaGV5K1VRcTNQQ0lvQWtZRjdSbGhHMWFvWVJC?=
 =?utf-8?B?dFk4VzRRZkMyRWh0NzNnNFBnbXlFYTcvUzlTb1k2Q25yWDNBcWZSZDZhb3ZJ?=
 =?utf-8?B?NTg0QUh1WGxBVDV5Zm1hQk4rMkxZakxIWnM1cHRzRWUvZzU3bVRFQkJhMnAz?=
 =?utf-8?B?RzR2UlpUbzZEWWhTSWZFNXU5VXNQcWwwWXFSL2hldnp4dlhwS2tUNU5udm1v?=
 =?utf-8?B?dGlXNHdxbHVMaTJxOThLaHN4R29XQjc2YTRna0VyaHdxOW9kRW1HYy9DaFhp?=
 =?utf-8?B?cDArTmVOWm41UWx5K2FLdll3a3NsWURnUFI4clM5eWxRRGlPRVBFa1o2dHBl?=
 =?utf-8?B?SDNhT1NmY1ZKcHNlL3p5L1k4aFgyVWt0eFhYRXdzZk05OVVrWGw5RHBwZmFv?=
 =?utf-8?B?WkhVL01DVUJmelUyT3pad1haNXhVSGc5TVV2TjlXZWlSU3lkOHNRNll0STE2?=
 =?utf-8?B?VDZkaVBqOVI4ZGZOZ1BhOXZzNXlrYlF3ZWJYZU1CbVY5U2pidjJFcXo5UzBT?=
 =?utf-8?B?aGhLSVFRdWRXcEo1UEpPT3JLZUxuS3o3SlI3bklQVExXUUFGWElsTTdRU2Zk?=
 =?utf-8?B?UzNWUHRYanZhb3NFbk1mdHVFWDljSUJVK2d4TEZBcWlEbkFUNk1ELy9MbXhP?=
 =?utf-8?B?UFhLNDg4d2lWK0crN2tUeitPK2UxR0NzcmRyU0dPYmx2THUzY1BtbDlML1VG?=
 =?utf-8?B?Y3l0eldzTmVXUFhlK0RZUmE1R24vY0Rmd0tNREU1bXBRZnZYbWt2cEJtaDN6?=
 =?utf-8?B?Wm11c0pyR0x0Rm5xanFZSHpnMUxYd1RMclo3UUpzSVJLblltbXRaSmp1dkFP?=
 =?utf-8?B?ZkxpZktMYVZDSGJ5T1J1OHlJNmxTRjM4NzJzUS85dnVVeDFrKzlieXNWdlN1?=
 =?utf-8?B?UU5sek1ORk1xZ0l5OXAzNXUrMUQ0SzRUMVgvMk1mNDRKRm1yWUdkUU9YRVhk?=
 =?utf-8?B?ckZZVzFqRHl0U0JsWVpObFV0dm0yRVVHUmxwVkVRMU9zNzZtb1BLemRaRXVu?=
 =?utf-8?B?dWtmVlZpNlJzYjA1SjBwb2JJLy81NjZaUU55VlM4K2REbC9CS3dHQ2E0MU5u?=
 =?utf-8?B?d0FjaE9PLzBqSEJCUU0xdVF0QUJqUDdaTFUrL29iU0tXd3F4anRTdkNzdm8w?=
 =?utf-8?B?L0FlYUZSbVpJaHA0WVQzQk1Gb2RYVm9CVll0RjZCQXlId2tOSDA1cnNDMDgw?=
 =?utf-8?B?Z1NvZ2NyTGlrckpPS2UrVEFJdS81UVNEQ2x2cit6WGZFb29kS3ZWTjBlYnNF?=
 =?utf-8?B?ZFJseEUzYzJ3c2ptU0U2aGpCK3NWYmRpOUtvdDg4cDM3U2h0dHFrS3cxZFNs?=
 =?utf-8?B?bUUvWm55eTh6Nko5RTFaQ3ZDZ2U5blJlQlk1bjZwOVpMVkRzMC9aNHRJZGRj?=
 =?utf-8?B?N2liL2Fsc3RXa1g4ZDNwbWxTR1FIVlZsQUlnU21iN2ZDWUFWSXBPNWp5NHRl?=
 =?utf-8?B?eFAvTmgvdm5VQm9Nbzh2cGZrMmZTeCtPUUxTTEpaaGJKdGVsS2VhZGh5MFEv?=
 =?utf-8?B?SjFHSklobEVyaDl0dktTUHhabnE2My9jNXNwVU5xODlhK3FteEZKcDF0aG1G?=
 =?utf-8?B?Vnp3b3RacllJS0VHdktsSTBBNStZd2ZvTDNDcDZUbVg1YWF0V2hIN1BXZk9o?=
 =?utf-8?B?dW9Rd2NVUzM2UEFUNUVxckl3K0lUaHZwS1gyYUk1WGdQc3NTcVFCS2g0NktW?=
 =?utf-8?B?WWFWaXZMdGx3Nk4xWGRsTElFWTVaang2VDhCS1h4SXloOHcxakJ0SmU5UDU5?=
 =?utf-8?B?SXNKZFBEd21XcUhkeFgrcmluUzllV3hZUVVXeE81REgva1Fwb2xET2pwejB3?=
 =?utf-8?B?b0Y0N1E3a202UzJQejlHWmh6OFU5VnRVM1JpaDdYME8rb2ttN2QxUTkzZk0x?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E863F72B69F27042AE4D2A949530A1BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0230ce5d-e03e-45aa-3f03-08dbb80e4d04
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 06:12:56.4071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+h1k4500PmiVWbYga1y0iyyXszrd1z1p6yWzjRaj/0MBj4LR1RISvlOYEYr3sow4NZofOkFWwiscNG1ss58fO1tKskw+ohsrTb6+FgsW/ywm3K/dIxR85VlO176UfZu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8073
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxleGFuZGVyLA0KDQpUaGFua3MgZm9yIHRoZSBpbmZvcm1hdGlvbi4gUGxlYXNlIHNlZSBt
eSByZXBseSBiZWxvdy4NCg0KT24gMTUvMDkvMjMgNzoyNiBwbSwgQWxleGFuZGVyIERhaGwgd3Jv
dGU6DQo+IFtTb21lIHBlb3BsZSB3aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVu
IGdldCBlbWFpbCBmcm9tIGFkYUB0aG9yc2lzLmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0
YW50IGF0IGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+
IA0KPiBFWFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEhlbGxvLA0KPiAN
Cj4gdGhpcyBpcyBpbnRlcmVzdGluZywgYnkgY2hhbmNlIEkganVzdCBsb29rZWQgYXQgYSBjaGlw
IGNsYWltaW5nDQo+IHNpbWlsYXIgZmVhdHVyZXMgdG9kYXksIHdoaWNoIGFscmVhZHkgaGFzIGEg
ZHJpdmVyIGluIGtlcm5lbDogQW5hbG9nDQo+IERldmljZXMgQURJTjExMTAuDQpNaWNyb2NoaXAn
cyBMQU44NjV4IGlzIGEgMTBCQVNFLVQxUyBNQUNQSFkgYW5kIEFuYWxvZyBEZXZpY2VzJ3MgQURJ
TjExMTAgDQppcyBhIDEwQkFTRS1UMUwgTUFDUEhZLiBTbyBhcyB5b3Ugc2FpZCAxMEJBU0UtVDF4
IE1BQ19QSFkgU2VyaWFsIA0KSW50ZXJmYWNlIFNwZWNpZmljYXRpb24gZGVmaW5lZCBieSBPUEVO
IEFsbGlhbmNlIFRDNiBncm91cCBjYW4gYmUgDQphcHBsaWNhYmxlIGZvciBib3RoIG9mIHRoZSBk
ZXZpY2VzLiBJIGFsc28gbm90aWNlZCB0aGF0IEFESSdzIGRhdGFzaGVldCANCnNheXMgQURJTjEx
MTAgc3VwcG9ydHMgT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4IE1BQy1QSFkgc2VyaWFsDQppbnRl
cmZhY2UuDQpodHRwczovL3d3dy5hbmFsb2cuY29tL21lZGlhL2VuL3RlY2huaWNhbC1kb2N1bWVu
dGF0aW9uL2RhdGEtc2hlZXRzL2FkaW4xMTEwLnBkZg0KDQpCdXQgaW4gbXkgZmlyc3QgZ2xhbmNl
IGluIHRoZWlyIGRyaXZlciBjb2RlLCBJIGRvbid0IHNlZSBhbnkgY29kZSBibG9jayANCndoaWNo
IGltcGxlbWVudHMgMTBCQVNFLVQxeCBNQUNfUEhZIFNlcmlhbCBJbnRlcmZhY2UgU3BlY2lmaWNh
dGlvbiANCmRlZmluZWQgYnkgT1BFTiBBbGxpYW5jZSBUQzYgZ3JvdXAuIE9yIGRvIEkgbWlzcyBh
bnl0aGluZyBoZXJlPy4gTXkgY29kZSANCnJlZmVyZW5jZSBpcyBiZWxvdyBGWVIsDQpodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC92Ni42LXJjMi9zb3VyY2UvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvYWRpL2FkaW4xMTEwLmMNCg0KT1BFTiBBbGxpYW5jZSAxMEJBU0UtVDF4IE1BQ19QSFkg
U2VyaWFsIEludGVyZmFjZSBTcGVjaWZpY2F0aW9uIGNhYiBiZSANCmRvd25sb2FkZWQgZnJvbSB0
aGUgYmVsb3cgbGluaywNCmh0dHBzOi8vb3BlbnNpZy5vcmcvYXV0b21vdGl2ZS1ldGhlcm5ldC1z
cGVjaWZpY2F0aW9ucy8NCg0KSSB0aGluayBBbGV4YW5kcnUgVGFjaGljaSBmcm9tIEFESSB3b3Vs
ZCBiZSBhYmxlIHRvIGdpdmUgdXMgbW9yZSANCmluZm9ybWF0aW9uIG9uIHRoaXMgZGlyZWN0aW9u
Lg0KPiANCj4gQW0gRnJpLCBTZXAgMDgsIDIwMjMgYXQgMDc6NTk6MTNQTSArMDUzMCBzY2hyaWVi
IFBhcnRoaWJhbiBWZWVyYXNvb3JhbjoNCj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGNvbnRhaW4gdGhl
IGJlbG93IHVwZGF0ZXMsDQo+PiAtIEFkZHMgc3VwcG9ydCBmb3IgT1BFTiBBbGxpYW5jZSAxMEJB
U0UtVDF4IE1BQ1BIWSBTZXJpYWwgSW50ZXJmYWNlIGluIHRoZQ0KPj4gICAgbmV0L2V0aGVybmV0
L29hX3RjNi5jLg0KPiANCj4gU28gdGhpcyBpbXBsZW1lbnRzIHRoZSAiMTBCQVNFLVQxeCBNQUMt
UEhZIFNlcmlhbCBJbnRlcmZhY2UNCj4gU3BlY2lmaWNhdGlvbiIgd2hpY2ggaXMgRXRoZXJuZXQg
b3ZlciBTUEkgaWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseT8NCj4gVGhlIGFib3ZlIG1lbnRpb25l
ZCBjaGlwIGNsYWltcyBkbyB1c2UgdGhlIHNhbWUgaW50ZXJmYWNlIGFuZCB0aGUgc2FtZQ0KPiBz
dGFuZGFyZC4gIEhvdyBkb2VzIGl0cyBkcml2ZXIgd29yayB0aGVuPyAgRG8geW91IGFkZCBjb2Rl
IGZvciBhIHRoaW5nDQo+IGFscmVhZHkgcHJlc2VudCBpbiB0aGUga2VybmVsIG9yIGRvZXMgdGhl
IG90aGVyIGRyaXZlciBkbyBzb21ldGhpbmcNCj4gY29tcGxldGVseSBkaWZmZXJlbnQgYW5kIEkg
anVzdCBtaXN1bmRlcnN0b29kPw0KQXMgSSBtZW50aW9uZWQgYWJvdmUsIGluIG15IGZpcnN0IGds
YW5jZSBpbiB0aGVpciBkcml2ZXIgY29kZSwgSSBkb24ndCANCnNlZSBhbnkgY29kZSBibG9jayB3
aGljaCBpbXBsZW1lbnRzIDEwQkFTRS1UMXggTUFDX1BIWSBTZXJpYWwgSW50ZXJmYWNlIA0KU3Bl
Y2lmaWNhdGlvbiBkZWZpbmVkIGJ5IE9QRU4gQWxsaWFuY2UgVEM2IGdyb3VwLiBMZXQncyBBbGV4
YW5kcnUgDQpUYWNoaWNpIGZyb20gQURJIGdpdmVzIHVzIG1vcmUgaW5mbyBvbiB0aGlzLg0KPiAN
Cj4gQ2FuIHRoZSBkcml2ZXJzIGZvciBBRElOMTExMCBhbmQgZm9yIExBTjg2NVggc2hhcmUgY29k
ZSBiZWNhdXNlIHRoZXkNCj4gdXNlIHRoZSBzYW1lIHNwZWNpZmllZCBpbnRlcmZhY2U/ICBUaGUg
cGF0Y2ggc2V0IGRvZXMgbm90IGxvb2sgbGlrZQ0KPiBpdD8NCk9mIGNvdXJzZSwgaWYgdGhlaXIg
ZGV2aWNlIHN1cHBvcnRzIE9QRU4gQWxsaWFuY2UgdGhlbiB3ZSBjYW4gdXNlIHRoaXMgDQpvYV90
YzYuYyBmcmFtZXdvcmsgdG8gc3VwcG9ydCBvdGhlciAxMEJBU0UtVDF4IE1BQ1BIWSdzIGFzIHdl
bGwuDQo+IA0KPiAoQWRkZWQgdGhlIG90aGVyIGRyaXZlciBhdXRob3IgdG8gQ2MuKQ0KT2sgdGhh
bmtzLg0KDQpCZXN0IFJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gR3JlZXRzDQo+IEFsZXgN
Cj4gDQo+PiAtIEFkZHMgZHJpdmVyIHN1cHBvcnQgZm9yIE1pY3JvY2hpcCBMQU44NjUwLzEgUmV2
LkIwIDEwQkFTRS1UMVMgTUFDUEhZDQo+PiAgICBFdGhlcm5ldCBkcml2ZXIgaW4gdGhlIG5ldC9l
dGhlcm5ldC9taWNyb2NoaXAvbGFuODY1eC5jLg0KPj4NCj4+IFBhcnRoaWJhbiBWZWVyYXNvb3Jh
biAoNik6DQo+PiAgICBuZXQ6IGV0aGVybmV0OiBpbXBsZW1lbnQgT1BFTiBBbGxpYW5jZSBjb250
cm9sIHRyYW5zYWN0aW9uIGludGVyZmFjZQ0KPj4gICAgbmV0OiBldGhlcm5ldDogYWRkIG1hYy1w
aHkgaW50ZXJydXB0IHN1cHBvcnQgd2l0aCByZXNldCBjb21wbGV0ZQ0KPj4gICAgICBoYW5kbGlu
Zw0KPj4gICAgbmV0OiBldGhlcm5ldDogaW1wbGVtZW50IE9BIFRDNiBjb25maWd1cmF0aW9uIGZ1
bmN0aW9uDQo+PiAgICBuZXQ6IGV0aGVybmV0OiBpbXBsZW1lbnQgZGF0YSB0cmFuc2FjdGlvbiBp
bnRlcmZhY2UNCj4+ICAgIG1pY3JvY2hpcDogbGFuODY1eDogYWRkIGRyaXZlciBzdXBwb3J0IGZv
ciBNaWNyb2NoaXAncyBMQU44NjVYIE1BQ1BIWQ0KPj4gICAgbWljcm9jaGlwOiBsYW44NjV4OiBh
ZGQgZGV2aWNlLXRyZWUgc3VwcG9ydCBmb3IgTWljcm9jaGlwJ3MgTEFOODY1WA0KPj4gICAgICBN
QUNQSFkNCj4+DQo+PiAgIC4uLi9iaW5kaW5ncy9uZXQvbWljcm9jaGlwLGxhbjg2NXgueWFtbCAg
ICAgICB8ICA1NCArKw0KPj4gICBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvb2EtdGM2LWZyYW1l
d29yay5yc3QgfCAyMzEgKysrKysNCj4+ICAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgIDE1ICsNCj4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9j
aGlwL0tjb25maWcgICAgICAgIHwgIDEwICsNCj4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWlj
cm9jaGlwL01ha2VmaWxlICAgICAgIHwgICAzICsNCj4+ICAgZHJpdmVycy9uZXQvZXRoZXJuZXQv
bWljcm9jaGlwL2xhbjg2NXguYyAgICAgIHwgNTg5ICsrKysrKysrKysrKysNCj4+ICAgZHJpdmVy
cy9uZXQvZXRoZXJuZXQvb2FfdGM2LmMgICAgICAgICAgICAgICAgIHwgODA3ICsrKysrKysrKysr
KysrKysrKw0KPj4gICBpbmNsdWRlL2xpbnV4L29hX3RjNi5oICAgICAgICAgICAgICAgICAgICAg
ICAgfCAxMzAgKysrDQo+PiAgIDggZmlsZXMgY2hhbmdlZCwgMTgzOSBpbnNlcnRpb25zKCspDQo+
PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L21pY3JvY2hpcCxsYW44NjV4LnlhbWwNCj4+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vbmV0d29ya2luZy9vYS10YzYtZnJhbWV3b3JrLnJzdA0KPj4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9uZXQvZXRoZXJuZXQvbWljcm9jaGlwL2xhbjg2NXguYw0KPj4gICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvZXRoZXJuZXQvb2FfdGM2LmMNCj4+ICAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvb2FfdGM2LmgNCj4+DQo+PiAtLQ0KPj4gMi4z
NC4xDQo+Pg0KPj4NCg0K
