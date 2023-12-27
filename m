Return-Path: <linux-kernel+bounces-11813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 412CE81EBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DCD283488
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8B13D69;
	Wed, 27 Dec 2023 04:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bRWChaRh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F313C16
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 04:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703649831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYnbMfr6YIqES14uXvQ/ldz8qMPfpB6A/e3ZgdEIsFI=;
	b=bRWChaRhCoxDK3a1bYkNAmsX5yBprNKwiOlzSYnV5u12Qf6jRCOBgcT5arL+l9e8CxjfP/
	1c1GvAJlfsaoWopux1K01D+wHNeAhMPFJ13DuYvQNXltjGNoldwdRzYNvN0RgsJom5nmX0
	27elFPnmalnq2omuC0y09nk4YAyQckY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-lr9QW5BOPYiQ7Cg4LLb3NQ-1; Tue, 26 Dec 2023 23:03:49 -0500
X-MC-Unique: lr9QW5BOPYiQ7Cg4LLb3NQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-20418404dc6so7826619fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 20:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703649829; x=1704254629;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DYnbMfr6YIqES14uXvQ/ldz8qMPfpB6A/e3ZgdEIsFI=;
        b=J3bFuq9oVNNzmxnLLRxsALgTU7BFgIGuiAtrhkNpuXxuYO1CRXhdrytgnWLovc5JqG
         NUiW+5trJr/SwU1eUYBVJ3mxhQTxiGUeg0v59DilBfWwFljbUi+BDFF0+ifCoLyEsTum
         9HQkONxlwsTTLf1JLQKxpq6ibnbXENoaifuzO+Idx2V8LIiEF9tY9npNUSknZWXqo0uq
         KgCve3yKxRgWfhTD0z/xQcFM+CcMm2Jv8raOVSCzaHP3H3xvALPyWzEJ5R0fUnlMigtW
         jP+mytuYR6qiYBcvffEiJWSM1uxLWr59+DQ80EpY+I41w6hraPOVM5b6b8vugQteoMCU
         +4Pw==
X-Gm-Message-State: AOJu0YxJJcyhMiGlwbCmNo50yAe3DGOuTHH23SSikLTbOj8uHMsk4HjA
	sNXkl3ZKYLEjC7VEOGzVm/qpAGhOeqk3kTmD/EU95sdlw5+4g7NDYeFUAK8Io7IUJau6KbRWTNV
	6KRD5NZfjA1m48AvOyo4BhTzkpr8dWj75
X-Received: by 2002:a05:6870:15c2:b0:203:e8e:b384 with SMTP id k2-20020a05687015c200b002030e8eb384mr9426558oad.85.1703649828784;
        Tue, 26 Dec 2023 20:03:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/hVWKYtpZpePv2eJ0Sb9VQ6qgeZc7WsAMDw91Zve0Bn53uUZnV9VO8T1gC0+TBrNy1CxwjA==
X-Received: by 2002:a05:6870:15c2:b0:203:e8e:b384 with SMTP id k2-20020a05687015c200b002030e8eb384mr9426544oad.85.1703649828536;
        Tue, 26 Dec 2023 20:03:48 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:ad0f:51ab:624e:a513])
        by smtp.gmail.com with ESMTPSA id a18-20020aa78e92000000b006d9beb968c3sm3746568pfr.106.2023.12.26.20.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 20:03:48 -0800 (PST)
Date: Wed, 27 Dec 2023 13:03:42 +0900 (JST)
Message-Id: <20231227.130342.618032792909202594.syoshida@redhat.com>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net, dhowells@redhat.com, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg/hash: Fix uninit-value access in
 af_alg_free_sg()
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <ZYUFs1MumRFf3mnv@gondor.apana.org.au>
References: <20231211135949.689204-1-syoshida@redhat.com>
	<ZYUFs1MumRFf3mnv@gondor.apana.org.au>
X-Mailer: Mew version 6.9 on Emacs 29.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 11:42:43 +0800, Herbert Xu wrote:
> On Mon, Dec 11, 2023 at 10:59:49PM +0900, Shigeru Yoshida wrote:
>>
>> Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")
> 
> I think it should actually be
> 
> 	b6d972f6898308fbe7e693bf8d44ebfdb1cd2dc4
> 	crypto: af_alg/hash: Fix recvmsg() after sendmsg(MSG_MORE)
> 
> Anyway, I think we should fix it by adding a new goto label that
> does not free the SG list:
> 
> unlock_free:
> 	af_alg_free_sg(&ctx->sgl);
> <--- Add new label here
> 	hash_free_result(sk, ctx);
> 	ctx->more = false;
> 	goto unlock;

Thanks for the feedback, and sorry for the late response.

I'll check the code again, and send v2 patch.

Thanks,
Shigeru

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
> 


