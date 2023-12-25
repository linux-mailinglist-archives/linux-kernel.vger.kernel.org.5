Return-Path: <linux-kernel+bounces-11077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAFD81E10C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 14:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEDAB1F22315
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB7C524C7;
	Mon, 25 Dec 2023 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4Ga8Hx/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A07A52F63;
	Mon, 25 Dec 2023 13:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9b3a967dbso784306b3a.1;
        Mon, 25 Dec 2023 05:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703512599; x=1704117399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fM2VXiQ1IcJYQBkF9PNmVeVe6d/DP76dAF1I7KIjp8=;
        b=T4Ga8Hx/w3l+uYu3jUy1YoCfHrMhI/GuosFHOhbBISLRH/KJcX4ntn18uZYp5GtyKM
         QBOM+Mg6L+ZLnC0A80mxtQfwz/a0wcnba5+x/VAyvSIMoMxUYnUaYgCpElwTXXzKzF6/
         Mi8FtONYyMNDNhLmihtkLwle63urqp/zGcdcReL6WQX8Na0jtEtu1ozXEsEsH/E0aQyG
         iCPU8K44t/b2IR0imp4MQsmaem9uqbZ3tyOQxJbD3wM95AgwHCCGkh0A5stebyTIdLfQ
         85uzqNw4KgtsOcfznld+ptKdXwUOT7RLhGLehjO7pz92gj5DasEq7UAc7PPiOOmu3IOQ
         ChLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703512599; x=1704117399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fM2VXiQ1IcJYQBkF9PNmVeVe6d/DP76dAF1I7KIjp8=;
        b=QOmeCffvKBmpue18maUpe4pgt7AgBlf5CJY3+Zlic13nXIs5wyK/ZmwNIjKoeILX6U
         3u5o3QgWU9z4fjERhiJC5rbwHz85VD1CGxTR4wsJJaWHFZhj5P+Binp1FpiVmCNCxpwz
         0vtsENm1+tngWwP1KTaAMjlJnQnumUMyrF8zhIlXkyST3Llxwhgc3lRMjNQu85/C1qLH
         WGGSYe9cDEQhe2G2JeBzJeB4rd5oUxp9zKJ7YIkuNf2nwiYA1SnBA3IPsx1WNM+M1/G7
         Ccu09vhfcGu32LAO+gwjUUNC6nUMetvVL6CqVmw5sZ5pz5zuyK4Rze8rnk4F2UQSAQ28
         jxwg==
X-Gm-Message-State: AOJu0YwEyXj9hDi1Rd4plAwzzn5/8uSzy+mardft0U8Evt07wEF17qHg
	AYYM5toIw2eyNAD2QMz5iHsJLfksNoLiIswkykHz41TVxdcbqA==
X-Google-Smtp-Source: AGHT+IGbm2tAa+JlyWvqqvKbXxgqy6Tb5+mXiFvLj4qXtVOOnr4gq0vZZsrlU1yvUYVFOvMZlQex3+hqA1GTFB6847Q=
X-Received: by 2002:a05:6a21:33a4:b0:195:4251:de2b with SMTP id
 yy36-20020a056a2133a400b001954251de2bmr6553175pzb.63.1703512599285; Mon, 25
 Dec 2023 05:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABOYnLz+S=-GosJ83BNgeY1hZhy7XAc2Eon3SrbCDTSrKfC9Tw@mail.gmail.com>
 <4f00e925-16e9-4c86-b3a2-41e0e5c3b73b@linaro.org>
In-Reply-To: <4f00e925-16e9-4c86-b3a2-41e0e5c3b73b@linaro.org>
From: xingwei lee <xrivendell7@gmail.com>
Date: Mon, 25 Dec 2023 21:54:08 +0800
Message-ID: <CABOYnLwMeKeNgzt6m3y1onyGWXbMBgj1PExgT4JriAV3u7c7ig@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in nci_rx_work
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: davem@davemloft.net, Eric Dumazet <edumazet@google.com>, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org, 
	jeremy@jcline.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2023=E5=B9=B4=
12=E6=9C=8825=E6=97=A5=E5=91=A8=E4=B8=80 21:25=E5=86=99=E9=81=93=EF=BC=9A
>
> On 24/12/2023 02:38, xingwei lee wrote:
> > Hello I found a bug in net/nfc in the latest upstream mainline titled
> > KMSAN: uninit-value in nci_rx_work.
> > I aslo comfirmed in the latest net tree.
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: xingwei lee <xrivendell7@gmail.com>
> >
> > kernel: net 7c5e046bdcb2513f9decb3765d8bf92d604279cf
> > kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=
=3D4a65fa9f077ead01
>
Hi Krzysztof. Thanks for your  prompt response!
> Isn't this just syzkaller report? If it is not syzkaller report, then
However, I'm really careful to check sybot and lkml to make sure that
my report is not duplicated. Can you provide specific information on
with syzbot dashboard or maybe this one is duplicated with another bug
that I do not notice?
> your references are a bit confusing, so short explanation would be nice.
>
> Best regards,
> Krzysztof
>
BTW, I'm doing some research on reproducing non-reproduction bugs on
syzbot. This one is another not on the dashboard but when I reproduced
and triggered it on the last net tree, I think it is still necessary
to report for helping fix it.

Merry Christmas~~~
Best regards
xingwei Lee

