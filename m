Return-Path: <linux-kernel+bounces-111073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E13886795
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC8F1F2496B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06959134C8;
	Fri, 22 Mar 2024 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q6R43q+9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T2JSS0Xs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q6R43q+9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T2JSS0Xs"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400BA10A3E;
	Fri, 22 Mar 2024 07:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093318; cv=none; b=Hk4SMVnZ46u/XJy8R8zbzb9B4WbefIDh5RYZIRZOdEjRdYCdF+iJkwI97tSfZDowONDsdsWyuvOe5rF4/ZTD6SYeC7Px/ugYM5Pego50xo9wF7o+ACfTqkwUmHkV4RqWagdO5JZwiGW33TydALo+TYctTTu5qIkNjxul6DH3lIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093318; c=relaxed/simple;
	bh=dKrafs6XcwNUasz4rY+rfSh1ClLebRTPfnGFP4kCwrA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KESNuuMpT5nxFxA4zJVfJEMSXuLplMhxS9cV4B3M+rl1CwMqcGuHtnuGcj1RzYuHnKBh5Zf0L37+gMOBHHDW+yqpuOVYTgF4FyvCwZC9aH01SZau+e2VxvJ5k/etZ6BCPYJSa9kpaFGwGbRs3RyHvfUis2cVj+M1jdoe3n8hE4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q6R43q+9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T2JSS0Xs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q6R43q+9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T2JSS0Xs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 330C15FAE1;
	Fri, 22 Mar 2024 07:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711093314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Qg0aAz2t8fhysVs3lIOlEc9pSaxXny4Ew84jrO9zds=;
	b=Q6R43q+9lo9fC/D7JRizMmYMGnfekrbVYSVetQxKgeaLVMACKjEei5SrPRKo+TDXPO5cFt
	3nVausOo/49km9AgeU4B8zCvCutEpoBSygMB3g6lkonZ+spIc6MpoEDAKdPCQSTJXmZLyh
	kCU0XMUxSyBTlj2W3ywfCGTd2fX/hgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711093314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Qg0aAz2t8fhysVs3lIOlEc9pSaxXny4Ew84jrO9zds=;
	b=T2JSS0Xs6L8K3uhXYGVrvzd7lmqxE3EWX+XOBbMKaVERPxT6+s9LIPK8f//p9zhI4HKsSt
	edFe+4QT8x3D84BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711093314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Qg0aAz2t8fhysVs3lIOlEc9pSaxXny4Ew84jrO9zds=;
	b=Q6R43q+9lo9fC/D7JRizMmYMGnfekrbVYSVetQxKgeaLVMACKjEei5SrPRKo+TDXPO5cFt
	3nVausOo/49km9AgeU4B8zCvCutEpoBSygMB3g6lkonZ+spIc6MpoEDAKdPCQSTJXmZLyh
	kCU0XMUxSyBTlj2W3ywfCGTd2fX/hgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711093314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Qg0aAz2t8fhysVs3lIOlEc9pSaxXny4Ew84jrO9zds=;
	b=T2JSS0Xs6L8K3uhXYGVrvzd7lmqxE3EWX+XOBbMKaVERPxT6+s9LIPK8f//p9zhI4HKsSt
	edFe+4QT8x3D84BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41575136AD;
	Fri, 22 Mar 2024 07:41:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SW2UDEE2/WXaIQAAD6G6ig
	(envelope-from <dkirjanov@suse.de>); Fri, 22 Mar 2024 07:41:53 +0000
Message-ID: <b26ec3b4-474a-434a-940b-4b8d1317286f@suse.de>
Date: Fri, 22 Mar 2024 10:41:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net/ipv4: add tracepoint for icmp_send
Content-Language: en-US
To: xu.xin16@zte.com.cn, edumazet@google.com, davem@davemloft.net
Cc: rostedt@goodmis.org, mhiramat@kernel.org, dsahern@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org,
 yang.yang29@zte.com.cn, he.peilin@zte.com.cn, liu.chun2@zte.com.cn,
 jiang.xuexin@zte.com.cn, zhang.yunkai@zte.com.cn
References: <202403211010443485000@zte.com.cn>
From: Denis Kirjanov <dkirjanov@suse.de>
In-Reply-To: <202403211010443485000@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Q6R43q+9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T2JSS0Xs
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -6.50
X-Rspamd-Queue-Id: 330C15FAE1
X-Spam-Flag: NO



