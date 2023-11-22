Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0BE7F4890
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 15:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbjKVOLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 09:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjKVOLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 09:11:33 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B7E83
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:11:29 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-32daeed7771so4150666f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 06:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1700662288; x=1701267088; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j6oC8Fs3BZRJguyt5O6618kkpqiUsB6zuCr+BFV9ojc=;
        b=fKvw+77CHGqlTTds0h6ZA0xJDT2GieivfWFu2cIG42z6ynVtPRnZfHqybqEkvOSavi
         TLR00jdpYmFIsXQOP1tmJboBDFpTn1nUg1tEi6xF4C7QuGmSWC/OOWz5rnQacS0te1ul
         WiRok4rjVRjwhDeVe4CT+3XaDPfdarXn4/U94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662288; x=1701267088;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6oC8Fs3BZRJguyt5O6618kkpqiUsB6zuCr+BFV9ojc=;
        b=TDtxFW4/NIpoNkQRvyshW0AkmbChQ2Ia1GbaNev+IcSDMZBMYDvfk6r9FLhHp8TBl4
         mvX1i7yerdW+hXpDdA9x3q0sV2qqkEMUfNvwFecQplEaOEoC5SKL6rb8C5OGSKL/CS1w
         qrEPrpPlBY3V2Css9edWPh8JP1NJ1DtQTS1JqLmNOTEVsqtJ2NXkQyU4pKLw+AHh9tvh
         sWeOuJKg6pBe6dMFGuXosEuV2mURG+FJ1D8DCj6VYIQ6KIv8e0F9uc2Edl3DSzQGwPXS
         NpRfNorVf2ntGYgv7LzA0vkT4sY4g+XEAYBvRDKMdFjWKbBeHiCpOlvL7Li0YPmMxHrd
         xZ2w==
X-Gm-Message-State: AOJu0YxWxm6MRU+tPHN5Ha7UP98jT/XmDwClbIzgfrNCGl8ezJHBmH9I
        lUVMxNELx6rhQ77ujFLPzKnwkw==
X-Google-Smtp-Source: AGHT+IHvST9DtUHsKkmwgZf6S3xVst9F2NM1FhB0lgKbcdN9HZ4sV8auN2hvsgW/BtionlZ4Z4ov+A==
X-Received: by 2002:a05:6000:156f:b0:332:ce72:d589 with SMTP id 15-20020a056000156f00b00332ce72d589mr2511576wrz.3.1700662287943;
        Wed, 22 Nov 2023 06:11:27 -0800 (PST)
Received: from ?IPv6:2001:8b0:aba:5f3c:1718:e534:44cc:c75e? ([2001:8b0:aba:5f3c:1718:e534:44cc:c75e])
        by smtp.gmail.com with ESMTPSA id az30-20020adfe19e000000b00332c36b6563sm11363831wrb.101.2023.11.22.06.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:11:27 -0800 (PST)
Message-ID: <e49abe2b336ce7534e9a7c82e21df9644f00f3a2.camel@linuxfoundation.org>
Subject: Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128
 x86/alternative: Rewrite optimize_nops() some]
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        paul.gortmaker@windriver.com
Cc:     bp@alien8.de, linux-kernel@vger.kernel.org, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org
Date:   Wed, 22 Nov 2023 14:11:26 +0000
In-Reply-To: <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info>
References: <ZUEgAAGDVqXz2Seo@windriver.com>
         <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-11-11 at 12:51 +0100, Linux regression tracking (Thorsten
Leemhuis) wrote:
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>=20
> > [Re: 32 bit qemu regression from v6.5 tip pull [6c480f222128 x86/altern=
ative: Rewrite optimize_nops() some]] On 30/10/2023 (Mon 20:30) Thomas Glei=
xner wrote:
> >=20
> > > On Mon, Oct 30 2023 at 19:24, Thomas Gleixner wrote:
> >=20
> > > > Can you add "debug-alternative" to the kernel command line and log =
both
> > > > a working and the non-working kernel output. It's noisy :)
> > > >=20
> > > > Also do you have a .config and the qemu command line handy?
> > >=20
> > > Forgot to ask: Does the probkem persist with 6.6 ?
> >=20
> > My bad, should have mentioned v6.6 and linux-next is impacted. Always a
> > conflict between burying the lead and boring people with details.
>=20
> Paul, was this regression ever solved? I wonder as I could not find
> anything with a "Fixes: 6c480f222128 [...]" tag on lore and this thread
> looks stalled.

I didn't see a reply to this. I can confirm the issue is still present
and we're not aware of any fix yet.

Cheers,

Richard
