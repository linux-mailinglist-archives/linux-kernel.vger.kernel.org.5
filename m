Return-Path: <linux-kernel+bounces-69297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E92CF8586BA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B59C282146
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CAC61386A1;
	Fri, 16 Feb 2024 20:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9s57z4z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B687A139581;
	Fri, 16 Feb 2024 20:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115268; cv=none; b=gc6lorh1pbjYMAGRvVCyNasDiPDMSOlRUY6VCSGfZBpTgw14VNVjl/tHzVfUDbb8iXiWLjL6VeZGCbQBpwAQmhvEp+sp+EhBQk8S3D4tG4sxWR7nsB/oaq1W3FcgV3FgjBcuoSrJxoKWXEfVcjkUlQFKcnb4zNx2iTkflDBUge0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115268; c=relaxed/simple;
	bh=5eEyyHxk59pCQy01eZ3kO5VsW0KLoSkpdsO63ghICCI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T390rVYtQAA3egQVuY/vKiEKhPQrsA94z0arudBPiy7MuMq/bO1p/Ff2EZ16ouG57VZcJXLYaWmcYzwvZ5w4Mn5Z2Fp5SR36hUQcq2ogT6yLoHbcKzuigtnuwBKb06ZazmIzrV9200907fXRIDLAaEjSq6wkOrcROJigSaav/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9s57z4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2851C433F1;
	Fri, 16 Feb 2024 20:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708115268;
	bh=5eEyyHxk59pCQy01eZ3kO5VsW0KLoSkpdsO63ghICCI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=C9s57z4zJYL3RMdj308R+wIz3APNia/JGof6uISu1wROuMciZ7P8Vay9YbMooG65R
	 J6lSDiXezleXAH8A6OCkWOL0ex4QNEebSeFeZKQe5hcX5D7qVYderfXMEgNh8RHbpz
	 iDiU1GohfAtHLV3qM1XU8IxzZEg+xROk6l1175YK5++Nq4dKT4fXIaR8eRsyzz5TuL
	 I3GkKwTW2a80A1gqhM3cJerdLKakhddVtcqPXi2ZkYmns/0N9t6KgB0NsMpX67r8Q8
	 8KVxW1btTlD6v1zkY/5aaJKWiCqHjltIVQkGNIV7m7xQpPGBRgpzMQwzyNqpUiB0v1
	 yal9i8V8MyLJQ==
Date: Fri, 16 Feb 2024 21:27:48 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, corbet@lwn.net, 
    workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
    linux-kernel@vger.kernel.org, security@kernel.org, linux@leemhuis.info, 
    Kees Cook <keescook@chromium.org>, 
    Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
    Krzysztof Kozlowski <krzk@kernel.org>, 
    Lukas Bulwahn <lukas.bulwahn@gmail.com>, Sasha Levin <sashal@kernel.org>, 
    Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v4] Documentation: Document the Linux Kernel CVE
 process
In-Reply-To: <20240216192625.o3q6m7cjgkwyfe4y@treble>
Message-ID: <nycvar.YFH.7.76.2402162108370.21798@cbobk.fhfr.pm>
References: <2024021500-laziness-grimace-ed80@gregkh> <20240216192625.o3q6m7cjgkwyfe4y@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 16 Feb 2024, Josh Poimboeuf wrote:

> - Not users of -stable since they already know they need to be on the
>   latest version.
> 
> - Not distros or their users as it's just flooding them with low quality
>   CVEs which have no analysis or scoring.
> 
> And enterprise distros will never be able to rebase onto -stable,
> especially for older streams for which they have to be very selective,
> in order to avoid destabilizing them.  As you say, "a bug is a bug".

Now that you have played the distro card (thanks!) here, let me just copy 
my comment from LWN where someone suggested "well, it's easy, it's the job 
of the [paid] distros to do the triage" ...

The problem is, that with this new system, paid distros are going to 
suffer a big time (with no benefit to anybody at all). We'll have to put a 
lot of productive and creative (upstream) work on hold in order to have 
enough resources to sort out the havoc that LTS team is apparently going 
to create by DoSing the world with a truckload of irrelevant CVEs.

-- 
Jiri Kosina
SUSE Labs


