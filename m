Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCFE75F558
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGXLoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjGXLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:44:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBDCCF;
        Mon, 24 Jul 2023 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690199048; x=1721735048;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sJltT1zHXt8HSZT72taB3ccrgM9OSkOWKzHwjirA0DI=;
  b=DlywYI9gS1uZU23Ah27I6eZJtQb2yFZAoRiGFhQtqRnrtwHkyxWuqz3C
   bO7NUuIZLbv6ioxuCPfSVD/NS6Vh7wV909BjWXVMxXAOQxwoewOH910sr
   yGnDHDUifsmdYOj+9uc/GEDEEkDU42E9W4jxaaFZGfOcl6vinUU/4Bri5
   NvzeBpQBJJ1+nrMbNPxHlk7yM0vabeqcl+NVOKhfaXg3sZm93z9CIi9Ur
   e4jl4FgMpe48yo2Wug49TGVmKFSxnvnzQJS4/2U4p4mzM0t3Nz5anyOBi
   KxtZTv16Lg1tBh8gQjKVOiP1bwzBpvwFGFJ/xL87p0wcGOiTBmMjp07bh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="364880797"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="364880797"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 04:44:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="849603517"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="849603517"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2023 04:44:07 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 04:44:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 24 Jul 2023 04:44:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 24 Jul 2023 04:44:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTpBc1OPMI7xwD29i/KKpWCG2FDlhM6SPk/X3kPsG5jEe+D5zHKspB9JcVsq05kRScmKK0JkBEy1f2xWR+i+ynKL/a0XIrKfAPK/X0SfB9IitS42T1UPDFuHObMqZW73pP2itCi5OyWPLXyA67PXyK/8hbvjfYi4VOZWq2XW9h8iDoZdNznxR/CwEoJ0bvgmarH7BU/1DLtRUxIhigYm/ydxWhF/dHCq+OWyhBcHcJ6VDldH7/9yEzuOflNzu0xGypew5pmndoY8iAK138yYcwVE6zo66Y6D1stO3rgO39UWHbFJVorRjsc+D/6HlbCx5q0lEOnVfcn60okXaf18vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJltT1zHXt8HSZT72taB3ccrgM9OSkOWKzHwjirA0DI=;
 b=XqyZyE2weGzPMX/5R2N5ySVq7kBIHs5O72L+z+FriODTJVuYZs8C9qax95ghXBFKESeu62uELgq0udhyuohlERTh0HleGefl3zwHZ1eSL/G4iYF5xXK/mASa5adz3C+h1rScL16wnwnADZl4awmn+g7hsFfEOV72TI7k2Bte5xYp6LsrCQDNUs11V+hcX397xyQhwlKc2tZgT+4gr6IM6tn3F+2dosFZd1KaYFoiVXucMprVCbmcSUDldMw3YUY3uSFb6DzXv+KhWyYK47e7QszDSEZTtTuxFbR+vPNwMeqNCrXd5i690EM/94mJtT8vFJTNmcXaDgy1QcSS93pvCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SN7PR11MB6972.namprd11.prod.outlook.com (2603:10b6:806:2ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 11:44:00 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::f8a8:855c:2d19:9ac1%7]) with mapi id 15.20.6609.025; Mon, 24 Jul 2023
 11:43:59 +0000
From:   "Usyskin, Alexander" <alexander.usyskin@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 1/2] mtd: use refcount to prevent corruption
Thread-Topic: [PATCH 1/2] mtd: use refcount to prevent corruption
Thread-Index: AQHZo3n2ZB8U6WhTx0+aElx0ckVEpq+5lImAgAGKEwCAAPTUYIAAe3sAgAxtDQA=
Date:   Mon, 24 Jul 2023 11:43:59 +0000
Message-ID: <CY5PR11MB6366C254F767B6C432C98A0CED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
        <20230620131905.648089-2-alexander.usyskin@intel.com>
        <TYWPR01MB87756794A30EB389AB017EB1C234A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
        <20230715174112.3909e43f@xps-13>
        <CY5PR11MB63666C8DA33C93E1DC3BCB21ED3AA@CY5PR11MB6366.namprd11.prod.outlook.com>
 <20230716153926.5e975231@xps-13>
