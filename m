Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F278129D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443347AbjLNH6C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 02:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjLNH6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:58:00 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91497E0;
        Wed, 13 Dec 2023 23:58:05 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbcdfad714aso707894276.3;
        Wed, 13 Dec 2023 23:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702540684; x=1703145484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sj0NwqxPiof3ml42MbQY4Ahv5ohZXpex6OnUgaYQww8=;
        b=WJi/ohrGdnui+xHmqlYZ0jR7MAZ6XBk6cPmXjaN4qj3dMTl9zN1HGq66RyYnl9rlb5
         xq9TnDWuGyXDdTBzZESIBk4TnVYlRkpYx9xpN6T6wDYc4nT+WlSqycTpXnRIUtaqEyrg
         DFZd7y+IU1d2ZuoSoRIaokqyiW3XC1rDa0GTYbkdGtJXqFoyJHPBKhmwOq7iKRTvyXkA
         albWcAXmUqS7f77l+rLLSbXK/QI5nkzT1lQgGSYuWzOyHrmNE1yhnkKmgG5PObsyUrKi
         bTnM516NcVUyTUSv5wG97bXVLEZeKTc36643sDpnjdyLKU9fIkAGnYjv9E2yiH4X7UMe
         g22A==
X-Gm-Message-State: AOJu0YyGDDPBtyBQYfDNW9LfOF63NF02Cx9OCPP89r8dq5k+OuW75WOI
        4iUxAZ+2MymYyEDLo1TKc5EvynVAw2WHcA==
X-Google-Smtp-Source: AGHT+IGmGY/s839VHzJmmPpAftTdQg4AhG/3K9CTqyyHA24aK6e+tyX6vGcqUdXulWCDFUjA2B9YoQ==
X-Received: by 2002:a25:f45:0:b0:dbc:e89d:659d with SMTP id 66-20020a250f45000000b00dbce89d659dmr75478ybp.50.1702540684524;
        Wed, 13 Dec 2023 23:58:04 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id v139-20020a252f91000000b00dbccadd6dd8sm1265708ybv.59.2023.12.13.23.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 23:58:04 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbcdec51ed9so779788276.0;
        Wed, 13 Dec 2023 23:58:04 -0800 (PST)
X-Received: by 2002:a5b:7cf:0:b0:da0:442f:988e with SMTP id
 t15-20020a5b07cf000000b00da0442f988emr5673057ybq.19.1702540684087; Wed, 13
 Dec 2023 23:58:04 -0800 (PST)
MIME-Version: 1.0
References: <20231202035511.487946-1-sjg@chromium.org> <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com> <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com> <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com> <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
 <CAGXv+5Est3FL-XcEL-vB-6zVNas0mqb2cNYa==Yb7W2SQU9xVQ@mail.gmail.com> <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
In-Reply-To: <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Dec 2023 08:57:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXDPSQXNhBH5LCrggfJCWG32v_ZtcRdPfaGRuLj20N+Lg@mail.gmail.com>
Message-ID: <CAMuHMdXDPSQXNhBH5LCrggfJCWG32v_ZtcRdPfaGRuLj20N+Lg@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Glass <sjg@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Will Deacon <will@kernel.org>,
        linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Thu, Dec 14, 2023 at 7:12 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> On Thu, Dec 14, 2023 at 1:03 PM Chen-Yu Tsai <wenst@chromium.org> wrote:
