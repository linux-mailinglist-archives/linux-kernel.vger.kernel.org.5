Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D467CE9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjJRVRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjJRVRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 17:17:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1604115
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:17:10 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53f3609550bso2946411a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 14:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697663829; x=1698268629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BmzWNRuuuMHLesQTgLE+SaWMDv+DrXY0BM9GFaIRAmU=;
        b=e+iFmLSRPde5OBfeeGguRNuxFKBq6QS1RO3O923Ks4FdwIsgfvga0zkp1A75T0UXGP
         V78GjbrZ1TLlEY7bJWBOi73ia6Se/54+kRlSM8U1KUmFOh7QHap+JrMP7lWCaZn5lJVg
         lmTOuNpGkaP+y0KZ4Lp+4IXShw7Yb+yiZGqlfNbwwd8O3ZYL296tb1qmJaIWeG20mJp0
         3JnRf/RGEJ4XecGoTZJWvtJifAnJj4j8gXOmZ+SqQ5DRBoA06Hgy6VabvyElKk1hotgZ
         cAtUnB+HDn2v53Qf9NFpdTXz7rkNuNk5ZO/QZPh2jjIQ04HMxZtOEzb+8P5SuKfpdq9T
         pSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697663829; x=1698268629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmzWNRuuuMHLesQTgLE+SaWMDv+DrXY0BM9GFaIRAmU=;
        b=oDTl/3K4HtTq3qpRQqNb2yE1apQXwg7wFi13TQJDch30nVwyOuZx5n9jkXjeCPGtLn
         JFidncQUiQh3+tyfBOBCvQ5Ykbj6CTKXVbtBBcL8DQRzxpcXV+xxHsFmbmqwv+49vXNW
         OPjkuNCct7LsUGxJq9W7s6OxBM4KX2ZCTiPxvsy6H+rsMfar5wpJNE0emR4aI+fLyq6q
         TQQ/lwwnZIkLToAVuhHQyHRH3BujdpMrUf5YYiCpZ/tFN/y3J/GcDY6BnnwXZnk4a7Su
         iDX76LgzjTY5Wtw/vKJYu6oNtzLCsk+ZO22I92TYmJTU2hrkND7dXs/pDazA1B//VS4F
         Y6BQ==
X-Gm-Message-State: AOJu0Ywpg3GcmXcb0/Tuib4Si9ZjQ4H0hQyxnSl27JFQBsvP12hCWrVh
        Jz21KIRuFD9lxbx6bxYa/JjFrsfGQH8CZyOv6+7h0mX8zCudqKl8XiTci7i1
X-Google-Smtp-Source: AGHT+IF6zjERAyTclhi1slQ6zRPCjIhAEdwhb3O6LQNCCsuTO+W6R8ZELmUgrESCNkBRM9HEiVaaSPyHU1ysa4KHxvg=
X-Received: by 2002:a05:6402:520a:b0:53e:8972:1d4f with SMTP id
 s10-20020a056402520a00b0053e89721d4fmr158614edd.5.1697663828986; Wed, 18 Oct
 2023 14:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231017-strncpy-drivers-net-wireless-ti-wl1251-main-c-v1-1-3a5c02382e35@google.com>
 <68fba283-aff8-4751-a4df-78843d89ef13@quicinc.com>
In-Reply-To: <68fba283-aff8-4751-a4df-78843d89ef13@quicinc.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 18 Oct 2023 14:16:57 -0700
Message-ID: <CAFhGd8pTPkY+8=cFf9ys7vfRrzTJsh0rvnKJwDGaWvq3s=MEvg@mail.gmail.com>
Subject: Re: [PATCH] wifi: mac80211: replace deprecated strncpy with strscpy
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 4:46=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
>
> On 10/17/2023 4:30 PM, Justin Stitt wrote:
> ...
>
> > diff --git a/drivers/net/wireless/ti/wl1251/main.c b/drivers/net/wirele=
ss/ti/wl1251/main.c
> > index eded284af600..cd9a41f59f32 100644
> > --- a/drivers/net/wireless/ti/wl1251/main.c
> > +++ b/drivers/net/wireless/ti/wl1251/main.c
>
> wrong subject for this path. unfortunately for you the most recent
> changes to this file have been in conjunction with mac80211 changes and
> hence why you see that prefix. But for a stand-alone driver patch the
> correct prefix should be wifi: wl1251:
>

Ah, I see. I fixed it in [v2].

[v2]: https://lore.kernel.org/r/20231018-strncpy-drivers-net-wireless-ti-wl=
1251-main-c-v2-1-67b63dfcb1b8@google.com

Thanks!

Justin
