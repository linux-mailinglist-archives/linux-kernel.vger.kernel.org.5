Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB147D622C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjJYHMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjJYHMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:12:35 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A17912F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:12:33 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9c145bb5bso90205ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698217953; x=1698822753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwbGfylf8dqZZHtCf2e2D7FZ7upydRRgKUPRy5QiEuc=;
        b=RYvrc4vpAYfAWRjya4viKV5VoAkN7P4P/3Q8rVc2lKGBfmDHbEaDhf+1BeSuWIitUF
         06OwNQIAO9a8zGff3qg0rlJjLHIoddL2MxkY8Nm3WMyxPeoKzi7H2748C98VEPJYMgq/
         nVBgDb38f/nIkkwGPLHedfoq+FEe49bXgxiWmt8zgv2ImqM3zLFVTc8RmN1p/hbY7fF+
         19XEjlcvqaxEKX4SxYxAEeEVQD4IPOqHTd9rNl4wMegT69pjE25brfu3kv+xXJSInhUn
         JzGqcFAGeAlH1qM2MruXBvN4OHpiB+Py6z4T0CPl/RwwGrjgRU7YL4dd/1vdtC08bSTd
         DbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698217953; x=1698822753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lwbGfylf8dqZZHtCf2e2D7FZ7upydRRgKUPRy5QiEuc=;
        b=GJqrzn6pYOleow/4hTe7g12XZWHEffBd+L7QKomVGStIEe4qGV1Nx6HiNz/di4NnNe
         B2rQ+lte6CZFnNfGGg6YnsNNjCzDkmKtOXTTcuuUOCrcJK2Nloxbme8G2Y5/cilL8AkS
         C46JKS7w8WVB5x87pGpEJ6shrmhZxLNyVRq45klmm+VDdnQr7s1bbWDmPO2pvO9hg/d+
         K9NJmwXdOx+aDUE7FCKNeulrfNqQlQle2qzaw+OKzgNcZvmC5dv37St/zZwN/e8AYP8k
         L5uo/vlPUigCmLVT2wnvgb4Hq9YpHtXiY/UG9r/9DP0CefK69Kp2Vyii53Zs90CzzZv6
         ClZQ==
X-Gm-Message-State: AOJu0Yzd9GUgN+dgBjb3K/Ov+XzksrfN7nslksLmR8sAULnIgLEy7rlN
        rI0EpWywIiaVK9clJQe7Gvx08UKJ5f5yKbAyIWh/bw==
X-Google-Smtp-Source: AGHT+IHU1BXYoAQ/WKeStF7iKz6ollBNNgSRA5J4cOXGGIgOTujOOgOlVNvae2Wn5XL+9vVCiPLu89alCeafa3ZNc3k=
X-Received: by 2002:a17:902:cf0a:b0:1c4:1392:e4b5 with SMTP id
 i10-20020a170902cf0a00b001c41392e4b5mr83859plg.21.1698217952599; Wed, 25 Oct
 2023 00:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <CALkECRjyG8AtbUunWFYErQethdyCfiNC2-ZHP6oVtO3+GHxahA@mail.gmail.com>
In-Reply-To: <CALkECRjyG8AtbUunWFYErQethdyCfiNC2-ZHP6oVtO3+GHxahA@mail.gmail.com>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 25 Oct 2023 09:12:20 +0200
Message-ID: <CANp29Y5duVTxPyB=O+nyi8r68iebvEQmcCGOapL5b8Qpym8keQ@mail.gmail.com>
Subject: Re: KASAN: slab-use-after-free Read in nfc_llcp_unregister_device
To:     Abagail ren <renzezhongucas@gmail.com>
Cc:     krzysztof.kozlowski@linaro.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
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

Hi,

Please also note this report by syzbot:
https://syzkaller.appspot.com/bug?extid=3D81232c4a81a886e2b580

Its title is a bit different, but the stacktraces are the same. At the
bottom, you may also find KASAN crashes.

Judging by the "Discussions" block, there've been a couple of fix
attempts already, but they did not make it to the kernel.

--=20
Aleksandr

On Wed, Oct 25, 2023 at 9:03=E2=80=AFAM Abagail ren <renzezhongucas@gmail.c=
om> wrote:
>
> Good day, dear maintainers.
>
> Since the email system replied that it refused to accept the email becaus=
e the text contained HTML, I sent it to you again in the form of shared fil=
es.
>
> We found a bug using a modified kernel configuration file used by syzbot.
>
> We enhanced the probability of vulnerability discovery using our prototyp=
e system developed based on syzkaller and found a bug "' KASAN: slab-use-af=
ter-free Read in nfc_llcp_unregister_device." I'm still working on it to fi=
nd out its root cause and availability.
>
> The stack information: https://docs.google.com/document/d/1gdHebCRsvVsSPK=
filcoXVu3Pctvoj2FSZCACcVYZXns/edit?usp=3Dsharing
>
> Kernel Branch: 6.4.0-rc3
>
> Kernel Config: https://docs.google.com/document/d/1WIM0btqS2dex18HQYaL2xy=
oW6WdX2TsaNguTnWzHMps/edit?usp=3Dsharing
>
> Reproducer:  https://docs.google.com/document/d/1LrgGdOgZwO8wz0opusZ7flP9=
QSFZa32GdozvoxGysyY/edit?usp=3Dsharing
>
> Thank you!
>
> Best regards,
> Ren Zezhong
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller/CALkECRjyG8AtbUunWFYErQethdyCfiNC2-ZHP6oVtO3%2BGHxahA%40mail.gm=
ail.com.
