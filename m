Return-Path: <linux-kernel+bounces-117748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3888AF0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE781C3F27D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB4A125C9;
	Mon, 25 Mar 2024 18:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDc9ORKI"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606E175B7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392774; cv=none; b=rGUvOg4tYmm1n8QB3s3mlBMODgLaB9iCp4g3aXi/AMjDICV2NZ4djj6T61zvFzt9H3VbLNMo/6gDNcD8PCLRQu/T6exzIE8vrDe0huiaptedsXIb/2maTkh6M/bV1jxyhwFKmx1bT/E92vBz7Obki+tzc+HkVwhPnMxVVvnraHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392774; c=relaxed/simple;
	bh=sjntyHJgumHBsDdlImy/ZxlszmUM5Cen57KzuTTxRQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3lRjsZzbO0zpEXpLuyKgfNmcn7TJZAxraQjKfnouEfQCosWD0LC+TLtoRXieflVzJ3lUtc2JBbhds3t9I70GTAIF+BYDs+ZyzJ/EDxBRfW9ZZNiZU5HP7gyL9qkiuYw1Hw9sVasqIojDdyXNt2jwW3pYQ1RtRlkjFqOOXiGE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDc9ORKI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so2688831a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711392772; x=1711997572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFE5PA8F2UkyyZ/2jrVp4vjDURhN/6bA7Axf+jQ+Jdc=;
        b=ZDc9ORKIjLzqDaqWVFj/l/YPh0DF6m1Evq0vAOTWHMoJdmqfQKoYcaKY2dNdTpKIFk
         OKKf2X+56BKHAfR7u3ewHH2xVFX7H84tZQLx1HxYg3Gz3ACDJiIkwJpyME9oVKdpwaQ1
         6IBcy+ukyXddBpy73Kel3ZDDykNbCnK6ahFJpF0rXYem5l56l+vXURsIHNg3tKkRnnPv
         R0A0CQY/AJTXELKvKPt/J6UL+mqhhVOgPW1DQd4y9N6M94SnlbSEnM63vZlpga+3TobQ
         bgTpJkdKq+8IGryD2VTFuv7D6S0SEZrksNO72a/aQVlYhQAPTiDyAPP/vLtonz5pcUzD
         LE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711392772; x=1711997572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFE5PA8F2UkyyZ/2jrVp4vjDURhN/6bA7Axf+jQ+Jdc=;
        b=Ns4P+OaWusVIz8GVqfyt45Z37AP3bNi4Bk9v+lyj1QOu+uk/zeMfJoG1YIurMY3w0R
         i6hQfyyAKdVqgi+362Ct067ylI6UTHJO9J69yp028yRiiJEZFZ99bFulABSo/gkfZY/p
         KLh8e7cpYTpqdRNu0/64ezq64wsPTXtoL7suF1hA0fH+gpsKZYZplhOcnG06GUlVvOGu
         akMzDm8A3Rh8codLQFWQVXMQkZkiCXse1ymoaMMSlTsKIoqTIkDfFtHIv89MzgA43S0m
         ubJt4al1JwF87QPgqwCRkSaDubnfcshFmWVGQwP7P3Aji7tcey6OsbynfFTYycbW4lJA
         zhxg==
X-Gm-Message-State: AOJu0Yxu+18FOA3Gx5a6ltSIsYbh9tszEtkUUYHSkOtwNN2Gob/IfxZS
	qp2yrQE00glGQweaD7G6bfj186B5ncyrR1i205j9/LtfFM8vRbS+b95ajGv9
X-Google-Smtp-Source: AGHT+IE9AOvW4l8dPjiJKbSvWKLjr5iBPTHxRDIkvEurQjdigdjfGyNEyTJJUzzVJGSerY6E9+VKLg==
X-Received: by 2002:a05:6a20:d489:b0:1a1:87df:beff with SMTP id im9-20020a056a20d48900b001a187dfbeffmr8850786pzb.4.1711392772460;
        Mon, 25 Mar 2024 11:52:52 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id m12-20020a170902bb8c00b001e0449adfaesm4994926pls.191.2024.03.25.11.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:52:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 08:52:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH 2/4] workqueue: Reorder the fields in struct
 workqueue_attrs
Message-ID: <ZgHIAjijs2_aaWMj@slm.duckdns.org>
References: <20240308094253.2104-1-jiangshanlai@gmail.com>
 <20240308094253.2104-3-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308094253.2104-3-jiangshanlai@gmail.com>

Hello,

On Fri, Mar 08, 2024 at 05:42:51PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> So that its size is reduced from 40 to 32 in 64bit kernel, and it can be
> saved more when allocated with kmalloc() in alloc_workqueue_attrs().

Does this matter tho? Also, the sizing would be dependent on the number of
supported CPUs, right?

So, before, the order was - nice, cpumasks, affinity scope related stuff,
and then ordered flag. After, the cpumasks and affinity scope stuff are
mixed. Unless the saving is actually meaningful, I'd rather keep the current
ordering.

Thanks.

-- 
tejun

