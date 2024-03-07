Return-Path: <linux-kernel+bounces-96072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C35368756C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5BE2B21ACE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FC2137775;
	Thu,  7 Mar 2024 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlRJ/CIB"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589413664F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709838534; cv=none; b=Do2QTDeaNJr7YUtxxbGAF+79ZUUazXeUqk1RzGCGKJaw/1cDTZeCHBPxqvkzUQJ/UtFKUgAt2DcK4H5qlr1XDFF2IXmsh51Cqu0GYsF4kpeSYzMPy6iiZrBDHnsSfDfpXSaaCJWueQJyVIJ1yhqV4OOj3vvgy/0+244WqFqOBro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709838534; c=relaxed/simple;
	bh=UFyayZ0MeBLKORhw7dQZoLLj9DvK03YvbjRbbZyWTGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esVtu49IN7rtnk4LXQ5JqQlicX8TcYAg9nx3g4GZDU7dWIHpuLc8XMjFYuGbOnOy2qHWZ2RJ8+UKgfoFmYKAoJpymibzcw6T6r8qLVVbSpbylbIUU4xjR68sks7wu3waMkh0l5E0gjTAXbpyalTG2YdYqHwBwBKw+0jn3SeAkJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlRJ/CIB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a452877ddcaso182036266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 11:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709838531; x=1710443331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WWwNH3sz9yXBSWgT8KL4kcpHYy1BeQvdzHXc1X2rkTs=;
        b=SlRJ/CIBFd6qnAxqr73uiLHB9xNmpV7SIOkez/a4vuUaQBNykDMxwstsdiI6w/2tEH
         CxU6mB9gsCrw5tqF17skRsq/Fcp0LoLyNgDdM6AZcatEWxqy44ONB/B4sh41ALAOItEv
         3GsfOhTIKKBIadpFuVrVWjfEyw1mXVuoDGO8puD+1yjFT+Hlh1k4dI4C7AwmDuIvUP0n
         vYbV5W9dh5UonZqonD5GCA6x6Z40REdZD9Xy3QfL63F6pzchKHm1iGMLg7rEHPb/NTbh
         n9udI+FWK+8CMhW86Pct75uHLVfb/ZtwPnwkvXIc5BqFkgO2AhU3NrremjO5+HQ+qAfx
         T5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709838531; x=1710443331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWwNH3sz9yXBSWgT8KL4kcpHYy1BeQvdzHXc1X2rkTs=;
        b=gLC1kodp9Q+Nq2MSUxQLclrgzVZAtJ3OaOXeyMuTyWwP/7b3arzxc8ix650ETjE+lc
         URouBQeI5WXzpjeJPMWSZ3KFixe4GSLOCsOHJzvHpq5tt5/xjpwLa7CGpZc/fsxWqQgt
         ycWlkb4zxPFfXJXovY20L9wc1o59v3IcwkTpqoiB2YSzq0fFBLsdh+cv/95V6m7tN4mz
         +bYTpuKNNTJx/MH/Ysx086WLJ+kcd00xz/+/kgM0zyQd2Wev/4n5mG4CEdwM9Chs/Zc/
         cfu6jiLM7bmUXFlCiF5mhkSiv++5CUH+giBYZq2w4jS302puzjm/QFJYp1oAwCxo0d96
         3s3g==
X-Forwarded-Encrypted: i=1; AJvYcCVH/sT1Ue/6hWILeKDa9thcxOubDL0qiLns1c08wqaAjtMhu49u6mz1EuY+vswr2+3xvrhjSl3LcPQsSJXyqKk9N0Ag+G8T+ELYnbwE
X-Gm-Message-State: AOJu0YyXKKf5VvqhA2JxPuU+ar9e0VB4YGJs9tzPxuvWRh9ovVdQKCCD
	Idk1S5qvvamzVYu81Rx06K2rN1oWkd2rPieKcGrCBQghu1gcoe6DbnM3+S6t
X-Google-Smtp-Source: AGHT+IGvGm/gs3UTbz7z/BL7cXpETYIoAIHQwWL1AfD2GlrgYEcWpWqZHFcqXN145tLGoV1f0PGAkA==
X-Received: by 2002:a17:906:3941:b0:a43:f825:ef57 with SMTP id g1-20020a170906394100b00a43f825ef57mr13149395eje.49.1709838530703;
        Thu, 07 Mar 2024 11:08:50 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id x23-20020a170906135700b00a3e4c47bad1sm8504509ejb.8.2024.03.07.11.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 11:08:50 -0800 (PST)
Date: Thu, 7 Mar 2024 20:08:46 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <ZeoQvj3l6moF9KdQ@andrea>
References: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>
 <Zedd18wiAkK68Lzr@andrea>
 <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
 <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
 <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>

> > I'd disagree with these premises: certain instructions can and do execute
> > at the same time.
> 
> Can you give an example?

I think I'm starting to see where this is going..., but to address the
question: really any example where the LKMM doesn't know better, say

C test

{}

P0(int *x)
{
	*x = 1;
}

P1(int *x)
{
	*x = 2;
}


> >  FWIW, in the formal model, it is not that difficult to
> > provide examples of "(not F ->xb E) and (not E ->xb F)".
> 
> That's because the xb relation in the formal model does not fully 
> capture our intuitive notion of "executes at the same time" in the 
> informal operational model.
> 
> Also, it's important to distinguish between:
> 
> (1)	Two instructions that are forced (say by a dependency) or known 
> 	(say by an rfe link) to execute in a particular order; versus
> 
> (2)	Two instructions that may execute in either order but do execute
> 	in some particular order during a given run of the program.
> 
> The formal xb relation corresponds more to (1), whereas the informal 
> notion corresponds more to (2).

This appears to be the key observation.  For if, in the operational model,
(not F ->xb E) implies (E ->xb F) then I'll apologize for the noise.  :-)


> > > The new text says the same thing as the original, just in a more 
> > > condensed way.  It skips the detailed explanation of why E must execute 
> > > before W propagates to E's CPU, merely saying that it is because "W is 
> > > coherence-later than E".  I'm not sure this is an improvement; the 
> > > reader might want to know exactly how this reasoning goes.
> > 
> > The current text relies on an argument by contradiction.  A contradiction
> > is reached by "forcing" (F ->xb E), hence all it can be concluded is that
> > (not F ->xb E).  Again, AFAICS, this doesn't match the claim in the text.
> 
> That's why I suggested adding an extra sentence to the paragraph (which 
> you did not quote in your reply).  That sentence gave a direct argument.

Well, I read that sentence but stopped at "These contradictions show that"
for the reason I detailed above.

  Andrea

