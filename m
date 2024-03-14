Return-Path: <linux-kernel+bounces-103793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB12787C49B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FE31F2217B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A18768FC;
	Thu, 14 Mar 2024 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bea/Cegc"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67B76418;
	Thu, 14 Mar 2024 21:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710450735; cv=none; b=aLxDjXxHChp2j5WWaUXuqWskWfiBGniqY79Q64JhT2BJaZAjQAtpDbzWvmUpWXfQxi+7hNEPzHpUnpkWC7OCUzJtZz1KJqMsVglXSd9iWXpuvO00S5ZZZumQ1Co/eWq1/7hDiudh1B2OC30UwM0hPw6Ou6KF/Fm3RXP5fJzLm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710450735; c=relaxed/simple;
	bh=lA71U8fItj9J621XwAfGWPV9TTXnYts4mMluMhcUNL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hke+bssnigOTqFCl10Iy1mFLs2ezOyn30QS6IZ/OXRh++dlIlV/UOYUjBag6s8oUjxDA6YeBLI5ERwuXNcCbzbtZKnywmGkQH7o9K/8teOpC75LHeERTCu8EAKg+ePMUPDz8UlCxaxDk/qzlCzqeVjdOHChVpvKwkOno1gXzCAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bea/Cegc; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d41f33eb05so16848631fa.0;
        Thu, 14 Mar 2024 14:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710450732; x=1711055532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nmlhyWc/OCnHJHfz1owIUbCiR94nli1BGaWkIFU5Rc0=;
        b=Bea/CegcgpVN6buwoaRDZacWC628TcJ9YSVSvkqmKLqtl+Wf7ROBNFEVMoz8JFfD6z
         EVSVKm/Yls4NbG0PTQAQ+1aSrgmPRKctlv+6FH/X2vp8YBEkhjSQKYNRkxoCaIMJiekS
         Wqoj6JcoQ4I7y+woeDxiSb+ZcPRRJMHe4Rytj5fp6VUJ/x1EdNd4w4iMM/n8t6hnDyPg
         z29/SHgVYE/wRk1KPiPLwp4M5PHxgKwzM8SVUZKfsnurgYCwGXF6a5DLNXafdmK7W7cd
         5h01jcTDa0OBLKUUVW5Gshnrncp+ZgacDL1dqMnZZqqDsPflPzQW5TY3LRUtJtlmXcIR
         aASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710450732; x=1711055532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmlhyWc/OCnHJHfz1owIUbCiR94nli1BGaWkIFU5Rc0=;
        b=RAVNbOXU/OojzEgSiUqF7wJGpjq8qZmBDTzIRwVbKait7Xrfvtq78qsqKDGECU+b1V
         nTWlJnJNzp5wzgxBE94wkGXSDv7qc9ghfXxHI/uYdCKYYGLXwsieZAqyw3Lym2F9zQr+
         aULntB9rsLbmoYHNA6VYhwg9PzmZ1RYdtuwv0Qz0qZ8xYNRihaCp1RUZktZPzs4A4GEC
         RzygbkihGBG6rbH2bwhqHGcKHvGnfM5NlDleky66ej7+R20/wv6mxBZke/1znCHjsYP/
         EJIvbXJlNZYA2z4TdyUoZIAzlnUUOVDbhvxayahKoIOPmn6+Iv1k2uNAMsIjAv4NXYFA
         f3xw==
X-Forwarded-Encrypted: i=1; AJvYcCUDpY0hUzGt32OkPepG54WI+r8pJ0uA/Jaz9kVxfsoqyxzJj0+jRrHBEbdYQDteUVx+4UhnZ3x9m0YkcOzmtPQ32V32vn7l6VoTCyZtoVDEK4fGrfRjn/uG9uQ0+hM174UqMvCcgKHi9kLsjDlk4kfsMPWXLGahyY/7/+8CFbmV
X-Gm-Message-State: AOJu0YzEyFM/QuxcMTS/ZmB3Ezv12E+jrzkFV0yUBf+4/GpDCumzUQXY
	oga+qv49o+7z1MHSaQB0AboAxleHhQiXfhqh5dsnJYtzm4sYms+CXtOYkHYR8vusWg==
X-Google-Smtp-Source: AGHT+IG55+gItQQB8PKaRFYNLr7CO+vj6T1pJtzzXs6BsOcBhCzBiaI7ENJRiA1KOzF2Ih9IcG06rg==
X-Received: by 2002:a2e:86c7:0:b0:2d2:3fac:5fc7 with SMTP id n7-20020a2e86c7000000b002d23fac5fc7mr651153ljj.45.1710450731890;
        Thu, 14 Mar 2024 14:12:11 -0700 (PDT)
Received: from fedora (host-95-250-206-50.retail.telecomitalia.it. [95.250.206.50])
        by smtp.gmail.com with ESMTPSA id z1-20020aa7cf81000000b0056835320f76sm1053596edx.8.2024.03.14.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 14:12:11 -0700 (PDT)
Date: Thu, 14 Mar 2024 22:12:09 +0100
From: Francesco Valla <valla.francesco@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	fabio@redaril.me, linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Documentation: networking: document CAN ISO-TP
Message-ID: <ZfNoKWwM0UKVdHnv@fedora>
References: <20240313223445.87170-1-valla.francesco@gmail.com>
 <20240313223445.87170-2-valla.francesco@gmail.com>
 <20240314-nurture-apricot-d4707bc77a00-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-nurture-apricot-d4707bc77a00-mkl@pengutronix.de>

On Thu, Mar 14, 2024 at 12:20:10PM +0100, Marc Kleine-Budde wrote:
> Hello Francesco,
> 
> thanks for your contribution! I've some remarks to make it a valid rst
> file.
> 

I did a bit of rework on section titles just before sending and obviously
forgot to update the separators. Will do that in the v2 patch.

Thanks for the review!

Regards,
Francesco

