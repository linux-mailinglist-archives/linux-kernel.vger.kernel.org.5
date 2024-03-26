Return-Path: <linux-kernel+bounces-119777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730AF88CCE2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45891C62189
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F9D13CFB0;
	Tue, 26 Mar 2024 19:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7FKgbew"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E3E13CC57
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480564; cv=none; b=N0IjJVK1HB+JpXB/UgRL0M9z+LSQQ4XNPhLIaU7tFlAb+rTJHoLS4gAbuYz/q0CDC4Y+FozwHMRw7PZW6q76c0104L1g46J8376MT+Mj/FmsgcW07rs1pycajZRwa+mRAQ8YcPmQSjiJwHQFnQWi/FO4GWSB9eyM/tFev34rd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480564; c=relaxed/simple;
	bh=1bMBEM4/4Iz1/xrCSVXmU80L5Uy6aFNi9Xg6YN6SE0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SoaruuKPGXGoonCMnHeaHEaHRi0N0zpJ9lDN8EhcA3lS0JyVuZez1wa/ItIjrmnU3vGr45jlm88eyYtjfH1fFzX6aiSk0LtPaU+yQPDj3CLx7fFFkNjsHXQpF7EAk/qj8WNN7Toozm5b+7O89+aAUUwICUe+RLo9UXci6en3gbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7FKgbew; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-414881d8956so16542955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711480558; x=1712085358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osYawWPBQpxNHOQr0ivWR3zdMRhvuhxlPXcfIlj9SjM=;
        b=A7FKgbewWwRP8zDOloEo5Jac04YS5LFYaBnh3bMFeOFwFFTdT2sSULcbPTELUYkVo7
         X5zMugrxhKBXrSREtabTC5VoThw1oOTAMfsvQc30ovgWWeMtpMKRLMvUFz50VQjKD5yD
         qv95F1ia9n0Mb5gVcZZ6KyaFamq0hLZyRFvfo+7FMBMSMfqA9GEL1EQwEIDgISYDXoR/
         L4zahLCNFXYY3dWU7PgFfSzPpfvbehrQO2bP+ZS8BEw+n3PlnwwmImcC2Eau0S4rMW8i
         WE+ogV31WKf+jeMgo2Y8GquU1ywyf2mAKWD5SQ+4Gu78FqBIhc69c2gqAZeE8uwaZkYO
         7kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711480558; x=1712085358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osYawWPBQpxNHOQr0ivWR3zdMRhvuhxlPXcfIlj9SjM=;
        b=poeqgTO7SY1EnCObbWwVMlYgoa5HXBPrNdCRXxAyIsmaimBJKwEbjsaXewATMf0eHU
         yZw+0qHEnXko5J0aJmF9BfpuVYYFpiEUiI7y1pYIrK37MYOzhcgckWDG2SSQnFgXeDcd
         qvknzbXLfeQVIZrBu4VHsyxE2mvN1MjV6yPNHgPOKMCceRQp1N7pZ7ad7Uf7XItr9a4B
         1VNGVWx8m6K0oX8HrawP6kLFKSSufEzVpFWXSGb9gru78xEtYX39aSxJREpPcH1I7bec
         yFjZu678AQpCMLmDDRY6E2DBcURXUcjJt8veyBQGAg64yXYR/fAbyGjPYrtF+MyofkiK
         edgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUD1R0mNyVEmuT/PePAYFiJKiw+xQMb65qRXbjYT9a8eOtyVblqTWcyaLbskNdqUdCYpgA+2VNQ+geT80K5UrHcQEsiZV8WLAkh3GlY
X-Gm-Message-State: AOJu0Yx0Fe2GEs5kyEj9kCCH5XFoBaVyp2AL6h3ZnW0+c4GhGFCcSbYF
	qTbeJA7Pro6Uw55QcErF0E6QVhRTe2D4QAGsoiAV1sxnr/jLJ2n+
X-Google-Smtp-Source: AGHT+IFTXPNB+5Y8dw6CT9jqWPpomMrIZQNnjzcN/lR4ruYYE+qCICTu8WrzesvUnN/1BbGu850rcQ==
X-Received: by 2002:a05:600c:3b9b:b0:414:64d3:f33f with SMTP id n27-20020a05600c3b9b00b0041464d3f33fmr1617890wms.23.1711480557902;
        Tue, 26 Mar 2024 12:15:57 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id fj12-20020a05600c0c8c00b0041409db0349sm12387973wmb.48.2024.03.26.12.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 12:15:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 20:15:55 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, peterz@infradead.org,
	vincent.guittot@linaro.org, qyousef@layalina.io,
	linux-kernel@vger.kernel.org, vschneid@redhat.com,
	joshdon@google.com, riel@surriel.com
Subject: Re: [PATCH] sched/fair: Simplify continue_balancing for newidle
Message-ID: <ZgMe631rb2Iaw76t@gmail.com>
References: <20240325153926.274284-1-sshegde@linux.ibm.com>
 <ZgKCXrUbBIxp6+mu@gmail.com>
 <7e6789d6-1e85-4945-8a7b-02cadc95cfa5@linux.ibm.com>
 <6c1eed8f-455f-4612-be4e-02876f35e37e@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c1eed8f-455f-4612-be4e-02876f35e37e@arm.com>


* Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

> On 26/03/2024 10:00, Shrikanth Hegde wrote:
> > 
> > On 3/26/24 1:37 PM, Ingo Molnar wrote:
> >>
> >> * Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
> >>
> 
> [...]
> 
> >> Is this actually true? Any change to behavior invalidates such a sentence.
> > 
> > From what i think, code path is same and I don't see any functionality changing. 
> > Correct me if i am wrong. 
> > 
> > Currently, sched_balance_newidle does the same check to bail out as the
> > should_we_balance check in case of newidle.  i.e  
> > 
> > should_we_balance
> > 	if (env->dst_rq->nr_running > 0 || env->dst_rq->ttwu_pending)
> > 			return 0;
> > 
> > sched_balance_newidle
> > 		if (pulled_task || this_rq->nr_running > 0 ||
> > 			this_rq->ttwu_pending)
> > 			break;
> > 		}
> 
> LGTM. Commit 792b9f65a568 ("sched: Allow newidle balancing to bail out
> of load_balance") (Jun 22) made sure that we leave sched_balance_rq()
> (former load_balance()) for CPU_NEWLY_IDLE asap to reduce wakeup latency.
> 
> So IMHO, we can use 'continue_balancing' instead of 'this_rq->nr_running
> > 0 || this_rq->ttwu_pending' in sched_balance_newidle() (former
> newidle_balance()).
> 
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks for the clarification, applied!

	Ingo

