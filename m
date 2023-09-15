Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33AA07A20B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbjIOOUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235593AbjIOOUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:20:00 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992671FD2;
        Fri, 15 Sep 2023 07:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvikeqyw44UAGN1Lu6et8+JvXDSnYQ0C4o8Qco/8/DMKYUEHPG5hJiG8tXMczDmCN4UvkWqUIUx4amJwUbeJMg7JxFhLXXO2Zp2axsQ65ljHH3XrVMit0X7+PO5X0bvTL0PkOo0NUTMdUnC5SxScjaAE08eLpADweocjdBOwUrJQhIrz2OcnbgH9T8bOrPwtqAAM+5xIB9uf2jLDQyr8F8WBXnwTMVgWc5aJ4FNDr8fCKQ3loTrmMw4P22U5Hv6Vrmsg+Y+uYw+F1Ji3GWdkCZFQ5HM6ni5dc0MQ91SbehLkPBK9jNeOHlnxVMhquIbt1YR4JTgukRLsuw5OGXRxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMaf/YynBp6DyrPg1KE0l9+l7zS84O7EX1zVRhb30Lc=;
 b=Thahew501K926kOgJBOfoX06jDAhlg3JA5Qm+aVfT+Zeo/TRVp63QsU9wo39ktCnYkDZqL7k5WJ6p/FDWWRKIW+JiRKhwDPigWPL2zQwYp62HYsvaxtaAUYxuHFJLEjUExsN5WvLF6dVXo4doNQJxvMMOArYsu/KI//MW1ZdJDmBrogO5W3sOEFJk79foxOppRu4FNZ5/7ahxLFoxJENJfN3Z5Wj1G9v9v7dWuTsfDV+M+HAaMXrMO2Z//yMI2JtoxcxWf2NtK7Q+K66TDFS5vl1rmXb1R27XIv5yZG6/K0K56BP5rb2c2FLEIxksGEm3+TPkaK39KztWuNneKIzaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMaf/YynBp6DyrPg1KE0l9+l7zS84O7EX1zVRhb30Lc=;
 b=SkM3IwXBxfSAeqzbWw/kYYQNEqCc4yN4Jz1FiGinV6h2/ErgU7bEl1e2WpKK5hQD2tuVmtHa2nVAmxY7N5q74dullfpsOj1DaHVr3LmIDw7acHa2a53eJAtUK//q+NoMlmHbvSYz/irX2EqmhDoH3p5OXioHaQFJTrSxi84E390=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI1PR04MB9763.eurprd04.prod.outlook.com (2603:10a6:800:1d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Fri, 15 Sep
 2023 14:19:52 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::9b66:c45:32e0:6b1c]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::9b66:c45:32e0:6b1c%6]) with mapi id 15.20.6792.021; Fri, 15 Sep 2023
 14:19:52 +0000
From:   David Lin <yu-hao.lin@nxp.com>
To:     Brian Norris <briannorris@chromium.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "amitkarwar@gmail.com" <amitkarwar@gmail.com>,
        "ganapathi017@gmail.com" <ganapathi017@gmail.com>,
        "huxinming820@gmail.com" <huxinming820@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Francesco Dolcini <francesco@dolcini.it>
