Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88ED67A2ADC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 01:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbjIOXFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 19:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237930AbjIOXEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 19:04:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50E810D;
        Fri, 15 Sep 2023 16:04:32 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso3052718a12.3;
        Fri, 15 Sep 2023 16:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694819071; x=1695423871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/dxG2q7F6Mkp+vlHGfUkxcAXUqWVC7Xr/x4rCnTi+nw=;
        b=SMm+JuF0yEka5ORuNsj5M0Yjdn1k+3uWkXuNE7OzcG0hQP3GC9rFQDYk1/3/FepVk+
         Sg50Z0tknh8dhFzU3JEifqKjDR8l8vWA7BDYwyer/Lk1stt56R7pJiFksRRlyC5wtIp4
         enENXb6EExj1JzR6c1p96tcxIpUn6nZuYoJ4ph70tgzK8sx2RTIyJjXYdiAykzHs16JN
         SJgirZeJXkY+UHItpJpRnmIQpY9CWUZZ0U/QIUVdw9jfRFJKv7GR5C4E5sUG2V0aw0Fz
         oM8HPliJayynl/Q8VD2XXLIlg7rwtMB4yTE99/6rxAVq6d/9Z3cX7ZziDDsZcARYVuqr
         I0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694819071; x=1695423871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dxG2q7F6Mkp+vlHGfUkxcAXUqWVC7Xr/x4rCnTi+nw=;
        b=OLl9PNVF+IMJuuIv1DS0qx6lJAZPdg41iQtmpEynkS7YS1uxu/wgXtYRnCBE+yPVRw
         L3uVBHobuiUVylH2cLzzq8wDQhlFHj/ZKBAeVA2q3hi7HK6rDABJ0tyIjx03F9mr66v+
         7Nbc+M9QhliBv54uKtNUVYA6kY4aS8VYt89mvQbN5RIgek8GU+3sG5DfA3YS5WbIoVx2
         c1UloiLo8wk296+s6w+jMfIB05nnuxz8pToxiQJl0OB2Gid8LHFzgsUNEbaGH+LUV4gg
         n7xCqDF6w4P5P6uakeZmEjFFJeT0FCO5dKvmRBA1neHD73GBxAEU5Tpn4+GkLyyiX66R
         jIdQ==
X-Gm-Message-State: AOJu0YyZAq8y8CuD7PFlWZWpW9V1dLA08o2lsR9vZp2Fe7GwXIKsohKf
        CvKdPXHRZNdOC2j7ku98l7dh3MJOHMYOdW/9usdhNd8fb4s=
X-Google-Smtp-Source: AGHT+IFk/4QQIsJh5pUlO7CGZk+/3wXfyCvaMWmuJ3//r/dMlCJwaGmfCc9vG36qHgaiFk9OzPuixZAzv6zA93Qcl9c=
X-Received: by 2002:a05:6402:344e:b0:525:6772:1595 with SMTP id
 l14-20020a056402344e00b0052567721595mr2291463edc.6.1694819071151; Fri, 15 Sep
 2023 16:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <5a7f2a6e-46a4-a5c8-fe6a-c2581496b5cd@gmail.com> <c7e70f54-9696-4b39-aa17-576987ffce85@leemhuis.info>
In-Reply-To: <c7e70f54-9696-4b39-aa17-576987ffce85@leemhuis.info>
From:   brett hassall <brett.hassall@gmail.com>
Date:   Sat, 16 Sep 2023 09:04:19 +1000
Message-ID: <CANiJ1U80VNiLGKEmgYpGjUQ2poREN9uGnv2QXM_GtzjgBtUSWQ@mail.gmail.com>
Subject: Re: Fwd: 5c8a79e8e12b ("wifi: rtw88: correct PS calculation for
 SUPPORTS_DYNAMIC_PS", 2023-05-27) increases CPU usage usage for irq
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'd suggest that there are actually 2 regressions
(https://bugzilla.kernel.org/show_bug.cgi?id=217841 and this bug). Bug
217841 masks this bug as it prevents the laptop reaching package C8
and I'm assuming this bug shows when in C8. The patch for 21784 only
affects devices connected to a VMD controller so I wouldn't expect it
to affect the 8822CE.

Options that I can see are:
1. Park this bug until 217841 is resolved
2. Try to test on a laptop with a Realtek 8822CE but not a VMD
controller. I have access to 5 different laptop models but none meet
those criteria.


Thanks for the reply
Brett

On Mon, 11 Sept 2023 at 23:29, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 27.08.23 04:37, Bagas Sanjaya wrote:
> >
> > I notice a regression report on Bugzilla [1]. Quoting from it:
> >
> >> This commit improves power saving - it enables the kernel to
> >> achieve package C8. To achieve package C8, 3 Ubuntu VMD commits
> >> must be applied as well. [...]
>
> To me that sounds like there is no upstream problem, hence this
> shouldn't be tracked as a regression. Please correct me if I'm wrong.
>
> > #regzbot introduced: 26a125f550a3bf
> > https://bugzilla.kernel.org/show_bug.cgi?id=217828 #regzbot title:
> > correcting SUPPORTS_DYNAMIC_PS calculation for rtw88 increases CPU
> > utilization #regzbot link:
> > https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.2/+bug/2025040
> >
> > Thanks.
> >
> > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217828
>
> #regzbot resolved: invalid: seems to only be a problem with a patched kernel
> #regzbot ignore-activity
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>
>
