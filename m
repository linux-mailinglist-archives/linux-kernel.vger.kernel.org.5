Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C44C758100
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232641AbjGRPd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjGRPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:33:24 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321651BC9;
        Tue, 18 Jul 2023 08:32:58 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-cc7863e7b82so3812211276.0;
        Tue, 18 Jul 2023 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689694361; x=1692286361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0Ew4xDSq7MPi86/w9VZGABdvX7HcWbeJ7xpN4f/T0Q=;
        b=FmqGVJCml02/ilNevpUFn/TQWqjlykL92VfRnD+cKehmvmOsbBdpW2grMoNXm2reHp
         1EjtfCmx1n5HLtCIRw+z6znkwfps/sMFwItmDxxO+5ZUiyTiMRQKGAhC6pfxpm/Bs7mZ
         fG896h10jrFADrHG9duWLAljqr7LMuZfMKlj1HBq3+kqupzZ50UFG185bzDknuxDa/lj
         tbAxLimD/oVh4LgCeRKhRcqDYU0cLIHVw/jRsK5+iN4uYcPrLA1KXGHQ5Tkb5fm0qRUf
         naWAXSMJYYiffHZ6tRo1+6JBtN75MN0Sw8ag83GAGEk6MSNcAeG1zRb0l3bepoW0fNPZ
         7maw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689694361; x=1692286361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v0Ew4xDSq7MPi86/w9VZGABdvX7HcWbeJ7xpN4f/T0Q=;
        b=ji9FnvnBjmavb8FCQwBNypAyx/jF5O/fHoda65tH29Z2pG4SjpLw/E/mhCPOJaVZul
         1RofyDSb5TncmtZgMSrX6gCPaApSH/NP+AxFN32n+wC8qDpZiYZkqx1fILEb2KhverME
         UQQNL8mMSmJ1xe4Le1olUvrwgDozxT3pSNggprmkzPsCFCSdaAtWNxRtR/8TLubrtCw0
         3GgqOsFu+s830SzHZdcrxJwwsKzZvEIP8hj44O+LW0oCjdiwj+qqow5S+FAzZU/+7eeI
         0mZRVW4VQ9i5I9iNEzLk+HCXfwP5i6id9bGp/APQRRJzdFGTodL0EwUqF81/r+FEA5Ew
         y94g==
X-Gm-Message-State: ABy/qLb9bvEpQXpYVgdDkp0pRGaAg6rLEVUERI2bexGL+/NSAeYS09E3
        gh1ZZo56yy8aVEG2kpWEIqxBGPvAwzhenOGyowM=
X-Google-Smtp-Source: APBJJlH0ne69dDk1mq0QwkUUsLJPBFfYY2V3/WGOX0if93HKy07/Z0XGrjiTXhKPcqu08pWmPMdFFF2957u984MsT60=
X-Received: by 2002:a25:aba1:0:b0:c6f:db67:cbf7 with SMTP id
 v30-20020a25aba1000000b00c6fdb67cbf7mr95826ybi.16.1689694361102; Tue, 18 Jul
 2023 08:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230717151624.3470714-1-carlos.bilbao@amd.com>
 <20230717151624.3470714-3-carlos.bilbao@amd.com> <CANiq72=jiEqYfEvcRAxXsm1BCODnpxmWZOmbGB_YwM=pUGYEeA@mail.gmail.com>
 <88eefdcf-5398-97bc-161c-78f056c682a0@amd.com>
In-Reply-To: <88eefdcf-5398-97bc-161c-78f056c682a0@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 18 Jul 2023 17:32:30 +0200
Message-ID: <CANiq72nTYGrHCCGmhavHU=qTs4XJoXsgTf3KgdrjEnuLjy4W9A@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] docs: Integrate rustdoc generation into htmldocs
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, jani.nikula@linux.intel.com,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org,
        Akira Yokosawa <akiyks@gmail.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 3:54=E2=80=AFPM Carlos Bilbao <carlos.bilbao@amd.co=
m> wrote:
>
> The previous patch works without this, the generated HTML will show in th=
e
> Rust index:
>
>   This documentation does not include rustdoc generated information.

I see, thanks, then it does not matter much. I guess you put it in the
first commit because the docs were moved to the URL the docs talk
about, but it still means we are using a tag that does not yet exist,
so I would have put the "link/URL feature" as a separate commit
(together with the creation of the tag).

Cheers,
Miguel
