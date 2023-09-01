Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695F27902C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 22:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350705AbjIAUTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 16:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjIAUTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 16:19:46 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C10E65;
        Fri,  1 Sep 2023 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693599583; x=1725135583;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mxWj7PT1vyruSsL4OzV7oJYzGt4qRA3ZqeDWDJbgs8E=;
  b=ewhqcpZbMTp7DBQv/zbgcr5/JhSlVUECoY4HNk9VQJFuoj77V9nu1LY9
   kiT59usmbYucZ7SolTdBf8XCebD+wukwicn94nxYhEkFMSlVAd4wi1eDB
   FIMyigNhT10BT2qYwdCMnWj5gzHUPobHfydFaCJeppfQUarQEi2aDfECX
   ckj4vY3NRbwVlXdBGPKkbVbs4s1dkt7WJPu/dCakx+VIS76+b3ABCCtce
   Jmc2+d7/8spNl0/WDnsFGMsvyszViUx06L7W7umnRyBEpox5prOz6T3TS
   8R8ThSE2yywtM08C8UaR6MopnwjFecSvkWICjPogJiGFPHR+GyU7BciKg
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,220,1688400000"; 
   d="scan'208";a="354787106"
Received: from mail-dm6nam04lp2049.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.49])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2023 04:19:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeIaWUY0vVx0YFfK587OYmRZFkAXXJaqhktkASg0LdvNCTH01Uufq/y7+qucUht7QsWf0hpp7Ipzm5XpLrAyouoJ4S6FSyEdQRlxZnc4z28Su4wNWE6evHFdjh8i9cieLIXbz0aY42Jc6I0KDYRQlz+pobhfduSu9Kup7rfY8DwXLCfWBxnlIJj1NBCdOTfIstseau4bzx2FjbDH1Oyo60UY5LXcNQJkMgBN9q3pTIggFUPogLUOVmPmJ83aq0dGvdsYihtOHiHwWQZU2XujzW8+41xEQG4xzCx/Ktf/6sbbD2uKyUi7CyWT2tDhd8SBbHfELsN4FREHzpiq/KLqyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYxQmCmJRtQEN011xefoyQw0FaOQ5ZtVIq2UQArrXEs=;
 b=hzGfLV05ks9Y4I7X0cU0ZTPFjubN5x5l5QmSIV3tAmZhXLMhFqyiIyMsXX2n/eEbvYI2xaOjQ9DQcgpLFhX9l7dDPwFHoMVPjMhDcwsLIuv3jqu/KCcp9G3HygmQ5tzJUxWQ3MVqvEkTDIJwQuRweOoEEAUeM63XNZ40OlS0/3KDk/StCpXhaz8f6+Sj3sgh01OQ6ggPEdy+EFzW3dRxgsWKRXZH60hiubBflk2sZcXItubctynExgRh8CHfvC+plLvRAFa8yQJSSIvQqgehpdS1M6WQEpM+fTF12vEkrJPBKcS4rqjIWbgGv4VpLPRzefeZRkwASQ1TuU074Bp9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYxQmCmJRtQEN011xefoyQw0FaOQ5ZtVIq2UQArrXEs=;
 b=fwLDKxcBaGOBYBwcagXw/SNyCmk+i7f6+zUC2ZpWBswKeASWFit4Lc1b+A7JeI1VV0rV4OZuksVFqEzaVsy3y5CrXq3JQtfbMw9ISbrI9oVAIaNdrhNYS5CLxHPlyOqlkhA/dq4ESy1hlI5cvMV3Lo1q8YxiegJu0XzQIKwyrBQ=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY1PR04MB8752.namprd04.prod.outlook.com (2603:10b6:a03:535::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.16; Fri, 1 Sep
 2023 20:19:41 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::ac1f:2999:a2a6:35a5%2]) with mapi id 15.20.6768.014; Fri, 1 Sep 2023
 20:19:41 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Pawel Zmarzly <pzmarzly@meta.com>
CC:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ata: Disable NCQ_TRIM on Micron 1100 drives
Thread-Topic: [PATCH v3] ata: Disable NCQ_TRIM on Micron 1100 drives
Thread-Index: AQHZ3Q9TwQL+r0AWy0SwzhN5UdvRc7AGaSYA
Date:   Fri, 1 Sep 2023 20:19:41 +0000
Message-ID: <ZPJHXAQcDn0zNVyg@x1-carbon>
References: <ZPIyxg+iSWa+W93Q@x1-carbon>
 <20230901200220.3891806-1-pzmarzly@meta.com>
