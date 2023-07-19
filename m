Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD20758DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 08:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjGSGWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 02:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjGSGWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 02:22:32 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707131BFC;
        Tue, 18 Jul 2023 23:22:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666e64e97e2so4413287b3a.1;
        Tue, 18 Jul 2023 23:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689747751; x=1692339751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8isZuvk/P/YUKIH6u6PCyMNEXpd4vq8h/D4iPr6XM4U=;
        b=pPIcohcQv4obvugV9PzpinGPcx9WzEJxosLUNtR3Cb2HMObeYVerKeS8vrMRw3c6VP
         FW26J9ncrJWcIDUxKCYFaQzibnV0YHSF5J4EAJCxuRfw/SYB70vNK/iWlqw+K2lkWFfc
         ix83zldZI/MbMpJnnX0tkReuvbGrDUlVaZ9IDAtAXtHqMjx6zF2wITLPx3np1+XuqlPk
         uwTj8Y6gnyou5lKer0d4KlB0DQ4uICnbcS5V76N9T/wOSH8Fidsp8ae/EoRl6jysFGKx
         1/Sp83yvFQgGiV8bRRhgY7xvYwP2BI4Osh9/qcUFrTrA53WtQfhgeQcobUfYE7K2aIxV
         k4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689747751; x=1692339751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8isZuvk/P/YUKIH6u6PCyMNEXpd4vq8h/D4iPr6XM4U=;
        b=XdoeCt/HS2Kgf3ie9f2DktFqLfSG6ok0U8LqvoJqal8V8BFU4yT1Yl3dUkLd6GCwwp
         nZ1dWZa/TVMueY7p1BTUjSK+16czlfu8L3XelYWrT1aA3HaQ30O2Mj+ycllvco5o0Ky5
         GheoA/Q8ySbXHRb/dlmNc4hwFOG6J2gUoJXBPaQbUPyegNi/8/k6wN5eFNjHkfBBe7Gs
         x9GVAOcuMksfyi3g1a9Om4bGw2yBKv/GdW7SYZG5iY4HBzyTRdGCVbeim8OjpHE6z3AT
         sNoRNFoNvxclBh/TGtfqmvxXi/iWv5cx3jLCnbn8ySynVjhVx70bmIHqKJhHenjuOGgc
         26rg==
X-Gm-Message-State: ABy/qLYsewsQrgJ4fksTo2kxXRjAxwTSjjmOrvKd+Ug6dJnrgLTY2ePb
        Z2D5ZTvnFoxnMFTVh+mwXLc=
X-Google-Smtp-Source: APBJJlF4kAa/7l3Cya97fnaj8GNT+ma5FSvt3xOGAK1MBxRBHYIUzhH0hn4psNhBQTfklweoQFasNg==
X-Received: by 2002:a05:6a20:394d:b0:134:7708:49c5 with SMTP id r13-20020a056a20394d00b00134770849c5mr1386819pzg.36.1689747750702;
        Tue, 18 Jul 2023 23:22:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:798:b6f:a67a:7ac1])
        by smtp.gmail.com with ESMTPSA id u5-20020aa78485000000b0064d681c753csm2497543pfn.40.2023.07.18.23.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 23:22:29 -0700 (PDT)
Date:   Tue, 18 Jul 2023 23:22:26 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [RESEND PATCH 2/2] Input: mms114 - add support for touch keys
Message-ID: <ZLeBIma/CLcK++RF@google.com>
References: <20230714100424.29798-1-aweber.kernel@gmail.com>
 <20230714100424.29798-3-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230714100424.29798-3-aweber.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 12:04:24PM +0200, Artur Weber wrote:
> +	} else if (data->num_keycodes > MMS114_MAX_TOUCHKEYS) {
> +		dev_warn(&client->dev,
> +			"Found %d linux,keycodes but max is %zd, ignoring the rest\n",
> +			 data->num_keycodes, MMS114_MAX_TOUCHKEYS);

This gives me the following warning:

drivers/input/touchscreen/mms114.c: In function ‘mms114_probe’:
drivers/input/touchscreen/mms114.c:520:25: error: format ‘%zd’ expects argument of type ‘signed size_t’, but argument 4 has type ‘int’ [-Werror=format=]
  520 |                         "Found %d linux,keycodes but max is %zd, ignoring the rest\n",
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I changed the format specifier to "%d" and applied.

Thanks.

-- 
Dmitry
