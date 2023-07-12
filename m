Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D6F750EFE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjGLQwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjGLQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:52:14 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834E212E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:52:12 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6f943383eso117145241fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689180730; x=1691772730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oAuCX7b/d1hbHKp+310Sb1Zp5QGgY2qfzYziff3Pm1c=;
        b=U5ONKyp89d8LjT1vJe3usI67MT+9QxOmfVCOnV8Qu1V72IlaDhrnb03Zsqn440Rr4M
         B2fBHx4diBfDXv+wMUC7thn/86QRjglRTgYGshZRHvXSfInKy4w8SLCg8k7tPgXo0aOw
         FTpHc/9OLYlhJB4h56Lq2MX4SsudXF3Dy0Ws4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689180730; x=1691772730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oAuCX7b/d1hbHKp+310Sb1Zp5QGgY2qfzYziff3Pm1c=;
        b=lOwXESlyR+hNpO05aiJ4xjEj2KjIPtTKnXC9zq15/DIThjYe6UlqJIB4fR3yVAfk54
         tZEew7kD4qdmTi7ZHo34We0nzduXSNicKYf4ZLx/5E/X4EyK6Xer4auvnwUrOLaFnfaP
         qXftqr26ugT5GKQ91wDeII6iHC7caCKEUrp6vUP/SMr7F2PTvD7312ai+GbYJM7UpLE0
         CP5EfHrKqyojEymVlN35L8afnG5FRH+Jl+6ugU+PauTaVc/WJDFWqA1Bh8p3gq/+PQrJ
         4V7ICyOQkP5YdYYTnfdrREapg6vSeqr62wut38h4G+J5GnPnqMOsMOfSpRsMPncFIlrK
         f63w==
X-Gm-Message-State: ABy/qLb01U1RV8nGILsPuM1KuUIVkPxYda1r4yh3qBzXfcRkC9jMrkDG
        GjgwH/GQFczF9MqU+ZNutX5gmk+QHF5ukXn7CR6gxZZz
X-Google-Smtp-Source: APBJJlHnwaz0xGYZNm0qGtRj1Mhs32bW1hItlp4CGkLgB1ZWtC8z0gooPyWIPvvAdK9dx284+cy/UQ==
X-Received: by 2002:a05:651c:120c:b0:2b5:80e0:f18e with SMTP id i12-20020a05651c120c00b002b580e0f18emr17796281lja.3.1689180730711;
        Wed, 12 Jul 2023 09:52:10 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id e16-20020a2e9310000000b002b6cb40e9aasm1014444ljh.103.2023.07.12.09.52.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 09:52:09 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fb94b1423eso11058965e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:52:09 -0700 (PDT)
X-Received: by 2002:a05:6512:3090:b0:4f8:4512:c844 with SMTP id
 z16-20020a056512309000b004f84512c844mr19547117lfd.48.1689180728994; Wed, 12
 Jul 2023 09:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com> <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
 <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com>
 <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com>
 <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info> <20230711120609.GB27050@lst.de>
 <CAHk-=whXh9sgLo24RO02JjfD0m3HE5NADRPWoEd+dW6bruFhVA@mail.gmail.com> <20230712164546.GA31434@lst.de>
In-Reply-To: <20230712164546.GA31434@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jul 2023 09:51:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=whA9rmvNfo=8iKmtimayiA2Aus4XvPwcDrA53G2rfGP0w@mail.gmail.com>
Message-ID: <CAHk-=whA9rmvNfo=8iKmtimayiA2Aus4XvPwcDrA53G2rfGP0w@mail.gmail.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        =?UTF-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 09:45, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jul 11, 2023 at 09:47:00AM -0700, Linus Torvalds wrote:
>
> > and we have NEVER EVER seen devices with reliably unique IDs. Really.
>
> Sorry, but that's bullshit.

Christoph, you are *literally* involved in a discussion where this is the case.

What you call "bullshit" is what everybody else here calls REALITY.

The fact that *some* devices have serial numbers in no way implies
that all of them do.

And if you think that they all do, you are the problem. Literally in this case.

So you had better really internalize this "there are no reliable
serial numbers in general". Because it's simply a FACT.

> Well, let's try something like this (co-developed with Sagi) that
> allows it for non-multipath PCIe devices, which covers the quirks
> we've added so far, but also add a big fat warning, because we know
> people rely on the /dev/disk/by-id/ links.  Probably not on these
> devices, but who knows.

Looks sane to me.

          Linus
