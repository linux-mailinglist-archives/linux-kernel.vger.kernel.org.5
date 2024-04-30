Return-Path: <linux-kernel+bounces-164023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D308B7744
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8570B1F2252C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F24171E75;
	Tue, 30 Apr 2024 13:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htKrw6Kf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005F1171E71
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714484173; cv=none; b=MppBgQitRSj9vvtAOHxmlwkpUAEN02AdgAfEDV2KSjikNbK78MVXKsasUgU50iYq9dsmQcxCzs3OIN6SenrmJ7wR0rn0S4Ma5A57u9Tr4it47ZujGHKws+8FSee2Ul5/7q9qV8S6yWraLYiAjV7leYZjKMFWh7qBYUmoLyEAHSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714484173; c=relaxed/simple;
	bh=BT6nfyV4uk8xm25Isa+tjRkP93nsj9rWL3ISJtY6I4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU9iFQGddbUxC3/ttxg2aibB+ZbK9rVg/J+v4vGLczZeMc24xg+3zsb6OsDwyzu9/TjYBNd3O3ury87zmMB7e6kd3UNyqMATZQWP2+biSg9qtLI08nxNRP+bPU+ojYFr0+BN1JD2g13isfdT9+driwRoU4tftL8DfGqqtH3V7RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=htKrw6Kf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714484170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X39GiTLDBKMPfoBDISZFmIycGpaQv/DxiE0jSscvhBo=;
	b=htKrw6KftzhZqDpiBybpbWsF4ZiVbeQbUieHM6x57g7io6DDbsBG6Og//9/OEWqn1AKz+Y
	IGTW1v6UJCf5sjTTMWQKu1+dDVJiyjxcBGmUluiLFjIdZ10xTjRgmcAl9XilyR2BoDK3af
	3DTjeCg+JSbRQseoKDtp4n4543yAMUg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-pzfCSVaINmuEwHVJ-KAbFw-1; Tue, 30 Apr 2024 09:36:09 -0400
X-MC-Unique: pzfCSVaINmuEwHVJ-KAbFw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-69b6e12ea63so22190086d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 06:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714484169; x=1715088969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X39GiTLDBKMPfoBDISZFmIycGpaQv/DxiE0jSscvhBo=;
        b=qNYC7fQmwzN9/revIyYsvsm19Co8MVPniRt5pfb+FJp9QJxjoXVJ0ieI2Hjhd5giNK
         A8ijWCn8AH2HaR/2RQJ3mXNHXclhp717Vt8N1g01c+TJ8R9choUDS6PbnjJZ3v6iZrLS
         iFRjQT+WO9Sf0UUAOSU7R/cLKao0GF2J200D5H9Dqj0l5qSg1mwAYRR1+Y/2OS3WKsKU
         Czq2xKsbj+8cyP/XFhDOaUkNqOtDtSS1jSR5uLqlyWsy04TsMv+cPdbQ8/UnMLxSd/hC
         4xz9PNW2l3jEOG6Sc7EXRNpCPswTqcD4drJ9RHSynahh4IMKO1LtkuHojO5vSW/fe2oo
         3Ayw==
X-Gm-Message-State: AOJu0YwrEzFM3qX+B+snPFREFtILFqDUTVQL4QymO4YVpSzckCPpszf4
	CN1QJ1A8paz2rSJVQEGRnK3KivSVFHF+RjhZ+TFhVSF+wjgpGYNlQCzuMrKQvH7OqrlP4I4pv38
	bq6YD1kR0bNZi5Lp4TZ53NYPkqQNBvj7QssRcSD7PQcKc21XE3bSqld0CFDos9w==
X-Received: by 2002:a05:6214:411b:b0:699:dfe:6015 with SMTP id kc27-20020a056214411b00b006990dfe6015mr14696152qvb.5.1714484168652;
        Tue, 30 Apr 2024 06:36:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESpSTho+aha4lI1SDbS2XZA+HSwgqi2ttcjxIWV9PibJjPOqo5Au0EYQEDH29ebG39tMI31Q==
X-Received: by 2002:a05:6214:411b:b0:699:dfe:6015 with SMTP id kc27-20020a056214411b00b006990dfe6015mr14696112qvb.5.1714484167928;
        Tue, 30 Apr 2024 06:36:07 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id z15-20020a0cf00f000000b0069942e76d99sm11384559qvk.48.2024.04.30.06.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 06:36:07 -0700 (PDT)
Date: Tue, 30 Apr 2024 09:36:05 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH v1] selftests: mm: gup_longterm: test unsharing logic
 when R/O pinning
Message-ID: <ZjDzxcrP_tDxo-X6@x1n>
References: <20240430131508.86924-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240430131508.86924-1-david@redhat.com>

On Tue, Apr 30, 2024 at 03:15:08PM +0200, David Hildenbrand wrote:
> In our FOLL_LONGTERM tests, we prefault the page tables for the GUP-fast
> test cases to be able to find a PTE and exercise the "longterm pinning
> allowed" logic on the GUP-fast path where possible.
> 
> For now, we always prefault the page tables writable, resulting in PTEs
> that are writable.
> 
> Let's cover more cases to also test if our unsharing logic works as
> expected (and is able to make progress when there is nothing to unshare)
> by mprotect'ing the range R/O when R/O-pinning, so we don't get PTEs
> that are writable.
> 
> This change would have found an issue introduced by commit a12083d721d7
> ("mm/gup: handle hugepd for follow_page()"), whereby R/O pinning was not
> able to make progress in all cases, because unsharing logic was not
> provided with the VMA to decide at some point that long-term R/O pinning
> a !anon page is fine.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


