Return-Path: <linux-kernel+bounces-56739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1B284CE5F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B16531C23B6B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5D7FBD8;
	Wed,  7 Feb 2024 15:47:27 +0000 (UTC)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D5B7FBC9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320847; cv=none; b=l2A7T+j2kWfK1MLo2ZW/Y7FtNv5/vw9V+YuLr7QHfCyMqUQ460byHUqxLhmm0Umvjd/btFmuYfoLT+xsypHlx6oLID/NihlgAgL4LrjEiq9nUjnlQxA0/671Wg5X/mftJB0qmp1Qp0Pb10e2Jo4CnzBILwZmarpGC9vI7JvywsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320847; c=relaxed/simple;
	bh=dyWYtiGXzFXJ4IwI077Y5XLrNdGOtoniTabO833k+eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNVgVzL/PczdF3f79y8EiKDrLkbJBPur4QWfbailckfdz7FCCAkLZzHdfa49NkG+PiMwgkzQhE0wPyzCd8CjPr4j9JN72Dl2sFnNO6yNnG+BurV3vT9BgcIjIG5UZjFeZjA2s0cylJkMT8TrgOU0nhxDQOI4ZJ17dB4yDJ/ggvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42c44a3e49dso2961641cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:47:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320844; x=1707925644;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EH4QAI1e51e5AItBVUzjoRUHTunfM2rXlK/xs3B5qbw=;
        b=LzJ+Ee7YPl268UkGyBdIBW0XjZa9Ur+y+xuOdODYQdmBic/CMKi6bjkxJfYE4PwGV8
         3JP+30J866D9VvgskAfqW4ZF8NM2gCX2cMQHxylzT8BpnohPKOa8Z93vrsQ9W9hxPk6+
         wnZWI3g8CIomoqzk4Cfh3jJHHKK6I4quKQ28BRiGtQuJaHfPRuneWFQV8NjDNzg2xIZR
         aFlr74yJoHyyHyqHzQ2mkSkadYLhtc6YZNxoMYtJyfQpellYQ4Ve0FkheitsAGT6uc2G
         sRaN+zkG99VdS+oWu4PmLWPlA8j9Wl72GsoJ0JHLx7fOZ21PtqXY+LTUr4Wu2IuqFPXR
         GmBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+DYvryzjrPNsksENbDJf1jn9d5nrk0fOq/Hxac3umQoQw8JP6LWG/b3CdUjSqOAA9i9Z3R1TbUlvrc3k9r/qGDJAFSSj9ak19Fngd
X-Gm-Message-State: AOJu0YyiWJ838FIQAb9TtzYewCRmXNkbDYEK+BthMESx4Gccxg15sEOi
	uSH76GHLxRergbwKu4BfCG3EujsT00jpUAlwpx1BsfxjrNxa3DRP7rJGxt/4jQ==
X-Google-Smtp-Source: AGHT+IFj5BQVZ4HkbvaVuLsW5/vSgXxrjxxPEtPZ/DtIoeQq68kueNtsATKPfnUSerkMiTzWpn4HfQ==
X-Received: by 2002:ac8:5745:0:b0:42b:ebf7:d207 with SMTP id 5-20020ac85745000000b0042bebf7d207mr11986797qtx.29.1707320844599;
        Wed, 07 Feb 2024 07:47:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLpDb25OiRPZPgQY6IeUVI0HZHgU+RVGrYeyDJtizwnQBJv0koZZBP+xzhOKpWHQaxVtdi3VAC9YAwApJ8Cz7XOL/PMqpVrZwUBcEdkSyKQggkIOw4weozWCk/ZQHBjqluhlLQ/4KRQ2SP9mHCi+nhuCIgYM4ocjVSeJTXVhX0jJWH5PwiuiLr5fv7fuMZISJNzKAjnHmmHy0MpmErmER5m1VuLfjgpA2LXcri/SMZkKqYnb/J5PZOjSyUHI95Wi2IQpwzC4EoKilWzVIyB9ouW6HiSE+dDBK69z6jWbM1x7IwBYKj
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id o13-20020ac8698d000000b0042c18b0fb1asm626781qtq.56.2024.02.07.07.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:47:24 -0800 (PST)
Date: Wed, 7 Feb 2024 10:47:23 -0500
From: Mike Snitzer <snitzer@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alasdair G Kergon <agk@redhat.com>, Hongyu Jin <hongyu.jin@unisoc.com>,
	John Wiele <jwiele@redhat.com>, Matthew Sakai <msakai@redhat.com>,
	Michael Sclafani <vdo-devel@redhat.com>,
	Thomas Jaskiewicz <tom@jaskiewicz.us>,
	Yibin Ding <yibin.ding@unisoc.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the device-mapper tree
Message-ID: <ZcOmCwaun6SRXShJ@redhat.com>
References: <20240207144053.1285b3e2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207144053.1285b3e2@canb.auug.org.au>

On Tue, Feb 06 2024 at 10:40P -0500,
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> After merging the device-mapper tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> drivers/md/dm-vdo/io-factory.c: In function 'read_ahead':
> drivers/md/dm-vdo/io-factory.c:118:17: error: too few arguments to function 'dm_bufio_prefetch'
>   118 |                 dm_bufio_prefetch(reader->client, block_number, read_ahead);
>       |                 ^~~~~~~~~~~~~~~~~
> In file included from drivers/md/dm-vdo/io-factory.h:9,
>                  from drivers/md/dm-vdo/io-factory.c:6:
> include/linux/dm-bufio.h:86:6: note: declared here
>    86 | void dm_bufio_prefetch(struct dm_bufio_client *c,
>       |      ^~~~~~~~~~~~~~~~~
> drivers/md/dm-vdo/io-factory.c: In function 'position_reader':
> drivers/md/dm-vdo/io-factory.c:182:24: error: too few arguments to function 'dm_bufio_read'
>   182 |                 data = dm_bufio_read(reader->client, block_number, &buffer);
>       |                        ^~~~~~~~~~~~~
> include/linux/dm-bufio.h:64:7: note: declared here
>    64 | void *dm_bufio_read(struct dm_bufio_client *c, sector_t block,
>       |       ^~~~~~~~~~~~~
> 
> Caused by commit
> 
>   82da73bac1ee ("dm vdo: add deduplication index storage interface")
> 
> interacting with commit
> 
>   3be93545346e ("dm bufio: Support IO priority")
> 
> I have used the device-mapper tree from next-20240206 for today.

I've just fixed the device-mapper tree. Sorry for the trouble,

Mike

