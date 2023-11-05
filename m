Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C94C7E16EF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjKEVz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEVz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:55:26 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC5EBF;
        Sun,  5 Nov 2023 13:55:24 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d3505e1426so38811a34.1;
        Sun, 05 Nov 2023 13:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699221323; x=1699826123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PnCQo2jJdNP1v8hfPEAzBImF3kZOSlGPf3wKLl8H+0=;
        b=HuUWWkJFBxiPnBqGw1xwfMOxgx4PG2io8jzawZOEo9DKiRSWBePVu658LBhiSGvJeG
         uonwwSt0cQEpBZP/opbZI78xt1JPtzNLwCfGuZyK7Lt6FAKsFU4QaB8wNdVlxjN/ldFL
         QCdB524JJIuw3vLM0LPQaUJj4fJaE+tjM7AcM3JZkC31w3aobBr3WJy/otIEEYMfWWG8
         ChwtB/T1JaciNSdvd1uXvV2XlwMmVWmTCEssjlg+/h49hCXcGJCHez3fOHhKi2O6U+rA
         8egSFoxWF2wP6qwP6gJ++nV3flelIVk7zh1vA/RYayQUpMHXGz2zcOT7S1yAhgaRnMVp
         15iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699221323; x=1699826123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PnCQo2jJdNP1v8hfPEAzBImF3kZOSlGPf3wKLl8H+0=;
        b=ipjPh8lmnejACNZGObbZaLjG47a41ErTRDcCrrJVokxPREnq0Cc6HwcFiNmeMQGntv
         YFi1xCRA+5AxmqesGUzR9cOuwABqEFqTB11IPU68/b7De5kY9d7iXHyjAhl+oyQj8Nc/
         iZFGl4GlA3SeBlQ7+4Rc6k+WrFevEjysFCe7VD3dcICNh9hlQDb9FI2ZsOifSRqEQC79
         zsMnBRUwDqUUsVPScrzvavgaCy/pxf/VK/HmMdQo7QexuvU++PiE36kariCqsoJfuiPx
         Fp1B+wmcG6+ef0AhAbpMq+UfA1tVw3ShV0WnfH0U6ggSXWyOOS5wJkjk9RE9KwEJRtcR
         /2MA==
X-Gm-Message-State: AOJu0Yw79Q+ZD1+mlyrIzMqTCxg67Xcv1TU/xphykPUCtEy3375yCRJ6
        NEbTucIGKRcg44YrcdoaAbLKxbP7//BNQWJ4p/0=
X-Google-Smtp-Source: AGHT+IELii7XHSOhU2UCOzpOqaZbLhEI7ngf5iK2a8rNGdkzJrcVq2e/xKePZlsDxNHZXk9QOSVPQGn7Nvvso0t5Qss=
X-Received: by 2002:a05:6830:390a:b0:6c0:c1ba:8f78 with SMTP id
 br10-20020a056830390a00b006c0c1ba8f78mr31652540otb.0.1699221323646; Sun, 05
 Nov 2023 13:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20231103234247.4505-1-dmitrii.bundin.a@gmail.com> <CAK7LNAQE=ankopXh_6q=Rw+JA+MVus5jjyuS3YBoJVz4YPDB1A@mail.gmail.com>
In-Reply-To: <CAK7LNAQE=ankopXh_6q=Rw+JA+MVus5jjyuS3YBoJVz4YPDB1A@mail.gmail.com>
From:   Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
Date:   Mon, 6 Nov 2023 00:55:12 +0300
Message-ID: <CANXV_XxGCCrqeN-Yu0H4AiJwV=Ve0dF7VnJz8CWoDywU31qPCA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: deb-pkg: apply short --rules-file option
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org
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

On Sun, Nov 5, 2023 at 11:08=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
>
> I do not think it is a big deal because the version 1.18.8
> was released in 2016.
>
> Best Regards
> Masahiro Yamada

Even in spite of being documented that way the long option
--rules-file was fixed to behave the way it currently does in the
commit 5cd52673aabdf5eaa58181972119a41041fc85f2 of dpkg dated dated
23.07.18 and become available starting 1.19.1. That might cause build
failures for some versions newer than 1.18.8. I faced
dpkg-buildpackage: error: unknown option or argument --rules-file when
building the Kernel using Debian dpkg-buildpackage version 1.19.0.5
having no errors for --jobs. To avoid such inconsistencies I think it
might be useful to apply short options that are guaranteed to be
available starting 1.14.7.
