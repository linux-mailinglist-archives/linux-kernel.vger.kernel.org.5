Return-Path: <linux-kernel+bounces-98340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EEE877898
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AA671C20F39
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C043A8C3;
	Sun, 10 Mar 2024 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E18wbX16"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B2024219;
	Sun, 10 Mar 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710106412; cv=none; b=Ch7/was5bE91ZVWs4iq+sZs7w4njKcMmrqqxN3k1xBbDv0ZW7E1cHpdsgQ4zPQPnp4HBF4ZMCHkkIy0vPwKvG+gIYGj4CSyPj1uODQ7c2cRaUZj24msYehfNuk9slS6oq92ijPTxaemhXfdnJYlamyrAJHwKiuwEmhG8oLWm4ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710106412; c=relaxed/simple;
	bh=ueJS1O/JtHawNgx/FfjRX0euojg6lOc+UX9U4BZ5zWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raMW5RlDjd11N/4E1YjtAJXI9aj2oA59hBF+DBT4eAcTepKhSCEprftbmlGKptOj2LvBNr7h22kV/SCWMehm0ushHAGEU1V8wWdiujHG+SwxiTvUEDZJYs5Y4HxNBdIb+MQ/TQtvUEwFeke+HMz/y7LsPynVUERLbauEM8YGWrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E18wbX16; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dd878da011so4181805ad.2;
        Sun, 10 Mar 2024 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710106411; x=1710711211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yiM66r47Wsopw5rga2V7RmdxX/5jq3ltiDuGeELsiLI=;
        b=E18wbX16bzIGyi4Y38rcKjLQV+1gtG/BdRDRgd7JuGfNLevRcLmjCtpM45SNw0ZVW5
         xD+NCSKRdwDn+FnLLN1dBUS1xoJpPa94uWEnXfW9Er7zRmF07ofYDzbrE9iqIieEIZxM
         OukGw+Ja86NjfKz/zvwPSBDQViSVSd7UBtGTtyqdnR4qaPbQNtHOXy7Dghf0lGdoDPKK
         WvFN5BtmAn0lF+Kk7ns+7yCxAB6q5VKYyHFGG0hglRebP79czMu3Ht2rpI5t4XC9+0uQ
         TnJ71NpR4RJeuf9Sje1mZ6PEBYGbkeVz0EdHA5FoWQbBfuTSzfXoDjs0OfGEYlBs75En
         PXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710106411; x=1710711211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiM66r47Wsopw5rga2V7RmdxX/5jq3ltiDuGeELsiLI=;
        b=PA9sf5e5aDRrvl7fCUph/j6ygpjBAwNWWI5d1k95ykaBAI2yGphzj9poIpzC7DWEMa
         /wyLpbe5+M8mFuatTNMRzBNCM0evhhjEuwSrFmWoxxajbwWg0UidlEaJi5nrL8Q3Yk6S
         UpMDq5LxXEMyVPMScTHboVreeNlA46dIV3pVSi/wzsGr56n4Dme+Pd1dNDYIx3g9lTYC
         FpNheeLiK+/TeEZYqXn+qQQOEFMcCiC3V3jh+Kxqb3/i2MZCoT9KDuta2I/aJBlUJhL0
         yscWD8SLJ4rxfRfMibVwzfojT5rLxLgk/Hrj95KBKptEvbO5z5yCAqRHpBpWIc7wWHwf
         wFJg==
X-Forwarded-Encrypted: i=1; AJvYcCXYYyDlOImpd24YSOqWIhMSW+gySspv2nWZnBlkl+IgBMobjpb7xFLZRoyhScNzc2gRysyr01K9cAv+2FJUkmMxXWnIPuQoopI8yNkU7MSVgSxpW8n3eUoh2XBcMmF7ZG6qYduyXmFXQw==
X-Gm-Message-State: AOJu0Yx7qsjFGN4EXEDTthVsINnXXmRp7nB+m71GobIdd5zwigqf93SU
	hzRdjX29ohzdu8V5k1kSiYIkaN1d6B6Ar+qg7zurujCp6JXLu210
X-Google-Smtp-Source: AGHT+IH5M6lxhoEhQFQUUdquyTdPTSFkTx2ksrOsyIUxOaClOyJLehXU7WD2Ng4K4q5FcK2tceBgxQ==
X-Received: by 2002:a17:903:18a:b0:1dd:7de5:88fd with SMTP id z10-20020a170903018a00b001dd7de588fdmr4104045plg.66.1710106410660;
        Sun, 10 Mar 2024 14:33:30 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fa9b:d52c:840:abd4])
        by smtp.gmail.com with ESMTPSA id z2-20020a170903018200b001dd7d00f7afsm2874652plg.18.2024.03.10.14.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 14:33:30 -0700 (PDT)
Date: Sun, 10 Mar 2024 14:33:28 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/17] dt-bindings: input: touchscreen: fsl,imx6ul-tsc
 convert to YAML
Message-ID: <Ze4nKAF1GwgFqcur@google.com>
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-5-sre@kernel.org>
 <Ze0OQ0DB1TZEtJ-6@google.com>
 <7tynuiwqaaskkuhi2vzo5wtxhyoyigym44ieomianfkwvzx7qj@hnelnwsgrfv2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7tynuiwqaaskkuhi2vzo5wtxhyoyigym44ieomianfkwvzx7qj@hnelnwsgrfv2>

On Sun, Mar 10, 2024 at 04:07:06PM +0100, Sebastian Reichel wrote:
> Hello Dmitry,
> 
> On Sat, Mar 09, 2024 at 05:34:59PM -0800, Dmitry Torokhov wrote:
> > On Tue, Feb 13, 2024 at 02:00:53AM +0100, Sebastian Reichel wrote:
> > > Convert the i.MX6UL touchscreen DT binding to YAML.
> > > 
> > > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > 
> > Applied, thank you.
> 
> Rob send a message, that he applied all DT binding patches from this
> series (incl. this one) at the same time you asked how it should be
> handled:
> 
> Message from Rob (Tue, 5 Mar 2024 11:34:32 -0600)
> https://lore.kernel.org/all/20240305173432.GA3745196-robh@kernel.org/
> 
> Message from You (Tue, 5 Mar 2024 09:30:47 -0800)
> https://lore.kernel.org/all/ZedWx79qP7QXc3Om@google.com/
> 
> I assumed, that you would see Rob's message and thus did not bother
> to reply. Obviously I was wrong, sorry about that.

Oh, my bad, I'll drop the patch from my tree. Thank you for pointing
this out.

-- 
Dmitry

