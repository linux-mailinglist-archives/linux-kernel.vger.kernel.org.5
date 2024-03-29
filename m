Return-Path: <linux-kernel+bounces-125130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB566892126
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 578C1B2ECEC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A88E4E1BE;
	Fri, 29 Mar 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IShpZdoJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5CF4C63F;
	Fri, 29 Mar 2024 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725949; cv=none; b=m2JbW6gGmxK3p87YkkdLDhtrSVbKo36RyLyXciOQK3AKFwSQRXgE6btIBfw9fnF30+LQxY5SuOsJStfQhUuvpGJH2V0I1pdrphAr9f82zEDXTTfsdqzKdzY1vVZsVUuTaERtuUR3dUOPFCLTWpTlN4XYyibmsaqMgphc9rkpIew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725949; c=relaxed/simple;
	bh=Osf1Z2q3n8yY4dhROiRx8gO9B7djKPb1ZMYZa1eyIWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bm33Q4SUwDc5tASEVehREwuxRoKTkXwAumYUw1SY0bEZ9muWIJQhM+PpPLx9MNCltMOc8hq4LUyL4gOWsd7EjI7evpqKlV5yEPi08CjhrVobq0FIOKICHX5L3Cg70CVvJIfhF0teIrnLzATxOG0Nd0xcDyYw6Ra/XZhX4Xs9Foc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IShpZdoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37CFC433C7;
	Fri, 29 Mar 2024 15:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711725949;
	bh=Osf1Z2q3n8yY4dhROiRx8gO9B7djKPb1ZMYZa1eyIWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IShpZdoJ8MbvXVXROFDDBAFKTqasTyW7bdupmBM+DziqzyMhLLN6y2ol20Ad2KG8v
	 M0ss/Rm77UTSFimcoG8WZBHSlqp1eahc/PUFbHLQh0RY9df+vjCHdfIzHuq92xfw42
	 fiBoUSvpFJ/04vbGEUsv++BJWyex79DorMvuJOYL0/qjV+dgN97TxN1sF0lO8cydLs
	 NPCNOcc59rtrXTr/uFUk382lt56MMTLmgc7Jl8D9VeoZaWelHa5zihl4PzxAlbMWQ1
	 NH6+oIn3jMMSYAAdz8C3ZP9FQlPZd6EVxsF1vnqrX7fuzfsWZJK/3H8H83gkTBrs5Q
	 P7Rniy03qgV1Q==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d476d7972aso30353991fa.1;
        Fri, 29 Mar 2024 08:25:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXLw3+RJmjCF7Z/+88fshC+5YW6iPrB2Iddj6P0ZGIwt4dxM0JmvchAjuzEha2p9mOHtVsaq84wOaOuvvFVBzNeqEjjMWusC8gi70hH2dqcY2xCBZ+Wyb4/wSNn887gGojyrqP4
X-Gm-Message-State: AOJu0YzxGBe0eZMfLVI6QjZNMs3XwHoE5994a7JZcPked7kJrLAqCyV7
	YOIilHBI6LK3gn38d9C1b0hJxvgT9Ms7BOXPW4N+z3eUu1+8PSlo6csnZ5pDtCYN9sYLFJtVBiz
	R90bq9tpwHJX+eviocaRKP04YRqo=
X-Google-Smtp-Source: AGHT+IHGFQreuRdKf10WxAH8Qs+v5kOr5+Flsdu3WUfPItjOx0uNzWjfZ7HwxQf10gDfw4XYZGENtUoFrnHla+hOqlw=
X-Received: by 2002:a2e:aa14:0:b0:2d4:68ef:c711 with SMTP id
 bf20-20020a2eaa14000000b002d468efc711mr1689753ljb.25.1711725947373; Fri, 29
 Mar 2024 08:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120810.2825990-1-sashal@kernel.org> <CAMj1kXGNneD2E=iGM18DMrAqKySi6JdDF-f-Sd+Vs036-_RL2g@mail.gmail.com>
 <2024032916-statue-skyrocket-af59@gregkh>
In-Reply-To: <2024032916-statue-skyrocket-af59@gregkh>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 29 Mar 2024 17:25:35 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEtH5NdRL2Ya3+h0wJqsLwQudNmfxepsw5x4hcS2K1T-Q@mail.gmail.com>
Message-ID: <CAMj1kXEtH5NdRL2Ya3+h0wJqsLwQudNmfxepsw5x4hcS2K1T-Q@mail.gmail.com>
Subject: Re: FAILED: Patch "x86/sev: Fix position dependent variable
 references in startup code" failed to apply to 6.8-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, 
	Kevin Loughlin <kevinloughlin@google.com>, Borislav Petkov <bp@alien8.de>, stable@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Mar 2024 at 13:56, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 27, 2024 at 04:39:20PM +0200, Ard Biesheuvel wrote:
> > On Wed, 27 Mar 2024 at 14:08, Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > The patch below does not apply to the 6.8-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > >
> >
> > I will send the v6.8 backport separately right away.
> >
> > v6.7 and v6.6 can take this patch unmodified but will need to take
> > 29956748339aa8757a7e2f927a8679dd08f24bb6 as a prerequisite first.
>
> Now done, thanks.
>
> > (v6.8 no longer applies because of the way Linus fixed up a merge
> > conflict in the 6.8 cycle)
>
> I fixed this up by hand, hopefully got it right :)
>

Thanks - I will double check once the patches are sent out.

> > v6.1 and older need separate backports so i will send those out later.
>
> Wonderful, thanks!
>

I sent this out on Wednesday but I don't see them in lore. Please let
me know if I should resend these.

[PATCH -stable-6.1 1/4] x86/coco: Export cc_vendor
[PATCH -stable-6.1 2/4] x86/coco: Get rid of accessor functions
[PATCH -stable-6.1 3/4] x86/Kconfig: Remove
CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT
[PATCH -stable-6.1 4/4] x86/sev: Fix position dependent variable
references in startup code

