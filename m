Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E5B75D6A8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGUVfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjGUVf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:35:27 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0A93A86
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:35:12 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-579ef51428eso26807937b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1689975311; x=1690580111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhZGqswAQb0pQ9L1ZWkYOLc6gCR3h3SYPJFiQTJWHqg=;
        b=ahUw99YNs3DdsZp/HQpT2n5t5/cxcNh1L5W8NnCXbqPTy2xPT3dR6Vi4QaRY/jOTSZ
         Vl9G9oYNlH5mxVqT0p9vEHCcQT1fk1bICeogaEhJO2qTSzLNDLdcB5I+cUOe6Zuofo1n
         KCbNOc2DfVybSlAkPdxgR3jYGsq6Q4p5k3rbgbAjpA/ElI/2+fY/j1IQndtNJ0cr/W1+
         e5CXLTU8QE+LNhAWCz6YTVzo4XclevuPJ99MDx8EeyI3wUxuc0z5/5CAN7+iPfFlUe7N
         NbEGLgom61o8bKU1r9Y2lP4WTmg8aPCOga4cSbZUr6EV1WUoYBjjSgWkn53aiadKk0RE
         On5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689975311; x=1690580111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhZGqswAQb0pQ9L1ZWkYOLc6gCR3h3SYPJFiQTJWHqg=;
        b=jeYrddgJvRNTkZeh1XhN650YHbic1Pa7RNwc0fUBBZmn5tKeuValvML2HoeouU1+85
         rqZdV5FQPsPhoA9+9FkEi9CM7xtmddfbYP2d7KBW9RfLDMi2KzHpEO6pNTW51i18G/DQ
         v4zYDogMA0Mj+OwZby0wO/AaFgxU9MLlLDerTiDD2FlcAbyxz6kxARKrz/0xn2Hrn5yX
         0O5a3gYYjmtjM7SGDryi4aOTZhTd41LXjgXeAsbuM0k82Ydp2yMJCqQkgiHO1uFV+y2y
         f+hgd9OegmSZL7UjZS6SSUpNm0Pcy05QE4J/yuiWZ3QsBr3TOg8azOyMqkxBhF8PMm01
         +SxQ==
X-Gm-Message-State: ABy/qLYD7SDf0XXPKBBSSv1CbrP/3su0kAk0/97fyYipRVT1Ze7SgEhX
        yzJsuos6DLKZGzcS3HEJRO/aClg3jN9emQWlMqjH
X-Google-Smtp-Source: APBJJlHnM5RlVKK+vFrce2eT2zjq6UoxVzjNaj+DfBYDzPtGCIhOqyzJLgQZRXltGkz1TH4ZBfanOvNXOWqyBk+uWA8=
X-Received: by 2002:a81:670b:0:b0:577:3666:bb4e with SMTP id
 b11-20020a81670b000000b005773666bb4emr1296458ywc.36.1689975311278; Fri, 21
 Jul 2023 14:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230721122840.31740-1-yuehaibing@huawei.com>
In-Reply-To: <20230721122840.31740-1-yuehaibing@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Jul 2023 17:35:00 -0400
Message-ID: <CAHC9VhSm_WX9zJceFOz2fqTuqYJ+DrCen-__knstN4+7Ob4AAQ@mail.gmail.com>
Subject: Re: [PATCH -next] cred: Remove unsued extern declaration change_create_files_as()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Anna.Schumaker@netapp.com, dhowells@redhat.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 8:28=E2=80=AFAM YueHaibing <yuehaibing@huawei.com> =
wrote:
>
> Since commit 3a3b7ce93369 ("CRED: Allow kernel services to override LSM s=
ettings for task actions")
> this is never used, so can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/cred.h | 1 -
>  1 file changed, 1 deletion(-)

It's unclear to me who might merge this patch, but since the original
offending commit came via the LSM tree I figure the fix might as well
come via the LSM tree too.  I just merged this into the lsm/next
branch, but if someone else really wants this to go up via their tree
that's fine with me.

Thanks for the patch YueHaibing.

> diff --git a/include/linux/cred.h b/include/linux/cred.h
> index 9ed9232af934..f923528d5cc4 100644
> --- a/include/linux/cred.h
> +++ b/include/linux/cred.h
> @@ -164,7 +164,6 @@ extern void abort_creds(struct cred *);
>  extern const struct cred *override_creds(const struct cred *);
>  extern void revert_creds(const struct cred *);
>  extern struct cred *prepare_kernel_cred(struct task_struct *);
> -extern int change_create_files_as(struct cred *, struct inode *);
>  extern int set_security_override(struct cred *, u32);
>  extern int set_security_override_from_ctx(struct cred *, const char *);
>  extern int set_create_files_as(struct cred *, struct inode *);
> --
> 2.34.1

--=20
paul-moore.com