Subject: RE: [EXT] Re: [PATCH v4 0/1] Patch History
Thread-Topic: [EXT] Re: [PATCH v4 0/1] Patch History
Thread-Index: AdnPR2z5RfEdmhOXQ3+2NbaQx2XQrwXju21AACdlNoAAGn0WwA==
Date:   Fri, 15 Sep 2023 14:19:51 +0000
Message-ID: <PA4PR04MB96385D1A60A99C17E6140C67D1F6A@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <PA4PR04MB9638B8753EFD81E174E55BC3D114A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB96381E2BC08BD1B636067413D1F7A@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <CA+ASDXP9rytcdS1Ao4RbfEULU2kwm4fRiu1MC1H59HABWGPdEg@mail.gmail.com>
In-Reply-To: <CA+ASDXP9rytcdS1Ao4RbfEULU2kwm4fRiu1MC1H59HABWGPdEg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI1PR04MB9763:EE_
x-ms-office365-filtering-correlation-id: 6d1b2978-20b4-4f6f-c09a-08dbb5f6d3a1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ckae9qTFYlOVm3uldjrFt6GC6vOxuV2x6ji66d8+zgtDWuNcUa5QuD15D3MDOg1VXl/UkWtZeOGff9YHwdL20zZJxKJasiWKiEL6byakiuaL4TVImHowJU3cVHF659elevIdqXNMYDcNRfuooIgq7jn9tIK1BTTZ2XjFb2FvpH919VwAIUcDSx9HvsrrnHpXXQa6UC57mWArUZhhBUqKG44yWPGhUTDm/I1A3mx8h3eQGliDlOlBoRApLTu2tfuqoQzjthI3lNBRUInoDUkE77lfEchznG9W3KGEEFRww6iwY8gjirB119q63F1eEeOr1chtPLK15riIvc6bIcDP+r6EhkOTUrf6g5BCO8JN7hcmOpTsHfUo9hGkDEsUX1EptpAF+C5xizQ1LknYB25uwppiUdWGyA8yXduRa0N4sXKcYFk2wqU0ymkuqcXy3Zh7/Rac/8SHM4NgmyDOkMZ7Rtj9cIXVrwgKrnbvmsIKG6EmFYBAWT3oAOyNFHUCQZ575cKoB2qqeOph9cSd3Y57T2lbiffz9PbklJpLuBn+XVt/dFwRyJZaumKFhLMUb1/mtUC5nmUMtqr18mZbkeveWKMgh4X5anNsNr98YpQiV0YbshdULg8zgURu21Yg4LQD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(186009)(451199024)(1800799009)(71200400001)(38100700002)(66446008)(66476007)(2906002)(54906003)(316002)(4326008)(66556008)(8936002)(41300700001)(8676002)(5660300002)(52536014)(55016003)(64756008)(7416002)(45080400002)(7696005)(9686003)(33656002)(53546011)(66946007)(6916009)(6506007)(38070700005)(86362001)(26005)(122000001)(478600001)(83380400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0REK1VZN2FWYjdRejBoMGhrMEIyMDVCSU1mS05aK0htNVpYWGN0TEJmamd1?=
 =?utf-8?B?OStWTENCSlV2ekZBVkJ1cEt5M2N6V2lBM0R2ekxveDNBNHJBeGhJdW9rQ0dD?=
 =?utf-8?B?UE91V2F2cjdTNTRxU0dJdEhpa1p0MzBTYkM0SVU5OFh6THZsTGlKZjA0TkhY?=
 =?utf-8?B?Y0FKVlBZSEZVd1gwWi9GOWt1MkRoakFsNnFtb0xIR1Jqem1YQ2owR3h0NkEv?=
 =?utf-8?B?dEdqYlQ4M0pYa1M4NlpvL3BCWTJLUzY4N2FOdFRmT0daSUplb2RuT3N1UU5O?=
 =?utf-8?B?UjZoKzQ2NUxHRENieE0yMXlVdm94dm5VamNyNW93aUFxaEJwVHNxNjZwN2xh?=
 =?utf-8?B?bHZSNWthdHNzRjdabjgxcFRhSmJoZEZWNDhGRTdZODU4Mi9uemZZQkVlTGp1?=
 =?utf-8?B?My9kNU4vMUhMRzlKQWlTd3NmMXBpZWozT1lUc2VhMWVVdVZmMGowTnlMSm5H?=
 =?utf-8?B?UjNTdXFPOWRaRTlMc0Y3YW1Td1dSZlhjelUvWithZFhLSy9RYXV6OUc3MFJl?=
 =?utf-8?B?ZUk2UklOS2RkQ3JIekVqQ0VRRmwxNGx4NXREWGF6amZNc0lDK256cHovWGJB?=
 =?utf-8?B?OFpIQUNXN0RhUWJVeEtMUjVkTlFzR3V0TE00dTg4ZEhZMmF1NzBtMlp5Rm1Q?=
 =?utf-8?B?YnN0T2xIaGdVWGYvd2QyRldoNUpuMDZndVc5WFcvZDdRdzl1REVXMmRGVDds?=
 =?utf-8?B?NmYrSXQxYlg4eWtNbHhIVEJiOVkxWEZSUW1LTS92dHhOcU5va3RKMHBqcTNS?=
 =?utf-8?B?aVBhbktlaWdPN2tISTQ3ZGxiYlhySkthRmV6MytDNjVmazYycXd0M3dTT1ZZ?=
 =?utf-8?B?K0RTckxSL2hMN0Z6TlVVNnBJd09WcWExUmx4bXkxZGZSWDc1Y01ITXgvNlhj?=
 =?utf-8?B?eTZTZmdMWFRaa1gxcmhWUlZxUXlxOFFLZVFpT2lRQ09vczJ1YnErdHN2R3ky?=
 =?utf-8?B?N2NkSS9RZmtFcWJteWZLL0ZITW4zZlV5N2FGcEV3WkRNanNnMlFJOW4xM1JK?=
 =?utf-8?B?Q2xZVERYRXc0ZWE4SklPQW0wNzJYT2lwMktSVWNkbExhRlVlZGNlVDhKOWxj?=
 =?utf-8?B?YnE1YkJ3RmFPOUFydERFRVlQMnhYZnNaVjQvVDRRSDVqNlNZT09YRFVZbkxp?=
 =?utf-8?B?dzIyUlo2Zm91SklSck5SR2VhYzM1VHEwM3dlSzgvbDRKL3hUb3hGQ1JqT2pQ?=
 =?utf-8?B?dE1ReHB2UTY1YTlwSTVBeURpUVVDZGVlelRXL3BxMjhrRHBQSitQbWF4SmxG?=
 =?utf-8?B?QW5wcFBvYzdNeCtuOUp3MEdPU3FZblZWYm83cjdpaHczUE9qU1lzWVhqeVlE?=
 =?utf-8?B?RG5KYkEvSG1UWHllT2ZLYnZHbXpOWFFXVWJ5T3ZsTm05RjVlWmRUbFVZUUxm?=
 =?utf-8?B?MS9sbHJvSXJVNlZOMXFNOUkzS3o0NlBjL0VsU29RUWpYYmgvN21VaDVON1Ny?=
 =?utf-8?B?aG5nckxFR0RoNjBpeUFKR3hkUFhCWHMrb2xiZnlhdnZFSW5FNHUzN3dtaXdu?=
 =?utf-8?B?ZVVvSDBJUmJhNHBGNzhiZUJzYUFpRlBXbHgyRUtkdXZWZkVoK0tmM0daWDhz?=
 =?utf-8?B?MTFTWTJzRmpyZTB4RGxuMFBnVkNWcW5nbGdPTmlvWUZick5ld3dGNW9WZkkz?=
 =?utf-8?B?Yjd2cVNPam1WWi9tM013QnhxRUM3OEV3VzhRQ01UN09KREJ4MVF6WHU4ZGkz?=
 =?utf-8?B?SzhMUG9HK3N1UTVubC84dWUzZ1JaRmliQnBacW41QzJZTlNNUDJmRGRKMmJK?=
 =?utf-8?B?ODdqZHZOTjBZbXBtdmtIMXU5WEZFK0lGeEsya3V5WjB0ZTRYcXREYVgycGFZ?=
 =?utf-8?B?Tjd1MThBT0ZFM2ZxYTYrUWRsS2RSQjJQUWU1THhPRG9Vc1lJdTZSZzc2TzhF?=
 =?utf-8?B?NkM4V1FPSWNic3hZM1ZNQmFRNU9xWlpvN0wrSzNDdzc3bkgvYW92REVJaFUz?=
 =?utf-8?B?L000eU53UmtHYUtmYkwwR0JyWW5pUU5aN0xxVzJiK0UvbUtHWjF4anRwdzJk?=
 =?utf-8?B?SytVSHo4MUFSR2tNVWRyOHhSY29MamlEVXZYL2szTVM5ajVPaU54bE9zdXph?=
 =?utf-8?B?ZmNJRXZRT29BajB5MU53L1daSU5OMGhRdDB6OUVpVjFTZHhPYXdQblBINTZQ?=
 =?utf-8?Q?Ji2rPM2Km9RnSOcUhPxJTpsUr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1b2978-20b4-4f6f-c09a-08dbb5f6d3a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 14:19:51.9828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHCXZ/pzt2U06vN7xstJsm4jZxcA8HC/lsxW7j93V99EqB6jriCFisUX8ZEaLC5RJ3hIf2rhMP1iTqsdtaRryQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9763
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCcmlhbiBOb3JyaXMgPGJyaWFubm9ycmlzQGNocm9taXVtLm9yZz4NCj4gU2VudDog
RnJpZGF5LCBTZXB0ZW1iZXIgMTUsIDIwMjMgOToyOSBBTQ0KPiBUbzogRGF2aWQgTGluIDx5dS1o
YW8ubGluQG54cC5jb20+DQo+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFNoYXJ2YXJpDQo+IEhhcmlzYW5nYW0gPHNoYXJ2
YXJpLmhhcmlzYW5nYW1AbnhwLmNvbT47IFBldGUgSHNpZWgNCj4gPHRzdW5nLWhzaWVuLmhzaWVo
QG54cC5jb20+OyBrdmFsb0BrZXJuZWwub3JnOyBhbWl0a2Fyd2FyQGdtYWlsLmNvbTsNCj4gZ2Fu
YXBhdGhpMDE3QGdtYWlsLmNvbTsgaHV4aW5taW5nODIwQGdtYWlsLmNvbTsNCj4gZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFiZW5pQHJlZGhhdC5jb207DQo+IEZy
YW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY29AZG9sY2luaS5pdD4NCj4gU3ViamVjdDogW0VYVF0g
UmU6IFtQQVRDSCB2NCAwLzFdIFBhdGNoIEhpc3RvcnkNCj4gDQo+IENhdXRpb246IFRoaXMgaXMg
YW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBv
cg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3Nh
Z2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24g
V2VkLCBTZXAgMTMsIDIwMjMgYXQgMTE6NDLigK9QTSBEYXZpZCBMaW4gPHl1LWhhby5saW5Abnhw
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBLYWxsZSwNCj4gPg0KPiA+ICAgICAgICAgUGF0Y2gg
djQNCj4gKGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRnBhdGNoDQo+IHdvcmsua2VybmVsLm9yZyUyRnByb2plY3QlMkZsaW51
eC13aXJlbGVzcyUyRnBhdGNoJTJGUEE0UFIwNE1COTYzODM4DQo+IEYxMkJBREMxQjlGRDM3N0NC
N0QxMTRBJTQwUEE0UFIwNE1COTYzOC5ldXJwcmQwNC5wcm9kLm91dGxvb2suY28NCj4gbSUyRiZk
YXRhPTA1JTdDMDElN0N5dS1oYW8ubGluJTQwbnhwLmNvbSU3Qzc1NDMwZDZmOTZiMjRkMzVlMmUz
DQo+IDA4ZGJiNThiMWNlNSU3QzY4NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3
QzAlN0M2MzgzDQo+IDAzMzgxMzE0NDYzNTc4JTdDVW5rbm93biU3Q1RXRnBiR1pzYjNkOGV5SldJ
am9pTUM0d0xqQXdNREFpTA0KPiBDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZD
STZNbjAlM0QlN0MzMDAwJTdDJTdDJTdDJnNkDQo+IGF0YT1ScWJHQU8wckFUb2tUUUk3NnJvUkFQ
bDNEcjZPUUtyaHZlc1UlMkZHNmNFQlUlM0QmcmVzZXJ2ZWQ9MCkNCj4gZm9yIGhvc3QgbWxtZSBo
YWQgYmVlbiBzdWJtaXR0ZWQgZm9yIGEgd2hpbGUuDQo+ID4NCj4gPiAgICAgICAgIEN1cnJlbnQg
c3RhdGUgb2YgdGhpcyBwYXRjaCBpcyAiRGVmZXJyZWQiLiBJIHdvbmRlciB3aGVuIGNhbiB0aGlz
DQo+IHBhdGNoIGJlIHJldmlld2VkIGFuZCBtZXJnZWQuDQo+ID4NCj4gPiAgICAgICAgIElzIHRo
ZXJlIGFueXRoaW5nIEkgY2FuIGRvIHRvIHNwZWVkIHVwIHRoZSBhY2NlcHRhbmNlIG9mIHRoaXMN
Cj4gcGF0Y2ggYnkgdXBzdHJlYW0/DQo+IA0KPiBZb3Ugc3RpbGwgaGF2ZW4ndCBzZW50IHRoaXMg
dG8gdGhlIGNvcnJlY3QgbWFpbnRhaW5lcnMgKGkuZS4sIG1lKSBmb3Igb25lLiBJIGFsc28NCj4g
dGhvdWdodCB0aGVyZSB3ZXJlIG91dHN0YW5kaW5nIHVuYWRkcmVzc2VkIGNvbW1lbnRzIGZyb20g
RnJhbmNlc2NvLg0KPiBBbmQgZ2l2ZW4gaG93IG11Y2ggRnJhbmNlc2NvIGxvb2tlZCwgSSdkIGFw
cHJlY2lhdGUgZ2V0dGluZyBoaXMNCj4gUmV2aWV3ZWQtYnkgd2hlbiBoZSdzIGFjdHVhbGx5IGhh
cHB5IHdpdGggaXQuDQoNCkkgdGhpbmsgSSBhbHJlYWR5IHJlcGxpZWQgRnJhbmNlc2NvJ3MgZmVl
ZGJhY2tzLiBGb3IgZXhhbXBsZSwgcGF0Y2ggaGlzdG9yeSBhbmQgY29ycmVjdCBtYWludGFpbmVy
cyBJIGZvbGxvd2VkIHRoZSB3YXkgZGVzY3JpYmVkIGJ5IGhpbSB0byBmaWd1cmUgb3V0IG1haW50
YWluZXJzLg0KSSB3aWxsIGFkZCB5b3UgdG8gdGhlIG1haW50YWluZXIgbGlzdC4NCg0KRm9sbG93
aW5nIGlzIHRoZSBtYWlsaW5nIGxpc3QgSSBjb2xsZWN0ZWQgdW50aWwgbm93LiBJZiBJIHN0aWxs
IG1pc3Mgc29tZW9uZSwgcGxlYXNlIGxldCBtZSBrbm93Lg0KDQo8PG13aWZpZXggbWFpbGluZyBs
aXN0Pj4NCmxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZztzaGFydmFyaS5oYXJpc2FuZ2FtQG54cC5jb207eXUtaGFvLmxpbkBueHAuY29t
O3RzdW5nLWhzaWVuLmhzaWVoQG54cC5jb207a3ZhbG9Aa2VybmVsLm9yZzthbWl0a2Fyd2FyQGdt
YWlsLmNvbTtnYW5hcGF0aGkwMTdAZ21haWwuY29tO2h1eGlubWluZzgyMEBnbWFpbC5jb207ZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldDtlZHVtYXpldEBnb29nbGUuY29tO2t1YmFAa2VybmVsLm9yZztwYWJl
bmlAcmVkaGF0LmNvbTtmcmFuY2VzY29AZG9sY2luaS5pdDticmlhbm5vcnJpc0BjaHJvbWl1bS5v
cmcNCg0KPiANCj4gKExpa2UgSSBzYWlkIGVhcmxpZXIsIEknbSBub3QgZXhhY3RseSBoYXBweSB0
aGF0IHknYWxsIGFyZSBmYWlsaW5nIHRvIG1haW50YWluIHRoaXMNCj4gZHJpdmVyLCBidXQgdGhl
biBpbnNpc3RpbmcgdGhlIGNvbW11bml0eSByZXZpZXcgYW5kIGFjY2VwdCBuZXcgZmVhdHVyZXMu
IEF0DQo+IGxlYXN0IGlmIHlvdXIgcGF5aW5nIGN1c3RvbWVycyB3aWxsIGhlbHAgb3V0IHRoaXMg
cHJvY2VzcywgdGhlIGJhcmdhaW4gaXMNCj4gbGVzcy1iYWQuLi4pDQo+IA0KDQpJIHRoaW5rIHdl
IHdpbGwgY29tbWl0IHRvIHRoZSBjb2RlIHdlIHN1Ym1pdHRlZC4gSW4gZmFjdCwgd2Ugd2lsbCBo
YXZlIFFBIHRvIHZlcmlmeSBwYXRjaGVzIHdlIHN1Ym1pdHRlZCBhbmQgd2Ugd2lsbCBjb250aW51
ZSB0byBzdWJtaXQgcGF0Y2hlcyB0byBmaXggaXNzdWVzIHJlcG9ydGVkIGJ5IG91ciBRQSBvciBj
dXN0b21lcnMgdG8gdXNlIHRoZSBjb2RlIHdlIHN1Ym1pdHRlZC4NCg0KPiBCcmlhbg0K
