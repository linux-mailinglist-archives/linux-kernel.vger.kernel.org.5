Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86806796EF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245070AbjIGCaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245059AbjIGCaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:30:08 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102191FC9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 19:29:52 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6bd3317144fso392664a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 19:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694053791; x=1694658591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jXVHSN9UH4yRS9yEiibVU5OrgopEwYQrywWZWB1MiJg=;
        b=aY8UelKi5PnPJ76YUeGiMZLQjwXImNaEC3b/ls5agm//2DgOvK9S5TFI6dIWHy4YZq
         EZA8EzsD2YdMzdKq6c6oAt0XEpd61dIQldFMVw4qaP6n3iwZ07f392G96SImPxYRsVZo
         mnSKqrdNZWl12pPrwJcXo8IJ4HFxmpEcN8R3geJeY+W5bVM8U1B8g4TUprVjVxRer9Ld
         il2hvP9u5Z2+5IDpNf/I8JHevz1iHAN4M57/zRzTqoZs5OfU4vRw6dWVAlcDMyh/kdzX
         JryRh/nL6Y77fq9R+MdQHcAmXbUfFRdDdFlVDmGyxxb63lYhQdHtQU3ylgzaD1kGxbKI
         4Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694053791; x=1694658591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXVHSN9UH4yRS9yEiibVU5OrgopEwYQrywWZWB1MiJg=;
        b=AZcODN4zozhra/+j5mRzf23PIrbJ2a5NxBSmTyXGVg4CLecjLS3nNG7IriyispKhhR
         aJEKrlkm/1TvJK0akqz3xUsPi1zi+fI25TXthcRnG9FTMJ4G9DTIoNERekVjIQ5iTDlJ
         xBD/r1Kh2eh/2MnYX06UkyFqvSG5VEmVwqcH7IiFsHM7S6LGIcLbG59IFEXCmK0Hhp6t
         NzVJAhvyjdLNd41Ylf8sRD/rXC6wzC6v7gg/7xTy3ooJq+IC1POldG6mxbV0wrZkWegq
         +wT+NSTWwKrsbWP3Zt2jP0I0XG2e1EBBIRcHToXltGjg/wLTUCoIDDesDk6W0VoGm8qT
         sMMg==
X-Gm-Message-State: AOJu0Yx4NdFaankRMleLrNH585rCDsVT0yJ8NSbazJwkOT3eqpzlLenU
        0Fq6Zc3Mz4pKnpX02gc/tio=
X-Google-Smtp-Source: AGHT+IF4wgCwuS0FbyDPyPT9pWqQtGo78O11d/UR6tq+pxI1r5JzC97u4kA4pxEFFJwZA55yqfH1oQ==
X-Received: by 2002:a05:6830:14d9:b0:6b9:8357:6150 with SMTP id t25-20020a05683014d900b006b983576150mr18467951otq.35.1694053791031;
        Wed, 06 Sep 2023 19:29:51 -0700 (PDT)
Received: from geday ([2804:7f2:8006:99ef:50e4:98e3:42a7:1619])
        by smtp.gmail.com with ESMTPSA id l2-20020a05683004a200b006b8c6eb962esm6941477otd.52.2023.09.06.19.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 19:29:49 -0700 (PDT)
Date:   Wed, 6 Sep 2023 23:29:46 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Antonio Terceiro <antonio.terceiro@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, Takashi Iwai <tiwai@suse.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: snd-cmipci oops during probe on arm64 (current mainline,
 pre-6.6-rc1)
Message-ID: <ZPk1mpbSeK7+eVs2@geday>
References: <ZPelHaX/Lt++kkOm@linaro.org>
 <877cp3esse.wl-tiwai@suse.de>
 <4f335dd2-8043-c60e-cf84-c2b01c4fee12@arm.com>
 <ZPjGuCdmPgqznc5t@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPjGuCdmPgqznc5t@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 03:36:40PM -0300, Antonio Terceiro wrote:
> On Wed, Sep 06, 2023 at 01:49:16PM +0100, Robin Murphy wrote:
> > It's blowing up trying to access PCI I/O space, which has apparently ended
> > up in the indirect access mechanism without that being configured correctly.
> > That is definitely an issue down somewhere between the PCI layer and the
> > system firmware. Does the system even have an I/O space window? Some arm64
> > machines don't. I guess we might not have got as far as probing a driver if
> > the I/O BAR couldn't be assigned at all, but either way something's not gone
> > right.
> 
> I'm pretty sure I saw reports of people using PCI GPUs on this machine,
> but I would need to confirm.
> 
> What info would I need to gather from the machine in order to figure
> this out?

Antonio, please see:
https://community.amperecomputing.com/t/amd-gpus-on-the-altra-devkit-and-other-altras-patches-available-now/336/11

You have a quirky PCIe controller it seems. You'll have to go through
the errata and then some.

Good Luck,
Geraldo Nascimento
