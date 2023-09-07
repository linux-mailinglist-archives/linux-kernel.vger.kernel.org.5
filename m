Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6455F797DAE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 23:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbjIGVDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 17:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjIGVDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 17:03:07 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB43C92;
        Thu,  7 Sep 2023 14:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694120583; x=1725656583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6AEAcbqNN5OPw4JSV1r+/Z1dB8CH2L/Nhagq4lNhRt8=;
  b=PG3/PFWJYrGodPuyKJEZzc3ffOIMK4lCxhw4pHCMiPzoi2NstqUjjR0t
   bCHfUg+6mpSQ5SJjIx1iEG7MZxe9VP6LP5T7tYtVt24uFB3WJrVR5lzB5
   i3rVQ8aDQgvJ1eiCy9/g03uw1pZOUqOG6lYAl2R/vOCh8GYijD3hR0w3w
   b4Nn7JgEWmV8DQZOtWgXVtYN0P6rfIMtagOiR2zY1+NostZQZzQu+8EDu
   gfgk2N7wsCd3g7AJ21kurUjifk3yjO6lsUHZeAUee1ArDGoLYVOR0suJZ
   kGz06VFawYJP6nJ3VF/bz2/WpeTiCVSUNZMIpPC1zDJuFwfDpg1oIWOK9
   A==;
X-CSE-ConnectionGUID: pxx3Ct1ZRhu+2GZl90yZBQ==
X-CSE-MsgGUID: 2GZvYZRSQEmT1h6mhOaelA==
X-IronPort-AV: E=Sophos;i="6.02,236,1688400000"; 
   d="scan'208";a="241503414"
