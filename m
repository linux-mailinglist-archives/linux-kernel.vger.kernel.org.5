Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A43D7D38BF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjJWOBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbjJWOBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:01:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A805110FA;
        Mon, 23 Oct 2023 07:00:56 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c514cbbe7eso45921651fa.1;
        Mon, 23 Oct 2023 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698069655; x=1698674455; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ep/A8Ui+ru8uebgA1aJ0Zc3GZKTR+UyP/z9Ha3kgeFE=;
        b=KFk15ooS9nNtiwwtRxM/QkjtKIfLOJXbFqFhQ4wmftttoM2DSwJ5t2PLsOtPFNdVKk
         7SaccQDWaf7KyPSv9upliv9sSoocDR19sUl2MDKPZNi8DOKRxxaTXW1FzLhC1AgP1+vK
         Enk41ka7ow5bMA4gFJJo3BPAb2PXdvi7xjlAZB5co1u29wTEwsZS5ldXbGoPEQPUqImG
         mHlnDHo3ZM3z1byiPRG2Lo5HjWEbYl1GIg38gsTppO2PCgrTbwGRWd//tTk4xTP9NDzo
         Ws5lfGtrunJPvrrOHHX5a+UNqKJbjpaVQk4SgQLkDw9+OLwRwBlvBPnP6wCpvKRo5FfP
         hpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698069655; x=1698674455;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ep/A8Ui+ru8uebgA1aJ0Zc3GZKTR+UyP/z9Ha3kgeFE=;
        b=f5qiSDxQDRaOon/dgfrciN278/rhYnLV08ymupaIvHBRIRF40qQD7R1IjMhivrjsK9
         UFuNXEnMVPFrPJUVThnn+1SP4veqa+K0zOUPauHGj3g/QpVIZQAgJlirntKpIS/r0IxV
         Jy1XW9SNqnHkJTTP0W3YVrJQID/iz281zrLa3LxG5InMEUWX9qW2HEMMCX+QKHmcVk6C
         6fiSjAwV7m+vmmVNkAiBi4QXaDdi53o+d6CFh+L5+zxD6hPOH7nvDEPdPT15pWsYfV+z
         uiArmqRhKI+WA9P0rVy3O0WvmlwXv4kmApDSatyFK3p3jO4pMcawQNJsgB3ta4Ku79Hy
         cKeA==
X-Gm-Message-State: AOJu0YwqixPZcGxFkdJQrRdE5ID0Dkm4J5YKuadue/KDdF3g0S/w6pD2
        B0vWh6jdnUDnT9Ts08wQOFc=
X-Google-Smtp-Source: AGHT+IFWnEUYFZAl4EhHBY6WzbA2S0DNEQDiwmXXUn9vVY94IJuTenmyBAJlGPFROluafjpBU/M8oQ==
X-Received: by 2002:a05:651c:1a28:b0:2c5:14d3:f295 with SMTP id by40-20020a05651c1a2800b002c514d3f295mr7835810ljb.35.1698069654540;
        Mon, 23 Oct 2023 07:00:54 -0700 (PDT)
Received: from thinkpad-work.lan (13.red-83-35-58.dynamicip.rima-tde.net. [83.35.58.13])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b00401b242e2e6sm14394370wmq.47.2023.10.23.07.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 07:00:54 -0700 (PDT)
Message-ID: <b4a76c2f3440da1ab6449b34fb352d21c9347b7b.camel@gmail.com>
Subject: Re: [PATCH v2 1/5] iio: pressure: bmp280: Use i2c_get_match_data()
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Phil Elwell <phil@raspberrypi.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Mon, 23 Oct 2023 16:00:53 +0200
In-Reply-To: <ZTZXTLeWbUHKkHIn@smile.fi.intel.com>
References: <cover.1697994521.git.ang.iglesiasg@gmail.com>
         <0554ddae62ba04ccacf58c2de04ec598c876665e.1697994521.git.ang.iglesiasg@gmail.com>
         <ZTZXTLeWbUHKkHIn@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-23 at 14:21 +0300, Andy Shevchenko wrote:
> On Sun, Oct 22, 2023 at 07:22:17PM +0200, Angel Iglesias wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >=20
> > Replace device_get_match_data() and id lookup for retrieving match data
> > by i2c_get_match_data().
> >=20
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Hmm... What tools have you used to format/send this? It seems differs
> to what `git format-patch` does.
>=20

I just applied this patch from Biju's series with "git am" and then generat=
ed
this series running the following invocation:
"git format-patch -v2 -p -n --thread --cover-letter=20
--to=3Dlinux-iio@vger.kernel.org --base=3Diio_upstream/togreg HEAD~5"
My work repository is publicly available here:
https://github.com/angiglesias/linux/commits/iio-bmp280-add-bmp390-support

Kind regards,
Angel
