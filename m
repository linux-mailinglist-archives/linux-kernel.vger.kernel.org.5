Return-Path: <linux-kernel+bounces-44096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE32841D42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E61AB1C239D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771A455C2D;
	Tue, 30 Jan 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zkPBm0bH"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4F454736
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602301; cv=none; b=haGu8DfDX9pJ/aJdQkFAo3aYza/hL+yd8wAj8lsL0moXDCLhcHZ4T7SUGZA4em06oFjEmz40pjp7U/xTtRlXHwe1Nm+Twg00Y3Ytd/paHOb8R8v0AUzYk9p0YGC/G/g+B+cGJkyvu5y9FS5wAQOMilL6P71XnEZlpqTVdTzW9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602301; c=relaxed/simple;
	bh=tJcfkRLSec8V90fDBMcC8fu9LjoS7gBQvD2cDv827co=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WMLx94W6UJjFRvbWKqcJEjFUxYVAQWYvYlsI9tLaJ6H4UBh9im2q1zQyf21rHx25Z4RjDMulH2NEqzEPr1+n0ALuz+PZdOfaZhixL+yAHyGwBqyp4sWNRFoByCzoSI44nI87kVivFfRAr/Ooed+nUhybUez/yFVG/w5+p879CLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zkPBm0bH; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-602d22a54caso53284047b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706602299; x=1707207099; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MB0zSqc4v6QJWm2r+bwmMTwgDhYEDBQW95gH3tHtSso=;
        b=zkPBm0bHIAFekSK2nebDKPGlNGrpwG/t87B4Z9sENt7ja5wrRUlJdC1U8SNaPwkEoi
         +/1ml8+NEeKzesTeBTi3tCWwNvQEcnVaW4roaK6akHLX/BGJ8WSV/0UUbDqMZ2Ijd+98
         NAN9L5aec5DETBgu0ucCkRiY03SiosRn9EjY8r+AG/KK39LOgx6iV7gFkv+bYEKPZkd5
         A6dVJkcko2GO4ZWS0v4obSXl52gm6vUtWxX3iGwLBvZAij4aTrgk1U+ouAxYA9XJ0Pas
         bA4ubkNylKA8xDYRzWcs6CM4aFmqvtddHaWYVgAkCUL1ADZGCtFwc2yylkZsdkJFjNHv
         PzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602299; x=1707207099;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MB0zSqc4v6QJWm2r+bwmMTwgDhYEDBQW95gH3tHtSso=;
        b=EEwJ9TiS5POr/3wsFE3V2Ho7a6N7S9yWzlnDB1DhMOgQzb73KQNZ8UTIvXqySSd6y3
         IDzcfV0efcZLVk4bI1X4VCGGy8klhP6gIi0eyBVRvoyzFCfazDpb+YuAnMrt2VyV2FhH
         dZ0fRIsojP5q59tR2RmRXYw1N47PH1K2EsrLFje/bQJk+iwNZxDQp7S6khGo5yX1AqxB
         ZhTPCm3X4vFm1+t+nDMtU/biljdy6cqK7SvqItgVVwGxiCfhiRcL/k/aU8jxp4HnRZ9v
         DMDvYuvWt985mq8icCN7H2Q/mqlfoBv2OcdFbS3De1K0XrtFY8KREzEpZoAruj3rKGJd
         xhtg==
X-Gm-Message-State: AOJu0Yw0gGaFe9nm4OkAKWd/cS07lzjeg/hmaChTpczN0EFNDS2/5Ch+
	Y5Anzno7F9pNOgsyyI0wSXd2+KvtYfmCPm6fK7CohYqjIso8AU8D+QYWQ1CWbeeN7qK7SDjjJas
	BEi2fIJ0pDJEKNfwPbg==
X-Google-Smtp-Source: AGHT+IG0hPSxQYojBv+Xj8kRktpRrQ4U3YvHXIcSLB7tnNj1gmueIH4ClhDGo4I0UT3fna01dETT0yi6RlfT9Weq
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:f91:b0:5ff:80cb:23c7 with SMTP
 id df17-20020a05690c0f9100b005ff80cb23c7mr1764515ywb.1.1706602299330; Tue, 30
 Jan 2024 00:11:39 -0800 (PST)
Date: Tue, 30 Jan 2024 08:11:37 +0000
In-Reply-To: <20240130014208.565554-8-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-8-hannes@cmpxchg.org>
Message-ID: <ZbivOWCrcPb2B81f@google.com>
Subject: Re: [PATCH 07/20] mm: zswap: break out zwap_compress()
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 08:36:43PM -0500, Johannes Weiner wrote:
> zswap_store() is long and mixes work at the zswap layer with work at
> the backend and compression layer. Move compression & backend work to
> zswap_compress(), mirroring zswap_decompress().
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

