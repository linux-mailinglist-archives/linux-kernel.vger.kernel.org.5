Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA247EE633
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 18:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbjKPRyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 12:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345385AbjKPRyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 12:54:35 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29A8D5A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:54:31 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-50949b7d7ffso1568152e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700157270; x=1700762070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RDZxZXQw38fLxfRFujJZywNkog1jvLPlmbJYwotb9A=;
        b=h1qI8PUojdnEGe4GZIYdW8+v6rwVo+Z6uiyxAof+feFxW84nQqSYZU3M+jClyhhnwk
         aM5L5CQSvTxFR88Ld8GHz9xCNNXfqf2Lq/7x5lMWlfM5M2zo+u5XX7CcHgZi0h69Ve48
         ZbSTvD2ubY9l+e3pO3lEQzqGdg91uxVsJlVkJqCCt9T0DP81jqIRiurCtW9aYI6fcGWL
         O5pBiLdgsClaN3br7Fs2QKDsRqUm2JXWLtKZhNr2HNJYIr1bTlArXwIbRFGu9IuTTKNa
         KS7vm/gLx7C/4zTOFTBCw18W44L64eIzywIJ6g3PzIkPKF8UwuTzeLJFlnVv6jnbTC//
         TIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700157270; x=1700762070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RDZxZXQw38fLxfRFujJZywNkog1jvLPlmbJYwotb9A=;
        b=Os693Pb/GewlggJiJR2xJtbIykxaB7sM0FZoYBG6wq5bZH+WsMF8eyNH8/EtJ1Izbm
         pHcHShqAgQWBD+ASCZNqMl4BkLuH1UQISeJzdQ6hrRD+lcE8oXR7u4iw8jq2SpIpctIk
         xlO14lMbC5HFZX0wFTIrvcqXE/a5kXvjdeDdHnmKUADlanMnyYHvjRVYmlwaqZ9mkPzZ
         10eODn6Xl4ZB83RIm3wN0ho+euySATBqrJV4IWPHUyOvbky35LwEGoQE9ekHCq4jv4wJ
         45SxesXjdB0LAqHToWbiKqFtN7Js7qmJoPh6Hp9U6rU5dtIU2q5RbQ2aQRbQefQgAN4l
         +Afw==
X-Gm-Message-State: AOJu0YyJ391WNT+o3bzdfdknWSYCf5RKZII9wCyQnlwXwYgiwgQrzSt2
        XwMgwwFZI3X9ulU3KKwnjrXlCaAkD7tzW32JSBJMVw==
X-Google-Smtp-Source: AGHT+IFz7zh+0ZdIqnz5ejz7YNssiuPxBYm4eGI90YO5NwzWRK1clM3tcLQ26ai2V0O4NIFX72Kok4ogLtDONoifRJg=
X-Received: by 2002:a05:6512:1243:b0:507:a001:792e with SMTP id
 fb3-20020a056512124300b00507a001792emr2974680lfb.46.1700157269663; Thu, 16
 Nov 2023 09:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20231114233859.274189-1-appsforartists@google.com>
 <70f12e96-0fcc-4954-8507-27cf5e15a3b2@redhat.com> <CAAL3-=9YYQBV-T-KhHdYrtGHH1RC29uzTuQ98roAY9GwrNrwmg@mail.gmail.com>
 <CAAL3-=-b3-RZNNfQEYzQxK=SW4PPJ7cmrX8omBniec+tgC2frw@mail.gmail.com>
 <4570d94e-b446-4fd1-a24a-db11a87846c4@redhat.com> <CAAL3-=_p4waxpf9a6B0Yvno0dnakZ6f81-Kfjxwbw4jA_CrcSw@mail.gmail.com>
 <02ea9279-7bdc-43ca-bd7d-898dee14884e@redhat.com>
In-Reply-To: <02ea9279-7bdc-43ca-bd7d-898dee14884e@redhat.com>
From:   Brenton Simpson <appsforartists@google.com>
Date:   Thu, 16 Nov 2023 09:54:18 -0800
Message-ID: <CAAL3-=_y7T1ErkEj_QjDWc7svimA1tCSH=xZ0LPsMCWoi40s3g@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-orientation-quirks: add Lenovo Legion Go
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Allen Ballway <ballway@chromium.org>,
        Patrick Thompson <ptf@google.com>,
        Jared Baldridge <jrb@expunge.us>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh believe me, I tried.  I spent like 2 hours fighting with the CLI to
send it.  There are restrictions on what addresses it can send from
that don't line up with the identity I use for git.  Our corp setup
can be=E2=80=A6complicated.

My workflow for patching the kernel is actually a bit weird: I use the
GitHub web editor to make the patches, and then test them with Nix's
build system, which pulls them by URL.  Since it's a gaming console,
it's easier to use a real computer to write the patches, and then test
them by instigating a build over SSH.

Now that I know the format the email is supposed to take, it might be
easier for me to paste GitHub's .patch body into a plain text email
and add the Signed Off tag by hand.

I just CCed you on a patch created that way.  Does that look okay to
you (at least from a formatting point-of-view).

Thanks again for your patience and assistance.  Sorry for my weird setup.


  .matches =3D {
   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
