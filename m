Return-Path: <linux-kernel+bounces-31898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C94833614
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CDD1C20DE8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 20:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5D212E6A;
	Sat, 20 Jan 2024 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="YRd4tKq2"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDF6396;
	Sat, 20 Jan 2024 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705782459; cv=none; b=andHK7L2BKjJWhxOCv/Bd/gComNF/vJZqey5M3IAv2C/8LrKEMSgVD+kudPXeoddSo2+Mqgg5xKy7Hks98izDZz72rUpeywtxctvPC+JgkSj7obndmGVeFgqiTODG/CaXOiNTMPW90bozIps5QCcHgkQfwjNwRWUbYBfw2pTiVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705782459; c=relaxed/simple;
	bh=lF/66FvKXAzZ7V3dWtaNTfnZNtgIynhOFGZ/MUB9phw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lHtEc99+jqSAHE0dHtVZ7LcZSIu/bcJ2WDj9cr0kClnAVCyKKvN53SoeIoxDgJUQCIlWFzAGsLuTpNnBgAfohI64ba2eoSM1paqfM8v/Z58Qa8fNBvSWerb2sr5zqbnS+7xI6mtgM2UaSvmmvZUWW2H1CrJSeY9ix4XrtZeyePY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=YRd4tKq2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rkjhyoAITJExRooUi1ksbqNbsSRsxv+GppPIU6XBsUs=;
	t=1705782456; x=1706992056; b=YRd4tKq2EkpUFXUi6TALLEg4tlmBSl3jNmf7TrUDhbPlwav
	UPEc26C+4d45zwsmiJ6lhhFK15IZad2jCIB2t7RZNaJAZNdZBRfk/3HwvgDiZi29HRJq42Jk8Rxwf
	HKlYVWK6RygIgUMx2yV1w0w4zQ9CIuGfvWwDDEuNxCrSiahiVdIJ6Fn9mzTZhwelS1XtTnVR0BgmZ
	228MUV9CZ3CNu6WlPN5gGahTCVaqx/iDzWv7oYlvw4S3EkT9R06RINO6mR7q+gOcT2g0Mdq1/DGe0
	SF5o9O3A3GrHZ9Lmlm3yNuERe9cEWAHw4PInOHrqwQfZqC+vcNUckaCe2iwY3/Uw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rRHw0-0000000BEZ7-23ve;
	Sat, 20 Jan 2024 21:27:20 +0100
Message-ID: <590fe2823d934af997c515640733eb8889b0560f.camel@sipsolutions.net>
Subject: Re: [PATCH wireless v2] nl80211/cfg80211: add nla_policy for S1G
 band
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Lin Ma <linma@zju.edu.cn>, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org, kvalo@kernel.org
Date: Sat, 20 Jan 2024 21:27:19 +0100
In-Reply-To: <9e1db7f3-fd18-4b3b-a912-3cf6efd96fed@quicinc.com>
References: <20240119151201.8670-1-linma@zju.edu.cn>
	 <9e1db7f3-fd18-4b3b-a912-3cf6efd96fed@quicinc.com>
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

On Fri, 2024-01-19 at 15:47 -0800, Jeff Johnson wrote:
> > --- a/net/wireless/nl80211.c
> > +++ b/net/wireless/nl80211.c
> > @@ -911,6 +911,7 @@ nl80211_match_band_rssi_policy[NUM_NL80211_BANDS] =
=3D {
> >  	[NL80211_BAND_5GHZ] =3D { .type =3D NLA_S32 },
> >  	[NL80211_BAND_6GHZ] =3D { .type =3D NLA_S32 },
> >  	[NL80211_BAND_60GHZ] =3D { .type =3D NLA_S32 },
> > +	[NL80211_BAND_S1GHZ] =3D { .type =3D NLA_S32 },
> >  	[NL80211_BAND_LC]    =3D { .type =3D NLA_S32 },
> >  };
> > =20
> something is really suspicious since the NL80211_BAND_* enums are
> *value* enums, not attribute ID enums, and hence they should never be
> used in an nla_policy.

Yeah, that's what it looks like first, but then they do get used
anyway...

> what is actually using these as attribute IDs, noting that
> NL80211_BAND_2GHZ =3D=3D 0 and hence cannot be used as an attribute ID

Ohh. Good catch!

> seems the logic that introduced this policy needs to be revisited.
>=20

Let's just remove it?

commit 1e1b11b6a1111cd9e8af1fd6ccda270a9fa3eacf
Author: vamsi krishna <vamsin@codeaurora.org>
Date:   Fri Feb 1 18:34:51 2019 +0530

    nl80211/cfg80211: Specify band specific min RSSI thresholds with sched =
scan


As far as I can tell nothing is using that in the first place ...
Certainly not in the kernel, nor wpa_s, nor anything else I could find
really ...

We can't completely revert it since we need the attribute number to stay
allocated, but that's all we cannot remove.

johannes

