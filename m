Return-Path: <linux-kernel+bounces-30236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C068A831BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EFDB22705
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E631E4AF;
	Thu, 18 Jan 2024 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zubU+iIQ"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF939B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705590336; cv=none; b=kb3PA8mOm/mrjXV8ACopjKplJANRsKFGy4SL4kL+MZmKeNmioomwN8cfOe8hkndwauFmoevtwpy5HbyTU5FEi6Cr7a9QodNQMTtZAeKQgxZe7Xx9nB0IqzixGguQ86lRxpzBjuI+p1fvclE+zJfpwQFYqL8KgcoiPi8yyLZ8s0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705590336; c=relaxed/simple;
	bh=5LIBRqIH9d38AqW642NsUE5T+QZsWHhG1v1PwOLgS+E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Mqq1HtseD0htqiWQ8PDtoa7y/7r4CjVS1WVUJeshBKrBxprndBYD2Ih9kov+6mop0M3h9cmun4i6C0HnJsGQjBoLmoxjYJs+xVhEobIVaNDL8z6lIIblh9OzwNlZc712TxjZ1lBC4Qq7hnuLdQm7ehvSo62Mof2dMSEFlGM+JPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zubU+iIQ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-681397137afso48373066d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1705590333; x=1706195133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai11Ox6ozQ1+i3t6b5EKtUxSZgIrQyAtf+uNDfugNVg=;
        b=zubU+iIQwv0J7O/+W96ledxZsWpeD0tAk5w/kozk+NQReoYVwmgoSR5vV2ZcIGyHJx
         em8Pb4W5klaTCyUu11xj1zzHvFPrJoITkmJ60eX0hjZn/Hg6QnBOPpVJZKBniDz8CDgV
         sk2oipXHTt2eM4yT/oM+lA09EgiXtB/ipwErIcfyheOYIj5HPu0hb/ldT1K1OdV9r6Sy
         bR3wP3tTizA9AjnkkDLZb3tfA6wP61rx0y1uOMJDasuw7f0tCbSauA3wSdYsftnh9Onu
         FvJcRVg18VShBww/w5QhlUs/tcT8x2uFkovXOquBHSw8dfHaHw/JeVHbjUOy3IQPrxYd
         yqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705590333; x=1706195133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai11Ox6ozQ1+i3t6b5EKtUxSZgIrQyAtf+uNDfugNVg=;
        b=N7/oj9rHnpeohEBsSJ51PAWiYMSnD1T+MyUxsxmy9YJSLb46Nm+HpL5OTDgmZtULoV
         2TtErAWaLPjAwIrQydBKAAVWLQcVR3cTVWRH+ZWzolm/veJJse2JM57BdvtaLozOH1Ge
         yGoM9sH5EcBBNyvttGRfwrhfLrzR6piWQXayQ3ZTnkkv5UtI2FsKtGWWIHW2IY2tafFI
         j3OzzNA1mKTl2yELivXL2H2e1Ply1soeHxDSMriVqugIwGyK7cAxWUwOf6M7+NJ0sRig
         wKCHgp9MtMiwtqOPTQ0bTYYyuFsxPtI/cNYUbhOT61VbUDdYF0Op9DnFnnLJCzO2AjF0
         5uGQ==
X-Gm-Message-State: AOJu0YzDH+84vDV+uhvJNy/IdbXXCF6wpkTApmSM5xJlLuhQV+KjtZHE
	I1E5f+xaeGxJpTCr0g/ahVcCI8ZYsh/wXe5dMtxTj0jSiFOg0zl56t/rra/bZ60=
X-Google-Smtp-Source: AGHT+IEgXHf9ivg5U2Ll+f0Jt0MWWJicZa/xCtMMLFINtlzUYMp8gOkic/6xG14X14r1eS4Gmy2cDA==
X-Received: by 2002:a05:6214:21e9:b0:681:8739:9171 with SMTP id p9-20020a05621421e900b0068187399171mr952164qvj.119.1705590332640;
        Thu, 18 Jan 2024 07:05:32 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:c3fe])
        by smtp.gmail.com with ESMTPSA id eb1-20020ad44e41000000b00680cbea3c84sm5968443qvb.84.2024.01.18.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 07:05:32 -0800 (PST)
Date: Thu, 18 Jan 2024 10:05:31 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Chris Li <chriscli@google.com>,
	Nhat Pham <nphamcs@gmail.com>
Subject: Re: [PATCH 1/2] mm/zswap: make sure each swapfile always have zswap
 rb-tree
Message-ID: <20240118150531.GG939255@cmpxchg.org>
References: <20240117-b4-zswap-lock-optimize-v1-0-23f6effe5775@bytedance.com>
 <20240117-b4-zswap-lock-optimize-v1-1-23f6effe5775@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117-b4-zswap-lock-optimize-v1-1-23f6effe5775@bytedance.com>

On Wed, Jan 17, 2024 at 09:23:18AM +0000, Chengming Zhou wrote:
> Not all zswap interfaces can handle the absence of the zswap rb-tree,
> actually only zswap_store() has handled it for now.
> 
> To make things simple, we make sure each swapfile always have the
> zswap rb-tree prepared before being enabled and used. The preparation
> is unlikely to fail in practice, this patch just make it explicit.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

