Return-Path: <linux-kernel+bounces-95837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9019A8753B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3BA2844DE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1993112F583;
	Thu,  7 Mar 2024 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnvwjMev"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A821812F37A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826736; cv=none; b=IpMQOLWmNbKSDvvyO1VfRoHXOTLsclHeaegfqsP9QCyF0oEg+jjm5N9BN69tKri5D1YnStIHnDNIH6C8dQ1l5a2bcHdRv5noKk8xuvcrJRWgMsVivtBuYO1IShi9/FDAiO+qGcIhB6Nm1oBqwRC/SI+o34ok5yOm08CY7rbQgYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826736; c=relaxed/simple;
	bh=f5cOvCMcZxYt6SgxQo5SsRXEje83Zf4F0G07okBBSYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyrbRS7pr/u4rNVbEbS2woI7lE6NyELCfQuNqHQAScQFDfDN3WGD25iwm9ls/HyS7AyxMhI3fRGgCofOK58qE2JOCsEY1G3qlaOil194As6LP1bKtF6cKIB++A8t2YH03UqZWJBGeDSAKptJAkJq64+GOT2GFUONRvkYhZWcbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnvwjMev; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so396633466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 07:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709826733; x=1710431533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcKVt6lNKTClD87/EvnKiZiuOPsJDAZmnpBC6AGLlUM=;
        b=KnvwjMev1BDfGqovzfMOWvtCAjfWbBEnO1kHw4+nTtlaOvRzWYO5R966bhU01y/37G
         i09sw00GjtH1gsF8OG195e5+y4Fih4L+CqKpx+NZWCYU6OVnp47l2bD0T13gsYExbVY9
         oc2U+RdXAWPlzzhqEpDpBasBWWe3t3dPTQeFobuMK4cxPzauopsdklWpEkDRg7/IP7XG
         qPfEa9FPPTbFU8ttXGU89y1nszOaWwmqp1mmB7j223hc+DslQMuTw7rEMrrMThaW+x4n
         /AUoesP7mLbFC8RalJBRDpbwTS7mVy0908LarD7V7VQpy/zhhNb4yy7dgzi6/aGZ6CfB
         714Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709826733; x=1710431533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcKVt6lNKTClD87/EvnKiZiuOPsJDAZmnpBC6AGLlUM=;
        b=fBiB9Z03TooGCly1dVVLoxpD7orpaVw0Bs7iLtgpy8GdU/AWGV26d6xdjY9JtOXUmi
         rC8xPt5bNpX8lIVxONOH11XaH8kXxvGrjNnXxaleYraY4Jh2fdEXYhbgTlVTlIQDmlXZ
         vgj3Gec+oYW4151pxponTeybRd/WeqttTjLt4BXafborh1fGZZggR2agVAIiwZNCJfpb
         G2jr30/EjidutIAWwCFn3OmbZlnorM/TXu2/cIXq1CiNnb50FEyRdCK4Zs0/mI6T08Jp
         a9d5oMkNlPvH0sNufk/1fTCWxdvgPoFulw/IEkeWcbU98urp2Tnlyx3+n+M8ZFldX4n8
         e+Ww==
X-Forwarded-Encrypted: i=1; AJvYcCV9JvS+hTBgPbSJk1ENpCy8nR4mJZTnNDtLM2yJiG6RwZiVz1eOe3xPT2zHL3gAVt9TfSeSYwcohbcGHljA2+sJ7Cmw12/MWcahSmN1
X-Gm-Message-State: AOJu0YyINUF3D4jLCXRWOzbrjJrH4VTiyHVryTQM4J9nujpiu89gJbj+
	ASY+Racr2C/5S7PXyi7ghqUB9zXUbrRaBRTK1DHgZDm0m92abwG1
