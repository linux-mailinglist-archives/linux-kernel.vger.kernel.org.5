Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22F776A53D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGaXzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGaXzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:55:18 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CD910C1;
        Mon, 31 Jul 2023 16:55:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe21e7f3d1so5435746e87.3;
        Mon, 31 Jul 2023 16:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690847715; x=1691452515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4pbTHD6tjmefXpshBCW5jz178SsoZXI/gyLrsf3Jo0g=;
        b=aSniwb46EziMct0wa7R7iEvhc05wrVYWgvblFqG5oTGqaEe51aj6U/88Qf6J0nXZ9Q
         eQ6KV0ktHPDoMfbQRltAE9a4hAEqcq8grwoswnU64KqMmC3TmsUJmk0kky+LgPVeQbof
         aTI4BAcp5kl/2KLizO10hp16iDKHYMZkGlNYnpAzoJRXaD5gvSXBnbEL8RvNLVstW4GC
         aB/haQVh1jKZsK8S/QEZ46Kk9jmGM6TIv+2AfxoUkdUICUFsQ7A6JPsyvc30oVCJwkwv
         ZB+cm7HMgrtj6SnffBP/ejwW0qOk1nAs+q7+QWZMoB91SnTmjwaSbi/PBM5S2kxEOQO7
         OhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690847715; x=1691452515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pbTHD6tjmefXpshBCW5jz178SsoZXI/gyLrsf3Jo0g=;
        b=c714D6D5pG7yQi95ZlX6hwMTJA/rROaOB6F2rB/FkzWnjp+7e+uj4MDoYmvnmqCmCI
         /cyz3OtLNTaxZXpvtOB0elSLqLCDGktooyWcO2ykB5okZL4Hnx5e6vyda8XGu7IhSSKX
         gtT7TJF3sORvSNfdWTupi/hhViFHlMJw3AoRWnbSeIpXQ2WGBwgtYSMod1H1IFyxaexc
         FRxkrNpUSltEAUOljugFkkuI5/eXBd+isbnYOwe8Xdwhr+3oYHXNXqSw1Tl0+DK4+y9Q
         nVp9s/jYfH3X6twnifgGas6vdqJFDn6O8hqmQVWnuoMauRNX88zFuiwaEZ4iW+HVRLuD
         hhOQ==
X-Gm-Message-State: ABy/qLYQtU9TS9gwgTrsjKWwFl6uGGuX+UJBnk6d5v7Wkko2gJdc+nVi
        c8UOKN5vw9627wzpq7I63yDKiWNUeKo=
X-Google-Smtp-Source: APBJJlGUDDjPPHt44seWPu/ci3y9lLwcQrFwpRmxSbFeKhWVYfEmOTrr264TyKs8AmxDG9XWC0X1eQ==
X-Received: by 2002:a05:6512:baa:b0:4fb:89ad:6651 with SMTP id b42-20020a0565120baa00b004fb89ad6651mr1038693lfv.28.1690847715227;
        Mon, 31 Jul 2023 16:55:15 -0700 (PDT)
Received: from mobilestation ([95.79.172.181])
        by smtp.gmail.com with ESMTPSA id t5-20020ac25485000000b004fe3a2e3952sm498202lfk.100.2023.07.31.16.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 16:55:14 -0700 (PDT)
Date:   Tue, 1 Aug 2023 02:55:12 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        wuyonggang001@208suo.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: baikal-t1: Using div64_ Ul replaces do_ Div()
 function
Message-ID: <xfw5vpmcqgktuvk2hhxhi5yppzarr7kidmr7g33r55zxcncd5a@z6zz2ciw2ipu>
References: <20230612033904.34921-1-zhanglibing@cdjrlc.com>
 <0dc9409b662180ed29cbc281f0f076b7@208suo.com>
 <fcd37e67fba625da304fdaf07e0ab0db@208suo.com>
 <CAMuHMdX0xP5Gugo7uF5Wqk9_ny6-4fOWYRm41KicOo26kC6m+g@mail.gmail.com>
 <nt6kbounehvfqo4hpfj3wbr7baukuhr22dafvoykgyehs4imsp@pc6bajyo6ugn>
 <CAMuHMdUHDK9CCJPoMgLQBrXjk9VWszYF17dUU=9JtQ8XX=QAPA@mail.gmail.com>
 <2xp54apmm6o5np34obv5muus5d2lpoo7fn6ozuzzj6p4f2whot@c3pji7twevci>
 <vnps4c6o6nsvazyggdqhhqedwsf7vrucc2kpiwpuozi7e2e7tc@celmt367ov73>
 <f4bb6c51f66325c388a43b9336ffa45b.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4bb6c51f66325c388a43b9336ffa45b.sboyd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 08:24:19PM -0700, Stephen Boyd wrote:
> Quoting Serge Semin (2023-07-27 05:28:47)
> > On Mon, Jul 24, 2023 at 05:11:23PM +0300, Serge Semin wrote:
> > > On Mon, Jul 24, 2023 at 03:38:49PM +0200, Geert Uytterhoeven wrote:
> > > > > >
> > > > > > Likewise.
> > > > >
> > > > > Right. This will also break the driver.
> > 
> > No news from Yonggang meanwhile the patch will certainly break the
> > driver. Is it still possible to drop it from the clk-cleanup and
> > clk-next branches then before it gets to the mainline kernel?
> > 
> 
> I've dropped it.

Great! Thanks.

-Serge(y)
