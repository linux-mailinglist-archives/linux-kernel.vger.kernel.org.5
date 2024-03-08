Return-Path: <linux-kernel+bounces-96389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE0A875B7F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90B82831F6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEEA4A2A;
	Fri,  8 Mar 2024 00:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLVzLu54"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9E1EEFC;
	Fri,  8 Mar 2024 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857221; cv=none; b=sVLxdsQiOc207UCeoU/+TPlzEX1wCUfvGSaus9L5lbzAi7A3+bj1XSHNcrfwEpVu2XQVNAe1xNT/DX5yRSNGDOxJRZS7wOAW85mP6iYexb9yCs/yqOnA7DBtkJOT6gqFDCFdK5rYlRvMSW5mjiKKIAd2Eu5py9MS5uByA6nf8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857221; c=relaxed/simple;
	bh=rB4lp6/1YlAa413HSPp/WsLKqX4VSp3G7PnOY+g1JAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/3Ipp0qCWMRJRSbk5AAIo+LJvCRtZLQ4k6rJ/mLJlsTSTEuWBVzRbdzpIXqTb4lyIDK7/FMr5m1zkX7ZaYAaPitrgDgrz+iZPRGsnlrBji+LkxNJ/d8ysFEM/oMc/O/Fo7mqzxWasAj0BhNCMH8hNTFc6xNTKuIDqkV7RRoc0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLVzLu54; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d944e8f367so12982995ad.0;
        Thu, 07 Mar 2024 16:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709857219; x=1710462019; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qiadRDhrHYs7pZHF0QSLGBthaeNvMdgIbhDEucBWyKo=;
        b=aLVzLu549vsIDfUoO8+vvybW0oS1/HolXdBPRYu5QXH8M4BL3LW1Ze1k+yhP+3ZPSr
         gPca4tLIzi85/6/Gk7NnKrrVojM+u28acVulwH2SVoV4JFaKzpH8rFCgVGYU1s3C7g1Q
         SXL6XEtH0WTZDKoCYOapuS5QOEhVKEaeoqq281n2rxvETCAuBZxe2AsNsthFwnHVt8KB
         WEn440YRiOE79bjOxs1MG6p6+G3ZcacOx+6I8fcavUodsrq1xF4+4ZDr/F7p3qKf4vrL
         pWYXN201afwdeL9hKDoKATnibktQN2Mf1943pIPrgFsQDNIqttxWCBTdCEvBaJYg6z/L
         iffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709857219; x=1710462019;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiadRDhrHYs7pZHF0QSLGBthaeNvMdgIbhDEucBWyKo=;
        b=KMHtNABU0eHh+OalC4TnUsSF2K1yCXkmTLo6+3W2lVLWGvxVFnHmAFHn3pqqgFHt0V
         4NC1VZ1WQmQLlTGFD5qiYpDGe8J5lGoHLY+IZwGSC50RTTnYtJWYwDDXVKmSyWYsuNKr
         c74WDMzsJ/gKsE3XmlsNP+8ThKcSZ+31+VMcevRQLdL0Nl18M0YC+UIBcm8eOZrsnHf4
         +BppixS/ueorVkYVHv/XywFYKqsdkfILQ69o4o9zd9shBUqWllLxgSGUSIEwkSOUWjvl
         ftPVquVkot9Fw/iTgZSO5bV8TeqQ0eOgZPUVO9puE4st6IPrmdtbwA7oONfVd2JpRZ2g
         W3fw==
X-Forwarded-Encrypted: i=1; AJvYcCWavbJygBVWea+sxM+XAI02U/jzJ86ZzcsSvwr+K5Y3CCuF1HnWn8WPhE97sDb7jEnBEN3FuOP9jiijdpirREGdlBrqV/5+5TjMrNLxSrc3rIxnmU6JrkyrqZ5jA6r+46t5ZQ08HV4B824=
X-Gm-Message-State: AOJu0Yyra9GTKpS/YIm9R5jF+QUwORZqwa9xR7+s4kxFSVFXpClGjyxm
	vZfLe9+SfgC41M0f8/Vfl7eryfvioTpVAyDpCSm43R/ety2Ai5KZ
X-Google-Smtp-Source: AGHT+IFBRC9tP0PXluHmsZX9a4ly6ggPtNiYS7cmVXkZrd6NvkNbVxC8pgJs0esQ1Vr/gDH82hjMWA==
X-Received: by 2002:a17:903:2a86:b0:1dd:3d06:6b7d with SMTP id lv6-20020a1709032a8600b001dd3d066b7dmr6180475plb.58.1709857218685;
        Thu, 07 Mar 2024 16:20:18 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:13a:f30c:e020:9a13])
        by smtp.gmail.com with ESMTPSA id q7-20020a17090311c700b001db608b54a9sm15183763plh.23.2024.03.07.16.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 16:20:18 -0800 (PST)
Date: Thu, 7 Mar 2024 16:20:15 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Torsten Hilbrich <torsten.hilbrich@secunet.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nick Dyer <nick@shmanahar.org>,
	Brad Spengler <spender@grsecurity.net>,
	Sasha Levin <sashal@kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix UAF of IRQ domain on driver
 removal
Message-ID: <ZepZv98s4cHR24E1@google.com>
References: <20240222142654.856566-1-minipli@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222142654.856566-1-minipli@grsecurity.net>

On Thu, Feb 22, 2024 at 03:26:54PM +0100, Mathias Krause wrote:
> Calling irq_domain_remove() will lead to freeing the IRQ domain
> prematurely. The domain is still referenced and will be attempted to get
> used via rmi_free_function_list() -> rmi_unregister_function() ->
> irq_dispose_mapping() -> irq_get_irq_data()'s ->domain pointer.
> 
> With PaX's MEMORY_SANITIZE this will lead to an access fault when
> attempting to dereference embedded pointers, as in Torsten's report that
> was faulting on the 'domain->ops->unmap' test.
> 
> Fix this by releasing the IRQ domain only after all related IRQs have
> been deactivated.
> 
> Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
> Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>

Applied, thank you.

-- 
Dmitry

