Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F4278A845
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjH1Ix2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjH1IxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:53:22 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE9EED;
        Mon, 28 Aug 2023 01:53:19 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5731fe1d2bfso1554254eaf.3;
        Mon, 28 Aug 2023 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693212798; x=1693817598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WvWirOz3A9sFh4wCqcgDGy7yfebE462gaqIZqiWt7o=;
        b=aUHopSXEmB7cbBZSL4dR+PqOAsEjY8+8PlY5xCMZWtc9UhXs3RvHTpkmt/flOMtAcI
         rX9oxVSHQqj8lRMZB4aNK+TSndznglloVsNcO9v6qTAREKTamRVSQTSzbud4L3CsGGR3
         OMSW4CcfYQiCqZDB/UgscEzhukv38PwURgSo89vMWXDXV3qZjLYMrvudExeKXY1GuItV
         JMWCOVKywi66o0zbiBkn8hhHmfJMZPOgMjCT9qKCB5Dy4VdeW3ziVPcqYfb6VyJPsIYc
         iXunAANkA8WcY9+3HIt4MIsSfe7Qshj2d82pd3kKdT1foY3Dzm/kMPBHxgjGwxBzNrdN
         lCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693212798; x=1693817598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WvWirOz3A9sFh4wCqcgDGy7yfebE462gaqIZqiWt7o=;
        b=kwOEisbpXawPB5lh79aMx/pj+EIyv14DZ2pzzPmy1u3viEPes22JYxw1FiDwsTQj9k
         3eACHTLVDcxkjf9OihLpPcIyJt5CUc+iHpjI6zda3pXGSN9Di/8Cw0L4n5hzRDO+G7xP
         tXNC2EHngz7VOGVBnhQkNwgb6MD21DrFFU7WWWNpInGwZspqsj6cl6e66qAMjphxQy9l
         4exn8qS0zVqmMVG5uI8/NSzQfLqkPhFtk1C/pbBHciZgcGg+5lKEpggRfhJ8dC3sYNDS
         Ns3m/iG98h3vAs2H6aW1S1E/cHRczOSO5RYvMYL8W/eQfVkyewTiRi5yloe2ckXwuqIF
         v++g==
X-Gm-Message-State: AOJu0YxvUfZQG2R4GQ0quikCp4I1X3lYxmdatslJaM65tGQ/eigsBOJP
        nLpzyeYRQUKBXLrZaKdAQ5mIDmGd3wij96dfb0E=
X-Google-Smtp-Source: AGHT+IF8hmrt/EeLG42FlDYQXkWu/xfDd6aDotDAvNihE8Hk5HbWzXbTAR1ysaExMKKYwdQKSed9RfakNBUarSkXZyY=
X-Received: by 2002:a4a:92cf:0:b0:573:4e21:5d25 with SMTP id
 j15-20020a4a92cf000000b005734e215d25mr5092572ooh.9.1693212798414; Mon, 28 Aug
 2023 01:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
 <20230703185222.50554-7-andriy.shevchenko@linux.intel.com> <50683aac-b186-c6ae-de1f-5b8e4806913c@wanadoo.fr>
In-Reply-To: <50683aac-b186-c6ae-de1f-5b8e4806913c@wanadoo.fr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Aug 2023 11:52:42 +0300
Message-ID: <CAHp75Vf+x9pdRiYQUodUtK+erN3j0cqEZEHZ+MVecASfgP9Tkg@mail.gmail.com>
Subject: Re: [PATCH v1 06/12] HID: cp2112: Remove dead code
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 9:30=E2=80=AFPM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Le 03/07/2023 =C3=A0 20:52, Andy Shevchenko a =C3=A9crit :
> > Remove cp2112_allocate_irq() and counterparts that seems to be
> > a dead code from day 1. In case somebody needs it, it can be
> > retrieved from Git index.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Hi,
>
> for the records, just in case it still makesense to keep this code:
>
>         https://lore.kernel.org/all/CAO-hwJJfncQ3jgtS=3DHO0atbzrTNOT_rzU6=
6oG2yRTWTSY-L8KA@mail.gmail.com/

It's in the Git index, so we can return it, but the rule of thumb is
that we do not add dead code to the kernel.

--=20
With Best Regards,
Andy Shevchenko
