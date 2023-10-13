Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0F7C8A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjJMQF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbjJMQFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:05:24 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5298136
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:05:08 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57de9237410so1309086eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697213108; x=1697817908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0E2adTq+ZvO86bFiocTbWu1/NJw0Sxi2mxF0K0O3yCI=;
        b=CW+BYi6iU/jlGC1kBBGyca/HWtmzV3cYN/uvg4zlIiSHxDcVsGKAS/rr/PvbZHnQAl
         AuYbPZCEGshgShNjCUDliCzZiKhQ2b0RK6IgOp7DJcd1KllXCvbW6VURKbA1mEMGCOVL
         aEQlIESaOcANPUvDqykyoHPQ8TQ27s71dI2ofimWG1QBzURYM24amXyKuvAoooWXvwZJ
         XQ1NXCHY0QnyS53dHlQXQ+KyCa7YCsbx4XZ0Orjyj3t/XLy76FS2ygdrTh1H1nwKLh94
         N/J9mWfhK4Mccmkf63ErlWULIOk6VpmmCfExBQrlTbULkKYQ+k+QOIEnycld1iH6Kihg
         imCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697213108; x=1697817908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0E2adTq+ZvO86bFiocTbWu1/NJw0Sxi2mxF0K0O3yCI=;
        b=mjluDY2+GZtMyXfyacmoJZFx8IyJ55L0YwrYEp/wvhmufLBIh0Lx1hB0xt0RT81Jo+
         CRwQcJSqy4SlVEuJ/UykLg0YmQiJw5dPi4ac60Or4/2sKEMvGAodRQG7cnx8H+/P2Q/S
         mFjGXqgYTSKYf0aRSRrYJpOAPOpFyQJcPWg+5YJ1BOjUqJBERNQgYM2dnS2ERX7aghul
         ox+QEw9xL/mnwk0a+9uyUy/kzweE7cl7HnkLfMnVJC8SXlgXAPtzrwZLovhv5t1HHOHc
         gQWix1T0gEcVq4aYBHR2y5PtPg+vQdKP5E4Wn8IdkBDyRQmiZMcP1Qc8m8pdBp/PAFO2
         sN+g==
X-Gm-Message-State: AOJu0YwTtjBLB7xnxVmVhh+SCnAENJgL8CpzFRQy9zXgX6mrTTIZSmOK
        1hBi5y3SF9oeK5vKiJgkxNS7iqnZ/zptxDx+o8Y=
X-Google-Smtp-Source: AGHT+IETtWM/w2WA9DKTdQv6dDMKZy6/XPv3txCpzyyRcq09faeMnhs/q9OovphD5y5FtIjEDZUykVEwQt4DOxp6Yu8=
X-Received: by 2002:a4a:9c85:0:b0:567:4e58:6aaf with SMTP id
 z5-20020a4a9c85000000b005674e586aafmr27825009ooj.6.1697213107970; Fri, 13 Oct
 2023 09:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <ZSkg7y2Y2T3midXB@lab-ubuntu> <67d90726-15b9-4d64-87c6-bfbf662cbe81@kadam.mountain>
In-Reply-To: <67d90726-15b9-4d64-87c6-bfbf662cbe81@kadam.mountain>
From:   Calvince Otieno <calvncce@gmail.com>
Date:   Fri, 13 Oct 2023 19:04:56 +0300
Message-ID: <CADFX3ORVXcEBzovdbPawW2SLxcMoraKBmmLuOFkMpnHj=T48qQ@mail.gmail.com>
Subject: Re: [PATCH v2] staging: wlan-ng: remove helper function prism2sta_inf_handover()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luke Koch <lu.ale.koch@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Simon Horman <horms@kernel.org>, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 3:12=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Fri, Oct 13, 2023 at 01:50:23PM +0300, Calvince Otieno wrote:
> > prism2sta_inf_handover() function basically calls pr_debug() to print
> > a literal string. This can be done by the parent function directly.
> >
> > Signed-off-by: Calvince Otieno <calvncce@gmail.com>
> > ---
> > Patch version v2:
> >       - Replace pr_debug() utility function with the module specific ne=
tdev_dbg()
>
> This isn't a v2 patch, right?  This patch assumes that we applied the
> v1 patch...
>
> This patch is not white space damaged though so that's good.
>
> regards,
> dan carpenter
>
>

Hello Dan,
Does this response mean that the patch was accepted?

--
Kind regards,
Calvince Otieno
