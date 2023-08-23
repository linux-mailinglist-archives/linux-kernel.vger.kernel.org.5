Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C12537859C4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236289AbjHWNux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjHWNuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:50:52 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D715CEE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:50:50 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bbbda48904so69016891fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692798648; x=1693403448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1EOrOgCseln8t37rY5FBO1h5UdCTgTFQYEVgsNrZcU=;
        b=WCv92+IcD6D4hZoAESWW3dioRImv+ylYqTQXvnpsjZrO7x7/uDFqq1qpN/dGI5YwKU
         B3EQpk9J1MSDK1wHZrKHxl3c+pqEgaokusOZaajgwzzvTQJQYrY/9oAh3gluHFn9nVN3
         EBWyGiXWGM1USSI7Tggn9O1VCe9KE2y6lM6ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692798648; x=1693403448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1EOrOgCseln8t37rY5FBO1h5UdCTgTFQYEVgsNrZcU=;
        b=MgCFAs/5IgpF31r4OJqYPw+V1qZsMxbC4w1MVffBei8u+JI85DWcgPEdqer1RsHTkC
         avQNAH5KiBQ1Iyzp07vQ2DfVb9+8SmEluqDJMAhbMeEn/ch29ZWrja6LZWYp94rP9IwQ
         14B0VZAOoKK4UMEXRyqhKpIbWeU03FSU3TvQ0ovOm/Oqc+Tcuo7Vn/BcbxBP9T8Jupdj
         it2Is9+cMCcIVmNgpGdOYBMf6bjLMcOxvGLFTWOH3swgzZfT4n3h3lBOoN/R6+XYpixj
         +Pi4gPCJg6yR5MUwfUlAizndx4GJyII6GgVATywBDMYzHxylQHpJM+laH5CP/6b5RL+n
         4HLw==
X-Gm-Message-State: AOJu0Ywd1uFAt4uUar1H+i//jkR22V/Dfmua5r/jg+REmq8scm70gK8j
        CsnnWScYkNei9w+waGntd1HwfrlKaag61bV0whugYw==
X-Google-Smtp-Source: AGHT+IGo9+IRolLSArCmBrn+ncxG6gkdaLbU303VOalvuv1hvpM3HIfnQtUrdt3ph1C3tx20196fcVyK0fOYtp0qG8A=
X-Received: by 2002:a2e:81d3:0:b0:2bc:db5a:9545 with SMTP id
 s19-20020a2e81d3000000b002bcdb5a9545mr1737607ljg.14.1692798648532; Wed, 23
 Aug 2023 06:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALm+0cVvHb=Fe8kseVLesjS1d=579c7Bn5hxdiqyzBp5Z7SugA@mail.gmail.com>
In-Reply-To: <CALm+0cVvHb=Fe8kseVLesjS1d=579c7Bn5hxdiqyzBp5Z7SugA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 23 Aug 2023 09:50:37 -0400
Message-ID: <CAEXW_YScFnFG0Y1NgFS7KGS6s9CoXJ3ZQB++6udyK38mcJ=1xg@mail.gmail.com>
Subject: Re: rcutorture: Can not Disable RT throttling
To:     Z qiang <qiang.zhang1211@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 3:37=E2=80=AFAM Z qiang <qiang.zhang1211@gmail.com>=
 wrote:
>
> When running build-in rcutorture tests in 6.5.0-rc4-rt, and found that,
> although the value of /proc/sys/kernel/sched_rt_runtime_us is -1,
>
> cat /sys/kernel/debug/sched/debug
> ....
> rt_rq[6]:
>   .rt_nr_running                 : 4
>   .rt_nr_migratory               : 0
>   .rt_throttled                  : 0
>   .rt_time                       : 0.000000
>   .rt_runtime                    : 950.000000
>
> but the rt_runtime still is 950.000000.
> set sysctl_sched_rt_runtime in rcu_torture_disable_rt_throttle()
> does not disable rt-throttling.

I think you have hit a bug. I think the problem is
rcu_torture_disable_rt_throttle() modifies the sysctl knobs, but does
not change def_rt_bandwidth and reinitialize the rt_rq. I think we
need to call sched_rt_do_global() like the sysfs handler does, or
change the sysctl knobs to be earlier in the boot process before the
rt_rq are initialized.

Or better yet (not sure if it is possible) trigger the sysctl change
via the sysctl layer and let it do the same logic.

Thoughts?

Thanks.
