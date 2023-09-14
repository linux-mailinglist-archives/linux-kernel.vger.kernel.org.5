Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD079F96F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 06:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjINELE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 00:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbjINELC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 00:11:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C417F0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:10:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9a9d6b98845so365772866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 21:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dowhile0-org.20230601.gappssmtp.com; s=20230601; t=1694664656; x=1695269456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aufe5J8vU+SctNgmT1W1/mq3RGiP8XjApWBecp6gONY=;
        b=ImRwRd6b/zFAX4YmIppIskNk6Jwzcmx7YL+FTacGwAvYnCrNJRX0yKmaMhmCZ2B+nQ
         Z0hvQnKO/+d4R+T5zPDCzXqVijeV7lPjUgT52LPLoIEwcXwjWICndpZmo5cvepOghKRu
         nMrMH4br6I+JX4xqkTFJnVA1TjYa1dpF9ciPzEh2VeWKVM67h5b/yXRUyCFgFSqpfeqy
         hIfcXxm4uHBwfR0pvgeyucgUAnzPeek4IwHtIobEoYl4JH+ZPOQkqfqMTBw/z3TWG1N2
         Omb/f1GYTAHZENLFi8VnpUx4o5RRa93XM5gAqLk8mK835rPdoZLhLLtCsWvcXVxYg+xY
         evyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694664656; x=1695269456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aufe5J8vU+SctNgmT1W1/mq3RGiP8XjApWBecp6gONY=;
        b=uxZd/0ALCBKhI+L27VGGW5va2dM5O29dh4u3EO8eZwNq5NDREyoGdfFcLk4lgenVfM
         ifp1T+RhqiW9DSztuSdPoWd2cf+WV4/MplbNsiaBXf2j5M0UuBqn+0OxJESEpUmRx2fI
         oRDbQb3eV69jeez5qz7c+NevkweJ3Pb+bBGRyGKKwr4mAMLQL/yyV/eFCfdXfybAGFqg
         3lUSI/2lP44DHkrBvHI79WmNSBAej1lFWf7zT7InL6sdNkl7L62d01H1bBRA9tyaGxSn
         UaFYpIvCj88rUYdDU5tIsLQmQkDMlT8U/dem3p14T0lbRdWuo5T0clh29fVnGGwfYX8p
         Ik7w==
X-Gm-Message-State: AOJu0Yx1L3/RGLR+fcItYaeIKHWmwdjWJyHjYYWi0fxvHzlEg0TrQzPZ
        7Zt8Prrz/aNW+HbHZIECBRlN6rEvMUiOliJ/NPXcOg==
X-Google-Smtp-Source: AGHT+IFtsvUmPS4Noz40u6zbY6fpqmr+96j8eujD/00V5cBzXdC4gU7MPilZUrybMC4DFXO6Yn+sO+DlY8NEeebB66I=
X-Received: by 2002:a17:906:5399:b0:9a1:b528:d0f6 with SMTP id
 g25-20020a170906539900b009a1b528d0f6mr839462ejo.27.1694664655307; Wed, 13 Sep
 2023 21:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230913-submitting-patches-delay-v1-1-a2d48c5ca205@kernel.org>
In-Reply-To: <20230913-submitting-patches-delay-v1-1-a2d48c5ca205@kernel.org>
From:   Javier Martinez Canillas <javier@dowhile0.org>
Date:   Thu, 14 Sep 2023 06:10:43 +0200
Message-ID: <CABxcv==jJvujerZNmN8PXF1-YYXy4Ra1WAHcmX4YUJRbRPUPzw@mail.gmail.com>
Subject: Re: [PATCH] docs: submitting-patches: Suggest a longer expected time
 for responses
To:     Mark Brown <broonie@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Wed, Sep 13, 2023 at 4:57=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> While some subsystems do typically have very fast turnaround times on
> review this is far from standard over the kernel and is likely to set
> unrealistic expectations for submitters.  Tell submitters to expect 2-3
> weeks instead, this will cover more of the kernel.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Mark Brown <broonie@kernel.org>
>

Agreed that 2-3 weeks is more realistic.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
