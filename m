Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F3D760194
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 23:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjGXVyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 17:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGXVyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 17:54:19 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D68194
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:54:18 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-583b0637c04so39358857b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1690235657; x=1690840457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DQnZVWxKX+0CXafj6SJn4lekIqwhPXUIrLSw0b0Ful8=;
        b=So/G3KZGtWFl9G3u0VtRaafKXrXKTw3kIG1uGlCrkctZh0r+yc2/8579W4gqddkPoQ
         YiXM8tpjpD/vewR3GLr8W9tjOFqzKpDAAyj5Y11QjzoGUdyVjEJTx52CUfAdevLX/0+k
         gct2e/EsQf0zqd6IK6R4kwjbVYDOMd3j3IYvEyyyILHoHZau1+EWVQDxhn+3/H3OHJML
         Qg4XcL4oJQtg+Ij2VnE/5sGBARqipnRvYyrfMEqXMzsbuy4tPGsXAbrtVEfxSZ7pOXM4
         qEBwUFiP45QxGgGTE1mFGVDxPz7pq1+HsF4hD4gBKTiyr1ta/YTYZfVW/ERMzVkpznEO
         qVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690235657; x=1690840457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQnZVWxKX+0CXafj6SJn4lekIqwhPXUIrLSw0b0Ful8=;
        b=ZRquZskfFgb2TGOu4HHUNqqn0EbxVUdnhBF8b+MAzTPFMemuo2Ah45+N0y73NxIoHx
         IX5MVMCU/lOuCMFzHRQRfw1mN03vSe3Q7lY9VPluTf/qjObKrnn1u4R9ZSOpItHkt3AT
         uZD8O4vgDHGTwB5/YDuv7Dla6IlqURlBz7GWYAvl+h9dTpz4s8genRIln4gIQJZRHbQx
         v2FFq/IGZTiyicgI6RhPc2WqZvKHt2rLQEXi17VQUQEdQ9iemh9WyAxBz3mWP9JQqBLr
         oTHwRfwdGj8T+/1jgqMrzEJbpXgEoNybT7BGbKdyk32JLcffb+6sOdbCfkbYU9Cz9pBE
         hcRQ==
X-Gm-Message-State: ABy/qLY5xEzC6SLKffKlOqWnh3epDc2jIbArJ4AaJewJQpmH/F6tlFzs
        GVsQlX1weYX1p/cOK0dsvUDi8hd1tNmHfIeDNUmT
X-Google-Smtp-Source: APBJJlGm86O3vRSyfJo7FzGkguVP9DN/0Kx7zG8LSr+E4dwbB1z1OOAPei8bpFNceBvParOi32TeB3Kmh32RVv+jcWQ=
X-Received: by 2002:a81:6d88:0:b0:583:821b:603a with SMTP id
 i130-20020a816d88000000b00583821b603amr587409ywc.20.1690235657596; Mon, 24
 Jul 2023 14:54:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230724145204.534703-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230724145204.534703-1-roberto.sassu@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Jul 2023 17:54:06 -0400
Message-ID: <CAHC9VhQcVSX+kZ3PMJGJ3i-qxv9g3iP_Y4At5VCV8qSoJYj8Cg@mail.gmail.com>
Subject: Re: [PATCH] security: Fix ret values doc for security_inode_init_security()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     jmorris@namei.org, serge@hallyn.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
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

On Mon, Jul 24, 2023 at 10:52=E2=80=AFAM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Commit 6bcdfd2cac55 ("security: Allow all LSMs to provide xattrs for
> inode_init_security hook") unified the !initxattrs and initxattrs cases. =
By
> doing that, security_inode_init_security() cannot return -EOPNOTSUPP
> anymore, as it is always replaced with zero at the end of the function.
>
> Also, mentioning -ENOMEM as the only possible error is not correct. For
> example, evm_inode_init_security() could return -ENOKEY.
>
> Fix these issues in the documentation of security_inode_init_security().
>
> Fixes: 6bcdfd2cac55 ("security: Allow all LSMs to provide xattrs for inod=
e_init_security hook")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/security.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/security/security.c b/security/security.c
> index cfdd0cbbcb9..5aa9cb91f0f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1604,8 +1604,8 @@ EXPORT_SYMBOL(security_dentry_create_files_as);
>   * a security attribute on this particular inode, then it should return
>   * -EOPNOTSUPP to skip this processing.
>   *
> - * Return: Returns 0 on success, -EOPNOTSUPP if no security attribute is
> - * needed, or -ENOMEM on memory allocation failure.
> + * Return: Returns 0 on success or on -EOPNOTSUPP error, a negative valu=
e other
> + *         than -EOPNOTSUPP otherwise.

How about "Returns 0 if the LSM successfully initialized all of the
inode security attributes that are required, negative values
otherwise."?  The caller doesn't need to worry about the individual
LSMs returning -EOPNOTSUPP in the case of no security attributes, and
if they really care, they are likely reading the description above (or
the code) which explains it in much better detail.

Thoughts?

--
paul-moore.com
