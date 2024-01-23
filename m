Return-Path: <linux-kernel+bounces-35010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99821838A77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B57284D55
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61FC59B74;
	Tue, 23 Jan 2024 09:38:28 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB7D59B5C;
	Tue, 23 Jan 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706002708; cv=none; b=Qrk+wKCfQ0Cd99crTuF3K2r0oM9a2pzbmnShupzi+f0SS7VnZ17RkC7SXe5CG4n70OaKOhAI/LbdMfn2tt6lG4RikTrgSpJe2vi57gUREFCkJnGz/6u+NZgLlY+/c8mTrCFUd9kIj3vIi262PRA+cJqYPj7a2DeicKKposHluNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706002708; c=relaxed/simple;
	bh=FxLlvg48cPCI0xTuEsv4CQppE6mL1x/n5kLFPEffL/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibflw5FF+nGfVZjj1yhtzI7wCFmKUAWEyoqwOtJ+iBmCYrVAX7HivKCzqlPMO7rckrH7tRoJJ5Nae4WW7OOD0H6dWHNTYeMUGIatu7lfYGOrqwcnu5+gdnIFy9Hndhcq4oOh9/VDl5P6iMyPcHWkReWJ5A8HeTviDjIoO8OK8+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8586861E5FE36;
	Tue, 23 Jan 2024 10:38:10 +0100 (CET)
Message-ID: <48fb7356-506f-40c1-ac2e-4f43c2cbebea@molgen.mpg.de>
Date: Tue, 23 Jan 2024 10:38:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in
 DT
Content-Language: en-US
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123071523.23480-1-quic_janathot@quicinc.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240123071523.23480-1-quic_janathot@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Janaki,


Thank you for your patch.


Am 23.01.24 um 08:15 schrieb Janaki Ramaiah Thota:
> This change is done to avoid BT not to go UNCONFIGURED state when BDA

“This change is done to” is redundant, and can be left out.

> fwnode is not available in DT for QTI SOCs.

It’d be great if you documented the test setup exactly, on how to 
reproduce this.

Please also add a Fixes: tag.

> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>   drivers/bluetooth/hci_qca.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 94b8c406f0c0..11d66f3e5f3f 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -7,6 +7,7 @@
>    *
>    *  Copyright (C) 2007 Texas Instruments, Inc.
>    *  Copyright (c) 2010, 2012, 2018 The Linux Foundation. All rights reserved.
> + *  Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>    *
>    *  Acknowledgements:
>    *  This file is based on hci_ll.c, which was...
> @@ -1904,7 +1905,17 @@ static int qca_setup(struct hci_uart *hu)
>   	case QCA_WCN6750:
>   	case QCA_WCN6855:
>   	case QCA_WCN7850:
> -		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> +
> +		/* Set BDA quirk bit for reading BDA value from fwnode property
> +		 * only if that property exist in DT.
> +		 */
> +		if (fwnode_property_present(dev_fwnode(hdev->dev.parent), "local-bd-address")) {
> +			set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
> +			bt_dev_info(hdev, "setting quirk bit to read BDA from fwnode later");
> +		} else {
> +			bt_dev_info(hdev, "Not setting quirk bit for BDA");

In my opinion, the message in the else branch, should be a debug 
message, and should also contain that `local-bd-address` is not present 
in the devicetree..

> +		}
> +
>   		hci_set_aosp_capable(hdev);
>   
>   		ret = qca_read_soc_version(hdev, &ver, soc_type);
> 
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> prerequisite-patch-id: de5460a6c886a233feff19313b545ee6569369fb
> prerequisite-patch-id: e18252a26d0f289afcbec18113b7f636a46a9aed
> prerequisite-patch-id: 26e607ac96dc6d0d295793a0449a5b4c0f7ddc92
> prerequisite-patch-id: c8d7f229399fc8075722ffe05260675ece93f691
> prerequisite-patch-id: 554cc93ba4899eabe31585bf9591052058609d96
> prerequisite-patch-id: 99c00a3d8d98a880c0d3a5545def0ca9ade0f903
> prerequisite-patch-id: b1ef1add471677d1e1b60eaaab3e109abf7c7b2b
> prerequisite-patch-id: 96131754c09914f327f353dee4daabb7ab5e6f29
> prerequisite-patch-id: 610b5ec4a338d15cf8dba0459d5a1bfd28dccb4d
> prerequisite-patch-id: 5172cd9d99462e123f264f0fd9a9768f2cae5498
> prerequisite-patch-id: f57b8285516730da78089325d53f6125daaf2e6a
> prerequisite-patch-id: 69dc26e36476660935070261f0e11cdd55c35688
> prerequisite-patch-id: 8087dd28f6ef90fc3ad847b4bcde8a096ff721b5
> prerequisite-patch-id: 8640fbfd7e5dcbdb4eacf5b748ea49678a2e6675
> prerequisite-patch-id: b3613c0002cfd9cc77923f6ce781cec90a2f0cd1
> prerequisite-patch-id: dc4f4077bfa02a5d5128bb39ef3a36dfc3db27bc
> prerequisite-patch-id: 9c9aa8de9b4c50252d451a2dd76717c287fe1848
> prerequisite-patch-id: 3c4a931debe7e8aa7d0b70870456421a17ff86a5
> prerequisite-patch-id: df500031c7b6de9320021d52b060338b71340d91
> prerequisite-patch-id: 14758d2fb4b6151aa9c27ab7e3cb8c742988f1d7
> prerequisite-patch-id: 1c28faa0d8a4e294752229611ade87a216da0ce6
> prerequisite-patch-id: 03680549373d9a5b0ab0e4c94260e8aaea04ef25
> prerequisite-patch-id: cfcc27083466c9c87801628fe9c0f2131fc22dae

What to do about these lines?


Kind regards,

PPaul

