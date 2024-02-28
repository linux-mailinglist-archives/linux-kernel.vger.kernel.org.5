Return-Path: <linux-kernel+bounces-85075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D77486B00E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8540286082
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2052814C58D;
	Wed, 28 Feb 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uqK1EiTh"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13143149DE2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125944; cv=none; b=g3gx/hp76hJK1RZWQTNgEJqkhFGBOD6AtWFmeJd/uceLBYOXJgWLYVpfE9c6r+zDY0wNvS+rQ8HWdRunkM56axALHDl+54diet5HEaDWXe6+UDMSJLCE1K8hRGCz9NfRpfO9xUIBaWkFkUynQ/MtQZXAlO2nB6FeWItqAYPfEHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125944; c=relaxed/simple;
	bh=1bD+TvbzDbXTfsdrw8BzIDHbEibgU9qHHyHfTTUEBTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OGCOLskSXt6uKCsEwGN+2dAPKqQzzW84h7snQXAcs2wTi4BPjG1bini2mJNyYM+UJGwjOB9gvHXln40ahRQxU0dPxkuJTwCcDI+VKltB5+zTzYsYBP6s0QOCrWbg64MabKquU9O27bpkXZh6pFPygvBUSHbUOZ1CZqUHWoTOQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uqK1EiTh; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33aeb088324so3440852f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709125941; x=1709730741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1bD+TvbzDbXTfsdrw8BzIDHbEibgU9qHHyHfTTUEBTw=;
        b=uqK1EiTh3xel+0qm7EhNE1wrmPIkHwBuvsPN9ed1KKFieLgrMMcj875f6MPNHStiO3
         5/tgtrcsgWS/1QpPJATY+kIh/6WGvKESqnCypzvq3Hf6u6bbQ+SwBAJ0svB4wq0CGoIs
         JidN1OVsX66nsMI5C/qbqXNzYTz+/RrryIDTbYsg1Tp4PwvLQRfz4LWtaSE25nARWCL4
         0HZSJmDLBaXpTd3akC45U1hXQB5dOGfNIuD7F03HDO60NSsCynekGmd88OfZplUsc7Y8
         4RGWr3cAKne7MCn+dQhT62U5z72CHmXK/58lqkVebazcJij2xNhxnQOQOHIWDmknXI+M
         QAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125941; x=1709730741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1bD+TvbzDbXTfsdrw8BzIDHbEibgU9qHHyHfTTUEBTw=;
        b=KXpxtL4lHTC1rMJgpLOHgC+8qCaTDGvqyYMjqLIijflFRXrQJnDWcN9jIhN3wmAoua
         ogWn5h6DQlKodGd9S1rhkEiDPeanWK9FB+w/Aanfr5ERtXgDqAAfe2UJIpqQftOVBr0i
         5sLScKk9WHO2q8xAAoR5FPLGfdl9V/hLAulAQXkSN38lPP8Cgpq6QdzDVm43W7jXyDPC
         QknGnVAOnKU9ibkokhaIo8jsIgP5mHeI2QULXX4bxolmPrDMzBx3j/Pri3SK4ro5qwvr
         4vu49yY0yz9wa9XP0XcdSNljZOskCRPzhJN/vaf/SxwuH269WW4OLcRdePSzQ9gXErNo
         h9xw==
X-Forwarded-Encrypted: i=1; AJvYcCWhEA4GfyWLU7vDmlOR3KSTFpQPe38APanx1/ZmPfWWrWWnf+DIiJKwnddIN9H9I30mnztu0oadl7a48rWg6ntiFnpAcQzSRC5VdYXO
X-Gm-Message-State: AOJu0Yzp7RS7tUcjcWeR2Jdb+C1z41uBFH7Ufa9/V+y5vcORPB1UKHSA
	Y9/5+7jcVbKVeu5qQ0ve5tol1wgAqDyiS0sDsL4aHTG7hD6SzZb9xCPZnnss59A=
X-Google-Smtp-Source: AGHT+IEm2GPfTV3ssQeU4XVkZjEXwj0yIajzxFEe5Z89HZRUR1knrmaQTBO7zoB7PCjicKbgFQLtoA==
X-Received: by 2002:a5d:698f:0:b0:33d:2d07:b567 with SMTP id g15-20020a5d698f000000b0033d2d07b567mr9499056wru.24.1709125941487;
        Wed, 28 Feb 2024 05:12:21 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id eo8-20020a056000428800b0033dcac2a8dasm11954467wrb.68.2024.02.28.05.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:12:21 -0800 (PST)
Date: Wed, 28 Feb 2024 14:12:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next] selftests: net: Correct couple of spelling
 mistakes
Message-ID: <Zd8xMsNFaF6ZE5AS@nanopsycho>
References: <20240228120701.422264-1-pvkumar5749404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228120701.422264-1-pvkumar5749404@gmail.com>

Again, you sent this already here:
https://lore.kernel.org/all/20240228082416.416882-1-pvkumar5749404@gmail.com/

Could you please avoid duplicates like this? Also, note there is 24h
rule not to repost the same patch. Could you please read:
https://www.kernel.org/doc/html/v6.6/process/maintainer-netdev.html#tl-dr

