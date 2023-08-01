Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B227A76B6CB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234475AbjHAOG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjHAOGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:06:33 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D230EF;
        Tue,  1 Aug 2023 07:06:11 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RFcMt2Gb4zyPp;
        Tue,  1 Aug 2023 17:06:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1690898764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaq3tUxGWT8kGOgYm0nW8eQt9ANPfhADF6lkxkW0974=;
        b=NseJW3ia59kmCdTykP6NnUDaKv1bRlsIR2JIwCZLTtk2+/aQSOyL+TsB9xbdnDT+FaIHF4
        uwbtYEo5l10kfZHH+Z4zD+l6MUYnYagPSvd8rso9ILMKgdOFQzdXkxOZBHQkZzbSD853Gm
        MLNh6dWCyE0zeCf8d5JIuFS6huryufk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1690898764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kaq3tUxGWT8kGOgYm0nW8eQt9ANPfhADF6lkxkW0974=;
        b=uZfuf8FmRo6v5hjr5987MJjC7boJpxHd1f9EpZHHlhvrOgMPM0JgBKeelaWaWeBD4ySwJV
        UHlucyijE3gMK5/RJXCalBlUpXduWCEQ1sSk5GwOM4TwaELN/Tf9IWqqtVu0Qcsn2PBKo8
        Brpl/8kysJiOx7wUSj7Ge0AdQ2CSaUM=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1690898764; a=rsa-sha256; cv=none;
        b=shcZAOjPrqPSB5PnpOAyi/h+O7lZ6fGlXGObEanUClT3vSqCD9cr4VPKs27USpOpIRKKGl
        jSEADw1kAT+b9ZyoilW+Qf18E5wuI5dJTc9bqXsC1KukJIDh0Vs4KXxGtEXhYvqzKx0aYe
        x2z79mznlJO2/t5fzYUrGynXMfuXwls=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 8D736634C95;
        Tue,  1 Aug 2023 17:06:01 +0300 (EEST)
Date:   Tue, 1 Aug 2023 14:06:01 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Helen Koike <helen.koike@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] media: dt-bindings: Merge OV5695 into OV5693 binding
Message-ID: <ZMkRSfAwcLQIKkHL@valkosipuli.retiisi.eu>
References: <20230707210604.868002-1-robh@kernel.org>
 <ZMeZIGyD+ET6gaox@valkosipuli.retiisi.eu>
 <CAL_JsqK4A9vpUiP3sCz9+hAHitcsB9NYMMy05n4=1hn7NvjOtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqK4A9vpUiP3sCz9+hAHitcsB9NYMMy05n4=1hn7NvjOtg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Aug 01, 2023 at 07:45:08AM -0600, Rob Herring wrote:
> On Mon, Jul 31, 2023 at 5:21 AM Sakari Ailus <sakari.ailus@iki.fi> wrote:
> >
> > Hi Rob,
> >
> > On Fri, Jul 07, 2023 at 03:06:04PM -0600, Rob Herring wrote:
> > > The OV5695 binding is almost the same as the OV5693 binding. The only
> > > difference is 'clock-names' is defined for OV5695. However, the lack of
> > > clock-names is an omission as the Linux OV5693 driver expects the same
> > > 'xvclk' clock name.
> > >
> > > 'link-frequencies' is required by OV5693, but not OV5695. Just drop it
> > > from being required. Expressing it conditionally would be ugly. It
> > > shouldn't really be required either as the driver only supports 1
> > > frequency anyways.
> >
> > The correct way to address this would appear to be to add link-frequencies
> > for both of these devices. I think I've seen one or two sensors of this
> > class (raw, CSI-2/parallel, external clock etc.) with link frequencies
> > documented as "fixed" --- which is probably a documentation issue more than
> > anything else.
> 
> link-frequencies is already supported. It's just a question of being
> required or not. Adding a property as required is an ABI break (if the
> OS starts requiring the property).

Currently the ov5693 driver requires a link-frequencies property, the
ov5695 driver doesn't care.

In this case the backwards compatible way would be to make it optional for
ov5695 and if it exists, then allow only those frequencies. It's a fairly
trivial driver, it only supports a single link frequency at the moment (as
well as a single external clock frequency).

At least link-frequencies should continue to be required for ov5693.

-- 
Regards,

Sakari Ailus
