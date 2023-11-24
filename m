Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4685F7F70DF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345434AbjKXKJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345470AbjKXKJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:09:13 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBCD170B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:09:19 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5c8c8f731aaso17511807b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700820558; x=1701425358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7d06b6G7ORlrNQJU6TvzYJsppMO/COUWuckfBOPugA=;
        b=IOsL5Yn/2ONsRx3AZY/b37Bgaf/iyqpidxgZj6rw7NYkgqy5vAPljchwXUoAE3lGHG
         ZtQ5INVkDN6krE0PJdIfU7iGgdd1Q3T8z+OyF4DvIJ3g1+1GZ2bdB5FxVaIJJ/+GP+6i
         6ouSe4MuFwLBR2IXDibvZis2sXd4n/ptZX8gSX8lBSfM+CrC0VCdSb7/Ecl6H6Fqv41j
         jacYAw9yNZxJ2NLhp1ZeSYH/NnVRtyP3NiSOOEk5/+r5P944J8p0C/+E42F7wPPFjwQm
         bKUbbHv9h/TSt2OqOdwSztMGOnO8cbytFPoLPgxUNghRTcjxJMUQMtDqiQj9xm/3ACyh
         NoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700820558; x=1701425358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7d06b6G7ORlrNQJU6TvzYJsppMO/COUWuckfBOPugA=;
        b=dPR0pUDgiaALLAyjrNPphJ9nV+gd7MARaol6xKghyor4GkMBUXrBCmQ7Lqwq99lNHr
         Ov75Aqj+kpEXrJC2Jk0V6zFrcbvcTS1JV7iJQUkiXbLa2DH8pFtsjMZOwlEJXShI/Im9
         zgCQiXCdGU86U6lTsFDZD6pzG/Wvf3rLKgQ0dkdG8qVwxsNUFASHqp4QXLvZmhA6RrpD
         GUajQUGfUzMWblV0ziq/zVYoRy/b7zCtQSa/wlTCPWbQaN/8Ex/1nDjtUW5BIFnOsDOL
         h7fwiq/zNU13O8ZJWDWh+pfxsyOz4AFiNS22JB5ka9RxNisHgzdK/oredPB/WUmDVjOU
         nmmw==
X-Gm-Message-State: AOJu0YwzC07QCUTxWTsrr0neCimkgwtR/3uGTpaGl2s2mYw1LBF/PMBW
        /kcl7hxx0aeOZNVTL9LiRnNgdp6VMI7ELjkLvkWJZQ==
X-Google-Smtp-Source: AGHT+IFZDOwR7JExk+WTPrKofyiSPhESOa5Ty4+gyeA49vmY5GeURfJ5lGSFWgjatvyDMJJIGKpHsSimm4ZZ6CjLiag=
X-Received: by 2002:a0d:fa01:0:b0:5c5:b0f7:1087 with SMTP id
 k1-20020a0dfa01000000b005c5b0f71087mr1855847ywf.40.1700820558337; Fri, 24 Nov
 2023 02:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20231120194802.1675239-1-andriy.shevchenko@linux.intel.com> <ZVzy227f3cIiTmtE@smile.fi.intel.com>
In-Reply-To: <ZVzy227f3cIiTmtE@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 24 Nov 2023 11:09:07 +0100
Message-ID: <CACRpkdZi5uW7saBFFA=VWDYpj_MCw3he2k-CLh__zJzUOOEkyw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: nuvoton: Convert to use struct pingroup
 and PINCTRL_PINGROUP()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomer Maimon <tmaimon77@gmail.com>
Cc:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 7:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Nov 20, 2023 at 09:48:02PM +0200, Andy Shevchenko wrote:

> > The pin control header provides struct pingroup and PINCTRL_PINGROUP() =
macro.
> > Utilize them instead of open coded variants in the driver.
>
> Linus, I dunno if you are going to apply this sooner (assuming Jonathan i=
s okay
> with the change), but I have a bigger pending series where this will be a
> prerequisite. So, when I will be ready and if it's not being applied (yet=
),
> I'll include it into the bigger series as well.

No answer from Jonathan but I just applied another Nuvoton patch from
Tomer, so maybe Tomer can look at/test this patch?

Yours,
Linus Walleij
