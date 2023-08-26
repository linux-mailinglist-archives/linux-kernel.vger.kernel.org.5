Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067047898D1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 21:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjHZTrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 15:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHZTrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 15:47:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829E11711
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 12:47:20 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500b0f06136so885302e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693079239; x=1693684039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JfqtSyOOEfYeYXPTw3WvhRqU9e0vvdpGdFZBiD7IMmM=;
        b=fw2iNj9Em5f7sj12SJcskjFuQM5sRPS6mGTZYIck6eSj9Xy4xQaUl6bA2aMC9A1aix
         a3f62p5aLukbSQz1bkTravregpJUVE9HcLQDHqSUUg+IEwwoxhLA1JmZ/gnhDLycldML
         vwWf18/OyN947xDFz8T8Iw2Yw6xOeJR+0ZyBzKfP57SGD1epCVcLFKUCplq4y/KuMygT
         /1/4L+GswEAhu3vZYYxI7Jn71TmNaQbKkkTK6CvqLxHVOU6XpWvvvg7TO8qiD94LLMQH
         btuft6vPPIB0pCeTAXDnmb7TQlK99WW66+j/y9GEfaJnFXoGsVNonorroXvv1gkR1i3o
         NpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693079239; x=1693684039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfqtSyOOEfYeYXPTw3WvhRqU9e0vvdpGdFZBiD7IMmM=;
        b=fIc06g2UDb8GxLMzYQ7h6vPGQnPwm1TjWCxP5xumh+0vTEYn3PgwzKyY2/9bfIoGwb
         HtJoxIQ410U3nJwMuTk1fboy3L709PPzXn6fKKH12GF6KFnRXG5Yn3ba5526PRgNTjqU
         Zcd0c8rgE+HHRQAFK1DVDYMb9DNdNJU+0wd0MDvDXCXpt0jnzFilxCcYQTJA9PVY8hWy
         kcmjMZ8Q66vlwU/VPKEbjtTPDSo3EUptjBE3PWnlwaSl/7Qgt8RqFX7kjH8bUI1X6sdy
         hDuyRh5fJ8IRDbi00n4VGQe6CftQoxJGNEEETxSObIqbps49bKoqw4g6HDF9EM7CGiqb
         NXbg==
X-Gm-Message-State: AOJu0Yx3v3r7/nju2sjwcejovBS3/JmEzopevxcEhkBidi2X/s3E/PQ9
        1CGkdUm+fr4JJ+wSQjrdvhM=
X-Google-Smtp-Source: AGHT+IH6qDpM6m/YAxoJlYEq00WDgoVHO/8PUUtiAVqxMxmaYkeqIRnLFr71BPhd0b7U0lVKDdaOdA==
X-Received: by 2002:a05:6512:313b:b0:500:81fa:46f1 with SMTP id p27-20020a056512313b00b0050081fa46f1mr11357717lfd.67.1693079238415;
        Sat, 26 Aug 2023 12:47:18 -0700 (PDT)
Received: from nam-dell (ip-217-105-46-58.ip.prioritytelecom.net. [217.105.46.58])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906825200b0099364d9f0e9sm2543939ejx.102.2023.08.26.12.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 12:47:17 -0700 (PDT)
Date:   Sat, 26 Aug 2023 21:47:16 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     Alexon Oliveira <alexondunkan@gmail.com>
Cc:     gregkh@linuxfoundation.org, martyn@welchs.me.uk,
        manohar.vanga@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/4] staging: vme_user: fix check alignment of open
 parenthesis in vme_fake.c
Message-ID: <ZOpWxBjONs0QpFlU@nam-dell>
References: <ZOoWgZ7ZnGyWHUKe@alolivei-thinkpadt480s.gru.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOoWgZ7ZnGyWHUKe@alolivei-thinkpadt480s.gru.csb>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 12:13:05PM -0300, Alexon Oliveira wrote:
> Fixed all CHECK: Alignment should match open parenthesis
> as reported by checkpatch to adhere to the Linux kernel
> coding-style guidelines.
> 
> Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>

Patch series should be in a single email thread. But your 4 patches are sent
separately :(

Have a look at how your patches are sent on https://lore.kernel.org/linux-staging/
and you will see what I am referring to.

Here's an example of how patch series should be:
https://lore.kernel.org/linux-staging/736c8159-90e9-4575-3c22-5a62515d5c03@gmail.com/T/#t

Best regards,
Nam
