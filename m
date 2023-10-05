Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6577BAF50
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjJEX1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjJEXZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:25:57 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE80F1B2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:23:54 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-65b10205207so21896406d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696548234; x=1697153034; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPy1KIj47wf2+7ji7ueJsN5688cGu/wo+yyPOcjYdVI=;
        b=Uifcnlli7dwwFZRMuv9KAJBcPKW8lgTmflGiyiyAM3nLZbwHJcW2QrWOxfAp/Ix60B
         H2BOv3Q7nnXDdiiEdQHUSJm+9dXtSkvhUWprHuYigDKCnk/1XrdV+DHF0+spG9ApWhTX
         AAKQ5pdVV3D6veV06fkIKSu+N5bfB5rYsT4t2wpaO49dZs91obca84Ser5W8hESYCAzK
         7FmRUWWRB996if9dL0KMDEbTwYggaCHTRKfXLNDSl/shdzKuG1iA4Io318yw9sC0xgCR
         xU2mhh80e2M/tXf2v0uhgBi4DWoDKsibAmZ/+8I0A/dDo0zg/9ZEu+KOR5o3iwAw3tcO
         w3QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696548234; x=1697153034;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPy1KIj47wf2+7ji7ueJsN5688cGu/wo+yyPOcjYdVI=;
        b=Dla4tWAHY+OQkS12GDP8Nhxk8in8Tr+78xXOeG3noRo4UNP3xhfYC+Jk654OdC+2ZW
         Ohc6Sxko4brjm3VLkwJ2/3DNL3FanBZCrpO5TL9w9cMqVJyMQ1/mHVzXpZLoYZs+YzsX
         wPeGKIt9JFPpCrnqkLoGGD0yUq1RwWbIyk3nA6lWIVw6VizkM68rGrvnWkiZ6owd5I61
         zHd6pLuQhMP4mDt6zbv41Qjc8MHLpNtO9cPXLXNE+ZxQ2vkUmc/2H2XSSJU7erxx1oEi
         9PbqWPTWE7zKnnqY0a8upvTWqWvQjVnOa8iK4z5dTJvzPv0vtYeu4VmByG2YO5/iicLU
         NxWw==
X-Gm-Message-State: AOJu0YwWDIcxA3nW+CjOVFfsLB/0YjUD9yB38VevJDbcI1jcsEtMrNK7
        gfNOtUFsej7/8orDfNrGUh8Yq4VT3k6bpj7VzZr20A==
X-Google-Smtp-Source: AGHT+IHs3h4fp5OSVp1J9NSDTyrp2yMMSLYrfQzWcGVBx/vR+8jrWyqSGXlSYgYjT43Y+/dHWUhqKcgNjOTM8zUxAEA=
X-Received: by 2002:a05:6214:d06:b0:63f:9130:4e9c with SMTP id
 6-20020a0562140d0600b0063f91304e9cmr3493143qvh.26.1696548233746; Thu, 05 Oct
 2023 16:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231003041701.1745953-1-maheshb@google.com> <ZRzsWOODyFYIxXhn@hoboy.vegasvil.org>
In-Reply-To: <ZRzsWOODyFYIxXhn@hoboy.vegasvil.org>
From:   =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Date:   Thu, 5 Oct 2023 16:23:27 -0700
Message-ID: <CAF2d9jh46s=ai1Ykgk3Lsg8Nb6qRNY6bWPV3fVCTC_S95csyag@mail.gmail.com>
Subject: Re: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        John Stultz <jstultz@google.com>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 9:38=E2=80=AFPM Richard Cochran <richardcochran@gmai=
l.com> wrote:
>
> On Mon, Oct 02, 2023 at 09:17:01PM -0700, Mahesh Bandewar wrote:
> > add support for TS sandwich of the user preferred timebase. The options
> > supported are PTP_TS_REAL (CLOCK_REALTIME), PTP_TS_MONO (CLOCK_MONOTONI=
C),
> > and PTP_TS_RAW (CLOCK_MONOTONIC_RAW)
> >
> > Option of PTP_TS_REAL is equivalent of using ptp_gettimex64().
>
> This change log is horrible.
>
> Please write a proper explanation, and be sure to cover the following
> three points.
>
> 1. context
> 2. problem
> 3. solution
>
> Every change log must have those three items.
>
> In addition, this series needs a cover letter that clearly justifies
> the need for this change.
>
Fair point and the series does have a cover letter  which you can
access it at https://lore.kernel.org/lkml/20231003041657.1745487-1-maheshb@=
google.com/
Probably it's fault of my mailer-script which finds the reviewers for
individual patches by running scripts/get_maintainer.pl but then
coverletter is just sent to the mailing-list


> Thanks,
> Richard
>
