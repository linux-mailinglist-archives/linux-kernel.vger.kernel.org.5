Return-Path: <linux-kernel+bounces-121451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B711288EAB2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F018B25207
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46913A405;
	Wed, 27 Mar 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQwu7Tz5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D05084D14;
	Wed, 27 Mar 2024 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550374; cv=none; b=WHfg+j8nJ2SsntT3EsubH7UKAjWVktR1n8A6F+32mYcmHYV3JdDn4JllLQxvEuqodXj8j9KJnZcF7d+iWM73azhNw46Xk1eSI8z+qP0tRxd+rbY/NPRjLCaX3VDwNGoj/GeR5DlfQbfRz2bWTG30I+IOR8xP1qGcY8LyfCTbjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550374; c=relaxed/simple;
	bh=D/OtNyLm0lT1yqwqIkJwDL94aKmtds0sRv1Pu6LmrZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NUnUksVGiT3QDgcpm3WXS409OjpybdhZpLGfoFjC+RK71KXnaM8GN7U3W0W8lxIshLAsdJQmdsMTW8JrWDjYnnU6k8aTgg3srmzOl+H3qp9WxA/S6fG6Jp7CMyzJzRPBei8L2hDD6EuS6Q2IK3x/4O/PfIMELJ9UO1/+TmLtspE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQwu7Tz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE797C433C7;
	Wed, 27 Mar 2024 14:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711550373;
	bh=D/OtNyLm0lT1yqwqIkJwDL94aKmtds0sRv1Pu6LmrZU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZQwu7Tz5j06x8n3nMApzeMBlPz60IH08yPIYu2M2Miz08wRjzTNsZo9OMo/N7qtr+
	 LpQt5RDnkR6hQSbvoOgUPdFdiOAjRj3Ws6oLvAo5dZKn7i1slsiL+GDeSSK9QnRICQ
	 CF0pzXYw9B44xpKcMFEA8+4CGzGfUDi2Mubws2VGr3YzDV2A5kl91ayrefB39KGKho
	 aouXMCUnnwHlR7xSBZt12G4KkWcSd9uOPaZlpL1/2nENPkyXn4GkLuEJWSGR1ZYAwk
	 daffaVCo+X8txXZafFu5/oM1Z+wnU/AGKlMUvr54UrBLsYUt4UjuUMfdFcWQcF+mdz
	 OQOO7+hn+j13g==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so33895581fa.1;
        Wed, 27 Mar 2024 07:39:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwJqRqILhyhVS/TT08xEgWU331aCOmuF62p+4mza9ZG2+34ilzcS3j8qabVg5zQ7rZsQ3ephZD5KYlN5FiNMqgGZBiyQCol72gRxeK
X-Gm-Message-State: AOJu0YwbfOyKDV9s6BSKwyeO0JlVOenJZeWknzK1Nc/0/+kJ+/cTtWZk
	P/aMP0nmXpcX336KDAHQ6eUTQiDOHgneDooIjcUxdq9QH1k6uPKWpIEcl1DAFaOKUxdgqFKrj96
	lSTdv9/TfEvnmTV/1YGmT1GwafjI=
X-Google-Smtp-Source: AGHT+IHYnRfLuyNMZXnzon5tP38t10f1dlhvjxBkDNx0+YPDhLnacqAyoT4wVzbvVnc86/Z+eT2JrwmxJ//h2tXefRU=
X-Received: by 2002:a2e:a443:0:b0:2d2:4f81:4dcd with SMTP id
 v3-20020a2ea443000000b002d24f814dcdmr142850ljn.21.1711550372251; Wed, 27 Mar
 2024 07:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327120810.2825990-1-sashal@kernel.org>
In-Reply-To: <20240327120810.2825990-1-sashal@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 27 Mar 2024 16:39:20 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGNneD2E=iGM18DMrAqKySi6JdDF-f-Sd+Vs036-_RL2g@mail.gmail.com>
Message-ID: <CAMj1kXGNneD2E=iGM18DMrAqKySi6JdDF-f-Sd+Vs036-_RL2g@mail.gmail.com>
Subject: Re: FAILED: Patch "x86/sev: Fix position dependent variable
 references in startup code" failed to apply to 6.8-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>, 
	Borislav Petkov <bp@alien8.de>, stable@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 14:08, Sasha Levin <sashal@kernel.org> wrote:
>
> The patch below does not apply to the 6.8-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
>

I will send the v6.8 backport separately right away.

v6.7 and v6.6 can take this patch unmodified but will need to take
29956748339aa8757a7e2f927a8679dd08f24bb6 as a prerequisite first.

(v6.8 no longer applies because of the way Linus fixed up a merge
conflict in the 6.8 cycle)

v6.1 and older need separate backports so i will send those out later.

