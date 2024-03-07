Return-Path: <linux-kernel+bounces-95192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AB3874A7A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C103E2825F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A97184038;
	Thu,  7 Mar 2024 09:13:30 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E934683CCD;
	Thu,  7 Mar 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802809; cv=none; b=aPxE2dNzzulxkgOArb3O5IhGJ0Wildxzx8likAeT6aVvvy5+bgGu//Cus3XG0qYDe4Y2TNASy8Qz//ukFUCYREdgXtLhpL58BeI6jOmh9y5ICaWus5Zh3nuso66xz0cvgyycwzjQ6TRCJDBlnyQFxAWhR4ciAl8zsT6Qct+/3vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802809; c=relaxed/simple;
	bh=jWZLNPxBjf1iDqocrMtHXzxTpIiuXDj0iO8oLm45ckg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XpQZBLq/tMO+XBhbvPHmaeqck+5xEtWt6uVnAvDRHQyA2nzct1L+BlzwU1l3AyOzfvn+R/bdKJnLSGoVATT80T3JmZbDZ9QcqRQEL0c5cX7HJsyUc8WbcJ9l4lBpM6c3MqJvGKZTq0mFoQLHSEdR9gzJC8rFlNxFWL0y1KXzIyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso705970a12.2;
        Thu, 07 Mar 2024 01:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709802806; x=1710407606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH8+RgzKMvYC8oEUchqW7a7jrzhsYboIsApSOZ3Ww3o=;
        b=DGFBlex51I1gIxLk25FfQqDZXHRAnEmiI3KevqCLJ17FS2SrozjN7nvdKVY30lmkvq
         mFkEyyOn3gBJYJNQQ6DE3peHR4tSLtwEVeP75utXEmGAEDp65n8HOopBxbiHt/wJOjL8
         koRMRAPhOVoSjAeAnQPMJvrc8Vlj6lIAf18lu69LM+n7KBfQwvDbv51zw7ZmZ1lm4zBH
         0iA84TK0TDZq+LuJSJ0k2dSQcPncOdBhH08oUy7n+9YSlMA+AlJUyOZVGg1+rxizebUO
         0veseatvmDrmBRFv36Hq2rA02gqjTutaRtXrhq0eEmgDVY1AJqBrVceYPUfjrt4IQly9
         f9xA==
X-Forwarded-Encrypted: i=1; AJvYcCX6OGVlrYUyCtLS6UKyhmhMB1mKhCVu+o7ZBRn9xYDnMPvK9S9FYv2Xe3o8zKN0qMldDfvNbC4lkAncdiqbBnhpq6S3nBLlWNqHy2tu
X-Gm-Message-State: AOJu0YzYIsEy+XAbE4ZLrODNgp4khCBwtCfUUf/XtSPmJ1/4ZjiVjSui
	+5uIWDwe9npxf7Bf2I66B6aqYuy37ye7ylvvIILSHQsb0hG8B0fC
X-Google-Smtp-Source: AGHT+IEPN5KnTTcEF7UqXQ+6g1wmC9CjME+8US/C3E6DC/QD3OirmeB49H/a0JYCnuFwlv4rNitz7w==
X-Received: by 2002:a05:6402:313a:b0:567:3436:b85b with SMTP id dd26-20020a056402313a00b005673436b85bmr8370127edb.12.1709802806144;
        Thu, 07 Mar 2024 01:13:26 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id c6-20020a056402100600b0056536eed484sm7864018edu.35.2024.03.07.01.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 01:13:25 -0800 (PST)
Date: Thu, 7 Mar 2024 01:13:23 -0800
From: Breno Leitao <leitao@debian.org>
To: gaoxingwang <gaoxingwang1@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	liaichun@huawei.com, yanan@huawei.com
Subject: Re: [PATCH] net: fix print in skb_panic()
Message-ID: <ZemFM6jds/gN+gEG@gmail.com>
References: <20240307061143.989505-1-gaoxingwang1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307061143.989505-1-gaoxingwang1@huawei.com>

On Thu, Mar 07, 2024 at 02:11:43PM +0800, gaoxingwang wrote:
> skb->len and sz are printed as negative numbers during the panic:
> skbuff: skb_under_panic: text:ffffffff8e2d3eac len:-1961180312 put:-1961180408 head:ffff88800b6ac000 data:ffff887f804ffe78 tail:0x1e0 end:0xec0 dev:team0
> 
> Use %u to print skb->len and sz,because they are defined as unsigned int.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>

Reviwed-by: Breno Leitao <leitao@debian.org>

