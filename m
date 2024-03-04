Return-Path: <linux-kernel+bounces-90087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5649186FA10
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7865B1C20BA6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9677FD272;
	Mon,  4 Mar 2024 06:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLm0Kl6Y"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF06C15B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533794; cv=none; b=bTpe0zdd6sVcb781OqiTqWXpH4BnLcEyl+I5knizLU/U+GVdk+xFsmXJSU4p20njUfwRBBYSrUkkjVGk4Ho1qw9xeoTgs9AwuglAOBlkXeNfM7L4TfmwGVTqjZiBI6xX/WmRYsN04zdi+efSxyjybIkqGFyhZodVJ9HK3P4uoUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533794; c=relaxed/simple;
	bh=Pf7uv/gYGGXC6+7FVldt3LroRAuk574J76EPU23+wJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuwRRIMEVep42WCHItVNVs8LAph1lNo6O0dnvuL5xOP/RmGYDzFZT5u2EeEIUScmURUMtg0bsI+20UdFvSddRQwalnVUMcsFYEp2iKFXEkWpbSwordO+9/JkFLGjAUOjLtBIGRQv2phmmOyRDX9C6mwifzd4vpwvPMCLK5Me9vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zLm0Kl6Y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so29586785e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 22:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709533792; x=1710138592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Sr+3/igGAuTwcw+O5i8ci7ivmixVyDSgfl+R16S+q0=;
        b=zLm0Kl6Y2TH/8Oo7HmkD4jIua3Kt569yVyPjwEWvhbgxkr75ugX+bDs4JLwFc+F7SU
         ULI1IpC9KySojzUnEziEv1AIs/Hze6C7mz3nEULZ2XsKxL2XqQ+MZWpG78V5riA1tCCK
         xn84eKPtr/8/89XXJglR6kiMs7HT89O+EGZJvPWCV/Wblr2GNFT0qxyHW9yqYhdkYPtO
         yIFgPP9zh0gBCik8MVzJqhc7b0+3JeqYjb/oyo0fGMV04W24gHJxOKxdLb4G7g80TY7i
         G6BI/g/vWyMCnoe1SfO9T0vbotBs1EH+DoC9kEvTuFmO+oF3pFTXXK3c2nZJQgrwqY84
         kHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709533792; x=1710138592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sr+3/igGAuTwcw+O5i8ci7ivmixVyDSgfl+R16S+q0=;
        b=L5ub+UHljHObrEyMsDn8lfkOzbLJwKTTWv/S3FxWH2p6oqjbp2Il2aw3H9EzINNvKk
         wUWZf4XCBlMbBLGTiAGKwCb76TnQyFLWEorbP8xKsBoA4UOSAtpvij5KKgmMjEr5ptVl
         XzzvyYBDadXEpd6LO7QPbnB1ix+4wilAifzUh12aBBJ6hPaB7JgHyq1htK/+Iy7m/osb
         W05uv7BaPAc5KdgdjUiw5zs5IslTO5KbzslW9t5bomTYCfJj7yQ0ufOHBhxrWUlEQoBk
         dZaIs6VOQ1634e22Nz8MTM5upDGyzfg+Vf9qS/b9NWoi/6esLHZ5BCELrxpxR5tkjjJc
         zMnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWihZPQU4rLQ2Pxst4+T6PnGQUo8oMOcMEgEpcJAdpNGB2oEkBGnlwHt0qEuwEdRMcPS2UiAdtuXDz8bQKT7lLvSnEIMKgn7xkIivQ/
X-Gm-Message-State: AOJu0YxR2hagY4kV1M1BLuc2srI6aUrMhPcXLQ4boKSy+tBFAVWGmDnG
	DsClaYb6RKJ6fNXrCFsnDlN1S9eQFN8OMqJGodTVt3TzN+nHGIa9WEbjG+27UkA=
X-Google-Smtp-Source: AGHT+IHq9JCYT783Wtc+zj9tHovEmxaZxWX3kn+l7xtGlx5U/KJDz3VB67RRX9FFH9wGGkZte3BftA==
X-Received: by 2002:a05:600c:4f82:b0:412:dab5:b20e with SMTP id n2-20020a05600c4f8200b00412dab5b20emr3940436wmq.8.1709533791619;
        Sun, 03 Mar 2024 22:29:51 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c4f1500b004101543e843sm16723413wmq.10.2024.03.03.22.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:29:51 -0800 (PST)
Date: Mon, 4 Mar 2024 09:29:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rui Miguel Silva <rmfrfs@gmail.com>
Cc: Mikhail Lobanov <m.lobanov@rosalinux.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: Fix deref of NULL in
 __gb_lights_flash_brightness_set
Message-ID: <02f31119-e35a-4358-a0a0-079416ba4a9d@moroto.mountain>
References: <20240301190425.120605-1-m.lobanov@rosalinux.ru>
 <7ef732ad-a50f-4cf5-8322-376f42eb051b@moroto.mountain>
 <m3ttlolktk.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ttlolktk.fsf@gmail.com>

On Sat, Mar 02, 2024 at 03:23:03PM +0000, Rui Miguel Silva wrote:
> Dan Carpenter <dan.carpenter@linaro.org> writes:
> Hi Dan,
> 
> > On Fri, Mar 01, 2024 at 02:04:24PM -0500, Mikhail Lobanov wrote:
> >> Dereference of null pointer in the __gb_lights_flash_brightness_set function.
> >> Assigning the channel the result of executing the get_channel_from_mode function
> >> without checking for NULL may result in an error.
> >
> > get_channel_from_mode() can only return NULL when light->channels_count
> > is zero.
> >
> > Although get_channel_from_mode() seems buggy to me.  If it can't
> > find the correct mode, it just returns the last channel.  So potentially
> > it should be made to return NULL.
> 
> Correct, thanks for the fix. Will you or me send a proper patch for
> this? Taking also the suggestion from Alex.

I'll send it.  Thanks!

regards,
dan carpenter


