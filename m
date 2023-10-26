Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480357D8BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 00:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbjJZWZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 18:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjJZWZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 18:25:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B783CC
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 15:25:08 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso2158572a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698359107; x=1698963907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeD8ayoKI+cNQ+dfy3v3WycX2QANJHfshgC8v+Kwnbw=;
        b=GU1LpBpDCnYxb8bp+dnWZ9au4wpEq0GwhQRGapIBqwVja+Jg9m1Idz0jldUI6+SuiU
         SRNktZ8FHw1OMU8X5C0LGrblY3IBErxVCmeRSv3NRv35SUC5w7wUwlUMXfNocwuyjWiv
         +MKJghA4AwDwk1WwywWsx1HIzWvNh8O59q/xTzE/0zCHeh3iXq9dr1JUCrkzsLX/RpBM
         fjPeTAcyg47Qmg1rpb4+NpYnsVdARIbLM+5tjGHB58pWpeKTJGxwbFTmlTJ+tsfBYkgh
         //OiUW5hjE+9St6bN3D2sgEUyPJ/LuVBnIWAt4MKOP559OQ1nTenXBVJ8J7S4wwwXXRU
         nL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698359107; x=1698963907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeD8ayoKI+cNQ+dfy3v3WycX2QANJHfshgC8v+Kwnbw=;
        b=CvCh7T4DeYX4q0YufTr4hCMOkH08EkmpwnoJIBlUfDeEq6IT2lwpeYvIBOsNlnIQgC
         tq/Vf/Bse+AXLzQriMy7eQoMuirUiI9tKuofFgl/mjwczbiQo1s8YvSx0BkJXKhbtBaU
         TdqmTUv6+evA5mdZu2YsnNMcgsnyfHDzy+Ebndt6Pdfwq80bRmUsVl4k7EoN1+gynWRE
         Hw0q7fxwSsfhYzuHGZCOvOqBYLKt3hE+YU8pPJccaDOeC+AobnafAl9dAePVZeS5jmAD
         7bjAZSpnd2pjb8nY5W3StWHsl61QGDec3s4gsKhB2AgO3stM3qpWKsxT9GVudAumUBrI
         FHHg==
X-Gm-Message-State: AOJu0YwyI28DqawV3FpbD6B7/HiX/zoHcucytYU5YwZMtR5ack/60Of1
        BjyczMZUYLYccYtkRM8xLY4rJm6rT5wyLtuFNy7l9g==
X-Google-Smtp-Source: AGHT+IEDCJBHZUfT8pOveWHXKzhM9wbznVGkZxbqGNmoGRYpA7P/cGpiYUPu1qoNnYeFP4ggNqE2H/AXW9GW4yBSvD0=
X-Received: by 2002:a17:907:928b:b0:9ae:46c7:90fe with SMTP id
 bw11-20020a170907928b00b009ae46c790femr740516ejc.72.1698359106926; Thu, 26
 Oct 2023 15:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-2-0d67cbdd0538@google.com> <20231026221206.52oge3a5w4uxkkd5@skbuf>
In-Reply-To: <20231026221206.52oge3a5w4uxkkd5@skbuf>
From:   Justin Stitt <justinstitt@google.com>
Date:   Thu, 26 Oct 2023 15:24:54 -0700
Message-ID: <CAFhGd8r-u193pBk2+WWF+sHWEo5ixxEiT=fcSYiuy5W+aWDsbg@mail.gmail.com>
Subject: Re: [PATCH next v2 2/3] checkpatch: add ethtool_sprintf rules
To:     Vladimir Oltean <olteanv@gmail.com>
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
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
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
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 3:12=E2=80=AFPM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Thu, Oct 26, 2023 at 09:56:08PM +0000, Justin Stitt wrote:
> > Add some warnings for using ethtool_sprintf() where a simple
> > ethtool_puts() would suffice.
> >
> > The two cases are:
> >
> > 1) Use ethtool_sprintf() with just two arguments:
> > |       ethtool_sprintf(&data, driver[i].name);
> > or
> > 2) Use ethtool_sprintf() with a standalone "%s" fmt string:
> > |       ethtool_sprintf(&data, "%s", driver[i].name);
> >
> > The former may cause -Wformat-security warnings while the latter is jus=
t
> > not preferred. Both are safely in the category of warnings, not errors.
> >
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> >  scripts/checkpatch.pl | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 25fdb7fda112..22f007131337 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
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
> > +       }
> > +             }
> > +
> > +
> >  # typecasts on min/max could be min_t/max_t
> >               if ($perl_version_ok &&
> >                   defined $stat &&
> >
> > --
> > 2.42.0.820.g83a721a137-goog
> >
>
> I don't really know Perl, but does the indentation and coding style here
> conform to any rules, or is it just free-form? The rest of the script
> looks almost as you'd expect from C. This is unreadable to me.

There was some discussion here [1] but AFAICT I need to use EMACS
or configure my vim in a very particular way to get the same formatting

But yeah, look around line 7000 -- lots of this pattern matching code is
pretty hard to read. Not sure there's much to be done as far as readability
is concerned.

[1]: https://lore.kernel.org/all/137a309b313cc8a295f3affc704f0da049f233aa.c=
amel@perches.com/

Thanks
Justin