In-Reply-To: <20230901200220.3891806-1-pzmarzly@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY1PR04MB8752:EE_
x-ms-office365-filtering-correlation-id: 962de591-7872-4771-dac1-08dbab28c629
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nCDdRe4o/ji6i4FT5GNkEWJ7KlAF9c+wyMcw5PI1S0TJMm3o9nbhCMg6J8n6BX2QFAa3BxzVG5tMpKBUahlxVM6V7PdNy+r2a7DW7KRx9MbNAVvGWVCBt2M25E0OSVGcWBOCT9akOmbQNo9Y/q6oWYAlEy4XqT6n+9wJtWhRKcAl0dbx3kYOqpHhUloMSdbIs5sdexNX2p/5p8lhXrGKrFWnJVaze8cyJyTdKQpNXKU2TEY97+5J1L0BF83O0XnwMWooNvtPgxvlvmx44yb37Nb+pHMJXBmfoHsg+zhCmx4gmtgrXaUSruqtggBjCZIliSXlNevtPUaVU2udhDQbJ5iiqQvXFtjjGH8jUK9SWc9Agb4Sr3fTGDhGDEdQdAwst0n1J3OKdfQkCkPwasRnXaWASSMyE4DCPjQDLjiW8Rj2vJkm2GagN/8CNXGuYRXmJsmCXq6pqDHadiBtlXUw8iXcaJcxmuol4j4K+PilmfJNnhreAhXgaXSljmUGuO24SH3QWtNOR1Ekzk+mJO5ykeSvs3q0shZKpISktqG4VkePMTlvQ/tSVA5QAq5PtcQK59G7lTFWY7OxzVESZxU+oNBv32CbXZsOapabwJ8xPc38h95bvdNR8Q0HMp/NPRta
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(366004)(39860400002)(396003)(346002)(1800799009)(451199024)(186009)(33716001)(86362001)(2906002)(5660300002)(316002)(8936002)(4326008)(8676002)(6916009)(41300700001)(66556008)(66946007)(66476007)(66446008)(64756008)(54906003)(91956017)(76116006)(6506007)(26005)(82960400001)(6486002)(122000001)(38100700002)(83380400001)(478600001)(38070700005)(6512007)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8jQDCDuiXDezQvIlinhgKZoOZ0+W37XSTqq4Ggvg5+cyoVp520esgLhrecv0?=
 =?us-ascii?Q?lb0sOs69vqJmGn98UWCKxUTnTU5pBnp4RBdvmSs5tbJWe0YUWtNYIOaEW1Rc?=
 =?us-ascii?Q?bveX9no1btQR0aANqMHK570Z82wrTWDnHkf3kCQpyOppNilDKmrNXyDGQVB7?=
 =?us-ascii?Q?1UJ6GoRuNB+hpbOSc/tjfVbmVCfd5PJhmgbOROTrd3x9dWJALnyFQK7cHgoV?=
 =?us-ascii?Q?mNiZxtS21HPTgLJHVGgXvx9jW74L/2KqDsx9qyILw+qTBQdD7DuwRFp3ts9i?=
 =?us-ascii?Q?YF4hcMJWqB4jZg8FQjF8ETIXw0cfITDCxvKK4eNThwOy4h4CBhq93d7sG5fC?=
 =?us-ascii?Q?XgQJd83+F/XRU9Wo6hm7Bo46lQ5GtKQSdGXz4GT9PfE7zgsQSSvTBFEmJzgU?=
 =?us-ascii?Q?8SBIQu8qM2TigjUZwMhfPK9TeWIaW6N/rcinpVcKbISYpCw7fVc78MOLJnGx?=
 =?us-ascii?Q?GiTQYauWV3V3ICvKzY3a526BAFn5MBSJr+v1cD6mQTgRylY9ynuegQZAYVtp?=
 =?us-ascii?Q?XX93prNnjMSKBrsGD5BlzLKD0fetsTdUqxH8pJnWL6SIqbIVGhYLNrywQ0ZA?=
 =?us-ascii?Q?ME0xSwipWWcwMuLggQoDjjEp4iGp2R9PiRI7DEAo4cgKjRcTUYkUuu6zSPEA?=
 =?us-ascii?Q?d7OO1Sv7EBpxdJMy3FrMTNcOl6q/om//aXkVXPwRYY+RX8TmcKO4y+GWmVO7?=
 =?us-ascii?Q?ucXj3lNEdGbZ48YW7+3IGvQEL6zHSbvs0SVsvbCNJATKKnapu/FpurqGb6W9?=
 =?us-ascii?Q?8o3co2k8iEPcEgh3bu8Uo23P+Esj+RPjuVI1dh1OfVJbRl+DUJ8aiBDznaxS?=
 =?us-ascii?Q?Ngm0tzsx30iNOGaQsl7zuhweQVyYIwtVt+S+5AneWM1fRTnwljDZwYvVu2KN?=
 =?us-ascii?Q?lyQP2wBfHjuXN0wBeTwaBkDd2FKT40ghTEV4A0MHMzPP3g4laPqQCLY5+yta?=
 =?us-ascii?Q?YkFJHHL9MR6tz5scV/BukfkONUuA0K9NerRfBl/FHIhZ8bYPpxCvXolVhiTp?=
 =?us-ascii?Q?JtitGYx2h0+yR7tQR5yavbuC591HmAoYiqGUTZwC2UDg/6ayfwGbKV0S298H?=
 =?us-ascii?Q?MOsN2AbInw+YEskSDxXdrdPyOsvn36CG8lNtCz+D1VVUP/STai61g+O/QtJJ?=
 =?us-ascii?Q?R6Iixb2kVsFTr7Fzjs+UsDxFnfEtFkowpZTvJ4YS4lV7bHgQmhajQwKEwgv8?=
 =?us-ascii?Q?KvcTZCK6ZJ/qAfrwW9GeeW+/YwNTeTTjISOE80argjyRQBrn38zI5lykxRiJ?=
 =?us-ascii?Q?Jug/QSLIWnxcqzx5Kg8P5+R9Va7IePDM+uAnc3UItlqs/p6mfXhA6pgDqwGJ?=
 =?us-ascii?Q?sHDLwkMZUR/hvNlDPNKxDO768aOBXHrHFr8MR70ECrO7z3mkM/WWCaST7IR2?=
 =?us-ascii?Q?jcHC6XCSD92BEJuD47RIT7PhBwYm0LAzqQD4FSrQxEtBdk06+pWO6wWsRK+t?=
 =?us-ascii?Q?GetBOKMKixTWlqKTtfMcnzZ023C+/i4KrtM+w2O7tVx7Q/5tYueqesP3HWzi?=
 =?us-ascii?Q?kQ4MgHGLnkNpxTApvLDPNITAFyZvV8rvZxLrcEzW9yLPM6+D2sA7B+BuN1IT?=
 =?us-ascii?Q?lKiBrlfsgXXyf+mO7xbQ5lcxkyRC8594yNn+pD477xn/taLIJ6sRDlVAWm+/?=
 =?us-ascii?Q?Bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <52D4D4E1715A5F409E8EB3A0E427296A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oqo1mGo4SbBcGtC+DV7cCmccBMv7DGAuH8ucP6VJH/76HCyOrCSkSQy5GuWudkDo+n+XgDDmKPrzadbeZo4i9v84A/rxxiO+xTnVibDuiw5JCkhASkdZ92Hf1XPCBAdq8yHxBfsW4Xc6SzM/WK6BcAYec2+xqVhGTWK5GgAKVQl80cNzUf/HEa+1gSWi9yubG8RG7Z7Pq/nquqdsqE+2SdH/Q8bFxVe+wvkbLmdnh/iLeHt85oj1ZzajQ0syNsdQpxfkEM9AUtGKijCkUqvmq6Xyt82/5oAJGvtzV0ouMUL9dkMVGMqwkTXM6vsnSq7jX+FR0iQzvWty68wzfCHs1WkhvXPJ+GMUv+/K23Ka4JOSk+IuicHVr8zMv13kKR1ZOsn1nvVAZ9oQh1vUaUvLmgRC6MMLkl+AiKCyzyC1KIU/qFED40L4/y8rmgGolOWRkack0SzJso6WIF6aLkGypCnK6elGS7IAquDa86uC0br8aifsw/NBZQyBFarHUXKGR0hHOUnCnFJG62kKogZWHQJ30nqriBdpEA6bbZeZD+97/fzmnslIUhcYnEIPuH3CpnnoHOU17GdwL7cTDvmOy+vVtfMMmf+e3iNgTJu9Rf64qe1ndiwYtnF3o+qhqUyy7vqu7Bw1KpaJbT+PCr54KsLivgAbm2PHsf5d1uUznlgWNyu9ccrUgioqVrPZjE1tyHLVKOB/VXl89xhf1YQg9PRvyBxJFi64DPGW/lymYlN8bxicUPtnzCBfcQlpzdLFQ/CSCZWtbN0hQ45OU3Lkx+UG36hDU0c0unWurRt9H5lGPbefQs/m4xQUb3650t7hdpq+mTMDjoyfWdJHRi0AHg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962de591-7872-4771-dac1-08dbab28c629
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 20:19:41.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4URptLJf+H2jF1t2CZGmazdLFLJ0/IGjGcAxbcyz2f+sgsiQvZi6JuDMp5cD9czMImKNS84F2NxLMXIup3reGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8752
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:02:21PM -0700, Pawel Zmarzly wrote:
> Micron 1100 drives lock up when encountering queued TRIM command.
> It is a quite old hardware series, for past years we have been
> running our machines with these drives using
> libata.force=3Dnoncqtrim.
>=20
> Signed-off-by: Pawel Zmarzly <pzmarzly@meta.com>
> ---
> V1 -> V2: Fixed formatting.
> V2 -> V3: Added missing Signed off line. Sorry, this is my
> first time upstreaming.
>=20
>  drivers/ata/libata-core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 175b2a9dc000..116f5fd6e3f7 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4564,6 +4564,8 @@ static const struct ata_blacklist_entry ata_device_=
blacklist [] =3D {
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>  	{ "FCCT*M500*",			NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
>  						ATA_HORKAGE_ZERO_AFTER_TRIM, },
> +	{ "Micron_1100_*",		NULL,	ATA_HORKAGE_NO_NCQ_TRIM |
> +						ATA_HORKAGE_ZERO_AFTER_TRIM, },
>=20
>  	/* devices that don't properly handle TRIM commands */
>  	{ "SuperSSpeed S238*",		NULL,	ATA_HORKAGE_NOTRIM, },
> --
> 2.39.3

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
