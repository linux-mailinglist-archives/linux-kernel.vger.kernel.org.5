Return-Path: <linux-kernel+bounces-50216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 264758475DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BAB1C246CF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B792614AD3D;
	Fri,  2 Feb 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUM/m4u+"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901FD14AD1E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706893826; cv=none; b=VVVxXhXHNsu2XvMpPCstTzOcYYEtqJwPVcEkcagUi5/6Ef3lBM6YP1cPef2PkVxy6xUoeXnw9hPY+bolDsiVFrgtQ43svpJQAUzOHcYd5jftxjmC2l9l6Y4ieNl4k/PYEgxeW80J6ZsFcBl01U6zgN/V9vPVlg1p3eDkmHHZ//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706893826; c=relaxed/simple;
	bh=HyM3x47RfSEDaROYFbkt8/xDWLSc0oYeea/gDaqgYCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RffV4rl26ZBkpYYtjeL6dLMNXfRw1ndQpDYxuLjdxUMxvLmLGfbAeAl8TMXd9NzrqT16VAK/HQ8PP1jBnesvsCO9Vt5puuVnCnAFsnRl7rMfCGBVLZdgQqyM2J7pz+aqDUtqilUYB2XVW/HHIsFerg/n2Dquj1jUY7uII6Zbpco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUM/m4u+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d746856d85so18028485ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 09:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706893824; x=1707498624; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEc0rxFi6UHP4RvDxTxnsNS+Za8QCetoo+sqYgIySQ4=;
        b=SUM/m4u+UKRImziwer1e5kwlNFa7XNMRNiZhUwURPYi32K5L3NsWZclf3QVdNPACpa
         lXrQoPTCVVddtEwHgwh85y1HidRqNGX+2uzzTN60BouE1+AfH0jrHHOiAblJ2Zk2Hg0T
         xJmF7C5ti/h1ExxlsBPkKxotOrAVlzz7aQ62ASCe+MvSPVOZy28cmMeRRR3x4Hnhng0a
         Ogb0aKBYgM7zRavgvvdmoqSx1WRmMSp9PJjNqbMRX2jEmgrkCGHE3NvyOn38GIxpO65l
         o7DM4U3skiMDVFqdrpO6ePwKTWZ1VTRFHF5P6zOuRloYA+DnJHjBBxq2bBoD5hLCwlnW
         TQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706893824; x=1707498624;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEc0rxFi6UHP4RvDxTxnsNS+Za8QCetoo+sqYgIySQ4=;
        b=Fhpzv9s/ckOEhYdgGIUZdbnp4eWKNb7t/yjDISYZhLfVD2in1XGBOLFpEfWbc19UDY
         DKkoj8KYT9RAsGCWJQ0Gz9DjeF3rj4wEfFkX3FmGEuGICmr+vANFPqIWhafkxZjxw8Ez
         q6ijipLAW/vwBwk/5SbmAinV69L38qlPO2Oha0nKT7T149/DMYDDcoebo5BizB45Tmk2
         8+ejNbWiuAa8zwxqbz+OMqw7LrMmBcb2MdpqzAyDlIgUz88I30r+jGNTAK7vqmSS/hUO
         0N5IDRakbPf2zmQFsXADRORYZgpDUZlnu2+c5DCBIXwhsgQHUJz/9MMQiWR1p4HGDqir
         kiUQ==
X-Gm-Message-State: AOJu0YyyiOEs1KPLkVRLoMF5XS9DiboowqhuN5Wf4ziSL676bp4r4BvK
	YGzG+Bmzj90D/EI8vrPFv5XS7bHPXxIfQSx0i4QPhraiJ6MpNv89
X-Google-Smtp-Source: AGHT+IFlDbdR75rj3hDUKVfeow3GzpffWgGsoyIeuuP50FBe/aSHIDKCnMWN/DDHK1q8adNvllS49g==
X-Received: by 2002:a17:903:1210:b0:1d8:debb:4125 with SMTP id l16-20020a170903121000b001d8debb4125mr2463893plh.38.1706893823800;
        Fri, 02 Feb 2024 09:10:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV5bJwJN43TBQQdTlx955/0y5VjRVVQtm5DU52aLfgMrxW4/sIqC2mW4QoH83pdQOTaJyxcPYIzVxN13I8ctufEIsY0wUGKddexLn00+ojebKmlB5sxIR0cK7R4f7UyYcuQ+2lMgRTApHDEyz027psJ6VBGS2uR+6rgc2ZKFkBcGZb7yBvJoPB6Oe4m
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902bc4b00b001d8f933fb5csm1840551plz.93.2024.02.02.09.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 09:10:23 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 2 Feb 2024 07:10:22 -1000
From: Tejun Heo <tj@kernel.org>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] cpuset: remove /proc/PID/cpuset
Message-ID: <Zb0h_rAph8oBpKuS@slm.duckdns.org>
References: <20240202104911.125894-1-brookxu.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202104911.125894-1-brookxu.cn@gmail.com>

On Fri, Feb 02, 2024 at 06:49:11PM +0800, brookxu.cn wrote:
> From: Chunguang Xu <chunguang.xu@shopee.com>
> 
> Now we can get all cgroup paths from /proc/PID/cgroup for
> a long time, so it maybe useless to keep /proc/PID/cpuset,
> besides the path get from /proc/PID/cpuset is not consistent
> with /proc/PID/cgroup in default hierarchy, so now we may
> can safely remove /proc/PID/cpuset to avoid the mismatch.
> 
> root@test:~# cat /proc/1186/cgroup
> 0::/system.slice/lmeter.service

I don't think we can remove it, unfortunately. We can try to deprecate it
and annoy people who use it over time and eventually remove it, but I don't
see a reason why we should do that. It doesn't get in anyone's way, so let's
let it be.

Thanks.

-- 
tejun

