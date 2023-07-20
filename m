Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0334175A721
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjGTHEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGTHET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:04:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C545ACC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:04:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso3042895e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689836657; x=1690441457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9AlU95qM4t9xHPBYL7DWAvT1cUkDalZV3dRJmbFdb9U=;
        b=dU+ORkJC8RNWsmM5SVA/u5VDWKga3el11dXhQWod28uKQxqV27WsfA/tglMuF8ytal
         oR9rHhg8Ffr8qjFOlQqJ2TP9mDjnM8aHh1J5JZ0M85wyO4MFq/InWjdqlvlmOCXT18oi
         QjpSMQRBEYEVQB6VKcMyoKiOj/fWRc9bltCj1as7WQq4ikJK1y9pA9lypkyLy0PS/V31
         fqTMXHOhDDccm9U/ddyDmuiSNegiYxGBV02zlmpbfcFhi+ia8+CoZbqjukiyT21EcZhf
         bHGNBBO2nLGsAxMvkqHDWb8OMWWqLsO9IvKBYvV6AmrR7RC1LKD/Z8ux8r9zTLpiZhoR
         IGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689836657; x=1690441457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AlU95qM4t9xHPBYL7DWAvT1cUkDalZV3dRJmbFdb9U=;
        b=AYccvn8qhiLFFGVIpFMLo/BrowdsK4zc0Cd7OQJoHl033BBaJhrxjqiAWctPD7rEKu
         SJayy8nQg2PvBDAND0+TYkGcy8GWNHN6/EhDAtm7+7dGfk39byw2rL8WHn4IZFU0ynya
         i4F/d8+zYlLKIYJg7/Z45z8wWaU1wtQh/7GEMledNO3hp91duerWEPdnXQZBRnEomNPZ
         H7jBZ3t4cjioMoNNu8ZNYLfRp9vYvv9bO3S/scJjNioMDHgDGaKtXI3FARlUaQ15t5VB
         8iruqwIBPOuMZAVIXzHxMu5UMEMrH8k/IZP45WQxT/PD7191bhw3t02IchzwKe5Cr1rO
         hPuw==
X-Gm-Message-State: ABy/qLYLeodJyCeiDyaZe3tncpxQPSEY4dXnsFo+kSvOPZ1kAsk7DeVA
        6NIBw/xBIZxqqLWwP3bTDwymDg==
X-Google-Smtp-Source: APBJJlETKoi7x80wxBFFAxwsjGt5k10dYMeMuHD3TbDxOf+1dqUg2RtWoOiart0Ss3Mt2QyTH5e1AA==
X-Received: by 2002:a7b:c390:0:b0:3fc:62c:8447 with SMTP id s16-20020a7bc390000000b003fc062c8447mr1061669wmj.9.1689836657174;
        Thu, 20 Jul 2023 00:04:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a5-20020a05600c224500b003fbc9b9699dsm419216wmm.45.2023.07.20.00.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:04:15 -0700 (PDT)
Date:   Thu, 20 Jul 2023 10:04:12 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: rawnand: fsl_upm: Fix an off-by one test in
 fun_exec_op()
Message-ID: <6f3c9139-cf68-4761-af06-462a72bda978@kadam.mountain>
References: <cd01cba1c7eda58bdabaae174c78c067325803d2.1689803636.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd01cba1c7eda58bdabaae174c78c067325803d2.1689803636.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:55:01PM +0200, Christophe JAILLET wrote:
> 'op-cs' is copied in 'fun->mchip_number' which is used to access the
> 'mchip_offsets' and the 'rnb_gpio' arrays.
> These arrays have NAND_MAX_CHIPS elements, so the index must be below this
> limit.
> 
> Fix the sanity check in order to avoid the NAND_MAX_CHIPS value. This
> would lead to out-of-bound accesses.
> 
> Fixes: 54309d657767 ("mtd: rawnand: fsl_upm: Implement exec_op()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

Good eye.  I'm assuming you did something like this:

#!/bin/bash

FILE=$1
WORDS=$(cat $FILE | perl -ne 'if ($_ =~ /\[([\w_]+)\];/) { print "$1\n" }' | sort -u)
for i in $WORDS ; do
    grep -Hn " > $i" $FILE
done

regards,
dan carpenter
