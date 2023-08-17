Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED21C77EFE5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 06:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348040AbjHQElv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 00:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348037AbjHQElZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 00:41:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED40810E6;
        Wed, 16 Aug 2023 21:41:24 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1bdc19b782aso37331505ad.0;
        Wed, 16 Aug 2023 21:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692247284; x=1692852084;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KXTa8Gdeix+AwTf+LsiQd7tn8eKSEaT9AUK0BaN6zjI=;
        b=RYRIaSSBLRAMDVOmVybYk6u//bhwoF4obPRy7C4F382pRYfPVixhvIws20xIZV2BX4
         eR9vzXi4xEhM7VrpNP65ihx7ytj5gzP+3T5EuHKXuUpPB92UGyxD+Ugd0Oh7gmG+JgW2
         hp5OIDROIUKPtbxwAmMzlQm5kz3F97zPW+VZ/x+vq4Nr96hl9AdR7ob7nyr/GFrZZfBg
         X3atUV7M+etAiHxuT17d003oYivhMe5MahDzfyQXC829KaxHPDM8qikBxrMcPDqQ7XRd
         bvrrkNiQzpO7A71g4qU8jLXKERbtx99Y48ns/aLMT9M3tZjp7wlMOeCZmN5oiyGZqRg/
         FN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692247284; x=1692852084;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXTa8Gdeix+AwTf+LsiQd7tn8eKSEaT9AUK0BaN6zjI=;
        b=AfpU7TaRXNt9tUfz5HYDX86FPKwpdvbyCmnsLFF1QOZlGtBOeLgNgbPeCSbkfy7SSa
         rcVVbYiCjbxbe0A9F3Oee37OMjRXmvkLtmLXl1JfRNDsYn/imt64E8RzIp/xONF4ftg1
         xkaZs4Yiy1J0zmKln6ppk6Bwu4gb3/bTrGrgnhV3e/s/Smh1UAza/hscBkT3EJoE3gtw
         +NfuSKPmYh4uEFqpSsTs5xVHAyKpIPsM/v6WHCd2SDiJiqUA+PlZ0t1108+WfLH8ukxj
         ycoxE06Eun62TgrVXBEouaEnwpJt+L9RdAkRhwJyp2Kos/CqnVGh1qxRNRiYUoxwYYVe
         UpPA==
X-Gm-Message-State: AOJu0YxfZxSQrsUCCPPMm1qw5f9PUfxj2SzJMQ1AsbOSbiMido4xDr28
        AQvuYr3aqsPaDcY7gYn2RRM=
X-Google-Smtp-Source: AGHT+IG64SRkztdlJoF3i8ZR+Y8alyPt1NtfoLwETnZ2nIHuNr25PUFpMPiRypvUV9qZqgSrtllTzQ==
X-Received: by 2002:a17:902:8c8d:b0:1bf:78d:5cde with SMTP id t13-20020a1709028c8d00b001bf078d5cdemr2119079plo.59.1692247284289;
        Wed, 16 Aug 2023 21:41:24 -0700 (PDT)
Received: from sol ([220.235.36.234])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b001b7f40a8959sm14021553plg.76.2023.08.16.21.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 21:41:23 -0700 (PDT)
Date:   Thu, 17 Aug 2023 12:41:18 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/5] gpio: cdev: bail out of poll() if the device goes
 down
Message-ID: <ZN2k7gemanIpbyFh@sol>
References: <20230816122032.15548-1-brgl@bgdev.pl>
 <CACRpkdaTUi0r+nY12J8sLxmvfG2xRd+OMngcMiQkr5cqerevtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdaTUi0r+nY12J8sLxmvfG2xRd+OMngcMiQkr5cqerevtA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 11:41:06PM +0200, Linus Walleij wrote:
> On Wed, Aug 16, 2023 at 2:20 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Wake up all three wake queues (the one associated with the character
> > device file, the one for V1 line events and the V2 line request one)
> > when the underlying GPIO device is unregistered. This way we won't get
> > stuck in poll() after the chip is gone as user-space will be forced to
> > go back into a new system call and will see that gdev->chip is NULL.
> >
> > Bartosz Golaszewski (5):
> >   gpio: cdev: ignore notifications other than line status changes
> >   gpio: cdev: rename the notifier block and notify callback
> >   gpio: cdev: wake up chardev poll() on device unbind
> >   gpio: cdev: wake up linereq poll() on device unbind
> >   gpio: cdev: wake up lineevent poll() on device unbind
> 
> I see why this is needed and while the whole notification chain
> is a bit clunky I really cannot think about anything better so:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 

The issue I have is with the repurposing/reuse of the existing notifier
block that sends line changed events to the chardev.
Correct me if I'm wrong, but now all line requests will receive those
events as well.
They have no business receiving those events, and it scales badly.

My preference would be for a separate nb for the chip removal to keep
those two classes of events distinct.

Cheers,
Kent.

