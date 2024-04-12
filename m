Return-Path: <linux-kernel+bounces-141814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1798A23CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB202850EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB2B10A24;
	Fri, 12 Apr 2024 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvedhCm7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601DD205E34;
	Fri, 12 Apr 2024 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712889340; cv=none; b=MthWMMc7df27pXqHoR2gTNkLYV/MBWzB+I/mgsej26QlwRKsSAARMo67/FT3ERl9pe0/emz3O4aNl9bRnUxPOD4lBzaKh2xZc1XNHACfguRWT2kDaBR5nQMERQlS41smHr7qSP/TU0uo+GLWjUFDBUjNhb04jBwn6snqXr+sUPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712889340; c=relaxed/simple;
	bh=UHLb8BMg9kcikF9LErqMMTQBOl5MAAVtW9EC56S4M9k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpJ5CBrHaeUO74zDckJMTq8Vy3k4M7jLQwRh5QyW5e38Z03s+O67tBVN99pcNPcwsIzNs6v6C2G/jpTPn7oXljPH3ctulR3aWxEo579eLVF4Rg8ehV55jtASdKYGW8Y/kFYMtQhJ4RtCXAT7waUyI1qcnOESgKJkRsSMI+sCTxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvedhCm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DA2C072AA;
	Fri, 12 Apr 2024 02:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712889339;
	bh=UHLb8BMg9kcikF9LErqMMTQBOl5MAAVtW9EC56S4M9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VvedhCm7a9pXhYiZ8cphtt4m7Xvujq99Fh8VKi6dVesz85fnV84tHD+qATEZMrl9E
	 +B6Q3UUCtb34yGr1V0n7gAuxp8wJ/J6nrLMrZ5TTQ/58Ui2rwXtmxEZiN0mb3d4R8P
	 8XLSGRBb/9xrDaNsmZe9qgDWgpmOV/P4nHurOIsbZBE4lFKudqHUqwZXr/QxugzRLe
	 DbGS/FTFcMNSKM4fyWFAKDZjwy1H8eUjDSEhp4OwNlWZ1RhpO4QvnFR+UlzVHFKFdr
	 bzdkrvXDhEZ0x+jqQYLPnmzte9U5taukH34gG3llJCS3rLn/FNOhU1ro+EwSY/iGfr
	 Bf95y2G4JeZ+w==
Date: Thu, 11 Apr 2024 19:35:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] flow_offload: fix
 flow_offload_has_one_action() kdoc
Message-ID: <20240411193538.46f42987@kernel.org>
In-Reply-To: <9abe0c09-efa5-4ff4-b423-469a2dd34ef8@amd.com>
References: <20240410114718.15145-1-ast@fiberby.net>
	<9abe0c09-efa5-4ff4-b423-469a2dd34ef8@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 12:32:44 +0100 Pieter Jansen van Vuuren wrote:
> [Removed my old email address from CC]
> 
> This LGTM, thank you.
> 
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>

Thanks Pieter! :)

Consider adding a .mailmap entry to remap the email addr.
We already have Simon, Quentin and myself there, from @netronome :)

