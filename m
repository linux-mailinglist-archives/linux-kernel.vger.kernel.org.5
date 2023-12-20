Return-Path: <linux-kernel+bounces-6826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0A8819E22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8F0928AD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6562137C;
	Wed, 20 Dec 2023 11:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9fVYFGg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA7A22309
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703072015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GZvXo9n7E1BUG9QukBdJSLRTxHIpYEVliraJ+HgqD48=;
	b=b9fVYFGgzsupIl3ZGFiMbVCBZjibCB6GWG13j/5vqeYoIl/LRzjin4XywIkrrwWKxnmuQW
	K3kINiOxhSQ3+3GGsdwQfN25npYjDtDeT+HEzRWySxKOjRqBiiLLZezZd07J3XaYCIKsh+
	6X5AfIxnTC9Pkqo9LHOMi2TN4Bl/ge4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-IZ45YgO3Pz-Y0jeAr7NRtg-1; Wed, 20 Dec 2023 06:33:33 -0500
X-MC-Unique: IZ45YgO3Pz-Y0jeAr7NRtg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-28b0fe75032so5532598a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703072013; x=1703676813;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GZvXo9n7E1BUG9QukBdJSLRTxHIpYEVliraJ+HgqD48=;
        b=KOT26s+1SrQ1AqccFV1s3FccXTv6DHiM2/ZGAuugomZtdTXEcn1JbshxejOgFttsqB
         OgtH+BHyWMD/WcMd+wAoUUNvZXXjTJ9SQxFjoKaTiJCk2wpWozCBldy1eBjGyMTgdWnW
         NF7cDVG+03T6ks01AFz0wLCUcmkJyMmOx59hD+xUMJdBLJvj2aHH8fk4AIXaazAcULYf
         62qiG8IZkNyqLZy5rFpkcKy2itPF5/pq/w8i8q5D+pqZkSRKOlomoITlbAtRcCDVQ40u
         8ZCxnyRhBfaklshQia8wXh3kfYez4MAkaegptM5mKiAv1+bwwP9F0fpAdtyHw86RwYFP
         62JA==
X-Gm-Message-State: AOJu0YwOgwd4Gh8O4xqor+jGrO09zo5uB1Oy+lwwE8sMXmzP12Jy4Ozf
	ywQ7zlujG/Zov19xmHZVv6TnSmck4oYDCi5MppBrd+ftl3VV09h9iuDehWAgPNZ9fnYKV6n3NJz
	NJ1p73BE6Hn/W6ofMs47k8T57PtlQ2O4d7RjSe4si
X-Received: by 2002:a17:90b:4f8b:b0:28b:cfea:c3a with SMTP id qe11-20020a17090b4f8b00b0028bcfea0c3amr915929pjb.39.1703072012769;
        Wed, 20 Dec 2023 03:33:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrvhx2+ke9fT+Ck2vv/eRkSRqKHgA3znkYCpalIpUXY7DbRWaaCOV/vGf7lKVHCsZIv8L3LHll2lJL8n/QSCE=
X-Received: by 2002:a17:90b:4f8b:b0:28b:cfea:c3a with SMTP id
 qe11-20020a17090b4f8b00b0028bcfea0c3amr915916pjb.39.1703072012512; Wed, 20
 Dec 2023 03:33:32 -0800 (PST)
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
 <87r0jiqmnx.fsf@kernel.org> <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st> <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
In-Reply-To: <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Wed, 20 Dec 2023 11:32:56 +0000
Message-ID: <CAOgh=FyX5tfzB+yN17pYQGy=8pBy4hmL-jc4cMZexzdp=aZSdg@mail.gmail.com>
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hector Martin <marcan@marcan.st>, Kalle Valo <kvalo@kernel.org>, 
	Daniel Berlin <dberlin@dberlin.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, 
	Hante Meuleman <hante.meuleman@broadcom.com>, SHA-cyfmac-dev-list@infineon.com, 
	asahi@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Dec 2023 at 01:54, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 19 Dec 2023 at 16:06, Hector Martin <marcan@marcan.st> wrote:
> >
> > On 2023/12/19 23:42, Kalle Valo wrote:
> > >
> > > Why is it that every patch Hector submits seems to end up with flame
> > > wars?
>
> Well, I do think some of it is Hector's personality and forceful
> approaches, but I do think part of it is also the area in question.
>
> Because I do agree with Hector that..
>
> > Just recently a patch was posted to remove the Infineon list from
> > MAINTAINERS because that company cares so little they have literally
> > stopped accepting emails from us. Meanwhile they are telling their
> > customers that they do not recommend upstream brcmfmac and they should
> > use their downstream driver [1].
>
> Unquestionably broadcom is not helping maintain things, and I think it
> should matter.
>
> As Hector says, they point to their random driver dumps on their site
> that you can't even download unless you are a "Broadcom community
> member" or whatever, and hey - any company that works that way should
> be seen as pretty much hostile to any actual maintenance and proper
> development.
>
> If Daniel and Hector are responsive to actual problem reports for the
> changes they cause, I do think that should count a lot.
>
> I don't think Cypress support should necessarily be removed (or marked
> broken), but if the sae_password code already doesn't work, _that_
> part certainly shouldn't hold things up?
>
> Put another way: if we effectively don't have a driver maintainer that
> can test things, and somebody is willing to step up, shouldn't we take
> that person up on it?

I am trying to help try and find a maintainer in the community, but of
course I can't guarantee anything. Theoretically of course it should
be someone from Broadcom, Raspberry Pi, etc. and not the community
(not that this helps unblock us promptly).

I just would like to say this upstream Cypress driver has a large
number of users via Fedora and CentOS Stream Automotive Distribution.
And that's just the Fedora family of distros. But the Apple Silicon
devices have a pretty large amount of users also.

We need to find a way of accommodating both. If that's either fork the
code into two separate files somehow or find another maintainer, I
don't know (just my uninformed opinion).

Is mise le meas/Regards,

Eric Curtin

>
>                   Linus
>


