Return-Path: <linux-kernel+bounces-2919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DD6816442
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 03:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED82A1C21049
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 02:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E126323C5;
	Mon, 18 Dec 2023 02:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRxQAAtw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597D5228;
	Mon, 18 Dec 2023 02:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-58d18c224c7so1656384eaf.2;
        Sun, 17 Dec 2023 18:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702865213; x=1703470013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKnYT6PKG7isJEwfwt4q7aWVApkXd222Gzbu36ZvTuA=;
        b=JRxQAAtwgYm2eXqme6LNtsat9qKl7TFvuEkwM3LrckM1HHFaax72tcSNWJW8PSY4H4
         yO4/4UnDCjzoPA3Jz8j4+B9ZRQtSjGHHCKCRPG+eCl9vAWzrBbt3NgpfJgF9kA0uhTxQ
         ZJAftAjqkfn6KvuHhgdPDs7/INxo7I5dO31Z+Qyl6lsEDEaBLfdR/1bD6Wnmozrb0/We
         sWCSS81kv3kRS6uoSl/9CAoFhBUZtsctcbG7xyZjGHWjXjj5HkY/ZKOcKcRXZ0cwWl/Q
         GnBe1caeuv0IxsLp+vWdhwSWBvVrogOAd4p0ExQ4Q2v11pS7ZeaTNeXgmtEmBsMkzVWP
         Xfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702865213; x=1703470013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKnYT6PKG7isJEwfwt4q7aWVApkXd222Gzbu36ZvTuA=;
        b=ZAUjiU6I9cqB0bCJw2klEKhosh1Z8sSBVBauYTYKJOS7fgq3dXG7HV01CF3ba9z9BK
         lPm5Qm5FhAgiODR15D4Uz2D24umiKr8MZABHmhN9NSoZwjn2fNdpKUOEOFhNgW/xjbCm
         oYtHop8dDxgnsF6GiMxdczuXka73iPwUEN0XWyHa26HAEfVTuglAk5h8AK8vnr4WzOJB
         dgNFrnh5gWgmux1EhROn/UUnLibebpPeMmWXiRgh3EkZH464aa6Skx/xaVEi6THhVKEY
         5kbNydC2eH+8vGMVY2k/dtaEWoafycx+A7YnofSeZACIosaMJfMwMkFXBA59yICydob0
         6Veg==
X-Gm-Message-State: AOJu0YzdtjDVzneEQVZekRVXXw+kWs2e5LM5RnFZeYD8dAOa/7PbJ85T
	xzkcIYJ3JdqFbvuMk8fwF0aa3N/TXwmsIl01Sa0=
X-Google-Smtp-Source: AGHT+IF9kw4TyVazYzXPgD+pbfcW/qHmmmr4LJQSulMg27SxvluP2HiadT3wlYkHOmqceAqJwzXrhyTItSFUO5WMWaA=
X-Received: by 2002:a4a:b048:0:b0:591:54bc:438d with SMTP id
 g8-20020a4ab048000000b0059154bc438dmr4693538oon.8.1702865213089; Sun, 17 Dec
 2023 18:06:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
 <20231217110952.78784-2-qiujingbao.dlmu@gmail.com> <20231217-wrist-flakily-db9974d8b515@spud>
 <CAJRtX8TQ02swRqzNfPHPrcS-MU=pBN_atjV2PFsAyJeNBF8kgA@mail.gmail.com> <20231217-swept-uncorrupt-92ac058dba4b@spud>
In-Reply-To: <20231217-swept-uncorrupt-92ac058dba4b@spud>
From: jingbao qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 18 Dec 2023 10:06:42 +0800
Message-ID: <CAJRtX8Q_811P+2r7bim-YLWYcCX4_ao72XH7ASBXKG1=_ta-DQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC
To: Conor Dooley <conor@kernel.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 4:47=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sun, Dec 17, 2023 at 09:16:39PM +0800, jingbao qiu wrote:
> > On Sun, Dec 17, 2023 at 8:26=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > >
> > > On Sun, Dec 17, 2023 at 07:09:50PM +0800, Jingbao Qiu wrote:
> > >
> > > > +  reg:
> > > > +    items:
> > > > +      - description: data register
> > > > +      - description: control register
> > >
> > > > +    rtc@5025000{
> > > > +      compatible =3D "sophgo,cv1800-rtc";
> > > > +      reg =3D <0x5025000 0x1000>, <0x5026000 0x1000>;
> > >
> > > Why are these two regions rather than just one, given they are locate=
d
> > > next to one another?
> > > Are they separate on one of the other devices in this family?
> > >
> > > Thanks,
> > > Conor.
> > >
> >
> > I think there are two reasons, the first one is to distinguish
> > different logical ,
> > REG_ CTRL (base on 0x5025000) controls clock calibration, sleep,and oth=
er
> > functions, RTC_ CORE (base on 0x5026000) has basic RTC functionality,
> > The second is the maximum address used by RTC_CTRL (base on 0x5025000)
> > is 0x0ac,which is much smaller than 0x1000. Therefore, the datasheet di=
vides
> > it into two parts for introduction, and I also divide it into two
> > parts based on this
> > introduction.So do you suggest that I merge them together=EF=BC=9F
>
> If all of the cv1800 series devices have them sequentially, I would just
> make them one region.

Thanks, I will fix it.

Best regards,
Jingbao Qiu

