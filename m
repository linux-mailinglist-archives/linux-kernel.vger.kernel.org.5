Return-Path: <linux-kernel+bounces-53174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B88584A1B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D995FB248F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345AC481D3;
	Mon,  5 Feb 2024 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCGnx5A/"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32206481A2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156028; cv=none; b=tX/KuOq6QmpBmTRhuW6IuHtd8h+yFX+1J3y9QNcjox9DBt7S7q4MUEhW4kLBAbVkdMCP6uS1wGytYjoE6+In7iHkSQ1bxvgjYwz8bEi179naji8LVpbiK8QMzdP668z1cBBB5JmruIso1P2rOX5FTALGo0G+3EwfKj6gebyw4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156028; c=relaxed/simple;
	bh=4cbaL7x9kmS/7jhUb7/LFL1L1yWMNdcX3Ncw3a5DAms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BpGaMqYFAAEHBjhLKeV11x9dOCmK+FeHUMBBlXWQbNH/fmQSRInkRqbrwyCrV4a7hskT+Xt8DJeYg0KXfdOlHrie8reAdB4LngyDOP5SQ+kQZSRghp/mw1qtMEaguW5oOT5SIqpjRk2aGn5cBsOOEOGPmRTIUx+yg9O+Cq0Bg4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCGnx5A/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5d8b519e438so4522016a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707156026; x=1707760826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBbeR5Doiy04wsDNGFC/6wGbdAcJa6bdWvcJ+PuL0Nw=;
        b=PCGnx5A/qKsdopumIzn7AVIWz4KOhIDi78GhAhNXx94BlNbFehZKDy0XjrBScFxnL3
         5m5QTvvQtAMvmY4tmswLVmZj7xbKRJDPpinefocE/krouruLeWV7joGTPmSnhO1/gykH
         bTCbuVGZk0PO8j+Lva2SDb18xaNpU2IRcenABP2cVAoCGXpoSklfuWteKVodv8GtLXve
         o5nllvVsCDcQa1ZzPZ1TcCOGyqTnnzlz1KxJ2fmm3p3MMtfKyMsXsv8e0tJ+WNMq49Sc
         2aYMHwR4LUC8Ae8eEKD7Hd4jISQvMV8kXBeoXgt8R6C0HVn8yCcV4osMUX2VaPyCdkH+
         OASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707156026; x=1707760826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBbeR5Doiy04wsDNGFC/6wGbdAcJa6bdWvcJ+PuL0Nw=;
        b=fw/6PN98fGAyG8eSorZLYsjHBnv2ITcSpd2O9cD1nCTtlkaqbpWRD5z5JIwDatdwad
         dqOZfNYOr9fy60QnqwbvjQ7H1viidgj++cxgCh8+19nR6qRfq842VjPpx0OCWQzdM7xf
         nBkN64qeJ7VqAAsS1eUJkYIreG793T9zJ8HLTv/Hh/ZC0L8AVdjIGlOxuNs0YalzzBFo
         jysOArRq8M099ji/DNoSEQWmpOE9hy7SxHhaZJDqLbnYM8VxWtsd7z01f66PsTLdGBXc
         abK3n9/5poB1FNy3tNJNuBKni9kKqV7R7XAsOZnajP9W8AZlcnll2CtfiZf/VSzfJM/2
         //ng==
X-Gm-Message-State: AOJu0YyO1xkY1kK/4eO+Xja2IqxRORnNHOF7Sc0v7Zy+F+uaGYEVMpnj
	XwDh10EEv5paLpCdwrYPBScqiDU2SMZptrPydNrTp2g7ZygEAyZwg2zLJ7b4AaY=
X-Google-Smtp-Source: AGHT+IFVR3BW1fNylqXt01Fr8n0fbBst08cx132BdDGaDHRQZGG//b2hrNsL1U3c5al7GTngr3H1ig==
X-Received: by 2002:a05:6a00:26ce:b0:6df:e85e:ecc6 with SMTP id p14-20020a056a0026ce00b006dfe85eecc6mr294292pfw.3.1707156025583;
        Mon, 05 Feb 2024 10:00:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXoqT7uVSdp/vUnSV8nhSf3V3uFMHfqLqYhxyTrCkBLmIZR3isYdp6EFkX/jfARLL6A0vp41A9Dd6Yih/ZIbYJ15ZW5YYGszRvuzTnpX/k0qQU4+VU6WCWYHElBzBRZPkLR6QQMEAuUf5pXwE03S/zy2Q80PIluKHzK5O/OAlu5QYI+adaMROcuoAJVwABjoFMgIHkWmUQPPBpQ+epDPNP8Uo8n2fiWq5E9Dot6/i3e04JFlWMpzlwuTcz1Bo2xLfZIgkc7yg==
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id y10-20020a62f24a000000b006e053c0509esm132811pfl.69.2024.02.05.10.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:00:24 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 08:00:23 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH-wq v2 1/5] workqueue: Skip __WQ_DESTROYING workqueues
 when updating global unbound cpumask
Message-ID: <ZcEiN7p_3ZgVKxrz@slm.duckdns.org>
References: <20240203154334.791910-1-longman@redhat.com>
 <20240203154334.791910-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203154334.791910-2-longman@redhat.com>

Hello,

On Sat, Feb 03, 2024 at 10:43:30AM -0500, Waiman Long wrote:
> Skip updating workqueues with __WQ_DESTROYING bit set when updating
> global unbound cpumask to avoid unnecessary work and other complications.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to wq/for-6.9.

Thanks.

-- 
tejun

