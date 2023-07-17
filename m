Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C37755AEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjGQFmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGQFmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:42:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDFD10C6;
        Sun, 16 Jul 2023 22:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fz7nuhYPcnVAVWrLNxqgjzSIDCc7f1R4i8PRLEn5RFiM0omuiVXhrViJicu5C0dVk62Op56CknD5h8km5BeSKjYu/Uy97OBrqP2Zmi+Yzi4D6y8k2M2ky+eOqgN8elMMCqCWSG16pUJ2kx2VL5+iBqwYKM8VQfl6dczFje/v8hvYT+ldHZze0xPrmMSj/QHg7s6rYIQaJjl3I8XvBF/Aw5fBuYlS65CWhUvQxOw/iWAbm6dIMnwfONUpxPFvTfm6s8FNgWY6CGO8fWgN/EzIptEz1LK0btJhaOK5Tqs8N1Je2ZnlLKVH73UJctSRGgRVjlMhAf9GM38RhsXckyGd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoRCyPORMPEFytGv538ZfFy5mByKuIXxULYJNbUhx6o=;
 b=IJGrWURD8pIUrXWC5GSg0KtmEqTmI539fAaPRXJBcyzV9fjtI2iA1hm/zNaLoUR7kFoa11APsxzIbtTruQFUbavCCjXuRU0qsn7ROKx4DvFeLFoncjZc40RWGBz7mAbv6pIIiNETpDcyeVjt3j3qwJNbNrkF6grKGGA8rK92VhHnNdjBGSYL0+uFzLLEXo5k4vWryev5DjgWF3YDtPqqrUQDUqt97t86d+xwHZQJSS14ajpwCJHvCAWA8ZVKTWBioBkGhJ7xSaj55QzYNW2NimGKSLwDS2yVn5dzmRWWdzgcKUXQ3a2cq0aiPXcn5rhf0PJZ7FrIcAcJm37ZhoRTHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LoRCyPORMPEFytGv538ZfFy5mByKuIXxULYJNbUhx6o=;
 b=H5HKYQxuNQujbYjTfBDm1AmgC//ZATzbTpKK94mWS5F1YuaDfarppatWCrnSk2ylfWeBomeu/+yrcFHTFQQrLBhXaD++dMNU/OTgG/BUzUKTIy2RxqcBYJl/Q2q2Ceo4ZmI8er+d1+bBxlWdN/So0VnK+G+1KopFhD4FQTzjYe4=
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com (2603:10a6:803:cb::15)
 by AM8PR04MB7972.eurprd04.prod.outlook.com (2603:10a6:20b:236::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Mon, 17 Jul
 2023 05:42:14 +0000
Received: from VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::d375:ff5f:2ab0:d6bf]) by VI1PR04MB6013.eurprd04.prod.outlook.com
 ([fe80::d375:ff5f:2ab0:d6bf%5]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 05:42:14 +0000
From:   Gaurav Jain <gaurav.jain@nxp.com>
To:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Victoria Milhoan <vicki.milhoan@freescale.com>,
        Dan Douglass <dan.douglass@nxp.com>,
        Vipul Kumar <vipul_kumar@mentor.com>,
        Franck Lenormand <franck.lenormand@nxp.com>
Subject: RE: [PATCH 2/2] crypto: caam - add power management support
Thread-Topic: [PATCH 2/2] crypto: caam - add power management support
Thread-Index: AQHZtIcyg6YJ5QS8jEaSJS+mW0yjC6+9ecyw
Date:   Mon, 17 Jul 2023 05:42:14 +0000
Message-ID: <VI1PR04MB6013380ECE99DE1C6FB5D2D1E73BA@VI1PR04MB6013.eurprd04.prod.outlook.com>
References: <20230712060728.3562376-1-meenakshi.aggarwal@nxp.com>
 <20230712060728.3562376-3-meenakshi.aggarwal@nxp.com>
In-Reply-To: <20230712060728.3562376-3-meenakshi.aggarwal@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB6013:EE_|AM8PR04MB7972:EE_
x-ms-office365-filtering-correlation-id: d240184a-1976-403d-70aa-08db86889331
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AmGHAAxOSANm4Sl3iPY9CvcaKIrd9GxyRFuCRG5BUKntZlUucFB2t+yCt6flU996UmBNp49hyTUBuEOH/uqTUJ/volSstYMDZlXk4FzeSdBe1/FKHk3r2JswDuyfh7McbTbxpdCjIOqqCAGFa6FfkORACslBlW7npzXO5clT87fk5DsglFN5TLbE/taar3Ld1+Q5GhnjwXtWVNgAOTI63CjPdLQfbt0RAG/iJpuHzYiLo9GuNm7hDSwE2H51fYTS35cSwiHwYnrUAF7YQ9EY++BV6Gfiaomxk/ruONyR1MHrSdzxkv4IOHO1eOl25n6iccys8Xyq2k2nhjuYFGF7MyBA6Bk9SwL4tF2OQOso6im8YvEtrT8rIzbcJ1UeRHOufxvkO7ap49wAKrgNQXVYW946h95Pb1MdhSrTaWkyoGSEMmTE0nhRFsEU071swRzYaaZR0JZi9b+SFbQg5wyxcCVJn6b1K7HmyTwgloxJEfdJ5E3Y9u4fj/iGnzy5EO9oTEOPtEx6nXR3bZaAa4LqFE940n0kAKmuZVkLtBKVmpx5zG7mad/EdcB/IX6xW1UonKHP20DqTXzJVg40DNeNkY59bytGPIQsuHTYW6zaMEIGc/VPrFaCbAGaA1qqomNk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB6013.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199021)(186003)(71200400001)(86362001)(122000001)(6506007)(38070700005)(53546011)(41300700001)(9686003)(55016003)(7696005)(30864003)(44832011)(66476007)(76116006)(66556008)(478600001)(38100700002)(2906002)(54906003)(110136005)(66946007)(83380400001)(64756008)(66446008)(4326008)(8936002)(316002)(8676002)(5660300002)(52536014)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZxtVxlXjcT3IhrXuS/3IV9PgS6BF397IWMf7yIQHUdWAEfrdpy6YaRM6N1yZ?=
 =?us-ascii?Q?ed3SITZEMEBni3CqBSRhrhM1tD+DjFHF46rPan0N1zu/4as0Kyqc8RbYBcoB?=
 =?us-ascii?Q?ia0mIRtrkPLBOqOYObfolZbEtumFTJxUSaopihfO00tuoIyHCh/PN3rLksyL?=
 =?us-ascii?Q?rAJQJ/3jbMimPj5jzsyLBBI3ThLNvG12z0kpA/TkeVcBxGewNTidK++9Bgq0?=
 =?us-ascii?Q?50uVSGFFk5ra4kax/WYjs7oaks2UFtpBE+EpQYfxqV2By2/13tm8TynR+NOj?=
 =?us-ascii?Q?McoRKLOKpbwy+DMwrYfvfi03Llm7U77tMYZiJ9S5F1J3M2p+5preFammL/NA?=
 =?us-ascii?Q?81o3uiq9x8gy3+TUpVcKdv1EjrjNRz7BqGAFzFRzEYSSJNUFtWNVkMa9gxyb?=
 =?us-ascii?Q?VZPErLsM2NcJSB0B7o6fvPYDLQDKRY5jTHlIaVmgluSkgU60arFCRqy/T69e?=
 =?us-ascii?Q?2l6x7aoBpQ0uqYMYS6dEf5/x5s56bmS8Zll5huazqKNorWFSxl3BfRlsUz4q?=
 =?us-ascii?Q?nV+DrbfElHqy+nv/1/VdhN2Z3LsW6oe4ixvtwQYLpxjR3qJB0AQUQseDVDII?=
 =?us-ascii?Q?us1ze4LkXczQVAVRJ0fWm2BkS12m0J5gX6sxCiNBrW215GZk9dpOHDG3V68q?=
 =?us-ascii?Q?0E6sK/Ztd1zAxrHnP3ptDjbB2suoFHVilyYo/tcKKtm9HcjHHtTxHDI2YsS/?=
 =?us-ascii?Q?ZPB+p5xHAdjxKaWPydSLz/xkdpCWbwUjAV+zI7e2DJEQvjI/8N/kxQGl4Mqh?=
 =?us-ascii?Q?6D/BWHscYCTm04uRqfZShMxkmlws/P9+dCt8pKZBf/GYYVQGc/IpGMzO/G6e?=
 =?us-ascii?Q?KAZa796O06uWTjihNEe1WjDrhUHpXnE3qH1oQHdMyeQ5OYV0J17iAL+xl4MF?=
 =?us-ascii?Q?k01e+o4f3sFsKULAUUaiqFSnvHnhXJhDIag2ARlnUnGveEnabHmCX4AEvlY9?=
 =?us-ascii?Q?8COpNB0U9hYs7fArDMO4SKn9/DlyqEw9YDaVPhUa3wycbTtvkHnhgxg1o67X?=
 =?us-ascii?Q?5AH7230THGI/RBl2QO4MfjGtGvMKMHgoyc3vWMlpq+kO4UOGQKaxaIfz4QU9?=
 =?us-ascii?Q?zs9pHPDbg3HXPkYrpZ1g+9MphxtjGrjxI+y21P/QkbQ1dpkxa1AhsuY1vzux?=
 =?us-ascii?Q?HDXVXnHTK8+n48I/+vHGUW6JNNYBLd2d1Bf9VUfv+uw42MsaMLGFIvY2BUwi?=
 =?us-ascii?Q?naYhEjNOtF1iWcWdkb7WB3wsQSgjY9xB0kbxiFkx1qTXLCsXFjJGCKXKOQLW?=
 =?us-ascii?Q?wrdxHqD//Tb1cR0YGah7R3KoU+oinp6/9LijLRatEHQT9vxyD5IqqQG1jTfI?=
 =?us-ascii?Q?K/DsJCtjVKRII3j+JPeE49IPUXNC7cX+Er0QBDDYBsLzV17pkMk8QWKqol4+?=
 =?us-ascii?Q?bv/Y2QHfLAOJsBxXz2sOCjK7evR9IolIrVoCrr8igFWSoBG+ZvGjOQWUh/ns?=
 =?us-ascii?Q?dTg1dCFbr8o+i/146I1JlHlphfL2vX+y0PUWO65blif5cB6pKxme/5/mHB8O?=
 =?us-ascii?Q?VB2i1K59fc+m245zTrqhBIuXsGuZpG718oivFdjn0clbR/b571xfgEg8RA?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB6013.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d240184a-1976-403d-70aa-08db86889331
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2023 05:42:14.5996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /+aKDvDxvIwNLf8FgVvF5IhCOzCLDm8+VhpC9Op33Y4UCw5XDVEdBi+LBPBxzPozzFls/kF7ledt1Tr22ukJNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7972
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Gaurav Jain <gaurav.jain@nxp.com>

