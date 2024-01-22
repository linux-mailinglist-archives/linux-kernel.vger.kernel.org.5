Return-Path: <linux-kernel+bounces-34295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A698377BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F29181F25B23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554404E1AA;
	Mon, 22 Jan 2024 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbZWdqQY"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5084B5A6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705966205; cv=none; b=m187g2YP8UOmwT8XcL1JiZDPIVadcV6tdj8jl2OJfqEv09vFmbgw9aWErBXEyBHnk5ldQiVsGjlmGXemYq2NvpgJIBW/2v1jr4vmrAPsLRa6uqyhuxKPkRwndQsKf8UqgmqFoqDWkcTrxyJHSc98+cve9XlXeWoUsKsZUXqwfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705966205; c=relaxed/simple;
	bh=8f5V1pIN+HwrIPe3zxmztqaVm66Xypxbk10pGL6H3AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guvefQl95ycpuNxJIEmVklp+EBGPn5qEHHb1SMWPEkX1ZI8JT0CvgsoxpXdHNTl5iNWylSW7rJs/iKuy3Hlzw6+IAbQ+SLoE0YLg2ox5R/UwgI9Ynmehy42zH8nQn6SeRMe/otXAuba/UAOrvsH2opSlH2tryCcdMX71VLK9FVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbZWdqQY; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6da9c834646so3719018b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705966204; x=1706571004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUOidC22dDHlSk4Qftb/5fCyWMGT9ty7KwSP2qXw47w=;
        b=EbZWdqQYOgOqJYI5ZydZ3k/ZqMb7O0WcMvwK1LSGDpuDHQi09PFkMxXFvRR6cbm8SD
         bRmZ6H1biyi33k3j2PwPwKVG3kmZR34OFn9RZGvT0AVqqwCAHcajrqCp3fpMoO+8sjrM
         wCGk5O4t73qRTJRJIiFHgSB57l89Yl3Fu8H8f+/hMr3oz63zZaHsoFo/prBDF16werCd
         y8URrxq+/0zN9pWJATMg604C422bBEgx90k6GXLQquysrAW2w6wFQo9r1az2blx5MXyO
         snEQJv8sD0+ah/cEuKdSbIF9Ix2U38j21zH4PgtC/FROBM/9e5zabIMA87NROfHf4E37
         amKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705966204; x=1706571004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUOidC22dDHlSk4Qftb/5fCyWMGT9ty7KwSP2qXw47w=;
        b=NSDHwvxtlig6eFJMSV+eGbbbiK2CfuSpibqYlU4l/4PmRX4R9g3pC5UqnLwCR3vVY2
         R3e5wGzAKzFDlBOnjhc9gBOAdZtNrYMerZr7rgC6zJpNulQkusB9GDhRuq/+0SZGuMhG
         XoUUYTqjal3mAPj11nZh+yOHoGZpdj/4jVXJPYmEVGgub2IE/yxTf++B/X42IRdXv41T
         j0Fb7DwMDkXeMZRkBp46tN0Yz2mlqFoz+oUkm3s8k8O0aJrT/7tpwz8WTF7TZL1vp0gL
         HLpLAcgXd48Z9dJEXdR8XwDOCHFU/nWjSlYnwgnE1YfGHR2HOWtX1Vtew8kPI7j8eynG
         cVaA==
X-Gm-Message-State: AOJu0Yx2xOKUb7U9D4m8f0oBTSfOqhEoW7qpMkTy2f2alBaMCOI4lwos
	O8s2Sp7vFWZiGS7u6BiYLS0ReZ+kk56xP78MQ8B9/Jz9ILpJCuhq
X-Google-Smtp-Source: AGHT+IGsuieeQgTUkrvX4zvqFlP0YJjBALSTDR4c2hkefINgj+fgj+/O3bqH4oa6zR146MXuactozg==
X-Received: by 2002:a05:6a20:bb25:b0:19a:4e25:be96 with SMTP id fc37-20020a056a20bb2500b0019a4e25be96mr5084877pzb.67.1705966203509;
        Mon, 22 Jan 2024 15:30:03 -0800 (PST)
Received: from LAPTOP-7VGLEE77 (19.216.252.27.dyn.cust.vf.net.nz. [27.252.216.19])
        by smtp.gmail.com with ESMTPSA id o6-20020a62f906000000b006dbd3aec001sm4077744pfh.146.2024.01.22.15.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 15:30:03 -0800 (PST)
Date: Tue, 23 Jan 2024 12:28:44 +1300
From: Hoorad Farrokh <hourrad.f@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] staging: rtl8723bs: remove unnecessary braces in
 while loop
Message-ID: <delmvvkjuq2t76jrrxxb4a33tuef3m7bhkzpnopp5x7xzjdntb@ceybtr5piecl>
References: <4ii7ptqhz7ion46dczabnevuj7tjfv4iofvzedms6tvfgsfu2e@6rvcsdyodny2>
 <39fbf9df-d6da-4275-be3b-191108f94ec2@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39fbf9df-d6da-4275-be3b-191108f94ec2@moroto.mountain>

Hello,
Thanks for your comment.

> 
> This function doesn't do anything...  The name says "free_all" but it
> doesn't free anything.  I would prefer to fix this warning by adding
> a comment:
>

I didn't fully understand this part of your comment. Do you mean I should add a comment
to the while loop + my changes and submit it agian? or 
do you mean I should find a way to free things in the while loop? then submit again?

Great regards,

Hoorad.

