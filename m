Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC43879B922
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355355AbjIKV55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjIKIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:49:57 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A624C1A1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:49:53 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d7cbcfdf137so3610423276.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694422193; x=1695026993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1XeVTw6l9wEw/TS4Pji090kAEBOAUIe1JhBKyS65/GM=;
        b=WAEgihlJWBXiKO4E9FJQd/opFTODCuvfqZwsk95t66AAG5UTQH14iOItVj1gSd4/fH
         i8wRJIUALpWNmrI2Vs9eaJuwZYHACV3YzMyys+0EMVqBcfgRKARCRw9cLOxcBaP9tqH9
         p+wwVwQgJ3LNECtByxxVWZZDaTmLNdyGReIrDHiadQTdxkmfvRqGLEyjBiqKarLZ1t5L
         oQfR/gTUnJvz5/5Kt8SCuz9lQZ1z/TNbwbKcaXQq5i3bwuAW10sJMaS4NKUQAhWOi6gf
         q+JdWkNxX84MAwV6DZjdikzIdniOXDFP8xGVEO9kXI+1euKRQyHBGCaQ/pt+T7gkpOxv
         gBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694422193; x=1695026993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1XeVTw6l9wEw/TS4Pji090kAEBOAUIe1JhBKyS65/GM=;
        b=Q0tGlw5bbzwwnedW+bXtNif8dnys8h+mk41nS0eK9QNnXT68S8c1rN6EoZnAzjKMgr
         G2jmuxCHfFzMiNgfy05ZpCtZYCW6WqCpo+90NRIqHmt3MyKpZxwb31ltVzjg95+Jc3RA
         jeluCBkClHiBlLmlwAo4NUZw0AtpJindwO+BJD1fHlk942Fp2Ix+k3PTv/Ad5r3spVlM
         /IACR3BugIPuH+PN9Ti/g0wwQNIE6TMK/R+DITeEnEvp17SZgioX/l9s3UBUGUecjb2b
         yA+a5HRda/cwHsOFVKrE+Vn2fNGDGrwyz2648Obyjy6aYvIy3BGR8ZVDdcHhqeqAzoE2
         HmLg==
X-Gm-Message-State: AOJu0YzFI6I/ozpCABX3u6H4hJk7tLpU4wVmlVB1ceJ4IgzNmoL3csZ8
        egQKUN1nbDFmnRLm/HCSYSKvQLn0EHvl3rF8qZyFShNm65A+STrh
X-Google-Smtp-Source: AGHT+IGbpV2m4yKh+I0fgDw24ZWEJ6x0/MOD946fI6agF+0cD3UaHguS6LgmwKLsHoRPmftj975mmYdj+r++S5ll+V8=
X-Received: by 2002:a25:d695:0:b0:d62:6514:45b7 with SMTP id
 n143-20020a25d695000000b00d62651445b7mr7997320ybg.37.1694422192875; Mon, 11
 Sep 2023 01:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230824064508.968142-1-masahiroy@kernel.org>
In-Reply-To: <20230824064508.968142-1-masahiroy@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Sep 2023 10:49:41 +0200
Message-ID: <CACRpkdbu8eYYTwpVr2-AS7qxGRPkXp9gVgBzkcoDvxV7o4p6MA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: single: remove get rid of __maybe_unused
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 8:45=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:

> These are always used in pcs_probe().
>
> While I was here, I also changed 'unsigned' in the same line to
> 'unsigned int' to address the checkpatch warnings:
>
>   WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Patch applied.

Yours,
Linus Walleij
