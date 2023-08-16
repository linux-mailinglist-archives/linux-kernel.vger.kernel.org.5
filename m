Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF39777E5AD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjHPPxA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Aug 2023 11:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344429AbjHPPwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:52:51 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB2226B1;
        Wed, 16 Aug 2023 08:52:50 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-58a24ac48eeso31650047b3.0;
        Wed, 16 Aug 2023 08:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201170; x=1692805970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCoW3PFrY5/ShBvNx/r+Isbq5FMD3VTelpopPpsFcYU=;
        b=Nx4NRZNyxlkRjO3Rl5A9bPwf9Ayec5gMYbI2TChuFB5j/hcvqwYVyGIFNGJJERyIp6
         Hf5XV/xuCG5DQRmizkeqj0nvo8C97Fdy54bnBMcWLwQgych4YNXLgw0EPYwR66IWSS94
         L0PDowjAPSVrO74Ukl2lLQNzr0aUoE7YW8NVGUqbLqqOJvx2YIP3dIeu01yXZjvosmtI
         lfTn/bAchX7wgQzSSWQ67rjYpCjTPlET4dNhuK4Wnh3gjnblMgaSXAGT9USNgiImgxVD
         6AXbhavTEFeYk5/nFIEPBwrT9CR52OI5KiF1FPt9TlKRQfhlkfjMj9bm1reVesrPtmXw
         vXZA==
X-Gm-Message-State: AOJu0YxbmI7lWYqurc2PCbpnh0DIkbSUAr76m2F7fZ7hpxTVwBjNN6gl
        xqoZ/hsoHZviF1aOIyo+20vuK1bHPWLGAA==
X-Google-Smtp-Source: AGHT+IGo2dk2TmpLM0lr8dO4vo2CVkGHcDooMBeb4mpWtgC2skQZ1TW82B6c7Mcq1B6TuMriYR5WQQ==
X-Received: by 2002:a0d:e883:0:b0:586:a684:e7b6 with SMTP id r125-20020a0de883000000b00586a684e7b6mr2205323ywe.9.1692201169978;
        Wed, 16 Aug 2023 08:52:49 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id x1-20020a818701000000b005707d7686ddsm4056332ywf.76.2023.08.16.08.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 08:52:49 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d684d7a2a67so4511799276.0;
        Wed, 16 Aug 2023 08:52:49 -0700 (PDT)
X-Received: by 2002:a25:7389:0:b0:d44:2269:a289 with SMTP id
 o131-20020a257389000000b00d442269a289mr2415604ybc.1.1692201169015; Wed, 16
 Aug 2023 08:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230810141947.1236730-1-arnd@kernel.org> <20230810141947.1236730-12-arnd@kernel.org>
In-Reply-To: <20230810141947.1236730-12-arnd@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 16 Aug 2023 17:52:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUpowogoGXp+70W9VaUMa-t4T=xNo2Ehf0ZgHAewEkKuA@mail.gmail.com>
Message-ID: <CAMuHMdUpowogoGXp+70W9VaUMa-t4T=xNo2Ehf0ZgHAewEkKuA@mail.gmail.com>
Subject: Re: [PATCH 11/17] scsi: gvp11: remove unused gvp11_setup() function
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org
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

On Thu, Aug 10, 2023 at 4:35 PM Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> This function has no declaration, which causes a warning:
>
> drivers/scsi/gvp11.c:53:6: error: no previous prototype for 'gvp11_setup' [-Werror=missing-prototypes]
>
> Since there is also no caller, just remove the function.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
