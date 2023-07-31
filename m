Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10DD7694B0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjGaLVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjGaLV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:21:28 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205DA19A1;
        Mon, 31 Jul 2023 04:21:16 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RDwm11Lfxz49Pyr;
        Mon, 31 Jul 2023 14:21:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1690802467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0yTUDvKr9KLJ6gBlgIFt0nRAFsoBYNTAi9NRqIkWAVs=;
        b=AYI5iHHUBmc01ZiU7KqvPtIs4wGSE7vI+4Li73ZPtdwHGysuYtisKNz1RCt6gbkbHzHmSo
        iesBV8KPLWj3hHXHfDev76TMOOoige9pF3e5Xel3hbfkcgzfeBaikLW957V48XhR37MuEK
        ETFwRhT3mpleJfqSFTdhZ8iig7WZEyNQGIZPVtFtNSnSvQcj68GurDoHi5ZWI4F964AN1n
        BcniA5OO6U+LtNI8bYRlqo0hoJyuCV+/LWmxDrZrzUmbkMvz8HgpZg/+V1ISl3t8lT1s01
        k+Z0Y3xKD8IKVwTRqicfSCwUsYmS35r4CRjli1rPIxTBS/DiLPkEmslv9/MnzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1690802467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0yTUDvKr9KLJ6gBlgIFt0nRAFsoBYNTAi9NRqIkWAVs=;
        b=HAfq68Aq+b99nBng9aVkropwlrnjCcqaNtoRYITdsQe9etLceD09vCESqZrqjaA8CwpACC
        WEAmhy2fq2WdZZQ4vhWexMBFsPe16SrR09wmxHHk4/bknq4nyugb0r07J50inqNQaG/rdC
        hdwxSe0y2rf8qyEAr2hOk1IZHBjgW0pbUBu+T7HKhW/HshVRmUchm48BKwvpbSCgAlKz1I
        iWsm19mWR/iAbNCqZK/mhBioBsff4WKk+nDE2CWGeIPNlaYlHnBuc40bTwoiZNmPf30gq9
        tX6OdSOjIxfL14Y2RJHge4V6+1VYbmqqxJWhcN7aPiTlJ1TondA2YV9gi3Zkqw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1690802467; a=rsa-sha256;
        cv=none;
        b=wLTcZStgf+OVjSvMjtGKMLiN6mVJZN2XZsvK95TuF3IMgEYRmmTNNS4P0HYQ74Szh5+tEb
        yy9TuluHhSdDkYs2nY4H+LwkXxWOR081H/snDEYNkGNBO74VG0bE+WfKcVo47+4sj3bkZC
        TkVItmMuqxfh1xlOSPvRfQEWwwirp0jO3KoJsDRZEPhm9KKUsgIi4yQcWik/skv+HjMgeM
        gAt19b+XyKRrwvyjMfGRm/aK7jSm1oI+RQQS+E4WBsyfJXhfVhbFLPOLpn33o99ivFqTle
        tx+xRNQE8eLTmf+cnCqNNdgdaaFWwsEMmvyYTFisGGTCxswer2FT/DhYXa/Qnw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id A9F60634C95;
        Mon, 31 Jul 2023 14:21:04 +0300 (EEST)
Date:   Mon, 31 Jul 2023 11:21:04 +0000
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
Message-ID: <ZMeZIGyD+ET6gaox@valkosipuli.retiisi.eu>
References: <20230707210604.868002-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707210604.868002-1-robh@kernel.org>
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

On Fri, Jul 07, 2023 at 03:06:04PM -0600, Rob Herring wrote:
> The OV5695 binding is almost the same as the OV5693 binding. The only
> difference is 'clock-names' is defined for OV5695. However, the lack of
> clock-names is an omission as the Linux OV5693 driver expects the same
> 'xvclk' clock name.
> 
> 'link-frequencies' is required by OV5693, but not OV5695. Just drop it
> from being required. Expressing it conditionally would be ugly. It
> shouldn't really be required either as the driver only supports 1
> frequency anyways.

The correct way to address this would appear to be to add link-frequencies
for both of these devices. I think I've seen one or two sensors of this
class (raw, CSI-2/parallel, external clock etc.) with link frequencies
documented as "fixed" --- which is probably a documentation issue more than
anything else.

Also see:
<URL:https://hverkuil.home.xs4all.nl/spec/driver-api/camera-sensor.html#handling-clocks>.

-- 
Kind regards,

Sakari Ailus