On 3/21/24 05:10, xu.xin16@zte.com.cn wrote:
> From: he peilin <he.peilin@zte.com.cn>
> 
> Introduce a tracepoint for icmp_send, which can help users to get more
> detail information conveniently when icmp abnormal events happen.
> 
> 1. Giving an usecase example:
> =============================
> When an application experiences packet loss due to an unreachable UDP
> destination port, the kernel will send an exception message through the
> icmp_send function. By adding a trace point for icmp_send, developers or
> system administrators can obtain detailed information about the UDP
> packet loss, including the type, code, source address, destination address,
> source port, and destination port. This facilitates the trouble-shooting
> of UDP packet loss issues especially for those network-service
> applications.
> 
> 2. Operation Instructions:
> ==========================
> Switch to the tracing directory.
>         cd /sys/kernel/tracing
> Filter for destination port unreachable.
>         echo "type==3 && code==3" > events/icmp/icmp_send/filter
> Enable trace event.
>         echo 1 > events/icmp/icmp_send/enable
> 
> 3. Result View:
> ================
>  udp_client_erro-11370   [002] ...s.12   124.728002:
>  icmp_send: icmp_send: type=3, code=3.
>  From 127.0.0.1:41895 to 127.0.0.1:6666 ulen=23
>  skbaddr=00000000589b167a
> 
> Changelog
> ---------
> v2->v3:
> Some fixes according to
> https://lore.kernel.org/all/20240319102549.7f7f6f53@gandalf.local.home/
> 1. Change the tracking directory to/sys/kernel/tracking.
> 2. Adjust the layout of the TP-STRUCT_entry parameter structure.
> 
> v1->v2:
> Some fixes according to
> https://lore.kernel.org/all/CANn89iL-y9e_VFpdw=sZtRnKRu_tnUwqHuFQTJvJsv-nz1xPDw@mail.gmail.com/
> 1. adjust the trace_icmp_send() to more protocols than UDP.
> 2. move the calling of trace_icmp_send after sanity checks
> in __icmp_send().

You should target it for net-next

> 
> Signed-off-by: Peilin He<he.peilin@zte.com.cn>
> Reviewed-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Liu Chun <liu.chun2@zte.com.cn>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> ---
>  include/trace/events/icmp.h | 64 +++++++++++++++++++++++++++++++++++++
>  net/ipv4/icmp.c             |  4 +++
>  2 files changed, 68 insertions(+)
>  create mode 100644 include/trace/events/icmp.h
> 
> diff --git a/include/trace/events/icmp.h b/include/trace/events/icmp.h
> new file mode 100644
> index 000000000000..2098d4b1b12e
> --- /dev/null
> +++ b/include/trace/events/icmp.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM icmp
> +
> +#if !defined(_TRACE_ICMP_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_ICMP_H
> +
> +#include <linux/icmp.h>
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(icmp_send,
> +
> +		TP_PROTO(const struct sk_buff *skb, int type, int code),
> +
> +		TP_ARGS(skb, type, code),
> +
> +		TP_STRUCT__entry(
> +			__field(const void *, skbaddr)
> +			__field(int, type)
> +			__field(int, code)
> +			__array(__u8, saddr, 4)
> +			__array(__u8, daddr, 4)
> +			__field(__u16, sport)
> +			__field(__u16, dport)
> +			__field(unsigned short, ulen)
> +		),
> +
> +		TP_fast_assign(
> +			struct iphdr *iph = ip_hdr(skb);
> +			int proto_4 = iph->protocol;
> +			__be32 *p32;
> +
> +			__entry->skbaddr = skb;
> +			__entry->type = type;
> +			__entry->code = code;
> +
> +			if (proto_4 == IPPROTO_UDP) {
> +				struct udphdr *uh = udp_hdr(skb);
> +				__entry->sport = ntohs(uh->source);
> +				__entry->dport = ntohs(uh->dest);
> +				__entry->ulen = ntohs(uh->len);
> +			} else {
> +				__entry->sport = 0;
> +				__entry->dport = 0;
> +				__entry->ulen = 0;
> +			}
> +
> +			p32 = (__be32 *) __entry->saddr;
> +			*p32 = iph->saddr;
> +
> +			p32 = (__be32 *) __entry->daddr;
> +			*p32 = iph->daddr;
> +		),
> +
> +		TP_printk("icmp_send: type=%d, code=%d. From %pI4:%u to %pI4:%u ulen=%d skbaddr=%p",
> +			__entry->type, __entry->code,
> +			__entry->saddr, __entry->sport, __entry->daddr,
> +			__entry->dport, __entry->ulen, __entry->skbaddr)
> +);
> +
> +#endif /* _TRACE_ICMP_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> \ No newline at end of file
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index e63a3bf99617..21fb41257fe9 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -92,6 +92,8 @@
>  #include <net/inet_common.h>
>  #include <net/ip_fib.h>
>  #include <net/l3mdev.h>
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/icmp.h>
>  
>  /*
>   *	Build xmit assembly blocks
> @@ -672,6 +674,8 @@ void __icmp_send(struct sk_buff *skb_in, int type, int code, __be32 info,
>  		}
>  	}
>  
> +	trace_icmp_send(skb_in, type, code);
> +
>  	/* Needed by both icmp_global_allow and icmp_xmit_lock */
>  	local_bh_disable();
>  

