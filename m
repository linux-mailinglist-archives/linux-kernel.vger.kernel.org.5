Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9683D7E9B34
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjKML3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjKML3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:29:06 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFDAD5A;
        Mon, 13 Nov 2023 03:29:00 -0800 (PST)
Received: from hillosipuli.retiisi.eu (185-9-10-242.cust.suomicom.net [185.9.10.242])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4STRyc1kfwz49PwQ;
        Mon, 13 Nov 2023 13:28:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1699874937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mU4n0Cg3PDT4j4JVwkM1M5j7hZmZY5ovb/ovuz6hI70=;
        b=MQMM4dyTbYE+3lpqRfzGCO4H2z+6WrUFqTGNZR4jZEooueHRNgClF+BAlmVmaqEWRkygQw
        9XGIqHaZL0iEkMrWXM0ZNJ+AMUhb+aXklDNv6PbmKkqVnx8vYHmLNpYNEOGBm5wkGMWOvy
        uDwiPxTR7vDWsXhPqb6mOWdUkeMWaGCR83Zme9sL1OrUmiYbsr81/6aC62t2QAeOguDeyr
        JDKRZL3TeUxH1mxCB1wIr0FScq3FjAd9SmPjR2LcfLmw3hVThJwTnjclzkxCbmKw9oivn3
        1ZSR3+IdMTmzdK9r/q0AemxgPOW8yQ5nCM90Oe+O2TsgqG4SOq5ku+txtG1i8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1699874937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mU4n0Cg3PDT4j4JVwkM1M5j7hZmZY5ovb/ovuz6hI70=;
        b=mLNZIhkEvJZXmqKu/jZMJNrfVzrtgHLBmTwD3Ee7Qup9tfUkwk0srYui+tf7zNfgbWlzSm
        9ovux918b+rxwZqf8BXzVV27cd3fcA4gnGEkG+4jh6Y7qAl/xquW2l8eiI6JS37aRdJxHy
        Nk1UTpj1EJ0/3q8lzhaWUSyGxtI5b+X5tavfD9GZFFjNKF40xZVJoHfqnDoxjVksesr2L7
        Tm4suzaodk8IvooD86C9/xgmoWelgulKTo+FAflLYzv9yxezZ9QPiNr9M4IiDFlA/3Mdjt
        sFmlim1p9aiBj8YX5bHi3xkLIuyGxKb4Xby9ayUIfc3V6ErLKhI5c+tl5b17qA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699874937; a=rsa-sha256;
        cv=none;
        b=PbOTf3dEsYLFo1+IRLK88fjB/jPWJBqUievZ+m5HTVkqSeyp3ru+z8rOvkavHwtCa8AmgI
        kvUXb5f/Rk70GJ5SB4yiuqLnxqfuA9RFDYEoXi2VoGF5ZpU2RNz+JDccTLjpFVWDMkpeq7
        B0ok4zCgby7lw04qY5tNMTLwI7K7vWc4EpRvS4Jt4FK1+GZjmx1wQbJz9lBkuMdFLtuCSN
        HY0F4+RrwWUuL1qHiZXbL+meo+5fwTDaxq0KapQFiMnI1EHw0MZ2a9yo8wGpujzb1JMvqh
        gOt4EY8qNAv0aqqcPsY3MM+kQiVidloGDLgubMsAAfKUGksSHIk6VraabdczzA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 2134B634C93;
        Mon, 13 Nov 2023 13:28:52 +0200 (EET)
Date:   Mon, 13 Nov 2023 11:28:51 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v9 10/15] media: uapi: Add V4L2_CTRL_TYPE_FIXED_POINT
Message-ID: <ZVIIc-fi32ZxIi-p@valkosipuli.retiisi.eu>
References: <1699595289-25773-1-git-send-email-shengjiu.wang@nxp.com>
 <1699595289-25773-11-git-send-email-shengjiu.wang@nxp.com>
 <4cd6b593-2376-4cbc-a7c8-d3eb36a2f7a0@xs4all.nl>
 <20231113104238.GA13981@pendragon.ideasonboard.com>
 <6a3e7eb9-505c-4cfb-8a86-a8947a2e44d5@xs4all.nl>
 <20231113110754.GB24338@pendragon.ideasonboard.com>
 <3e898664-cbfc-4892-9765-37b66891643b@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e898664-cbfc-4892-9765-37b66891643b@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, Nov 13, 2023 at 12:24:14PM +0100, Hans Verkuil wrote:
