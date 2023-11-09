Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693727E6ACD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 13:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjKIMrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 07:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjKIMrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 07:47:05 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBD7210A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 04:47:03 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5b31c5143a0so9708567b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 04:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699534022; x=1700138822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUEgb8MmlHVZ+GQXOXSn2Ul5aehNovNEy7sZi4Nbf5I=;
        b=QS8W2bQ6RWOMpXDZI0lfXbuVwJHtSPvoF9BSWjtE4dL2DeJXynplYZofdYVsN6p3or
         kxR4ibpEFoTVbFvixXnGmKGxQFUKMDkqhdcHb8OdNKyVDzuuF8rduCihH11dexXQ0fdU
         NbM5x+xWiBk6YohvjI7NWUHLNXFeIgvPEleiNzDbpHSkKMB8yjfV+cR24ySmEv85VWQX
         FONpN2HNkcSO2nVimS1aIm1rmn3ddkyhWHuzWEprJ+3AgfLfonLe5xByR57PCoWNPpfY
         POt/MLNvHa9itMjsGP35omYD0ThW6tICLFPDF7kddaZOdQsz744eI7Xeftki1u2WCAM8
         mg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699534022; x=1700138822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUEgb8MmlHVZ+GQXOXSn2Ul5aehNovNEy7sZi4Nbf5I=;
        b=Gk/I8jcxzqwR2RZLxnpDQWHjNhuMGKcSqipYpoqKZFxJbOODHFgE4lzzmcG4jXpUxU
         ej35PtANKIzljblE/yR9OgJeOvmmDklRFydLPH8qWwKUGDO6gZ0HzwovAbpK++pJQ5ax
         egYYFdyAASXo/U7lAe78OYf5h9FRL5SfRefWQvS00IyrBO5JD142fYVFpC15xwUrI2KP
         K5C4U5um3wiLYtncKEVRxJI8JmhYjG6v7ZIlrkYQvN5hLrNqNgroSB5MmrP1URWO1YQH
         Gbn0s02pTEGV7uSOFE0EktKBLEDauJLaZ2lilk+zIvGs4/f4VXRt9+4CxMSSXfZElql8
         96/A==
X-Gm-Message-State: AOJu0YxGfcE78Rm/IoAfDbHoBEaoAjZvC4a/N3WFzkpwfbEKXJGq0GS1
        iejI/zdgC02PQZFK42nSlVxq/n54y/AeLE23yVezfw==
X-Google-Smtp-Source: AGHT+IGb5+7qEAUXDqtbvGisdFDBkO6/VjsCdjKUSsKXrN9GVIF//NY9TBAeKGJwTSJpgHcDzpBuTaoA05z3h00RGuk=
X-Received: by 2002:a0d:d597:0:b0:5a1:e4bf:ee5a with SMTP id
 x145-20020a0dd597000000b005a1e4bfee5amr5088917ywd.41.1699534022641; Thu, 09
 Nov 2023 04:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org> <20231109105037.zppxrr3bptd7a7i6@skbuf>
In-Reply-To: <20231109105037.zppxrr3bptd7a7i6@skbuf>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Nov 2023 13:46:49 +0100
Message-ID: <CACRpkdaNLjnLtGNQtcsH4xC8FQusj510cQvOYXLHw=Q1Y-hoNw@mail.gmail.com>
Subject: Re: [PATCH net v4 0/3] Fix large frames in the Gemini ethernet driver
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 11:50=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> Thanks for being persistent with this! I hope we didn't miss today's
> "net" pull request :)

Hey thanks for one of the best review cycles I've ever had, really
really appreciated.

It's more important to be correct than to be fast so I don't worry
much about when the patch goes in.

Yours,
Linus Walleij
