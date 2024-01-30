Return-Path: <linux-kernel+bounces-44089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B75841D36
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 431AA28BD35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A655477C;
	Tue, 30 Jan 2024 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uuVC6mQV"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201B54677
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602132; cv=none; b=Bz7cN6QbRc6xIxxWgfULfmuh0i9ZufNJ+urXOMPnyobJm9t3DWsqNzd++sN6gZkUm9DezsR9q6f5YUHRn3SPtBxej8KZr0RG7MdlXV7Ee436EGYkp4/uhmPkfSOkE0z5mqdlWsGTPWI+UGu2899LZt7C17CC7mEwXEm/yV37fQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602132; c=relaxed/simple;
	bh=MsX32WjhNDdW2qr6JOHB9rEwqosyJkstTNFGRZOwOuk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L6BrM0bW0sZDYs/hFOdXINqLWJ2dxAxQNwnvS1zlpiKYtwYO5TY8fAWa1C1v0a+8Euj+pZCkEsG/Zsjgz6gNThcKyVZmHRLjIOpCRBal758n5Rm9bXHMpnDIYx/BqdG/I26PR/xRIb8Wyy7wdVuA1vNwZ2eDU5NcvMRGrGzm4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uuVC6mQV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5fffb2798bfso62548527b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706602129; x=1707206929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4yuy6DXMuQ7aM2x/F8JDP7FABfqZoOLw5CnCxlTpGVA=;
        b=uuVC6mQVagqiaTri0wSyvJLr+suSR3o43FkKQMMxmSqk0S7mmTqKSlFC39M7BBADzX
         ltYBaAzmlEsP6TaPKtm8BRqO0NszUh5xN4C9uNQzpomFGWo7SjxwU7iPOPEl2OiRKznO
         9H+Sb/B1bDTjLQqpKfiHE4jwnc1gQRQLXjXVndZR1BApI/ouEOUuIACnvE5lshY9Sa7C
         WHGT5vxOCtGY9Lx8NAEbAwdL/zb55izpvG7MrMTKuYJDnv2ySCm3tiUrL/CfQ9hnb8m6
         iEonkC2Ek7ncu+tXxqPyZW/dwpE6Jv+N2HySWHjm2hcqHOOVxGCt8a2pS2X7k9eTckO8
         B7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602129; x=1707206929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4yuy6DXMuQ7aM2x/F8JDP7FABfqZoOLw5CnCxlTpGVA=;
        b=fnTCeIybWVkYRspOHdsogwPxf2aUpv8tprTo/6z0aKNpx9VR43avRaTTTDbcv09zuS
         H+LqXwnRVCfBR0a9o8L6qM0sewdrNJZQXtdqeLqgNjod7pFPVaC5siZJJcG0KmMxd45K
         Z8x0muqiYU7mg4o++ndfHHShC2DpGCb6Rq7ILFRKtG8rKyIIHJvly8YLOaaQ47iGdCHg
         ZxCBEkaC8e/SU+vJcq/RZn+n+2DpKLeTZKZk5D9ocDHeHoYEs2JdT3/SV6rDSOLLOBph
         8QwjjrJkKukqy03H2nv3d1K8ckVlJYCOrmGEZzIMi05RSsagLpfXDy/Z5Bd3Uq57omKp
         EEJA==
X-Gm-Message-State: AOJu0Yx60FQJyB/QKWD2+XSX2p+eILgMWyFKGypyE/33OzwYA74Geivh
	sEZIuNzJKRlOHJpT2MVYHaYXyLGV5ORKUD4s6Sffp2lDKS+wY/To8nTK1opFmhdHFOIYD96zRPQ
	taZeXQ1lrkiltbUc+TA==
X-Google-Smtp-Source: AGHT+IHYJh/JZb9tcGVFMyDOwEKQlvsjTsnVcdkiirQ0l/OYkIkLQ0xdTfuKo+pCIIg1GGlzGiCXJcuUxWGhHlNo
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:79d0:0:b0:5ff:aa85:6244 with SMTP
 id u199-20020a8179d0000000b005ffaa856244mr2355603ywc.8.1706602129686; Tue, 30
 Jan 2024 00:08:49 -0800 (PST)
Date: Tue, 30 Jan 2024 08:08:47 +0000
In-Reply-To: <20240130014208.565554-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-2-hannes@cmpxchg.org>
Message-ID: <Zbiuj7qXrKJ2sQhW@google.com>
Subject: Re: [PATCH 01/20] mm: zswap: rename zswap_free_entry to zswap_entry_free
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 08:36:37PM -0500, Johannes Weiner wrote:
> There is a zswap_entry_ namespace with multiple functions already.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks.

