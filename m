Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF607FCC97
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjK2CJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:09:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2CJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:09:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4750A172E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 18:09:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0637C433C8;
        Wed, 29 Nov 2023 02:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701223798;
        bh=krQxXz6X16omvuw1/mfx1edESKLpPSL4GmvftnLHIjY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uMX4IWEcfeXX1ffFM9xMIaQgMcuJ4sVhGBRqO+YQuAD4fDVoGSDGlmr32++7uCpOk
         dhViZ7qA47ZkoHy41KeQm7ATVfzwcsLr8tqUwoAmf9kTrkJGSRkg203OAx/6hvgZbN
         W/SZEjz2zBqU2sWVfyLUAymPNmMUSA8LwwrLd3VY=
Date:   Tue, 28 Nov 2023 18:09:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Damian Muszynski <damian.muszynski@intel.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v1 1/1] units: Add missing header
Message-Id: <20231128180957.ac5caa884abb2b5f00ca47c4@linux-foundation.org>
In-Reply-To: <20231128174404.393393-1-andriy.shevchenko@linux.intel.com>
References: <20231128174404.393393-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 19:44:03 +0200 Andy Shevchenko <andriy.shevchenko@linux=
.intel.com> wrote:

> BITS_PER_BYTE is defined in bits.h.
>=20
> Fixes: e8eed5f7366f ("units: Add BYTES_PER_*BIT")

This is post-6.6, so the fix should go into this -rc whatever happens, but.=
..

It would be rather nice to know the effects of this change please.  Did
some build break?

> --- a/include/linux/units.h
> +++ b/include/linux/units.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_UNITS_H
>  #define _LINUX_UNITS_H
> =20
> +#include <linux/bits.h>
>  #include <linux/math.h>
> =20
>  /* Metric prefixes in accordance with Syst=E8me international (d'unit=E9=
s) */
> --=20
> 2.43.0.rc1.1.gbec44491f096
