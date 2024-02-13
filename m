Return-Path: <linux-kernel+bounces-63111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0DD852B10
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D42A284098
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5421B7EB;
	Tue, 13 Feb 2024 08:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="s7XnIvt7"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BACD1AAD0;
	Tue, 13 Feb 2024 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707812752; cv=none; b=uIrlEWxA0eSBIH2CR9w+5FiJI3quEn3OqWViudUWIdyDek8u33W2DlwllfzUZBIIG8zoBpLUHoG2Wj7YjplyQgFIrLFSHAC6+MPk8dU/IurTJK5koz3nTMA/HVQyJLlsDYSo39orfnSQCBED+is1qLxsf4qIpHrnixn9lJHM1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707812752; c=relaxed/simple;
	bh=Y4swPSmixwDlCf3VeNMrCDbgnEXkgQhDCBMQSZgB5ws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MlALvEuYFA5Iq8AuSb+Qnc8hlgCWXkr51Uz7kB7zmtjU1t/3NvmLGAncN/AN7vJH98azjWZM6eXV+gt41mE2ey0w+BlXMNdvzTvlFLr2nXuKWRDFuX2HP7TLIGIjCOwr70j8TVNcGlZlq4T/HNX5kPS+4jsivdCobfWv209dGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=s7XnIvt7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=wntTEVWdVna6Y2qQjgbm6YvNDEH/qFCUkWGzNzGVbT8=;
	t=1707812750; x=1709022350; b=s7XnIvt74Ka+w3UuMLOuCQRvItaATetbHxDkrfLoGx/6kg/
	H7KKeT2Xrvwv4IJp1x7fNyfC7l36jpYkojzgm3rZSO0d8vx8T2NNVHJjrDjDUYjqQvPY/kZgEy5TN
	/Dy2rLM7fIjM8buKBsz0uGS8+UPK5s/h+Olfpu+aXUBxHgAkLNbaolF98LTMGHcUmZnnZNmpaw4Dd
	1mQ5noDtqI8SLp3BxVXziPx9JHYvqHiMRXkwxK8/d9+8sEvADye91itvDsJfQa2P5vig0mdBswd4W
	BWkVnlC5/NidCDZXq1JDSoGtgP5scXRYGvEO164JyJzJSTJ7vCYC0DXzNCdoxZyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZo6q-00000007XZF-2GDC;
	Tue, 13 Feb 2024 09:25:44 +0100
Message-ID: <4044e07e87af766f643f89f839b332973819e048.camel@sipsolutions.net>
Subject: Re: linux-next: manual merge of the wireless-next tree with the pm
 tree
From: Johannes Berg <johannes@sipsolutions.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kalle Valo <kvalo@kernel.org>, 
 Wireless <linux-wireless@vger.kernel.org>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>
Date: Tue, 13 Feb 2024 09:25:43 +0100
In-Reply-To: <20240213110852.51524899@canb.auug.org.au>
References: <20240213110852.51524899@canb.auug.org.au>
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

On Tue, 2024-02-13 at 11:08 +1100, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the wireless-next tree got a conflict in:
>=20
>   drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
>=20
> between commit:
>=20
>   2e171a57c312 ("iwlwifi: mvm: Drop unused fw_trips_index[] from iwl_mvm_=
thermal_device")
>=20
> from the pm tree and commit:
>=20
>   8cb3a308ceb1 ("wifi: iwlwifi: mvm: fix thermal kernel-doc")
>=20
> from the wireless-next tree.

Hah, sorry about that. I told Rafael this was likely not going to
conflict, but didn't see the doc changes ...

I guess we'll have to live with this conflict, unless Rafael you have a
feature branch for this I could pull in and resolve?

johannes


