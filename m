Return-Path: <linux-kernel+bounces-119759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D78A188CCB3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153091C22CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9513C13CC44;
	Tue, 26 Mar 2024 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H4SWdBf8"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676D128807
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480067; cv=none; b=skHL+uJ/oV8iSBZyIOwxk61iTfHE5h6paDmuYbvZODnm6EroWAD8aDjsLPxUwH1nELwvBw3yL1GIDHWiZOc63pbqkZS/YeS2Aoxl9WgrmIoeXPB14SAJet22ViCBTrBJAL3LashJyKl3IG1DruIkvcilhFPPZeHEMuUFP2Y+3QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480067; c=relaxed/simple;
	bh=Lqc9pjiV7j4DU0vzMAEDlb9FYCZTenHq/XANizmEr7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vEH1yvybkupUAIA93oFLPjArhzFckffsxnWQiRh4+sjNL6puTR/kX+/SjYe3ZyXjxt2bjp/ljj663ZAQxSNqkBz8uzIJQhafwqSXxwQxAlAW/M+esmUZTdnlIbGXtSysWIRkiKDlTZSc8YtFxIOV3SlCcGjiU7EKFWn5N6Qvehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H4SWdBf8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e6a9fafacdso4531593b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711480065; x=1712084865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BlKH85coPfvLXGKgP52Ck14DTun5Z9ZO3eF7ngWmZ0g=;
        b=H4SWdBf8EXOhU7WL9RAYfJXA7MSrkfAmGk8x13gEmVfZRbYdCDVVr6dpJIMnfXj+LU
         ytYZ1InfVo1wSQ+QZTiZAZFxhQCa7xuaorbQ3ZX31/poCwKXZl+BNYL5CmlXUvdPG/RX
         Bx4AMrpW0EHuNrnqiwtJOaK/j/hs8y18dJleE9dFuV0I7Rs6o4qs+WdApR5LpZFb4VZL
         eq0f6KDcB8HdbV1kKTiCk6w0GdSbf7tYUYQtmxP33iBGQeydW7X4YEukz0xwzvxW6qhv
         NeiCkOy1NBfUSJJksdWRyN3b5SYuoTYoG6bhqTewYeoDS4qPkrGkQjtmWK1VwGD55coM
         qLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480065; x=1712084865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlKH85coPfvLXGKgP52Ck14DTun5Z9ZO3eF7ngWmZ0g=;
        b=F+qHEqk5JFoGSYiLh3uPslO1FdXhjRpexmTZDTy7/iOlvoJ9YBa+Sw1uKNUViZ9Ldv
         hIBw++7sIt9LMLAhptEI/FrXUEBnVHOdXbvEuLkI4w/WbC9KI4H00QCT/D0hMrxxGcRJ
         udBPflRh/Ifn7ifLiyCf4GT3JKF1ikxTWpgaKuKSPr5LYyHHnN2A9VX+zU0npU5YUDWo
         7imR35nf1XQ+HCwfrwL4iq41vqThxfPLlvo++6RVojgkONLq/IK8Gm3NXFV2YRCf2apL
         /TppT+ApHnRUuG7gHdWFBNFchYvFLbEu5I4ouTPugPv+HhUR6U/ydHniW8+An3oQ5Yc5
         /ZZg==
X-Forwarded-Encrypted: i=1; AJvYcCV8S3q2F/QsEthUKkvydNsWJaYBMSbK8zEFehmgLEtdSHl8NXgNI4x55bZrRX/xUZLg/iN4tbiP2OlLoXUtZJf+FJjxmCO12PRLPlIy
X-Gm-Message-State: AOJu0YzlbuKRFyaqzZ5//aiSmziT/1QSZ83Sk/V0RIFKKGiDKOD9yCw4
	NcUrqUsX8HnbQAtwhQarb0HKWV114UdA7uiiD6djz/mEepDrM50c
X-Google-Smtp-Source: AGHT+IEEFY1XjrNqa1/3v96ZwnVdDhFYP1oZvq2A59ICrpFz65Qv+OLccXZpvBRh8GpimnMYhACUuw==
X-Received: by 2002:a05:6a20:1a07:b0:1a3:5c60:112a with SMTP id cj7-20020a056a201a0700b001a35c60112amr395260pzb.36.1711480065179;
        Tue, 26 Mar 2024 12:07:45 -0700 (PDT)
Received: from fedora (c-73-170-51-167.hsd1.ca.comcast.net. [73.170.51.167])
        by smtp.gmail.com with ESMTPSA id y14-20020a056a00180e00b006e68b422850sm6303432pfa.81.2024.03.26.12.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:07:44 -0700 (PDT)
Date: Tue, 26 Mar 2024 12:07:41 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
	rppt@kernel.org, willy@infradead.org, muchun.song@linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] minor fixes and supplement for ptdesc
Message-ID: <ZgMc_e4_lQpkHm1L@fedora>
References: <cover.1709541697.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709541697.git.zhengqi.arch@bytedance.com>

On Mon, Mar 04, 2024 at 07:07:17PM +0800, Qi Zheng wrote:
> Hi all,

Sorry for the late review. Thanks for looking at doing some ptdesc
conversions. This patchset has the right idea and looks *mostly* fine.

> In this series, the [PATCH 1/3] and [PATCH 2/3] are fixes for some issues
> discovered during code inspection.
> 
> The [PATCH 3/3] is a supplement to ptdesc conversion in s390, I don't know
> why this is not done in the commit 6326c26c1514 ("s390: convert various pgalloc
> functions to use ptdescs"), maybe I missed something. And since I don't have an

It's important to keep in mind the end goal of ptdescs, cleaning up much
of the struct page field misuse by standardizing their usage. s390 page
tables and gmap are similar but not the same, so the conversions require
deeper thought. 

My initial "Split ptdesc from struct page" patchset tried to focus on the
most straightforward, simple conversions in order to introduce the
descriptor and lay a foundation for future conversions - you can see some
more complicated iterations v6 and prior.

When converting to ptdescs (and any other newer descriptors), we should
be careful about generating superficial code churn instead of using
them to solve the problems they are trying to solve.

