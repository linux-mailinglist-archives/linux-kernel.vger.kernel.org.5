Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DF97A7D33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjITMHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjITMHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:07:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8753E0;
        Wed, 20 Sep 2023 05:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695211630; x=1726747630;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GU/XebSjV3S3gX1Q4IugMFhSnRpjPLJIAcCEzlYgaWI=;
  b=hA9eR8CzvFpp6IWpjdHAY7+E5jLXsmYWGaMWOjsoHm/aG+JJ/0MiBhz9
   8yVnSUd0yzaO1hF5xfG6Dn9PgqXus1J2VvMnI7aao11qx7QkFEvEewkC3
   ekJeFWjDGK49+VBA9szW+tJ7xIEw1jRtT1YjdxoRLMbzjs5jrMMUiZ33e
   6R8rUEp4RW21QkFyOeis0VKdOdVBBTgNHXZ8SOR+cDZkH+Ngkvv0Ukl0e
   jaEqLSbPuoW9cV48Y8JqKk725iepjffiAdKipsiFh7FvZdKZEV9FaBZWZ
   wWLoiXXtXEJUYuDD2KOTsZlqShAM7IzTAmJzOpCI1/xZ821HmA9KPpU7T
   A==;
X-CSE-ConnectionGUID: toqJibaqTPGyXYM71ZKLqA==
X-CSE-MsgGUID: 18vfN9PiQM6GDoUqA92XNA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="172633664"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 05:07:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 05:07:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 20 Sep 2023 05:07:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jm44oG4Bh+ACOGN731DNMVCbfiduPcJ+adgCFaXUsqEe+jQ0JOmlrkRCGaODa5AD8BG+yE6Rjj+oZ9FetaMMHogtci0vtsn15CugtgNPvlscP+6OjDmibP+3oBexUcZCt6Bsg4di4iaDQV5q+4IYYhjGdV5c3tjtxD0D+/ZiglsczPFSgN+fvwMc4HmNZFgoAtez1qFOcWaYClGCFIe5tYocGbSkpT/mZYj0y+Sge8fBmod3tBfm+VhJJp52BNCVoF/uR4JooPN9eR1ih6neGE41jGAIWgFoIpAYo4uC23OOxpxCnITv7tRw4wdnxjZDNBUyR+mGOsyFpkQgK8Ul5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU/XebSjV3S3gX1Q4IugMFhSnRpjPLJIAcCEzlYgaWI=;
 b=FFyYNqGUnsDFqQkKfZCBTAZCJA8gTDj7niTxAxgng+ZtcBiHSYcxGV1VQi+tOVM3tjeCwU/u9tQRtOoYSWI57PlWG8Ou7juC31ZYPOSsJ8cauXWqvUp+9djQKfYvaZwIds2lXRkyQt3GAf6s7mnfIEYoIhJqLz7V82k3ElGYDJnAqiMpGfRWJ+dQVeEBltv3Z3nGPcBTSdB4l7pK8a1rKM0xSLF5RdWZ73T1AxfDcu2QwrAclpzbSnMgYoKAg48VPqQJ33b0p8NxZSNlhZN4qxGZIp96/vyDMe6s6tXiGHrcZnp4OcYdgQh9Vulyt0EPnPFmAbfTd6EIwzuEsqZfrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU/XebSjV3S3gX1Q4IugMFhSnRpjPLJIAcCEzlYgaWI=;
 b=DkzyzFDE4Eu5UJ+fPdDwjG56dTczvOMxBvkwNbr6NU+Ke2dXHpWOFs6FwgA3TzGKz6E0T7aIwg1qyzmybVS4o645gcHbPZP9N9w0ezq+g3RHQOwPgRXmElpG2r4yamX6zNn3mtk36zBrHCC3t3FOaTpQgB5iljFeukihoRe54UI=
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by DM3PR11MB8682.namprd11.prod.outlook.com (2603:10b6:8:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 12:07:07 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::1133:b6c0:3f07:84bc%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 12:07:07 +0000
From:   <Shravan.Chippa@microchip.com>
To:     <sakari.ailus@iki.fi>
CC:     <paul.j.murphy@intel.com>, <daniele.alessandrelli@intel.com>,
        <mchehab@kernel.org>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] media: i2c: imx334: add support for test pattern
 generator
Thread-Topic: [PATCH v3] media: i2c: imx334: add support for test pattern
 generator
