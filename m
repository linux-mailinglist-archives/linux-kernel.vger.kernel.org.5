Return-Path: <linux-kernel+bounces-159823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7898B34A5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3490C1F21A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58651140381;
	Fri, 26 Apr 2024 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/nIp3n+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8077EF;
	Fri, 26 Apr 2024 09:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125328; cv=none; b=N8HF3LocUMrRPj1zHb3d/Zs0vNNSDqB5TVfxqdgEP7WhO6RPmgbCVt0rRg9fzubFQqVQ3vDo/3PQN6KKTHQ/8pewVuiYELtwEg4o+daFpOFPcmArEiPNkBLut3Jgr/9wD7JMGuwtTAQ1URmwuUlz2kWqmzI22czhitrgBVIgOEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125328; c=relaxed/simple;
	bh=nEsffx9NnWCYvdWoWlZutoq9f9SadTTzQv71Jmd4xhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=doQIrtVSmkulnT3lhyxmDg7+l25/n51qybLksTCzgKDQ18o93TgHcxqmJX5JrVCKROmWDAJKtEHh0OO5dhnow8/F83+/cZ16F0RnNGALy2p90LKVVkNv5EKRDje7JHHTgYxYOfJ0UEVvjLRvUiUn4LGv36lYxPYJYJBrWD8P2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/nIp3n+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE54C2BD11;
	Fri, 26 Apr 2024 09:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714125328;
	bh=nEsffx9NnWCYvdWoWlZutoq9f9SadTTzQv71Jmd4xhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=I/nIp3n+lg4yMg3H2dLiuNHWIRyI/0KUHlR6ruX7wfAMoyf/TNiUc0L8tq5gqXZuS
	 7xwI/r9KIYexr89Y9l7qUjG0mAgELadNuMxfGKOXLXDj6BNndQqyFxOGK8j2nVkhWa
	 uObOtqwWMhPmrlg+7CtnBvKgmUht0A6PdvzbXDPkgD9dfT+ZjcWeaCgJNNcJgBbMGc
	 eLxXNVQMW01dCEc1Vjv/PlmEqi8c024CqKu6s/q3N25iOmq7oLoFp8XAEPYB1Z/C5B
	 DonygS13XBrdCRHVX+JnBKT1KbkIO+8QlmtLug6AwzusH/k0tUZzq2NqJJGjab7j0y
	 rvEEMHkGdrOGA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5af12f48b72so412270eaf.3;
        Fri, 26 Apr 2024 02:55:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXy7MJQfuo+M+JqDIbuZzdgSfa1RTNLlZ6uN4Eo4bzYkuNj7VNK+XxkLYyq3sBj42FXB92rohJEf+D2KG67yoAEII0PlAWd4RXxECliJA0OW8WS4e5HynyWmil6KEcNsyBt7hgtNd8=
X-Gm-Message-State: AOJu0YxyakA7ikZeqeEniHDALgTCRY0KZG4iuPUwc8YGqKnbyZmWmQJA
	fahXJgH/3DyRvxmo2m2Idyw/gvHXI5MmWiqdjGVogkZyzi+evb4n7Ud7XvCPc8fmH0paAR4iEgU
	943Ut1j0wHQI0Gm9D5jVCfDJievE=
X-Google-Smtp-Source: AGHT+IEWhxSPHhTzX2mbfY3Ou49Jgm+donLdT6R5LfI2YS+Jd033qSDJOxZHAvcQu3MebYa2RHrdX1kjH1xO4qPFFX8=
X-Received: by 2002:a4a:a882:0:b0:5aa:241a:7f4b with SMTP id
 q2-20020a4aa882000000b005aa241a7f4bmr2722851oom.1.1714125327279; Fri, 26 Apr
 2024 02:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3297002.44csPzL39Z@kreacher> <8f94bbb8-3cdd-428d-89b9-1ae04c806c73@arm.com>
In-Reply-To: <8f94bbb8-3cdd-428d-89b9-1ae04c806c73@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 26 Apr 2024 11:55:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jpB_2xEbKK_S9AMHELqsjGhLQ60_0gycm8rcphi3ELbQ@mail.gmail.com>
Message-ID: <CAJZ5v0jpB_2xEbKK_S9AMHELqsjGhLQ60_0gycm8rcphi3ELbQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] thermal/debugfs: Fix handling of cdev states and
 mitigation episodes in progress
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>, 
	Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 10:55=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> =
wrote:
>
> Hi Rafael,
>
> On 4/25/24 15:01, Rafael J. Wysocki wrote:
> > Hi Everyone,
> >
> > This is an update of
> >
> > https://lore.kernel.org/linux-pm/5774279.DvuYhMxLoT@kreacher/
> >
> > and the only non-trivial difference between it and the v1 is a small
> > rebase of the second patch (the v1 of which didn't apply).
> >
> > It generally has been based on top of
> >
> > https://lore.kernel.org/linux-pm/12427744.O9o76ZdvQC@kreacher/
> >
> > but it should apply on top of the linux-next branch in linux-pm.git as =
well.
> >
> > It is present in the thermal-core-next branch in that tree, along with =
the
> > above series.
> >
> > Thanks!
> >
> >
> >
>
> I have also tested the patches, so feel free to add the tag as well:
>
> Tested-by: Lukasz Luba <lukasz.luba@arm.com>

Thank you!

