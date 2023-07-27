Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51924765B42
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjG0SQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjG0SQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:16:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A963530D3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:16:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so1317a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690481777; x=1691086577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DiDS0mChascCO6L3tr3Hz0xDTzt2hEO5MJ+iwsPLl7U=;
        b=OqKw06mieFE2i7Texhe7OHQzvhb6ib37GdrPTOEVqzDpVnflcRQEdAUGLqXs5nDotf
         9obVCG4LmcSQGVVzMtLTO02vaJnzEX3/MPZN3ISVLwmESgeAh43kLyodB72Fob+qTKpP
         oNeWog1pOi9+GtH0Z9+Ce+a/yb/i/vjtN92mAcSdXKK6ytR7LUQuWBnjXENNuQlIVO+p
         GiKyx0qsNKgN+APrsJvS0VzdSWngL0ZF838Jqp3Br+H/5tqyZQwfOHvrRp2hJGeG2JxN
         LhQPUyuyGhqRToDM8Dqi7G3/NWs0LbavhI+ThoXGxk9nGs3LC2rAmS5s+FiHasYv79AH
         uv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690481777; x=1691086577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiDS0mChascCO6L3tr3Hz0xDTzt2hEO5MJ+iwsPLl7U=;
        b=iVfRlb8Uq/w/YA9wtF+uUlNAGww/kfCiMosR1nFO5lCHXBlZHRZNW+hodlGX4ctVdv
         eC92K+0QsSuFYQYkZ+iifkgNlm0XOCEAUZ0xF1t2zc8Hlzkub/AjJw4BQIPI+zXSeGw3
         5BmIvFyIEV8g7Gz2ZRTzvYU31rjou1AkUDwt3OjGKEhN8N2b/uh1q+U80A/QfqOJPEUn
         oaPXPdoWML+98PHbLBYtralo3ob6zwO1Tvq5V7YtVbULzTxAKdoWA5o4RBWlLOQ9pzyw
         65Dsb6MgNbS5+YjNspme1HbGMSD0PJiT865nA+9yqhnSN6pBk9/bZFp1omcQ4fjWY8nc
         Kskw==
X-Gm-Message-State: ABy/qLYdxMPf1K0bpiauv2Xk4XLUe6tAQ2ePbXr5KpUkweO03bakNsGx
        zf2Y2i2fvGbhHv7A4rclnb7qVWguXl1lck4KOgerBA==
X-Google-Smtp-Source: APBJJlFrSL1AM7CHEdphomj39vss8b33BHSYCNSZrbHdcSZoGX7g6eEnHPlUf54w3Y83E5cBi5H77BQGzK66cSEt/Vc=
X-Received: by 2002:a50:d50d:0:b0:50b:c48c:8a25 with SMTP id
 u13-20020a50d50d000000b0050bc48c8a25mr14715edi.6.1690481777012; Thu, 27 Jul
 2023 11:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230726020946.1409565-1-rdbabiera@google.com> <13b9a16f-0f26-23a4-1e2e-5b1cf9cb4070@roeck-us.net>
In-Reply-To: <13b9a16f-0f26-23a4-1e2e-5b1cf9cb4070@roeck-us.net>
From:   RD Babiera <rdbabiera@google.com>
Date:   Thu, 27 Jul 2023 11:16:05 -0700
Message-ID: <CALzBnUGYZXgocCmycqgf6FyCA9qmVYYj9vuVkeXFoQy=E1GiwA@mail.gmail.com>
Subject: Re: [PATCH v1] usb: typec: bus: verify partner exists in typec_altmode_attention
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 7:27=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
> Is this theory or actually observed ?

This is actually observed.

> This dereferences partner
>
> > +
> > +     if (!partner || !pdev)
>
> ... and then checks if partner is NULL.
>
> On top of that, pdev is not NULL even if partner is NULL because
> adev is not the first element of struct altmode.
>
> In summary, this code and the check as implemented does not make
> sense. Maybe partner can be NULL, but pdev will never be NULL.

After looking at it more carefully, I agree on the pdev assignment and chec=
k
being odd. I'll follow how typec_altmode_vdm handles the NULL partner case
and remove the NULL check on pdev.

> > +             return -ENODEV;
> >
> >       if (pdev->ops && pdev->ops->attention)
> >               pdev->ops->attention(pdev, vdo);
> > +     else
> > +             return -EOPNOTSUPP;
> > +
>
> So far this was explicitly permitted. Now it will log an error each time =
it is
> observed. I do not see the point of this log message; obviously it was
> not intended to be considered an error, and I do not understand why it sh=
ould
> suddenly be one that is worth clogging the log.

My rationale for logging anything is that it will make it easier to
identify port
partners that send Attention messages regardless of whether or not the
port registers the partner Alt Mode. You're right that this is not an error=
, so
I will treat this case as a successful return moving forward. Then the only
log generated will be for a port partner that sends Attention messages to a
port that hasn't registered an altmode for it.

Thanks for the feedback,
RD
