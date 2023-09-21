Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661717A9A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjIUSii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjIUSiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:38:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035E3D9D2D;
        Thu, 21 Sep 2023 11:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695321067; x=1726857067;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4CBlWrRqN6+qOz8LP5mj33zgeI90jKrIMnedYbzTQnY=;
  b=o85zB6/mwwD8ToFtbpG0Ny22FSJZNr3tbF8WeLnJhNrdSjXvZ0xlvAq/
   DSwm4UE1kg7NrcavH/8lxR6NXJt02CUjOcQDcekLX1s0ED/37Ubz8Jr2p
   Neo+K54a4DAWTAF8FKR8kbkn5EUvwnpgIqCbk7h9hvqiR4K8lwLVfUEda
   LIfvXcLQnnjcfIYNkegC4MnRN6rx8jYmXQ4Lv43FtP8FTgvfS+3gGrqXO
   1/gTp6L995FCQUJraA+bAfj9feK/RXQP2tavd7zHELAAPT97N69HWxR44
   qY+ugaoxelG3HgV8RM0Y43MUGeijCbcosYxxt0oZNSFKFYLxrP/wSL9LJ
   A==;
X-CSE-ConnectionGUID: BQS9kesvT7aQsqy7lhVmLQ==
X-CSE-MsgGUID: vklMglAhQLuV02jQq6ROgQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="172820029"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Sep 2023 02:15:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 21 Sep 2023 02:15:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 21 Sep 2023 02:15:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYT1Qb4a1vCKgNb3vutMjabktd1tGaLBXOO7sFyZa1eeFhZBdicmao0bKHrub3AwQZCKkI1H2tOaGsKvAd55iEJM7EBlbRb6DXuphQZ2+hSCJUxL3OxGSZnTdToG7426Y/z8wU6J4apKtmqoJsiKdxRsDzW7Goa+Mc93Q/Yhb7YW1PEopqDfazv4x9U8RNK1NWu4avnjJ2MjUiE80HSSh6ax5VqjxUU3jThUdCr1jC4QqunjHh4f4HNyzAHAzhef7rfnn9KbUdGlekN6PLBJLTokaPpsu4kBQi+XGz2KArD2/+4XrY47hhU+6bTkLTMy4wgPqC/zneDBZB/u3YpI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CBlWrRqN6+qOz8LP5mj33zgeI90jKrIMnedYbzTQnY=;
 b=UA7VDqz7NNbqoLG0f5QTdLcdHvy423Ky7X0Th0enTOANoffi0Ta0e4Tk7pVnHDaFX/Fc69Xxluz0TmhYSkOUxEJjb7lnUaUjQr3AeToMwLH7L0szg9REjvxnOBsRQWVHJoXT82H9b2UAQ9d4Z98SN6T1+ZEVA2nXbTBfNiTVd6uFeiTp/eahhgY79jh/NU0biZMtz2Lwln8tl1dhOPVK7xBVF8M73UFiFKYFosZjqh+M0hSHe16DG1Helf0QgzNewmyC/hKvem/BaL+WTBPAfSR1Mr6D7ezr1hlPSTv3TQALNgdJLpG84xa5K7XsIz8vn3UeAtDHpMU5ii1nxrj1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CBlWrRqN6+qOz8LP5mj33zgeI90jKrIMnedYbzTQnY=;
 b=ff9HoBRwr7NVM2S82rgpLkxgL86Zztacmo0/W61O6xUeX31zz/XLi/yoBit+YnIjxN0zHSYWsrprH1kkK6ZXynJXkM9un2XkRb86usilRSmOl1/qPwqs7sO3KaO9A0CtoZNOs3hl6JfvtvoWJmRPffOqgVcUuqeDmgi6mzuY0O8=
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 DS7PR11MB7782.namprd11.prod.outlook.com (2603:10b6:8:e0::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.21; Thu, 21 Sep 2023 09:15:29 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::6352:54f7:6c42:69ef%7]) with mapi id 15.20.6813.017; Thu, 21 Sep 2023
 09:15:28 +0000
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
        <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>, <Ciprian.Regus@analog.com>,
        <jtm@lopingdog.com>
Subject: Re: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Topic: [RFC PATCH net-next 1/6] net: ethernet: implement OPEN Alliance
 control transaction interface
