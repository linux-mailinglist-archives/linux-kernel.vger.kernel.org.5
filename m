Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE30804C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344731AbjLEIP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjLEIPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:15:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71FB10F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:15:31 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso6021a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701764130; x=1702368930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynnvl8LsLrxfDj7bKNLo1dnw8JKtWg9wpT6p42z0kYs=;
        b=N1G1BU1O6pWXmtflNDyVkl4VutO1eOQefrYTa86yR2mtjc/VMP2Vx9qvWM79VL2PUf
         WyxWovtAo0lDw6umMUMcXKodyfwHWnUWFa9AdVipTiXswo2mo8ezkU8MaNmHshZaQY4L
         jU2LcthdFAbjqDiTG7ctrFU5NrSLBgpahd+WU6KVoBndArpYrRJ3aVLb+641EUnOrLV0
         b5zzMSUAQL3L1JdkDRnrZByXy1YezzbHlXNeAKciGJjNOg45dHXjhp4wpzi+WM+S8oQo
         9fNy2aHmtk2hSP/CjQbHM4OE4bZvYelfva4TfsfAGbPVF7UMSsvcMwgXAdy77c2A0Oc3
         /6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701764130; x=1702368930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynnvl8LsLrxfDj7bKNLo1dnw8JKtWg9wpT6p42z0kYs=;
        b=vOYLGonhfX5YLaEU8cS3nEY915WGD9QXPzlX5NY5YdjCtscwSB00npB2ztsAkOeQ5P
         Jlm3sreqn6EobMXxJbQFLFbjHiniwxNLYZrs6jJzSdw6n0gP3Xu7dR5KBpVXGTkBduwD
         7YSnSSn3K06/8yOR1jgwO7deUfnzc6+UyQJu/JKDq44XZShyrw5GHjuom3s0Sw8q+ro1
         TTlnquYiArlibdmjhUrkaCRwRUU3QXUSuNGHCSbgY+K2QWER+ny9svqwav3k9E2FygyM
         p1mAAMaPP0e+7y0JaSOwHZbESdrQ9DduRxzdIhsq/g1YGYL4hpd5ycnrdj/9kLF3oxrW
         R39w==
X-Gm-Message-State: AOJu0YxocAPqStwpr7HVPXCe7IsAEKEG8vjrk3aM8R/Xgc4ZfO4zKzBW
        vAo3dVWfxuizpQ6hLuTxWmjSeAGdnm6fK4JpJDFgdw==
X-Google-Smtp-Source: AGHT+IFNWdVhhSQl5FTZcEdFUQFcb28k663ttPMC6jRcM8Ukfae+es4lkf8WRyKmWGpUYViAefmyfT2whU+s1YSg3k8=
X-Received: by 2002:a50:aacf:0:b0:54b:321:ef1a with SMTP id
 r15-20020a50aacf000000b0054b0321ef1amr419141edc.6.1701764127887; Tue, 05 Dec
 2023 00:15:27 -0800 (PST)
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
 <CAD=FV=VqmkydL2XXMWNZ7+89F_6nzGZiGfkknaBgf4Zncng1SQ@mail.gmail.com> <CANn89iLuxfSZs+HV6-3=2FJL_KHg3=7WLZ109VXqsXO2-k+KvQ@mail.gmail.com>
In-Reply-To: <CANn89iLuxfSZs+HV6-3=2FJL_KHg3=7WLZ109VXqsXO2-k+KvQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 5 Dec 2023 09:15:16 +0100
Message-ID: <CANn89iLugAraF-n-PE72k2g+OUo9T0RcdC+HbKAKRZW-cTbHsg@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To:     Doug Anderson <dianders@chromium.org>
Cc:     Judy Hsiao <judyhsiao@chromium.org>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

On Tue, Dec 5, 2023 at 9:00=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>

> Please Judy send a V2 of the patch.
>
> I gave feedback, my intention was not to author the patch.
>
> This is standard procedure, I now realize this was Judy first
> contribution, sorry for not making this clear.

I meant : "first contribution" in a networking tree, let me clarify that.

>
> I will simply add a "Reviewed-by: ..." tag when I agree with the result.
