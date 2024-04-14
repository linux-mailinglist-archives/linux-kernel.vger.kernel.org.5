Return-Path: <linux-kernel+bounces-137978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421FE89EAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64EBB1C22DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C4F29CF4;
	Wed, 10 Apr 2024 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tiiND5PO"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E173B2AD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730049; cv=none; b=nl3oy8CPDXlJLYFEUwpTMS+4MFp+hfJ7L65y8p/9sKloXj5alfEkMfYIRE4xjTGbwyfT46WGVvm6vV7EygSPQyy82MgisAZbb2XhlkcMZiwdI61jWolg/QNUbTvS/a6GqlvteY6ZSIGNiB6IgNpnAT4amvVEqmyC0/1w9mlrdBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730049; c=relaxed/simple;
	bh=pGzvQp1jk6hG2hU4DWJ5Hy5XsdLP/WXM86/nIa3nzDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9e7oYv/ftfSzwTdwagF0w5bssF1xod6RV1Ch3byqRAqkhdBKaWILuYETYZ0+zUCZIt2rVLjSa3aLdQHR15WrXJ3P01gG2PrPGQFdolcN9xoZmGmW0Wikd7Oh6FtX9/fSQtG0fl5yqsObbWiNHl6YRYnBaTWKFdoi/xYRg+Fx2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tiiND5PO; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7D4533F213
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712730044;
	bh=c4RLomVFx/TuAWRMBXK2XWbrdYltPGPf0njvoF5tjOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=tiiND5POxFnDZRSQNQQ1a/I3xtu/ruAyHTsOM1U6udUJV26G2v6nC0YwlKtHBxb7v
	 Rvr5zvwR0BurfEGjwAjQEXm85PnW5ws1k2Z9PtMmr7qQNRLLMg36ntiCHJAyaYUNsn
	 rElkQRdAUpkppdn0UArW6rSmacdNH0C2PJbQDIZok8vXUt6eMnVVzFn4azBnD4ZYiA
	 lfQku+6KB5cr71CgH1CVohCiL7TibVOxcR7Cn+Z0oT1K9cKfioae+OT6yvUIWILCw6
	 /Khq88bBbg21NdmKKdOz25+10+26/4sVAU1wOUpXWojcFtmgjsRAquYpwe8RYpDizH
	 xhV1pPTWY5yxQ==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5d1bffa322eso6979870a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 23:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712730043; x=1713334843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c4RLomVFx/TuAWRMBXK2XWbrdYltPGPf0njvoF5tjOU=;
        b=gylKFaqPXf1GatpAXLFdEKHxIXFw2uInCRnv5skNMg7HIS0G8DnEo+FPYlC2Bv1Ylv
         e12Ys7brO1rSf8Ps1huTMIkDeOGi3DGmsbIDBSIgdeRtJbEsQMVCTeHrIUbD0SwN939U
         nAhqWlZngkfVqh4K0+PbEFaHJLi+z/gOlJywuWktDUee0yQK7bYTieVIH0K8OFCb91fP
         QcWxANmuQqYybTgUtJ4o5m4Oz8xYKycr7rBkXboLqe1XHHqXYuLM8BxpgYGtNJQgRecb
         07f8GYicw12Q0ddbN2GXGHAT7E97lixbtxW3KTCn8Kt5+Z9a51yTqOMddShnNeOidxeD
         J/TA==
X-Forwarded-Encrypted: i=1; AJvYcCXKakh7tGL/5sCYc41l7lBwSRfxsA9tpEgLv1jLJlmh96gk7L4djZ0T6mcuWPA1S6K1H8y7Ok0sCeMPUMGhfHHTN/iG2+d8e/TXmYV7
X-Gm-Message-State: AOJu0YwDIioWipT9Q+fZIAr4FSRi3GxvgyaNGNSCQqE7BFkBss0pSXhC
	4/g93w+xfHI54fYuPf+Th5DOssc0xn7/3LerPFejZr60gnanqYH3/MCe6WzNn9izb0K5b4X4v+z
	QeuULiAgZH6kDt0PrHJlBssez3df187Q1UgMyXOru+COg5OMFo/w7KUv30UseO/BOORj3vJi49J
	ke359nmG8BWzlE5x5rJ5VB032ov1VNYda1PR7JQNGjKcW7GlE8CIX4
