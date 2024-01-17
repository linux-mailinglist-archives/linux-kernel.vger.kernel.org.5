Return-Path: <linux-kernel+bounces-29261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694B4830BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE901C24D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE44B225D0;
	Wed, 17 Jan 2024 17:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbACLZtX"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9C8225A1
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705511537; cv=none; b=dyE/6RTPXumTGFI8brWgtTGLOxa12LZP72skv6wNHJ/7grUJuJ1uD7YmoXHMIIL+jOytsSeHa9WauVI9DQh8nI4Azg4vbCIAUx2g+npSUpb2DUOQk14qQOgbdHa82qQycWr+YBE6PeFYO8AGXVWDhLyj1WZqmsbtKZzi5/sev38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705511537; c=relaxed/simple;
	bh=jmlCqKtLGMs4Kwsd9u38y4zOPmq6VA6dw+7SLfxbteU=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rf3Af/R5DGtmiqUCiwCB8cNLk4u0FJlGE55Rp/winETTGVZ/gGQeMq/q/zz1D+T2gyQux4DlRhX5FKxQ5lUIYEmc8ZzfRqiHjgN2Zgd5VqrjxdxzMnSlieM8UtC9twFmBot4wkaozKKlO+7WymBnNfdZiuoAdGjvXHZGc1VwgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbACLZtX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9cb95ddd1so4906244b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705511535; x=1706116335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4bWrXBozZxWT+Le+JKj0QjMD23koe1KxVtSt7dBjPW4=;
        b=NbACLZtXAB5O5t1OLzVliUAT7bJc64/shxZjaPugQwWcE+Bf/lfDAXHouLaguUIVIG
         uv4i8Jad4313oAuSTll8W2sn3VdlHhBf5kLygBejJC7N/IWazcDZ0fHWD9tvT6R+FBsN
         Uvd+dcQfxiSgjuOXpv3CwrdheaEPg0qjfDMDAYcbopo8Hnghl7adF0FXrogl1oOLhz7s
         T50T7rFqymsc0dyIZIc8nbsa0zEQnGTl63M+eUWXVZjR+x2koAOXup32HfTFdC+g9LXT
         I1rswToLoJRA1hNuuwSOmJxQulNzTQx2j0+4jzaIbbRELVaNoiPoY29wiKC9ln+hwsJY
         OGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705511535; x=1706116335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4bWrXBozZxWT+Le+JKj0QjMD23koe1KxVtSt7dBjPW4=;
        b=hvUBXHxXc6XO0U6y4ggJIL7AWqNZrKLqQvj7AyZumk6yGzz3RrOGijGBv9EnO61j8s
         U63KA3MKhu6l3oCUEYtJA41ZU3Krl3Z/AuoiINVWhks0IQHCoElLGQyksWKNdcjjXgpo
         aGWExIaikAXi1EliC6XoHFVfuoU3eU3z+KZtjnqHCf3SjCusXgKFNs6zPGykkjlKWWJ8
         XBj0sXAQrghUvMENZiPc2xLuWVRlaXWbDkXE+d9HTkvezyQeJA9/3nmsekMFuJqSBn2p
         G0Nsy2mp2OqrNPIyTigZGpGKR63etDg3NPF9sblxx2UAo8ZRMKI9Nx4Zgbuo8H+XAK6O
         MBPQ==
X-Gm-Message-State: AOJu0Yw4mhZgPRP9pPqEHhZVHWUQip9TnBfAXWSdbNXgew1CawJboD8i
	adIdzz8gpH7fmZqhDyZ0uuc=
X-Google-Smtp-Source: AGHT+IFt2fYcxUQeurS5FmLTiZQ2Z6HQJOkGdK7DZBC4bp2HfFTY4wSTcEY39YdmqUns0jTPoGPS1g==
X-Received: by 2002:a05:6a00:3a0e:b0:6d9:e5ae:2056 with SMTP id fj14-20020a056a003a0e00b006d9e5ae2056mr8107415pfb.60.1705511535288;
        Wed, 17 Jan 2024 09:12:15 -0800 (PST)
Received: from localhost (dhcp-72-235-13-140.hawaiiantel.net. [72.235.13.140])
        by smtp.gmail.com with ESMTPSA id l18-20020a62be12000000b006db3149eacasm1671836pff.104.2024.01.17.09.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 09:12:15 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 17 Jan 2024 07:12:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] kernel/workqueue: Distinguish between general
 unbound and WQ_SYSFS cpumask changes
Message-ID: <ZagKbRlBxZHsKiw5@mtj.duckdns.org>
References: <20240116161929.232885-1-juri.lelli@redhat.com>
 <20240116161929.232885-4-juri.lelli@redhat.com>
 <ZabRlEklmuqwFPj-@slm.duckdns.org>
 <ZafQwMw8ZKztunMU@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZafQwMw8ZKztunMU@localhost.localdomain>

Hello,

On Wed, Jan 17, 2024 at 02:06:08PM +0100, Juri Lelli wrote:
> > This looks rather hacky. Can you elaborate how the current code misbehaves
> > with an example?
> 
> I was trying to address the fact that ordered unbound workqueues didn't
> seem to reflect unbound_cpumask changes, e.g.
> 
> wq_unbound_cpumask=00000003
> 
> edac-poller              ordered,E  0xffffffff 000000ff      kworker/R-edac-            351 0xffffffff 000000ff
> 
> vs. 
> 
> edac-poller              ordered,E  00000003                 kworker/R-edac-            349 00000003
> 
> with the patch applied. But honestly, I'm now also not convinced what
> I'm proposing is correct, so I'll need to think more about it.
> 
> Can you please confirm though that ordered unbound workqueues are not
> "special" for some reason and we would like them to follow
> unbound_cpumask changes as normal ubound workqueues?

They aren't special and should follow the normal unbound workqueue cpumask.

Thanks.

-- 
tejun

