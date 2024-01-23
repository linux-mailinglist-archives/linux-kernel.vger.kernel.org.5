Return-Path: <linux-kernel+bounces-34754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC4E838722
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B5F1F2410D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419B4F5EB;
	Tue, 23 Jan 2024 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JrKO2fOd"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902B4F213
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990237; cv=none; b=hHzahfQW4H0ykwm17d6Dw2sF2jo4aAR/3ETLck1/VQvF8dLJhuS2kLV+UM7BFykxMG/a2BW9dzfsHa/iiyDPzaJBzfAQeUUx0EEZX3cASMkjizM6oqvoQpvO4Qt4sPm+zzmbL2BqsVUWQk/Lxxsjh/MybUg7ihD4W7HqbV/BpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990237; c=relaxed/simple;
	bh=w3gqNh/2pOwoeMf06X/XCaRk9VzBiWnMpsT5GqVh0sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpQxAuEPAlR7fJb/ZFIQBgftUdGRGylXVgtNIgdZySs/bCa4fXLEfn56DJ3AwYw0tYS0LqIRBwfNH1DvBdKANAlVFePT9I7WlFMtMyv4sSTQxF55V8xlTP2EdomjqWruxo8qY/ED7xr9/LC8dQ/rtmiboI29PNoFZQMm2tNaSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JrKO2fOd; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78333ad3a17so339174785a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705990234; x=1706595034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5A/ClUoIrkIoreUe1TXm2hkzVatmI8TCvtYDlQ9V8pE=;
        b=JrKO2fOdkY41PXhJGTMJygUkSWyotkuY7gHaWpSQi2iHSXH1rk07WQzSj5u37zGixQ
         X7mpSknaC3M3jgYRDzqQ723YRduh9IBL2PjWd8Dh8Vf7F8U9uKmmG0FoNZtPY5ehanoe
         JFecZMRLTPmaxN9flw1KVT3SGpPVnXsQ/SVJzn8/wbu4RFHVTz+DCw4HMrQbBs5A14d/
         WV/FbxwETQlBbtM9Qu2znjLzx7al5X7IeFriLpf7drA2MCwwpQg3FBhBltxnAYyy4wBb
         OfKDdnGFkcI4mxRwkKUsEdgYKl/gw9UzshGrMyri5IJZK/XjBw1F+uuHgAZJBzUkAlaG
         5Mxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990234; x=1706595034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5A/ClUoIrkIoreUe1TXm2hkzVatmI8TCvtYDlQ9V8pE=;
        b=NS271Jj+7oMfF/prhIpXFMEW7OZCBYb2jSkWDibny9X8zr8d99F71j2a7gxug4gxVK
         DuKpPHlyy3DFFAE6HEtiu5fdh+IPmBHYxyfysPRIP3acrDBbG/rvQYp/acoBoTa3qIhx
         0yLQPpbD02Jx1EL7Uy40nVqFI4S0JplJupErfTmWeOEnF8Wl/NXsEYNhl1IrYj4N33el
         HXwkrQtzmdy7fTDSGI6bciBGTM578fWqusuY2r1eiVAe3gqmuj9kV+YsIlCPfpp7EA+0
         8+qlbgf6FxcxNMFROHMHghKm4gduk42wSe7gVmFIUIVN2OrlPJDj0ceNNXLv704VC8fh
         HyaQ==
X-Gm-Message-State: AOJu0YyQw1uDGOTFQZQpsfhVu1K183wCFoFFFjajsumekAmbgvkhuKuc
	2o3ASZB4+xGVeAVJYANfrLLjNqAUhg7Bn2kuXu9jE7uCN6e5rupa4f6T2XGnVUM=
X-Google-Smtp-Source: AGHT+IE4OD6TOeSlxeub7wxFFX8Sv6dWWmPrA3e8kSMzmAMyNUFBJ2e3X/JubQQACaJDh2v9EM67/w==
X-Received: by 2002:a05:620a:ce6:b0:783:3f25:c6f3 with SMTP id c6-20020a05620a0ce600b007833f25c6f3mr6039607qkj.47.1705990233567;
        Mon, 22 Jan 2024 22:10:33 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id o11-20020ae9f50b000000b007837e17f643sm2839113qkg.63.2024.01.22.22.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:10:33 -0800 (PST)
Date: Tue, 23 Jan 2024 09:10:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hoorad Farrokh <hourrad.f@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] staging: rtl8723bs: remove unnecessary braces in
 while loop
Message-ID: <cd2fd58b-1017-4019-8810-c2421ddf02e0@moroto.mountain>
References: <4ii7ptqhz7ion46dczabnevuj7tjfv4iofvzedms6tvfgsfu2e@6rvcsdyodny2>
 <39fbf9df-d6da-4275-be3b-191108f94ec2@moroto.mountain>
 <delmvvkjuq2t76jrrxxb4a33tuef3m7bhkzpnopp5x7xzjdntb@ceybtr5piecl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <delmvvkjuq2t76jrrxxb4a33tuef3m7bhkzpnopp5x7xzjdntb@ceybtr5piecl>

On Tue, Jan 23, 2024 at 12:28:44PM +1300, Hoorad Farrokh wrote:
> Hello,
> Thanks for your comment.
> 
> > 
> > This function doesn't do anything...  The name says "free_all" but it
> > doesn't free anything.  I would prefer to fix this warning by adding
> > a comment:
> >
> 
> I didn't fully understand this part of your comment. Do you mean I should add a comment
> to the while loop + my changes and submit it agian? or 
> do you mean I should find a way to free things in the while loop? then submit again?
> 

Either one.

It's weird to note down the bugs in the source, but if we don't know how
to fix it, then perhaps that's the best we can do...

regards,
dan carpenter


