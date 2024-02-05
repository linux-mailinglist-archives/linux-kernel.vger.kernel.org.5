Return-Path: <linux-kernel+bounces-53873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D0984A77F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477C81C27264
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7096683CBB;
	Mon,  5 Feb 2024 19:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1iHn8oU"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5A82D7A
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162792; cv=none; b=efj6GTjconMqA42bzSDIWiLCXmemCQ+4ureOdhPNZSuAj6u3Anzwq/E/OmA5dKlg74XF743VjOYlCvbCxH276/SNJV1993TVPKJlaFUEYGgGTKD8oDWbrQ65rjbo/iPFP/0/LeU6inxvHS75HVKt6p7bAWBgVFGhJQgJVoNq1bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162792; c=relaxed/simple;
	bh=kBnNpTKxNHNuN0M481E2J87UdjW7sMvfzwiCfFIQn0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMuwML48A7Zh1a3ueiTqBFopGHGDZXiRzkjF1MoAJpAXG2VFo+m/NTaIW5rG//Zu6k0jvVc0V774B/aUN9PQS1BJe0Yp5x33x8XkFSbnBtXRd2/mXD8ScgHncmGnnD/KmNubo0IHEPyFa/ecjLriKo/TFLbuedJfIEwiD+y60sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1iHn8oU; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2906773c7e9so50138a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707162790; x=1707767590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWe/67exXwPWxPIWuf0Zi0TJlQ/QoxoIB5w3IbpqLws=;
        b=L1iHn8oUAn9Qwe6OTRl551+2tR43jfXgNQcZTgGFN+TUVDCap6Ni0mUw0T43b8thLJ
         LLx4iKVUEQzvZDIlYo54JxWNNi6DB55/4kIcAZMlkldmbWq7BmGaqo+c1YyuYHQkiaIM
         3iBEGQ3ukDGmHXLPFwbcE7sU4TC8ywbeEkyFI0/WB9hJ0eqDrk5muwRnDLggmUrOjNbo
         TZXSm2CYbKnQPQ14hdhs7WtgcFvMk9axvWQ5lav9izno78KnSt4dGXQi2MoNuoD/QHgG
         DsNaOwJgu1Jh4wW7SnLMhu5Ve6gI7Vv1Jyx9xTVSIaScj8AZBnhTKQdJ6PcaxHsixHZ2
         QtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162790; x=1707767590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWe/67exXwPWxPIWuf0Zi0TJlQ/QoxoIB5w3IbpqLws=;
        b=U4dWC8soh9JixC8bILqpSqaSQJUb6t2xTKPPCIWIx48TtUmXSALT9vz51ubzPujHWm
         dDm+fpXt4GvDAEUyGdElJ98OAa6XBM+UvwYyXz4uV3VtfvTsebdTkFH+Jkbocxk1Tunj
         52zM7Z6qPdJiMvvGcCgrPpRjoxiPAsDX4ZvQ93atVFkgem674ES3yyEcHS6BgrXcuB7u
         QfhPvGc6+uoTK1ZA/Lj+WG8V92rlbfTSGEkahGvy6YEe/u6WvU/6ie/m6dKBuYD3d7SV
         xdx4S1Mi0YqVc6+iWsplVrDFAMSMTPWG5sfjI7Pk87trv2l22FX7l5JkdKAh8nEp9MLz
         cgQg==
X-Gm-Message-State: AOJu0YxoCVtWRYiCj3zMsTl4KqtCJaa8Vlw/nvm4TygPNtvxcpZc7Ixd
	hVOUHfcFCenVofbIX50BACFl5Vs+dY4wMHIpl0VpOafGHYFh5RaiyCaQOTO+U80=
X-Google-Smtp-Source: AGHT+IHcKNX+LcLBHOdSfsD/FTF0HVs6KxeDK3GCkTogMd2yNrj08DBi3ElIzqohJY284fiyjanzwA==
X-Received: by 2002:a17:90a:ad07:b0:295:d223:ad11 with SMTP id r7-20020a17090aad0700b00295d223ad11mr451991pjq.36.1707162790487;
        Mon, 05 Feb 2024 11:53:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVXAoYYmVGC+BXJc/MzRGCRgs+sjoMxxHPuFEfPe5TOULOkfm/8lwk65sXsHruIIFlkzEHfFiFMdloZpqAvfRLcSy6KK68KSLyTydJP80sJfesvQ7RQx+WZmsCmB4tBuPGLwAa07BSQg1UsNyk7+76anXgTqk99XwtB+ZEDrtMOl8yqWgctpJmZFPFOnVBhQKuqb9E6sQ0jo5EZCmK5WQkIw8uKJGABRSqaQRsKvUIB6giT+aaDCVWB0tfVC5R1ZKfGRGDJdA==
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id ju16-20020a170903429000b001d96a0cddccsm243128plb.296.2024.02.05.11.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 11:53:10 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 5 Feb 2024 09:53:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Alex Gladkov <agladkov@redhat.com>, Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [PATCH-wq v3 0/4] workqueue: Enable unbound cpumask update on
 ordered workqueues
Message-ID: <ZcE8pUuHfa7gVZs6@slm.duckdns.org>
References: <20240205194602.871505-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205194602.871505-1-longman@redhat.com>

On Mon, Feb 05, 2024 at 02:45:58PM -0500, Waiman Long wrote:
>  v3:
>   - [v2] https://lore.kernel.org/lkml/20240203154334.791910-1-longman@redhat.com/
>   - Drop patch 1 as it has been merged into the for-6.9 branch.
>   - Use rcu_access_pointer() to access wq->dfl_pwq.
>   - Use RCU protection instead of acquiring wq->mutex in
>     apply_wqattrs_cleanup().

Looks like we raced each other. I'll wait for v4.

Thanks.

-- 
tejun

