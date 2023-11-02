Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDCE7DF73F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 16:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377037AbjKBP7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 11:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbjKBP7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 11:59:31 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44B186;
        Thu,  2 Nov 2023 08:59:28 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id 71dfb90a1353d-4a06fb5331bso441548e0c.0;
        Thu, 02 Nov 2023 08:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698940767; x=1699545567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ue1VCsQrNTh0wkOE8vbEkaeSz118eW1UHQHVP368AaU=;
        b=mWIDghuztTAfEIgvlfE+ZZa0r03pvnabWAexRQy8OZdycWjgXy+s6g9rC9xUSiLAxq
         MctJ60EBdVDzYv9L2O5Qa6Et6JLZH8CZu3OEd3/zLlJIhP8kffF5bquYJoDBzpwVNCWX
         oonAtzjADYMDnhQ1OQSpPcOzq6+BucC+eb815j8Sy5bqg+ZTkTv3jqPBN4ih2oiZCyOW
         MdkxnnjIl4MrDcBAy0JUHdjqUKRApL+2q+kVKJSB/xte8FbnPbn8gtFUytJ9wtgEyjVb
         h4wmSSLB05c72gGMXOTL2gK45Y1oyoRmFRs5faHYzOCeoKiGb1byP5SP7NOS9dvvFIdt
         P5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698940767; x=1699545567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ue1VCsQrNTh0wkOE8vbEkaeSz118eW1UHQHVP368AaU=;
        b=lWCq8mUD52ivdcdtREzVoYS6ApmUbqXoEl1Wlkb4kceckidKIYKAp4NMceHTA1DuZY
         pej1TzrWK30V5RemzpD3PfjyXqSFusOfjx67uv0C+x+PYWLzkDgeCIL8oLt1Wep+8X5s
         aNydSC/caJVCv3K4TV00bmT/zxtzZZ/c2neR7eou7EINVg+EC+OKI71xCpSdiI1dS40d
         frSqPTR3Mi5hlU7jbMGl2a7IYtHlGiSx7oyiP+gMtEHGuyyKXaHJVXWrhDHaonfhthgZ
         zSHd0/rYPnWgRXRSKBXcwz38AqsnXhuxrZM1LSeq6t1iVg61sLCSuHASSJBOiu5P9lLH
         YdIQ==
X-Gm-Message-State: AOJu0Yx2GE2b+2FyYheCIFEy9cTodsRjqAdu2orueoueUu0UpMvQZqHH
        SLV9SPvYdtHY1IVxw9daiqNrqpfg+DpicRL0HKs=
X-Google-Smtp-Source: AGHT+IFhOihPPYm9P+n6xwu60HTpRDKAlswLpn32NJkPK2X7ib6nd33g8JbItc/iaOQWVypSic8FuXMd9JPDNVFJf8Y=
X-Received: by 2002:a1f:1993:0:b0:495:c10c:ec39 with SMTP id
 141-20020a1f1993000000b00495c10cec39mr17936350vkz.2.1698940767544; Thu, 02
 Nov 2023 08:59:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231102101357.977886-1-eblanc@baylibre.com>
In-Reply-To: <20231102101357.977886-1-eblanc@baylibre.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 2 Nov 2023 17:58:50 +0200
Message-ID: <CAHp75VdG4jX=RWusOfVBscMxims0PDr9tumrZXufy9sTgfgPmA@mail.gmail.com>
Subject: Re: [PATCH v8] pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs
To:     Esteban Blanc <eblanc@baylibre.com>
Cc:     linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com, u-kumar1@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 12:13=E2=80=AFPM Esteban Blanc <eblanc@baylibre.com>=
 wrote:

> Notes:
>     This patch was picked from a series since there is no dependency betw=
een
>     the two patches.

If there are no changes, no need to resend. The b4 tool can pick up
selected patches from the series.
It will reduce a gigantic traffic on LKML and other related mailing
lists and save a lot of resources.

--=20
With Best Regards,
Andy Shevchenko
