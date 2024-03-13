Return-Path: <linux-kernel+bounces-102486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5670687B2C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B559288733
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6E14E1C4;
	Wed, 13 Mar 2024 20:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9sFh701"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175951EB31
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 20:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710361284; cv=none; b=BP2Z4S/II4bFwT5Ft9U/ZU3U5YUZLETHnVuY3nFli6ltftH1KNSAEu6widJ1eBWbGD5wEKHNkvAtWRwGGO6nam8wzxXJH5wlE3yxpqFK+tJqko4rqLwqf9goBv/xK9/jxfFPS1qqmHnBN1iaPeqgC5h7v5yosR5/+Bt2GHuZ5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710361284; c=relaxed/simple;
	bh=oOyEKIiGSmzjQiNOPdNB5XQw7YmMhvSzVrGoUKGXIyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz3OLKpD4m4yQi2G0btSlLVp4qVQ6QbsfG29f/o1O+ZAPrRstREjjPkRh+qGzAAtzvUA3rJeWC2bypvvgZB3xby1DC5CLFeemrbqlCxv+n8Lv91dF+jd9kHi0v7s/0Qaw66KQRP8Kdvu1G5KwkXgB5BAXyNY1t6s+IPLOPOX2Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9sFh701; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6e6b6f86975so219673b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710361282; x=1710966082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5rIAfqpydh71BAQAHKKmEpmcOuXzR2MU+9NEW5K4wU=;
        b=S9sFh701tTEToKngqt9HjaqMjyZqpsI0hOQeqRXFqTtZs1N4fO4vvMjQdDz5HK5Gck
         xYptNSyU/3Q1WLm7aLhuHZU9S1tEM1q4W+r/CsAPAxuJ46Yx967ReSLqAnteyqnHc7oi
         JJIIxCp7VF+ZkMIv/CkbYRMkJ9+7jiwmDomiGHzhRp6RZfb5Z5qoa5l6s/P9QXil6JI3
         2FqVTxfYqvUm1N7kzh+HMHhkQIEuZmUtUDaeXcXT4VA2NlbMPs+eSJk7IYfNnIJ76KuV
         Zm6bPLRlC3JXsxPp1imiO7khRfu/TXABpxkTtxQAL7lG49GJwi84dyK8QtLNL3vrNyyj
         oQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710361282; x=1710966082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5rIAfqpydh71BAQAHKKmEpmcOuXzR2MU+9NEW5K4wU=;
        b=HlJMKYCbd43RjfH+PVSRKZ434UXj+Mnet/f73yl1YPg5Y0rGRv/zu1uUw4SSHeYZzf
         2HBauDngqd6oeTxa9PPAruiQxXCKP0VZn3lHqUZZey8A8NZP1wnq30b5JyOFdOijoaLI
         SXwBazp1v9OANg2aaoDc5nk8f6jBoUHeRziG3O5noYw7MdjxK3aPmD1pUfHT5HHVZMv8
         /I0jCVt3dBKeLcJQy/XbCnvJalkxRKPViAwkxOUvwblLsJWxt89FOCId8pq4LXLnw+jA
         XrvkIvzIwNas/Sm9IzE8eEv/tSQKZE8PO3OYBnuqHWME8WVIqHzNMZIXcDk7KjQ7yXcq
         MIlA==
X-Forwarded-Encrypted: i=1; AJvYcCUlKZ6DYDGoz4fvR+5njFOD0l/B9U75g46YKkUG4l8ILxAq/c+jLEl7wC3ZzqjrWOxsSUR/x8sbVmxLiJpGbY8GhfYN6mrYUS5PIEux
X-Gm-Message-State: AOJu0Yxl7xtFx4khvzdH/jvvfQopt+RvOjnrbRiNwqYi7TVQNaPdF6z/
	3RExLkkSeqHPu+Fnr/qxX4ym+JjzqQyFSsIQv7ch2WsAXCtnpbVisrJ49F+B
X-Google-Smtp-Source: AGHT+IGljKtYvJULDDiFD9o2RAlMWuep1s/RYPhxAJMMOwkC5meL3QklUabIwE9Z6dhjV2nkMeIKhA==
X-Received: by 2002:a05:6a00:8706:b0:6e6:bfb6:371 with SMTP id hj6-20020a056a00870600b006e6bfb60371mr1812208pfb.34.1710361282263;
        Wed, 13 Mar 2024 13:21:22 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:2875])
        by smtp.gmail.com with ESMTPSA id d193-20020a6336ca000000b005d553239b16sm46815pga.20.2024.03.13.13.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 13:21:21 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 13 Mar 2024 10:21:20 -1000
From: Tejun Heo <tj@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Bug in sysfs_break_active_protection()
Message-ID: <ZfIKwFSmw-ACj_jO@slm.duckdns.org>
References: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>
 <e9d710fc-eace-44de-b3cc-1117c3575ef7@rowland.harvard.edu>
 <2024030428-graph-harmful-1597@gregkh>
 <416a8311-c725-419a-8b22-74c80207347f@rowland.harvard.edu>
 <9c2484f4-df62-4d23-97a2-55a160eba55f@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c2484f4-df62-4d23-97a2-55a160eba55f@rowland.harvard.edu>

Sorry about late reply.

On Mon, Mar 04, 2024 at 02:17:27PM -0500, Alan Stern wrote:
..
> struct kernfs_node *sysfs_break_active_protection(struct kobject *kobj,
> 						  const struct attribute *attr)
> {
> 	struct kernfs_node *kn;
> 
> 	kobject_get(kobj);
> 	kn = kernfs_find_and_get(kobj->sd, attr->name);
> 	if (kn)
> 		kernfs_break_active_protection(kn);
> 	return kn;
> }
..
> If kn is NULL then the kobject_get(kobj) reference is never dropped.  
> It looks like this could happen if two processes want to unregister the 
> same kobject at the same time.
> 
> Shouldn't sysfs_break_active_protection() do this?
> 
> 	kobject_get(kobj);
> 	kn = kernfs_find_and_get(kobj->sd, attr->name);
> 	if (kn)
> 		kernfs_break_active_protection(kn);
> +	else
> +		kobject_put(kobj);
> 	return kn;

Yeah, I think you're right. It's an obvious ref leak. Would you mind writing
up a patch?

Thank you.

-- 
tejun

