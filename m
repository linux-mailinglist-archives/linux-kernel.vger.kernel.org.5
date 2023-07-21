Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9455175D078
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjGURRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGURRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:17:44 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFD630CB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:17:40 -0700 (PDT)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LGd5pD016817;
        Fri, 21 Jul 2023 17:17:24 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2109.outbound.protection.outlook.com [104.47.17.109])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3rywqdr303-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 17:17:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpUiLZ1N0Q6BS6Eog66kc2cQ8vK2+wMvZXw3pOUDS/a67dOqpQZAAh3Hk7i/TW2KaHFFf0pkwqa5nIDryh/qeUBRPu+et78bYgU9/f9+T2PWDNLUKdicv/eT+295+Xsh9dhHKGTBtZ83Xrhw73hR2E3KWTx8eIM2b6N5zFU+TPJVI6ou1Yllalncku3NnQqeoJlVvFc2rg5hDOhZ/qQp74AUnthJexWnVpudDzjrfsQ49lBal4+GHLkMci1kbFfZQSVivX3hAqt+7kPsK7BBqgFqdQ2a1L49MN54co6sjujWG1KWNVF5NjhQ0ZSmtXio6aTEgdQeAFkcoXHy5RcVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfIcqW9GgexNsijht0tyEaiScvBY9P0LfsmoQ66ReWk=;
 b=YEJOcKTdEO+gEmubfgGx3/m7Mg2bkN6Qn7eqn83XuHsNHP7z+zDWXUG7WRAuwoYrakIEcGZdwKwWFeT3HJl1ciT+M5FIitNYfI4Npq2eXowchhlsbGl9ISTr9q2qm/gWl07sjZPbAKxOE6cwg3sEcDZVuD/B8Wo/m11TuGi33eW5srmCZIC+yv0qQVjCp6hRc2oIRmyFvlROYIAOpoGjjxglgoaYyQYVncYDza3Nyx2kiaZ3hZvqmYfcURuCbu0QQM2MWzMXqA8hRvsMnKEFyYVB5CUAywA94akCRn4K8/goaZtxN2hzjboOzjgzU0ga2kQh+VMPm5fWluGOgDH/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfIcqW9GgexNsijht0tyEaiScvBY9P0LfsmoQ66ReWk=;
 b=Epmpxyitk/4mrd7SmOyKeQm28aLQfOuGxNeCAxew+LdSl8UCCssb9L/tiG44hixOspwHiKe0XA/TnnqmxLRSmeoAqHeA/QhOafbmZ9pSvNiCehSPpfpB7OhZl0KLdXLe01NKDrIGZMwSinkiPSikfaT96JCfg97nWegzOn4JKOvSRntIfRi1z59xDlQYo4yBOMfAC+nbSX+NooKXUo863PICb2fCimwWps/InAxltLy102Xes0uhnrN3ZqXFAjMJmY54NsEczvBNXi5OsxvgsCZcQV+fp8fe9yBHLIkgEw4brp/3SaurJnLblyC3gsPFI0HtGzTzyczOBbyVc000Ug==
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com (2603:10a6:10:ed::15)
 by AS8PR03MB9772.eurprd03.prod.outlook.com (2603:10a6:20b:61b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 17:17:21 +0000
Received: from DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2]) by DB8PR03MB6108.eurprd03.prod.outlook.com
 ([fe80::11f9:615a:4d9a:a5d2%6]) with mapi id 15.20.6588.027; Fri, 21 Jul 2023
 17:17:21 +0000
From:   Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        "stratos-dev@op-lists.linaro.org" <stratos-dev@op-lists.linaro.org>,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen: privcmd: Add support for irqfd
Thread-Topic: [PATCH] xen: privcmd: Add support for irqfd
Thread-Index: AQHZtJ2tw+2Ln+ZUhUa/nIHLslV4fq+3Uo+AgAB0BQCACqzlgIACEa0A
Date:   Fri, 21 Jul 2023 17:17:20 +0000
Message-ID: <b126f918-fcd7-dc45-5fa5-eea8309d1b60@epam.com>
References: <d4e0233524b8c7c48614b09cae4d23f2cdf10988.1689150266.git.viresh.kumar@linaro.org>
 <a5521a9d-72c6-4e03-0fbb-8a37418c32f2@suse.com>
 <97e63191-e2ba-34f6-ca6c-99b9e9841587@epam.com>
 <20230720094127.zsqpvryj36cbekik@vireshk-i7>
