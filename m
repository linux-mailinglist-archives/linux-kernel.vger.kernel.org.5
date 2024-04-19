Return-Path: <linux-kernel+bounces-151322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120D58AACE7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B9B1C20860
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD53A7E794;
	Fri, 19 Apr 2024 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIVUtXVC"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8170022085;
	Fri, 19 Apr 2024 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522724; cv=none; b=W7KpnNZ7zoVy0k3WNm4tVzxCq2LzH1WTVw1yyir/YB6cNhrmRg2+kdIL21Kl0k1XNME/sEemcrAxTwD2ATSQX4FLT11Dsns7nJ/jH6vZtCSu+/JOli+Z+5kiJy+InbO6DTo1htcEVnB6yhXZ8eFUli8aLf47wGNcymkecXKM7rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522724; c=relaxed/simple;
	bh=oMjuJg2nxzcJ7yzI/HWD4b2lVf4QtR3X0iqixF4fFGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lk5tEoW0MToc5nEEZfjAMbKdCZsRr4LVnoX8tGu/GjAR/Ocuql6yBXq7fh1RN2hOFG7s1ENrMtEfceiuhXGTpwE6lNzZ4zMPTT3I5ErTNg99+fHGDmWBbrQuKWdD9wF7fHmhfmTYvgvifNeS7K1A9/1lhOBpPBCTWSetclKMqM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIVUtXVC; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516db2214e6so2450605e87.1;
        Fri, 19 Apr 2024 03:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713522720; x=1714127520; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ADY1jQ3fMn8t5XRSmhrf7CXlATYEKca4dISZEI/O4I=;
        b=bIVUtXVC8g2KdZlpiVHX9sX0By/HFkvMmBPDkT2UNAE/I4dbXt29kD/DVeS0oJJ6tf
         xC8a3BUOMpKgO54VxmfQowdo2K6e/JyeHuTif3dsPmDokJVghrtpjJNNzSiqE1+Mn9Sh
         j02wbgaczFOZApM+M2p1xNCmi/MKJUk8KeTrm5j7orQtF/0keCq0WlJdy26SwIgwW6pa
         NzcLMSAD2IyxOfmEnJJX+6kn2JMbcJZR+KDKSwReS+fkExtGKkANJmUzSfCFcBM/LenH
         dSxvDh0JJfP+iys5bhSzCTBZHcZWAUsf/tVuSX8bMYVi1so5TXFoWIIZmCbB021TBksB
         s4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713522720; x=1714127520;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ADY1jQ3fMn8t5XRSmhrf7CXlATYEKca4dISZEI/O4I=;
        b=keSX9pjd7X1a0otXIrnT/qUB7dEmOmwfFFpFPmwRYpu0FqRqsGr0ywJP5EXsCfxNZ6
         lYr+5ce7qKCq/cJ/A/mHfjY3uB1MZKKB3droc5F/mf+i86FKye2lHDuCscoC8AJt0s0f
         6AijEUnlV68U/wcyhKYo8dnhMqWxbR6MGQ8tEdFo78lXKXXdhNLtmfVM+1OGyfR8uudc
         Q4eAoZbUImyeVRQEa6MuESnH3oCQAyK4VFK/ofqoJztN/XF+eZ+c4LSjNjpGcgr2lKip
         J0uIQS4bbZRoKp/LoaKo9a6+HfEsVczZXekckcBVzWit+l2xdUeVJ85Ff2ZfdC5TB/iI
         GLcw==
X-Forwarded-Encrypted: i=1; AJvYcCWtyA0kE4TmJgxQLUVRePYtJUe4pxOjOX6mb5cHQuZ80WIcovx4D6GuBo8M7tcZT6DPgXf98LnLCAy3517R9YkOKYFPU9gsqIWjsLwItZI60Ty2oET8Onm4oZ1D/yuXYLj0SPRx
X-Gm-Message-State: AOJu0YyDyZpaVUMjHExiwJL7JizW8ro5eFj7dGm0NCix840i2DNaROXk
	rpBRG+1hdrdxhY5ut1+tpW8xtzBEsSZtxDCRWsQ+8CNIC34pPZ9V
X-Google-Smtp-Source: AGHT+IHr1f2wQScjD2nMhwXM6LKMkGtdkS3wIc4hV1dHZdV23oMwK6P2ia0+IEZA+sRulz+K2TXHOw==
X-Received: by 2002:a05:6512:2807:b0:513:39a0:1fec with SMTP id cf7-20020a056512280700b0051339a01fecmr1166802lfb.66.1713522720278;
        Fri, 19 Apr 2024 03:32:00 -0700 (PDT)
Received: from localhost (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id p7-20020a05651212c700b0051abb2bfc76sm264087lfg.304.2024.04.19.03.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 03:31:59 -0700 (PDT)
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
Date: Fri, 19 Apr 2024 12:31:59 +0200
Message-ID: <86wmot7ie8.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


Hi,

On 2024-04-15 14:49 +0200, Lukasz Majewski wrote:
> +void hsr_handle_san_frame(bool san, enum hsr_port_type port,
> +			  struct hsr_node *node);

Function declared here but never defined or used.



