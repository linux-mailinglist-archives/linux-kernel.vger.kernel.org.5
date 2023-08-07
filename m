Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C79772733
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjHGOKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjHGOK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:10:29 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD769E;
        Mon,  7 Aug 2023 07:10:25 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso69842461fa.3;
        Mon, 07 Aug 2023 07:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691417423; x=1692022223;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KCn6b8Y4egX4m+kFsKdxSAcYU2iXuIgvgiEXKk/fp/0=;
        b=oJ4KDzJY0v4rfA8l+OXaUHjGrU6eM9tIo+Vru04y0dubzkPTojVnDwnVImQ3ymmpNk
         O2RNGQaz5IpnCUNemSRZwbU1lljIYZClF0Z2oahr22/YIuT8YX52NMeS+973mOrlU82m
         GWx5936E9GBFTHIzBrg4oMox/nx/RQAqqBiSog6ZbXv7l3Xt0hYE/U2unY2wmh2wqB7t
         moyBpp4R7x7MWAIMoWt5P2dzOQwrT/iJw782v1d/Llha+OppM1IZTJNnPAfGLaYJTiY5
         QclEi0IDiVQbeXN/Zn1FRidRozoBtYxODKOBSCaZ+QY5iVlaHIjkysabf8WOyhoQtD6x
         IliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691417423; x=1692022223;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KCn6b8Y4egX4m+kFsKdxSAcYU2iXuIgvgiEXKk/fp/0=;
        b=CcWHgzxr9oIJK/f014GWxbwlnkd3U/DP+7e/IAbvHNh/AHyKrineZpVu0rXgosw+zd
         9hft8tBsr+gjYy0deqLKItl1Z30d64j3P9oD3hUs+zEb5Bt/7KYTQhJgt3kdGnGZjmhA
         5S0WKxu2lQXkMeqdgRY18zokfgNMx9mvmuN1xfawQvvt5VxnzNtJdw+CQvKMyWN6zic8
         3xDOJ3Y811fFKZbrHYNvcN2EkfX068csrinv5jJzpYMaXptOq/WzNNsbqa0xlmPlBIfX
         qQ1YsIyw67thZVv0LAK/9l9gwqDYUbEgMdH/A/pnn2A9HmDAuOGlOYWur/H7VOl2vbO1
         1Tuw==
X-Gm-Message-State: AOJu0Yxn1oJ3Go/VMxO+HezU76SbDj6vILvS/0StDMLMe5pB0PoI6eqX
        q+4iUbcpGWhs27nmkQMFYIc=
X-Google-Smtp-Source: AGHT+IEw8gtJrH4053Gs3+OKrmHzil5bOmEJj/YkwjBnLmacxmd0J61iDfWXdUZu8kKtgbOuH6cghg==
X-Received: by 2002:a2e:8e86:0:b0:2ba:2cf8:9334 with SMTP id z6-20020a2e8e86000000b002ba2cf89334mr3548429ljk.19.1691417423023;
        Mon, 07 Aug 2023 07:10:23 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef09:a500:ffed:38f8:59e7:f38e? (p200300f6ef09a500ffed38f859e7f38e.dip0.t-ipconnect.de. [2003:f6:ef09:a500:ffed:38f8:59e7:f38e])
        by smtp.gmail.com with ESMTPSA id x4-20020a170906804400b00992ed412c74sm5191566ejw.88.2023.08.07.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:10:22 -0700 (PDT)
Message-ID: <068ce8a2f8111ccc4b6374985dde972548741a9a.camel@gmail.com>
Subject: Re: [PATCH v4 0/6] iio: Add buffer write() support
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Aug 2023 16:12:56 +0200
In-Reply-To: <20230807112113.47157-1-paul@crapouillou.net>
References: <20230807112113.47157-1-paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-08-07 at 13:21 +0200, Paul Cercueil wrote:
> [V3 was: "iio: new DMABUF based API, v3"][1]
>=20
> Hi Jonathan,
>=20
> This is a subset of my patchset that introduced a new interface based on
> DMABUF objects [1]. It adds write() support to the IIO buffer
> infrastructure.
>=20
> The reason it is not the full IIO-DMABUF patchset, is because you
> requested performance benchmarks - and our current numbers are barely
> better (~ +10%) than the fileio interface. There is a good reason for
> that: V3 of the patchset switched from having the IIO core creating the
> DMABUFs backed by physically contiguous memory, to having the IIO core
> being a simple DMABUF importer, and having the DMABUFs created
> externally. We now use the udmabuf driver to create those, and they are
> allocated from paged memory. While this works perfectly fine, our
> buffers are now cut in 4 KiB chunks (pages), non-contiguous in memory,
> which causes the DMA hardware to create an IRQ storm, as it raises an
> interrupt after each 4 KiB in the worst case scenario.
>=20
> Anyway, this is not directly a problem of the IIO-DMABUF code - but I
> can't really upstream a shiny new interface that I claim is much faster,
> without giving numbers.
>=20
> So while we fix this (either by updating the DMA IP and driver to
> support scatter-gather, or by hacking something quick to give us
> physically contiguous DMABUFs just for the benchmark), I thought it
> would make sense to upstream the few patches of the V3 patchset that are
> needed for the IIO-DMABUF interface but aren't directly related.
>=20
> As for write() support, Nuno (Cc'd) said he will work on upstreaming the
> DAC counterpart of adc/adi-axi-adc.c in the next few weeks, so there
> will be a user for the buffer write() support. I hope you are okay with
> this - otherwise, we can just wait until this work is done and submit it
> all at once.
>=20

Yeah, I've started that process last week:

https://lore.kernel.org/linux-iio/20230804145342.1600136-1-nuno.sa@analog.c=
om/

the dac counterpart is actually missing in the RFC (as the goal of the RFC =
is
not review those drivers but the framework) but I do state that my plan is =
to
have it in the actual series where I actually mention we would need this wo=
rk
:).

- Nuno S=C3=A1

