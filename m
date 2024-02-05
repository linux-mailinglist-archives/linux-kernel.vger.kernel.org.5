Return-Path: <linux-kernel+bounces-54101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBFD84AABF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 00:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA8381C23D12
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7F64A9B0;
	Mon,  5 Feb 2024 23:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9CW0qTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72DA4A99C;
	Mon,  5 Feb 2024 23:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176495; cv=none; b=Xh6Z0Aew3AwIN6VyftjV3Gt2/UA95oHMNTLL6FmXzzVr1L+XDmMZhWsrfOdsM4dUR3h49yUiCtmlaiaF0KDgKW0jOJFHEE2JTCwXxns3cn8F0ZPdb2KCd/5hLLRJGB8X8/C7XkS5urImVXoBejlR+VR1v5PP/uqX7OjfupdTKAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176495; c=relaxed/simple;
	bh=4ZVwHQibcE6DybMWbCZR3MkT+6AAyNTke5LJVfv0u3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxK+39UYWFfaOsRoWES/NjuXT9mdCik11NDWXlpfKZgcN5i6rCqjiaI+IpQgjJ5tVgLMYQwGcnrEJ6bgPncY09VJsD8c9tfALPw0TaxU7EWTw3ziOQPSxk4VXmxSQygVIQapyQDmlUBeondF+ncaV+Rxsk38CmChz9P16yy29zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9CW0qTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9937DC433C7;
	Mon,  5 Feb 2024 23:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707176495;
	bh=4ZVwHQibcE6DybMWbCZR3MkT+6AAyNTke5LJVfv0u3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=n9CW0qTgkZOTT0oFcegBL1pW1GbowAypwkLoAYhvl9F2IjI23RU2m+fDGTffyIfP6
	 ONSfwMV6sQlpZkp++zD+iDjaI5geOG9rLFsw9KfpUDmwq8EgJlsvYD0tTCD2s1+xly
	 l2PwiOBgMEXLT+/qqBA7WKfPAfarnN5nfAAFWo8UtutnGwVhFrn4lxuIga8DQEyJ9x
	 aEnNSDkVxN7IynWiVerXzHmvcad8RTbwg5MuToICeHDqVKFVd4FQI0WRLjirsyevGn
	 dxlw3yAGLKNAB+KisxHCyL9G/e33nm9ccOFRX/BXlpIaEIheaoh4HYHxtw4p420Cnv
	 J+FC+OFbpSrRA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-510faac8c57so17689e87.1;
        Mon, 05 Feb 2024 15:41:35 -0800 (PST)
X-Gm-Message-State: AOJu0YzkpKlRbQ3W91RYcb5G9iR9kIzJW+P2+2uJJBQv07sWHtmCnPfM
	QpQEiGQ3wVBqWE8BTe6R2rlZMChwxVsp8pwInCKQKAIq55lWpQZMs9ezJ9gL6M0N1nse38qgJEx
	IH453wpTTz6eJConF6pnw3IauY7s=
X-Google-Smtp-Source: AGHT+IEQKhqJmETKodzsCUnWP+wVrWKlTs6eOEjM7N8ABj2NU7ijrEr4c+V9oNugyi8qObUSQwoXkU+J667Dgr70Fy0=
X-Received: by 2002:ac2:44d4:0:b0:511:3a8c:1c8c with SMTP id
 d20-20020ac244d4000000b005113a8c1c8cmr315842lfm.12.1707176493850; Mon, 05 Feb
 2024 15:41:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201224549.750644-1-maz@kernel.org> <b05b2e24-07db-5689-a965-97c5ced8c5d7@huaweicloud.com>
In-Reply-To: <b05b2e24-07db-5689-a965-97c5ced8c5d7@huaweicloud.com>
From: Song Liu <song@kernel.org>
Date: Mon, 5 Feb 2024 15:41:22 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7BwNtmj-QJtvj61U5YGL=X19QW49-vrJsuMFSAQxLHVA@mail.gmail.com>
Message-ID: <CAPhsuW7BwNtmj-QJtvj61U5YGL=X19QW49-vrJsuMFSAQxLHVA@mail.gmail.com>
Subject: Re: [PATCH] md/linear: Get rid of md-linear.h
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 5:08=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> =E5=9C=A8 2024/02/02 6:45, Marc Zyngier =E5=86=99=E9=81=93:
> > Given that 849d18e27be9 ("md: Remove deprecated CONFIG_MD_LINEAR")
> > killed the linear flavour of MD, it seems only logical to drop
> > the leftover include file that used to come with it.
> >
> > I also feel that it should be my own privilege to remove my 30 year
> > old attempt at writing kernel code ;-). RIP!
> >
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yu Kuai <yukuai3@huawei.com>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
>
> LGTM
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>

Applied to md-6.9. Thanks!

Song

