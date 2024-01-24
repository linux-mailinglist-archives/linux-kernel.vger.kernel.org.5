Return-Path: <linux-kernel+bounces-37691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BA183B3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EE3286E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4E01353E9;
	Wed, 24 Jan 2024 21:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWdBB08p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA91350FE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131588; cv=none; b=a8W2fQM2dkj1hpPAfjXUJ+AshUbJsERN1CyNl+6/OaLkU7ZQpchqDPqojSbJhl1gpFFZP3XMIfeEPAmmGWSKeWZp8VAYpSPrKtIJAvYg90vz4JIMTrSSNhV3EfyTHrVLE8kXFNz3BeMUJ9RYBMys3eF7FHpRKjoLdh8S/Ha6a0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131588; c=relaxed/simple;
	bh=YwjKI9TeRHu2HAKPXCip024NEWDyVskxtCxsbbjnWH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJ4oV5EsSfYzMRmUGTcm78jbAFBx3odHwwfH1J2UTh1lQAgDoSYcEBPdEN80lfjSDFQQNGPy6R5FyWI3QpMa4yFtwrWLEhsOM6+eWAZKBZFi2ZpaQD9EXTl8NaiK8/XsfzinyTUtGcpKdT9DPmuG3X8TPvyc/jFG57qYlz58amk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWdBB08p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69508C433C7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 21:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706131588;
	bh=YwjKI9TeRHu2HAKPXCip024NEWDyVskxtCxsbbjnWH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XWdBB08pAvWlFFOGiCQ50GGE7LOSF1o0sADddoFwxY+/vNc1bPZODndkrIqIFkBgr
	 /PyFZIlDASbCCabOHGf+LMESjAP7UA4NR0m39y6z2fuOXVmFOnAiBrbaiIPj1O0Rmv
	 nbOMYtvJJAgYeNmO3xeTjm3Xu26l7qS07zu97GoBxBU3eQKIk6M/86GFUwaraSa3Hk
	 bQciRZsNfZ8SYz/2mgphsnFFePJn+Rb6Gj66qQV98O7ep4Y50kX+nZWNqvw1v/mNv4
	 /L7sLRpMrNMIaHfC6BXr3FW9ixFRgd3ZszBiiL2Txrp2g7hKziE5RM2meWRUjFcESL
	 jZHUHyVz6wqdg==
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4b77c843fbeso1613841e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:26:28 -0800 (PST)
X-Gm-Message-State: AOJu0YwCizFrqzvy3h98/7lh2AkXWWdLVyCOgxa7I3r3AVPFfQcxgqdp
	UyyCdY/DVuQHW+T7/77RlhWXXJC/DEF5HrVzneSM5IgoW7Deoon7s0qNFpOh2sb9xXS0xiXMZHT
	LXTjSUUjnGgioafkEEYtYaO8VdOGPVpxSxZz6
X-Google-Smtp-Source: AGHT+IErdulTFO3fU5VxFF9xvpJwqyHGtju6bYR7gxGQ9ytOi9U/IKanvnGLGrlOBya/uIxR0d9OR3DGAEPJ+q4+KNU=
X-Received: by 2002:a05:6122:3691:b0:4bd:67b3:fd5c with SMTP id
 ec17-20020a056122369100b004bd67b3fd5cmr48494vkb.31.1706131587436; Wed, 24 Jan
 2024 13:26:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124004028.16826-1-zfigura@codeweavers.com> <20240124004028.16826-2-zfigura@codeweavers.com>
In-Reply-To: <20240124004028.16826-2-zfigura@codeweavers.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 24 Jan 2024 13:26:15 -0800
X-Gmail-Original-Message-ID: <CALCETrU+Eb5CdkqfYK8JvOiPA7K-6Bfs4uEWiu-U9oH95XfvKw@mail.gmail.com>
Message-ID: <CALCETrU+Eb5CdkqfYK8JvOiPA7K-6Bfs4uEWiu-U9oH95XfvKw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/9] ntsync: Introduce the ntsync driver and character device.
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	wine-devel@winehq.org, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 4:59=E2=80=AFPM Elizabeth Figura
<zfigura@codeweavers.com> wrote:
>
> ntsync uses a misc device as the simplest and least intrusive uAPI interf=
ace.
>
> Each file description on the device represents an isolated NT instance, i=
ntended
> to correspond to a single NT virtual machine.

If I understand this text right, and if I understood the code right,
you're saying that each open instance of the device represents an
entire universe of NT synchronization objects, and no security or
isolation is possible between those objects.  For single-process use,
this seems fine.  But fork() will be a bit odd (although NT doesn't
really believe in fork, so maybe this is fine).

Except that NT has *named* semaphores and such.  And I'm pretty sure
I've written GUI programs that use named synchronization objects (IIRC
they were events, and this was a *very* common pattern, regularly
discussed in MSDN, usenet, etc) to detect whether another instance of
the program is running.  And this all works on real Windows because
sessions have sufficiently separated namespaces, and the security all
works out about as any other security on Windows, etc.  But
implementing *that* on top of this
file-description-plus-integer-equals-object will be fundamentally
quite subject to one buggy program completely clobbering someone
else's state.

Would it make sense and scale appropriately for an NT synchronization
*object* to be a Linux open file description?  Then SCM_RIGHTS could
pass them around, an RPC server could manage *named* objects, and
they'd generally work just like other "Object Manager" objects like,
say, files.

--Andy

