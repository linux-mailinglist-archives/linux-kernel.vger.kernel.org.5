Return-Path: <linux-kernel+bounces-128959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF95896248
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB231C237E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DACB179A7;
	Wed,  3 Apr 2024 02:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZf5hcBS"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6658214F70;
	Wed,  3 Apr 2024 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712109675; cv=none; b=DB4af0ZZ4AjYgiz8pKmY/G+o3PHysU1Xsvy+l3PvLdD1vOw8DLTqB6ozqzGzK/e71iDkX9BSOfeaR52QLrLzHVJljaHHQRU9jQGlsB34/c222hrV7Wn/fIxWeG3M0M8BSCNUFY7Y0i6WEVSy723RK6iufzAkOtcsb4waffkYEh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712109675; c=relaxed/simple;
	bh=BpDt+tf92JC4R6bQIR0AZ9LRysFGYDVx7rMcvoGhgwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRam0De5ZkHeGeEwksI6r/FHzX5Os+tlFl33iXwt9GKTFm5h/wSO0pZCYhZSumu7ud81iVhwsnyhZTIFzNQa1occ0zzWcJqy1KS9fgCsKxE1eFGtKNtCS5W3uPu2rURSMxlNycy9okofZ6bgxL2BxXruPs+4H5+z7q1j+6i9ekc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZf5hcBS; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b70b39efso4177156a12.0;
        Tue, 02 Apr 2024 19:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712109674; x=1712714474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEDMsVuuuoQ1174prvc6pVoSXIXrvtv4pXkECgOo8mQ=;
        b=HZf5hcBSBuZTN1ZwECcybURc5NfH+uPT0BYhrjYvwY1tAzrq6RiuYN6TZlZxIZ38cY
         b+n2HtqkeL5mooApn7RC3NWFdlTnE+PP/o91I9YhuRy+dsPac1ezv7UTxuUpDXRLoMl0
         Lrr2JWYtzT5nJ80wTckknC9Ru5yYwwDCqsz5sCuiznPnXHHjvGGb2cQGgGGEj0Z5pVM4
         DES/kE4f3dfadyF33wkLmwJokMh0ZV+E/C4YLIrd71j9LP8xkTX7NmGpsHMIldQ5D7Aq
         rkyk9Qt+hjr74De4Z2zZw2mPZBYcfu2GE8JNOmdaEYNhcIu9+MkHkjl4CxfmunBA6CsR
         2FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712109674; x=1712714474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEDMsVuuuoQ1174prvc6pVoSXIXrvtv4pXkECgOo8mQ=;
        b=G5f2nkfOGtqPRTL0Dd4tBwXxQEwlduf5wdjRWRON3wThwCUFsI2MKRB/HBTNFQJhBZ
         zNm4i0ubPM8S2n9nH5daSpPZX8BhFqJ19+PmagYMpW5VLFLv8TkAMxyxWBp7pRhTo+yK
         a2i4Pu1+iI7tniSjWKrvppZ3ZN4snEojiavryPgAFQ5k5luQrhNMlywm2AN+YrowdBFh
         CnQpBm73fbX6deYBHML2ftMcqAQri4D6Q/WJOfJsK2rC7baRDqLviujM7ic74guwM3pn
         t0bElbGEQdK6R0CnpCTbNZ5HGp+7YjHyaA+hMELEN66gqjQlFJNZ6uqQBGTpnbvVyg98
         59sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxMsSF88RZuusqln1yHqo7Y+p2I/8ZWBkM6DaxtfMNPUg5DUMbBjrr5cCRpOts2a9VTlEB748Z5SVjUdXlg2kYF41Z1hWtX2/8KsD5me/BtQuwulJfsAFtSOCyTluOOIsYkzCI
X-Gm-Message-State: AOJu0Yzku680e1/sn7vB54xqY5QyAyBd/jC02LbmBibDErlJQE4/f8UA
	D141tCNRKkCefhMHppC13nvJORwD+FeM7JPQqc2uji/a4Q8tTwRa8/lpa6hHR4H8FD8gMfMoEnB
	5GY2DRwz368Op6YT9S1gH9jO3vxQ=
