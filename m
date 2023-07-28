Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083EB7669BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbjG1KDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbjG1KDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:03:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977973C0E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690538559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJxfGpxbppzJwgJdPmeEdmGhAfwaruKH//tjBHG7QkQ=;
        b=UcW/bvsfuhZr/nwmvVUjy/TSHGeqUP9SzsPLXJnkWIR0Sbz1CeQ14a7oG5HO2DipEdRmxO
        QaIYvYTxaFWeblsrzNF/Jyg73INo2TW19gtRjXQzIpUR1cLDTLy1BLjeZPcpAYtEiJpJnV
        SFpwbl+ioRsa5jF0xNAnQ9D35AuXYIU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-UIABiW5QM1m8NJnH-WniKQ-1; Fri, 28 Jul 2023 06:02:38 -0400
X-MC-Unique: UIABiW5QM1m8NJnH-WniKQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbdf341934so10664455e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 03:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690538557; x=1691143357;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WJxfGpxbppzJwgJdPmeEdmGhAfwaruKH//tjBHG7QkQ=;
        b=hjkMD4jpZbxqXVs0yHhROQ4Ibjr57Oi1AVioglR8VRhZ6+Ltp6po8OK2VZjFzQRPtm
         7IQSaKehqUoz/QPDp77pT8MKJDEUGtwidNA+tT7uBLxpEFiPA8sAXiMsJq2iy1QuZDC3
         WMMG2mS4kByqpsqEbYXGxEa4eVuto/Oe5ykOEGKMO54tf4Yf2gAObCK5DmwMdr4XFVjD
         TvN26hqJxKPFQRJ1I/lUqKFlwrVW4rkDv9MtaUjr3/E6GaYIr12PAaPlCkAzCCcigLhg
         +STF19foujgBavzqwMmA6/EI69CZWtqHirswaGI+3UnjnWIKe508qAERvG3+e0RZCY8Z
         vvhA==
X-Gm-Message-State: ABy/qLZQrirA1SnqCRXop94fr+ECpYC38/w2KZOxXRym3weNC3Xg5C68
        Cg6ubC0eqQuwX/uBLcrqSl88h+v3l90MI5zJF6xRODQJkrfCRUsuvnxNbSmYMPcBaUMVDo56B3K
        3rFQMcxvbQ44y9kaSEz1Vg2yK
X-Received: by 2002:a05:600c:290b:b0:3fd:1cfa:939e with SMTP id i11-20020a05600c290b00b003fd1cfa939emr1548204wmd.4.1690538557637;
        Fri, 28 Jul 2023 03:02:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGZAUlnXLzjKeLMo1ALDnDndM9wZM0oCDKowY7IKMK5H4noYhpTucg62NPlgPhdJHLTvyOrGA==
X-Received: by 2002:a05:600c:290b:b0:3fd:1cfa:939e with SMTP id i11-20020a05600c290b00b003fd1cfa939emr1548187wmd.4.1690538557338;
        Fri, 28 Jul 2023 03:02:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bcb99000000b003fc0505be19sm3716930wmi.37.2023.07.28.03.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 03:02:36 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>
Cc:     Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-fbdev@vger.kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        dri-devel@lists.freedesktop.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] Revert "fbcon: Use kzalloc() in fbcon_prepare_logo()"
In-Reply-To: <bd8b71bb13af21cc48af40349db440f794336d3a.1690535849.git.geert+renesas@glider.be>
References: <bd8b71bb13af21cc48af40349db440f794336d3a.1690535849.git.geert+renesas@glider.be>
Date:   Fri, 28 Jul 2023 12:02:36 +0200
Message-ID: <87wmykxsjn.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert+renesas@glider.be> writes:

Hello Geert,

> This reverts commit a6a00d7e8ffd78d1cdb7a43f1278f081038c638f.
>
> This commit is redundant, as the root cause that resulted in a false
> positive was fixed by commit 27f644dc5a77f8d9 ("x86: kmsan: use C
> versions of memset16/memset32/memset64").
>
> Closes: https://lore.kernel.org/r/CAMuHMdUH4CU9EfoirSxjivg08FDimtstn7hizemzyQzYeq6b6g@mail.gmail.com/
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Pushed to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

