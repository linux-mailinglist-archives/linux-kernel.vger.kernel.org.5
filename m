Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7914757BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 14:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjGRMcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 08:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjGRMcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 08:32:20 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA538E70;
        Tue, 18 Jul 2023 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689683538; x=1721219538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nkVjZyF79fbMpx4742PCH0GBMhqQYMOA6Xdbe0JSjhg=;
  b=WCx6HEvWmItGyQZlTyXM1AhKDU+TTIQ/wjmQKOj6ju95oRmMKz5xFKzc
   wZgVavYnwGbgCFuWpFkI6V1Wn9Gk8VFk5PhIum6k6ribbOfB8/Bpvl9+t
   +ndAabEBdV4uT0AICl60ho6L/ViQFnxDvoFZtMH5F5KKF+PAJ1kb2WJa0
   vU7vk2zumFbZBoCDSjyRmqYYM8XKfKsZTZCKUPRLBEt2XC7iNy3FCfqcZ
   4ezeWv4GUL69GBt57seDf2a2gexYcqbcN8UW0zvPfK1NBH55TcU3QakxN
   Rkm0XdMas1HQkpX0Mq6g92hR2TYkHoGe0ZTXXzKpgqoJ4oYrz1cAKPvlT
   g==;
X-IronPort-AV: E=Sophos;i="6.01,214,1684771200"; 
   d="scan'208";a="236768309"
