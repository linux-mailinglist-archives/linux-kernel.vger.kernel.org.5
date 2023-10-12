Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8D37C79EB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 00:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443006AbjJLWoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 18:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442995AbjJLWoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 18:44:32 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6C9CA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:44:29 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7b3d33663so20122767b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 15:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697150669; x=1697755469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThC9OBSQAxx9CbrpHWBQ0zkJROVRC61V38/nSgp5HoM=;
        b=b4G7xYBcuAkydWP3BszZyI+okskeDTUYbtU+UJfHytPXM5YFGoED5frmauZsuzBDIc
         IVZM2bhe8DLMF/k4K6pr9ss1D8T1AFKrNt1cO2Qt8zMtNkD4n+pmecR/7/sWsvhlTQoE
         6vnrUJvlKCs2jPiiiLoX+EevPtbcO9wQb0rUSCxSqqOOBhjJBoIAf3yjPoU3BYlafskM
         JcRR4O1WCqUq7r7WD+uP5RMJIUf5rrgGyyBZYdLr2dhzPlw2SJu7I+etnrwcN1Zy289u
         r06caP8tf3NVzsuFFytWqkCoRMRrGP101mlwVzqZUsRqYq472Z6pCVV1vinorI1zxqsi
         OJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697150669; x=1697755469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThC9OBSQAxx9CbrpHWBQ0zkJROVRC61V38/nSgp5HoM=;
        b=QFvBGBmJ1JwmjeiDkV2o1f1DADYiej11FJYZyh6SXHIfntFiq4Z5vprWUaJDodeh6C
         jDclYGpF9vhcIGGdT9cbFCDrj1bTDT/PHIbRcr8sasUHY6FThtmmsyOm+FuoEadm+mKl
         MPcutwcpixfhhUitc9ZgU+PB0g22XZzs+qx/pZdSmjIpfKQ707qbWMoJdYCLJEOGnLfw
         WhcMjKtRmSO3G7p5+Oy/Q3dMpFJrkoIbT2EwuHWK0IT3gq5ZfN6yoVu3bDtnpeI6JTtt
         uo0ev5+VEkaT3tl/IwO5II4DnVlVDPftO4lUFX5fSMjOiWmH5bGtTydzYqidcupiEt+m
         vzrg==
X-Gm-Message-State: AOJu0YwApcK7VtuUHB8mGOmH9JjxLyFUnlcDpHKaPd98ijMJIZWe3CsN
        yLy0J82Aw0OebZ8COnno59xuZ1oNW7CsMK8lB7WDZ6ec/FLJStqn
X-Google-Smtp-Source: AGHT+IH28qIQJWQrhAr6utmKMWPnLFiLOt7veOPWa1C8KhQ+A8TdpwSWV8WYcTU4eXA5QFl9kVqoXypx2BgQKOmpMqA=
X-Received: by 2002:a05:690c:f0e:b0:5a8:1d0e:ca6 with SMTP id
 dc14-20020a05690c0f0e00b005a81d0e0ca6mr133714ywb.32.1697150668972; Thu, 12
 Oct 2023 15:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231013091831.60a032c2@canb.auug.org.au>
In-Reply-To: <20231013091831.60a032c2@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 13 Oct 2023 00:44:17 +0200
Message-ID: <CACRpkdaEVUfFg-O53NBiyWPsjx0VZVMKK7o2ikUMSCy0_AJUGQ@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 12:18=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:

> The following commit is also in Linus Torvalds' tree as a different commi=
t
> (but the same patch):
>
>   73394a1b2194 ("pinctrl: renesas: rzn1: Enable missing PINMUX")
>
> This is commit
>
>   f055ff23c331 ("pinctrl: renesas: rzn1: Enable missing PINMUX")
>
> in Linus' tree.

I had to fix up the commit message, sorry, I'll rebuild my branch for -next=
.

Yours,
Linus Walleij
