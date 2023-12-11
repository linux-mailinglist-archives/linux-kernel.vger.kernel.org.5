Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6EF80D0F1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbjLKQQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344880AbjLKQPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:15:53 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8F8106
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:15:26 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5c08c47c055so45001077b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702311325; x=1702916125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnRSD+sBsefYYvzn3oBRGskx6xnKDW8P+HTWAzvULNU=;
        b=WL1ZZUAiHI3jgra1bD3B0ZPJ4M8B2vD6DgLOkWeDTst2+Vp15GKXhSfBYuhwURIoJe
         hSnt9KjWm5kY4+iJZml9qKbwHnM1vVJZhKTi8zzlYcifMGm5NSm/nU/Ba3JjbQoRIfel
         dpYl5avD1kTMoB5uQXrJ01mclOCcDTRmCkW02YA5WI7POdKbO3oigZhr8tarQEyBT+/e
         On7qNyOj0csaOO5VnIF+Loe57thEXJuzC0lvWd9vvO0SH3906PQiLICfrOrOh36jUW4a
         kwJMiyoHgQassjGvZ4SXcpY/kssjMkKC4xn1VumguyK+eqvZo3gQ38OwfTOXeJP8tJPK
         rNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311325; x=1702916125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnRSD+sBsefYYvzn3oBRGskx6xnKDW8P+HTWAzvULNU=;
        b=OI6e2OK6ymssDEYjBzZ02hGGy6rhYhqrmICPs8ZIB6ho8N/yi2tHVdFZ6J641h6kth
         lTtEP/D0vO6CRwZDnxCkU27A9FTOuGfypARrMwqr6NyU4sWdlLdUE4Fe4oI8SaGk9H9u
         KW0vsXKTujMIvG4QBgcjdZOUiiG/2aKc1GUPBLatLxFeGPCPRoZhvs2Y9sV7IM5wjFDj
         FRp7QYoPjsNsSD0R/SGPk4yk25xDh6XFDvp9OGFrIG4rmaxWnWmwbWNm3+gZrRUspKo+
         7Pvd7d7+vkcmdf3kQocC3ikZIKhFotXux0dfbI/ykjSHZ1Kzm8OvLtirGXh42UtgVWbB
         eVBw==
X-Gm-Message-State: AOJu0Yz2b3ORFg3HM/EpV51PZkqZ07Zf2ThaaimGZFtGc0C8t/RUQ+XC
        jKDbJbVem5ThLjz088wg7uqsNKx5boh0ekzgHFjREg==
X-Google-Smtp-Source: AGHT+IFtvdYDtV18pDROt//QGcMAArJtde9LSDLbsQOqNXlre7oPEzwTXObS2vRBaJiNoebZprMpaahUpj+4Qgxz+Yw=
X-Received: by 2002:a05:690c:3749:b0:5e1:8875:7cc2 with SMTP id
 fw9-20020a05690c374900b005e188757cc2mr464939ywb.15.1702311325143; Mon, 11 Dec
 2023 08:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20231206103702.3873743-1-surenb@google.com> <20231206103702.3873743-6-surenb@google.com>
 <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk> <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk> <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
In-Reply-To: <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 11 Dec 2023 08:15:11 -0800
Message-ID: <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
To:     Mark Brown <broonie@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        ryan.roberts@arm.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 4:24=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Dec 11, 2023 at 01:03:27PM +0100, David Hildenbrand wrote:
> > On 11.12.23 12:15, Mark Brown wrote:
>
> > > This is linux-next.  I pasted the commands used to build and sent lin=
ks
> > > to a full build log in the original report.
>
> > Probably also related to "make headers-install":
>
> > https://lkml.kernel.org/r/20231209020144.244759-1-jhubbard@nvidia.com
>
> > The general problem is that some mm selftests are currently not written=
 in
> > way that allows them to compile with old linux headers. That's why the =
build
> > fails if "make headers-install" was not executed, but it does not fail =
if
> > "make headers-install" was once upon a time executed, but the headers a=
re
> > outdated.
>
> Oh, it's obviously the new headers not being installed.  The builds
> where I'm seeing the problem (my own and KernelCI's) are all fresh
> containers so there shouldn't be any stale headers lying around.

Ok, I was updating my headers and that's why I could not reproduce it.
David, should the test be modified to handle old linux headers
(disable the new tests #ifndef _UFFDIO_MOVE or some other way)?
