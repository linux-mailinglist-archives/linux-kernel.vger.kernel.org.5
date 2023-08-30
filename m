Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4ED078DBDB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238573AbjH3Sh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244646AbjH3NiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:38:12 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857AD1B0;
        Wed, 30 Aug 2023 06:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693402688; x=1724938688;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XxD+oyz5sNvFB4npsD15z1OsVvfTty3wBEXpT07aPRQ=;
  b=czk8Zx7aoggYXQf09fgWTUfjIXNfazB52XiQCgLCCkAJS1Qnu7Fshank
   +MH/Oaot8V/K7qrS0OB63J2OkaFumpcq2SH3rsJlvjjU/ZXr4Z54PSHMF
   zTSa4bNqsfuqp3UZH83lQOa6hKScHNEy7gI7jAv0thvl3SP96S1Lp7gxw
   F4Tb94YmzCNSSlb8KtUWsEzk9hdO3uawWU5YaXWBBXanR1HDgwi3uAEW3
   o7442bgPG7Aup1vEtbnfFS3wJjFNfO+xkviWHBuGQhlF9lGS9+uBAq9Ie
   796Cp90yD58Krx0gQRucOv42b5xjnFbSOIuFmh2i9lj9hq5ABeK8KUOgV
   A==;
X-IronPort-AV: E=Sophos;i="6.02,213,1688400000"; 
   d="scan'208";a="347771448"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2023 21:38:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5t3bokukoGqrW4iHECNvpXnXFRevDzw1q3MxnbSCy7k+p0wiom1Ez52ModB1Idr91vXaLDfhS89xxVJi8QTYvH12dJJnbyuVh/siaWtz+pxwdXZRx/QVV5orUWK9fF8vavCULsfIjaqZ422SD1SMfo4vlb3nonm0NPO/dXTFIPnqPFx/r4QNnmVc5+6HmOds6FBGsF/rQOyyUGVtukzaP+/hu8StYrw4u3zeUupPlDqJ05qka/mdWoV2rGYyLBEx52xQ68XczvHcXeuAhfWLXXN0Qr/EdQueYq6zYKkexsdzSZDcd4+mEPf9IkEmo671equbiQd00PzgV+pALbCAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ms3xnnyByKdosR/SJeiQchiLbMQCLRMOWa2E5ATnkkg=;
 b=THpIQmrPwTZhD6XE79TNIp0npXvek3Haf8i3LCUcJ3saEhLwl6Wjna6K9XfRFQjbU8TLIARhU8wDbtNu4rVYcAwTnc1zwirB0mSbZpqefEVwN7WSHXMT47Yi4n1YVPxWHyiO0n5AqiZy+Oq34l+LSAv46D31zE0+f0IbUJrrQaXvj3+KEO5gDQ2lTXkYDFVBz7P1hS6GqqB8BMtb5955RmBe0RVWFNvJK/RxzIkNDVXqv/xDPT+m0CSSbNwPTRYETM407dEChlJf3CmKiBAGMK9WefPjCcwrEGEY2kojYaYt/sq8eUvQYerCCQ79TieAjHKPPMrXb/ARq7tdAhOuDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ms3xnnyByKdosR/SJeiQchiLbMQCLRMOWa2E5ATnkkg=;
 b=J3EaclX7tF5xBLvdzmfiCYakikFzF2xKC4Pz5YFlcJCnCmcq+1Mpt1EjtR8GmaSr3MAkKT8WbaRb4EsOFO9TkPiL0LkI1kS2EokwHja9+nCUtGN5nwgSkiVyzOrVD/nuEbGiJzwryaGCQgjdrB3fV/amXdfy445yWZ9muWyQueU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA0PR04MB7452.namprd04.prod.outlook.com (2603:10b6:806:e2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18; Wed, 30 Aug 2023 13:38:04 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6768.009; Wed, 30 Aug 2023
 13:38:03 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v4 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Topic: [PATCH blktests v4 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Thread-Index: AQHZ2yM7D30ZgvpqvUqaelpgiH585LAC2B4A
Date:   Wed, 30 Aug 2023 13:38:03 +0000
Message-ID: <fhwbcvhmm57c55ozfgtczcix42zri63cswjavre46l42tmzgo7@3krpokexbslw>
References: <20230830092019.9846-1-dwagner@suse.de>
 <20230830092019.9846-4-dwagner@suse.de>
In-Reply-To: <20230830092019.9846-4-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA0PR04MB7452:EE_
x-ms-office365-filtering-correlation-id: 651351db-8d09-4bd6-8c16-08dba95e55fe
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyzsyzkSAUKpZKQGhkAWQZDsuTvYsZnvrdUzwdLTh344drHcTPugR12pzlkkv8RIhtGh40+TD9ch9VuaZ/n9kNuyCnqJWGACM0jtgHbIgxfXU3ib/BKMLtLNJncJ7auDDxvG5eSaMHmHUD45f5dVQm67OBvCOl1J9vaptXJq/Nq2n0C6f3++NzyGbmfM6SM2rDli4CCHj3C4UrB73alw8QPghdfqR13YuutRkSatvMmp7DhZXV5uZY8CHxpPlyumanRB8HZJM3VP+YkZgJZBp6vV/emFBJRDIiVaws+JQmz8h42SSEq2FLejAj8CVZh7A7sb3na70eeczOve5YQXHuGhb4Qbbx6YZ2ktsWho6Be6vRlGsLeVoEmgaeYxn9ESnSbBGoMEYvoJBqGy/3zptjAyuTbf+Be+iuMvc7zMe/S1589KTd6j9cP6G53atdpXyRFBvL99bzumojDccmJW0nFIHu7wS59dxOyqCFQvUjrSvja5ecAoZMEIyBflx8+L8vPKhzYsUTg/4jJSO/lssLPesGE30U4zBiOYixk9r5bBbdUNGoVCupwnQ21DdFFd1EYTrfHd4/PJBzvI6BFtRmuiTuwTzuEcwg2AX/dW9E6MFQMio2HkDPl7RlJ0KW9U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(8936002)(122000001)(91956017)(66946007)(76116006)(478600001)(6506007)(71200400001)(66556008)(64756008)(66476007)(54906003)(6486002)(66446008)(316002)(38100700002)(38070700005)(41300700001)(82960400001)(6512007)(9686003)(5660300002)(8676002)(44832011)(26005)(2906002)(6916009)(33716001)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a8cyhGk7YHgjA/6UGZtF/r8whK5VujILrJjATDY7wYCcDfumaETY8Cpi0t+u?=
 =?us-ascii?Q?aPwa9xoaKqXNauRVAW3IonNdKpgX4rtRic425V+emFctKBM+WLWfJsHF67BW?=
 =?us-ascii?Q?RHGW+5CieDwpF1QEpgdRzCtGwalaV7R8OtTcj31YWwRy9fpeiIW41dNFe08K?=
 =?us-ascii?Q?VHbJO+H0KW4v0R/2Tf5HNwMCOir7wXwFPYpwEreiS2FgeO5SLQ9xjkINr3BB?=
 =?us-ascii?Q?8K0r+fY8fUWp2ZESzebVpHzcCg5EQO7KdklqUDz3lmk2u5Oh6QlmziRUklst?=
 =?us-ascii?Q?JC7JjuJvKzU/1wXEidIPKGw5xuxtCNsNNaBcQ3jaDFIo94Or0u6Enwdx6gbK?=
 =?us-ascii?Q?JM+xg/18qelD3LBFQg8aII0nd3u7VrBL6NExfUc5rJ53JrKhf8C/MTbPvkNV?=
 =?us-ascii?Q?L9E/5mgJohZ2umMwC5bcYiTNVye2Nd4o7eUiKqabcEkQkPoFmEb0CnlDcL9/?=
 =?us-ascii?Q?Jwj69iuD8tdbgwIAkWE53UwG+I/yapeLKcywYOj3ZlVw84fKEDXHhrY7f4Ks?=
 =?us-ascii?Q?sp17ovIXCkKJr9sjStnOm3v968US+EW0uDrmY3ou/t1xOVPgcDLB4QcKFGKk?=
 =?us-ascii?Q?aTFBt1RwHWfVjvF629heYP6sFHTbLQDD5zhnquQaFGOdztYu9Fbmk04Bnp9O?=
 =?us-ascii?Q?2hRuo/iNclH+GTQ9SbXukTR12AikVyppg2cBNccxjNX3kZBFkzafXbkbZqUv?=
 =?us-ascii?Q?odgk0VQFWNnNPjzjtuPx8fh/cfGZJxJKqGcpgPsjm10IP1JDfqw/vNA1KN0Z?=
 =?us-ascii?Q?Prg7qqgWgVx4qiEl9xeEq13hF72mP69aS18XEe6AKSvLGbvaggNpra8WGEc8?=
 =?us-ascii?Q?qktJcF1xr5JiVI++WH9wrVk8eKrTH1nHzZFxAeXbBbWnkQB5FCEUN3QvrfqH?=
 =?us-ascii?Q?DXUnLUyDV9zdoeSAAGV23Evz/eCxSwaodQ30AquEy2d9HJbTymWVj0NQdl6F?=
 =?us-ascii?Q?LN+3Xj5UHkc+EiQ11Q8U06CgiBJOs7XDhryQ6uoSZ7tc5eUz49KNAh858a/h?=
 =?us-ascii?Q?y0KKIfEy5Aio0f6JpFDQpAGna5xsr5Z5l0U9hfkn8FOaR7h8fH6NUx6pfHRg?=
 =?us-ascii?Q?zB8CCR4W0eGQrrAX2x/wsisHbUBOWt/Z66ONLr44ew8XaU57zngayZuEimUK?=
 =?us-ascii?Q?MQ0fqpNfAsE9IThPI100MVMaeqnWkXewccXZFB5X6DazJo9Ghd0CYWS1WBNw?=
 =?us-ascii?Q?nmp07Aw5KgOirqRQcmD+LHMGMBuDBMoq154W5b2AdsnxlFCGBuH8BKBw3TiT?=
 =?us-ascii?Q?dUZ/myc0wAD/sCSsYqjrTkO+CQkuwMgM9Ww20aCFN+1d27Pa9LMnc6OBuJV2?=
 =?us-ascii?Q?5AJFtWZOdD4H2dSpLamlRiJmRp/NC5QwNiXJYi5w66iVM5LyiC688gj9rx79?=
 =?us-ascii?Q?VSnO1iqhoNpJtZK6CKUFRUkIp8dCOeHjgi5i14vkyMZ6CJeYgoSsXUdwoFPE?=
 =?us-ascii?Q?bhgKsjwq3LmcMnP8zp/1q6Iuaw0fT6i7njazybmGatsvrNZZhAQY/OeqmIoB?=
 =?us-ascii?Q?mVAM3V2AikYB8IfhhvlmWfTxnGMczB0b4ZbdO/TqEZFxJ40PBe0TyVJkJmy/?=
 =?us-ascii?Q?AfZzV3SQdKLqR5iRN4vf9lJQIC38MvOTUFzIH32LvWDdovooBXqMz8tQyKWO?=
 =?us-ascii?Q?AIs/hfZStF7BDA6pTyy5Cvg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B15C4976A4D30419F80A85CD31E814F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GJxjsPUGQXzjuFa3TbjrQwDxOSLTNEbVeKdCdMxCudX6IwwcRSIUas4xrLSB?=
 =?us-ascii?Q?JZ+Ug+PFzuyYvfO1/0usq0GnXInIKfaArFUreq5cRC6PvBWD1dHwBIPkumZH?=
 =?us-ascii?Q?zu59MmglCEcPvHCCEWDYGYDKvPWxirb9Y+g2f1HXq7xBlyK2YkWKPRgozRO8?=
 =?us-ascii?Q?J6LLBbwtEDdUTf1RY0HD3eF0dRO4zYpZefqTTOXsMDiQIQhL6s4zs2lueJ8R?=
 =?us-ascii?Q?LpI0IKBEQpELJ1W7cYvYuSR6aFRki5Z7EUd4SZdqS6spSgbMxDi2t8/IZ9+0?=
 =?us-ascii?Q?wyGIHKntU7lJdy/Ad3w3v1P+d1MkFDHbarWbcyY9qKVAtPyl3xkxx3jfqa8Z?=
 =?us-ascii?Q?zgoA9aMxXUl+6H8iuCQJ/YOLViylZlaz3frAG5OrHivmuNP7sSCrdn0grrIK?=
 =?us-ascii?Q?Hchk9Eyt4arZfMhn6STUDuhzVfrV3Gu1bj+AKh+Bx+gCWJTCVvGPtDj7DBZD?=
 =?us-ascii?Q?TUzxP0Sr9T5hShYcK0r3yhUwdrXHZtly0XUudRhrIEzoPqmCLmKl3YXf4GHj?=
 =?us-ascii?Q?qXy9OmjCaw3XzqkFu1OM3GejAC3CrtKXBZHUTihARLEQEMIdmDMEddAWabwr?=
 =?us-ascii?Q?TVjk7884xtvSuf2682d3vUm6Bb8r4CR1fxNty5uykoEZDh3K0AIRofhlRa3R?=
 =?us-ascii?Q?1uWClzYEHOZN747z09b5/xx5ZA8jOt0TwrTJfX4cHc/qNLscNOEMBS+0iMqe?=
 =?us-ascii?Q?gt5bFM3ZFjUYg9rV6+uZvKr+BeM8EI6MakU4aqT/KQG7KtxPHafFI4u9rGoo?=
 =?us-ascii?Q?9tNqPtzejcJ4C3b0MOb2yhLLUWBjb8G2Af61Ycq34xG4RPaQVNKKmpxdJ/C3?=
 =?us-ascii?Q?eYkpnTyAPBONwe/GItq5kTqXPdUuFFeYVdKKJjj3xKiHKDkjn62oHr2jGja9?=
 =?us-ascii?Q?asUQrpg992EfikqoqZVWO9Z4SlpSyCXxMSQob6ifWo5dWog0f9a2UTy6cuDa?=
 =?us-ascii?Q?EMF8LQtd9OzAjNJ2oF2ujQ=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651351db-8d09-4bd6-8c16-08dba95e55fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 13:38:03.7539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z5/tBbV07GNGWnPVs7MxXY53TMOp8tP6R0WTVAG7/SQe1j9KU8/Bhsrxxmkn1am4U+sDqoHPlQ4O8A5YukoZm4gSPDRiNlwRAEl5ZYyA/sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7452
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 30, 2023 / 11:20, Daniel Wagner wrote:
> Almost all fabric tests have the identically code for
> setting up and cleaning up the target side. Introduce
> two new helpers.
>=20
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Thanks Daniel for this v4 series. All patches looks good, except one thing
in this patch.

[...]

> diff --git a/tests/nvme/018 b/tests/nvme/018
> index 68729c3cb070..19e439f3f3e0 100755
> --- a/tests/nvme/018
> +++ b/tests/nvme/018
> @@ -21,16 +21,9 @@ test() {
> =20
>  	_setup_nvmet
> =20
> -	local port
>  	local nvmedev
> =20
> -	truncate -s "${nvme_img_size}" "${def_file_path}"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${def_file_path}" \
> -		 "${def_subsys_uuid}"
> -	port=3D"$(_create_nvmet_port "${nvme_trtype}")"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> -	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
> +	_nvmet_target_setup

As I noted for v3, I think the line above should be,

	_nvmet_target_setup --blkdev file

If the change is ok for you, I'll add this fix up and apply the series.

> =20
>  	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
> =20
> @@ -48,12 +41,7 @@ test() {
> =20
>  	_nvme_disconnect_subsys "${def_subsysnqn}"
> =20
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> -	_remove_nvmet_host "${def_hostnqn}"
> -
> -	rm "${def_file_path}"
> +	_nvmet_target_cleanup
> =20
>  	echo "Test complete"
>  }=
