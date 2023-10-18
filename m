Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951EB7CE040
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjJROkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjJROkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:40:40 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884B9AB;
        Wed, 18 Oct 2023 07:40:38 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9abc069c8bso7216331276.3;
        Wed, 18 Oct 2023 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697640037; x=1698244837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNv8M58yyPVg5uvKIwOx60Ldf+nVn0ykDKlqkzwcMQ4=;
        b=HnzJ8oOuERbMsiH8fKQk9Humoddf8bJIhljCPtSFWO8/JZvsXBxjF/0Nk5k/56piN4
         W4DK2DTNIDRA+DibwPLcFVnmLRqr32+vY/fCamtqezwoFxbtwPIf5EUnkzdmkde6fQ/j
         sCFoyIZpCHmNgr8/59DQJBanEeXjWe1l9+rD036dQdYji2nSK0GU8+TjqP3a3uBBzpxr
         ZZgvRz7rQYMY7tUaDlHBxXTM25bE/v5Dt6a36ySLwWJIXteytPnTVtlySQGJ0plQg1cO
         +fMrKBgKzUTByyfXiSg3WLxqfuWLfP9erMn1ee8IV7u55zKs/V/ImpKd0mwRmfaDKBRc
         fUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697640037; x=1698244837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNv8M58yyPVg5uvKIwOx60Ldf+nVn0ykDKlqkzwcMQ4=;
        b=SJ3qm8vzXkJup0J9/XJYNAji/3zNyAIaEypVNnScOx0Fd8aDBwlPFqE38dXXb7TMUM
         MVQ2B3j4sKXltIc44D8A0MVlvxouZV0thkn00rb1VjXpumDJ4bjgr5XXyy8nZdaTXG+t
         ywqlVomQAv4VClmG02P81XfVVNmGZLb+1UGGJMpDE/TMUASC1CsLliTZQvwBZCP0Lz9T
         y3RxdRywjgLbOaVLlZyGmKmlttWE1xqvnrkt3/y1J6g8Vok6Iko/mWtcqrh7wuaA/Ex3
         +SnsaeGhrf1DZe1X2w+CBP4SCc9A6c3K2iNUiLQwUMCgaA2q0xhehndb+XCQvKxOs1f1
         c19Q==
X-Gm-Message-State: AOJu0YxEPt1TsDQMxe3e9Ch9PrrjAEd6k46zYtm9gBwqL4pBTAExg6XK
        kIBuDjSMGCkpi/3ZIPDT1K4S4PP3v5usCLIPk00=
X-Google-Smtp-Source: AGHT+IHJBSmMP2EVuH9Btz7PWxUtHiy8BjT2/gXVTElhQYOk7FNM4ZHT9ysxYJisRu4kpRaND+qRh/8VbZ0QGGHZjcQ=
X-Received: by 2002:a25:a2c2:0:b0:d88:a049:e901 with SMTP id
 c2-20020a25a2c2000000b00d88a049e901mr5679424ybn.7.1697640037733; Wed, 18 Oct
 2023 07:40:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
 <CAOptpSMSpuU_NDKNPKRk1ZS76KhOfCmSeB7YxbD6jvNpvNGZPg@mail.gmail.com>
 <0091a3e7-d3cf-4572-af46-79adbde42ab8@acm.org> <8877db4d-50e2-d814-484b-c2ec501f752b@huawei.com>
 <3e7cd38f-681b-446d-9c16-a694a8d03497@acm.org>
In-Reply-To: <3e7cd38f-681b-446d-9c16-a694a8d03497@acm.org>
From:   Wenchao Hao <haowenchao22@gmail.com>
Date:   Wed, 18 Oct 2023 22:40:26 +0800
Message-ID: <CAOptpSMnGyc5cjkxuHvLCsv_DaS8e9maCkCyp=vGne6KDX43eg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] SCSI: Fix issues between removing device and error handle
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 9:51=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 10/17/23 18:37, Wenchao Hao wrote:
> > The previous version was posted on 2023/9/28 but not reviewed, so I
> > ping soon after repost.
>
> Since a repost counts as a ping, I think posting a ping soon after
> reposting is considered aggressive.
>

I didn't mean that, then how long is appropriate to post a ping?

Thanks.

> Bart.
