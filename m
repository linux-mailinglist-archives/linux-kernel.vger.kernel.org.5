Return-Path: <linux-kernel+bounces-38738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E2783C513
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08E66B233D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC546E2C8;
	Thu, 25 Jan 2024 14:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Z6GSwCb6"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D6B46BF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193950; cv=none; b=j4na/hJQCYbyHSWA9eQQgM8F8KqeP3CFi8PcJ8XWvqdNfUj9VIgswg0gYAyIcyyFvitLZc5eZSp6w8E6XTfpeEQ+FDTT8aJXRsjqQla8ZvVQLiRhLomxNaVve5Yok6MZoGktLE8OTGwe9kyVroZarfNbBKnRKqoVZt7/8UsN4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193950; c=relaxed/simple;
	bh=XeLcrTXgRUBxY2opFhvlqbaHTJSicORN+r5cxuO1vZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhdBa1m9Hq1uIeGHJiQisW/hdxMi6MV4tlL78fDB+NppGhmJks2MUm26+v7Ch15YLIhR7r2VQ2pNWLMgXQoixl/wbkbpWYOTmdWyijiwltHxdUdNhD/TKzkWr4HXnX4MH253BCjfAPTkAutt79l18cLXqPNVWfXzd630CU62sD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Z6GSwCb6; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7833b6bb41bso559939285a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706193946; x=1706798746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fERUYFordh8wpVldLUkEYqPvl+IlrIUAy+XlUPOME3c=;
        b=Z6GSwCb6jkiWpI/ba68/B4LUdosxE/390Ntdc4aje2J1spHtoJXsJ7POXhf4kvVzRS
         ni4hbgQjFuaAcqMBsr1MKE++LuOE3KkBRVSL+Fhlwa8MhA9o1rQVn3epyRWoxQzMptlv
         J3lq0gNzsFQpiBuCpXF+1jXs3eEbKHPFmQQIGuxjJY4I/3klDFTOrQt37iwrchzgKvTT
         zcA8bpKSyJyd9C9NA74v43h0OSn2CNArn1X5uWA/BNwmY4Ucd3nochwqQo9oRdRzUKnn
         sX0Op2k/HE3Ywx4XfVAtugXlPWyykVr4ho40dayco0HA9f0XAtetqpqmEVrKjx92ecRS
         UB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193946; x=1706798746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fERUYFordh8wpVldLUkEYqPvl+IlrIUAy+XlUPOME3c=;
        b=vNDBBWP6evWxAIOO3plePY8OXg7TkWqF1iYH8T6jC+nin8mmGwuRJpUkqbzxFX9R3s
         OciFhsM9M/QY55v22gmG4mAz6P+cgniC+BIwwmzGhBV4ITv+F4cpM/bytBrPcSny/fLH
         ypb9F9jObd+oZnvxyI/I947r7yQXJQES3FAUkA1jVigjtUwvB+oytdfbhJiBRQGAUX3n
         vUu6dStVoujstsk+9mZq0guxpmffwkzfHDOaYSk5jk0678PAn7TVyd92QOPXprSrruzx
         AzTi4XMrheezWf219WptYPH9kZmIbh+l3bE9n4DK2lqdBRnYH1YFKRB7RJYjnGUEI89S
         GXMw==
X-Gm-Message-State: AOJu0YzbeVF/E/rqjE9XRSfWq7YVm3BhHxBZ8pBqBAcNJ6Dag5S46NS9
	dyO6G9bRUlXmiSKm1KozsVF2Dh1czQGCxywnYCQABJqMhXkUnCyv5cqPpnaaeX8=
X-Google-Smtp-Source: AGHT+IFk04ObHayyHd6rHDR74pcU2TEStnZGiVbsja6Vj+RMlLyPqfRqUua1oq01Baob/0F0LSSUPQ==
X-Received: by 2002:a05:6214:844:b0:688:d75a:cf51 with SMTP id dg4-20020a056214084400b00688d75acf51mr696922qvb.9.1706193945917;
        Thu, 25 Jan 2024 06:45:45 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id oq1-20020a056214460100b00688b198a440sm488433qvb.6.2024.01.25.06.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:45:45 -0800 (PST)
Date: Thu, 25 Jan 2024 09:45:44 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: zswap: remove unused tree argument in
 zswap_entry_put()
Message-ID: <20240125144544.GD1567330@cmpxchg.org>
References: <20240125081423.1200336-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125081423.1200336-1-yosryahmed@google.com>

On Thu, Jan 25, 2024 at 08:14:23AM +0000, Yosry Ahmed wrote:
> Commit 7310895779624 ("mm: zswap: tighten up entry invalidation")
> removed the usage of tree argument, delete it.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Beat me to it :)

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

