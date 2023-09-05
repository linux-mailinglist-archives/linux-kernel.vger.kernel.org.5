Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE5792F09
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239817AbjIETgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237705AbjIETga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:36:30 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9827B1B4;
        Tue,  5 Sep 2023 12:36:13 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6bd0a0a6766so2144808a34.2;
        Tue, 05 Sep 2023 12:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693942572; x=1694547372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eqUQg0zMZLwgq0WsuJJKdJpvD6RBeoiu/NWcTYcjvUo=;
        b=URL2bNo6rl4EKu8sD1Ajz2zurBQ8zmvPNeq9DmibOpAYbs0ovsHx6+hGlgjCCdfC9s
         466Ht2DUzzHONXxynjwmDXQsp0U0NAAaTxL5t9TLgRu7rYqucyghPGG0T1djfL8frqZg
         6dSMNGBpb6sPKpOLdOxuGFv9V0v8VtOhI3tspqc8nc7dLilecxswig7sFTXV9eWsV6rv
         r/CfrnqRbSWLaBV3BJXQpgaPRuHvnKRmA4Ee38XLB5haL7DeAI/6gz58IlOxM3mf4dYz
         GbywsmnAUiP9kdMiXp2ML3lXpl/GDUsQn/Zls3i8dZ85MU0caFH4dQW3OlcIigzeEjzJ
         Yy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693942572; x=1694547372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqUQg0zMZLwgq0WsuJJKdJpvD6RBeoiu/NWcTYcjvUo=;
        b=DL+IeExs/0TpGIWsU2bPSsE4rISvv5za/JMLakPvcJs3qPhRRjbms56MMbmdw+2QEA
         zIlPk+LUP8kxxn6q30dyX3xXQbkbhKIRY74sNCyWKJxzQiXcj9subo1tIfNjFB6tkUIC
         XGL7V4rV3II4lVc0o71bVnMw9lIHm7PYZ0Pf9qzSQJwyAR8WAChoaPlg9AMRq7vx6zFc
         DqyV737QvfA4Y3A5IjHTlid6uu92AgM9n7ErlnF+nwAd1eJl9capzCw9YZIwamU/AbqO
         n6wqGf9Z+gW8TICRmvRG6W5Gtvjcg0VuKcMs2rt3LzZL5vnpWGMZaE5RDteybzbrOngy
         9cKw==
X-Gm-Message-State: AOJu0YwazJA6qhAadgG9MaNFDB4R5rns3dIOYULFBR2WsCspzVmvkHP3
        XkvEum83wOWIe7c1BSzXkaPb9Cj6IjEOzCMzGHM=
X-Google-Smtp-Source: AGHT+IG4KsVoswA9/HKK1dHnAhZCIdOaEBAg0DAlX4uU6o6k8YqLFhqbrFcmbyxzXPj4+CgnxAksRCSpL1RP9/6LisU=
X-Received: by 2002:a05:6358:279e:b0:13a:bfc:8546 with SMTP id
 l30-20020a056358279e00b0013a0bfc8546mr972132rwb.7.1693942572396; Tue, 05 Sep
 2023 12:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230905191333.never.707-kees@kernel.org>
In-Reply-To: <20230905191333.never.707-kees@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 5 Sep 2023 21:36:01 +0200
Message-ID: <CANiq72=B9s4+4BhezmDPWc6K9tYvhyNpw9uWnRhVdymSUAO_sA@mail.gmail.com>
Subject: Re: [PATCH] module: Clarify documentation of module_param_call()
To:     Kees Cook <keescook@chromium.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Johan Hovold <johan@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 9:13=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Commit 9bbb9e5a3310 ("param: use ops in struct kernel_param, rather than
> get and set fns directly") added the comment that module_param_call()
> was deprecated, during a large scale refactoring to bring sanity to type
> casting back then. In 2017 following more cleanups, it became useful
> against as it wraps a common pattern of creating an ops struct for a

s/against/again/

> Many users of module_param_cb() appear to be almost universally
> open-coding the same thing that module_param_call() does now. Don't
> discourage[1] people from using module_param_call() but clarifying the
> comment: module_param_cb() is useful if you repeatedly use the same pair
> of get/set functions.

s/clarifying/clarify/

I sampled some, and indeed many define the ops struct.

> [1] https://lore.kernel.org/lkml/202308301546.5C789E5EC@keescook/

Link: tag here? It is actually quite nicely explained there.

> -/* Obsolete - use module_param_cb() */
> +/* For repeated _set & _get usage use module_param_cb() */

Perhaps add "instead"? Or perhaps add a bit more detail, something like:

    Useful for describing a set/get pair used only once (i.e. for this
parameter). For repeated set/get pairs (i.e. the same kernel_param_ops
struct), use module_param_cb() instead.

Reviewed-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
