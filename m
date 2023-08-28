Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D578A4EB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 06:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjH1ERV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 00:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjH1ERT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 00:17:19 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B51129;
        Sun, 27 Aug 2023 21:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693196237; x=1724732237;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xaOOkEZbX2DeohH0v8/NzQV7pdm871uiD47uZXoG7oE=;
  b=fOcg4iSdBOmZU/F4y8BSvcSdWmsRCaOx+fA4is4GxBdzje6rNZ2bV4MW
   0UG6fbs1jT6uE6oIVX4yulm6btSRAaTxPVAQQQuT8wbyi+akDzl3K0SrW
   J7BtWetGSt7qB+iakuhbVvhkDKaVJWlQrAlkHJU9fnTa9TxaLjvUYA+Xa
   BMYT/dDtovSzcgOlMPLb8rnjBQIdW4gIOMzHvk/osvVub1PbwyThg7iz8
   G9HeejojCaeQN4ctLCO5CgKvz/1vofp7CGN9o2ruce/cDU4NFkO/53Mu6
   6bSnTOFmPvBvl2NIdtAa9HosT7u/WHDLTKqTWbrFVvcTQs2emTPIF0ukD
   Q==;
X-IronPort-AV: E=Sophos;i="6.02,206,1688400000"; 
   d="scan'208";a="347532645"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2023 12:17:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1kntRFjQRburFkc5lqxn49n7hgdLffGHh6Vn2e9M3Js0fvy1IFQI0Rm1k8844DMxjVJQCE8adx7nQ5Ll0WXxBHsjygr5LlHeX3O9iDjiELcDw6j34Bk8KZoo4M9Nn5d0sE+mSXajoW0XnhucM7he3pdRlqBHOgcfNhKGfRFMVHFH4tJNw2kK7dY6oilkRw3ZVKsH7oa091OcZ5dEjQ76E5Zeo4NJ4SJP4BD4GOBi+YDWF5GFl2e/VJ7AGkFZpQTHR7JRx260DS0IwYbjNTVuNN/CnjxlLfyU2+pwRj/MtF6f/bZ3xj8UTOSmdPL0aTdv5pNWD8n9ki0AWnT54mOLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUwu+ZSmnv1EFehsHaBUaOnrbpW4uEhO2+02IbpAU7Y=;
 b=LMpWBDuU7R7XZ5Jg5NVuL1IeOX1IqX9a8ItioNVqjQs+6n+GfV5ferSI1rzCi0JUx7uRN+H53p4HQxk3rq5ncNuVDSwInyodrUebcWQ0eBuJ0o6Rz3nmzE+3GRLJfGS60aXu1T/cSYWetMyOBa1RBscOB2/OPqDuhwjTJeF+uA9Uhhv6m6a4Av/+wvO0C2oEnB+iDolihG1/CNGFO0/XNqDGnU/w2DF4keuUgCy2WePQY8kg02Kr3OyNDTbWJ9ars30guxJ0+auoUMM4OrZ60i19bs97iDCBNXa4Nb/e9oz0Nv9HkGDN38aF+sBEmJifpex3jjA1iBUumfmIrWOyAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUwu+ZSmnv1EFehsHaBUaOnrbpW4uEhO2+02IbpAU7Y=;
 b=Gk0IsnuIzph/LL3GFbDInXmh/y7m+LcrtDfYIgcrVoMd80JgHq7f522tRMEKL3UKx7Gup1erKcmGoHFCojT9wadPgkK+Xyaf5WZD+T7E7Q7cWmhnmpzNV7E/2awoaYzN1p8iGriztPy6d1PPoasSuvwLXTXEej9PGdBKWAqDa00=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CYYPR04MB8867.namprd04.prod.outlook.com (2603:10b6:930:bf::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.16; Mon, 28 Aug 2023 04:17:14 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6745.015; Mon, 28 Aug 2023
 04:17:14 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Topic: [PATCH blktests v3 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Index: AQHZ1NQBelM/0wps2Uy83of5WKTqEa//I2KA
Date:   Mon, 28 Aug 2023 04:17:14 +0000
Message-ID: <455c7sf4hrgppludozegzjzkkdrqjujvguzgqwsjiz6bnsbmva@g7h6bkzdlada>
References: <20230822083812.24612-1-dwagner@suse.de>
 <20230822083812.24612-4-dwagner@suse.de>
In-Reply-To: <20230822083812.24612-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CYYPR04MB8867:EE_
x-ms-office365-filtering-correlation-id: a372c6f0-3707-4321-16c0-08dba77da870
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tfhTPxRn6vbIk6NGiwNtttKjQk5f48rtSXQfdI5v+Ds8aakL4Bq35Fm6hSUULMi7nqMsMERys2yPyrgZ75FjRVvXgaeeuDfyJpoOGPH+EEpXuTcqyWaM3074+OtbRjuM2+tTqrrUeKg8F4R7zhKfEzNZCS2amjaerCs/+Z3S9fWftSZQ24iBms2r9hw9HYCN3A3Hg2dOsZs95d+DwohEMdndZa/koQ63i2UBzQmZDTDoAWehRpfb2TwUQ4WH0LaDcUK7BM6JlKRgezOiGWytzO9awfKjwctAQ0hMdFy0d1keMPydQwaVB0mSZfJsgKfXj9vsqeDQNi7BMOx/lHuCIl1inewG1F5GAo6pF8IyNjEYk9piCYNC9RrwCsp6THQqJ8eRRKD8DTLoQERf8vXEPELAVbhLNyqgMYOrNeEZscAMuhn5ubP7Y0sR6QKzabD7vQN+WFiGeJMEaW8AVNiZ07oxABCRllpwXh3y57XpV5FcmE9XELDhNIrrtPJikEDJzrFxOSSaz+YQy26+SX1eW7RZweJE2IrSYpJ8OmUAbAGpLKZNbllJCw8GjDIA9M85vpfBbuvdNjKuFyouvunOLSlul3qJ69ItNeKlnzQQ8swFDA65GTw1HAimko25YI4u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(396003)(376002)(39860400002)(186009)(451199024)(1800799009)(41300700001)(33716001)(122000001)(38100700002)(38070700005)(86362001)(82960400001)(478600001)(71200400001)(26005)(9686003)(6512007)(6506007)(6486002)(4744005)(76116006)(64756008)(316002)(54906003)(91956017)(66446008)(2906002)(6916009)(66476007)(66556008)(66946007)(5660300002)(8676002)(8936002)(4326008)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NVdQ2SkPhmavX5NqcQPQXfPN/G22c9SPHVITGTQhP19cZ+0LqxelBgm1fCp6?=
 =?us-ascii?Q?22UnT5st6L3x9IQhqqbP6UCBC/JqGi0SlhuLqQ6hFQTvq3nzEh2XTlai+nOR?=
 =?us-ascii?Q?V4VuAXCQ2alCjGGONxi0IbuUvA47TnPZtl64+RAOYxeiX9AhuaBnExzIOYq7?=
 =?us-ascii?Q?L2EDT2rCq0UgKWzQ7wtZqee97BiBigb8DylvLT8HmfzesR/6AF45spzLD2Bd?=
 =?us-ascii?Q?TM3iGDvZHb2BMyIkUZ5CahvOwVz7D6Pk+0VB28Qd2rNYNqhkqN4C3dr8JiO9?=
 =?us-ascii?Q?hi27qP3gIGj5BO8XkFQq15gl/AxwTljElNoCtphg5XrR4rNJakXx5RDq50WC?=
 =?us-ascii?Q?kvGv5dTwic4nQUON2GuOkBYIyso5m+OWe3PXpKuBwfnWRHz3hrUKuCz5e21h?=
 =?us-ascii?Q?OZiH3dzSmWLURqFMtAvfK7VrD5E+CM9DWr4a8Og0nTD4d/9xG1WFkQ8XH+tK?=
 =?us-ascii?Q?/4jm/S9i0CQjj8sbWcEbPTGaoPr/97pb7OPzBwIdf+JqtJCU2YgvN8FVLtD2?=
 =?us-ascii?Q?phIy3PiThMFLJ//hCaeUWw8nNQG+Y/BxOAFwBZos+fgTNiQZZtybNrr67rbM?=
 =?us-ascii?Q?hVkaCc6cC0VCwLVI02MlivMpYbdmur24Tt5q1nRLaDPwaXEwk4dEFmAimFTg?=
 =?us-ascii?Q?x6IJI0ZoiEzZOYbDxm/Sj8la1yu+cCctV5V0XK2E5Zflvj+QA/PlPu5xj2nS?=
 =?us-ascii?Q?uEtd+Nw40J7frxSiUj0LsIAuZ09u4Zt9wsBgyyyhi4XHgPQoETIXxvlz7hEX?=
 =?us-ascii?Q?Le3s97WpNzuT0VQd5nN7i+KCKpbKmnKFr8D7O/ilw9rhPcMR+rissdiReajX?=
 =?us-ascii?Q?pRytmUnQDeAVBRzVuulkXiSwh4XGFGWsUeQGkWEA9OKVksWRra63C8+Beml0?=
 =?us-ascii?Q?RN99M/UfF7Gah9TOrXK56nlDoGG/FL8s9DUnixE+tvmpXLQkoUpLcx6bXYIF?=
 =?us-ascii?Q?y9M1XQivt+IuFQs9cfFmmp1Sbl2GxB7FltRJPscsT1BVi21Z855gI7y+IgDs?=
 =?us-ascii?Q?l7FjmuDxo8iXbNKDKd6YrNoQirLtRyZwmkCaPB/IdXrt97Z4vC2AyBz4dt0F?=
 =?us-ascii?Q?TtexIxG9Is6PVB7Xca1GWmYZsqMkD+tH0cCwNrqHLk6n+JBcYG7kuwDWNVge?=
 =?us-ascii?Q?mQOBZY7+EeSEcrLtAUTdkshVRDUeflN4CikLRSc/fQRLBbXn5F0hULxnqRV1?=
 =?us-ascii?Q?FgFhwe7N7swllYS98AJzvQxYxwdbSBAxxIHz4qqDcFGLjMH/K0KwVJBp42Z/?=
 =?us-ascii?Q?YfBlC7vBj7RmVPo4WKrBqHfNUgvZf9foT3QLYEIgG6zLxRg5/VRKUb9yjewx?=
 =?us-ascii?Q?5f8W14qas/YshJmLtzGmRqv+p777UIPrt4dLaMS2750kRXgq15k97O8i/9uH?=
 =?us-ascii?Q?O75m3N6ba5/bUDJqWQkEliCa21hEyMaJ2TKTnG4vpTw8i0PySDMfCnRUyEBD?=
 =?us-ascii?Q?pnPI2kk2b5StBpmn9FtOnteu5PD6pgV2lmWUQ6wG92h8tCVkQ8y6JIyJLFdz?=
 =?us-ascii?Q?m469lYPzaxD58vkrYNExcYH9f/KGUAYAodQL/xuTepuUcFwcxFamSxAnL6w7?=
 =?us-ascii?Q?3h6OZatcePKPv7WOUUP4c/hyHuhOXqoCQTyNdny3Rr2VCV1SconBzMnvyxFW?=
 =?us-ascii?Q?T2eBaw9G7pas0I18B+T9EmE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F809E6DED5C9734EBBA26124229B9469@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?P1yqZQqY/oFhxwaj1/0wGutYjbQZUPAC1gEDAhkwKoFG/kmZU44LeMprjDPr?=
 =?us-ascii?Q?yptcOZkfXx0L3tNFSPzdrK71vYJHL2wpIFk/l1nC34yGlCXIadWwkStjKotO?=
 =?us-ascii?Q?5XBaJexNu0Y1JpxfOwrOy13jRWznLmW+oI692kvdrX1fjj3SFcLMX97+zZBo?=
 =?us-ascii?Q?byN87NKDSHxGzDaViJtyYtX6qSzi6Jbe6FemiOS6eSv1D7kGjkirI0BvIs+F?=
 =?us-ascii?Q?z1rWSpBK95pnPocbCR5YntjKcjomxojZoaC/s9ME5msSPf4axOWClryAtKKw?=
 =?us-ascii?Q?dLdBT6bXla5CRFQF0li9L/NFj03yg+UJISVBfH8kA0kzF/K4YP1eo2A1JAIv?=
 =?us-ascii?Q?bm4gDO5d0odK+S2hYn+uKoyHbPc1Rzk+UznGFir+GKHiaenwXMtl5Nv1Yrpp?=
 =?us-ascii?Q?8kv6x9KQ1CZb1tDSMDkESxWgwf4Rt0BeVu0fGm+YGs4gBqjxzS+Gu43REesR?=
 =?us-ascii?Q?BIzgOxATPEpITWzcgaGSzXFGRMl+XcPYWobajDcu3uzashcN+uJaPDQb3cjL?=
 =?us-ascii?Q?+tUyeX4HwtmiHpdljDneLfmZJCIc3VlTPnlFklq1ovtZmT8cqoB3+C8guc+5?=
 =?us-ascii?Q?qJ9TZWnPuFS6TijsI8qdTIR1WksFoBMPdZboHG8zx0fNZsr5MEFvNA5jh54r?=
 =?us-ascii?Q?ZsXJKSlFH+TBO1Mqd3tcB3CoRIi9UIhnpNassHqOfUpLICBsxJbFF5UbQVdR?=
 =?us-ascii?Q?DrRYoI/xfz9kBPKr/P5g6o1pfRmjjXgZKa5uVECybHq8F75pyL9T2p6z64Jn?=
 =?us-ascii?Q?3GfSHSsLQw9/uxk9z95B24m4JJCHSW4+3rHD+Z/TyYCRJWZI0BGgJNxW/1+w?=
 =?us-ascii?Q?tA4TIR+5ouI5XO9CI3EHK5UADiI+9Azbs/xwgKJu83/VXU0UIuDeU/9AD3PH?=
 =?us-ascii?Q?KHDkzown1XMFu7fYZ5x8a2Cr/a6nShhkXIGfuRiMFn1obHuqoc7smajf/CQ4?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a372c6f0-3707-4321-16c0-08dba77da870
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 04:17:14.1493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QVqqJRKayEZw9Mtpm7rvnikk1uhvMIdSGJmRzB9KikLjjwPJ2SAOz9/Bk0CStgivrd+ecPPjo9z3YCUr7HH6XORS/W/dQMQJRkJBC33O0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8867
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 22, 2023 / 10:38, Daniel Wagner wrote:
[...]
> diff --git a/tests/nvme/015 b/tests/nvme/015
> index bc04e39c628c..b418d785ab27 100755
> --- a/tests/nvme/015
> +++ b/tests/nvme/015
> @@ -20,19 +20,12 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
>  	local size
>  	local bs
>  	local count
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		 "${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup --blkdev=3Dfile

I looked back and found that the option above looks wrong. I think it shoul=
d be
"--blkdev file" instead of "--blkedev=3Dfile".

Same for other _nvmet_target_setup calls with the option.=
