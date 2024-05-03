Return-Path: <linux-kernel+bounces-167667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B63EC8BAD17
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E64451C21E40
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB6515381D;
	Fri,  3 May 2024 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L20zb0sy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC5E14A08F;
	Fri,  3 May 2024 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714741434; cv=none; b=G8TqxaPeZStqfbtVqCCbCukIFClWgGpIiOJjlGR7g6rfpzhwCgYiFNFjWMy18M0TcTEAY+RwQMUK/2qC4Igf4cIydoZZiF9y4lZez71xFBgEorKc9/XkJxZo5aNHodADLjPhlMxoChLF9+QePsf5ImQhmq23u1ODqRmmqLMhFPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714741434; c=relaxed/simple;
	bh=QIJdpoviZQBKczshFO6NH+Q6b1BR6BVP5K2x2cfw8M0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fYkJijhl6mVmniID2RQYlQbi0Y8gnjcX0h+xytQMsFcf1zjNlGULbjR6+ZbLkSSC63CYcCo4o893ZF0w5rAJdwyydb9bpbFWrL6slYwClOrMVrko/9xMe2bLnHxPXMuzxqNfiFoAJ4WRcqLJY9/prUmtVpC5N3Jsw/vtDcjU4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L20zb0sy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2D8C4AF19;
	Fri,  3 May 2024 13:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714741434;
	bh=QIJdpoviZQBKczshFO6NH+Q6b1BR6BVP5K2x2cfw8M0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=L20zb0syXQqT/bJxeRTAZpS2P5t8Wp5z8WWcQhrjyVHrGBgkHZYAN4eYy3U0kV9zF
	 vH2LBpfSSM3DpC48YQY6at2YXE7PEIXPPRhQ/xY1LolKZ4joS59oGC2IH6PqQ1xANu
	 7t2sVikXICxJncM5CQZM5c6dvJLJfqi6NzQ0KYJ+ku/UhVZLI+xqH0DORUj3lQ/4GG
	 as0i7kpeMAGWEwm787hKnyRiMRKyXZ3P9oZ6HIBV3PpO6IFKWz50IYJ890ManBJ/+b
	 KS0LSkSCLvOxnxKnk7P5VSaKMZmyCx0Zar+LifCWmgW+zRmiEJUxAsIJmtPu6kP4VK
	 8HfBpT2WD56Hg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51f0b6b682fso2463437e87.1;
        Fri, 03 May 2024 06:03:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmHGCH7MW5oAhJHjxUsmjDWMIukJg6dyzGBspNBPcYXFTPRiLmFO9n8IdjpBnGnY1ieomUiVwMWaniAwqiNLEsA5RpFB2ynom8y+YXC/SG8Fuqtj/obkzyPQob4Db5aL8J224kXjixMA==
X-Gm-Message-State: AOJu0Yxulkk59e/VKfyWZfZJI3xZH1PvOzfkH89Dhea+c5B/AK0GPW3A
	N+JRTxpeMB5OBH7wXwwaGejsP6upQkR+QoXJ9ez7JouM8C8LGB9zH/IyBx5VM+Ty7QiUNQgbMIA
	5ZMAW4m2wOtMNKrrbWFvy3hXPbw==
X-Google-Smtp-Source: AGHT+IFAzybPw0nmiKUwPZXHcrHdxnzH3kv2HpsAVov/yrGuF8JskKjbpZBl14p1kUi7qAc+tPXB1gphmuvmX0YPU1M=
X-Received: by 2002:a05:6512:3b08:b0:51a:e305:eb20 with SMTP id
 f8-20020a0565123b0800b0051ae305eb20mr3012638lfv.17.1714741432515; Fri, 03 May
 2024 06:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502192403.3307277-1-quic_obabatun@quicinc.com>
In-Reply-To: <20240502192403.3307277-1-quic_obabatun@quicinc.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 3 May 2024 08:03:39 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLOL-dvzggx0OXXhfgVeztK4MgeFqgXV_Jg4mhXAed=2w@mail.gmail.com>
Message-ID: <CAL_JsqLOL-dvzggx0OXXhfgVeztK4MgeFqgXV_Jg4mhXAed=2w@mail.gmail.com>
Subject: Re: [PATCH v2] of: reserved_mem: Remove the use of phandle from the
 reserved_mem APIs
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc: saravanak@google.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 2:24=E2=80=AFPM Oreoluwa Babatunde
<quic_obabatun@quicinc.com> wrote:
>
> The __find_rmem() function is the only place that references the phandle
> field of the reserved_mem struct. __find_rmem() is used to match a
> device_node object to its corresponding entry in the reserved_mem array
> using its phandle value. But, there is already a function called
> of_reserved_mem_lookup() which carries out the same action using the
> name of the node.
>
> Using the of_reserved_mem_lookup() function is more reliable because
> every node is guaranteed to have a name, but not all nodes will have a
> phandle.
>
> Nodes are only assigned a phandle if they are explicitly defined in the
> DT using "phandle =3D <phandle_number>", or if they are referenced by
> another node in the DT. Hence, If the phandle field is empty, then
> __find_rmem() will return a false negative.
>
> Hence, delete the __find_rmem() function and switch to using the
> of_reserved_mem_lookup() function to find the corresponding entry of a
> device_node in the reserved_mem array. Since the phandle field of the
> reserved_mem struct is now unused, delete that as well.
>
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> ---
> v2:
> - Addressed error found by kernel test bot:
>   https://lore.kernel.org/all/202405020127.3ncxx3EI-lkp@intel.com/
> - Fixed spelling error in commit text.
>
> v1:
> https://lore.kernel.org/all/20240422235243.2878536-1-quic_obabatun@quicin=
c.com/
>
>  drivers/of/of_reserved_mem.c    | 22 +---------------------
>  include/linux/of_reserved_mem.h |  1 -
>  2 files changed, 1 insertion(+), 22 deletions(-)

Applied, thanks.

