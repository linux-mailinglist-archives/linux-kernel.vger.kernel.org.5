Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F91D78A0E5
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 20:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjH0SJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 14:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjH0SJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 14:09:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A559AC9;
        Sun, 27 Aug 2023 11:09:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3708E614BA;
        Sun, 27 Aug 2023 18:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA077C433C8;
        Sun, 27 Aug 2023 18:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693159777;
        bh=oHb1AKwhAF0IMae6XrrnNKcxQ6DhFENseFL14Fq6aRE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lD8Cr212zFmFEYfiRrjTWBDsoKN1OR6MBmCsakTQtYxbV6ucxOcZ+779vTtTlX8qc
         JaFxaqc38ZVXMTtLWHtUEBECl4nGZ7ahK/vLbksyFLgvvY3mbOc3d3FKb/iMCvI/6K
         mVIogzegGACTmeHTI3cLN6OrWRV/v2qrZoZTLH+XvogU6qTR3ursJ2HQWVOqbmWCJq
         cS/XY3dY4bkbZyAALt0qSmgT6E44ok/x7gu8a8pmZCb6glW5NNPYgoEglK71PvMdiV
         j7uaBhqOkTZohiQwOKv3LuBv/tpCBWFR4kO7nIAKi15gGAqH4gOmKB0jltq5cRJvwo
         s6ErXopLA5s9Q==
Date:   Sun, 27 Aug 2023 19:09:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <20230827190732.5e2215d0@jic23-huawei>
In-Reply-To: <ZOdrtNQijmhN9RAx@smile.fi.intel.com>
References: <cover.1692824815.git.mehdi.djait.k@gmail.com>
        <923d01408680f5ac88ca8ee565a990645578ee83.1692824815.git.mehdi.djait.k@gmail.com>
        <ZOdFyKHBc6BcOgZw@smile.fi.intel.com>
        <eb47d0c9-9144-c947-f91e-d487c6ec9c45@gmail.com>
        <ZOdddZ0Zpk5CknH8@smile.fi.intel.com>
        <CAFukWp2Z0OCrJdTy+wzVs9jdCm70YNR-66q06=xoyGhaHg=aog@mail.gmail.com>
        <ZOdfeaW6AxE4eeqw@smile.fi.intel.com>
        <CAFukWp0ubncNcMiw-s_h5GoP1_RsjTaw3XxayGMuaeJJJneBow@mail.gmail.com>
        <ZOdrtNQijmhN9RAx@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > > I see. I think my confusion can be easily cured by renaming the callback to
> > > > >
> > > > >         get_amount_bytes_in_fifo()
> > > > >
> > > > > or
> > > > >
> > > > >         get_bytes_in_fifo()
> > > > >
> > > > > or alike.  
> > > >
> > > > or leave it as is. The function is documented:  
> > >  
> > > > + * @get_fifo_bytes: function pointer to get number of bytes in the FIFO buffer  
> > >
> > > Do you find it unambiguous? I do not.
> > >
> > > Still needs more words to explain if it's a capacity of FIFO or is it amount of
> > > valid bytes for the current transfer or what?  
> > 
> > how about change the description to:
> > function pointer to get amount  of acceleration data bytes currently
> > stored in the sensor's FIFO buffer
> > 
> > and change the function to "get_amount_bytes_in_fifo()"  
> 
> Sounds good to me, thank you!
> 
Bikeshedding time ;)

I don't like "amount" in this - it ends up adding little meaning
and to me it is ugly English.  It's making it clear that we are dealing
with some sort of count but that is already true of get_bytes_in_fifo()
So to my reading it adds nothing wrt to removing ambiguity.

get_number_of_bytes_in_fifo() flows better but also adds nothing over
get_bytes_in_fifo()

You could make it clear it is something that changes over time.

get_current_bytes_in_fifo()

Which at least implies it changes - though it doesn't rule out a weird
variable max size fifo.

get_fifo_bytes_available() might be the clearest option and is the one
I would prefer.  It's still a little messy as it could mean
'number of bytes of data that haven't been used yet in the fifo and
 are available for samples in the future'.

Sigh.  Maybe least ambiguous is something longer like.

get_fifo_bytes_available_to_read()
get_fifo_bytes_available_out()

Honestly I don't care that much what you go with :)

Jonathan


