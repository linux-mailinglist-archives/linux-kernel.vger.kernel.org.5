Return-Path: <linux-kernel+bounces-14209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFFE821919
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D74681C21393
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC583CA78;
	Tue,  2 Jan 2024 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEX95bv8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A033ECA64
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-336897b6bd6so9083677f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 01:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704188997; x=1704793797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=czuPNSsZEEViwXKMxRjI0Bf2/iQSweSghdx0XFLXISw=;
        b=XEX95bv87Gu9S2r9EfXB+rH1lCQm9dXBC4b0UTgCTu4TZ9Rro5kq+ETMZ0Cb7t5oAT
         E9pTQzDBMoJNA/U+JuPwCsT75gT6DUQFrZlFVLkQSInfU3gQz2bBekhI1RC53VOOLScL
         89TIU3IT6CuGhGyI37XwSt/pOKO2RJ3TNHDalrHFa+nOrwAwSsKHQeTAOR5XpeKzBIex
         8bvv00MEHyLW1K2QGGzBWINhK3nPfU5fL1mMWQOnxpj8JJURcZXlbcIIDwUTc3UBz9c+
         2bDD6kR83rG6yRy7e6QIgjHSF9DuCz3MJlm4/u7Q7hyWIHac0zoNJzivfy+lEjxKa9KV
         /AdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704188997; x=1704793797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czuPNSsZEEViwXKMxRjI0Bf2/iQSweSghdx0XFLXISw=;
        b=NJDID4sk5rp45a+y99J2B8D9MeTS/s9jOUDHr32oayIANCS89RWVztXxrj2R2GNTB/
         DCYTQVpR7m2+bNoQlGmgtnYzdgBS4P7UYjxRslSg1SCdSjXJwtg4NkSZN/ZO1XFqtUaI
         SQqWAV0u5JpQwoW0v1wcO2p0QdQYXu59k+r69rlbUo5ZaBVsbqGqH3aQz0GibGVWQS50
         dkrA2NcxOV/xnHqpH4tzYLCePeqD2bEr3RgjsxZU42ZB0+p1ahZ1i8B5f7gfNHCPgPAZ
         bt/ALfGu1J9Es+LXb+5Qtj6ZMlFDLlumR+KDirKDbTfvDgFzQ8g0Ibt2uGmndeWsI7Ph
         15eA==
X-Gm-Message-State: AOJu0YyGZvfkBU0XBKY2CH4+511sg69AW/9Lm266UHYTxkDNW+qyT0H7
	eoNHO7bUDg1bmELLGAK8K04=
X-Google-Smtp-Source: AGHT+IFyL1kGzmCf7lxa2xG8+lAeF0tqLdKViQzr82/M4+rH5ogcX/7IRHOaL8FuAajxdwVnvWcTNw==
X-Received: by 2002:a5d:598b:0:b0:336:ef13:301c with SMTP id n11-20020a5d598b000000b00336ef13301cmr6579876wri.111.1704188996642;
        Tue, 02 Jan 2024 01:49:56 -0800 (PST)
Received: from gmail.com (195-38-113-95.pool.digikabel.hu. [195.38.113.95])
        by smtp.gmail.com with ESMTPSA id u17-20020a5d4351000000b00336f05840c4sm15268416wrr.100.2024.01.02.01.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 01:49:56 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 2 Jan 2024 10:49:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>,
	"'longman@redhat.com'" <longman@redhat.com>,
	"'mingo@redhat.com'" <mingo@redhat.com>,
	"'will@kernel.org'" <will@kernel.org>,
	"'boqun.feng@gmail.com'" <boqun.feng@gmail.com>,
	'Linus Torvalds' <torvalds@linux-foundation.org>,
	"'virtualization@lists.linux-foundation.org'" <virtualization@lists.linux-foundation.org>,
	'Zeng Heng' <zengheng4@huawei.com>
Subject: Re: [PATCH next v2 1/5] locking/osq_lock: Defer clearing
 node->locked until the slow osq_lock() path.
Message-ID: <ZZPcQu9WsMdMi9d1@gmail.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <714ca2e587cf4cd485ae04e5afb8d5bb@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714ca2e587cf4cd485ae04e5afb8d5bb@AcuMS.aculab.com>


* David Laight <David.Laight@ACULAB.COM> wrote:

> Since node->locked cannot be set before the assignment to prev->next
> it is save to clear it in the slow path.

s/save
 /safe

Thanks,

	Ingo

