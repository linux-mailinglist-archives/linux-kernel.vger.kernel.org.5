Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF477A273D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 21:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbjIOTdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 15:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbjIOTc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 15:32:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF16419AC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:32:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-501eec0a373so4010473e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694806373; x=1695411173; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qBds5z+NJpOb5bJHssQMRX8nwTbVaqnNS4P35Wp01u8=;
        b=iCyzVubqhYY6lE1mU9p22l5KPIKF9WAO0jWB37ZtCSOwOxA/jcDxfabkU7Y4utoN8h
         jB2L1fwQcTjmD0fotyviZvzlu/YtOXZqnpiR+Omy0vP6j8DVCR2q5LZEV3QlNl+Mse5A
         PoV3bzrnVyXlvlHjpj2d9YsblmO4aEHFbQkOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694806373; x=1695411173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBds5z+NJpOb5bJHssQMRX8nwTbVaqnNS4P35Wp01u8=;
        b=pHmWWNklNvq9GWUCWNu6KPoEvL388wH8Y8y3zMgSnw2ff948JZScI1zdNanpYmb/i7
         VIwJbJOazzLkxkMmKA4gxkfzYJ32Tx1Y3HmaNK4qYdfCtsMYjVzS2Hp11d4915wDpRr3
         xs5zo1HZ1lSjPVKe8z+R4aXA2r9m1FxEXqbV6St2L7McXt2fPZPXU354ix48lA3YdyjD
         2trT1oZ1HkvLAeaQwboFxdOYxInAEFGuf1IzkFqLd3vDE/joSxaxtqSI01AKlGDKWHtt
         ixbWFaxh934siFrGWgJKDh47ts3BPtnKl1fS0xrkMYQ/W11BpWFhQhyCuipvqpIHUkK/
         rpBQ==
X-Gm-Message-State: AOJu0YzQHC7L/t4qIJAXfnMSGDwNygyYfCHrwts4NEIWnao3XC3wpeDh
        8m9JCZVRepZcNsVndtD98rOqHC0Puy+oozc4WMXBRqhH
X-Google-Smtp-Source: AGHT+IEs8iFJmOFJbya/VHNWTbOKTuSgewRUXEbKdkAgiCpTa4PUF8CfGDo+f3olykpvZptIbrjD0w==
X-Received: by 2002:a19:771d:0:b0:500:9d4a:89fa with SMTP id s29-20020a19771d000000b005009d4a89famr1986533lfc.22.1694806372775;
        Fri, 15 Sep 2023 12:32:52 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id z7-20020aa7cf87000000b0052718577668sm2614447edx.11.2023.09.15.12.32.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 12:32:52 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-530ab2d9e89so532070a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 12:32:52 -0700 (PDT)
X-Received: by 2002:a05:6402:1159:b0:523:3fff:5ce2 with SMTP id
 g25-20020a056402115900b005233fff5ce2mr2114923edw.41.1694806371880; Fri, 15
 Sep 2023 12:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230915082416.3949600-1-geert@linux-m68k.org>
In-Reply-To: <20230915082416.3949600-1-geert@linux-m68k.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 12:32:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=witemuuUen2Gr_+uUq1nSWb=MxNVTXS2f2hiTeqfywKrQ@mail.gmail.com>
Message-ID: <CAHk-=witemuuUen2Gr_+uUq1nSWb=MxNVTXS2f2hiTeqfywKrQ@mail.gmail.com>
Subject: Re: [GIT PULL] m68k updates for v6.6 (take two)
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 01:24, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> m68k updates for v6.6 (take two)
>
>   - Miscellaneous esthetical improvements for the floating point
>     emulator,
>   - Miscellaneous fixes for W=1 builds.

This is not appropriate for a "fixes" pull. It's about an order of
magnitude bigger than the pull you sent during the merge window, and
the merge window is closed now.

                Linus
