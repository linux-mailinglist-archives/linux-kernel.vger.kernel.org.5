Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4427778DFB4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbjH3UBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238841AbjH3UB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:01:26 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2FF813AC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:38:14 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4ff9b389677so300685e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693423918; x=1694028718; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3cBG7lD3zs+X/wz67fgIGSozS1sG1L75FoCiqrCIoA8=;
        b=iHpG6XWdu6qGf5+cAwJa6qDP6+wVxcv2VFakd+WD1JjKOkNuyeHeelPY60YfmpMmM7
         95qin++W98AFqTA1xkgVjgMSSl1IBg7MuE8PqZ7ez4NYB/Pz9qnPz7eMsQ7hg8pn32P8
         2Qn1Fx0brI/W2fLggky5GHbv6KIRYzaUUDusc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693423918; x=1694028718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3cBG7lD3zs+X/wz67fgIGSozS1sG1L75FoCiqrCIoA8=;
        b=BsdHcsbD7e9pvreR1sx0wGRnantrk/OIlbh1iQXxzv045Dn4wK17xRnKN8P5IRY5Tk
         U9DRTAysmGzaudPG13frT0vTRYa9BiCIHKFp9WYjmN/5UoJJk1No98UPB/0TSajpTv5k
         1ILgWbcFg2ux8xdiQQBn11SPH/i/kOJn3oeYkvf68ynCJY7sHIKlzsf+GmeCJjnZrNiN
         5mmLttqIJe8U1tJggCRUCbe89t4YF+uKsodeNiyTfprJWYatvDV8Lsjvf/YnmKBT21QN
         XNk3Y76NCleuGWwnvBOGtJ+pxq1T+UbTfJfK0K+Q65YY4J4z8IUCx2fCIZ9op+LXMOUK
         LTag==
X-Gm-Message-State: AOJu0Yw5xlEm4gcEtzpfxCK22ccPaApbNOzUNZhrR1OSarIwcIVNsZrS
        +k+D3yBk9TDdHLHsQJDdXRVbkYdsbkFvx0KYuE4wse0Z8/m88OkE
X-Google-Smtp-Source: AGHT+IEvd0RifKzpOFQOfh/+QWJZKqujw6WsDyyw2Db52aENsHPvHM2VIXiSa2Bhu2ismMdk7Djt47sPjIM8JQNuntI=
X-Received: by 2002:a05:6512:2102:b0:500:9d4a:89fa with SMTP id
 q2-20020a056512210200b005009d4a89famr1993107lfr.22.1693421590926; Wed, 30 Aug
 2023 11:53:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Aug 2023 11:53:10 -0700
MIME-Version: 1.0
In-Reply-To: <ZO97gl1knsW8n99a@qmqm.qmqm.pl>
References: <cover.1692484240.git.mirq-linux@rere.qmqm.pl> <682e260d8cb75c34f79ff7fcc3c4bb8586140cc4.1692484240.git.mirq-linux@rere.qmqm.pl>
 <CAD=FV=XbfBf9y1sdt9T=81cTCRcRUbVqo3oKrHvBQZC+hHQpCQ@mail.gmail.com>
 <ZO0DDkNUZ4FwYTrz@qmqm.qmqm.pl> <CAE-0n51gcN+3Ng7+bz21eS_6JomnVDzZMuWyzZVB25paj29j4g@mail.gmail.com>
 <ZO5iWlczXmX7wNn9@qmqm.qmqm.pl> <CAE-0n531mK2Lvt7saXySPZLbGsA1giB3at0WDadErYOhcUv6ew@mail.gmail.com>
 <ZO97gl1knsW8n99a@qmqm.qmqm.pl>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 30 Aug 2023 11:53:10 -0700
Message-ID: <CAE-0n53Zcxc0XFrSKmN1NS7RQHanPEBXy+KgJ3E_2jHaJBMevg@mail.gmail.com>
Subject: Re: [PATCH 6/6] regulator: core: simplify lock_two()
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Doug Anderson <dianders@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Micha=C5=82 Miros=C5=82aw (2023-08-30 10:25:22)
>
> I see that you prefer the held/contended intermediary names. I'd like to
> understand why we differ in the perception of readability of this part
> of code so that the change is needed? The algorithm is simple enough,
> and it would work even if the locks weren't swapped for each iteration
> (even if slower to finish).

The locks need to be swapped per the documentation above
ww_mutex_lock_slow(). This is how we ensure forward progress.

> What is missing in the context of the
> function's code? Are there some assumptions not easily visible?

Yes, there are assumptions that are harder to keep track of with the
names 'rdev1' and 'rdev2'. We have to make sure that we call
ww_mutex_lock_slow() on the contended mutex, not the one that we could
get first. I find it easier to keep track of which regulator is
contended and which regulator is held by having the local variable
names. It's not up to me though as I'm not the maintainer here.

>
> BTW, I went on to add the regulator_lock_contended() to see how it
> would look. I'll send a v2 with it so we can apply your proposal if
> needed on top.

Got it.
