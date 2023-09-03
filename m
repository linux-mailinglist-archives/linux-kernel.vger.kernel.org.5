Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15F6790BA3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbjICLhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjICLhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:37:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C6DF2;
        Sun,  3 Sep 2023 04:37:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF319B80B74;
        Sun,  3 Sep 2023 11:37:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF3CC433C7;
        Sun,  3 Sep 2023 11:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693741020;
        bh=tuwGfP4B5oLh2LtVZlEqLCMMizDfQJW9MygJsSHWdRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pj6isdPfsn+2Z5P6wHJ19ywhDGShVDt6j+sL4gLmlOPP8NGnafK/uXEzVNMhWe01r
         pb1F4ffRt/TM3lMc4VyprsRxhtr6yMWEFrX3X3MlEWuaqm+dh+aKJCulQWBrcPAXaW
         IFjhJo6df+10NSNZUQL+FdqdgPdLyvPc6rej/hFp3EzJAxfa0JcDf3wCDYj3r4Ysqt
         QfWW2ef8hwoNM4yLf9YYYWY2P0OfqV9TnqIN0ZUp9tIUdHOFNmojuCFaS5RbYDlYb3
         DuHxahKCiFaqSjkPplOIfxrcXWi0UTdZDkxNuuUD3lxd7ktqmkmJ+FcEffGgs7pwji
         PyfwIu1UZJXAQ==
Date:   Sun, 3 Sep 2023 12:37:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linus.walleij@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: addac: ad74413r: fix function prefix typo
Message-ID: <20230903123727.62a18f24@jic23-huawei>
In-Reply-To: <0527327b556aac4ce9b7e4db85aa831ca439e600.camel@gmail.com>
References: <20230830094314.26353-1-antoniu.miclaus@analog.com>
        <0527327b556aac4ce9b7e4db85aa831ca439e600.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 09:48:19 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2023-08-30 at 12:43 +0300, Antoniu Miclaus wrote:
> > Use complete device name prefix in the input current offset getter
> > function.
> >=20
> > Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > --- =20
>=20
> This a typo fix. So, I'm not so sure if a Fixes tag, backporting is reall=
y needed...

Agreed - I dropped the fixes tag whilst applying.

> Anyways,
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
Applied to the togreg branch of iio.git which for now is only pushed out as
testing because I want to rebase on rc1 once available.

Thanks,

Jonathan

> >  =20

