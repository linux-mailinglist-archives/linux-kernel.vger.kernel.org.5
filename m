Return-Path: <linux-kernel+bounces-50688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD553847C92
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC891F250B8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42A12C7E4;
	Fri,  2 Feb 2024 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jg+yGgYL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF518593F;
	Fri,  2 Feb 2024 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706914675; cv=none; b=fHRISQCi3aUXTfaXxmqa3j68fn/ZTOvGg1676d9W/ZrlKUBKasd0KceJzBCbeTE+TGjqWpGlnftrCem9dVjyGQ5CM9Kkwn66aIiUtqwdFwrdsnANDo2xKxFGxQ2vpMEZpm36NROzSBwS6a9uoeU9J3i/A3Y07cssKQ641W0MS0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706914675; c=relaxed/simple;
	bh=MxXvRNhRQV3ez+vTFS4T4y0bBEnlLlneX57Ow78rfLY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qs9TjNlCJ8Nc2SZ2rHaAp+sm+b/HRiyd1aY9hKNEsIM2ziUWvYEptiYdfjv51GVair7ulrbs/3eY3YtapQ0rRhcyI8bb34fKli6/074rb3lyf1dRUjO1TTe/7mJVzbHi4gD53nsGb7tiRhYd75+Pb6nL0bNVbvhMoL4lEGyqoGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jg+yGgYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D387C43394;
	Fri,  2 Feb 2024 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706914674;
	bh=MxXvRNhRQV3ez+vTFS4T4y0bBEnlLlneX57Ow78rfLY=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=jg+yGgYLVSG043qQDEw6lDMo7zwq1maYwt+e1Zw+RkXWkwOPpqf0qfhuk+xDEmSWz
	 XXR6tlnzb6ylKdNRdeR1B1CW2NZRh0SqB91TzrEI9A6Yew7vR0ajNbCGTqvC5DVNBv
	 wsAa0qjqWzxL+M1S+kANQ6XkLIO40FIv1aXqocPsn+DNUJKpla+0vLzQOmDRkpOLiZ
	 QCxc4zwM3w80HzgJ7p7assBr/FRbSK99lenhHNiUeWC8/3MR9yoNRv29N1UbL6NRn1
	 1Nnu6q9EXOUlYywkdRK7ngFVLjg7RDzNFgGGYxWbUaUdVmQhXwMgg3x4xwezVOtVHb
	 XI6rD7lcgp3Zw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59a94c0fb55so1332912eaf.0;
        Fri, 02 Feb 2024 14:57:54 -0800 (PST)
X-Gm-Message-State: AOJu0YxYqVFJKvucc9t02dV5y765IyVcwYEAeua+s1q2eJOQYempRvUP
	BlbwhwMOPiQKK/wqskBeBcyx7KfpsL7U3ZhtTNX8zhDO3TZlVzOM+DRBZ0j96oDl20Z7fq614yM
	rVVjc+tErjyV+FngNtEo9KuxzOLE=
X-Google-Smtp-Source: AGHT+IGKDU432zvrh2YD9SDCT8yNyv2tot4NOdlmKs/VFBxd84o8jhy0jFTzOu5IjKEGG1t+9Gi8Fvp9Vl6yPZAa/sY=
X-Received: by 2002:a4a:d750:0:b0:59a:9ff:9ed0 with SMTP id
 h16-20020a4ad750000000b0059a09ff9ed0mr6777199oot.0.1706914673738; Fri, 02 Feb
 2024 14:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5e89:0:b0:514:c0b3:431 with HTTP; Fri, 2 Feb 2024
 14:57:52 -0800 (PST)
In-Reply-To: <20240202081317.128980-1-yang.lee@linux.alibaba.com>
References: <20240202081317.128980-1-yang.lee@linux.alibaba.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 3 Feb 2024 07:57:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8NktM=Q7Px9ZjsTKnAC043XOTKL+QCL2WuEVrs_giPqw@mail.gmail.com>
Message-ID: <CAKYAXd8NktM=Q7Px9ZjsTKnAC043XOTKL+QCL2WuEVrs_giPqw@mail.gmail.com>
Subject: Re: [PATCH -next] ksmbd: Add kernel-doc for ksmbd_extract_sharename() function
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

2024-02-02 17:13 GMT+09:00, Yang Li <yang.lee@linux.alibaba.com>:
> The ksmbd_extract_sharename() function lacked a complete kernel-doc
> comment. This patch adds parameter descriptions and detailed function
> behavior to improve code readability and maintainability.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Applied it with Randy's acked-by tag to #ksmbd-for-next-next.
Thanks for your patch.

