Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2A37AD744
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjIYLwA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 07:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjIYLv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:51:59 -0400
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3252E8;
        Mon, 25 Sep 2023 04:51:51 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d849df4f1ffso7244514276.0;
        Mon, 25 Sep 2023 04:51:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695642711; x=1696247511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbGjQ4X7/uITZ81FT1dF6rZOUZ4OOwjhyRuCcUqlCUY=;
        b=dbpnGAGrhQJfFnsuKhraMDrmWFvUdybhLLsvnhFmrvh2lhdl5pQ03pDWnEgNwjuMsS
         eLjlMvxRcJDFmpn0OZAmz0nF1Miw2E5gRo7hcr/IC9q5uJ1yjMe9fL70j4VgzpV864dH
         zFOteab3i5rHPnMbu8hfD2BjwwvUsG2dVGmmbnwRkb2l7/JakE0wouE9/i1UCGlPuLDb
         99eP1hyGwuZiqdM3gzAGBNDQHh5VHobo944YZqjxPTjtIRDI90oWhY+ByS9CpnCi5zRv
         z1fzJBOtEkHbcBvLCPhShiDv6Slekp0b4fdDpH+Dl7IN8u54C4de31mZXuAlpGIUL2Dw
         f2ng==
X-Gm-Message-State: AOJu0Yx1G8srQ7iTWKvDdZ0dnIVwjTV4pV9ZUqwlyA/cCy+nGLNnio2f
        gd2uiMlx1tZQcQw4hD2SXXevmpmFkqhjrA==
X-Google-Smtp-Source: AGHT+IEMUEbQTuY6uLEArgpqWzlZtHJUaIxWqsBqfse7wuOX/YSdsWcbb9APNLHDsOUekiJEoEq6hw==
X-Received: by 2002:a25:ac97:0:b0:d89:47d6:b4f9 with SMTP id x23-20020a25ac97000000b00d8947d6b4f9mr333157ybi.23.1695642710942;
        Mon, 25 Sep 2023 04:51:50 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id p10-20020a259e8a000000b00d677aec54ffsm2048499ybq.60.2023.09.25.04.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 04:51:50 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59f6441215dso30304137b3.2;
        Mon, 25 Sep 2023 04:51:50 -0700 (PDT)
X-Received: by 2002:a81:6d04:0:b0:576:7dfc:e73e with SMTP id
 i4-20020a816d04000000b005767dfce73emr6627907ywc.32.1695642709821; Mon, 25 Sep
 2023 04:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230922063642.4120-1-wsa+renesas@sang-engineering.com> <20230922063642.4120-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230922063642.4120-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Sep 2023 13:51:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUErS2DB+50YRRHGRv1a_LFnA1Ar6Y8bJogUqCxC16n8w@mail.gmail.com>
Message-ID: <CAMuHMdUErS2DB+50YRRHGRv1a_LFnA1Ar6Y8bJogUqCxC16n8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: core: remove cruft from uapi header
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:48 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Remove the GPL boilerplate since we have a valid SPDX entry. Also,
> remove the outdated filename from the comment.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
