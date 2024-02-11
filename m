Return-Path: <linux-kernel+bounces-60853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F787850A2A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12151F2337A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190CF5B695;
	Sun, 11 Feb 2024 15:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="avdI3CPb"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731A5B5D3;
	Sun, 11 Feb 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707666945; cv=none; b=X1cDpm4W9ZU7kM6nTYRKcEaSjevIfdCEF8jb4bc3sJUZJtKKjrBDPpmXoqkaB03ViESe9xQ06fqiETG8eTKby2vy9MgfotMPYCaOZsSRJ9LjG03yFc0q1nM8JZ/I+vomcAHhgPMgECuyEQuHBIc2z5ZyWqpbsEoS/pL/n4uyLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707666945; c=relaxed/simple;
	bh=2FRgYgyflnSGpo+BbtBM9y396InP9396hfneNd7u6hg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUg4QPuukUmnPK13cWh8DPhlyUIcffogmXLW412I4cbYEYIurKAPvjd5fiTwKjwG1CLpOsNVwlkpnNtLi9OO9qOrGYK2D7CGuQhzgl2Pim4hSE5RWEZvcgaaP/UPhyoTj0ROzTfDw29cJWpAGKBDqBZ/macx+6oYb5ECGejZN/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=avdI3CPb; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6e2e452c852so184086a34.3;
        Sun, 11 Feb 2024 07:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707666943; x=1708271743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BnVdgSrimIUNebRD+alSOEIaQVJ79eO07pYheI1YFiE=;
        b=KbJAA9vOGC72SzYVBF5nkTX3zWISaNqinLNvD+GeEkQYabXZg0rmLs2Gi4oRDkq5JM
         W+8sXj5v3SRWp37Qpy++r0qhsn3EkWUlXPOH0OZHdHJpTk08IDBSajLgPFySjzcltzwQ
         9r6weJxKcN6iQbMjX2Grk5GnH4jcJGsSdsh/YowgdkMA8ZAI+qwZMhudH7grUfEIPtlT
         JHE3XwNkul36KwW0JPw6gI5SJO6jHttzZJSYAEDL7gDDfoRk2LoP1OCFM6TvquaGL7/5
         1iRd8GIjlTVrN9R6RohDqDcPynhxoMm45PfvuC6LqcJAhHg9tr+Hi//2u79fCs6VA+Kp
         5twQ==
X-Forwarded-Encrypted: i=1; AJvYcCVduFAuRVRBx6PBf5GS2SmXzyRzVrKJROb8KqdVZfEv0ReAc4qH1QwsJrdDEIgVaaAhElTanS8NbwildlVbij+josIXWmLxn3TT/iCjF9rGKRS9nz13LH29jUPm4A3yO1TTwrzE6p+7wAlDauSCvDY=
X-Gm-Message-State: AOJu0YzNf0+SN0yRFO2whFE4NXR+vcEtPfSNgLX08kjufNhazO2nUf38
	OWZAktw+HE0OIJjbPB/Yx5NLtQCM7SZEBCCBJm0QH1cEavuDRl5+
X-Google-Smtp-Source: AGHT+IFOaiDd/It/43Np3t6TxEFwcVLRPRGSvfb0LMF7FrSK04Tlh4g+AmvSnpxHzurAf4fFXNP7Lg==
X-Received: by 2002:a05:6358:5f12:b0:176:5cad:a2e1 with SMTP id y18-20020a0563585f1200b001765cada2e1mr7316661rwn.26.1707666942956;
        Sun, 11 Feb 2024 07:55:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV54x3d/0vyI6YRJ0nAaHpZEWPleDAxKCAhHqWC+J5Gwa7mMTpNSnBjA45IKoD97vfo9b7hVjbNbnFEZFsVk4rDP9/mN25aC5ti28KH/z/xoZOZGqdXTyK5p0S7CfGRn+Elb/hE3Tj9Lh9mI/9mSxdAFmIJVG/HSPUjQZem99jGLbJGF8K0MCGWGyyVeUdDuWATNGpvYM1o4IcE1BHfI/hVFaEhP4vUVOghNUyfmcMyPmQZj6Mgcy8QcAb3D5LL4pxxVC1jhM7pCw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ls13-20020a17090b350d00b0029730d71015sm178898pjb.14.2024.02.11.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 07:55:42 -0800 (PST)
Date: Sun, 11 Feb 2024 12:56:19 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707666941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnVdgSrimIUNebRD+alSOEIaQVJ79eO07pYheI1YFiE=;
	b=avdI3CPbw6jXYwXbb+PgBzCGcv4dmXUf1xPcbsnjgTZ3DtBC1p9UrJwrzHynAknkLU8zo6
	JwGfuBQ2h4fHSW+73h82iJ4rQhAsxFbBulVLzHsoFfyC+opd7XNN94gevj9SA3hfizLgSF
	ydpUMQxKq/G3HWuDO00x6AzriJ6LhRUoLekq6NMGMvjjO+Uh8D38soL1gFuoDCZdInjv1d
	l1Bgf+PrOTcg4p1kyJu9vAZwaaE4kooOZQEJEFELJATPHhbkZFdZZDzSF/xlVv3r2xbDgT
	ICPzr+T2WzN0+DztGnjQ8VLDbY95KoZaB6UPA3rnm51A7UKF9bzLya0z3GDMhg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] ARM: s3c64xx: make s3c6410_subsys const
Message-ID: <qvg4aimmo5eghq3uqf5wwioapafoabsqrm47axbkkp2jwx2rud@gh2xfqacq2rb>
References: <20240211-bus_cleanup-arm-v1-1-5c0102bda0bd@marliere.net>
 <a51701ca-1b64-4716-b51d-59dafaec62de@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a51701ca-1b64-4716-b51d-59dafaec62de@linaro.org>

Hi Krzysztof,

On 11 Feb 16:45, Krzysztof Kozlowski wrote:
> On 11/02/2024 16:41, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> 
> This "Now" was confusing last time and is still... There is often no
> "Now" in multi-tree-repo-approach. If the patch allows it went through
> different tree, this is still false. If this was already merged into
> mainline, just say since which commit or which release.
> 
> I raised my concerns last time, so please fix all your future patches
> after receiving such feedback.

You're right, I'll keep this in mind. Will send a v2.

Thanks for reviewing,
-	Ricardo.


> 
> 
> 
> Best regards,
> Krzysztof
> 

