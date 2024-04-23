Return-Path: <linux-kernel+bounces-155248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 311BD8AE765
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D855B1F22C28
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A8B1332B0;
	Tue, 23 Apr 2024 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gPCm6X/m"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C9134427
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877598; cv=none; b=iJkqRJN9r3bj6Hzn2FRcfkJvR3PkMRxq5xlKfgIyfUoo4ASUIcdNK9ajIDq509k4891jRKX6UondsjZ+EBoDnjOqlfHjdCR28QZOCjhvWx5vWtwmIwLFwcBvssEZMjgjDj+6ZDy96RArylQ/SeL+EHb4vqwgOai5OGgbsExC7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877598; c=relaxed/simple;
	bh=grwm9HXpZ8bNgqFZwTamq6hPZswUJZHRWpQR6jPcCgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQVfrVcEgYjHWNHfb2BucEDrInPsCeZwpKYrTsagGKTc4gPnh/JCF8IMRnnGNLQ4tY031PnGeWYQNqyuXGI4qTFtPT7cr+2ZAfJ8dD6OI2pb/UMnsHER2QRRM+D1gCPCvEfZFR/YA434AUX3ujnm8XBSCkvAGVmj2ZBLtxDLfJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gPCm6X/m; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so8366789a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713877594; x=1714482394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YtNKrVkvv3wQwUeLZfXmzb5Q0GHzil5K1gY3ZsSm6Z8=;
        b=gPCm6X/mQOKQYH5eQn8hp4KffHO79Mpu49w8aIjcNL7hp9ZXFXkxU0tTN7UnMrSGiS
         pnCRTncVMeCIZ5VnP+zOerYj5nTg2ioZX/b20+QWODPsOJjfSZKcKv0gz3TQjD5EW3w9
         lpCPUgzKXD27In/qdiOmhpawtv3YcGLOVtzolsTgsMBKP206fhbU9fFCCtzt6nzkoi5c
         kLtCRbhXmV45OCxfMOGyjuKlAdnUX5Ykl7FvRx4N3Kv71O2VGO5Hb/k6Lb5MdjzhuWf1
         GCcj8s3aAPSksAdSZ7iA4u1x1o+6Nw7+edj3bVVqhBYynmZGiKGWuIEzORAAYffz2R+P
         INLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877594; x=1714482394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtNKrVkvv3wQwUeLZfXmzb5Q0GHzil5K1gY3ZsSm6Z8=;
        b=fBttD0wvuLb50DAF4MNHNWncpHnQspag+1vjCcFETJ1cUXIKGC+HJH8NNUn92+rsbV
         L3TOj/WkAom73eI3M0qZXK3pAH6a1VBWZ1wFJmUvxoTKUWya6nBdsnpP8sJPHRn2iELr
         PskrTzov3QSEgQM7UauIayGo5PCcDSEJF4j7Lyv9xEFKO/Zuug0PIRe5+51Z9V7wnhlT
         7vUORiYNr2Yi91VZfndAsBl/A7Zd0BXuB5qZEsrGg2pzIhGy4R6xwZ6wm6MAa/svV15g
         ZLPFM2Iw+tVEE/HyP2mhvYHA9lKhjok8feCU9Q7vLIeifz2C/uEVNsgeie5hprLW0Oij
         wtuA==
X-Forwarded-Encrypted: i=1; AJvYcCVycGnfcQOvMpj66kpv0vl9PmI+F2bsLR5PAknCZ+itxb7MoF0Tfix2rT1QjYGi6cFk6vILTwjcDwhJ+x5dkOCg6ZWzYpzHRCJ9L3ma
X-Gm-Message-State: AOJu0Yw0VjFlqrZgdgUgFXRLoGnnSYn3z2dURjSvOUW8/IP7MEcbDOSh
	wRRCA9KWUaHRltPhLMQshsmnog5nnfDX5RPEHsW9CmZXWKJWk94aLtNEAXQJieI=
X-Google-Smtp-Source: AGHT+IEfj15fF7r+4JoIHYXpZkv3IMh0LCnfIlqWJ1hT3PKS6rWFiI+6gS+uY4CKIniCYg2L0Kg/iA==
X-Received: by 2002:a50:d542:0:b0:568:cdd8:cf60 with SMTP id f2-20020a50d542000000b00568cdd8cf60mr12887790edj.8.1713877594441;
        Tue, 23 Apr 2024 06:06:34 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id et3-20020a056402378300b00571d8da8d09sm4806843edb.68.2024.04.23.06.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 06:06:33 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:06:32 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v2 7/9] octeontx2-pf: Add support to sync link
 state between representor and VFs
Message-ID: <ZieyWKC7ReztKRWF@nanopsycho>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-8-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422095401.14245-8-gakula@marvell.com>

Mon, Apr 22, 2024 at 11:53:59AM CEST, gakula@marvell.com wrote:
>Implements mbox function to sync the link state between VFs and
>its representors. Same mbox is use to notify other updates like mtu etc.
>
>This patch enables
>- Reflecting the link state of representor based on the VF state and
> link state of VF based on representor.

Could you please elaborate a bit more how exactly this behaves? Examples
would help.


>- On VF interface up/down a notification is sent via mbox to representor
>  to update the link state.
>- On representor interafce up/down will cause the link state update of VF.
>

