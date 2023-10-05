Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCF37BAF3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjJEXQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjJEXOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:14:46 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C48110EC
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:13:11 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65b07651b97so8211136d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547590; x=1697152390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2O2X72sw/T7xt9ZYaaZg62x6tjZu36SBUEiSSeviOQ=;
        b=H5gB3pBeJMg6Ej5sug8/52RRMg6NHi6N27nHUwQMTQvKHZLgdLpsv5YnhXPE8umvcn
         Z9xKLlh6K14rmHeT9MSbVq6g+Ccg8xHY/bdK4eVeUyKhmZ5Ho+FuiLOTz9qHy28budTU
         Nyoa4qk5l2lRsEt5OidagroRsXsJh+wzgOeSsWD15j8In9I4fAVGDkyxyKU/UrbW09Il
         O6ZNbd8aQrVcWtnTXP53qJ4CPvM10wFwMwXWV6KLMRvT6vKFZl9Z1ReileMmg668MHIV
         lK+iFnB3bdbjO/viT2aal8LS5SA89ZFF/bRFOvNCBN1LJLxpgYHVz6rUwuhLW6GviEPZ
         GtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547590; x=1697152390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2O2X72sw/T7xt9ZYaaZg62x6tjZu36SBUEiSSeviOQ=;
        b=V92DQTS9v7sSutMlyDgQl3Cip3M5TxTaJv7SEwSBCEuTUrhcRRMj+sI+7wx9Vuap+i
         HxIDkZBGA5Xrvvm6n1+m7ex5DpCTAAlYSQUP1+yvApNMKcE2yztaTvzbpbSeeb+QLHO8
         tvB4rKMLXTQ+IZmzSI4tLfmw41QU0ZGQz9am9SPKG9aEjUCZe0Fh9YGV/hGoYChYFdq5
         uH3SmY0Dk2N+ecGM+LBitMwP1f74dfuSlyxPYroYI1Vdcm4x+SJEYZ4ONtzHVc6MZQaQ
         u482ZOfjv6obIT4tp9EGJy/VNf//yXXYdYae5RnIHfkfWQ9ru10Jzj+eUMoMd6sMrFTW
         qBDw==
X-Gm-Message-State: AOJu0Yyv0r11/1hT40WOYXVlRXo+X1gyxfb713pDo/LyYZqs9QxNyqLW
        zVJArgYlDOauuA9UQT//LKO45wNmttmGpW7efFRJfw==
X-Google-Smtp-Source: AGHT+IG5c0/pTKX96AVCxurr+fBXRzMwArsZvBBKtDR/g63IMgCzmXqnBgT2HDZ+O+ChaD+FDoqOkc/v3DsFrZzmd88=
X-Received: by 2002:a05:6214:808:b0:655:d870:7306 with SMTP id
 df8-20020a056214080800b00655d8707306mr6553318qvb.25.1696547590132; Thu, 05
 Oct 2023 16:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20231003041701.1745953-1-maheshb@google.com> <ZRzqLeAR3PtCV83h@hoboy.vegasvil.org>
In-Reply-To: <ZRzqLeAR3PtCV83h@hoboy.vegasvil.org>
From:   =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= 
        <maheshb@google.com>
Date:   Thu, 5 Oct 2023 16:12:44 -0700
Message-ID: <CAF2d9jggffd6HtehuL-78ZFPqcJhO+HAe1FX-ehXc5oBmZ72Dw@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 9:29=E2=80=AFPM Richard Cochran <richardcochran@gmai=
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
> NAK
>
> Don't just ignore feedback and repost.

I replied to all your earlier comments, which one do you think I had ignore=
d?
