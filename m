Return-Path: <linux-kernel+bounces-18112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771BF82590B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 18:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC798B21676
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D508321AF;
	Fri,  5 Jan 2024 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn/9KCKo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3C3218C;
	Fri,  5 Jan 2024 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5f093e7c095so1485517b3.1;
        Fri, 05 Jan 2024 09:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704475769; x=1705080569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k7QJySwDQ7NTkbKcbw/A3aOLckB6WzzI0AOdXEu2nM4=;
        b=Hn/9KCKolkqxlhj2B9JUn1eEOeAfpfz1iYRbRzc+BNtO3rYelUgH6tQmKAlHfFNm+W
         oaVjzpJpCeoBnfMprj8mJ3YQS3GcT7wmZUC8dBMsudey/T2orb/2WuykDZzX+mHw9NRC
         e4DOoUHLVvCkjtTFv3qpWc4xFWxwilyTElwsifrzVTOFK166ABAwzvAtAHxcicb0dPSB
         hy4N9QJJpawQzExndRxMt5UKgB1jEEcHPOg+TB13bmS4Gpdrq5miMMg6istJt1XdFJJv
         K7m2wJApuMhyyqGu9fXUSf7ruK2YrQM7KiU1cQL4rTCZ4i6i2JexWHaS5iARBCbCiO1a
         o5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704475769; x=1705080569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7QJySwDQ7NTkbKcbw/A3aOLckB6WzzI0AOdXEu2nM4=;
        b=A5y52TmHhO+4SFjLLKyU3hGiZAIyreitV392oVnIqHlc0pCeWAPcex3YSB1waw6hAl
         pNx7dzXFpLT4ZUeb42upfnKh+aZLwXLMahkLPqM4pun6X3fzktMZvZqEcqCGh7s7DUj2
         JAKy+ZkHVSKM9t8vGpaFp88dJb3xv0WleXNSgVy0FVG0xFhkp8B9J9pC9zoTd0Yc2Pdf
         r5Q86q1OxJ7KOP/IdVhQZZWcpC2HJ4SYdO4QEK3GG/7jMbuJtgHWxV3l16iMP6jseTgq
         BFO10YPNvLan+eyynlNbBXpAxm7JE31bMD4epDH1h1rxoWZRJAYdqTNEmhT3wHi5EH1F
         b3nw==
X-Gm-Message-State: AOJu0YxLsEJfVmUKTMeK835y9eV+1xuitbUhwTBEHaFa9DSoJQN9C7sa
	g4nkybJbwxEt3zgT7p4ypG594t+eqLc=
X-Google-Smtp-Source: AGHT+IFUyoTdm8+qIH2Eyd/JHmmDXU24n3J0kViKBI3ezD2Rjd8T8lnpaWkbG4HnJMo/Rw7/6Jei+g==
X-Received: by 2002:a81:80c2:0:b0:5e9:811:91cb with SMTP id q185-20020a8180c2000000b005e9081191cbmr3877216ywf.5.1704475769285;
        Fri, 05 Jan 2024 09:29:29 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id r189-20020a8181c6000000b0058fc7604f45sm782659ywf.130.2024.01.05.09.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 09:29:28 -0800 (PST)
Date: Fri, 5 Jan 2024 09:29:26 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Min Li <lnimi@hotmail.com>
Cc: lee@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 1/2] ptp: introduce PTP_CLOCK_EXTOFF event
 for the measured external offset
Message-ID: <ZZg8dmWUNB1IfZMF@hoboy.vegasvil.org>
References: <PH7PR03MB7064E904EEBAAF0992DF42A2A0662@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR03MB7064E904EEBAAF0992DF42A2A0662@PH7PR03MB7064.namprd03.prod.outlook.com>

On Fri, Jan 05, 2024 at 10:23:12AM -0500, Min Li wrote:
> From: Min Li <min.li.xe@renesas.com>
> 
> This change is for the PHC devices that can measure the phase offset
> between PHC signal and the external signal, such as the 1PPS signal of
> GNSS. Reporting PTP_CLOCK_EXTOFF to user space will be piggy-backed to
> the existing ptp_extts_event so that application such as ts2phc can
> poll the external offset the same way as extts. Hence, ts2phc can use
> the offset to achieve the alignment between PHC and the external signal
> by the help of either SW or HW filters.
> 
> Signed-off-by: Min Li <min.li.xe@renesas.com>

Since I ack'ed v6, if v7 has no substantial changes, then you should
have added the following line to the commit message:

Acked-by: Richard Cochran <richardcochran@gmail.com>

