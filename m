Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4087D198D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 01:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjJTXT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 19:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjJTXT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 19:19:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EC0D71
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 16:19:26 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507ac66a969so1693812e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 16:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697843964; x=1698448764; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd+y1EVP7Tnl3Fn7df202mdRXZ1tRrmqlbxFbYLZtrg=;
        b=BmPOHq/PHVm4U/5mDghRW68MaFUT+i+KgiZCpHOKxRq/E9o/XizyK8fvabsBEhGAv5
         rt21nwmwci5sFnXnnKsGK2Y+AeQ/O8zNDLm4eUyDbXKSDkcQG5+FpuWQr7EN6TDZORo1
         NLCRYC1B/VkjmeLo1gkrj2YfKYPWQX4WSnm/PyXzgx3MK8J0EfviJI/nroMWioQz+y7N
         2cwM6CGlV57uachfxoHM/cAiI+hlzPuWt21gP0+Yoy+yONCs0VySy3+W+lGkwAux6Myn
         egxYuIg8X/15D/evj3xoNfA3xh6vRP+UCZDWbkRM48R5wZBqV/sDg2y2JQ05rVZpPGR3
         xXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697843964; x=1698448764;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gd+y1EVP7Tnl3Fn7df202mdRXZ1tRrmqlbxFbYLZtrg=;
        b=eMyYeUpYc2ve3gTnD6igtlEmXgxVICQgRDyYWIuFr2j9IbsTuwuG+fDFWZ8bZG3K8S
         Bxcsr5aKfkJovcTos8FSkEAsyiwfW7sFqtkD2Kfq0ZbVbHzElls1uCBNURZccJTAknao
         tFjx1PFIV8YVhFYxHA3Y/07Wzrm8nui94IM/LGfzWu6WA5QgM6z/o2LrtSMdcqCniQzy
         mIEHnlRroN3gqmZMifRIk7WotK9hDEhS8ZSeVA3he8UsGhyeMzhJaki0GW+uPLFn/Q9l
         k2JImfSxxgtHhUMbecMo7/Zc4/U8KzMavqda7yenxzmo3Je5OiTs+cbeEEsG7XO2qtRP
         UFeA==
X-Gm-Message-State: AOJu0Yz5L2VXls23eyTWic8aKjF71ouYh3G0DGO0JxDp2oJ3Wf8nynvr
        PY60WzwZ2rb8vIpGFBsfd90=
X-Google-Smtp-Source: AGHT+IFbO5a9uW2x8EMaPxKrNZYl8CKdmOJba3kWXFwTKqv6/E/6iwbLLAWd+A/kzuWQwx8SQFHmdA==
X-Received: by 2002:ac2:4183:0:b0:507:9f51:acee with SMTP id z3-20020ac24183000000b005079f51aceemr2101993lfh.22.1697843963947;
        Fri, 20 Oct 2023 16:19:23 -0700 (PDT)
Received: from dell.localnet (77-255-201-154.dynamic.inetia.pl. [77.255.201.154])
        by smtp.gmail.com with ESMTPSA id 24-20020ac24858000000b0050797006048sm576424lfy.68.2023.10.20.16.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 16:19:22 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ti: ams-delta: Allow it to be test compiled
Date:   Sat, 21 Oct 2023 01:19:20 +0200
Message-ID: <13380212.uLZWGnKmhe@dell>
In-Reply-To: <9bbab4c8-f616-4abc-9eee-022c19c6921d@sirena.org.uk>
References: <20231008135601.542356-1-jmkrzyszt@gmail.com>
 <9bbab4c8-f616-4abc-9eee-022c19c6921d@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2913659.e9J7NaK4W3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2913659.e9J7NaK4W3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ti: ams-delta: Allow it to be test compiled
Date: Sat, 21 Oct 2023 01:19:20 +0200
Message-ID: <13380212.uLZWGnKmhe@dell>
In-Reply-To: <9bbab4c8-f616-4abc-9eee-022c19c6921d@sirena.org.uk>
MIME-Version: 1.0

On Thursday, 19 October 2023 13:40:57 CEST Mark Brown wrote:
> On Sun, Oct 08, 2023 at 03:53:10PM +0200, Janusz Krzysztofik wrote:
> > The driver is now built only when MACH_AMS_DELTA is selected, which
> > requires a very specific selection of ARCH settings.  As a consequence, it
> > gets very little attention from build-bots, if not none.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Hi Mark,

Thanks for your Ack.

Since the fix required for successful compilation of the ams-delta ASoC 
driver already reached v6.6, my former suggestion to pass this change also 
via Greg's tty tree is probably no longer vital.

Thanks,
Janusz


--nextPart2913659.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnyr6IsGnTYAeAkHJ2WqSnltsjBoFAmUzCvgACgkQ2WqSnlts
jBpNFAf9FNv7JXlsqK4cead1KZEZ3CLVzOWvKWgquVyK21Rf35wQOfJvzlWTXSeB
J/GS5Jdb399q0uSGJ0H9tN7E2kUQ7A3EffqHigsjDsmUlJamS00OFWlw93CpZlKB
11TtR6hrxxXoCoDZXmzYLvCac0+AZ6moIQ0mJqY6AlBho4QNAxPafvwaQ1bzAkmA
v39as9EopIOAaH8XYgX2fnQruN8jY7s9dhZwoO7VzpzcQliwakIxE2fGbXpnh45s
k0BHkOLJgF2z2nj2PekKh1vnGw0757dytIAUpPu/j/jtTA6AI94bTTEYMQHTWjaz
fDCU+8ORkRns59sg882e2rnWGjh73A==
=m2Dz
-----END PGP SIGNATURE-----

--nextPart2913659.e9J7NaK4W3--



