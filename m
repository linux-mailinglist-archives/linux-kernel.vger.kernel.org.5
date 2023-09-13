Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084D979EDC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjIMP4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjIMP4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:56:19 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E3FCCD;
        Wed, 13 Sep 2023 08:56:15 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Rm4n85GpnzyQw;
        Wed, 13 Sep 2023 18:56:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1694620573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/R7N3Fz0UaV151uGoY+FD3BuhhnuRg1huSPbvoh8eGA=;
        b=CjlPu01cyxe2rEcmLY4yhvWxSfd++0EeiAbLwR5W2flMcHNu8ntEOJTzUrcY5nUB3HWk+6
        ofzB+eikXq4C0mx12HmGAONhgda/c86VcbpvuPxDgQMbMBqy/v7ks9A+TvNH/4tBciy5UA
        I6M1mZBefKkUzRFO534f7jwkpX2oM38=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1694620573; a=rsa-sha256; cv=none;
        b=iX7abkyEIZT4a3r7yNTjGvRNJBQdyti1BJW05XRYa9a132OnhEqv8GEnj+qOAJj8hq11UQ
        Q86qHrlG5oH7BDnkVE5zqymCW8fBSWQYFqC57h7rHubFzb5xHP1tA9jIIKFH9xiJVEBzuS
        O6PeUznq29k2j2g75BZhnFh3H0beUuA=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1694620573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/R7N3Fz0UaV151uGoY+FD3BuhhnuRg1huSPbvoh8eGA=;
        b=LPfJ748FgSkqOh8IIhb1mYx4RN5r6MqeUhfLi8wl+YWkwq5zDKai3HR9TtltAFw9Q8QV93
        7Wg1/af+bcSeQ/E52YWo6UIL5PkxT8+2kYZ04QtkICPhzeue1SP/6m1QMy+PFXn4cj4sVY
        wIBOZ6OpeQBGUcilghaOq4QJGANPENg=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 0B043634C93;
        Wed, 13 Sep 2023 18:56:12 +0300 (EEST)
Date:   Wed, 13 Sep 2023 15:56:11 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Fabio Estevam <festevam@denx.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org,
        linux-media@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3] dt-bindings: media: Add OV5642
Message-ID: <ZQHbm4K6tDs6ILo+@valkosipuli.retiisi.eu>
References: <20230802160326.293420-1-festevam@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802160326.293420-1-festevam@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Wed, Aug 02, 2023 at 01:03:26PM -0300, Fabio Estevam wrote:
> As explained in the description text from trivial-devices.yaml:
> 
> "This is a list of trivial I2C and SPI devices that have simple device tree
> bindings, consisting only of a compatible field, an address and possibly an
> interrupt line."
> 
> A camera device does not fall into this category as it needs other
> properties such as regulators, reset and powerdown GPIOs, clocks,
> media endpoint.
> 
> Remove the OV5642 entry from trivial-devices.yaml and add its own
> ovti,ov5642.yaml.

One more little thing. Do you have a driver for this device? In upstream
there doesn't seem to be any.

-- 
Regards,

Sakari Ailus
