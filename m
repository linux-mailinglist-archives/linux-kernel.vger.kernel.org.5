Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C865076D6A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjHBSRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjHBSRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:17:15 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0191717
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:17:14 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f14865fcc0so516e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691000232; x=1691605032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrCRBhBQL3OtQ+bHa7OyL271Q2ifOyGlImfq9DRj0XA=;
        b=Bn/S0ROLdNzzMjvQSdQfYLpLYu0ENORnFQwnTNSOJPGeBL705QcFs1SDRoXALnmu/s
         7uEicafnIa1IrLxAFpt+OXCBbkW82zMn52djGXMnWkk1L/TVi543x888GYfWTaO8xlE5
         UZvRLuhCM32FQYxclXxSnO/0co8i+zpEl5Olt1NlKDkFxzC0sjsPrDcXH90XZdEQbAt0
         nA55Zz89QYFDrKkrafHqbN+VkidYLlmlndx0h+VZCm7VwA07C8qhpjP4gNc6gBuNJtCA
         JZ1l/n7JxXvyxyVdXorsqP+tNjz4euRntkavRVHrHK2RV4AJ2C15ey/8Fl5I8cNeqNuf
         Z6VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691000232; x=1691605032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rrCRBhBQL3OtQ+bHa7OyL271Q2ifOyGlImfq9DRj0XA=;
        b=VURTWZddr1QuIn83HlOBwCb0IfBwWl5LXE4QOo+kIxEjvI+id+VxgeUH+s+YYvBmSG
         rrrz6xenhiy2VwnHTPTrBfnHQ6LIedGn0ZBTz8ZxWcg18JCQOtzsiRFdimOnBuGIMqKJ
         YJ0G6vPoJZsJuzu2hQTI2sX5p+BnFfie6Kv6+PyslO6Fg39ZqKpWl+FKzOxTK7eskZVa
         PdJlBjYaaSRw9IRc/xhAMZaksWaW5qHXOtDgyxXpqK+vgB7emzUUuZKTeyyflAqh7by+
         +enRw/gs0NMU7DDJtdAbL23FV7nmaYxvKtbUhsCDo0OLEk0vghh2LbMU0aHZMJHFI/W0
         QrcQ==
X-Gm-Message-State: ABy/qLZAbiKrsn24fS8S3R8o3cRwFvAV3XdutHH1zwfOTAskjr866kbm
        cc9e9za3sTcBp5OPBrKu1/6N+7GDtLaj/3Dvp9XWhg==
X-Google-Smtp-Source: APBJJlEO1A+9k5TPeXApIKpU5BAdebVzfqO2UFz8PXgDQU3iKOSjIOMUTuSWMd8o+lSP1RhohVYl/vVaYEiQkGFxW1c=
X-Received: by 2002:ac2:4477:0:b0:4ec:5157:bb37 with SMTP id
 y23-20020ac24477000000b004ec5157bb37mr290237lfl.2.1691000232445; Wed, 02 Aug
 2023 11:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230726181738.1.Ic6b8e25120b2aec95e3d0f4ac92c2a35fc7a40e8@changeid>
 <169079822136.24246.16960757983645261559.git-patchwork-notify@kernel.org>
In-Reply-To: <169079822136.24246.16960757983645261559.git-patchwork-notify@kernel.org>
From:   Rob Barnes <robbarnes@google.com>
Date:   Wed, 2 Aug 2023 12:16:35 -0600
Message-ID: <CA+Dqm30s282gcs6PHkZkH92mhndLi5YP=NPwS0duorizJfx+oQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_lpc: Sync filesystem on EC panic
To:     patchwork-bot+chrome-platform@kernel.org
Cc:     bleung@chromium.org, groeck@chromium.org, tzungbi@kernel.org,
        dtor@chromium.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: This change is being rejected upstream due to the use of
ksys_sync_helper. Apparently it's discouraged. I sent a new patch to
replace this one:
https://lore.kernel.org/lkml/20230802175847.1.Ie9fc53b6a1f4c6661c5376286a50=
e0cf51b3e961@changeid/

On Mon, Jul 31, 2023 at 4:10=E2=80=AFAM
<patchwork-bot+chrome-platform@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to chrome-platform/linux.git (for-next)
> by Tzung-Bi Shih <tzungbi@kernel.org>:
>
> On Wed, 26 Jul 2023 18:17:39 +0000 you wrote:
> > Perform a filesystem sync when an EC panic is reported. The
> > sync is performed twice in case some inodes or pages are
> > temporarily locked. Testing showed syncing twice significantly
> > improved reliability.
> >
> > hw_protection_shutdown is replaced for a couple reasons. It is
> > unnecessary because the EC will force reset either way.
> > hw_protection_shutdown does not reliably sync filesystem
> > before shutting down.
> >
> > [...]
>
> Here is the summary with links:
>   - platform/chrome: cros_ec_lpc: Sync filesystem on EC panic
>     https://git.kernel.org/chrome-platform/c/0a329167220a
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html
>
>
