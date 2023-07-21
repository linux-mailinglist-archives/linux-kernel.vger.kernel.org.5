Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29C675BF28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGUGzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGUGzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:55:10 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734F5270A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:55:09 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-313e742a787so974275f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689922508; x=1690527308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNmlJ3n3qyZkESUqFDbn55zZvGbTykf04wh3VlzzJ2M=;
        b=fA2EDLuWemqTcPzlzlAmx7gqs4R8GeoY0s3ZvqfB0cD8eyNdOxy9CggCCu91rSNuZZ
         tDHGmUIRj8MaHRkmSDPWVXK3IG8+qR5LMkm4heBVzehUyUuxRh2wrCKebGEUlEvzWzHx
         6HwfhGGzKLBEsJjAkXgPoyfokKEmEhJcpmkcL7zWQg9b/4jbXzUxJFrUaB0dnURAV8rn
         bttkywZISAzbLjykzQPS5FJBtBvPVb4kbPR8wywfHPYVxqSS4pnv8aaw/BwfVK/bU0O9
         J6Mz7sD5ZOR/bNfkcEBfMu3DxC9JZKmA+KVTOifgkMkQrojTzDRSvLpBJyuR6Cw35sHp
         6q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689922508; x=1690527308;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNmlJ3n3qyZkESUqFDbn55zZvGbTykf04wh3VlzzJ2M=;
        b=a4IIyeI2FjMst2U73mbWJay6zhwhpgpdH53p43N61jODU+SmNURFNTJC6a+rD75CTi
         4KuHgwdS28ZE3/JJ3tDvyHTc1UeB/7Ewb5XEAcBfVkuqyR+1fPSjrU6TRZ0vqlqfIl/O
         yDnNGyjxhJjqJVdxH35Xxo5vRLl/XWOInhAu61ysKds9Pv9UIfpUpE4vljnju4ueYhPR
         VE2DEX1/KHWRyd1Ja/iYuGg/pxvK2VDR8Yg9JD8dsU0ZWnvM1R3QUoTxIqyvfcy/i5JL
         9ZFgD31KWXCk01lzQkmimxvWtcFTY3Xbz6rEEhYGzz+TqIdCqdwc9eSKDQe6AYOEqSUx
         kvOw==
X-Gm-Message-State: ABy/qLaJJX7Gmq9ZjhhOwmkCrv9lbNppY7srDBYgA1dWKgao3bNWZWDB
        Cu013YLEgWi+pfVCDG3hkca/5Q==
X-Google-Smtp-Source: APBJJlHAMjvc9srETZeqqF2QeqDhmDxQakmm/3s+sSUcsZ9fpOqqrCeUyx6rx6fxFezazMkoh84RmA==
X-Received: by 2002:a5d:4564:0:b0:314:1096:6437 with SMTP id a4-20020a5d4564000000b0031410966437mr847140wrc.19.1689922507952;
        Thu, 20 Jul 2023 23:55:07 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k18-20020a5d5252000000b00317046f21f9sm3276880wrc.114.2023.07.20.23.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 23:55:05 -0700 (PDT)
Date:   Fri, 21 Jul 2023 09:55:02 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Harshit Mogalapalli <harshit.m.mogalapalli@gmail.com>
Subject: Re: [PATCH] mtd: rawnand: fsl_upm: Fix an off-by one test in
 fun_exec_op()
Message-ID: <587c59c1-17f2-4c16-b2b7-1b1208e7c128@kadam.mountain>
References: <cd01cba1c7eda58bdabaae174c78c067325803d2.1689803636.git.christophe.jaillet@wanadoo.fr>
 <6f3c9139-cf68-4761-af06-462a72bda978@kadam.mountain>
 <03c69172-b85f-d9c2-6fd4-33f3ad149142@wanadoo.fr>
 <604b0c70-01cf-4cbc-b387-8c709c972fef@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <604b0c70-01cf-4cbc-b387-8c709c972fef@kadam.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 08:37:02AM +0300, Dan Carpenter wrote:
> Harshit and I were mucking with this about yesterday.  He made
> Coccinelle script as well.
> 
> We found three bugs in max9286_parse_dt(), hisi_inno_phy_probe() and
> jent_testing_store().  Only the one in hisi_inno_phy_probe() is real
> life bad because the others do an out of bounds check followed by a
> mask.

Actually wait.  hisi_inno_phy_probe() is not a bug at all.
MAX9286_NUM_GMSL and MAX9286_NUM_GMSL are both 4.

I was wondering why Smatch didn't find this bug.

regards,
dan carpenter

