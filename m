Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DB377E648
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344662AbjHPQY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344692AbjHPQYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:24:09 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519D5271F;
        Wed, 16 Aug 2023 09:24:06 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31781e15a0cso5903203f8f.3;
        Wed, 16 Aug 2023 09:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692203045; x=1692807845;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WPKmjKH3vI30hmWADxPP6Gm0i0g8LtfW4X1PKpkKa4=;
        b=UGf8wUSXm0E0xb23PNDIC1bdvQoDWqY7o6SXj/w2aN/diHZK4TTX0nlQo7zroOXJQe
         qt1MUbmt5lJr3ywys+JVkWbzL6yQTvzk55WCCV8dEnUpc/aNPgID2zbNEWqrsrvm+lGx
         TxwYeumOMcfAXj+YiRYXde6RPbXDLrnJMU5JrzDRYTGT7Znuwy9KT9wLY4hUtWRTmPZR
         DMFWQ3XWeIoc/bSBuN6LbjQaCFgxBNXcePrx7HlWaImJNqlmIASdSyd4WmKv1faiyJDx
         47l+yh6SUUw0tu4VR9omAVfzQ+I2mmhHjry3nl+Etp8HjeTK2ncF91xwY/lZ4lsLEn/R
         XpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692203045; x=1692807845;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WPKmjKH3vI30hmWADxPP6Gm0i0g8LtfW4X1PKpkKa4=;
        b=fG8TuCL3B+/nOYT4kW87Fsq/gQBtobyrggr0vGp4V0smstrwRM8jETC5XttDSnk7MS
         6L7oeA6Hr5kbgy/5tAABNBCJIL0kZ0yJuMtke3Imm03WJyNMZ89UJw9NF3QgHXlZwwsE
         +NqxZ+hRHqm7ShEts0rVyod+bTunJ7URdBgvHRba807EMdbAWM8m908+bh/JgBc9zVLk
         q4SrQyi5m4I0pF3AQbz/jNdJ43OIap8DUKi2d8dzayUsPTcoMh8cssUHcDjTrFY7pLki
         YnJAcNIl4uE/ErY8frMcQMBV69J14G3XMnc0PPwzF38f3BeSOBuk2lm2qNAnkdgmN10N
         G4vw==
X-Gm-Message-State: AOJu0Yxum2lo1oGcPGE4jlQVeXIrOthX/5OZjoOBsNEXpUeexo3uge0V
        C2iGEK8Pb77bSghjuMW55XrzVuiwMjg=
X-Google-Smtp-Source: AGHT+IE5j7r351lRqM+YIViVxYVvGqlCu/bv3u6+eUUwYtCuj2rkPBE0tZ2K+AseRmi61d4HTJCX1A==
X-Received: by 2002:a5d:6b84:0:b0:317:cff4:7357 with SMTP id n4-20020a5d6b84000000b00317cff47357mr1931657wrx.20.1692203044513;
        Wed, 16 Aug 2023 09:24:04 -0700 (PDT)
Received: from orome (p200300e41f1bd600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1b:d600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id e13-20020adfe7cd000000b003180fdf5589sm21981770wrn.6.2023.08.16.09.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:24:03 -0700 (PDT)
Date:   Wed, 16 Aug 2023 18:24:01 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     linux-tegra@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: tegra: Enable IOMMU for host1x on Tegra132
Message-ID: <ZNz4IZ8lSXlGIZb_@orome>
References: <20230810214543.16235-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jfBf7x5cY9mempMY"
Content-Disposition: inline
In-Reply-To: <20230810214543.16235-1-rayyan@ansari.sh>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jfBf7x5cY9mempMY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 10:45:41PM +0100, Rayyan Ansari wrote:
> Add the iommu property to the host1x node to register it with its
> swgroup.
>=20
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  arch/arm64/boot/dts/nvidia/tegra132.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Do you happen to have a Tegra132 device that you can test upstream Linux
on? Just asking out of curiosity because these devices are becoming very
rare these days and it'd be good to know if people are still using these
and that recent Linux kernels are still running on them.

Thierry

--jfBf7x5cY9mempMY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmTc+CEACgkQ3SOs138+
s6F5vA//TPAbrdWP/7n9SHdSG/ExqNDo/+BLmflFRbk4ZyxM5DxTNMkOYtbcU6lx
7mKudSObBXxd7tu+RzE0D2HCd91IYlW3+U9IGfKYumpIVnBwsrKpmgmxG2577re+
fgTxhiV2HjUSoTenDLGUV21o8qp8/MQJsJfo+ZLdUWFK4E+3AX4rFF9+vyfUVhVc
Cn6mYbw/VXsK3os4gXtpUzswT1QABZks3bG/eNctyZsjlia5W7WOVCIMh01C+7LV
Ow7sHhfnzJGJL9OjGdSFzZjm8DJw99Kpu73ObJPR/RDQZuVP2qzuXH28S9+eJMYZ
qdCmsgPMcyTpqU4jHKtlT9K/Tv9qz7G4tqpMZWpLueEenqLEiduN5Q94fEAS1xui
Q26ymOk45cxUV/ww2bIN47EIt7DX2LYAe//qGk554c3z+MbypertT0ppXsdVIAZf
bqF497EK8wNCU6aHEc2U1iMNk17Do8h/b2HLkZkjuj/YVm3HW+iguBbIB4JioLGY
nLNkchrhp3RRdFyAIbA4FrZuIEuqOOp1nGtwo+bcr0zFph+jyvMsinG0fXXJNwEs
ktKmaVZpGMMyVFMcKvCVs9i+TYwHq+OOmVkYmlHzfEYoTxC2EYySIbWzOlFjLu+q
8uE6NSbjOU8tqOOzHgtyd8eCxogbdzuUShte3RhqsPkqgCbAJDg=
=20YM
-----END PGP SIGNATURE-----

--jfBf7x5cY9mempMY--
