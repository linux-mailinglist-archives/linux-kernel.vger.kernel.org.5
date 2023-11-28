Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7037FB530
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbjK1JGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjK1JGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:06:20 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6DF1B6;
        Tue, 28 Nov 2023 01:06:26 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50bba1dd05fso553180e87.0;
        Tue, 28 Nov 2023 01:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701162384; x=1701767184; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2RW99vE38PIc6SpTpGSG9Fw0ojZLVZidXqTc1Mj5whQ=;
        b=O+Pgi2FMtzQMj5pHCz8zWS/AuLC94Zq8vDcgWtweRAm5gAGShhFPeoKAo62Bjb2GK4
         rG2FsD4VYsLKcddRFQ5ZFVUnEAbvFQsPDJQ5HIrwhidZyThguWkUxtErDWFRTbRby3+Q
         Q5DsMUg3urDR88ZaSX5F/HPflf9tjINyCwEBKOHA2oj8g1B/b1MUP+XkEy6QCacQQdAV
         DDuAZ6sM6Dzt4GX6sMqwqE28oXl0+Q4PhyoXZLcOsdqlTeeKqYXP01K0TwxCpheZuhK8
         FSJ/xmibWPl7RMCJTWildhn4ZA8aqMjdgJ4xqncgTvOoC23CdilW4hKu3zZZp556lMgx
         zzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701162384; x=1701767184;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RW99vE38PIc6SpTpGSG9Fw0ojZLVZidXqTc1Mj5whQ=;
        b=oHw5Bn5GUhHR663/W03EsaevFt5b+KKqPtfsv5i6pU3KknxGmGIESSnrPOvJGB1ESE
         muYZMNo81EOG5UzVDKiNm7/MRw+Eg4Vt/SF06TdSnKoYgI8HW3SuwYGDFhX3RbqKknZl
         GcX7SDom/AO4iWxKyav71TOMKvjf0Eo0TyinyenUKhoAYiLbqseAnXGSvSurSmPuHbEc
         2TY5BNwFgA8vhYlbDfN5oNzB9ELjNyASR7o9xyvCT6er6sQ8hkEXSOHi7S2ov5DUEvda
         46szgt4h189y+XMVFQzXqkWrE4OVAWkhhUNBbknUm2rmJO+hsgz2YYwaqQR8/M9k+IOY
         qxzw==
X-Gm-Message-State: AOJu0YyyO4q4b+MILcQkbl6sBYkoRFvTFbTPcjenqDqIgYSkVP7sX0vg
        ltDCLi2e5YD84IkR/a8qfyk=
X-Google-Smtp-Source: AGHT+IGbOBovg6fWIgafLZ3Jq8EYazhSCYX3LZlT85DjVqFn5+rmPXoZQRKL/M9Ab3jAoYVa+3ahvg==
X-Received: by 2002:ac2:52af:0:b0:50b:bfd6:dd7d with SMTP id r15-20020ac252af000000b0050bbfd6dd7dmr174275lfm.20.1701162384217;
        Tue, 28 Nov 2023 01:06:24 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:4423:d503:bf11:e8c6? (p200300f6ef1b20004423d503bf11e8c6.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:4423:d503:bf11:e8c6])
        by smtp.gmail.com with ESMTPSA id f8-20020adff988000000b00332e75eae4asm12398149wrr.85.2023.11.28.01.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 01:06:23 -0800 (PST)
Message-ID: <f40f9c163f094a60443516f1744c8d09b4dc10ca.camel@gmail.com>
Subject: Re: [PATCH net-next] net: phy: adin: allow control of Fast Link Down
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com
Date:   Tue, 28 Nov 2023 10:09:24 +0100
In-Reply-To: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>
References: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-27 at 16:31 +0100, Vincent Whitchurch wrote:
> Add support to allow Fast Link Down (aka "Enhanced link detection") to
> be controlled via the ETHTOOL_PHY_FAST_LINK_DOWN tunable.=C2=A0 These PHY=
s
> have this feature enabled by default.
>=20
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---

LGTM,

Acked-by: Nuno Sa <nuno.sa@analog.com>

Thanks!
- Nuno S=C3=A1

