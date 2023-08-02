Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A03876D519
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjHBR0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHBRZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:25:57 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4393ED;
        Wed,  2 Aug 2023 10:25:56 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-583fe10bb3cso82826357b3.2;
        Wed, 02 Aug 2023 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690997156; x=1691601956;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YpPXroXrivp2oqSXrd5mVrkzp3XdQTSk9hrAgVtYUMI=;
        b=di135iIWW+eTqzw4vL43zpQ02LIFyGoRZR7ZhFsNukaq27imiHGAlcaz3pSlptp5Dp
         EwYJEpfS5XBfF5e6JZQZijnreYABU5nMNqk6RCYQN8xlX/zNNnt+sjIiPokyWwZJbpqD
         TP8vfYN9zToVR9ljOLLtq1Frm9VQkuFkXVdHJ1BJ/u0xKQRp3x9v41IACG9ZhfVf3ZOS
         4UrbUOj1Hgihw7yx+7VZynYoM9+zSsWWOVZkbCu+FxF84jha0q3eO6wRgv+Qe9ihw2P7
         gWiqKytdPdybEIo2UORvZChskMiIVcvjQM+4JoXMYTRKUlSqb6gcjQsKlYBzV8GYvYDx
         V94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997156; x=1691601956;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpPXroXrivp2oqSXrd5mVrkzp3XdQTSk9hrAgVtYUMI=;
        b=E8o/GHSRxn7iRONkUsZQ8ZRDZw0f5IRhlnzUbuDeOfSLe3NE8UT+QDA7Tsag00CE4m
         HP9KN/OKx8Zy6ncHkjD98QvSI6OIkQa/yA2l4Dz165CqBHEZD9w4M5p1B5D6C0SK+FVI
         kcqJVQiRRMS28vqOZFjw6vno4XBeT8mdHIHGGlgiBGh1rjvCX/ooCIWBPNj1ufMKwxhA
         z+rNAsGyfLBDv9CxSEWN2Q4FM6VPxn0nTVLTSx1NzC3jROgMGHLsVn4LnmUfoSgZoqei
         cNQPCnMxdT4Tb4yjMh0pb98EwdUbwH3qccoSFArgBDY9Jr0pv7MB0S+/V00bnXMPnety
         ecjg==
X-Gm-Message-State: ABy/qLYmfiFjjDjE5kNY1FLXQO+DkISIxfhb9Z20v/CNHcrL4q6bWZVA
        2DzwY3DpASoXLZW6Z+XasG0=
X-Google-Smtp-Source: APBJJlEt7z7QZtDchjFQrTTiyOdhjoBA522GpyLibMtT4mAHwoGMoo1oTrWqNFzmBJaiw8V99Oc7mQ==
X-Received: by 2002:a81:c313:0:b0:576:f0d6:3d68 with SMTP id r19-20020a81c313000000b00576f0d63d68mr18840238ywk.32.1690997155892;
        Wed, 02 Aug 2023 10:25:55 -0700 (PDT)
Received: from neuromancer. ([75.28.21.198])
        by smtp.gmail.com with ESMTPSA id a135-20020a0dd88d000000b0057a67df3308sm4677099ywe.101.2023.08.02.10.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:25:55 -0700 (PDT)
Message-ID: <64ca91a3.0d0a0220.8e58d.89b3@mx.google.com>
X-Google-Original-Message-ID: <ZMqRoAEesL5GAflV@neuromancer.>
Date:   Wed, 2 Aug 2023 12:25:52 -0500
From:   Chris Morgan <macroalpha82@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        cros-qcom-dts-watchers@chromium.org, linux-input@vger.kernel.org,
        hsinyi@google.com, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        yangcong5@huaqin.corp-partner.google.com
Subject: Re: [PATCH v3 02/10] drm/panel: Check for already prepared/enabled
 in drm_panel
References: <20230725203545.2260506-1-dianders@chromium.org>
 <20230725133443.v3.2.I59b417d4c29151cc2eff053369ec4822b606f375@changeid>
 <snx3fzvf3icauri2xuigydvpqxtzhp34mptdxvifi7jswm2evy@sx7jr7zwvjw5>
 <CAD=FV=VcsTik+HD11xeDM2Jq9ispcX0-j5QtK8D1qUkrGabRGg@mail.gmail.com>
 <i3cbgrc365lwscwux2itho6uv74ji3hsjuge4zoxfnlnhacyqc@r73mmifyxffj>
 <CADcbR4JB0h8fByM2Z6diByvWaFprW9GDapBNt+YLWr9-vKoe7A@mail.gmail.com>
 <kuctj2p353nsae24lrhcymqqpfajbc7qoqly63zpwvdp6lgu3b@kk4gpzsapxnn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kuctj2p353nsae24lrhcymqqpfajbc7qoqly63zpwvdp6lgu3b@kk4gpzsapxnn>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 07:03:07PM +0200, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Jul 31, 2023 at 11:33:22AM -0500, Chris Morgan wrote:
> > In my case a few different panel drivers disable the regulators in the
> > unprepare/disable routines.
> 
> And that's totally fine.
> 
> > For at least the Rockchip DSI implementations for some reason the
> > panel gets unprepared more than once, which triggers an unbalanced
> > regulator disable.
> 
> "For some reason" being that DW-DSI apparently finds it ok to bypass any
> kind of abstraction and randomly calling panel functions by itself:
> 
> https://elixir.bootlin.com/linux/v6.4.7/source/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c#L868
> 
> It looks like it's fixed it current drm-misc-next though.

Good, when I get a chance I will test it out with the existing panels
I have at my disposal and submit some patches to clean them up.

> 
> > Obviously though the correct course of action is to fix the reason why
> > the panel is disabled more than once, but that's at least the root
> > cause of this behavior on the few panels I've worked with.
> 
> Like I said we already have a commit on the way to fix that, so it
> shouldn't be an issue anymore.
> 
> I stand by what I was saying earlier though, I think it's mostly
> cargo-cult or drivers being very wrong. If anything, the DW-DSI stuff
> made me even more convinced that we shouldn't even entertain that idea
> :)
> 
> Maxime

Thank you, and yes if a driver is doing something it shouldn't we
shouldn't be patching around that, we should be fixing things. Thanks
for providing me with the additional info.

Chris
