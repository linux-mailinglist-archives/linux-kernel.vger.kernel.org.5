Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DD57666B1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjG1IPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbjG1IPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:15:51 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79914D9;
        Fri, 28 Jul 2023 01:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690532150; x=1722068150;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3LJP9HEjkNZN9kGtNssgxqeddtAvODTfiyGrf8fNWBI=;
  b=R8NZiZswYTIBwX10Bdfwk0zwOT0IpLKJJVs8xwAfxxaFuzjI46Ax+tXr
   eOFBQIKVKm9XKrLAjN6y+1VwKFNXzwcIHw/RsMSae7JSbaEGD4vCIhI1L
   WV1t6MRlKvett+BpZbHw4wotJci2DajniT8ZbNrRwX8A9iGaJlDsey21K
   3h5iLpVLlyGqKM8/Uifp8PbB6rAbANSs0qVosxnmkqcO6lCYXIVanr+sr
   92VTrhjFhoEOZ2L4C9FWfXKBmKs6zX7WoI+iW+mR0kMz2djilCwblhTjn
   fkCHGFWZLFdUgphtuHHzfD4m4A631fdXD10gZNJ49elpSz0qwV6OHs5Sk
   w==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684771200"; 
   d="scan'208";a="239175954"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 16:15:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfsqQ4DdT91Q6rVtMydrDcTzNLdWqLurKrkay87rnZUPZP0JRPIbC81py6eaPNkigK+bbUQcc74jsY9g+S6Hgt/BeI4rfOesMg9XSJHIKr08f2IHYJDh+J6YM1YRbKgOJQZQHo9mS7Ucznq4DIysoWZyvlTmmTjn2JGAScjc1rFPNdqOJqvpaPR8FAvo4SANJugKzSD7YoEtujMAOc0TSTYj01/o/dOtLRyan3AicsNCtZKFFWc9PMRvc5bzRRjDHSMq/BMY/5mhP0aL5xtwtn7NlcjGfcR+FrBUGrat+3K3N55ezesbBOb5f78dDG6mLfCIeO3Wn0jWyIOmzRjbrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rg8r101PC/WVtdLzATPvruAR6bWooPSpZBHKszKpDLc=;
 b=Q5peD/7b2nV99p7HYWtUm3bFf7GffnalYQhmwdDB3UI4QX2rduePG5nPfEVgMkeMTu/anz9PBvNAVeV+MslszNmxDu7mfAFVmC9u066qT4ctaLwvM5llv1vyJkuAjeK9h/j7b73TIEYdjUhWcrFFKIw0DtYvvZx36LtsXXRz28o6fTbFjT4QAC7FiA/FxK8ykkX8wZPQwm4wx+VxNtWWgPmmHGxbcQNCgnw3OOBk1JZHzRs25cBDVtCQT4Z4ZVybo0vq0r9uRyc/mPgCAiphl9/RaGm6E5geGayb2XfHSHI4BoBhUhuJnE0xaVqICABBTffqzxIvy2WtwiuguYrMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rg8r101PC/WVtdLzATPvruAR6bWooPSpZBHKszKpDLc=;
 b=QVpPyULSg4zuIPWaTo709M76SPOJpSCUdp2R/Irn3yIX9KyP+tc16bm4vadjse9vlx97twTwvqKowqgHfDiRXkZUuH+tUUiwEkwTReuozbOHTR7mXnLgI8VNAc5h7QiUuiEVaWkEfa0TrRHkXj58yi6Ggag4N96zxHL0YxvIpGw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB7060.namprd04.prod.outlook.com (2603:10b6:a03:223::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 08:15:45 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:15:45 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 11/11] nvme: Add explicitly host to allow_host
 list
Thread-Topic: [PATCH blktests v1 11/11] nvme: Add explicitly host to
 allow_host list
