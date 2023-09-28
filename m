Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1830E7B28E5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 01:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjI1Xi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 19:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI1Xi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 19:38:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B9AB195;
        Thu, 28 Sep 2023 16:38:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0CEC433C8;
        Thu, 28 Sep 2023 23:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695944333;
        bh=eWU967jREmjZE4MCqLTeXdTZLBzl8v3/op7N9RLiY+E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kfM4lHBOYywiUs1pSsJD72kDGGNfgjYh2nlEYO/Hn5nbeITF+6qyQUmtAbQcdYbW7
         XdcdgETTEEoPg5c7zOshcCcA3jjeEg0W42+ivpFGnbDL40OIEEX1Jz68enbD/EHZwD
         RnOffNJf0bvf2KHzcbwjA0smxFXx3yBpoY+mSmvg7UV/ExaKyFc6OWEkCcIuhvqd8l
         30jSqINA6zVSQRvGDH8ig9BH+FfxTNwl9ifdO3ab+M7zojCxUMxVS0p/yj5tOsI5oe
         Hu/ZEI00ZJKeyi47AGEQIqf31w7d0vpcuPo5jC331mPR61a+4nbYZv67g/uH/SxXam
         GdQWaV5q66dFw==
Received: by mercury (Postfix, from userid 1000)
        id C06C9106058E; Thu, 28 Sep 2023 15:38:14 +0200 (CEST)
Date:   Thu, 28 Sep 2023 15:38:14 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] power: supply: qcom_battmgr: fix battery_id type
Message-ID: <20230928133814.szn5dd4gzshmccia@mercury.elektranox.org>
References: <20230919124222.1155894-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jpqm2iodkegz3nb3"
Content-Disposition: inline
In-Reply-To: <20230919124222.1155894-1-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jpqm2iodkegz3nb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+cc Johan Hovold who gave away that he is involved with this at
Kernel Recipes :)

On Tue, Sep 19, 2023 at 02:42:22PM +0200, Sebastian Reichel wrote:
> qcom_battmgr_update_request.battery_id is written to using cpu_to_le32()
> and should be of type __le32, just like all other 32bit integer requests
> for qcom_battmgr.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309162149.4owm9iXc-lkp@i=
ntel.com/
> Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power =
supply")
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/power/supply/qcom_battmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/q=
com_battmgr.c
> index de77df97b3a4..a05fd00711f6 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -105,7 +105,7 @@ struct qcom_battmgr_property_request {
> =20
>  struct qcom_battmgr_update_request {
>  	struct pmic_glink_hdr hdr;
> -	u32 battery_id;
> +	__le32 battery_id;
>  };
> =20
>  struct qcom_battmgr_charge_time_request {
> --=20
> 2.40.1
>=20

--jpqm2iodkegz3nb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmUVgb8ACgkQ2O7X88g7
+prwdhAAoPJP/kxvYglc2zIyjQTXI/AExR3u3+o47C9YvdKmXIQOiosSNdIs+a//
BvpjDsFrTx32MCX4koS+KGSO1f64xepggcCzddr/Kp/URu0oc7zcx2560YC9IRrT
ioFr3PT3+OZXbcA2KxT4m2emAcr0tANrQL6ri2BO5O59U5lVOEMZCIUE5Mef6wIC
0VdBZwxlthYKEdFJiLW5bvWK5tm+U7nhimTWCX84/5jTvOXYXId7RY1oZjh3I0LV
bOC6Ah0bVbF5nJ+tlA5kDHzFeRqsOhyxURxejasWqq9IrvYooOe0bKPwGRyEmATe
qPewgJMwK/4ki0YIPVWsNTUTKf8gRw+7e2RmX0WJX/5Vf6/U5mMZNXhK6OQ9G8PU
OiihKwvTlFToYadhXUSAl8iMP24047AUy1KTTA23FKB7uvUxryg6ylW2K1FndmV+
WZxJZlJ2c+Gj8Z5FC8/LFV3OnCxfh9kyVdu8n8UoMGs+UNQ4VZnfC1ZkluskQEcO
EfDQunn3u1xS9sPRcF7tdKF3rW7sDJHp7WObe+AiVkOmxUrFU45AwaE3NFp7OmFN
tbNbEHMGJXmU1rsuhO7BNogLltx1eXjQstPkSMkOAjaprs5FXaKXQVOflQVohwjv
b5M7LGGcJQBBaViH+xs16eSTlUg08RobdGZZjW1AcddVAzRv1gQ=
=qDg+
-----END PGP SIGNATURE-----

--jpqm2iodkegz3nb3--
