Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF5778753
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjHKGQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjHKGQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:16:51 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C8C2D48;
        Thu, 10 Aug 2023 23:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691734610; x=1723270610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ERNPlsgfgGtZy8J6k1TTYBU6tJG2uxNCXJCF76nkeYI=;
  b=ULMMH07i996rTL+91jwNm3wcJ8dBVfeAo/TZ+CEYOCns1lRyWCY6UR7Z
   +ll1ZHm9Cw1GIMySQpZUJA7XgeMhZtQhVAy06KnJahviSRe2ge+C8RAJH
   GxK9pcR/syuNmNHhEZ7Rm21qk97hBhNc/GuwS3mPULu6npvRpbtyoxvcL
   fjoCBahl92qs0gjvHs2dyJ1wJmFgnEggQvOBgWPLpNy9Ps53fS/Szzv+1
   S5ct9efXDikYwu2U8FpNquz8iegWAJeltN0u250iLDBaQ1m3fsr6darRP
   h8PUux4p8rkBBpYfSiCFkoaVtJ2oJFv8NLGOBruOODx6WfwwaT8cX20XN
   w==;
X-IronPort-AV: E=Sophos;i="6.01,164,1684771200"; 
   d="scan'208";a="239020148"
Received: from mail-mw2nam04lp2174.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.174])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2023 14:16:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSKuXyzBtEcr0kPywW9zDs+2IFACkGc9Uu8PG/GwitUoyTTdQQ20RiSjxLMWON1KZXJsR9uzOIiow455qNKL1cfo7PZk067QXSrEaEclpI+AHufLhtgi5YNmQuwqOfVmt1ywKyUFMbx7hEII5nSXPgSiBisXKktmNLmU2I1qn2GAqFxQhBlZRBHq8lIsXDPsKV2Bc2mYrmev8qEFhS8lTj/gTbWkUEveMMX/7bpWu6hYeic8CN3hnHxB6Qg+G2nTgeuC7RawN6lIJyciSjYVLAx2bQ3P+ylx5uur1cp8oc8te93TepS/NTWbo2GybFITZxefylTFHU6nxwfiPfhbow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6l84u9gscBa/54pBDgiHnXJOfQjU4DKsQOWleYZ2Y+o=;
 b=dFZgX+R6O7GJb7pDmBnAe1dZiX6lOOqqf0XOjEZjxgIhZ/fN+K624lmCayoB6FYZy8qf7Kith3oneP/CA8EnP+VM/JMVk/tZlKh78Iby0qfOG56uq+p1Bk6TkixZZS9ZY/VDVgSO46eKgXWkxdpr+xLgiW5NG8GCqGfRjxWOyPYaK7KrbfwWSvoe05xiEnjHcup6Q5YFZrDMjQuCsiAVK13md7TABBD+NKCdeTnRlc3O/R393bdKRiTsamkKe5yGj50VHI7YxdmV7DqsqCub8iMr/itX/3u1EZfwkeLInzne7mfSfeOHX+1ntNXvzPabj8js9KOvMx6gVpyjVV1kNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6l84u9gscBa/54pBDgiHnXJOfQjU4DKsQOWleYZ2Y+o=;
 b=ToVCNcwpHrLLzMircGn5ycFnDH6yO4YLMlTRct95ZbYSJhKyNKl6XhYcv2xvQlwSrpypT9Ice3X4+WAed1ryKhjDjT/woyDScqp/pso4Q4Y1NQu+eP34rVTmq010x6vTmwe9Znv9p5UaRNtyAKYV2Qc0XT0gWRBlEs5fDV0x/ig=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN0PR04MB8174.namprd04.prod.outlook.com (2603:10b6:408:15d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Fri, 11 Aug
 2023 06:16:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 06:16:46 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 00/12] Switch to allowed_host
