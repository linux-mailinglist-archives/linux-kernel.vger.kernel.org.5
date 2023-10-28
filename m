Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B017DA7CE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjJ1PbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjJ1Pa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:30:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04D9F1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 08:30:55 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5afa5dbc378so12737227b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 08:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698507055; x=1699111855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHGCwgjZIqGB+kWVRXo5SM7mjEuCPP1Ig0m992rCBoQ=;
        b=CbZ1NdCoQLPZ1qu7IsHXCU0ZJGONRrKcsqbkkItQxcMm459LYJZy7ovZop10Hl/PuL
         MnzQrLyLsxsG6wEtoHmEBCN3Jj3DYxuXbnrh7WgnQNCiPjBws3InUIIGPfaDj55ZRLFS
         jQ2P40f3wcC9jmh5TNGSq4RbKBDyCmUlHzh+69V6gEOEXARPjjtdTc28N4CPSr8CNq2v
         sxChq6VkPjgGxbbMIiO0oTNG/SFIZoPnJiX+DqPRFcDhb0SVqwHrkkyR+pnG1HsZjywD
         UyfuEY7DIlS+JjjodOH89TCbVppuUdcdjgQ0SLX3w+d8KKnAiz8gL1bm/T/5RPyyXli6
         x3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698507055; x=1699111855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHGCwgjZIqGB+kWVRXo5SM7mjEuCPP1Ig0m992rCBoQ=;
        b=MdTRx4p6KvwZe5NdESA4+d2fjxeIkWWW7Hwq0bySzMyYXjt5CoGRA+VdC+SuG9bgdL
         4ZPmL49CwSRvj77lD1Fdk1CTGjg+Y7WheDqMTMiqwq4GgpCG/YBENiFwJJcrCR761q3c
         Ervk+Qv52lfHbgt8WiF0RrWu16/K/lQk3mbleqFlmgUjqTZrxTJhSsnGtzqAnbVMSkQv
         2FAfYd3nPlbHeclixedy75Frnhb4S4j+ljPXCRd5qLCW3GBS0lEXM4tmcCrk8zCWxIkw
         BjagoAIxpG6owX9ubRX6+lzCdW006NpvGP3STRasQ4rND6IEtwNKbXEua1SpdGZklGR9
         MEaQ==
X-Gm-Message-State: AOJu0YwLvkSIcpr+FBrGU+nQHyEMduTM+5gZP2IKQd96iLfjXQELHEsu
        877hFipgsJIYOc9wGYDgEtq2Bq+iGePATUscGPdu
X-Google-Smtp-Source: AGHT+IG9uR0fSzLR97zYT6K+v7djYeNU4DHYZrjF6y3TYZqPUEgRIOU+aD4DsrplsrGvaImuVg2doC+UcOndx4DZjbo=
X-Received: by 2002:a81:e20a:0:b0:5a7:b9b1:c0c5 with SMTP id
 p10-20020a81e20a000000b005a7b9b1c0c5mr4498364ywl.3.1698507054876; Sat, 28 Oct
 2023 08:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231027125226.1ae3d41c@canb.auug.org.au>
In-Reply-To: <20231027125226.1ae3d41c@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 28 Oct 2023 11:30:44 -0400
Message-ID: <CAHC9VhQ3CVYJw2Xf92P34GUA-Xvy8OABdBghBn9xfV0fCm45KA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the security tree with the
 asm-generic tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 9:52=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the security tree got a conflict in:
>
>   arch/ia64/kernel/syscalls/syscall.tbl
>
> between commit:
>
>   cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")
>
> from the asm-generic tree and commit:
>
>   6d54f25e4605 ("LSM: wireup Linux Security Module syscalls")
>
> from the security tree.
>
> I fixed it up (I just deleted the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks Stephen, I'll update the LSM tree if/when the ia64 code is
removed from Linus' tree.

--=20
paul-moore.com
