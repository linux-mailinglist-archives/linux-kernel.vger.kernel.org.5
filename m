Return-Path: <linux-kernel+bounces-45216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3374842D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3724BB238B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFF369E0B;
	Tue, 30 Jan 2024 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QfPxvVCy"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76A1E539
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643956; cv=none; b=MJW1AAAnnzyYVZzCher3o6pa02/5t0+4vLP36N/m4h22i9w6fREPBCM4HrsyqrlBAd/aoxVOuZe4kouK7ir1OClDe6M18rh/MKQWFnP1j1hNW/OHlKMCjbUDjfXE+Wae5GAmOe3uF7KlykRUk8K3wlqCZxM8u/ygLopD/7xBDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643956; c=relaxed/simple;
	bh=49sMRWF/K6QFNGgIHdO81t040vFV+oPiN1D4LAMvBx8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CHKPjzv8QNl31Id3v+FiWQMrlDobS7aLvWSXCkDeCvk/WkI2RLRhDhjNw2mz5Lj/rs0+MKxen0PmeQuYenNYXRP2fbbcmd/KA78yePOfmKQq/6cSmOAG7HK9DRnqqBd3KRQvP9S+BZZzqNxJGzzhr0LahM9Nf/2Mls5U/ujNqXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QfPxvVCy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso67983597b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706643954; x=1707248754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=49sMRWF/K6QFNGgIHdO81t040vFV+oPiN1D4LAMvBx8=;
        b=QfPxvVCyoEstTqab3CC9CqtB8vAggEMAeBi4sr01jpT3MoxwIzCj1NAkw4h4HnCVCM
         2hBWhi/gJ1qlUxwEsPrOlnSQOw7Z2kRsZHxmUUTuCkuabI9hHF810jh3qZ8JjmZytN46
         Q82fGSI7nEMAuvy3SXViypRRo+vVDFDmcfyvwhi493w/9Th4I0EsaGl4Ip6Q+xcGkFAQ
         I4fcr6yYSW5Ip/dxps89C52wpqaU5PKPkG7RUqD0tAy0aqU/uj53Xk5PNdCONhpcpvAK
         e0jEFsTEZW6QBwcWXMdWjjZkI8UhXwpMmi87c+jZeqWysVoDQV9E9fS3te7morSMj2KK
         hVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643954; x=1707248754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49sMRWF/K6QFNGgIHdO81t040vFV+oPiN1D4LAMvBx8=;
        b=tlzhA1Q0S0hZuEdZFUtt/x/eAJqBh6kSKKrRcW1SbRxQw/IHSJUvCGh42W6gaBG03v
         deaKZH593XkyQyCyWB2+0wyn1h5OlSFi2LWubZoWsGV4oYAUvmlm7HvqCofzE/jD/Ddl
         j6dZTRl1NrLLs1R+NcciprAJbdIV+lLJmU2zrA+SSvmr+AvM+HLRr6XQXoYl57Noe9Il
         D1Hf/XlKOCg7nLOMZJMXSywtXd9rw82WgVRa7QHFWLW54Da65SnEMXkwpo6O1FrPq8Vv
         f7/PvsbBvS2LJeaDPYa3YPfLCp9QU1BgpSWMGq0NQckwNg4LJHX3K5/KGoyH6Myp6HOS
         p1wA==
X-Gm-Message-State: AOJu0Yx0a1nVUYZ6jC96448NmbBBEhMRopRfgFzcAEjnzF94nNfJ5naD
	YiX6UlIJSQF4Su69LWKuhxWG+fvKo0iPJH8crpsazrzUhrMNlBPUW4WlqsozijOK/tIYGxvCp+n
	rKw==
X-Google-Smtp-Source: AGHT+IFiD2PV3VakBYat7YXgkSMHUliCXpyd+Lnfy+NMI8f+8ne0cXTgDDnTKDkQ24stdY7WUy8JegD8MeI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:86:b0:602:cb41:99ad with SMTP id
 be6-20020a05690c008600b00602cb4199admr1775988ywb.7.1706643953768; Tue, 30 Jan
 2024 11:45:53 -0800 (PST)
Date: Tue, 30 Jan 2024 11:45:52 -0800
In-Reply-To: <20231218161146.3554657-1-pgonda@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231218161146.3554657-1-pgonda@google.com>
Message-ID: <ZblR8D906iGypO1o@google.com>
Subject: Re: [PATCH V7 0/8] KVM: selftests: Add simple SEV test
From: Sean Christopherson <seanjc@google.com>
To: Peter Gonda <pgonda@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, michael.roth@amd.com, 
	thomas.lendacky@amd.com, joro@8bytes.org, pbonzini@redhat.com, 
	andrew.jones@linux.dev, vannapurve@google.com, ackerleytng@google.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 18, 2023, Peter Gonda wrote:
> This patch series continues the work Michael Roth has done in supporting
> SEV guests in selftests. It continues on top of the work Sean
> Christopherson has sent to support ucalls from SEV guests. Along with a
> very simple version of the SEV selftests Michael originally proposed.

I'll post a v8 this week, I've already done (almost) all of the changes needed to
get this into shape.

