Return-Path: <linux-kernel+bounces-75150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4461A85E3D6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6790F1C224AA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B91839E6;
	Wed, 21 Feb 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsljfjTJ"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B33A1B1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534672; cv=none; b=ss5HY/GCfCfNmfsWc1ebwnfXoWjueF52C4923gv4GrK5BkCz/j9z4jaj2yoiR9znwDhOJzSEF9u4wJmPh8vsGT/R1cZAPpCkr79d5Jw6E5JoxZ5KsgjCvVFC2lZ5asrTBPodIsMRnxnLh3Tzqr1MgaSemjKG1dXYTTwJgwj5nqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534672; c=relaxed/simple;
	bh=JQ6FVpaAPtcvjI//WyhL8aGmD1PfvX1dpap9Ryke5Ww=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g2uEMnrTSr7O89KFXmUv5B1WQjosHTrPthTdE/n/656FJ/ITHjiJPpTkxTmvR4TYQpTVooTsqlVx0nTMmHWiiVPtor0L/8Nor2CPbLEbWR0TCGMYcHvisWZJ6u3/lAVzNy3GoYZaacWTJTdz8NAXB9zKYlNAorMUI2pGZeItV6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UsljfjTJ; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c134813841so2323519b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708534670; x=1709139470; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJWYEU/M/WsHNzSMkh9EKav36BnK47emNVVN/Db4odE=;
        b=UsljfjTJqxaMHLN9TaYjQTXOkm4Lq/yQQWH/ReYYZt1aQl+jYzzOTZ+I1yCvJNKnFC
         bJW5QzM6nK2RM58z+oJrDbYdz0CEUklXlt9WpUR0iSkpIWJyngx9xZ4JxoBa3FN4i+Qe
         2k+xpo/xj6uMk4axI14PrTfwkRPT+u7N69OhLgQb8CRPzrfjaUAX1PtB4axuvvrdg8F8
         bxmNdPqWND3Q+ROicUSxGNXjjACyu80FQf2ApwTxLqbx7pTE+axrrekMCm4TNW3WpRzk
         4wqrhOTbysRXyFDwqJttiQ4DdnIQKE+7GKPkv5iTrQbNBn0D2mNqPWZWsH1VTmOw5sfa
         wVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708534670; x=1709139470;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJWYEU/M/WsHNzSMkh9EKav36BnK47emNVVN/Db4odE=;
        b=KVHPPd8qJssM0RaJkJwq5u5fO6TN5zagNnZffKm0vIc/PR6gEOMLACaw7RjDLvheNf
         NdOAfIV1WuYdQJ+KpzkE49aAFps4+XH/NsLMatYduC9pjqsjk5fJNHVIMNioRrhcCfI+
         lyizN7eFILegkIYC5q+O0dMnumTrylFFHmmgrkuTjUsr4EJD8PUT2XPgkhH59PnBzLuP
         rx11Q3XKl6lqSRfpu1WM+/WgGTenN3isbuRnRY1UVtySgZ5MUkgqlFPkmEtaskYj+rin
         SH4yE0NisI6SQSio+c+cMBoM4TFNi/T2bwdkzAYTMnmBcHMtTPUIold7CEZoZY4T/Uel
         fKAw==
X-Forwarded-Encrypted: i=1; AJvYcCWWvsDuLX1nS0+pbAhmMaFSnh20Y5gi1AvHX0XQOtG6S4m8Mc3yEiBNPEQ5avCXpVtG/IVeT42CcSQgsBsWcKdu+QBNV4SMrV+v3HI4
X-Gm-Message-State: AOJu0YwJbvF6DBu+ZBfHNsuGbBQZayb3Eweftz37aSNsPPbOBK03lkmj
	r57fML8RoHzJfs9Ptm+RhtVz3NsQ9sbCY6hhdwz1VD2G0txx7BUj
