Return-Path: <linux-kernel+bounces-66215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E785C855895
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 02:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90ADCB225E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4CD1109;
	Thu, 15 Feb 2024 01:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxd4qvJk"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54868EC7;
	Thu, 15 Feb 2024 01:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959260; cv=none; b=vGpHuNssSOAJnkhgg/hcJZjrjlKanz8XIzlskcyp6W1q+AmbGHmLhJYTc/Fm/fySp0YD/r60Ot2nGByjdYYljtK70znycVu2UC4ASE0yAqrLnHlieECmURQ2yDGQ2ZPco/kjbbwAaLbcpxtb+IF3QZJHBi9BkhI6mPtEf5UnIVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959260; c=relaxed/simple;
	bh=3Z47SJOfrj8RNjScGe+RKC3+DdRXLGJtAIa0MG6SDa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwc2Ap3eirKbf/vyX5OHyn2zRtdLZ5uMJEokw+imaDrPfpGsAQeUQjg3faBjd1zyN+jrcRQUEf5ONNsL/TFd41j2PhgDv1Dh94Yd11poyWTbKUV9jDrFiUnz6PRLakRdtsCY+8ePcCN2owY3UpX8ixKkuI6jsoYmCjEFp9bwvTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxd4qvJk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e09493eb8eso1151832b3a.1;
        Wed, 14 Feb 2024 17:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707959258; x=1708564058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Z47SJOfrj8RNjScGe+RKC3+DdRXLGJtAIa0MG6SDa0=;
        b=Qxd4qvJkCPHg3mhxSl7zkYQUCbRr+7y7NRNC1KcME8Zm4r7AuOeOFrxOMk7rnMH/Rb
         wd4pD/+mwzX1ii2quIU3CyIqLjX17XdWchf3TpL89EyJ62L6BidM+0vkNNjlA2IRsUbL
         5XnlCEKAjd6RyRXGRa78SqyyJDSKtlTDbZEoegZcMriBy6+3e1DzFVzSOW6y0LwHz7Fu
         JkxHW6DEhImdxaQy6qdSpWqh6DrigolgUPq1JOM+J0ccJ+FR/CZh3SDuu00TANR0g36i
         4cfTGhInSucdWELusizotawNKmZIU12C/SnNMukGMqlMnQEPElkaa9oHT7ojzOOcaCR7
         JBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707959258; x=1708564058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Z47SJOfrj8RNjScGe+RKC3+DdRXLGJtAIa0MG6SDa0=;
        b=KNcqBKN0XBTr/T0ukP3cXgYeXBtA0SYvAZxeHvneT4EJeP7M+N3pcb4TK7tkYlTdKa
         NdnPfywuAAUMHL7UCZawtacG/9qxEUOSO7FU98LGU2xOYPvTP5rY6N+/fH34g7QOz+W2
         RgSWwkqTS4Ap9Ki7giTG+2grMdCmRn4hJQGWLAz+pLz8Bgsn4+EsjJahi5HAVWe0I5AU
         r6t7NObiddU1sd8w89BvTmDC3nKa/Wq5B0Zbm7rDFTWzCjCcGN63hjg3Kq63Xj/NXhXn
         YO6GhjrFrwY6XxZnU6SpfhCIVU66j0LwDBugX4SxOTyvlDmXeLs3fD52IHNNIqVtBVxs
         sStA==
X-Forwarded-Encrypted: i=1; AJvYcCWPBUMx7yzxqBljMQYyWJdq2TxGYynSwjgZrTPWTlZ/lfPxLDnZxailUOgTXGShL5RtLqgPoBshxrkZPZjdGd0lbgYWqP4mDGjRhA==
X-Gm-Message-State: AOJu0YwRMvleKG7wKAFZGHzSC6ZjRi/shvy5scSxz4fMHYfJ0fSwaNdG
	Ofk8pAb65iX4DkCH6x6sxDVxOTvMxeObNP/4Q+N2ZDNlGtnqCHd8
X-Google-Smtp-Source: AGHT+IGZT2g7/RQXZKKgTw/ldmr45xi0KO+228vH2wkjRRfEdEZMtlQBBax0p6vfNaEt6oObKBTFIA==
X-Received: by 2002:a05:6a21:2d87:b0:19c:6620:483c with SMTP id ty7-20020a056a212d8700b0019c6620483cmr329862pzb.23.1707959258486;
        Wed, 14 Feb 2024 17:07:38 -0800 (PST)
Received: from rigel ([220.235.35.85])
        by smtp.gmail.com with ESMTPSA id l7-20020a056a00140700b006e037ce7cb8sm90759pfu.0.2024.02.14.17.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:07:38 -0800 (PST)
Date: Thu, 15 Feb 2024 09:07:33 +0800
From: Kent Gibson <warthog618@gmail.com>
To: brgl@bgdev.pl
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linus.walleij@linaro.org, andy@kernel.org
Subject: Re: [PATCH] gpio: uapi: clarify default_values being logical
Message-ID: <20240215010733.GA30995@rigel>
References: <20240211101421.166779-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211101421.166779-1-warthog618@gmail.com>

On Sun, Feb 11, 2024 at 06:14:21PM +0800, Kent Gibson wrote:
> The documentation for default_values mentions high/low which can be
> confusing, particularly when the ACTIVE_LOW flag is set.
>
> Replace high/low with active/inactive to clarify that the values are
> logical not physical.
>
> Similarly, clarify the interpretation of values in struct gpiohandle_data.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

Just checking where we are at with this patch, given you've merged the
two documentation patches that followed on from it.

I realize you have bigger fish to fry at the moment, so sorry for any
distraction, but I just want to ensure there isn't something you are
expecting from me or it hasn't fallen through the cracks.

Cheers,
Kent.

