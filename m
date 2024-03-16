Return-Path: <linux-kernel+bounces-105213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E977F87DA97
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833261F22183
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B351B1B969;
	Sat, 16 Mar 2024 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="MG/SJNiB"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF81B80F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710603677; cv=none; b=c0RqeczdfgpM6qcQItXbwzCLP9hnohXEY4SfzouWmlv6aUirnJg3pfuC9/koNC7SDkBe6RuSSqVXCeFEOM+lUwh+oGz0saDUWmnNbIosvQ9wVMcAWQsJz5XH6Zk7KsXs8xQjIvTx+wxiwflCya+R0YPIJk0m/MIWWIx0pY/a45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710603677; c=relaxed/simple;
	bh=DVKnrx4LTWg3PJvGZiH9RqXWaCCjAmllk8cytlWNXq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GIf5pJFPeZ5I9BfD7lMBCsZNpXMseRAE5N7csDAcckEI7+0SxWXQHCAAbjq+wB08tJ8o3bj0pGY6cL4vLFLCg3T9JMU7LMznkZQJftMcQxSuoNOEUWBPsCaEHdjYzSYK67kfVGOXeqhIvnpYf5YxOk+i5FJCxgLKABN52U9QtPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=MG/SJNiB; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41409fd8b6eso1966075e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710603673; x=1711208473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r08nE6M+052czd6TDRRSKiJ72BtB1MGicKvM+Jhq7Do=;
        b=MG/SJNiBQXstzPfIOb9A8hDhaab9s+7iSDafv2grb0IrG+b23BjqJ/SAUyjAmh+6qc
         gXuZS3RJ7/jIcyPeQbbnsx2mcF3L4tWDaPvXDeqwXVfyQvRarPPz7XFcDirY5RZhTHwP
         AsvRmRXApVGk/4O8gn/7ypnyo8ZQoe/12AqNsQ84V0ml/RM5BOid3juV6DgNpVhQrJuF
         kdSq4qCNHvfOIW6hQ+G3FEIHgznK7Cr2+XRvTNbx2fWB0Qvyfwie6E9ROytNlHTLWpDy
         1kuQEG17xrxtVBDMrQ1uTvWa//R+FH8MrCFrppTtg7SnmtRlwKL9jDjYH5u3GRfnPIMK
         0pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710603673; x=1711208473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r08nE6M+052czd6TDRRSKiJ72BtB1MGicKvM+Jhq7Do=;
        b=PprKm6qYS6vIU+Zb4IoOSTS8Xrdgy5HbxmZihVU9OOFGkB+kTXp0ZlSfyqn/qn3na2
         pbL3eDWzox8zatsCds+yRHw2l3SPPvT3PgROUUHYzjEYVI6PYK83LTPa5ciOCNZbczhX
         LQ0fl/zoZskUOiO7uWCDXukzKRXlwnPeVM7JFuxIdJWrboCYMvPx+SXd4MHQzs49+NfX
         NQD/vh0Bwo6MOzJwytCy36gt+lgXEZc5SPk4pJCEg6/TV5K26zUyVUAt58+nXIWPS/yi
         TtPp/cxrAkOoWhxYs6FV2ZIQQC+DWTtgatW1k+EEvfmAdHQE26iFrfmjhd9b2ENHDKJ2
         ctLA==
X-Gm-Message-State: AOJu0YxGhDlfsKvNeMBj/4ucNiWUBcpsX6+D5haQ/dhvdqFzKK9cLT+9
	0xdxVmi4i8jrhCnxXPTLVj8Dyc6p4sjoVWWh2NmfyhAg1vAEQxOPRu8wDzrwN5U=
X-Google-Smtp-Source: AGHT+IGVtnHAsQI+NrgyOQlqywZZb9eSCnpF7NvP2GYs/VAan2qIio3AQRHayTDkuUxMqOc2pwF4uw==
X-Received: by 2002:a05:600c:45c8:b0:413:1212:3eed with SMTP id s8-20020a05600c45c800b0041312123eedmr1818806wmo.3.1710603673172;
        Sat, 16 Mar 2024 08:41:13 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b004140726eac3sm2366569wmq.6.2024.03.16.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 08:41:12 -0700 (PDT)
Date: Sat, 16 Mar 2024 16:41:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: David Rientjes <rientjes@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, cl@linux.com,
	penberg@kernel.org, iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org, vbabka@suse.cz, roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com, peterz@infradead.org, mingo@kernel.org,
	danielj@nvidia.com
Subject: Re: [patch RFC] mm/slab: introduce KZALLOC_FREE() cleanup-ed
 allocation macro
Message-ID: <ZfW9lVhnClqr9Han@nanopsycho>
References: <20240315132249.2515468-1-jiri@resnulli.us>
 <171412ef-1a93-3e56-2b7b-3baf83233eb2@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171412ef-1a93-3e56-2b7b-3baf83233eb2@google.com>

Fri, Mar 15, 2024 at 10:39:02PM CET, rientjes@google.com wrote:
>On Fri, 15 Mar 2024, Jiri Pirko wrote:
>
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> With introduction of __free() macro using cleanup infrastructure, it
>> will very likely become quite common to see following pattern:
>> 	type *var __free(kfree) = kzalloc(sizeof(*var), GFP_KERNEL);
>> 
>> To follow the CLASS() flow from cleanup.h, introduce a simple macro
>> KZALLOC_FREE() to wrap this over and allow the same flow.
>> 
>> Show an example usage in gpio-sim driver.
>> 
>
>Seems highly specialized especially for kzalloc specifically, so not sure 
>this warrants its own macro.

Yeah, but having like 2-3 macro variants would probably cover vast
majority of usecases now. The rest could still do things manually.

