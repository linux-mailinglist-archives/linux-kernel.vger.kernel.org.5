Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088867C681F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 10:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378146AbjJLH7y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 03:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347098AbjJLH7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:59:53 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6765DA9;
        Thu, 12 Oct 2023 00:59:49 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a7a7e9357eso8594917b3.0;
        Thu, 12 Oct 2023 00:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697097588; x=1697702388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNdfcf5RJbVw3euD+r2W2z32tRPcDJdoEVJcQdZ60Yk=;
        b=MYcze3xpTW5gTQj1dq/kDXSiX5FjG8qKWsz6EHzxzEa2swAA4Q4LFms0r7tZhYYgsO
         QVbpxOMwJHlDZQyn3EL+meJz4lhmXleuVdBoFHIfU2HVQFxMSxEJHksDQnWRqMaLCFam
         rYPaLDXLZRn4dl6/5QlMhfTuZZ9WyyyGWNtPge/p/XfnGdzjVXpt/NEd4k3xT+8ZOI1Z
         Xx5uchJj8GsFDg6kYaMq+hNAXbu+EnJBDy1hMm41361Eh9QGC9Qw8A2LfUcas2tQx7zN
         Vct2doIr/AgB2TERkNGWh0rOUNNZe2ly4UOA/oDEpRSMfri0p1QNTKQ8xBG37hePQ5yS
         utPQ==
X-Gm-Message-State: AOJu0YxkILFpTv5hwiD2bLrSDc+TL4lE9y1Isp/Yh0hLbQLHpdNzxzSu
        2Vxwt8pTkxBcyzJkLDuuKgONKMfqpH71qg==
X-Google-Smtp-Source: AGHT+IFQAs8e5QSaZ+RGLIac7ReKdfC4kXP91j2xzSMlXtqKYo+VDYS8QrhiuPsNZTgzBvmnd+X8hw==
X-Received: by 2002:a81:79ca:0:b0:5a7:b930:16a8 with SMTP id u193-20020a8179ca000000b005a7b93016a8mr8342391ywc.4.1697097588468;
        Thu, 12 Oct 2023 00:59:48 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id e12-20020a81dd0c000000b005845e6f9b50sm5667158ywn.113.2023.10.12.00.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 00:59:48 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-579de633419so8279187b3.3;
        Thu, 12 Oct 2023 00:59:48 -0700 (PDT)
X-Received: by 2002:a0d:cb49:0:b0:5a7:c97e:39e3 with SMTP id
 n70-20020a0dcb49000000b005a7c97e39e3mr6477357ywd.15.1697097587925; Thu, 12
 Oct 2023 00:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231012065822.1007930-1-javierm@redhat.com> <20231012065822.1007930-6-javierm@redhat.com>
In-Reply-To: <20231012065822.1007930-6-javierm@redhat.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Oct 2023 09:59:36 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVR=aM-fr6SLfZMyA-Mdw23Tv+rX-iQQmw5u5U3vW5Ajg@mail.gmail.com>
Message-ID: <CAMuHMdVR=aM-fr6SLfZMyA-Mdw23Tv+rX-iQQmw5u5U3vW5Ajg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] dt-bindings: display: Split common Solomon
 properties in their own schema
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Conor Dooley <conor@kernel.org>,
        Peter Robinson <pbrobinson@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
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

Hi Javier,

On Thu, Oct 12, 2023 at 8:58 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
> There are DT properties that can be shared across different Solomon OLED
> Display Controller families. Split them into a separate common schema to
> avoid these properties to be duplicated in different DT bindings schemas.
>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
>
> (no changes since v1)

New patch in v2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
