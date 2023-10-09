Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863E27BE558
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377042AbjJIPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377001AbjJIPtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:49:15 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37DACA;
        Mon,  9 Oct 2023 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696866552; x=1728402552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2zTCjupZXITz7qdjXtPUGT4i5Nbx5dj9xg7+at+6Jcs=;
  b=YQ8wjK3/De5PtRz6V/SrsIWfkzX8ni/6JCaJlnBUw1HjcH7eED/o6bT8
   npGqjEhrw66MWISnncq2pTjQ88OtXFBa444XBzKD7YuaMvIZojFHVS5qJ
   sbByh3rnVEmF1KRCkDmPn8w5epHx4zdL+duVumGS6FqHO/FeT4QK0pLZH
   F6ynUsJEACHI+jLxEHkEyid7VML0buZwEeqneh3mu5acPToiLn/kfuhpl
   av5+TAbKm5/Vb89Uc6zHFi21e8wEKOjRr/4/ILHgaK17Qlban4pK3X4dA
   XrmLoxcRh3zZKwlVTrLaB6IsfJZwMJpxU2v4dvC3uSLTFl1HfQ/YNRoE4
   Q==;
X-CSE-ConnectionGUID: c/7FzAgwQUatbkkLf5thyg==
X-CSE-MsgGUID: S7U6cqM+RDeGGxYs99fs0g==
X-IronPort-AV: E=Sophos;i="6.03,210,1694707200"; 
   d="scan'208";a="250565004"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2023 23:49:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMFstwX4SsHMxW+egBt/HGStCftYAcOb8bWa6f6cXoDTuZXCT1tZukfXkd9MA9aDsEJnNrNVeJCDdugqj2nX2rpPdqJ9Zcgk305iJUGRmcwehZI79pO+tUC/nSbQviMHNC0mki79Fk1J3Pti7oyo/p2x892Yc2brIJ12jQPvrvJmicdKPyDpI2+KfxrpRwndmB9u4xvi43PaEAMjqFbKskc3pOtSqNQbdOqb1DJeU+QmQkbZ7sy2eOtyBsbS6M3tKfNTpKymBLTn31Cmlv8ehlGvHGpAdYRziqkZhujKqIc4Eu4h5cD9SNQ069rDwbwHWQmdAvfbagbKUurm/TeZPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zTCjupZXITz7qdjXtPUGT4i5Nbx5dj9xg7+at+6Jcs=;
 b=MXYjFt7ECOXcCprLFS0abBxmXadkf+R1+tGY6+pcUnvIQI+pU9qX20A3QfGMeQDysvBxxTFU4jO0V77f4xTPD56UFq8eIf1+qlXEEkip3Y8txAPdktkfjDphreKTZn//I+No0EnIR4IYsAIqPmJ+ZQ8HKQX2LxY9R8FuDRlfWyjWUJKeBSo6Ke0oR6Bzst4zd9MBRgphB9788uA8vulOH0ghobSy6TRu1xpT73rO5AalQ7c56wis2oCLNLphaheG4/559PKt2hQk5J0tTfD8g2QQ9/bUjKVnG2Ldotjm10++Q5pkzRPp8OYXtmyfGREvZqLgQWzN9dk+r+GqsYA97A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zTCjupZXITz7qdjXtPUGT4i5Nbx5dj9xg7+at+6Jcs=;
 b=Rw7NSuNgYRpIORTBed3UmL4wIQzvbSutZ1AYk8bNfzbGqe9SzJ49lHRlFlw5/PpgCJKRnIrwaoitlJSYoz/8PLk4iPGHWl+8saWxAS7ooIPaC9nC/JM/WNGaxCbJKPKqvRtChgIdna2EC0z5rR9+h0oSSEkZkugP0K/DxWoypjM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BN8PR04MB6417.namprd04.prod.outlook.com (2603:10b6:408:d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 15:49:07 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 15:49:07 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Rob Herring <robh@kernel.org>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ata: xgene: Use of_device_get_match_data()
Thread-Topic: [PATCH] ata: xgene: Use of_device_get_match_data()
Thread-Index: AQHZ+r6tyqEqExIopkKdwhLCRrgP3rBBkp4AgAAIJYA=
Date:   Mon, 9 Oct 2023 15:49:07 +0000
Message-ID: <ZSQg7yIkm9q2aNkF@x1-carbon>
References: <20231006214433.339688-1-robh@kernel.org>
 <ZSQREEr0WBk15fFJ@x1-carbon>
 <CAL_Jsq+Q0iR19OfyUhCvA24w+PzVNzG2qMhcH56qkADBa83Omg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Q0iR19OfyUhCvA24w+PzVNzG2qMhcH56qkADBa83Omg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BN8PR04MB6417:EE_
x-ms-office365-filtering-correlation-id: 7b959d8d-ec83-42dd-36a5-08dbc8df4599
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T1SSaf+7DIKJyf1EUkNoJXwLuKmnG8iwjkuDv0oSezYxBC3V9U2BNgsYPjHlYrS8QMm9hTyDRHxNatYzgoSRIL4AqhfX3udkrHjkXhfyNw7kukHNctiEk74lOnBCfxNPqxQfdiMl1xPFBsISaRiYtM+FHUYMegG5iOuLjLrfBleQp20VpReyZjP7dcucpUYfLupuwgxlczf9HHLD4XrHdK6XHRxAIkepTKJtCFpFi3p6Nv54ruX4E1lmPEMn3/fV2U5riu4LLp+EDMQcILCXJ9uT44/CpORO9/m+xeebg2LkVZq+OuGWrphNbMg3n5thx1LvLS6Zh3FgTuJ32cisvbTWpNscIaS4xg4yGvI3c4eWCi4KjO9XyQ/mhyeSlJ03o2LSAaAyXttPwBLfB7bEiKr+QSyOFc6RAUYrsoSN2bT2CpjsVNjAdE9ckjtXp1qt/5/jhneBJelmM0iWcV6jFz0wzW3DD7Ei8UCjClgcMX45U7OoKRtavyGVB9GBjuTbduWHtZ2zs8SYZ3z3dnsU/EYmXa95dSIgrYndwpS0FiZBjvXk7zf/qDQdrnylR8LU5o2m01E6jN5ly5BMyX50JutaGAj7QWqClpzKotK9ChM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(9686003)(2906002)(83380400001)(64756008)(26005)(66556008)(66476007)(316002)(66946007)(91956017)(66446008)(54906003)(76116006)(6916009)(8676002)(8936002)(4326008)(5660300002)(53546011)(41300700001)(6506007)(71200400001)(966005)(6512007)(6486002)(478600001)(38070700005)(38100700002)(82960400001)(86362001)(122000001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFRzVmxwT3NDaThTalFRTmtuRENQeHBKRFJ2dVpqWW5ibk9xSDRzbGxzRWpp?=
 =?utf-8?B?bUhwWk9tbm5WSVdoSldocTlJSUROT3dGNXBZdTV1VTNHZVVhZGdzaHl2cTVD?=
 =?utf-8?B?VjNWN2VHOHVpR2ExcjIrMlV4WUxrN3ZSTXd0bUZmNHlSUmliQ2ZDczhFTzlW?=
 =?utf-8?B?YUdYTkJPKy9QKzdFZTM5RHVqd3BReU9IQVQ2c0tsTlZBMXIrWVJTWXkya3p2?=
 =?utf-8?B?bm1CSjdFeCt1SDBKOUJnRTVXUjl0ZjFHcDlTKzhrUTR6eFJwZ0Y2NDNsQmJo?=
 =?utf-8?B?S3dVaFdrajFOejVvbEp6UzBhVlMxQVNtWUNIOHZaS09oQ24ydTl6T3RpamxV?=
 =?utf-8?B?cTlpWWQ4M3Y0ZFYvWDQzMkpWa1JiUjhKV3ZCRkFjTmxqQ3Y0am51eTM0S01z?=
 =?utf-8?B?RUk0a1FmYUJTcWRTSWtsZWtPV3lPck14dmpsSjY3L2pkaStQWDhrMEdTRzl1?=
 =?utf-8?B?Zyt5SFZnZU1YcW9GaHBHbTBzZ0dpdm1MRHhKTDFPVWpqdEJuOU1zQkFSTGlE?=
 =?utf-8?B?aW1ZRUZnTWV6Ykh4TG8rbGYzM0hRNVExQ3lZK0ROOEs2dXBoVDR6ZGVjblFP?=
 =?utf-8?B?UzZ0akJlZU5HWGxpYWYwaVN1bXZkOS82MFZqWnlNeUM5NUI3a1JKOXUvekpK?=
 =?utf-8?B?S0Z5ODRPWGl6T2kxUXN5SjhZaE1VTTV4RCt1WUsvb2twekxOM1c0T0xGQ250?=
 =?utf-8?B?VUthOWZla0tyS2pOb0RUSHY5TXRLWUVEMENiZDVSYVBEU3BxMkV1VkFpM013?=
 =?utf-8?B?aHBRb2MrMEdySlRuM040cXlBYUNxWStTaTA0N2NwLzA5N2gyb0l5aGl0RzVs?=
 =?utf-8?B?WDlWeDZabjBvcGtPY2dTSVVHVEFZeFdsTmQrUmRlYTAvbkJtaXEzYkM3QnJB?=
 =?utf-8?B?MTdSVTFCN2w1ZUxFS3RpZEVVT3pKSUdtM09zMVBSSllWNmdJYnBscVMzZWdi?=
 =?utf-8?B?SVVnNDBDaHkrVjlRNW9wMjAreU5QK29MUkVxVjR1ZTFKU3ZVVzluTG9pYnZj?=
 =?utf-8?B?TkN6bUkxTGtPYll3RU5OZ1A4VHBzdlRKM05BMUkza2RoaDF2d0l5bFNnYklp?=
 =?utf-8?B?b0VkWUYxR3VQUGtSOHNvTjVwTFZ0QkJNRmRZZ3owUHpnTFE3THc2a2VLUzhF?=
 =?utf-8?B?VUVjcTJHNkpGYWJVaWU4VURPRlU0VlMyV0huajQxOFpNaFJ0NHdXdi9HTDUw?=
 =?utf-8?B?R1FVbGdtandSUlRQQWxqN3VIbFZlb091Yk51LzdnV1lHTVJWVHFXUm1lSlA2?=
 =?utf-8?B?R0M1Qyt2V082RFhlbHhLQk1SdkRET0UrWE1TTThSbG1DQTJnOUVjbm8zYzFE?=
 =?utf-8?B?andNeHBNUFFMREhwTG1MeFlZdXBSb2lCeXFSWTdpd2YxNVErM0t0Ujg1eEJC?=
 =?utf-8?B?MU1UNlNCUHFEc01ucXVVTVlHc2FYbXY2VHIvVUF0MS9tS0RXcDZjcHNFVmkv?=
 =?utf-8?B?KzZxblo4WjNNU012RWtvdk9JN2dUSGljWWNhL0xYVlZZQi9pSG1xZjUveEFy?=
 =?utf-8?B?eWlqOXdhNUkvbE5RRThBZEFmTGdEMWMxWWkrajRGK2xGSVcwU0dDeHYzLzA1?=
 =?utf-8?B?UWlMUzdOUVJFZEpob0V1TnVCaXFOK3N1QXJxeWtrMUJleUtQSEhqK1N4czE0?=
 =?utf-8?B?WFFTR2hFVkF0QnhGTWhMcnovd0lYNVVGSDJqdGVnVk4zVDBYM3pCS1N0SkVB?=
 =?utf-8?B?d3VJeDNxdGMxaktHVFVUR2JtNWorcy8xbHQyWVVYdlVNY1RmUjg2bCtMWnZk?=
 =?utf-8?B?b09rZWROVldtZHBhUHZGVWtTWWJYUFhGMUd3cWRwVXk3dWViczJLL1pWKzN5?=
 =?utf-8?B?TXhIMGc2U2tCTVUzdUErTXA4cllxYkRKbERBTkhuK3dXL0JVL0dYNTRLQ3o5?=
 =?utf-8?B?UlV6RytFSXFISHB0aGZYSHNiSStwdjhhUXdHVUYvK3pYYlZIVHlRSWNyaisx?=
 =?utf-8?B?UlZyWDFsOGxiNk5NM2FGYSs2Nk5HOTk1QjdoYVRXcXQ5NXlqeGtzN2djL2Rz?=
 =?utf-8?B?OEd5QUhyUkxUMGlwWkdDVkZUWFF1WDhUdm9tSVZucm94WTgyWVoyTWFJMVls?=
 =?utf-8?B?RUhEM01ROGtLbHB2cE1mejhhRzFENTd4WGtmOEdNODdSdm9JMHdUWHVlSWhS?=
 =?utf-8?B?MjdjSC9NSlhISVdLNkpScUk3TUV2MnZyZjlsRDhrNmFDUUw4V0pmdkRVNGFP?=
 =?utf-8?B?MHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <572E3F2CF764114AAD7302744F3C6A27@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f9Tj4i1HBfAYux6ccbM5b6AD4Nn6Fc3A4HelBWhbgeLOuAZMFEwhUqRMFSEntBhGeftUEc1yxt0N5rE19xfJzSyBdA5+wp/jZjDPYD8qjUxsMiLqFdOo/Kzr/dqqbxI4/WnEX9vpvSvWrfD5bAkaLty1ITNMHXRirK7fdo+lXuAItGSBYi6jH2ixD1yhGspfUsItDme9Pqypw+nWSRr3+N5+p9fTbx099oUCP/Tt7DpJbSCWmY5PcuX7NXNuN3PPv7H35M2pyztB+3fY4chGezhWGrP8Nc5WWsYDVkurcMIrDAdU6LnWyzsk5tpdl6limhWvHtsMEDSDFbjqO9StQJ7bENwYEv8Kf1kGK1uJ4y/e4Uk2UPaszcdozTlFOtPgz6i2PypjrWlW09Guxnj5EuZLw7ffmHz8fslQsg3kJmS3249gaSmtbTtr3NETFs9Ad24PhQ1bvhZYVyPoojW7gCcTwNtggGmI5FHNgJjKyybB4Y01C7A1jlSoDb8OFfldUH9xqOsicID6NK7Tez2RsMZDQMPjOoPP5lzOAKylBELt1H8JRSs5Brd1DpYTuoDZ9GrzOmVcQIniD7391vpbOLjOLKnPB1JpCeuK+MSphzylhDUXvYPZD83DyQ88bJatdCMwwXiabnDRgVqfKv+mnovimiTjW2oaNVBmM6pxwBmEhv434LclYKpe1al5cJ4Rt6hVemzR1OXwUAv+snsgVfCr+6FCysoPihOSPPJru/IxrJrxJklTniDP6NEPwpzSsGHgvrYD76/S9yzbimPy4BTw1XZP1VEhgJ2NSi/X9fuKYRgBRVPD+VXFW0P4X3rd
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b959d8d-ec83-42dd-36a5-08dbc8df4599
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 15:49:07.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGD1V95rAnSS5kQDySOnDAKdo/0Cu6Jv0uYqv9XxLAtW5PO3DHzGrdt48Og4g9fTd4Sm8iaeZc+L3xvNn72nAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6417
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBPY3QgMDksIDIwMjMgYXQgMTA6MTk6NTRBTSAtMDUwMCwgUm9iIEhlcnJpbmcgd3Jv
dGU6DQo+IE9uIE1vbiwgT2N0IDksIDIwMjMgYXQgOTo0MeKAr0FNIE5pa2xhcyBDYXNzZWwgPE5p
a2xhcy5DYXNzZWxAd2RjLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBGcmksIE9jdCAwNiwgMjAy
MyBhdCAwNDo0NDozM1BNIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiA+IFVzZSBwcmVm
ZXJyZWQgb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgaW5zdGVhZCBvZiBvZl9tYXRjaF9kZXZp
Y2UoKSB0bw0KPiA+ID4gZ2V0IHRoZSBkcml2ZXIgbWF0Y2ggZGF0YS4gV2l0aCB0aGlzLCBhZGp1
c3QgdGhlIGluY2x1ZGVzIHRvIGV4cGxpY2l0bHkNCj4gPiA+IGluY2x1ZGUgdGhlIGNvcnJlY3Qg
aGVhZGVycy4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiBQZXJoYXBzIGRldmljZV9nZXRfbWF0Y2hfZGF0
YSgpIGNvdWxkIGJlIHVzZWQgaGVyZSBhbmQgYWxsIHRoZSBBQ1BJDQo+ID4gPiBzcGVjaWZpYyBj
b2RlIGRyb3BwZWQsIGJ1dCBub3Qgc3VyZSBpZiBhbGwgdGhlIEFDUEkgY29kZSBpcyByZWFsbHkN
Cj4gPiA+IG5lY2Vzc2FyeS4NCj4gPiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvYXRhL2FoY2lfeGdl
bmUuYyB8IDExICsrKy0tLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKSwgOCBkZWxldGlvbnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9h
dGEvYWhjaV94Z2VuZS5jIGIvZHJpdmVycy9hdGEvYWhjaV94Z2VuZS5jDQo+ID4gPiBpbmRleCBj
Y2VmNWU2M2JkZjkuLjgxYTFkODM4YzBmYyAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvYXRh
L2FoY2lfeGdlbmUuYw0KPiA+ID4gKysrIGIvZHJpdmVycy9hdGEvYWhjaV94Z2VuZS5jDQo+ID4g
PiBAQCAtMTMsOSArMTMsNyBAQA0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4g
PiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gPiAgI2luY2x1ZGUg
PGxpbnV4L2FoY2lfcGxhdGZvcm0uaD4NCj4gPiA+IC0jaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVz
cy5oPg0KPiA+ID4gLSNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiA+IC0jaW5jbHVk
ZSA8bGludXgvb2ZfaXJxLmg+DQo+ID4gPiArI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gPiAg
I2luY2x1ZGUgPGxpbnV4L3BoeS9waHkuaD4NCj4gPiA+ICAjaW5jbHVkZSAiYWhjaS5oIg0KPiA+
ID4NCj4gPiA+IEBAIC03MzUsNyArNzMzLDYgQEAgc3RhdGljIGludCB4Z2VuZV9haGNpX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiAgICAgICBzdHJ1Y3QgYWhjaV9o
b3N0X3ByaXYgKmhwcml2Ow0KPiA+ID4gICAgICAgc3RydWN0IHhnZW5lX2FoY2lfY29udGV4dCAq
Y3R4Ow0KPiA+ID4gICAgICAgc3RydWN0IHJlc291cmNlICpyZXM7DQo+ID4gPiAtICAgICBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICpvZl9kZXZpZDsNCj4gPiA+ICAgICAgIGVudW0geGdlbmVf
YWhjaV92ZXJzaW9uIHZlcnNpb24gPSBYR0VORV9BSENJX1YxOw0KPiA+ID4gICAgICAgY29uc3Qg
c3RydWN0IGF0YV9wb3J0X2luZm8gKnBwaVtdID0geyAmeGdlbmVfYWhjaV92MV9wb3J0X2luZm8s
DQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZ4Z2Vu
ZV9haGNpX3YyX3BvcnRfaW5mbyB9Ow0KPiA+ID4gQEAgLTc3OCwxMCArNzc1LDggQEAgc3RhdGlj
IGludCB4Z2VuZV9haGNpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
PiAgICAgICAgICAgICAgIGN0eC0+Y3NyX211eCA9IGNzcjsNCj4gPiA+ICAgICAgIH0NCj4gPiA+
DQo+ID4gPiAtICAgICBvZl9kZXZpZCA9IG9mX21hdGNoX2RldmljZSh4Z2VuZV9haGNpX29mX21h
dGNoLCBkZXYpOw0KPiA+ID4gLSAgICAgaWYgKG9mX2RldmlkKSB7DQo+ID4gPiAtICAgICAgICAg
ICAgIGlmIChvZl9kZXZpZC0+ZGF0YSkNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICB2ZXJz
aW9uID0gKHVuc2lnbmVkIGxvbmcpIG9mX2RldmlkLT5kYXRhOw0KPiA+ID4gKyAgICAgaWYgKGRl
di0+b2Zfbm9kZSkgew0KPiA+ID4gKyAgICAgICAgICAgICB2ZXJzaW9uID0gKGVudW0geGdlbmVf
YWhjaV92ZXJzaW9uKW9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KPiA+ID4gICAgICAg
fQ0KPiA+DQo+ID4gTml0OiBicmFjZXMgY2FuIGJlIHJlbW92ZWQuDQo+ID4NCj4gPiA+ICAjaWZk
ZWYgQ09ORklHX0FDUEkNCj4gPiA+ICAgICAgIGVsc2Ugew0KPiANCj4gQ29kaW5nIHN0eWxlIHNh
eXMgb3RoZXJ3aXNlIHdoZW4gdGhlICdlbHNlJyBoYXMgYnJhY2VzLg0KDQpIZWxsbyBSb2IsDQoN
Ckkga25vdyB3aGF0IHRoZSBjb2Rpbmcgc3R5bGUgc2F5cyB3aGVuIHRoZSAnZWxzZScgaGFzIGJy
YWNlcy4NCg0KSSBzaW1wbHkgbWlzc2VkIHRoYXQgdGhlcmUgd2FzIGFuIGVsc2Ugd2l0aCBicmFj
ZXMsIHNpbmNlIHRoZXJlIHdhcyBhDQpjbG9zaW5nIGJyYWNlIG9uIGEgbGluZSBieSBpdHNlbGYu
IFRoZSBjb2Rpbmcgc3R5bGUgc2F5cyB0aGF0IHRoZSBjbG9zaW5nDQpicmFjZSBzaG91bGQgYmUg
b24gdGhlIHNhbWUgbGluZSBhcyB0aGUgJ2Vsc2UnOg0KaHR0cHM6Ly93d3cua2VybmVsLm9yZy9k
b2MvaHRtbC9sYXRlc3QvcHJvY2Vzcy9jb2Rpbmctc3R5bGUuaHRtbCNwbGFjaW5nLWJyYWNlcy1h
bmQtc3BhY2VzDQoNCkJ1dCBJIGd1ZXNzIHRoYXQgaXNuJ3QgZm9sbG93ZWQgYmVjYXVzZSBvZiB0
aGUgI2lmZGVmIENPTkZJR19BQ1BJLg0KDQpJIGd1ZXNzIGEgYmV0dGVyIG9wdGlvbiB3b3VsZCBi
ZSB0byB1c2UgaWYgKElTX0VOQUJMRUQoQ09ORklHX0FDUEkpKQ0KaW5zdGVhZCBvZiAjaWZkZWYg
Q09ORklHX0FDUEksIGJ1dCB0aGF0IGlzIG9ydGhvZ29uYWwgdG8geW91ciBjaGFuZ2UsDQpzbyBs
ZXQncyBpZ25vcmUgbXkgbml0LiBJJ3ZlIGdpdmVuIG15IFItYiB0YWcgb24gdGhlIHBhdGNoIGFs
cmVhZHkuDQoNCg0KS2luZCByZWdhcmRzLA0KTmlrbGFz
