Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CAD7A5FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 12:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjISKi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 06:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjISKiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 06:38:25 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043E4E8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 03:38:20 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzdf0gkyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4506:4f15::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RqdRS4W9jzyWs;
        Tue, 19 Sep 2023 13:38:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1695119893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3n9vFemvqZfmdJNKvnR6R2hYzMGPNge32I2NtV3jk4Y=;
        b=wjrBx65XoqVmBUD9A7B0U2OiDcEqzhTXEyYlpGFjaZn47dkgoNN6ofvPFKWXUeBkwyC/MJ
        xnqZfr7VfVLPrQVm3zO+C6Y6yftEEnfv52EaG+WbYEjzYTbpj5hfcbgGEsAiNVnglJT8qd
        5hzxxw4bvd0045R0ySrtc/FHKvqFvbQ=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1695119893; a=rsa-sha256; cv=none;
        b=qt8NM2IkObeDkxmsSM696Fj9Eehv2r8WreU81WP5UyTLFMLp1Oicr31wnK+/oPUFuIg0iC
        Np1HmYeO1H0SlXJ8DJAzWeE7rlj5X0nokb/oeEuPhPsbIgkCuMRiGVBZnNebqnR8pMNJxN
        h92ocI9J62lt7anSN9Go4QQphBZe7kk=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1695119893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3n9vFemvqZfmdJNKvnR6R2hYzMGPNge32I2NtV3jk4Y=;
        b=iBp9VfcBDP0PLn1eSnEAIY+oBL8t2ahPA9dOcEd73tHJftf5VHQjvt1Sel1wCF5YGgMu9P
        Dtw9FQBZlbgIxBlyPerTIHKJ7lwVmt3WDH+FwRRtTj/hqCfKaRMYGk1Bf+buxQzOakSv08
        FaRfzpq/gpzJZnM7WiGWr6OTYxc0iaA=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 43F57634C94;
        Tue, 19 Sep 2023 13:38:11 +0300 (EEST)
Date:   Tue, 19 Sep 2023 10:38:11 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     shravan kumar <shravan.chippa@microchip.com>
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] media: i2c: imx334: add support for test pattern
 generator
Message-ID: <ZQl6E3AGzXi5OvGV@valkosipuli.retiisi.eu>
References: <20230919091740.1821543-1-shravan.chippa@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919091740.1821543-1-shravan.chippa@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

On Tue, Sep 19, 2023 at 02:47:40PM +0530, shravan kumar wrote:
> From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> Add support for the imx334's test pattern generator.
> By default the test pattern generator is disabled, so add support for
> enabling and disabling horizontal and vertical colour bars.
> 
> Acked-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> ---
> 
> V2 -> V3
> Added "Acked-by: Daniele Alessandrelli"

There's no need to send a new version if you're only adding acks.

So there are no changes from v2?

-- 
Regards,

Sakari Ailus
