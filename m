Return-Path: <linux-kernel+bounces-111678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ED7886F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BADB1F22C22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E354D9F0;
	Fri, 22 Mar 2024 15:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tolfqZJr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337B50A6C;
	Fri, 22 Mar 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120049; cv=none; b=vC0JBoVqhxgsCKGktFyBJI/ZsEXYkZ5vEis2pPHxjwcSYAMj1Fwq4Lr8LxjYt98cJDkFIz5hOrnap+kZkW96J+LjBuDjKPsnsZy6L6FJAtDUWEVaGsB9zo/mQt/GKuQeoSbhYe5t/O2VZysTD5LSYvTEhc/CDaOmEjaikjg0/k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120049; c=relaxed/simple;
	bh=cOjxN5a8Uxoq5RZDOaVWJjUpOyf8vxk4lYzck1Oloh8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lf+CijmLzq0mxO3oeWcSOagiThvJEtVk7eGiVe7ZsnQIi2w7i4shXJyLh3M86ayQi1xV2F9XSotsNP4PhFkmXrLka88ClPNiChY5lq4LQ1FKBz5TcIOchyxXSSbuL7BUAQT9KxsdFQM7z+uLkI0IoVhpdch4xfiSix5mEznfY+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tolfqZJr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15942C433C7;
	Fri, 22 Mar 2024 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711120048;
	bh=cOjxN5a8Uxoq5RZDOaVWJjUpOyf8vxk4lYzck1Oloh8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tolfqZJrO+Z3wfVlqqFejJv6TQ2YOXt2+91MUkKj4NcF0/SakEipDbZyE2ehaj4yM
	 dJz/m6/2UCXerb/eqH193Tfu2lnTrTQGI8YM0pr83GaNwp/Qyx+2DI/uF0uSQEb1hs
	 CtgPX07D7x1kA13np4oH5E53+8gAAdJAYYsBI+lcF8xUDlCIJ9fIwFbRBhGRzVsdOP
	 xe73vy8tIT5+kCJOAJSGF3hss31q2NcLYbfR3VG2w7Nf8UQ9qgqA7I5sOMEhq1ewBs
	 IE93Mq98NskOF0d0hsa9zOqxgfPfWObK/8j2TwjrMBIPlmczlfGjw9+Li425rM++y4
	 SeXLCfk8tynHg==
Date: Fri, 22 Mar 2024 08:07:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: gaoxingwang <gaoxingwang1@huawei.com>, mkubecek@suse.cz,
 idosch@nvidia.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 yanan@huawei.com, liaichun@huawei.com
Subject: Re: [PATCH] netlink: fix typo
Message-ID: <20240322080727.786dd760@kernel.org>
In-Reply-To: <Zf097_S2K9uxGsR5@nanopsycho>
References: <20240322072456.1251387-1-gaoxingwang1@huawei.com>
	<Zf097_S2K9uxGsR5@nanopsycho>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 09:14:39 +0100 Jiri Pirko wrote:
> "gaoxingwang" certainly is not.

According to what rules? Honest question, I don't know much about
transliteration of what I guess is a Chinese name.

