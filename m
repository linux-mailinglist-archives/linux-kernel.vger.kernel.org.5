Return-Path: <linux-kernel+bounces-78967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06664861B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B571C28A3C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73DA142634;
	Fri, 23 Feb 2024 18:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="mjZbgi9O"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2E012D1F9;
	Fri, 23 Feb 2024 18:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712410; cv=none; b=qvhKL1lCvUlTULkTZhGoknuRzDAnQw1YtiWQil3KabYJztirSix4hSJhKgwwBAWeHpAtM/5+yHdOx/1SYO0mttuswpjTt/vPp//nb6UsVcapoXXvy+iC7BrL8+QVxhxzvH3jIO2tRhWRU8qfx7wR+T4lgASS5QjtK9+GU90Q00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712410; c=relaxed/simple;
	bh=L17zNUCxvNnm7yyqQ7WS5W8AZHiSgpBGe/zD9/AGBOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y0ZOBfUI5EnREzcYLk0OQ0IThrN2nncDvlDcnhl3e88aHHSMymL3Q8oukEs2ptCEesTB+5MKiyOVu2J3l77+o3eSjsWXBujsnOVQg5W5bvEQ1pPrE5Ely5MbNzH2IRhoixfCb1rS1zBv/tdl2UWQx8SedzZrqniVAcppl/NWKcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=mjZbgi9O; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.55] (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id CE777200C247;
	Fri, 23 Feb 2024 19:20:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be CE777200C247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708712405;
	bh=QvbrHms9ETKk/v/CsD8CfF4FaoDekyg4wG/YRj8GOqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mjZbgi9O1KiS3zphKQB3YRcvJaUIZGjlHWJbEWKciGZrv9WW10zNrgHKW/5d3UY/9
	 Q/+npasTrG7gWq0+wNIoVxufjRcpPgyvg+4DGR6qZaX6+j1LANaU+p1oze7zVtdpLe
	 KAgWj+CTITrjLGKVbMbSKsItLiwk5gwGIzxmlTOTA3eX3qO5VSOlTRgurILwzGswLM
	 Rpn5VjpTQRu0ft89eDT3Viy4gwi2Fuu8TJnn1uOIqvix24WEEBsufY69LmzJcn1z3W
	 Ajp0GFK5pWsq1uzU1n+qpfiXWZt2DUeMjOTCZrshgQ+LRgBII3M99txJB28MqE+cNV
	 IcQbMvSws1W0A==
Message-ID: <da6a308f-8053-4744-8b81-67b63232a526@uliege.be>
Date: Fri, 23 Feb 2024 19:20:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/3] net: exthdrs: ioam6: send trace event
Content-Language: en-US
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 justin.iurman@uliege.be
References: <20240223144135.12826-1-justin.iurman@uliege.be>
 <20240223144135.12826-4-justin.iurman@uliege.be>
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20240223144135.12826-4-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 15:41, Justin Iurman wrote:
> If we're processing an IOAM Pre-allocated Trace Option-Type (the only
> one supported currently), and if we're the destination, then send the
> trace as an ioam6 event to the multicast group. This way, user space
> apps will be able to collect IOAM data (for a trace, it only makes sense
> to send events if we're the destination).
> 
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>   net/ipv6/exthdrs.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
> index 02e9ffb63af1..003f35d9b42b 100644
> --- a/net/ipv6/exthdrs.c
> +++ b/net/ipv6/exthdrs.c
> @@ -50,6 +50,7 @@
>   #endif
>   #include <net/rpl.h>
>   #include <linux/ioam6.h>
> +#include <linux/ioam6_genl.h>
>   #include <net/ioam6.h>
>   #include <net/dst_metadata.h>
>   
> @@ -954,6 +955,11 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
>   						   + optoff + sizeof(*hdr));
>   
>   		ioam6_fill_trace_data(skb, ns, trace, true);
> +
> +		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)

Hmm, now that I think about this a bit more, I'm not sure we should 
force a node to be the destination in order to send the event. Instead, 
we could just remove the "am I the destination" check and directly call 
ioam6_event(), which does check if there is at least one listener before 
sending the event. I see two reasons for the change: (a) one may want 
(for whatever reason) to capture IOAM traces on transit nodes, or (b) 
one may use inline (instead of encap) IOAM injection where the 
destination may be outside the IOAM domain (i.e., destination != 
decap/egress IOAM node), which is not RFC8200-compliant and requires 
removing the IOAM Option-Type in-flight from the HbH, but that's another 
story.

Any opinion?

> +			ioam6_event(IOAM6_EVENT_TRACE, dev_net(skb->dev),
> +				    GFP_ATOMIC, (void *)trace,
> +				    hdr->opt_len - 2);
>   		break;
>   	default:
>   		break;

