Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78207B83B8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjJDPgW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 4 Oct 2023 11:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjJDPgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:36:21 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D842198;
        Wed,  4 Oct 2023 08:36:18 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-59c215f2f4aso27690447b3.1;
        Wed, 04 Oct 2023 08:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696433778; x=1697038578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E1DdlhuqR3JN6uSIXuCO9eqHb8GCx2/yO+mSSn2zYgQ=;
        b=srLs/8yCgUxhMAURFDVfU0+2pRt+lSkNUJ1n7XOhc/YVwU7RX0jq8cU9dz91cLEjZk
         KcVo7mI9JqWmqbv9cB1nWz+blOMBRxc8ayu/qu0EItR44ekBq6bspHT2kXX+2EIxFiaP
         BGZNebQuAUYvtY9fDRxxlUuAyU4KHjWmDhPc5t2+OL1OT0ZJOgYW9fdTWzIbzWfHqYyc
         2C2KLrar8cTtTNfGEEBZQv6aXhVxjmDXEXbzzi1dDK59xWjtkUdjFCmjkXwYpVTNB0/q
         PQHIjjvLOXtRCq2s5MO2TG/Dk/+87AULBP8QLvZC80t6XfGDgNInpOBnA0ElOqWGLz5q
         Jt5g==
X-Gm-Message-State: AOJu0YznlqqFF5sfCuBYbJ69tB7X3IpWcIguqMqHLyMRlgw9K7AR2sJd
        Zy/Nn3nkNOx7we2ZyObT21fzI6bB/zEUuw==
X-Google-Smtp-Source: AGHT+IFJN/pUOe7Ed9W2W6RxupIa7W9uDqUAVG6lZqDx/bM0qOOjQXQX8RRhZoMDk0ZAOWpBMVS1dw==
X-Received: by 2002:a0d:f645:0:b0:59f:761a:fe70 with SMTP id g66-20020a0df645000000b0059f761afe70mr3041092ywf.19.1696433777861;
        Wed, 04 Oct 2023 08:36:17 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id t130-20020a818388000000b0058ddb62f99bsm1235589ywf.38.2023.10.04.08.36.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:36:17 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a24b03e22eso27837227b3.0;
        Wed, 04 Oct 2023 08:36:17 -0700 (PDT)
X-Received: by 2002:a0d:cad2:0:b0:59b:f744:f158 with SMTP id
 m201-20020a0dcad2000000b0059bf744f158mr3013260ywd.15.1696433777258; Wed, 04
 Oct 2023 08:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231002165957.11388-1-wsa+renesas@sang-engineering.com>
 <CAMuHMdU+1ox_6e65YQ0bCQMbqtWkYzsE2S88-En7OnYvomfJ2Q@mail.gmail.com> <ZR2DQYvwTbADM0zX@ninjato>
In-Reply-To: <ZR2DQYvwTbADM0zX@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Oct 2023 17:36:06 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW7xYh7EFczC3OBFDCRCa5OhW50iLhC2f3p00goetoTHQ@mail.gmail.com>
Message-ID: <CAMuHMdW7xYh7EFczC3OBFDCRCa5OhW50iLhC2f3p00goetoTHQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r8a77990: document Ebisu-4D support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Wed, Oct 4, 2023 at 5:22 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > Ebisu-4D has a different part number: RTP0RC77990SEB0020S.
>
> Oh, then the elinux wiki entry is at least vague [1]. I checked against
> it and it says "This is the Wiki for the Renesas Ebisu (Ebisu-4D,
> RTP0RC77990SEB0010S) board," which I read that the the 4D is 10S.

Yesterday, I checked the schematics.
I guess I created the wiki page based on the DT bindings doc.

> But I'll fix according to your information.

Thanks!

> [1] https://elinux.org/R-Car/Boards/Ebisu

I updated the wiki page.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
