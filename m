Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138EA776170
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 15:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbjHINmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 09:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjHINme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 09:42:34 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C972109
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 06:42:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d4b74a4a6daso4488928276.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691588551; x=1692193351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aN+FplIKKK7RYr0Y31cgi1AbLRZ5VPs2/8SsV3oWXZ0=;
        b=XVvtPgbVgOyiC6hrUMe13eiOP5fztIj6UZuel4GtNUav1ZdcVI+k7jUSIw9lAWvO4m
         VRblgx1Nlzqjmj7xxk1IoKYfWbtSJrEsmfYogXqqfNTf9c6ATu7k7toI60t4kUygarYz
         C8zzNw2bKzwsaleAH5izLEPSlkqLFMhYK5Y+Khn+W2uzToQ8CJ4qQZLl2UZky3Xu5SB7
         /WNHjoQv7xTiQhmD2/Ym/ilaqsrBUbmeEoAKGPmAq5RWzemzSi/ZUVvxUni5LqcaPdwh
         0+V2Xp5yWHnFDCNNvFK792wRdujD1zk/q8WjZ8qL8YyVDlscsikAcLV7216z8KRqGewr
         XQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691588551; x=1692193351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aN+FplIKKK7RYr0Y31cgi1AbLRZ5VPs2/8SsV3oWXZ0=;
        b=C1onGenk0Bb9NHyb3ofqzEUj3a8/hMKXx/iERLtfLoaywnrlkhT+AJNHMDvJj0LfHf
         gR78XaqGOY4ZIK3LyD2cakKP9Dhjg1yI1pfLZ/0q9OHjU6Vp0JsNKKo0eUzKNDMGuLzq
         Zc1aZHTCKICEDcD7CD8sQ9ca1oKcFakSLZSEA5hvHkcNyKe7JNElmUpBc7qgOmpjfTOR
         +cK6rVFqL65csn4mlEFgxEPB93JSOZYIpCflk4Oz2/5AnNE1LIBpIKpFxazc6+PJ5p0C
         hYBoFLRsb3zTpX+9nhnt8aB0vwow+K9zRxOmrvddP+7eGF+BFUBScIxL237qQuu+dBfG
         35KA==
X-Gm-Message-State: AOJu0Yxlw8oCbiJKUdvwXrBmaqPdOTyRj7TVizYROqTZ1FLf+nEpd+Kr
        ihz63g6pV2mcQUxez6VmYVajEVEzhVznQ6MGkI9WsANixy1ML+W2
X-Google-Smtp-Source: AGHT+IGuuUQiZKFCzSMTeH8Sgpfc/zHzkbce8TUWeKlIbJ0VWef7x1QmytTMYmvv8I/DwFGqwX4X/zmkViqiY1WFjic=
X-Received: by 2002:a25:69cc:0:b0:c4e:3060:41f5 with SMTP id
 e195-20020a2569cc000000b00c4e306041f5mr2520373ybc.33.1691588551254; Wed, 09
 Aug 2023 06:42:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230809071812.547229-1-harshit.m.mogalapalli@oracle.com>
 <20230809071812.547229-2-harshit.m.mogalapalli@oracle.com>
 <CAPDyKFqHnHCpsi+GBAQ2vmESf17rDMGyUK+EtZbhJT5AngvmBg@mail.gmail.com> <9c7a69b1-9ee3-4676-8d3e-9f12e39b37af@kadam.mountain>
In-Reply-To: <9c7a69b1-9ee3-4676-8d3e-9f12e39b37af@kadam.mountain>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Aug 2023 15:41:55 +0200
Message-ID: <CAPDyKFqaF9LhZPke6wEVCqZT0Nx4bBDsf_Qg1knT3UgznrbhpQ@mail.gmail.com>
Subject: Re: [PATCH next v2 2/2] mmc: sunplus: Fix platform_get_irq() error checking
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        tonyhuang.sunplus@gmail.com, lhjeff911@gmail.com, arnd@arndb.de,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        error27@gmail.com, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 at 13:51, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Wed, Aug 09, 2023 at 01:33:51PM +0200, Ulf Hansson wrote:
> > On Wed, 9 Aug 2023 at 09:19, Harshit Mogalapalli
> > <harshit.m.mogalapalli@oracle.com> wrote:
> > >
> > > The platform_get_irq() function returns negative error codes on failure.
> > >
> > > Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lore.kernel.org/all/a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain/
> > > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> >
> > Applied for fixes and by adding a stable tag, thanks!
>
> It's not really a fix.  The platform_get_irq() function can't actually
> return zero.
>
> I asked Arnd about this and he said that there were some arches where
> zero was a valid IRQ but they're not in the upstream kernel any more and
> we're hopefully not going to do that again.

Alright, I moved this to the next branch and dropped the fixes and stable tags.

Kind regards
Uffe
