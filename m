Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48377FAA91
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjK0TtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0TtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:49:14 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1112A194
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:49:21 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-332e56363adso2849669f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701114559; x=1701719359; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I197fyVzxg29ertOxEaJbhT/xEN2HsvYHrrXr5fJpSA=;
        b=csqgR1ikMNJAfEshrrBTDayc96NVIke5ErsJoUHo8ajqkW7yrYPEnWNmwwccr0h0Y3
         m6pp8bLBkiC/cT2Vy1mwgeWoai293PvO8d3dBbz2hJiA5MroOBKD4Vh6JOxGjYvIjWDT
         z9N5Vs5gvCwYtPBxoXVrT1U9KWTiTrA9Ttxcmbpdt8cRenFAR/n0AWd8aeTKp+zhRWLL
         xwlZpl0Hphwmn5vNf3z9yzheCrSsLiBxsA2lnfQvdoaQXWzBVHG6fFKHXxtkpeCFvM65
         e2jitNNeyaaFBc1aBdJ25mn84JC63dckJiDiZIlIccojcLNQh42E1ceqX6UWzuzau09B
         KkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701114559; x=1701719359;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I197fyVzxg29ertOxEaJbhT/xEN2HsvYHrrXr5fJpSA=;
        b=TsgY857E9tMgujeROUtF0Pbx7h8SVygH51G5pnOmdGchc96CtYiy1IiYKMCzzu0BCN
         fwk0NjK1TLvKynSLvOCiW58Br5Z6/bqMXv1iIyC35fqkTvEn0XoTCEk8TCzF8DgvD1cz
         61Ek7+NXn92FqMJPh4NJ7/b8YENQMcTchc2KPYTwEo1pF5YSElg5xMS9NY7mxinnSmvL
         /F2JVwIh8YIASwoh8lDwUqsmoSWh/jM6wMsVrmfy/LDzZS+TESd7BDIPDREzU6gb/Kp3
         dsBtLsWizm61mwtX7axggKOLC1plg+4dzaBpazpkp0rRAjg5VJsMKei9db+2yVZf5pb7
         5eiw==
X-Gm-Message-State: AOJu0YzUDIa0T2tBqpQYVLev5Schgff1AxRCQrtqPAC6LvvRaHadBG/T
        pQm0kF9sHKB7l7WDelkrurbK1rxO48zLnApCcg7TXg==
X-Google-Smtp-Source: AGHT+IGRkofSu9LCd/I1nOg2NDDUsV1JjpsW/RQKJWRvvwf+XtkSl9MpzoYftVYV5/RGBvmqBCiN5iD9W/O8vx7yBP0=
X-Received: by 2002:a05:6000:b85:b0:332:e592:bd19 with SMTP id
 dl5-20020a0560000b8500b00332e592bd19mr8917825wrb.67.1701114559343; Mon, 27
 Nov 2023 11:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20231122220001.539770-1-royluo@google.com> <2023112253-fresh-blazing-baae@gregkh>
 <CA+zupgzWqhOhAR0_ybxTQVL928dgAqbm5eqJ6gd-0qrNK7VZng@mail.gmail.com> <2023112339-deeply-curve-034f@gregkh>
In-Reply-To: <2023112339-deeply-curve-034f@gregkh>
From:   Roy Luo <royluo@google.com>
Date:   Mon, 27 Nov 2023 11:48:42 -0800
Message-ID: <CA+zupgyr3P6C_3NwWgXyXh+RfO0JRPS5JzH3E4HNxV1JRRcrFw@mail.gmail.com>
Subject: Re: [PATCH v1] USB: gadget: core: adjust uevent timing on gadget unbind
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, badhri@google.com,
        quic_kriskura@quicinc.com, francesco.dolcini@toradex.com,
        quic_eserrao@quicinc.com, ivan.orlov0322@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 12:52=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?

Thanks for the tips and your patience, I hope I get the format correct
this time.

> On Wed, Nov 22, 2023 at 03:13:20PM -0800, Roy Luo wrote:
> > The logic is there since day 1 of udc in Commit
> > 2ccea03a8f7ec93641791f2760d7cdc6cab6205f (usb: gadget: introduce UDC
> > Class). Do you still want me to put on a fix tag?
>
> Yes please, and do you want this backported to all older stable kernels?

Ok I will add a fix tag in v2.
As for backporting to stable kernels, I don't see a strong need that
satisfies https://www.kernel.org/doc/html/latest/process/stable-kernel-rule=
s.html
Please let me know if you think otherwise.

Thanks,
Roy
