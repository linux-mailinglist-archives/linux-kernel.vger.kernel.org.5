Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA8799DAE
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 12:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346590AbjIJKfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 06:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbjIJKfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 06:35:17 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17534CD5;
        Sun, 10 Sep 2023 03:35:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1befe39630bso7975075ad.0;
        Sun, 10 Sep 2023 03:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694342110; x=1694946910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tTDc7jJGGmcQrrskt69eEHOBvSYvKgUyc0AKWMkx6II=;
        b=SJ1x5F9TrbMN3NGLWoEBApOwSxb+BMPMNOFTWlHr/jaDGCIRgc/RWxKx4qDVXWbCnT
         QZH613N7cRwSGCfop0Hj13rkWZnbU+rg0ICeuVMN3Wn+ieATqsDROWIMJIBKC0vRnA4d
         p/NLvoqESpNke2yalqsJVXh/3tVUJ0+BqGSwV4bZS6TbIBDT3jd7Z4nXwLl/GgRmNliR
         cMTrKgmVR1RklmD+fY765ghxXeVo88eShX1rKsZ0zyaPmiQf7Q7Xk0YoVXGxvOOJryoI
         ICfYw+l+EKVXf+m5TWK8d1NuqQhtVC4jN6MRA0VdZ2/+mdv/KmtQ9w2S0qMsAfhvRLla
         PqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694342110; x=1694946910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tTDc7jJGGmcQrrskt69eEHOBvSYvKgUyc0AKWMkx6II=;
        b=iZLKAdzRmvFwCgg6Cw4wQ14JYr5uFFzOpisGYU6mI5X5vKwM6C8jnXGqXfWPGdRgxB
         KI08FbowuzScaM1ntDnbAxjWxN4RBGpWqpIShOzZ9mUC/UMqadypMCcDeFX10z3SxcH0
         tKWJNeYRIiNnPfurwgiyHNNk09M33+e4yuT36GZ4mFBgEge3L5VIy3SkKIx37ILpjTdJ
         GDnTneWk+LEBV5aqBQ1s7bxpPpQ41Avurjx/bHQeJ5l6pXqWXY6LDhQP5wnXpWiPzv2A
         flRZTf1oqWzJBQBfhaOF0tzDBkjVUpY1c2D1VJka1L1HCrc08GYfcknKVJ7lj/cTSBdT
         rueQ==
X-Gm-Message-State: AOJu0YzgMoYVkbPwnGyume4ry1h35RJh3n7roiIW319BmUTINTZRKcIx
        IEs/MeFFLOyfVMg10r0xFrLWbRvokfL35cfer4Q=
X-Google-Smtp-Source: AGHT+IH+4+9aVJ2cmUtNKw6LTChHte1Sgu23DKKYT/4awf966PHtd5PUgN5y7nDO2T+udLLFR8ENZn1xrYsJY0Jceyk=
X-Received: by 2002:a17:90a:9bc4:b0:273:e4a7:ce72 with SMTP id
 b4-20020a17090a9bc400b00273e4a7ce72mr4631704pjw.3.1694342110479; Sun, 10 Sep
 2023 03:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230907094926.8278-1-tinozzo123@gmail.com> <CAEVj2tnNm-Ucq0R7D5-eA0yTpD6h+TUpTFUwJttnoFpDDSPaZQ@mail.gmail.com>
In-Reply-To: <CAEVj2tnNm-Ucq0R7D5-eA0yTpD6h+TUpTFUwJttnoFpDDSPaZQ@mail.gmail.com>
From:   Martino Fontana <tinozzo123@gmail.com>
Date:   Sun, 10 Sep 2023 12:34:59 +0200
Message-ID: <CAKst+mCZ5dqGFKL27k1L-TdgcFZn-K6rqTgpy7iXWkCKkfeXdQ@mail.gmail.com>
Subject: Re: [PATCH v4] HID: nintendo: cleanup LED code
To:     Daniel Ogorchock <djogorchock@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Sept 2023 at 03:22, Daniel Ogorchock <djogorchock@gmail.com> wrote:

> Regarding the player LED setting though, I'm pretty sure the driver's
> existing behavior matches that of an actual Switch console (at least
> for the first 4 players).
>
> 1 LED lights up for P1, 2 for P2, etc.
> See the nintendo documentation here:
> https://www.nintendo.com/my/support/qa/detail/33822

Whoops, I assumed that it behaves like it does on Wii and Wii U.
Sending new patch.

Regards,
Martino.
