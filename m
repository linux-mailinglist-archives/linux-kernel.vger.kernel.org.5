Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93C57A60FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjISLPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjISLOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:14:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8582D7E;
        Tue, 19 Sep 2023 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695122036; x=1726658036;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nvYREegptLbLU9C96sEDqoWc7+it5HIqTU+CP//ycYQ=;
  b=DzmPqGceN/IFX37im1hNjFpCO4uOZ3S/WDkVU/Xs+MdlIw6Y0COigyEs
   s/B5yVF9cmSEiTsrV/PBJtDgFd6fRBWqfMjsmdFEJUXmOrD5SAk9cK7re
   XnIgi/coflj6xOcCCan+JrkJ1OyQHgNo3/3X+IWcJ8Yii40EZTlYqLOTb
   QB35VasKaQ5ZzeHwbG05GnIZWl+2/yJ8m/IrImXJtof0ZkPHPN6aP00kV
   L5Wcj2Rj0E2MuWMvvsD6Drjc2EcSVvubtHLwnxaeq0TxoSGhdTxkWYIrN
   t+xtJ+nAQORPcUjwdJ0pDNGYKYE903xFOLhK9jhQtBAE3nF4nY2nz/NkP
   w==;
X-CSE-ConnectionGUID: fFPnucd/SCK8IEWNYATfjg==
X-CSE-MsgGUID: flZEG7qAQNisRDmsLPDaAA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="172412939"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Sep 2023 04:13:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 19 Sep 2023 04:13:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 19 Sep 2023 04:13:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TltWFwo7esIzrf2DxnUElG84t8nm10wuazsoxw+BnSymmJNq6lxwfgIdtwmDp82MQgiRFp9/WqyIIbaSzjDZXhBziGV6tCrBgYoXQShHkIdmjV4G0k3mh8pQmSu5dvAAD7tmcq7xm4C/AAVnfVyv8ypAkwayOlhmsBOqL4FxZ47Y8pFHXUeupZLWHzQzolkmH5wzhUAAHtiAWGhWBYa/W15isnxQuqiR6pHIbOb+3Rky/Grff7dVcTIInIh5P2CLX7Dhls0/RiWOE4qGN7QNV7Z/YGRQFfd1ERyCcjssZJTX/8i5zCqYALHvZaaHesk4jdO5u9DlZUu5/uopwSK/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvYREegptLbLU9C96sEDqoWc7+it5HIqTU+CP//ycYQ=;
 b=AYdkOKJiPDLacQCIk1ww2UdfhC4Aj2/v4M2LalPisScSJs5mw26x8iLorscl3sMryWGeX69LMC7Vociv7lbrX0MaCCIRQLZaV7oZczQbyw6wh7GGcNpkatJdmreLoI3l+sbsaoQNw7IOdw7VruRwboNChNiy+/HZuo0gN6b6Eh8J4U9In8e6cAkYLbdFkCwsynJr2yHLXrc2bzdyB4bDh41K9ul59in5uzXcAdCFIUUj0wFIXqO72fizbCU7U5MNb4B+WWb+cQU3VRwwhY1YVLPv3Ofh+yVZXpouKRuSRIe6VudgjdAJLN7GKpLrxQyB5ZGxu7TT1CmBOkKe5fXU+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvYREegptLbLU9C96sEDqoWc7+it5HIqTU+CP//ycYQ=;
 b=Ab3wBtdcGYKR2U6kxBg4Pp7xloK1JPuFovNp8wCF67Ls+YdtAehQqk28U3iJaT1VVKUAMcIf3tGNa/kRZ8f2mXvxTRn5P6gdZtlNzmk8RVCegSe18NkxtT8PZC4945gSgW35ScWIe3xvOIXDzHLymBD5lykcUmGAyxsZBhOy9pg=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 PH8PR11MB6610.namprd11.prod.outlook.com (2603:10b6:510:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 19 Sep
 2023 11:13:13 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 11:13:13 +0000
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
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Topic: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Index: AQHZ4mEB+nwP90vbvEyYqcmk7ntkibAYC/aAgAoD1gA=
Date:   Tue, 19 Sep 2023 11:13:13 +0000
Message-ID: <9615b403-52c1-f24f-382f-8eea3ddfcf04@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <8d53ca8d-bcf6-4673-a8ff-b621d700576e@lunn.ch>
In-Reply-To: <8d53ca8d-bcf6-4673-a8ff-b621d700576e@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|PH8PR11MB6610:EE_
x-ms-office365-filtering-correlation-id: b3d1db76-f967-4051-a637-08dbb9016a55
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /LOrD6N/HE6zFYkRVdPinKP21L3B2BAAk7P3CW+eRI49e27+hS4qvzxbt7AF2GKKbK9lvOvhtXMCsig+XPFERv9p4tMaUfqn9IiYERx94bteSI9W8lBU9SD9/K6DJ/INKqW0qwQ3xi0sJHEkACqOif0Whd/qKKb5zYP2Mk7lRJdNvtA8MQ2riMm7Gv3PL7Dr0iu8m2UWp0NdVpme9j/sQhuuK2gOLrHt93mk1+fwyOkPnPASqN42BhIqtzsG7IddQexS3dr9welFpNeybAWQBderV8Z+Doo7xQe2Ijhfe2GIsK6qroxYprRb/swQgfqWPpUs4CdN2RUBbOg7AasceiCCJqDyMqiIyCSOziR6ikbgZuAEN0Nyo/o8p4V9JAozyiNRR7kxy8IDteMlfHq8Gt5MYB9qtZBIJG+2jUMXRJPvalkqkb40aCXQLIIIgHjRFzw7RGoRP4IT5C1SlF8hmx+aMLhgwVwKnHPPpBK3/+KGNatq+/rlc1h9Chd1RRSmH03rwyBslI8qUUVT9epDYtP+QCBpgFt/h5Cjcjfiwp4amjfPTHb9xs2mHvmEN9Irxvuri1XDq/2rqYjXe/Gj+b5U4vmLgJT1RP5J9kd7tfcNuBHR7O9q4gjxtofjrlnWw6xqqM9Ou88K2OJg8FLd9p/prEBLcmGb1UhwJi095DfpkrBMCPGLUd0BO+clQwqJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199024)(186009)(1800799009)(53546011)(31686004)(4744005)(2906002)(7416002)(8936002)(4326008)(41300700001)(5660300002)(66446008)(54906003)(76116006)(91956017)(66556008)(36756003)(64756008)(107886003)(66946007)(8676002)(66476007)(6916009)(316002)(122000001)(478600001)(71200400001)(6486002)(26005)(38100700002)(6506007)(83380400001)(31696002)(38070700005)(2616005)(6512007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXd5MUpjN3B1cXowUzdzK1AzTTlrd05IOVA4clVKZ01nUEdnL3p3MXlwTG96?=
 =?utf-8?B?K1FyL3hDVklXbkpmNEZTa0RiT3lDUDZ1eHU5V0s2UGtYR0RoZVNUNTV0SUJ5?=
 =?utf-8?B?ZG5IcWlUUmMxY1kzRi9XWTJ2WnBVbng5Y3dHV0RlZmlsSDhRbDJZdVpEdDBX?=
 =?utf-8?B?TW1sTkZQNzdyVElMZjJhN0VBS1NzaTc2VUJ3d3B0cU1kWnNvdUhxVU81MC9o?=
 =?utf-8?B?YjdXeUMxYXJlZ2hRdHo2RzFUV3gwbFM4aldpVjFmM1JQYVpPdUNmUGxIL0or?=
 =?utf-8?B?SVo4b3hTOWRCMUhSNVo2VklxYUlKekt3OSt5NVNDOWV4MDVoMGMxTHRnenIy?=
 =?utf-8?B?anNyNlRtL0tsY055V3gzSmsrR1E1VDRwQXZCQzJ4aTUrVjZIODIwaHVFMmlG?=
 =?utf-8?B?THYxcExUaWdLSVIxVFZCV0ExbEo0TTg5bU1uS0N5L0JwY3pDYlY2azRmMmo1?=
 =?utf-8?B?YU9pcFdFUlpYdVlGZmd1MlFmc0xib1k3ZFQ0azJTbGRjcEJyeC9DWmVWQXNL?=
 =?utf-8?B?bVFpR3JwM1VlQkhrZ1VpM1JDa2NTMmM2UTFUNmRmczNsU0pXdWNoaFRoVnRD?=
 =?utf-8?B?cUZNQjhCZy9CY1E2YytabWVvV291SlNjUkdyNDRnS1dUaytrV2RhZDh5blJD?=
 =?utf-8?B?SCt3Y2htUEZVejF2c1RzNkcxKy9UdjFmaXlybnd6cnRUMndYeXRhaEE0Rkpm?=
 =?utf-8?B?V2Uzd080TFkvb3paKzFGNnk1SXVVODUvNkhVTXBGSXpXWExSY1JDT3BlNGsw?=
 =?utf-8?B?OHlTVzhTL3Q0cmxHRXpEaThrRzVCdnpvZEk5K2dKSG1hNFNQTFVFNWhXSmZH?=
 =?utf-8?B?UlBDRVltbXRPdllkOVBINFNZT0h6N0o5OGp6c0pMTUltQzNGb1U5Uk5PZFFy?=
 =?utf-8?B?d1dmcEJURWtabVZ4enFRQjRMWkFXQ0ZhbDNLWGpSakp5OU9YTVN1YVRnaVd6?=
 =?utf-8?B?aUVTVE1jN080UlZVTm5GRi92ZmtLa2lFTGkxYTY3c28vWmxmVXNVTHhRZmFN?=
 =?utf-8?B?S2VwZFE4cllucndlTnNDNVNPL3ZKMnZ3K2ZwMDd2NjR0amFLdDRXY3puN0pR?=
 =?utf-8?B?a1dNZjZweDZRdnpsSFNmQ0o4V0d0Ty9lVWlGY2J0L3JyMFZjZHBTNXVFZWJL?=
 =?utf-8?B?TnNiU1lTMGZtb0dHY201YTA2cEVLWU95bkJwME5sQUg3SzVETVE5aXNyTXBu?=
 =?utf-8?B?ZjZUb2g2aUppMWVGRkxEd0FOVDVlQ2w4UlVneVNsalRoMkhQSlFXR0lhbFFr?=
 =?utf-8?B?SDh3MkZvV0tmeXp3VWxzczA4ZUNnUHRXa1N5akp4Um1rVHJtYXdoSDViWFp3?=
 =?utf-8?B?ZldCTVdUelIwTTkwQWdwQ3M4Zit2TFhFWk1mL2d4WGZVeW8vUWpoa0tkYzNs?=
 =?utf-8?B?K3F6OXpwODV4Y2kwVmFIaWR3dWl2eThLNU1EdVZ5MUZsZDZPWUNwclNoWTBw?=
 =?utf-8?B?UjltZHBONFdYV0d5ZWYyTWg5SlIycmN3K0pZWDlmZHpQUjkzMDdjUHh5UHE0?=
 =?utf-8?B?QSttU3lxa2lVTFJiNEFBR1BCbFV2R0FUTWtrRUllQ0NWeUgrb0JhUUhsbnh1?=
 =?utf-8?B?SHlFNi8xNnk2b2xlYm5DZkVsdzJ1d1BPTnl4Q0RkVEMvaXd1MmU3TUx3dVN0?=
 =?utf-8?B?bUd2c0NjZDFsdnE4cDhMOTR6OWFMa2tNSWdFL2VGNGlubjJ6dzhBQ2FhaXFl?=
 =?utf-8?B?aTdZNHowN0hObHBidWNSYzZPaUc1NlVCZHErdHRta3hSdUlBZG5qc0xQL1Vi?=
 =?utf-8?B?Qzd5b3hUdVJhazZubFJoQ2hqb241QXltUnNtVlRPaWdlaHhlMS9xQU1McWJP?=
 =?utf-8?B?N3lEbHFNRW1RMm9PYkwrRFJGRG1Tdm1WS0xhRGJVWlhCSVRFY2dpY0pKWGhv?=
 =?utf-8?B?eWdlRXpEMGdVMWlkc1o2UlhtdzlGOHpVdS9xWVJtMFBXMTNVRDd6c3hFeExB?=
 =?utf-8?B?d0FSS2wzajR0ejU1V3JIYVlybkNaMk91UkxUMU0rTzBoTzY3YWwwOEZ5eEZp?=
 =?utf-8?B?N2dmaFJCMFZpUVBMVmFpTUN6cGRQUitrSXV5eUJKSEdzWGFQWTBBY25vemMz?=
 =?utf-8?B?bUEzbWh5WnpNUURjbHc2RE9UWWFtcHBhVGdFNW9QQjN1b092eHE3a0RhQVFU?=
 =?utf-8?B?eUlVLzE2Z3pFd1ZLeDlwQnBYOHdRK2g1TDE3TW5LTUhrc3JFUEZIdm14Q1Qr?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D67B64EA4A16E34BA54D786030351F0D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3d1db76-f967-4051-a637-08dbb9016a55
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 11:13:13.2819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Zm47iGeyvjiA3w6z0q9vA/y5me6oHTZhX/d751BmpxWnUe7ZYEeamj3DFJK21IYUa3FU668vZqMz9N70VLuTShD6ZjgXTIMZ1Xh00WMW3m8gN5Ji3p5dERobquc8Pu7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6610
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAxMy8wOS8yMyA3OjQ2IGFtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gK3N0cnVjdCBvYV90YzYg
ew0KPj4gKyAgICAgc3RydWN0IHNwaV9kZXZpY2UgKnNwaTsNCj4+ICsgICAgIGJvb2wgY3RybF9w
cm90Ow0KPj4gK307DQo+IA0KPiBTaG91bGQgdGhpcyBiZSBjb25zaWRlcmVkIGFuIG9wYXF1ZSBz
dHJ1Y3R1cmUgd2hpY2ggdGhlIE1BQyBkcml2ZXINCj4gc2hvdWxkIG5vdCBhY2Nlc3MgdGhlIG1l
bWJlcnM/DQo+IA0KPiBJIGRvbid0IHNlZSBhbnl0aGluZyBzZXR0aW5nIGN0cmxfcHJvdCBoZXJl
LiBEb2VzIGl0IG5lZWQgYSBzZXR0ZXIgYW5kDQo+IGEgZ2V0dGVyPw0KQWggb2ssIGl0IGlzIHN1
cHBvc2VkIHRvIGJlIGRvbmUgaW4gdGhlIG9hX3RjNl9pbml0KCkgZnVuY3Rpb24uIFNvbWVob3cg
DQptaXNzZWQgaXQuIFdpbGwgY29ycmVjdCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQpCZXN0
IFJlZ2FyZHMsDQpQYXJ0aGliYW4gVg0KPiANCj4gICAgICAgICAgQW5kcmV3DQoNCg==
