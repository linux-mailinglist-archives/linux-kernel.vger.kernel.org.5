Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D15754A0D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGOQMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGOQMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:12:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99361E52
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689437512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Js70kE6M4tQuHcgETIy8XYzF63AeuA3GvQidoiOZKq8=;
        b=dYYFt6s4e6CAacR7XyJfvaRROmPd+8UwddJ08I3yMXG3jJerPFNkDPlHYNQqAgbKuXedap
        UzbZ9IHO+PcWp+M1TK5vhIY5ql2mIP7cMedTAyVVHyvUctGWIsY1Tzwpd3LJVKsz2Pu0u5
        yBXb9p+8oCCveEYMj597cXrxn9FbiPw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-SEU_BYxAOPWSoR6Dn0ClLw-1; Sat, 15 Jul 2023 12:11:48 -0400
X-MC-Unique: SEU_BYxAOPWSoR6Dn0ClLw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa8db49267so14994515e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 09:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689437507; x=1692029507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Js70kE6M4tQuHcgETIy8XYzF63AeuA3GvQidoiOZKq8=;
        b=aiz0C7y5Wf4Of9Lov/g1BCfzumEz+ca79rTTEBzS/BkUXW8caOVcU9KyFAKyx8iIce
         +0GUtVEOduXGA8088dZKIIdt5t6mj5bpvLklQpi0ZRduq9xdhweHVhIfW3IgkbcezLD7
         7+ahiqlYJnfxQ1DG/GaL1zhWG7t+Z1gCTf9g7o4Oy79Js1amUqZC++FLKxLZOF69gX8n
         yWvRI4/wnSfgBNlCIh9q/zxxIcP7WzOROriFhwrnjoLaPlxpV+tbvDh6Ir4VT5gQF9n9
         sSdxgXiVv5q6WxA1t0+lPJ09U2uUvh9gv5jiAj/Pc5UdifD7hC6/Y0AagSoq8TNSIvbO
         flnQ==
X-Gm-Message-State: ABy/qLaWD1l3dFbTobykhTBaA4OqPddWEShE6bCcUoIS5qA/h64JNSoc
        S3oNu1/CYdOUrOmPubbDAZGCgcumSZVrDUSb+Gh5GWU0eEEVSv62bJkT9JOfosy6x6hBwi3W3E4
        5IaqfmhaiCthRO8ucL9X9KVNs
X-Received: by 2002:a7b:c40d:0:b0:3fc:1a6:7764 with SMTP id k13-20020a7bc40d000000b003fc01a67764mr6353261wmi.16.1689437507834;
        Sat, 15 Jul 2023 09:11:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG69QqpP0KlK6PdSqxWvSyyuu5NRgXyRxSUWxITz0TGdie9WxsU5U+VqP/uxSgCoNT0EjL9WQ==
X-Received: by 2002:a7b:c40d:0:b0:3fc:1a6:7764 with SMTP id k13-20020a7bc40d000000b003fc01a67764mr6353234wmi.16.1689437507258;
        Sat, 15 Jul 2023 09:11:47 -0700 (PDT)
Received: from localhost (net-130-25-106-149.cust.vodafonedsl.it. [130.25.106.149])
        by smtp.gmail.com with ESMTPSA id y6-20020a1c4b06000000b003fc3b03e631sm3602905wma.1.2023.07.15.09.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 09:11:46 -0700 (PDT)
Date:   Sat, 15 Jul 2023 18:11:44 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>
Subject: Re: [PATCH v2 net-next 6/9] net: ethernet: mtk_eth_soc: add
 MTK_NETSYS_V3 capability bit
Message-ID: <ZLLFQJ/CMvqQqRgN@lore-desk>
References: <cover.1689012506.git.daniel@makrotopia.org>
 <6dc1e0ad7e8138835c959fc83a6c1564e8488c59.1689012506.git.daniel@makrotopia.org>
 <ZK+m+ayRW/uaxl6u@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Eh7tZsXyDFZVqJbt"
Content-Disposition: inline
In-Reply-To: <ZK+m+ayRW/uaxl6u@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Eh7tZsXyDFZVqJbt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> on thu, jul 13, 2023 at 03:19:49am +0100, daniel golle wrote:
> > +
> > +		if (mtk_has_caps(eth->soc->caps, mtk_netsys_v3)) {
>=20
> this is a case in point for one of my previous comments...
>=20
> this code started out believing that testing for mtk_netsys_v2 for v2
> features would be sufficient. your first patch ended up having to
> change that to !v1. how long until this becomes !v1 && !v2 because
> it gets used on v3 and v4 etc?
>=20
> this is why i think an integer version field would be a much saner
> approach.

ack, I will fix it.

Regards,
Lorenzo

>=20
> --=20
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>=20

--Eh7tZsXyDFZVqJbt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZLLFQAAKCRA6cBh0uS2t
rGs9AP49MdY//QxPjTry+O5HMEDUJz0xScmT7VFDAbt7wb7HwwEAn0Yz8q6MfSkC
djHk8lPoM7OXLyH5gZ4UFWEqt305dgI=
=nLva
-----END PGP SIGNATURE-----

--Eh7tZsXyDFZVqJbt--

