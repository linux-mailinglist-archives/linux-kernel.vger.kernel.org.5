Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0CA58129E9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443349AbjLNIDa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 03:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbjLNID2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:03:28 -0500
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B89B9;
        Thu, 14 Dec 2023 00:03:34 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e2be6dde31so7332887b3.3;
        Thu, 14 Dec 2023 00:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702541013; x=1703145813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISW1CmfanAMiWVZH5SdhMYK/ZmRMGW3YrjonNTWY3Hs=;
        b=Qcm7nenAzlFzQgybJ49j9LuzjRquqN0oSj2D9HElt+uhGGrScnonGoxP+wAz5C6ift
         wHDKTTCJyjutFUVbvscUY5r3QoW8ojhH/MWdDtrGkLXH3NJrpULhuF0Zqzoa+8eggPkK
         gFeEl5uQ7lwfzxS/k0EfJa1JL5wc0MfXof9EUWabxbQP39odwTzVuZ0O09Td2YsRCWAz
         5iVX57D07O/W9QZYl1QeNiPy0Zn3bsfNYjp4D0/CKSsuzhgPED157FlzTu7lr9JTcN9y
         z3u3the964t4qlPnhSV2OYxY+YJ7xOzDJdFFvxrGsYYbRKsy1iZl7FRpPoXaWg3Rig63
         pc1g==
X-Gm-Message-State: AOJu0YxkPGcqJBUsYDNTpddOdN+KcrP2Tfibd5zwid1ltX9UopSD2qAE
        C0Dv5Cvhv1+z9G9fsigj2aWpaErcTmf3Pg==
X-Google-Smtp-Source: AGHT+IGaHpC6z6ImdpxWHmgDTe/+NfA9Dz3GZI3Pp6FNfx2HbpgUJRf8by0zdsGLgUvttnEAVVtrzQ==
X-Received: by 2002:a0d:d684:0:b0:5e2:578c:916e with SMTP id y126-20020a0dd684000000b005e2578c916emr1917461ywd.58.1702541013491;
        Thu, 14 Dec 2023 00:03:33 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id l2-20020a81d542000000b005af5ef0687bsm5282115ywj.13.2023.12.14.00.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 00:03:33 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5d8ddcc433fso52954137b3.1;
        Thu, 14 Dec 2023 00:03:33 -0800 (PST)
X-Received: by 2002:a25:aea6:0:b0:dbc:d97d:3b76 with SMTP id
 b38-20020a25aea6000000b00dbcd97d3b76mr760349ybj.27.1702541012774; Thu, 14 Dec
 2023 00:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20231214074358.8711-1-wsa+renesas@sang-engineering.com> <20231214074358.8711-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20231214074358.8711-2-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Dec 2023 09:03:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXAnAc9A7M-qzDceeTZ=pSkzxkZRzFhXKtR2p-UtB5rw@mail.gmail.com>
Message-ID: <CAMuHMdXXAnAc9A7M-qzDceeTZ=pSkzxkZRzFhXKtR2p-UtB5rw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] i2c: rcar: introduce Gen4 devices
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Andi Shyti <andi.shyti@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 8:44 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> So far, we treated Gen4 as Gen3. But we are soon adding FM+ as a Gen4
> specific feature, so prepare the code for the new devtype.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Changes since v1:
>
> * rebased to 6.7-rc4
> * moved S4 specific handling to patch 2

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
