Return-Path: <linux-kernel+bounces-59055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565FF84F095
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBED1F21F7B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CE4657C3;
	Fri,  9 Feb 2024 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Sadvmouc"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC735657B6;
	Fri,  9 Feb 2024 07:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707462232; cv=none; b=ZJQrXP1AO5MiC/fm/rpKdISDb0ed5lGasUCVpA6y33H+iHmmz76ktHeqbfi1Uz9v0dFFmo4V4/KAPFQAwh6ODDivl4EOKsn9ssipGaV/WgCbZ6FonmOCzOFj0dPZVFdaplYWKYNNawRvm6uPo42/myqhC+6XIfCW3PgnATd5n/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707462232; c=relaxed/simple;
	bh=oD39GGpIa3n9RPnVlxvtta4sdl95u7aVxINCZb7pq1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kjvG8Lst72ug1bL6hXh6fguun3UIT3/6lN0mTG8ntmTHa11UgvQ7u+NExmmZQMkRv9XMnb07gdBgqxx3l2EAGklqXJqEflrX4w5pVG2sDPoGcA17Ax4/U1gDYlQcuWXN3TZH3Sl+EjOKex97MxqsOEIDakcQbKpy55bxgzQdiv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Sadvmouc; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=M5G8cq5/h5jaQJDYa4hbLffTd4p2e5waNZsFsoE+Gi4=;
	t=1707462228; x=1708671828; b=Sadvmouc3lwDiRzqzNAuAAwKdAyat//69DcgmxpUtZSu8c2
	NepdiJmcIbfhmZcwb1dL6DKgQKXB0AwF4hRQ4CSr0UZJ5IPdgt2tT2+aA68C4o48GuNiKRNRrZpKl
	E8M4fFiPuWgHL0irrmcxCqaUdl54g22boUggs571MimoQQKVa67BAM9hA4yxNVX779DbzcLKkh+k7
	L7dko1wCbQI3ViwVs3ezApRqc6XWv5I3/2rW0YVD0iWBg4hS/r1Bk0c02kwPi+00bcj5JIOWtXi4q
	Mt98H4nb+FgUG85cyY0/zpfgILhFrI4PR1mOsySqKWTA9NnJu2F3+kGQfSCU9vvg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rYKvH-00000000xcM-0YZ9;
	Fri, 09 Feb 2024 08:03:43 +0100
Message-ID: <e42a9ad67eada684fc1ee3d272774248ead9ae26.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with the
 wireless tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>
Cc: Wireless <linux-wireless@vger.kernel.org>, Daniel Gabay
 <daniel.gabay@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>
Date: Fri, 09 Feb 2024 08:03:42 +0100
In-Reply-To: <20240209105606.66e7808b@canb.auug.org.au>
References: <20240209105606.66e7808b@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

Thanks for the heads-up!

On Fri, 2024-02-09 at 10:56 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the wireless-next tree got a conflict in:
>=20
>   drivers/net/wireless/intel/iwlwifi/mvm/tx.c
>=20
> between commit:
>=20
>   2e57b77583ca ("wifi: iwlwifi: mvm: use correct address 3 in A-MSDU")
>=20
> from the wireless tree and commit:
>=20
>   3d869feacb74 ("wifi: iwlwifi: mvm: use FW rate for non-data only on new=
 devices")

I had a different (potential) conflict on my radar and pulled wireless
into wireless-next to avoid it, but this one wasn't on my radar at all.
Sorry about that.

> I fixed it up (see below)

That obviously looks fine, thanks!

johannes

