Return-Path: <linux-kernel+bounces-164591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E4A8B7FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:33:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53BF1C23454
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4388B19068E;
	Tue, 30 Apr 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bd+VB3Ak"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B83D3611D;
	Tue, 30 Apr 2024 18:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714501978; cv=none; b=cQOfEcrcnv2IwzDJJnNw2Eu7jHdvmwsZ0O/0MIL0v6AJYmsXiHLaayiQ8PPup31J6gz3VH6WL4Zl5j5QSYKiOf4O5LefcS3rYdFbWuP1nRk6KKkVWjBE2s0zy0x8if2CKbDxTp+dOvaOPbqi16qFrop6/DeFbKjze1NoZJ4yu/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714501978; c=relaxed/simple;
	bh=CQprubpB8YMHv2XCb19xqFCKvkLYHG2uyxu3LDv3wsc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Q8IZwn+cX3twoC5uYhMFANr+Je03gQqk5puDo3P/zX4szQqfIk1zo2177MJUkE13f0Y91sQGwASVjRugiGi7I07jeF70+CppsgI6MH3UThALi9XBTCLinBP1Kj1zzMsxcidZmOyv3ysWaBY5LjsbPYNfGxDsj8ZuWFMULX1odDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bd+VB3Ak; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ee4162061fso1105771a34.1;
        Tue, 30 Apr 2024 11:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714501976; x=1715106776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV7zk+wo5XdD6RHY7NZuGP7XMhfV5bcA88HKAcpktm8=;
        b=bd+VB3Ak5rXP2/oQU7/Ofa/M2WnOOwMriA+hONwUi8y3idpu8yyczwxGSn96WWO1Q0
         dMOkE/UFcgfAnQa4crU+kwkCYLqXcK/mxLCodmodSZ+xrabNdPZ39bawyXiDlM+JoEvg
         OAhV6yJk2NH9ze4FQDWA8CA4ZxzbVlr0bkK2LL8PCV5QUWE+8HMoMnhKYeUHHxEEt8Lj
         tYFHq3YuRlFkvVvzxItAQ3KcIPpXthQh9RUpay3jxwY+d6u4GjLR2hCDkPpqP323gfnT
         Lw/zWlYfJm0oiLM5i1bKsDgqeM2B8tqZG+o93uE/n9xoXbmsfbe9GnRzMyDDAu5hFnkS
         DJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714501976; x=1715106776;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xV7zk+wo5XdD6RHY7NZuGP7XMhfV5bcA88HKAcpktm8=;
        b=Zt9DB8YzNDAXRO5a1B2AjZn9fBDxa6T70FwbAOOoVdMraVSJ58pIrrAI4Ra6fkD3Fg
         5fvgFww8yIXD8boa4HHaLcw52Ke3EenW7CYnymtTeSmaA7m/qrUVM9p2/gOvMlrkeDIj
         vzbu8rxPrk06Q/W+Gvlzw8MjHNGAT1CEnaUCqEGc1HTEaNMiHKO6WpXi20yIt9kChE15
         8vGdyIoQmAMm6ZHXsb7x7qnkNCd1niYOaNXsDmCNr+03iewCsOqd5FkY+HGXt34W5Xik
         p3hSX4ff76z5RYWoX2gsxpsXpMw8WYU+3wgz8+ioB7aEh/Li/WBqTWYiHQ+txUlTpLGD
         CQxg==
X-Forwarded-Encrypted: i=1; AJvYcCVkd0rD4fpn6kozaFQ7EMstp7LYRjyDHiZqH/FoTtj8U+YLvzPXKOPQh2qUbcU14DIhADm7N7R3oacojto4WChIxLFNdeFLWHBEnNmpVbSkv+2luGC6y3tGsRHESKkJr30xTxCe
X-Gm-Message-State: AOJu0YzGSOFMLe0Drx+StJpX3EYs0d991EzDZWSTta3qca5IUmH6ABPr
	0uh8eigGF7iTZ2A3VVHBpgcD631IPYY4omGgosFwlMdZ0cjZiSTzaUU++A==
X-Google-Smtp-Source: AGHT+IEjLk0SXti2ttFvB6m1CtczScYTQcqB4YELArlFTfgvA+mtXr+a8fheoqQ1WO2EBJ+ARX5f0g==
X-Received: by 2002:a05:6830:22c7:b0:6ee:29d3:81bc with SMTP id q7-20020a05683022c700b006ee29d381bcmr362547otc.2.1714501976081;
        Tue, 30 Apr 2024 11:32:56 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id y16-20020a37e310000000b0078d5fdc929fsm11604498qki.104.2024.04.30.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:32:55 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:32:55 -0400
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
Message-ID: <663139575e4d7_32e7ba29446@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240430143555.126083-3-richardbgobert@gmail.com>
References: <20240430143555.126083-1-richardbgobert@gmail.com>
 <20240430143555.126083-3-richardbgobert@gmail.com>
Subject: Re: [PATCH net v4 2/2] net: gro: add flush check in
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
> Fixes: e20cf8d3f1f7 ("udp: implement GRO for plain UDP sockets.")
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

