Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E077787ED9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 06:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjHYEDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 00:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241127AbjHYEDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 00:03:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F7E1FCE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:02:58 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso33725e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 21:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692936176; x=1693540976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m9sg31Vv1AEK6pMFEnTwVpOX88IctMNcLSQaCMVBld0=;
        b=p22IXn3LiO7+xE5be9I4knIk/LjZIa5V6nUvXLUGNy63k93/O5keiEwHSvV2pSah8d
         MX2GRpydWTeUtHOV3ydIDRfe1fOUcDronqUWgHjUbG6KSvJaqdIGMMJH7EfoLGcQcrke
         GB4jAJGF0q9gEJW9iNeNKrjVOrGsUdza9A2J4+2cpPuKJcXHAq+kHTzj8ucGZll9f/ZJ
         1dh9Y228CAD+1Z5PglSiX4o07XyQZxNU+bupArXNSqAk0Zwn2zsueyIPRuSwajsB4g4b
         7dVJIo2iLru+fRFa1T+LyqDsImiw0BW5gSZZhginIS6/O8VObJvVaM8Ijuq85dwMdMWS
         vcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692936176; x=1693540976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m9sg31Vv1AEK6pMFEnTwVpOX88IctMNcLSQaCMVBld0=;
        b=iWKN0IzWH9tn4r/BrHNOyi67BjpDrJ/f6O2etshIrTL4JLZgb0mvKx1zjjfDUez+WJ
         fOkDzwPAy4gzOJfdKNe0z2IugzDwGnFLcJWGnIS862Va3hNauVzDnZ4NTPhASn5qPqq7
         uccxCakGl0KQN9FiQVnzqzGmlCgqXPSbb8VuUGTAexpqIvRBAIuCUUyoEQONHZF72/CW
         G832iE5xWcLiEh1WYLd5UKZL35Sgt5W87Tor3QwjEP5Dsk9UMIbYD8yfACGzBNqQmLEO
         NEO72yFQJOEqw1KK65ZefDbM+L+IPBxQ2+cUuuT5WPzhOzrKk9c2HP+xLuXTzVzocG93
         Nlmg==
X-Gm-Message-State: AOJu0Yyy9m/a1T3huG1/UgnlCSSvIw6OcMFIkKG7fQ2rBz9Y6+ig5m9J
        Tpfv3j5VVrouLUCYebW/7FNj+j3xVYhzR2ThJH6e
X-Google-Smtp-Source: AGHT+IHZUkyR9MmxidQ+Azo47hk9036prVUWmM72oDABWQhlhKfGW0YG595MQ3UnolXiPTEhRcBnaMybLsBwSA/zm2o=
X-Received: by 2002:a05:600c:6027:b0:3f7:e4d8:2569 with SMTP id
 az39-20020a05600c602700b003f7e4d82569mr80654wmb.5.1692936176497; Thu, 24 Aug
 2023 21:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230818012014.212155-1-peter.hilber@opensynergy.com> <20230818012014.212155-3-peter.hilber@opensynergy.com>
In-Reply-To: <20230818012014.212155-3-peter.hilber@opensynergy.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 24 Aug 2023 21:02:45 -0700
Message-ID: <CANDhNCqt2ezUXQvCzuP2yLnNW=3m7uY4S=TYckZjWEw_VBd4uA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/6] timekeeping: Fix cross-timestamp interpolation
 corner case decision
To:     Peter Hilber <peter.hilber@opensynergy.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        "Christopher S. Hall" <christopher.s.hall@intel.com>
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

On Thu, Aug 17, 2023 at 6:20=E2=80=AFPM Peter Hilber
<peter.hilber@opensynergy.com> wrote:
>
> The cycle_between() helper checks if parameter test is in the open interv=
al
> (before, after). Colloquially speaking, this also applies to the counter
> wrap-around special case before > after. get_device_system_crosststamp()
> currently uses cycle_between() at the first call site to decide whether t=
o
> interpolate for older counter readings.
>
> get_device_system_crosststamp() has the following problem with
> cycle_between() testing against an open interval: Assume that, by chance,
> cycles =3D=3D tk->tkr_mono.cycle_last (in the following, "cycle_last" for
> brevity). Then, cycle_between() at the first call site, with effective
> argument values cycle_between(cycle_last, cycles, now), returns false,
> enabling interpolation. During interpolation,
> get_device_system_crosststamp() will then call cycle_between() at the
> second call site (if a history_begin was supplied). The effective argumen=
t
> values are cycle_between(history_begin->cycles, cycles, cycles), since
> system_counterval.cycles =3D=3D interval_start =3D=3D cycles, per the ass=
umption.
> Due to the test against the open interval, cycle_between() returns false
> again. This causes get_device_system_crosststamp() to return -EINVAL.
>
> This failure should be avoided, since get_device_system_crosststamp() wor=
ks
> both when cycles follows cycle_last (no interpolation), and when cycles
> precedes cycle_last (interpolation). For the case cycles =3D=3D cycle_las=
t,
> interpolation is actually unneeded.
>
> Fix this by disabling interpolation if cycles =3D=3D cycle_last. Thereby,=
 avoid
> the above described corner case interpolation failure.
>
> Fixes: 2c756feb18d9 ("time: Add history to cross timestamp interface supp=
orting slower devices")
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>

Thanks for respinning these.   It's still a little tough to get my
head around why this is needed, but the extra explanation helps a lot!

Acked-by: John Stultz <jstultz@google.com>
