Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E3C7C57D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 17:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346940AbjJKPLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjJKPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 11:11:36 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53977A4;
        Wed, 11 Oct 2023 08:11:34 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59f6492b415so9836207b3.0;
        Wed, 11 Oct 2023 08:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697037093; x=1697641893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N85hn0rfHvoD3FkOQ0P6XurQeRvpI/ST4GShkVgPjjg=;
        b=iMyfoKT+DAd6kkCctNys9yNKZxr47zr1upCK6ScWzYT0EnCXC+Lx7bU8FY68UA7jfi
         iQ6xl3GzXo+3ytN0QjlHZ1WiSyjf50IuRm1cq3o8NCAbWNLQ7GqtDRTR0O/hgbgDUGJF
         06Hbd5tb7Uy5LHsB6gH6z3QYpTKzyxm+R0xGe1sBoTVC65D6AnbE0GUV6H8c/gh5pj2D
         UhlcxxZnzGaNXElL5AW9qY+wTzjh6E3b7UaG6iZrZgaKI+VFvw5ZEWDAM5iuDp6NMVZs
         lu9iZ5C2VB5CwIZD7hrsmSdlVFo/JmnRQzzM1CcAMOCxZW12nJrJomZD3Oc4ZVsChO8r
         C8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697037093; x=1697641893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N85hn0rfHvoD3FkOQ0P6XurQeRvpI/ST4GShkVgPjjg=;
        b=i9M9EsNpfWXFFkl0wBI/0V/gZOajzKndLYzjSShEvr4FPJdPG/S/Q6WDLPamXd4Jor
         VbTGYLn+E0kVGy+d7CFe6GAm9VtKGMJovdNb3Gf8JYk5EApjtgGiamuOKAnzQkOhbsGR
         jiaUnba3Ax5AbrCwGclniEjvcmtntG1IpMFQfkntWg9k54I02kUFmF3/L1jVZf0KjwhV
         tGy4Hu+IU0pupo0pKe+c0PYQ74J3AgK9Y6R8IK27UeYsk72IYArFMTTJOKHd7bUeJFty
         SfOX+KYSFLN1iVWc4vlJNQIqGWCGMGdteu8mDUSgKpc5YbfQjzzULBPrFJ79ropOzu/O
         nvgQ==
X-Gm-Message-State: AOJu0Yzr/D62SGLP1qdnG0j77aAnkfgXdZ4rDYVkLoLWImC6myJJp4WH
        2cRlKageF0qQIv7ZQMkkOaSH/VI9vKYECQ==
X-Google-Smtp-Source: AGHT+IEITYIRCAw7xbrk4SpUgLorxrDqPXRI8N71z8GtPpLPOh8h2SQhvkFU//z49RHrD/TBLsXLWg==
X-Received: by 2002:a0d:d914:0:b0:58c:4dcf:78b6 with SMTP id b20-20020a0dd914000000b0058c4dcf78b6mr12318429ywe.21.1697037093414;
        Wed, 11 Oct 2023 08:11:33 -0700 (PDT)
Received: from firmament.. ([89.187.171.244])
        by smtp.gmail.com with ESMTPSA id q65-20020a0de744000000b005a4c2316412sm5292147ywe.137.2023.10.11.08.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:11:33 -0700 (PDT)
From:   Matthew House <mattlloydhouse@gmail.com>
To:     Alejandro Colomar <alx@kernel.org>
Cc:     Rik van Riel <riel@surriel.com>, linux-man@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too long
Date:   Wed, 11 Oct 2023 11:11:24 -0400
Message-ID: <20231011151126.754612-1-mattlloydhouse@gmail.com>
In-Reply-To: <ZSa1duEmIvCb0-_w@debian>
References: <20231010234153.021826b1@imladris.surriel.com> <ZSZ7yXwYAg-xPC7P@debian> <60b4d916663ea31ae05a958b6dea8aa5bf740d0a.camel@surriel.com> <20231011134437.750422-1-mattlloydhouse@gmail.com> <ZSa1duEmIvCb0-_w@debian>
MIME-Version: 1.0
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

On Wed, Oct 11, 2023 at 10:47 AM Alejandro Colomar <alx@kernel.org> wrote:
> On Wed, Oct 11, 2023 at 09:44:29AM -0400, Matthew House wrote:
> > To expand on this, there are basically two separate byte limits in
> > fs/exec.c, one for each individual argv/envp string, and another for all
> > strings and all pointers to them as a whole. To put the whole thing in
> > pseudocode, the checks work effectively like this, assuming I haven't m=
ade
> > any errors:
> >
> > int argc, envc;
> > unsigned long bytes, limit;
> >
> > /* assume that argv has already been adjusted to add an empty argv[0] */
> > argc =3D 0, envc =3D 0, bytes =3D 0;
> > for (char **a =3D argv; *a !=3D NULL; a++, argc++) {
> >     if (strlen(*a) >=3D MAX_ARG_STRLEN)
>
> Are you sure this is >=3D and not > ?

Yes. In general, the kernel's string limits tend to include the trailing
null byte. There are two places where this limit is enforced, one for the
pathname (or full pathname for execveat) and the other for the argv/envp
strings. The pathname is handled by copy_string_kernel():

	int len =3D strnlen(arg, MAX_ARG_STRLEN) + 1 /* terminating NUL */;

	if (len =3D=3D 0)
		return -EFAULT;
	if (!valid_arg_len(bprm, len))
		return -E2BIG;

where valid_arg_len(bprm, len) is just (len <=3D MAX_ARG_STRLEN). Here,
strnlen() has the same behavior as the ordinary libc strnlen(3),
effectively returning min(strlen(arg), MAX_ARG_STRLEN). Thus, the check
succeeds iff strlen(arg) + 1 <=3D MAX_ARG_STRLEN, or equivalently, iff
strlen(arg) < MAX_ARG_STRLEN.

Next, each of the environment and argument strings is handled by
copy_strings():

		len =3D strnlen_user(str, MAX_ARG_STRLEN);
		if (!len)
			goto out;

		ret =3D -E2BIG;
		if (!valid_arg_len(bprm, len))
			goto out;

The strnlen_user() function, per its documentation, is explicitly inclusive
of the trailing null byte:

 * Returns the size of the string INCLUDING the terminating NUL.
 * If the string is too long, returns a number larger than @count. User
 * has to check the return value against "> count".
 * On exception (or invalid count), returns 0.

Thus, the check succeeds iff the size including the null byte is
<=3D MAX_ARG_STRLEN, i.e., iff strlen(arg) + 1 <=3D MAX_ARG_STRLEN, or
strlen(arg) < MAX_ARG_STRLEN.

Matthew House