> > On Sun, Dec 10, 2023 at 1:31 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Sat, Dec 9, 2023 at 4:29 PM Laurent Pinchart
> > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > On Sat, Dec 09, 2023 at 10:13:59PM +0900, Chen-Yu Tsai wrote:
> > > > > On Thu, Dec 7, 2023 at 11:38 PM Laurent Pinchart
> > > > > <laurent.pinchart@ideasonboard.com> wrote:
> > > > > > On Thu, Dec 07, 2023 at 10:27:23PM +0800, Chen-Yu Tsai wrote:
> > > > > > > On Sun, Dec 03, 2023 at 05:34:01PM +0200, Laurent Pinchart wrote:
> > > > > > > > On Fri, Dec 01, 2023 at 08:54:42PM -0700, Simon Glass wrote:
> > > > > > > > > Add a script which produces a Flat Image Tree (FIT), a single file
> > > > > > > > > containing the built kernel and associated devicetree files.
> > > > > > > > > Compression defaults to gzip which gives a good balance of size and
> > > > > > > > > performance.
> > > > > > > > >
> > > > > > > > > The files compress from about 86MB to 24MB using this approach.
> > > > > > > > >
> > > > > > > > > The FIT can be used by bootloaders which support it, such as U-Boot
> > > > > > > > > and Linuxboot. It permits automatic selection of the correct
> > > > > > > > > devicetree, matching the compatible string of the running board with
> > > > > > > > > the closest compatible string in the FIT. There is no need for
> > > > > > > > > filenames or other workarounds.
> > > > > > > > >
> > > > > > > > > Add a 'make image.fit' build target for arm64, as well. Use
> > > > > > > > > FIT_COMPRESSION to select a different algorithm.
> > > > > > > > >
> > > > > > > > > The FIT can be examined using 'dumpimage -l'.
> > > > > > > > >
> > > > > > > > > This features requires pylibfdt (use 'pip install libfdt'). It also
> > > > > > > > > requires compression utilities for the algorithm being used. Supported
> > > > > > > > > compression options are the same as the Image.xxx files. For now there
> > > > > > > > > is no way to change the compression other than by editing the rule for
> > > > > > > > > $(obj)/image.fit
> > > > > > > > >
> > > > > > > > > While FIT supports a ramdisk / initrd, no attempt is made to support
> > > > > > > > > this here, since it must be built separately from the Linux build.
> > > > > > > >
> > > > > > > > FIT images are very useful, so I think this is a very welcome addition
> > > > > > > > to the kernel build system. It can get tricky though: given the
> > > > > > > > versatile nature of FIT images, there can't be any
> > > > > > > > one-size-fits-them-all solution to build them, and striking the right
> > > > > > > > balance between what makes sense for the kernel and the features that
> > > > > > > > users may request will probably lead to bikeshedding. As we all love
> > > > > > > > bikeshedding, I thought I would start selfishly, with a personal use
> > > > > > > > case :-) This isn't a yak-shaving request though, I don't see any reason
> > > > > > > > to delay merging this series.
> > > > > > > >
> > > > > > > > Have you envisioned building FIT images with a subset of DTBs, or adding
> > > > > > > > DTBOs ? Both would be fairly trivial extensions to this script by
> > > > > > > > extending the supported command line arguments. It would perhaps be more
> > > > > > > > difficult to integrate in the kernel build system though. This leads me
> > > > > > > > to a second question: would you consider merging extensions to this
> > > > > > > > script if they are not used by the kernel build system, but meant for
> > > > > > > > users who manually invoke the script ? More generally, is the script
> > > > > > >
> > > > > > > We'd also be interested in some customization, though in a different way.
> > > > > > > We imagine having a rule file that says X compatible string should map
> > > > > > > to A base DTB, plus B and C DTBO for the configuration section. The base
> > > > > > > DTB would carry all common elements of some device, while the DTBOs
> > > > > > > carry all the possible second source components, like different display
> > > > > > > panels or MIPI cameras for instance. This could drastically reduce the
> > > > > > > size of FIT images in ChromeOS by deduplicating all the common stuff.
> > > > > >
> > > > > > Do you envision the "mapping" compatible string mapping to a config
> > > > > > section in the FIT image, that would bundle the base DTB and the DTBOs ?
> > > > >
> > > > > That's exactly the idea. The mapping compatible string could be untied
> > > > > from the base board's compatible string if needed (which we probably do).
> > > > >
> > > > > So something like:
> > > > >
> > > > > config {
> > > > >     config-1 {
> > > > >         compatible = "google,krane-sku0";
> > > > >         fdt = "krane-baseboard", "krane-sku0-overlay";
> > > > >     };
> > > > > };
> > > > >
> > > > > With "krane-sku0-overlay" being an overlay that holds the differences
> > > > > between the SKUs, in this case the display panel and MIPI camera (not
> > > > > upstreamed) that applies to SKU0 in particular.
> > > >
> > > > The kernel DT makefiles already contain information on what overlays to
> > > > apply to what base boards, in order to test the overlays and produce
> > > > "full" DTBs. Maybe that information could be leveraged to create the
> > > > configurations in the FIT image ?
> > >
> > > Although the "full" DTBs created may only be a subset of all possible
> > > combinations (I believe Rob just started with creating one "full" DTB
> > > for each overlay, cfr. the additions I made in commit a09c3e105a208580
> > > ("arm64: dts: renesas: Apply overlays to base dtbs")), that could
> > > definitely be a start.
> > >
> > > Now, since the kernel build system already creates "full" DTBs, does
> > > that mean that all of the base DTBs, overlays, and "full" DTBs will
> > > end up in the FIT image?
> >
> > I suppose we could add an option to the packing tool to be able to _not_
> > add the "full" DTBs if they can also be assembled with a base DTB and
> > overlays. Think of it as a firmware compatibility option: if the firmware
> > supports overlays, then you almost always want the deconstructed parts,
> > not the fully assembled ones. Vice versa.
> >
> > If we don't we could end up with two configurations that have the same
> > compatible string?
>
> Right.
>
> We would end up with such situations because applying
> an overlay does not change the compatible string.

That is correct.  Which is one of the reasons for not using overlays
for this, cfr. the details in my reply in the other thread
"Re: Proposal: FIT support for extension boards / overlays"
https://lore.kernel.org/all/CAMuHMdXQdMeXUOAAw5nDO4+q5_HFvUc86Wi8ykMwjUwPex6wvQ@mail.gmail.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
