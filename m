Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27577FD90F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjK2OPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjK2OPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:15:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C783BC;
        Wed, 29 Nov 2023 06:15:15 -0800 (PST)
Date:   Wed, 29 Nov 2023 15:15:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701267313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvINaeel3us7q2G8aevzOOZScdLQNs5ot2M+53moFQw=;
        b=I1AJlJs5pYppHlKxHxnJgSTfOdDFkbJX8xul4rLzGgYQNn5YqZvfyAJrhfGhFJU0CFldJA
        0SZurWoK/YNvzfnPPSeiVcKKpjoGOVo8vhmeyk5HVrTS4r6Iq4tk9JzzxlYjA++qmcrUpp
        RT1dqHk0uMqEmcEyyrkJPluA3IRdw1CpTmXUx0jPWw9ODWmM6JIv0P6se8I89xrVEDohf+
        AOZIAfSaXpFFT+QIENgJanphEnsYqv9S0FGiGWy2cGH+UaQoFvMj9wWaL3750t8uDlDRl4
        1u/tjeEFBevfLZDxv2Cy/k/RiL9XdTtA0ppl7aiyqdHM1LcJW0ltpJHLVfS0rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701267313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvINaeel3us7q2G8aevzOOZScdLQNs5ot2M+53moFQw=;
        b=uc3Z6Can7SdrJXV08lkocsrKGPRby5hRaK/0tEO3E9BRnD2CAhdQEXi8q3hy9c7YZSwcew
        zzIva1xfW2VnV8Dg==
From:   Nam Cao <namcao@linutronix.de>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] spi: introduce SPI_TRANS_FAIL_IO for error reporting
Message-ID: <20231129141432.ZzaLYucz@linutronix.de>
References: <cover.1701264413.git.namcao@linutronix.de>
 <361901574eec1271c0969edba6492d3f2132fade.1701264413.git.namcao@linutronix.de>
 <CACRpkdZYZUP9rnXbqO1BaHe_e5R8m30sYuPmfhj=VcDS-drZjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZYZUP9rnXbqO1BaHe_e5R8m30sYuPmfhj=VcDS-drZjg@mail.gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 02:55:18PM +0100, Linus Walleij wrote:
> On Wed, Nov 29, 2023 at 2:32 PM Nam Cao <namcao@linutronix.de> wrote:
> >  #define SPI_TRANS_FAIL_NO_START        BIT(0)
> > +#define SPI_TRANS_FAIL_IO      BIT(1)
> 
> Is it obvious from context when these flags get set?
> from transfer_one() and in which flag field?
> 
> Otherwise maybe we should add a comment.

Agree that the purpose of this flag is not clear. I will add some
description in v2.

Best regards,
Nam