X-Google-Smtp-Source: AGHT+IH19wxXTnX56CpkfG9q8nHE2/QBnAp8SedZHbT/e6gpfR+jibekaU4Z6KI4Kei3ISjm4yMRXA==
X-Received: by 2002:a17:906:f1d8:b0:a3f:c32:7b0c with SMTP id gx24-20020a170906f1d800b00a3f0c327b0cmr501317ejb.22.1709826732576;
        Thu, 07 Mar 2024 07:52:12 -0800 (PST)
Received: from andrea ([31.189.122.3])
        by smtp.gmail.com with ESMTPSA id k13-20020a1709067acd00b00a44f3fb4f07sm5861059ejo.191.2024.03.07.07.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:52:12 -0800 (PST)
Date: Thu, 7 Mar 2024 16:52:07 +0100
From: Andrea Parri <parri.andrea@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kenneth-Lee-2012@foxmail.com, linux-kernel@vger.kernel.org,
	paulmck@kernel.org
Subject: Re: Question about PB rule of LKMM
Message-ID: <Zenip+8BDM3p+MUh@andrea>
References: <tencent_C5266B7D6F024A916BCA7833FDEA94A74309@qq.com>
 <Zedd18wiAkK68Lzr@andrea>
 <tencent_744E0AF832049C200F96FD6582D5114D7F0A@qq.com>
 <ZeipiSVLR01jmM6b@andrea>
 <e05fa6a9-c810-46cb-b033-b91ae7a5c382@rowland.harvard.edu>
 <ZejC+lutRuwXQrMz@andrea>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZejC+lutRuwXQrMz@andrea>

On Wed, Mar 06, 2024 at 08:24:42PM +0100, Andrea Parri wrote:
> > Later on, the file includes this paragraph, which answers the question 
> > you were asking:
> > 
> > ---------------------------------------------------------------------
> > The existence of a pb link from E to F implies that E must execute
> > before F.  To see why, suppose that F executed first.  Then W would
> > have propagated to E's CPU before E executed.  If E was a store, the
> > memory subsystem would then be forced to make E come after W in the
> > coherence order, contradicting the fact that E ->coe W.  If E was a
> > load, the memory subsystem would then be forced to satisfy E's read
> > request with the value stored by W or an even later store,
> > contradicting the fact that E ->fre W.
> > ---------------------------------------------------------------------
> 
> TBF, that just explains (not F ->xb E), or I guess that was the origin
> of the question.

So perhaps as in the diff below.  (Alan, feel free to manipulate to better
align with the current contents and style of explanation.txt.)

  Andrea

From c13fd76cd62638cbe197431a16aeea001f80f6ec Mon Sep 17 00:00:00 2001
From: Andrea Parri <parri.andrea@gmail.com>
Date: Thu, 7 Mar 2024 16:31:57 +0100
Subject: [PATCH] tools/memory-model: Amend the description of the pb relation

To convey why E ->pb F implies E ->xb F in the operational model of
explanation.txt.

Reported-by: Kenneth Lee <Kenneth-Lee-2012@foxmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tools/memory-model/Documentation/explanation.txt | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 6dc8b3642458e..68af5effadbbb 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1461,13 +1461,11 @@ The case where E is a load is exactly the same, except that the first
 link in the sequence is fre instead of coe.
 
 The existence of a pb link from E to F implies that E must execute
-before F.  To see why, suppose that F executed first.  Then W would
-have propagated to E's CPU before E executed.  If E was a store, the
-memory subsystem would then be forced to make E come after W in the
-coherence order, contradicting the fact that E ->coe W.  If E was a
-load, the memory subsystem would then be forced to satisfy E's read
-request with the value stored by W or an even later store,
-contradicting the fact that E ->fre W.
+before F.  To see why, let W be a store coherence-later than E and
+propagating to every CPU and to RAM before F executes.  Then E must
+execute before W propagates to E's CPU (since W is coherence-later
+than E).  In turn, W propagates to E's CPU (and every CPU) before F
+executes.
 
 A good example illustrating how pb works is the SB pattern with strong
 fences:
-- 
2.34.1


