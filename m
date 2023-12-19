Return-Path: <linux-kernel+bounces-5441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E49CE818AB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EA21F2939D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEEC1D157;
	Tue, 19 Dec 2023 14:58:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBED1C29F;
	Tue, 19 Dec 2023 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rFbXx-0007lI-5j; Tue, 19 Dec 2023 15:58:13 +0100
Date: Tue, 19 Dec 2023 15:58:13 +0100
From: Florian Westphal <fw@strlen.de>
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Simon Horman <horms@kernel.org>, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ast@kernel.org
Subject: Re: [RFC nf-next v2 1/2] netfilter: bpf: support prog update
Message-ID: <20231219145813.GA28704@breakpoint.cc>
References: <1702873101-77522-1-git-send-email-alibuda@linux.alibaba.com>
 <1702873101-77522-2-git-send-email-alibuda@linux.alibaba.com>
 <20231218190640.GJ6288@kernel.org>
 <2fd4fb88-8aaa-b22d-d048-776a6c19d9a6@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2fd4fb88-8aaa-b22d-d048-776a6c19d9a6@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

D. Wythe <alibuda@linux.alibaba.com> wrote:
> net/netfilter/nf_bpf_link.c:31:22: note: in expansion of macro
> ‘rcu_dereference’
>    31 |  return bpf_prog_run(rcu_dereference((const struct bpf_prog __rcu
> *)nf_link->link.prog), &ctx);
>       |                      ^~~~~~~~~~~~~~~
> 
> So, I think we might need to go back to version 1.
> 
> @ Florian , what do you think ?

Use rcu_dereference_raw().

