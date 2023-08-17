Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F6B77F406
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349895AbjHQKDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349867AbjHQKDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:03:13 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB60E210D;
        Thu, 17 Aug 2023 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692266589; x=1723802589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Xyle4h2uJB8UK0YYRBhzXE5X2Q9WfJWTQ58x2eKEgVQ=;
  b=UmF2qUD8eZZhlUKiYi1awO79/k4ydYoXtgtEQOLnZSWPUleINngp4EQL
   L/zP8j1Ojy3RPmD/gRuAKg5Dup/35NxcG0BGBVSvmGnRAzwnjtHquah9v
   RCMUVPZwVi80MmoozNN3dZP9xXZ/JYAvhkW9hDznbzDEXXa1BdQo8dRiw
   /pon/AFS7NWb1qLNHulUY3CC63pGVG0aoVupShZaIMJbEI1nBO5YBRBC8
   yLPvqI3+WfZO9q/yneaLGZ9mOiBIILxIlZxRI77rPG/SUQgTS46PPIQ8U
   5JXkEf5G5nTlKUgWM4ysdH+dy8d+TGlOr+wCiL9Y3NzocpdC4bV+CvzKG
   g==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684771200"; 
   d="scan'208";a="245977331"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2023 18:03:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjgtbNdFoAm2i5Cd5BNGBLLizkHZOH0WB52eLHUzEomlULYlcySP4uek9EF/fA13VdIXNGii61FFFPkuzKDwnLt+AFhDLDdhng04eIcyI+p1wlrUmfT3FJucU6Yty15jFgztqryrncU2agDePFR7n1sOzdHE3507GosNX7C/vhcF51523fmyTYDGrfJ/DsIATTr8J0iAMNM53jOAh3Bex7Z5rzKN+RoqHBIC+t0tfyjvKfiYKiLRkH3hegRvkm//nv+GPhxhvgeh10Rw1CBluLlJtlIAPZJ/7Gi+slZvz9BxdTx7eT6NMqx9rO2xWGZcis96qT4kPnMWAQV2mqziKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqPV1rQZN7L+IulVSokXWGKPAS8/0GVR/YHiMOB/6g8=;
 b=XEbHrEiKjFDYSwXXrjElzBg9N1MsC3tly5+/lmTRVR9ABy4uTJ09GPnRoN8fS/pGN8Rxv9aQIh/tpJALtwaFi5n+6n1SSiW8tLDUrCoBY1uK9wRwlerXLvkmvbbaR3DD7N9XUYMlTN6BaG8K3Pn9UpUq47ov80SDE6YnXxSK5w8q3qzKy535eL2CT5GnhlxXoFxeHwZWbmKzD7BTm2aGNJmWEynpCftOYLlY1HoXNF2/Y5ny6zH+uC6WhX7hEM/skOHexjY8/xCojKT9Ii9tl9kWne8sziRPcj7dELpa3AuP+vc48Fn5dLsplwCiJb7iMskFJ7zmIc8lAx//UTe4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqPV1rQZN7L+IulVSokXWGKPAS8/0GVR/YHiMOB/6g8=;
 b=qJe2VXafRNxZV57V7Q97eBox0cUd0HYQbVpT/1CONf/2qJUggTFSyAbGrCcT27xKlHtHMdTstPNuO6osfmK+fBoB3tYZQ4fib75FH8FBIJEj8Fw8d5eR8Rdgd+hprSwsGPOGkB30gicO5jqNCaaVtMaiGZklhPV22QhoTCieKBk=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CH2PR04MB7111.namprd04.prod.outlook.com (2603:10b6:610:96::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.31; Thu, 17 Aug 2023 10:03:05 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::4781:1e0e:9df8:940b]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::4781:1e0e:9df8:940b%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 10:03:04 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Christian Lohle <cloehle@hyperstone.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Loehle <CLoehle@hyperstone.com>
