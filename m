Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F9F7CCF72
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjJQVmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjJQVmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:42:15 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3F1FA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:42:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so10594983a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697578927; x=1698183727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdTRJHG13Z2N6++a7YzX0QvWRCMms+vfvGikUlYHj+g=;
        b=WEJJvi6gOVWUdbp3qeBMxW0Mo4NtA6BJd54P2fn4X43U3MxNqKLM8zFgyxd76qriFi
         USlCcqYfNDKpJf3DbDJBVEUBz6BbdB1Ud2AvLCbO1UVtoVf1KgrqOQLsIhlM3zdK86rJ
         d69fxybxnKnhavvrnIN9e4cFXxVz3fzIFEFOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697578927; x=1698183727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdTRJHG13Z2N6++a7YzX0QvWRCMms+vfvGikUlYHj+g=;
        b=ftQaBVUEmAtsnXcDQXKAROAsMmvKbhwEFnOD0TUtTOKh1P5DZTKwjP7WVQMFUVgLsU
         WBkyJVpVlE5yIkvm0FEt8IK9VWFelNvjc4try1kXqYa0QOJ7pJAMfyVScmkcAR1Cr8c/
         r6FQVifAN6JjRSN8adxlYBlDDW5SLejbaq26SaQDOb9Dazgy0e6JJV88qFNjJRJoGxbh
         IatlE/un9LKV7vUyV+TbUldCAs5zBVzYsJems0oYLYgGi7OhS6wmRANBAiEGh3dpgu6l
         ZL8bTMxMB4FLyOklaG/hFlpVlPVQxWgwa+ESxdP0ynsbs5TaNVm+sfpHbzBqfCWaz3oa
         IBHA==
X-Gm-Message-State: AOJu0YzUBZZry/aV8bYDKsILO0TTg6pnmlHOp1yA1THALLeNJp78XyGr
        8UGW+ErBHYtrtGGjwSL3UNK+TdEQ0W5AzzVu1eE5tX4o
X-Google-Smtp-Source: AGHT+IGKpdPoNPHTKydtLm8g95RfeC3scq4EgN1m1/H/V7lnHcAqQ4u+FJEiDUfeEksAasFkh7FFgg==
X-Received: by 2002:a17:906:7310:b0:9be:39a4:b440 with SMTP id di16-20020a170906731000b009be39a4b440mr2243158ejc.76.1697578926889;
        Tue, 17 Oct 2023 14:42:06 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id kg11-20020a17090776eb00b009ada9f7217asm426150ejc.88.2023.10.17.14.42.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:42:06 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40662119cd0so13855e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:42:06 -0700 (PDT)
X-Received: by 2002:a05:600c:5108:b0:408:3727:92c5 with SMTP id
 o8-20020a05600c510800b00408372792c5mr46974wms.2.1697578925977; Tue, 17 Oct
 2023 14:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <20231017091900.801989-1-tylor_yang@himax.corp-partner.google.com> <6c7d9c92-7616-4fad-806e-44302c33b63c@linaro.org>
In-Reply-To: <6c7d9c92-7616-4fad-806e-44302c33b63c@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Oct 2023 14:41:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X2kZcyeyK1SBcXaViBft4F6XYtA6+JwBqJswU41V9kUQ@mail.gmail.com>
Message-ID: <CAD=FV=X2kZcyeyK1SBcXaViBft4F6XYtA6+JwBqJswU41V9kUQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] HID: touchscreen: add himax hid-over-spi driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tylor Yang <tylor_yang@himax.corp-partner.google.com>,
        Tomasz Figa <tfiga@chromium.org>, jingyliang@chromium.org,
        poyuan_chang@himax.corp-partner.google.com, hbarnor@chromium.org,
        jikos@kernel.org, wuxy23@lenovo.com, conor+dt@kernel.org,
        luolm1@lenovo.com, robh+dt@kernel.org, dmitry.torokhov@gmail.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        poyu_hung@himax.corp-partner.google.com,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        benjamin.tissoires@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 17, 2023 at 10:08=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/10/2023 11:18, Tylor Yang wrote:
> > Hello,
> >
> > This patch series adds the driver for Himax HID-over-SPI touchscreen IC=
s.
> > This driver takes a position in [1], it intends to take advantage of SP=
I
> > transfer speed and HID interface.
> >
>
> Dear Google/Chromium folks,
>
> As a multi-billion company I am sure you can spare some small amount of
> time/effort/money for internal review before using community for this
> purpose. I mean reviewing trivial issues, like coding style, or just
> running checkpatch. You know, the obvious things.
>
> There is no need to use expensive time of community reviewers to review
> very simple mistakes, the ones which we fixed in Linux kernel years ago
> (also with automated tools). You can and you should do it, before
> submitting drivers for community review.

We can certainly talk more about this, but a quick reply is:

1. If a patch really looks super bad to you then the right thing for
you to do is to respond to the patch with some canned response saying
"you didn't even do these basic things--please read the documentation
and work with someone at Google to get a basic review". This seems
like a perfectly legit response and I don't think you should do more
than that.

2. IMO as a general rule "internal review" should be considered
harmful. When you're a new submitter then absolutely you should get
some internal review from someone who has done this before, but making
"internal review" a requirement for all patches leads to frustration
all around. It leads to people redesigning their code in response to
"internal review" and then getting frustrated when external
maintainers tell them to do something totally different. ...then
upstream reviewers respond to the frustration with "Why were you
designing your code behind closed doors? If you had done the review in
the public and on the mailing lists then someone could have stopped
you before you changed everything".

3. The ChromeOS team is organized much more like the upstream
community than a big hierarchical corporation. Just as it's not easy
for you to control the behavior of other maintainers, it is not
trivial for one person on the team to control what others on the team
will do. We could make an attempt to institute rules like "all patches
must go through internal review before being posted", but as per #2 I
don't think this is a good idea. The ChromeOS team has even less
control over what our partners may or may not do. In general it is
always a struggle to get partners to even start working upstream and
IMO it's a win when I see a partner post a patch. We should certainly
help partners be successful here, but the right way to do that is by
offering them support.

About the best we can do is to provide good documentation for people
learning how to send patches. Right now the ChromeOS kernel docs [1]
suggest using "patman" to send patches and I have seen many partners
do this. Patman will, at the very least, run checkpatch for you. Our
instructions also say that you should make sure you run "checkpatch"
yourself if you don't run patman. If people aren't following these
docs that we already have then there's not much we can do.


So I guess the tl;dr from my side:

a) People should absolutely be posting on mailing lists and not (as a
rule) doing "internal review".

b) If a patch looks really broken to you, don't get upset and don't
waste your time. Just respond and say that you'll look at it once it
looks better and suggest that they get a review (preferably on the
mailing lists!) from someone they're working with at Google.


https://chromium.googlesource.com/chromiumos/docs/+/HEAD/kernel_development=
.md#send-out-the-patch-using-patman


-Doug
