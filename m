Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2821C762190
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjGYSim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjGYSij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:38:39 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F2B19BD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:38:37 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-579de633419so67373987b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690310317; x=1690915117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4tqWftng5Zihz34ZZJ2o62k4+GEKzXsMpDrA8+pTXHY=;
        b=A9ANBtZSH81qqxfhpPDIXRFIREEBBiwkBHMuK5V8lgo/r4pEZgyEZfcLkRk/rrGcJW
         gwNJFD3pSxdmYokhWQ8UO+Bu85pdUoHNxRGOmFiKtH8F2DHxjE3ztUOSaLhyJ4oGeHtA
         YQ4Ip3RJ9nM4B5nj2tIeykr5a1ympJMFifAmNjLkjb+CAP3qYY4uX5rv59Psf7GLGQMN
         rIMQ9H5RwOpFCaII+qaEJ0l0CkAVU8yXxymW0+PCmHQCJCt1xu/WR0/+7KhriimBsvXS
         8tt12M6m5UmdqIxK/atehqP1nY+0xeDiaurbNy0qrfkS0gGLL6Imf2EKeCt9iwZ/LTK5
         lntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690310317; x=1690915117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4tqWftng5Zihz34ZZJ2o62k4+GEKzXsMpDrA8+pTXHY=;
        b=l1YJA7OT9A5I9Uqj/+v1lf7cCZ0bPOMlML0EpDB5C+JrB22qXwYMvKxBy2OJFPEMy2
         hglHVtKjsKh0OCYvKuMqhRV1U45BM3HoBFkQy6Ah4Z83AlD84vFNnE4LamIcnUa1xI4O
         ksd9WOk35wV7LE0XtDCCIGAOJP0opFCh3B194+tRu69Vr53UL/0KMgO+Wumxr17OflPB
         vkkq0kwXFcvShLGpM75IfjdHZSKVNk25tbPvCSZayX7rp+rdZNy/34yTAnv6Zl7PfumD
         k6Ntd8NY5kRLEhvjteSJzIWCDJmgoEpQCvUm3aq8FVx13QZW0vD8Z4DO7L5EEP4A2HFD
         mLNw==
X-Gm-Message-State: ABy/qLYNEZ6E1B+1AK2S5I3WDU2ZMi90qOtBwNbG5a3IkTDY5tpMYzvY
        rmpQ6qLkCcXx09CrrdhT9Dm90+mR6Xt6PZCEcmIZhYZsU62iLNo=
X-Google-Smtp-Source: APBJJlGPf/LGegU/3z6LP2Dg6XXokJhv16FjW6ZYYINqiXtlipJBZfpbQn+eBMzUEdOjtUmr9u+tMfovTlu0nIjDYl0=
X-Received: by 2002:a0d:ce86:0:b0:577:31c6:b35b with SMTP id
 q128-20020a0dce86000000b0057731c6b35bmr74129ywd.32.1690310316938; Tue, 25 Jul
 2023 11:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230724145204.534703-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhQcVSX+kZ3PMJGJ3i-qxv9g3iP_Y4At5VCV8qSoJYj8Cg@mail.gmail.com> <a582bac4f709fe28dc17d9023ac78b53a2a1ac64.camel@huaweicloud.com>
In-Reply-To: <a582bac4f709fe28dc17d9023ac78b53a2a1ac64.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 25 Jul 2023 14:38:26 -0400
Message-ID: <CAHC9VhSbya3Q-VM8v43qkQDWCuYWFqQ801j9_HfdwWJ9RLzkjw@mail.gmail.com>
Subject: Re: [PATCH] security: Fix ret values doc for security_inode_init_security()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 3:02=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Mon, 2023-07-24 at 17:54 -0400, Paul Moore wrote:
> > On Mon, Jul 24, 2023 at 10:52=E2=80=AFAM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > >
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Commit 6bcdfd2cac55 ("security: Allow all LSMs to provide xattrs for
> > > inode_init_security hook") unified the !initxattrs and initxattrs cas=
es. By
> > > doing that, security_inode_init_security() cannot return -EOPNOTSUPP
> > > anymore, as it is always replaced with zero at the end of the functio=
n.
> > >
> > > Also, mentioning -ENOMEM as the only possible error is not correct. F=
or
> > > example, evm_inode_init_security() could return -ENOKEY.
> > >
> > > Fix these issues in the documentation of security_inode_init_security=
().
> > >
> > > Fixes: 6bcdfd2cac55 ("security: Allow all LSMs to provide xattrs for =
inode_init_security hook")
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  security/security.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/security/security.c b/security/security.c
> > > index cfdd0cbbcb9..5aa9cb91f0f 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -1604,8 +1604,8 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
> > >   * a security attribute on this particular inode, then it should ret=
urn
> > >   * -EOPNOTSUPP to skip this processing.
> > >   *
> > > - * Return: Returns 0 on success, -EOPNOTSUPP if no security attribut=
e is
> > > - * needed, or -ENOMEM on memory allocation failure.
> > > + * Return: Returns 0 on success or on -EOPNOTSUPP error, a negative =
value other
> > > + *         than -EOPNOTSUPP otherwise.
> >
> > How about "Returns 0 if the LSM successfully initialized all of the
> > inode security attributes that are required, negative values
> > otherwise."?  The caller doesn't need to worry about the individual
> > LSMs returning -EOPNOTSUPP in the case of no security attributes, and
> > if they really care, they are likely reading the description above (or
> > the code) which explains it in much better detail.
>
> Maybe this could be better:
>
> Return 0 if security attributes initialization is successful or not
> necessary, a negative value otherwise.

Well, I'm trying to avoid differentiating between the non-zero, but
successful attribute initialization and the zero attribute case; from
a caller's perspective it doesn't matter (and why we don't
differentiate between the two with different error codes).  If the
distinction between the two states is important from a caller's
perspective, there should be different return codes.

--=20
paul-moore.com