Thread-Index: AQHZ6toVr4ymchptDkKwdXRk/TEGQbAh9RGAgAGq2BA=
Date:   Wed, 20 Sep 2023 12:07:07 +0000
Message-ID: <PH0PR11MB5611FF1F6DAC249C6F2D387D81F9A@PH0PR11MB5611.namprd11.prod.outlook.com>
References: <20230919091740.1821543-1-shravan.chippa@microchip.com>
 <ZQl6E3AGzXi5OvGV@valkosipuli.retiisi.eu>
In-Reply-To: <ZQl6E3AGzXi5OvGV@valkosipuli.retiisi.eu>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5611:EE_|DM3PR11MB8682:EE_
x-ms-office365-filtering-correlation-id: 13785a79-11e0-485b-168e-08dbb9d21c3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oEz9R13gK9yMVF/StRqhre9ipvqXoIx2ktcPGjIgdVvjV4oOyETs6z0+MDusQ6nc0g1S5mnSiF/D8RsquHg0lsh7GV1mZ/SfhABzSSPepvlr9ugpy3vkOXv2tXtKyln0aE3wm8UlRmLhRbF9aBt7F4KMCglBQC3ZrFXP+iT+98KiLts7wu0WY7wPx7CSk2uQoNvyHFM0RwsnlDwLtHM6yWoHSlaWSmyW8JqykJMwx5M3b5uUDI1Pl7RxttqkjWRBxtDYdvF9uAPHZKVmyHYVLLuYJZxla8ixGO5BgLdfpnXXVYZAv6F15dMMtjH3KIo0GB+relkvcwgtMpakpPW0NYbt7E5fzrJY0BZsSYNelk8XgTlQ4x9mXCJUqSmS46PYDc+V0j+iKsHo6AYNZa+WULofFOfbiehcA07ejtGt+w+1eW2zkGw/bwvDZ26brnwBWE7UIEG/UScyWQ8oflfHDKqEau8sjWXEoraFp297ZtPYzuHTSvRUAAA5WilsjmHJTS2yx9zO/QkALQH26BtdtQV2fvPy02RTKb4vf7KoYV3qf0CZhELPu+VRsobSo1kbna1gET5qIJ086oq0GqkcJLNg/qFv8bBxwqtWz8X6+lfZeHXuMKxcfp6jL6dEEqPi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39850400004)(376002)(451199024)(186009)(1800799009)(38070700005)(83380400001)(7696005)(6506007)(53546011)(9686003)(478600001)(4326008)(8676002)(26005)(66476007)(64756008)(66556008)(316002)(6916009)(66446008)(66946007)(54906003)(76116006)(5660300002)(52536014)(8936002)(41300700001)(2906002)(122000001)(71200400001)(38100700002)(86362001)(33656002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bosqY0DdtHYsac5en9tw/B2Xnt0ySkOb5ghWb6C0dZ18Er58LlIzvUJnce/C?=
 =?us-ascii?Q?CJSABB11GIRWmMOoATjP1i473LViCVNnuU6kh1jRpfh1pToPyK+mY309HjAB?=
 =?us-ascii?Q?HuK6W79+yjiLscCSoSAVvSc0xToFWzS75gRZdaoKcFXXkLKjPtiZ7+hn1gRp?=
 =?us-ascii?Q?7Fkr/vKF46soWqqPwiut2OlLpkRDUa2kyu1k6B+z1pQ7nJIr1+E2SU80DXe0?=
 =?us-ascii?Q?6i+NFtn3ggVkDW22LKIH8pexeba88Js5g7rqOUBK7knMgxyhfk5NrCdEg6dk?=
 =?us-ascii?Q?xok4FeGqROoyQaIvYYnANgUJE8S7LlutzOXbZV2/LJJo3NP+ERA12/I0iw5f?=
 =?us-ascii?Q?z+WB5VptEiCwZeXfAvjTgHGCLe5QZpkYDRHYk3A1U7hXfELMFXSUVft/Vc/o?=
 =?us-ascii?Q?MW90c6WP167yIa9yAM95/XWqVuNlWcs4xHxDGMpPwYMZ07pFhwUJU+Hg/doG?=
 =?us-ascii?Q?GjtBYSaDDeOAfcem1aAY5vtykOfeYeuruy8tugm1SUZ/F2/PxrGrVS3oXX6T?=
 =?us-ascii?Q?jHaUqwSiOHvcX9Z1gfz7bGQgSVQOWSLBmPm1oYLbQNlD4beW7pMVh5exHm5g?=
 =?us-ascii?Q?1UyoUzup5/dAUPBbT8AlNXe1/48p6ptn8/WCK0v+GGHk3RUdXLPssBceXyEb?=
 =?us-ascii?Q?sEHR3qIFL+sKqkurPf4ONh/cRsbStsimvdqqJVQXr7/ERVT91Ote7KAZXN49?=
 =?us-ascii?Q?4c3KFS5B6L2mnqBezeDdMEjHkB5f7eeF10GD8KWrwBs0OcL9JdqlH1ki+wkN?=
 =?us-ascii?Q?JitvCyjucTS8OtXY7Fb/rrfCZorMt6HCbNHIBejgypILQZROnhR8EtjtP+3B?=
 =?us-ascii?Q?FVSAAbHxOKfKRPquMzCg1CE91IvovHkPt89Ed1QroGNdVc+D4IPNpJUKFAj4?=
 =?us-ascii?Q?02FTbGQ6S9gs7T5pt2lsxr1H4DfQebf+n4ZNpzhwtym0lbp4cmE3JF1bgFy5?=
 =?us-ascii?Q?5qxp+OBcfxYrsGZyOZf14jCLJReUz3bbnxSe97sBC619R6vcUKsnmqku5hlk?=
 =?us-ascii?Q?b/6rcoOS6u8aBw+gV+VppXyz0tqIBT9TaL+S3krLnRdRF9GdlvHVlfExamD+?=
 =?us-ascii?Q?OTho1YgIB6BL/4hY+1rjN3QmPHLID5TvGiVMAs8D4CrcSyeMDq990DvQ/0uA?=
 =?us-ascii?Q?uJPmX0ineREDFcAyfsx9QyTbpQN2o8pKe/zbtgnJcPLgOFXZiL2elZxXqwNe?=
 =?us-ascii?Q?7f5MDqGudKYl07X68jqChV49pbJZIa3dKL05X089Fb/N9RC6HCMoT2RDyUVm?=
 =?us-ascii?Q?zvDsXvvutrtDKSLWEL17b8xHdz54t0WF0KdyePeGFWA7ArzzErudRvr3ZG4e?=
 =?us-ascii?Q?N9xIvsGZhQZlPp0q5hxDzi/B245dxSssT/460CBpqpFNKEW4E/cNd7YdoLqD?=
 =?us-ascii?Q?m/CPKreFDtvr900qujUR/8k6s8JQ/Co27Baw/zSETnNThJDt1wIx4W/p5j3D?=
 =?us-ascii?Q?SyXGu1IjkGZgiX83+HRFlpK1fJ692YTIumIS5yNolXqXVym4mzEhdKmGu2Wv?=
 =?us-ascii?Q?Q1weoXi25Oif4t4WEAcrgefr8WvT1QnPj7bjURmarFsd1Ig/0PhZD7avWIeI?=
 =?us-ascii?Q?cSymhdslpde0gprExLuDiVp7U6EI30sjfiTXojwNZBSfv4dbFL0lKhOWiNkz?=
 =?us-ascii?Q?LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13785a79-11e0-485b-168e-08dbb9d21c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 12:07:07.0752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uBVU+YScEiUgchb91tnQaNyEa85iqCE/GCwFzjT51GIETnjTfugehQlFkCEVCaxeavafDM79cTQoFjT4HaiEtcTdPkWleyLp5gl2z/U9vDs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8682
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,


> -----Original Message-----
> From: Sakari Ailus <sakari.ailus@iki.fi>
> Sent: Tuesday, September 19, 2023 4:08 PM
> To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> Cc: paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> mchehab@kernel.org; linux-media@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3] media: i2c: imx334: add support for test pattern
> generator
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Hi Shravan,
>=20
> On Tue, Sep 19, 2023 at 02:47:40PM +0530, shravan kumar wrote:
> > From: Shravan Chippa <shravan.chippa@microchip.com>
> >
> > Add support for the imx334's test pattern generator.
> > By default the test pattern generator is disabled, so add support for
> > enabling and disabling horizontal and vertical colour bars.
> >
> > Acked-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > ---
> >
> > V2 -> V3
> > Added "Acked-by: Daniele Alessandrelli"
>=20
> There's no need to send a new version if you're only adding acks.

Noted.

>=20
> So there are no changes from v2?

No code changes from V2 -> V3=20

>=20
> --
> Regards,
>=20
> Sakari Ailus
