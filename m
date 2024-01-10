Return-Path: <linux-kernel+bounces-22296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA35829BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853F72886C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8874A997;
	Wed, 10 Jan 2024 14:01:32 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C18A23CE;
	Wed, 10 Jan 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rNZ8z-0000jz-0g; Wed, 10 Jan 2024 15:01:21 +0100
Date: Wed, 10 Jan 2024 15:01:21 +0100
From: Florian Westphal <fw@strlen.de>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@openvz.org
Subject: Re: [PATCH 1/4] netfilter: nfnetlink_log: use proper helper for
 fetching physinif
Message-ID: <20240110140121.GA28014@breakpoint.cc>
References: <20240110110451.5473-1-ptikhomirov@virtuozzo.com>
 <20240110110451.5473-2-ptikhomirov@virtuozzo.com>
 <20240110133333.GA24888@breakpoint.cc>
 <367b1642-c09a-4bc6-ac63-7692b716174d@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367b1642-c09a-4bc6-ac63-7692b716174d@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
> On 10/01/2024 21:33, Florian Westphal wrote:
> > Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
> > I think you can drop this patch and make the last patch pass
> > nf_bridge_info->physinif directly.
> 
> The whole Idea of this patch was to replace nf_bridge_get_physindev with
> nf_bridge_get_physinif before the patch which propagates net, so that we
> don't need to propagate net first and then in later patch remove it when
> replacing with nf_bridge_get_physinif.
> 
> But I spoiled it by forgetting to remove net propagation to
> __build_packet_message...
> 
> Is it ok if I leave this patch as is, but instead remove:

Yes, thats fine.

