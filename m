Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2357525FD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjGMPDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjGMPC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:02:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D148419B4;
        Thu, 13 Jul 2023 08:02:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb73ba3b5dso1490051e87.1;
        Thu, 13 Jul 2023 08:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689260572; x=1691852572;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgOoYheic/1eveJmfA6+ivqPQJzF4lSPnsSfcznjE1w=;
        b=TtZO/8Z7Rn8rxh9PM7P3iQKoy5vK0LxpK6FQWolQLHTSMfkrSOBz+/NMejVGied4DS
         oKaJbjMkd96DY3Fw4Br9Fh5oMdniQVUVchiFpaDUOsIXaSqsTZXImOxEfLtbpobs8dME
         Rfmb9WEzPYnVGTykWbG0WGVng1sVjWBLgPKh3CoUlM0WJPX+KkuYhgzAxEK7jrJ3+Eof
         kJUQU5l0XHbT7W7Pw0xnxjmV0EZVyxk1iBBs4tN1RBHPOCKwH82xZN58eej3+goUzIDz
         dJO8X+rtwfw+iSeLPm1qkuEO0+qN4hnb+zotKClQEQ0JW84gP8Bl8f/KyqOvSLX5xvfM
         TAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689260572; x=1691852572;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mgOoYheic/1eveJmfA6+ivqPQJzF4lSPnsSfcznjE1w=;
        b=CPnFykMJHD1YLpX/CTBPziWYs8BjdKRjmhHz8GEcKnWCby3XmFs2soonKvQ4HeqkFo
         PlP/Rcl02ftUNKrsnItI2QtTOEFhXDM9PTkSrDGZ8hO39ndurPijjH8wG5wPdncSNJv+
         4BTaKwXs2OIF6Y55dF2V/Hpy0xG1Ap4M5dD4NdYtR52zRIll4UAFh4H37LYdvvoqW77g
         OTrOIHxzAZR9OC/xnYpzo4kaKdvLvLn9GyFc6UhsOhjopIkqRTu9ReEgHio0yvkqcFxV
         +IKXzANCzyIG64kF9JHff0OUpVAFgjUgA6VgGOtHOtIxzB2mExH0PiLLK/s0hGafcBVQ
         kCPQ==
X-Gm-Message-State: ABy/qLZ2EEFROCXN1PpVxg8O2CCp0fpj/GqSUGPrxVVoyBnsUG7/0iCB
        lncz+XSKXXIFQci0k5VC5MDPc5975BA=
X-Google-Smtp-Source: APBJJlEmG+ltFMXIcdiSeKFINz8Lg+v1AW3Hl+VhX1mBiswe4VMKVqi45MsvijxZpTbY7Na4rcZLhQ==
X-Received: by 2002:a05:6512:23a6:b0:4f9:5a0c:85b8 with SMTP id c38-20020a05651223a600b004f95a0c85b8mr1686964lfv.36.1689260571576;
        Thu, 13 Jul 2023 08:02:51 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id w25-20020a170906481900b00992ddf46e65sm4082160ejq.46.2023.07.13.08.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 08:02:51 -0700 (PDT)
Date:   Thu, 13 Jul 2023 17:02:49 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     krzysztof.kozlowski@linaro.org, treding@nvidia.com,
        jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, bbasu@nvidia.com, talho@nvidia.com
Subject: Re: [Patch RESEND 3/4] memory: tegra: add check if
 MRQ_EMC_DVFS_LATENCY is supported
Message-ID: <ZLASGT0mN9aj9ewL@orome>
References: <20230621134400.23070-1-sumitg@nvidia.com>
 <20230621134400.23070-4-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2X/dZqFCgg7nkckt"
Content-Disposition: inline
In-Reply-To: <20230621134400.23070-4-sumitg@nvidia.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2X/dZqFCgg7nkckt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 07:13:59PM +0530, Sumit Gupta wrote:
> Add check to ensure that "MRQ_EMC_DVFS_LATENCY" is supported by the
> BPMP-FW before making the MRQ request. Currently, if the BPMP-FW
> doesn't support this MRQ, then the "tegra186_emc_probe" fails.
> Due to this the Memory Interconnect initialization also doesn't
> happen. Memory Interconnect is not dependent on this MRQ and can
> initialize even when this MRQ is not supported in any platform.
> The check ensures that the MRQ is called only when it is supported
> by the BPMP-FW and Interconnect initializes independent of this MRQ.
> Also, moved the code to new function for better readability.
>=20
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/memory/tegra/tegra186-emc.c | 136 +++++++++++++++-------------
>  1 file changed, 71 insertions(+), 65 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--2X/dZqFCgg7nkckt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSwEhkACgkQ3SOs138+
s6Gy9Q/+IsxukfQ8tganMMPYwgRuKrnjxIKtvwCN6YIFLd3u8LbzS7Un+gbc/RtT
cZN1+GiiXoHm1oHjEGhU9NVxU8OgVzlut5nL9z2ieRIyk53+SxZlU6E2acV7xNNM
Ti2BhH3JpMTGt+/rjUkYelnIpkTf5q7CLQv+mcL1SlLgn1T24oz/RgflzE9hERha
TJ8nVJ1uduFeQJIRF/NcQtbsCMJUWrXBm+yQkt0L65JomKSteApyUJNw/3hj1KYY
d775QHaAZxAva+FRfNWMI8P+gfMe22vavSZhS70KMLn1MtyKUkXqDm+HYTZYlu2j
il8SJhbPLOaiuHG2nczkZWSoGZCvgTjIs86boqq8/7ovygJRzTeyFxKCDhmQhIHB
WzC4oTnguqLqSwhAU2eLFjgPQE1H4LFeRVclfMYm3MCIEO8JfgksGWmHyx8RYw/c
GXmD6K887AwY+QOegsx9zTsgwSmr2ijK4VPfyjUi3JER8/7SWxH57Mz99hpJLx/0
7aHGQu43BeeH5VR9oo+VC3d80DZQDhqdO//olNCPSD58/MiHDZSgdUzws5dV/q1v
jGhajhavgEOvb6XO2mldOIUcYjRl4sjdr8qNSEHRHdWTLi5i8LsyvKwVavthMoUv
kyIRmLmSCmDW2aBAqnSl+9DeEGNRr0CtrTuP/7CATpQ7LVN8frs=
=PBIz
-----END PGP SIGNATURE-----

--2X/dZqFCgg7nkckt--
