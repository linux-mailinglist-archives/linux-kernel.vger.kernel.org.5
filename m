Return-Path: <linux-kernel+bounces-31699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB988332A1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 04:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44231B229CA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99726111C;
	Sat, 20 Jan 2024 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j42r09te"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1610E1;
	Sat, 20 Jan 2024 03:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705722294; cv=none; b=RuGL3s8nd3KGyDsfsOxSiQX8/WlcMjIOqR+4ztAboX9bbNoA0MVIS4GpaCZNWwi4BlvqdyKSMMmmGEHth987BdgG88V7USrtMEyav9DSfZmtl7XOXI1Sz2trHZZnYUfdlinfaxhGMV6ZefcKDc91cPpC5NGipQFQ6oSV6DpQxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705722294; c=relaxed/simple;
	bh=cg3WFqnhoer8UCwcfjhLyZcS/wj1ImRLeXBoXfVxv1M=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cF1N13On9p7hoqdGLq+yL7QEbhHyf9W21ZDTA1+LSjlRvaqnRhu/j808nPsF3zpNqRHgWbwluQlwXw1QNjXrpFQscS0zW8tFPkhiqV6x90S3NKG+tU+D/rGtqhmRt1mHLb2NGnQ6fizS3LCas63MVpaRorUMdDyJ8ARUUpEzO1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j42r09te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319F7C433A6;
	Sat, 20 Jan 2024 03:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705722294;
	bh=cg3WFqnhoer8UCwcfjhLyZcS/wj1ImRLeXBoXfVxv1M=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=j42r09teOyWLQJTiAYQP3hIzKFHOfkJ1ogA3c1aypTGfnhECX3V2m3CCnPqvxhA8z
	 hO7CEieHsg81enOvR3bv5L6JUYMKIY+DiZheNExdH7oK4B4iHmxwfB3z8QoLMVGekA
	 KuOnx9SSvUnqqXugAdAlhoFXJRsw0YLZX3dKVzbhtHoT4yr95F1CYkIU5dw05CIu/0
	 cm8OPowJTWWD1yhIAXagekc2L+dcO8dBHGSdqF74pxWQjJdpqXXFIvSQ7k0YU1Fhb3
	 cYINGEkZV+g8vASaVGS8L9nKTYhAYJMb6ttqR3TAw7iXWA1/VDmgu9Glc7PeM7bZoG
	 +zb50VBQD9KPg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-20757468411so923673fac.3;
        Fri, 19 Jan 2024 19:44:54 -0800 (PST)
X-Gm-Message-State: AOJu0Yz7ZwXtBJFOh+eiJ1rsk3CnXYc7beFQhRyx1eCUWiOFvxEjOcFn
	PIlrkKX3OsbGJWvVvIzDenyG/3tjElbxFm1NAG2ZElJw4XM02XO4Mx3MfhAcX5T7Ivy+IBk8/Gb
	u3dPgnxuNT13TDBhrKzVYdos+6ZI=
X-Google-Smtp-Source: AGHT+IF1V/Lsn+7+Bd/BYCgnAJWfklNe5/m5epJzrOa2BIrYb5wy+uQTcGEfx9upJkfz7QIm+49miPLiWTHjoVvdPKY=
X-Received: by 2002:a05:6870:8293:b0:210:ee15:925 with SMTP id
 q19-20020a056870829300b00210ee150925mr787350oae.107.1705722293463; Fri, 19
 Jan 2024 19:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:6c8d:0:b0:513:8ad5:8346 with HTTP; Fri, 19 Jan 2024
 19:44:52 -0800 (PST)
In-Reply-To: <20240119095707.120338-1-yang.lee@linux.alibaba.com>
References: <20240119095707.120338-1-yang.lee@linux.alibaba.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 20 Jan 2024 12:44:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_aFRptGGWbvXujYJ7fQuycY6-DrbsX_o0oU75zDHsbAw@mail.gmail.com>
Message-ID: <CAKYAXd_aFRptGGWbvXujYJ7fQuycY6-DrbsX_o0oU75zDHsbAw@mail.gmail.com>
Subject: Re: [PATCH -next] smb: Fix some kernel-doc comments
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2024-01-19 18:57 GMT+09:00, Yang Li <yang.lee@linux.alibaba.com>:
> Fix some kernel-doc comments to silence the warnings:
> fs/smb/server/transport_tcp.c:374: warning: Function parameter or struct
> member 'max_retries' not described in 'ksmbd_tcp_read'
> fs/smb/server/transport_tcp.c:423: warning: Function parameter or struct
> member 'iface' not described in 'create_socket'
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Applied it to #ksmbd-for-next-next. Thanks for your patch.

