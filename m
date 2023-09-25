Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D617ADD48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjIYQha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIYQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:37:27 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36AAFB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:37:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso864393866b.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1695659839; x=1696264639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XCsL9O31+ub/w4O62oibz3JG1gJ1/+3uXSRPucbY31Q=;
        b=2bFGR/ZzSaMRUjaxM3RDBLphP/E8ulHXAamdNO++LPR88owcCykCiS19rgMKY7KdJP
         ttTI73pR51KINBS4XAOdLyXuCvL4dOzHaTnlqgV84kQouIaTQoZYQW8Ph8CYpcDuncsA
         0yHpabZQ5jiIK/230t47ZEjzEX98sZjrYic8peWwFc2W+K3SXe+zM0eCFHfJ6egX9RrT
         9qy8MHVeNJ3b68lIrVXL3r5TkMaUTfdVfYZ+lrhJ1lpvF2tNkMkCJsd0E7hZycvEygSB
         NmLweh1GKRuNIkoJN7QsSseL3Q70dJ+sji+RDvgU6v8fu7SnN5JkZlY2k+rKtH2Sa6nb
         vImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695659839; x=1696264639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XCsL9O31+ub/w4O62oibz3JG1gJ1/+3uXSRPucbY31Q=;
        b=euG7+29YzDQL4wX1CzQ4HGiQTUhzcyeo038jrKYl8Y2JEIRJHKvUsRRgzPc6CL/erY
         Y7GMBJd0Gpf2f1HzUbeHU4Z8gW+9McsuimKJjxfLU3Kesq3XXD/JJdjx/s5Ixeniz2vF
         9TR87wzjnLorsy/hg3B1pYWj7v9hgWFcasN7/ttyQ5YNe9BK3Wij2WPW6iDdRt7KL2Wl
         FviKgy1lP+SvINw4err8ODfpSm2gfDncpd2P8nlueycpHO60T4k1RT0rsTWz0i2vfXD3
         byrHlaOPJJkUangaG+DrKj8whNKms0QijvrmQnZBisuTlcR8oebTEp+jSOByoIuCRDPN
         l2AQ==
X-Gm-Message-State: AOJu0YyfPq2u2PtaH8qXn/e9mU6O6JXGcaHCqRI/o1l+GTWehU9lTkgc
        VbM/84JB2bo2i0P0oT/49UzdvDcYzUP+ZnwNcS6jdw==
X-Google-Smtp-Source: AGHT+IFD7lzXMvCXQOFmekS6RNokyWqG7NHLM0il8mO+/QOBoiAPubZ810+kAeu1PedLTs6VzXhNk88WVq2e3EOI64o=
X-Received: by 2002:a17:906:c14f:b0:9ad:a4bd:dc67 with SMTP id
 dp15-20020a170906c14f00b009ada4bddc67mr9258502ejc.50.1695659839417; Mon, 25
 Sep 2023 09:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230921144400.62380-1-dlechner@baylibre.com> <20230921144400.62380-10-dlechner@baylibre.com>
 <20230924185902.579a444b@jic23-huawei>
In-Reply-To: <20230924185902.579a444b@jic23-huawei>
From:   David Lechner <dlechner@baylibre.com>
Date:   Mon, 25 Sep 2023 11:37:08 -0500
Message-ID: <CAMknhBEsiaSu87Xi1J4BZHrrz4wOovHUVCJz1BgcG00LGJk+gw@mail.gmail.com>
Subject: Re: [PATCH v2 09/19] staging: iio: resolver: ad2s1210: use regmap for
 config registers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -     if (ret & AD2S1210_MSB_IS_HIGH) {
> I guess this was meant to be a sanity check on the chip responding.
>
> > -             ret = -EIO;
> > -             goto error_ret;
> > -     }
> > -

Yes, according to the data sheet, if this bit is set, it means there was a
configuration parity error. This test has been moved to the
ad2s1210_regmap_reg_read() function.
