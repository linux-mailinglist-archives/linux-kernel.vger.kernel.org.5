Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453F8766654
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjG1IGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjG1IFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:05:44 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AE03C3C;
        Fri, 28 Jul 2023 01:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690531486; x=1722067486;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QC3nZ7U0H36xnCSR7mS1jyfzCLUVDFznb0j2mXmCK6Y=;
  b=J09ADTAzZ+nLNixoWRrILj/3U4ApM1kn5vxVSgCMl2VT7pDtAGtLwakZ
   yANqalh0Ub9dm4hPxfvyGWFAf4rZ5vXn80OQaPeT4vwpB7ggIxA2x1nNc
   pBwsn8cYhD3wyhTTeyjbMKH3YQV6LToEMP+zzoOHrq5Inr5jIpIQ6hK6j
   kz9jji0ZbZPNMHtqcfgzrnry/XphijKHGa30o9mz9amNmu2LHYkL9QTXA
   F1B6cPPYH9Qqavw7oR9d+pnUTJoLjjDkCCQZh5cBYRtfywQ326qxg+Uet
   98vwzYvuwH5TZ1x5XYR81Z4baZzmqGU7AZnvhDkZRib3UauLPMw4fJcwV
   g==;
X-IronPort-AV: E=Sophos;i="6.01,236,1684771200"; 
   d="scan'208";a="243987105"
