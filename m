Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42BE7A42EC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240014AbjIRHiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbjIRHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:37:50 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7ABCF4;
        Mon, 18 Sep 2023 00:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695022495; x=1726558495;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PZxWt5m6k/mTkrGKk32Ftls6yBi4/8hcZHg4r6zq7fI=;
  b=JxxIFuhM+XGOI1jbkE8U+4FGbk+GNqWE0yf+ejCMpKfVWp7/i1Fnhms9
   ycAFrY0s4Z2RF0znbOxg3URWXvcXo3mh0uMqf+OaQDT0zAO2Dryqsh7IH
   13wQKzTSUKlqG/rfpnBW8mUJ9slWb3ZDxS0j+QSkKTuURvdboChReLMsx
   DPf01x9LlzFe239qb4dVZJSx9kx9fMEzwk4UPZYgN3OiTySk8aLxaPUeR
   TB4yeOz3c/vuKrQavBgLP8i49cxwoZ7dCnvckN51StYhq3C4E1as7dX7h
   NwJTeTgb5w0gL498HzPWbFoidoVHpjL71QvDIVtoErHP557j5NPr1tyUG
   Q==;
X-CSE-ConnectionGUID: /6Q7CdytQmOWesHzf7K7NQ==
X-CSE-MsgGUID: AHIR+pSfSIGHr8PgaK4QrQ==
X-IronPort-AV: E=Sophos;i="6.02,156,1688400000"; 
   d="scan'208";a="242422850"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2023 15:34:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPQ4LCK5rB7EujEj8fJushfkpXRkvQqLdaHrZkEbnDl/d9NkQWtkKavmsGHgeCjUjgOKuvPmAr2xI1t2Y8/hOiEjvG4OViOdZF4wMfqTJmjvX0Q0pcX/Sq745Un70honQroIuk1+B8VMwqMWzYJQGaf69w4s0gl2wxf+OVjlFpYd5H96OCXK7GobPlkIPR/7LUbaT0bEQxQM999thSaX7/8HmkdUJwMgI2MaZFPBKKGYEzTuzN7Kpofe3cRt/EH1cJLG+s8grNZ+v/ukfkpPuxfUrMvemSPfZlv7r51BAiBP8h4/ZDb9iXZdxTiws4lYFxzrpJBZ4GHoFVffHLQZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZxWt5m6k/mTkrGKk32Ftls6yBi4/8hcZHg4r6zq7fI=;
 b=fIRtZf/ntLkc00Xbs8M/fQHqn3yX7vjbkRI0qV1TmYvqxrJ+yLLxTrJLV+SgoMB3loURLxRjCG4Dew78L84nZKQ81eQEHgn7ppKl1PkYYuyAouGZY3mfO6fHuZelJUDsCjQOe3r3jg7D+y4c0eyMkUvl1fd0x5EmcuRcHCkhQ6v5W6F2PXYmi5QglKNEGGG/FaPgNgH77mqgNP9QFBqMfgwN/mrT+Ain5BLRIV4SrLjcHJ/f5vRZDsWm/hBdngJMny3JgYylAiKfNRxwSLWniMVvtGeSZJ0KtK8z2fk/cMtwMKr2EE3inLzudqLW9JKxAfrBXKqrn05j7/RjCWERHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZxWt5m6k/mTkrGKk32Ftls6yBi4/8hcZHg4r6zq7fI=;
 b=cBlIk3kmwTkav20Crs92SthHkDEaMm8Lp5uEeAtx5/ei2fQjyRmzFAiFH/zFPlX5CMSdG2uutT94sIJfFNtlDKORxOh8ZLf+uDWDQtEGJh23IvKQT6K7mNJYFmEaRGZjYgEEb2k2qLyCZu3HgXsBCNtchZEphzHoyusxv9SB23s=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by CH2PR04MB6872.namprd04.prod.outlook.com (2603:10b6:610:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Mon, 18 Sep
 2023 07:34:51 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::dc1b:888b:342:3b75]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::dc1b:888b:342:3b75%6]) with mapi id 15.20.6813.013; Mon, 18 Sep 2023
 07:34:51 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Song Liu <song@kernel.org>, Timo Gurr <timo.gurr@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux IDE and libata <linux-ide@vger.kernel.org>,
        Linux RAID <linux-raid@vger.kernel.org>
