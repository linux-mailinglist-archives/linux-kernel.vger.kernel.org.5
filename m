Return-Path: <linux-kernel+bounces-100120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B95C879202
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA451C224AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44A279945;
	Tue, 12 Mar 2024 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTZuSLE2"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7175AAD53
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239281; cv=none; b=aMDtY2DYyqVYVpkX3NO2WJnoSKFHQwVaDjdrn+5/o6KNaZPscTWsERJVSY+RZEIQ6HrJWsTvngtXjM/cEMvjxmBZHIhBDHJrtLpSB3AMxkMwFiAmp8fqZrbj+olvC9ErGDI70OGkIPJsHamHa47U+0qKDEbElP72u+vVCYYPzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239281; c=relaxed/simple;
	bh=nWCtChNLnIWCZCI7jxrlZkxFLGwfjKBFvs6uIAJ4/6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=El8VUk682kry074i6PWJCZzbRMxNqE5rFgkJZ+3ixZDpEF/4kO1aG/edpCVLoua7ObAEyGbLhBacdGEOkhriwqMZbXuQcR4bXFUHJXiFYDZ5IH48GIwj72BTFPyhAET1pvBpRuknaJWx+/E/nQg8y0b4C+PpmBtUs++9HZ431vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTZuSLE2; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e796cc90dso3550279f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 03:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710239278; x=1710844078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPlEbwzF2CID+TnG9yfLW4UqfMrhdUNdbyx67Tqwpyc=;
        b=VTZuSLE2KtL7Q97nNKVxm40rks9LEzUkFZNPg8Dgv6VfEz8wLAQVS/RiXBFVG0KrnK
         9pQOZ+hE1x8FZnlNqyMzsHwVg4/F3Bm5OySxFFZprmhDdjDViL4iEXxt8QN/uJXtUJpq
         Yc70lQY9RHo2QUrIvs2UoUTW8j0nf2bV8OtjMeoCWMAKsxRXZIDtcaQlr6T0ukQMTcQF
         NlXPP1YMw2iHHcczjLuh39IDs5JX+7e/WHoscEMJTwoFiTLKB7Y0EdJLfVYnjJtm4GYB
         5ZRmwRy0yqgkwYC8Mie6sJCJe66PmOc3Sf39JWISNuL7g+f9WJZLzERD8hnBKekfkDKK
         S2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710239278; x=1710844078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPlEbwzF2CID+TnG9yfLW4UqfMrhdUNdbyx67Tqwpyc=;
        b=D02EZf+MQDTVAncB9s1lUS51JAI6XaSZ0a9W8jOqfEphYLnDWnSOh6x/HKX32BpW/x
         PwyeWXmgeTNm70fTXGDoGEuxHtQKvD6QTWGr7YdpiIH3tL1Xwh8av7DaUO24I1Y9/YBy
         vwPc2a/HPcfkmYqdvK0NEChJqwRLrKrEgzK7APZqSeJqYKN0YUbOwtF9zXLQnsXzHP1Z
         7eh8dvtOjeiK0GHbx4XlkfzuBemj4ma1jtDNolgkIVOJ4oIY50ENedCKsm0+mRLtxa9q
         xKaSR1pojzPmK3Hb4ix1ZwymqVUAao6BHcljxUpQxeqyWgUGTFuN4/Lw5izCjMy7b9C+
         nVMA==
X-Forwarded-Encrypted: i=1; AJvYcCWnl8VtUMjLFYbiXmTc2YCOSX7A1zxtujguc8a5qAezfYAA3fPQRFaORMSYWm5DGKoRA/KyIbxoRGVc5ktEwKwGNoyOT0DE8rRzdFon
X-Gm-Message-State: AOJu0YywrKQ9v6XLvmkHygE4X1RQUSuR6lekWZ2orQxuQUSzS2yjT4FF
	uXo/XBhhIrMJm/RO79dFj8bR55oLBo5Mzk/UXY9D366BaXNmZFi0
X-Google-Smtp-Source: AGHT+IGNYyLp2NlBt0Q/YHLGIWFl1+zUTfSw0F5gJn+Nt19ch+PZhh+w7ep8sLlPzed0szPcLEQ+dw==
X-Received: by 2002:adf:f84f:0:b0:33e:1a96:2be7 with SMTP id d15-20020adff84f000000b0033e1a962be7mr6228654wrq.11.1710239277399;
        Tue, 12 Mar 2024 03:27:57 -0700 (PDT)
Received: from gmail.com (1F2EF295.nat.pool.telekom.hu. [31.46.242.149])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056000060500b0033e8c2476fesm6747193wrb.5.2024.03.12.03.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 03:27:56 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 12 Mar 2024 11:27:54 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/13] sched/balancing: Rename load_balance() =>
 sched_balance_rq()
Message-ID: <ZfAuKjZ7pNgE2pc7@gmail.com>
References: <20240308111819.1101550-1-mingo@kernel.org>
 <20240308111819.1101550-6-mingo@kernel.org>
 <f14bf408-8a6d-4213-b922-82f1e8782609@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f14bf408-8a6d-4213-b922-82f1e8782609@linux.ibm.com>


* Shrikanth Hegde <sshegde@linux.ibm.com> wrote:

> 
> 
> On 3/8/24 4:48 PM, Ingo Molnar wrote:
> > Standardize scheduler load-balancing function names on the
> > sched_balance_() prefix.
> > 
> > Also load_balance() has become somewhat of a misnomer: historically
> > it was the first and primary load-balancing function that was called,
> > but with the introduction of sched domains, it's become a lower
> > layer function that balances runqueues.
> > 
> > Rename it to sched_balance_rq() accordingly.
> 
> nit: Can this be sched_balance_rqs()? since load balancing happens 
> between two runqeueus.

Yeah, but we really are primarily balancing *this* runqueue - because it 
got potentially out of balance due to a newidle event, or we are checking 
its balance in the periodic load-balancing tick. So it's really a shortcut 
for 'balance this runqueue' - singular, although internally it will indeed 
search for a source runqueue to move tasks from.

So it's a kind of a pull-balancing model, with a singular target (this_cpu).

> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> 
> Though one would have been familiar with names(for someone started recently),
> given the correct behaviour and historical context helps why the name changes are making sense. 
> 
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Thanks! I've added your Reviewed-by tags to the series.

	Ingo