X-Received: by 2002:a05:6a20:4309:b0:1a7:3b64:d502 with SMTP id h9-20020a056a20430900b001a73b64d502mr2208380pzk.2.1712730043054;
        Tue, 09 Apr 2024 23:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgyoDZl5olc2xjm1Mxx1Ht8QRN5jAV8LOnYj30hN5SCozJfPV5QBdffJRdphGLQ2L4F90HAbAmEOPBLEJnwNg=
X-Received: by 2002:a05:6a20:4309:b0:1a7:3b64:d502 with SMTP id
 h9-20020a056a20430900b001a73b64d502mr2208360pzk.2.1712730042713; Tue, 09 Apr
 2024 23:20:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231101114541.GA43502@bhelgaas> <20240330134655.GA1659153@bhelgaas>
In-Reply-To: <20240330134655.GA1659153@bhelgaas>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 10 Apr 2024 14:20:31 +0800
Message-ID: <CAAd53p6hH1=pchRidgMg2Go21tG=nJz+nz+6w++9hGSgFOcVgQ@mail.gmail.com>
Subject: Re: Fwd: Regression: Kernel 6.4 rc1 and higher causes Steam Deck to
 fail to wake from suspend (bisected)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, Linux NVMe <linux-nvme@lists.infradead.org>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>, gloriouseggroll@gmail.com, 
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bjorn,