Received: from mail-dm3nam02lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2023 16:04:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6f3ELd4qGkQymGyMerPNVzRnTP/r9ISs0ZSV1ZlHVh+RLLIvsYNzB/YSD9xI5IyfMXlewrNx4tqNWHvmESgTncXAS/3DTyShZsSBAJqcrhkkMzgu/CZcraaGcD5jwsU2V/S9rA8rL6rZETlviGV3OBqEShwLt4cPzlZWqxqKJkYqQjanXZO9O+0wFw2OJ9caq2V0mNb5FDRi5rq1GBZL6H4RSmNIVAQz2imcPb0LsfQPcY1hbNhSK+TMsEGGVOmuRM2LYxDU88E7mt0aBISJPLl34TdWxywuCvX4IyR37BuZMUjcHaAh6/aQEKee83hrlNfH3rl2LZ7lFI+DETQLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlmBHc0T3efZXyHTsvaNjOUxFW1nqScjKnOgdpYxFO4=;
 b=ekB1LvEbWuoLfFgZdDTuKdD9fwa7Hbvw08YCZ+UZvWPm5nO5/4CRBQFPfVNMZYbTuu5TtfofUl1nNr9FgIeheX3joVmyn/Pn85ZC6tW1o7p7+dZCE5dYN19t+6Z0m3e04hembkGPACl9XWiLGrIC/zr4B/NDCTEWEWTYVIPJjKEqJ3OmR2U3JLFhjexAhnJ1AWx1MK7GZ1j6HHR51vPAKAsmFQU0LLuNvzaDks1oJX1n7l+7XaQQ5XVlpAatXPJcWwHpVIujTXOLgxnimQypxbaULPVQjmK1l/ChVIdkHUiOerP7cbwoX1fPtXZor6NZKZfhfxApZX9uOgrEry7hbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlmBHc0T3efZXyHTsvaNjOUxFW1nqScjKnOgdpYxFO4=;
 b=FB4SbEdjwkXekExVFJpNI1TfLh1wi32FAxE9Du5nQnrqiexadVps437NakE1v3NOHpNYIebRWbAq1P0hQ70FvWuj3X9wInWsYVTq5c+yBWDb3I+vp6MlXSiaZTaU7dYaYjACeNllfkZ4o8LM6LV9QQ7tmjbz30jTScvH3SUdqtI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB7066.namprd04.prod.outlook.com (2603:10b6:5:242::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Fri, 28 Jul 2023 08:04:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 08:04:41 +0000
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
Subject: Re: [PATCH blktests v1 04/11] nvme: Use def_subsysnqn variable
 instead local variable
Thread-Topic: [PATCH blktests v1 04/11] nvme: Use def_subsysnqn variable
 instead local variable
Thread-Index: AQHZv79I1kiCd2iKNECml+OSVsLt4q/O1NSA
Date:   Fri, 28 Jul 2023 08:04:41 +0000
Message-ID: <yiandzaqpwhcvxrc3xsdtdplxss4nknkiseoiwc2cgokldlyil@deykhee2rr7g>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-5-dwagner@suse.de>
In-Reply-To: <20230726124644.12619-5-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM6PR04MB7066:EE_
x-ms-office365-filtering-correlation-id: 2517a178-7a7a-42a3-a631-08db8f414c2b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FuuRtXLJLU6pI8NK2wFPOHjSEcOAoZQ2mkWJaLsTQmXZskbOvRswz6VF11rpIOgSy0zxqSB+F2YOYDh1Heua7Bc1ABtjaEWVBmjcq3wkQxj48uA7Ieo3GRQJGzrA53SkovDtaX62sDLT9EToBIGk7OpYnUzPbQO/ZsQcPVuXlXu4Wox3o7bKS8CWnzHWk1hz03VYnKfjpK3sHH3aV4bKL9z38P2UYAZn3Lkxy1c1LgkcHx6Tic4ilFRGTU98PJJ1GcKTs4CI/rqwhDXKp4P5atb01Ckj+wWgp/pzFibgsWHiYZRROdgtMF8DXqmI6f5toUg7n23fp0FkojlI1xHxKMFliJQ1Ut7W4kf6aFj/KuD/ON97eap0FiQLPJ2WE6/7UxrTALIJ9ILXzNfpBqaGfn7btBv3OBgKEWHtdBY/ExW/wpr7sPfT2pqVPQS9uPEqEd3yalprJyYH30vmxBbde0/dujjSNQ4fMXoAswYcvIIR7cw2cH0EgHa0ZeQB1dvE4dzb7/NYO8mU48nUALWl2gXAtruS1z4yPCTa0aM+uj60l/z2IkFuHei4/ldbQtIokToBk1Q03vW0F4c+35ZQz/nmLBmMGoyhmwOSEiKGmSoabf1uLVjVJpv7ZZDQ3VYS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199021)(66446008)(41300700001)(33716001)(26005)(86362001)(66556008)(71200400001)(38100700002)(478600001)(122000001)(91956017)(9686003)(6512007)(4326008)(8676002)(6916009)(8936002)(186003)(316002)(66946007)(64756008)(66476007)(76116006)(6506007)(5660300002)(44832011)(82960400001)(54906003)(38070700005)(6486002)(2906002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kt8ZErU7rYXkJtb1tIHMrZDItENpj2y6u8reqyALACcEJ72IZ/d4HY1/quqE?=
 =?us-ascii?Q?ztHH5+hs9fhc0Ezze77K51r2yxbHfUtCbEQcM+i9nHH2D+XzVMEZSKsK+GW6?=
 =?us-ascii?Q?/JEv0nCX5HptluqE5OEWQuitAmtRu9g3gIn5IylFfpjELD3Icq+OlZ64jRS/?=
 =?us-ascii?Q?jl0gQpjgQOO+Ks46Op8kMefe9IGw5nVvRjaPMXrxrxA7bajZqtLMu5ZVZLrZ?=
 =?us-ascii?Q?04a4HrCPYemQ8iAOtQFYmx2LPqlXo/XxvFid02UnI5vSLlui62rCSLAizW2c?=
 =?us-ascii?Q?8/DyIiYI00gJgTzxcrZJhvStNrGT47hAKZ7gVRmmCcdMKbAjA3IoYyEM6ZOk?=
 =?us-ascii?Q?ExHorhtEqkp/KlNdAfwZTJlRnTCvUeTs5bpAjMnu2emVNrXF5LbafJptqQhq?=
 =?us-ascii?Q?2x87dtsXCgmywBQuyORHnmYvK0rOzI3biEnyhhJHNH0AcIKN613HiAeAK42j?=
 =?us-ascii?Q?BgSfYHj5eFTnQ/154SkcfniO78fRODv5Imvk3E92eGjSLT9I0ddbDPYMBaSz?=
 =?us-ascii?Q?YbReAXqLmIOjHUNj8txAUuR+SZ2k+m2oRY8tkvwFiWSwLzX+k6COkwm/W8g0?=
 =?us-ascii?Q?dPFco5O95oEfKfRTTrqpQJUEhtkMZLwlrap5mJR8mYuhhQD1MO/6fygrnQJf?=
 =?us-ascii?Q?mTK7g97l/hj05q0NdY37FWeHacUyc6J66nt9HVbf5bvAecWKyv0Un695LvJD?=
 =?us-ascii?Q?eVMTyWPinndLsuKzkNJ7Dnn/C43nJnzfb1CqhzBvFcmqkj5GKuRvQNzP5kQQ?=
 =?us-ascii?Q?4JiyJSGfZFnhYQVdOvyuAkVEn+OyklCreotnNpgjKMmXsKXUOyE4lNqVSj4Z?=
 =?us-ascii?Q?tEphP+h363fkB5fjU2mdMTPp0KDdpSkbqwvMs0EiRzWP5qv8zjdLYXUXDOyJ?=
 =?us-ascii?Q?fW8IOo8LVhfTPcNJSKseHZ9cUU2fPz8D9BTgq6e8QdqPn2qvNHvkuIDhonwX?=
 =?us-ascii?Q?RoqLvtZxnp0wlwFsIrym8iR81Gss53Q6xMKUrFqHsyjTOyumD9fsK93AusD+?=
 =?us-ascii?Q?7U6Eait4on6d0RDhFK2dHnDzzNClb2UMIJNYwqt39xUYJvg30cmzdqlIjAZz?=
 =?us-ascii?Q?pkKiLgoVo/t2xLxglk4IvGESEQO+Vn0b+aY8zOqn3duda7C/O14Hq3RCB+72?=
 =?us-ascii?Q?NBiNwxWQVDS9BhbMnqpzi+CrDYMAZo0Xc3yXnInBRMuBHNEZEN12zTJZr93v?=
 =?us-ascii?Q?EuNRW+tybskjI2Adj/a9lZ/ioy3Dv59ySfSY3Fqt3QLSperguUyHanDDmxTC?=
 =?us-ascii?Q?QrbXzRUY/MBNuAoQQN6npi8+6VCO+gQJAQX6eQRklREDHBUDpycrNJiRVJJD?=
 =?us-ascii?Q?4QgV6EVl9DOsSKObJuMeL0BJJ8wgwir1jrRb+U8RNS69FAQFoP7Ddl+Exjp4?=
 =?us-ascii?Q?3Ca6HBj6IZin66zZDyPrM8kV8HyzkQZdhyIn3G5JnYHPFqqtqYjpCaqg/zAX?=
 =?us-ascii?Q?TAQsIt0kul9UUtNpApiGHxunaD1dpoldCPNbaamBZ40G5XJyd6ABR1y3bKEw?=
 =?us-ascii?Q?mAj2MPmcRY2lYcPp5HZbww4sqsybrck20u/Jop4gopSuyeELyXmPfQEmYfgv?=
 =?us-ascii?Q?LjEfrHHLyOV7UX/UzR6di+m/pD0VpV6xsHg141YhTovT9sWG2uaOZjctc+yH?=
 =?us-ascii?Q?ZOjH2IOek2gMxoKtfyUOWJw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <040561077F0E8041B318F7BF3DD23E99@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Vx/mJhadTcU2at1uXmoQ1cHXo3SEZRLwYSexK5ZDajugW9hwDz95vhAzHR16?=
 =?us-ascii?Q?LOf0qMPqp8Eb5QdZlRXkUCdz4PAxBwn5d2EHDYSWZetENnktro7mHFwt9Noi?=
 =?us-ascii?Q?fp8digw7otq4BZtXiPm0rjl2pKbyS/vyR7CIck0z9+k4awNVkzg9cD4Ocu3I?=
 =?us-ascii?Q?A+aXKsmutAJ5urcwaDiVhDCMUD5YTY9mF0oyAxxk7u6LVrxVAA3soln5BK7y?=
 =?us-ascii?Q?pfJywqAvYfQpVYwwgm0TWpUSw15vXUocfWLSofMOyPs3+S3Sd/nPx1VUnb0K?=
 =?us-ascii?Q?37vAx/92CISsFH93endKZuluS4lFhO5PLX+13YlEfLGo1JGykQi1/j03Ea9H?=
 =?us-ascii?Q?sbVAwSBclSE9TqobJF55yLXdxwnNXeZumXlHk+CypbrjNRV9qL79Os8fzj1T?=
 =?us-ascii?Q?LZm5Vp9+r/shv/kTmFWkr0X7d4s3HZLnRyN3g2R+Rj1jZDLmxuhGAp7xZ6Up?=
 =?us-ascii?Q?EULARbzm8rhAQGMaM8PE6ZDT8Huk4vSad248w6wU1xXEe7FZuFqjrqTjVGmk?=
 =?us-ascii?Q?7YV1IIupNNNx8hRjZkHot4EIpZ4xh53thHHLLzpmdfXH9UaiFdX9s4TNFtPd?=
 =?us-ascii?Q?LJ+dt1D6tg49V16dkcsa8c/2GoYAxj6jleQCkklWkSpyoEoJNEgCGsek0otp?=
 =?us-ascii?Q?Vi9nrvcA5mGTOcyme3Fo3kLpu9bp+ibnHu8gfxRmW9XCEKbml2dButcmsyHq?=
 =?us-ascii?Q?UvwQU1gaRze7L9zSY3srmMR8r7aRdVc1hRylQXfaDRUBfDyniaAL57/cn6EK?=
 =?us-ascii?Q?9kuAHvgQK8PVDEhaxQkJtNMDqy0DbpeGZjkUX4LdYUuQJV0MItW7Wi7dTIyx?=
 =?us-ascii?Q?8EErrZxd3v9/Jm5xae/LKmgI8QX9aUE/QzUrs8pICPusH/fUQaZZP6nVlhrg?=
 =?us-ascii?Q?ezEP5xab6SBeOF/rxFWthhbUblBQXb/MTHIULJNlWr6q/NJd0EmIgjCjk2Do?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2517a178-7a7a-42a3-a631-08db8f414c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2023 08:04:41.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lLb5VPsGk3ORQsqAeNuzt7VAYPvjviuvu04E7LdVQKKLZS6BeTGqaZRrlNUIckZAhJXLcLcWuvFY9NQG3vV8JJsCePGQYPBi+Z8i3vUtHow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7066
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
> As all tests are using the same subsystem nqn anyway, use
> the def_subsysnqn variable and drop the local subsys_name
> variable.

[...]

> diff --git a/tests/nvme/043 b/tests/nvme/043
> index 4a37f91e50c3..6392bd8b2492 100755
> --- a/tests/nvme/043
> +++ b/tests/nvme/043
> @@ -26,7 +26,6 @@ test() {
>  	_setup_nvmet
> =20
>  	local port
> -	local subsys_name=3D"blktests-subsystem-1"

The variable subsys_name is removed here, but this patch still leaves a
reference to it. This causes this test case fail. The reference is removed =
in
the next patch. I think the left reference should be replaced with def_subs=
ysnqn
in this patch.=
