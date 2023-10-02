Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C66A7B4AEA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 05:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbjJBD1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 23:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbjJBD1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 23:27:33 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5103C9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 20:27:30 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-419768e69dfso344601cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 20:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696217250; x=1696822050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3scGPNEBOwqptWVfFKrAiu9JumQod6q+Tv1f0Kk9vI8=;
        b=p0I0WQngiMTljmtIUk48OauD++yGbo0q4BsGs1uucpi8V2/5luig3wKUKgZCXced/h
         P2tkQk3Ut/vOBa/lHXxiFpa+ScXwTzv374fCNQGQD5R+5qeF3WjSFHw/fdzWmz/cZnX4
         CWTCjSu3dbC9yryQuEo0pHJYJtQa5QeieUJNiffCp6rp9JWOTQy8vpmfJeXLFtD3Ztv5
         IAIoPfhAFPtvRvjuY93QnmQmiAzY6LxhMj78rLx0z6cIHTMErYZ98oq6Rit+bSC1A+2R
         MWW4yYQ68q8T1YUofP5xbOoBp2Z5ie39dbnQ0wisy1cGdhsRpnueHQvVN28czXOTSjpw
         BFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696217250; x=1696822050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3scGPNEBOwqptWVfFKrAiu9JumQod6q+Tv1f0Kk9vI8=;
        b=BQZ/VMbM39ZkcARbzmVZqnhqJhO41V28nY2ldwOZdDUztfTQYSdBb8WQp7IFQE2dG9
         HeCxucUCItF+ytx24vSQBpMkQOi6kd5iSII/xeafmrlzCq5X1RdjTuKw8lcJ73dMO/uL
         0w4M+cBqPVGso+lhAY0ZHiFYwmkZsfbYca2rQuWcKIpAt2OA8+GgrJH8/6mdWd6z/SpP
         du/tLChKbc/KFE+Av9lCOAbypXD8xiRhukCawALq+06qy77Ic3blSiTzoiTsfVk7ndnR
         RTcsAyXR/BNpblkA83JaSdwJDaCDNLk6ZYjBqOgSeXFf5BuxERcAIaUkFSKt+/g01vzg
         VmJA==
X-Gm-Message-State: AOJu0Yw0sfyxvKQlv6+3jyafhDcgNloVfJH3S5OTRSMjYMX+GN2tAim1
        abZZMW9VnN0UZiEcSOAXcj6psP6utwlY/juRVao0VsjPpeOOPFtuSVvPiQ==
X-Google-Smtp-Source: AGHT+IGENNrmhb+4VzqpTVANnEdpNQzdc47Y1/jQh2hnXoAhQ9KrK2qnZ25Hg3IgVO1OgzS81imF8a9kjErZFI/73jk=
X-Received: by 2002:ac8:5746:0:b0:417:cd31:a2f6 with SMTP id
 6-20020ac85746000000b00417cd31a2f6mr235602qtx.1.1696217249641; Sun, 01 Oct
 2023 20:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230926051035epcms1p312b531bba2c17bb763b6f046a45c86da@epcms1p3>
 <CAOUHufZwLET1E9dQq15LX27v+20HwWstL4XFi+qzVuz1voLW=w@mail.gmail.com>
 <20230926042250.6028-1-jaewon31.kim@samsung.com> <CGME20230926042019epcas1p11c28533f7b7db99db9f9d8a03ddd332c@epcms1p5>
 <20230926073333epcms1p14c9798232b395007eb20becb5dbc4b4e@epcms1p1>
 <20230926141519epcms1p5b7808c768df48647516f458529e4e3c8@epcms1p5> <CAJrd-Uu16oZncaFzycGoyryxyjEGFWJdecQoShveGV6_GGJLiQ@mail.gmail.com>
In-Reply-To: <CAJrd-Uu16oZncaFzycGoyryxyjEGFWJdecQoShveGV6_GGJLiQ@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 1 Oct 2023 21:26:53 -0600
Message-ID: <CAOUHufaqROR00_u6enJxhvGuPLTLMW_t4MSMqvDuyGpTECU3Mg@mail.gmail.com>
Subject: Re: [PATCH v4] vmscan: add trace events for lru_gen
To:     Jaewon Kim <jaewon31.kim@gmail.com>
Cc:     jaewon31.kim@samsung.com,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tjmercier@google.com" <tjmercier@google.com>,
        "kaleshsingh@google.com" <kaleshsingh@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "sj@kernel.org" <sj@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 1, 2023 at 5:41=E2=80=AFPM Jaewon Kim <jaewon31.kim@gmail.com> =
wrote:
>
> Hello Yu Zhao
>
> Could you give me your comment? I am waiting for your opinion on the
> reuse method. I'm planning to resend it as a complete patch with it.
> Thank you.

Acked-by: Yu Zhao <yuzhao@google.com>
