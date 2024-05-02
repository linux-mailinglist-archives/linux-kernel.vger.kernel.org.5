Return-Path: <linux-kernel+bounces-166633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8758B9D4B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C227D28A082
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FBA1552EE;
	Thu,  2 May 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyWnJfdj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8686C15A4BB;
	Thu,  2 May 2024 15:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663434; cv=none; b=SMmFbL9DiKvs7rryRWqmuKc3WKIu0Z2y9zkA0yQCr2v7xCeF49ZrGpoGGgLBXf9RSKFSg7YX8A1+QqAXj8hddKbkEzR72C2DtewfTEFRMhjU/Lif4CR1Ez0r1v3qCRtsNytuFNWIImjBpmWYQIe4e7pxkcDtthmhjisGdGbYhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663434; c=relaxed/simple;
	bh=5IqX86MvYbkMaFLjZjBIRmlrcBhqvsnynsm37uOsPSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d4RudI2DBXMGwS+esPGSM9VOCaZLKf7rG5StGQa2TE+7x2TPvZeTGahgvuMipi8yQl6GHesiZIDx7V5gvndTQMwKjg6qLOcy3DpvhLSYXOJ7FOKqW5vuuOZ+iO6f78T6co6skhACSSjhGygUztTiLpqgMbTSF/TpIag6NHaXkB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyWnJfdj; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714663433; x=1746199433;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=5IqX86MvYbkMaFLjZjBIRmlrcBhqvsnynsm37uOsPSw=;
  b=kyWnJfdjlNk2GKGRRIc3NOjVotX7d8rljU8iibnx720TCYCAdDtqbtKT
   gdazrfUPeAf1Vtqm15AdvwM9MLLc0TMetUmDrvXVwYOokhE9NKWoCtxxl
   +jbbn/FJ1L3AwJBtmcRRILyD4IKwiOOhA/CNt8ao2B3W4v10DlfRPIwrN
   rxs9PiXIHfvxyX8rlZHUANsAKXocYMSirU/uibt1l3qJgrEFuCWG+45Ln
   +xXBC2XwK9qnag08x0lt++iUnNZtJBaxTFNUEEMpvyRRaiDvt5yAReCxP
   QslYzz/shKWrR/e5xD2DlxyVqPMgZGejUVCta49x/sTWfzx92LzUduGJN
   Q==;
X-CSE-ConnectionGUID: R+xPVCEMQ/KjPmljZeFusQ==
X-CSE-MsgGUID: POnIa/7RSUuP0iuYpmwu5w==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21584940"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21584940"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:23:52 -0700
X-CSE-ConnectionGUID: CtuVBYUDR8uJXodxLwfJCA==
X-CSE-MsgGUID: F4o+jrUySKmJh0QWoWsY7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27256247"
Received: from spandruv-desk1.amr.corp.intel.com ([10.125.109.143])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 08:23:51 -0700
Message-ID: <95fadbf4772d575bff777ddb738cb6c25b85b779.camel@linux.intel.com>
Subject: Re: [PATCH] HID: intel-ish-hid: ipc: Add check for
 pci_alloc_irq_vectors
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Chen Ni <nichen@iscas.ac.cn>, jikos@kernel.org, bentiss@kernel.org, 
	even.xu@intel.com, lixu.zhang@intel.com, kai.heng.feng@canonical.com, 
	hongyan.song@intel.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 May 2024 08:23:51 -0700
In-Reply-To: <20240429085422.2434036-1-nichen@iscas.ac.cn>
References: <20240429085422.2434036-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-29 at 16:54 +0800, Chen Ni wrote:
> Add check for the return value of pci_alloc_irq_vectors() and return
> the error if it fails in order to catch the error.
>=20
You can write as
"
Add a check for the return value of pci_alloc_irq_vectors() and return
error if it fails.
"

Thanks,
Srinivas

> Fixes: 74fbc7d371d9 ("HID: intel-ish-hid: add MSI interrupt support")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
> =C2=A0drivers/hid/intel-ish-hid/ipc/pci-ish.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index e79d72f7db2a..9b9bc58f0524 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -174,6 +174,11 @@ static int ish_probe(struct pci_dev *pdev, const
> struct pci_device_id *ent)
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* request and enable int=
errupt */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D pci_alloc_irq_vec=
tors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_err(dev, "ISH: Failed to allocate IRQ
> vectors\n");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return ret;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!pdev->msi_enabled &&=
 !pdev->msix_enabled)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0irq_flag =3D IRQF_SHARED;
> =C2=A0