In-Reply-To: <20230720094127.zsqpvryj36cbekik@vireshk-i7>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR03MB6108:EE_|AS8PR03MB9772:EE_
x-ms-office365-filtering-correlation-id: 07551415-9849-40e3-543e-08db8a0e57ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hhH2lM3WQV4yOCRJPEE08qHunE4pQNlnP3gsWo5VaY+pr3y0E1Tuxz0vL+Vljp9Ll/TalltUmOcImrR8NGxw6nBQu4N86ScSfd4xt7ebnWQYia29BVSA+ZQ71/wyj21J20stU2MmjLSyB10+MDlAtanlN5l334A5bI1HDU72gTi/iBYD6XF3qhhWHom/IAzn244Kw+7iVbpkvjule+ATXP+uQHOuClIdeQR16q89cySPE7i4cZ4Y8G/jBcEo/RUrxIgHcHcOYiff5QUsMsh2TQ6NrjdOLdnmAlGvRlKXEb5p3lKRGPxqY8SJD3V2jSMod42kVmy4zCKzC0Zq0bzx/bDQhPYxmCyihUuODC4EzPD/hhAr8zo8CO9g70WAstSCUa+3E85NpWz9UhVj3u2Cz5H5l06ZFzgYEB45KCyKVL5di6NtvUYev/Th4T986R6oIdMmSEBSgkg99z2EixNeAiYsabhawo6rtc8Ar/DDM9gNK5RBtjbJip1Cip0KTO9SrdGGV07UCAlPR82SudfPg3DzSZ9Q0zUt+JyzvnDJKQNJnTsD+CDWhHV+MJ6pdQ5ytCAgTf+Ev8faUmyg+JOUg0D4w3el/qmeKDUL7eKepmgRym0Up5oFHRHWC9wiYm6uBZ24x46jnIU5auOmyK7BBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR03MB6108.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(38070700005)(31686004)(31696002)(66446008)(38100700002)(86362001)(122000001)(4744005)(2616005)(36756003)(66476007)(2906002)(71200400001)(8676002)(8936002)(7416002)(478600001)(83380400001)(5660300002)(6486002)(966005)(6512007)(53546011)(26005)(6506007)(186003)(6916009)(54906003)(316002)(4326008)(76116006)(41300700001)(66946007)(91956017)(64756008)(66556008)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OEZuWittRTV5dkJmWlpkczBoeFFlZFBDOEJTcitmTS9pbGVqN21RTkc1T0xr?=
 =?utf-8?B?aHRpTUNuN1ArQ1NGTVRYUGIzZUxjeHljc3BXV0RIb3ZTOWNvQ2ZpQlQza0Fi?=
 =?utf-8?B?ZzI4ajhEVjN5aG1HWUFJc0diZEttRVNHbHBMV3o3aDFGQzFrS3p2TStnTExX?=
 =?utf-8?B?V0c3ajI0ZWNBMUdiMWpzTXMxR3cxNUZPTDM5cnlUdmx4TUw0cVZER2QzT3c4?=
 =?utf-8?B?eUpRK0ppelNuWWtZYVpLTUlOQ3VsZUlneFJTMzVaNGVHRDdrZFEycy9rZGVu?=
 =?utf-8?B?SzlKTEswcnFlb1RTN0ZkTmsxRVhhSEgrMDNxcGM1aEp5MTJFajd0R2p3TlIv?=
 =?utf-8?B?L2dFL2ZzdHBnaXkrbG4xaDZqRGxCUVRsWGRIUVNsZi9rL2pJZDgrN3lRbWpw?=
 =?utf-8?B?RTJnZS9sMlVaY1k4Q09kTWE3UE9tRUE4aGxqMzdsZ05XYXhnbWlLQitWREwr?=
 =?utf-8?B?ZjgrdDB5UzRlOHdMYXE1VGh0WFprMnkvS3htR3Vscktaa0tDNXc5VU9PMm9W?=
 =?utf-8?B?OGRoOUVQSUtCdGczUXJWSVpGeFZsRDYyemxKTnFRWXM4V3BBbHhSMXBWTWJw?=
 =?utf-8?B?K0FJdFI4RnAraExjaVdYMFpWZXFCWllLcmVEL2RTTDJFTkc0Y2c0K1JHckEv?=
 =?utf-8?B?RDNwRnM5cDBHVytOTnpwWWRQdEt4c2NFMHdITWtTZnZnajBOdHJIRDY4R1Fq?=
 =?utf-8?B?SnIxb0gxSlhaWjBUUzczMFN6YmtjT2VMTDdmQW05U2RzNUQxbDhBZzlOei9S?=
 =?utf-8?B?aHZIbWd3bkJKSlJNN3IxdEh4aURLTEpmVXNGUlFNYTFVYXpFY3BJWVBsRlF3?=
 =?utf-8?B?Tkl2R2puaU53Q3J4U1VkdlM0UUFKZ21oZWQzVFNtUmRvWHBhd2FsM2xDQU4v?=
 =?utf-8?B?RUVKRWwvWEo1WkZPVkpnbWZKb0l0TERta3RmeThMZk9pV1hpdm5NSTRWOG1j?=
 =?utf-8?B?YjBHcmlrS3JodXZUWnlGOG5OYTRDQ25WazZVUkloWUp1WDR3SEI3UUw5UEVP?=
 =?utf-8?B?SXNHQjZBM3ZrMWQyZjhkYm1UWDdaR2FjNWs3RSs3UDRrOUk0U3gyMmExKzJq?=
 =?utf-8?B?MUVtQzV2OEpSenNvLzRKOVRlc0FMVjJLL3ZvVk1Xd3N1bFpNeUpyYU9STzlr?=
 =?utf-8?B?M1Ficy9UVUxJZmI5ZEhRdDhJbTJpdnNWQVpvdHpHWUg4TWtsYitjWkdWMlpa?=
 =?utf-8?B?cThLcG5GV0IrbkN4K1NoZWQyVzBRTDk5SUVsZDlqOEZWeHhLcDFvVFh2WWov?=
 =?utf-8?B?NjB6VmJJRmgxb01XNzA2cmtjUjhhL01wMEpUMGxEamp3cDJEczRIMU42MUYy?=
 =?utf-8?B?SU5IVHh1YXEwckZyMVFXQXJFQlprMlR5RC9aeWF0S0JPZHQvWFBBQ3h5RlR5?=
 =?utf-8?B?YjRUbGtwMmNUSnowS3k0MnZ3c2lpUTNGeFgwc0szTURHWHdvWDZzZmNKVjQ2?=
 =?utf-8?B?eDhYSFlaZVhmVlNNTVhjQ1FBakQ2cTI3UGtPRi9xdzFzTnVGd2I5MnUvNk9s?=
 =?utf-8?B?TTc5cmt4WTNVdkF3L29jVHF6UXhldTZhY2xES1NzZlNWcDN1c0JlcHhGQ2xr?=
 =?utf-8?B?cG0wUDBlRURUSi8vT1NMdWRoUlovMEFDaThsWjF6TnhRdXlGWEo3bU5ERDRG?=
 =?utf-8?B?RU8reGIvbVFGcDFYVmQ0K1lTVnoyUFFmZlRhQXpCQWNqZlNRMGFIUlFTdHdO?=
 =?utf-8?B?dWV1RzNVRE0vZi8vQ2FLSGxLUFVqRHRJQzdCMSswMktLZ202RXY0bFpodm9I?=
 =?utf-8?B?V2lFNnQ4WTJrbUVOSTIwckw4RTJ4K1BBYlZRb1dMK3dxOGdOUlh4R0gxVGh0?=
 =?utf-8?B?MUpEVEtHV2pHWUE3RUdOOGhtdVdOKys0czZMOXRwQnArZWtpQ0lrYWZjY2Nh?=
 =?utf-8?B?TTV5eGhoNjUwYzlKcDExczJXbUlHNWcrZ0hsMGVYTkVlSFVGN1BmSjdwRE1B?=
 =?utf-8?B?eW92aHlRSXY4NjAxdzhOZU9yMlRkckVQdktVRXY4Mm1Ua2xpSERWbE9ia0Nm?=
 =?utf-8?B?Z1cxZlNsQ0d3V1NLYS9XSllzMnJ4RW5xQWtSTUgxd2xDeXZBMGY5N2w5Ny9h?=
 =?utf-8?B?YW1XaE91V0twbE1xck43OGE2WS9FMVZVMm92aktFL2NzQURDK0JZK0o0NWJM?=
 =?utf-8?B?c2orOXljZUxVMkxkOXhqdTZFRkpUSU9mbXZlakc3SnBQODcxNlhCSEZZai9l?=
 =?utf-8?Q?Q0Xbuxwib75s69+HBEIESPM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C90163E51E2C6645AD5DBDBC7DEFA6F7@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR03MB6108.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07551415-9849-40e3-543e-08db8a0e57ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 17:17:21.1693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oeYrGgD8AomwW/LAUvsAdBHbU15Jz2RQUM3MK0USsLgWFn2uRVMTUlusagEyaqat+GNK2hCa45kmZoM7Aj/XPimj0lnyThAhLXj9GRfxruU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9772
