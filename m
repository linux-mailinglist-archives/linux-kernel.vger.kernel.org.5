Return-Path: <linux-kernel+bounces-79641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 800A1862525
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 14:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41C18283D57
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 13:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E963F9F3;
	Sat, 24 Feb 2024 13:23:31 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD8125C3;
	Sat, 24 Feb 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708781010; cv=none; b=ttqWrZ6fFE8seEUh3Apc3DgG5HKSG7K7nEbypxmiTLUfWVylxvrzpxgaZqUjvSuxYontaT12xK4t1QDX9Y1Yhx5KhKt5nozJ9/UEdmqBT66iirpRGfI+LBLfJCOmaid1HBXKpkCaOUSXIy2rioBLDUXoFThxUMG/MXuwGhLyj80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708781010; c=relaxed/simple;
	bh=sOeZ7VjdJLtUTLoc52UIxXOs60Oaaq74itnIyOLQ3xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9akinK1YbolN0tLgyZ5iGYP2JP32x9YOkMhe/hWPO0AtTiUhO/mV4fAbLNVkKWNeYjZn7WtOEo0SYlX6Fi3BYumWLZ6wUZcJsxRFpzw+Jq+XVpP2AmeHaZjuzrq7wsmbVYU8/YdBgRyUUCbsf/RScG9PBUWFUHQiwY1IMPXgHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rdrzh-0004nb-7z; Sat, 24 Feb 2024 14:23:09 +0100
Date: Sat, 24 Feb 2024 14:23:09 +0100
From: Florian Westphal <fw@strlen.de>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: xtables: fix IP6_NF_IPTABLES_LEGACY typo
Message-ID: <20240224132309.GA27709@breakpoint.cc>
References: <20240224121330.1924338-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224121330.1924338-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Arnd Bergmann <arnd@kernel.org> wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CONFIG_IP_NF_NAT accidentally selects the wrong NF_IPTABLES_LEGACY
> symbol, which ends up causing a link failure in some configurations:
> 
> WARNING: unmet direct dependencies detected for IP6_NF_IPTABLES_LEGACY
>   Depends on [n]: NET [=y] && INET [=y] && IPV6 [=n] && NETFILTER [=y]
>   Selected by [m]:
> 
> Select IP_NF_IPTABLES_LEGACY instead of IP6_NF_IPTABLES_LEGACY.

Patch is correct but this is already fixed via
749d4ef0868c ("netfilter: xtables: fix up kconfig dependencies")

