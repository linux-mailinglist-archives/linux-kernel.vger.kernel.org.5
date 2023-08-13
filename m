Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B0577A63C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 13:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjHMLjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMLjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 07:39:09 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F9110C1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 04:39:11 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41007b45418so5016081cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691926750; x=1692531550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNaE4Lf3OwAauzesLxWLEJGdibhMJMcTpGIKkUNUZwA=;
        b=KecGN7lWTrxZzwVBxQM4BtcgY9PlbsBLgCEP8VcyJAi3+4GYVoep4ZsuPAM0EKpQ23
         +0h2y9G1c+BSpeS8dUracJES6Wzo3fMQP9wAyK5gxtoo3h07+19XRT4TUotiJdBnEi9n
         nNZlGeChG1nM4oQK67qdY2ohX3oFXtTRHqUJ4sbGg8wDplNXT4cDK5OdlZuzwVJPwEg5
         JmpISBLbGOBfYxtSQooPvNGGQ/2Mn8QC4FUT/C412EmeZM14+/n7Xq3s5VWRCBhq7hmw
         9kfiQ8ZGzoVrNWpDBLHabNDmYvRS63QMtWVVvEf9b6FwiN04D5dBzH+ACn4fgCSwbXx+
         avmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691926750; x=1692531550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNaE4Lf3OwAauzesLxWLEJGdibhMJMcTpGIKkUNUZwA=;
        b=dSDYqFjzU0Fst0FVYLFDKzWBL8ld42uGumm6ffGp7x1P2w5LVk5pMzlUz8qwKBWQDO
         mfn8MlBDu0crFo1vC35cOAEsaBvcREehn/YNzVVQ7TQcSt2DYCxhkSSsZo+wSphNqYEF
         HO5QCHc09UGRH2q9EEvIg3mTREyLDJM7iONgZh/POXCUdmciR+qDDhvsuDc4HKzyl1Gs
         LGH6nUOaLm/POxnf8e3wW3X1lM7sl2jYOSOci8yR8VR1nVFa6aXX8HvkGmVAeSnR3wF2
         NLx8Z7JxzErYscUOZj4kVopciQ+rJxzR6Tm/LiwVlt4XCySFqrJQsw6kyzyblLWGX/c/
         /RSA==
X-Gm-Message-State: AOJu0YyZJJBjbnqdHARc+CqonmNMRbyYITOjIccJoA0SDfkwLnhIqWug
        NruXUUUxYnyYFziLeO4Q04P/QVpyxkxyQlhUD+pE5YitHz/nojC3/YY=
X-Google-Smtp-Source: AGHT+IEt+esBelBipZmBCOlvjdk/cl1H1+D6Ii/tWMg1QG8OpIivJjulQbApwLkKUJVsaSP+ItlBv2xbG6ipqpPuYFE=
X-Received: by 2002:ad4:5c4c:0:b0:63c:f852:aa30 with SMTP id
 a12-20020ad45c4c000000b0063cf852aa30mr9690587qva.0.1691926750560; Sun, 13 Aug
 2023 04:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNTaNw3q1OciYq111vdr+-ouaRVmwVqVJH4iT0NqxFAcQ@mail.gmail.com>
 <20230813082413.GAZNiTLaOxUNUHPvlf@fat_crate.local> <CABXGCsNoNaGLsuvHLRA7aG9FCckQpnXaXWoUGvRwzfRKNB4xzA@mail.gmail.com>
 <20230813093502.GBZNijxgueFxBTxWwG@fat_crate.local> <CABXGCsMrNz2SPYN=zLZTT7jU4axSi-XLm4bTm7K3NuWnc=yr9g@mail.gmail.com>
 <20230813111425.GEZNi7EXyHOLQTNzFg@fat_crate.local>
In-Reply-To: <20230813111425.GEZNi7EXyHOLQTNzFg@fat_crate.local>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sun, 13 Aug 2023 16:38:59 +0500
Message-ID: <CABXGCsO5=tEB29apcnPRF92yLQR-LD--vSGYPfLWAm0Z+++HRw@mail.gmail.com>
Subject: Re: [regression/bisected] Add IBPB decreases performance in two times
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        x86@kernel.org
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

On Sun, Aug 13, 2023 at 4:14=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> No, you have to specify it explicitly. The default mitigation is still
> safe RET.
>

Too sad, this means that others must also face this problem. And not
everyone will know about a possible solution. Everyone will see that
the processor is simply running slower. Slower builds kernel, lower
FPS in games. And the slowdown is exactly two times. If there is
nothing to compare with, then everyone will think that it should be
there.

--=20
Best Regards,
Mike Gavrilov.
