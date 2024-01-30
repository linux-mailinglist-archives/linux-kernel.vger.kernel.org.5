Return-Path: <linux-kernel+bounces-44092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C89841D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 212701C259FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC0158205;
	Tue, 30 Jan 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c8jAd+5C"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842FA58105
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602212; cv=none; b=ett0iT4NIEdRvydYNDowq4zR7NTwGfxTosUMxNy22XOhFcusLas8Yi9+PzprGmyUCLeVJVhzr3nsVJoH0PzH3e4UAc6OW3QcbZE34Ji151XolQfFUxGnSPUs6IzVj7ryDjRyfjU9O+Jrrf2ku2tNTp2fCmfOiUAS14HWoA0SdmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602212; c=relaxed/simple;
	bh=ytVBhqmqpPefNWrNQw7WFVCn7POXZJQaXF/swp/OGCk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gQo4eiqJAqM2VpnFb3Nij4J4QxXktvMgcel31k1wEmHmnHPvlsQZx4hC2LCSg52xIivbqmQYgtRVX68Du+sqcoepRwOOvVKEhL6/h0iB0oX2BGw55bD5R3VRUzRloYubUqd2s5Gu3S1JfPVul6rMpwPPfULJopPq5ToImdj3Xtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c8jAd+5C; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ff817c96a5so65843177b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706602210; x=1707207010; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wC5dkC6Jq7B6DAe1rPPi3X80tYoDo3ynjpR7BnHrH24=;
        b=c8jAd+5CnxFByMIwmm5nGGwmGTYTf3ty+s4vubW5k9KJiaDbc0BMXLsRPMgciTJedD
         W4Gok1PIhS1rUVmMyyaKwYJ/TCJsSm1qHYHFu1b1YxdoWi2RTzqrZ0IOjlAFgCYUqfIy
         y1EZsWT6dmR7VLoK+ba+dVbQPeNM2R8fJgr5r5BNZOUOJ/qh4g6ShnhSvOt1jpo/3kB0
         ndoe/L0XHIVBAZN2HcNR5A2CwuI8j3xUo2O8/RfwE3nkpXCUYeZd4G1PPev5zbIO2Lcz
         txuJz+Z6riXlKIsRze06nTivJSYj920f2Am5rx82eBRJ8cPeS2htmnjIDUAzLatwjYKu
         UAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602210; x=1707207010;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wC5dkC6Jq7B6DAe1rPPi3X80tYoDo3ynjpR7BnHrH24=;
        b=NoTdzFdUZk7M/Ri+7QFl8X9LMQIE+XVQ9IGrCd9PcW6x2oh78JTlQEeYqcY6iEtoWG
         dYagvgz3+PFV73j5Vyo6Xn4x6ZOkppFlVuu8rMBCrlSkG794BJWg+mhxGwp9bkDmW42m
         DYaDfW+mseNmEDASuJWqyVFGjK0nbv2EzsxWOd3xohbsFaPDRmiNXj8wRJtaXc+fG+kO
         ON1tACKN8vCuBjZByrcOX3YBq8CuShSeVI4Dvpho0xnRnViedjfoU8eAe9UDaji3GIWQ
         Hjja1/grPauDfI12+cQgerURR6Ev7TJm7jjTh7Vy8i1oi8fj1Sh1g2fNCeuK5l9Jhyez
         RwOg==
X-Gm-Message-State: AOJu0YzdxnkC4FdAZfM9cxXVmj6JuzB+nUkF7ldRLk2um726lEjSBfuQ
	i03AZdX/aziUzkDFrd+xAN5OTBghsT0xzsTQacdaU0wdLfA5TTNKYP5/YgxITbMMbaRtl0rrhiO
	Rjz+44TfQxKEX5HfAvg==
X-Google-Smtp-Source: AGHT+IEGENChTUCRnKZVFWxFOS4pHUFu6+Rg66aYoZaZvwtob0PAsFmEE7KfWXugj4uae0G0k4NzpIyId6wV2yjo
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:4c03:0:b0:5fb:7e5b:b87f with SMTP
 id z3-20020a814c03000000b005fb7e5bb87fmr2437055ywa.1.1706602210387; Tue, 30
 Jan 2024 00:10:10 -0800 (PST)
Date: Tue, 30 Jan 2024 08:10:08 +0000
In-Reply-To: <20240130014208.565554-5-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-5-hannes@cmpxchg.org>
Message-ID: <Zbiu4O1bn7v13v4w@google.com>
Subject: Re: [PATCH 04/20] mm: zswap: warn when referencing a dead entry
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 08:36:40PM -0500, Johannes Weiner wrote:
> Put a standard sanity check on zswap_entry_get() for UAF scenario.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

