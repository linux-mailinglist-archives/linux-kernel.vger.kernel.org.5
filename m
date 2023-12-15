Return-Path: <linux-kernel+bounces-1221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E600814BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27DA81F24F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0961D39FCB;
	Fri, 15 Dec 2023 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyLP0V55"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445DA374E6;
	Fri, 15 Dec 2023 15:38:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31BAC433C8;
	Fri, 15 Dec 2023 15:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702654687;
	bh=x62x6NYP9yRE2oI6l70jSejMRfQlxBsF7W56q+aZzXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YyLP0V550r0J42MzYaM+fh9x16QkiLirDBV+ev3nM/dMxEM/tIWeNgdP7VGaHY4re
	 vmZCe/MyyH0dKzHE0E7OZY2g4o4Ji1S5AicP+zGMUyX+5wI+3yF18jCzic9tCLWqg8
	 iMVfC3C6zh8ezJCk4aqyYWMIXax6ZQdGyciyHmPUBQXQUV/REjmzZto0pMHp7RCMOB
	 y4Y3w07lmwo3Dn26huf0KFTtaTgddlbFxXJ2seImYkE49cpAmzMSp7SImkFGfWc9T+
	 ewGuAdursxUAtZxw5NmaEKo/sXifX7I8+XQYXcjieCTn2yEtp+5fWhRxrsQWwDc804
	 XfD9S6wmSDA5Q==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50bf8843a6fso736859e87.0;
        Fri, 15 Dec 2023 07:38:07 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7MU5SKSvGjpy43nmB1sHRBukz+7Gb9NeaYlZHxv63snGBMEbK
	B04aT2bxgRlJ55x8WhNKLynz2xBJKIF2S0XNS9k=
X-Google-Smtp-Source: AGHT+IF2o19iSjuma7z1rViUr4sWABiy6wlRLdIwp5Tpkbtge9DERt9+zTTFZPwV1qlJD1XBSN92MPB6o6otz7AUm6Y=
X-Received: by 2002:a19:8c47:0:b0:50b:ca4c:fedd with SMTP id
 i7-20020a198c47000000b0050bca4cfeddmr5404455lfj.31.1702654685913; Fri, 15 Dec
 2023 07:38:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214222107.2016042-1-song@kernel.org> <20231215125059.00006270@linux.intel.com>
In-Reply-To: <20231215125059.00006270@linux.intel.com>
From: Song Liu <song@kernel.org>
Date: Fri, 15 Dec 2023 07:37:54 -0800
X-Gmail-Original-Message-ID: <CAPhsuW6GZnufqFseLvgpMrrX6qRXodX1n89vEbbC-FqTjsWPDg@mail.gmail.com>
Message-ID: <CAPhsuW6GZnufqFseLvgpMrrX6qRXodX1n89vEbbC-FqTjsWPDg@mail.gmail.com>
Subject: Re: [PATCH 0/3] md: Remove deprecated flavors
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mariusz,

On Fri, Dec 15, 2023 at 3:51=E2=80=AFAM Mariusz Tkaczyk
<mariusz.tkaczyk@linux.intel.com> wrote:
>
> On Thu, 14 Dec 2023 14:21:04 -0800
> Song Liu <song@kernel.org> wrote:
>
> > Linear, multipath, and faulty have been marked as deprecated for 2.5 ye=
ars.
> > Let's remove them.
> >
> > Thanks,
> > Song
>
> Hi Song,
> Great idea!
>
> Please note that there are mdadm tests for those levels. I can approve it=
 only
> when mdadm clean-up is merged. Our tests must pass continuously.

Is the continuous test result available publicly?

>
> It is a nice code complexity improvement so let me know if you would
> like to get my help with mdadm patches.

On my local tests with mdadm, I need to make changes to the following
tests:

00linear...
00names...
00raid0...
00readonly...
02lineargrow...
03r0assem...
04r0update...
04update-metadata...

The changes are all straightforward (just remove things related to
linear/multipath/faulty).

Thanks,
Song