> -----Original Message-----
> From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> Sent: Wednesday, July 12, 2023 11:37 AM
> To: Horia Geanta <horia.geanta@nxp.com>; Varun Sethi <V.Sethi@nxp.com>;
> Pankaj Gupta <pankaj.gupta@nxp.com>; Gaurav Jain <gaurav.jain@nxp.com>;
> herbert@gondor.apana.org.au; davem@davemloft.net; linux-
> crypto@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Victoria Milhoan <vicki.milhoan@freescale.com>; Dan Douglass
> <dan.douglass@nxp.com>; Vipul Kumar <vipul_kumar@mentor.com>; Franck
> Lenormand <franck.lenormand@nxp.com>; Meenakshi Aggarwal
> <meenakshi.aggarwal@nxp.com>
> Subject: [PATCH 2/2] crypto: caam - add power management support
>=20
> From: Horia Geanta <horia.geanta@nxp.com>
>=20
> Add support for suspend and resume operation for PM in CAAM driver.
>=20
> When the CAAM goes in suspend, the hardware is considered to do nothing.
>=20
> On some platforms, the power of the CAAM is not turned off so it keeps it=
s
> configuration.
> On other platforms, it doesn't so it is necessary to save the state of th=
e CAAM:
>  - JRs MID
>  - Address of input and output rings
>=20
> Signed-off-by: Horia Geanta <horia.geanta@nxp.com>
> Signed-off-by: Victoria Milhoan <vicki.milhoan@freescale.com>
> Signed-off-by: Dan Douglass <dan.douglass@nxp.com>
> Signed-off-by: Vipul Kumar <vipul_kumar@mentor.com>
> Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> Signed-off-by: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
> ---
>  drivers/crypto/caam/ctrl.c   | 114 ++++++++++++++++++++
>  drivers/crypto/caam/intern.h |  33 +++++-
>  drivers/crypto/caam/jr.c     | 199 +++++++++++++++++++++++++++++++----
>  drivers/crypto/caam/regs.h   |   3 +-
>  4 files changed, 328 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c inde=
x
> ff9ddbbca377..64b6cd09d8a8 100644
> --- a/drivers/crypto/caam/ctrl.c
> +++ b/drivers/crypto/caam/ctrl.c
> @@ -740,6 +740,113 @@ static int caam_ctrl_rng_init(struct device *dev)
>  	return 0;
>  }
>=20
> +#ifdef CONFIG_PM_SLEEP
> +
> +/* Indicate if the internal state of the CAAM is lost during PM */
> +static int caam_off_during_pm(void) {
> +	bool not_off_during_pm =3D of_machine_is_compatible("fsl,imx6q") ||
> +				 of_machine_is_compatible("fsl,imx6qp") ||
> +				 of_machine_is_compatible("fsl,imx6dl");
> +
> +	return not_off_during_pm ? 0 : 1;
> +}
> +
> +static void caam_state_save(struct device *dev) {
> +	struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(dev);
> +	struct caam_ctl_state *state =3D &ctrlpriv->state;
> +	struct caam_ctrl __iomem *ctrl =3D ctrlpriv->ctrl;
> +	u32 deco_inst, jr_inst;
> +	int i;
> +
> +	state->mcr =3D rd_reg32(&ctrl->mcr);
> +	state->scfgr =3D rd_reg32(&ctrl->scfgr);
> +
> +	deco_inst =3D (rd_reg32(&ctrl->perfmon.cha_num_ms) &
> +		     CHA_ID_MS_DECO_MASK) >> CHA_ID_MS_DECO_SHIFT;
> +	for (i =3D 0; i < deco_inst; i++) {
> +		state->deco_mid[i].liodn_ms =3D
> +			rd_reg32(&ctrl->deco_mid[i].liodn_ms);
> +		state->deco_mid[i].liodn_ls =3D
> +			rd_reg32(&ctrl->deco_mid[i].liodn_ls);
> +	}
> +
> +	jr_inst =3D (rd_reg32(&ctrl->perfmon.cha_num_ms) &
> +		   CHA_ID_MS_JR_MASK) >> CHA_ID_MS_JR_SHIFT;
> +	for (i =3D 0; i < jr_inst; i++) {
> +		state->jr_mid[i].liodn_ms =3D
> +			rd_reg32(&ctrl->jr_mid[i].liodn_ms);
> +		state->jr_mid[i].liodn_ls =3D
> +			rd_reg32(&ctrl->jr_mid[i].liodn_ls);
> +	}
> +}
> +
> +static void caam_state_restore(const struct device *dev) {
> +	const struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(dev);
> +	const struct caam_ctl_state *state =3D &ctrlpriv->state;
> +	struct caam_ctrl __iomem *ctrl =3D ctrlpriv->ctrl;
> +	u32 deco_inst, jr_inst;
> +	int i;
> +
> +	wr_reg32(&ctrl->mcr, state->mcr);
> +	wr_reg32(&ctrl->scfgr, state->scfgr);
> +
> +	deco_inst =3D (rd_reg32(&ctrl->perfmon.cha_num_ms) &
> +		     CHA_ID_MS_DECO_MASK) >> CHA_ID_MS_DECO_SHIFT;
> +	for (i =3D 0; i < deco_inst; i++) {
> +		wr_reg32(&ctrl->deco_mid[i].liodn_ms,
> +			 state->deco_mid[i].liodn_ms);
> +		wr_reg32(&ctrl->deco_mid[i].liodn_ls,
> +			 state->deco_mid[i].liodn_ls);
> +	}
> +
> +	jr_inst =3D (rd_reg32(&ctrl->perfmon.cha_num_ms) &
> +		   CHA_ID_MS_JR_MASK) >> CHA_ID_MS_JR_SHIFT;
> +	for (i =3D 0; i < jr_inst; i++) {
> +		wr_reg32(&ctrl->jr_mid[i].liodn_ms,
> +			 state->jr_mid[i].liodn_ms);
> +		wr_reg32(&ctrl->jr_mid[i].liodn_ls,
> +			 state->jr_mid[i].liodn_ls);
> +	}
> +
> +	if (ctrlpriv->virt_en =3D=3D 1)
> +		clrsetbits_32(&ctrl->jrstart, 0, JRSTART_JR0_START |
> +			      JRSTART_JR1_START | JRSTART_JR2_START |
> +			      JRSTART_JR3_START);
> +}
> +
> +static int caam_ctrl_suspend(struct device *dev) {
> +	const struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(dev);
> +
> +	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->optee_en)
> +		caam_state_save(dev);
> +
> +	return 0;
> +}
> +
> +static int caam_ctrl_resume(struct device *dev) {
> +	struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(dev);
> +	int ret =3D 0;
> +
> +	if (ctrlpriv->caam_off_during_pm && !ctrlpriv->optee_en) {
> +		caam_state_restore(dev);
> +
> +		/* HW and rng will be reset so deinstantiation can be removed
> */
> +		devm_remove_action(dev, devm_deinstantiate_rng, dev);
> +		ret =3D caam_ctrl_rng_init(dev);
> +	}
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(caam_ctrl_pm_ops, caam_ctrl_suspend,
> +caam_ctrl_resume);
> +
> +#endif /* CONFIG_PM_SLEEP */
> +
>  /* Probe routine for CAAM top (controller) level */  static int caam_pro=
be(struct
> platform_device *pdev)  { @@ -771,6 +878,10 @@ static int caam_probe(stru=
ct
> platform_device *pdev)
>=20
>  	caam_imx =3D (bool)imx_soc_match;
>=20
> +#ifdef CONFIG_PM_SLEEP
> +	ctrlpriv->caam_off_during_pm =3D caam_imx && caam_off_during_pm();
> +#endif
> +
>  	if (imx_soc_match) {
>  		/*
>  		 * Until Layerscape and i.MX OP-TEE get in sync, @@ -1033,6
> +1144,9 @@ static struct platform_driver caam_driver =3D {
>  	.driver =3D {
>  		.name =3D "caam",
>  		.of_match_table =3D caam_match,
> +#ifdef CONFIG_PM_SLEEP
> +		.pm =3D &caam_ctrl_pm_ops,
> +#endif
>  	},
>  	.probe       =3D caam_probe,
>  };
> diff --git a/drivers/crypto/caam/intern.h b/drivers/crypto/caam/intern.h =
index
> b4f7bf77f487..fcf0a080b5d6 100644
> --- a/drivers/crypto/caam/intern.h
> +++ b/drivers/crypto/caam/intern.h
> @@ -4,7 +4,7 @@
>   * Private/internal definitions between modules
>   *
>   * Copyright 2008-2011 Freescale Semiconductor, Inc.
> - * Copyright 2019 NXP
> + * Copyright 2019, 2023 NXP
>   */
>=20
>  #ifndef INTERN_H
> @@ -47,6 +47,18 @@ struct caam_jrentry_info {
>  	u32 desc_size;	/* Stored size for postprocessing, header derived */
>  };
>=20
> +#ifdef CONFIG_PM_SLEEP
> +struct caam_jr_state {
> +	dma_addr_t inpbusaddr;
> +	dma_addr_t outbusaddr;
> +};
> +#endif
> +
> +struct caam_jr_dequeue_params {
> +	struct device *dev;
> +	int enable_itr;
> +};
> +
>  /* Private sub-storage for a single JobR */  struct caam_drv_private_jr =
{
>  	struct list_head	list_node;	/* Job Ring device list */
> @@ -54,6 +66,7 @@ struct caam_drv_private_jr {
>  	int ridx;
>  	struct caam_job_ring __iomem *rregs;	/* JobR's register space */
>  	struct tasklet_struct irqtask;
> +	struct caam_jr_dequeue_params tasklet_params;
>  	int irq;			/* One per queue */
>  	bool hwrng;
>=20
> @@ -71,7 +84,20 @@ struct caam_drv_private_jr {
>  	int tail;			/* entinfo (s/w ring) tail index */
>  	void *outring;			/* Base of output ring, DMA-safe */
>  	struct crypto_engine *engine;
> +
> +#ifdef CONFIG_PM_SLEEP
> +	struct caam_jr_state state;	/* State of the JR during PM */
> +#endif
> +};
> +
> +#ifdef CONFIG_PM_SLEEP
> +struct caam_ctl_state {
> +	struct masterid deco_mid[16];
> +	struct masterid jr_mid[4];
> +	u32 mcr;
> +	u32 scfgr;
>  };
> +#endif
>=20
>  /*
>   * Driver-private storage for a single CAAM block instance @@ -116,6 +14=
2,11
> @@ struct caam_drv_private {
>  	struct dentry *ctl; /* controller dir */
>  	struct debugfs_blob_wrapper ctl_kek_wrap, ctl_tkek_wrap,
> ctl_tdsk_wrap;  #endif
> +
> +#ifdef CONFIG_PM_SLEEP
> +	int caam_off_during_pm;		/* If the CAAM is reset after
> suspend */
> +	struct caam_ctl_state state;	/* State of the CTL during PM */
> +#endif
>  };
>=20
>  #ifdef CONFIG_CRYPTO_DEV_FSL_CAAM_CRYPTO_API
> diff --git a/drivers/crypto/caam/jr.c b/drivers/crypto/caam/jr.c index
> 96dea5304d22..1801638eb1c8 100644
> --- a/drivers/crypto/caam/jr.c
> +++ b/drivers/crypto/caam/jr.c
> @@ -117,6 +117,25 @@ static int caam_jr_flush(struct device *dev)
>  	return caam_jr_stop_processing(dev, JRCR_RESET);  }
>=20
> +#ifdef CONFIG_PM_SLEEP
> +/* The resume can be used after a park or a flush if CAAM has not been
> +reset */ static int caam_jr_restart_processing(struct device *dev) {
> +	struct caam_drv_private_jr *jrp =3D dev_get_drvdata(dev);
> +	u32 halt_status =3D rd_reg32(&jrp->rregs->jrintstatus) &
> +			  JRINT_ERR_HALT_MASK;
> +
> +	/* Check that the flush/park is completed */
> +	if (halt_status !=3D JRINT_ERR_HALT_COMPLETE)
> +		return -1;
> +
> +	/* Resume processing of jobs */
> +	clrsetbits_32(&jrp->rregs->jrintstatus, 0, JRINT_ERR_HALT_COMPLETE);
> +
> +	return 0;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
>  static int caam_reset_hw_jr(struct device *dev)  {
>  	struct caam_drv_private_jr *jrp =3D dev_get_drvdata(dev); @@ -245,7
> +264,8 @@ static irqreturn_t caam_jr_interrupt(int irq, void *st_dev)  st=
atic void
> caam_jr_dequeue(unsigned long devarg)  {
>  	int hw_idx, sw_idx, i, head, tail;
> -	struct device *dev =3D (struct device *)devarg;
> +	struct caam_jr_dequeue_params *params =3D (void *)devarg;
> +	struct device *dev =3D params->dev;
>  	struct caam_drv_private_jr *jrp =3D dev_get_drvdata(dev);
>  	void (*usercall)(struct device *dev, u32 *desc, u32 status, void *arg);
>  	u32 *userdesc, userstatus;
> @@ -319,8 +339,9 @@ static void caam_jr_dequeue(unsigned long devarg)
>  		outring_used--;
>  	}
>=20
> -	/* reenable / unmask IRQs */
> -	clrsetbits_32(&jrp->rregs->rconfig_lo, JRCFG_IMSK, 0);
> +	if (params->enable_itr)
> +		/* reenable / unmask IRQs */
> +		clrsetbits_32(&jrp->rregs->rconfig_lo, JRCFG_IMSK, 0);
>  }
>=20
>  /**
> @@ -470,6 +491,29 @@ int caam_jr_enqueue(struct device *dev, u32 *desc,  =
}
> EXPORT_SYMBOL(caam_jr_enqueue);
>=20
> +static void caam_jr_init_hw(struct device *dev, dma_addr_t inpbusaddr,
> +			    dma_addr_t outbusaddr)
> +{
> +	struct caam_drv_private_jr *jrp =3D dev_get_drvdata(dev);
> +
> +	wr_reg64(&jrp->rregs->inpring_base, inpbusaddr);
> +	wr_reg64(&jrp->rregs->outring_base, outbusaddr);
> +	wr_reg32(&jrp->rregs->inpring_size, JOBR_DEPTH);
> +	wr_reg32(&jrp->rregs->outring_size, JOBR_DEPTH);
> +
> +	/* Select interrupt coalescing parameters */
> +	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JOBR_INTC |
> +		      (JOBR_INTC_COUNT_THLD << JRCFG_ICDCT_SHIFT) |
> +		      (JOBR_INTC_TIME_THLD << JRCFG_ICTT_SHIFT)); }
> +
> +static void caam_jr_reset_index(struct caam_drv_private_jr *jrp) {
> +	jrp->out_ring_read_index =3D 0;
> +	jrp->head =3D 0;
> +	jrp->tail =3D 0;
> +}
> +
>  /*
>   * Init JobR independent of platform property detection
>   */
> @@ -506,25 +550,16 @@ static int caam_jr_init(struct device *dev)
>  		jrp->entinfo[i].desc_addr_dma =3D !0;
>=20
>  	/* Setup rings */
> -	jrp->out_ring_read_index =3D 0;
> -	jrp->head =3D 0;
> -	jrp->tail =3D 0;
> -
> -	wr_reg64(&jrp->rregs->inpring_base, inpbusaddr);
> -	wr_reg64(&jrp->rregs->outring_base, outbusaddr);
> -	wr_reg32(&jrp->rregs->inpring_size, JOBR_DEPTH);
> -	wr_reg32(&jrp->rregs->outring_size, JOBR_DEPTH);
> -
> +	caam_jr_reset_index(jrp);
>  	jrp->inpring_avail =3D JOBR_DEPTH;
> +	caam_jr_init_hw(dev, inpbusaddr, outbusaddr);
>=20
>  	spin_lock_init(&jrp->inplock);
>=20
> -	/* Select interrupt coalescing parameters */
> -	clrsetbits_32(&jrp->rregs->rconfig_lo, 0, JOBR_INTC |
> -		      (JOBR_INTC_COUNT_THLD << JRCFG_ICDCT_SHIFT) |
> -		      (JOBR_INTC_TIME_THLD << JRCFG_ICTT_SHIFT));
> -
> -	tasklet_init(&jrp->irqtask, caam_jr_dequeue, (unsigned long)dev);
> +	jrp->tasklet_params.dev =3D dev;
> +	jrp->tasklet_params.enable_itr =3D 1;
> +	tasklet_init(&jrp->irqtask, caam_jr_dequeue,
> +		     (unsigned long)&jrp->tasklet_params);
>=20
>  	/* Connect job ring interrupt handler. */
>  	error =3D devm_request_irq(dev, jrp->irq, caam_jr_interrupt,
> IRQF_SHARED, @@ -635,11 +670,136 @@ static int caam_jr_probe(struct
> platform_device *pdev)
>=20
>  	atomic_set(&jrpriv->tfm_count, 0);
>=20
> +	device_init_wakeup(&pdev->dev, 1);
> +	device_set_wakeup_enable(&pdev->dev, false);
> +
>  	register_algs(jrpriv, jrdev->parent);
>=20
>  	return 0;
>  }
>=20
> +#ifdef CONFIG_PM_SLEEP
> +static void caam_jr_get_hw_state(struct device *dev) {
> +	struct caam_drv_private_jr *jrp =3D dev_get_drvdata(dev);
> +
> +	jrp->state.inpbusaddr =3D rd_reg64(&jrp->rregs->inpring_base);
> +	jrp->state.outbusaddr =3D rd_reg64(&jrp->rregs->outring_base);
> +}
> +
> +static int caam_jr_suspend(struct device *dev) {
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct caam_drv_private_jr *jrpriv =3D platform_get_drvdata(pdev);
> +	struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(dev->parent);
> +	struct caam_jr_dequeue_params suspend_params =3D {
> +		.dev =3D dev,
> +		.enable_itr =3D 0,
> +	};
> +
> +	/* Remove the node from Physical JobR list maintained by driver */
> +	spin_lock(&driver_data.jr_alloc_lock);
> +	list_del(&jrpriv->list_node);
> +	spin_unlock(&driver_data.jr_alloc_lock);
> +
> +	if (jrpriv->hwrng)
> +		caam_rng_exit(dev->parent);
> +
> +	if (ctrlpriv->caam_off_during_pm) {
> +		int err;
> +
> +		tasklet_disable(&jrpriv->irqtask);
> +
> +		/* mask itr to call flush */
> +		clrsetbits_32(&jrpriv->rregs->rconfig_lo, 0, JRCFG_IMSK);
> +
> +		/* Invalid job in process */
> +		err =3D caam_jr_flush(dev);
> +		if (err) {
> +			dev_err(dev, "Failed to flush\n");
> +			return err;
> +		}
> +
> +		/* Dequeing jobs flushed */
> +		caam_jr_dequeue((unsigned long)&suspend_params);
> +
> +		/* Save state */
> +		caam_jr_get_hw_state(dev);
> +	} else if (device_may_wakeup(&pdev->dev)) {
> +		enable_irq_wake(jrpriv->irq);
> +	}
> +
> +	return 0;
> +}
> +
> +static int caam_jr_resume(struct device *dev) {
> +	struct platform_device *pdev =3D to_platform_device(dev);
> +	struct caam_drv_private_jr *jrpriv =3D platform_get_drvdata(pdev);
> +	struct caam_drv_private *ctrlpriv =3D dev_get_drvdata(dev->parent);
> +
> +	if (ctrlpriv->caam_off_during_pm) {
> +		u64 inp_addr;
> +		int err;
> +
> +		/*
> +		 * Check if the CAAM has been resetted checking the address of
> +		 * the input ring
> +		 */
> +		inp_addr =3D rd_reg64(&jrpriv->rregs->inpring_base);
> +		if (inp_addr !=3D 0) {
> +			/* JR still has some configuration */
> +			if (inp_addr =3D=3D jrpriv->state.inpbusaddr) {
> +				/* JR has not been resetted */
> +				err =3D caam_jr_restart_processing(dev);
> +				if (err) {
> +					dev_err(dev,
> +						"Restart processing failed\n");
> +					return err;
> +				}
> +
> +				tasklet_enable(&jrpriv->irqtask);
> +
> +				clrsetbits_32(&jrpriv->rregs->rconfig_lo,
> +					      JRCFG_IMSK, 0);
> +
> +				goto add_jr;
> +			} else if (ctrlpriv->optee_en) {
> +				/* JR has been used by OPTEE, reset it */
> +				err =3D caam_reset_hw_jr(dev);
> +				if (err) {
> +					dev_err(dev, "Failed to reset JR\n");
> +					return err;
> +				}
> +			} else {
> +				/* No explanation, return error */
> +				return -EIO;
> +			}
> +		}
> +
> +		caam_jr_reset_index(jrpriv);
> +		caam_jr_init_hw(dev, jrpriv->state.inpbusaddr,
> +				jrpriv->state.outbusaddr);
> +
> +		tasklet_enable(&jrpriv->irqtask);
> +	} else if (device_may_wakeup(&pdev->dev)) {
> +		disable_irq_wake(jrpriv->irq);
> +	}
> +
> +add_jr:
> +	spin_lock(&driver_data.jr_alloc_lock);
> +	list_add_tail(&jrpriv->list_node, &driver_data.jr_list);
> +	spin_unlock(&driver_data.jr_alloc_lock);
> +
> +	if (jrpriv->hwrng)
> +		jrpriv->hwrng =3D !caam_rng_init(dev->parent);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(caam_jr_pm_ops, caam_jr_suspend,
> +caam_jr_resume); #endif /* CONFIG_PM_SLEEP */
> +
>  static const struct of_device_id caam_jr_match[] =3D {
>  	{
>  		.compatible =3D "fsl,sec-v4.0-job-ring", @@ -655,6 +815,9 @@
> static struct platform_driver caam_jr_driver =3D {
>  	.driver =3D {
>  		.name =3D "caam_jr",
>  		.of_match_table =3D caam_jr_match,
> +#ifdef CONFIG_PM_SLEEP
> +		.pm =3D &caam_jr_pm_ops,
> +#endif
>  	},
>  	.probe       =3D caam_jr_probe,
>  	.remove      =3D caam_jr_remove,
> diff --git a/drivers/crypto/caam/regs.h b/drivers/crypto/caam/regs.h inde=
x
> 0f87bd365582..873df9de9890 100644
> --- a/drivers/crypto/caam/regs.h
> +++ b/drivers/crypto/caam/regs.h
> @@ -584,8 +584,7 @@ struct caam_ctrl {
>  	u32 deco_rsr;			/* DECORSR - Deco Request Source */
>  	u32 rsvd11;
>  	u32 deco_rq;			/* DECORR - DECO Request */
> -	struct masterid deco_mid[5];	/* DECOxLIODNR - 1 per DECO */
> -	u32 rsvd5[22];
> +	struct masterid deco_mid[16];	/* DECOxLIODNR - 1 per DECO */
>=20
>  	/* DECO Availability/Reset Section			120-3ff */
>  	u32 deco_avail;		/* DAR - DECO availability */
> --
> 2.25.1

