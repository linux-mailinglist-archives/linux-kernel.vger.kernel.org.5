Return-Path: <linux-kernel+bounces-75607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E256885EBE4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4B52851D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51363C473;
	Wed, 21 Feb 2024 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ttd0uWL/"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB34EC5;
	Wed, 21 Feb 2024 22:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555012; cv=none; b=inSZv6N1I4SMR5UtXmvrUISbpQKKV2skjqnn4z/QLI0+sWfNR21CITRAnd25U5ges+e7AkkLPdMdtezi+is4H6Snm/HgMd/0pM+e3ObB77ydLFbW1nO4xGDxPAS+uz8zwCdnux1xNzhmeG2RiizhTJ+yZzchxsSHTJNTvIYxO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555012; c=relaxed/simple;
	bh=1DlCMsm9Uoa6uGuW9HYEKY5OHTI8oAijmibPIeN5aEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHocYNxhT2rtH5doNBZQGkINO8qvhsqE7GzC565gyRpkh5mwlDB4ybXvIHTTpf5G8ZTAvFcCOd45EHLC3NKWvrePRnBSvPHH3ZtBU8WCEuf1ICD9sXqGog8l5gzmAcXVXIo72O+Ng0I8/75yf/yHUAzzEQR5S6Z+OuTtS+4zqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ttd0uWL/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+DUC9Ol77HyNFU3nLRrnMQQ7bRbYxwVbPzMRC3bl3iU=; b=ttd0uWL/7GDlNBMREPucoEQUUI
	7xtjioQo7PLDh6I7TXwyRrlID5zprEJOlSO1E5qphV/bAZV4MEll/4egqGVWwgOpcjNVqnIcQ+IQN
	RCLrYZ6ttiIbMg1cBJ0TlydnVPYiMLvdrTTFSQrUm3YL+Td8pUeDNvkPzNA4TnxdbJ5M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rcvD2-008OrM-Fa; Wed, 21 Feb 2024 23:37:00 +0100
Date: Wed, 21 Feb 2024 23:37:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] power: reset: restart-poweroff: convert to module
Message-ID: <f8e3a66f-20a3-4819-ab1b-d0f163a2e95f@lunn.ch>
References: <20240221174610.3560775-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221174610.3560775-1-alexander.sverdlin@siemens.com>

On Wed, Feb 21, 2024 at 06:46:07PM +0100, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> The necessity of having a fake platform device for a generic, platform
> independent functionality is not obvious.
> Some platforms requre device tree modification for this, some would require
> ACPI tables modification, while functionality may be useful even to
> end-users without required expertise. Convert the platform driver to
> a simple module.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
> This RFC is merely to understand if this approach would be accepted.
> Converting to "tristate" could follow or preceed this patch.

So that is you use case here? Why do you want to be able to just load
this driver, without using DT to indicate it is needed by the
hardware?

    Andrew

