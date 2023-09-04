Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC7791EC0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbjIDVA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjIDVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:00:28 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB83B8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:00:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-500cfb168c6so3036952e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 14:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693861220; x=1694466020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hfbcmmzl0B7rvyjvzxIrk+o9AmKL9CushBb6sDo2Fw=;
        b=Ih2qPIHhOtLa9v3C5gzy4duzsPuXhcIUUv6lnT8Nn40/VicwV1zERIPd8tvyuA7+W5
         tW52EBW3ISErWYtRftcEUmTlnc5gfLFWcMlRqDWRLzxbCYgMhAxXDKe7KsmPebj3sJ1V
         /Dj6CQPeP7zSlcC0ds9yDdURsCfFKT+BtHL/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693861220; x=1694466020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hfbcmmzl0B7rvyjvzxIrk+o9AmKL9CushBb6sDo2Fw=;
        b=ZzfsuJTCMjB1Qa9b6sJYhQbVElatbqeu2+d+nsK0+Y4cHLt/2BcUWUwz89+I23OvNz
         vWxa1/nj3+nzhKLzmO3fofvRPOq8P8HuajPRmBu7J8iXd9E+PqY4urU7lYj0njLsQCxh
         2PZxGnEdM+hHnZejhKLgCDEycjMt0LeX3u5/DK6gWu7TFdrX8TuwwpuWXN28vUQckLu/
         tEHXZIrPWsfIoKdqgZyitaWOGMuiL7nEq+4X/34GIUwFvMRPvR2jh1igG5R56ZB1t3H/
         8Xvv245XipIPWkRv3IiBtq1UjXJunc+oiRHU8kGN1I6MpINSI1yiyJLqDvLmTeQvL/Xt
         xTqg==
X-Gm-Message-State: AOJu0Yzi4nQrHFqtbs5JB8F6URr46571uxpDacrfiKhik8jvb+KLpow+
        cwxW40ifwoQD2Um3vPGIUOzym2WmVGAaac/qtWF/LN3C
X-Google-Smtp-Source: AGHT+IGG9lWq0rcreO3o9DnMDpdE8X0DGtYWYFDAs1N62Ad5wcsicV2NmTSVdG+oFHd942+OeF0CKg==
X-Received: by 2002:a05:6512:33cf:b0:500:bff5:54ec with SMTP id d15-20020a05651233cf00b00500bff554ecmr9013712lfg.3.1693861220353;
        Mon, 04 Sep 2023 14:00:20 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id d26-20020ac2545a000000b004fe39f31dc7sm1928811lfn.294.2023.09.04.14.00.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 14:00:18 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-500cfb168c6so3036888e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 14:00:18 -0700 (PDT)
X-Received: by 2002:a05:6512:473:b0:500:86b4:5282 with SMTP id
 x19-20020a056512047300b0050086b45282mr5938668lfd.34.1693861217713; Mon, 04
 Sep 2023 14:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230904140444.GA13143@google.com>
In-Reply-To: <20230904140444.GA13143@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Sep 2023 14:00:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-tX4YBjr2MOa=3pJz6wr2rG1nYDNwDC-vtUo4eeTtAw@mail.gmail.com>
Message-ID: <CAHk-=wg-tX4YBjr2MOa=3pJz6wr2rG1nYDNwDC-vtUo4eeTtAw@mail.gmail.com>
Subject: Re: [GIT PULL] MFD for v6.6
To:     Lee Jones <lee@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Sept 2023 at 07:04, Lee Jones <lee@kernel.org> wrote:
>
>  - New Drivers
>    - Add support for the Cirrus Logic CS42L43 Audio CODEC

.. this had apparently already come in through the spi tree (although
Mark incorrectly called it the CS43L43 ;).

             Linus
