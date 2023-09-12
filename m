Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA69879C830
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjILHaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjILHaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:30:20 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7298110C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:30:16 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-493639d6173so1982529e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694503815; x=1695108615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TN26BfaiDJoVfg/UiN2J0tRS2gVILmjP175yRV3yNlI=;
        b=R/qlokm+Y6EFdERhrhL9csvQ4Roy1PlshTaavKHyz5HV9/zEUJrD5WMW6DnRmjfJNi
         XM/KLX/yCec8rGJ8KE1NyP+v5oK+AcyZb2DDCOgQCm3CN1QHpLfSPhHkbGLepEU9caRO
         8FcqKPQhGG77rh7WPWbIsyMA1VmvrYA4i7sOEh5wn/KcAuOEDfR0Qn/1lVkPUUpSL5at
         XHLDF54Ywl8zQfwI5E+xS2ZPJ1c6qUdy0f0z440qr2+e81gHxqnMd7hct62W/CI5kr03
         lebUt0tOYStymZDic5xdTKVCoNL6GSYz2DYjpAix1d7QqFF6cEwIeoTXduQ9lwOm3gLy
         Ar+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694503815; x=1695108615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TN26BfaiDJoVfg/UiN2J0tRS2gVILmjP175yRV3yNlI=;
        b=sv/o4dHITlqusppe6ordSSrWCgDt8AM/S36WuSIZzpdPMlFqSr9MhTz4WYYZqkJgQv
         oQELOs7o4ZkMrgG+4on4dYNBZNm0gDKVv227eHPJODPZY3u9kASKsgydb+EZVw0io6ij
         RQR3RFAU0gywm9Kz0vVjPJ4byKCNkISj9KhaCyf7sUpCMITC51dzW2eVnqn1SS11JSEp
         yHKMjD4tZ4pbO6ZxgR6NkWh7mo4gSXg0I6/qASNuyESTf8CpZsOE+hPo+AtXjRQN5Qqv
         odoJdcTjRBvUYRa+SBGlvxstLvuwzDF6FF4sWvFGsm90xrr2sXt+hjIMWgQKnNi6b8B8
         s20A==
X-Gm-Message-State: AOJu0YzHPK9QJ5cgdTsGWe4DyCqxVEkD3IQFSQ8S+ZsZFfXC3wl/6W9p
        HliGT1EyhfdWe4o/2Nly0AS4oxMryNTJjBit4y8+ag==
X-Google-Smtp-Source: AGHT+IFtzFaIKPX4W0g8Ku/Esb0yDPwbn2qjfMvsWFxv10KrDhKiHx0bBUFzOaRYfKdb9b/hbixCClPVv+oGXc9aFCo=
X-Received: by 2002:a1f:cac3:0:b0:495:ba08:79dd with SMTP id
 a186-20020a1fcac3000000b00495ba0879ddmr8876215vkg.5.1694503815601; Tue, 12
 Sep 2023 00:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230911110740.16284-1-brgl@bgdev.pl>
In-Reply-To: <20230911110740.16284-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 12 Sep 2023 09:30:04 +0200
Message-ID: <CAMRc=MfXe0POno6LuonTMC56+rOfHZ=mwOG3PhFxLT3yjRWK5A@mail.gmail.com>
Subject: Re: [PATCH v5] gpio: sim: don't fiddle with GPIOLIB private members
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 1:07=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We access internals of struct gpio_device and struct gpio_desc because
> it's easier but it can actually be avoided and we're working towards a
> better encapsulation of GPIO data structures across the kernel so let's
> start at home.
>
> Instead of checking gpio_desc flags, let's just track the requests of
> GPIOs in the driver. We also already store the information about
> direction of simulated lines.
>
> For kobjects needed by sysfs callbacks: we can iterate over the children
> devices of the top-level platform device and compare their fwnodes
> against the one passed to the init function from probe.
>
> While at it: fix one line break and remove the untrue part about
> configfs callbacks using dev_get_drvdata() from a comment.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Patch applied.

Bart
