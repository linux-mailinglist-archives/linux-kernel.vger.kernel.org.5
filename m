Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D678D769D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjGaRDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjGaRDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE23F1735;
        Mon, 31 Jul 2023 10:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CB4461206;
        Mon, 31 Jul 2023 17:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736B5C433C8;
        Mon, 31 Jul 2023 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690822990;
        bh=prqbrDd1eQM/ciCHGjg5jabFwA3khIZ739HC/mJfYHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eejfjuhP7BADOW/epFaY0YfjeuaoWC587CNl3oKWWdwOxmI0MU+TyGgtJXmHlqCu/
         JhG19cnizr15/Rf1nokDUwJ7XmHWQEwam5PLQRCe9oGui4E2/VZTpOaCgWWQpiqnWh
         UJWmVic5qArl8bC1Ok05bwLblI5knX5lUpgBvZdxefR2zSeCrf+8tcU1arh0/IhLW0
         Pw20j9T6LSKcVe/WzfNCH46TB3HgonSpus5jUudJcqIXigCb/JvutafnJcvT3n9lQI
         apNl4dP39mJQaYZ6zrNsF23izQHNgo/wc49RfA2NvwobOFdIowpoas69DSRIPj3jNb
         WUwe3W5r6g4Xw==
Date:   Mon, 31 Jul 2023 19:03:07 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Chris Morgan <macroalpha82@gmail.com>
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
Message-ID: <kuctj2p353nsae24lrhcymqqpfajbc7qoqly63zpwvdp6lgu3b@kk4gpzsapxnn>
References: <20230725203545.2260506-1-dianders@chromium.org>
 <20230725133443.v3.2.I59b417d4c29151cc2eff053369ec4822b606f375@changeid>
 <snx3fzvf3icauri2xuigydvpqxtzhp34mptdxvifi7jswm2evy@sx7jr7zwvjw5>
 <CAD=FV=VcsTik+HD11xeDM2Jq9ispcX0-j5QtK8D1qUkrGabRGg@mail.gmail.com>
 <i3cbgrc365lwscwux2itho6uv74ji3hsjuge4zoxfnlnhacyqc@r73mmifyxffj>
 <CADcbR4JB0h8fByM2Z6diByvWaFprW9GDapBNt+YLWr9-vKoe7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dtkqu6ml752thbrc"
Content-Disposition: inline
In-Reply-To: <CADcbR4JB0h8fByM2Z6diByvWaFprW9GDapBNt+YLWr9-vKoe7A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dtkqu6ml752thbrc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Jul 31, 2023 at 11:33:22AM -0500, Chris Morgan wrote:
> In my case a few different panel drivers disable the regulators in the
> unprepare/disable routines.

And that's totally fine.

> For at least the Rockchip DSI implementations for some reason the
> panel gets unprepared more than once, which triggers an unbalanced
> regulator disable.

"For some reason" being that DW-DSI apparently finds it ok to bypass any
kind of abstraction and randomly calling panel functions by itself:

https://elixir.bootlin.com/linux/v6.4.7/source/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c#L868

It looks like it's fixed it current drm-misc-next though.

> Obviously though the correct course of action is to fix the reason why
> the panel is disabled more than once, but that's at least the root
> cause of this behavior on the few panels I've worked with.

Like I said we already have a commit on the way to fix that, so it
shouldn't be an issue anymore.

I stand by what I was saying earlier though, I think it's mostly
cargo-cult or drivers being very wrong. If anything, the DW-DSI stuff
made me even more convinced that we shouldn't even entertain that idea
:)

Maxime

--dtkqu6ml752thbrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMfpSwAKCRDj7w1vZxhR
xSIXAQCizbGTVxHYDBO+tfnKn70WkSNp3OzkFHZtJzhXUbG9NQD9HpsTG6Ik+ohd
AXiX0xz1UvP/to/HW6CpWv7tiS5uDAw=
=pXP0
-----END PGP SIGNATURE-----

--dtkqu6ml752thbrc--
