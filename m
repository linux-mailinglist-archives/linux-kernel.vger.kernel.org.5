Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9077A9606
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjIUQ6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 12:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjIUQ6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 12:58:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B39128
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:58:09 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-405361bb93bso7490625e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695315485; x=1695920285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Drrb5cgIdX9bQlcJOAIQy6p22Hd1U/QgsuYhc+HIXtc=;
        b=ciuzlhmbvucY7t8kFwQX7szPJX/8c0YZah6t/QI7qYXYOF6Ge7rcZGhwWD4lwbtUs4
         HwFTgaBHYWHxgM/IZfL7U1ciIOLHqLY/U29HvPeDNAdcKl5or5t8+6d5s8RftIrHn6jv
         BBV9KlTj3SN55VyazRRUGQ75L97JWIJWWgba0hg9VVvfy9NTsNklNAq7RjSPH0PQlJIl
         /isO1dtcIZq8z4gBaizh1tnau7xH8w+YNAhdDDFzJkuaZrhX5SVQtqdAPYGd7XkroY7q
         GAFcmSnE6Nm5evwih3is+Vey/MqWo0CXMxRAEHasAe+5guElvkhb5VvLpLUDClD2ILsf
         yBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695315485; x=1695920285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Drrb5cgIdX9bQlcJOAIQy6p22Hd1U/QgsuYhc+HIXtc=;
        b=Rg75M993zoZVeYzRHJNJNNhoFTAZ5O0yZYU/PyysRXierX4fnG3K0Lq/ke15jvGVo9
         JkyZkGJBKCxmZ8+xXBOFp1aAHsbtiyHjKzmbBZWCo//1r+8/gZhSgfW5B81U4LqD6hR0
         PZwaUzlKsOAITYJdOQVYlSPxwGIlWskfW7RNQ71WubhEdxMBoG4jeG/tEQ/odaylVwnU
         PD9+9Pav5xnAVx7pq9myH6szTBAUq1FoW/XDbb7yDXnAdBE7JSRdhmbZN5vAzwmA9Uq4
         fjxwUlpKDzEwC4a6cpprCPTnw6VlB/PBrEd8x2i/0Z6JUpTiPOwKqlMEgvUoCCHw9NJW
         IiOw==
X-Gm-Message-State: AOJu0YyxW95jBm0epAWm7n7t8R5I38xTi0mMSSXXA6eUBH6FQ8+p1ZDK
        TETD3kQCsTJoRn1avO8T23sp1+K+hUvPU3ibPcFQn1SlZ6cJv4pG90IiFw==
X-Google-Smtp-Source: AGHT+IHtAdCqWfyKxt1ELmKKg//qfdzKK9qhy8uM34Bqm0u8o8sOZrkwXfRLF0pU4lRrTWBBCH79wK6kC1VudFfOvFA=
X-Received: by 2002:a05:6402:3228:b0:533:f22:17b9 with SMTP id
 g40-20020a056402322800b005330f2217b9mr3895347eda.19.1695289023375; Thu, 21
 Sep 2023 02:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <ME3P282MB270323F98B97A1A98A50F8F7BBF1A@ME3P282MB2703.AUSP282.PROD.OUTLOOK.COM>
 <ZQF+PHTYDZRX1gql@nanopsycho>
In-Reply-To: <ZQF+PHTYDZRX1gql@nanopsycho>
From:   Loic Poulain <loic.poulain@linaro.org>
Date:   Thu, 21 Sep 2023 11:36:26 +0200
Message-ID: <CAMZdPi-qZ3JjZmEAtEmJETNzKd+k6UcLnLkM0MZoSZ1hKaOXuA@mail.gmail.com>
Subject: Re: [net-next v4 0/5] net: wwan: t7xx: fw flashing & coredump support
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Jinjian Song <songjinjian@hotmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        corbet@lwn.net, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
        chandrashekar.devegowda@intel.com, linuxwwan@intel.com,
        chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com,
        m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, nmarupaka@google.com,
        vsankar@lenovo.com, danielwinkler@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sept 2023 at 11:17, Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Sep 12, 2023 at 11:48:40AM CEST, songjinjian@hotmail.com wrote:
> >Adds support for t7xx wwan device firmware flashing & coredump collection
> >using devlink.
>
> I don't believe that use of devlink is correct here. It seems like a
> misfit. IIUC, what you need is to communicate with the modem. Basically
> a communication channel to modem. The other wwan drivers implement these
> channels in _ctrl.c files, using multiple protocols. Why can't you do
> something similar and let devlink out of this please?
>
> Until you put in arguments why you really need devlink and why is it a
> good fit, I'm against this. Please don't send any other versions of this
> patchset that use devlink.

The t7xx driver already has regular wwan data and control interfaces
registered with the wwan framework, making it functional. Here the
exposed low level resources are not really wwan/class specific as it
is for firmware upgrade and coredump, so I think that is why Jinjian
chose the 'feature agnostic' devlink framework. IMHO I think it makes
sense to rely on such a framework, or maybe on the devcoredump class.

That said, I see the protocol for flashing and doing the coreboot is
fastboot, which is already supported on the user side with the
fastboot tool, so I'm not sure abstracting it here makes sense. If the
protocol is really fasboot compliant, Wouldn't it be simpler to
directly expose it as a new device/channel? and rely on a userspace
tool for regular fastboot operations (flash, boot, dump). This may
require slightly modifying the fastboot tool to detect and support
that new transport (in addition to the existing usb and ethernet
support).

Regards,
Loic
