Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3130175BD04
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjGUD6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGUD6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:58:41 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5191BFC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:58:39 -0700 (PDT)
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 03B233F460
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 03:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689911917;
        bh=GocbvuUn/KKhNIVDE/WECAklLWGIdwfJnkvuB2CSoho=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=Gu5EYzkuLSWlQhGKPhI7jTxtHXaO325522uAPfp6Xu26/UUyJdKu2w10t01tgMXxQ
         g3Xee0Spdijo+AQgX6t0Zltcw14/M8K6Anbqm2T2cHz4E/Hn8BakBj8YaW7l2zyUdO
         hEN7yTQ+58q2P0g0K6wotc3/6fdp5H3EKqFX3t8dpJAvAqsCJHoXdiiONptGSwskcQ
         ZsSWVTotugi5UWvExW5yFvzjjRU8gf7Hrg0dd0ux6EsGhHFE0XFquk8AeMzOxWGTgl
         PEq3AVTk91aPnyx2H9HLEkeTgWvRkTxhBCO5ovIiNOU8z/xeYWAzh2rKdtVDe+QIud
         MDWnspskrFY6A==
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-76839756ba4so225493885a.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689911916; x=1690516716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GocbvuUn/KKhNIVDE/WECAklLWGIdwfJnkvuB2CSoho=;
        b=IvrPtCAVlB/7nVkMdbPXrd9N/oSTDwKvikfwOBskgiFHLntqOaLdC4ZiQc1wjc/zFb
         B6N+wXXXHkaIqtbNERLmCZWNweJC3Uny7nLTPagRHr/COy4sLyTg1gYGBIJWGRiXWfOB
         1FaK2A3/p6tDM4dDTBzvrjbQqBm21IhBnjnU9i73o0wP8wuWxQZz0gkHHyIDGbtYU/wE
         LQOBVxNerWgCK4K0Pbijz/LB41/YOHFFxm1U66SncR870hdshvANxz6zq1YKWOhfKblc
         GjkOoX9afQMTJYsCpZnybVtdKzWtg3bmpN/8XAhq3K0f/s5nIYmp0LPFpptGTIgzK883
         p7Tg==
X-Gm-Message-State: ABy/qLYRgXcnACME/TQToS3VPDhav7lK7mkLlyI6KTLN6+XuTECPOu2n
        yMKDWqjsFROoW+MTlTpMjLF1PiZPxWZh+F1s5KM2gencj3R7btw+toQ2Fx0Bc1m/KiNkmIZG4GX
        BJ1rFA1gjnwINEOn4l9AklCibQaA60VLUZ72AYsEn8lHaeIQvJz8KfOnQFGQZKgO+1A==
X-Received: by 2002:a05:620a:370f:b0:767:dd27:f91f with SMTP id de15-20020a05620a370f00b00767dd27f91fmr765497qkb.4.1689911915907;
        Thu, 20 Jul 2023 20:58:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHmRFr03QlbL90E1otFhV26tkDlQsoNE4/JIlUqeXJCA0CvGSuI6Y+qq5Ho+bsJ4Ch2FLZSeBw/KgODSH31WSs=
X-Received: by 2002:a05:620a:370f:b0:767:dd27:f91f with SMTP id
 de15-20020a05620a370f00b00767dd27f91fmr765485qkb.4.1689911915640; Thu, 20 Jul
 2023 20:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230512000014.118942-2-kai.heng.feng@canonical.com> <20230718111702.GA354713@bhelgaas>
In-Reply-To: <20230718111702.GA354713@bhelgaas>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 21 Jul 2023 11:58:24 +0800
Message-ID: <CAAd53p7RfVcZjw+ShtkTmhCAA4zpegRZOzwiXgmanthx_KMjxA@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] PCI/AER: Disable AER interrupt on suspend
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linuxppc-dev@lists.ozlabs.org,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, koba.ko@canonical.com,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org,
        mika.westerberg@linux.intel.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 7:17=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Rafael]
>
> On Fri, May 12, 2023 at 08:00:13AM +0800, Kai-Heng Feng wrote:
> > PCIe services that share an IRQ with PME, such as AER or DPC, may cause=
 a
> > spurious wakeup on system suspend. To prevent this, disable the AER int=
errupt
> > notification during the system suspend process.
>
> I see that in this particular BZ dmesg log, PME, AER, and DPC do share
> the same IRQ, but I don't think this is true in general.
>
> Root Ports usually use MSI or MSI-X.  PME and hotplug events use the
> Interrupt Message Number in the PCIe Capability, but AER uses the one
> in the AER Root Error Status register, and DPC uses the one in the DPC
> Capability register.  Those potentially correspond to three distinct
> MSI/MSI-X vectors.
>
> I think this probably has nothing to do with the IRQ being *shared*,
> but just that putting the downstream component into D3cold, where the
> link state is L3, may cause the upstream component to log and signal a
> link-related error as the link goes completely down.

That's quite likely a better explanation than my wording.
Assuming AER IRQ and PME IRQ are not shared, does system get woken up
by AER IRQ?

>
> I don't think D0-D3hot should be relevant here because in all those
> states, the link should be active because the downstream config space
> remains accessible.  So I'm not sure if it's possible, but I wonder if
> there's a more targeted place we could do this, e.g., in the path that
> puts downstream devices in D3cold.

Let me try to work on this.

Kai-Heng

>
> > As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power Manage=
ment",
> > TLP and DLLP transmission are disabled for a Link in L2/L3 Ready (D3hot=
), L2
> > (D3cold with aux power) and L3 (D3cold) states. So disabling the AER
> > notification during suspend and re-enabling them during the resume proc=
ess
> > should not affect the basic functionality.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216295
> > Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > ---
> > v6:
> > v5:
> >  - Wording.
> >
> > v4:
> > v3:
> >  - No change.
> >
> > v2:
> >  - Only disable AER IRQ.
> >  - No more check on PME IRQ#.
> >  - Use helper.
> >
> >  drivers/pci/pcie/aer.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index 1420e1f27105..9c07fdbeb52d 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -1356,6 +1356,26 @@ static int aer_probe(struct pcie_device *dev)
> >       return 0;
> >  }
> >
> > +static int aer_suspend(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     aer_disable_irq(pdev);
> > +
> > +     return 0;
> > +}
> > +
> > +static int aer_resume(struct pcie_device *dev)
> > +{
> > +     struct aer_rpc *rpc =3D get_service_data(dev);
> > +     struct pci_dev *pdev =3D rpc->rpd;
> > +
> > +     aer_enable_irq(pdev);
> > +
> > +     return 0;
> > +}
> > +
> >  /**
> >   * aer_root_reset - reset Root Port hierarchy, RCEC, or RCiEP
> >   * @dev: pointer to Root Port, RCEC, or RCiEP
> > @@ -1420,6 +1440,8 @@ static struct pcie_port_service_driver aerdriver =
=3D {
> >       .service        =3D PCIE_PORT_SERVICE_AER,
> >
> >       .probe          =3D aer_probe,
> > +     .suspend        =3D aer_suspend,
> > +     .resume         =3D aer_resume,
> >       .remove         =3D aer_remove,
> >  };
> >
> > --
> > 2.34.1
> >
