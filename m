Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3449D757F71
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjGRO3W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 18 Jul 2023 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGRO3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 10:29:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ADD9E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 07:29:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qLlhR-0006sb-1r; Tue, 18 Jul 2023 16:29:13 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qLlhP-000OT0-1G; Tue, 18 Jul 2023 16:29:11 +0200
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qLlhO-000Eqt-2k;
        Tue, 18 Jul 2023 16:29:10 +0200
Message-ID: <6032fcba75d34b0273508166c8b79331cd5c34ef.camel@pengutronix.de>
Subject: Re: [PATCH] pwm: stm32: Implement .get_state()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:29:10 +0200
In-Reply-To: <dac9c545-fcbc-3aec-c341-abc62f551703@foss.st.com>
References: <20230608-pwm-stm32-get-state-v1-1-db7e58a7461b@pengutronix.de>
         <dac9c545-fcbc-3aec-c341-abc62f551703@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice,

On Fr, 2023-06-09 at 15:06 +0200, Fabrice Gasnier wrote:
[...]
> > @@ -635,7 +675,10 @@ static int stm32_pwm_probe(struct platform_device *pdev)
> >  
> >  	priv->chip.dev = dev;
> >  	priv->chip.ops = &stm32pwm_ops;
> > -	priv->chip.npwm = stm32_pwm_detect_channels(priv);
> > +	priv->chip.npwm = stm32_pwm_detect_channels(priv, &n_enabled);
> > +
> 
> I'd suggest to comment a bit here, to explain it initializes the PWM
> counter clock refcount in sync with PWM initial state left by the
> bootloader.
> 
> In all case, this is fine for me, you can add my:
> Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Thank you, I'll add a comment here.

regards
Philipp