Received: from mail-dm6nam04lp2044.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.44])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jul 2023 20:32:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ2rcaWGZ5sF49mQ4JnJ3axnWQA9p9mdRvUJcvQn6xaMigzskC1I9PCmA3ASnIOt/CbVJdAlJ3W/JOVFT4tWqkDPWwKFvbPHItsPHybTPwPmgaoUjK485UuWoTHMvihuePrWJBr80+gmFBynTEOmnGKHL5f4Ii4rrpEn/0RizCtlLpOmT08vgt+sZ3S+eK8GrC1F1mtpcb8yyxjE+91tDoz1CGJtG91cKf+DhZc4zr5KGtMrRoxX4JfTkenRBHESijaCPwldhR1ll1Hw7m0JXkYBamWefvhxAsiAK4yB/MTVe0dfHJ4HImoo4VGBpTHpdY0QuOQIiCebNFuSzIrPUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkVjZyF79fbMpx4742PCH0GBMhqQYMOA6Xdbe0JSjhg=;
 b=F/a6CNSdLISdM2Z6cCd8PPvZsd0vRV58IZTu2haQOdJx+Uhm01BXLu2i7oLgHlyg++z/r8LoWXDxLR7gc1zXHmDYpQxny7vTXeU4U9aB0kh242VcdO0qeM9JFaYe9T/xsjlvlIwmxSXteksQj43DEoB1SgwNt3FsMsMmTpQM8wyWa/BpXpqk0Zvz99Lbw9M6T7/ZpsOi4vZ3VfsNNnADJCG+UCNx4EiqY4GCar3Mwn9AVJWjSCCrQ9HZP5R+WLlaN9e+RXIvGivfsmp6JRYhxUOz9INnlmDqmOIpEcCeKxk1/dN2oGcCrXw4FnZn9OpJOeNXwNGotj7dMwIheHPDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nkVjZyF79fbMpx4742PCH0GBMhqQYMOA6Xdbe0JSjhg=;
 b=Cl1mbJCotbXlfP9xpJt9Hdho+4yoOAMmW+FE1YfZyesR5SAdMTClH3SjZCUe23aG5YlEZT9QD8Ec8d6nJR564ZuO2CgZkpQ90bwRXeWXh45LgICOrlLxHVmojG/YA5vvHl3q92s6dE8CyljJP4oE8eX1xnrmsnbELXAHcHrOXiA=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 MW4PR04MB7330.namprd04.prod.outlook.com (2603:10b6:303:71::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32; Tue, 18 Jul 2023 12:32:15 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::4781:1e0e:9df8:940b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::4781:1e0e:9df8:940b%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 12:32:15 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wenchao.chen666@gmail.com" <wenchao.chen666@gmail.com>,
        "zhenxiong.lai@unisoc.com" <zhenxiong.lai@unisoc.com>,
        "chunyan.zhang@unisoc.com" <chunyan.zhang@unisoc.com>,
        "yuelin.tang@unisoc.com" <yuelin.tang@unisoc.com>
Subject: RE: [PATCH] mmc: core: Remove FW revision from CID check
Thread-Topic: [PATCH] mmc: core: Remove FW revision from CID check
Thread-Index: AQHZuRVytpaKAVzFqUCnmE3tULXVpa+/C9GAgABo/JA=
Date:   Tue, 18 Jul 2023 12:32:15 +0000
Message-ID: <DM6PR04MB65753E95C58554A9BD01C3FEFC38A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230718011504.10947-1-wenchao.chen@unisoc.com>
 <b4ef97ba-440a-2641-0811-bb05e630ccb1@intel.com>
In-Reply-To: <b4ef97ba-440a-2641-0811-bb05e630ccb1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|MW4PR04MB7330:EE_
x-ms-office365-filtering-correlation-id: 33de889c-d886-4f7f-95e8-08db878b04a9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4mLg561y7UQ/Izqw3Ms7S16QfT1y/YWsyJYClJqoVRetIcMaLK4/J2A9yZFA9CQTQVwHtZnT/bkhNKXfBV63M1tgIRZGNmLLzpOEu2yGpQ0rXSDA3cUlFu+BfyOfBloBVfuLHM1Id+rBuD6QYQGZkdnQ+KDtGsFgLKnFB0RbpqZqgKbzNHmp0uCKKc8Vv+P6ZX4HwV6LWVykj/HbP5ZJnxWglfZkpO0vqA4b3x2J1C+fbsXkCgI8kkyY/ronMdeOJKsUdfFP0LcB1bCda5st0i79nUkERlZfW6BzotBQL6qCgj08u1DYk90lkOJorHJi1Rb5x/B9bce82vFiQufP5H+RPyEIto28jR3LRQStPkSgaYrn4UIgRyan8reD+SBltf8cy/QhLcs68aIW+T1G+dNor7OYVbps5qQTtMA+1Dl0ZWbdNP1Otx0YFYDsTl926TgKrvlJKAF6YNycmmIZXfb2yQM/zklagXTh+HslOUt2aBTwQ1Mi/qVhv/gqkHTZcCrN0nIxpa0ALvrTkTbwLCAeOkZL9rcNueLkJz+SmbyP78bf5vT+fctMGXA5g0mu3EwItF52UtinR6WTAxPdsNsWNd6DIMxApLpaq+kPs+5EaZPZ8Z9E4K8cxwlNv3HK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(451199021)(8676002)(41300700001)(7696005)(66476007)(66946007)(2906002)(66446008)(8936002)(66556008)(54906003)(122000001)(76116006)(86362001)(4326008)(316002)(64756008)(52536014)(5660300002)(9686003)(38100700002)(83380400001)(186003)(26005)(82960400001)(71200400001)(6506007)(33656002)(53546011)(38070700005)(55016003)(110136005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVRpOEFycnlSSlRTcnFLcUFuSWNyWmpBcVlxNy82cjdKMzdldmhCSXNieVYv?=
 =?utf-8?B?S1ROTnBYOVpZRFlrRkYzSzBuYlhjckt0M2owZ25oYmp6V05nV0ZMSDFid2tq?=
 =?utf-8?B?MkFNYk1TMVl2OVdYSzVpVXpacG9RbW1KQkxLRk5tNW5pYTRRMGRuaS8wbnZD?=
 =?utf-8?B?cVBBaVY5V0RaR2srRXZ1VEZvWCtUNmNoR1VYZytIM2pMZmZPSE0rVk0xTVY5?=
 =?utf-8?B?V0VpZ2MxUjk2bUFQZzBzQWlIKy9SM1l3TEszRytJWkMyT0N3YnR5eUhHam40?=
 =?utf-8?B?WWRVWTFGb1lMVkFwakdOZEllUU1RcmxZVWRFZy84R2VBTlRGdE4rQllkRkRQ?=
 =?utf-8?B?OXVwVzhOZkd4NndFSVdtYlBjeDlVOEJiOFV0VHhKVVNYdTAybmg4ZEZsQXJs?=
 =?utf-8?B?bTkzNGtiN0p5ZmJiZHcrRytWOE1jbUo4M2xLZnlGMUc3ZFE1TjNtcUZqcGFU?=
 =?utf-8?B?S1RrcjIyempqVjZlRnUxVGRtcDdtaEQ1QkhaeDNNZ0pyZGNyVStkVWZuM0RQ?=
 =?utf-8?B?SHE2dGpYaWwwcFZCYS9aTmduejFoY2dUY1ZNc3YwWXNoaXh4OHQzZnA5Y3Zv?=
 =?utf-8?B?SzNBYy9RWXJXS2NnNDdReXhYTmN6clV5aW9aWDd3RnBrVEZFZUYzTnk1di8z?=
 =?utf-8?B?ZnlxbUovSHcwOGVYc2ZoMEZQeUF1Tjh2d0Npazl2SStZWVYxSkN4OUJERVNS?=
 =?utf-8?B?ZGMrclRkUFV1ejVzamlkK3hnTXdGZ1FEdnJ2K1h0KzJHR2NMeDkyY2NUZjVt?=
 =?utf-8?B?alNNQXRtZlB5Zm04eXBQNE55b0xTUUR2Y0RwVGhCSjlBd0c5emRrUUhaNWM0?=
 =?utf-8?B?UkVRNE8yblo2Z244Y2tRS082Qy96YVR4ZWtVQWVnZEVXQWZGYldaUmZtNk9L?=
 =?utf-8?B?VkE1WDBuUS9IaXg1Q21zL3F0a3djdDNiU2tzcDJ1d21INHBkV3AyUGY1ZkIz?=
 =?utf-8?B?RG9xMmVVRk1MVDAvU0p5WkZpbExtTjVQSGN6Rng3aXdZd01SOXl5bHVWd3hv?=
 =?utf-8?B?c0grQi9SWmRyYzBoTmlkSkJBMVNqbHFPUUZOOXJVOHJOeERkcFo4bi9nSkNm?=
 =?utf-8?B?a1lWM2lGRjcvNExER0R4RGl0YXI1WWVyWXNLdnNvVzhQNjQySEo5MFpGb1VL?=
 =?utf-8?B?YzBFdmQ1NGNFTDFISzNJbHdVTkgwZEErQkg1T3JnNFRsTjZBS2hVb1VkbTVH?=
 =?utf-8?B?QVVWZ0p0emhYOVZPMyt0NTlCRU5tSlRidlhaQy8wRkxvSS95K2VZTGR4SlZs?=
 =?utf-8?B?ZGc5ZElzWS9sUVUvWDc5ZzJUbkVJVGZ6MEp0MTlqLzY3dDFWZUhzajJ5OHlo?=
 =?utf-8?B?R1hWNTZYUkFsNWxvSVZ4WFIyTk9LYkVtc0JSNkVpYkZUR0dwMjVEcDJGWDFR?=
 =?utf-8?B?aEtNeXA0U2FXL0J4aW9XZzJlc1R6L1FxZnMzdEtXRGhhK0dMUTM1bXdBcks0?=
 =?utf-8?B?SDU5TjlRQnJZWmhTeDlOTlFtS1d3SnJXTVJET2hXTEdrblBveVM2MzQycHA1?=
 =?utf-8?B?K3ZLdVNTM1A2VitRTVV3OUVrMC9naUt0THQ0TUc5MjVxOWdjcll1dnp1SXFp?=
 =?utf-8?B?aDF2YU4xRlZLU3RGdHZ2Tkw2UGhLdlc2VUx0WFppSkt3TGV5T2tsUFU0eXQx?=
 =?utf-8?B?SGZuVm10L0tuMUpRaDI3RGJ5cE9WWitqYXRJUCt3NExkZWM5bCtMbTl2dTk4?=
 =?utf-8?B?R0krTjF6OHBFb25yT2xxYkdEN2x3aThiaUVVeWVmRzBoVGZvTFg2ekpvNWls?=
 =?utf-8?B?U2RzMk1uSEtTVVI1TjhVcjNOOHhPcHRkdkxIOFZBRml4RE0zR3NJVmxvb3Va?=
 =?utf-8?B?RTlSZW5xbzdvR1NVOEpKRkNrckF2dzdOOFV2TTBhRGlpek1wUVpaNDZVTWlu?=
 =?utf-8?B?NGVrUytXK2pYTjh6ZlNiNk41YWxFd0VXY2hQU2FlSXFlT1NBU3dvVzZuQUpO?=
 =?utf-8?B?Sm53U2lUU2g2ellPL1ROL2Zyd3ZmS0xoSFVVL1VFQWtzTVExcDZIQ1VWRHdF?=
 =?utf-8?B?N0hrVmc2T1VvVHVFZ0J2aklBaEdnS241QUR4NmNKYkRNdHBBZWlobjVkUi9h?=
 =?utf-8?B?dFhkeDd4QUZsMmVkUkN2QlBUZzAyQUhtS3NSVC92NU94dEZkNW85ZVhHNndJ?=
 =?utf-8?Q?1kIcKqI0/JerTfixNRB9nMHHk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PD5zV/myG/yHzd1Kk9ZyP4SJ59+0b8iAj2O7rxWz/O/x+uRKfG2DGfsp7F38sp4qJ6rZ/ayNnMAIaBXR+ZBp+hJAY6u7Cy6ad5neUzD31o+i1l/iZ/OuFhU/1kAXvYIeGX0BbR7n4XUhTTmzYrcMZu6s4OISdBN4nH2EwaaSu91SQCbxJqFzZkj3MNivNydLzMAFVCMRpovz7q/I22DKKMDVfebQsZ0LUhBUdwBgY4r26HCrYLpOxpZ08aXmgvzN0+w3ES/vD5Q137tD7sZDW2W6pPjEdmay/i29mpG0LlXZVvCzcg7vjdso/8WsgkRAOwjVT8g+2sUXoUMD5B7Jx1bQhG72EyY+Svq8ArBG/ITVrvfqERMjFk3cbW04/F2xj/XYvji0qn0XujZFXQhQ2GxcYuFZs9fDix71UYBpxMbiv6wU9YeA8ZDVhBNhsEKHbUy8DoCFZT0LDG4Lb2LVcknWHMiewjYM5AWkc5n5ovB1QqvjCGRqy5+WFK3EkmrbAmqpOrq3RxiFUZJn8IZG0eKMqkXmyEN/xCvcifylCXHLKM/kx7N2J69tEw1tourNh98qZeqGnzUPj7YZiLihhH9i4407bVozCNtkkAfJeiYw4Xe9mUBPWD2d/IN7Qd2u59HVxwiALe4m49+qxloXXx5YMa0lcgkiJSRZiXU0AaZZKh4PUHlEIRM9x96xanKUBymkvLHAvvhIkSxrcT3FVn1+L1YQ8W5/gWSzcr+rvXtfHiAS4Gz453e6nw0O1kO+q3mKdxtxsxEwWyEJ+oL4/XYwNuh7H204oBk0aqhnUWmXJegOUWKNqO+cqXnGuSidQA3NKAO+c5m+WyuBRs7PNJEDdxMhPdot7alris6LEEdxgBqwiQ3Xn/9WPmmeyDsC7OPsOy3+z/bHXCwlN8PaIQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33de889c-d886-4f7f-95e8-08db878b04a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 12:32:15.0932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dHx+NrQZBFmOZo5GskIdxRQ0r2EX60s2Ukg48BwTlPmoOIRu+JSE7eQgTIgoD09zEi4GrYTpdvsqfc7NQwX6GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7330
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gT24gMTgvMDcvMjMgMDQ6MTUsIFdlbmNoYW8gQ2hlbiB3cm90ZToNCj4gPiBXaGVuIHRo
ZSBjYXJkIGlzIHJlc2V0LCBtbWNfY2FyZF9pbml0KCkgd2lsbCBjaGVjayBpZiB0aGlzDQo+ID4g
Y2FyZCBpcyB0aGUgcHJldmlvdXMgY2FyZCBieSBjb21wYXJpbmcgdGhlIENJRC4NCj4gPg0KPiA+
IElmIHRoZSBmaXJtd2FyZSBpcyB1cGdyYWRlZCwgdGhlIHByb2R1Y3QgdmVyc2lvbiBtYXkgY2hh
bmdlLA0KPiA+IHNvIHdlIHJlbW92ZSB0aGUgcHJvZHVjdCB2ZXJzaW9uIGZyb20gdGhlIENJRCBj
aGVjay4NCj4gDQo+IFdoYXQgaXMgdGhlIHVzZS1jYXNlIGZvciB0aGlzPyAgSSB3b3VsZCBoYXZl
IHRob3VnaHQgaXQgaXMgc2FmZXINCj4gbm90IHRvIGFzc3VtZSBhbnl0aGluZyBhYm91dCB0aGUg
Y2FyZCBhZnRlciB0aGUgZmlybXdhcmUgaGFzIGJlZW4NCj4gdXBncmFkZWQuDQpBY2sgb24gdGhh
dC4NCg0KUmVnYXJkbGVzcywgdGhlIFBSViBDSUQtc2xpY2UgaXMgWzQ4OjU1XSAgYW5kIENSQyBb
MTo3XT8NCg0KVGhhbmtzLA0KQXZyaQ0KDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2Vu
Y2hhbyBDaGVuIDx3ZW5jaGFvLmNoZW5AdW5pc29jLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9tbWMvY29yZS9tbWMuYyB8IDE4ICsrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hh
bmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9kcml2ZXJzL21tYy9jb3JlL21tYy5jDQo+ID4g
aW5kZXggODljZDQ4ZmNlYzc5Li4zMmE3MzM3OGQ1YzMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9tbWMvY29yZS9tbWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gPiBA
QCAtMzIsNiArMzIsOSBAQA0KPiA+ICAjZGVmaW5lIE1JTl9DQUNIRV9FTl9USU1FT1VUX01TIDE2
MDANCj4gPiAgI2RlZmluZSBDQUNIRV9GTFVTSF9USU1FT1VUX01TIDMwMDAwIC8qIDMwcyAqLw0K
PiA+DQo+ID4gKyNkZWZpbmUgTU1DX0NJRF9QUlZfTUFTSyBHRU5NQVNLKDIzLCAxNikNCj4gPiAr
I2RlZmluZSBNTUNfQ0lEX0NSQ19NQVNLIEdFTk1BU0soNywgMCkNCj4gPiArDQo+ID4gIHN0YXRp
YyBjb25zdCB1bnNpZ25lZCBpbnQgdHJhbl9leHBbXSA9IHsNCj4gPiAgICAgICAxMDAwMCwgICAg
ICAgICAgMTAwMDAwLCAgICAgICAgIDEwMDAwMDAsICAgICAgICAxMDAwMDAwMCwNCj4gPiAgICAg
ICAwLCAgICAgICAgICAgICAgMCwgICAgICAgICAgICAgIDAsICAgICAgICAgICAgICAwDQo+ID4g
QEAgLTEyNiw2ICsxMjksMTkgQEAgc3RhdGljIGludCBtbWNfZGVjb2RlX2NpZChzdHJ1Y3QgbW1j
X2NhcmQgKmNhcmQpDQo+ID4gICAgICAgcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0
aWMgaW50IG1tY19jaGVja19jaWQodTMyICpjaWQsIHUzMiAqcmF3X2NpZCkNCj4gPiArew0KPiA+
ICsgICAgIC8qDQo+ID4gKyAgICAgICogV2hlbiBjb21wYXJpbmcgQ0lELCB3ZSBuZWVkIHRvIHJl
bW92ZSB0aGUgcHJvZHVjdA0KPiA+ICsgICAgICAqIHZlcnNpb24gKEZpZWxkIFBSViwgb2Zmc2V0
IDU1OjQ4KSBhbmQgQ1JDLiBCZWNhdXNlDQo+ID4gKyAgICAgICogdGhlIHByb2R1Y3QgdmVyc2lv
biB3aWxsIGNoYW5nZSB3aGVuIHRoZSBmaXJtd2FyZQ0KPiA+ICsgICAgICAqIGlzIHVwZ3JhZGVk
LiBBbHNvLCB0aGUgbmV3IENSQyBpcyBkaWZmZXJlbnQuDQo+ID4gKyAgICAgICovDQo+ID4gKyAg
ICAgcmV0dXJuIGNpZFswXSAhPSByYXdfY2lkWzBdIHx8IGNpZFsxXSAhPSByYXdfY2lkWzFdIHx8
DQo+ID4gKyAgICAgICAgICAgICAoY2lkWzJdICYgfk1NQ19DSURfUFJWX01BU0spICE9IChyYXdf
Y2lkWzJdICYNCj4gfk1NQ19DSURfUFJWX01BU0spIHx8DQo+ID4gKyAgICAgICAgICAgICAoY2lk
WzNdICYgfk1NQ19DSURfQ1JDX01BU0spICE9IChyYXdfY2lkWzNdICYNCj4gfk1NQ19DSURfQ1JD
X01BU0spOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgdm9pZCBtbWNfc2V0X2VyYXNlX3Np
emUoc3RydWN0IG1tY19jYXJkICpjYXJkKQ0KPiA+ICB7DQo+ID4gICAgICAgaWYgKGNhcmQtPmV4
dF9jc2QuZXJhc2VfZ3JvdXBfZGVmICYgMSkNCj4gPiBAQCAtMTY0MCw3ICsxNjU2LDcgQEAgc3Rh
dGljIGludCBtbWNfaW5pdF9jYXJkKHN0cnVjdCBtbWNfaG9zdCAqaG9zdCwNCj4gdTMyIG9jciwN
Cj4gPiAgICAgICAgICAgICAgIGdvdG8gZXJyOw0KPiA+DQo+ID4gICAgICAgaWYgKG9sZGNhcmQp
IHsNCj4gPiAtICAgICAgICAgICAgIGlmIChtZW1jbXAoY2lkLCBvbGRjYXJkLT5yYXdfY2lkLCBz
aXplb2YoY2lkKSkgIT0gMCkgew0KPiA+ICsgICAgICAgICAgICAgaWYgKG1tY19jaGVja19jaWQo
Y2lkLCBvbGRjYXJkLT5yYXdfY2lkKSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBwcl9k
ZWJ1ZygiJXM6IFBlcmhhcHMgdGhlIGNhcmQgd2FzIHJlcGxhY2VkXG4iLA0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIG1tY19ob3N0bmFtZShob3N0KSk7DQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgIGVyciA9IC1FTk9FTlQ7DQoNCg==
