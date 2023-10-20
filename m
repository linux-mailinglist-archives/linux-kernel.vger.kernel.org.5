Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A237D0934
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376359AbjJTHJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjJTHJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:09:19 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88169F;
        Fri, 20 Oct 2023 00:09:17 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6ce31c4a653so314187a34.3;
        Fri, 20 Oct 2023 00:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697785757; x=1698390557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYSv4aandaw7wmzTidVqaa0hP5wMnJZDctMSVWEzevg=;
        b=nCYrual93KJOui+COdn+LQH6e6D+RY5xt/+14rf6L1SPmtUFaOBnq/S4rnXqnZQl9g
         YXboqCg1aT1Lgxh2TpN/Tju+SeSqWzSpc3q7UBhtZTMaGpBGX9siG4LxVKMqRdtkYqnn
         nXjpGsMnq8xJn6qw4n/Eh33RGyMvOoXzU3uKzroRiXhBh3wtljfBGjs3pEt/zMZRlluB
         UC0F5dlGSvUsOT8rFvrVC0lbEkJhkiM8b3mqT2jy7t0vaO6Q3XzTPfvsaErYbK7SJuYM
         /Bp0+d3qBsksdonztkVl5dL6pAwR1Aah8eUHj4XknccBGMa6jZDI1dJN+IDmJ/dcsy3y
         mhGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697785757; x=1698390557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYSv4aandaw7wmzTidVqaa0hP5wMnJZDctMSVWEzevg=;
        b=oLqAYoGKrtiEGhP2eJe/CqRAkRB9vZSjRkH8TAexApwzwptwLQRuCLd9dCe3FmvC0D
         kLQZDATm9BLFRN/PCB8Zozf1oSbVaq3ncldu4gRFxOvt5kO116f5Yyz6G+vWWmlYW6G0
         XRqEdVcNcrkCGMGNYoUO2nZiQNFM7wvsyh79Q532mMWIZs4mxfJ0ocOEBB2JT4iSvrIO
         CH9u6W7iDxcPhUSSYpGDHCzzpkR94IyN4Ca+wkbA34I3z8CsGHSVI5M52cSzailKUD71
         FGoPPgCrOCCR+GYH4mV4LR5SIODNpv1f0Rq6NKQU9bVDigqOYRRgnDsGvqpgeZwpesci
         ZZvg==
X-Gm-Message-State: AOJu0Yzb9wqnm8BD3HD0BQGgi1J5KKY6bcitoBM2T+SPW8aDkKC2Ad3w
        MVc/yi+TvmIfz210XyKhgiE8nQzYm+oX88vTfCQxRQjo
X-Google-Smtp-Source: AGHT+IG9U5CPm2fz9a/n4UH5ZtMl54iNd4sTgfQFIbO/CQk28zgi5jrT99rut7KKIJCprOd97zGIZsAAqY7TtFelxy4=
X-Received: by 2002:a05:6830:1081:b0:6b9:e3b0:1433 with SMTP id
 y1-20020a056830108100b006b9e3b01433mr943487oto.37.1697785756829; Fri, 20 Oct
 2023 00:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAKZGPAOurEwCs7B8RAinTEBwWKOEwW=8FLtAKSzLu9LjH9AHvg@mail.gmail.com>
In-Reply-To: <CAKZGPAOurEwCs7B8RAinTEBwWKOEwW=8FLtAKSzLu9LjH9AHvg@mail.gmail.com>
Sender: getarunks@gmail.com
X-Google-Sender-Delegation: getarunks@gmail.com
From:   Arun KS <arunks.linux@gmail.com>
Date:   Fri, 20 Oct 2023 12:39:05 +0530
X-Google-Sender-Auth: 32ViEhZLuO--T80YOdxzVChFkaU
Message-ID: <CAKZGPAMj6umUvoc+supfTU4juGoUXw78UiveUJgZQFE_ErdGbg@mail.gmail.com>
Subject: Re: Question on pre running clocks
To:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     sboyd@kernel.org, mturquette@baylibre.com,
        Arun KS <getarunks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ linux-clk

On Fri, Oct 20, 2023 at 12:37=E2=80=AFPM Arun KS <arunks.linux@gmail.com> w=
rote:
>
> Hello,
>
> Lets say there is a clock which is enabled by bootloaders and is pre
> running as linux boots.
> Is it mandatory for the client drivers to call clk_prepare_enable() on
> them to initialise the enable_count to 1?
>
> Or is there a way we can specify to the kernel that this clock is
> already enabled by bootloader and initialise the enable_count for this
> clock to 1.
>
> Because otherwise, clk_disable() prints a WARN() if a client driver
> uses clock handle where clk_prepare_enable() is not called.
>
> I grep through the code, but could find any details. Appreciate any point=
ers.
>
> Regards,
> Arun
