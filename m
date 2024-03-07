Return-Path: <linux-kernel+bounces-96007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDE6875600
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2622D1C21D75
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C059F132494;
	Thu,  7 Mar 2024 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebOeCamR"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983112E1FE
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835534; cv=none; b=b6qomTq0f0qO526kk/19mLap5IJU8tlA09s3TF5k1Szwcu3S6ju+02w/KVMtGEFWAMktpqocMj5NHfKA+DWu00lxmKG5dwjr08j+qq+wdBIRPTFrrC8ZQ9fxxjQoRd06N4GAIaA8s7PwnxKFik0xy42VkKL8jNQ3MQFBZiQU1Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835534; c=relaxed/simple;
	bh=FXT4m7HmrVbNlkkcuqc4h5hIuOLr2Owzoeu7EYph2QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWHv+bCbRSoAfJ0RxbrpjSe+yW+vFRBsBOvM/08eHovSm51TzcEYqiccoiobAGudd01jodWeAZ3imR6fazI0F8BvqzcYERzuWsUSqHl9aOa6PfZ4NSrBJfVeXlp5WqnVOTDTgqcXsEbf4kEIkj+/SCBHNhPcXkGmaskBbByq0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebOeCamR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56647babfe6so1800985a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 10:18:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709835531; x=1710440331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3ih2qp0TpnzVvtyG5Tp6Nj5YhfoLGtJWPyIG/4IO+Lc=;
        b=ebOeCamRvZrgmoWb23Ekh1qyArb9pieXzv1tZdVn5IWgXSdHUZJT4uR2iq7Ac/HFXm
         m3P7nJu17yBLx6g+oLgWjhRCDpQIgpNLm1tqbEK21hsjxlO9YDsRX0rPBOZUdgkLxAnI
         fm/oO69JAmB/rMWcHxIER3gKmzBtXbWhVhGIvOm4juKiQ5TjFLF6h/kManun44OVDI9K
         QS70izlgCjqBTU3RUl1M/kGWBM0Etkq5MCfQhxZCsI1yLV13Bb6D2NDAPrpr2xQsWv+J
         2B0F17Z1vsOKOZOuO7nTWxuMFOCD9oa72rl6I8IqtwWWEw63P4nKMMdZvPROWFBFoCQX
         KuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709835531; x=1710440331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ih2qp0TpnzVvtyG5Tp6Nj5YhfoLGtJWPyIG/4IO+Lc=;
        b=uwugJhWKtDHkaIv7a39vkNf+j3/UezH9cCvBx9Bq3HcmpxVIlI6erTLs9/+dEyrM34
         pxWr0yFiYRLzrU3Eb37QKO/bZjtyd4qvj9TmvsdILXIM3MMZtJr7CiRNDGKiHXx1yTvj
         Q1uryECY3egBgk9OLRrNShQJm/rj0D0jC4vu59RH54NqpDHorzqVphL+bLDHzpmnja6C
         uiBG471Axx3c1w2gO7+aXplkQrAgvSZhVzgBQPVrGVYcNdi99X8BftDwNaUO0VsxFKQ5
         OAu0Ab0gKUg3+A+hRJZ4MI7wkSCQH/xXmRMlFr9lbOCANQJA3US01GUhnl6SefyXjuih
         a2Ag==
X-Forwarded-Encrypted: i=1; AJvYcCU5es+9+38C1oBfZ+Xwh4P/QaRoriHgq5H9tm29G9qYRhUoAtOCP8WwOvX7RaW7Vpcd57ecEFG7smaVNRKr1+aYyk3RvutpBhxgBQN+
X-Gm-Message-State: AOJu0YxWtzGMWRS581HBinvVrTykM0iE76rWfdt7a3lH0+bQXowGtKws
	nVwYVRUYUAf82GUlu/KVbh4J5aUeQ2n4HLAamn879zeBZWAj5IPIUQkN4Ftb
X-Google-Smtp-Source: AGHT+IFjVyBM1I0YrYvFS2Yf7mFCSmMnGCqlE5FTKQWqn6ZXKlyaKeLTlmjxtg3EWaKCaHD5DH9Spw==
X-Received: by 2002:a17:906:f8c8:b0:a45:20e3:688e with SMTP id lh8-20020a170906f8c800b00a4520e3688emr8941380ejb.56.1709835530603;
        Thu, 07 Mar 2024 10:18:50 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id lk11-20020a170906cb0b00b00a4577ffe69csm4137062ejb.78.2024.03.07.10.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 10:18:50 -0800 (PST)
Date: Thu, 7 Mar 2024 19:18:46 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <ZeoFBkB1BeTdEQsn@andrea>
References: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>
 <Zedd18wiAkK68Lzr@andrea>
 <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
 <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>

> So I guess you're talking about the second, intuitive meaning.  That's 
> very simple to explain.  Since every instruction executes at _some_ 
> time, and since we can safely assume that no two instructions execute at 
> exactly the _same_ time, if F doesn't execute before E then E must 
> execute before F.  Or using your terms, (not F ->xb E) implies (E ->xb 
> F).  Would that answer the original question satisfactorily?

I'd disagree with these premises: certain instructions can and do execute
at the same time.  FWIW, in the formal model, it is not that difficult to
provide examples of "(not F ->xb E) and (not E ->xb F)".


> The new text says the same thing as the original, just in a more 
> condensed way.  It skips the detailed explanation of why E must execute 
> before W propagates to E's CPU, merely saying that it is because "W is 
> coherence-later than E".  I'm not sure this is an improvement; the 
> reader might want to know exactly how this reasoning goes.

The current text relies on an argument by contradiction.  A contradiction
is reached by "forcing" (F ->xb E), hence all it can be concluded is that
(not F ->xb E).  Again, AFAICS, this doesn't match the claim in the text.

  Andrea

