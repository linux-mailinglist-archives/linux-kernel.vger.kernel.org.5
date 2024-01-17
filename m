Return-Path: <linux-kernel+bounces-29256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F08F830BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFD91C23C14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939FF225AD;
	Wed, 17 Jan 2024 17:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4dkHest"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C3A22337
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511345; cv=none; b=CCoVgKxcq5hrJl4HVfL3byU1Bmgp+VXDhrUC7H66TRvU1LMtBT0/LQfTM8gekxUneRYesVDCgL0M55u51CnOAWuuay/Fnj1CCsWBal7s6K4iwCV+ahNqZJ65PeItc+5ff6JI4B/fn6nl9I9axT3qz0IfbyvpTGjZcwu83J6NotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511345; c=relaxed/simple;
	bh=vJj27+qQMBN/p4eAjghXbtpSrZjAOPtehec33WHDYf8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IEpUe5yeDD1I4NZWy1pB/XCNRSQ927caBPDq4yWReIaZ1tuIR8nI0GISjYhLkKXeV3W4oN0gt+Vz+7B8sztEqu74rRp49GMobQJBmptwK5lcXpIhvmxKNMoAOA2WoEFAiIeZNuRRm7J9dUVRnT5mPs0ma2dhrBpob7CniASMXBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4dkHest; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d45f182fa2so90628905ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705511344; x=1706116144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wnsLwS+TwWx/T5frD/rh1ETL+0OcvA32upbUlIFwbo=;
        b=V4dkHestDYAbiOi9Qzp5Qgk4hRb+b0KdOVBxhwMH7FuOB30Yp42+PaLg2DpkGPCoKs
         mJYM+FOLyKguP4yIqS9MpK3mLSGgtIInlbDrSuiUnow2LYyM4H2LcgDBXICleIP6ODv6
         OGXFrtXkvxnrVvyereDhSzwAxd/sAenpFlfe8WvaPR+N/ZtkEypRePteDmqwiI2+A2GI
         5tK5vut2dERPXt2E1KIJtZ/YHKTThZaYAa1V3YdFhIxY17pCupmSDXl1V+stwGnybyW1
         Mv/mPIXl0znd2ujBuiLVm8qzrCVicjBJTeVbR9WPcawAEUvZIocQvHTkhLT+nhwy1V7F
         8eHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705511344; x=1706116144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wnsLwS+TwWx/T5frD/rh1ETL+0OcvA32upbUlIFwbo=;
        b=uLTXCejM6W8NIvtKEPCqRjyylwFUyC0ywykuE5aKBlFTu3tVKyAE/2YdWjd5Eb8Zpi
         FkWR79Rbaw7NnlhzLBTa1C+B1KAUUz4zeLOG2z/gbAdsGFyrcDqJAWTMZ40V+IjaavlJ
         Sbt/ubUzEu7OKPRnv2N5QJz/C0MOmOY3bszmmwMVwF3n1oootbRLYFxgu/Q8CGhrYire
         +5mHwnxFBefc9h8Xp3UkLJ6RxrCFOkPi+mdSjcmcLXB6iGRbevSzIz2yVIqtr8zl9Dea
         Hkc7sJKkCGmb3rscd08B6frglVKlOlbq+VGSQ9T6E6KG5zJr9VkQKkFn4doVnpPPMJG0
         k5yg==
X-Gm-Message-State: AOJu0YxxM3tjxwlhjsvgO2WLSCPQ9mU5R/no9IgPmihMtAHdbcqD+tIT
	sMZUAjO7f9FZJ2oxcoVqC8GMYtra5aY=
X-Google-Smtp-Source: AGHT+IEvi4NDOgygC5T4qpIx88KR+afplTg8jCaKuHadAUdNRjciOFL9SZW//dHwB/pPNQQtLeGcow==
X-Received: by 2002:a17:902:aa44:b0:1d4:c445:c705 with SMTP id c4-20020a170902aa4400b001d4c445c705mr9499023plr.26.1705511343910;
        Wed, 17 Jan 2024 09:09:03 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id ix2-20020a170902f80200b001d6f584ee1esm1087316plb.34.2024.01.17.09.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 09:09:03 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Jan 2024 07:09:02 -1000
From: Tejun Heo <tj@kernel.org>
To: Audra Mitchell <audra@redhat.com>
Cc: linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
	hirokazu.yamauchi.hk@hitachi.com, ddouwsma@redhat.com,
	loberman@redhat.com, raquini@redhat.com, rasmus.villemoes@prevas.dk
Subject: Re: [PATCH v3] workqueue.c: Increase workqueue name length
Message-ID: <ZagJrod33CPFaXGg@mtj.duckdns.org>
References: <20231215193954.1785069-1-audra@redhat.com>
 <20240115170822.451231-1-audra@redhat.com>
 <ZabLkep0gOFEyjxH@slm.duckdns.org>
 <Zafm-hkCI4sbOr78@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zafm-hkCI4sbOr78@fedora>

Hello,

On Wed, Jan 17, 2024 at 09:40:58AM -0500, Audra Mitchell wrote:
> Thank you for the response. May I humbly mention that I did find the following
> while testing my patch:
> 
> [    0.120298] workqueue: name exceeds WQ_NAME_LEN (32 chars). Truncating to: events_freezable_power_efficien
> 
> In an effort to be thorough, would you like me to submit a patch shortening
> this? Perhaps to "events_freezable_pwr_efficient"?
> 
> To be clear, I am not pushing the change, however, I do want to make sure that
> the changes being submitted are not causing additional clutter. 

Oh yeah, please go ahead.

Thanks.

-- 
tejun

