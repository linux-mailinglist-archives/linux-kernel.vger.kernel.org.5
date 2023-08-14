Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5377C33F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjHNWGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233180AbjHNWG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:06:28 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50059B0;
        Mon, 14 Aug 2023 15:06:27 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RPpQ729dVz49Q2s;
        Tue, 15 Aug 2023 01:06:23 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1692050784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dDY+q0GbD+c5m/2/KmoNXHxGiMYNorLbqVC+i7ZVYIU=;
        b=j5izHspBQzWo6iLrHIKFPwI5n63rn+vNwzOhyAB3ASZwziYVmy3dM4zbC4hzy0Zbt5zEmD
        SEsXXhirt3i1+8Arp0fQaTPKAJEbenteizqHtOAZKJCRDxuOVRK+I7RfI7lgEsJ4V1ln+x
        z+re3S6VKVrcG8EnRxc8D05J1xcE28eM8wdlqAg9iNh95R7bIU2Z+PbzuWP3cZXDzdczv3
        BsdMNJjKUZLB3eh2cQTjhr/lyOk/65xnl5hmVSLRYtkByHquhItFpzTiUwm6egF+39Kl8F
        ZH/E4oL3KxztSwCSGo5lW/PmzcROCVeMzAFilTPhU9lBkbOKfKq7HZXpKfYJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1692050784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dDY+q0GbD+c5m/2/KmoNXHxGiMYNorLbqVC+i7ZVYIU=;
        b=PbgNs9+jf2URHm996rfIprTblohrG/TsZi/Ux2B7uCT9JGT2zavhUwZtsgvE8zdrQzKbbD
        VpzHO7MON08xkxEQzz9CjmnNn4vK7FX6atRMvZCJTllU3FdlZDLPdG6pVs1knnm5z75w7S
        OoESKNQCxITcXM5UoQ5dOJOq0QHp0EPSx9qkq7IGiMk9/kacIbfV4i3LdcHQsan0Y9pw2e
        oKEFcnIu+qmeejLIlvCsC/7HdsUB/rZZde84ql9s6vhcH+ftIJvL9NH5Stfp29ic/IzjUl
        Pp9GNpHjD7XMsjyOGnfvG9Rl+cTNsry5VS16+X/O7zlA667M9PUsoYq06LQ8tw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1692050784; a=rsa-sha256;
        cv=none;
        b=Yk9WXE3vQsdsuzByG3JgM6tXIFMvNeWtAAVxDTbf1WqyAOfKy2r72e4y4rRb2Ool3X/3QT
        dscM1/J29g4wJOXzg80EXaV1WtCJYubeWKJN8RTvrCdr1NNNMbLhDVrRPM4oO8bpdG2Wsi
        K8B4ODHtFpZeXrjNXgVSpTM2xDzaRTxMIZ6HKxGekXTOmksZb8+e5BNh4HExh2QssnWPyu
        bb+eXC9+I6v9L8WNuL0/dT3VXBQ9GVYLWE5BEgFGJPXsIhVysYwMDbOiCkrxNf+YZoyt0A
        SvevLHdyGiH65mnEEzCRChNfP1JVN5qhiC0PTw1rXLoQRFbxhKUzjMFtEXUNFA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id A0593634C95;
        Tue, 15 Aug 2023 01:06:22 +0300 (EEST)
Date:   Mon, 14 Aug 2023 22:06:22 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Suhrid Subramaniam <suhridsubramaniam@gmail.com>
Cc:     mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        suhrid.subramaniam@mediatek.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2: Fix documentation for 12-bit packed Bayer
Message-ID: <ZNqlXsg82lSSi2fn@valkosipuli.retiisi.eu>
References: <20230711013140.54080-1-suhrid.subramaniam@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711013140.54080-1-suhrid.subramaniam@mediatek.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suhrid,

On Mon, Jul 10, 2023 at 06:31:40PM -0700, Suhrid Subramaniam wrote:
> Fix documentation for R13 and R33 low bits.
> 
> Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>

This doesn't match with the From: field.

I can fix it this time --- which one should it be? And please do fix this
going forward.

-- 
Sakari Ailus