Thread-Topic: [PATCH blktests v2 00/12] Switch to allowed_host
Thread-Index: AQHZy3uxzZvUupgtrkSugC1ZrGM0Tq/kn9aA
Date:   Fri, 11 Aug 2023 06:16:45 +0000
Message-ID: <xpoocad2nthor6naxp35h5qiz3oqxpijp5qds5qao6aguh6fp5@6fyygawm7kfq>
References: <20230810111317.25273-1-dwagner@suse.de>
In-Reply-To: <20230810111317.25273-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN0PR04MB8174:EE_
x-ms-office365-filtering-correlation-id: 5a6563fc-48d7-4cad-206b-08db9a328a2f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qoc/VMPs5Qer1pxj03w5DRgsW9ldY818sE/OOAcYNtwaKY6mtoL4IjMsNqCTeffgjJgGrM1mB9EkOMz5or0yBFIshFC2pro2hH8wKRhHYDG1kQyfBeDSD+PXZ48KxkHRVSULxhX5fWP2PsdBEntu0SksCgfxX67SgznD9uQ2DCEo+GNot54GsD9qCtnVE1YFLIO8/VmHAeGotK9/uxlKlGdxPdZdu+55bTSyYzqnwM7CzyBKkcXK976+bEtpSGNSQF2MyV1ZHC3rx+4ft/4CJoUGxhXvTHc3SWFVO0n1K+KcLGVkvBO9brGi34jefNAsHl8UHybtbXZy9yMoTT1kt4WN0CG2GOUsoEeZEWEB0JLl1RvpJl3craQgzN4EztaPsFspe09JFMB2YNAM28F6Ob7GaZAAKz40YSXr2OOJ89vYnnSi6d6IuVp0Q2n47kkwveGcwcH/baxcwkd1J0A102VHIcDk8dvZ5PlMMgaTSn8MrA38MGDvujXeSDLutDud8sQFwTROLMO//ds0nFTZzMNrPQVK23qvVX6ST6LJwfrytkUMPH6gWsSRPAGAfL3uH3VTKey0fpflVA9taujd0C+/cx3cf355XiTuxy7U9wwO5isvjZpXi6dH4gkj5EFn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(396003)(39860400002)(346002)(376002)(1800799006)(186006)(451199021)(9686003)(6512007)(86362001)(38070700005)(122000001)(82960400001)(38100700002)(6506007)(26005)(83380400001)(478600001)(54906003)(71200400001)(6486002)(91956017)(4326008)(6916009)(316002)(41300700001)(8936002)(8676002)(76116006)(44832011)(2906002)(7416002)(33716001)(64756008)(66946007)(66556008)(66476007)(66446008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pxU7St96i2G+U0HDKrFLfbgm+EvksRFRaHcizMoMO6Cn3QHtFji8Jbk/c0XL?=
 =?us-ascii?Q?UVz07SjLIUAd4UlzXLIDxQ8bHxLi1UqzdXuLN+xmtymFwjUUSAj5PWlKAfUv?=
 =?us-ascii?Q?bj2RaXzs77oqM2UvWD/9D02UGyuuzin3rEPEoQ61J7JNp2rCRI5x9MYxmBJH?=
 =?us-ascii?Q?d3r0oybJwjwNLGiU4LvVmfohsjTO7qmusgyid3dbv/j6WIVgHzm7+y/OHpdC?=
 =?us-ascii?Q?qskdWzLmZJruCmV/E66Lf01sQSYp6kdJjKqpPTarQLAQ2yRa6ZEbwUPCdzC1?=
 =?us-ascii?Q?8BD/+NvyMEJUmIjSC/X3qXAvPdwkNcPIQFG5r/FDXfKscgT5VveJwNNl7hlt?=
 =?us-ascii?Q?UNS3ZPStN+qN/+9M6fgTWAUNSk0VCqgci/Sws1gfSIYtXc5FdWmx0UALjJZL?=
 =?us-ascii?Q?utySy2VnhXrl6j3cSJiH0DWfc+Rus6yGAvSUTD9RO3I3lFY24GOJnJe13Zab?=
 =?us-ascii?Q?53u0V36Zs217Pgrwy5Fr71yx09i8QU5jxvqJBjmEYhreiVXIr2Hs4u+LDSU7?=
 =?us-ascii?Q?Ixe2frTZyk349tQ560cBgIeQnExCccdRhN6kTXnxtgS8GKL+clLddrAlJfkT?=
 =?us-ascii?Q?j/jgYrYblGU5Q1d9mQmkpX1IBgs/l8qaKgYItF4afnuhcFz75nG/fDunlVhn?=
 =?us-ascii?Q?HkK3UduARsfdmGP1ajHejq4ShYxtwa/gVJZ4NsVhRwcqeB5RPbPR6aKs/1pu?=
 =?us-ascii?Q?a0kVDSNRQT+V1sfGpMpAaOYCEisCetH/EVNBZEvZLRn1+uU4OJAo0KvfvBzj?=
 =?us-ascii?Q?Q3rdcKA2X7VzxzzaGtibvDhTom83StkwFe1SItuUbF5sCWKoShXYkL9woeNj?=
 =?us-ascii?Q?/tln8bGebjIkDt/TDT83KXdy+daFwK00XjL5zi4kJw99J+9cwv9AMKgI6d//?=
 =?us-ascii?Q?BPEcewaj+OmgCsV0zlCFLPGWdYWmeEhRIbRsjBris4Eg8KpKcaZ1V1HjdUG0?=
 =?us-ascii?Q?5VMP6F075CAKlu1qTAO19kM49ZYw9FfnIgHluO2frQX4tZ6yWJZSjhh5toGe?=
 =?us-ascii?Q?PDvJVP+4EFqRUB+vpbND7DYZ6Er1nOgNr3TGZ2J4R6EVq4HvGEc/0lc0JUHs?=
 =?us-ascii?Q?nndXsW2lOxOJBN7rZ1xe8YvX2WDlez1ZdyvCgyjT8b8f/suqox1MsrLMwoX7?=
 =?us-ascii?Q?prLz8jjc9MJA+hScyF0tKwDlphxdOekasPV92kg/3IG5fdJYCRFTv6Vr+1nF?=
 =?us-ascii?Q?4mff9bRGoYk258s1bOa2HwkKqJUHqO+Stck/rPdY7LKm+VMtn292pyWc71rT?=
 =?us-ascii?Q?uEersr776TaHA7bZT2IGTD7Z6ybJ7KpLT7/MX0lrZ591fQ8ZmphO4IUCfkjX?=
 =?us-ascii?Q?13u7/urC2RQaKwYaJf8pfbKEEjF2he6XhotELcwrH6u/e9qjcLNDhUsBojjO?=
 =?us-ascii?Q?z3sNWmR6hu5nDKdz4w0d0LUQ0QVfA2yIE5+cl/s+/I0sDiW0lxjudEIZqixE?=
 =?us-ascii?Q?XGzVe0Zbn43bfOAyVSC7zg0NmIpyWr+0dAN6Hsh1PMRPXtNc35IDIOkv1XnY?=
 =?us-ascii?Q?r7NvpMiyqZiy8hfE20pN/zk9elOEygpI9eDaEnmuXIO9X6lokwpLoOt8698m?=
 =?us-ascii?Q?89o5EGBZmXyM+SecQ7wdrpvkT7K8LB/rR3pK9PMSA05IP5gAqSYgO3exCm1r?=
 =?us-ascii?Q?PLrkbO4uaJKiSektoUSv3Pg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EEC309B587B8945A01F894BB57860DD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?28byDAZZUh9/6qg6ZqKvw5fJwxGVVfHYeW59Asc0ALKolZjb2Iybe/oC9i1i?=
 =?us-ascii?Q?XxOZPPbEMoMYJEin7VMw7DfcV/yYQ8nnhw3VF6uExsdy5Xm9t+5jWRWLcgRB?=
 =?us-ascii?Q?JWBgb8rYwfx0jX0odY71ILcTbtyek+O7+C1C5P26DOnr/GzQiGv/kwfxCX9a?=
 =?us-ascii?Q?5vyCrSawh1voXDNN2Dap8PG67Vnqr7RE/2p+RAgPjYhKMHhY7IEDLbXIGQ7f?=
 =?us-ascii?Q?m/7fJR05xySjqDrStvMqZOmwOJRcDJmSVuUJdSvCGsHzcHc/a/rinHcCo3o/?=
 =?us-ascii?Q?mzQWmjwF0shZ0uXU7Slc9WUvmhoZ51qY1mhp2eeBEmXlib8r8qB8HA9pu8c2?=
 =?us-ascii?Q?h+VYGh82yfn8WbxHtMktgMYQA5vLjws1HOlIUuXe8wq1Gz3RE3r75sLXsJZg?=
 =?us-ascii?Q?WH8hJDpEntB0EyfdvNS9QKaqYMVRWREVhYlzqj7ckByJ/NqEl5xsuw4nhhla?=
 =?us-ascii?Q?tPCY1zsgSXLvPV9B4a8c8pHM/e8ohb+0MQlkRaCFHYItkCLaWcDwjZPqroue?=
 =?us-ascii?Q?uGj67mzg4PMG0kpSSKEbDhdUMsIrvKG9nKJm+kzwQCEPaSZ0th/zvW6HQ1JS?=
 =?us-ascii?Q?efqme2cthLOoazMeSdYsfrelHiDJZMptqzQVmMpLpDnsJJkcheVMfM1JdBAJ?=
 =?us-ascii?Q?55nplZzsxigeC+ffCEScntnQ6tf+U2/gs4n66a4//D+WYDFCVkUbTuciw8Mr?=
 =?us-ascii?Q?g7OcDuqZP5BtQ8Y/4r07s9aN4F4smgp6Wvyr4Qchb+e9Almuk5EUxwchRS0v?=
 =?us-ascii?Q?jBNc1oGHLMXbYm5zA9R4NfXpsi1qi8i89DRCW2yUxGN28NUvpcb+PyMohc6c?=
 =?us-ascii?Q?C0aocpz0/HBM6VqC/oLaMppll2eY7QwmTEn7HYyeO+BW/KG9tU15DCaTQ4cU?=
 =?us-ascii?Q?KMje3x51COcgFez8TCdpF0Laqml4XGNoMn+GNJaNt2ROhwbvZqGF+wIR+Tnz?=
 =?us-ascii?Q?PWI5m1T2eCXQRlz8Cu5sLQ=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6563fc-48d7-4cad-206b-08db9a328a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 06:16:46.0048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X4xD558YBwpis561y4SJrWKwg2Yl2hD3Ue3EF8ABi1LsV8lpTKq4OhTn2+ZLxYbF5Nosm0I2mjAkcH63epoPRtOoOgRpxAS6ll3QRGBkosw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 10, 2023 / 13:13, Daniel Wagner wrote:
