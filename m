Return-Path: <linux-kernel+bounces-118465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C2988BB4B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB3A1F36ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30129130AEC;
	Tue, 26 Mar 2024 07:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoLfIJgi"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315BA954
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438420; cv=none; b=Drx9yASo/fMM2gkD4RF1piy14Lk9mQRL78M5PiDtE/HSuKIab+ggheF9PaVzDJuhgYGis0e+317yPhSdfSZI9cJBn3WCiEnc/2rIxwUfpn2XhZJJCFGJ0QYge5+BmfUvuRrSyyZhSla7TJV21g2t0nRGPcrJigCKp5uOOR5qWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438420; c=relaxed/simple;
	bh=cwJZsR6D0T+X/EugIqLJE/B2nebHJsuKld/4gyYiRcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFalVJwgTC/eZHO2jukohPPCANlqzKFWS721dox4CxtttAsdKCg8DuRSLxfAE5gNo1hUXLYJACom2Xr2WVl2+qRh6X0uC2tUOKtC4FT/hGVp0wk0Cc7dKHNy6dNRF/NsLP4b1qCXqdUnfoRl8aFnom+UVbUYVjGpR8RKnS5aNzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoLfIJgi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a46f0da1b4fso657998766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 00:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711438417; x=1712043217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibTJTKQWBJSmG30a8MZp9EJ7Qtamba9WJj/kswlh1p4=;
        b=AoLfIJgikS1lzmNlEpVjXEWxwgdcafw6b0zbCIpUkIJHpWXAG9BLwWI8y4eGOIEue0
         mW/66btMtrcejhGYKq8jZhnH4wle6vLN9SNSJrZq9HXZfiNTJkAkD39eNp+F7x+uWH1t
         mfbi5WmK872odZiI5eRcaqi815athBc/TeOnjK171EYo6JN4mNVCgcpn/jhN/FnA8pHZ
         WknufWhPoNbxmRRjgB6gZZO89eWNId706P6/m/wPpFXUqe4p0zqZV/CN0oHE35dY2XAR
         pPDG4/MFXP3T7bK/fpAJFaD2zXmTzkj1AaqN+JJpSIzT6+ASMS5o7hfFm2s1svybW5tf
         Pdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438417; x=1712043217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibTJTKQWBJSmG30a8MZp9EJ7Qtamba9WJj/kswlh1p4=;
        b=cxXDDAuQmxbGLZaoCC3ROLKczorAJ5+PD1lxeg3tWRhm70xfKTBXZelTT7IlS7PyWW
         TINEd6VE6MEAnQEjfSMSRrD+RzyvNj8L/8unc71Hg/BmNJxb+pqt87qvALlTaKebl0fE
         JHUpXEpttvzYzCJzTTZeXWvhSHyvVtiUQEd003llpaM+8DdrXNgXNC7qJHJLoc/dSRtB
         zWnUnkOQkIDPy5zGE1+S0LipLhoKUOerrVcnmO3q5+KQChjY8wT3MYYTij+tXXJUVWbs
         JqW0eaEKG9kIZFyq73gS2i1EGolGFRzyiGO8ZReHCJuyO07bOBsji708hFVeu7cqkwuB
         Cx6g==
X-Gm-Message-State: AOJu0YyhToQ5et9Cu6KJu3AXRiK0dqtVl0VYW9TL7GSlWT5qZ4xkfmTH
	FdvUlcoPPKiRskACSCOicPcdamgmTJ0npO6y+TTsWZSrjuRtJE8s
X-Google-Smtp-Source: AGHT+IH0+OSRxiXO1MCdsDMn/zEnmQVZNrofWwBm5d7pT1kC5ffjiiSM6jOegFVGJp84Z+bFJ9neEg==
X-Received: by 2002:a17:906:1455:b0:a46:d5b9:c2ae with SMTP id q21-20020a170906145500b00a46d5b9c2aemr5839504ejc.32.1711438416849;
        Tue, 26 Mar 2024 00:33:36 -0700 (PDT)
Received: from gmail.com (1F2EF63C.nat.pool.telekom.hu. [31.46.246.60])
        by smtp.gmail.com with ESMTPSA id m12-20020a1709061ecc00b00a46d04b6117sm3916530ejj.64.2024.03.26.00.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 00:33:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 26 Mar 2024 08:33:34 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	John Stultz <jstultz@google.com>
Subject: Re: [patch 1/1] MAINTAINERS: Add co-maintainers for time[rs]
Message-ID: <ZgJ6ThVoU6bv+0Gm@gmail.com>
References: <20240325172048.548199937@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325172048.548199937@linutronix.de>


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Anna-Maria and Frederic are working in this area for years. Volunteer them
> into co-maintainer roles.
> 
> While at it bring the file lists up to date.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>

These are much earned promotions. :-)

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

