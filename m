Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7039E7519DB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbjGMHYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjGMHYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:24:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE582D47;
        Thu, 13 Jul 2023 00:23:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51de9c2bc77so412524a12.3;
        Thu, 13 Jul 2023 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689233029; x=1691825029;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2smSIC6Mx2KRuBQW3mY2Yb4bW79lOcDBYxUDHm0cCk=;
        b=UEbHeTJbZ7LyKuvjSWRk1VpJ+YgIkM7PpaFfowtm55Ej1jcmkh+TuENe4EQMwTcBF+
         oYfZ3yhd/iGtc/m1ONfnaYI82MKYqqlBfk+ww6ydh8i7AJ22REU4kJhQ2svjjDVp+SZN
         K7jetlEVrziajYXMuJKGNHgKqmgX0m1aPDfnnSRF1Iul5N7ySD1ye6iESNzt4wRkibil
         VUZImgiiCk+BmkBOiodWYrWyNR3h7v+A35x+Sm9WVIU/WJe95mC3s6AEq/AJnZk2WpW6
         4yv0RwkU7Dpg3g3kMArpTI1ITBL5YDDnHOGLsKnMUMpGGXZI8K9TSAOs+dcPOarzOnEz
         3I3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689233029; x=1691825029;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2smSIC6Mx2KRuBQW3mY2Yb4bW79lOcDBYxUDHm0cCk=;
        b=A6BxFzFqXwam8UrKWCaL14ey4r96I8MyIv39e2NsnWlxRxQ9gddvuN1K1x/bmRvFWh
         OuMjqHlgG+DxBY/MduAysG5tKXVuGe1y2vz6T0AWk5ue95pncj+TIlVAnP8Y9nFDUGK2
         XW40nRiCaDr38ViYfXCbwKWYuLtv1BmuyGReT4xC4wCRO5poJwCyYSW0+CmhKZNLjkmh
         rMn85ODKEIwUekQJPCfS7bP7RJ2+kmz7PeHQs8cbmtwDBnXgl2MfYiNTYkj/54hpTSE7
         DdjUsizxcK1ukcchstuZbW8aR7ujrCKS9lNrbDaeM/Gx+suDTHEpOf+aQ2tolPWC72sH
         v1qQ==
X-Gm-Message-State: ABy/qLbUnddOe8XOtLiAxWi6bj+cWq9xUZz411EwBh4uFVqMwsPByQWU
        MQww/m8H6R4eojxx9ZGGIAg83KU7aoc=
X-Google-Smtp-Source: APBJJlH/V3c8kH8fWRfoVqeUd4He7ZuLqIRUfMKRDtHQtMkd9sYqGd5NZLZM61W1OSMe1QjvoAlS6g==
X-Received: by 2002:a17:907:985b:b0:982:cfe2:32fe with SMTP id jj27-20020a170907985b00b00982cfe232femr669996ejc.63.1689233028794;
        Thu, 13 Jul 2023 00:23:48 -0700 (PDT)
Received: from orome (p200300e41f4b7100f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f4b:7100:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f25-20020a17090624d900b00992316f0690sm3571611ejb.74.2023.07.13.00.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 00:23:48 -0700 (PDT)
Date:   Thu, 13 Jul 2023 09:23:46 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Minjie Du <duminjie@vivo.com>
Cc:     Krishna Reddy <vdumpa@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:TEGRA IOMMU DRIVERS" <linux-tegra@vger.kernel.org>,
        "open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v3] iommu: remove redundant parameter check in
 tegra_smmu_debugfs_init()
Message-ID: <ZK-mgtHQQkDxkVqq@orome>
References: <20230713071902.9007-1-duminjie@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wLMCeSBFKkFZ5p/5"
Content-Disposition: inline
In-Reply-To: <20230713071902.9007-1-duminjie@vivo.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wLMCeSBFKkFZ5p/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 13, 2023 at 03:19:02PM +0800, Minjie Du wrote:
> debugfs_create_file() will return early if smmu->debugfs is an error
>   pointer, so an extra error check is not needed.

Not sure where the two spaces at the beginning of the line came from,
but they don't belong there.

Thierry

--wLMCeSBFKkFZ5p/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmSvpoIACgkQ3SOs138+
s6EvshAAiJBn5EfHfP6glGtjvawsr+NfMraodhNfMmfA8n2I8P8eruokHKamOTaQ
N+byvxO7+oR4kZ+4vpn9ZPp4eI24LJzPz2wg8fqUcb4eaoUcOHPczUe/lIHJt6t7
bOp7pwSgPqc0YMe+bIXa2EwUzxw2qAV4M2W7CpL7+i16kFMk4dtRKhsU5BBw2uYN
wU1pryJnLUho8kB+Da3P32+sTD+8288hs7JZ8aj6JzUe+x4BJGWfkoUoj4EqFs/x
L4bdIaFsqsQ/1lr2CP7B/sb7h5Z1GByfbw+gJa92/3sYu8FAaeaXyHYorlj5aUUD
mVgDw9s+r+oc1S3jTinubNZ3O9FkQAURFBnWBlqGHbW2Zfsuhr6ABwjKt7Xjdq/v
qSYnTyuzGoHScIHF/pXd/1lN7e8bNH0c49bO+gd9OuJ2SxfKBqANGLgz8LZGGzkT
irW9FT0zuQ+YUkYbPEvW4TzJjP90Rz70n9kQvkl/8WEWAG8Ka2gBarNWFN+/HgTs
m2x4CT13QuT1NWEp+SIi67KYcBIAPJEB3Q1jWXSkS6D2X0/+eCax9FLlrREEm3bl
XzIdpgv0yw+dE6fI3VD2V11CNsaHiqPpG0w03R8LOeiKnc7pkc4RhGM0ngC0SQWl
0omANMnOkxKmBNXuksgCagQjYlBgWj3vSvo8vllACp3tpPXawpo=
=UiJF
-----END PGP SIGNATURE-----

--wLMCeSBFKkFZ5p/5--
