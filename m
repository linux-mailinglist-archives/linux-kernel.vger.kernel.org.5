Return-Path: <linux-kernel+bounces-150409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 755D48A9EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151641F21BA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE5516F830;
	Thu, 18 Apr 2024 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhkqlAwL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C40F16C84E;
	Thu, 18 Apr 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454727; cv=none; b=JxIeAXP3Z8SaPz7FQMpj6Fnq01lIORa0dY7QCBmZ3oCPHiPSXd/6v9No5eDoIAovC8aCwcUwWg/5qZGzVG4XT4sEK8aysh6pzxPtkoOp6B7UZfshD1zkmFSboApCZQp3RN/0tuufz7YZnmjFktQGHhvCTDdmvectQhjTKahpdzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454727; c=relaxed/simple;
	bh=9L+ytCqJGlRq3mzedi+5XWftfmTStIQGpeqQNjbi9W0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EQO7IP1qtttOpWbUAB6uOimbrwSlnZZQ+rr8IH5WA8xMhcaqb+0ihnn3ABAcvaVS8+jwR4vg3ZbtCc3adijRiipJb2IhaFyvmu3EAW0iTKQrVKnAQgZlssbu8k+TRQ9u7+pKvPSEusMS4Vj377p9h8e5sv2Ks2GxvXcluifwgiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhkqlAwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94367C113CC;
	Thu, 18 Apr 2024 15:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713454726;
	bh=9L+ytCqJGlRq3mzedi+5XWftfmTStIQGpeqQNjbi9W0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FhkqlAwLouBJA2FGHB5wBlMYjSFVy0bAyBCQaBukcpwfhQlqeRWJjdFcWcrtj3cjm
	 u0T17lxmpCKznktqjnYy+0Aoi1ejwILyqT3aL5WzIPUgjd+OnSuHnlYg++g0Luwt9B
	 yq4GdUoa8Fqz07kE1Qr/XiDIOJrlGMgZehjk8hCh4h/AddTHDar1N1Mm7hywKGDOYp
	 Q5sWO/Wi2oJ46Wsn5ndjQ+iwijlELQalWLyeKhEfY3DQWf/fcCWQh/2eXw86q2t2Ia
	 oCEMxlZkLd0nY/e8hdbfNDGHijQEvANN/+LoO+Y0DM/H237ywG4GT614RdyqElbcVf
	 v9L9nJrBIMNvg==
Date: Thu, 18 Apr 2024 08:38:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "jun.gu" <jun.gu@easystack.cn>
Cc: echaudro@redhat.com, dev@openvswitch.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: openvswitch: Check vport netdev name
Message-ID: <20240418083845.3b1f2407@kernel.org>
In-Reply-To: <20240418023242.259542-1-jun.gu@easystack.cn>
References: <811765EC-AD27-4210-9AFC-034129F24BFA@redhat.com>
	<20240418023242.259542-1-jun.gu@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 10:32:42 +0800 jun.gu wrote:
> +	if ((!vport->dev) || strcmp(name, ovs_vport_name(vport))) {

Please drop the unnecessary brackets.
When you repost, start a new thread, do not post new version
in-reply-to.
-- 
pw-bot: cr