Subject: Re: Fwd: Marvell RAID Controller issues since 6.5.x
Thread-Topic: Fwd: Marvell RAID Controller issues since 6.5.x
Thread-Index: AQHZ6gKbG/jznQ51z0m6I88wj8s10A==
Date:   Mon, 18 Sep 2023 07:34:50 +0000
Message-ID: <ZQf9mh3v5qfN5Tm0@x1-carbon>
References: <224f10a4-7a6a-48bb-88be-491faf8ecff7@gmail.com>
In-Reply-To: <224f10a4-7a6a-48bb-88be-491faf8ecff7@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|CH2PR04MB6872:EE_
x-ms-office365-filtering-correlation-id: da33f6a9-3793-469a-f9ec-08dbb819be5d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f2UgcLW7Rf0jRERhBxz5xv3BOwVg+geaQXATr1Bn9s8A9ZDnzmNweTktUFi5E2SvsR4+jxpGknmLNEQ/zspe/0zptM+lrpJoDk7POq88NmbhiVTOkCAmSo2LLZsSPGsHXSojN8z1FogbkJhNPqWwScSOMI5zR9q0ZOcC4L0vTLoFub+98op19PVRuAlVLoHTfmEh0CoqQBDJkDqrCs9slhc4w3FgkNDO596jnTycxkzKxV+sgBi7s6DB0DBkaG/k5RiKmNupKb/kE4si+WhaL7gZHP9a4mcDEKo57Hwfr7NgRPiz5i4vZYTCeZwBv8jqmtClkc8ksrNxwCEVw7SiUq6H5wWhoGyOcA+NDAyM+p5yXbunFxMZ2ljruMm22Pa0qfgxx7/EtSLz1YMliKCQuKHaqmfuSI636nROERNVBhZA7r4rrN4f9hOuCActQCFomnzVdUwRrdgm8SumGa988fIETIJXHQm7u2iLoDplbZCHZ2Ddngm5KBMEDczZQT97X5EQ4tZ5lpH0wpfUMmWxpjOmv6rm9F4iivPWrtkOl8K/YSyo2iLn/BIq8SeDBU+Aj349pb8eHEEncjhFxT2ZrskuARvAqGY7CW1aUGIKgkY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199024)(186009)(1800799009)(64756008)(6506007)(54906003)(6486002)(66946007)(66556008)(66476007)(66446008)(38070700005)(316002)(38100700002)(6916009)(82960400001)(83380400001)(91956017)(76116006)(86362001)(33716001)(6512007)(9686003)(966005)(478600001)(26005)(2906002)(71200400001)(4326008)(8936002)(8676002)(7416002)(4744005)(122000001)(5660300002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eedtoHlQV0l+A80Xq/luziFyRocOTduwAX7KzBVH6nkx4jPAWZ7+5WZrk9x7?=
 =?us-ascii?Q?Tha53FJVMtS+193/TcQzcNhlJfN4zazjv0kuqj1JaPbuf4amBFEI5IHoL1rL?=
 =?us-ascii?Q?3KCebn8JDnXdum4eAO1Xn0eDLS9DptUl6FioU1WvmEHUFCFeY6pdMWvc9ank?=
 =?us-ascii?Q?syzbTcjGWGc/1yhoJts8YZKlS9vyBMH28g7hJrPKTLWNs0UYRMT/TxsbdUSv?=
 =?us-ascii?Q?zE5jVDQH3bPmvUwTHGiN1mtAknd6WxesmHfduhgSX8CCwMbgQhahfJY7UGqO?=
 =?us-ascii?Q?tdJ+nTa07RcZI46IL4a2Ek8VqDpuxR1cSWUY6BidsYmafSVyJ2IC3FP9FSkB?=
 =?us-ascii?Q?pMYJdrxrXZbVq64EMpkNwOCHFqbzdFJN57v5WjlS8CS817jYegN8oA4+kJQh?=
 =?us-ascii?Q?Jz+qMpxY3MGfNuPd1t3ccLgGY5kQvD43wpI7vw8i3c/MkVPjJhqPnShXzuWf?=
 =?us-ascii?Q?pB0d9CfhqjaPSo55/fLjFp9C1q3Ts5JL+a2h/NejRjs4jVols3EFCshjW1Ai?=
 =?us-ascii?Q?PGKI9zpjjQipHtXcXQDQagiEVDZaiLb9E5TskXJH4OEk3rGwdfFHRkJN46d4?=
 =?us-ascii?Q?gzT+OHhysHRinPqDKAQ6D9eB7hH4Y2FV1FpPyXj1bSBottc7UmnvKDAipXmK?=
 =?us-ascii?Q?RqGRmCpBLQXGzCewBf0SgInw47QzOlEViri6SjwFQKNQhLbDmXbvcPhvcEr6?=
 =?us-ascii?Q?gNl2uSXZKNVDEHOELk+XVl1vwgOm8zPSS/ZsoN7pnNyWIXHWuzyGRmHzC+I5?=
 =?us-ascii?Q?6UU45vB+VQcJZaJr83W4+Nmu8w7eBfMTMcoVI7HtiGWr+oiEPlkkDkGl52TM?=
 =?us-ascii?Q?mlrUuT0aU5nj4QqureD158iDPNDbPYBNARcyyA43ZGR9u5yVqkpc7FkL36nr?=
 =?us-ascii?Q?m8TL63zF1LPNFiAQkzJJCf9+SwmR+jimP8d+xuaFohKTDIgC3M3TXWVYgMNU?=
 =?us-ascii?Q?+XoJnVi8lHl3kwZI2bgK4Qy+wf1FYa9G3oHT3tHwqrtEIpQMmblw5xHRzfSo?=
 =?us-ascii?Q?uWzurWz9PvIHHjnwUrGSYli1dGvOSgK3XeRaTTRSCKrB1aZjfwaPMfbCKv1r?=
 =?us-ascii?Q?Heh4ELHFM0HjPx5NwoH9d2gunc0lP+cquCVN6JJZ7ULrR1AmS6Wg4oeXFPym?=
 =?us-ascii?Q?R3yABKeniruuvNCneEvYNvor8sgxBdFdkqZcbSWplzhjp+/1cTegR+CgLPSl?=
 =?us-ascii?Q?WLX5i+vjVZ5/Qz8g1B9AhEIJAPcscEIQMKUkgCvWOXjghv02+VIGcaPPjd46?=
 =?us-ascii?Q?np4rgC0qYWAzVdpzur/FgsN88txWg7ZND0rlOlYuhLMYvy6qacegiKZO9BsZ?=
 =?us-ascii?Q?bVhkS23SQPw9BeTP0+k/XOAzmBSU1CnvS9LKTN3OKUkm+zXRJuMuObZPZWMc?=
 =?us-ascii?Q?tGmHnDUhnqjXQIdIkxXlB8pitWx9ylMOhN13wlcWH021H8FscO8Jk2v7l0dN?=
 =?us-ascii?Q?pwCczhC79fF9bSybCdfHSGTvhwd7RlOlcVZ4Kln7rmtDfQfcm1l2gvWmIcY4?=
 =?us-ascii?Q?UiSM7VKvxcXqdgI6n8eBpCfHpqI0FTotbIEHXoKsnP0YTmkDOvxYzJlu7gvF?=
 =?us-ascii?Q?P7aKlH7Q0fxxhCWCUg1WMr7nSjo4FanvlJjwCqM1CwwHOHs/Z8kCfOZErWGY?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1539F7F2F13DDA469EFD154DD1D494BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3UVpH1Z0nwuGcEC81AyiuTsRS4Ao+lG4Dr/Tf9FOH9aYDH4yeLK5Huc+cEnh?=
 =?us-ascii?Q?xW/39uy4mc6Q+APhsnONT4FWHm9n8RnFyJ9TQAuB8r+oJQffLXtzrmgefJ8D?=
 =?us-ascii?Q?St7CzQ4gxjQrdamOQM5BCPqivRZEiq99mmARBIc4ruEaPkxLy2La3QU9QV1V?=
 =?us-ascii?Q?I+zcZUgXACx2yvtA/t3EZHqqyU6NIbn1cuVUmBKIEw52+f5rGo3dkHik3TBB?=
 =?us-ascii?Q?6jjnbmUbF5T7om2IelyEbunEsS+e4x7LZZaIBHcMKAgu+JoWT/tarlJHNYOF?=
 =?us-ascii?Q?W4DMmoIC/8Bui/zmenH5yJ//EtkwOV7BTiIS/nBdRgHC2Tfh4n8vukWUKc98?=
 =?us-ascii?Q?CAgwVSygsTf7+Cryhl1isRhiPzAXIPhYg6iOGCJLelYWTrHho4ZfayaY149p?=
 =?us-ascii?Q?OA27v3fw+5vxEw6Y99x+xptfFJKAxDt8zwdHax9686rgadQtrTQ1c0Pad1En?=
 =?us-ascii?Q?51of//mLtDSju0oMBjxOK4b3q0r+FKJjHIvdkQpF2n4iLQ1oV58nU4CG8p4C?=
 =?us-ascii?Q?KbTI6jgGvEfxScKsVwVeqilwBiFPf2HT+PYeDHeN7Ly+CB00oIalQw6GuS1f?=
 =?us-ascii?Q?JaeLfwP3Sv1WzrbuwvGLEJaF4MsEvquH9RYiGKfSpJqCzg/rXW3NouVp+hj4?=
 =?us-ascii?Q?03Jzzl6h3Nn/YQcOcqoe0sqVEDtwem1I+QypsCH+c3qgErFBWUDEzwr3PkaS?=
 =?us-ascii?Q?NUqPevan5767mmRg1lpufanB4u+g8IVulKKZV6c5c55W3Lt9RWh9yiFutP5D?=
 =?us-ascii?Q?6qq2/Out0kJp9mG1JNlNT5Z8RaNLUGFZRp9KYsfDi35cp3ffUYbegZqQgWkr?=
 =?us-ascii?Q?TdCyVMpymBms8q3R/8MdktR1j9BrpbKHlwxA6yZZQ02HHCEqgX9b4MR1EvEf?=
 =?us-ascii?Q?PURWXnpiIEt4XeYh742HaOhj8S89PawQjvVFCi5L4IbcIbSw32D4Ke/sCcHS?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da33f6a9-3793-469a-f9ec-08dbb819be5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 07:34:51.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIPisiGDpLMupcBtqKA3HYrmOs2CdPNEqbKyn40htstGmw1oizUVlnH3HSRNmKM+Xc5W5vAUxJ5VMcC7fNdgew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6872
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 07:18:28AM +0700, Bagas Sanjaya wrote:
> Hi,
>=20
> I notice a regression report on Bugzilla [1]. Quoting from it:
>=20
> Anyway, I'm adding this regression to be tracked by regzbot:
>=20
> #regzbot introduced: v6.4..v6.5 https://bugzilla.kernel.org/show_bug.cgi?=
id=3D217920
> #regzbot title: UDMA configured spam on Marvell RAID controller
>=20
> Thanks.
>=20
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D217920

Hello Bagas,

This is a duplicate of:
https://bugzilla.kernel.org/show_bug.cgi?id=3D217902

Problem is solved by:
https://lore.kernel.org/linux-scsi/20230915022034.678121-1-dlemoal@kernel.o=
rg/


Kind regards,
Niklas=
