Return-Path: <linux-kernel+bounces-146613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BF48A6833
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09039B21155
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9022A127B7D;
	Tue, 16 Apr 2024 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LzZqxFhb"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7740285942;
	Tue, 16 Apr 2024 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262913; cv=none; b=CyoqQIegj0pEK+o2JR7gH1bwkl2ATq+rSTp5qu4+f9orcFZsdBaFKnHo3J2OTyRmH8EKyLMYqqtBlao4aeqIgimJ9nBuNgd3PTfPipB/+ULnhuTIk1xfFzePM+7Jd0LtEhRZh/CohbANUq2Q4JPWoKyJVQqPQtsk4j5Dofw3UgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262913; c=relaxed/simple;
	bh=gSFIyLD40xxdsdu9LlgQjcGv+7zJhWYMcO5gfQdTOPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UEXN3/vIFwgPXn6ujzlSaD2sALdtgs1hDpIROK7645rMswn7K+AzGyMu5LycYi+N4wuRQ6HvJ0R3JRwLZSbivb/UrQQe7q5hmoTGF8C2pyKAiDPWJg1rsVaqghPRLgFjHum2B362NbSOu759Dt4zEDUQwTzEhhmiT054IG2Eh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LzZqxFhb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4189a6a71dcso1937385e9.2;
        Tue, 16 Apr 2024 03:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713262911; x=1713867711; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8csJrmgXQI5Pr4I4YtFUr3dcklSRyrUi/oxRjBrMa0I=;
        b=LzZqxFhbvIXziUp8syo5FOmLknWdSXs2fX3ddtalCQ9YlzPs/nhjC3Ry6ZH6iGLnWO
         ut7khVmeI9S29YCaU7X/0cnieb6JBxXBexciJIM9a/aPW4HSj8KAESdifr0ewN0jJbtD
         YqwptsLGdtQ3PX8zb7oYtbrLF2AGH4i9DpUUZ3qqcxWkCT9e7EDy1n1IG4TyHQ5XNkAX
         rRMWGp3/2fpbgCaJOhiqFxDNyfnSFfj1hiagXWfASBHGTKKxquWQXwIn0+0FMtsFbYE3
         DV9cfx+7iNjQf69kgevJh2p7qxO3kx5qsMaSjVGGVu9Hl1hfW6KYIRFqVM9DtmWHnu3j
         LHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713262911; x=1713867711;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8csJrmgXQI5Pr4I4YtFUr3dcklSRyrUi/oxRjBrMa0I=;
        b=rwT91DmbsWkl1NQbEYpH5O38XnVO8AHO64RN/TNtc1PMqiUYbPp3kHwmdv5MjZk2d2
         QOliMfySpDl5QA4CLs+PhBSCRnXHDl/5SB2Xby90sAj8revYZ/onnjTfxZfMxkdNwtRG
         mGz6WfI8R9DDUsVsOWVKijlq6013+7EI8HYvLBSAvR81FYMHHhV2sdwrCsuhJ6fbc2Nz
         V282SE7L8PVcakAuG1xKDnqNXNcK8QI/C2cMoUFmqBWr+S/210jQnqiczexrKUZKYboO
         Y2ZL4chydnwVm57bgajwRvMt2G0Od15Q4cnFIDyu0M4poGbjmT6dNk57tlMAeNo+blK+
         HYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5T2eQr341lhthmMmsmq+x3jZTUJSUYli9MlAk+WvAq3B3P/lYU0JpGykzJPK9bRgvsPS+1x8utMTV71mMpRf2X2Dqja14zQ+W1EWERe3Vd5l5uiBtsjAxdm0QdR1ph3hjU1/n
X-Gm-Message-State: AOJu0YwQ6Q+01G17l0EHyrD+2qK1Ok72OLzbOefI2xv5SnsIIAPhmInQ
	4ZOr8KD17so+mWLRZe2NwNdHcDRurGRGlsHDkukMpxJ4hbB4vhqN
X-Google-Smtp-Source: AGHT+IGl/vrL9yTs/fzPE29KSumPtxNKJnN588fAHtiF60Mf/qCEJtBBx0DwDalq9SU68GbBqkUngA==
X-Received: by 2002:a05:600c:1c8d:b0:418:93f4:b4ef with SMTP id k13-20020a05600c1c8d00b0041893f4b4efmr1024618wms.0.1713262910533;
        Tue, 16 Apr 2024 03:21:50 -0700 (PDT)
Received: from localhost (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b004180c6a26bdsm794676wmo.1.2024.04.16.03.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 03:21:50 -0700 (PDT)
From: Casper Andersson <casper.casan@gmail.com>
To: Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel
 <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com, Sebastian Andrzej
 Siewior <bigeasy@linutronix.de>, Ravi Gunasekaran <r-gunasekaran@ti.com>,
 Simon Horman <horms@kernel.org>, Nikita Zhandarovich
 <n.zhandarovich@fintech.ru>, Murali Karicheri <m-karicheri2@ti.com>, Jiri
 Pirko <jiri@resnulli.us>, Dan Carpenter <dan.carpenter@linaro.org>, Ziyang
 Xuan <william.xuanziyang@huawei.com>, Shigeru Yoshida
 <syoshida@redhat.com>, "Ricardo B. Marliere" <ricardo@marliere.net>,
 linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: Re: [net-next PATCH v5 1/4] net: hsr: Provide RedBox support (HSR-SAN)
In-Reply-To: <20240415124928.1263240-2-lukma@denx.de>
References: <20240415124928.1263240-1-lukma@denx.de>
 <20240415124928.1263240-2-lukma@denx.de>
Date: Tue, 16 Apr 2024 12:21:48 +0200
Message-ID: <86mspt7glf.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi,

On 2024-04-15 14:49 +0200, Lukasz Majewski wrote:
> - Modify frame passed Port C (Interlink) to have RedBox's source address (SA)
>   This fixes issue with connecting L2 switch to Interlink Port as switches
>   drop frames with SA other than one registered in their (internal) routing
>   tables.

You never responded to my comment regarding this on v4. The same SA
should be able to go through a whole HSR and/or PRP network without
being replaced.
https://lore.kernel.org/netdev/20240404125159.721fbc19@wsk/T/#m9f18ec6a8de3f2608908bd181a786ea2c4fbc5e7

BR,
Casper

