Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A9C80391C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbjLDPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjLDPqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:46:34 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1279BB0;
        Mon,  4 Dec 2023 07:46:41 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3333fbbeab9so1629642f8f.2;
        Mon, 04 Dec 2023 07:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701704799; x=1702309599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amuIbHDzAqT6Bi8G+JeF8+U+6uTvPFyg5L8vg4OnGtE=;
        b=jiNBf39KnHXR+xpCcNzLvlEARTxj22HWfK5HZx+B0wDkr4HXzBxHIJUvskI+bQP+OK
         PtCyJoZ0kaGdJK7atwPF2AQ+jUipJE5CsC63oWFan5zpI2sSVgyerJDaPUUyXnoqV/09
         oAXn2couPit2yH7PL0JXCde30LszbobSmPKk2yz8L8XseHoTefME9oxQ/vNm3YCfuKzl
         24dGOQVisG8JwRDHBfYTTLUpfpUfigVXHWQ4C5sWv9Nt1kPqVZJYm+gJGD1a07V9o0jt
         +Jk1QU9STysfLp+wHejrdmACL4B3OPcstLzDhtOPujEvZAxF3QQ8ejSupFNbT484FFq3
         rlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701704799; x=1702309599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amuIbHDzAqT6Bi8G+JeF8+U+6uTvPFyg5L8vg4OnGtE=;
        b=kALgXUE/GQ9L58wwYQy1yyC9Vugno2nLP0m4QOsaXFIC63jCbPvdG2ahR6Mkrz/NAn
         8DtJn7i0vJMUoH+oNtiOZaGr9uzmxWSrxV3KJr1req5HSXEN63k9jiR5VxcDVUtz4gMI
         flYK+NnHL9n5/L8ZitYOA4wfL69zJFdMtBa4ziiaU0/uinoSCsyK9uva9Cn7VcOeMjqy
         Unlw5IzL3/26MalmrbNISa/NzHeh4bDAAFrQJxbrPt57ksEW0eocmJNOso9Pchwpf0S6
         fy260GjaeKQbfhv61DPbMksw2sCvZiaAXyx96V0uEvwf4hoZfYEcMfAY2+U9eLK6nzsG
         T1kQ==
X-Gm-Message-State: AOJu0YwkM2ET+jLSfHkdi0yDA5fAJzHK4nBXH55oq4mWnO/ZejeBkN8n
        1NGxigWWtOb4QqMkMQq0pHYiL3bvb9capqg5gIQ=
X-Google-Smtp-Source: AGHT+IFnfE01G1Fydy8ah3RTw57Wy7GZBdDIq6Kik/wzS2EFcysgajtUkf8AxStMS/FZ+lMMmn4QQLvddMETW2/0lIc=
X-Received: by 2002:a5d:4534:0:b0:333:2fd2:68f2 with SMTP id
 j20-20020a5d4534000000b003332fd268f2mr3128201wra.133.1701704799369; Mon, 04
 Dec 2023 07:46:39 -0800 (PST)
MIME-Version: 1.0
References: <20231130205010.it.412-kees@kernel.org>
In-Reply-To: <20231130205010.it.412-kees@kernel.org>
From:   Ronald Monthero <debug.penguin32@gmail.com>
Date:   Tue, 5 Dec 2023 01:46:27 +1000
Message-ID: <CALk6UxrWjHAfUXQZF4UcA-iwW92gpmfc41LBETC5_wDXn4zWww@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] qnx4: Avoid confusing compiler about buffer lengths
To:     Kees Cook <keescook@chromium.org>
Cc:     Anders Larsen <al@alarsen.net>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cheers Kees,
BR,
ronald


On Fri, Dec 1, 2023 at 6:51=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> Hi,
>
> This attempts to fix the issue Ronald Monthero found[1]. Avoids using a
> too-short struct buffer when reading the string, by using the existing
> struct union.
>
> -Kees
>
> [1] https://lore.kernel.org/lkml/20231112095353.579855-1-debug.penguin32@=
gmail.com/
>
> v2:
>  - Use BUILD_BUG_ON() instead of _Static_assert()
> v1: https://lore.kernel.org/all/20231118032638.work.955-kees@kernel.org/
>
> Kees Cook (2):
>   qnx4: Extract dir entry filename processing into helper
>   qnx4: Use get_directory_fname() in qnx4_match()
>
>  fs/qnx4/dir.c   | 52 ++++++------------------------------------
>  fs/qnx4/namei.c | 29 +++++++++---------------
>  fs/qnx4/qnx4.h  | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 78 insertions(+), 63 deletions(-)
>
> --
> 2.34.1
>
