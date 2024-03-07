Return-Path: <linux-kernel+bounces-96329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9403F875A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49AE41F22A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4508013F45A;
	Thu,  7 Mar 2024 22:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qCAOyD/u"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35101131E3C
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 22:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850616; cv=none; b=DPbduP3Pc1OAEa6kYhrYLC2MnmaSNl45FBeoro0FfidvCjVBZQ1V8HlLe3kCFsfk1pCnhsu8pPPBzfVa6P1owOrFCHpZcuDN87eR06y9ZJTNxgFh/5KgJ42zE+kVPnZcggkkXenaeRyTYy7Jwl9DfnGiWzR+oIIKkM56Ghi3Rdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850616; c=relaxed/simple;
	bh=pDhFnSH+2GnqjFRhyAcXHT7DAiUPUVzbSyDK+ovWPUo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RTmc4s0ukSemY4GTnwVryDdvfuJBE//67DRF7xtCSzJxZC8Y9IQ0dm2/Gof4S16n4aqbIx1t47dwxYpb++uii//3+QkBVwbp3+k8lAtCne/DKpaQkeDPKtqFYSh6EHaOR6CJHNUoMqhsyrERDwD/ymUJcjFVhQh1cNLyqnjFrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qCAOyD/u; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcbee93a3e1so484697276.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 14:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709850614; x=1710455414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p4U6/xi3Ize/Gq+5zcGCk+1frkvpk205kMxRiv4nKJY=;
        b=qCAOyD/u13OpTwhUT37m85wZ+NCuVuhBWpXN8kVM6aNc3pG6+rzMtoTb/7swaOYNkj
         azmfCrXWR6xTkZRNRBokQnRl40hUaz3T0q5vJHzVPwfkxjAMKLpUevVworluuSAe11YC
         H8jkAGD7WGV2pvYYsWBnfEcWQPWx104Z3D8yqnLnho2OwvsSSvslqv805BjwMaLvNNYr
         AhuHyUK9Gp4HKETaeg44fILEMoD34Tw+YFTCh7amrX1NWwY7aED8TIzm0JGsy71AkIVV
         YJHIGSVExcqCLo1hVrt+aiEnSFMH6O/yewwetkcXvS1nroxFcF7jNbG++xB1kq7RT22C
         jgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709850614; x=1710455414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p4U6/xi3Ize/Gq+5zcGCk+1frkvpk205kMxRiv4nKJY=;
        b=LM21N8Hd+Ef00Bv6+AaMdeEAgWInVxvzjY5b425WF50ocnCimv0erbVE0udxAIKgoU
         R/QSjG7mv4vlEWlA6bYKNg5araZDoiW9CcoQC+q84bA5kljJ4U+yhyJ2WXpQY7AnD5Dy
         mSfgUdi5+aGyQZ2u+kR6hhGncWRaTOfVGeD/fgV/yikn8OiymCln+tLvT5eVZ4/cUAD2
         HQVqDPs48IRHl4HiuGXcF3+4P5EtaMbIrkpRhP66L31QntOt8SVFY8n/b8NHLEvmXVTE
         y5mdNFe5mA0ppWfZ7mKQEBw+3OjP3gFm7CfsrU5NtSXZ13zqCL2frEW+DLfDQsCW0IVP
         wdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFj+hGUxTmZlI+4qNjFoXVaWIoFPjIm493Sl+LhavV4HGKPNU5pLbq+/6F4xiMeTRxRRNEbrlhIl1LYDkWbkt2jxLcbKpkp5/uWPx9
X-Gm-Message-State: AOJu0YyvBLgwxk+bzcNE0iVMDKnRfBQP7uWc7XBN/oovIVZtX0Ffa0aH
	M2Ov/b47CTUWx9mRUB0V2l1AUXTej5/pdGy7FDiVVPjZ8SuxBgGCbmJBxSRZ/0YJD8owafKyork
	qQ2sPlar9SUylw3YCnw==
X-Google-Smtp-Source: AGHT+IFyo7BTTs6Cive4MhKHbExY9d1K9zFrBTX7P3+4ufRaCc+jnmE+UROJ1/UwhO4dTDE8Wr3Fa9+InHNzK88w
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:c585:0:b0:dc2:2ace:860 with SMTP id
 v127-20020a25c585000000b00dc22ace0860mr701571ybe.2.1709850614208; Thu, 07 Mar
 2024 14:30:14 -0800 (PST)
Date: Thu, 7 Mar 2024 22:30:12 +0000
In-Reply-To: <b7f0e16c-17e0-46ae-a777-7e4dca0bbdb3@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com> <tvbgstojgmb5jerhrdwbhknuhhbwmq2pqkb4lxyo3htdynioee@poos2yt52xg2>
 <034466a4-0917-47c4-934b-9549c3076624@intel.com> <Zeos1arCH11X_sXv@google.com>
 <b7f0e16c-17e0-46ae-a777-7e4dca0bbdb3@intel.com>
Message-ID: <Zeo_9IJgcVKYUzrm@google.com>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during
 context switching
From: Yosry Ahmed <yosryahmed@google.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, x86@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024 at 01:48:28PM -0800, Dave Hansen wrote:
> On 3/7/24 13:08, Yosry Ahmed wrote:
> > CPU 1                                   CPU 2
> > /* user thread running */
> > context_switch() /* to kthread */
> >                                         /* user thread enables LAM */
> >                                         context_switch()
> > context_switch() /* to user thread */
> > 
> > In this case, there are no races, but the second context switch on CPU 1
> > may not write CR3 (if TLB is up-to-date), in which case we will run the
> > user thread with CR3 having the wrong LAM mask. This could cause bigger
> > problems, right?
> 
> Yes, but this is precisely the kind of thing that we should solve with
> mm generations.  Its sole purpose is to thwart optimization where the
> mm_prev==mm_next and might not rewrite CR3.

I think it's clearer to have an explicit check for oudated LAM in
switch_mm_irqs_off(), as I mentioned in my other reply.

