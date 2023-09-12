Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59A079C991
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbjILIP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjILIPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:15:47 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B2B10C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:15:43 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d78328bc2abso5008355276.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694506542; x=1695111342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tghVFyIVhGX7gYPr6Xj0nI/BEuj6kidnkTNQDfpOQPI=;
        b=U9nCW5ZbT8ShIHJFZi93YCEvs2CdMeYP2+a1cL715L/re+nSH1CO43I6hK0h5Y5d/e
         h9VO/B0dct4DrXiD6xvkg7MGCYQWNmHcfck9dqtnAWLctv3ACZfwdRo1vLxKm1voC+aJ
         w/hFIMpp47OW4w6XNZ8ErKG/bUE8tGgy5J/I5C4pcjVeTdRwkuDP81lHvqwkatisOTfU
         PzV2i4UI3q2W1J55oUABuhwraycdKejnPTIVmUMuy1TuTQEX4ZkaWphG+Xylcw+Oywik
         4aj56Y02olVCRG0TolnLnlRBZ9MNPndwhqMTxW3MNzBplge/6QSvEuf15i1BI8kV2N/M
         jS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694506542; x=1695111342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tghVFyIVhGX7gYPr6Xj0nI/BEuj6kidnkTNQDfpOQPI=;
        b=J+Aja/B8LD2zhwcA5FOzAkDGlx+j7eL1Lb2VYaE3eITCNbJlrSbTV6G5JT+m16c9wD
         YmbHMHrVguGeHwDS9eCAy1+cpBYpkmtE5xYI3w8CL88p2mDldatS6vMnybl0wKrOaCQy
         FXEt6JLmCSDLHt4mJW7llRgSlden1yWJWd5EcKqHaty+qAdfRJn4GLEduWP6MPf+y9ic
         yM+HidfIXoTOeMRlQ6Wf4BkihwBNSbw3iXg45tr1VdFxZAMdAJxjA+IcMC6chPYmlw6Z
         V5zDBFqe62hgzxal3rgD5dzQkQiJ8Ne3PukzHaK2Bs0tE8S2zpkEqnL2WKubkzSKNORE
         bDhA==
X-Gm-Message-State: AOJu0Yy7LnfJxkMxhPW5l0saatSHTorhx1RzTq9/d1S379NV+1eDveQ7
        XJCx8PMA+hwuEyzYBbNaJ2POGKRaS7BAA1uxEioX6Q==
X-Google-Smtp-Source: AGHT+IF9JdFOEbM9cB2dJiRJKc//HeRrwq0WKN18VB7VbjHOfLCYipsBo+gHvg02bKHENmMSmNIRGBLQIXk/n6NrARc=
X-Received: by 2002:a25:aa69:0:b0:d7a:e0f6:54cc with SMTP id
 s96-20020a25aa69000000b00d7ae0f654ccmr11152715ybi.26.1694506542714; Tue, 12
 Sep 2023 01:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230909063613.2867-1-jernej.skrabec@gmail.com> <20230909063613.2867-3-jernej.skrabec@gmail.com>
In-Reply-To: <20230909063613.2867-3-jernej.skrabec@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Sep 2023 10:15:31 +0200
Message-ID: <CACRpkdbTZYnehWiWFgY3KJLFdS47RpxOp-Cct4BDqgYCYtd2vw@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: pinmux: Use dev_err_probe() in pin_request()
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jenej,

thanks for your patch!

On Sat, Sep 9, 2023 at 8:36=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmail=
.com> wrote:

> Use dev_err_probe() when printing error message in pin_request() since
> it may fail with -EPROBE_DEFER.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
(...)

>         if (status)
> -               dev_err(pctldev->dev, "pin-%d (%s) status %d\n",
> -                       pin, owner, status);
> +               dev_err_probe(pctldev->dev, "pin-%d (%s) status %d\n",
> +                             pin, owner, status);
>
>         return status;

That's not how you use dev_err_probe()

Just replace all of the lines above with return dev_err_probe(...)

Yours,
Linus Walleij
