Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A8D798318
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbjIHHLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjIHHLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:11:37 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6E719A8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 00:11:32 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-57325fcd970so1073074eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 00:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1694157092; x=1694761892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=72dFAJSGUagOoS+KoRkKv9gdaS3fHJdzDdjwkMM9wZc=;
        b=t0ZAn1qeMFUNAuAheEHg8mfSXbiXo9T0AzovkZGPedynp+Tx8qH7Hfa4V3TR6rqCBL
         zE/Dyw5A4e+uB5DvggznqRZrv6Ocg22eGRzhgOALuYOCgwk7ik1SzM6zku/H/CmObFWI
         J6r5Zd1Csqt+UJwKEEsLWxpr96HZAFejf5JR3hOiz2LlZJez44haXQRCxqyfG8+2+KZH
         /k8LTOO3imNYVID0hxN8aSM6b7R1OEa7Q8eQ48M20LwJVdjFbJ2RNRFHToxCWct4a04L
         sDNVF2HmFNnC9he/5om6WqBqAzgTLS360oeqM+yM65wmF+uY6Cn/4OlKzLvz3fCNtdEy
         brbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694157092; x=1694761892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72dFAJSGUagOoS+KoRkKv9gdaS3fHJdzDdjwkMM9wZc=;
        b=p1PRnIjm37oFEqa9Rvspm/qUmHlG174YA3GhMW+nnYvfCvacVpjfypqB8LE7H8Qxg4
         33njcS7gvetT1q7fKUGyBzRjIg9KpJCB3u//FDfqBpFUP4H2BEfHz+xVItqlMRpp7ScJ
         btPqr/T+GpQL+S9Yt6xZI4WniTPOFAkZjnxd7boi0pQpiZGPz8QN91nW3aKX8LCK5CuR
         exmgC1La04JPHmJAf++kR9ZUm+1Phj/sSxOcxVcEuaYQK833JWmkk+ZwScD2SvcC7H0U
         ssn5mZKGfZybIsCo3DFu7znmLGl9hXrWIg54hcgyPueAAEdIiL+mzjOCPFEFv2kPpUH6
         WAPA==
X-Gm-Message-State: AOJu0YwC3JCd+0m8nDoAmZLaUBrMBvcS9HX0wIORhtCBWI0FN5KSX2Bv
        g/UKXZFVzw2MI5nVYhd3N7N0JzxJXUIK/hqp5Kkjbg==
X-Google-Smtp-Source: AGHT+IHh32vWOCqQk/yQ9vH2Sb0yomFK9N4t9UhZFg7t2QpHtDnkNUivzN5mBR/6w4hKnCmTQPTcpXSzn8v85vYLPUk=
X-Received: by 2002:a4a:6251:0:b0:570:c0c3:8319 with SMTP id
 y17-20020a4a6251000000b00570c0c38319mr1805993oog.3.1694157092101; Fri, 08 Sep
 2023 00:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230908061950.20287-1-hbh25y@gmail.com> <20230908061950.20287-3-hbh25y@gmail.com>
In-Reply-To: <20230908061950.20287-3-hbh25y@gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 8 Sep 2023 09:11:20 +0200
Message-ID: <CAPv3WKe3=RDzcp60KdX8Ew8DF=E1Uqgjr1LWQXsgiOdNuDTxSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] net: ethernet: mvpp2_main: fix possible OOB write
 in mvpp2_ethtool_get_rxnfc()
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     justin.chen@broadcom.com, florian.fainelli@broadcom.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux@armlinux.org.uk, nbd@nbd.name,
        john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
        lorenzo@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        maxime.chevallier@bootlin.com, nelson.chang@mediatek.com,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 8 wrz 2023 o 08:21 Hangyu Hua <hbh25y@gmail.com> napisa=C5=82(a):
>
> rules is allocated in ethtool_get_rxnfc and the size is determined by
> rule_cnt from user space. So rule_cnt needs to be check before using
> rules to avoid OOB writing or NULL pointer dereference.
>
> Fixes: 90b509b39ac9 ("net: mvpp2: cls: Add Classification offload support=
")
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/ne=
t/ethernet/marvell/mvpp2/mvpp2_main.c
> index eb74ccddb440..21c3f9b015c8 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -5586,6 +5586,11 @@ static int mvpp2_ethtool_get_rxnfc(struct net_devi=
ce *dev,
>                 break;
>         case ETHTOOL_GRXCLSRLALL:
>                 for (i =3D 0; i < MVPP2_N_RFS_ENTRIES_PER_FLOW; i++) {
> +                       if (loc =3D=3D info->rule_cnt) {
> +                               ret =3D -EMSGSIZE;
> +                               break;
> +                       }
> +
>                         if (port->rfs_rules[i])
>                                 rules[loc++] =3D i;
>                 }

Reviewed-by: Marcin Wojtas <mw@semihalf.com>

Thanks,
Marcin
