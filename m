Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF7576B623
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjHANp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjHANpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:45:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02FEF1;
        Tue,  1 Aug 2023 06:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59AE2615A9;
        Tue,  1 Aug 2023 13:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B30C43391;
        Tue,  1 Aug 2023 13:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690897522;
        bh=FlNMB4occqS43nWZw7tCdE81qdOmSaFvz51TyVwZ12A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V/Atskh0zJalEV3june32SmY+QY+ml0aprBa2qNx55YyaxGsx9+KWxumY8cWPqzLT
         HI2vWkUpJ+hyaHKzejhLj0m04KzuCr+5A7l+l01VBKxmADbPsasuUokvoukPlIk9c4
         9EqQnEdGg+MEKBvz4WZIKjt/AMEh/lCyK54N+btBGsftEblUu27TknPQD5rxvSkQtf
         jRABjhAHAlTGBLQ1JFNOIUbsxpwuTG4kOX9bbyVUWG+dVRD931p5N458wshmJ0l7K6
         1CzYkDRnrq7A7GlAdHhQDAZhltWazPq69IWuZDe9Fed3+dHCnySSEAPgrhfto5yBUT
         WAf8thcb3CjBA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so69865331fa.2;
        Tue, 01 Aug 2023 06:45:22 -0700 (PDT)
X-Gm-Message-State: ABy/qLbv8kTZ3X6pKaJznbV0mH4Kz632APlXNixkzmjuqKIJQ5zo8vQS
        Auq7soZpjEa1InNC5LyzfiSH4UyU4F1SpUIKmQ==
X-Google-Smtp-Source: APBJJlGnhX9iKt57XHeT9WSosBHuXMkDbBmL27QD49R6iCNM2dCQvYNxQbuweCPsYlRjfVRMiCmQ2gLfv5RsNo/PvvI=
X-Received: by 2002:a2e:805a:0:b0:2b6:e2aa:8fbc with SMTP id
 p26-20020a2e805a000000b002b6e2aa8fbcmr2093301ljg.8.1690897520717; Tue, 01 Aug
 2023 06:45:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230707210604.868002-1-robh@kernel.org> <ZMeZIGyD+ET6gaox@valkosipuli.retiisi.eu>
In-Reply-To: <ZMeZIGyD+ET6gaox@valkosipuli.retiisi.eu>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 1 Aug 2023 07:45:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK4A9vpUiP3sCz9+hAHitcsB9NYMMy05n4=1hn7NvjOtg@mail.gmail.com>
Message-ID: <CAL_JsqK4A9vpUiP3sCz9+hAHitcsB9NYMMy05n4=1hn7NvjOtg@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: Merge OV5695 into OV5693 binding
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Helen Koike <helen.koike@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 5:21=E2=80=AFAM Sakari Ailus <sakari.ailus@iki.fi> =
wrote:
>
> Hi Rob,
>
> On Fri, Jul 07, 2023 at 03:06:04PM -0600, Rob Herring wrote:
> > The OV5695 binding is almost the same as the OV5693 binding. The only
> > difference is 'clock-names' is defined for OV5695. However, the lack of
> > clock-names is an omission as the Linux OV5693 driver expects the same
> > 'xvclk' clock name.
> >
> > 'link-frequencies' is required by OV5693, but not OV5695. Just drop it
> > from being required. Expressing it conditionally would be ugly. It
> > shouldn't really be required either as the driver only supports 1
> > frequency anyways.
>
> The correct way to address this would appear to be to add link-frequencie=
s
> for both of these devices. I think I've seen one or two sensors of this
> class (raw, CSI-2/parallel, external clock etc.) with link frequencies
> documented as "fixed" --- which is probably a documentation issue more th=
an
> anything else.

link-frequencies is already supported. It's just a question of being
required or not. Adding a property as required is an ABI break (if the
OS starts requiring the property).

Rob
