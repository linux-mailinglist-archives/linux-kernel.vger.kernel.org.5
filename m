Return-Path: <linux-kernel+bounces-160984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A88B456C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F31E62836F2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEAD481A7;
	Sat, 27 Apr 2024 09:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2FWgJaI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39A91DA53;
	Sat, 27 Apr 2024 09:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714211482; cv=none; b=U+HsMI+YOH3pnWKAymd83g3+dvK3t8C1ZetcDXBsPrPLKQcP6YmHpIFLe0wmBVxrj0i+yocgoM+bXrnsZU0UQKbr1MM5qSHxflSHBWNu3jJRrDnPeB7Ay2E23wLYvG/0J365skylQrKztR3/hBaIgT53OKQAYvLxzC/ThngPVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714211482; c=relaxed/simple;
	bh=+9jHW4K9f03QSUVl2W7YEhTYJug9zNGMkpMyfCOygP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2z2NdNQJskYgnVmoAe3alKaHe9TF1IuqOPJN2GSWdhOlg9r9rCpnAjWqRwUl9ZVSRyNEnCwsOu5aljHhThCxmvOmVdEKeeUNxeCPLU9NWI+x4LpXFa/GN/iIexcH+6wya0RI3mirfT8hr4+P3wvQWWpeHYk2tJ2LGM+lxbkgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2FWgJaI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775E5C113CE;
	Sat, 27 Apr 2024 09:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714211481;
	bh=+9jHW4K9f03QSUVl2W7YEhTYJug9zNGMkpMyfCOygP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p2FWgJaIfciwCvq/aIPFu3JfseSHblixqx3DxRboReHmvIprimvCfu4+DHbPq9jyl
	 uJULBzCVRtvAgdqAe13RZSYUBhv4enfc5mFs1ElKuqIJQgaYDl93q4LEv2Jus/SeqC
	 p+eOThYmjfasvhu7CuTTO8vjZimNthpsIy/24VqPQfkJQA6JCFpcugmxJf/XhjC2YM
	 pPbIyrBq/mP6z8HSdA9nnGQQq64i9M8jbhF87ECSd3B3HPCZZNh8Q5UqrkGHFrxCS3
	 1yLnu/srAxWbT7rNAmg6/FSILV53ALP5xSLDcYASRN/f7EP8fnoUf+ez3T9uJqYLyw
	 EA0dL//xze00Q==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s0eiI-000000006Sa-48Ux;
	Sat, 27 Apr 2024 11:51:23 +0200
Date: Sat, 27 Apr 2024 11:51:22 +0200
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
Message-ID: <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
References: <20240426155801.25277-1-johan+linaro@kernel.org>
 <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>

On Fri, Apr 26, 2024 at 10:23:15AM -0700, Doug Anderson wrote:
> On Fri, Apr 26, 2024 at 9:00 AM Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > The default device address apparently comes from the NVM configuration
> > file and can differ quite a bit.
> >
> > Store the default address when parsing the configuration file and use it
> > to determine whether the controller has been provisioned with an
> > address.
> >
> > This makes sure that devices without a unique address start as
> > unconfigured unless a valid address has been provided in the devicetree.

