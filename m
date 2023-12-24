Return-Path: <linux-kernel+bounces-10651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B8C81D81E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FDBB1F2180C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 07:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AEF20F9;
	Sun, 24 Dec 2023 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHCIcONJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF461C14;
	Sun, 24 Dec 2023 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-35ffb15244dso976465ab.1;
        Sat, 23 Dec 2023 23:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703403872; x=1704008672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BV6l+VzR8Otb6xxnCm5UaMRDcIu9it9fiR3os5Qmr84=;
        b=QHCIcONJkYXEKw3IjaDeBRSGPTPNyDZXkUVdt6Ve32F0XufrSE86B8gX0hNOhAJSSZ
         dxougsds3Tg2C15JX5wceJGS8CQBG2IT6wXTX4BAYKcFmecyqA+h3L/d1CJoKs5mTQUu
         2Ep26vvi4qdubKC3NjRD2J6xr/d8LIEj3nB0xu41Pn2+1i6ZI8FftpJWPurQa5q4CGxW
         bN7by3j1OqVhnDml02RPju28Brvh2JDU0R1EsMdKobzF5ZZDdf+HRwZLlcASLZ78hTx9
         +jG2eTXAnK1G2nJZe1xNpU6xFcSh2uTJRNd0tlD0o2j8ejKX/JLeN9NYfTexxG6ZRGrH
         yW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703403872; x=1704008672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BV6l+VzR8Otb6xxnCm5UaMRDcIu9it9fiR3os5Qmr84=;
        b=VdwVqVWXVTc4uchqVs9XZdSgskooJJYqxfWTlcLXmP4FONfhbUTNLs6SfhYsqa6DZa
         l+vMPejeIg1u0uCWIrT4old7uXfo6WGfNRyipUo0MxsuH4rvcV8OZwYQOCg+3vIKYddH
         Qy2FkX4qgRcWp/rB2gMk6zjjGlRutrE1ur1vDL1siwpT+jF3dWjjv5nZxmWFvaTE4/p+
         WcaSwxziirQjm11lzK8a5qLAS5oDQvMXDxIP4NQ3VrxQiQTPMTBNOBVNCsw/riK/PSE/
         YdLA9aet2g6z/ep4YVZs8gin7u7EqbgwBRAl+FUmMaUrp+p5ZA1rq4Tv/IoHGaDUjVl/
         sTKw==
X-Gm-Message-State: AOJu0YxvSs3rm7tnM6ymTc53GoYKqGUPrMp29NMLGXOICFgjNO+lrk6i
	jT+BHlfgUq3D7CLFyp09Hvk=
X-Google-Smtp-Source: AGHT+IEluG3xWjBPWBwC7o4P+ek2duGQ8uD8ktVdwfOt+iVtcAp5BRLODXvEiyNTWir7Sa0qDGWjPg==
X-Received: by 2002:a05:6e02:1581:b0:35f:ae07:53f8 with SMTP id m1-20020a056e02158100b0035fae0753f8mr5753177ilu.116.1703403872210;
        Sat, 23 Dec 2023 23:44:32 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:765c:936e:ea43:6046])
        by smtp.gmail.com with ESMTPSA id d9-20020a62f809000000b006d9aa51f0a3sm1653569pfh.171.2023.12.23.23.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 23:44:31 -0800 (PST)
Date: Sat, 23 Dec 2023 23:44:28 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Christoffer Sandberg <cs@tuxedo.de>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: SoC button array: add mapping for airplane mode
 button
Message-ID: <ZYfhXJT8W6AkogLu@google.com>
References: <20231215171718.80229-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171718.80229-1-wse@tuxedocomputers.com>

On Fri, Dec 15, 2023 at 06:17:18PM +0100, Werner Sembach wrote:
> From: Christoffer Sandberg <cs@tuxedo.de>
> 
> This add a mapping for the airplane mode button on the TUXEDO Pulse Gen3.
> 
> While it is physically a key it behaves more like a switch, sending a key
> down on first press and a key up on 2nd press. Therefor the switch event is
> used here. Besides this behaviour it uses the HID usage-id 0xc6 (Wireless
> Radio Button) and not 0xc8 (Wireless Radio Slider Switch), but since
> neither 0xc6 nor 0xc8 are currently implemented at all in soc_button_array
> this not to standard behaviour is not put behind a quirk for the moment.
> 
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>

Applied, thank you.

-- 
Dmitry

