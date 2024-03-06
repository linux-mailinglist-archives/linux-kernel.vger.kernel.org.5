Return-Path: <linux-kernel+bounces-93938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9E5873737
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BA4A283CE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D68130AC6;
	Wed,  6 Mar 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbmVyClh"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B8112D1FC;
	Wed,  6 Mar 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730146; cv=none; b=FS9RJzjJRFuXV7PjWjdDs5pM3XaSoosXSqz1pdslMxpUqyZOJlg7Axb3nGFVtefU010ASAkJkb7tMTdYBkffhpXziiRIqEzt9XUKaG0xiSKY2/Ek1X8BJURlVK2emUku5LwPnjap6ItC6mwQWAugHmUVbij0ctLCUwwzMDOVNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730146; c=relaxed/simple;
	bh=4AFROTHMuHkNbiIJu1IN5g677k3qgMNbGiZ+lMx65Aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qp+eHxOEBLspQif9dXkkLPl0vUlcedh8bvgNPYvZasgA02Yw1LWVEK4AW9cnbDEPHl2/aXa6ULt/EwND/7Ihe/mY8JXy5B3wFGTtzwmXCwuiv17yawbVZ1BQg+oiFVQGkeurV2esWswKkjNk3Gt+3SdtCl5wr7G0BkhE17/WlRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbmVyClh; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51326436876so1144819e87.1;
        Wed, 06 Mar 2024 05:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709730143; x=1710334943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2scCxrSMIVw48B77Is9FzJLaywsQG2nWxV6RCAhtBdc=;
        b=UbmVyClhCT6RMXB6cGI7/sQ0jDAx/ak9gm3e5tkD9WPf368LVxUB1fxShiPMlwHwff
         vZaryrIJ+dAs3UKvpPTdLc5lc0ZZ2bCJh1qrcUB8vlavVp4OiNvh650RpTjkaTcwaSkK
         WJgvqPOq31zOYugkZBDCHqMFRllulZ67BZ7UUTSI6bak3BFgS0pgQ4HItufZi8lmQNoB
         LDA0V26/2V9H46sTs8Tm6nY8PndulUF0eqkxrwlD5jKYmvXUtlTZUDAc852nLrIY3cQg
         zOCmU60KhWVqiofm4Vi/Ajh8MB2jdrwJE+57V5v4rCmpDvMXeDN0t8qdZKZLI7n6PmMK
         cwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709730143; x=1710334943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2scCxrSMIVw48B77Is9FzJLaywsQG2nWxV6RCAhtBdc=;
        b=J6orjpd3TH3jeNrg+WzDUbd+HA1vppy0LTrfm/JMYavgGexL0sda9Rin+iNWYqVZrr
         68rGAYvyV9X/l/Bp8vGm7gswA0+XunET4q+TNpQyoxYh7KnKTjUP4hpiuZk47H5O76Xd
         4ctpVNwp89RB4wIBTh1R4pwsMcmgtpSzekOHJ/AQY178EsJjckSmK8g4HJrhNO9khS4C
         ldKEj/1Ctm+IrjDHiKMGh1ncMevL8VrMYwZwdwq6vEmET0UJJtOCCJgQNNF+iQNIg5LG
         u7QkUqoqhuHI4eyjod7TOncdfSNudXKaQiccqPsCKHB0dugfuI1wsRHJ5CeAbEyGHDUU
         X16w==
X-Forwarded-Encrypted: i=1; AJvYcCWJvlWzYL/DOWyvpbpG/51BSKFPPHYB9au+/HZOHh9448RFy1mMaN5xeUztCHS1/UX/gMnSWrY6oPZo7FpEcjuSv+5I5RIfr6P8
X-Gm-Message-State: AOJu0YzYrpcs2dpoyCuLpH1hpUJiJMpmLCVVTdU0EjobeMhaj88/jwlc
	qEJzPAXb5owB0CMm4SE3sqpJTZYx2/zim4uhosiEvsp2nZj9AB0oQnfOF9HH1t4IsFSCgIqPeXC
	X6VVQv8g2BZYsYu2SjrfwDi+ZRya0Hiua
X-Google-Smtp-Source: AGHT+IG8sad1DURZBguoblizmSAITvuTR16ntLK/rmABipQNAgS2rnsDGDXEsNZRrdG5Nj86zK0RB7yHnrM9wVZtxG8=
X-Received: by 2002:a05:6512:6d3:b0:512:d6b6:dc44 with SMTP id
 u19-20020a05651206d300b00512d6b6dc44mr4301391lff.66.1709730142561; Wed, 06
 Mar 2024 05:02:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <hxiq3upwxs3j5mc5arwlx4jriqm7fq5z54wroc4h4kqcq4gq7m@uwnoq2vnkhup>
 <ZeXzuWVmC9AnsECt@debian> <7ubz52rfdl2i76sotvd3s4thv6jvbfao6zct3sywqus2owlvkx@wpbeqqdvipo4>
 <ZehMWQ0LkemsTHAC@debian>
In-Reply-To: <ZehMWQ0LkemsTHAC@debian>
From: Oliver Crumrine <ozlinuxc@gmail.com>
Date: Wed, 6 Mar 2024 08:02:10 -0500
Message-ID: <CAK1VsR0XZMgUW8qMQMcDPohD8-+OZsgW68sZegLbVy6cdoWucQ@mail.gmail.com>
Subject: Re: [PATCH] ip.7: Add not supported by SOCK_STREAM to socket options
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 5:58=E2=80=AFAM Alejandro Colomar <alx@kernel.org> w=
rote:
>
> Hi Oliver,
>
> On Tue, Mar 05, 2024 at 02:31:48PM -0500, Oliver Crumrine wrote:
> > Hi Alex,
> > I have attached two programs in the form of C source code below. No
> > special compilation options required. To change between the three
> > different socket options outlined in my patch, there are two options on
> > line 16 and 18 with a comment above them explaining how to use the
> > fields.
> >
> > Here's how to use the programs:
> > 0. Make sure you have netcat installed.
> > 1. Compile the dgram one.
> > 2. Run it.
> > 3. Run nc localhost 8888 -u (in a seperate terminal window or tab)
> > 4. Type whatever into netcat and press enter
> > 5. Observe that there is a control message recieved, and there is a byt=
e
> > printed, which is the first byte of the data in the control message.
>
> Can't reproduce this.  The terminal running nc(1) isn't printing
> anything.
>
> alx@debian:~$ which nc
> /usr/bin/nc
> alx@debian:~$ which nc | xargs realpath
> /usr/bin/nc.openbsd
> alx@debian:~$ dpkg -S /bin/nc.openbsd
> netcat-openbsd: /bin/nc.openbsd
>
> > 6. You may repeat this for the three different socket options.
> > 7. Repeat for the stream one, but use nc localhost 8888 (without the -u=
)
> > for #5.
> > 8. Observe that there are no control messages recieved with the stream =
one,
> > and byte is 00, which is the initial value of the variable, before it h=
as
> > a value assigned when the control messages (of which there are none) ar=
e read.
> >
> > Thanks,
> > Oliver
>
> Have a lovely day!
> Alex
>
Hi Alex,
Type into netcat, not the program I sent.
My program is the server and prints out whatever it recieves,
along with some other stuff that lets you know which options
are supported.
Thanks,
Oliver

