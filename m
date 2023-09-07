Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38C0797795
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjIGQ1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238169AbjIGQYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:24:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCF24EE6;
        Thu,  7 Sep 2023 09:21:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B29BC116AA;
        Thu,  7 Sep 2023 10:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694082058;
        bh=w08iyCZEv2y91XhjG6gytJX/08/uuFNdY7YRHOjrTKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SVoOSJ9LefWstHF2hTnikgZ/UUNwtOUth5vPxYcufjsTjslUusP7MKDm091Ndjv1q
         78kLUean1Oc8AnlV8LY0GWc6zu1Qfpc073Z1iT+MgtqAwnVLgMiQVVGnrYveCMxn/N
         c8fhp/kCn/PoATsQH64OI+p5gHydwnV92anTt+1L3Elxd+AKcgSsInhDqyMS8P3IAo
         TFybtf55GAyA7GLjEXjySR85zLpTch/rXP8HTvBJYw1rsE6xfhbUVn3q7hpySc9f44
         CrPl1sz5GpTIM4eHWAMqSuN15v7QaGWsaiynG/2uDQdcBjUyvitKHO1de8bG15fFcr
         46GOXc5xqg9XA==
Date:   Thu, 7 Sep 2023 11:20:50 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Sarah Walker <sarah.walker@imgtec.com>
Cc:     dri-devel@lists.freedesktop.org, frank.binns@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        airlied@gmail.com, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, corbet@lwn.net, christian.koenig@amd.com,
        linus.walleij@linaro.org, matt.coster@imgtec.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, faith.ekstrand@collabora.com,
        afd@ti.com, hns@goldelico.com, matthew.brost@intel.com,
        luben.tuikov@amd.com, dakr@redhat.com
Subject: Re: [PATCH v6 03/20] dt-bindings: gpu: Add Imagination Technologies
 PowerVR/IMG GPU
Message-ID: <20230907-22495ffd0407dacc5cf1cd12@fedora>
References: <20230906095542.3280699-1-sarah.walker@imgtec.com>
 <20230906095542.3280699-4-sarah.walker@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/PgLc/igXG8aid6c"
Content-Disposition: inline
In-Reply-To: <20230906095542.3280699-4-sarah.walker@imgtec.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/PgLc/igXG8aid6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey,

On Wed, Sep 06, 2023 at 10:55:25AM +0100, Sarah Walker wrote:

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
> +
> +    gpu: gpu@fd00000 {

This "gpu" label isn't used and can be dropped if you respin.
Otherwise, this seems fine to me,
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +        compatible = "ti,am62-gpu", "img,img-axe";
> +        reg = <0x0fd00000 0x20000>;
> +        clocks = <&k3_clks 187 0>;
> +        clock-names = "core";
> +        interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +        power-domains = <&k3_pds 187 TI_SCI_PD_EXCLUSIVE>;
> +    };

--/PgLc/igXG8aid6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPmkAgAKCRB4tDGHoIJi
0nQkAP9uKeN6K/WPKUkM5yMV//ie+sobH7mqetqT7BiWIVUj3wD/V2onnXfHh+pl
bVSIzTHnqcOZIQIgCDr+4Zw1Uj/lTAk=
=7B7v
-----END PGP SIGNATURE-----

--/PgLc/igXG8aid6c--
