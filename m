Return-Path: <linux-kernel+bounces-130464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAAB8978B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 891E1B2E2EE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374DF15443A;
	Wed,  3 Apr 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDfDCzXI"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D649153566;
	Wed,  3 Apr 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169941; cv=none; b=Waii4mcJ8W0skwwpL+uuQ4GW50XbltBQ9Vj85L4R5EOMHIcpOqiAK4hY2qR+W1MhuExL3WxB9nNpDrxbhcXIdDSK2d1++VDK7qRIuinGrhh5hZYq6MRAM0AKTXnNI7ntnHtaZe9e165VHPh5S9qomJOrs1IFTLkTR+dRqokegfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169941; c=relaxed/simple;
	bh=qSN4Yv7Zq10gRXFhUJf6F1ppK0AjMdsqdlHAQoPSaWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ob7mwY6Wj18qa6+AYSSZSwbvBgsBhhxOdqOsjS5X6PV6i+l6nGof4fGPxuRdPd4GI0NHVcaPMq86GAuwhdZVfmkj1TRZxmPjV7FjJnvigKQWgTck9Q6fwyF9ltdn1Au4uIKbo8flfYzQ/l5iuYV5oId9TDMMCGYZOkjh5WnuFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDfDCzXI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6eaf7c97738so91448b3a.2;
        Wed, 03 Apr 2024 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712169939; x=1712774739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eJtx9UPAg2VkCg/WWStMTH5T4NGyXLu18Jc3mVrHPfc=;
        b=bDfDCzXINXeXq2XXWRcPS6oVlyI1WDPWhL02Mngk+JBVZiwMapYCaXMQHYNdcMNRLp
         NpScCu8FxrBI0/zuBSmcrUAqgQJ3Sx3bPph1TS8muXJX3VnNse0TA93qN8IWwPej5Iyd
         m3Z5jk+KITPpU4ItIF/0RBSdgyCrtuutwEXpj0aUDdXw0pogANYp1zXXIFBJECmMZADO
         UI/yQCvz7Y9IisGeDxC5Vrr1J8eyj24aWetb5/PLwgSB49b00f0uJNhwc26iqCGFtK1x
         OFPOMYzmoFUlfOuED8ZU6qTZlkVwxATKrtyMDyP1TTt8bCjLNHX2TmkxBl+RFUj9qEJs
         uRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712169939; x=1712774739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJtx9UPAg2VkCg/WWStMTH5T4NGyXLu18Jc3mVrHPfc=;
        b=KMjzQHyb4jw25pYY9jG2P77HiIfs8ZtODYTOt1r0Gks9BvtPgWXET0yKcuNXlZp6/u
         n2QtTcNaEopYeCsJ4F751GXx0HKU4OzB0aKkXs3dKsc8HkKsqauVIN4Vuvks1Tlk8rFR
         J/ZzcS6Irq8eRk/Z6x5lROb986iErqDWyjt8zwweh5F/CrkahRpBsXB85S4Ul0Nqtn8f
         vPcD9pUyZEowgGVAUnFpfuXDa5hWvFN+HBCCZApMznm2LP7/SwLIeEa/lIUzJGdZalYK
         ohvz11zmZA1zV4D06IMeI30Se1jELV96qgMcRXiGaSSsG5L3Fh6wOc9Tcs+7SdjlGW3d
         hdsg==
X-Forwarded-Encrypted: i=1; AJvYcCUaMStKsyGXtLp2ei9Nd5doKRtqtavyGwieCtEUoforl7xqiuFOYLCywpHC0O3EKh04rT+Jg30uxtmm6fbOLKdAVyjGDRpwuChjvn4ma2dQAtUvZtQt3X+al7OJ383m3F+yObh7H1bm
X-Gm-Message-State: AOJu0Yxf/v+XOdy992RU3prHw8WDAKBZxPvY/YasDnjnw/PaoTTpvyji
	+c/rbvA5Equ1ThGHqBu0KLnURPnnunvDF9ERNZCJyYcSQ+qIGDfJ
X-Google-Smtp-Source: AGHT+IGzm8QA5jRXKwJjVJ4Wb04NIEU5X1Oelr4Ipd47XJ5wCJBOtuPNnnA46E5u50IV+AjTFtch7g==
X-Received: by 2002:a05:6a20:7f96:b0:1a7:1f8:9be2 with SMTP id d22-20020a056a207f9600b001a701f89be2mr715340pzj.9.1712169939326;
        Wed, 03 Apr 2024 11:45:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:25ab])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902a38500b001e256cb48f7sm4099606pla.197.2024.04.03.11.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:45:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 3 Apr 2024 08:45:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Audra Mitchell <audra@redhat.com>
Cc: corbet@lwn.net, jiangshanlai@gmail.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, raquini@redhat.com,
	rdunlap@infradead.org, aros@gmx.com
Subject: Re: [PATCH] Documentation/core-api: Update events_freezable_power
 references.
Message-ID: <Zg2j0dmwnh2D7xEO@slm.duckdns.org>
References: <20240403180022.16248-1-audra@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403180022.16248-1-audra@redhat.com>

On Wed, Apr 03, 2024 at 02:00:22PM -0400, Audra Mitchell wrote:
> Due to commit 8318d6a6362f ("workqueue: Shorten
> events_freezable_power_efficient name") we now have some stale
> references in the workqeueue documentation, so updating those
> references accordingly.
> 
> Signed-off-by: Audra Mitchell <audra@redhat.com>

Applied to wq/for-6.9-fixes.

Thanks.

-- 
tejun