Thread-Index: AQHZ4mEB+nwP90vbvEyYqcmk7ntkibAYCnuAgAoMZoCAADwLgIABZ4MAgAAP5YCAAUkogA==
Date:   Thu, 21 Sep 2023 09:15:28 +0000
Message-ID: <03cfa7c9-53a3-9107-c185-7e5953475518@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-2-Parthiban.Veerasooran@microchip.com>
 <f23997c1-7507-41c6-8bb3-47d6a353beb8@lunn.ch>
 <14c089d7-4d34-9cd5-7f77-55c80815e003@microchip.com>
 <deff3e64-a10f-4d07-9651-502442a86987@lunn.ch>
 <cf23ed3c-d1cb-61fd-a305-e2787ef70cb1@microchip.com>
 <52685909-ec92-41b0-957f-25da8a9be9eb@lunn.ch>
In-Reply-To: <52685909-ec92-41b0-957f-25da8a9be9eb@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|DS7PR11MB7782:EE_
x-ms-office365-filtering-correlation-id: 8a0a7ace-7ad3-49ce-d870-08dbba834c70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uZ5ycJFSUKFx+Mf/sbb2RRE1xNfmNAJeu6NLaRKbhknUM9qJm2Gx38b05GVNbI0IE4+hvLyPi+ppklvNB8MqnCsk2i2BJk2kAZTyGB5xV1a/zffaFp13MsUM1DYi6WdEEwkWJnB4adBzy/RIYzeT9UqtzISmashH7IIYpyQ6P2qI10PzrXlnVx3HC5mzxOSXlSATztUvmG+24gdf94GgcbNe/4SIHVqgEnfIIC9ThqqTXygK2jNOpmuFrh9xEq4vxTAiZbGiQT+Fruv8vwLOpFkFBgAaApBaIDfFuLak/Yf6tTTnAmNHDiuwV+8exVEzgg2Pc/9NHs4+N2zy61mCQZuhXUf9bcLaNAFGv1uoj1rEUB/YlujE1lAocTashPCGo1jz5kf1EHxBm+3z1yMGGlCWg7vKAoEkb5YAVB1m2stXzxX2heZuvDgGjmTPYNMNVySlfclkROWgPep+dc9qhiVaYxJ75TT1I7k+5aTpozmLPDf0lkyFHPXjdXd+qBRt1VMSBYQWXM+kYGW9DLJ4emE4357ViuKWbnpp64+FOONcaDIXWwIvXR3daRRXbkNLtnXPAck1yE4fgvANkMwnF9i5j3+WF8cR21Y1Z3APJp1BZsEd+g/uN8GcSrEeDx7xiDRroC/oLLg0ivD3ddNnUSyXNm6mlUiLwLW/mJUNoO5DkzVByCfqLu3gnT2l1yI+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(478600001)(2616005)(38100700002)(38070700005)(26005)(71200400001)(6512007)(6506007)(6486002)(53546011)(122000001)(5660300002)(4326008)(8676002)(8936002)(41300700001)(36756003)(64756008)(76116006)(66556008)(66946007)(54906003)(66446008)(91956017)(66476007)(316002)(6916009)(86362001)(31696002)(7416002)(31686004)(4744005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0hJMGcwRkdpWVdJZ1VvQmRlcVRQUWVzangyTytOTTNmWE1xR0Erd3VmTW0z?=
 =?utf-8?B?UFgrRkw2SEJCcDVML2U0THRkVzdMSlZGcFliOU15U25YWGJ4dHdhTGJQZkVo?=
 =?utf-8?B?YURSS3NqNUl3K29KelFhdUh5N3FIUXJyM0pGaVhSblM5SHlYWG5xYTFPR2lx?=
 =?utf-8?B?TGlHSVNYTGhnMGZaS1dLOHJ4TnJLQXlyU3dndUZSRzlEYk5oK1AyRXJHRGNa?=
 =?utf-8?B?ZTBMWlpyVkd4Q1NOVlFlTEZUWWNERlUzdUNVb1g3b1UzTlNpQmdnWE9sdVpE?=
 =?utf-8?B?VTRBRGVFbnNxWFl6YTBRbnJ4d0xQb25jdlNUNmRxSTN5R21KYnkwUDBhK3FX?=
 =?utf-8?B?cDlGRkY1ZTYxOFdKV0ZUeE0zcGFCRGZqTU04NG9hMlpSUHNKVktRTWFxWDdl?=
 =?utf-8?B?cEQrQVJUaHFHYzRXWXdHSXZJaE5uNU5GbUVkYmg1eU5tQXRmV1BjbCtuMGRv?=
 =?utf-8?B?VVBUTUhWYUFvYUFySVdBK2JTVHhzQzhlZS9MWjh4b2JzckVoQzRyQS9NRjBB?=
 =?utf-8?B?NG9XQlZrS3hKWEVGM3ZTVVFNMFcvaE5GOFF2aHZSNmxWZXpxSlFGWkM4Z3N6?=
 =?utf-8?B?MDM5M2l6VjhNNEh0NVg5NzFSVkRBd2xPNHBsMnRLc1g3MWZDYmxIQjJPSzh5?=
 =?utf-8?B?K2NINmpoWXduTDR6T3Q5UTBudHNLZ0RrRFF1ZWV4Q0J1SmhOVVE1TnE0VTFV?=
 =?utf-8?B?eEdTRHF3NnNRZVZiUTdGajhGdlBhZ0lPaC9Tamt6TTQ2amd5YVlxekoyT3Fm?=
 =?utf-8?B?b25MRUUySThUZkorZ05SYlV5b0RpVmt5a2cwU0xoMUFxV2Z0bDhmSlBheXN5?=
 =?utf-8?B?Qno0NFZzRnR3UStHdUE4ZUdVTlAvbkVlMVF0ckRlMTNrRlowRHlXbkh1MFNO?=
 =?utf-8?B?ZkVaZmdrZnVTMysxTmpqTzMvRS8yc2FvMEdIV1FCbldNY1FFbW9icittZ1NN?=
 =?utf-8?B?UHRCUDNWUHJhSnZtQzl0U25qeUpTTW5Fa0tWWTN4ZHdqUGRTbzNFWndDRkJy?=
 =?utf-8?B?amt6bDZYd1Mzb1JPcERvQUpzaVhGTUJYZkkyRUFPWmZNMU8wek9XSEJweFg2?=
 =?utf-8?B?czFCK05rc2NES1dobDlGT1NCMGJ0MVhCdVB0ZVRCQkdLUHZKOG8wQnFDVDQv?=
 =?utf-8?B?a3lYY0hKL0NTV0E2bzVvOVNlQ2t4amlMd2Q1ME1udkprK1lGZVZYOVFzNHph?=
 =?utf-8?B?aWJBQlpLNVBKS0p1N0d3UVYwSEJXUEREZTJJcUlqZ0RFVGN6S1IwTS9taXZC?=
 =?utf-8?B?Z05HU2RrTURkMVluVzJQK21TUGJpV1pLb1krMmRSditBWjBGUjZKZktQSGdR?=
 =?utf-8?B?SFk1bmE5MTVlOHRGMWQ3eW1NbE03eU9Vc2o3bVd5aWJNd3dtaUovQ0NiZjNo?=
 =?utf-8?B?c1NNdkpZeUNOWjA3dnA4VXJvSUZEeUJmRDBFVWVXcmdESWlCaVBoQmFZNXJK?=
 =?utf-8?B?ZFVRNjUyeUdrdmtXelJ2VEE3dnBmYk9pZFpxcmM1U0R5SElzMkpsT3ppSkZO?=
 =?utf-8?B?UThYOHpGeTdsRDc0TURQQk4vVmkwbklpT0JKVXpDR0NTSWhidWI5dzY5TTQx?=
 =?utf-8?B?Q3VaNWMvMHo1ajZhZlZTaXI0L08rV3BzU1RsdzZlcHJjZXplajYyemFrTDFN?=
 =?utf-8?B?akRFYm9Tc2ZQNXhPZDBDVm00bGV2UWI1Nm00MlRmbGpUdEp6aUt1U0VRa1RJ?=
 =?utf-8?B?aUFwZnZOMXo4dHRnclN4L0tuRUFzbW1GV0JHZXRqRGZNd0c5a28reDFjMkJ2?=
 =?utf-8?B?M3FGYjR2YjhZaFp5cWF4d2pTVkg2NXJMQS9FcXdLSkQ4WXFyNXMwWno5Z281?=
 =?utf-8?B?VDVGVXd4QVJ4cForZGYxaHAxZmh4enB1THhhdmZuNjROWkF2ZnpkUGtIMjJj?=
 =?utf-8?B?eTRmSmRNRlhkdVVjMzArTGFFMFF3Ui9teXgzVEFHOWx6dmlEanVVR3luR1Jo?=
 =?utf-8?B?ZzBXdWNPT3BjZ3d6ejhadnBtSWdhSHFCVFVqclkzTnJ5SThja2ZNcGpsbTVS?=
 =?utf-8?B?UzFPR25Pa1hrNDJDdzNGQXd3bTJTKzVpK05YYjFTUnhtcTJIempyNlVWeml6?=
 =?utf-8?B?STJrUUU4ZXJoamNhKzZmYlhNaFNOd1JzT2V4UDV1aXR2SHhWZFlqbnVrOHMr?=
 =?utf-8?B?cUdoNklTTlc0dHJWUlhpOHhROGx1L0hTYVdXSlppdEVTUTExZmdyVGw5VjF3?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D2FE3F03D81BA242ABA356357B2352EF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a0a7ace-7ad3-49ce-d870-08dbba834c70
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 09:15:28.8489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xJ5uD7ft1udRWeXQgxcwawH1eavlLzWA3vxfvWYoosoxf7+voXLXJkumY8I90PfN9l8YjfMbJGJVie9i1twYGyRMjnyMZKQHzqT5UVxdLOhPLUZAv9qoPrTGpIdw+Qs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7782
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmV3LA0KDQpPbiAyMC8wOS8yMyA3OjA3IHBtLCBBbmRyZXcgTHVubiB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPj4gQWggb2ssIEkgdGhpbmsg
dGhlcmUgaXMgYSBtaXN1bmRlcnN0YW5kaW5nIGhlcmUuIFRoaXMgaXMgcmVsYXRlZCB0byBPUEVO
DQo+PiBBbGxpYW5jZSBwcm90b2NvbC4gQ29udHJvbCB0cmFuc2FjdGlvbnMgY29uc2lzdCBvZiBv
bmUgb3IgbW9yZSBjb250cm9sDQo+PiBjb21tYW5kcy4gQ29udHJvbCBjb21tYW5kcyBhcmUgdXNl
ZCBieSB0aGUgU1BJIGhvc3QgdG8gcmVhZCBhbmQgd3JpdGUNCj4+IHJlZ2lzdGVycyB3aXRoaW4g
dGhlIE1BQy1QSFkuIEVhY2ggY29udHJvbCBjb21tYW5kcyBhcmUgY29tcG9zZWQgb2YgYQ0KPj4g
MzItYml0IGNvbnRyb2wgY29tbWFuZCBoZWFkZXIgZm9sbG93ZWQgYnkgcmVnaXN0ZXIgZGF0YS4g
V05SICh3cml0ZSBub3QNCj4+IHJlYWQpIGJpdCBpbiB0aGUgY29udHJvbCBjb21tYW5kIGhlYWRl
ciBpbmRpY2F0ZXMgaWYgZGF0YSBpcyB0byBiZQ0KPj4gd3JpdHRlbiB0byByZWdpc3RlcnMgKHdo
ZW4gc2V0KSBvciByZWFkIGZyb20gcmVnaXN0ZXJzICh3aGVuIGNsZWFyKS4gc28NCj4+IGJhc2lj
YWxseSBpdCBpbmRpY2F0ZXMgdGhlIHR5cGUgb2YgdGhlIGNvbnRyb2wgY29tbWFuZCBvbiB0aGUg
cmVnaXN0ZXJzLg0KPiANCj4gT0ssIHNvIHRoaXMgY2xlYXJseSBpbmRpY2F0ZXMgdGhlIG5hbWVz
IGFyZSBiYWQgYW5kIGRvY3VtZW50YXRpb24gaXMNCj4gbWlzc2luZyBpZiBpIGdvdCB0aGlzIGNv
bXBsZXRlbHkgd3JvbmcuIEFkZGluZyBrZXJuZWxkb2MgdG8gdGhlc2UNCj4gZnVuY3Rpb25zIHNo
b3VsZCBoZWxwLg0KU3VyZSwgSSB3aWxsIGRvIHRoYXQuDQo+IA0KPiAgICAgICAgICBBbmRyZXcN
Cj4gDQo+IA0KDQo=