Subject: RE: [PATCH] mmc: core: Fix error propagation for some ioctl commands
Thread-Topic: [PATCH] mmc: core: Fix error propagation for some ioctl commands
Thread-Index: AQHZ0DdwHngodiqC+0eDbhyluMlK5K/uQxdQ
Date:   Thu, 17 Aug 2023 10:03:04 +0000
Message-ID: <DM6PR04MB65759A72284F94585D19A3F5FC1AA@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230816114712.25093-1-ulf.hansson@linaro.org>
In-Reply-To: <20230816114712.25093-1-ulf.hansson@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CH2PR04MB7111:EE_
x-ms-office365-filtering-correlation-id: 593d2454-bd78-491e-6ef8-08db9f092640
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MpJqqAeOxJ6551AeyjnWfK7RpDRMbhIyJxZmhx6RoDyd4mQTIC92f0tweXMww09736MlFLSU0wpa0u7ydZDncOX/hg0ead5WCNYF+2PnbXhm/Z+IhLlRHgjegxgOfUuCsEM13yheg4mnFeA10PWRu/4KToxSiEfpXA7TCS9VWlZJDehylBaVLYSbzBEt7pXHgbA6SCTLlieO1qXIYsNLMCTeUF6ZBv4Sq5fJ1BRphi5YZbk1/aFA6NT6uoexyTel68NmbFAFfCxAT0er0njdq+Uy3xtyrT85kjdUqimU53J+3dP9K8ZB7F5SEIJSD03u/KSKB1m28TVkmjpnl8yySqYQf+flY2nYJFRT/b1Vdd1sfzN1J/O6yOm7yTOUCdJbYvQNGf/a9j29OTjbNNVOoEV5aH4vcNCMGniBsU0i9jkeVUj20lO103rdXaK7jtPVaFmteq9MzAYiUHi5a/kE1B3Yn7FL+xrPcebnOYCdeyAjUNU2TMBfdmQGTKCSFRPA0OQI6yboiN3wnltz+m9HrkXqF59dzCEd9QrVGFFJB2RrtE0DkR5dziRJkXJNpM3H6Y8OVOMMp+GlmW61Ijq6abJu3iXaBZiNTCI4BwCKWM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(136003)(346002)(451199024)(186009)(1800799009)(33656002)(86362001)(55016003)(83380400001)(52536014)(8936002)(4326008)(8676002)(5660300002)(2906002)(41300700001)(26005)(7696005)(6506007)(71200400001)(9686003)(966005)(110136005)(76116006)(478600001)(122000001)(82960400001)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(316002)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pAwDjVwetePg0+C1F4Q3zoDPe5ypQALYwgoIdkjfnOar0KWcO3TbmgnYUPmY?=
 =?us-ascii?Q?rWTZE+KeagNQAiJmcWqoQLH8G/jAtx3oDTxPUmapR+XC6GRmgaHmTmVJoe0n?=
 =?us-ascii?Q?aru7pPUocTtXUufHN/wUNE/eUJ+PqKsk1JTTbeoo4hIiI78KzrKJ6hFVwyWH?=
 =?us-ascii?Q?1IMQUGI3Ng25fM+nABk4Me7V6GklD92xslFDTaUO3+gY+3An7ZbyKc+YJTy/?=
 =?us-ascii?Q?m7N6BKffEYlzv7yR+RLvk8t/aUh4xwVWbPtk4LoN+HaQAzOoTWavOIWgMpc8?=
 =?us-ascii?Q?2yVk0XWi0aMo9ZezHX5MkdG27JUz+9YWYuruXO3EakHyGRWEfAGfov8svT7O?=
 =?us-ascii?Q?5ri7sqEDHmlwM27HZ+5NZp5/mXunQcXtK4PKPrqnt1rDPSAGfPpHF9FFjgzd?=
 =?us-ascii?Q?htqP4vWVkLkKEMF8ZzJ9yEiW4nvalrBuGhfh63FzzVTljBFDqO9n4STX3Mdb?=
 =?us-ascii?Q?jH8G0rhOySrLHZimGLH7ile0o2Vzlt9nlTrjqE13Y8eD9eUMw9WwITAhFJbw?=
 =?us-ascii?Q?ZDcOU4gNQYTqAXfhCaraJNC0/TUf4M1F1xCMR1iaa2MR+8ax0k+wFWJGG1ip?=
 =?us-ascii?Q?VDbvig1fZty00+yTlPE2mt7c82PsciEn9P57xYFzZmqDeN4hcLKq/7YAEMq/?=
 =?us-ascii?Q?ULyLsJLdGXjP42KGhhuwwtdS9TJoJdtcVREaS4Dk1DrGH2IjkKzkyiU6WybV?=
 =?us-ascii?Q?f6Nb4NRO7tb/RL2VomN9D7hZ3J3sBXkdhpxOSdn3E223QAXn3JcCbuSgJfLn?=
 =?us-ascii?Q?BcJPKx8ep/yevtI1eDq0PIdfwlmjuJ0MKE85/7EMhF6RUKWGPhVxTG4ud1Qn?=
 =?us-ascii?Q?wg10jZPXG7mfFuAPE231/6t4VWLDgO3Rv9vIqjerhRxVCoYRst5l2pee87U+?=
 =?us-ascii?Q?ZLieXQ7BgcvVBhhzQfoTrNI5bTWeAWi9AuwNFANVq9I3ipmP8VvkNuT0lnmp?=
 =?us-ascii?Q?Z71bJgYdv/WnX+Bm+SJvg7+L/BUkXgQvsupOs0HFF3wJ3xH/kfKJM6T+Cn+Z?=
 =?us-ascii?Q?vg3J5zFroRAb9RX0VyXyKSkkCw13GLSQcUKDgFMwUrDPbzZhkg4cmUwJ6UdX?=
 =?us-ascii?Q?I0ZSdOcNALx6wcA20yPL3vSVVyyxZStTNfoR3YUV0pRhMx0n+/0x34D2wtu+?=
 =?us-ascii?Q?sVs9NvOsPrhQGf/De7rs7rmKgkbHAThDlQba28z0ybHCArEqf1of10s54HIP?=
 =?us-ascii?Q?MNAL24JHzSIXpd6lKKIYNBs7Lz32qHtvAQOP6PHle80M/quG5b5takP9HigX?=
 =?us-ascii?Q?ypPh1lugFKXm61ApSdbvQ00lhPRrgJM/x31cnA/wtiYoAHqr3Y0lPso6NZJa?=
 =?us-ascii?Q?UdNS+a3NCeVVWKEKEvwi9NArwRURv7pj9Fm3iaJRkxEPOFzPk14bXye5kgae?=
 =?us-ascii?Q?y5FcTuvogEREhV3j37JBVkqyEgUU/p21e1ZQ2quBV+y7ZLBlEgss2p8x71Md?=
 =?us-ascii?Q?UjGsogp+ybbpvsY1QNhZB9t7ONETusw5roPELQNi8/Kex1dASF9zGRB0t6W7?=
 =?us-ascii?Q?OqAPMyATZwoat6GEWr5HFQDdJqwGJHeT5m6s+j7SWJ6nNpfVwnW+c0QDxXg8?=
 =?us-ascii?Q?yR/OVUF35jeTekPVf3TdED2n9C3OQbfKV21tkwzD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jB/5gMzVz22L/7+uem87gaJeOPHmYejEPr9GgFckQQmLP42t1kTj8JL5hvRNa4wdsjmkXI40vOJWEwm+FVfA9bY/o2Yzd7MTS+uBClTcW0AB1zTm182rENb35Yo0UiQOFEMrLflkpuHxK/jzWiQej2x5RNZmGMLy+CF6/ATIyF2kkgPXseGKVlJ1gzDTZ8BnOV9Xo/2YoSIdAJjBSA9JHjwofWL9jUnIvHyz/9nog4sewf8N0acMgayCgK95DME1D/sr5KGx54J9vfJy+YYMnTfWb4y5iPgC42HU6fGRICUEWi5wRPdjBomcDKxLfakYxl6E3SIBruHgjOSsxAoRqjw9Zv5nlkcgT86usBkeJ3FN0A5uEF5EGA+xmoo6VNh126HCIUIWX5hxYepcM+PTGb9ymYspLwhjxKL5PJBSR0X9MaWE5I/bdXBKewiB6HST0Emm+VSIdY80TDY46//pDA5pJ2HWwodRf4cZLd/zH2Wg0ATYTKguvJs0CMtHajiRO02DXM0Oq9Tp0dBuAQsQ+vSvDGRfjxXbT6Hp5EOdh/FbfbcsdfBXzOX1qqC7UZFHAWvXBw/yAHxUaWv82iiOkyv6riZxbMVomV/0oWyrgsYLdVz1YUuTNfjDlN/9tAuhJk/WHTfBKtAvK7mQaPfFrdYA67/xuItdDDQQ6X6TIpESVx9sbpFevosf8u3pIlW2cDt/hyKa8bv8sy6Sw4efzCiPol3El4YsO4rWMpB28miPzA+ii4qPUiHxPsegqukpjCzkvZywgt6PJ3myDgeXy+0Q/3TCntMqthtqoQJRiIvLJQhslLbEepF+0Ls1GqbsjUdyXmurT1HfuE7kLwCaEJ7lJNBVVpYwjUNNrswM0Ice6+XVQbftgnZWGFTB0rUF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593d2454-bd78-491e-6ef8-08db9f092640
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 10:03:04.8186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjnCr2eSxLj/KuqsSIw94EVec6e1JfvwmDEoeJVQxJABIttt55Pr4JmGkuLjyW+JU5dOApa0CRQFAPegzwDKTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB7111
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Userspace has currently has no way of checking the internal R1 response
> error bits for some commands. This is a problem for some commands, like
> RPMB for example. Typically, we may detect that the busy completion
> successfully has ended, while in fact the card did not complete the
> requested operation.
>=20
> To fix the problem, let's always poll with CDM13 for these commands and
> during the polling aggregate the R1 response bits. Before completing the
> ioctl request, let's propagate the R1 response bits too.
>=20
> Cc: Avri Altman <avri.altman@wdc.com>
> Co-developed-by: Christian Loehle <CLoehle@hyperstone.com>
> Signed-off-by: Christian Loehle <CLoehle@hyperstone.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Avri Altman <avri.altman@wdc.com>

