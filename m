Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3407ABA3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 21:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjIVTqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 15:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjIVTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 15:46:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05986AC;
        Fri, 22 Sep 2023 12:45:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F816C43391;
        Fri, 22 Sep 2023 19:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695411957;
        bh=Z73INrp+tUCDrn3nt/IznNU60OcEzvbVv581pkRDXlE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P4ZZPqOmhipnrgdjc5Cicuv4gwGoR5ahpSW6RraPJhB2FOCevSoVAq7M03SUqbiJq
         K7C83A8rvE9vTWF2PZ5kYCMKgg3G1IVvpRh+NW3hqCEKgBE5APzZ0p6is/9D0IzpXy
         L4KFq+qRrX7Nsl9X/FVhceTOut8PENgISZ7V9Hgc0n17gQFch+sOZHm06uwoEbBMFg
         bdQku4DZghgBK/X1clycJXNjGfpUaVv8cK0r9G/b2uMU+jMiHYfIm/lqjl9v/3n8cS
         tduJT5OdwlLHx5IjPVmN9jiMNIWgStlkcTXysI9oJM3ogbUGEUzRoqqQuRZPSge2DG
         XwBXMnxxa/mIQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso4403480e87.1;
        Fri, 22 Sep 2023 12:45:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YzET3fIoLVxGM9RxuqSwL+djuYNXhC9P6ZumOlepuoR4JARMjx+
        h4LOZERLC7Rm7GHf2X+sobwCVY8k0UHqW/Y9dA==
X-Google-Smtp-Source: AGHT+IEyL15UWPDOOifALHGXr9zT3PFp6EFjcQQ6N5sRMKjOVNVOEvEhKETlB6KYvfp58mdiyeysUyZjSt5CkUaQLB8=
X-Received: by 2002:a19:651e:0:b0:503:18c5:6833 with SMTP id
 z30-20020a19651e000000b0050318c56833mr310830lfb.61.1695411955742; Fri, 22 Sep
 2023 12:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230922075913.422435-1-herve.codina@bootlin.com>
 <20230922075913.422435-26-herve.codina@bootlin.com> <169538601225.2919383.2942072541503354871.robh@kernel.org>
 <20230922154546.4ca18b6f@bootlin.com>
In-Reply-To: <20230922154546.4ca18b6f@bootlin.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Sep 2023 14:45:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJTruTExc=uHCPCp3q-fo+fB-wAJ-ggPpHpWcHSoGALdw@mail.gmail.com>
Message-ID: <CAL_JsqJTruTExc=uHCPCp3q-fo+fB-wAJ-ggPpHpWcHSoGALdw@mail.gmail.com>
Subject: Re: [PATCH v6 25/30] dt-bindings: net: Add the Lantiq PEF2256
 E1/T1/J1 framer
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Takashi Iwai <tiwai@suse.com>, Simon Horman <horms@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org, Paolo Abeni <pabeni@redhat.com>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Shengjiu Wan g <shengjiu.wang@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, Qiang Zhao <qiang.zhao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 8:46=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Hi Rob,
>
> On Fri, 22 Sep 2023 07:33:32 -0500
> Rob Herring <robh@kernel.org> wrote:
>
> > On Fri, 22 Sep 2023 09:59:00 +0200, Herve Codina wrote:
> > > The Lantiq PEF2256 is a framer and line interface component designed =
to
> > > fulfill all required interfacing between an analog E1/T1/J1 line and =
the
> > > digital PCM system highway/H.100 bus.
> > >
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > >  .../bindings/net/lantiq,pef2256.yaml          | 214 ++++++++++++++++=
++
> > >  1 file changed, 214 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/lantiq,pef2=
256.yaml
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/net/lantiq,pef2256.yaml: properties:lantiq,data-rate-bps: '$ref' should no=
t be valid under {'const': '$ref'}
> >       hint: Standard unit suffix properties don't need a type $ref
> >       from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> >
>
> The '-bps' suffix was added recently in
> https://github.com/devicetree-org/dt-schema/
> commit 033d0b1 ("Add '-bps' as a standard unit suffix for bits per second=
")
>
> This commit is not yet present in any dt-schema release.
>
> Should I update my patch (ie. removing $ref) right now even if this updat=
e will
> make the last dt-schema release not happy ?

Yes. I will spin a release soon as well.

Rob
