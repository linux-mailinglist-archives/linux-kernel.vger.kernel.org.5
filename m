Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD95178F546
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347662AbjHaWHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHaWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:07:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC36E11B
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:07:20 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58fbc0e0c6dso16590797b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693519640; x=1694124440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgnjEF4yFasLmpmpPrDGfWRlTkHCJIfRLIREm8beBzY=;
        b=t7Io5IhL9RSuMhtkctSkxHUvO49KKR8JyuvpkVwzmIs8/jD6gi4VZiGJfH6LcsSE9q
         V8I/TuC5PRNTUNqw22BsFHNgxv/AXhZMhWHLs9Gc4vAQPYKKcCxrdyewkseilVP7NuWQ
         dAd2VIANco0vjDM3D/CtFfpWQRG7mxCZUP81ZONaddE/pUc2s9eEl3CvCF7cO6ynMWYY
         Cv5Myn7vOTKa9JKc/7WhmGc9g8rnQG3rPTFWgTDNuqDBLqp8AA3x/FqH2yr1WhauiiMd
         UqH6j6pKm64HQcqijTt4iUSJAjitO01RtBK28emi0fm9mD93QRbnrcM/9WJhlJPaQxlZ
         mmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693519640; x=1694124440;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qgnjEF4yFasLmpmpPrDGfWRlTkHCJIfRLIREm8beBzY=;
        b=jYy3pfydJjw2d4/00PoZW00L6JZ9gZUJdQ6GqL5mBKTs2mQ0KXIiEWCuCNJwJnhAwd
         7blfL1eyPKqkc6WbO2GTsr8JT8lP0VFTLCMEnJRnIu19TQdcSOxshS36D5GD4zoWyZo7
         0WVS9JBu7JOKZcwbAkMqR3Usi7k0m9Ml2zIoM5UEMULKKscXGiiiN+GnFloc42eAAphU
         u864ZWWtmDXiWLTiW1JI77LuyCuD8CtgEK1tkJkKYaFhSEqrmvBNrECVSlv22RF4dUYJ
         PR02GYkDrGeifZUTdgmpSR1LGNY2LU/GaNKA7HqkYUJ2PFiNGeT8uqhG7FFWnLxDPrk9
         +tqw==
X-Gm-Message-State: AOJu0YyH3CwTpF35lEN2wWa79dcFFnDmEnjbxJnhWD6sRN2P4q5cohsW
        vuA5yn0Tv4sKl3FFajtZZM0OauYbu28=
X-Google-Smtp-Source: AGHT+IH7jvi73S8Hy8V1cTNRJcs7gjaW7hdTTxoQCUGUr4SIru6AT2AYKzQ67n76Lv+PuuOp0QD90g+s5Og=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:7343:0:b0:d77:df8a:389a with SMTP id
 o64-20020a257343000000b00d77df8a389amr23375ybc.3.1693519640007; Thu, 31 Aug
 2023 15:07:20 -0700 (PDT)
Date:   Thu, 31 Aug 2023 15:07:16 -0700
In-Reply-To: <ZO5OeoKA7TbAnrI1@torres.zugschlus.de>
Mime-Version: 1.0
References: <ZO2RlYCDl8kmNHnN@torres.zugschlus.de> <ZO2piz5n1MiKR-3-@debian.me>
 <ZO3sA2GuDbEuQoyj@torres.zugschlus.de> <ZO4GeazfcA09SfKw@google.com>
 <ZO4JCfnzRRL1RIZt@torres.zugschlus.de> <ZO4RzCr/Ugwi70bZ@google.com>
 <ZO4YJlhHYjM7MsK4@torres.zugschlus.de> <ZO4nbzkd4tovKpxx@google.com> <ZO5OeoKA7TbAnrI1@torres.zugschlus.de>
Message-ID: <ZPEPFJ8QvubbD3H9@google.com>
Subject: Re: Linux 6.5 speed regression, boot VERY slow with anything systemd related
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Haber <mh+linux-kernel@zugschlus.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux KVM <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023, Marc Haber wrote:
> Hi,
>=20
> On Tue, Aug 29, 2023 at 10:14:23AM -0700, Sean Christopherson wrote:
> > On Tue, Aug 29, 2023, Marc Haber wrote:
> > > Both come from virt-manager, so if the XML helps more, I'll happy to
> > > post that as well.
> >=20
> > Those command lines are quite different, e.g. the Intel one has two
> > serial ports versus one for the AMD VM.
>=20
> Indeed? I virt-manager, I don't see a second serial port. In either case,
> only the one showing up in the VM as ttyS0 is being used. But thanks for
> making me look, I discovered that the machine on the Intel host still
> used emulated SCSI instead of VirtIO f=C3=BCr the main disk. I changed th=
at.
>=20
> >Unless Tony jumps in with an
> > idea, I would try massaging either the good or bad VM's QEMU
> > invocation, e.g. see if you can get the AMD VM to "pass" by pulling in
> > stuff from the Intel VM, or get the Intel VM to fail by making its
> > command line look more like the AMD VM.
>=20
> In Virt-Manager, both machines don't look THAT different tbh. I verified
> the XML and the differences are not big at all.
>=20
> Do you want me to try different vCPU types? Currently the VM is set to
> "Opteron_G3", would you recommend a different vCPU for the host having a
> "AMD GX-412TC SOC" host CPU?

I would be surprised if using a different vCPU type fixed anything, but it'=
s not
impossible that it could help.  In general, unless someone from the serial =
driver
side spots an issue, fixing whatever the bug is will likely require a repro=
ducer,
which in turn likely means narrowing down what exactly is unique about your=
 AMD
setup.  In other words, if you have cycles to spare, anything you can do to=
 help
isolate the problem would be appreciated.
