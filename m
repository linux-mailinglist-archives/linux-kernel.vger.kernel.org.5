Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9097D73E2
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjJYTG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjJYTG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:06:58 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8ED123
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:06:56 -0700 (PDT)
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 00BF83FD3A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1698260813;
        bh=BdwZ3eVaAqHpyQJjNHLInPz7RJuDJsJpeXFXoSIUzNI=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=cpNCSSu13IhcFmLCyXVWkbQ0zTdnoKIknvRn/Hs2mxCdzVZc6hqLlAJ4POAqZQ0Pl
         wiQA4ARrWfUJGKwSNUHwHQoJBef5sJp0F0g8DG4Ha6qhX60jYC/v0twbqxycZgD3Lx
         g98FdLITrBEmdEi0njQ+XbFpGVjjo3+m6+/WQvUNuSEj8vn6IvX6S6R3uSXsm3aGau
         00jn/WFnVLOCRAA14yfhcMxcvfqDuZo8/5TYX2G0PTkV75e9BcLwpNS5a1WthFm4oU
         OyPsJuGodM8t15ONjv7Ub9d573s0Tz0EGX+hDNMcvHGXZETRYM/6EYjnsKBO0q8S4C
         /akqL7W5+7fRQ==
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-66d0ceb78cbso1311746d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 12:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698260811; x=1698865611;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BdwZ3eVaAqHpyQJjNHLInPz7RJuDJsJpeXFXoSIUzNI=;
        b=BnnCMflqeI+ZwfVvgUrbZyZrAOGxSR3Q5lvFTNKcu3Kd6omKgyimUAoFib9tW+C4si
         NLKmLlZnHAYKsjE/sDYRp/nPLhDeoYFav+pTAyQ+tV1rgy3WaypKkWF2wzRsrSJG0skl
         2X8meYuF+oqa9Vi+JYLP7wUtIUbWf3RDEmEehRnIZ7JhsW8KAWaUFiNC3hQIzq4ZGwLx
         TnPOMG8sVuuvIHagyGBUi5jbrevq9EfzzGNP0EaVF2I6tUjx2jSvL17x9X96X/HaaDp2
         3/Nq/Jr1RPbCC9cLL+z/WKNk4hohbWOMj0RvAmhF/o6l9g5GbqPvhGC1edcTS555Mz7m
         gkHg==
X-Gm-Message-State: AOJu0YyBfXnlesOoGDUiIK4cs1qN3XZpf1/nYhlKcqXrBdn+2dSMD1Kt
        MEgu4fJMsqFwzMJVDp2Bsn2HBlF8soSh6urrRIH+0bml5YXWr1ObIxa7cRIW//x1BLn4/8eh284
        +4FCmeXEMnfqT/4+Rty76/wGonP3f8cYJBcyocL0WBTmHLgSMeg43+63UVg==
X-Received: by 2002:a05:6214:ccd:b0:66d:33d2:4ffd with SMTP id 13-20020a0562140ccd00b0066d33d24ffdmr17139783qvx.59.1698260811369;
        Wed, 25 Oct 2023 12:06:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLO2gfkUwl69w4gSQFYMDMCqyB9EPF4PqKeayY3C56ZJH5AQz9536l4Lwjl6PXc74ecKD4x2ISGpNHCPe8LNQ=
X-Received: by 2002:a05:6214:ccd:b0:66d:33d2:4ffd with SMTP id
 13-20020a0562140ccd00b0066d33d24ffdmr17139769qvx.59.1698260811144; Wed, 25
 Oct 2023 12:06:51 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 25 Oct 2023 12:06:50 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAJM55Z_pdoGxRXbmBgJ5GbVWyeM1N6+LHihbNdT26Oo_qA5VYA@mail.gmail.com>
References: <CAJM55Z_pdoGxRXbmBgJ5GbVWyeM1N6+LHihbNdT26Oo_qA5VYA@mail.gmail.com>
Mime-Version: 1.0
Date:   Wed, 25 Oct 2023 12:06:50 -0700
Message-ID: <CAJM55Z9gy4RFXqu8n5jtW4k2gwDtpJDkevdLht9rMyL=464AMg@mail.gmail.com>
Subject: Re: [PATCH 0/4] soc: sifive: ccache: Add StarFive JH7100 support
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emil Renner Berthing wrote:
> This series adds support for the StarFive JH7100 SoC to the SiFive cache
> controller driver. The JH7100 was a "development version" of the JH7110
> used on the BeagleV Starlight and VisionFive V1 boards.  It has
> non-coherent peripheral DMAs but was designed before the standard RISC-V
> Zicbom extension, so it neeeds support in this driver for non-standard
> cache management.

Ugh, sorry about the broken threading and From vs. Signed-off-by's.
Will fix in v2.

/Emil
