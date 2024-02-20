Return-Path: <linux-kernel+bounces-73320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0D185C0EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D9041F223F2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F31976416;
	Tue, 20 Feb 2024 16:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="yKnHUgQv"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAF276059
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445750; cv=none; b=n7ztmill7VlhNNekAcKagRjJJS3mPi16f8qOTvm93VeJ/3dhvtVgMhdCt0120r9lRvG4EOpWWqISXJ5jVmsazwfDiRsAzKYFfbVc5vsPOw/3+x2v3bkx1h+Z99ndVTXMQka+v9rJOnBvJMbGNlPyORCqsfYzlLqCBvGJZlLL9ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445750; c=relaxed/simple;
	bh=Rjvp4u4/TfjTiLTVYcv9zy0VUUt4tTVk9oECtAyxaMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jxjrb28TZORfpXbQMXoeO1FRfTyTKgWuDEUVGOfk0EtKdr+LO+Ho8YnOrZVZoDTgZUx/LnrwMsxSsDmtkZWP1cr1ctqkYJ8C8hF0A9BqBP1i4yVGUczowAypZRPIHGOT7YdcsosX+45sNskawATpZfT81tS9waWKlRT/tDulpOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=yKnHUgQv; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-41271096976so3792465e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708445747; x=1709050547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oexcpEK3SYlZj1vKQUs7VxLt0dPuJjGzyfbCkVDC4Qk=;
        b=yKnHUgQvRerbbe48jEd1D/T18284fTxXOyWuxJ3MhKK4RQcRFCsWRxQU7j52vbrWrb
         C4dnyjb/K3tFatT+CvqtG3h0QC5a2VRAZcY854fuJRF3aN0wJcA/C7KiKi7ntzP+2oXy
         NniSz9GTF/RgTSokT8hLtKrCwpZJx2goIsFmoDsW3p/5x2XtDCsHjYtPHYbtxEjZKjdk
         lHxVXLJ78hfs2q3grWmat8MlOw7eFtE5wT0ykyxbG52kNEe7ZKIBWJgLsrgfFwcOgPcg
         gQ594y2kcVtFODNwXj8PUa8TyKeLQAI6l2iREQxsasyf08ixb4UrLoq1TELJVWn827jG
         j40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708445747; x=1709050547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oexcpEK3SYlZj1vKQUs7VxLt0dPuJjGzyfbCkVDC4Qk=;
        b=RF7wiOIh10qbRB3ZRbRLHuIhTCqsWQ7k22IjHqx6Sracxx3SIAxEqOP90dB9PbrOBU
         wkpsVt1lDfpd8iTXJredwXV7G2QmoEabXbfoKwkDxXUNNJHR9lbdg0dLKyuKmHiiGg5B
         h7dZiXsVFQY1P1JpKn9V3bKhYBIz4VR3VHLDatxCno5DzNScAPwr8Oxxa9DnsxIHzWx8
         //CF8+E7MIVSRTsfAvZOSH6YSiAPYHTN+MVyhk4tT0e3XVInMZj/hILOsjkL524CEj2Z
         HFYQBEW9gLckWyT2WV182L+Bv76ZE8WiFRpkGjuiFNii8zIBGcAwzsbGWtFWqnzruY2Z
         sERg==
X-Forwarded-Encrypted: i=1; AJvYcCWcpWub6zCckM0bJEF80eEu7m+CA93xJEXMxOVNFzdJnYib4+TfiT3l7Rn4vs+J8TvGVz3QU8lxucl+eYzYWADNepXIrpCkp0LtmAKj
X-Gm-Message-State: AOJu0Yy0baLmawrxgyp+5nki09jj1A/RQbX46DlHDy0xXGPplwVl1oMt
	a11rz89iNeTy56qoAsSkUht+aBAdCK5SGQIVCLMhNVXHIxvjL1jDfI3r29q+rSc=
X-Google-Smtp-Source: AGHT+IGC2SdP4KuI2gjhiI6gXAleG8heqXMKLqUNP7rwP7YQvXEOg8Ka1L8oMAsqaWUWqa+AwbeTBw==
X-Received: by 2002:a5d:5f91:0:b0:33d:4c06:8614 with SMTP id dr17-20020a5d5f91000000b0033d4c068614mr5208825wrb.37.1708445747511;
        Tue, 20 Feb 2024 08:15:47 -0800 (PST)
Received: from airbuntu (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id ci3-20020a5d5d83000000b0033cf2063052sm13947115wrb.111.2024.02.20.08.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 08:15:47 -0800 (PST)
Date: Tue, 20 Feb 2024 16:15:46 +0000
From: Qais Yousef <qyousef@layalina.io>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <Pierre.Gondois@arm.com>
Subject: Re: [PATCH v5 2/2] sched/fair: Check a task has a fitting cpu when
 updating misfit
Message-ID: <20240220161546.7r3leteuqygf6jxc@airbuntu>
References: <20240205021123.2225933-1-qyousef@layalina.io>
 <20240205021123.2225933-3-qyousef@layalina.io>
 <CAKfTPtAsij+_=n9JCxHw==j3-wC9rYZHEJyVmyBJsx_-Udhzgw@mail.gmail.com>
 <20240220155913.n7uxb3e56kuhcxs2@airbuntu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240220155913.n7uxb3e56kuhcxs2@airbuntu>

On 02/20/24 15:59, Qais Yousef wrote:

> I realized that I wanted to also add a new patch to not double balance_interval
> for misfit failures. I think you indicated that seems the right thing to do?

I think this should do it?

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 70ffbb1aa15c..b12b7de495d0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11552,8 +11552,13 @@ static int load_balance(int this_cpu, struct rq *this_rq,
         * repeatedly reach this code, which would lead to balance_interval
         * skyrocketing in a short amount of time. Skip the balance_interval
         * increase logic to avoid that.
+        *
+        * Similarly misfit migration which is not necessarily an indication of
+        * the system being busy and requires lb to backoff to let it settle
+        * down.
         */
-       if (env.idle == CPU_NEWLY_IDLE)
+       if (env.idle == CPU_NEWLY_IDLE ||
+           env.migration_type == migrate_misfit)
                goto out;

        /* tune up the balancing interval */