X-Google-Smtp-Source: AGHT+IHUcyjcP2AuJIMMMPPLJA0QZmjqHygE1wZIcVBYLdz8J3dluza4MbNXQvR57Vui1zS7cOCffQ==
X-Received: by 2002:a05:6808:189a:b0:3c1:6caa:1131 with SMTP id bi26-20020a056808189a00b003c16caa1131mr22813oib.18.1708534670133;
        Wed, 21 Feb 2024 08:57:50 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:aa0a:4200:30a5:ebd1:48db:41c6])
        by smtp.gmail.com with ESMTPSA id nz6-20020a056871758600b0021ed5ee3c77sm1551790oac.16.2024.02.21.08.57.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 08:57:49 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Re: [PATCH] ipmi: kcs: Update OBF poll timeout to reduce latency
From: Andrew Geissler <geissonator@gmail.com>
In-Reply-To: <9680ad7d7a48fc36a0572dc2286a1229a29341fe.camel@codeconstruct.com.au>
Date: Wed, 21 Feb 2024 10:57:38 -0600
Cc: minyard@acm.org,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Joel Stanley <joel@jms.id.au>,
 openipmi-developer@lists.sourceforge.net,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-aspeed <linux-aspeed@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 openbmc@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <527F52AB-0070-43EA-BE82-945280CA2AEE@gmail.com>
References: <20240220123615.963916-1-geissonator@gmail.com>
 <a9169894-6972-49c0-a1d4-d80863f5b511@molgen.mpg.de>
 <ZdT+eThnYqb3iawF@mail.minyard.net>
 <9680ad7d7a48fc36a0572dc2286a1229a29341fe.camel@codeconstruct.com.au>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
X-Mailer: Apple Mail (2.3774.300.61.1.2)



> On Feb 20, 2024, at 4:36=E2=80=AFPM, Andrew Jeffery =
<andrew@codeconstruct.com.au> wrote:
>=20
> On Tue, 2024-02-20 at 13:33 -0600, Corey Minyard wrote:
>> On Tue, Feb 20, 2024 at 04:51:21PM +0100, Paul Menzel wrote:
>>> Dear Andrew,
>>=20
>> It's because increasing that number causes it to poll longer for the
>> event, the host takes longer than 100us to generate the event, and if
>> the event is missed the time when it is checked again is very long.
>>=20
>> Polling for 100us is already pretty extreme. 200us is really too =
long.
>>=20
>> The real problem is that there is no interrupt for this.  I'd also =
guess
>> there is no interrupt on the host side, because that would solve this
>> problem, too, as it would certainly get around to handling the =
interupt
>> in 100us.  I'm assuming the host driver is not the Linux driver, as =
it
>> should also handle this in a timely manner, even when polling.
>=20
> I expect the issues Andrew G is observing are with the Power10 boot
> firmware. The boot firmware only polls. The runtime firmware enables
> interrupts.

Yep, this is with the low level host boot firmware.
Also, further testing over night showed that 200us wasn=E2=80=99t enough =
for
our larger Everest P10 machines, I needed to go to 300us. As we
were struggling to allow 200us, I assume 300us is going to be a no-go.

>>=20
>=20
>>=20
>> The right way to fix this is probably to do the same thing the host =
side
>> Linux driver does.  It has a kernel thread that is kicked off to do
>> this.  Unfortunately, that's more complicated to implement, but it
>> avoids polling in this location (which causes latency issues on the =
BMC
>> side) and lets you poll longer without causing issues.
>=20
> In Andrew G's case he's talking MCTP over KCS using a vendor-defined
> transport binding (that also leverages LPC FWH cycles for bulk data
> transfers)[1]. I think it could have taken more inspiration from the
> IPMI KCS protocol: It might be worth an experiment to write the dummy
> command value to IDR from the host side after each ODR read to signal
> the host's clearing of OBF (no interrupt for the BMC) with an IBF
> (which does interrupt the BMC). And doing the obverse for the BMC. =
Some
> brief thought suggests that if the dummy value is read there's no need
> to send a dummy value in reply (as it's an indicator to read the =
status
> register). With that the need for the spin here (or on the host side)
> is reduced at the cost of some constant protocol overhead.
>=20

Thanks for the quick reviews and ideas.
I=E2=80=99ll see if I can find someone on the team to help out with =
Andrew J=E2=80=99s
thoughts and if that doesn=E2=80=99t work, look into the kernel thread =
idea.

>=20
>=20
> Andrew J



