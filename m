Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967327E2732
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjKFOlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjKFOlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:41:22 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B62DF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:41:19 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5a7fb84f6ceso48219417b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 06:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699281679; x=1699886479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHhRL6E1QTK6GLqibFGgeqG7BAAsKilb8/i8BJs0LwY=;
        b=V/+nwwXufVLEkbfBABifJhLKD/ftO9qvmXX24Ic4wvfuMDJd8qwJnQLZhqeF2ApkD9
         WY+msP6dSBFfnaVKg1kzHXCadD8ZqdRmCk6Mh+Lz0cShZWipbVwKC3DTAt8udg+bsaR/
         NqSk5QdFHkNTrCYLVWON9hnqOGbGwGbFpn4t3qisZu6R63mKHe3OmdX5/NjwnpRSSH4o
         Se6qaJ2laYjQiKXEhvb/kQ0heyBQmcN9X2hB/7xXk2/hS+PhdAFpcEqCzD6EJo/TP3HO
         alMEp/K4zg88T7VxoXX1Hr4JP9Jh7/WTmsbJ6zv8eb8wnc2KCx67ERhC3IsjunsUeCrr
         KZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281679; x=1699886479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHhRL6E1QTK6GLqibFGgeqG7BAAsKilb8/i8BJs0LwY=;
        b=vGqW+zg/RDlXqoUUoH+POOUY1VviaheBCcPKWlfaEfDpoGiD3VoW59Azrg3xI3vgy9
         s8l0XFPYSnZatdGwymkH+QicXV/N0QWAOLS/fy6AvgwBvcM0FD/pTFyNtiX9CISf4Gk2
         jFAOceSf+QLdfAEbe2fSPDrmQ4sM/4WWkbglfgg3G6++62TD6ViwYbZXBzXxxrx76iI3
         gs4FSo4JCwZ7ZqX/jp68rlp4PgG3mNr9CG9ZM12Nsl4aT13Z4LNZL3MhJkuGZfZrpm0v
         h39jKP2jnKt0UL9ZC8mJ/royqDg/jCC4kvXnGyPCCjMlLqlziJu9Rib3QP8Jsy/eg6BT
         gyyA==
X-Gm-Message-State: AOJu0YwRlYNhPdABgu3mx24n5yU8rpSLEeXXn25Vvo9SZLpzF4aleb8a
        z505bnFrLnEKVjcKh/cblYusqXHMjLer5udR9nMFLA==
X-Google-Smtp-Source: AGHT+IHuK9urmXNM4I6o8s8Xi8/q3iaCHfOaciV+yWn+XgKe+tUw+ppiaxjedpMQtWoZzWyTKLYCMn70PbXAJfFYtGQ=
X-Received: by 2002:a05:690c:dc5:b0:5a7:b9b1:c0c5 with SMTP id
 db5-20020a05690c0dc500b005a7b9b1c0c5mr9584194ywb.3.1699281677720; Mon, 06 Nov
 2023 06:41:17 -0800 (PST)
MIME-Version: 1.0
References: <20231018103337.34622-1-victorshihgli@gmail.com>
 <CAK00qKBH5P3naXUHhbQ3zgMzQrUxy=v8r84a8RCcdNORVoRPkA@mail.gmail.com>
 <CAPDyKFob14Tc4c0UxRfj2qbXJkDn7NRwNwRuYQ6m9t3c27Kp=Q@mail.gmail.com> <CAK00qKDvdDBJ9zrBh=9anCArOZUis8-kE5bRx=owjD_pe4ZDCg@mail.gmail.com>
In-Reply-To: <CAK00qKDvdDBJ9zrBh=9anCArOZUis8-kE5bRx=owjD_pe4ZDCg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Nov 2023 15:40:41 +0100
Message-ID: <CAPDyKFo4t8+8gW_3y3WpQphVcJG0RGF+TkWG79NA4NCW_eTHRA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer
 timeout of AER
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw, kai.heng.feng@canonical.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2023 at 09:56, Victor Shih <victorshihgli@gmail.com> wrote:
>
> On Fri, Nov 3, 2023 at 6:28=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > On Fri, 3 Nov 2023 at 11:13, Victor Shih <victorshihgli@gmail.com> wrot=
e:
> > >
> > > Hi, Ulf
> > >
> > > Please help review this patch and give me some advice.
> > > I look forward to your reply.
> > >
> > > Thanks, Victor Shih
> >
> > I don't have in-depth knowledge of how to properly solve this for pci,
> > so I am relying on Kai and others to help review.
> >
>
> Hi, Ulf
>
> This is a standalone patch, this patch only solves the warning
> messages that will
>  often appear in the system log when the system accesses the GL975x PCI c=
onfig.
>
> As I discussed with Kai-Heng at the end of
> [V1] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer timeout of AER,
> Kai-Heng will be submitting a patch for the PCIe layer to solve the
> situation he encountered.
> I will also help Kai-Heng test when he submits the patch.
>
> Thanks, Victor Shih

Hi Victor,

I was just about to apply the patch for my fixes branch, when I
realized that it would be better to split it up in two patches. One
patch for GL9755 and another for GL9750.

In this way we can easier manage the back-porting to older stable kernels.

The patch for GL9755 should have the below fixes tag:
Fixes: 36ed2fd32b2c ("mmc: sdhci-pci-gli: A workaround to allow GL9755
to enter ASPM L1.2")

The patch for GL9750 should have the below fixes tag:
Fixes: d7133797e9e1 ("mmc: sdhci-pci-gli: A workaround to allow GL9750
to enter ASPM L1.2")

I think you should feel free to keep Adrian's and Kai's acks for both
of the two new patches, as the end result should end up being the
same.

[...]

Kind regards
Uffe
