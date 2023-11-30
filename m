Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101607FFFBF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 00:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377334AbjK3Xyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 18:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377294AbjK3Xys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 18:54:48 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A18910E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:54:52 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c9c581596eso15792861fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 15:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701388491; x=1701993291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGO8mAdrAqhDRxrlrd1/sOrvK17UXFpdyDtQDEFr48s=;
        b=P0w3vrmZ/OBgZk9VnvkxG4/ZliZvrM8ERpyZfmVJKGBmM0tfKXgDxFmE5gH8Ht22Id
         S3vGIHzsLFBxxfAuzBPmoPiSJN6XutpKQFsSnFA8F/TJLS8HKVFcQ+ObIOUlA7g2jaPs
         MKEt2e59vzN9ezXrHBIXIz3PHN9rxLxs2wsxaZP4fXlpqv/PYHvOm+crQe5Y9wxQoFrd
         Juyf3ayyw1z/ZgcXRTa2meWQPqkjrcgQbcMhIrz/vm4pBAL7yFlPy/V+Ae1rcJERCia6
         mDSxhFMmCL5O+b1Ml3PfpzqgdGhEM9S0W+yiIMIZRHCRwCIg188JRqibz4A78+t2YG8H
         +oUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701388491; x=1701993291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGO8mAdrAqhDRxrlrd1/sOrvK17UXFpdyDtQDEFr48s=;
        b=UpUBdATQrta3T6XJM75OUuTERjJ52nB3WyB40/bDJp2nIcQ+CPwR1nnehKH7l8Utzl
         SDVmSFLMw6kqrxSbqNRcTHVn9FCsi6Igc989bQnmPI7Cf5wpbYPm3OYsMgu5YeML7SVc
         IaYQLMKk74BOphHtWrNTnOxZCZevDyEaNHH9d0zDN/vdN1gbI/5qjaBoAswchYJ6mRrJ
         /3RxqLnvSf2noAahG55Isb2Ncd1fHqeJIGZT/TL6oVf14NoL1x5BsmbusrmCacyv5iYJ
         2NOWOGBkZriGNsch0KFbLiswpzRwE0bncZBmReNrTRp6H2qEOabjg4huhpRWhm/hktJ9
         hoCQ==
X-Gm-Message-State: AOJu0Yzguv7iC/MdMaaSwCT7oKBT+1DtmpLlBPrLMprTS+bQY0IzZ8Wm
        0jfmLQUtuGf7TJS0gbXkBw+k/Npxew4ypcsYj7XyOA==
X-Google-Smtp-Source: AGHT+IEDwWrg5ORWAu7cojx2auj03EsJ4gxI7RF6HouCxhjtKTlwjmweO6WdaOgqE9ObA1y9cBqoCf7+CnqtwPLTmwg=
X-Received: by 2002:a2e:5cc4:0:b0:2c9:c50c:a9c1 with SMTP id
 q187-20020a2e5cc4000000b002c9c50ca9c1mr203763ljb.6.1701388490692; Thu, 30 Nov
 2023 15:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
In-Reply-To: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
From:   David Lechner <dlechner@baylibre.com>
Date:   Thu, 30 Nov 2023 17:54:39 -0600
Message-ID: <CAMknhBH0pF_+z_JqWGscELBmAEDyxLAtgQ-j3=6P2MeFXnzhWQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] iio: add new backend framework
To:     nuno.sa@analog.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
<devnull+nuno.sa.analog.com@kernel.org> wrote:
>
> Hi all,
>
> This is a Framework to handle complex IIO aggregate devices.
>
> The typical architecture is to have one device as the frontend device whi=
ch
> can be "linked" against one or multiple backend devices. All the IIO and
> userspace interface is expected to be registers/managed by the frontend
> device which will callback into the backends when needed (to get/set
> some configuration that it does not directly control).
>
> The basic framework interface is pretty simple:
>  - Backends should register themselves with @devm_iio_backend_register()
>  - Frontend devices should get backends with @devm_iio_backend_get()
>
> (typical provider - consumer stuff)
>

The "typical provider - consumer stuff" seems pretty straight forward
for finding and connecting two different devices, but the definition
of what is a frontend and what is a backend seems a bit nebulous. It
would be nice to seem some example devicetree to be able to get a
better picture of how this will be used in practices (links to the the
hardware docs for those examples would be nice too).

In addition to the backend ops given in this series, what are some
other expected ops that could be added in the future? Do we need some
kind of spec to say "I need a backend with feature X and feature Y" or
"I need a backend with compatible string" rather than just "I need a
generic backend"?
