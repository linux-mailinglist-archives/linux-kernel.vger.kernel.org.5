Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51FE777E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjHJQ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbjHJQ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:28:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7897E53;
        Thu, 10 Aug 2023 09:27:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D9CF66367;
        Thu, 10 Aug 2023 16:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A082FC433CA;
        Thu, 10 Aug 2023 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691684878;
        bh=1uOPhd/TGZVc50vJm5N3nOBZuoc7uO6m9eAcoDZzXvg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AOjAu3zyP4aIquoh4aUaxep+S85yNfYEbAxhGk+qZnDfJb65+3OnyimfZCrEgnXs3
         EoiC/pHa9FlRUzTpPQ2BvtYdz3ndsWAYz+mngnDoMSOtxH0UDeQGufvnIWTJajt0Tf
         eGCll8O+tOuIYqd5DFbgMdQHgitvT4muWTdpnK+IeCl/m4+66yHOBUc5NhXFHGqChd
         CkQPZzOo2u1NUNh+HODAbokcHQjm1SJSipwALubgKmv+JDAFqpjAraIpRqY7fB9U9z
         NtJNgQcyJu7OOU5MhIAEsPFHIy8Iq3ELTs7u3RYOWjC73kmWQqAKo9jeKWPIR62yCr
         bcCcbSvGhUDcg==
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d479d128596so1568341276.1;
        Thu, 10 Aug 2023 09:27:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YxDcTmRcBnSA/htG9RrinX1JkQNuCMpRpa37vwWKdF4fe0QL/Pa
        Y0k0yjSirqC7vKBt2uornzgzt67NftwtLg+nbw==
X-Google-Smtp-Source: AGHT+IFOyMAT+LzUzpq0pyxDfCYUTe6KwSf4qtBrlqGEsIJEOqifg9vah0d+5UFaukDKELTJfTw3ZYA1gkoEbUbdZGg=
X-Received: by 2002:a05:6902:1025:b0:d48:f413:d21a with SMTP id
 x5-20020a056902102500b00d48f413d21amr3258310ybt.32.1691684877632; Thu, 10 Aug
 2023 09:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230810102309.223183-1-robert.marko@sartura.hr>
 <169166649202.64563.6248344012653953343.robh@kernel.org> <CA+HBbNE6H4WWW=+etRysPZr0bAXKaAq_0-oB0SnhUb5quQtivw@mail.gmail.com>
In-Reply-To: <CA+HBbNE6H4WWW=+etRysPZr0bAXKaAq_0-oB0SnhUb5quQtivw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Aug 2023 10:27:42 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLK54gEwMu61n_pbNcS2s+ekuJ2B3DN1S8htgzXfJu6+g@mail.gmail.com>
Message-ID: <CAL_JsqLK54gEwMu61n_pbNcS2s+ekuJ2B3DN1S8htgzXfJu6+g@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: ethernet-controller: add
 PSGMII mode
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     pabeni@redhat.com, netdev@vger.kernel.org, andrew@lunn.ch,
        davem@davemloft.net, edumazet@google.com, conor+dt@kernel.org,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        luka.perkov@sartura.hr, hkallweit1@gmail.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 5:32=E2=80=AFAM Robert Marko <robert.marko@sartura.=
hr> wrote:
>
> On Thu, Aug 10, 2023 at 1:21=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> >
> > On Thu, 10 Aug 2023 12:22:54 +0200, Robert Marko wrote:
> > > Add a new PSGMII mode which is similar to QSGMII with the difference =
being
> > > that it combines 5 SGMII lines into a single link compared to 4 on QS=
GMII.
> > >
> > > It is commonly used by Qualcomm on their QCA807x PHY series.
> > >
> > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > ---
> > >  Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> >
> >
> > doc reference errors (make refcheckdocs):
>
> I am not getting any errors, nor there are any listed here as well.
> Is this a bot issue maybe?

Yes. Converting dtschema to pyproject.toml yesterday did not go well...

Rob
