Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0784176368B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233746AbjGZMmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjGZMl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:41:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D381E2129;
        Wed, 26 Jul 2023 05:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B45C61AE9;
        Wed, 26 Jul 2023 12:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1F1C433C7;
        Wed, 26 Jul 2023 12:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690375314;
        bh=bALS92dZEp6Bog/IDgTHSkowfaf9shZJRJWKE/3Rzp4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K522A7YUIGm7SR5p/ijItVCD+05Na78v0dHvP6RrW5JDm7ocD8s+++3FsBW8zCpCN
         YCYw7f0JDV6tPpmtPpErRRqlfR0RwAge3HzBCoQ9Af/F9h9z2E+58+4Vw9X1x+LsPx
         brSuyzhawBS3vJEvDQEKEvjEsX6xEqCE9wZ3lfxucpuzxeF5ix9CWN+KJDMsX/tTnM
         /A5ClEgYaWPfeez2AMkgkIfesVaiHKxxmElImvFZjrGbW3Qw/ViVkE3UL+kGB0BrLN
         Qeaq5YJIvU0QGCNBQi0eUSoz59sADEaMRgyFu6TARgzDEhRkthXLxa7Sp8dRmYo0M7
         zUas4sryFDWNA==
Date:   Wed, 26 Jul 2023 14:41:51 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
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
        cros-qcom-dts-watchers@chromium.org,
        Chris Morgan <macroalpha82@gmail.com>,
        linux-input@vger.kernel.org, hsinyi@google.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        yangcong5@huaqin.corp-partner.google.com
Subject: Re: [PATCH v3 02/10] drm/panel: Check for already prepared/enabled
 in drm_panel
Message-ID: <snx3fzvf3icauri2xuigydvpqxtzhp34mptdxvifi7jswm2evy@sx7jr7zwvjw5>
References: <20230725203545.2260506-1-dianders@chromium.org>
 <20230725133443.v3.2.I59b417d4c29151cc2eff053369ec4822b606f375@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fea6cqcwqp7wzipv"
Content-Disposition: inline
In-Reply-To: <20230725133443.v3.2.I59b417d4c29151cc2eff053369ec4822b606f375@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fea6cqcwqp7wzipv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Jul 25, 2023 at 01:34:37PM -0700, Douglas Anderson wrote:
> NOTE: arguably, the right thing to do here is actually to skip this
> patch and simply remove all the extra checks from the individual
> drivers. Perhaps the checks were needed at some point in time in the
> past but maybe they no longer are? Certainly as we continue
> transitioning over to "panel_bridge" then we expect there to be much
> less variety in how these calls are made. When we're called as part of
> the bridge chain, things should be pretty simple. In fact, there was
> some discussion in the past about these checks [1], including a
> discussion about whether the checks were needed and whether the calls
> ought to be refcounted. At the time, I decided not to mess with it
> because it felt too risky.

Yeah, I'd agree here too. I've never found evidence that it was actually
needed and it really looks like cargo cult to me.

And if it was needed, then I'm not sure we need refcounting either. We
don't have refcounting for atomic_enable / disable, we have a sound API
design that makes sure we don't fall into that trap :)

> Looking closer at it now, I'm fairly certain that nothing in the
> existing codebase is expecting these calls to be refcounted. The only
> real question is whether someone is already doing something to ensure
> prepare()/unprepare() match and enabled()/disable() match. I would say
> that, even if there is something else ensuring that things match,
> there's enough complexity that adding an extra bool and an extra
> double-check here is a good idea. Let's add a drm_warn() to let people
> know that it's considered a minor error to take advantage of
> drm_panel's double-checking but we'll still make things work fine.

I'm ok with this, if we follow-up in a couple of releases and remove it
and all the calls.

Could you add a TODO item so that we can keep a track of it? A follow-up
is fine if you don't send a new version of that series.

Maxime

--fea6cqcwqp7wzipv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZMEUjwAKCRDj7w1vZxhR
xanPAP4voVmceTn00DRIp62vuGdOHci+svLi/7f8l6Z6NuyYrQD9Ewfs//FjcPgH
B/1NNtCNPIdGky8NtXB4QU3dP2Nq4AA=
=15yF
-----END PGP SIGNATURE-----

--fea6cqcwqp7wzipv--