X-Google-Smtp-Source: AGHT+IEkuAu1KEHf0qNFo3/DEdx3/SbuyX9NHysxtbJHzqInyoOkwHICDgHTkvCxXHRJIXikQW4riTdj8T+ZtnHQn1c=
X-Received: by 2002:a17:90a:5909:b0:29d:e70f:7240 with SMTP id
 k9-20020a17090a590900b0029de70f7240mr12467666pji.11.1712109673683; Tue, 02
 Apr 2024 19:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327110142.159851-1-cathy.cai@unisoc.com> <d1da7fdb-10f6-7f69-4820-520469c0193c@bootlin.com>
In-Reply-To: <d1da7fdb-10f6-7f69-4820-520469c0193c@bootlin.com>
From: cathy cai <cathycai0714@gmail.com>
Date: Wed, 3 Apr 2024 10:01:02 +0800
Message-ID: <CAG8gwPWFdckcoP5apUxP1E9haiet=XkRXH4LBygMN2awiVMabA@mail.gmail.com>
Subject: Re: [RFC PATCH] net: stmmac: Fix the problem about interrupt storm
To: Romain Gantois <romain.gantois@bootlin.com>
Cc: Cathy Cai <cathy.cai@unisoc.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, xuewen.yan94@gmail.com, 
	cixi.geng1@unisoc.com, wade.shu@unisoc.com, zhiguo.niu@unisoc.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Romain,

On Sun, Mar 31, 2024 at 4:35=E2=80=AFPM Romain Gantois
<romain.gantois@bootlin.com> wrote:
>
> Hello Cathy,
>
> On Wed, 27 Mar 2024, Cathy Cai wrote:
>
> > Tx queue time out then reset adapter. When reset the adapter, stmmac dr=
iver
> > sets the state to STMMAC_DOWN and calls dev_close() function. If an int=
errupt
> > is triggered at this instant after setting state to STMMAC_DOWN, before=
 the
> > dev_close() call.
> >
> ...
> > -     set_bit(STMMAC_DOWN, &priv->state);
> >       dev_close(priv->dev);
> > +     set_bit(STMMAC_DOWN, &priv->state);
> >       dev_open(priv->dev, NULL);
> >       clear_bit(STMMAC_DOWN, &priv->state);
> >       clear_bit(STMMAC_RESETING, &priv->state);
>
> If this IRQ issue can happen whenever STMMAC_DOWN is set while the net de=
vice is
> open, then it could also happen between the dev_open() and
> clear_bit(STMMAC_DOWN) calls right? So you'd have to clear STMMAC_DOWN be=
fore
> calling dev_open() but then I don't see the usefulness of setting STMMAC_=
DOWN
> and clearing it immediately. Maybe closing and opening the net device sho=
uld be
> enough?
>
 Yes. It could also happen between the dev_open() and
clear_bit(STMMAC_DOWN) calls.
Although we did not reproduce this scenario, it should have happened
if we had increased
the number of test samples. In addition, I found that other people had
similar problems before.
The link is:
https://lore.kernel.org/all/20210208140820.10410-11-Sergey.Semin@baikalelec=
tronics.ru/

>
> Moreover, it seems strange to me that stmmac_interrupt() unconditionnally
> ignores interrupts when the driver is in STMMAC_DOWN state. This seems li=
ke
> dangerous behaviour, since it could cause IRQ storm issues whenever somet=
hing
> in the driver sets this state. I'm not too familiar with the interrupt ha=
ndling
> in this driver, but maybe stmmac_interrupt() could clear interrupts
> unconditionnally in the STMMAC_DOWN state?
>
Clear interrupts unconditionally in the STMMAC_DOWN state directly
certainly won't cause this problem.
This may be too rough, maybe this design has other considerations.

>
> Best Regards,
>
> --
> Romain Gantois, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

 Best Regards,
Cathy