See nit below.
Thanks,
Avri

> ---
>=20
> Christian, I took the liberty of re-working your previous patch [1]. But =
rather
> than keeping your authorship I added you as a co-developer. Please tell m=
e
> if you prefer differently.
>=20
> Kind regards
> Uffe
>=20
> [1]
> https://lore.kernel.org/all/26d178dcfc2f4b7d9010145d0c051394@hypersto
> ne.com/
>=20
> ---
>  drivers/mmc/core/block.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c index
> b6f4be25b31b..62a8aacc996c 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -179,6 +179,7 @@ static void mmc_blk_rw_rq_prep(struct
> mmc_queue_req *mqrq,
>                                struct mmc_queue *mq);  static void
> mmc_blk_hsq_req_done(struct mmc_request *mrq);  static int
> mmc_spi_err_check(struct mmc_card *card);
> +static int mmc_blk_busy_cb(void *cb_data, bool *busy);
>=20
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)  { @@ -
> 470,7 +471,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card,
> struct mmc_blk_data *md,
>         struct mmc_data data =3D {};
>         struct mmc_request mrq =3D {};
>         struct scatterlist sg;
> -       bool r1b_resp, use_r1b_resp =3D false;
> +       bool r1b_resp;
>         unsigned int busy_timeout_ms;
>         int err;
>         unsigned int target_part;
> @@ -551,8 +552,7 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card
> *card, struct mmc_blk_data *md,
>         busy_timeout_ms =3D idata->ic.cmd_timeout_ms ? :
> MMC_BLK_TIMEOUT_MS;
>         r1b_resp =3D (cmd.flags & MMC_RSP_R1B) =3D=3D MMC_RSP_R1B;
>         if (r1b_resp)
> -               use_r1b_resp =3D mmc_prepare_busy_cmd(card->host, &cmd,
> -                                                   busy_timeout_ms);
> +               mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout_ms);
>=20
>         mmc_wait_for_req(card->host, &mrq);
>         memcpy(&idata->ic.response, cmd.resp, sizeof(cmd.resp)); @@ -605,=
19
> +605,28 @@ static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct
> mmc_blk_data *md,
>         if (idata->ic.postsleep_min_us)
>                 usleep_range(idata->ic.postsleep_min_us, idata-
> >ic.postsleep_max_us);
>=20
> -       /* No need to poll when using HW busy detection. */
> -       if ((card->host->caps & MMC_CAP_WAIT_WHILE_BUSY) &&
> use_r1b_resp)
> -               return 0;
> -
>         if (mmc_host_is_spi(card->host)) {
>                 if (idata->ic.write_flag || r1b_resp || cmd.flags &
> MMC_RSP_SPI_BUSY)
>                         return mmc_spi_err_check(card);
>                 return err;
>         }
> -       /* Ensure RPMB/R1B command has completed by polling with CMD13.
> */
> -       if (idata->rpmb || r1b_resp)
> -               err =3D mmc_poll_for_busy(card, busy_timeout_ms, false,
> -                                       MMC_BUSY_IO);
> +
> +       /*
> +        * Ensure RPMB, writes and R1B responses are completed by polling
> with
> +        * CMD13. Note that, usually we don't need to poll when using HW =
busy
> +        * detection, but here it's needed since some commands may indica=
te
> the
> +        * error through the R1 status bits.
> +        */
> +       if (idata->rpmb || idata->ic.write_flag || r1b_resp) {
> +               struct mmc_blk_busy_data cb_data;
> +
> +               cb_data.card =3D card;
> +               cb_data.status =3D 0;
> +               err =3D __mmc_poll_for_busy(card->host, 0, busy_timeout_m=
s,
> +                                         &mmc_blk_busy_cb, &cb_data);
Maybe we can pack those 3 lines in an inline handler - they seems to appear=
 a couple of times more.

Thanks,
Avri

> +
> +               idata->ic.response[0] =3D cb_data.status;
> +       }
>=20
>         return err;
>  }
> --
> 2.34.1

