Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE5A7E1ED3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 11:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjKFKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 05:48:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 05:48:12 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411D592;
        Mon,  6 Nov 2023 02:48:09 -0800 (PST)
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SP7Nj2S11z49PxL;
        Mon,  6 Nov 2023 12:48:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1699267685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFt+BGmAPnhgn1cZ5dvrGmly2meJ+ws2AZ1QjFXNz74=;
        b=so3RjZhleUxiEbMGYS1Q6eZgdNgPsUrMAMr3DBAAU/nN94VqeMDbwHpMycmS8Qd/oPjnly
        Y6KQzmmGKDy6q95FyzyVmKtWIAPdr8waf3LdY2uDL5+A8yN5BIJ1yI0/TJ4WkOIGZ1InTa
        MSLTSlnvbRLfsMZuR/bLF6NQBxIl50vnlvafuX16xRxd+ZcwmrYJFLxfcJDXUVAiJRvRv4
        N2dD1eH6JAgiOmXGMpkCYwQjvM0hXFhij5axHYzZzWEiq8L/dCarowF1H90AtDn/n3Flkd
        4lhrzDT65oNv0nIVfJW3eMPZLjhE2YdvAxpr9A+RLFLGUD20b7xt41k+fi0R8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1699267685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFt+BGmAPnhgn1cZ5dvrGmly2meJ+ws2AZ1QjFXNz74=;
        b=YbkqxpEc0ob+UGs9xbZySWCHtcxQLbpRb+svLX0QHvjhNSSSvPPikgRRCmfxd4xyAYVTHN
        Pi9OXN0UCNrqfEDXItjLpg1nMwyHXhuOqVB8QTzGZhiCZWgPUT3jrB1zDYBuoDK9v64pf6
        V8WGbP72VgGNHejb6QRm/7RzQYICyR+lwYpbOZ5UWIfgRS+ULBYLkI98qQc+5Q4smRLjvd
        2RTINIPzD0PGG9yndZJQ1qO9cqT7ZTFxltQioUkAt9JsAWw6X3X+9+IHJ3iHzs5jj0lDxK
        Qzo20fCwq2EU2EqYiFzb6duZwYnp75wSq43e3PMGs6JQ9jlS+SXuoA9wgrmgoQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1699267685; a=rsa-sha256;
        cv=none;
        b=gBnAAGcJd9s5fR+lpWWx4We+vRs4QDxkW1RD5/iSovLkX2It/1myrD9yl9lbg/8QkhlOAQ
        kJtXJeJdUeK1aecyzKsXPVXPGV7ke0/Z4A3YUjahwEK2BwYZOQmKIhjJbz4xwg6gmiRieP
        q7htoJYzQu3RQlje4U3AVkbgz90q5OEWygcg/eJ3U3RAGQXa2H6fUPzfN1fOi90wSil8ws
        MpXbtY4u5bn5+/x/p8cPiSgXxS7c72ZXUeudtdbO2aOO1vGPyML4pGA76fP6KEhXOJtGev
        +2xENRWWihPQKMDQay94QC2NTgeeGWDmfmiErqAYpv+QUHM77Sri0MeSxPVnzg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 2E79B634C93;
        Mon,  6 Nov 2023 12:48:01 +0200 (EET)
Date:   Mon, 6 Nov 2023 10:48:01 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Rob Herring <robh@kernel.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: i2c: gc2145: Galaxy Core GC2145 sensor
 support
Message-ID: <ZUjEYYH9jgaAjGfd@valkosipuli.retiisi.eu>
References: <20231011175735.1824782-1-alain.volmat@foss.st.com>
 <20231011175735.1824782-4-alain.volmat@foss.st.com>
 <kwlierdzflnm4ignc3huklbrkxq6wftr2ks3lmdmm3dfk7z654@fvpszg7jywz7>
 <20231030163711.GA2977022@gnbcxd0016.gnb.st.com>
 <ocohxhbo2rrngjy5g6twy4exxqaeuhws2tnjo7uiv7ja24etot@7wgzo3xrnon6>
 <20231106095546.GA3071306@gnbcxd0016.gnb.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106095546.GA3071306@gnbcxd0016.gnb.st.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain, Jacopo,

