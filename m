Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3BE7F0A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 03:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjKTCmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 21:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjKTCmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 21:42:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D1B115
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:42:28 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso1200690e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 18:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700448147; x=1701052947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1OeThoHf3uMeDHt078nnfHlRh9jpmMCwPFIZIn397Jc=;
        b=N0gJ3QuoNyF6wnF5kK1mdx9nexcs9RMD9oNMnft4upRCP+L3UqPJTMBpkc3z5vVXEN
         fAThq821YxswDcZylw8SR8B/FV4GoJxxij2Ae+/ZOoJ7NF+6zIIqO/xHqbJvyqrJFrEi
         KnlqLB3HnFIFT8xkuXqDEaomFkjBDD+5NOBsfohvGu5TDNSq6dMDzJ79mRlBeHUxYPwD
         +VmbhAJkgMkfVJ3FjpMxhm2nJLAsXeDSgnSgpFi8E4vHa1or/0p6iIM+FL0ZDFynQ4kA
         DIBtNhUf3xoLDfqw/FW0eMvDZkaUthiLu26q8WrA21FjJugm689+EHUorrroHBQuBd64
         1WIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700448147; x=1701052947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1OeThoHf3uMeDHt078nnfHlRh9jpmMCwPFIZIn397Jc=;
        b=YVHnbA0y2b2yyY9Qq5rUquXwUs9O86/A0q5Jz70pGxWo87Vd9uEhecfKG49Ko0rzRm
         3mMFqxJ47Up4NPNjiVfqPuAz5fsyyHnFkRr3BQFUPQT1TCY7tDOFzmnYqACxFjBmshC7
         e3dgML0jStxntsL16KRA8Lg09OTRbtk5a9/RCrCmnn2k6kDFAG/lYimPGSXelHNUVcVE
         7rg0V5krg0fch9nc9XdMQ9iUUJmqinkyfHAw0pz6JqOByQgBuDkBLso/SqChyB0m9yug
         RsDKh3xnDBiRuHklXY73UJW0zV/+pvgOtQ676A+LwxdoRD6PAQPrsWn/rPjt8tWuXJ7C
         QDqg==
X-Gm-Message-State: AOJu0YxiOB1QhtFTbTOzrqiL2SnW7yWxWd8+Ww2rILrQejXdjvD/CDqm
        sPIiybtBj5+7TLsbxFdmOqEXCCXy9eUo8biLLFSDNIaM1+/JYPyycmI=
X-Google-Smtp-Source: AGHT+IFMEhHZQSdBSQP6HIDQV+eH1EumpQzHxEExKvm8bLGoK89XkTNdivLD/bjPEbVY3wnx1OCxlHLNueYlzvQgMbQ=
X-Received: by 2002:a05:6512:3b83:b0:50a:a9ec:1897 with SMTP id
 g3-20020a0565123b8300b0050aa9ec1897mr3482128lfv.35.1700448146995; Sun, 19 Nov
 2023 18:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
 <CACSyD1NJ4ycr74pXHNus3ZjA=LvZP+aMNyz=iWyHuDODpx7aww@mail.gmail.com>
 <CAF8kJuPymUX+DwouwgH6og0BO6ZYheGXsk=GYqYuMjKMz-Xqbw@mail.gmail.com>
 <CACSyD1P-6mQ7n+ghsZQ0Gp4AxyTTi6=UZHz2DnXWuCWke2fkPw@mail.gmail.com> <CAKEwX=O0eNmoFRsnRXpkY55UGHBOiGL2aQW6um8Kq5hgGH=c_A@mail.gmail.com>
In-Reply-To: <CAKEwX=O0eNmoFRsnRXpkY55UGHBOiGL2aQW6um8Kq5hgGH=c_A@mail.gmail.com>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
Date:   Mon, 20 Nov 2023 10:42:15 +0800
Message-ID: <CACSyD1Pn1HrJgG4XhSmrq7ROpHU5bO4SS6Szn+L5Nz1EjVxGZQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     Chris Li <chrisl@kernel.org>, Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Shameless plug: zswap will much less likely hit the limit (global or
> cgroup) with the shrinker enabled ;) It will proactively reclaim the
> objects way ahead of the limit.

Hi  Nhat=EF=BC=8Cglad to hear from you.
Back to the beginning, the original intention of this patch is to solve
the problem that shrink_work() fails to reclaim memory in two situations.
The zswap_writeback_entry() will failed for !page_was_allocated
because zswap_load will have two copies of the same page in memory
  (compressed and uncompressed) after faulting in a page from zswap when
zswap_exclusive_loads disabled.

A simple test:
1): Turn off  zswap_exclusive_loads_enabled.
2): Run a read-only program and allocate more memory than the limit,
so the limit will be reached and shrinker will fail.

>
> It comes with its own can of worms, of course - it's unlikely to work
> for all workloads in its current form, but perhaps worth experimenting
> with/improved upon?
>
