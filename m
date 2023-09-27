Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7D17AF921
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 06:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjI0EPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 00:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjI0ENu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 00:13:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CFE1BE9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:30:49 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a65f9147ccso1245901166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 20:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695785448; x=1696390248; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nppwpKZq5iygodJXecx1lmUaP9gsbzRp9mrEGrUyrgo=;
        b=f6Y8HXG/UOya3f+0mHrnRJL1MQst79zz4deYzoeSon9VdSJZhhA98YlMIjXNms0cNS
         GniNRB/N9ff7jwVTf5GAxmL6yuvlSiYENpGYLE3+NI2K2fraW0iShGW5pa0s9onLpEPW
         0F5jPGwh+gCzN6BVzR203vNBPXwqGdqOEIrnHYLnYmCNIylBk6o9pCVt9bQNfrIA9nAd
         73HpANIqJA6rD4FHepam1Kp6RpQWrqRz3j3Wqgnt3tn+snme6ozuHBGiMxeE0zZN1N2P
         YOh5hgPci24Bw5n/fQUACzXQEYL0KSuEyBq2s06w9/xV5VDvhMrXAMHW+vs6TjSK/I9c
         0wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695785448; x=1696390248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nppwpKZq5iygodJXecx1lmUaP9gsbzRp9mrEGrUyrgo=;
        b=sqf6HVT3le+j58hfDrhCM/8t4swddEDeYNf0VoPzW+XgMkSYDtSlVDYA8E63xoyQeB
         /df0HH7hwN/2ZU3uJHqe8p95TM/RMcSWocBzZ/dBuV6WncFMhPX9UKoUbTBmrsyVRLh8
         a5/Jhp79OqgkcS/JQtBTZVQ3g2F8b2C1X0/mK124uVFfixy7e0fcasBNlUORvGnFZGXK
         itsylXm83xr5V6sb5CUwCfWferK3E9VMKRFVb11wcE6gTT5FE1FgC1UGvtW/QhQRll7O
         3zz7xbV2NuZhEeXOlyfBUdxPanzEmOq9Gwb3SzFYcw4y5pNQAWm67SSXZVPyuNmz5H8K
         GTZQ==
X-Gm-Message-State: AOJu0YyTBxTnBjuEV1y9oB+gcabpHNT1Fjxg+xqT7sRCynvVF9Vu3jgW
        bx7K58SRCW6m2BNuCD+q9Ad2p6SNNX7kgIw6y40CUA==
X-Google-Smtp-Source: AGHT+IFcLyVzIzw4hV1jVAVdCCoXngVbCS/riNKQfab68M9OsvyIzENEy8FHbfDNBD9x0wBTx4G3x3FIQ76RlFOqVnk=
X-Received: by 2002:a17:906:70d6:b0:9ae:961a:de81 with SMTP id
 g22-20020a17090670d600b009ae961ade81mr557499ejk.27.1695785447817; Tue, 26 Sep
 2023 20:30:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230927-get_maintainer_add_d-v1-0-28c207229e72@google.com>
 <20230927-get_maintainer_add_d-v1-1-28c207229e72@google.com> <036869e27fbc0ec753afb4e5ae32fa74ada8e24f.camel@perches.com>
In-Reply-To: <036869e27fbc0ec753afb4e5ae32fa74ada8e24f.camel@perches.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 27 Sep 2023 12:30:36 +0900
Message-ID: <CAFhGd8q+cbqi3v=tyVKYVHEUTymc9HhRBSN4M1UFgVn7F29aqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: add documentation for D:
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        workflows@vger.kernel.org, mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 12:27=E2=80=AFPM Joe Perches <joe@perches.com> wrot=
e:
>
> On Wed, 2023-09-27 at 03:19 +0000, Justin Stitt wrote:
> > Document what "D:" does.
> >
> > This is more or less the same as what "K:" does but only works for patc=
h
> > files.
>
> Nack.  I'd rather just add a !$file test to K: patterns.

Are there no legitimate use cases for K:'s current behavior to warrant
keeping it around?

>
