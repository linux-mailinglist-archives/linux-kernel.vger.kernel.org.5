Return-Path: <linux-kernel+bounces-157942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A18B1908
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CBD01F23D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E7F17577;
	Thu, 25 Apr 2024 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcwAkWIN"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF468468;
	Thu, 25 Apr 2024 02:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714013158; cv=none; b=QdikoU2m4bo6HCnJmVH/JdSFCt9U/W2Pzd3Mm/xc6XmgIUTHhFbjF1xFht6XT45aXy3kwGPoNzBl9v+itvNCtNuIvwh1HrMJBuNaCImmyXQ4FjYmwpch5If0eCvfEBxqANK8vMBYEMAEx9kQUVVBqFJ+sjkN2ShdcncISXR8uIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714013158; c=relaxed/simple;
	bh=tGGzkvse5x7QzpyTc6QqCgkRyQpmieuDkIm9c+52WGA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bd8jWL0BYDjmbxBH9laEnfnOPjZcNfoLzc62Aph8u4DCnG3i87yR69AXXaogbHtT2TbPcOX0xDPCETT08boOKx/E8/1kdXrD4u9Gl07APaB1C/nrddj2iDoq+TpgFAVt6WrLCJbwj2Tg7nNLo0yV022UR5q1Ka/mr3goPQqyS7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcwAkWIN; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69cb4a046dfso3561366d6.2;
        Wed, 24 Apr 2024 19:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714013156; x=1714617956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALmoHECddjt6N6MxgyKV+Irxijyc9f0ExErYPuzOQes=;
        b=TcwAkWINYWzFGhuaM4kZHS1uiw2P0OagfDW0b33DvR3xNbuuq2aTwaJk76u+nF4Sj4
         rLomjQCdxn0wncHeMwq2U4nTQgjVbHez0syiEcUuJpTA9zaPF4RyK4DFN3RNO1IC+9xY
         wkFXXzgmQZDAJn2AXfE4VY9MQX6h+u3RWBci7mCRJUnfwNfbpvN131T4IwCiutPpj1l0
         Ab0IjaLj7VE5sglyeWpyJHsT3qtpGWVOuPQMuQwJzPy9J1xEyoU7K05IsxabzRfyYM8z
         E80DIieqp5eMjWjtx8i6rJ9sxCjyf0KLxhAUlRU2trKDGQWViDaxwHCI42Z0Yl669z2R
         r6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714013156; x=1714617956;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ALmoHECddjt6N6MxgyKV+Irxijyc9f0ExErYPuzOQes=;
        b=i0nx5gUehNQooKQ8FWdYKgklvL/idJzMqTIUpkKKyGzP/9zd9mIHp7wYRvejkUTb/F
         T48soW/vVvr8rLq66aCAv8fweR9THXS4BH8mpVIJUk8QuX85f7P+NwgXT/aCNINKSxCo
         0cnAq6AWsRdx60N5ApYoAhPv2fCSFUlIA0DlVqRC1GR0jAdVGXC1gZ3Q4raoiggoX2hr
         L3+3bnmaiIwUh8MhUrA45eSRNIZEyVfOVuk1AcxMFKAv9PGRfXjkntthrv7jpCsph3Tz
         sxinu2ZFssZKe3Z6v4VRULRfWU+XLqhSCDpZLnrzlUlz5ate3cvGeEmFcYdTIwstNBai
         Sn9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb/AJiiNdEBlwI0yGYTaCtQ8yhpo1GgLgVPA6CojYJT40zK36qaJw0qk//tBOoxlne/ci8jZyYowxA/kj8Pd4BzRr+MQlTL2GRFAImgP1Pbg25vgYK/8eJBol/mdr+KO838/jw
X-Gm-Message-State: AOJu0YzKMPHR4tiGAIBSzY2zE2htv/q5b86wG7y5sjkETplmjm5SBRSw
	jBEGGvUfLhKSoOtE0KS6l3aFTbmNVyNFhd7rpxZZxFMs7UtbVYzP
X-Google-Smtp-Source: AGHT+IGV+v8fJdDcDneYeqPuZy464RHuSwbcAf86EK0M4ZCnTxYlKeON3ftu2qt9Z3vEFAMw+r4+/Q==
X-Received: by 2002:a0c:cc86:0:b0:69b:20c6:a3f1 with SMTP id f6-20020a0ccc86000000b0069b20c6a3f1mr4870918qvl.53.1714013156185;
        Wed, 24 Apr 2024 19:45:56 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id j13-20020a0cf30d000000b0069b584cd2dbsm6593546qvl.5.2024.04.24.19.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 19:45:55 -0700 (PDT)
Date: Wed, 24 Apr 2024 22:45:55 -0400
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
Message-ID: <6629c3e399f65_1bd6b029423@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240424163045.123528-3-richardbgobert@gmail.com>
References: <20240424163045.123528-1-richardbgobert@gmail.com>
 <20240424163045.123528-3-richardbgobert@gmail.com>
Subject: Re: [PATCH net v3 2/2] net: gro: add flush check in
 udp_gro_receive_segment
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
> GRO-GSO path is supposed to be transparent and as such L3 flush checks are
> relevant to all UDP flows merging in GRO. This patch uses the same logic
> and code from tcp_gro_receive, terminating merge if flush is non zero.
> 
> Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")

Should this be

Fixes: e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")

>  net/ipv4/udp_offload.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index fd29d21d579c..8721fe5beca2 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -471,6 +471,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
>  	struct sk_buff *p;
>  	unsigned int ulen;
>  	int ret = 0;
> +	int flush;
>  
>  	/* requires non zero csum, for symmetry with GSO */
>  	if (!uh->check) {
> @@ -504,13 +505,22 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
>  			return p;
>  		}
>  
> +		flush = NAPI_GRO_CB(p)->flush;
> +
> +		if (NAPI_GRO_CB(p)->flush_id != 1 ||
> +		    NAPI_GRO_CB(p)->count != 1 ||
> +		    !NAPI_GRO_CB(p)->is_atomic)
> +			flush |= NAPI_GRO_CB(p)->flush_id;
> +		else
> +			NAPI_GRO_CB(p)->is_atomic = false;
> +
>  		/* Terminate the flow on len mismatch or if it grow "too much".
>  		 * Under small packet flood GRO count could elsewhere grow a lot
>  		 * leading to excessive truesize values.
>  		 * On len mismatch merge the first packet shorter than gso_size,
>  		 * otherwise complete the GRO packet.
>  		 */
> -		if (ulen > ntohs(uh2->len)) {
> +		if (ulen > ntohs(uh2->len) || flush) {
>  			pp = p;

I suppose this branch already could immediately return p. And avoid
a level of indentation below. But agreed to not change that in this
bug fix.

