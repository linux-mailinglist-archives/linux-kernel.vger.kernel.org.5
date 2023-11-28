Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814B37FB224
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbjK1Gwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjK1Gwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:52:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD25EA;
        Mon, 27 Nov 2023 22:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701154366; x=1732690366;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lntXxvO0J6m2wHobU4AB8DoRuRhc8RU/SqNI10cEUtE=;
  b=twGYYFfHzZlwo5dYvvZQGZPp6JWW79Wjs3emMlhqo06SKA855oU+VNOb
   NBE8Eez8eEaWJ4ypXaTm1Jr4nG1Iv3cB+N5MZw3HuppleCWy8mRdUGFbn
   7QQSevLXJHYb/vnX5y7HfPJJY2e4jdG8KqZ6QL9LDmBbj6elDJ0vI9BOL
   9I3ibsVwELt4XCdvdMe+KHzUAv7dxjLbSeB37GuhttVzGNUpq0BEy9w5J
   bHWOW6MkG9wrPB4yPHasR8G+/N2w8GWsf7WqMwXrEsFfx2Vj/uNM4HgNo
   ZOmcQLc7U6/A7CyxeFds7G/IudcHwrtbO5xNZ4Ln0oW4uMrHwTh7QJu5E
   w==;
X-CSE-ConnectionGUID: 356L9FM4STKd+NocMLP5zw==
X-CSE-MsgGUID: hh5ePo/3QZyNtiN0EwFP4w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="179516497"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2023 23:52:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Nov 2023 23:52:29 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Nov 2023 23:52:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL0qa0cHG5le1bmmFj2rHq/i2M09moJX2M+aTzapiisEIvTUmQR0IKpmmJpb2CMIFexJcT8HVzDQzkjC57gtQAHqhPWVIJMpTqmT+Cy+431af9KYMC72nZvCi0B86PFNqQ9igiPJedSTHqmnk47iLriZMhYvppwIalvoXqizCqCfBamcDLRITQC6XjOqY72SFSMa3BJpFY+x3blTeTvSoXEyXMA5I4Jd37wCjKqU/aONa9DQ9sAYeIe8rnxpM67EQTesIHswqrBoKxICFG2UicM8vurNrJTXXPQohop8SZ0UQrW6o8pzTPZM8ojYM1HFqNNqSZRQbRrWry5au7gNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lntXxvO0J6m2wHobU4AB8DoRuRhc8RU/SqNI10cEUtE=;
 b=WyP+veBc5dYOLFOF+kh2KXj5L8lCLaIrffMIaYnNw6iqCAb3MNgZJJ3U36djXTjAhTcQWpfafHHaAR5zuYAHddk8cNSPvohjpWX95dGDdwK/l3qpljqgS0hl6iB6/r0X3/QxCfrE4rXOB/1sLgXcJDpyYtLEmj5nGbTtAnPDKZqMUaYAxHGzs+VkSE/VpBbSC7p3ndA0TToz2dPdveWwrnUYEfhrV6+EfPgN37ZG5oZqT0eftoiAhodmtGU5rytThavnq74Hcj5ANE4meOqGZ14YjXU/RCo0AeuHBja2zToB5llBHnP/aq5j2ZRaMG3jiK0RC9GXAi4ECkslJ8kWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lntXxvO0J6m2wHobU4AB8DoRuRhc8RU/SqNI10cEUtE=;
 b=sw7K64iRsDqoLO0AbigVh7AU7ZfzaO3lysCLRyiwFbrhQux9fJ/qvVfFmsybB3e7RA3UdAksbKTaOs1kRtEomq3gEoVELhE+vT7wJCVN9UdmyMTnD2R2OVGVNHVBp7c0X+mNL5GNa7MdmpTjNdgr4SJ0E2MvdUeSQVx/Lwoq0pGlUTzHCZ779BrFUfwjTwb6N7d7nV6Rh4mx70E81mRLybmZzX3H/5T3BEq/RIaYCCIlySV6JFQmuVxxo8eo5B6XWggWl0yPVHS94Kz71CjbuhaHLHXzZS8YJtQvmxkzjazgovnA9/7aHryKdv8owckz8MlxTa3esaMZyOko0/Kdkw==