On Mon, Nov 06, 2023 at 10:55:46AM +0100, Alain Volmat wrote:
> Hi,
> 
> On Tue, Oct 31, 2023 at 09:05:32AM +0100, Jacopo Mondi wrote:
> > Hi Alain
> > 
> > On Mon, Oct 30, 2023 at 05:37:11PM +0100, Alain Volmat wrote:
> > > Hi Jacopo,
> > >
> > > On Mon, Oct 23, 2023 at 10:38:59AM +0200, Jacopo Mondi wrote:
> > > > Hi Alain
> > > >
> > > > On Wed, Oct 11, 2023 at 07:57:30PM +0200, Alain Volmat wrote:
> > > > > Addition of support for the Galaxy Core GC2145 XVGA sensor.
> > > > > The sensor supports both DVP and CSI-2 interfaces however for
> > > > > the time being only CSI-2 is implemented.
> > > > >
> > > > > Configurations is currently based on initialization scripts
> > > > > coming from Galaxy Core and for that purpose only 3 static
> > > > > resolutions are supported with static framerates.
> > > > >  - 640x480 (30fps)
> > > > >  - 1280x720 (30fps)
> > > > >  - 1600x1200 (20fps)
> > > >
> > > > Anything blocking having a writable VBLANK ? This is a YUV sensor but
> > > > GC2145_REG_VBLANK seems to be writable. I don't want to push you to
> > > > more work that what you actually need, but configurable blankings (and
> > > > then frame durations) seems like an important feature ? (and if I
> > > > recall right you want to use this sensor with libcamera, which will
> > > > require blankings to be controllable (if the sensor supports any RAW
> > > > format)
> > >
> > > No, nothing prevents to write the VBLANK register.  I just did some
> > > tests directly via rwmem into a running sensor and vertical blanking can
> > > be updated, allowing to tune the framerate.
> > >
> > > >
> > > > I don't see any RAW format being supported in this version. Is this
> > > > something you plan to do on top ?
> > >
> > > Yes, absolutely, it is possible to output RAW formats as well however
> > > this version of the driver doesn't support it yet.  The plan is indeed
> > > to add it on top of this.
> > > Several things to be addressed on top of this serie:
> > >   - RAW format
> > >   - frame_interval vs H/V blank control.  Is my understanding correct if
> > >     I say that if a sensor has RAW format (even if it ALSO has YUV /
> > >     RGB) then control is done via H/V blanking controls rather than
> > >     frame_interval ?
> > 
> > I'll reply here to this question that is asked in a few other places.
> > 
> > I can only point you to the ov5640 driver, which is capable of both
> > YUV/RGB and RAW as this sensor is. The ov5640 driver supports both the
> > g/s/enum_frame_interval and has writable blankings. I guess it's more
> > for historical reasons, as when blankings have been made writable
> > users of the frame_interval API would have been displeased if that
> > interface went away.
> > 
> > The resulting implementation is not nice, as changing vblank doesn't
> > update the framerate reported through g_frame_interval, and keeping
> > the two in sync is not trivial.
> > 
> > I would suggest to go for writable blankings, and if you already plan
> > to remove frame_interval then not add it in first place so there won't
> > be displeased users.
> > 
> > Sakari, Laurent, what's your opinion here ?
> 
> Sakari, Laurent, do you have opinion regarding how to control the
> framerate on this sensor.  It is a YUV sensor but which might also (not
> yet made available in this first serie) support RAW format.
> Should I expose the g_frame_interval / s_frame_interval or only blanking
> ctrls ?

As this is a new driver, I'm leaning towards implementing blanking controls
only.

-- 
Regards,

Sakari Ailus
