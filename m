Return-Path: <linux-kernel+bounces-14597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83532821F67
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0DD1C2255B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F413E14F85;
	Tue,  2 Jan 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PARIRRPY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833714F62;
	Tue,  2 Jan 2024 16:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653D0C433C8;
	Tue,  2 Jan 2024 16:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704212575;
	bh=gG7U8wfsqJspOQsKTYrud7yfex3Z8KKl5bsvmNjAg0w=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PARIRRPYBxRfsOodJa3PH1YXUIuLMRrPsjXTikeMyJ0DLVSwjopF0hjV+YMdtszYO
	 iErETpkXzoCX4spRW5BL/2unwgX1hi8Lv1GsqE3p+gGZJsZPMEhHdYBMQYfhHMu5gG
	 g/Gp0+nyWsuVHCt7CtlScl1xFDOapMRbEGOOaXJkUruDqbUvQuTOPozIgSuZbYI+K5
	 27wu7pcf2RygN9MfsIS7Ybx+G/mqk/3R4vyuC6lhF8994V0u+OuMnBhz3UaIPRoC8n
	 n6m5Ar0Z8BHISdSbytdNNgCZiWwiQGIv0NZQ+BqOju50Ym73aMXuqmZHPakfgKFwv5
	 UCa3XlgcXjbdA==
Message-ID: <e29255b4-4905-4c33-82b8-094c7b8ef61d@kernel.org>
Date: Tue, 2 Jan 2024 09:22:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/3] net: gso: add HBH extension header
 offload support
Content-Language: en-US
To: Richard Gobert <richardbgobert@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <127b8199-1cd4-42d7-9b2b-875abaad93fe@gmail.com>
 <27d4cc21-1ce5-4417-bd0c-6dd43a92e4aa@gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <27d4cc21-1ce5-4417-bd0c-6dd43a92e4aa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/2/24 6:20 AM, Richard Gobert wrote:
> This commit adds net_offload to IPv6 Hop-by-Hop extension headers (as it
> is done for routing and dstopts) since it is supported in GSO and GRO.
> This allows to remove specific HBH conditionals in GSO and GRO when
> pulling and parsing an incoming packet.
> 
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> ---
>  net/ipv6/exthdrs_offload.c | 11 +++++++++++
>  net/ipv6/ip6_offload.c     | 25 +++++++++++--------------
>  2 files changed, 22 insertions(+), 14 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



