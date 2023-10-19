Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA8B7CEF18
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 07:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjJSFg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 01:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjJSFgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 01:36:54 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A235AB;
        Wed, 18 Oct 2023 22:36:53 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4a4021adbc7so3095861e0c.2;
        Wed, 18 Oct 2023 22:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697693812; x=1698298612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeTuEgeZAR5PeG9CXkJkOeBEKLRDO8E7qwHgbzSQfH8=;
        b=YMlHd7IfbmNLvomSUIivTWflUydN6tw8byEB73YDSORleq9Fc8eAupxNDdskW+zLJk
         Je6hsgfjFG6YCGmomogpqTRrdSz/g7X3myZhc42QhpSibnWOv6966Clr5vk+edJ6EmM+
         B+QqLHO3cxxrZ3nuEJHdhKoHgmmEkvyXsz2cZ46fSUqVuhsgCOZjdQr4EvfKMYgixFGf
         o7Oz3uFXnuUEPyKwa1YKHj+43nwRbBDEEIFha7ZNkljvuWM904kTZKv0DPJdtTNZO2ek
         eZKNAp3A3uoCw0g6TWeHwUBwqWi8Cncy8V6Kowv8CuQb9Lkb8qyiSpmAFY5nZZh9kLXQ
         K1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697693812; x=1698298612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeTuEgeZAR5PeG9CXkJkOeBEKLRDO8E7qwHgbzSQfH8=;
        b=fKsQ+QLrCg3F5FPA+q2pASwVKidyReK5FxXMVULsjScGLHKxPkQHxOzmiUvSWV4aBB
         APuCcIs7aS/am5Oj7fYYxIA3WGXSiY0uI441KizxKtErKco+r8bVZ/FbQ4Gum/66I1/C
         HdooW0ksNmOKqyBAa/Aj0/3I5cGf2rjCfYXcbA8tYi3/VyqhATSg/Up+t8TcGH2csvd0
         1b5ED1vS7LQvhQUol2m92PvSgg085edhF25+TreN2lYvUoQb8xt1c7DoLJgUxtTi8sLv
         FVxf/ZKiiWgjKYArSNQmoek33GoGIVFpDSCrnykaklu+Aakzyb6xu67ZRLm2n181H0mF
         XxdQ==
X-Gm-Message-State: AOJu0YyF3QkJUv5HNAXLyVdesyap8sAMK2Tgww4Pnl9Pvg7b7OKHo5ZV
        /o/oAv7QdipDXivQhsuMrU9/S9X3BQvBziHfkgQ=
X-Google-Smtp-Source: AGHT+IGETPIhZCNHO7HAFXrvQgfr2sRQ2CBBFh6/pPtyxTLfNkn+hlq04xKnP/BvoC4hgaUr4c3lfX7ajnDULQGbj8U=
X-Received: by 2002:a05:6122:1da6:b0:495:c10c:ec39 with SMTP id
 gg38-20020a0561221da600b00495c10cec39mr1279598vkb.2.1697693812195; Wed, 18
 Oct 2023 22:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231019101231.174f1124@canb.auug.org.au>
In-Reply-To: <20231019101231.174f1124@canb.auug.org.au>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 19 Oct 2023 08:36:40 +0300
Message-ID: <CAOQ4uxh8ydr+YdyKtD9yR1_kpkqkt+MdjvAzkA48F2UNSxz40w@mail.gmail.com>
Subject: Re: linux-next: duplicate patches in the vfs-brauner tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Brauner <brauner@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Thu, Oct 19, 2023 at 2:12=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> The following commits are also in the overlayfs tree as different
> commits (but the same patches):
>
>   b8a42d441199 ("fs: export mnt_{get,put}_write_access() to modules")
>   5363f9742437 ("fs: rename __mnt_{want,drop}_write*() helpers")
>
> These are commits
>
>   ddf9e2ff67a9 ("fs: export mnt_{get,put}_write_access() to modules")
>   3e15dcf77b23 ("fs: rename __mnt_{want,drop}_write*() helpers")
>
> in the overlayfs tree.
>

Christian,

Did you apply those commits by mistake when you rebased vfs.misc
instead of merging vfs.mount.write into vfs.misc as it was prior to rebase?

Maybe it would be easier to rebase vfs.misc over vfs.mount.write?
with the intention of including these two patches inside a larger PR?

ATM, overlayfs-next relies on two vfs branches as being stable:
vfs.mount.write and vfs.xattr.

It's not a problem for me to rebase on any other stable branches
that include those changes if you wish to reorganize the vfs topic
branches differently.

Thanks,
Amir.
