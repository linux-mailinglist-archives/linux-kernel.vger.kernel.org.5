Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 962477DA7D3
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 17:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjJ1Pc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1PcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 11:32:24 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78AFCE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 08:32:21 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-da0344eb3fdso2306080276.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 08:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698507141; x=1699111941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9xPC9NHDnis/tKwqDaO8Fh0oY0AWUAqa7N79wuFtP0=;
        b=AftYDS3AppvSwdOq3+MUKRr1+B5oaovB3F0BIwxfDF/lnbL3/gUAtNZPDRMoELf/G2
         5ylcKmJtq920s6qckXiVvVZZCG2Ze0T9S+JxH41YrAnMME/ef2hM5r+g8NwBcRekdxwH
         qTUeP5safmdOaJQRCLDEmf8A3+VWUGbsCezrjhCwQWYdrWTGllxuj5iXVtwQLZCQEM6P
         JSqgpzyEEKcySDFNjG1Xe3ahKQCAIgoAe/Tqzs2zco8gu81L3MVr8XYcNcGXMtUO5YoT
         kziEV3aq5zTrSyYlYM3LMZoCAQ7qlnjKsJlvFgVCqrdnmRtmcQBZ5dOtsHV+pHZaFm7E
         Qb2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698507141; x=1699111941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9xPC9NHDnis/tKwqDaO8Fh0oY0AWUAqa7N79wuFtP0=;
        b=WreaeEULDf7JpgnMR+Z160MnBqrqxTu3A0zt2+Rnc1MU4XgR3Q9w3vhVaNgRceCe1D
         /2E5kox0orU7ezZC0oUUAvO/tvhaffJfcQsnZzNcjdSVXFehBhAX5ce/vpu0nX9+v3MG
         7VBvrzdxM6lQ78uKGVASPHCYa1z9hi739PxCN+4hD370e4kXuzIPqY2F+oZRYLUguKBN
         Qz50YnG/pV2vdm20QtkHP0yPueNxtfbHSnm42Y7EZ2TcekrwjfsC3OYfnfRq0x7R09K5
         olNRCJjXDEf4twBSJMDz1nwXFeg5TFZYpxLcaQ/JFS2C/E1dQdQzW8IIJR/BMXpVb+so
         rrlg==
X-Gm-Message-State: AOJu0YxO/Ggc/a3gz+Gc1Zynw6IMb2soNfY3/1/4nPXUOsvMbEDuHnsk
        toHJLQ7dxILOBZPX3r/Q5oz9GQJPc8tW8sSN9C+q
X-Google-Smtp-Source: AGHT+IH/+cFzrYWntaF2t3N6XBlCbFamqUfA6rqLbDa1k+5nR7UoY21wECRbfQxJnJKSh5KxSsQUJ9HSmbNH5FMQBLI=
X-Received: by 2002:a25:7694:0:b0:da0:cea9:2b43 with SMTP id
 r142-20020a257694000000b00da0cea92b43mr5296609ybc.41.1698507140829; Sat, 28
 Oct 2023 08:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231027130320.69469330@canb.auug.org.au>
In-Reply-To: <20231027130320.69469330@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 28 Oct 2023 11:32:10 -0400
Message-ID: <CAHC9VhQ+Nt7CrLxSZcOVNEtAypruOmM0ST0P0JJMrOq4XYmAkw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the apparmor tree with the security tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:03=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the apparmor tree got a conflict in:
>
>   security/apparmor/lsm.c
>
> between commit:
>
>   3c3bda37ca1d ("AppArmor: Add selfattr hooks")
>
> from the security tree and commits:
>
>   bd7bd201ca46 ("apparmor: combine common_audit_data and apparmor_audit_d=
ata")
>   d20f5a1a6e79 ("apparmor: rename audit_data->label to audit_data->subj_l=
abel")
>
> from the apparmor tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks Stephen.

John, can you take a look and make sure this is correct (it looks okay to m=
e)?

> diff --cc security/apparmor/lsm.c
> index 5e16c03936b9,4d34180e9799..000000000000
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@@ -771,16 -868,11 +917,16 @@@ out
>         return error;
>
>   fail:
> -       aad(&sa)->label =3D begin_current_label_crit_section();
> +       ad.subj_label =3D begin_current_label_crit_section();
>  -      ad.info =3D name;
>  +      if (attr =3D=3D LSM_ATTR_CURRENT)
> -               aad(&sa)->info =3D "current";
> ++              ad.info =3D "current";
>  +      else if (attr =3D=3D LSM_ATTR_EXEC)
> -               aad(&sa)->info =3D "exec";
> ++              ad.info =3D "exec";
>  +      else
> -               aad(&sa)->info =3D "invalid";
> -       aad(&sa)->error =3D error =3D -EINVAL;
> -       aa_audit_msg(AUDIT_APPARMOR_DENIED, &sa, NULL);
> -       end_current_label_crit_section(aad(&sa)->label);
> ++              ad.info =3D "invalid";
> +       ad.error =3D error =3D -EINVAL;
> +       aa_audit_msg(AUDIT_APPARMOR_DENIED, &ad, NULL);
> +       end_current_label_crit_section(ad.subj_label);
>         goto out;
>   }

--=20
paul-moore.com
