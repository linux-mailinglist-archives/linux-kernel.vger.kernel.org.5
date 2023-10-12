Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C607C631C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376758AbjJLCxS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 22:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjJLCxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:53:17 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02C394;
        Wed, 11 Oct 2023 19:53:15 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-45766b79b14so237853137.1;
        Wed, 11 Oct 2023 19:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697079194; x=1697683994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o63NRkqQgQp5HjyonmkoKn7I3h3Gg+fPv/gJKTSgwVQ=;
        b=UxOZl3VgRY2S+Cn9X8YH1hvj9Dvpfgvkl4VAmUPy7r2ISQJYldXh4alAUmzV3X2oJl
         Mc09jz7JyEIIFHb81MdfOGkYWMFJT3gLZUZtUq59oqyFDEeSV0Y3WtRtfEuUMv9W8Gx7
         5p8sNfnqVuHYhau4U3V5xQX8LSd+IKCecl1Xj2ToG0HkzyS9G1Q2FU9aeN6WVNinfkfR
         sp3HPvfLxCaNSAFk5WhWVuyfCrqO9JrHCvt/Ibo3jJqSgqfrRp7hQciLSiuXJ+bgVIhy
         sAg7H6QC3X9mNB0ESGWNKSbZyB4Yew2Q5Mr+4URdSMEApVyTY5u4h1LD2zQPMcGW8qnb
         qUfA==
X-Gm-Message-State: AOJu0YzTztolmaTxR32ert+HWnAurCmsHbLn/NcYv+70I+ixjC5tbZmo
        f3Cu4DUyT5KcPOZdxmXjHDx9OQ+h1BVBIg==
X-Google-Smtp-Source: AGHT+IHv1buOjvz0r6ctqRQNT7gd9NiM+jsjWI/ZQMC6NxZvQGiRfQgNOMlghlFsjh4s0O1KF9UWWw==
X-Received: by 2002:a05:6102:2d03:b0:457:6858:af77 with SMTP id ih3-20020a0561022d0300b004576858af77mr13540487vsb.26.1697079194582;
        Wed, 11 Oct 2023 19:53:14 -0700 (PDT)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com. [209.85.214.182])
        by smtp.gmail.com with ESMTPSA id g25-20020aa78759000000b006934704bf56sm10832893pfo.64.2023.10.11.19.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 19:53:14 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1c5bf7871dcso4360215ad.1;
        Wed, 11 Oct 2023 19:53:13 -0700 (PDT)
X-Received: by 2002:a17:90b:ed7:b0:268:7ec:51ae with SMTP id
 gz23-20020a17090b0ed700b0026807ec51aemr19828705pjb.41.1697079193746; Wed, 11
 Oct 2023 19:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230911171407.1572030-1-jernej.skrabec@gmail.com>
In-Reply-To: <20230911171407.1572030-1-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Oct 2023 19:53:04 -0700
X-Gmail-Original-Message-ID: <CAGb2v65BnLK2PWh_vnntCtQhCMrAu6segShTFzrfnZMp+VV5+Q@mail.gmail.com>
Message-ID: <CAGb2v65BnLK2PWh_vnntCtQhCMrAu6segShTFzrfnZMp+VV5+Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i-r40: Add interconnect to video-codec
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, samuel@sholland.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 10:14 AM Jernej Skrabec
<jernej.skrabec@gmail.com> wrote:
>
> Video codec needs interconnect, so driver knows that it needs to adjust
> DMA addresses.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