In-Reply-To: <20230716153926.5e975231@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SN7PR11MB6972:EE_
x-ms-office365-filtering-correlation-id: cdbd7ae9-3fd8-45de-3a31-08db8c3b456c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YX2MBgxaCLHRQnkrpiGU1mS/qTuVYln9FMUwStG2KOYvndI/ezbVU8Y+0e4WoR/733H438lMtJ/njjgTpIbXJQk2uqHUz473mKapz8ebbYjGe7QSV/3iNs11Dv5p+It5IOK7O5gOJVz8EQqdRsUdaHAtgpW2IajL+mdFE1yfqRnWtwsTcRa/OwdETGcsXDtSkbDqliVnRsNPO2YrzJlggaAo5L3o0xZflc9Oy8rc/r+EhTNftFIIp4OZFbCBjIkjCbeNmCS25Wvfp+4eD6YegvvNoQ2pnJslIaqcfKWs1KOMyolDFsxX4sCDG//fUfHKoHzmutzVNKwox5Y//8bo6lzz44GFPUCp2BYmhexQYOBX9dOIgPWMDqyYqeZWp6iWDjHUSWBnBnmgaJYl2I7cknkTyjrHNrTBQfRZVCLe2A+Inw3fGF32eJbpza3Z5FLwN+AoQ/BkSjWovMz9czO64UFVa9US5v5v739dtoLqxl9BoQ/R2UtDB/8wXrxImoYxXgOBBqryDnAbOha6u+CCSzumGQOXQQearnD/skqzyoIY+/yohjvEub+hyML0Kjdu/QX9mZOBSJ3LzJwDHgv9KMaEkGg6iNIgYfw+9HMQRVImAtK6S5jb+IsBVltCYRjA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(366004)(346002)(136003)(39860400002)(451199021)(7696005)(9686003)(71200400001)(478600001)(54906003)(186003)(6506007)(26005)(2906002)(4744005)(76116006)(41300700001)(66946007)(66556008)(66476007)(66446008)(64756008)(6916009)(4326008)(5660300002)(7416002)(52536014)(8676002)(8936002)(316002)(82960400001)(38100700002)(122000001)(33656002)(38070700005)(86362001)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzUzT2ZkQ0dKVFFJc01nYUlsc3RJemxFdDF2ZmRuOTh5dTlkY3k0K2w1Rmp3?=
 =?utf-8?B?K2lDZGtyZXl0Y0trdW1OZnZ2VGJORldyNXFVbnpQWXVWdFExWUp5aFB3MjNi?=
 =?utf-8?B?K2hhdmtNOURMZStJdEFsZHBORytLVDdGZjlzQStKaTBSeGdzcHNqaVJNR1Vk?=
 =?utf-8?B?L0FWelVKYkxBa2xtczQ0clM3dGxVQUkrVmRnVUluVExYcGg3UEJDRXJJNDBC?=
 =?utf-8?B?QTE3RDlxcDNGK25ZWWhwdFcrR2ZtZHhQSjJEVWllYVpqUHYwTmFOMWllcTMr?=
 =?utf-8?B?N2ZWYjdkQTFjMGpwVkIzUDlWSTZCU3Z1NklOczZ4V2lHKzJOZFZ3ODNPcE8v?=
 =?utf-8?B?cWtId21vTUxrM3Z6VDRmSmJxRHN1TVFVOFoxVm14czJWdVcyTFhMM1c3TjRj?=
 =?utf-8?B?YUU2bEpNM0xva2NTbHpKV2R0YzUvbWpXYlpIOWxCWitrRklVV0IvelU4ZjdG?=
 =?utf-8?B?ZTZtZ1FRRktSU0g2cnBicFRvOUJTaUZrNTd0Q0xLOWUzdC9SN2w2RkdZVm5J?=
 =?utf-8?B?Y0VIamVjWWVyYjdrSHhyZTk1c0JSazJNUnJ0NXk3Q0NWTXdWMU9xNFJnSlY1?=
 =?utf-8?B?LzJMU1JnRElaeU5HOEhqV3diU0lSblAybGlBVDF6ak12Z0tKeFNMUkw3R21R?=
 =?utf-8?B?ZVRrQTM2c3RHRGE0OHpsS1ZUQjdNaE9hbS9ZaFJEMXg5MGVyejdmUzRrajdm?=
 =?utf-8?B?R3QvNzdrK1JLREYzcjNMY1NTNGtCSm9ObFRlcEdTKzlUMytqdHNtWkVnUGcv?=
 =?utf-8?B?NkhMVzZHS1AyWDUxK0xIeW1ZVTA1Unc2QXlmUVJpN00zYlkrVXJWOTVRQmZ6?=
 =?utf-8?B?dGRJak9DblltZlRMeEpyUGdpWThIYlRqbzhjM3JRanNwRGVwcXhFRTdBeHhC?=
 =?utf-8?B?eWdWQXpDMlhBY0JVaEphUVM4TnNhS3dXbnVQb0cyTnlsUVhTeUwzbWJadnNK?=
 =?utf-8?B?OStHek16MVRFajVBV0NvUHJzT3NpbnU4TUZ1TVA4bnBOZ0x6dHNtOUJPS1B6?=
 =?utf-8?B?R3ZtMGpFRG5PMTZsa25ONStHT1g3S1FhV2hEaWVYek1pbTg2UWpjdWhUdEVR?=
 =?utf-8?B?b3dlSVk3QTVlSlpMRXBiUmNKa0pvakdhbEFwbStNeCtFSlo4WDJieUtzU0FW?=
 =?utf-8?B?aFZFSCtUbXNKenZjUkhpZUFXQllwVm82MkE1djJEcStDL1EycW5xaDM4bmlV?=
 =?utf-8?B?VmlVM0o4b0pNVnJOSGJrdmMxYlJWRDIvdno2RjNrVFJVLysvOGVHRXhIendu?=
 =?utf-8?B?SFpQZ2lVT1RNejJ6czJNQ2paRndOTk5XcGU5RTRUWTEzNE85SXUzczBMR2R0?=
 =?utf-8?B?a1dkN3htSEFDZitOZCtaWXR5V1NFSmthbVBRcWJqNmNsMHFOOTBycUJyYk1B?=
 =?utf-8?B?SzBoc3ZZYUFaOUdPbmJpNDVEZlNkdnJVYlFONWJtVmJaM3VIMGhxQnhSSDRq?=
 =?utf-8?B?RzVaSjBkNkh0WGVlTjJvdHRHRWRHTk9RdTFyNEE0Mkt3a2ozTUJVTnhMNERN?=
 =?utf-8?B?eTlVSnArWEpkVGxVdDEzZXZQUjRXVU11amlrOUZCK1hGZThUSXEwNytjNFNu?=
 =?utf-8?B?VDR0ampIazRvMzhyS3lIYzNBWkc0elNyOWpoWVZmOGg5L1NIT3dHeTA0Umc0?=
 =?utf-8?B?UjgxWElBWnRvQjFPUTc0YXZyNmVmYmROVGphOWROOHhuUE9hSTQrK1RIVHlD?=
 =?utf-8?B?SFBqVFNHWUZpOVlmNjJSaXVUUmpKd09QM041TUh0cGNoNTBOS2Q4YlhoVlZl?=
 =?utf-8?B?WlZRVW5Od1pUem9WWlBIb25iYkdwRWFCcXpxRFcxNXhLam9vekF3aUtnR3BT?=
 =?utf-8?B?VWpaMG5qU3V2N3NIZkFTQU1KNElHNVZPd3hiNThzOWJ4eXlqOHhJUXNmWi9m?=
 =?utf-8?B?MEhkc003NHFkZEVibzNveEplK3RpOGlsRnVCaXdVYlhFUTF6bkkwQkVvTW8z?=
 =?utf-8?B?WXBRM2NtVEFLSFRFL1Z2QlprSDRPckluRHltUlF3TTVuNW1qYThaUmUrTk8y?=
 =?utf-8?B?aGNpWGhabkVlNHExZG5uNG91eWMrZ2tyU096QmxPSHBtWk1FWVZpMHJMQlRt?=
 =?utf-8?B?dm5UYTJRUFhuMVlGR3NZaWpRenpNckEyNmZ5TE4wSWNUMTlpeWRlamdaQ21z?=
 =?utf-8?B?YVIxRzlJMVdjaEdaZlJOdzkweGRFbDFvWEpKWlBIT1JKS09taEY2VFhlZngy?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbd7ae9-3fd8-45de-3a31-08db8c3b456c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 11:43:59.8502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqjeyBJfanqD4jZS3XwLs/O+VAMTUUFeG86N6SnmR6feF3SOsjPFNLl67OlYkgelSZtasZKndVx6ntQVpaUyFef/aKQztwcMARXex1iF6eM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6972
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ID4gPiBXaXRoIHRoaXMgcGF0Y2ggYXBwbGllZCwgd2hlbiBJIGxvYWQgdXAgdGhlIG1vZHVs
ZSwgSSBnZXQgdGhlIHNhbWUgMw0KPiA+ID4gPiBkZXZpY2VzOg0KPiA+ID4gPiAvZGV2L210ZDAN
Cj4gPiA+ID4gL2Rldi9tdGQwcm8NCj4gPiA+ID4gL2Rldi9tdGRibG9jazANCj4gPiA+ID4NCj4g
PiA+ID4gVXBvbiByZW1vdmFsLCB0aGUgYmVsb3cgMiBkZXZpY2VzIHN0aWxsIGhhbmcgYXJvdW5k
Og0KPiA+ID4gPiAvZGV2L210ZDANCj4gPiA+ID4gL2Rldi9tdGQwcm8NCj4gPiA+DQo+ID4gT3Vy
IHVzZS1jYXNlIGRvIG5vdCBwcm9kdWNlIG10ZGJsb2NrLCBtYXliZSB0aGVyZSBhcmUgc29tZSBp
bWJhbGFuY2VzDQo+IG9mIGdldC9wdXQ/DQo+ID4gSSBoYXZlIHNvbWV3aGVyZSB2ZXJzaW9uIHdp
dGggcHJfZGVidWcgYWZ0ZXIgZXZlcnkga3JlZl9nZXQvcHV0LiBUaGF0IG1heQ0KPiBoZWxwIHRv
IGNhdGNoIHdoZXJlDQo+ID4gaXQgbWlzc2VkLCBJIGhvcGUuDQo+IA0KPiBJIGJlbGlldmUgbXRk
YmxvY2sgaXMgdGhlIGdvb2QgY2l0aXplbiBoZXJlLiBKdXN0IGRpc2FibGUNCj4gQ09ORklHX01U
RF9CTE9DSyBmcm9tIHlvdXIgY29uZmlndXJhdGlvbiBhbmQgeW91IHdpbGwgbGlrZWx5IG9ic2Vy
dmUNCj4gdGhlIHNhbWUgaXNzdWUsIGp1c3QgYSBiaXQgbmFycm93ZWQsIHBlcmhhcHMuIEluZGVl
ZCwgaWYgeW91IG1hbmFnZSB0bw0KPiBmb2xsb3cgYWxsIHRoZSBnZXQvcHV0IGNhbGxzIGl0IGNh
biBoZWxwIHRvIGZpbmQgYW4gaW1iYWxhbmNlLg0KPiANCj4gVGhhbmtzLA0KPiBNaXF1w6hsDQoN
Ck1pcXVlbCwgZG8geW91IGhhdmUgQ09ORklHX01URF9QQVJUSVRJT05FRF9NQVNURVIgc2V0IGlu
IHlvdXIgY29uZmlnPw0KDQotLSANClRoYW5rcywNClNhc2hhDQoNCg0K
