Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0EB79E34F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbjIMJPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbjIMJPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:15:11 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFE22137;
        Wed, 13 Sep 2023 02:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SICQK+xgDvSUmWMJi4bih6DYjUgHwaPy9vlZr8VRk4SGwxMQqjxF+YGb6eBnzEfyyd5Sf54opvfesDkuS4kUcQFbvXwOGD4uLrnZBl5HFTo0VSAfUwObd7n8WYdCyYFDsJWqF+9RWHp1oqd8lp+twjgq3Zz0fj4C3CAvtLYfXiSj1fIneibRrMdj8RLpNnATPwcvEZsGEtQ/rECZIS9cxCeCCs/S6QEOS2H2QtVNWtNO45G62363Qb6wRZIvh2T6DCrZ6CSmMvJ0CA1pZxmU3njwMjDIJJI9oLsxd3ziG7AnjfNeLYC2jXC1u0ZMNrdI+RAMrQ4IczzE+wVdV3+l7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HohbiFKJm79bCwMoKCw/hMGbr0DYKNgvl/CIazopMw=;
 b=TPZc6hqUbGYU9dwCsnDRh76FPixLleFAXE4hNTzBielmXAFD40NySzPETzaKHi619tIWQ6s6tyOoCZlaU846mgBNT4T2vEKUH3Gq3s4qyA3620bAMfDJbXd06P2TVyhKkiJIwzsT2tz02qD6VmRA/9NJ0WIovjFAVdcSR0BJ3momMzs271LqKM4HRCSf5ON3iiR0xmR2/PS93KrSUjQOqTT+dGqKakeV5JJ90lPq3rDuihVY+vI19a0QBuiIyUaG7KBNNiV7G3OK6X/DC/m1jJwaG+VwFijcMHxHwaxfrbZLq7hofacmK6uaTYuOaOZO9wo4mA6eLsUNfP0xcxktNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HohbiFKJm79bCwMoKCw/hMGbr0DYKNgvl/CIazopMw=;
 b=lDP8DIFVDw3IcQSTfPAFWKlfewLlbFTsBIoCTTF5f28R63LnYaLSUchnxhztKhnua6nkXRC5LHtWYqCfG3ebkQSoNE9Rh+0EawRUMvcVE7caUF18RA3ZZvoRS43eEWrdNGXgwjI4PFqGLkNEr4Wvo5bEj+W0BrgjNpdnkP3udKU=
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8)
 by DB9PR04MB8074.eurprd04.prod.outlook.com (2603:10a6:10:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 09:13:59 +0000
Received: from DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d]) by DB9PR04MB9284.eurprd04.prod.outlook.com
 ([fe80::964e:b1f3:bf81:867d%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 09:13:58 +0000
From:   Hui Fang <hui.fang@nxp.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>, Xu Yang <xu.yang_2@nxp.com>
Subject: RE: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Topic: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment
 size
Thread-Index: AQHZ2UI/RGKEIcG6sEyAOrT4GOix9LACiU/wgAAMzoCAB7BFoIABXXYAgAHcP6CAABZdgIAHn6dggAFXQACAAE0GQIAAA6qAgAAHETCAAARQgIABqGOw
Date:   Wed, 13 Sep 2023 09:13:58 +0000
Message-ID: <DB9PR04MB9284A1DAB3C642C57298893A87F0A@DB9PR04MB9284.eurprd04.prod.outlook.com>
References: <20230828075420.2009568-1-anle.pan@nxp.com>
 <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
 <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
 <DB9PR04MB9284A0CDB1FC7CAADE0A394F87EFA@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5AugUGh7Z=9Qh7SS4=-0ddGBmRAOOyCGDfPdT-=eurtUg@mail.gmail.com>
 <DB9PR04MB9284A45033B3E24F44C5AA3987F2A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Bk0DUq5jgFDHV2wGYEcfQzNVQ2KYJ2ZYLubwFLgqW4kQ@mail.gmail.com>
 <DB9PR04MB92846D75C93A9B2B8C8A998D87F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Ar18TvFE3jXBuphpCiwWAb8O99wqkiwEVDSs3+MXvW0w@mail.gmail.com>
 <DB9PR04MB9284404C1E1F1300EEF5A70487F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Aq=ZrNGQU6psXJXt1ak2SkoRrZ=QBzp+xxHmWre0zBVg@mail.gmail.com>
In-Reply-To: <CAAFQd5Aq=ZrNGQU6psXJXt1ak2SkoRrZ=QBzp+xxHmWre0zBVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9284:EE_|DB9PR04MB8074:EE_
x-ms-office365-filtering-correlation-id: d1cda6ed-158d-454a-58e9-08dbb439c383
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0O16kC4Xj8MBCHqy7whIWilCzgstwOKdbGfr8NSnJAzKB9IH/vE5pin4Ih6m0CdHEMdXiqsQLFKs7WYN4EGR8ZXUNcqqOpBuCIG0uLJAwdIvMJY76Qi9tVC4hoOHwDwayu+bRRojcRfJNtRuwEbjdj6+PmeXrA00INCadR1p+2nBERLlV0ZeV/oTwVtvaDlR8pGXLsdtDy2pcoQhs8bvZ2O4Hj7pKXnhsrD0G8md+WmTtTi0/X8BtDS1xkCactF8llBsF7Us28xSV2uJSTMD+2t2xjboW4rcY1pagXPOazGGHizO4n35JTLLDIbezVGbuNyfFjydH0NHVIghUwS8tLZY+Lk65Rxy5fxwHJKcBpR4E4Xfg8IyywMJOz9bOaNdIJKCNll3iVp4Am8CI/vwCDRlkcgzbeERkmZvaDayg4HWbROK7FjYcuOGSqQdGB+5RG5jELyzKGHLRGBnrR+efG3rZTpa7+hK54opLuugRuQf9oNeDrlwzxtiq9zqwHwadiwqfuvjVvHnC0Ew6fvTOyd1tWx0sTFG36AW9VfTwzRIT3ajsFxglpVQC8M/bCpCGUnOJPvlIRKEHG17W1YIObRatmm+gZeeHdvu74li3/WkpwGY3BK/+1X07HKJh3t
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(55016003)(86362001)(5660300002)(44832011)(52536014)(8936002)(4326008)(2906002)(4744005)(8676002)(33656002)(38070700005)(38100700002)(26005)(478600001)(53546011)(6506007)(71200400001)(7696005)(122000001)(9686003)(41300700001)(316002)(6916009)(54906003)(64756008)(76116006)(66946007)(66446008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dm84VXpEcjJXSnFqa1RhWC95cXhSSkFseVFQTjhzOGI4eTVmVWx5eEVDZ1l0?=
 =?utf-8?B?bjlUcEI1SURMcGs2UmYxdUs0OVdaZ2p3TUhwMkZrei9Qa25lRUUwWHQxa2F4?=
 =?utf-8?B?bzVaT3RTR2k4R202N0Y4VXVIcEE2bnB6SWlidm40bE05RVBCWWJkZCtyQmZy?=
 =?utf-8?B?bHJHc1pQVG5EREZPTjlBVG5oS2VkN0gxVTkvOXh6ejJQWDZLZFd3T0hyWmlR?=
 =?utf-8?B?b0JlQXZaRkRqU3prTzBFYTJBbVhla2hVUzQ2MHFIWngwLzcwemo2OU9jZUFu?=
 =?utf-8?B?RUhSaG51U002UjJFb2hWVEhsQ0RZTm5ZK2I0VisyZTVya2d1MDBobnlKSFQv?=
 =?utf-8?B?c1hOTTE5eUtFSDBOK2FQUnlJaHNkNzhyWUZEOURvQml6VkgvdWZIWm9lOUFZ?=
 =?utf-8?B?S1cweC9xbHZnNk8xQTJpMUJlNXl5SkNlZzN4cDlFZWNKelZTZXBxTlZRblZ2?=
 =?utf-8?B?b0VJcUdqU3ZsS1BKNGxrcFo2UGZzeTE0cjc4L3FyVmdtZW4yM0Z2azl2R285?=
 =?utf-8?B?Wm5vUHRUcHAyV3lpVVJ0M0NCU2JyODg4WStXd2dMTndESXBBc21lNjNRREk3?=
 =?utf-8?B?UmUxUDNUbUVOcGZZdmZuOXJ1cGtPVDVCUFFEMzJsbCtnUWN4eWs2TFhXdVdS?=
 =?utf-8?B?bExMMGp4ZmRQc0tkTmU0QWxvb1hqR0haRHJwUGQvc1RMMFhxLzNjK3hjSTVO?=
 =?utf-8?B?ZVV0UmQrWGpDWkRwVVp4Z1NiTktjbnllamRkUEV3R0Y5MjlDeS8vQnNmUDQw?=
 =?utf-8?B?V0JzcVNNdkFxNUI1SzZZMzhXbUt4cmpXQWRLQjk5MUJUcURQdEpzalZBSERo?=
 =?utf-8?B?TjNPZUZEemhrMnJUdmdmeEx3ZVVwN0FvLysrRDVTZWNRbmZFNnpIamJsOUZZ?=
 =?utf-8?B?dXVnNEs3cFhUMlduRnVENzZOOTgvbWNnYXdGWHpnekVBc3NEbGpONDMrek9X?=
 =?utf-8?B?U2JZQnNUeFU4TDJjajk3eXdxUUhBTFlJKzd5Y2NjeFdkekRRTjU1V0RzMTh5?=
 =?utf-8?B?RnJJMVdORmFGTG1FdUwwNGRKZGZyaFJOTittSlhnY2s1SDd0bjFCRGx4Qmsv?=
 =?utf-8?B?K1dyNytsQnVJMUtWMUVFa0NuL1Z6S3VneHYyeVRxS0xDSVdidml2Y0dtYVZk?=
 =?utf-8?B?VnJzK01QTHYwMTI4dk5SU01DRERvS0w4OXZBckQ5MHgycVJiejhack5laWpV?=
 =?utf-8?B?a1dyS1JraUNkcTgwclhDWkljMFZjd2VlNU1IQXJyNll5U3VXTjk2czYySi9h?=
 =?utf-8?B?MDduanpTcUhDalJJSmtPMFBHTzBRaTk5OEErZjZXL1p0TUFUN0FvbG5jVFV6?=
 =?utf-8?B?aGY3bWtsVnJPUlp2M2lEcWFhNDRRWGFwYWNubzJiNDQzWEdsNUpXU2ViYkUx?=
 =?utf-8?B?ckV5YmEwcjZUUUZmT0hOc1pKVEZyUWhhT3hBcUg4Yk5EOXhkeGIwTzNtdDdi?=
 =?utf-8?B?MXlHQ05jYXNSclMzU01xWmYzaS9ZUTNVVXFqSHdQUkxzbytKYmlIck5rYmQr?=
 =?utf-8?B?MjBNUzVmZHBuN25LZDdlUHdSd3cvRG1abENnU0RGV0YwRVJyaEQzZ3RoeHB4?=
 =?utf-8?B?OVNaemp6dDFyb1poayt6ZjFqdDFyNnNZY1dmUmFnOHhza283S0RwRktCTjNq?=
 =?utf-8?B?L2pDTUl5T0pNcW5aTE9rR29hdnlSNHJ0SGg0enBQNUVTYzVuMmtJUEphQ2Fn?=
 =?utf-8?B?RVl2UXJQUkJHS1ZHcVo5dHpZTnFYUjVsci9hUXR3YklMWmloNXFuQTR0QS9I?=
 =?utf-8?B?R0x2bStOKzZSei9RK01nUS9tdHh0blpIWFlRejBFbXltSjdnYVRvaFY1YW5l?=
 =?utf-8?B?WVVLbS9LZThIWDJxNUpNVGVUdDdXblNkVTYwS0hOaVpoNlNBZHZGc2lJalg3?=
 =?utf-8?B?OTRXRmloMDNwOVhHNTZ1TXNwZWdJN1BNd0VvWW1XU0haVnh0Mm80MllEVU9x?=
 =?utf-8?B?bmtyY2gzOHJ0QlJLbHhhQTQrbUtEMjNQU0QzM1J6M20vUVdnd2daM2RnblM1?=
 =?utf-8?B?TkoxVllqZEdieUZ2NnZNckVLTlU0bkJMdkdRbGwyWjZKaDZJQXpNN2g3OW9M?=
 =?utf-8?B?UmgwdTZHbVFaQm9uOWZlaVVqbUVJN1VvOStYNTBpcUlxVkhBU0p6UDYzZGxL?=
 =?utf-8?Q?4YR0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1cda6ed-158d-454a-58e9-08dbb439c383
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 09:13:58.9311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psTKcPF+X8vo+z2HRXYMORNGEjc41QwN/t76OkcWEJdTkEuqUb6/UfDmSYgTf+25cyoGSD9C90qbKgmutHnsJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8074
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBTZXAgMTIsIDIwMjMgYXQgMTY6NTLigK9QTSBUb21hc3ogRmlnYSA8dGZpZ2FAY2hy
b21pdW0ub3JnPiB3cm90ZToNCj4gUmlnaHQuIFlvdSBtYXkgd2FudCB0byB0cnkgbW9kaWZ5aW5n
IHZiMl9kbWFfc2dfYWxsb2NfY29tcGFjdGVkKCkgdG8gdXNlDQo+IGRtYV9hbGxvY19wYWdlcygp
IGluc3RlYWQgb2YgYWxsb2NfcGFnZXMoKS4NCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24s
IGl0IHdvcmtzLiBBbmQgaXQncyBhIGJldHRlciByZXNvbHV0aW9uIHNpbmNlIG5vIG5lZWQNCmFu
IGV4dHJhIGNvcHkgZnJvbSBoaWdoIGJ1ZmZlciB0byBsb3cgYnVmZmVyLg0KDQpCUnMsDQpGYW5n
IEh1aQ0K