> On 13/11/2023 12:07, Laurent Pinchart wrote:
> > On Mon, Nov 13, 2023 at 11:56:49AM +0100, Hans Verkuil wrote:
> >> On 13/11/2023 11:42, Laurent Pinchart wrote:
> >>> On Mon, Nov 13, 2023 at 11:29:09AM +0100, Hans Verkuil wrote:
> >>>> Hi Shengjiu,
> >>>>
> >>>> On 10/11/2023 06:48, Shengjiu Wang wrote:
> >>>>> Fixed point controls are used by the user to configure
> >>>>> a fixed point value in 64bits, which Q31.32 format.
> >>>>>
> >>>>> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> >>>>
> >>>> This patch adds a new control type. This is something that also needs to be
> >>>> tested by v4l2-compliance, and for that we need to add support for this to
> >>>> one of the media test-drivers. The best place for that is the vivid driver,
> >>>> since that has already a bunch of test controls for other control types.
> >>>>
> >>>> See e.g. VIVID_CID_INTEGER64 in vivid-ctrls.c.
> >>>>
> >>>> Can you add a patch adding a fixed point test control to vivid?
> >>>
> >>> I don't think V4L2_CTRL_TYPE_FIXED_POINT is a good idea. This seems to
> >>> relate more to units than control types. We have lots of fixed-point
> >>> values in controls already, using the 32-bit and 64-bit integer control
> >>> types. They use various locations for the decimal point, depending on
> >>> the control. If we want to make this more explicit to users, we should
> >>> work on adding unit support to the V4L2 controls.
> >>
> >> "Fixed Point" is not a unit, it's a type. 'Db', 'Hz' etc. are units.
> > 
> > It's not a unit, but I think it's related to units. My point is that,
> > without units support, I don't see why we need a formal definition of
> > fixed-point types, and why this series couldn't just use
> > VIVID_CID_INTEGER64. Drivers already interpret VIVID_CID_INTEGER64
> > values as they see fit.
> 
> They do? That's new to me. A quick grep for V4L2_CTRL_TYPE_INTEGER64
> (I assume you meant that rather than VIVID_CID_INTEGER64) shows that it
> is always interpreted as a 64 bit integer and nothing else. As it should.
> 
> And while we do not have support for units (other than the documentation),
> we do have type support in the form of V4L2_CTRL_TYPE_*.
> 
> > 
> >> A quick "git grep -i "fixed point" Documentation/userspace-api/media/'
> >> only shows a single driver specific control (dw100.rst).
> >>
> >> I'm not aware of other controls in mainline that use fixed point.
> > 
> > The analog gain control for sensors for instance.
> 
> Not really. The documentation is super vague:
> 
> V4L2_CID_ANALOGUE_GAIN (integer)
> 
> 	Analogue gain is gain affecting all colour components in the pixel matrix. The
> 	gain operation is performed in the analogue domain before A/D conversion.
> 
> And the integer is just a range. Internally it might map to some fixed
> point value, but userspace won't see that, it's hidden in the driver AFAICT.

I wonder if Laurent meant digital gain.

Those are often Q numbers. The practice there has been that the default
value yields gain of 1.

There are probably many other examples in controls where something being
controlled isn't actually an integer while integer controls are still being
used for the purpose.

Instead of this patch, I'd prefer to have a way to express the meaning of
the control value, be it a Q number or something else, and do that
independently of the type of the control.

> 
> In the case of this particular series the control type is really a fixed point
> value with a documented unit (Hz). It really is not something you want to
> use type INTEGER64 for.
> 
> > 
> >> Note that V4L2_CTRL_TYPE_FIXED_POINT is a Q31.32 format. By setting
> >> min/max/step you can easily map that to just about any QN.M format where
> >> N <= 31 and M <= 32.
> >>
> >> In the case of dw100 it is a bit different in that it is quite specialized
> >> and it had to fit in 16 bits.

-- 
Regards,

Sakari Ailus