Received: from mail-dm6nam04lp2041.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.41])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2023 05:03:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNOxSwWN5THjqiXV8XlRf/+2hxKOH487lbhtZZU+8GlE77IYjFlCEmBVQyeMAXah4OCfRqYydGiaYFdluqg7ElvlAYiq1r/65WOeXLDfKTvudzdF2c8POoZ+GrhLkG9wyUqs4GEWc6NjVqZLnUP6KBSNjK8v0/pDpl/heh0cxAIt4xWIZgM9kaJ2Rtq+oJOKYg77Ofix3nOI09U0Z6bq8p1yxNe98GwG1auhJQ8PKGeUXD8nWFOEJMJmal5xFRrKBQcj7QSGpLyqnIjx3SQYwYNTOCBdU19REVYTiLqsDWrHPGdXl0KidTlHWUSYvMQ3Xoh1alkfxV44K1m0uHbMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiINRoX6Z0Ok4h0fJKMmrgsWBFNV4XRvnaWCVx6m+b0=;
 b=A+YiPy56LXeT1GIVqVrXTjvT9fVuBJpUceVxdIxyVyvNiRwZnWnDRykQP++P7kUBD+2tlKKOzUXG7Se06J2qAskt74EY0ehGrJNffOAFQfXMmLhIQqZs09nTtJwJMMCC1UJJJ+9VCucqmbiE0Y053Rdm4qgXlTCRAP0P9U14+GT+Ka/GeC2nQjHZgdTTY8vLVLWT6sw7wqJkFF3PrOMTzDXRv8P0Uw8Q3DAtzAzzuNOBqQfk+5VCSHcd2V86NL7mkpRSTK95hSY7sQpjvlJYm9jDHKkvSaZQgWRTypfK2UZxcj3AeKgnrxjpFdeTzWOymFbUdT7k/0zSBElP27UNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiINRoX6Z0Ok4h0fJKMmrgsWBFNV4XRvnaWCVx6m+b0=;
 b=xHRKF2WnorRElf+QVcFSPwk7w71xKnnb9GimrrGTNtdU1Yb16fa5FaGQ/PhWt23iTYNCRS3mGn+YZz952+ZU6VT+x/acjCXv/DDv9RgrKGXA2c0Wd7LqLJ9HjNkSBCPv437TyF6hWrHpDKo331+cDrsDh02YPYBy8GeUounCYDI=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by SJ0PR04MB7774.namprd04.prod.outlook.com (2603:10b6:a03:303::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.26; Thu, 7 Sep
 2023 21:02:59 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.024; Thu, 7 Sep 2023
 21:02:59 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     "linan666@huaweicloud.com" <linan666@huaweicloud.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>, luojian <luojian5@huawei.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "dlemoal@kernel.org" <dlemoal@kernel.org>,
        "htejun@gmail.com" <htejun@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linan122@huawei.com" <linan122@huawei.com>,
        "yukuai3@huawei.com" <yukuai3@huawei.com>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>,
        "yangerkun@huawei.com" <yangerkun@huawei.com>
Subject: Re: [PATCH v4] ata: libata-eh: Honor all EH scheduling requests
Thread-Topic: [PATCH v4] ata: libata-eh: Honor all EH scheduling requests
Thread-Index: AQHZ4V8Fhmj5bt9aZE6JyD/cOfJ8WLAP2peA
Date:   Thu, 7 Sep 2023 21:02:58 +0000
Message-ID: <ZPo6fXqTbmwDyopr@x1-carbon>
References: <20230906084212.1016634-1-linan666@huaweicloud.com>
 <202309071557.3a90e7a8-oliver.sang@intel.com>
In-Reply-To: <202309071557.3a90e7a8-oliver.sang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|SJ0PR04MB7774:EE_
x-ms-office365-filtering-correlation-id: 1d9716fc-4117-4c7b-ffa7-08dbafe5d0ec
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ijWLHjcyaEF5cu1tA/qnkCpeCzAkOA01U7Xr+1jXVLjgCAXyYphH0hHWhyaWIQy94E2W8THc/1iF/tC18pc6506a/rb/LnF4l8gOLBDxLEK3CBL3VnDdstGrTxNy7+oGiYAn34tyzzJWfh/BAjy9KioDhjHB1soS0WzG1c4JAKvkd2/qJHhDDNra32g+NqL+JAamoXvIWmqlT6uNWHLm+15UQPflFA6vRbzke9Vcg9lOVHYl/lMi0iAjdISKhH2Ha3dZKS5cvkpwo7HIr9e+X1yL+b4820XpJv/Mbwm8iiXhOguolcIkTfCzw8cEtFJmKMe1w2je+r4OW11jdXrVS5uDlXPIuBnOrTAnP6Z+HP6AdEX7jtMfBx51U/0zOLEX9H2vn2s3dI7MqeC2nZJtQUvP2dGxisfJzib5d+H/HM9d+n8f+wsvnKDrNXtjzftij13A3ox0sy3yNjUoCPUfmz+JcS9RuFZoIMpEFg0mIVfq8mSMD6rZ75+o5udRr5Mtq8qosBg273Xq6YFqh89LtLeUGoVIyZTRziL/GsNFDqW4U1NQTz0fCDU1gRWijMHJxHkvGDhi+6FkgnNIZy2rg0IQOiWa6ni0Yb8js9a2aRcIpnyLCcDnIw0/0U2q49l5TMtCXzCrDnZR8/RdxLanfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(82960400001)(478600001)(6512007)(9686003)(38100700002)(38070700005)(91956017)(33716001)(122000001)(966005)(41300700001)(66556008)(64756008)(54906003)(66476007)(66946007)(316002)(6916009)(66446008)(83380400001)(6486002)(6506007)(76116006)(26005)(5660300002)(4326008)(8676002)(2906002)(8936002)(71200400001)(86362001)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NikuOK6Xw+344U6/aIhtpkZyA5Je4NBSv4cRz0EZiD109HFBjInSpZuZvQD0?=
 =?us-ascii?Q?8paqMOXMUxXNMX/FdxTgxJfToqFR1u2QAhzJlzXeZFiurBJc1A1MCFwnhGjs?=
 =?us-ascii?Q?YQISBMYeGTSQJeiRyhcVueKRRQ27QVIjzaL7uIizDvQndTTmQ3RWYaZ/GxK0?=
 =?us-ascii?Q?VF+aS2XKIg5k4qdVtEAr0hHrGHFM1U0RYgy39AdN/MBdAEYk2fvRq8z8YgXR?=
 =?us-ascii?Q?jIf6sGvgAkDY6H7g4lKGphM2u7422PoHowqpFX9yMzqaTw9+z5YDDa+euX5Y?=
 =?us-ascii?Q?WOGOd7qbgNvcFpOgi0rp77p/UO/rEE+QFMbZ3gwVWKe07RjWtyiFFEyssZ2S?=
 =?us-ascii?Q?mjDp83iupVAWfXS0w/45TllALeyD7/gplRNNQ9lK5VBmSbh2iz68Utsx6i2d?=
 =?us-ascii?Q?tYSibOWSs+bP0ED9+ghBRjLP9XgsNRSuKJmF9vPh3XkGdSQoY6fJrHAOR3RJ?=
 =?us-ascii?Q?rOsunkxyAWTP8y0Qw6iM/fbNaoAWTAdqET1VNW6IRApm8JOCLDeM94o+OM/T?=
 =?us-ascii?Q?vxwm5eA6LMpDIesYGJv50zC7t4/7vw4ueGVvP9hKPCYnWuak9KlsCezfLFsa?=
 =?us-ascii?Q?mFN1kmaAeRM7v+PalV5f6TG5782w+zGi5BWVN99Fh/VWJXQM4vFf+lxvGgon?=
 =?us-ascii?Q?0uYPH4ztP4e9vZbnrmhlJ7zqO8cv6997Q0w8Pg8wSvjpKuaWtiGKyKChYluL?=
 =?us-ascii?Q?FiqUmoh2hNeb6R2IsMiXy2sboav2HNe+o80dxPKzEo/Fqx3CwZJ6vLSYG6oK?=
 =?us-ascii?Q?exLovK0dyKTLKdpb27LHV+u4f4BnC632RR25Ilf8eODSHg+fhz7tz5icFVNL?=
 =?us-ascii?Q?Qdgbg/wxLwiSsn4AroXW3RRwgXVGXG1cM4oKjJX4X6bjUZdKWltPn+HalNRp?=
 =?us-ascii?Q?Lbn3qWbeE0bWhyhdK+wmr4/G70cj5r6wHISsyaobicV+lzxfDmOwvyxrTEVk?=
 =?us-ascii?Q?RTW6WufJAO/vyPWredB1PQcMGnZJYDWcD0vAPGQX8QxvtYpSiVqzGBhREk1d?=
 =?us-ascii?Q?xK801GR0jbEJAidTtvO0HRad0DYLel+X38/0Rngk766BL+EFAWHSScsAGqQW?=
 =?us-ascii?Q?mmp75L3PrF4JSg9ibZiDPTcP8c31IXx0BDOua0Bcci+qmB/OWkwZUijDwlFR?=
 =?us-ascii?Q?mN+5NJhkFUfbgvNBV5gIfjzyia5jeBWhV/GO0CNlHA5ZK+pvwD4IVNBmiNSL?=
 =?us-ascii?Q?GgclK79KhniWOreeHYNYmqLPT2CIMcz9tjJBlerelWP+wUPZDH8AGeA3uDKu?=
 =?us-ascii?Q?p5tGZuFrt/EluxZrtJmSkIWdcSPJ/EDzLCQemIYhdrPNWpguTruB4fwDQg8A?=
 =?us-ascii?Q?ebWQESOrlwuuCuVARqtG5/TThugRNr30zyBtj6KmpTpHh6X+r2W+Wt3eH5wn?=
 =?us-ascii?Q?o/9WnIocXECaLvAngb+ubDakY81Owjeknnk2qElEtcxwHs4MRmk32K1NQXvr?=
 =?us-ascii?Q?JpCL5IwB7LV7k+yrhQEFaOzqPq/g48m49pkull1u0yhLmLDUMC6JzdTLcJZu?=
 =?us-ascii?Q?719gGYp+JQ4XUmrYRDgBYdm7D2CIDjeN/ryJAWaLH1uOuQiVw1UIMB022RMs?=
 =?us-ascii?Q?CltiMoTYXhBNc5k146qv4ZEbMRMBYVMuBsRAOscXBpsSjCEikyYUKesyZBoY?=
 =?us-ascii?Q?/g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3319089EACC46348838CEE07A8CF4227@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iFqgbDtr6cPk5vvJ6kT5n8FjeTmqw2qDzigNudLhuLoz85gJ4cFT4cStzE+z?=
 =?us-ascii?Q?DA5ikV7MiOyM3Ct3tJ89qTD5dJ3NjI6lRlCSUwOi9/o/FGolb0aXSNZB8VUf?=
 =?us-ascii?Q?VGj+CUwzAEloY3lNizZHKMuseJshehBrmkWPEXGop+bF4/wxZJYLUV2Pic71?=
 =?us-ascii?Q?/QyYk3ExH2ll3C12S1hay5jvrA/duIDDYW7hdV3xiQMO8xQOwGQ1XYeq/DUm?=
 =?us-ascii?Q?1i+Q6ll2KTOP5N/yid4T1ei7LFGwLeL39XUmdgkqxlsngqsYceGn45qWkiob?=
 =?us-ascii?Q?VdqNb83whZmCFd5zEpEvmsUOKqkTt0MOsIcS0kzf9o29m5HOuUeXJcrf2mVo?=
 =?us-ascii?Q?dmrZiE9iMS3Sxrk7o1TXaKLWndA84d7i6ycvCJpo45yNi5/Y3Aoa1A+4D5mi?=
 =?us-ascii?Q?68euEPNIF4NI9kpQYdAiPccoNSezYV/mGxtZi5S+eYN7T9DRpnZfDZbvMv3Z?=
 =?us-ascii?Q?Rw++djgsrNqewKn98v/D8FCUVco4gG4yHtLzwh4yIHhAuctHAivT/H8RGpsN?=
 =?us-ascii?Q?Jf5E5ATe21I8IS+9PWrmo6dVhVSdliM125syx51o6hRjiUlcOlKgwopSsypN?=
 =?us-ascii?Q?MmOed/8LCLYzjBpvhz04hs0eL7KGSFNTTJtYBcn/d7pOGr7AV+Ovjon+KyEw?=
 =?us-ascii?Q?7IicA1yJvb3E+vzE2Ql8zYspeDy+LlTDHap6apGK/0r+u5rK57Z4mESqCGc/?=
 =?us-ascii?Q?9ZGLQ99XC3RZVwZsDQWhaLz4FrXBQQRiUsHA4AdGXhA6yfUJFiup4SJAn6Gz?=
 =?us-ascii?Q?Zapw2ow8H3Wcp5KIAXQ0bDZW7jUnrWHlMvackM89In/xbyIn+umN+em/zPtm?=
 =?us-ascii?Q?+qht3ALZTCYGKKnkTOmbuAayEIrbdHQp6G8UJpwYDilhxS4uxyu9Erb5xhI7?=
 =?us-ascii?Q?5HMDDi5kffNKuO2JC9sJ8E/sfbrum5Rze+d6hKZDkJSCjh4K9aD4C18DER1S?=
 =?us-ascii?Q?axNOsncKb6Xy7jddLQzoAmNpefxtouCYxNGm+7BxSL8=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d9716fc-4117-4c7b-ffa7-08dbafe5d0ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 21:02:59.0074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L8z+e1eMJ5xtzbs+n1muGnynTpQNFEUuQXh2pFmWLpkaAxDQcSJnyXKgGI6jffnXYLxjYU4QBsw1SnpSxXnpiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7774
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 03:43:19PM +0800, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "kernel_BUG_at_drivers/ata/libata-sff.c" on:
>=20
> commit: d3d099d5c2dd38db84abd96df39f9f0828c16b7b ("[PATCH v4] ata: libata=
-eh: Honor all EH scheduling requests")
> url: https://github.com/intel-lab-lkp/linux/commits/linan666-huaweicloud-=
com/ata-libata-eh-Honor-all-EH-scheduling-requests/20230906-164907
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 65d=
6e954e37872fd9afb5ef3fc0481bb3c2f20f4
> patch link: https://lore.kernel.org/all/20230906084212.1016634-1-linan666=
@huaweicloud.com/
> patch subject: [PATCH v4] ata: libata-eh: Honor all EH scheduling request=
s
>=20
> in testcase: boot
>=20
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 1=
6G

Unfortunately the problem reported by the kernel test robot is very real.
I could reproduce without too much effort in QEMU.

The problem is basically that we cannot simply perform a host_eh_scheduled-=
-;
in ata_std_end_eh().

ata_std_end_eh() is called at the end of ata_scsi_port_error_handler(),
so it is called once every time ata_scsi_port_error_handler() is called.

However, ata_scsi_port_error_handler() will be called by SCSI EH each
time SCSI wakes up.

SCSI EH will sleep as long as:
if ((shost->host_failed =3D=3D 0 && shost->host_eh_scheduled =3D=3D 0) ||
                    shost->host_failed !=3D scsi_host_busy(shost)) {
	schedule();
	continue;
}


The methods in libata which we use to trigger EH are:

1) ata_std_sched_eh(), which calls scsi_schedule_eh(), which does
host_eh_scheduled++;

2) ata_qc_schedule_eh(), which will end up in scsi_timeout,
which calls scsi_eh_scmd_add() which does:
host_failed++;


