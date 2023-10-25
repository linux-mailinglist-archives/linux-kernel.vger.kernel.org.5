Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8066F7D6AED
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjJYMMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjJYMMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:12:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A192218C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:12:27 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so82638261fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 05:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mwa.re; s=google; t=1698235946; x=1698840746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmQirNixdBVLhzipjmpOh2DK+B144w1ZHT/Th2x89pQ=;
        b=AxEvfFUL/0usdcOCkF6SNtQ7QRY39pD1tW5LkM3jP6gAvdZSOV7tcrzx48LKRt7ki6
         Ljav4p+LUtYY6AmBE8mlo1zW3HLsAKe30faAP3ORgimJ4vISI1IzhZCpMNDg3u8sKyCv
         9ky1wqLq9XwymHarMu66PMQmfh+FmVjFvT4Qt0OR5wC1rS8R7fmmQpdM1nSn4my5kT53
         tJPoI7v6DTpdRcuICtFijaJvAKFMEsPd5JMyuM8Gj1+wWNf4x9MxBdPdy7hShTAvUVIC
         shT7pUxE/svCDMdGfwlEzezvhpAyyni2o5wm9/MxYVUSCeL73kL3GqLk5SCvoZJFJx3m
         LqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698235946; x=1698840746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmQirNixdBVLhzipjmpOh2DK+B144w1ZHT/Th2x89pQ=;
        b=DIwOaEL0/HU1waxoeUP45MiSaesu69a91WLO0FGd5u+agN7lnYtSf6dmWgKX+I1RjT
         dHvgHWRuTOuBPcMHPKtWGxx+TFnn9VlS/nz91gU6XL0S1R/rIbZ8EeifzDby/jLWnzWh
         V0aWU9Gj2g7Kfj17H0SiWs95JI2OCuSZDlRO6QxcFOmQAaFok+x8ZzsUCEYWEdWtfTCp
         R2P/spWfxokfbjO8Sy1DkhvHiD9OnhF1WChY4DWK2SD6aLq3ToxcD9uG0WqmVaIKtBoa
         L0C6z25MScj7M6gjuy/zUw5HPSxArmWSzf2F5fKNrSen1Ea/PPCWiPM75+BY3IP2PbT+
         3Sog==
X-Gm-Message-State: AOJu0Yz9rb4v0JPCCae90a0zMDS10Wixg9EaGpvU6gR85U9XH1yF/Qeg
        C/6xGtmwrvC7NdYOz0lISyxxbw/SYLsTDhhz2wfGWA==
X-Google-Smtp-Source: AGHT+IG77TRnbAc5NHxWAToEdv8/60zE5lZkK8dST9jN7Z8I43Q0SHcqnOjXF3cDU1eg/WjvcPXDaMvx+eZ7Rp9b440=
X-Received: by 2002:a2e:b911:0:b0:2c5:2132:24f5 with SMTP id
 b17-20020a2eb911000000b002c5213224f5mr9609306ljb.53.1698235945658; Wed, 25
 Oct 2023 05:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <CANi1PHhzk80HvwQbBM46gpJ6_AA_P6+m5Jo0Nuy_MAdA4C2BhQ@mail.gmail.com>
 <87ttql5aq7.wl-maz@kernel.org>
In-Reply-To: <87ttql5aq7.wl-maz@kernel.org>
From:   Jan Henrik Weinstock <jan@mwa.re>
Date:   Wed, 25 Oct 2023 14:12:14 +0200
Message-ID: <CANi1PHieGooO0DK=6BPwq0UknHzsn9QM3rFQkh3HLMfWxDseUQ@mail.gmail.com>
Subject: Re: KVM exit to userspace on WFI
To:     Marc Zyngier <maz@kernel.org>
Cc:     oliver.upton@linux.dev, james.morse@arm.com,
        suzuki.poulose@arm.com, yuzenghui@huawei.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Lukas_J=C3=BCnger?= <lukas@mwa.re>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Thanks for your feedback. I understand that request_interrupt_window
is not to be used. I assume a setting a flag is a better way,
something similar to KVM_ARCH_FLAG_RETURN_NISV_IO_ABORT_TO_USER, e.g.
KVM_ARCH_FLAG_WFX_EXIT_TO_USER.

I will also check that WFx traps are always enabled while this mode is
active to make sure userspace does not get blocked/scheduled out.

The reason for this is that we cannot have the thread that executes
KVM_RUN to be blocked or scheduled out whenever it hits a WFI.
Nop-WFIs are not a problem, since the PE will just continue executing
instructions, which is fine. We are currently using a timeout signal
that kicks KVM_RUN back into userspace, but we are seeing a lot of
time wasted because our KVM thread hangs in WFI/WFEs. It would be
better if we could just return from KVM_RUN immediately if the thread
would otherwise be blocked.

Thanks
Jan

Am Fr., 20. Okt. 2023 um 21:56 Uhr schrieb Marc Zyngier <maz@kernel.org>:
>
> Hi Jan,
>
> On Fri, 20 Oct 2023 19:45:05 +0100,
> Jan Henrik Weinstock <jan@mwa.re> wrote:
> >
> > Hi all,
> >
> > I am looking for a way to have KVM_RUN exit back to userspace once the
> > vcpu encounters a WFI. It seems the kvm_run->request_interrupt_window
> > flag is currently ignored by arm64.
>
> Well, that's consistent with arm64 not being an x86 implementation. We
> can inject interrupts any time, and there is no notion of "interrupt
> window".
>
> > So my solution thus far is to
> > patch kvm_handle_wfx in arch/arm64/kvm/handle_exit.c and return to
> > userspace with KVM_EXIT_IRQ_WINDOW_OPEN - working example attached.
> > Any chance to get this (or something similar) mainline?
>
> Certainly not as such. For start, this won't hit all WFIs, but only
> those that actively trap. And we don't even *try* to trap WFx in a
> number of cases (vcpu alone in its run queue and/or direct injection).
> There isn't even any guarantee that WFx is anything other than a NOP
> (it is architecturally only a hint), in which case no trap applies.
>
> So your "working example" really isn't one, as the architecture
> doesn't give you a way to do what you're asking for. If you want to
> cause an exit, writing to 'immediate_exit' and delivering a signal is
> the way.
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.



--=20
Dr.-Ing. Jan Henrik Weinstock
Managing Director

MachineWare GmbH | www.machineware.de
H=C3=BChnermarkt 19, 52062 Aachen, Germany
Amtsgericht Aachen HRB25734

Gesch=C3=A4ftsf=C3=BChrung
Lukas J=C3=BCnger
Dr.-Ing. Jan Henrik Weinstock
