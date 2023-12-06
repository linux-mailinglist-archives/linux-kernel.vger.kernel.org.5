Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA501807671
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjLFRVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjLFRVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:21:36 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DE5D4F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 09:21:42 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54d712c254aso49085a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701883299; x=1702488099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaGi8ynGM0sSJk2cTHVa3nEhLRrFYa9iM9DZek/jE/U=;
        b=WNZGEuQ0NPvNOdNt1kOslNhT9F9Sxyg4xJcxWLaFjEmqMRuznC+2h1y9+WkDqnVFpZ
         hpXxDZ07/2V2yRDQmfn7jDQ6fz6JAYPCwIsInORUDvryW0p/yl+B3ezLsUUG2spKKY2+
         ArICsIxM8bJyFAtTsah2i7j0G/ntyFTT3OVEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701883299; x=1702488099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaGi8ynGM0sSJk2cTHVa3nEhLRrFYa9iM9DZek/jE/U=;
        b=oAvgoRUoKLV58zdYOSrchvrzIuzyJUapa3kl5MobixJT15Se9u5Vc1d57+CUhASlST
         N70m0UjU44xVbZK5QvV5IKWVc8ndYDZN18MnEkQhuAPBrBlnXYgo6r9VlsOoxR8AllhO
         yHVHL13DYZZzUKSqAE/9Mm/LWadNrMsdynMLk+iBN5lsd3vwIpZdBCewcLRPD0rxt435
         eLPHjIbsshNd7pxwv2QlrnPGz2HbYOBnjcwQASughBMr+eTZYDQ1XOu96txVUEwO/0UM
         LabhzgF/9WKsDWPfLIzm6a1qYCDwYEV15onM3GOeXQOWJehBoo805JGXfFpbv5V28xdX
         DpRQ==
X-Gm-Message-State: AOJu0Yyml8B1cpqTR6HQ2AsQbB2junq5n0EXHi40heqMShjMwqzNFmo3
        JS5et67kg8kdjnTG47iaihQTlHTjq9CFoGHgSXGcQUfa
X-Google-Smtp-Source: AGHT+IEWPa3txn8T0QA9BtMS8w3xKuB3LQUxqfY809r0hVhlqUvRknY43JdeZh1zn4ibVG7/86hJ1g==
X-Received: by 2002:a17:906:2c7:b0:a1e:2e2b:1b7 with SMTP id 7-20020a17090602c700b00a1e2e2b01b7mr324887ejk.132.1701883299683;
        Wed, 06 Dec 2023 09:21:39 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id c17-20020a170906341100b00a1e1a1dd318sm187241ejb.137.2023.12.06.09.21.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 09:21:39 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40b422a274dso95355e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 09:21:38 -0800 (PST)
X-Received: by 2002:a05:600c:22d8:b0:40b:4221:4085 with SMTP id
 24-20020a05600c22d800b0040b42214085mr87519wmg.1.1701883298586; Wed, 06 Dec
 2023 09:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
In-Reply-To: <20231206033913.1290566-1-judyhsiao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Dec 2023 09:21:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WCLB2M1jGEa5NM=thEmJmntV1sAqg11iLH0uizwhN2eA@mail.gmail.com>
Message-ID: <CAD=FV=WCLB2M1jGEa5NM=thEmJmntV1sAqg11iLH0uizwhN2eA@mail.gmail.com>
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 5, 2023 at 7:39=E2=80=AFPM Judy Hsiao <judyhsiao@chromium.org> =
wrote:
>
> We are seeing cases where neigh_cleanup_and_release() is called by
> neigh_forced_gc() many times in a row with preemption turned off.
> When running on a low powered CPU at a low CPU frequency, this has
> been measured to keep preemption off for ~10 ms. That's not great on a
> system with HZ=3D1000 which expects tasks to be able to schedule in
> with ~1ms latency.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
>
> ---
>
> Changes in v2:
> - Use ktime_get_ns() for timeout calculation instead of jiffies.
>
>  net/core/neighbour.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Though as evidenced by the discussion in v1 I'm not versed enough in
this code for it to mean much, the patch nonetheless looks reasonable
to me. I'm happy enough with:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
