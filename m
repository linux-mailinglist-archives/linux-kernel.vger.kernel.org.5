Return-Path: <linux-kernel+bounces-22252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5F7829B72
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAE71C222E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B380D4B5BF;
	Wed, 10 Jan 2024 13:34:44 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A844B5B8;
	Wed, 10 Jan 2024 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rNYj5-0000Z0-PZ; Wed, 10 Jan 2024 14:34:35 +0100
Date: Wed, 10 Jan 2024 14:34:35 +0100
From: Florian Westphal <fw@strlen.de>
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@openvz.org
Subject: Re: [PATCH 3/4] netfilter: propagate net to nf_bridge_get_physindev
Message-ID: <20240110133435.GB24888@breakpoint.cc>
References: <20240110110451.5473-1-ptikhomirov@virtuozzo.com>
 <20240110110451.5473-4-ptikhomirov@virtuozzo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110110451.5473-4-ptikhomirov@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pavel Tikhomirov <ptikhomirov@virtuozzo.com> wrote:
> This is a preparation patch for replacing physindev with physinif on
> nf_bridge_info structure. We will use dev_get_by_index_rcu to resolve
> device, when needed, and it requires net.

Acked-by: Florian Westphal <fw@strlen.de>