Received: from DM6PR11MB3532.namprd11.prod.outlook.com (2603:10b6:5:70::25) by
 CH3PR11MB7323.namprd11.prod.outlook.com (2603:10b6:610:152::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.28; Tue, 28 Nov 2023 06:52:25 +0000
Received: from DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::ba6d:cd09:d24:48de]) by DM6PR11MB3532.namprd11.prod.outlook.com
 ([fe80::ba6d:cd09:d24:48de%6]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 06:52:25 +0000
From:   <Parthiban.Veerasooran@microchip.com>
To:     <ramon.nordin.rodriguez@ferroamp.se>
CC:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] net: microchip_t1s: conditional collision detection
Thread-Topic: [PATCH 3/3] net: microchip_t1s: conditional collision detection
Thread-Index: AQHaIR5wk3YgliVBQEuBhfUZ1bg7VLCOU2UAgAAJDICAAPAzgA==
Date:   Tue, 28 Nov 2023 06:52:24 +0000
Message-ID: <2125cc12-1785-4a49-91c3-6479b0f4044b@microchip.com>
References: <20231127104045.96722-1-ramon.nordin.rodriguez@ferroamp.se>
 <20231127104045.96722-4-ramon.nordin.rodriguez@ferroamp.se>
 <142ce54c-108c-45b4-b886-ce3ca45df9fe@microchip.com>
 <ZWTEqXAwxIK1pSHo@debian>
