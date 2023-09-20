Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4FB7A8FAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 01:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjITXCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 19:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjITXB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 19:01:57 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346CBA3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 16:01:51 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-7955636f500so15553139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 16:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1695250910; x=1695855710; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=YHS0g09D6vc1thRPLJnGpAPdP+yVHQW0z02dWszN1A0=;
        b=PaieXlJHRsMjfC3fjDiReZ9AwKblQM3mT8XDx3Nfj8mdRGgLBgdZSb9cddSfQVREbv
         mTj6vO4BZf8ebNw3VT9DNHgFnYqqu2XR1eIyqk2dYj0JRC4aIeDF8neBqQzP5wV/E3AA
         7K4P+si7AGjg23D39b2j4MwFnR4ySWx67n/pZPDHFHevs8offQ9UDP9iQsXy8O7yQFDE
         wbhuAJeUVamMS+W8ZiJK7OItopGYmxachoV1KdahfjTgTnxvY3wjGSgzB9suVGX/lVAJ
         KGCQXsPNV/bE5oJ7xQWkPeAOENu33bvYGCcU0lToPp5NxgpJgWbwYd/ZKWelDfELaCJa
         YxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695250910; x=1695855710;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHS0g09D6vc1thRPLJnGpAPdP+yVHQW0z02dWszN1A0=;
        b=o3Ilr6m7OBVmAakFVu2ydgSejPrkfEMh2rBYIoVtx9mQGSAAkWDuBoIFfxYbMYwsln
         clwq9B0BWac/3aQOVG5dRTKQwuGxaTMMs43LaNVA+EuN7f6BtO08tDAekHKiafBw9CjE
         9+6bd7wB6VThyTbUJyXKIuObWjyom16FzCWXF5nIgMBqTICE1tcy/cbEhZ0ZFd/lqwmJ
         mcX21dxqgGyYrkqlvVwzQ+H6j/KRlnFT6EnywP3ORlKG0xWAiO0Z6/+1Z1uTU86W53pJ
         UwCHvOftBu71o7vzxmFOgv8X4xiZ347s0FBu34ozSMK/9043QrNC3cuFxftGLnLvPbJW
         AQTw==
X-Gm-Message-State: AOJu0YzPLC49B4t6eQMoNMXpuLq8Pd75yTSos4S8UrlollI4jCFKD0+h
        dJI37rQnyV26LVv9ZDOnQCUa7Q==
X-Google-Smtp-Source: AGHT+IEHrF3yRt5OaS3ynJdUvHgMnpCvlGeaGnJh9f4vOkGFecidC0lD/kLQsvkNbHNd0tUPsMmf/g==
X-Received: by 2002:a05:6e02:1b06:b0:349:36e1:10fb with SMTP id i6-20020a056e021b0600b0034936e110fbmr5083232ilv.18.1695250910530;
        Wed, 20 Sep 2023 16:01:50 -0700 (PDT)
Received: from localhost ([158.51.192.73])
        by smtp.gmail.com with ESMTPSA id a17-20020a62bd11000000b0068e38cf211bsm54027pff.197.2023.09.20.16.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 16:01:50 -0700 (PDT)
References: <20230906204857.85619-1-manmshuk@gmail.com>
User-agent: mu4e 1.10.7; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Manmohan Shukla <manmshuk@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: error: Markdown style nit
Date:   Wed, 20 Sep 2023 16:01:13 -0700
In-reply-to: <20230906204857.85619-1-manmshuk@gmail.com>
Message-ID: <87cyyc78km.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manmohan Shukla <manmshuk@gmail.com> writes:

> This patch fixes a trivial markdown style nit in the `SAFETY` comment.
>
> Signed-off-by: Manmohan Shukla <manmshuk@gmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

