Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B2A761B93
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjGYO0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjGYO0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:26:16 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD872100
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:25:41 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a5abb5e2aeso2234014b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690295126; x=1690899926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lbw+hF4eA8HmUSTieTWam1bAFkdmueOZYbqrfQtPVik=;
        b=Zyo9RIYLh1RqD1BppQI/5pZK3I4cnjCpNVNt//x1iVkGuP/r9mpVxDO8Tp/dmAOpbq
         al/heVGeb4ARmh9OzHr/LpmzYYKcZIv+Cc045K8mEyAzhUJHZ1FY53WdNM+IcIaYroLb
         oWWxujsZEoSUKGLUth8fvuLZB932TmKQzcEi0h+cAWeTXfzaLYchtOCVbq+K2dfoClBI
         OtcGZpevEPx5KL3C3s1sw8eJ9JerMXnfuydSMQkkoNT4WbEGDRRdar0cVxAQ358p/0vq
         1pkyrWZHGaPkKmJtQISt6cRccXnHIBHfy68wqi/bjy8Twjamuh5OP0iFLo/WkTExyo88
         75+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690295126; x=1690899926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbw+hF4eA8HmUSTieTWam1bAFkdmueOZYbqrfQtPVik=;
        b=YoQctB6eAR/X0g5gAijlpraTlstv7RTJ0GoTdf9WMchhQ0d3hbViMYeBX97nvSeMXV
         2t1Sgzktmn6Pe7GiHwokJLav1xbZoN4yK2lrBtgx49DK3Oo4+szQABQ29OEXU3dtJzS4
         lGjXCCgb37a/qNSFYZ/YGRXs1SrX2jPCSPKvKvKyJCVhvLlj1SxTTG2/ajNWbUadwSh3
         gCpFRW9772nLoav3QH39NFGqKykQW/aQxGyg4lzU1GhpNUHkLHQk3bqfRpw2/HX+SrSE
         bugyOSedcqq2KpXsAHiKAO1+VCq2uhhaXBPsEdzo/Sow3CyuNh6NcLZK7hZUgbPx4wm7
         gJFg==
X-Gm-Message-State: ABy/qLY/CKkIg0MoiDCnB5X4N/ggxRSKBP32Yj+Oy2q8YSA2i/Z7WpB5
        hApVfi2gtrpaOJ4J5GP7xCYJzMQIr4GQNFh++/MK59yekIiZlkok+fM=
X-Google-Smtp-Source: APBJJlFEEkg5rB18aIvSK8+Pxuko5XW13yL6Ux9oRT9OYqxPj5EenfOymivScqddM+vlji3mHG8ULRQSA3pklcl+aFg=
X-Received: by 2002:a05:6808:301f:b0:3a3:7acc:7dc7 with SMTP id
 ay31-20020a056808301f00b003a37acc7dc7mr15192641oib.12.1690295125987; Tue, 25
 Jul 2023 07:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230531090424.3187-1-johan+linaro@kernel.org>
 <20230531090424.3187-3-johan+linaro@kernel.org> <CAMi1Hd3fe=wk02WG8J7K5Ud1GcWkuKKKrxFjkNguxDkzNz2WVQ@mail.gmail.com>
 <ZKfyH4jRGlVlcLeY@hovoldconsulting.com> <CAMi1Hd2CGQKbMPm6GXfSHgrdHsyngBQ_DBseF08=oEvGdizVcw@mail.gmail.com>
 <ZKvvN53dM5vbAFGi@hovoldconsulting.com> <CAMi1Hd3-iiNYfSyrvXpsjEFQ+_PzR_WJPoDEbcnAvH+Q1O_Pmw@mail.gmail.com>
 <b4a0011e-95fc-dc3c-8201-cc6f64bd7671@leemhuis.info>
In-Reply-To: <b4a0011e-95fc-dc3c-8201-cc6f64bd7671@leemhuis.info>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 25 Jul 2023 19:54:49 +0530
Message-ID: <CAMi1Hd1fZVsNZ2_MQDcbXWTjP6veUhQLsD2QTQY+fxmhZ4WRxQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] Bluetooth: fix use-bdaddr-property quirk
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Johan Hovold <johan@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 at 15:11, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 10.07.23 14:22, Amit Pundir wrote:
> > On Mon, 10 Jul 2023 at 17:14, Johan Hovold <johan@kernel.org> wrote:
> >> On Fri, Jul 07, 2023 at 07:12:35PM +0530, Amit Pundir wrote:
> >>> On Fri, 7 Jul 2023 at 16:37, Johan Hovold <johan@kernel.org> wrote:
> >>>> Are there any error messages in the log when running with this patch?
> >>> I don't see any relevant error message in dmesg. I'll check if I can
> >>> find a command line BT debug tool which I can use on AOSP for
> >>> debugging. There used to be a few hci command line tools, when I
> >>> looked into it a few years ago. Not sure if they are still around and
> >>> useful.
> >> Yeah, I'm not sure how you set the device address with the Android
> >> stack, but there must be some way as there are other bluetooth
> >> controllers out there which similarly need a valid address before they
> >> can be used.
> > I'll look if I can reuse/simplify "btmgmt public-addr" command on
> > Android or find an equivalent tool to do that.
>
> Please correct me if I'm wrong: the avove to me sounds like you are
> happy with this approach, even if this is kind of a regression; but
> likely one that is rare and thus not worth making a fuzz about. In that
> case I'll remove it from the regression tracking:

Hi. Thanks to Stephan, this had been taken care of from the userspace
https://android.googlesource.com/device/linaro/dragonboard/+/f70f12a826af

So please remove it from the kernel regression tracking.

Regards,
Amit Pundir

>
> #regzbot resolve: minor issue, workaround found
> #regzbot ignore-activity
>
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
