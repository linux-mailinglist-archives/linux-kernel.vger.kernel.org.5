Return-Path: <linux-kernel+bounces-26944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2837582E85E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 05:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B49D2B22A73
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 04:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D0379C0;
	Tue, 16 Jan 2024 04:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SuQnNGW0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250F6FD5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 04:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705377736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eN8wKTG2df7ETKZTMCzRD2NROS0XfcHgZd5DcL2huf8=;
	b=SuQnNGW0nW5MjJIg/Zp94ZkT3eG8+T4L1WsFcsgCG1wqoOVq6AOGjgSjA65pYsKXJWlZTB
	KUPNJY8xkPgtyW8A2QJiGv6cy0s2F4UB2xGqzcZ0mvWJscwzTL8s/kOE2fDZ51Edbt0dXo
	/LeoIkPg0FRbhLnGuuOGQIam1S7mA+Q=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-bw-2pFa3OBGmihYXVmnHeg-1; Mon, 15 Jan 2024 23:02:13 -0500
X-MC-Unique: bw-2pFa3OBGmihYXVmnHeg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7833761135dso906712485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:02:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705377733; x=1705982533;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eN8wKTG2df7ETKZTMCzRD2NROS0XfcHgZd5DcL2huf8=;
        b=oBehDQRhMF3cZ62YFaZUrKcA4cPMrgU4TDzwobpvAj2/vC65fJ+PSKVT0tU7OTnPCp
         IeujMQADRd66NcXmaKwH5vVkc672+KrG0bALfDkbZT8CUvGcYx64UVP7k/Sudksci9Hh
         yqMsYNRPJbUZjoi+fU+jpISLyuIZsBwl82WSTC2N8uUPy9u9bT0OB3Alu96TMMmzbRm/
         RBlKw0DH7/UCiBBMN73CrNHOKzHuhGD99W5LyhucmdbdKRQYYN124U+msRZBcTY+RO3P
         Ls5gL+3hqtprxWhG4qkbR5OUqmkOr32ZKjpavi3qGnvn9fW5ghlfjj17n9IyMgVOvP4C
         sCoQ==
X-Gm-Message-State: AOJu0Yzdv2JIOovLTJqSMd9ZI8X7Qj//EnR03SMLEeNv23jaVrWwMRPa
	GYGvGe9kvLV41Uji/X4XrMjvV4813wqMowWNnhEY45nOBeMu6ROILeWmn0X+oU4iDGBUuxDwj1n
	Ni9q0/9GtbG3FIOJKrBr6/J/L9tQl6G0F
X-Received: by 2002:a05:620a:2983:b0:783:5195:408a with SMTP id r3-20020a05620a298300b007835195408amr5876981qkp.79.1705377733415;
        Mon, 15 Jan 2024 20:02:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEN6gIx9IqGFmyh2GEnwwBhoFZGR41zZEGHlDZ1mVdZGWyhXlUZdr2U8IoRwrewEbsHOcJ1Pg==
X-Received: by 2002:a05:620a:2983:b0:783:5195:408a with SMTP id r3-20020a05620a298300b007835195408amr5876971qkp.79.1705377733112;
        Mon, 15 Jan 2024 20:02:13 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:1b3:a803:26a5:3f32:e12b:5335:3c2d])
        by smtp.gmail.com with ESMTPSA id b6-20020a05620a126600b0078323aef218sm3401340qkl.80.2024.01.15.20.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 20:02:12 -0800 (PST)
From: Leonardo Bras <leobras@redhat.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Leonardo Bras <leobras@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spinlock: Fix failing build for PREEMPT_RT
Date: Tue, 16 Jan 2024 01:02:09 -0300
Message-ID: <ZaX_wZTlhFI6eVoq@LeoBras>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <yzh3yw3fsdptmlo4d27zakov3wkqzo35wenro3zaafyagfovuz@mp42k5gyfgcg>
References: <20240115201935.2326400-1-leobras@redhat.com> <yzh3yw3fsdptmlo4d27zakov3wkqzo35wenro3zaafyagfovuz@mp42k5gyfgcg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jan 15, 2024 at 04:54:14PM -0500, Kent Overstreet wrote:
> On Mon, Jan 15, 2024 at 05:19:34PM -0300, Leonardo Bras wrote:
> > Since 1d71b30e1f85 ("sched.h: Move (spin|rwlock)_needbreak() to
> > spinlock.h") build fails for PREEMPT_RT, since there is no definition
> > available of either spin_needbreak() and rwlock_needbreak().
> > 
> > Since it was moved on the mentioned commit, it was placed inside a
> > !PREEMPT_RT part of the code, making it out of reach for an RT kernel.
> > 
> > Fix this by moving code it a few lines down so it can be reached by an
> > RT build, where it can also make use of the *_is_contended() definition
> > added by the spinlock_rt.h.
> > 
> > Fixes: d1d71b30e1f85 ("sched.h: Move (spin|rwlock)_needbreak() to
> > spinlock.h")
> > Signed-off-by: Leonardo Bras <leobras@redhat.com>
> 
> I've picked this up - thanks!
> 

Awesome! Thanks!

Leo


