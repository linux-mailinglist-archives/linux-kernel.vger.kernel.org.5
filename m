Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD947AAA63
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjIVHgs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Sep 2023 03:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjIVHgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:36:45 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4406CA;
        Fri, 22 Sep 2023 00:36:34 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-502e7d66c1eso3012672e87.1;
        Fri, 22 Sep 2023 00:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695368192; x=1695972992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQ5IUNNW5XM0w46Ddjoo+5lCOw4ZdTJm+91GIKNdxYo=;
        b=F8nI8370Qbux1ph7sbr5r0aQYJuqXCMhEIb26wdZPG6pnBAvL9S0Xqou6xw02cVeng
         NJBIpR/BOKx29AzX0sjPoXuHzz3l86O//g08fTX5Cq8qni5N4DpmfEwwHUyt0xY5XgdL
         pkjWjl/hRCWkLH78xBhAh2U+6c69Cbd5X9QqMRIhYfOgkQV89hZk4X199xgn4bPM0vsw
         oSJLfl+WFgebinanLtDSebg1Rw89JFgQi+xUre0atBUiIg6+cn+2tPEI615mC7TqhnSK
         dEj3xkeCaNtA6Olh44CRSLUaHT5vls3YWsLs8ValGyA47egCRW2jkNFBEIfxiToyQM5t
         Uhwg==
X-Gm-Message-State: AOJu0YxtZWlnepVkTojYF1iWHeZE4hbx+37UnDJrncUvk1jBWHRpqnc4
        +mMPzU8TWYa/MadbXwZL/nshonE7AxyuodfY
X-Google-Smtp-Source: AGHT+IE25bTwJIqMhBCVIBuA0pFEOwWoOS9O8hgHB2uNKuf1U5opnOaqgPaBCy0Gjrw5QijKLNEFtQ==
X-Received: by 2002:a05:6512:547:b0:502:ab7b:e477 with SMTP id h7-20020a056512054700b00502ab7be477mr6176358lfl.53.1695368192210;
        Fri, 22 Sep 2023 00:36:32 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id l8-20020ac25548000000b004fe2f085d5csm619954lfk.299.2023.09.22.00.36.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 00:36:31 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c008d8fd07so30451541fa.1;
        Fri, 22 Sep 2023 00:36:31 -0700 (PDT)
X-Received: by 2002:a2e:7808:0:b0:2bc:b6a3:5a9 with SMTP id
 t8-20020a2e7808000000b002bcb6a305a9mr6713573ljc.37.1695368191602; Fri, 22 Sep
 2023 00:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230921132823.5723-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230921132823.5723-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Sep 2023 09:36:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWwnGNL-Jr+c=7z0cPiddF05MgFSKFVHSdVvjT_aKkKNA@mail.gmail.com>
Message-ID: <CAMuHMdWwnGNL-Jr+c=7z0cPiddF05MgFSKFVHSdVvjT_aKkKNA@mail.gmail.com>
Subject: Re: [PATCH v2] drm: renesas: rcar-du: use proper naming for R-Car
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Sep 22, 2023 at 2:58 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Not RCAR, but R-Car.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
>
> Changes since v1:
> * rebased to 6.6-rc2
> * added tag from Kieran (Thanks!)

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
