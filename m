Return-Path: <linux-kernel+bounces-7317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 734FB81A58F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117381F242CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0B346447;
	Wed, 20 Dec 2023 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZflNBp1/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD66A46422
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-28b3b3633f2so2824757a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703090872; x=1703695672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+hr4V87McH82DgC3Anhf9ZloJlMigAPQ1vsksB2THlw=;
        b=ZflNBp1/wjEdZ1kFsTyaJ1LRlzz2rZBspuLYl7qH8zUbOlEl5Snuz1gZqPlzcZjEFQ
         8Osqx0VfHtnZ7V3O3bd2U8l+bUW6xZvgCvrV4gtrWVxlQAgH1wNdA07Jf6PhwPbp46qp
         0biETjS7dvkTGS43pMbZ0xaPG8/PaUeJ0OvIQaRWgBuAfiD2pNfOuiEHu64a/Zoj28HA
         PuNz/YwxWu07bBpPm9g9KfsGWOeuvUCtN7gMKX/K0mSnpN7ZxhajZArT9/D5StYbyKye
         K6Y5YBBcer8z3Jem0tjRRaYbNwCLn6zwn4HYQEW6V+ga+nMvOIAzB22kxCMhckR6E5kV
         DMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703090872; x=1703695672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+hr4V87McH82DgC3Anhf9ZloJlMigAPQ1vsksB2THlw=;
        b=AaSVBxScT8hXwG5ecZRZjy83NBX6DFUjfKJhf5Ev4GdhqEnXSdL8aDbywUmT9pF8E8
         OFr3BlkacfRaFsM/9Lli1/31XaUvO2oo7x4htxLTXVBi5GrdWO8sDUhNal1EPw/1Gxs4
         VGSap01u9kyI7VZnKTNfAWoKCtdlRMZpNyUgBW2haTN0HduV1HX8zmRtBDfdbcyCJpx8
         gz0LIHTVyl7kJ+e0zAoCcqzIwPWB0AcqoMUib7T11yNMkw4NDD+8CQNWYHB+VwF/Dd1L
         b01+eS69Bn/RDlL962sxgs/Z5J/VdT+Ugv8cf5JI7PRZFMk+ve8qPdACR0ExKo/Eu7xX
         +F5w==
X-Gm-Message-State: AOJu0YxdK8nEodz/LrZbeQlMTK6Mds5jt+66WekKgNLc42d588+76TCw
	wZK+kfEK/mRyZtqcz4ozUt32qPLw598=
X-Google-Smtp-Source: AGHT+IH5gx6vnqTwyocc2CBsKDtajkCjexiIjNt640B3FJKdOZRpDJU0pQJha2B2fA8cqvRtV67GkzUa8y8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1a8b:b0:28b:da1b:ec98 with SMTP id
 ng11-20020a17090b1a8b00b0028bda1bec98mr81097pjb.0.1703090872134; Wed, 20 Dec
 2023 08:47:52 -0800 (PST)
Date: Wed, 20 Dec 2023 16:47:50 +0000
In-Reply-To: <DB3PR0502MB999347F512ECFDBE3BFA9941B697A@DB3PR0502MB9993.eurprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <DB3PR0502MB999347F512ECFDBE3BFA9941B697A@DB3PR0502MB9993.eurprd05.prod.outlook.com>
Message-ID: <ZYMator0DDfq_moN@google.com>
Subject: Re: Bug: After a 'warm' reboot the disk is missing (not detected by
 the bios) on a HP t640
From: Sean Christopherson <seanjc@google.com>
To: "Ben Mesman | Spark Narrowcasting" <ben@sparknarrowcasting.nl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

+LKML and other maintainers

On Tue, Dec 19, 2023, Ben Mesman | Spark Narrowcasting wrote:
> Hello,
> 
> First of all, sorry if this is not the proper way of submitting a patch.
> According to the get_maintainer.pl-script for arch/x86/kernel/reboot.c you
> are one of the maintainers of that file. If the patch should go to a
> different maintainer, can you direct me to either the right person, or the
> right location to find such a person?

Please don't send private mails.  Kudos for using get_maintainer.pl, but a demerit
for not Cc'ing the mailing lists :-)

https://people.kernel.org/tglx/notes-about-netiquette

> I recently started upgrading some of my remote managed thin-clients from a
> 5.15.x kernel to a 6.1.x kernel. When rebooting with the new(er) kernel, the
> HP t640 clients failed. The problem is that after the warm reboot, the BIOS
> is unable to locate the internal storage (so it can't boot a valid OS).
> 
> With some digging around I found that adding "reboot=p" will solve the
> problem, but because the systems are remote managed, I am unable to add this
> boot-parameter in any straightforward way.
> 
> I reported the issue as a bug in Debian
> (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1056056) but to get it
> solved permanently, they told me to try and get a patch/solution upstream.
> 
> What worked for me is the attached patch, which adds a reboot-quirk for the
> affected systems. I can submit this also as a pull-request (I think) but I
> don't know the proper way of submitting a pull-request, the last one I did
> was more than 10 years ago.
> 
> Kind regards,
> Ben Mesman
> ben@sparknarrowcasting.nl
> 
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 830425e6d38e..d63cc44a1117 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -468,6 +468,14 @@ static const struct dmi_system_id reboot_dmi_table[] __initconst = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "HP Compaq"),
>                 },
>         },
> +       {       /* Handle problems with rebooting HP t640 thin-clients */
> +               .callback = set_pci_reboot,
> +               .ident = "HP t640",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "HP t640 Thin Client"),
> +               },
> +       },

I'm not familiar with this code (I'm not actually a maintainer/reviewer for this
code, by default get_maintainer.pl Cc's people that have recently modified the
file in question), but this looks like a hack to workaround a bug elsewhere.

All of these quirks are obviously workarounds for some kind of bug, but AFAICT
the quirks are to workaround hardware or firmware bugs, not kernel bugs.  Since
5.15.x kernels worked, odds are good a bug was introduced between 5.15 and 6.1,
i.e. that this is fudging around a kernel bug that can and should be fixed.

Are you able to bisect the kernel between 6.1 and 5.15 to try and pinpoint an
exact commit that introduced the problem?

