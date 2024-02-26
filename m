Return-Path: <linux-kernel+bounces-82153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3313B868001
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A2A28EC28
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2491F12F39F;
	Mon, 26 Feb 2024 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3IiloCx"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D812BEAC;
	Mon, 26 Feb 2024 18:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708973231; cv=none; b=lsqqKDUFH3oK6eX5DvAp4AsA1IyTlmnGFgg0RAbOY3w//8JYA4cz6TtFFJjgVoVSrKmAxyWUT0MsfVAZ+DEgER2XOT4VDQznWQd7Oaah+thH++2HVSLAefnflzVZsQ3vxdSCzvoLIZrKsLysryYaGx2OkLaUOcQnh0hnjfTMRkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708973231; c=relaxed/simple;
	bh=D4J+iACiEQMVt1Yvog+GeKbpf9dV3YV9YJZuQfPNjjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDrbf2OAtOfhmxLOLpctYryPW3fVLebq6AWNTaRtZxAtexWzoMKVdv7GSplzqBEafyJgXTM/j3zrCXhhXqgUnT4l0ZcJBfyi8BhU1XkyLCds0t4rzdof+tUUtBE5xOdiV/4muAU8JxtQX/wJadKfP4PqdZvLLGhyEhLAVauF1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3IiloCx; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-59fb0b5b47eso1383644eaf.3;
        Mon, 26 Feb 2024 10:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708973229; x=1709578029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PFL8pDiC7nUP+eFCvCdg4g+ZRJAF9hLv9BvAZ0ru27I=;
        b=C3IiloCxgC6j4q+Ns1u8xSgFf0rdz+dHxZu13dn74VtL1CGlmr+418dgBHFq+/1Uff
         RND7ER6MHQpcwfHq3QzXVrXzfFWGqgrUlNWtHgObqWoJ02V2w5zP0ksokYjrLc8N2sK1
         AesU3T0Yp3CKJet+pOgAquAGoGp0bpFDJCYzys9j0b/bKqi/LaqSZbkjt7prmrABxDt3
         06YdfX2o8UzGGokTG8C0VG+AbVZC1JWRMg1bW8P7bpTCq4B7dO0S/dJI1k/wyDnHtenU
         z+P6F8OSMA5aag5NgjnySNIxPlkQR0oFKBzj2HkOG/6HL9zGxusOMPNYX1+5N0uJZHW0
         +eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708973229; x=1709578029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFL8pDiC7nUP+eFCvCdg4g+ZRJAF9hLv9BvAZ0ru27I=;
        b=ny61U/rUO3hAEaN9Y8XSgAiHoA6dT1l8Y8LJ7thnqEmqncVoTgKS2AhPBjGV9sEOvu
         cM6U813BMQbYLPzgQMvaBexbrAHRaSJlCY9wxTMuX4/p6U9x2WXMr2nWfyvez6yl1NLS
         1fnVwrHmRvPC5cCSJi5LYY9OEqwkORPx896mPtUOLEkQ3Kd7/6E/wD93jo76ucv4NGv0
         3V935IK5ef23dK/lSkWHFzI6i/yx830JEqHBncJlkF+Mi2VDJvZfN3RFvSkGWFvpvl3j
         GRoHphAVNL7QY9mPFAlST21oykmZAESUSAxSG0ZqGIquvOZk0UztQtRRnIb0d3tOwyKq
         PQaA==
X-Forwarded-Encrypted: i=1; AJvYcCWsb1KdTXxehCYEA/9eQkPc5x3OligcrHHkWsIIJ8D1NmBKqb12Ag6vLg1h7+dKOCbfSoN+/MDHCoaaRIzoiF65XZBMjszbErOXCFk4GUbp03PDZjSMqQmxlUTv6rBIPEelMTX1
X-Gm-Message-State: AOJu0Yz8GxQ3YYtSTd/Y/QBHDUaUegh/CCu4nP79bp2VOw1m55rTyq6b
	Hc6jfSIsPiLxfJ8X6zPyqoEbAkVmo9b9eb72nDldN29Yn3nb2zn5
X-Google-Smtp-Source: AGHT+IE/z/ZckjyccWtrq/CQPSJPdlaFy9/8HNqmT+/ptTbkYGWVj24Pf5Ol4cbQHtjyQZpqiJDyOw==
X-Received: by 2002:a05:6359:4102:b0:17b:b52c:c121 with SMTP id kh2-20020a056359410200b0017bb52cc121mr1452236rwc.13.1708973229018;
        Mon, 26 Feb 2024 10:47:09 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:31e4])
        by smtp.gmail.com with ESMTPSA id a22-20020a631a56000000b005dc832ed816sm4293862pgm.59.2024.02.26.10.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 10:47:08 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 26 Feb 2024 08:47:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: torvalds@linux-foundation.org, mpatocka@redhat.com,
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
	msnitzer@redhat.com, ignat@cloudflare.com, damien.lemoal@wdc.com,
	bob.liu@oracle.com, houtao1@huawei.com, peterz@infradead.org,
	mingo@kernel.org, netdev@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 3/8] workqueue: Implement BH workqueues to eventually
 replace tasklets
Message-ID: <Zdzcq_Z9iGb4XC0B@slm.duckdns.org>
References: <20240130091300.2968534-1-tj@kernel.org>
 <20240130091300.2968534-4-tj@kernel.org>
 <ZcABypwUML6Osiec@slm.duckdns.org>
 <Zdvw0HdSXcU3JZ4g@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdvw0HdSXcU3JZ4g@boqun-archlinux>

Hello,

On Sun, Feb 25, 2024 at 06:00:48PM -0800, Boqun Feng wrote:
> Sorry, late to the party, but I wonder how this play along with cpu
> hotplug? Say we've queued a lot BH_WORK on a CPU, and we offline that
> cpu, wouldn't that end up with a few BH_WORK left on that CPU not being
> executed?

Ah, good point. tasklets get transferred out of offline CPU. Workqueue
counterpart doesn't do that. I'll fix that.

Thanks.

-- 
tejun

