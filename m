Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234F47E0D5E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbjKDDGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbjKDDGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:06:25 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61500D49
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:06:22 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-4abf80eab14so542541e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 20:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699067181; x=1699671981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZ25dqMfmLYeg2Fl8aZNdg/aSqPTkJPsImAT7P2Xhqo=;
        b=a1Mw9g2VQFvIjnopXpw1PQAztY6LIBdbtVqupuE9dH45RYfrI2wk+992OpemS4G+sm
         Oyw2ZwDgEEaV37bs45uTLhunjDiIM/kLWP03Xj9ZOWkKDzJYkAwbS5/m7azWQ9Bhl5Cv
         IGwZ9gD/SMWESecLmwj/JNa9StbQRsZjdr9xhWGEUqdcckT/LLHAH8DCDvVFARFHxOWM
         Q+PBnRiOtg+vQWZg8+GhdTrPwmF+L/7WQZMZv70IfPhSvqiuZ1SHXvM6ubunCdSNuD3N
         +EE6fRnS6rLr9GzRfLH/ZmUaAffN3yUsgD/HGgtN1IgwF1iIQg2BzbnFl24Idn5egfBw
         yGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699067181; x=1699671981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JZ25dqMfmLYeg2Fl8aZNdg/aSqPTkJPsImAT7P2Xhqo=;
        b=MvopffiNuj9yuXAxdedw1EgyrO/X0NlbYAfAjr5DekjZHZT5ifJegoxDrJ8OSp2djl
         Q7VnaNbzQslsvNizvNcNd04gnofUzkhXbpspEkNa5XOoVeg+zrVKF3bGUwhAO92hlNQ/
         RWyDh7AAhfyAD6p35E5k2mIzlL9o22jdhJv7dBhU2xoOwKX5Bn4NrPTsDY4NvLCV1NLJ
         tD26GwAW9q/OnNZ2kH4m8+dqj81ffDMza6jnDu461XSy56MBOamoNXvEITwHAYqgC/z6
         RYlJ2s2WzhXV+1aqmwQLz/Uj9dITan8eulrNux1IvmOkXP+dd/FMZlJDAKFuaEqjDCHS
         mPLg==
X-Gm-Message-State: AOJu0YwX6v0gB5y85x+h/3YkERUzkrJDAkxWQg7aVkF7lf+eadycvYQ5
        y62wKWzDgLwLJDDi1hyYAJDEAJV51eVc+GB94VU=
X-Google-Smtp-Source: AGHT+IENifxKWcXUy7hWDZ6jYXbYA5CS7Kd+sNRq/6TwpmNBxaFm3k5pGLtv3YrfR6qS7jYOt5E3fiZhHTgFz0DCaTA=
X-Received: by 2002:a1f:b695:0:b0:49c:b45:6cba with SMTP id
 g143-20020a1fb695000000b0049c0b456cbamr21886032vkf.12.1699067181386; Fri, 03
 Nov 2023 20:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20231103131011.1316396-1-lb@semihalf.com> <20231103131011.1316396-11-lb@semihalf.com>
In-Reply-To: <20231103131011.1316396-11-lb@semihalf.com>
From:   jim.cromie@gmail.com
Date:   Fri, 3 Nov 2023 21:05:55 -0600
Message-ID: <CAJfuBxxVGaqG4wVu-kM3ynA8ARTD6DFPBuz0a1GqunMqdvRBgQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/12] dyndbg: add processing of T(race) flag argument
To:     =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@google.com>,
        Yaniv Tzoreff <yanivt@google.com>,
        Benson Leung <bleung@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 7:10=E2=80=AFAM =C5=81ukasz Bartosik <lb@semihalf.co=
m> wrote:
>
> Add processing of argument provided to T(race) flag.
> The argument value determines destination of debug logs:
>
> 0 - debug logs will be written to prdbg and devdbg trace events
> [1..255] - debug logs will be written to trace instance
>
> A user can provide trace destination by folowing T flag with
> ":" and trace destination value in range [0..255], for example:
>
> echo "module thunderbolt =3DpT:7" > /sys/kernel/debug/dynamic_debug/contr=
ol
> echo "module thunderbolt =3DlT:7,p" > /sys/kernel/debug/dynamic_debug/con=
trol
>
> When T flag with argument is followed by other flags then the next flag h=
as
> to be preceded with ",".
>

the trailing , seems punctuation heavy.
Could we just stipulate that any :string  (leading : trailing anything)
be the last flag in the spec ?
bare T flags are not constrained otherwise.
seems fine as API-spec-by-error-codes.




> When no value is provided trace destination defaults to 0, for example:
>
> echo "module thunderbolt =3DT" > /sys/kernel/debug/dynamic_debug/control
> echo "module thunderbolt =3DlTp" > /sys/kernel/debug/dynamic_debug/contro=
l

no colon after T means p is a flag, not a destination name
