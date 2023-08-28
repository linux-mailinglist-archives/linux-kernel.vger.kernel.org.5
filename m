Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC7D78A67F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjH1H3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 03:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjH1H30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:29:26 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22F1C6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:29:23 -0700 (PDT)
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 38C4C3F0E1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 07:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1693207762;
        bh=DIVogeJI0yQ/Lx3mwxf6eSKOkvu0QawcYuc3+Q6t3RE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=r69UCotwW+A4qcyNBT4B40sg2bM363m9adZUjCKGu9YQWSl8ZINXmYsPoyXGl1VnI
         7jfsz2OAAPPMqyotQAxbM67yE4zNAaH+EY9OFzEB6wlW8YKYKar7Lds8/eiSulO6l9
         NFoNzhgSNdtv/YheOZLYzji+w67TWRih1SptknfskzbiI4cqv734j9V8oC3QBAxiwd
         oT1qz3K+g625PJPW83ssgMHN6hBHz/uCt0or7GM+bkoWGnM/X1KNWtzTmNGw8lQvsD
         jfwrf6WFHlPhpI1dfro5tLr2nLQoazti5tyfwMRa2zybBcO+KDQDF8o09Vpv/Sdv9o
         PhpyhE2kODE5w==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-26d3d868529so3231514a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 00:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693207761; x=1693812561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIVogeJI0yQ/Lx3mwxf6eSKOkvu0QawcYuc3+Q6t3RE=;
        b=i8zyAn5q95USFQKBknd9XeraL5BnvNpcHncGyZp6l6UxFIwd0b7qCYXopIx6wqoVrq
         BQE9MA05OJEsCzr75f12Myae+lqS3XDsEx7AQbil6SR136s+pt5iMXPzzc4MwqUkPisw
         hFJqvy9kdJ2vo3gXXlnvqxJ5jLCmt6YDOlvdhyJL5Jp+vfsF6aqBnFjOMnPQzq+APq6P
         oydlAfDGaGL8hZVrV4vJemkTwjJiO8eAaqYLEw/qae65Yh41PWkJ64fkYKb380WbGXtt
         dyPVz/uCEwsaQwO9Cm+G0kkqbaMM6tu29n2mgqy5hw+R3y82aD0Ropr2c0QXgb+nJfDf
         LA5g==
X-Gm-Message-State: AOJu0YzCrSW7I9SAaUFOvjat9nxDfFZ6dYUN9VpXVig8ha9IDn8pQqcL
        h47JZTW9Z9TsgP3ty0+FjVi/gDgff8YpYQ+7B0KKkj0kGSTUZfjRMhyLpKXt8b7O7E0+lhufxP2
        zj2kH1UkKys1QVZ25pV4d1F5YSYxYeofIs1Lsg8u8dnW1V/9SkRk7f9+QEK+6Imm/dQ==
X-Received: by 2002:a17:90a:7041:b0:271:80f2:52c5 with SMTP id f59-20020a17090a704100b0027180f252c5mr3323932pjk.25.1693207760766;
        Mon, 28 Aug 2023 00:29:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmiz+V2SFbh8KCJPFrpA42la3Ej5wpiPSSR3kYZauPA/oKGqucsale97q3YHsaOeL/keQPMRpWzV7PB+WPzsY=
X-Received: by 2002:a17:90a:7041:b0:271:80f2:52c5 with SMTP id
 f59-20020a17090a704100b0027180f252c5mr3323924pjk.25.1693207760477; Mon, 28
 Aug 2023 00:29:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230825063948.GY3465@black.fi.intel.com> <20230826131105.GA691555@bhelgaas>
In-Reply-To: <20230826131105.GA691555@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 28 Aug 2023 15:29:08 +0800
Message-ID: <CAAd53p6qOetGL8VrN8k42tkDksVRvNYAOirX0xbXoaUrJDPp+A@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        bhelgaas@google.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 9:11=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Aug 25, 2023 at 09:39:48AM +0300, Mika Westerberg wrote:
> > On Fri, Aug 25, 2023 at 01:43:08PM +0800, Kai-Heng Feng wrote:
> > > On Fri, Aug 25, 2023 at 1:29=E2=80=AFPM Mika Westerberg
> > > <mika.westerberg@linux.intel.com> wrote:
> > > > On Thu, Aug 24, 2023 at 09:46:00PM +0800, Kai-Heng Feng wrote:
> > > > > On Thu, Aug 24, 2023 at 7:57=E2=80=AFPM Mika Westerberg
> > > > > <mika.westerberg@linux.intel.com> wrote:
>
> > > I think what Bjorn suggested is to keep AER enabled for D3hot, and
> > > only disable it for D3cold and S3.
> > >
> > > > > Unless there are cases when device firmware behave differently to
> > > > > D3hot? Then maybe it's better to disable AER for both D3hot, D3co=
ld
> > > > > and system S3.
> > > >
> > > > Yes, this makes sense.
> > >
> > > I agree that differentiate between D3hot and D3cold unnecessarily mak=
e
> > > things more complicated, but Bjorn suggested errors reported by AER
> > > under D3hot should still be recorded.
> > > Do you have more compelling data to persuade Bjorn that AER should be
> > > disabled for both D3 states?
> >
> > Is there even an AER error that can happen when a device is in D3hot
> > (link is in L1) or D3cold (link is in L2/3)? I'm not an expert in AER
> > but AFAICT these errors are reported when the device is in active state
> > not when it is in low power state.
>
> I don't think a device in D3cold can signal its own errors.  But the
> link transition to L2/L3 as a device goes to D3cold may cause the
> bridge above to log an error.  And of course a config access to a
> device in D3cold will probably result in an Unsupported Request being
> logged by the bridge above it.  I think these are the sorts of errors
> we do need to avoid or ignore somehow.

In addition to that, we can't really control what device behaves
during the D3hot (L2) transition.
The kernel can't control what the firmware on the device may respond.

>
> But Configuration and Message requests definitely happen in D3hot, and
> they can cause errors reported via AER.  The spec (r6.0, sec 2.2.8)
> recommends that Messages be handled the same in D0-D3hot.
>
> PTM is an example of where we had errors being reported at suspend/
> resume because we had it configured incorrectly.  If we disabled AER
> in D3hot we might not learn about that kind of configuration problem.
> That's what makes me think there's some value in keeping AER enabled
> in D3hot.

In this particular case, the firmware of the device gets power cycled
and starts sending PTM because of that.
For this case, we want to know the error happens, but in the meantime
there's nothing much can be done.

So is it reasonable to log Corrected Errors, but skipping the AER reset?

Kai-Heng

>
> Bjorn
