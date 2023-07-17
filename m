Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5350756E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGQUWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGQUWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:22:02 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06ACDA
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:22:00 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-5636426c1b3so3150722eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689625320; x=1692217320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWiE3CkGTDUlj6QCNZoo/WRVOd/qSvpeFml4/GNI1l4=;
        b=Ovnxdri/2azVGDeU5lzqBST5/chKrc8SVm4zfJ1ZIpx7cAbY9GLgYW3jcUkmuzRrXZ
         TJp15XjCoBRSz+SwqIsnVjp7s+32BR8O59aTYfOZafrbnu35Q0rYYdUb/FQoyhPBd5Ec
         8BvNLgEpZKM+tKgA0N1xj77okD4qJYUJ7lngH0Gth/8PUeL8d4VVqoRw7r0RaUPsHH75
         9BAXe19pLao6COeY4AI9UBU6iTPoizkDNxAjwpzHeXNDf3nK6N+XRkZ4pl/75zxhnl5c
         Zo28RFxYzG/kSPE4WRtzNH7qcxvWXo/D1CaGaD3GkTnyjCh8qNvS2fx94AR2ITDOJgVF
         vfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689625320; x=1692217320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWiE3CkGTDUlj6QCNZoo/WRVOd/qSvpeFml4/GNI1l4=;
        b=SJ/Y+QoN00LlW798YaczlTsOlhwwiRQqDh51GE1iwSP2JykFYW8QTu/YX6B0TPI5Tx
         A+gr84M63/6CTGeznR3lajSHjTecDpnex8QGou0mgFsuMBjommiBocUlPLOj7zGWbgSY
         zXEY8WTGvbqOO00n1gXNWN0rcjoqY/1zW8f1wV7Ca3DRCQDGerqNyfu+VDDm66odfwp5
         bCPU79YrfVQ/FamoFha4Pyma9NXBoM3uwgWrDApaTGBOuFG+aFQmjyvfoRjXlOp2X7a5
         ueVd83KfaI2fwx+j99Jt+uEQ7DQ9AgFuxZjTIQ9xPfLZ1L7rSuTIv1PXV+zKZRSl3pnY
         xBEQ==
X-Gm-Message-State: ABy/qLZSjSXKyI5em08j+rELBSmVqW51v+CeexAACFd0B8kf+rqMa14G
        HC955IesuLevBJ/LcHUMYDSkmnpgBW95jp7OGATpkqATIF8zxHg=
X-Google-Smtp-Source: APBJJlFChmprhsDlKpZJ+VXqA7MXSy6U6tiLSsjYS9GovKy+o4Q7IqfJNgEAdV13vfZ/utB4reCljTFOUd7b+KXxjvI=
X-Received: by 2002:a05:6808:140e:b0:3a4:316b:42c7 with SMTP id
 w14-20020a056808140e00b003a4316b42c7mr14345026oiv.2.1689625320107; Mon, 17
 Jul 2023 13:22:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230706133751.38149-1-cgzones@googlemail.com>
In-Reply-To: <20230706133751.38149-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 17 Jul 2023 16:21:49 -0400
Message-ID: <CAHC9VhQFn1cE39YuXNxssttu1tU6oXWsYjGLSzD496Wa5-Gs5A@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: disable debug functions by default
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 9:37=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> avtab_hash_eval() and hashtab_stat() are only used in policydb.c when
> the debug macro DEBUG_HASHES is defined.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c   | 2 ++
>  security/selinux/ss/avtab.h   | 3 +++
>  security/selinux/ss/hashtab.c | 3 ++-
>  security/selinux/ss/hashtab.h | 2 ++
>  4 files changed, 9 insertions(+), 1 deletion(-)

This reminds me that I don't really like the "hidden" and kludgy
nature of DEBUG_HASHES.  What if we created a proper SELinux debug
Kconfig flag and used it in place of DEBUG_HASHES?  I'm thinking of
something like this:

config SECURITY_SELINUX_DEBUG
  bool "NSA SELinux kernel debugging support"
  depends on SECURITY_SELINUX
  default n
  help
    This enables debugging code designed to help SELinux kernel developers,
    unless you know what this does in the kernel code you should leave this
    disabled.

... and then we do all of the usual Kconfig triggered dummy funcs,
etc.  Thoughts?

--=20
paul-moore.com
