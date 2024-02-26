Return-Path: <linux-kernel+bounces-80476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 758EF8668D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06156B2128C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39C91B80A;
	Mon, 26 Feb 2024 03:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcEla/O3"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72861B7F6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918985; cv=none; b=fvavVMPgwCY3/XNseKZGT+MHjvKqdgF1lUAgrQ6RFlLN/NP157tcko+ywty1Ep+RJqitcM2kPauUY8lLZFg1Wus3sT7xTT+wugYzPSjtqwVmVbGUtUIfYPnP7MK11dVeLZzis05A8B3sNBqQx4i3wjHX6KNSAsv4YF86T1aA0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918985; c=relaxed/simple;
	bh=Anlt2az+b7Dfd3siRvdJ1NVsMdWOr2QOiUscSVO/2tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGF7qBKw26SZ+SU5CtAD9hO4ErBokOHLfvhhkJBGsvsjX2WbtWkebTsMT4D4BLKVe9B9xjDIOX/NGdJDRCBCKhyDbXRDk1OBFfZYCpA0fVQxyDHKVaxu9xbTGA+9cKu0Jo4ogrYwfHBwxGPBGNHkMW+y/6Xk3dEd5xREJtYz+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcEla/O3; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso2595282276.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708918983; x=1709523783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGcn/WKEFJ2cswi2g4Ma6SzZtBVZ1KQHA19AIyx9qjU=;
        b=KcEla/O3miiYBPNRJa8IniedQlQUXKZZdn9Vw+VmaCKFGlBoKAGNLxWjaH5H4kKxAa
         UrWZ0VU8GgM1+3FpujVRdiMgN3OlHE6ZF8Mx6VNldVjow3jyPM/nsZfip+zARN0aRpYi
         8mb6XWQmxMWMKnC3/eCTpKtWwjaG/MXRgUQhzQF9YL62az+y2Rm91LsGRI4VRr0RMnLR
         kY71c8LPxx+LdUH2TfX689SVPz9pa1Tz2qXGlEivl2Db5LLbwTEbBk6oldeZvZdPzCJK
         49HaKftS9oRUKIbR/84hsF82zrxbsTB4HpZJ8DEy3TKInsVrMnWsY0e6sfozpfWN6rnX
         4D0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708918983; x=1709523783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SGcn/WKEFJ2cswi2g4Ma6SzZtBVZ1KQHA19AIyx9qjU=;
        b=SJQ/fvQrw63/SK0GPHv+a4PmSuHKKfC24JdVBO59yP+hdrlbai8RqbAAEwCSGDirHe
         N379vPwAx20KFY4Pm4jJImqG+SFC66ln0pEaR4+2AU5mjlfOoBxh4aISODuf71pocENC
         YWqnPwvoq7tuR+HIKWXsg1P8Xi68E3aMQQK7s98rtw8ueOAxjL+GntQvegcWgSSGQTxi
         LfiPSeSImktC6CtTPdcvmYGsOabibkFmI53oy2+JMWB+RU8PfsHaw6p7HC3c22HgXn4J
         VcFRuZ03oWd/9GhtyXOxedsCXCbsQX9v9M0M5EqQbn/buzWLv87hSk5x2Z8JuvBDPO58
         Kqjw==
X-Forwarded-Encrypted: i=1; AJvYcCVaLOYJof0SN9olrZLyPGj1irn9dTM+eYtSyqbC/X6/bVf9OyZV7IAJSvWItVVeEnjmRKCitrHkVyNX77tGgBojBhHWsl/XetJrMLAL
X-Gm-Message-State: AOJu0YxZQ0MCVJp+6kMQAum4lccC+K+40q/XqrR2so/t3u6MLGOeXIub
	qiNKorYs/ai8VRMn1cKVeRfXxdPNgLpmmsiiRLCqLDmQx9ZZshwU
X-Google-Smtp-Source: AGHT+IFOJ/JdVetEIEHMkHrNZjYVPIfUfivE2Sk+xCOjnJXhqq+0vwUm5NZXQaHEJ3VbEc5e+RG/Tw==
X-Received: by 2002:a25:694f:0:b0:dc7:4c21:fbd5 with SMTP id e76-20020a25694f000000b00dc74c21fbd5mr3330448ybc.0.1708918982804;
        Sun, 25 Feb 2024 19:43:02 -0800 (PST)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id x18-20020ac84a12000000b0042dcfeda05asm2029205qtq.21.2024.02.25.19.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:43:02 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E2A081200068;
	Sun, 25 Feb 2024 22:43:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 25 Feb 2024 22:43:01 -0500
X-ME-Sender: <xms:xQjcZSQDoy40ltvnvYx5TKUdFHbVsLvL7DHmJso7tSjTHVPJPY6OaA>
    <xme:xQjcZXzKYLUYIeBIxHMh1abIzwttHhslNsHYN4gmSKvu1Ydt7DlsUmc77AmEIpLkg
    o9GcKKQfj2Zkjyl2A>
X-ME-Received: <xmr:xQjcZf320VlR1hjFtpx5ZmODACIgbIt5rxJjAyFW99OgQttV5cpg3qmcvwKIAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedugdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtro
    dttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehg
    mhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeeitdefvefhteeklefgtefhgeelke
    efffelvdevhfehueektdevhfettddvteevvdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:xQjcZeDjbD7X09fCJFlgokg1ZBwd41NR5EheXvzvaSdbG6ea65KRLA>
    <xmx:xQjcZbgK3PdqEAVzMrraOerwHRWCEUkWQIST6hjWtA16B_p2eUzxlw>
    <xmx:xQjcZap82Cy8d5dCyW8quyfKFuw1oOr2_RUSTbF9odMTJCH9QVGp9Q>
    <xmx:xQjcZWV5J7WOIkX4Jqefg_RIGr9FHyA1H2dJQDIkBnZNl6J8B1_5NpwuJvc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Feb 2024 22:43:01 -0500 (EST)
Date: Sun, 25 Feb 2024 19:42:27 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org, allen.lkml@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH 12/17] workqueue: Implement disable/enable for (delayed)
 work items
Message-ID: <ZdwIoyRllkjnSTAH@boqun-archlinux>
References: <20240216180559.208276-1-tj@kernel.org>
 <20240216180559.208276-13-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216180559.208276-13-tj@kernel.org>

On Fri, Feb 16, 2024 at 08:04:53AM -1000, Tejun Heo wrote:
[...]
> +/**
> + * enable_work - Enable a work item
> + * @work: work item to enable
> + *
> + * Undo disable_work[_sync]() by decrementing @work's disable count. @work can
> + * only be queued if its disable count is 0.
> + *
> + * Must be called from a sleepable context. Returns %true if the disable count
> + * reached 0. Otherwise, %false.
> + */
> +bool enable_work(struct work_struct *work)
> +{
> +	struct work_offq_data offqd;
> +	unsigned long irq_flags;
> +
> +	work_grab_pending(work, 0, &irq_flags);
> +
> +	work_offqd_unpack(&offqd, *work_data_bits(work));
> +	work_offqd_enable(&offqd);
> +	set_work_pool_and_clear_pending(work, offqd.pool_id,
> +					work_offqd_pack_flags(&offqd));
> +	local_irq_enable();

Maybe
	local_irq_restore(irq_flags);

?

Because in a later patch, you make this funciton callable in any
context, so it may be called with irq disabled.

Regards,
Boqun

> +
> +	return !offqd.disable;
> +}
> +EXPORT_SYMBOL_GPL(enable_work);
[..]

