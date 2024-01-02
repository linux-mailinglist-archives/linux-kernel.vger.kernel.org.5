Return-Path: <linux-kernel+bounces-14208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9570821918
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5E11C21A5C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBB2DF68;
	Tue,  2 Jan 2024 09:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5nzt+PV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0157BDF61
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 09:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33686649b72so9407982f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jan 2024 01:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704188975; x=1704793775; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9IdYDocnY8f+cYqz3KbusbOjRD+EWHCa+eZhkdi3Tg=;
        b=E5nzt+PVsC1WWw/GnNXeMOcIsWz9pMRLRdEWsVtHiIRalkCsM7gYCMI0fR1IDUnWq0
         pH6tv44XRSYjs9XBan76wb6cG/RmQC59r8gD69XKAEu4GcqevuEwqSZxjDZmFza6Wle1
         RZ9EwRkKPspdQ1XZnuvsX+d84BTsTVYyxbUNnR5vBAASdLNP9gi5vnV5Y0YaX0RrlGKE
         q170rjyHYQtm3ETmjeClzAEslYG7Hd/WURBteamKLR8aP8YYna9yZgQ9GaEfjvZ+nHlb
         2h1ui4Ll4O/8PZqmtg1Zoq6jAzSmAiiOWyNxCV2wLDHJBJY7Wf5izKHrCvi5v+Ytr1yL
         aD1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704188975; x=1704793775;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9IdYDocnY8f+cYqz3KbusbOjRD+EWHCa+eZhkdi3Tg=;
        b=ukhFREKROut5OKvUJo5akeJSc6oK/bXxCb29fOVJJJ7ATiV+2vwP3xqRGD7GtISqSu
         KRQm7CMjrIkeQd7cUCKg+icnjqZ0D8bak68g4dzzQaKJ8RDodQteMLQ/su9OVetVQ1Gc
         k9lDAZIs1feQ509Y8n0K7uAeXlJSxUjUnXhr51a6bqLjNzMQsDQ7CcbyfAkGc4l7oFaA
         HXVwl81qEEP5xW80rBO3RgnB3UKn+jGaoAf7AIPIearSnIS9zvH3OQO15odphohyIXmO
         wyKixSWkzpFbEShdpqLmIQvqwj7Wyw3+d1V6u7NXu+GuxvVxOLNDWV1R82cS+S3gfitA
         sL6Q==
X-Gm-Message-State: AOJu0Yzy+zUey5atlI1uw96I+3M2eehA4AbnX1GvoHFykHQFw7VacPbN
	w0XTax2EBv8+d2PPV+1k8JM=
X-Google-Smtp-Source: AGHT+IGFPcA3voqNTRf+D2XH2sdzWpXKt9lIQ2glivPEa9CMhBsId3NfbqvRNF+wplZBb2rOFINj4g==
X-Received: by 2002:a5d:4bd0:0:b0:336:7790:6a36 with SMTP id l16-20020a5d4bd0000000b0033677906a36mr9470376wrt.129.1704188975145;
        Tue, 02 Jan 2024 01:49:35 -0800 (PST)
Received: from gmail.com (195-38-113-95.pool.digikabel.hu. [195.38.113.95])
        by smtp.gmail.com with ESMTPSA id h17-20020a5d4311000000b003373f723dcbsm5136543wrq.42.2024.01.02.01.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 01:49:34 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 2 Jan 2024 10:49:32 +0100
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
Subject: Re: [PATCH next v2 2/5] locking/osq_lock: Optimise the
 vcpu_is_preempted() check.
Message-ID: <ZZPcLJSbfab8pweu@gmail.com>
References: <2b4e8a5816a742d2bd23fdbaa8498e80@AcuMS.aculab.com>
 <3a9d1782cd50436c99ced8c10175bae6@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9d1782cd50436c99ced8c10175bae6@AcuMS.aculab.com>


* David Laight <David.Laight@ACULAB.COM> wrote:

> The vcpu_is_preempted() test stops osq_lock() spinning if a virtual
> cpu is no longer running.
> 
> Although patched out for bare-metal the code still needs the cpu number.

Comma missing.

> Reading this from 'prev->cpu' is a pretty much guaranteed have a cache miss
> when osq_unlock() is waking up the next cpu.
> 
> Instead save 'prev->cpu' in 'node->prev_cpu' and use that value instead.
> Update in the osq_lock() 'unqueue' path when 'node->prev' is changed.
> 
> This is simpler than checking for 'node->prev' changing and caching
> 'prev->cpu'.

Throughout the series, in changelogs and comments, please do:

 s/cpu
  /CPU

Please be more careful about changelog quality.

>  struct optimistic_spin_node {
>  	struct optimistic_spin_node *next, *prev;
> -	int locked; /* 1 if lock acquired */
> -	int cpu; /* encoded CPU # + 1 value */
> +	int locked;    /* 1 if lock acquired */
> +	int cpu;       /* encoded CPU # + 1 value */
> +	int prev_cpu;  /* encoded CPU # + 1 value */
>  };

s/ encoded CPU # + 1 value
 / encoded value: CPU+1

Thanks,

	Ingo

