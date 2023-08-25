Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656B3787F64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 07:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbjHYFn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 01:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjHYFn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 01:43:27 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795BB1FD3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:43:24 -0700 (PDT)
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E5CA33F227
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 05:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692942202;
        bh=LJCUcg31UklNFHV2Q+2OejZ1G9CU8oFqGaaQwsHgWIM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=WFioxI0IgVvJwwx8yjJuhsaGZ183qgZpmHlgezHrIoxYYybRgc8+FXaORiLcBRnrO
         3Ui5CpsprQRAi2SKD+W4nG0d1feGznVZYggnaHOu3Qm1HaxHX7C2WHS7xbl+Sbkv2Z
         nlnPWN+mLvUZH/Um5vGUuRq+1X5yShZyb1ulUVONhnbdpxhNbH1Pnyu7KjLnq3hy/N
         eTTZaj4XXhWjsRlPQ0iLfcKTeStXWHHVhkDbX1Jnd4zER+Z39TMdf7OEnR7/tpK1vb
         0TZ+hws4nIHElDOIPTdlBkPkYFjAQww8LSxPlC9qkxOuB2a/Zl3a3/cXqgPqU5e1Lb
         BKaFo08ihSdfQ==
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1c8d1a33eaeso622795fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 22:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692942202; x=1693547002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJCUcg31UklNFHV2Q+2OejZ1G9CU8oFqGaaQwsHgWIM=;
        b=Fvj9C5ouaGX9nlvvg9sK54jN2f7KHyR5lmKZs6wCr1tnHvv986Q9eWHdixnF/wonVe
         Kyi7r1ZH02Ahl3YXpDMKTrB1SriAAzxSVZsUh1fmUsEKvorlVPWfVMosHnlqENbp+LOG
         VKQRXcfX9LgKTdmFfwuJK+1hXqY0hbUzvycbegUVzABpMXIOX/m00mQKprj1CId1kJq+
         WkO39V17SFrqOVFxoJmu+vwPdf5yycQ8dkLLwgGMqcdvo9nupSSDb7VSwhwuHY5wJQw4
         f5LYYFynRVGrw2xEAARZVqKrmFY8WamJiV5o7A6qhScGXwxasHjbnFzzE+BV8+CqaPsw
         4tgw==
X-Gm-Message-State: AOJu0YxKIfmqDf3y5WkhxZ9YdriisivmVMpURUI/w3TaDnJ/1ydR10Wk
        lWp89Mf4S8PK8ER8YRwK47h4XL7C88a9RkZ6a3Ti0qDMp0pSSy2IrFyK2i5H8JfytUr1z5fxif1
        MGOM2NPS07g2OdhOzZiXLGM5nJP1YwrKy0nvoXazYMkagHnThzcSrEtkKtg==
X-Received: by 2002:a05:6870:818f:b0:1bf:acf:c1bf with SMTP id k15-20020a056870818f00b001bf0acfc1bfmr2093965oae.38.1692942201902;
        Thu, 24 Aug 2023 22:43:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEdy5NqUU8ce15yI3fHR8e6lh4+thS3wKMlbFd2kzAgOfDR7NRbVZUVYMML67fU3gNYcqgb/hJIicV7FaLM3g=
X-Received: by 2002:a05:6870:818f:b0:1bf:acf:c1bf with SMTP id
 k15-20020a056870818f00b001bf0acfc1bfmr2093954oae.38.1692942201718; Thu, 24
 Aug 2023 22:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230824044645.423378-1-kai.heng.feng@canonical.com>
 <20230824115656.GW3465@black.fi.intel.com> <CAAd53p4Ey15SRkeW-5rDQfxrT8Cif+hYOk2BZ6iQpfd8s51wEw@mail.gmail.com>
 <20230825052946.GX3465@black.fi.intel.com>
In-Reply-To: <20230825052946.GX3465@black.fi.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 25 Aug 2023 13:43:08 +0800
Message-ID: <CAAd53p71gLHq71WtnWBXOaX6K6rXyZ=nrGND5x8ZKXvyNsWBtw@mail.gmail.com>
Subject: Re: [PATCH 1/3] PCI: Add helper to check if any of ancestor device
 support D3cold
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     bhelgaas@google.com, koba.ko@canonical.com,
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

On Fri, Aug 25, 2023 at 1:29=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, Aug 24, 2023 at 09:46:00PM +0800, Kai-Heng Feng wrote:
> > Hi,
> >
> > On Thu, Aug 24, 2023 at 7:57=E2=80=AFPM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Aug 24, 2023 at 12:46:43PM +0800, Kai-Heng Feng wrote:
> > > > In addition to nearest upstream bridge, driver may want to know if =
the
> > > > entire hierarchy can be powered off to perform different action.
> > > >
> > > > So walk higher up the hierarchy to find out if any device has valid
> > > > _PR3.
> > >
> > > I'm not entirely sure this is good idea. The drivers should expect th=
at
> > > the power will be turned off pretty soon after device enters D3hot. A=
lso
> > > _PR3 is not PCI concept it's ACPI concept so API like this would only
> > > work on systems with ACPI.
> >
> > IIUC, Bjorn wants to limit the AER/DPC disablement when device power
> > is really off.
> > Is "the power will be turned off pretty soon after device enters
> > D3hot" applicable to most devices? Since config space is still
> > accessible when device is in D3hot.
>
> Well the device may be part of a topology, say Thunderbolt/USB4 (but can
> be NVMe or similar) where it initially goes into D3hot but in the end
> the whole topology is put into D3cold. The device driver really should
> expect that this happens always and not try to distinguish between the
> D3hot or D3cold.

What if the device is not in such topology? There are cases that the
rootport doesn't have Power Resources associated so the rootport also
stays in D3hot.
I think what Bjorn suggested is to keep AER enabled for D3hot, and
only disable it for D3cold and S3.

>
> > Unless there are cases when device firmware behave differently to
> > D3hot? Then maybe it's better to disable AER for both D3hot, D3cold
> > and system S3.
>
> Yes, this makes sense.

I agree that differentiate between D3hot and D3cold unnecessarily make
things more complicated, but Bjorn suggested errors reported by AER
under D3hot should still be recorded.
Do you have more compelling data to persuade Bjorn that AER should be
disabled for both D3 states?

Kai-Heng
