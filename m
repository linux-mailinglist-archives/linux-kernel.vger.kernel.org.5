Return-Path: <linux-kernel+bounces-85067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76C86AFF4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C4F28973D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775D014AD07;
	Wed, 28 Feb 2024 13:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xHRF6XNQ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9E149DE2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125777; cv=none; b=YxWX5HteSG5Rq7Uf004pjq0Ixfd9EHu+Hrx1gc4kNDWkm+sHGqhRp6C91OsUuPY+0+4xthTvhhcn38ezgKTtsufdiythcRNpjyt+dzQq52qSHwhJwHS5Okt3dLa3ail48RHlNg+w9BE2+Jtdj0fWumQlZMkNPnJI+e/rNBg+Diw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125777; c=relaxed/simple;
	bh=2Ft3bJiWKb5wT6iuIPDRn0E5KDZP5tR5xY4D5h4a9ZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7tp4juVyRew3l+gGOV4Lx00D4L2gAkdPYg2mnsv6+z4oObvZcvjo+Sb8QdpQEIyU8oJietoEoK98Mg40FWFymYKu4Uv6C9DvSFGk6ZkJYDcULIEc/c5ztLUoxA4uRsQW2Vs2K0FdA9e04tjrrae6RTRvEDmzGZazTHM9PtF9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xHRF6XNQ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d28464c554so52783561fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709125774; x=1709730574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ft3bJiWKb5wT6iuIPDRn0E5KDZP5tR5xY4D5h4a9ZE=;
        b=xHRF6XNQAxY19zdHQdOUBCXhFqvg9nw0+LncpnZg/0WCV1tFKM2DxOf4CiqN0P15Aw
         bF0OlGn6NEd/eq0BmVJqfnCNKsMS6V2uTTYGp/mPPzK4lTlol24rUygt9M5lsn/OqZ1f
         hbRRklnzvqTyxX9oQGpjEY0/EfSee5cS8UHfRy9+tvpjeqgrMLzTDtVMe7ywPA7axsVG
         fivU9MKwltu8QhEUujK5P7fdWLynqYJAIE5Ovn9OSiTBVZrjVRRUGk9ey1990QeJmkTx
         gkKa+Zsk6KzmZMDLgmSFBAfHqOrPEfFHRlf9z6JOHuRoqymNhujXFiucULye1pVzTqY3
         RmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125774; x=1709730574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Ft3bJiWKb5wT6iuIPDRn0E5KDZP5tR5xY4D5h4a9ZE=;
        b=wQvPbk5DU5870ql4NXVi16sE8rJ9RTV1ELKhPPSpsnU0tcg/h2Eu+hwrvUlLhylE3d
         TYAEbmqTHe4WyN2NTSEgV+xW5Vla/h6vUViuutZ2C1myNJ3kBroUfQPPd2tRoeCiYnLJ
         lSwM5sL1MXmMABrTSglER2HePpo3LJ9wodyqQJzuLQDgLgzOou3MIaFqh3NfJ7kcALyf
         JCEAmNEPlpu9hX0bqyw0N9aEJl6LE0YhhAV6o4hskFY128mZ13iSBAn2De5H9SZw74jR
         X9XgvwuC7jeIv+gDLshyAc8havhifZM7R+yAB+efEof8OnczFkiCuk0n0J/CDt6s/yM0
         8AMA==
X-Forwarded-Encrypted: i=1; AJvYcCW7znFnshhmCwcXfDiV0s8uuDvrU6EfoZvQs1KQ644yhL6v2XypOeRhOpxSeY8oJbjZjJah5WMpvCDNIhQ0wS4XBFGZ32HNTTHbWU/O
X-Gm-Message-State: AOJu0YzIeyHs+SRngXEZ1pLiT3wjbZLYP2P6WpBtgcGIOTljISIJNaTn
	1tMqdGhFO78Ma4mqKu7ShTbFj37ANNUE6tyaFV03zdVY26Pz2XsjNw82MQHhS2k=
X-Google-Smtp-Source: AGHT+IEXjIeaqkm6aDYE/p8eQaQhxLsM4l93SBBtG4gumRuwRAuP9F46ubbWmhhXEYGUD/OSV2vyhw==
X-Received: by 2002:a2e:860d:0:b0:2d2:9b00:2289 with SMTP id a13-20020a2e860d000000b002d29b002289mr3237613lji.29.1709125774294;
        Wed, 28 Feb 2024 05:09:34 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b00412b0ef22basm2091407wmq.10.2024.02.28.05.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 05:09:33 -0800 (PST)
Date: Wed, 28 Feb 2024 14:09:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prabhav Kumar Vaish <pvkumar5749404@gmail.com>
Cc: shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next] Correct couple of spelling mistakes
Message-ID: <Zd8wirexgBacmsv1@nanopsycho>
References: <20240228115707.420200-1-pvkumar5749404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228115707.420200-1-pvkumar5749404@gmail.com>

You sent this already here:
https://lore.kernel.org/all/20240228082416.416882-1-pvkumar5749404@gmail.com/

I don't understand why you send this again. Could you slow down a bit
please?

