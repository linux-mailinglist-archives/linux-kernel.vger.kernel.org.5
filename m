Return-Path: <linux-kernel+bounces-34118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 814CC8373DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D711F24961
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66640BEE;
	Mon, 22 Jan 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9UdbUfW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C841DFE5;
	Mon, 22 Jan 2024 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955690; cv=none; b=LiAOQObKT3hik4wtzoiRzrpgZfrUDFed0YZeKRV3tFACdOgxChu34LQNsU9YQp/aJZSksPvNgnQqaHVHyQAPqgairWd005ZxrxYoXRY6h2MSBbgHToIi+6WN0QTgQMH/tD4X+WU/J/F0Lzv/6ClCzZvN0tREMuWS/Ftyz81SaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955690; c=relaxed/simple;
	bh=V5cmoTuULoWNYm46a6ywQDlkSQMsgm/OdPOrANJiJVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RypjqbU3R+Bthdl0/mTHXBSTiIRCL42d7dX4gVnjthOyk28P4kbDqHLTW999/C4KhbF4r94pULBdsJKF4hsP4IeZ6aF7cfZIdY/eZuVtVyWjt2xFbmfZaDWipFE4raxDV7iQkvzk0GhV/Pq8iubz8AsK7IMUvnD6olUk2idBC0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9UdbUfW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B4DC433A6;
	Mon, 22 Jan 2024 20:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705955689;
	bh=V5cmoTuULoWNYm46a6ywQDlkSQMsgm/OdPOrANJiJVo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W9UdbUfWnmEKRK9+KT2odx42x8+09Geh810AJ5mYzAeJQPSAu+5dn6g0s4O+2re4X
	 gvoQo/19dBlOZup43iTh2+xVBX5EdUuI/+gg93spmSCKMVwrhczXtCTP4vvY8pFDBB
	 YEAakBnP6OU+VylHZBWeqMsZ7ZVZGb5AKTNqfoUoynkAr8AF/Mz+LOP6Y8ZSBGYKwC
	 xxPmX+6MbIXNVjJQxyqNwP/xsSF7K8JnC0b1giihwELpDo+ATssoIxKWAaN+GuJMmW
	 tWpnk0MebpvwobkMEwgXBhDYjgxbsOjse1QgQWcH/EYb41jfOnufXWeBwyrxQ6+EBl
	 Vrs19j4LcVFSw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so3881494a12.2;
        Mon, 22 Jan 2024 12:34:49 -0800 (PST)
X-Gm-Message-State: AOJu0Yy0zDhGbIQyewuK1RsOj4KmcVY0TOEdQUUMuIvby0IB821raRxQ
	XPszGmsBUGQ1HZ3nV4okkMRquXoVQOHrh3REXN2OaXOOvhu7cPfeZFC4YV3jFhlfwqO8WdEzWHP
	zuvoSwjx8BuU1DYz6rxox4LIkcVw=
X-Google-Smtp-Source: AGHT+IG85Eoeg9WBFX8KzgBjG4JF6JfnLT+fdMlItTYbC035wmY/ToxDKMxonv/slZ9MnxD+r1bilt0/EYdum+117zk=
X-Received: by 2002:a17:906:2683:b0:a28:b71d:6801 with SMTP id
 t3-20020a170906268300b00a28b71d6801mr2651916ejc.149.1705955688198; Mon, 22
 Jan 2024 12:34:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
In-Reply-To: <20240122-topic-qdf_cleanup_net-v1-1-caf0d9c4408a@linaro.org>
From: Timur Tabi <timur@kernel.org>
Date: Mon, 22 Jan 2024 14:34:11 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXCmZi8Qx-y2D_NhJiafnGhvma2OY6F+KauqYcNAAQNCQ@mail.gmail.com>
Message-ID: <CAOZdJXXCmZi8Qx-y2D_NhJiafnGhvma2OY6F+KauqYcNAAQNCQ@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: qualcomm: Remove QDF24xx support
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Timur Tabi <timur@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 6:02=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
org> wrote:
>
> This SoC family was destined for server use, featuring Qualcomm's very
> interesting Kryo cores (before "Kryo" became a marketing term for Arm
> cores with small modifications). It did however not leave the labs of
> Qualcomm and presumably some partners, nor was it ever productized.
>
> Remove the related drivers, as they seem to be long obsolete.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Sad day indeed, but understandable.

Acked-by: Timur Tabi <timur@kernel.org>

If you're looking for other QDF stuff to remove, the QDF2400 hacks in
the SBSA UART driver really should go.

