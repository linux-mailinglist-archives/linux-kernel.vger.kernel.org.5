Return-Path: <linux-kernel+bounces-105585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCCF87E10D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF601C20A5E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 23:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A52137F;
	Sun, 17 Mar 2024 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoAtml7H"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7A31E865;
	Sun, 17 Mar 2024 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710717231; cv=none; b=DOiZSVbhaSH/YgCLqVAExkXpMVw/KtSS7ML04lkZQJNctewFaFGPo7EDMLASq7L4JqrKpKbP5CtZuym5fO86IYOSpQH3aUFzIhkqCUbAMiY2gN95lQb1TVL31ArwQJTb/3vO1xK/uR5pk+SemCuYpu+F5Cuzwzm5Ki3/ORKXc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710717231; c=relaxed/simple;
	bh=NcYcZ/eTmtQ0mKt9XN11lyAC8prp/l2dCYr7rYB1aWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdwTwaHcCRTAA0sr9twV9tnGymipdv94+QeMg4WSn8VadsbGZkzH71fS4L6Hl09D9rCgGm/aMk/QuDZ9CCVvzvFFCSYjqdZEjHV9acrAsb9msyn8DmCEARXNumthvsnpGGc5ATdmWhaHVC0jQ9KUOEl6Hzf3ihxMTXZNYvRIqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoAtml7H; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso2961991a12.2;
        Sun, 17 Mar 2024 16:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710717229; x=1711322029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B35g6kXas5nIqOQCCTSbVwbY+qQHDK+cx3pRHV6O9DI=;
        b=XoAtml7H2hXqcU+3Jetrz/dY8DQOQzVocC8Rmk1tT5ngu49NdUqvNNpS6NORyRZaxr
         1hMQsEFYydSG09pKWpfMgbIJ+IsrONhWTJyZi8SjzWKLBDvHKl7WykCL3NDlleN8RKXP
         Hbni+HHOH7cfCXXI7aqMEuaB1k7wkcKksriZ/8g1rlnlj+XYOfZs4irgcLzkC8N5Oefg
         /a8k7yXmWmtuLBE4hRCBzPMPdMwgDsgv5F1ovwMRSOLvZ4K78Y2ArFTHN4cslVcbFsiB
         YHWiuXochnE9cGnwj5Ke8rWRR3GmPiAEeEREQtiV+SiQPGl8ilaIALQd+CsFKl9CdPsk
         UXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710717229; x=1711322029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B35g6kXas5nIqOQCCTSbVwbY+qQHDK+cx3pRHV6O9DI=;
        b=R+2fYaclJmP9ccdVxM4y/dtkauDOXrlpuGDQjbI+uEcDx6+RdIPylFvXFjlTg9CzD8
         uA99cixhOomVbuHE07mQtpNkg7YfQJpVQpyCh/myW0wPYSMvfou/6OWFyXRpt3mGMOMs
         BP4ohbj7RqxKnA2I1PXmeZPtsVq5Ux5lSCRpTCBWaM/s+/Y1ibW6/HMStIxMNaE9r3Gl
         yLkDcFOaZWRbBAJWfjM1+3EgloxT8pFKFF+Cps31q7n5v6DS94KfjHFAslNkuofGrli5
         9s/XC+wdtZqY7lMztuPkaH3NAifsBm+jUyc8HL8OuXg7mLan/Cy+STdq6yGm4Fq7gS/R
         qNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKcO4IBNjXgqM3UV8zNCnzU4qw29QBsZCiaSF439/xPGvbbuaioubzLL1I/WHhxkGgX8gJHbXgd78N6iwGDpqpp3YCkYGe8pamLVMjTA3jYFKeWa51OAvfEvNZUmqf7TaTl0ehnQTA9qik
X-Gm-Message-State: AOJu0YzF4COlZO1qcGZ0lNlK1lpXh12sqlQ7Qe3obk1YeRDr39/vCVQ+
	eh1aCWuaDLbyW+varEFCYDfgfxEFBscV2heNM6hb26i3OxJDY1ueAuVa/B5n
X-Google-Smtp-Source: AGHT+IGt8A8siM/QvNV3dmwfrpGaLLxN0kSxAeAoM/rDpsHCchg8h0yOE5pCSVjpKFVbd70H01592A==
X-Received: by 2002:a17:902:fc45:b0:1e0:18b1:d0a2 with SMTP id me5-20020a170902fc4500b001e018b1d0a2mr2963631plb.40.1710717229069;
        Sun, 17 Mar 2024 16:13:49 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b001dd72cc822bsm7779156plh.201.2024.03.17.16.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 16:13:48 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 17 Mar 2024 16:13:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Barry Song <21cnbao@gmail.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-crypto@vger.kernel.org, akpm@linux-foundation.org,
	chrisl@kernel.org, sjenning@redhat.com, vitaly.wool@konsulko.com,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v7] crypto: scompress: remove memcpy if sg_nents is 1 and
 pages are lowmem
Message-ID: <aaa8b7d7-5abe-47bf-93f6-407942436472@roeck-us.net>
References: <20240301192745.14987-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301192745.14987-1-21cnbao@gmail.com>

Hi,

On Sat, Mar 02, 2024 at 08:27:45AM +1300, Barry Song wrote:
[ ... ]
> @@ -152,8 +165,17 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>  			ret = -ENOSPC;
>  			goto out;
>  		}
> -		scatterwalk_map_and_copy(scratch->dst, req->dst, 0, req->dlen,
> -					 1);
> +		if (dst == scratch->dst) {
> +			scatterwalk_map_and_copy(scratch->dst, req->dst, 0,
> +						 req->dlen, 1);
> +		} else {
> +			int nr_pages = DIV_ROUND_UP(req->dst->offset + req->dlen, PAGE_SIZE);
> +			int i;
> +			struct page *dst_page = sg_page(req->dst);
> +
> +			for (i = 0; i < nr_pages; i++)
> +				flush_dcache_page(dst_page + i);

flush_dcache_page() is an empty macro on some architectures
such as xtensa. This results in

Building xtensa:allmodconfig ... failed
--------------
Error log:
crypto/scompress.c: In function 'scomp_acomp_comp_decomp':
crypto/scompress.c:174:38: error: unused variable 'dst_page'

on the affected architectures.

Guenter

