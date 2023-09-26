Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710D87AE483
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 06:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjIZEUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 00:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbjIZEUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 00:20:50 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD42E9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:20:39 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bffa8578feso133108091fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 21:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695702038; x=1696306838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Li36zbmUyy6s+dW9E67L55JpND/74r/URPr1wBjIrjM=;
        b=auS5kjkfivrF7j/nKj/90dbQta5tuODGhg6Pzd+FdEQoTnAR9wzD6SRx2uXzETLNoW
         GQSL8OPPq8zJBchBqXfDkwxuhruw7QTTVu1nKHBiJaFzxR2qXbI7MCao+0yXT6oVatvn
         32TM9t/49UqV1P+LBVq3ULfI7+Ptn0cxhJDhpDbTPi7YjZwZa1tAB197rIYYUXtusoUl
         bLvBejRlus/ni1mDoN8/j+rYGqF1l7w5iZ0EIi1if3x4yG3wQ8TTqKC5fAw3ZX6tU+yn
         D16z6dOM/zPq3geD/F9ljvjoUsl2z4sJJTyRH6Vy4wMk+BVzE6/p7zvucztC/gq/GprQ
         jqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695702038; x=1696306838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Li36zbmUyy6s+dW9E67L55JpND/74r/URPr1wBjIrjM=;
        b=NjzcNTM+v3MMY15O9LfHuzkD5axNVZdHwS58pfQ9aoZP51vGe74WElY7rBzOG1ez5i
         pVbxujPNmU4puqRYXBAA+IGV5fjHIcOOrfNZsStNm1mmqY3RW4AuMpFgrqBMEvd642TJ
         XqhVYSkwGTZhTJ4PztL7vcgI9lFIIcPIXMIOhbn4Zn7QbjLb9pCk7i67XmhoD9QcgpIo
         h8uWbBMxcaAlcbLJEsACeCgWn2j/8xby4/jFLQaec/XvapZME+ToSGw7o4Z/RL51nGxc
         8OL5hAVTezRFmplWjXtXSCp/zrcYqCAF7fqqmTu370fT5ftDqD+psPL1S9N2hdUNwlaf
         WHXw==
X-Gm-Message-State: AOJu0YxlyY17Ka+0qvghUYLgPNh4cATh3WhNvRZbqvhwqW5C5JnfQsJN
        wVprauff1NqIvGoJA8NEFkipQHrfgBnXYplNrZA5lfBTm3oW8/gzKhHpmw==
X-Google-Smtp-Source: AGHT+IEkvCHqaTe+C9BTh63er4gYYx6xBzFgCoo6j4Nql/jmV2gTohm+EMsT1nzsnEMZlt1Fkk9VQlZoksyiMSd4j3Y=
X-Received: by 2002:a2e:7308:0:b0:2bc:dcd6:97b1 with SMTP id
 o8-20020a2e7308000000b002bcdcd697b1mr6827475ljc.47.1695702037646; Mon, 25 Sep
 2023 21:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230921064506.3420402-1-ovt@google.com>
In-Reply-To: <20230921064506.3420402-1-ovt@google.com>
From:   Oleksandr Tymoshenko <ovt@google.com>
Date:   Mon, 25 Sep 2023 21:20:26 -0700
Message-ID: <CACGj0Cgh7Vjf5EcY7F+pf9bCjXhhJYN-xf3NeC8WWjT4+j9RrA@mail.gmail.com>
Subject: Re: [PATCH] ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     rnv@google.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 11:45=E2=80=AFPM Oleksandr Tymoshenko <ovt@google.c=
om> wrote:
>
> The removal of IMA_TRUSTED_KEYRING made IMA_LOAD_X509
> and IMA_BLACKLIST_KEYRING unavailable because the latter
> two depend on the former. Since IMA_TRUSTED_KEYRING was
> deprecated in favor of INTEGRITY_TRUSTED_KEYRING use it
> as a dependency for the two Kconfigs affected by the
> deprecation.
>
> Fixes: 5087fd9e80e5 ("ima: Remove deprecated IMA_TRUSTED_KEYRING Kconfig"=
)
> Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>

Gentle ping, IMA_LOAD_X509 and IMA_BLACKLIST_KEYRING options are
currently broken on all branches.
