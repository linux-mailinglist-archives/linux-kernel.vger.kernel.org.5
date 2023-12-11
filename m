Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94A680D288
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344884AbjLKQnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344613AbjLKQnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:43:12 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F88CB3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:43:17 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-dbcb1d23163so286072276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702312997; x=1702917797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9N+ZFziXjdSw2YHfmDnkRoyHHr1qlwBSocqQcY1TWQM=;
        b=Hk4xrQvHZbaQQa2Q9/6ImbEhqs5RE4Ju+k7KdVg4jueISZpjBws/Vuh0zUQsGU/aKR
         nOuq+eBuCnnYEW5R8hHzdYO6Vm1NhnByXq6wCF5DclLPRxjTPwDdhnEP0luvow3Lo+8K
         CTXw4nfNFTXUQLiAqZ5BJnCUpSfXdavk1XKe2s5ORzv1Cc4vwxCBlJ7s2GZeeaXJqcsT
         qNWN0gKI7j74/sfXbqT9GRmvs9Sy2zGS+nGah/UvGx2XoNaDSScyOpYSavyFScuRaXmd
         gH4xh0KWSVV4uxk4KQldLBILL/22N2K5f4JPrX3rfLfe6n/ftm+iEd7syqK7XVKs/Y4F
         XJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312997; x=1702917797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N+ZFziXjdSw2YHfmDnkRoyHHr1qlwBSocqQcY1TWQM=;
        b=gasahDw7P9IXx7rBZVACkhiqiYjUjAS1Tpa89oHfxZbfFENzJ9Ho7EuXqk9U5TIp2M
         GnkaRUCfA38/JzmGHA2GC3Fw2cx47BpA/vBxdX9XEguTtzFrFJUR467/2X+vz+BTplZm
         f9Xn2QDnjNZRbnfAMSNwHTR1nWFKDKEvnHheW8ArqkDuC+YOGTuA5X+o92FNW05gUrkQ
         AvuI2NTfyvDMxK/UcIdkxWV74SgQy+rZZxFgo+pbnNJB1CGmTwHlMhYK9Hmu9AfUQgkn
         opVOZ+N/s3zpo5tuH9BZIQMi8G5dEQqMFX3iojmq4bAyNkaqj5uDc7WYZ/foxFneFLE1
         GKRA==
X-Gm-Message-State: AOJu0Yyi5syTS1Pqzy64Mu1cOpoPRt2sJ1d8htpA0XqKS7Idc+/8aRIj
        TDEByvfewrdweryBkB5EbT9fCHtEriOOjvhBg1skJQ==
X-Google-Smtp-Source: AGHT+IH64hTzUfqokLkrmNt8XUgUbnYPQ5guBW2a+l70MLnxJeOCxxtEc/KpviRLotGVrRItTmgjhx1XKWmww9qpojI=
X-Received: by 2002:a25:7690:0:b0:dbc:ae1e:a987 with SMTP id
 r138-20020a257690000000b00dbcae1ea987mr583642ybc.129.1702312996550; Mon, 11
 Dec 2023 08:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20231206103702.3873743-6-surenb@google.com> <ZXXJ9NdH61YZfC4c@finisterre.sirena.org.uk>
 <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk> <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk> <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <9d06d7c1-24ae-4495-803d-5aec28058e68@sirena.org.uk> <CAJuCfpGEbGQh=VZbXtuOnvB6yyVJFjJ9bhwc7BaoL4wr1XLAfQ@mail.gmail.com>
 <915d2f82-0bcd-4992-9261-81687ca16e9f@sirena.org.uk>
In-Reply-To: <915d2f82-0bcd-4992-9261-81687ca16e9f@sirena.org.uk>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 11 Dec 2023 08:43:05 -0800
Message-ID: <CAJuCfpENZF3mMNuwVaff00hRnazTFbE4A5kaYuUiZCpuHr06Cw@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_XBL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 8:34=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Dec 11, 2023 at 08:29:06AM -0800, Suren Baghdasaryan wrote:
>
> > Just to rule out this possibility, linux-next was broken on Friday
> > (see https://lore.kernel.org/all/CAJuCfpFiEqRO4qkFZbUCmGZy-n_ucqgR5Neyv=
nwXqYh+RU4C6w@mail.gmail.com/).
> > I just checked and it's fixed now. Could you confirm that with the
> > latest linux-next you still see the issue?
>
> Yes, it looks like it's fixed today - thanks!  (The fix was getting
> masked by the ongoing KVM breakage.)

Very good. Thanks for confirming!
