Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ECE760C27
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjGYHmI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 03:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjGYHlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:41:46 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A610C8;
        Tue, 25 Jul 2023 00:41:31 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-583fe10bb3cso18214837b3.2;
        Tue, 25 Jul 2023 00:41:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270890; x=1690875690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mV4Y61G+p23gRP0f3Y4DyWUGgGHP+04UFPlgKbqr1k8=;
        b=dwZaFdsRXL77sHcd3rHfWM/F9sJrRA0FW5C+fKxZASm+pFn8cBFW5iv31bfuI0lEJx
         nbg/xm3HvN90v0+PNAQCPiQkClhO/9iRZpiMKHZ4hgB6By/3Knb4rOWBjyUZmYIv+6Hg
         miNXG+9RyPd1PG2+ideLPtClon51/ySS27acjphAT66SB+LRxY2HgFBU4YX9jvvHdRO4
         EmEgMhkHaZ97PfmJdDC+6bI9UW09D1xJEHEUETKqKWyx8FO9kFHSuFOR2RXjnlXv3/sm
         9/Bq/BuwPEqL5IJJ11krhcydTaWYLjIrBAwqcXSkNeeh1UvEQDmjBxzFserOE24yNseP
         z0hg==
X-Gm-Message-State: ABy/qLZCzv13ZU7YO3Zt9rZTXwYmECODe5cwiDe0hjVayvFcSRlVmLgu
        dRMYxRSEJbAjoAgKhpHwXU67xGOCl9EQkg==
X-Google-Smtp-Source: APBJJlHG2Chnee9PQ6zka3CfgM3ppHSVUcxXVmEo3UUpRnJCzicg2UndTwdQMlDpsXmL4xmikkEqyA==
X-Received: by 2002:a0d:d491:0:b0:583:af98:6fb3 with SMTP id w139-20020a0dd491000000b00583af986fb3mr6680153ywd.15.1690270890521;
        Tue, 25 Jul 2023 00:41:30 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id e126-20020a0df584000000b005773afca47bsm3379693ywf.27.2023.07.25.00.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 00:41:30 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-57a6df91b1eso63831657b3.1;
        Tue, 25 Jul 2023 00:41:30 -0700 (PDT)
X-Received: by 2002:a0d:ea8c:0:b0:579:e8de:3580 with SMTP id
 t134-20020a0dea8c000000b00579e8de3580mr12966229ywe.9.1690270889959; Tue, 25
 Jul 2023 00:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230717225614.3214179-1-robh@kernel.org>
In-Reply-To: <20230717225614.3214179-1-robh@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 09:41:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXp+AZ2puWEdmPuXc=oa=nQRTF=80y+S8xXo1AF8aso9w@mail.gmail.com>
Message-ID: <CAMuHMdXp+AZ2puWEdmPuXc=oa=nQRTF=80y+S8xXo1AF8aso9w@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: Drop unused includes
To:     Rob Herring <robh@kernel.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 1:00 AM Rob Herring <robh@kernel.org> wrote:
> of_platform.h is not needed, so drop it.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
