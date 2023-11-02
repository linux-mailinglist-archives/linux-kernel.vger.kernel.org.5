Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7023F7DFC01
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjKBVct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjKBVcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:32:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA5818C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 14:32:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9c41e95efcbso212642466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698960761; x=1699565561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vq5NPo4MczJen086IQAvce9UPFocIswVxg9xIedCGQw=;
        b=xgRMslaT1VfBaZkQ3faINVjc8DK09pbRq+078Ra9cm8HShgS9Yn5RydVFqI+QM9znk
         RlVzg7etf8M5Hjbpd69AbTwZtg0TpPg0J/QRDzjN5iNCkDEO6YY1a8VVLkDG8y32St16
         4PyTJKsiogtPLZvPTCF5GBhco3Pw2NaKkTAMAV8De2SPe5f5UrZvLotWvdj1Blpb8A0N
         XL78pkZGq52OrQ0Xb36Ui+wPT/umzNj5EkqT/iJJ6ng19etQRvVYn+L4zu8qqxFciOkM
         ipw1zJ0xqZyHQnbzNhU2Uvv2/Novby1zLlO0I1vW0gsu4eJzx2e7U6wCfz73AXCppLV2
         WH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698960761; x=1699565561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vq5NPo4MczJen086IQAvce9UPFocIswVxg9xIedCGQw=;
        b=mF7GTpzYeSIZz/odXtyuikaQWVuTP/NGSDEw7a0jfqkHc3qANrBZnQ5CsfRDMs44yK
         GaT5R+u/YhUUvdCLGPRFcD+miF6+KvDkXtJ1IjDDvu9UMxnr4AsZhthHzc6ujiyfZmnA
         rtV4fzZ9oJ5QpTsIJ68tOj2+xpT9UkB0pRWaxIvyb0T1bZBLjfE5dWuU6IvcwiDz6j5l
         a4s/kctlhi91aI7vh/UGjBJ2M/QaHw6XaJsZaJ73+ryz3ev4ZZKOkFsTNYCRMI6RkISd
         SLaKQ+saK7MJlbixDjGnFv9xWJJ6ARXjO7Zh4yoauhhpfoQT9cWPDPC3YSq8FkfFRs89
         APNg==
X-Gm-Message-State: AOJu0Yx1J7B/O1WhUG7ePOUvAqEd6Ovzfv1zTMbenjn/K8yUOerdHOJX
        D46fD2/kXyPC3LiZqlVXJ8NkY6UIFXNyTGu3Aous7Q==
X-Google-Smtp-Source: AGHT+IGyZP9u6aAbNP6NikHtNCgyA7xGVqp3DPsClZgLA9ftj3/+w+BBKe6H9xBGihWxGn5Wl/jeqaf7Czg+Qc1ZkLA=
X-Received: by 2002:a17:907:954f:b0:9c4:4b20:44a1 with SMTP id
 ex15-20020a170907954f00b009c44b2044a1mr3798351ejc.65.1698960760931; Thu, 02
 Nov 2023 14:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231028003819.652322-1-surenb@google.com> <20231028003819.652322-4-surenb@google.com>
 <ZUAOsn9Fj/qCo+xg@x1n>
In-Reply-To: <ZUAOsn9Fj/qCo+xg@x1n>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 2 Nov 2023 14:32:02 -0700
Message-ID: <CAJHvVcibtwWom6w=jdYa+712ZEVM3Kcy9RQwgfgHi8b=1nF9jg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] selftests/mm: call uffd_test_ctx_clear at the end
 of the test
To:     Peter Xu <peterx@redhat.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, david@redhat.com,
        hughd@google.com, mhocko@suse.com, rppt@kernel.org,
        willy@infradead.org, Liam.Howlett@oracle.com, jannh@google.com,
        zhangpeng362@huawei.com, bgeffon@google.com,
        kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 1:14=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Oct 27, 2023 at 05:38:13PM -0700, Suren Baghdasaryan wrote:
> > uffd_test_ctx_clear() is being called from uffd_test_ctx_init() to unma=
p
> > areas used in the previous test run. This approach is problematic becau=
se
> > while unmapping areas uffd_test_ctx_clear() uses page_size and nr_pages
> > which might differ from one test run to another.
> > Fix this by calling uffd_test_ctx_clear() after each test is done.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Looks correct to me as well. Thanks for fixing this, Suren!

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

>
> --
> Peter Xu
>
