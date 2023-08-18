Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303E3780B84
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 14:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376768AbjHRMHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 08:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236248AbjHRMGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 08:06:36 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8572435AC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:06:34 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-48b8623f34dso293824e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 05:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1692360393; x=1692965193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpnH469vEo7IU25SdSmcFE6MDeKiq05QJNZ2e7yCq2A=;
        b=jaRF9lcvT7n4dJ9N+5RvOSpA2pO7bs1RD4FurBWyWGlo5oOg2k92s2jCFwm7taeiRj
         Kkg7yzyeHDJpIwRrCiPORXJvm9e4A3N1hUKfwv74XZKqMdkeWx9dbNTillZGwGNMhGkw
         z++0R42Aznbps7Tl9nkdJo5g1aQAP1Nnkov3HxFtzT4nJHGCBqKqU8oH7U/In/Ce/+bW
         3HZoyxkMAsPs9ocNfC+yvaUsT/AecSptUxRKKEL0V+qVIkddGk9WAFzGvYNbvHlcyJOq
         GhUglHZ+niPpZeCrju4Gm2EWgxwoEr4gpckQmrHGAhDK3bXJUPx1uivXVSEJ6OJft6Nl
         xt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692360393; x=1692965193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpnH469vEo7IU25SdSmcFE6MDeKiq05QJNZ2e7yCq2A=;
        b=GIAn+zifSFH+Z5P5GFpIBssrDuYQWjRA9m5NMAjd2pVqSjEEULOh9KxcvN0UJ+JRak
         1qZmRFbwx7eDylOQolkyexUYFQX8FEENKpbpxW23e6YuZsFMaqJbVWuX6+ptB+itgIdI
         tjMpPP8GjAGyM+amoAqqx22DGmbWoUKckdubr7NWEpaYZWQSmTs+HKfqOzIXH429JvBi
         CHHYF1EegfqJefVjxvradq41snrFM4zmcvwymVkgFKxgrqkDjIv8Jwq0nCHdk8SFkDm0
         XE3yPzZBVo8sTiaMH5KPn2EzvQ6suexnHgb7at6UaSDkAw1IT1MNj+Lkf9dDjfA8IEHe
         ZYUQ==
X-Gm-Message-State: AOJu0Yw33dFJqt7QXw5JuRc2k9WnlBJKkXBCeTJ6B1P7HDo363nk+qFl
        CoBzuLTX+NrGWMtD/0MRK7faI8Ye4R4+47Q1+foUvg==
X-Google-Smtp-Source: AGHT+IGSndSXwIqtFPOx6mILg8kcTF4ODJjHV8rDnU6qSQPVtk60LVHc2UyMx4l+wp0BfKHsstQSmimTYEMEO7NK86Q=
X-Received: by 2002:a05:6102:483:b0:445:3bf:9387 with SMTP id
 n3-20020a056102048300b0044503bf9387mr3046008vsa.4.1692360392187; Fri, 18 Aug
 2023 05:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230817184958.25349-1-brgl@bgdev.pl> <ZN9JID53QpSz4epI@smile.fi.intel.com>
In-Reply-To: <ZN9JID53QpSz4epI@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 18 Aug 2023 14:06:21 +0200
Message-ID: <CAMRc=MfZ=GgcqKkDXkUgWC-bdCJECs0HfjRe9Ffy-Metwz6fFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] gpio: cdev: bail out of poll() if the device goes down
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 12:34=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Aug 17, 2023 at 08:49:52PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Wake up all three wake queues (the one associated with the character
> > device file, the one for V1 line events and the V2 line request one)
> > when the underlying GPIO device is unregistered. This way we won't get
> > stuck in poll() after the chip is gone as user-space will be forced to
> > go back into a new system call and will see that gdev->chip is NULL.
>
> Why can't you use the global device unbind notifications and filter out
> what you are interested in?
>

There's no truly global device unbind notification - only per-bus.
GPIO devices can reside on any bus, there are no limitations and so
we'd have to subscribe to all of them.

Bart
