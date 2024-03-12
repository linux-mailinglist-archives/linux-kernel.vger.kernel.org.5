Return-Path: <linux-kernel+bounces-99983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B8879038
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA0C281E94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D544377F20;
	Tue, 12 Mar 2024 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7cdtJ3O"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A24C8DD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710234083; cv=none; b=PAfKdbzTIqtbrhyC7mcdupRH/8SLZrGL4oC06LC6rTNZAuSSst35xTYKMgptIEbXg4Jag0s008LXBukYnWcu8xSZpiTzaX6qJ1z1ZIFMVCBKnSbMbWb12X4IRWd3LQB07UEy4X0CIyMfh5SxHxHfK+P6tANRGt+8+eEWYpcQX64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710234083; c=relaxed/simple;
	bh=8y2DQPNhzOaxdj9KvjXtszQ/bn5b2LagZPzqGN36x4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFJ9L7xCnBEhJbCX1Y7D2JeupvvrpkseLJTIi+ame8drYGh0+n2BYflKWXDXpi6lQPjbZ8Ss3RdoIWfPiArpLvFeSWjG70AuJ4cHLuZPYOU94gAjLvguiTv2UnYghqsCW0rxIIWI29kbGrxom6SMmqCPn4V4yayq8JT5+dIo39Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d7cdtJ3O; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a45606c8444so633367566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 02:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710234080; x=1710838880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JP3cfM7mrXURBm82U67JdNSwwTeGi+Ghi4y8x6qCXGo=;
        b=d7cdtJ3OBgn4Cp/r4iEyUyFZa6oxu12BUPM6b1OJ1UQXf7POqBS59e1hEHD3hVZw4Z
         SKZkowapFE1A/GF0lTzlPnb8vNZnsW/5TUnLQdFi2Z8Ead9qb75xgxhDsheWuM7kJARu
         iXJRz2Gl7DZs7fC5omg4dLxxAj0ypnMVPCkWAhFGYakkZaXerKmHHap11HOR8apBkDld
         l7bbDNZU6cbPDVi6zLXd4O41B8jMGZPM6hg130Jv9uiBkZ00xdC7/5M5C/hZ/+x4kBlc
         pflNkzufLfr6PbQrbeeF/aAVf1+yUfy3RZ5f+7XgJE7j6+kubvqGvAEoZJelrRj1eK7f
         cnFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710234080; x=1710838880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JP3cfM7mrXURBm82U67JdNSwwTeGi+Ghi4y8x6qCXGo=;
        b=JJvSOwbAdCmpsUNn+xsig13k3KN8hNCKiRTxWoBurBeFAxN1ZZGu46CdLjM8f5XoQz
         XKPCnMZVgR7Joyfu15Z3szfQPHb1gfuUlAfHVY2UZWE65WMsG25bWfuJllS0HUVvnII7
         IbbdgUXNML8SZW4QQ9Yy1Elm6+ylWV5dBUlDRe9MzGJV+wvk7q064Gfngy2KYNELWtuB
         7hQjgR8zgFTOhs7WAnib6zOR/VKnaj2qtml9i+4pSvePBB4cNdClL164MnsX7ZQbsoPH
         BKbLP8m5WG/YszsrvRjWAYB5qZBJPGINi7WW97ys/6g1zADANZJ5RcV/eC7iaOx9yOpu
         RIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm1zqplPOy+a2RWnNkYtzY3d4A3wUWy23eQjUtV+rL80eictpveRfheJgcCdQ6qEwMy+f0qw6eKIfAS86Zqt+54M28QDPQlgLwS3Om
X-Gm-Message-State: AOJu0YwBzJrDdom3h2lrliiKr5nUnN4u3Ub3lXRkJ51dLsi3fj7qnn0/
	SdfZtCelo7cya+tRhlTA7+LIFqFhp18HLr89RR79mKuLSyi7WL3m7Bp+M2mqS88=
X-Google-Smtp-Source: AGHT+IHwZrGE81YKbF2wM23szbAhUXytldSEaYxhYVB3Q19LP8guhW/J6+kuxH/HMd/98tZmJuGXbw==
X-Received: by 2002:a17:907:c001:b0:a46:20c6:b595 with SMTP id ss1-20020a170907c00100b00a4620c6b595mr4009913ejc.5.1710234079560;
        Tue, 12 Mar 2024 02:01:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qa10-20020a170907868a00b00a43815bf5edsm3643280ejc.133.2024.03.12.02.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 02:01:19 -0700 (PDT)
Date: Tue, 12 Mar 2024 12:01:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Felix N. Kimbu" <felixkimbu1@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: p80211conv: Rename local foo to decrypt_check
Message-ID: <0ae5c6f0-dfb3-4c98-9798-8379f6206256@moroto.mountain>
References: <Ze9Ie67PCSvBU+og@MOLeToid>
 <Ze+JxSpqc/eHfCKn@aschofie-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze+JxSpqc/eHfCKn@aschofie-mobl2>

On Mon, Mar 11, 2024 at 03:46:29PM -0700, Alison Schofield wrote:
> On Mon, Mar 11, 2024 at 07:07:55PM +0100, Felix N. Kimbu wrote:
> > This change renames the local variable foo to decrypt_check in functions
> > skb_ether_to_p80211(...) and skb_p80211_to_ether(...), giving intuitive
> > meaning to the identifier.
> 
> 'rc' is typically used for cases like this. If the name of the function
> being called is reasonably intuitive, then 'rc' suffices for the return
> value.
> 
> > 
> > It also indents the parameters to match the the opening parentheses.
> 
> 'Also' signals that this patch is trying to do more than one thing.
> One type of 'thing' per patch please.
> 

The name change did force a re-indent.  The v2 re-indent was wrong too
though.

regards,
dan carpenter


