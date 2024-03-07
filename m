Return-Path: <linux-kernel+bounces-96233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023B6875905
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995DF1F250F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F261624B33;
	Thu,  7 Mar 2024 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beYd/pyb"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B055812FB2A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709845576; cv=none; b=Q9eqDtTjGeK7LPTIK3SWXX40e0PpN1zEB5F83H1LKd1C7LNfHTTHXLmnmbQSDXiy3C/PxSte7FRCpiDwn0IhrPDQWpf33zm/ltN7zqzwADwA83eMXUdZgcRLt33xiLcwMjFJ/P5fz4P3LUtepwC2iREiMYWUtFUoHY+zJIRgB0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709845576; c=relaxed/simple;
	bh=Hkj/SAspPjnqN84OxUtN4mSQ5xjP0siNEVG42u0Eieg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpt7txRUwsWLOSKAmBRcfoE+Q8k8enj8r34hGuph7xLXSinDJINb4Z9uIB66JluaUkUNsBFkUqR5jToHdeswfJcjNG/swNnOhVRlgJGUM6nkgI82r3LMuCVmq8wmZn5USPZGRX/TyQJ+hYVvCe2fEFH338rRQX/RszDevs/m17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beYd/pyb; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5643ae47cd3so128002a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 13:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709845573; x=1710450373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TkFkmjyVWiKj6YLQLEdxeymU1NdgpU6c1bvV2nxIEwo=;
        b=beYd/pybROngNotctjV72cekaVAGZZlMmd0O0P1WtfR47gVUgqIn3/LJYCi4xccv1I
         aHi0jJ9SHqO8Z8VxZOK87lfyttcfbnnqRqJlLihOBzd3CzE1dccHdSUqF9P53MkeSZFq
         3UScVt0+xX1CILnUCNXP4Y9LjBD1CyRQiPJyzBhr7XdqJINEouvZRcEpntf/AJsXXJ/E
         phqAijqkqq2xCQUwurQ9/Sph/MAhQc6MHUBesOP6G1rOjuUJ2BIgtsfoSJMym5HTBkfP
         5VW0S+/oJg/9Ix9oY+h7SZ1rem61+pGTaAk6FPWHrh6Ajv8/XiUxPJjvsuS/hCXAsyRS
         GN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709845573; x=1710450373;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkFkmjyVWiKj6YLQLEdxeymU1NdgpU6c1bvV2nxIEwo=;
        b=V4Uv5I0oulVnfz5envNxy+NrVtFXbH92dLQHLSWtBROiHf1j5EEeym4Sjz9Lt3HUG4
         Z04sDD+WPXG+A11gIF8nf3rrcI8YiZEs48cEfd3fX0l/rcar/fkmbrFDUae5LB1wfGG1
         H15DjsI0r6aYZNlaVQ9TEojKmnHVxe+VIYkLqk9bKkQqItgxU4dCoxtS03t9Fc72zyD2
         QYMgXxl1fDiET4Pg9RpVq14cbMQIQJgKtKcbXd3+VHzifnlZ3oknWry4mRK+VkotCeOx
         ddYY/4pPHiLlznHNve7CSztOr8+2f9l+eEn8DTudgcE5ZeUh8ULuaMErg9Yt3XreFREU
         yUVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqk0r1kHN5uT0lEyuxDvj+zLZy1i7jFupQbD/EyWxD4GSEKwWt+BiRlBJ4PSYCZjkvpulAf5nMhhf6zzcbTXbwTa0HRHsJUdgeGBvJ
X-Gm-Message-State: AOJu0YxnQNqMBl3w7tMoYrMy+hPkdj5KH+SiwxtVBapmFzpg+NtG17JV
	nWEmcXaNL29Iw+quhaaXZkAgl0AFREHqa/87/CAvnqqp9RTAnw2N
X-Google-Smtp-Source: AGHT+IGr/C5j0jUY6SIpcHsUm/j73L5eJZJYuG4YJms2uaACecUO667CH4MTDyQPa2AkX7FHrObYxg==
X-Received: by 2002:a50:d746:0:b0:567:48a9:cf85 with SMTP id i6-20020a50d746000000b0056748a9cf85mr493613edj.37.1709845572530;
        Thu, 07 Mar 2024 13:06:12 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id p8-20020a056402500800b005648d0eebdbsm8419332eda.96.2024.03.07.13.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 13:06:12 -0800 (PST)
Date: Thu, 7 Mar 2024 22:06:08 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <ZeosQDNK8hN/KgJR@andrea>
References: <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
 <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
 <Zenip+8BDM3p+MUh@andrea>
 <eb8f2a21-d388-424d-8504-ccd7bdb53a93@rowland.harvard.edu>
 <ZeoFBkB1BeTdEQsn@andrea>
 <bde188b0-1c5b-4b3b-94de-395a52fc37ce@rowland.harvard.edu>
 <ZeoQvj3l6moF9KdQ@andrea>
 <b3137a9b-0776-421f-8b3b-b5ddd6bce96a@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3137a9b-0776-421f-8b3b-b5ddd6bce96a@rowland.harvard.edu>

> > C test
> > 
> > {}
> > 
> > P0(int *x)
> > {
> > 	*x = 1;
> > }
> > 
> > P1(int *x)
> > {
> > 	*x = 2;
> > }
> 
> Ah, but you see, any time you run this program one of those statements
> will execute before the other.  Which will go first is indeterminate,
> but the chance of them executing at _exactly_ the same moment is zero.

TBH, I don't.  But I trust you know your memory controller.  ;-)


> > This appears to be the key observation.  For if, in the operational model,
> > (not F ->xb E) implies (E ->xb F) then I'll apologize for the noise.  :-)
> 
> Okay, so it looks like we're in violent agreement.  :-)

Fiuu!!  ;-)


> The way you put it also relies on argument by contradiction.  This
> just wasn't visible, because you omitted a lot of intermediate steps in
> the reasoning.
> 
> If you want to see this in detail, try explaining why it is that "W is
> coherence-later than E" implies "E must execute before W propagates to
> E's CPU" in the operational model.

But that's all over in explanation.txt??  FWIW, a quick search returned
(wrt fre):

  R ->fre W means that W overwrites the value which R reads, but it
  doesn't mean that W has to execute after R.  All that's necessary
  is for the memory subsystem not to propagate W to R's CPU until
  after R has executed

I really don't see how the operational model could explain even a simple
MP without "knowing" this fact.

IAC, I'm pretty sure my "intermediate steps" wouldn't be using the same
forcing condition.  :-)

  Andrea

