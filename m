Return-Path: <linux-kernel+bounces-74113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8889C85D01A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AE6E283532
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C723A1D1;
	Wed, 21 Feb 2024 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MClBphUx"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918839FFC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 05:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494424; cv=none; b=oVZTb5isSu9chZ9ZJ6zgydozY2wZ1QfyPXsMwp1d0lmdibhMySVyh9z/gvPZiNTMr/UYdGmnyt9l7IQbT7shaQyGaRuodaPi0iJlfB5ucdQyeW77iVBiAbO1B0HIb/RYCyhNe+duIG6JwJv5jGTD6Nt/OJmvkOI8Xf1L+lgilgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494424; c=relaxed/simple;
	bh=gEF1FU5AuR5sMAROEucuVYy4vJ1INvdTgHvHk52s72s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKWAnd4yI/L7saqIhtKfjSLnkMFHLkeQwsYvrvoeQudQFuABOo/9WneNzC08JO9OqO9pRM+ZNMnsc+6FBKfxgbKB+y6qp0yCrBe2hKoLSmRlZDkAGjMUvJ8mI5nsKoifx6FwelaEp1tHShUdGx5NXQ8f4zlT43Q8bj9vUA+dxlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MClBphUx; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ddf26eba3cso4689572a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 21:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708494422; x=1709099222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fp0jwvLzKqTFWWavRabMZOMHCIo37a0oGTF58L8clkE=;
        b=MClBphUxJcUNV6hMrXfM12q2JP4YIfSqa39xGLIjZ0+zoGWo3O3KyYW3RBPQx+1q4g
         +Hio5quIy/NfibMQIIMcXt48MbntRXm3sd3wxPF1tJVYAllMYjyoA/HTnzEr9GimsGs1
         82d1XewVIACrw/WUCWxTfpnAAws9BmYGyrzGRyXFIpmwRH8nKKpE/kmn1Xiy4GKTme4L
         weefNFnKhYsR62GhGKYJngesnTT9lXCe0tXfeUS4MoM/AvdV3qG2KN0Fxm85Y6HNxvjl
         +/awE36BAUW/pfDISrAje5AildFJKm/qit94br1SO3IVx/ufhGb9Ahrt1arwAVV721pQ
         l/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708494422; x=1709099222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp0jwvLzKqTFWWavRabMZOMHCIo37a0oGTF58L8clkE=;
        b=onQAUTEpqQO0pYt+CAGq8kklIyNWNdyeLumS0VX/MgX9pkRBTFFXVkyqf0+j58BXLM
         HYVGB/NtkWiwAgX3t/fIZkusN5mc0BzoIOzTIaxlWCFPMpJhlXcEvJENoF1NKkxkBObf
         LFJoEv7q5y0+lY0mfXHwWJH20MUDbJgYgTVVoXghegEJ9aSYAfKzyfbY9hAV5INcrtom
         BZfzs0ZWm0AbwYHW+tJLzd5s9pyyni12ZydJmeSVpj2ZwVhMhAni73HKGoCpqcQu+BfU
         nqbjtJBK+cKBBvo1eFrbIgs+xZiqImeip8d0Y6HjG8QLHxzPHMRlNAiayM3CVRkDTltR
         ck/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWNESobfcrd09OjbLp74KiR+2fa07FK2uFtsmwW0r5kjzC46rOa3KfBdweyw7rLp4fq0s7uZDdoOZ5BadLF/5BxBngs1MFDRdWFyaB4
X-Gm-Message-State: AOJu0YzNSRxj5ahbLXqanmD+MMBMTQpOjuSXpen+Sm53W3puXxOk/LKJ
	/JSx/ub1ih+e/ZAsc/DyeBDU1CYlDl6Cqpx+G4QQxMctvnUz0MNX
X-Google-Smtp-Source: AGHT+IEN9U1/CoowF/BkPXE5HVcL3mOUwBGszVCORFAZmmkmUABJYwP2t3ePwm0ZVH4bwZnzbAAD3g==
X-Received: by 2002:a05:6358:2486:b0:178:fda7:ef08 with SMTP id m6-20020a056358248600b00178fda7ef08mr18393921rwc.32.1708494422084;
        Tue, 20 Feb 2024 21:47:02 -0800 (PST)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id p14-20020a056a0026ce00b006e4887b13ffsm1121856pfw.1.2024.02.20.21.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 21:47:01 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 20 Feb 2024 19:47:00 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	allen.lkml@gmail.com, kernel-team@meta.com
Subject: Re: [PATCH 12/17] workqueue: Implement disable/enable for (delayed)
 work items
Message-ID: <ZdWOVP5zwD_Uyeoj@slm.duckdns.org>
References: <20240216180559.208276-1-tj@kernel.org>
 <20240216180559.208276-13-tj@kernel.org>
 <CAJhGHyCOgrU9TC9o97LpvAEL2p+Dgt=uN0mo01Gr7HadVSD-Ag@mail.gmail.com>
 <ZdTxisk3zp_eXDVb@slm.duckdns.org>
 <CAJhGHyCvk=uqcjjf-=L64ig2m00qdEuRLSvc0qiJm_SftGqunQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyCvk=uqcjjf-=L64ig2m00qdEuRLSvc0qiJm_SftGqunQ@mail.gmail.com>

Hello,

On Wed, Feb 21, 2024 at 10:54:46AM +0800, Lai Jiangshan wrote:
> I think it is better to have the same handling (checking disable count)
> in queue_rcu_work().
> 
> 1) code is consistent with other queuing code
> 2) known state: no work item is queued with disable count > 0
> 3) catch wrong usages: some complaining code can be added when adding the check.
> 
> Adding checking and complaining in the code is as important as
> adding a comment stating rcu work is not allowed to be disabled/canceled.

Sure, will add a WARN_ON_ONCE().

> > I'm not quite sure flush_delayed_work() is safe. Will think more about that.
> 
> I think the code successfully deleting the timer not only owns the pending bit
> but also ensures the disable count is zero.

Yeah, this should be fine.

Thanks.

-- 
tejun

