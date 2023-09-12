Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A522079D886
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbjILSRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjILSRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:17:32 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0E810D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:17:28 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9338e4695so98112431fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694542646; x=1695147446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ymrBGh2e6fWEqS76b0juevgaQT1BTalM/4ednjAbvYs=;
        b=VQktlbP6OyD2iKUB0bTQ5fMEuUAtzJoEHpFPsPDmIY4IFN2+LPwb0haokCS1U7g7Pe
         Ta8pmJCqf0xktQmFsbolSi8uM7pjgF1lq7bjci+tZjzKFQt0qP/9gMlPVq5tieD/UwM7
         PNdypjT060i4iCzOSbJNysIl69HP5Wcok26bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694542646; x=1695147446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ymrBGh2e6fWEqS76b0juevgaQT1BTalM/4ednjAbvYs=;
        b=Ls+A0WoTtXQqoHCcJoOyuwRkY/riW49fMyYYfye94Ne+AewSHN1RTIfR9K+bAykheI
         /vccs1F8n0aHr3qL1eY/rP7NBTiMiFYStEB/N53zAZ0X7w+M+b6Eg6tH0yvQWo/+s6uB
         zP9/l1tAAdJz3ASPnctLDo588OLn1YF3+wfMCwEfVOKlMIF1PC2j7UokY+0vySUBVWSo
         apyW1w+JEyg5sTQvl3YAj0Q2cakedytmIe/Rk3CWJusbCqwvH26QPGI+Sav1GHaLqQGY
         5jB6EJ4HP9OuAtHFVPv0RieAKQ/Th7ELxIVLXzOA3aU7TkhWyEZzs/x51S0fjJN1eVLf
         L0hQ==
X-Gm-Message-State: AOJu0YyM7gqZM40+LvYUYomIWH5RYBwG32t4q8+SmOWvaKCCyJTGC+GB
        /b0LK8OVqhGZDnTo/BNBjHsV27YXxGHoUuCgFCDezpBb
X-Google-Smtp-Source: AGHT+IEA9aXTNqsMuxs4PI/rZb0qP6kRiHYMN/JkfUsMUU6OJsO3mC3T7k83lRbV1lC3QuEH5ETGiw==
X-Received: by 2002:a2e:9815:0:b0:2bc:b46b:686b with SMTP id a21-20020a2e9815000000b002bcb46b686bmr446381ljj.34.1694542646090;
        Tue, 12 Sep 2023 11:17:26 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id gs17-20020a1709072d1100b009ad850d4760sm1394652ejc.219.2023.09.12.11.17.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 11:17:25 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9ad749473baso230466366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:17:25 -0700 (PDT)
X-Received: by 2002:a17:907:3f99:b0:9a2:40e:2cad with SMTP id
 hr25-20020a1709073f9900b009a2040e2cadmr73265ejc.48.1694542645147; Tue, 12 Sep
 2023 11:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgfL1rwyvELk2VwJTtiLNpwxTFeFtStLeAQ-2rTRd34eQ@mail.gmail.com>
 <3c85e5f7-c9a4-4c77-b4e9-3b476ac6c1fb@roeck-us.net>
In-Reply-To: <3c85e5f7-c9a4-4c77-b4e9-3b476ac6c1fb@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Sep 2023 11:17:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+rYcuh0zp3b3qFuhwykXK1u1HcpRPCpeZ5EUnUKjJew@mail.gmail.com>
Message-ID: <CAHk-=wh+rYcuh0zp3b3qFuhwykXK1u1HcpRPCpeZ5EUnUKjJew@mail.gmail.com>
Subject: Re: Linux 6.6-rc1
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sept 2023 at 11:00, Guenter Roeck <linux@roeck-us.net> wrote:
>
> loongarch:
>
> INFO: trying to register non-static key.
>
> Caused by commit 0a6b58c5cd0d ("lockdep: fix static memory detection even
> more"). No fix available as far as I know.

Isn't this

   https://lore.kernel.org/lkml/ZPl+Y2vRYUnWtTQc@ls3530/

the fix? You even replied to that saying it's fixed.

Or are there two different issues here?

Or is it just that it's not queued up anywhere?

                 Linus
