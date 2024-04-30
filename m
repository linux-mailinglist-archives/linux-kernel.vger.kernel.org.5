Return-Path: <linux-kernel+bounces-164586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D7F8B7FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E464282AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41BEB184119;
	Tue, 30 Apr 2024 18:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQ4lXNZJ"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5DF1802DC;
	Tue, 30 Apr 2024 18:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501705; cv=none; b=Lispi0Pysn6HKbyneGinUxHD+fh7Nufjk4HKrJibjIJhYIkIotE77gRR9KB7c4dvKoF7SE14AnaRfkzbyHESVo5o1O78by2H2zwXUpHhut7pG+bH1HCBM8H7Gw7VtBHUWzWHOEuBF7Kwp3rK1pvQXTaxIJMEv5HWU32x+9Si7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501705; c=relaxed/simple;
	bh=AW17A+h4KjvpbbCYIE+0urWRTSmhSmb5SsQRXmHqFgs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=juMINHhuSr/BLvqQi9Q3ttdHLPjWm6+fbu5NHkt7noTj03rzgqm2JZxhPYVezaixEpFQO0t1kO0lOP4oHBlQ+6tADjGFfJgOKEMKnh+ZF1Ckw1CoGQkQUmlRq/pRtrCmvvAyxdYnKJyS3DGziWiinfxJ4CeoDn0Y5PLYbXTF3eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQ4lXNZJ; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de603e3072dso2347998276.1;
        Tue, 30 Apr 2024 11:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714501703; x=1715106503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukSR01B6XHaydvig1H25OOfxP0s6MMwbPOuSEjlNNCA=;
        b=KQ4lXNZJS8lJ16ZqCGsE9DzHfpDx1wWVJopBOPqqPYh52f6z8JVjLT3bfBEmO44m5n
         PxKF8QiLiqTsvDBqGEfl2S09aR5jOSvHsXI2q3v2q15k/Ca0NHJGF+Oygf+fWoY7+ERp
         b9Uv1E6d4Ll/EHXGtBG2WDBMrqZq9oC7ZYIY8knhEI19LsWqhnyoNMmAz56y3mU8nscr
         N3GsI/IlBt+lPKVBTZYi56GPEFw7yyUOPBH36887D1Eh0UUI7Ft7jLHlcNXNVgUPbf2k
         N/Xmg2Bmg/A+G+I/SivpaXLMAcq+HyjvnztUHBvYAU7ez/0d/WQPVfFAYjDX+HLv4gmb
         mG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714501703; x=1715106503;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ukSR01B6XHaydvig1H25OOfxP0s6MMwbPOuSEjlNNCA=;
        b=D85BRcKzVm1YyiH9zeTDHyd7RzMtJu+2acMHi48sqtMjV+QgaLBsDT+jfJfMnR1ZoI
         2GqOqSPpDSJWy9X9eDrT6pIJfrfJdRLhIRWxtalvwTXL+HmfvVjBm8gXAnNntKzuM2WP
         wJ1Oz7Vobzn5B8+TcMJpntT/1yOa3E70J6tV747L6CY1yVodq3DDtFeWTG6MvfK/zoom
         4M0wFh8Wsu51EylxleUvhByCm0n7ui4WcSEqe4ql4JtxpQVUVX/nPxUj7ceLJtq0aZZ1
         uJxoufAMtAwR6dF594U+t6+A+k0lSRBXeaWkqCFjjQSYpX0TpQrSZtNDGtv3rRoTgGgH
         ewOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhkCw10y2gNfuWmU6/GVgcgfhRJnFYGqGEli6q7yk/rIiTZQiSIX8qdyOE3urim/zUuagz1codYPUDTCiQnzIN8tUaFbizDmTUFtterGDk/hqnummYH0ERhLs3R6drAmuzS86D
X-Gm-Message-State: AOJu0YzGhx+QPIvqhqIFa6dfMv+CF5W0VqEZ9VqPiv9pXe5mxIC90syO
	JbL+I/9gquz95Q4UST9UIRzXhHGRtuC1xpybG5B0/Silel7Plo9t
X-Google-Smtp-Source: AGHT+IHHMEbX5CZv/m4nrho41MGfMQd8+d+S5+JBoLFiRfhk0pgwasJycIaKPC1MZpGWeiAd0QZ9QA==
X-Received: by 2002:a25:8389:0:b0:de6:723:3035 with SMTP id t9-20020a258389000000b00de607233035mr447063ybk.13.1714501702852;
        Tue, 30 Apr 2024 11:28:22 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id l6-20020ac87246000000b004369f4d31f2sm11643158qtp.50.2024.04.30.11.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:28:22 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:28:22 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Richard Gobert <richardbgobert@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 alobakin@pm.me, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Message-ID: <663138462a32e_32e7ba29458@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240430143555.126083-2-richardbgobert@gmail.com>
References: <20240430143555.126083-1-richardbgobert@gmail.com>
 <20240430143555.126083-2-richardbgobert@gmail.com>
Subject: Re: [PATCH net v4 1/2] net: gro: fix udp bad offset in socket lookup
 by adding {inner_}network_offset to napi_gro_cb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Richard Gobert wrote:
> Commits a602456 ("udp: Add GRO functions to UDP socket") and 57c67ff ("udp:
> additional GRO support") introduce incorrect usage of {ip,ipv6}_hdr in the
> complete phase of gro. The functions always return skb->network_header,
> which in the case of encapsulated packets at the gro complete phase, is
> always set to the innermost L3 of the packet. That means that calling
> {ip,ipv6}_hdr for skbs which completed the GRO receive phase (both in
> gro_list and *_gro_complete) when parsing an encapsulated packet's _outer_
> L3/L4 may return an unexpected value.
> 
> This incorrect usage leads to a bug in GRO's UDP socket lookup.
> udp{4,6}_lib_lookup_skb functions use ip_hdr/ipv6_hdr respectively. These
> *_hdr functions return network_header which will point to the innermost L3,
> resulting in the wrong offset being used in __udp{4,6}_lib_lookup with
> encapsulated packets.
> 
> This patch adds network_offset and inner_network_offset to napi_gro_cb, and
> makes sure both are set correctly.
> 
> To fix the issue, network_offsets union is used inside napi_gro_cb, in
> which both the outer and the inner network offsets are saved.
> 
> Reproduction example:
> 
> Endpoint configuration example (fou + local address bind)
> 
>     # ip fou add port 6666 ipproto 4
>     # ip link add name tun1 type ipip remote 2.2.2.1 local 2.2.2.2 encap fou encap-dport 5555 encap-sport 6666 mode ipip
>     # ip link set tun1 up
>     # ip a add 1.1.1.2/24 dev tun1
> 
> Netperf TCP_STREAM result on net-next before patch is applied:
> 
> net-next main, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
> 
>     131072  16384  16384    5.28        2.37
> 
> net-next main, GRO disabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
> 
>     131072  16384  16384    5.01     2745.06
> 
> patch applied, GRO enabled:
>     $ netperf -H 1.1.1.2 -t TCP_STREAM -l 5
>     Recv   Send    Send
>     Socket Socket  Message  Elapsed
>     Size   Size    Size     Time     Throughput
>     bytes  bytes   bytes    secs.    10^6bits/sec
> 
>     131072  16384  16384    5.01     2877.38
> 
> Fixes: 57c67ff4bd92 ("udp: additional GRO support")
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

