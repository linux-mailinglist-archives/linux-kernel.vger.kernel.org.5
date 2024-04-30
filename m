Return-Path: <linux-kernel+bounces-163376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42C8B6A19
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA094283BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B0D179A7;
	Tue, 30 Apr 2024 05:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9qUnYXB"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAE42F2B;
	Tue, 30 Apr 2024 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714456541; cv=none; b=imvYiSDAMWJbnioGvlAmoEPuH9P8f1vVdGTYMQwpDr5uaAedHo/LnGedmMP3KpOLxkltWl4b14F51MRY+w781J79S/4L9oUGSsqMnRm5kGLdB1TY/sReppM1AEMzLe7T3sbth+151/ZErCyjspJ9qGDHYcE5yI5pD9b+DdTSZes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714456541; c=relaxed/simple;
	bh=JlHGAp3EGmef4TCf1JVQYIOTz7AmKr5xyKwfNw2vxJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxY8BfTLf04EI2GuyBVBfPNNMgGYIfhksyGODp/tCoh5UaKbvuevVQItG+cWRdmhxikwGGKokWELXWMK+5E4ilIdkgt/B6ljBacZ+pJ+u6jMMWF59fBFqVSo/ARH7yQERdZd+7lTcSQy8i1nmM4H8x/WN9J4MrW9EkjTSK38a/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9qUnYXB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41adf155cffso39176065e9.2;
        Mon, 29 Apr 2024 22:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714456539; x=1715061339; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWx3qxBQpw9dNYzcnamFzEnLXb0WCdTI9Ppv9+NYhok=;
        b=G9qUnYXBX3mOuYcN+QLmhlXnK3dQSvODArpbl9XuNXV86DKz+zIVLFFMC2oTZZhuis
         uqzRA6Cc+eHHumz8p4QNM23+xBpOFJ1dnUf2/vLUiw8+3vdSxxsiKzACkHmHMDcz15pR
         pYChZCxibsAixc1ofpIWlDn3/SD39LyA/xfFbh9ugIpdJIRpllRJdiytA1ISD/aU1AxX
         HZOhNGXJSiQXr4B0viXgPzLNaIFbze1OgTQF/XP5Twt47sdptDI4s29TdUOwDZQ93DQa
         9b+A0h+qQk6WQ0DMraewmcx69oaCoEdW1RXzypi0rshZhhz2GZ54P1FHglrIrklzPoz5
         iCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714456539; x=1715061339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWx3qxBQpw9dNYzcnamFzEnLXb0WCdTI9Ppv9+NYhok=;
        b=Rs8zaTyCKmD2QhlcG27XzxdTPHtPQ1LdX2cvSq+/P88dRzXGIvcjUwqqV9kc7g1c2O
         g6+SNKscKEQfH0DrXqKwzaN5RzvvGCONJtKNyBHimT7m0rPnwpN3BYETSH9UkShKBhvG
         S/qBEx/wadaVuz5pecD2FDnZTpgQAaNCcVMarznvLQ0+EQ8K+9F3njlKTFqkimsb+nX5
         FDtCsekO3j8XXd5VZ52uT8wvOPU7n4B8TVHjcRNAbAZbs2Xxwh5luIhyVDMe3qIwgHvO
         ZjAFSmkXimcWjyAVOyr+J6n22I4dpKUYQOsnzfX99MvHfP8nVlY6t7BESOg9/0DMruQH
         Tmpg==
X-Forwarded-Encrypted: i=1; AJvYcCXDRq/0hNNnXUwGL8a0k3boQyrOUBd8CK4IcGvfzYzwKE904lB0k6aoIqHryYKF1c9ETXN74q+1ETQ23JoRwMo29x9p/b03
X-Gm-Message-State: AOJu0YxzFSRXqavpVUi2B0rIfj/FYd3nYBhdFVidyyyvPjIsR4hsWJrR
	ejurnbz0mHAd2QTgRjPtqeoJhW6ZJARRAqnjfriKVpAbLYkAwxdEmXdhiibc
X-Google-Smtp-Source: AGHT+IEtGjh8WkGMjE0EBcSIXgzDjsu/xGDfOyuxOWaPf6K8GJPZlfYd7ibg+QfrEHQcyPOFHLYcVw==
X-Received: by 2002:a05:600c:a4d:b0:41a:c92:d323 with SMTP id c13-20020a05600c0a4d00b0041a0c92d323mr8320125wmq.10.1714456538182;
        Mon, 29 Apr 2024 22:55:38 -0700 (PDT)
Received: from gmail.com (1F2EF046.nat.pool.telekom.hu. [31.46.240.70])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b0041ac4aafd3dsm25365112wmo.12.2024.04.29.22.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 22:55:37 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 30 Apr 2024 07:55:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/apic: Don't access the APIC when disabling
 X2APIC
Message-ID: <ZjCH11Eyo/ko4EDE@gmail.com>
References: <875xw5t6r7.ffs@tglx>
 <171439414186.10875.17224463643261311678.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171439414186.10875.17224463643261311678.tip-bot2@tip-bot2>


* tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de> wrote:

> -	apic_set_fixmap();
> +	/*
> +	 * Don't reread the APIC ID as it was already done from
> +	 * check_x2apic() and the apic driver still is a x2APIC variant,
> +	 * which fails to do the read after x2APIC was disabled.
> +	 */
> +	apic_set_fixmap(false);

JFYI, I amended the commit with the fixlet below, to avoid the inevitable 
followup trivial patch:

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index b229648b7a18..803dcfb0e346 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1795,7 +1795,7 @@ static __init void x2apic_disable(void)
 	__x2apic_disable();
 	/*
 	 * Don't reread the APIC ID as it was already done from
-	 * check_x2apic() and the apic driver still is a x2APIC variant,
+	 * check_x2apic() and the APIC driver still is a x2APIC variant,
 	 * which fails to do the read after x2APIC was disabled.
 	 */
 	apic_set_fixmap(false);

Thanks,

	Ingo

