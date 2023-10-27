Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FFE7DA166
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjJ0Tk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0Tk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:40:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4901B4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 12:40:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c3aec5f326so747733666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 12:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698435651; x=1699040451; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzKQXsJ9PPJ95N5huUjFyALdgbkkeZmKhRTaQ99Yt+o=;
        b=wKZpW2fww82ttWeUy1lpz4jS6QO+dMf2wi5uMBR4ioUAJkaxBwfJwDdylta/HtSNzr
         wf6eDWx+upBsAk32+pi0zevJDyYABjRG8JU1jwfr0CBpKZYT1U+d0VaM2NitjhGiUpwW
         VeBSmfIjP/dVTwSUreGHdvuIGNtp8TvrjhgbGCgeraQyTlSl3onoR1GJkyWRCD9jXxhD
         x/dVJyenJeaoAwSCEWqvB4hCxajNDdXyFyrMJxNJQ8JEqKdQxbbtt1rJfX9MKZviWayz
         z77uLsAOK4RL6x9uhNLlBG0tsHf7ypU9mY/lkL7wFBAx3Uxfz0zO3qw6ke/EJsOlxu11
         /hyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698435651; x=1699040451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzKQXsJ9PPJ95N5huUjFyALdgbkkeZmKhRTaQ99Yt+o=;
        b=D2y7EonRC4FdgbZ6f1NrIhYOWqv7AysbwhMbu4YBBXaiVVrWBxmMy0Mo/GV7he+8Vw
         dfkzpNt8cO9lXkcrRzz2AUiK1OfH6TnSLnbaKGFUHKd5Z469VzYd3PQrFflr1fwamWeU
         5p9jzzBsbRZxJWPzQUECkkXPz+Cs4jdp+Q1GwL75qx90vM9s6iF+qc3y/12QtXC2aLy8
         TIypGc7/RRs9hbCjUJlnT9lwW5g39x8ODyfu3s0Ac0LTpLQ5WlJbESGlU+yjp5abqlCD
         ZQMiWLKeia10SBLOV4D7NEGltUlrCP7y2KYVUlaXnybYb3xCIELdcsiwRPKvl7+nVsDD
         5J8w==
X-Gm-Message-State: AOJu0YyWSHo27i932MiJMrzpDjrbWAgcGkOeSZP/EEJwR+BG3mPM9DZ3
        kYajIsXTxUjyuJ3UWMm1pw2VIoaQyVPOAbfYe76AmA==
X-Google-Smtp-Source: AGHT+IEPfEM/trnfZm6cOr0U7cu+iGr19zJct2V4K5qR5GqFK9SelPMa/Z/9udzIJpJO7oi3U+zFq2t/7LTPw2L/vcI=
X-Received: by 2002:a17:907:2da3:b0:9c3:97d7:2c67 with SMTP id
 gt35-20020a1709072da300b009c397d72c67mr3978966ejc.25.1698435651329; Fri, 27
 Oct 2023 12:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-2-0d67cbdd0538@google.com> <8521c712250bcffce5c71e8d2b2574de786d4572.camel@perches.com>
In-Reply-To: <8521c712250bcffce5c71e8d2b2574de786d4572.camel@perches.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Fri, 27 Oct 2023 12:40:39 -0700
Message-ID: <CAFhGd8p9ytqbRuqgWmKe=zCg7Nhft0NMvbuuEyjAQHNAcBedaQ@mail.gmail.com>
Subject: Re: [PATCH next v2 2/3] checkpatch: add ethtool_sprintf rules
To:     Joe Perches <joe@perches.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shay Agroskin <shayagr@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        David Arinzon <darinzon@amazon.com>,
        Noam Dagan <ndagan@amazon.com>,
        Saeed Bishara <saeedb@amazon.com>,
        Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        Dimitris Michailidis <dmichail@fungible.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Louis Peens <louis.peens@corigine.com>,
        Shannon Nelson <shannon.nelson@amd.com>,
        Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Ronak Doshi <doshir@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Jiawen Wu <jiawenwu@trustnetic.com>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
        linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 3:39=E2=80=AFPM Joe Perches <joe@perches.com> wrote=
:
>
> On Thu, 2023-10-26 at 21:56 +0000, Justin Stitt wrote:
> > Add some warnings for using ethtool_sprintf() where a simple
> > ethtool_puts() would suffice.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -7011,6 +7011,25 @@ sub process {
> >                            "Prefer strscpy, strscpy_pad, or __nonstring=
 over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr=
);
> >               }
> >
> > +# ethtool_sprintf uses that should likely be ethtool_puts
> > +             if ($line =3D~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$=
FuncArg\s*\)/) {
> > +                     if(WARN("ETHTOOL_SPRINTF",
> > +                        "Prefer ethtool_puts over ethtool_sprintf with=
 only two arguments\n" . $herecurr) &&
> > +         $fix) {
> > +         $fixed[$fixlinenr] =3D~ s/ethtool_sprintf\s*\(/ethtool_puts\(=
/;
> > +       }
> > +             }
> > +
> > +             # use $rawline because $line loses %s via sanitization an=
d thus we can't match against it.
> > +             if ($rawline =3D~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\=
s*\"\%s\"\s*,\s*$FuncArg\s*\)/) {
> > +                     if(WARN("ETHTOOL_SPRINTF",
> > +                        "Prefer ethtool_puts over ethtool_sprintf with=
 standalone \"%s\" specifier\n" . $herecurr) &&
> > +         $fix) {
> > +         $fixed[$fixlinenr] =3D~ s/ethtool_sprintf\s*\(\s*(.*?),.*?,(.=
*?)\)/ethtool_puts\($1,$2)/;
>
> Thanks, but:
>
> This fix wouldn't work if the first argument was itself a function
> with multiple arguments.
>
> And this is whitespace formatted incorrectly.
>
> It:
>
> o needs a space after if
> o needs a space after the comma in the fix
> o needs to use the appropriate amount and tabs for indentation
> o needs alignment to open parentheses
> o the backslashes are not required in the fix block
>
> Do you want me to push what I wrote in the link below?
> https://lore.kernel.org/lkml/7eec92d9e72d28e7b5202f41b02a383eb28ddd26.cam=
el@perches.com/

Ah, I didn't see you provided a diff in previous thread.

Yeah you can push it but it's not really a standalone so perhaps I'll
just steal the diff and
wrap into v3?

>
> > +       }
> > +             }
> > +
> > +
> >  # typecasts on min/max could be min_t/max_t
> >               if ($perl_version_ok &&
> >                   defined $stat &&
> >
>

Thanks
Justin