So before this patch, setting host_eh_scheduled =3D 0; in ata_std_end_eh()
makes us say that works because it only negates the EH scheduled by
ata_std_sched_eh().

However, if we do host_eh_scheduled--, then if the EH was triggered by
ata_qc_schedule_eh(), then host_eh_scheduled will decrease < 0,
which will trigger SCSI EH to wake up again :)

We could do something like only decreasing host_eh_scheduled if it is > 0.
The QCs added to EH using ata_qc_schedule_eh() will be handled by
ata_eh_finish(), which will iterate over all QCs owned by EH, and will
either fail or retry each QC. After that scsi_error_handler() has finished
the call to eh_strategy_handler() (ata_scsi_error()) it will unconditionall=
y
set host_failed to 0:
https://github.com/torvalds/linux/blob/v6.5/drivers/scsi/scsi_error.c#L2331=
-L2337

So something like this on top of the patch in $subject:

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 2d5ecd68b7e0..9ab12d7f6d9f 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -952,7 +952,13 @@ EXPORT_SYMBOL_GPL(ata_std_sched_eh);
  */
 void ata_std_end_eh(struct ata_port *ap)
 {
-       ap->scsi_host->host_eh_scheduled--;
+       struct Scsi_Host *host =3D ap->scsi_host;
+       unsigned long flags;
+
+       spin_lock_irqsave(host->host_lock, flags);
+       if (host->host_eh_scheduled > 0)
+               host->host_eh_scheduled--;
+       spin_unlock_irqrestore(host->host_lock, flags);
 }
 EXPORT_SYMBOL(ata_std_end_eh);


With that incremental patch, I can no longer reproduce the crash reported
by the kernel test robot in my QEMU setup.



It might be worth mentioning that the race window for the bug that the patc=
h
in $subject is fixing, should be much smaller after this patch is in:
https://lore.kernel.org/linux-ide/20230907081710.4946-1-Chloe_Chen@asmedia.=
com.tw/

Li Nan, perhaps you could see if you can still reproduce your original
problem with the patch from the ASMedia guys?

However, even with the ASMedia patch, it should still be theoretically
possible to get an error irq after ata_eh_reset() has called ahci_thaw(),
so I suppose that this patch still makes some sense...


Kind regards,
Niklas=
