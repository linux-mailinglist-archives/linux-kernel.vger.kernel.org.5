Return-Path: <linux-kernel+bounces-96432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3B4875C09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 02:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002951C20FB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA61A2261B;
	Fri,  8 Mar 2024 01:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/nEGzLm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DB1F4F1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 01:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709861687; cv=none; b=dFzopNaXaClwVpKEQOle2f6+DFH75zJPGtXDEQsHqKiF9N0VgFBKdybyJ+HdTcPYo2c5dnLX6nX0L056k8yTz42+cKMsITcAfrNZTEAwh2Byn+V0rWQgqFMonPCe6ULi9pDRTZbO11hFAEUHDhyP8M5PC9I101af3xCCIDE+kLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709861687; c=relaxed/simple;
	bh=VjCS+mPzMg57EfVH0u7opRtoT+iYbBR5Y72kAhSAutY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=sNFw3qQFspqoUNF0kDVVtL5sWpP0YwS3dPfCZSUYvvqPGofNYz1USIBLzwk1Y5Jw4c5T0yNt+alu3Xnzec84yn2ZDtLK7flPRoWNBfCqY8+rNxVnATCBAeFDv493TLi1rsOjyJOUzcXq+8AjrlMZ8e15itn5egLfTqswJsY4724=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/nEGzLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E25C43394;
	Fri,  8 Mar 2024 01:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709861686;
	bh=VjCS+mPzMg57EfVH0u7opRtoT+iYbBR5Y72kAhSAutY=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=c/nEGzLmKXdbr0YrgSBm/K+mVHde1oYwHDddKj/l5JGP5tetyCw/QZuhYaPCrtJRI
	 aeIP0uYYF1746o8BOSIZ6MAVWEKePUJNM225tAAHqHTpFBl6a7LeTlGKHvUz2ufuFF
	 IVRc3QdcKexwxXkmgOuMja82d0TmGYAQfkwgqe0cp9xw8ejp+9klNstX4RFyeCeCt7
	 kf4VLbIS8Avm7WlzNQrZ6WVUeX7D8ud+LLyInf2t2QVoRPry7VTAOdzdVxQ08PdNRK
	 sew34aSEMlZ5LCiwaat5yXGZTOzIJSLMUGSVkkqEK04iGi/FsGSy7JacvmyOUJmBMI
	 cGKAQL6uka4Tw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 34A211200043;
	Thu,  7 Mar 2024 20:34:45 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Thu, 07 Mar 2024 20:34:45 -0500
X-ME-Sender: <xms:NGvqZQrShq2v4DoJYUpu2YooEOLI3HncUvlMXiAAEgo9txtSwEOIvw>
    <xme:NGvqZWqGSpjhHuddgz0O-aTDYrE_Mz0xPRutY9i5IdnDXq7nsIaI4rCSXTNoTmXj3
    ld0pLqyWzQzw_bWSBs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrieeggdefhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    hicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvhfeuvddthfdufffhkeekffetgffhledtleegffetheeugeejffdu
    hefgteeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedukeeh
    ieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinhhugi
    drlhhuthhordhush
X-ME-Proxy: <xmx:NGvqZVPPlpkJn-7H5VvcvzF6ERS-jq2r_2W5jIM7ewz_4m1PYOjJNQ>
    <xmx:NGvqZX5E4kICDqA5wPY54Vy6k4jEfcqu_OCMjP9D9qvAHMSQ8_d27Q>
    <xmx:NGvqZf4hTGi-LFM_ssFCWmJ_7swEAgei3iq9d-d7WhFWK42cemYcew>
    <xmx:NWvqZcGAKSZEKpNuQnAqc9IgG2vLIaV4tgsUmkTzsYrp5e7bb1OlkDzTn_s>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2E30031A0065; Thu,  7 Mar 2024 20:34:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <420fcb06-c3c3-4e8f-a82d-be2fb2ef444d@app.fastmail.com>
In-Reply-To: <20240307133916.3782068-3-yosryahmed@google.com>
References: <20240307133916.3782068-1-yosryahmed@google.com>
 <20240307133916.3782068-3-yosryahmed@google.com>
Date: Thu, 07 Mar 2024 17:34:21 -0800
From: "Andy Lutomirski" <luto@kernel.org>
To: "Yosry Ahmed" <yosryahmed@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen" <dave.hansen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "the arch/x86 maintainers" <x86@kernel.org>, linux-mm@kvack.org,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] x86/mm: make sure LAM is up-to-date during context
 switching
Content-Type: text/plain

Catching up a bit...

On Thu, Mar 7, 2024, at 5:39 AM, Yosry Ahmed wrote:
> During context switching, if we are not switching to new mm and no TLB
> flush is needed, we do not write CR3. However, it is possible that a
> user thread enables LAM while a kthread is running on a different CPU
> with the old LAM CR3 mask. If the kthread context switches into any
> thread of that user process, it may not write CR3 with the new LAM mask,
> which would cause the user thread to run with a misconfigured CR3 that
> disables LAM on the CPU.

So I think (off the top of my head -- haven't thought about it all that hard) that LAM is logically like PCE and LDT: it's a property of an mm that is only rarely changed, and it doesn't really belong as part of the tlb_gen mechanism.  And, critically, it's not worth the effort and complexity to try to optimize LAM changes when we have a lazy CPU (just like PCE and LDT) (whereas TLB flushes are performance critical and are absolutely worth optimizing).

So...

>
> Fix this by making sure we write a new CR3 if LAM is not up-to-date. No
> problems were observed in practice, this was found by code inspection.

I think it should be fixed with a much bigger hammer: explicit IPIs.  Just don't ever let it get out of date, like install_ldt().

>
> Not that it is possible that mm->context.lam_cr3_mask changes throughout
> switch_mm_irqs_off(). But since LAM can only be enabled by a
> single-threaded process on its own behalf, in that case we cannot be
> switching to a user thread in that same process, we can only be
> switching to another kthread using the borrowed mm or a different user
> process, which should be fine.

The thought process is even simpler with the IPI: it *can* change while switching, but it will resynchronize immediately once IRQs turn back on.  And whoever changes it will *synchronize* with us, which would otherwise require extremely complex logic to get right.

And...

> -		if (!was_lazy)
> -			return;
> +		if (was_lazy) {
> +			/*
> +			 * Read the tlb_gen to check whether a flush is needed.
> +			 * If the TLB is up to date, just use it.  The barrier
> +			 * synchronizes with the tlb_gen increment in the TLB
> +			 * shootdown code.
> +			 */
> +			smp_mb();

This is actually rather expensive -- from old memory, we're talking maybe 20 cycles here, but this path is *very* hot and we try fairly hard to make it be fast.  If we get the happy PCID path, it's maybe 100-200 cycles, so this is like a 10% regression.  Ouch.

And you can delete all of this if you accept my suggestion.