> =C2=A0drivers/net/phy/adin.c | 53
> ++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 53 insertions(+)
>=20
> diff --git a/drivers/net/phy/adin.c b/drivers/net/phy/adin.c
> index 134637584a83..2e1a46e121d9 100644
> --- a/drivers/net/phy/adin.c
> +++ b/drivers/net/phy/adin.c
> @@ -68,6 +68,24 @@
> =C2=A0#define ADIN1300_EEE_CAP_REG			0x8000
> =C2=A0#define ADIN1300_EEE_ADV_REG			0x8001
> =C2=A0#define ADIN1300_EEE_LPABLE_REG			0x8002
> +
> +#define ADIN1300_FLD_EN_REG			0x8E27
> +#define=C2=A0=C2=A0 ADIN1300_FLD_PCS_ERR_100_EN		BIT(7)
> +#define=C2=A0=C2=A0 ADIN1300_FLD_PCS_ERR_1000_EN		BIT(6)
> +#define=C2=A0=C2=A0 ADIN1300_FLD_SLCR_OUT_STUCK_100_EN	BIT(5)
> +#define=C2=A0=C2=A0 ADIN1300_FLD_SLCR_OUT_STUCK_1000_EN	BIT(4)
> +#define=C2=A0=C2=A0 ADIN1300_FLD_SLCR_IN_ZDET_100_EN	BIT(3)
> +#define=C2=A0=C2=A0 ADIN1300_FLD_SLCR_IN_ZDET_1000_EN	BIT(2)
> +#define=C2=A0=C2=A0 ADIN1300_FLD_SLCR_IN_INVLD_100_EN	BIT(1)
> +#define=C2=A0=C2=A0 ADIN1300_FLD_SLCR_IN_INVLD_1000_EN	BIT(0)
> +/* These bits are the ones which are enabled by default. */
> +#define ADIN1300_FLD_EN_ON	\
> +	(ADIN1300_FLD_SLCR_OUT_STUCK_100_EN | \
> +	 ADIN1300_FLD_SLCR_OUT_STUCK_1000_EN | \
> +	 ADIN1300_FLD_SLCR_IN_ZDET_100_EN | \
> +	 ADIN1300_FLD_SLCR_IN_ZDET_1000_EN | \
> +	 ADIN1300_FLD_SLCR_IN_INVLD_1000_EN)
> +
> =C2=A0#define ADIN1300_CLOCK_STOP_REG			0x9400
> =C2=A0#define ADIN1300_LPI_WAKE_ERR_CNT_REG		0xa000
> =C2=A0
> @@ -416,6 +434,37 @@ static int adin_set_edpd(struct phy_device *phydev, =
u16
> tx_interval)
> =C2=A0			=C2=A0 val);
> =C2=A0}
> =C2=A0
> +static int adin_get_fast_down(struct phy_device *phydev, u8 *msecs)
> +{
> +	int reg;
> +
> +	reg =3D phy_read_mmd(phydev, MDIO_MMD_VEND1, ADIN1300_FLD_EN_REG);
> +	if (reg < 0)
> +		return reg;
> +
> +	if (reg & ADIN1300_FLD_EN_ON)
> +		*msecs =3D ETHTOOL_PHY_FAST_LINK_DOWN_ON;
> +	else
> +		*msecs =3D ETHTOOL_PHY_FAST_LINK_DOWN_OFF;
> +
> +	return 0;
> +}
> +
> +static int adin_set_fast_down(struct phy_device *phydev, const u8 *msecs=
)
> +{
> +	if (*msecs =3D=3D ETHTOOL_PHY_FAST_LINK_DOWN_ON)
> +		return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
> +					ADIN1300_FLD_EN_REG,
> +					ADIN1300_FLD_EN_ON);
> +
> +	if (*msecs =3D=3D ETHTOOL_PHY_FAST_LINK_DOWN_OFF)
> +		return phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
> +					=C2=A0 ADIN1300_FLD_EN_REG,
> +					=C2=A0 ADIN1300_FLD_EN_ON);
> +
> +	return -EINVAL;
> +}
> +
> =C2=A0static int adin_get_tunable(struct phy_device *phydev,
> =C2=A0			=C2=A0=C2=A0=C2=A0 struct ethtool_tunable *tuna, void *data)
> =C2=A0{
> @@ -424,6 +473,8 @@ static int adin_get_tunable(struct phy_device *phydev=
,
> =C2=A0		return adin_get_downshift(phydev, data);
> =C2=A0	case ETHTOOL_PHY_EDPD:
> =C2=A0		return adin_get_edpd(phydev, data);
> +	case ETHTOOL_PHY_FAST_LINK_DOWN:
> +		return adin_get_fast_down(phydev, data);
> =C2=A0	default:
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0	}
> @@ -437,6 +488,8 @@ static int adin_set_tunable(struct phy_device *phydev=
,
> =C2=A0		return adin_set_downshift(phydev, *(const u8 *)data);
> =C2=A0	case ETHTOOL_PHY_EDPD:
> =C2=A0		return adin_set_edpd(phydev, *(const u16 *)data);
> +	case ETHTOOL_PHY_FAST_LINK_DOWN:
> +		return adin_set_fast_down(phydev, data);
> =C2=A0	default:
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0	}
>=20
> ---
> base-commit: e1df5202e879bce09845ac62bae30206e1edfb80
> change-id: 20231127-adin-fld-c072c3b79a5a
>=20
> Best regards,

