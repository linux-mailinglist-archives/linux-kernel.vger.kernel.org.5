Return-Path: <linux-kernel+bounces-67937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA0685734D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16F7CB23DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2ED2F0;
	Fri, 16 Feb 2024 01:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiTTd/46"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA11D267;
	Fri, 16 Feb 2024 01:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708046212; cv=none; b=DJXL3P8yVaEpwlJ6BJ34O5TNE42NfFhjg5M1yFnVxx9lv3UhU1JJLXsoVagAueVHqLSd4jFcVS8cTeH5M6lAgVUNKvNm4ZNYId6jCUnVOfzd4m9Q8tZ/APqG72Mloi5KaIAoLciNrcAQmjCNrrNiG7PxXvYVUWK9iTPMcVXekSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708046212; c=relaxed/simple;
	bh=V+ZtxNTTkmuOF/6gVBMGVUleC+8v+tJPdfpHWcvscao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UPBtXvazQj2yyUL8EngEILbzrZBSschLh6f2c/81L6qWntkzSwovK6u6UKWeLMPIWAFBeYzI1nJ4H2LV5yHO9Eno3qfNaaD1NIRbkzrDNeEREkaF2UvSlH4uqfYPJQDPjbP1PSNboX+aoZXyz+p59hZ+njYIs3BVK5bPsK3EzW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiTTd/46; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3392b12dd21so787804f8f.0;
        Thu, 15 Feb 2024 17:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708046209; x=1708651009; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V0/5eEMUdgTFVPz51GyIaKKFky9Useu7YxYIgUjehmU=;
        b=fiTTd/46tjvShtJcJsgg4VMCIF5L9Yk4N/aMZnTAwphzrvxbC+3/WtPTMrXZrlCuPn
         jX7YH680OEGO3ZMI+x45oDznxenH3SRkOwVxWQckCMPCJmka9O77p+h1QI5ROhPaE66a
         O3OtotHmWjemOlZLfy2iLWy5nevqq+s/+B+rMySEG5ShW4LWxL2jq3PMCwu43TW9qQKH
         V5wG6u31jfQNF+peBKuVB2shyC/fF5+et4a5shVytnruNsTCvXfaTIjY+by1JPgxtSkQ
         h4qFTuUc/tBpBGdhvMwF+Vb4ySLSyIrAeuKbsbNUoqTF08TrGeB7zlaa3Kl8G1hlxpt3
         D2Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708046209; x=1708651009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0/5eEMUdgTFVPz51GyIaKKFky9Useu7YxYIgUjehmU=;
        b=PZ3wgHH0eubnnfTDaJHNm53Dj2Esm2HJ5KM6C8jneb+mj8wVmSbdN8oChUsyvn4J7m
         SGu12t728LEvptchbvwDz7n/qMwJx9UJZtjgoRIDGrSGpWKYBpuZ7Q3RZ/GFqC6y4wNV
         QBzr7Rqx8U4UCmieaJcxyM2OXhVNUJeH67evemUfh+WBDmxa5XFSdi2IlHvwyF0CNLiQ
         8G5v3ommnIDeamJnaUUnyrBtOI+v98/nXCVnVTZq4siSihLTdjvF9aHiqrL+X9c4wYcY
         Ole9mqG9v9nrMqNjK2IbyOW9t8gqYNFXHLoDZJwoLF3sAwsS+EUlL3MIEOaF638cY/6Y
         kuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnh0jvhifEXZ3DeXSa0ZwmCI8aELcQt6uIyx+t0kY3tLohqDlyAhU2s9psg0CTXki6P/4p5+lpraSyfXEuE5Gq6PYQsmT266iz58QcUHDoOiRd+pnodR+gmfQcszqLSisa5kUlxwB5Q5X9Gu6W+fdx6hBJh2l3+UQywxLIzedZgQ==
X-Gm-Message-State: AOJu0YzYZdqd5QX5EXPVi2cJTTg/85T2onFWnKs5AsshR/jOGcA7lsXO
	IB2hrDtzuOGsTxR3THG96ru/vVJ+XXBZakUiKx/eYoJN1ASf75Br
X-Google-Smtp-Source: AGHT+IGpSo3EhfDZ/i5SD4NlrQwI0RJUEWTJXx7zxtcU9xNLdWd1XlQVgaOuhsmEJNL4xG5epTIpmA==
X-Received: by 2002:adf:ff8c:0:b0:33a:eb5b:f8cd with SMTP id j12-20020adfff8c000000b0033aeb5bf8cdmr2686949wrr.7.1708046208844;
        Thu, 15 Feb 2024 17:16:48 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id j27-20020adfb31b000000b0033cefb84b16sm645021wrd.52.2024.02.15.17.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 17:16:48 -0800 (PST)
Date: Fri, 16 Feb 2024 03:16:46 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/3] net: dsa: realtek: support reset
 controller
Message-ID: <20240216011646.yri2ecvuetxbgkhp@skbuf>
References: <20240213-realtek-reset-v3-0-37837e574713@gmail.com>
 <20240213-realtek-reset-v3-3-37837e574713@gmail.com>
 <CACRpkdZELbOmZieZTDLfA81VuThM7h399BWtuQuQ6U7o8Xb7LA@mail.gmail.com>
 <CAJq09z4wgPo=1_OtA6Y-0O4gLJ2nxy1jdf0BDoZwVmL=TkOdUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z4wgPo=1_OtA6Y-0O4gLJ2nxy1jdf0BDoZwVmL=TkOdUg@mail.gmail.com>

On Wed, Feb 14, 2024 at 07:17:55PM -0300, Luiz Angelo Daros de Luca wrote:
> > > The reset controller will take precedence over the reset GPIO.
> 
> I'll remove the "ifs not null" and let both be called.

If you do, be sure to update the commit message about it (see first line).

