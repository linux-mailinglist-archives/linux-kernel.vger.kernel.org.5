Return-Path: <linux-kernel+bounces-97757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFB3876F04
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136771F21AFD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70D36124;
	Sat,  9 Mar 2024 03:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sM4Qs9ET"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665E21DFE8;
	Sat,  9 Mar 2024 03:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709956531; cv=none; b=gzmqFiZ3kh56dLACDiwqycnUyHLLd8XbyqwTvNPFQNe2cJmoQ3gHpshUL6D6A3jal1ExkFANKO5sbmO8J0s96hxGyvDasOuEGUkhaxcYThWxuZHnZ0EctltsKVvWLNe+/Ma4syD63plPavd58P0PzLKzDyiWPNiuOgTKWh38SJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709956531; c=relaxed/simple;
	bh=cqxnRONxFqoFUHeLlMQOk9RLWMYU12XehXtvW+dv3SU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7JgGpwVdR7RjDBbgPw5KWVREkyIVkNvAuWRrnuHxUTqonbredHyvNYJxjYZGTmb8lCr75O+QgFclhdgd6P80SvQC639H8AaZUMIAkkuComUXRYD0IQtnf0CgH3RIDwAGQ6M4Bli7Fm8ex326LSKrm4aXREC+TsB0ERDWEN/8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sM4Qs9ET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD52C433F1;
	Sat,  9 Mar 2024 03:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709956530;
	bh=cqxnRONxFqoFUHeLlMQOk9RLWMYU12XehXtvW+dv3SU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sM4Qs9ETo7lFcytqB+dUZRGcitywoe5QpVnTaB+Gb1qLUPghLmhmX6uZfF9Q9SspY
	 49vo6v5lhGzBOKbolRDTxPweK0n5BUYO57gIfpAYlCTOfvJPO+tZ2/4F68jvFF6YAh
	 Zv+mdyJWhO+n/rrHFMigEPhNepDiOhnBwNtlR6p4/4QoL+KiOY0nV7y/baUdeJJ9is
	 MmMCG33JFuzorRhylVORKkJticmBJ0FiYHvRzRt8n6sGT4jesrgcS2EElPCpeKfPmN
	 EFu6qHhJsSdjnqOz+kgjP7WO+fmojNwH2taMyHFfIT0WFlkmXubUw6TYcMxpdORLul
	 wN9zMfntaM78Q==
Date: Fri, 8 Mar 2024 19:55:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leone Fernando <leone4fernando@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dsahern@kernel.org, willemb@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/4] net: dst_cache: add input_dst_cache API
Message-ID: <20240308195529.57b1a4fa@kernel.org>
In-Reply-To: <20240307171202.232684-3-leone4fernando@gmail.com>
References: <20240307171202.232684-1-leone4fernando@gmail.com>
	<20240307171202.232684-3-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  7 Mar 2024 18:12:00 +0100 Leone Fernando wrote:
> +static inline u64 create_dst_cache_key_ip4(const struct sk_buff *skb)
> +{
> +	struct iphdr *iphdr = ip_hdr(skb);
> +
> +	return (((u64)iphdr->daddr) << 8) | iphdr->tos;

Sparse complains that you're ignoring bitwise types:

include/net/dst_cache.h:170:19: warning: cast from restricted __be32
include/net/dst_cache.h:170:19: warning: cast from restricted __be32
-- 
pw-bot: cr