Thread-Index: AQHZv79Io1HdxWhQwUSyrN2PI2zcrq/O1+oA
Date:   Fri, 28 Jul 2023 08:15:45 +0000
Message-ID: <4eztk7hhup2le6nqd4u4udvdrek3sngrljfr22b7rnhaqcr4of@aoe2j52jfwzb>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-12-dwagner@suse.de>
In-Reply-To: <20230726124644.12619-12-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB7060:EE_
x-ms-office365-filtering-correlation-id: 9d6769dc-bdd3-4644-4a84-08db8f42d7f8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vUxZPvhv2CKqKXNY7A+emho6vPt0kFggwLmf7tcPfSJYc+22e/d1tOysbFzxzhHoZm0nRW6ruVoNLHji4a8mDyAOiU4it1dWatYSS8MruzJt2tuHm+B3rYGIDH/NPoM/h3WBZbg11mW4oNEo5SejZW7p7YKOT2y8DdFmEP3kbDwantB7pQ4BUI8lo4AFFF5IqJZ4nsCUMI9iFs9mq4/OAyPrz5u5/FPWNhgRF1G4NNMZxXQ2PsQ82x+zAILX3+JL9Y4pslg3gpaBnbjagbGkZX3yVuq5JyumWYtBUDYsryYDDCFWGwcrSTkdtD1VCJuerBTBpcY5H3HU5sqYx20jNHrFaZttmIR1mbH8JM6+qnRC3Yd31UqDQ7z3J0ugaPVT7IHOifovOt93fx1GdGWVwEihtRUW+9mzibPkvb6eZjCe6E6HIKuDangfDJtWieHjNha8HMUxoQaTMIN52tiumYo1rGBacDIFzanjO/Ay9Xcst4VecUJ2EW2h5qjGsbpSgPMpo0NPWmQcJKJ8FLxD/EMeeMhBjgrqeEexxdFN0yrz+TWEjPntHkZFDAt7qXIVlJZxztLWcbvRjQLiFMOcElO1DN0HBN7nRLfMGDFeqok2gc1wrB4rBs+Q7JZ6ZGx6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(38070700005)(83380400001)(122000001)(66946007)(86362001)(66476007)(38100700002)(82960400001)(5660300002)(44832011)(66446008)(316002)(4326008)(6916009)(66556008)(41300700001)(64756008)(8676002)(8936002)(6512007)(91956017)(6486002)(9686003)(6506007)(71200400001)(186003)(76116006)(26005)(478600001)(54906003)(33716001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ehbyyWGeeJbRgzyaEOBx6FzbHN9RjVj6hHpsG/DexXOELRMZUmXfBC5QZ87x?=
 =?us-ascii?Q?2PZw8sVWx6RzljAJaF4bxUhdYYYqi7qBL2q4MzzhN9hDrljOJfBLlSLn4rTe?=
 =?us-ascii?Q?zwCobwQQ0PNBHEIxDnbHmN7xQw3kSkf23Nkbg50bO5ZWJ7ZKB7F0e1N0Rff3?=
 =?us-ascii?Q?+8KVuGKJmyLdOTMBQoa8ba8nn5MZzUpqOlKOuqp2/ZqLG4Od9syUQeI1INgo?=
 =?us-ascii?Q?T45p9HuyopA80UY1D6I2utT/Ev/+VZ8YmRyomKT8Rh5bG0k/+OQ30ihAVXVw?=
 =?us-ascii?Q?f20GyDTpows3Jt58pvRJbeaxw0uHWpJ2bKpb7v4AnON1m3lpr6A5VbVyghPB?=
 =?us-ascii?Q?u3RoAXrWRjKlzjVhdynB5EQbgWThQ49NP7cWSFxkYTwT6znMhgX21UNWxoat?=
 =?us-ascii?Q?cO43nBTuhePVdxNzi2gNI5KkfhyuNqrr69XI/r65d5yjLJoEONVhn3nU0U7e?=
 =?us-ascii?Q?2WAIH0UvwWuFvGiPG1coZVXDrU13NQRtL8axxbpOEgZZ0qdxS+aB5QCOkPhV?=
 =?us-ascii?Q?Qy9FdpuOoDd576wBRPnGi3ok8RZ8xwBSvhYuRRgE7Ft0AbK7qD+ROt+7Rok7?=
 =?us-ascii?Q?yRRPO0Bn1YIH5O620lKIt4ZUK5y73F0I+217KrotNElI/G53f5dP6gp811AJ?=
 =?us-ascii?Q?+4tOzXoWIxqPa4Yr5O9/aH6lZKf3/6Z0tfPUi4aEkjRs2eZ/x/IKDt9XLbZi?=
 =?us-ascii?Q?s7MVqfa0l1T0HB5r3QDkSs/e5IlDOfaL3PnfisxXTWEb1sIhWQjoSL83lFeG?=
 =?us-ascii?Q?mZPLDlOxOhcRMzYSsk+kFi6ROv58BXx+7VIkbFavNTg4nYUvzbQJ1f6UuoUr?=
 =?us-ascii?Q?ni6pS/HeDbPHLQ0r7dMaw1/1WtGGg5Ef62unjONIgsdhPlDInGc0YejKFvCS?=
 =?us-ascii?Q?Hz5wzktUJucosgyKnWNBFxPc2KqvjuwB3lX+dY+IymCEjfuZidCZlFHJXn9j?=
 =?us-ascii?Q?GYfVsK3I7hof4ir336aJdJaiVE0gfYe9AKl6KgIsPL8MfCwn8HAoq0qkZryG?=
 =?us-ascii?Q?OGc89ZHdaPJab9pifQNZKtxVmRDe/5VLAPGV0q/0lRo4HvQpyGFbscy/02h0?=
 =?us-ascii?Q?Z/jYWjOhE+zOfjp3NksDoHZy1jnzJQixWI5/GBhifxAgtrxy4NHvkpArQCNI?=
 =?us-ascii?Q?iJ6H++toskb7kDazodJKe53pJdkHSL+p7omAZluXREaRNeRRkWMI+pgtJufi?=
 =?us-ascii?Q?wESgBZ37aJLmTHqxmyUsTP0Ign5Hvjav4iqKQrEhiZOVHSV0iF3xHeWHME7s?=
 =?us-ascii?Q?Vhf/MBU4Dtz1DPpB/u1CBK15Sj1VxLCmyJKc7aXNnqYWI7dUtxejtMNaf9OK?=
 =?us-ascii?Q?rATwPzL4Hon9GfTp+J9D+UwQnaSYXxL5jsbyXPHs4//cwxurRcEmqyiEmYR/?=
 =?us-ascii?Q?/B9J+KyO2GMS3SacwIPmFTJ247TBS3308o+42uB45mmyUiYLIf5HMB/fJPFk?=
 =?us-ascii?Q?lBszPCpC+Qq9omoZDF62hr5/9kmqqSQiFbKqYnNP5bgPQBD6Xvpdn2oGLTJ6?=
 =?us-ascii?Q?jQOzIpVTcy05WzYQsHiojGvvyxR7S7/0ga0wK40dFzDugo4OmRMSrvir5SUD?=
 =?us-ascii?Q?XenDwOZRKsBtCDG7bv9hrc4PmG31faCmBVxCIjhg+2+iZRunUmQDtpAt5Mcy?=
 =?us-ascii?Q?KepvlMFNzSAWYt7j4mOKc34=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E61C1B5E3F998B43982EC5079A7939A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?VnG9Z9vgE7jsXGlXP01/F91ig3j/jJ2iYasXDNlaPjYPSZhixtNt3Qt9z9kU?=
 =?us-ascii?Q?jjZvGiGlRhOD84jxdnyCBO1Nre7k6Vl+CBJmVZGdGipEWwa3u7vjcuxcbWbh?=
 =?us-ascii?Q?9tz7SfEZcXqbmYCOE3PeMlmE4I3/vOfY8bh+K8EmwtmWkrgyNC+b3BeBsuTT?=
 =?us-ascii?Q?pzYeAfBCAES2LhWneoMYYGVd8+bSScPRilpI6E4+rFKRLW1wN0TGlGEqHly/?=
 =?us-ascii?Q?5sy7sSZ8prpivWyvaKrAPWfC+5GR0Euhew3aDdMsO+KPxd5Wy5BRVod3WMjd?=
 =?us-ascii?Q?l3A74IA1yw1rvDmY8xUcFdevdvRsatUfFg1R9U+HaNKgXmnlKKcKRTCH7wkW?=
 =?us-ascii?Q?GAMA+SDVvSIw7I4zITUsQjCiL474XVRnxkTCldQlinXkdY7K94CKW00+5jAi?=
 =?us-ascii?Q?kIoFHctb9ok2kxRRMdK4CtDr5pz+MgJvyIxC12ZjQ4FdnA5ioYNpreyEn4wb?=
 =?us-ascii?Q?4OvgRP8da6Fqxj+uBc4kxn///SuBatiIXYt8JQNzD6/sVxNSAeuxuGcr1IUX?=
 =?us-ascii?Q?3+cU1sD3llIMRS7CUR2X86LEaN6isMvakmA/+IkIiblLW5tAr7uAaY4ll/BT?=
 =?us-ascii?Q?4gg+W+fwlQzLyiV4e6tozpVofgpqkDq3VnDNonv5DVn4IWPV8GkBFH8Dwz6S?=
 =?us-ascii?Q?lviIJBrF/qywy8cg/3uxfMKDK+m8LO49Fn6skF1amCZ37ZoXPAubVx8+jHo2?=
 =?us-ascii?Q?oEYu+3Ym0Adf7Ele4lVsqf+cjjvsQCbd3Q51CblWsCHMw7FX5CDWjkp2cOvx?=
 =?us-ascii?Q?Vm9AnbzO6AS8HC+jWjKvvoZT1tzEO3EonI+zjseS+MPGd9/lEWe6rZSh1FBq?=
 =?us-ascii?Q?28Sx1z7Ko9aZUr4asE17tjjHWTh0U/yf+e69bwkGxVOy0L7pfAgbNjMoTbDF?=
 =?us-ascii?Q?Dp9cbRpe9rctCEGz40wnXAOtVhbaE2lohUP2K88Q0E2QyCEcyC887La01jpk?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6769dc-bdd3-4644-4a84-08db8f42d7f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 08:15:45.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zLI2nfY2WiloeAwPCpoGMvWPSBaVYPAT3twUVpTiab3Qox9rksozRxzdB1EHzUUV/UtcJMibgpBEB9e2aealNMbIGCHN8sFOHN20DPuaG7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7060
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 26, 2023 / 14:46, Daniel Wagner wrote:
> Only allow to connect to our setup target with the correct hostnqn.
>=20
> Thus we have to explicitly add the test hostnqn to the test subsysnqn
> allow_host list.

[...]

> --- a/tests/nvme/030
> +++ b/tests/nvme/030
> @@ -28,6 +28,7 @@ test() {
> =20
>  	_create_nvmet_subsystem "${subsys}1" "$(losetup -f)"
>  	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
> +	_create_nvmet_host "${subsys}1" "${def_hostnqn}"
> =20
>  	genctr=3D$(_discovery_genctr)
> =20
> @@ -36,13 +37,13 @@ test() {
> =20
>  	genctr=3D$(_check_genctr "${genctr}" "adding a subsystem to a port")
> =20
> -	echo 0 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
> +	_add_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
> =20
> -	genctr=3D$(_check_genctr "${genctr}" "clearing attr_allow_any_host")
> +	genctr=3D$(_check_genctr "${genctr}" "adding host to allow_hosts")
> =20
> -	echo 1 > "${NVMET_CFS}/subsystems/${subsys}2/attr_allow_any_host"
> +	_remove_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
> =20
> -	genctr=3D$(_check_genctr "${genctr}" "setting attr_allow_any_host")
> +	genctr=3D$(_check_genctr "${genctr}" "removing host from allow_hosts")
> =20
>  	_remove_nvmet_subsystem_from_port "${port}" "${subsys}2"
>  	_remove_nvmet_subsystem "${subsys}2"

The hunk above looks different from other changes. Is it changing test
content slightly to meet request by Max? If so, it would be good to note
in the commit message.=