On Sat, Mar 30, 2024 at 9:47=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Keith, Sagi, Hannes, Kai-Heng, +bcc silverspring from bugzilla]
>
> On Wed, Nov 01, 2023 at 06:45:41AM -0500, Bjorn Helgaas wrote:
> > On Tue, Oct 31, 2023 at 03:21:20PM +0700, Bagas Sanjaya wrote:
> > > I notice a regression report on Bugzilla [1]. Quoting from it:
> > >
> > > > On Kernel 6.4 rc1 and higher if you put the Steam Deck into
> > > > suspend then press the power button again it will not wake up.
> > > >
> > > > I don't have a clue as to -why- this commit breaks wake from
> > > > suspend on steam deck, but it does. Bisected to:
> > > >
> > > > ```
> > > > 1ad11eafc63ac16e667853bee4273879226d2d1b is the first bad commit
> > > > commit 1ad11eafc63ac16e667853bee4273879226d2d1b
> > > > Author: Bjorn Helgaas <bhelgaas@google.com>
> > > > Date:   Tue Mar 7 14:32:43 2023 -0600
> > > >
> > > >     nvme-pci: drop redundant pci_enable_pcie_error_reporting()
> > > >
> > > >     pci_enable_pcie_error_reporting() enables the device to send ER=
R_*
> > > >     Messages.  Since f26e58bf6f54 ("PCI/AER: Enable error reporting=
 when AER is
> > > >     native"), the PCI core does this for all devices during enumera=
tion, so the
> > > >     driver doesn't need to do it itself.
> > > >
> > > >     Remove the redundant pci_enable_pcie_error_reporting() call fro=
m the
> > > >     driver.  Also remove the corresponding pci_disable_pcie_error_r=
eporting()
> > > >     from the driver .remove() path.
> > > >
> > > >     Note that this only controls ERR_* Messages from the device.  A=
n ERR_*
> > > >     Message may cause the Root Port to generate an interrupt, depen=
ding on the
> > > >     AER Root Error Command register managed by the AER service driv=
er.
> > > >
> > > >     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > >     Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > >
> > > >  drivers/nvme/host/pci.c | 6 +-----
> > > >  1 file changed, 1 insertion(+), 5 deletions(-)
> > > > ```
>
> > > > Reverting that commit by itself on top of 6.5.9 (stable) allows
> > > > it to wake from suspend properly.
>
> > > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=3D218090
> >
> > Thanks, I requested some dmesg logs and lspci output to help debug
> > this.
>
> silverspring attached lspci output and a dmesg log from v6.8 to the
> bugzilla and also noted that "pci=3Dnoaer" works around the problem.
>
> The problem commit is 1ad11eafc63a ("nvme-pci: drop redundant
> pci_enable_pcie_error_reporting()")
> (https://git.kernel.org/linus/1ad11eafc63a)
>
> 1ad11eafc63a removed pci_disable_pcie_error_reporting() from the
> nvme_suspend() path, so we now leave the PCIe Device Control error
> enables set when we didn't before.  My theory is that the PCIe link
> goes down during suspend, which causes an error interrupt, and the
> interrupt causes a problem on Steam Deck.  Maybe there's some BIOS
> connection.
>
> "pci=3Dnoaer" would work around this because those error enables would
> never be set in the first place.
>
> I asked reporters to test the debug patches below to disable those
> error interrupts during suspend.
>
> I don't think this would be the *right* fix; if we need to do this, I
> think it should be done by the PCI core, not by individual drivers.
> Kai-Heng has been suggesting this for a while for a different
> scenario.

Should I send the patch to mailing list again to stir more discussion?

Kai-Heng

>
> Bjorn
>
>
> commit 60c07557d0cc ("Revert "PCI/AER: Drop unused pci_disable_pcie_error=
_reporting()"")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Mar 29 17:54:30 2024 -0500
>
>     Revert "PCI/AER: Drop unused pci_disable_pcie_error_reporting()"
>
>     This reverts commit 69b264df8a412820e98867dbab871c6526c5e5aa.
>
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ac6293c24976..273f9c6f93dd 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -243,6 +243,18 @@ static int pci_enable_pcie_error_reporting(struct pc=
i_dev *dev)
>         return pcibios_err_to_errno(rc);
>  }
>
> +int pci_disable_pcie_error_reporting(struct pci_dev *dev)
> +{
> +       int rc;
> +
> +       if (!pcie_aer_is_native(dev))
> +               return -EIO;
> +
> +       rc =3D pcie_capability_clear_word(dev, PCI_EXP_DEVCTL, PCI_EXP_AE=
R_FLAGS);
> +       return pcibios_err_to_errno(rc);
> +}
> +EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
> +
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>         int aer =3D dev->aer_cap;
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 4b97f38f3fcf..425e5e430e65 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -40,9 +40,14 @@ struct aer_capability_regs {
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_lo=
g *log);
>
>  #if defined(CONFIG_PCIEAER)
> +int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
>  #else
> +static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
> +{
> +       return -EINVAL;
> +}
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>         return -EINVAL;
> commit 8efb88cf23d4 ("nvme-pci: disable error reporting in nvme_dev_disab=
le()")
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Mar 29 17:52:39 2024 -0500
>
>     nvme-pci: disable error reporting in nvme_dev_disable()
>
>     Debug patch.
>
>     The PCI core enables error reporting in pci_aer_init() for all device=
s that
>     advertise AER support.
>
>     During suspend, nvme_suspend() calls nvme_dev_disable() in several ca=
ses.
>     Prior to 1ad11eafc63a, nvme_dev_disable() disabled error reporting.
>
>     After 1ad11eafc63a, error reporting will remain enabled during suspen=
d.
>     Maybe having error reporting enabled during suspend causes a problem =
on
>     Steam Deck.
>
>     "pci=3Dnoaer" prevents pci_aer_init() from enabling error reporting, =
so as
>     long as the BIOS doesn't enable it, error reporting should always be
>     disabled.
>
>       nvme_suspend
>         nvme_disable_prepare_reset
>           nvme_dev_disable
>
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8e0bb9692685..2be838b5d1f6 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -5,6 +5,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/aer.h>
>  #include <linux/async.h>
>  #include <linux/blkdev.h>
>  #include <linux/blk-mq.h>
> @@ -2603,8 +2604,10 @@ static void nvme_dev_disable(struct nvme_dev *dev,=
 bool shutdown)
>         nvme_suspend_io_queues(dev);
>         nvme_suspend_queue(dev, 0);
>         pci_free_irq_vectors(pdev);
> -       if (pci_is_enabled(pdev))
> +       if (pci_is_enabled(pdev)) {
> +               pci_disable_pcie_error_reporting(pdev);
>                 pci_disable_device(pdev);
> +       }
>         nvme_reap_pending_cqes(dev);
>
>         nvme_cancel_tagset(&dev->ctrl);