In-Reply-To: <ZWTEqXAwxIK1pSHo@debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3532:EE_|CH3PR11MB7323:EE_
x-ms-office365-filtering-correlation-id: 1cbd47e9-eb01-473f-16fb-08dbefde93ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1n9sDJA7BrAHOMztullVMtlLG/90qXk6AaFjjrkiAswwskuLyjI+1damEH/O7Qm9zn/m3HoZyCxPSTF4Ze8L0o7v7PydPPO3IKPvq7kaNRDK1t7CDCnyScpycbqQSExcYZ85TSuiRM023D/MLWTC0PS1aJvNX/2Ftj9JiW8xQLeN4xjZVDTHdbowZmtb4NnX2QIe3XqzmC838fsIEuqy0N7MnI2JkxgvK0scmT5xoNnMWxxEEk/JPu5hW6u1WtkvGTqMHGXYWHjW2/kpY/rnEYUVeICeiacNWRaEp6fuZ8CLVBA8mk+9eP288KMsnoYN0orR+mqfU5K/rpCyp4aVgcqDUsPdp29SSgzyTq9jzyF7Lhr2amLWneOUv+nsYMPFh+lRrArEDXhap79f+73w3rT8XgMpSphs6u9tDZemDhzol+vhPN17MwQvWQ8upQR2vlEE3DH/yc4gbXw1WsN7A33mm55BekWplrFuabIBdDvn6kDWelMQb6jwXvLU8Vm8gIkaU0PSSMCoVFbfC/AKYRwbkRk6wo5Kv0XJjy3l6ps7ueHGgL9mnQcDa3u4dAgpW+Bb0s8ZMxtOBEcrfgw8EIu1LCqXLeyWb1z6lSP9620Wvs6CyovSU21uqT4Ixo/Ti7qui6H6wZU1mTIlKbZUH4v6qT2hvNiXP3lmKOMk2NBnlkl0t/f5zb+Vm7zIO7r0b4tBf4R7sGKOHOXgp8fG9Dr4QJ6FNVhdaG2KPNG218u7TVeFbmO31sLDxuSaPN+E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(396003)(39860400002)(136003)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(41300700001)(66899024)(31696002)(71200400001)(86362001)(5660300002)(2906002)(7416002)(83380400001)(38070700009)(76116006)(8936002)(4326008)(66476007)(66556008)(8676002)(66446008)(66946007)(54906003)(64756008)(6916009)(122000001)(966005)(91956017)(6486002)(2616005)(53546011)(316002)(26005)(6512007)(36756003)(66574015)(38100700002)(6506007)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGpUVWVBQWFuNys3MmJVNWl0Rkg2cFMycGVYUE5yeTlZeUZvUXAzNFVhbUZY?=
 =?utf-8?B?NGRmVlEyMDVVZEpGWHowNStoRi9TUWRxY3ljZCtSZmYwQVI2Vk1iQ0RBa25t?=
 =?utf-8?B?WXZCNTFnTUc0L2pyNFYrZG5KdklpRTFjR0tVTXBlcmpudEsrZ3FtbkZoS2lw?=
 =?utf-8?B?VlMzNVcwZ09iT2lqWkpOWTdVbkpYYzArMU1OR2lFYXQ1Y0ZQZHBySUVxL0ZF?=
 =?utf-8?B?cFJyU084eCtRSFZweW03b0JuMW1vTWxxVTZKNHprczFHemM2SW1sUE1qcGtR?=
 =?utf-8?B?KzE2QVJHT3BRWkFyQXZYajY0UjROeHoyUWhJejNocHRySEkwSVFSOFRWYksv?=
 =?utf-8?B?ZDdUOEJEZWMxNmgvaFJqYUFJWG1zRS9QdUdOZ0tjU3RtRGVyWGZia21NQXJD?=
 =?utf-8?B?S0VrMWkwdmZlVnlwQWczMlFpQmQ5SlpSK0dlcWlkemxOWllmeGNwa0xuQTFZ?=
 =?utf-8?B?cVRlREpLbDYwN1pLb2xzYjBpY2VjSkExK0tvR2plaFpaMXpmMmprYndzUUYw?=
 =?utf-8?B?QkdaTXdjRDVSTFdzbUVBSmhVRzRKRkM5WlQwSWUrd1pHa3ZwQ3BiMzRZSUhJ?=
 =?utf-8?B?am1NYTZ6ei85WDd1bkVpQnZ1aGtualQ5RmJuOVBMZ29QTnVRcDdOZ1JGcytS?=
 =?utf-8?B?R2FIbVV6WCs4bmxkWXFsRUh4YXhNemhyVEZXV2RVbms3OW5Vd3NLSWpJWmRn?=
 =?utf-8?B?SEJxSlh6cmlOd3MwME0ySGZpb3dkWVNNdklmcFAxd3B5dytUbjJrajgvOVd6?=
 =?utf-8?B?VExUdi9zTXNuT2xFL3M2RGZwMW5VcStPcFR1dkhrRXRHekdSL2h4Z1FiMEhM?=
 =?utf-8?B?V1FKYkM0VzdmbVZNYy93UC9NR1ZzdXVtTmxwTTVEU3hxT0k3WThnWCtpWVNH?=
 =?utf-8?B?M0wvZC95eGFQZk8yYUU1VDl0aG5zaTJwZ3Nzckhpd2RWWkh3VHpOVEZvello?=
 =?utf-8?B?UGhPeDBoc2xwNHZWaHI0OFExY2MzS0s1ZVVYa3pETklCamhTVVZIMzhla1Qy?=
 =?utf-8?B?S0M4YnVDVWZxZUVibzY0ZmM3OGp2bWRWaDJYeGFyRVFRTG1xRjY4NUFHdEo4?=
 =?utf-8?B?U1FXSEdRY2doall4bUhOWGtRdEtyd1pKYTQzUWRpNnNHQ3R2Vis0cU1adXI0?=
 =?utf-8?B?OFYwVG4vMVVxYzNjejVBRHUrbWxzU2JQbGQ0czM3SEE5WHkzWmVHWm8vYklw?=
 =?utf-8?B?RHVXcVUvS2VYeVFENjk3OU1SWmtIL3V3VTZ4T0UyN3dNSFhEaTNUNXdmVVZC?=
 =?utf-8?B?ZWJhNFlvWXFoempDTzByWkx6U3lXTVpWbG41YkJKUW5tazZ5aVlhNmdSZmp0?=
 =?utf-8?B?WDlab2JVSSsyT2x2RHpLWGl4YmhPbTduQzJlQ0JlTDNocHZVMkJUWXo3N1du?=
 =?utf-8?B?dEwveUorcTV4bVB4WHdQS1FyYlg0d1ZoOWkyejhWSnRnUXNqbFRuZlBzcG9F?=
 =?utf-8?B?NTNaaGUrWCtMeUUrR05VUkdOYTZ6aTVwZnVBZC9CZXE3b01SR2prN1c5R1ZZ?=
 =?utf-8?B?UVh6cER1ajIzeUZoUUtqTkcxYkJNUXJaa1dFL1UwNTV3Nm1ETmZzbEdzRkFZ?=
 =?utf-8?B?YlpERmk3MDQ3eTIwZjZZZkkwNGtvRGh2T1hONHZCUVhzK2VCSXMyYkVlbHZD?=
 =?utf-8?B?U1lzTG1MeWxEaWI5QjJqbi9uU3o4cjk5QUY5TlB0dmE5azlCN284Wm1IRzZk?=
 =?utf-8?B?SkcvZmFQMjZMaHBvTURhb25tMjd4U1VlOFYzb0ZUN3l2ckdZUFJ5ZTJwQ0Y2?=
 =?utf-8?B?Slh1azhIRGJiM2lyOUczc0RndUo5YWxjM09KdnhxL0w2VGFJTmZXd1FHMjR6?=
 =?utf-8?B?cE1Walo0Z0xqQnpnM1Y2ekZiclBnSlR3bFhTUFNvdi9jczB1a0phUGJHcEl4?=
 =?utf-8?B?ejVlK05ib2Qyc0E3RlROWUkxYmc0TjJ4ME1Qdzk2a2lIQUhiVVBtdVNVSlpC?=
 =?utf-8?B?UlhnVlUzQWh1UDhBRjdQYU1WTitkeTJuV2xWN1ZLRkZLZ2xEbzB0aXlCcjhp?=
 =?utf-8?B?Y3g4Rlk5bVIrNUtJdHBod2tWVmE3ZlZCWWxtSE5PR2NUZXNLaHY1WHU1S1gz?=
 =?utf-8?B?eU1CWlF5dVp4Wnh0bGVSd3hmc2ZOKzYyMFJnSGxLaGs2WGQzdkZCSEp3WWRW?=
 =?utf-8?B?U3lweG5vWllBTkFPcjl1bnMzNTF4d3I3N2R3LzhVRE41bkVjNFNFRjdaaWhH?=
 =?utf-8?Q?P4KNUWSvhO5nRCh/KXsWnSk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F85C1CB09546624093EAC7AE83C952C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbd47e9-eb01-473f-16fb-08dbefde93ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2023 06:52:24.2458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlgRfmmQ2sD0FW6tjtqi20+IEcVyyhbdOQWcpX6wbr11DLV9HtJowM4pXIoVqVcxKlLchL0aHk7KzvVVep3j6LqdjJHcqOypj9yGckOePWOSULwFJVQWJex/P8sLvaCy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7323
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDI3LzExLzIzIDEwOjAyIHBtLCBSYW3Ds24gTm9yZGluIFJvZHJpZ3VleiB3cm90
ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1l
bnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBNb24sIE5v
diAyNywgMjAyMyBhdCAwNDowMDoxOFBNICswMDAwLCBQYXJ0aGliYW4uVmVlcmFzb29yYW5AbWlj
cm9jaGlwLmNvbSB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IFRoaXMgaW1wbGVtZW50YXRpb24gd2Fz
IGludHJvZHVjZWQgaW4gdGhlIGJlbG93IHBhdGNoIGl0c2VsZi4NCj4+DQo+PiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9uZXRkZXYvMjAyMzA0MjYyMDUwNDkueGxmcWx1endjdmxtNmloaEBzb2Z0
LWRldjMtMS9ULyNtOWE1MmI2YzAzYjdmYTYzN2Y3MGFlZDMwNmI1MGI0NDI1OTBlMjRhMw0KPj4N
Cj4gDQo+IEJ1dCB0aGUgY2hhbmdlIHdhcyBkcm9wcGVkIGluIHRoYXQgcGF0Y2hzZXQgcmlnaHQ/
IEl0J3Mgbm90IHByZXNlbnQgaW4NCj4gbmV0ZGV2LW5leHQuDQpZZXMsIGl0IHdhcyBkcm9wcGVk
LiBUaGUgcmVhc29uIHdoeSBJIGdhdmUgdGhpcyBpbmZvIGlzLCB5b3UgbWVudGlvbmVkIA0KaW4g
dGhlIGNvdmVyIGxldHRlciB0aGF0IGl0IHRvb2sgc29tZSB0aW1lIGZvciB5b3UgdG8gZmluZCB0
aGlzIGluIHRoZSANCmRhdGFzaGVldC4NCj4gDQo+PiBBcyBpdCBpcyByZWNvbW1lbmRlZCB0byBk
byBpdCBpbiBhIHNlcGFyYXRlIHBhdGNoIGFuZCBhbHNvIHRoZQ0KPj4gZGF0YXNoZWV0cyBvZiBM
QU44NjdYIFJldi5CMSBhbmQgTEFOODY1WCBSZXYuQjAgaW50ZXJuYWwgUEhZIGhhdmUgdGhlc2UN
Cj4+IHJlZ2lzdGVyIGlzIHJlc2VydmVkLCB3ZSB3ZXJlIHdvcmtpbmcgZm9yIGEgZmVhc2libGUg
c29sdXRpb24gdG8NCj4+IGRlc2NyaWJlIHRoaXMgZm9yIGN1c3RvbWVyIGFuZCBtYWlubGluZS4g
QnkgdGhlIHRpbWUgbWFueSBvdGhlciB0aGluZ3MNCj4+IG1lc3NlZCB1cCBhbmQgY291bGRuJ3Qg
cmVhY2ggdGhlIG1haW5saW5lIG9uIHRpbWUuDQo+Pg0KPiANCj4gRmFyIGFzIEkgY2FuIHRlbGwg
J2NvbGxpc2lvbiBkZXRlY3QnIGlzIGRlc2NyaWJlZCBpbiB0aGUgZm9sbG93aW5nDQo+IHNlY3Rp
b25zIG9mIHJlc3BlY3RpdmUgZGF0YXNoZWV0Og0KPiANCj4gKiAxMS41LjUxIC0gTEFOODY1MA0K
PiAqIDUuNC40OCAgLSBMQU44NjcwDQo+IA0KPiBUaGUgcmVzdCBvZiB0aGUgYml0cyBhcmUgcmVz
ZXJ2ZWQgdGhvdWdoLiBUaGUgY2hhbmdlIEkgcHJvcG9zZSBvbmx5DQo+IG1hbmlwdWxhdGUgdGhl
IGRvY3VtZW50ZWQgKGJpdCAxNSkgY29sbGlzaW9uIGJpdC4NCj4gDQo+IElzIHlvdXIgcG9pbnQg
dGhhdCB0aGUgbGFuODY3MCBkYXRhc2hlZXQgaXMgb25seSB2YWxpZCBmb3IgcmV2LmMgYW5kIG5v
dA0KPiByZXYuYj8NCkl0IGlzIHZhbGlkIGZvciByZXYuYjEgYXMgd2VsbCBidXQgdGhlIGN1cnJl
bnQgZGF0YXNoZWV0IGZvciByZXYuYzEgDQpkb2Vzbid0IHNob3cgdGhhdCBpbmZvLg0KPiANCj4g
QW5kcmV3IHN1Z2dlc3RlZCBvbiB0aGUgY292ZXIgbGV0dGVyIHRoYXQgaXQgYmUgaW50ZXJlc3Rp
bmcgdG8gbG9vayBhdA0KPiBjb21wbGV0bHkgZGlzYWJsaW5nIGNvbGxpc2lvbiBkZXRlY3QsIGFu
eSBzdHJpbmdzIHlvdSBjYW4gcHVsbCBhdA0KPiBNaWNyb2NoaXAgdG8gaW52ZXN0aWdhdGUgdGhh
dD8NClVuZm9ydHVuYXRlbHkgSSBjYW4ndCBjb21taXQgYW55dGhpbmcgZnJvbSBteSBzaWRlIGFz
IHdlIGFyZSBvY2N1cGllZCANCndpdGggb3RoZXIgYWN0aXZpdGllcy4gQnV0IGRlZmluaXRlbHkg
SSB3aWxsIHRyeSBteSBsZXZlbCBiZXN0IGlmIHRpbWUgDQpwZXJtaXRzLiBBbHRlcm5hdGl2ZWx5
IHlvdSBjYW4gY29udGFjdCBvdXIgTWljcm9jaGlwIGN1c3RvbWVyIHN1cHBvcnQgDQp0ZWFtIGlm
IHlvdSBhcmUgaW50ZXJlc3RlZCB0byBkbyB0aGlzIHRlc3RpbmcgYXQgTWljcm9jaGlwLg0KPiBB
bHNvIGFueSBpbnB1dCBvbiBteSBzdWdnZXN0ZWQgdGVzdGluZyBtZXRob2RvbG9neSBpcyBtb3Jl
IHRoYW4gd2VsY29tZS4NCj4gDQo+PiBXZSBhbHNvIGltcGxlbWVudGVkIExBTjg2N1ggUmV2LkMx
IHN1cHBvcnQgYWxyZWFkeSBpbiB0aGUgZHJpdmVyIGFuZA0KPj4gcHVibGlzaGVkIGluIG91ciBw
cm9kdWN0IHNpdGUgYW5kIGluIHRoZSBwcm9jZXNzIG9mIHByZXBhcmluZyBtYWlubGluZQ0KPj4g
cGF0Y2hlcy4gQnV0IHVuZm9ydHVuYXRlbHkgaXQgdG9vayBsaXR0bGUgbW9yZSB0aW1lIHRvIG1h
a2UgaXQuDQo+Pg0KPj4gaHR0cHM6Ly93dzEubWljcm9jaGlwLmNvbS9kb3dubG9hZHMvYWVtRG9j
dW1lbnRzL2RvY3VtZW50cy9BSVMvUHJvZHVjdERvY3VtZW50cy9Db2RlRXhhbXBsZXMvRVZCLUxB
Tjg2NzAtVVNCX0xpbnV4X0RyaXZlcl8xdjAuemlwDQo+IA0KPiBJJ20gYXdhcmUsIHdlJ3ZlIGJl
ZW4gdXNpbmcgYSBkZXJpdmF0aXZlIG9mIHRoYXQgd29yayBhdCBmZXJyb2FtcCBmb3INCj4gZGV2
ZWxvcG1lbnQuIEJ1dCBpdCdzIGJlZW4gZHJpdmluZyBtZSBudXRzLCBiZWluZyB0aGUgJ3QxcyBn
dXknIGF0IHdvcmssDQo+IGFuZCBtYWludGFpbmluZyBvdXQgb2YgdHJlZSBkcml2ZXJzIGZvciB3
ZWlyZCBkZXYgYm94ZXMuDQo+IA0KPiBJdCdzIG5vdCBteSBpbnRlbnRpb24gdG8gYmVhdCB5b3Ug
dG8gdGhlIHB1bmNoLCBJIGp1c3Qgd2FudCBhIG1haW5saW5lZA0KPiBkcml2ZXIgc28gdGhhdCBJ
IGNhbiBzcGVuZCBsZXNzIG9mIG15IHRpbWUgb24gcGx1bWJpbmcuDQpJIGNvbXBsZXRlbHkgdW5k
ZXJzdGFuZC4gQWxzbyBpdCB3YXMgbm90IG15IGludGVudGlvbiB0b28uIEp1c3QgdG8gbGV0IA0K
eW91IGtub3cgd2h5IGl0IGlzIGRlbGF5ZWQgaW4gcmVhY2hpbmcgbWFpbmxpbmUgYW5kIGEgcXVp
Y2sgcmVmZXJlbmNlIA0KZm9yIHRoZSBleGlzdGluZyBpbXBsZW1lbnRhdGlvbi4gRW5qb3khDQoN
CkJlc3QgcmVnYXJkcywNClBhcnRoaWJhbiBWDQo+IA0KPj4NCj4+IEFueXdheSwgdGhhbmsgeW91
IGZvciB0aGUgc3VwcG9ydC4gR29vZCBsdWNrIQ0KPiANCj4gTGlrZXdpc2UhDQo+IFINCg0K