> I've updated the series accoring the feedback. Also added the mentioned
> _nvmet_target_{setup|cleanup} helpers which reduced a lot of code.
> Roughly 350 lines code less after the refactoring.
>=20
> Maybe it's possible to refactor even more, e.g. this snippet
>=20
>=20
> 	local nvmedev
> 	nvmedev=3D$(_find_nvme_dev "${def_subsysnqn}")
> 	cat "/sys/block/${nvmedev}n1/uuid"
> 	cat "/sys/block/${nvmedev}n1/wwid"
>=20
> could be moved into _nvme_connect_subsys(). Though there are quiet a few =
tests
> which want the nvmedev later on for something like
>=20
> 	_run_fio_verify_io --size=3D"${nvme_img_size}" \
> 		--filename=3D"/dev/${nvmedev}n1"
>=20
> So we could return the nvmedev from _nvme_connect_subsys() but I don't kn=
ow if
> this a good idea.

IMO, it is a good idea to make _nvme_connect_subsys() return the device. Th=
e
similar function _nvmet_passthru_target_connect() does that, so it is anoth=
er
small goodness to have consistency between the two.

> FWIW, it would also fix the current problem we face with
> nvme/047 which seems to lack the second _find_nvme_dev() call.

I posted the fix patch for the nvme/047 problem reflecting your comments. I=
 hope
that fix settled before further refactoring.

It is a fun to see the much of the boiler plates go away with the series :)
Thanks. I provided two minor comments on the 5th patch and 10th patch. Othe=
r
than that, this series looks good to me. Also I did another trial run, and
saw no regression. Good.
