Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC90E7DAD0B
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 16:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjJ2PiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 11:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjJ2PiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 11:38:20 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3C5BE
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 08:38:17 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7af20c488so32042467b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698593897; x=1699198697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qT43Nf94mF07rnV7CrLvxuub2Ca7aEi64+U8CyL0b3g=;
        b=elKvagR+t77xfpkmWelkGAt9q/K6/ipzvvpjNMG9HNLEq+AAqckqpJP8yQzR7Sm90U
         6a8Fr9tIpFYT+OecNH1TStn2w8g6nVk4z/63yUxaH8yRoRFafBHqb9Xc5vdKm9lkppmN
         cul1g9JyEMIHlB+PZWhSqGtQTZoljHYl4Rru+MprgmBzrT1b2extbmbodGdnfVaDaqid
         b5n8hhtw/6EdyB+l5XitgNGGC2pREvkBcAhj0eFIhCLjLs0lhLSyHhOSaNLAfVjTkfJt
         7a8XSWMpXnh6BZJQ5k4yoDKq5gr+I8qNatnBw7iXTCcV4vhgxgtQer4YJzDH09g2tcf9
         kftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698593897; x=1699198697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qT43Nf94mF07rnV7CrLvxuub2Ca7aEi64+U8CyL0b3g=;
        b=vW1DpBYA/6Hfm9r+hNvZJGR2CDDRRDP5wpQH7qSW5LsVggcCNY9XUsPhU7Hg241rAd
         b/HllIEkk/d86lsjFwy0p8RMYBscDfXejGUFCmtuenn1WQFO83LIbMp1+XxM0O4TCAKg
         Z2KboLW6Yig9uqKSwADUfYQSKr26+tkbfJxpnHHgdr+4e8WCxdDKt2vYrkztpas0F0j4
         nOUh/b6RJ25QonajKjj2BiMgVw6g5UMzvNC8y2yAOFdtFqGVuvGNTHHIcXlYrW3U4zu/
         oQ2Ny0I3utpzHSbmVIabiVJ2ByZVf4DeRP583ETd+7iHp7WKIYWs/82a9hXsrDvmzRmj
         TteA==
X-Gm-Message-State: AOJu0YyCvgwSooFCYeMqgoKBCP/aY6uWQOxKKpx/ZDLH7jwpbTMynndE
        zaI4QgtJB7CWglA7trVMkk4bOYhqvTsGtbezS5ob8Q==
X-Google-Smtp-Source: AGHT+IG9mfhQQbXcGl8AcijtrKNfwYSt3oDBm67fZGoetZ9+aWcXQ2nRVhfuKvMzIE9tEEvaJNYpsV9CoFfSaSnzLeU=
X-Received: by 2002:a0d:ec47:0:b0:595:9135:83c7 with SMTP id
 r7-20020a0dec47000000b00595913583c7mr7285708ywn.47.1698593896903; Sun, 29 Oct
 2023 08:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org> <95f324af-88de-4692-966f-588287305e09@gmail.com>
In-Reply-To: <95f324af-88de-4692-966f-588287305e09@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 29 Oct 2023 16:38:04 +0100
Message-ID: <CACRpkdbyMEqjW1a9oK-GM2_XL0famH1RgSXW-fQLszn9t9UhWw@mail.gmail.com>
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 11:23=E2=80=AFPM Florian Fainelli <f.fainelli@gmail=
.com> wrote:

> > It turns out that sometimes, but not always, small packets are
> > dropped by the switch for no reason.
>
> And we are positive that the Ethernet MAC is also properly padding
> frames before having them ingress the switch?

I don't fully follow, this code is the one adding the padding isn't it?
Then the result is transmitted to the switch from the ethernet
MAC (drivers/net/ethernet/cortina/gemini.c).

What am I getting wrong here...

> > If we pad the ethernet frames to a minimum of ETH_FRAME_LEN + FCS
> > (1518 bytes) everything starts working fine.
>
> That is quite unprecedented, either the switch is very bogus or there is
> something else we do not fully understand...

The switch is pretty bogus, all documentation we have of it is a vendor
code drop, no data sheet. The format for ingress and egress tags
was discovered using trial-and-error.

Yours,
Linus Walleij
