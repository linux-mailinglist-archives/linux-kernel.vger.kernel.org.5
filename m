Return-Path: <linux-kernel+bounces-71435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F155685A531
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9187C1F234A3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D218536AFB;
	Mon, 19 Feb 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="VbG5kIlD"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811332182;
	Mon, 19 Feb 2024 13:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350992; cv=none; b=VkWbUawf3K1W/tuEX9hagyYIFZJ6thXwocB0Zz8omB+LUSN9Tztic9ezoikUoKwj7+PV49EgFsg3o4i1zxxoGQ6QGAgng2xXcSFqjhXmf+P1VobGdEyqpoPU3aKiULgcZ9QvHBC5KARWSpjvChjNfsFjVS5x5cIo9MLjiLrqHkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350992; c=relaxed/simple;
	bh=RgNJprUPPOwhgeZ+/R3P4cQ/LqQ2+TTNR4vf52w2fm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ph2wmv+LEwpJYs27yOyvvEqXkwyWFoRqAJUCKE+yLiP8nib/doCKBI25GWbU10JjT76UlKSQQn288T4vJ7+UDq0p4INnr9VxiAfQG68nUvtXwykkVjaUmJ18RypsOSR2ILAdSanJO6kaDOY0pru+HhJQp3NYksCQv/wvQF/LM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=VbG5kIlD; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.38] (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 2BFAE2012151;
	Mon, 19 Feb 2024 14:56:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 2BFAE2012151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708350989;
	bh=v6h+TrhDCcE8IdpFwn9bMKIad9vYrlT3yDGRaM2ZAMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VbG5kIlDrORQqXvWn0WMs9HpjzrRMevGs7wjEDQih1jP60yCONS7UjsItXmrEIqHl
	 wu+AmuGiwc2oBAoHY6rb/ByUoxHF8Iu1KmoUK3zFx7UfxF6MBoQVFOm5mrnFMtmcz6
	 NN+9V3SkU2eSqVf5CQhuHLMjwFWdbblor82dQVbvh/5JPv5ItkcDiTopmAkjrbq+P+
	 GScktonQlaiOhxZGk9BiuiaNirCcp3Y8101S+tmUfN+1BvCDD00/7E0lY4dOniN6Gn
	 aj6h/pjOATGA5Y0ZM04bgHV/iXlwwXdqYscavkADyn8UJfWePE5yokSPa5+XQziL6f
	 XEzPmK760Aytg==
Message-ID: <4aa88e30-ea08-44ed-a7a3-602c12b6705b@uliege.be>
Date: Mon, 19 Feb 2024 14:56:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] ioam6: fix write to cloned skb's
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
References: <20240219134821.14009-1-justin.iurman@uliege.be>
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20240219134821.14009-1-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 14:48, Justin Iurman wrote:
> v2:
>   - use skb_ensure_writable() instead of skb_cloned()+pskb_expand_head()
>   - refresh network header pointer in ip6_parse_tlv() when returning from
>     ipv6_hop_ioam()
> 
> Make sure the IOAM data insertion is not applied on cloned skb's. As a
> consequence, ioam selftests needed a refactoring.
> 
> Justin Iurman (2):
>    Fix write to cloned skb in ipv6_hop_ioam()
>    selftests: ioam: refactoring to align with the fix
> 
>   net/ipv6/exthdrs.c                         | 10 +++
>   tools/testing/selftests/net/ioam6.sh       | 38 ++++-----
>   tools/testing/selftests/net/ioam6_parser.c | 95 +++++++++++-----------
>   3 files changed, 76 insertions(+), 67 deletions(-)
> 
> 
> base-commit: 166c2c8a6a4dc2e4ceba9e10cfe81c3e469e3210

Sorry, please ignore v2 due to net and version not present in patches 
tag. Instead, please consider v3. Thanks.

