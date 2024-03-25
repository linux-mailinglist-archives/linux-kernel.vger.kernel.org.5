Return-Path: <linux-kernel+bounces-117730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C86D88AEDC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E9B51C3A922
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E9A5B5DD;
	Mon, 25 Mar 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN9czvp5"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CF65A7B4
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392029; cv=none; b=tPC/L0v6Tex6oE7RTAu3DhK07Ms1E7g10btryUB4O1Oe77bwKdLD1JE801HLyXQzOWbB64YQi7/nO0tO7DyB2xyUG+PlbwjWeyj0vc3pXncxIortgHgdu9bllSi67AltsTL+oI+A0P8k7aEh5LMr9WfWu5QqfQxmgR1nfRXO8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392029; c=relaxed/simple;
	bh=O7s7P+cDe4NeCR8CdSiQI5VylMAQHNxBuqFTomYcIAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmBwjHT/1OqPAKVcH7KiyimgXmmn07jrdo3fRL0OjrO9hozuSN8iL1zRbptsdlR04MF5sa988CG+PghqRb5A0OlfmcyB8Cy1KZjplSPq8p31mI0fN9GKic15oE1+uQ5nINpoXaR2WXgARtaHysrH4SZVYEjVjCi9+1C6nHvu86A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN9czvp5; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1def89f0cfdso41526485ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711392027; x=1711996827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaHl6szep0qO6yx0eMDCkr/7xneKJ57JTjbT7cCEos8=;
        b=KN9czvp56MYhknChYtnUn8Riwc5J0k38l2ukMvELUQGmBc9laEbaQ2ZuRyK/CRm2W9
         706hrR+JMV7kDuCWpUwUjAFE7iPMCPBSkyLbLeoWhxVeHH/urCp0W9V+Xf8gS1lx1lCH
         GUhlKuGU7SSGhtZ6fql/LvLwsfal9kstlmm0bz7xm6LEdK75o0wbaphclicb4ON4jzkQ
         wZyRMvJEsxkEXkv+P6PXmLXff0F+T/NWwYtCOULr2zO67xF93rnGYrOEJdrowq8/Utr/
         ybM5g5/cH0MXNkpEabA574CSY4iqI6IAblfFqa4Lr8W48ZIJkJCR24FyYbQbcghoKQTQ
         /6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711392027; x=1711996827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gaHl6szep0qO6yx0eMDCkr/7xneKJ57JTjbT7cCEos8=;
        b=H8mbEN/FvUoJ7O6vjHFuNNssA+61noF8ERek637ViNpwt4SrffclbByrUN1cVfpsWL
         WEzFPSDeV4uxJu4w4JtC25+5WZU7N3pdz5bBNBSG4wwug/nfnVUoIGDoGe5wHjaYGvBA
         jdq+XUYA7Eo1HieJigAfkW9+XEIeOERp5lpOJkj9f+Mwlwmtp4samwqKTiAppb0Rm/J2
         olHEuSX6eABixg1ARO1Fs6RWwyksi1Sn1bbcrtfGHHO620vsXC+yYPRjRxWuhrqq8jWr
         PNJTSpbPEHWmXOZNQxU8CsXe3KNPRf25TbdHSA6Axkt9mW2/0B+SXEpWt+wquB9jUbA1
         NxVA==
X-Gm-Message-State: AOJu0Yz+BCHW//b3+ebIwtlG2WkbF6l7cMP6gwKarxjrerg/15jGru4/
	Op2DduZWQMRzQgO6tT4pjitOXRadL3T7z0fv8yCyclq1L/C86NgdD9Q8sSy3
X-Google-Smtp-Source: AGHT+IETTJFq3BVeDQvdt/PmgiaM/MSNVVXAdnbNhvkjgPzJv371nbEj9NcoEEbCs2HzFfTVJKo8zg==
X-Received: by 2002:a17:902:ea0e:b0:1e0:b60f:5de3 with SMTP id s14-20020a170902ea0e00b001e0b60f5de3mr6410458plg.7.1711392027123;
        Mon, 25 Mar 2024 11:40:27 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b001e0b5f9fb02sm3054729plb.26.2024.03.25.11.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:40:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 25 Mar 2024 08:40:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH 1/4] workqueue: Use INIT_WORK_ONSTACK in
 workqueue_softirq_dead()
Message-ID: <ZgHFGelSy6RvOu0Z@slm.duckdns.org>
References: <20240308094253.2104-1-jiangshanlai@gmail.com>
 <20240308094253.2104-2-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308094253.2104-2-jiangshanlai@gmail.com>

On Fri, Mar 08, 2024 at 05:42:50PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> 
> dead_work is a stack variable.
> 
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Applied to wq/for-6.10.

Thanks.

-- 
tejun