X-Proofpoint-GUID: MzMO3Kk743EXQ_X1rXZIPmf-QDioDhyI
X-Proofpoint-ORIG-GUID: MzMO3Kk743EXQ_X1rXZIPmf-QDioDhyI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 suspectscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210151
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDIwLjA3LjIzIDEyOjQxLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQoNCkhlbGxvIFZpcmVz
aA0KDQo+IE9uIDEzLTA3LTIzLCAxNDo0MCwgT2xla3NhbmRyIFR5c2hjaGVua28gd3JvdGU6DQo+
PiBWaXJlc2gsIGdyZWF0IHdvcmshDQo+IA0KPiBUaGFua3MgT2xla3NhbmRyLg0KPiANCj4+IERv
IHlvdSBwZXJoYXBzIGhhdmUgY29ycmVzcG9uZGluZyB1c2Vycy1zcGFjZSAodmlydGlvIGJhY2tl
bmQpIGV4YW1wbGUNCj4+IGFkb3B0ZWQgZm9yIHRoYXQgZmVhdHVyZSAoSSB3b3VsZCBsaWtlIHRv
IHRha2UgYSBsb29rIGF0IGl0IGlmIHBvc3NpYmxlKT8NCj4gDQo+IFRoaXMgaXMgdGFrZW4gY2Fy
ZSBieSB0aGUgeGVuLXZob3N0LWZyb250ZW5kIFJ1c3QgY3JhdGUgaW4gb3VyIGNhc2UNCj4gKHdo
aWNoIHdhcyBpbml0aWFsbHkgZGVzaWduZWQgYmFzZWQgb24gdmlydGlvLWRpc2sgYnV0IGhhcyBk
ZXZpYXRlZCBhDQo+IGxvdCBmcm9tIGl0IG5vdykuIA0KDQpJIHNlZQ0KDQpIZXJlIGlzIHRoZSBj
b21taXQgb2YgaW50ZXJlc3QuIFRoZSBiYWNrZW5kcyByZW1haW4NCj4gdW5tb2RpZmllZCB0aG91
Z2guDQo+IA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRodWIuY29t
L3ZpcmVzaGsveGVuLXZob3N0LWZyb250ZW5kL2NvbW1pdC9kNzljNDE5ZjE0YzFmNTQyNDBiMzE0
N2MzNDI4OTQ5OThjMjc0MzY0X187ISFHRl8yOWRiY1FJVUJQQSExeUhSUjExVGJQQi1jcUhtYk85
ZXcwVzRHS1BmeDF5MUdYV0hqMFE3d0lFY29tM1pnVTI4dVpjclhFWWxuVlBsMXg0N3Qzb29YRUNT
WWVyMmxDbG5PM1Fvc3FpT21GWSQgW2dpdGh1YlsuXWNvbV0NCj4gDQo+IEFuZCBJIGhhdmUgdXBk
YXRlZCB0aGUgY29tbWl0IHdpdGggQ09ORklHX0FSTTY0IHRoaW5neS4uDQoNClRoYW5rIHlvdSBm
b3IgdGhlIGluZm9ybWF0aW9uIQ==
