Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EFC79EE12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjIMQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjIMQMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:12:07 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D769695
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:12:03 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59b53488f7cso59636607b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1694621523; x=1695226323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlCwcmUEoeklmLodotE896hz78hDOYQASBGVLSHek9M=;
        b=QNGffN0wlDFARDvYh4sGAROCnp7YmYYpSb04UpwSCjSjomeEL9U2DY4aauveWqGUUE
         NJG+CeuhSzEqW1DLVJOIfTFCGLBpz6j65QBIfoASIAHylxp5i+mcHkfV4wqcKbCFdnlc
         k3DnGxpIO3Tof+YWXzA/oMPG8p2+WCBWFyQeBePpCdkAScPPPr9VPYJGsPww1JSflYH/
         hLpB4Rit42seZRPiKbvkIio+4wkG4ZQaaIVLMBAInStvMoMZbUxYpcQoN8LER5KLQ7sE
         HFnHAemvTqXdb2tpIwsXmtXJI9kyQoJd4VyIQNjiU3zmYsh/bfIelAV6ocaBHKLtmgz2
         On0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694621523; x=1695226323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlCwcmUEoeklmLodotE896hz78hDOYQASBGVLSHek9M=;
        b=AVnD5BZTdj8pG2i9ehjcErmUNPxRZhxcoy6e7EOofhB7jCcMdXil5AfMOrdlTehfaP
         wYNjMwy/OiVtCieepa+A8AWmjLWiIMyeKbQHL/HrPnfLIKQKjkzaz+Q5I+kLoKB61xCx
         WIHADcC7j+xUfn0Kv7/Q2rUBd8aoeBbgPDvJ3JzJ6D0hC8ktFbglcV7tEw3TLMmgKVTA
         i7BJXH2l4XJTgOJdsNVmHOvuEBv3zGRI2XdHU19fXC7Cz1mZjq4MB0oNKM+uLQEToVvQ
         rf5aE9JD5M5yT1xq6p7OgqUuAPDsB14yKqEPL6O7g1gmZpPTFTA6ZIOxwhQrOQm5h7ak
         WXGg==
X-Gm-Message-State: AOJu0YyvwPLfebKcphGp5wNrVRBjTduHPHiVj7EplDZk00u4BetcwNm1
        Bx6kGSC2mZSQxP4q9xtki/ZuB9+0SQJmT2pu7plK
X-Google-Smtp-Source: AGHT+IFsqdaxaKGGMmOWHrFoE/O2srrxrPG26n/7AgIeYncrBB4HMhfIY0VnkHAWQR0o3vt9mSH6r8Dj+ssy2XibnX4=
X-Received: by 2002:a0d:c9c1:0:b0:59b:49a0:eec0 with SMTP id
 l184-20020a0dc9c1000000b0059b49a0eec0mr3538227ywd.12.1694621523053; Wed, 13
 Sep 2023 09:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230818151220.166215-1-cgzones@googlemail.com> <CAEjxPJ7_CMFvRHFp1HVV+ppZEXPkWG6oH1MMEbjFESH44wZukg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7_CMFvRHFp1HVV+ppZEXPkWG6oH1MMEbjFESH44wZukg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Sep 2023 12:11:52 -0400
Message-ID: <CAHC9VhTiuZRCm2E3DkB=zD8R1OZccSCpsbr2mB=aOPGXkjUhhw@mail.gmail.com>
Subject: Re: [PATCH 2/6] selinux: dump statistics for more hash tables
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 7, 2023 at 1:42=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Fri, Aug 18, 2023 at 11:12=E2=80=AFAM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Dump in the SELinux debug configuration the statistics for the
> > conditional rules avtab, the role transition, and class and common
> > permission hash tables.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
>
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/polic=
ydb.c
> > index 84f02d4f8093..932e383bcad6 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -1158,6 +1158,8 @@ static int common_read(struct policydb *p, struct=
 symtab *s, void *fp)
> >                         goto bad;
> >         }
> >
> > +       hash_eval(&comdatum->permissions.table, "common_permissions");
> > +
> >         rc =3D symtab_insert(s, key, comdatum);
> >         if (rc)
> >                 goto bad;
> > @@ -1339,6 +1341,8 @@ static int class_read(struct policydb *p, struct =
symtab *s, void *fp)
> >                         goto bad;
> >         }
> >
> > +       hash_eval(&cladatum->permissions.table, "class_permissions");
> > +
> >         rc =3D read_cons_helper(p, &cladatum->constraints, ncons, 0, fp=
);
> >         if (rc)
> >                 goto bad;
>
> Do we want to embed the actual common and class keys in the output to
> distinguish among the multiple common and class permissions tables?

That seems reasonable, were you thinking of just adding it to the
hash_eval()'s hash name string, e.g. "common_permissions[XXX]"?

--=20
paul-moore.com
