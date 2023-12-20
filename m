Return-Path: <linux-kernel+bounces-7314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772D081A583
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22FB6B2141C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62924643F;
	Wed, 20 Dec 2023 16:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2BxIldG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C661246435
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 16:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703090591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I5Jq8BRDezR717te4tvhXEJvJSSiHs8Sjo1EI4a07rY=;
	b=h2BxIldGRRI0CwrskzHlpPak54FArjviznY570QD1IUwJ3keKK073jQyHYFvyZ8VdyytWh
	1PluaZfYS7Wa7x59DjmeubKKfDXwI2jmRDpS7o+N/v08bJ94dhQ+84dStdea4WJ0rCxlTA
	ujYDWPvzymskPeqfoX6mw+RMDM8PdUE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-MO9WJEcEMrOevXwrG_QJPg-1; Wed, 20 Dec 2023 11:43:10 -0500
X-MC-Unique: MO9WJEcEMrOevXwrG_QJPg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28bc21b3b48so1426076a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:43:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703090589; x=1703695389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5Jq8BRDezR717te4tvhXEJvJSSiHs8Sjo1EI4a07rY=;
        b=o28TWZdnx8qI+TpJxKL+PFYlon3UyEQQ1d/4uULx6Pj2D/d+YU6i53vfb2S+Aj/TOe
         ajQQoXVkcR7gVjyIMZ0eEsxeBJr5dY2VsNAcG/AEqFHefJvG1o2pDxQLW0vxqjWdrKpx
         F77JakzCKpovrZQE8sXo4LE8I9X7elidZP0wA314LL4TQy5sTuDvupzXv1PqNBSnRrYz
         0mbvYVVqu7gmf4xGIu/Zi06bM7z2MrU/oA8khxlgBSsHrgri/4OQ5kReNCapVs92+dbM
         gC+Tf/SPFvYLQcnMcp3KfbHzz3vdRexCzXx7Vi3tZIBQ2TwnYoRXe0CWx5cJ3j8cuhmQ
         LsiQ==
X-Gm-Message-State: AOJu0Yw7PWL36nZucBbGMAk5ttXsm6cjpD4YCEDTNLoc1XBu947A7Xvh
	2vw1EmDvmH5bwet/cZs9dhjUwnwB3bdObgEVBdf3zZSfLsuhGtmcZlFRPoY/16LWRyYxJJwJXhg
	HzJ1SEu0QqRky8Jk+RN2H23FBPz1pc0FtJO/o3QvU
X-Received: by 2002:a17:90a:bd04:b0:28b:c05f:f145 with SMTP id y4-20020a17090abd0400b0028bc05ff145mr1906703pjr.93.1703090589321;
        Wed, 20 Dec 2023 08:43:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXerTPwc3xtBwcSC0h1zkj/wOXM3W+7k0Hcr9Ots2Qxp5c4/DS5r00p5Hnrft+Y2JqQe4TwC17DWi4GTAXFiQ=
X-Received: by 2002:a17:90a:bd04:b0:28b:c05f:f145 with SMTP id
 y4-20020a17090abd0400b0028bc05ff145mr1906684pjr.93.1703090589020; Wed, 20 Dec
 2023 08:43:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
 <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st> <c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
 <CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
 <87r0jiqmnx.fsf@kernel.org> <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
 <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
 <871qbhqio8.fsf@kernel.org> <871qbg3m2j.fsf@kernel.org>
In-Reply-To: <871qbg3m2j.fsf@kernel.org>
From: Eric Curtin <ecurtin@redhat.com>
Date: Wed, 20 Dec 2023 16:42:32 +0000
Message-ID: <CAOgh=Fyy6yvEtPO3oPgAY-kZMgGNPGQRBbbNk7yCN6OEUnZ92g@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
To: Kalle Valo <kvalo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Hector Martin <marcan@marcan.st>, 
	Daniel Berlin <dberlin@dberlin.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, 
	Hante Meuleman <hante.meuleman@broadcom.com>, SHA-cyfmac-dev-list@infineon.com, 
	asahi@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 16:05, Kalle Valo <kvalo@kernel.org> wrote:
>
> Kalle Valo <kvalo@kernel.org> writes:
>
> > And Arend is the expert here, he has best knowledge of Broadcom
> > devices and I trust him.
>
> But Arend decided to step down:
>
> https://patchwork.kernel.org/project/linux-wireless/patch/20231220095750.307829-1-arend.vanspriel@broadcom.com/
>
> And no wonder.

By the way, just in case my earlier email was misinterpreted, when I
suggested we find another maintainer, I meant a co-maintainer to help
spread the load, test, review, etc.

I'm sad Arend stepped down and that we have less maintainers now. I
meant it in good spirits.

I have received messages from almost 100 people that seem interested
in helping integrate Broadcom wifi in the upstream kernel. I have
asked them kindly to not pollute the mailing list and to read this
thread to get full context.

Is mise le meas/Regards,

Eric Curtin

>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
>


