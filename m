Return-Path: <linux-kernel+bounces-1821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2D7815480
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1D61C24096
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BF645BF1;
	Fri, 15 Dec 2023 23:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+R2FKmz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2483C5638C;
	Fri, 15 Dec 2023 23:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6283C433C8;
	Fri, 15 Dec 2023 23:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702682926;
	bh=veadB982YLbyHCViqI+QSCopSnDgm5/6Vr03+g8/JLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i+R2FKmz8nGHNHey5zgwGf4eYEKRSHYvmDm24PP2lwyYVG9JzEIZ3NqvXKSLxz2rp
	 EuPYBKxSFQ9tFML0veWQP//SHl6FoVHzrzAL2XiwjyKHcFpqJ1aB3gkHo7uyJ/Mity
	 0KktetWrnccMbuvyI2NP8QT3q/p1g891AhQ3dB0FX9aoGXzs1ycEX8zqWdy6jtf4p3
	 t9Zv502ma6WHnDYR0DJXBB2vjI1mkcYZhsjuujODc51r5TBgngvXWhiKRwEvh4izmk
	 OYrWi/euP3Rmd+KlCrHbSDh/ysCd/6L7S9l/ux5hFwtB6wXmA1YQDialgEhKmCQM7O
	 2+Y/4mAbd7Q8Q==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cc55698c81so7615551fa.0;
        Fri, 15 Dec 2023 15:28:46 -0800 (PST)
X-Gm-Message-State: AOJu0YyA0mO9vUlM8oLMk2cnplRLVwtCEGLcd0+kFUIPHrM/ISvtiprw
	l3pJEWM+Bj9BW9VHS/VTDVPDkklAzfSgQeAxiGs=
X-Google-Smtp-Source: AGHT+IG0QW5VoJQKWqSlVXO5LuKRfOYueRM4izJQsXJdv6jqa6irdg/gE/fh/9iHPvKEKItXrSTJyg6C8mAVMYCFwnc=
X-Received: by 2002:a05:651c:1145:b0:2cc:1f9a:e1fa with SMTP id
 h5-20020a05651c114500b002cc1f9ae1famr7896670ljo.19.1702682924864; Fri, 15 Dec
 2023 15:28:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215023852.3478228-1-linan666@huaweicloud.com>
In-Reply-To: <20231215023852.3478228-1-linan666@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Fri, 15 Dec 2023 15:28:33 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4dziX5VPzWu5RX6OPfXdXu9M8Ktk+H_d0+CvnhiqQ0Cg@mail.gmail.com>
Message-ID: <CAPhsuW4dziX5VPzWu5RX6OPfXdXu9M8Ktk+H_d0+CvnhiqQ0Cg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] support read error check in raid1
To: linan666@huaweicloud.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org, 
	yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com, 
	yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 6:40=E2=80=AFPM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> Changes in v2:
>  - Add RAID_1_10_NAME to distinguish name between raid1 and raid10.
>
> Li Nan (2):
>   md: factor out a helper exceed_read_errors() to check read_errors
>   md/raid1: support read error check

Applied to md-next. Thanks,

Song