> >  int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
> >                          enum qca_btsoc_type soc_type)
> >  {
> > @@ -351,6 +348,11 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
> >
> >                         /* Update NVM tags as needed */
> >                         switch (tag_id) {
> > +                       case EDL_TAG_ID_BD_ADDR:
> > +                               if (tag_len != sizeof(bdaddr_t))
> > +                                       break;
> > +                               memcpy(&config->bdaddr, tlv_nvm->data, sizeof(bdaddr_t));
> > +                               break;
> >                         case EDL_TAG_ID_HCI:
> 
> nit: blank line after "break" ?

Possibly, the driver isn't really consistent here and only two case
statements have such a newline after break.

> Also note that on my firmware I never see this tag and thus your patch
> breaks trogdor. Specifically I put a printout here and it never gets
> hit.

Thanks for the quick test. As the parser is modifying the configuration
file I assumed it was correct and tested...
 
> I printed all the tags/lengths:
> 
> [   17.961087] DOUG: id 0xde02, len 0x0010
> [   17.965081] DOUG: id 0x0000, len 0x0000
> [   17.969050] DOUG: id 0x0000, len 0x0011
> [   17.973025] DOUG: id 0x0000, len 0x0a00
> [   17.976991] DOUG: id 0x0303, len 0x0303
> [   17.981066] DOUG: id 0x0033, len 0x1001
> 
> Probably EDL_TAG_ID_BD_ADDR should have been 0xde02, not just 2.

No, the parser is apparently broken and fails to consider an extra
four-byte header found in some NVM files and just happily parses and
potentially modifies (sic!) random bytes.

I've fixed the parser so that it works also on configuration files with
the extra header (apnv??.bin, crnv??[u].bin) and can read out the
default address for all NVM files in linux-firmware that have one
(otherwise all-zeroes is printed below):

bluetooth hci0: bd_addr = 39:80:10:00:00:20 (qca/apnv10.bin)
bluetooth hci0: bd_addr = 39:80:12:74:08:00 (qca/apnv11.bin)
bluetooth hci0: bd_addr = 39:90:21:64:07:00 (qca/crnv21.bin)
bluetooth hci0: bd_addr = 39:98:00:00:5a:ad (qca/crnv32.bin)
bluetooth hci0: bd_addr = 39:98:00:00:5a:ad (qca/crnv32u.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21.301)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21.302)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21.309)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21g.301)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21g.302)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21g.309)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21g.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/htnv20.bin)
bluetooth hci0: bd_addr = 64:90:00:00:5a:ad (qca/msnv11.b09)
bluetooth hci0: bd_addr = 64:90:00:00:5a:ad (qca/msnv11.b0a)
bluetooth hci0: bd_addr = 64:90:00:00:5a:ad (qca/msnv11.bin)
bluetooth hci0: bd_addr = 61:47:aa:31:22:14 (qca/nvm_00130300.bin)
bluetooth hci0: bd_addr = 61:47:aa:32:44:07 (qca/nvm_00130302.bin)

bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_00230302.bin)

bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_00440302.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_00440302_eu.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_00440302_i2s_eu.bin)

bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_usb_00000200.bin)
bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_usb_00000201.bin)
bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_usb_00000300.bin)
bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_usb_00000302.bin)
bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_usb_00000302_eu.bin)

bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0104.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0105.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0106.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0107.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0109.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0110.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_010a.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_010b.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_0303.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf_010a.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf_010b.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf_0303.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf.bin)
bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00190200.bin)

It looks like we're being lucky and the parser is at least not
corrupting the configuration files with the extra header currently in
linux-firmware, but if it ever interprets a random 0x0011 or 0x001b word
as a tag it would.

Fixing the parser means that we would start modifying the configuration
also for files with the extra header. This involves configuring the baud
rate and enabling a deep sleep feature.

Presumably this is something that should be done also on Trogdor, but
this would obviously have to be tested first. I guess we can keep
skipping this step until it has been verified and just read out the
address for now.

> > @@ -624,6 +626,9 @@ static int qca_check_bdaddr(struct hci_dev *hdev)
> >         if (bacmp(&hdev->public_addr, BDADDR_ANY))
> >                 return 0;
> >
> > +       if (!bacmp(&config->bdaddr, BDADDR_ANY))
> > +               return 0;
> 
> The above test feels non-obvious enough to deserve a comment. Could
> you add one? That would also help alleviate my confusion since I
> _think_ your if test is unneeded and maybe wrong? Let's say that the
> firmware didn't have a default address stored in it. It still seems
> like we could try to read the address and then if the firmware gave
> back BDADDR_ANY (0) we should set the `HCI_QUIRK_USE_BDADDR_PROPERTY`
> property, right?

You're right. I'll drop this check when revisiting this next week.

Johan

