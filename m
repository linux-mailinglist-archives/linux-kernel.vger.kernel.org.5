Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74B8778743
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjHKGEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKGEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:04:41 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4430270F;
        Thu, 10 Aug 2023 23:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691733880; x=1723269880;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F/SPmNZxm9uOQw4jAZRNulbU9gZ3eJG4IOB+2ll2MPU=;
  b=Mh22jkFIysb1pmW42W/SE2AnEQEZl3hRQZ55+WIDKCEtVO0hOoVyaRaI
   jEomIqlYXkHDt6Yc2PMXhRKLdB8tEcJMwFP/23lb2BjXh4/Jj8KYnnjl9
   YE62E4AhkOvPV1eAQrtb8rNj/nlPFBI7/YweuwptiACt/8BsM/vAyTacA
   QaKMux7DgzOJbkP8F6LcXIJtnf5BRaDP1QGWhq3iIosTOZmU6RNk2v0eV
   Dcr05kOTtDNm0Em0Fhjl7qLb/OhYjyONhqOnVtgXGubDRYiNAnuF8/Alb
   Xe6ESGIgGF93R2ja1AoAWr8F+6n8JZBM2nGrI7kyrl17dFdDUPk7kUa/O
   A==;
X-IronPort-AV: E=Sophos;i="6.01,164,1684771200"; 
   d="scan'208";a="352741598"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2023 14:04:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzagmNlj5fu47cVyW842B6DPYGEILNyegy4IRRYfXbR9syKTnsEXRr/2JKMOWiFTL9AKoHnkYfIBg4w8M1sN77JeZs4pYMqEj/1cxI28TmQMtEi6A11kByxTJ/ciCTi7SziQtkO497I7/lOOWcPgBvvIUWGWGrDeWHiydvpsgmwKmHS0i8CONhnxTe4uTZcXPEdLVE5sWGNcIdN1m9GqitoATI/NAdzronjNvU7H7JnLOq1H8jWUECd8lxipCBfrEY1sdOg7R91WY/iaLjIbzMvheS1JCP7BrvBGxWqF10hJawi4rNl8bBROdLliYqEebgJsfNlxTmxTsNdvrcpQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdATc67QuqjlA90mGX8l6KMOlaNl9Kfd41FsRls1A0Q=;
 b=BcTBnEK8WCZ/+9CGhhEWpY1Zw7yDt77qtKCyUD7U8vkNeQmB3WFJnZ38ljmv5CcfvFjEJaxEM0ZON+Z0oLW44fpAx0Hbvzo3QPAgFHyh0VLEwXUDHjSSdfbA+dTUWdj7OrOXomCYI/5Eh5oNXAsuYGLKgjQ3Erp/Ty9Y9/O7ZQA9Qj7exfBWi1BsJ+UjthUQKF/bQ1Uwu4AQeKTPCCMtDmB4FlMPBEoJ7ytRkQh3xPcWA2916H9GE+TzlXCPPULldNaAu3P2C0Ax5MLnolLHohY+M9OfTsNZ3o0wW54TpSzxafvwGaoIXNuJjJWiDZipRqkFn/6b8XyH89iMteteaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdATc67QuqjlA90mGX8l6KMOlaNl9Kfd41FsRls1A0Q=;
 b=DL+7ww9H6Pp76npHlPLJtKC3s69J6Fp0Y52b+shuHKJOCauj6elT4zHJ0kvdlqu2wkIUiWdVL8bstNdmm8Ar9r6xGNRTon94eyofsrxWm+41hgZY69GMXWtKc4/xqTdyjerHSN3jGljn7QU5QquEcQzC7spLrpvzfQniAZ++aPw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA3PR04MB8716.namprd04.prod.outlook.com (2603:10b6:806:303::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 06:04:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 06:04:37 +0000
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
Subject: Re: [PATCH blktests v2 10/12] nvme/rc: Add helper for adding/removing
 to allow list
Thread-Topic: [PATCH blktests v2 10/12] nvme/rc: Add helper for
 adding/removing to allow list
Thread-Index: AQHZy3u1fMRsxHhKcUS1Ga0VIzgeOK/knHKA
Date:   Fri, 11 Aug 2023 06:04:37 +0000
Message-ID: <tcmawhgj55ax4beeaxulc47aptx6ufuwa7vjdmkncvat4x2jfc@pqcikxb2edxy>
References: <20230810111317.25273-1-dwagner@suse.de>
 <20230810111317.25273-11-dwagner@suse.de>
In-Reply-To: <20230810111317.25273-11-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA3PR04MB8716:EE_
x-ms-office365-filtering-correlation-id: da350333-5970-4924-962a-08db9a30d818
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMS/eO5qz95uu84HOgP/8cMfVqyqqUxSG9HVyttcQELrOVRMLE8ysD2JmDjhYrYiAoUqpdgyi1CgBkhH+25Qu9OASSkpADGQ/lZ8gIZZQ7BSfUTImgSoWW5u1UXrBMfW5fSwnAwK9XWqDsUobBCbR5PdLd9KK0+jdAPh9/QJ9WtypxLq/PkqK+a/HtsWGkHgDUoNWLeM6cGWFBu2KYq2U4/yDdbde6bSpOdQr4eyLkFWFnwmye+UeVNvPMAdtXrDm9P2rFPEALnYGcrV9pA29CkmALNk+Cwo19qhefOUlOJRSeycDJG6BKYu2xKwxJOc8PvIoujyUaJTqJ733uXHFGf0fjgbo35iGWbgY/yXJ2KdyN/vbgKld3Yvx7Ttyrsj/6J0Dh+EiKBeGSoRcUFnATi5xSfXFgJ/+DnJycVh1PSqx5bXCBqnIYuMnYRlYV+dbHTC1SygdBMFIQuXPvSJdTwJ1/SCrtbPsK8wyihoJWdhVh/0geuxqOXL8uleySk5qtzcfc9QW5UGOnIr6gJhZElfPmsquWa0xNY1X1YAUol4oLo9+a2wrcetGNCQrxo0yRqik6Dkl419k0NRmSsEHleXP7Lr5+SciBnxu+BPaj9f1G2P+/+ei/QPf05UOXVb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(1800799006)(186006)(83380400001)(38100700002)(54906003)(478600001)(91956017)(122000001)(86362001)(2906002)(9686003)(6512007)(82960400001)(71200400001)(7416002)(6486002)(66946007)(8936002)(38070700005)(44832011)(41300700001)(5660300002)(8676002)(66476007)(66446008)(66556008)(76116006)(64756008)(6916009)(316002)(4326008)(26005)(33716001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8bHQrx1PxEhsQBUAIJAqLYLarn0dMeVpUKHD1FYAljW8310CcILMBc70Dp6Y?=
 =?us-ascii?Q?ynV5VN1P+hpDdNqsT0lEpAXKMSNvlM+SqHJBSuvB9FKDtgYDTxbNd+2TY6wD?=
 =?us-ascii?Q?7eB3x3XAXI5khtxIJU4ROv5JGh91cstpjjMkeu1GD100dZSQNphwHWRZjZBk?=
 =?us-ascii?Q?O70E4p6o8ZBOpDLXFB8FQOTn0k1q8WpL/6BUUPg4h+1Y+szV5GvuD1kMfI2n?=
 =?us-ascii?Q?xEWlC5EtPsa2tswcGIgqWgdDruloDHyAiTNnYXlypssvqt4qDH2tOjX11GvF?=
 =?us-ascii?Q?jfwgPqJmXqpygdtTg+xTkT2PNzD7V98tcUfO7I7Yo+IbKgSnrko45iYhAtTN?=
 =?us-ascii?Q?uOj1Py0+NFbvx4B4ukISO51ByPkK662TIHn49ND10G+bSzBaPrPn9zw+Ds21?=
 =?us-ascii?Q?BLZwMvvh3ZAuzzoXFjR+nlmsNwn45pNji0khfbkU07umQELdWEBbphvAOgUd?=
 =?us-ascii?Q?ZP/fF8fY+lN1Gy5ODUDd4pYlZupOj//GLWUdSrGWQ79soKEzgXQZcJ/DGLkO?=
 =?us-ascii?Q?ldCRg+aqMwsiC4zVImRJrwx5zBCPa2fmgtPvkUXM3JA4H0BI4gS44qjxCF9y?=
 =?us-ascii?Q?iAaiVtx995I/6W67+i/plHpoRNCVjZhkzQfuVVZLW41PNx0eYFySX1rC4VIN?=
 =?us-ascii?Q?64KNDbuKNHu5vQ9O0Vpfycz7AK1CswkgNnFoVk7A4grRRC11zVOfV5jXsDzt?=
 =?us-ascii?Q?EF+LSRzX0iNMZgUsAmIfIngYYVEvln0ZPro5+gGuLy/RAOmWz487SVI7UuS5?=
 =?us-ascii?Q?D9zwYBJD/I/799zuzS5JjBz08fO2BvxD2PaCjDqNf7ihWHH3WGo6Q64cWRWr?=
 =?us-ascii?Q?xKiqb89gFu2mQrRvOffMM2ABh6OW06VM4Vk06f1tZJENZk/5DMsf+Fkse5Ry?=
 =?us-ascii?Q?7D6k9UiitIX7d95I0LfeaXRp16vJvuCOX80O7ffFql2HI/UGmIE0sK+4pE8e?=
 =?us-ascii?Q?EbGEgZqQ4h3zYKT9Jo9Z3l0UlNefSmO9H1qqCdQH3rsheRy0jb73+rD09tTT?=
 =?us-ascii?Q?XMm07M592V7HGdPGUD+Ybc+q3r1QsJMxfAWR9aYy+HeN4b69elz+p9wsQXjl?=
 =?us-ascii?Q?dzOldDyUIy8T98R/GuwL7FluQrLy2XloQPd9ezApLFVo73AdhOuj/LPVV7o7?=
 =?us-ascii?Q?RoOcg/OxyzcIkQjWfljct7eUlMCXQNS6SSN4VgpXqFnkeCw5KrxdQL5pdDWp?=
 =?us-ascii?Q?qoNlyv/3MLOAsZk87DAHtU9n/Ui+xrpW3/8r66Sc8x28v4YTp0K2TewfCE3G?=
 =?us-ascii?Q?yh3lHxNCNDIN3r+7opeIafVFAQyZ8Vcl/Au5Hz3Z+b2d6t3ZotYI53xYIswC?=
 =?us-ascii?Q?FZhnniCz/Yjy1+SomH41PErLPFbPBLi21HEwbQ/LBrLAwpmhObwqGlcodxy+?=
 =?us-ascii?Q?XrejSVJWQ7mVf6nIhxM3EpTpUuvz8TX+1xUr2Qtjjlznw+c9n6djhqsovNnE?=
 =?us-ascii?Q?kWBd4oEhOjGitgsw0BemJZ/fJOX9Pkouv0nPUMmj63aJl/yy6x6qUkKP6HMK?=
 =?us-ascii?Q?udE5Kzy7cc+sJvB9CurJUeYWAA0ja+95o7G+vkz/0SgErz3yWZThOWIn79EQ?=
 =?us-ascii?Q?aDFLWn2/w/s8b076nORIaYGLfuunF1NIf6pQt2vfSbbSTD3zxgOYUpcq8X8A?=
 =?us-ascii?Q?6dZEmWmwyi2PUS1LV5TXpi8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C52C2F00D2A88D40B89DEA9BEF2167A8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?chg0zisyqIugo/BzNFTJbIw6vqQplGOVrQFdJXopbIdws9A4nWfJnI7cBzKx?=
 =?us-ascii?Q?ASVAzj2dUg8xFyQ/GtL0QLOd92TFfXKVy3WExTQqWTjIHcMzrgHS6ohRLv/g?=
 =?us-ascii?Q?fSxun6aE0CMh/uzYT8Yxa6VmwZZ4Pu6V6T8TXWLFb/cVINE4qJmWGaglB7B5?=
 =?us-ascii?Q?mwz3/5kOKvHRhwsjTM885mxc7nzQ0M/Y4ZSAdlsrnaUIclkKYcCgpuDsnMDO?=
 =?us-ascii?Q?YGK2q1SEG+Ua2LF4UoZe03UbzN3sCTgtFj+QrzrPwiorAtyRh+WQnDXGaDcj?=
 =?us-ascii?Q?wJiEn3vNSOfo9Q12/98HxJI2O0THecYNWgZ+tkf3NVNUtmD/Ber1yctcReIk?=
 =?us-ascii?Q?XzB7y6BxEs1JdWlYU9UQWwULH5+giPFzKMfmoSVUkFHeJ+AXJkO9OuXgME/X?=
 =?us-ascii?Q?MYSg18O5Dka7Nx0IMFGljtBHmvIMIWOO6y4g3zU3A+6q28jpUNjjhYfPZlaG?=
 =?us-ascii?Q?7oE/vopQ79/vZNfMX6ifTGmj1duzXxQ7v8rhGXP5qXyXUvAYlCcm4Srx8oPT?=
 =?us-ascii?Q?wagz2LQCFfWcN7nMrBgk3nDYL47vr/d6+HJ+6YR7sVWpyb/LkJDyn1gzQy/O?=
 =?us-ascii?Q?GFjYUz2Vy6QnYtG4s+iGujo5qwhAwulE/M8JU0lCJj7oa0yAuyn7B1ReefPb?=
 =?us-ascii?Q?ujXgPj34fXzVW+yTKCjUj10pOyZXRQ3PvrVl0ubNkmzLzuguWttSUfi4aVHV?=
 =?us-ascii?Q?KdbhI5Iw7uJ/wOnVWzsQ0CXvE/5Ss8WI0Wy9GuWxPgDEpqeEuEM/JnBfOCxK?=
 =?us-ascii?Q?pjt6taA5wAdpXk5Fq5tj72olvXrnMGlxZIdyESJf63YlcsXPPLBPxWf5R1ay?=
 =?us-ascii?Q?zukqOu7h9ab2sLOSqPhnM5xHp0k0+VeyYIbtGgL4gt4YRW/j6U0e3e0AZ9TK?=
 =?us-ascii?Q?FSkzC0SoLsxyf6Wl4rogjl9k7WStmIr7nD42ecGMVmX1wiY664wS626luyO6?=
 =?us-ascii?Q?iivHtUxIi85JzzaYVL2hrg=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da350333-5970-4924-962a-08db9a30d818
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 06:04:37.7598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3fwExGhsNCAXCN+CkatQi615gRc70D/BQZGMfnwQLygFOJb4v01KRZjDF8yI/bRPocFv2kbl/MGYx7qcK8tbbgg+4se0EYMun15xzabYT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8716
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
> Add two helpers to add or remove the host from the allow list of the
> subsystem.
>=20
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/rc | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 7f5829a2e58d..706f95d74a4b 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -612,6 +612,23 @@ _create_nvmet_subsystem() {
>  	_create_nvmet_ns "${nvmet_subsystem}" "1" "${blkdev}" "${uuid}"
>  }
> =20
> +_add_nvmet_allow_hosts() {
> +	local nvmet_subsystem=3D"$1"
> +	local nvmet_hostnqn=3D"$2"
> +	local cfs_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +	local host_path=3D"${NVMET_CFS}/hosts/${nvmet_hostnqn}"
> +
> +	ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
> +}
> +
> +_remove_nvmet_allow_hosts() {
> +	local nvmet_subsystem=3D"$1"
> +	local nvmet_hostnqn=3D"$2"
> +	local cfs_path=3D"${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> +
> +	rm "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
> +}
> +
>  _create_nvmet_host() {
>  	local nvmet_subsystem=3D"$1"
>  	local nvmet_hostnqn=3D"$2"
> @@ -621,8 +638,7 @@ _create_nvmet_host() {
>  	local host_path=3D"${NVMET_CFS}/hosts/${nvmet_hostnqn}"
> =20
>  	mkdir "${host_path}"
> -	echo 0 > "${cfs_path}/attr_allow_any_host"
> -	ln -s "${host_path}" "${cfs_path}/allowed_hosts/${nvmet_hostnqn}"
> +	_add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"

Nit: with this change, local variable cfs_path is no longer required in
_create_nvmet_host(). I suggest to remove it in this patch.

>  	if [[ "${nvmet_hostkey}" ]] ; then
>  		echo "${nvmet_hostkey}" > "${host_path}/dhchap_key"
>  	fi
> --=20
> 2.41.0
> =
