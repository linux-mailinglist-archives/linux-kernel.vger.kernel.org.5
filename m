Return-Path: <linux-kernel+bounces-106518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EABC987EFC2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2656F1C21F74
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85A656455;
	Mon, 18 Mar 2024 18:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlX7pZNQ"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C383D52F79;
	Mon, 18 Mar 2024 18:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710786605; cv=none; b=V9mxBxV1y0kaiyxvDYdtuT8bsCUWSMmTl3KDCTFBGoQHvZFa7nC6YYaB+HqF8NiyuI6gSco84k6q856p+dxLc+EkHv/7hmAPQhGec2s74uyeU4CMMxxF1gLiCFXv3WBptKM6uQCvO/n3N2yEagufQTEW1tCcT/2QqRbUKO0aR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710786605; c=relaxed/simple;
	bh=Ynp8bnG6+buv71x1Nn3/pZNzAA8yZum+DGfVX7g8v38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YafSttsYsfflzmA/phdw9R6KEVD6lzT5C30pC8aboq9Cvwv5ja+Tg7OdAxLFlWEO+fDQOYgJVRtGNWk26/8OwHCbBC71Zyw3CHGLIetQOwbtQUqKQqKICEwTvNyY1dLJ/wdHJ+u8ccHEDB3jRvCSvm9YifH/OH0HD3u68zJN9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlX7pZNQ; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a1bd83d55dso1792183eaf.2;
        Mon, 18 Mar 2024 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710786602; x=1711391402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PaPJt/hu7G4f/gTzUz3Um2wpMJFHsYNVfGbPZ6hAVDU=;
        b=QlX7pZNQl8C1iZuGK/1lrdQXagw4YaqJRld6fQpT4rclar1m/HSZ8dOrC5278Ts72J
         3Bytlb0VX2+MBGSmhHxX+rj1eLBvOr8YDdjSksT/s5NtbMcQzpnApKIKY4JfxskO64jr
         kQham7O7t41eY4VS0fET0BjZqVTENc/oRb1PtIpVyWSJ/VyBOXKulBVTK/090tfEPJAh
         oJ5wLZ+MiSoHNvds+hY6RJl9zLZwfF2SZFypuj7iPhMRc2H4KKO0cAkUy/55MK1okou0
         wswhQRQ3OFjkwCE8ZIZ5v5gEmu/dlbRyQe/2hjx0WE09g9wEs2vwmLqa2RbTN0/NkOf5
         claQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710786602; x=1711391402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaPJt/hu7G4f/gTzUz3Um2wpMJFHsYNVfGbPZ6hAVDU=;
        b=fu8uieOalurtv46+xD+JhIcDxkvksX/I0SdJAEYjcRJS1iiissfqTTMQ9FZ/JnSygx
         DPGjc0Kncm6dx+hDAUYpdhDXaN9M4E1/0iuoIBMNfWh5w6+hG/AXHnnbRp760RbAt5Lo
         r3/HDFPEZIexFaYCyTYSr6Ii4HIClBBClBiXfN0VIj/klYVlyKoGHx8HHNOwJwk+6SoX
         16iYrTeE5PoUpq80iccJ/VT8qz35AElKS8yNpjxIIMaYbUg+a3RezybCPe+Y7eeYfWLD
         33WmYpCj81vlqe1KezSp3yUYIXFCHZByZgqpTy553oa0nLOc7vp61TH+bAuE8c7fxvA9
         l+cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxLbLmChMYuULT237oaJ56KyV+0JeBXYgaLx0m/5nYRdBJrjVcf6gGjrHWz+la8X2NACz79iqsqUYqxravBgOXNZU9FHMZ84/9a7Ryd3UJxyM2YtLhlpRJSfe9C+2pTEw3aVvlk6g=
X-Gm-Message-State: AOJu0Yw2LCpOvHLjsMT3y78ONMim0QxRoyq3H+Syv6el3iQOwOAPyNMi
	xleoYQTb4KDY+4KWSh3EcW9sBYtpUZvFMBjT1FGiqUVcbTCmhC7T
X-Google-Smtp-Source: AGHT+IF8xiLUm5ZYOFopZ7ZCcIOH7LS23jILG8PxDkK5d3PlqHTVcf/ilXTgyuhGaFAODtP8m0RFbg==
X-Received: by 2002:a05:6358:52cd:b0:17e:694d:57f9 with SMTP id z13-20020a05635852cd00b0017e694d57f9mr10760688rwz.31.1710786601681;
        Mon, 18 Mar 2024 11:30:01 -0700 (PDT)
Received: from five231003 ([2405:201:c006:31f8:807c:8911:659b:1495])
        by smtp.gmail.com with ESMTPSA id s26-20020a65691a000000b005e838b99c96sm3770527pgq.80.2024.03.18.11.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 11:30:01 -0700 (PDT)
Date: Mon, 18 Mar 2024 23:59:55 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-hwmon@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: Re: [PATCH v2 2/2] hwmon: lm70: fix links in doc and comments
Message-ID: <ZfiII_4xMnemzWqi@five231003>
References: <20240318130840.74589-1-five231003@gmail.com>
 <20240318154540.90613-1-five231003@gmail.com>
 <20240318154540.90613-3-five231003@gmail.com>
 <6c8b2699-5488-4ae0-8d78-59bcb2030a2e@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c8b2699-5488-4ae0-8d78-59bcb2030a2e@roeck-us.net>

On Mon, Mar 18, 2024 at 11:11:29AM -0700, Guenter Roeck wrote:
> On Mon, Mar 18, 2024 at 09:08:35PM +0530, Kousik Sanagavarapu wrote:
> > Update links in the documentation and in-code comments which point to
> > the datasheet.
> > 
> > The current links don't work because National Semiconductor (which is
> > the manufacturer of this board and lm70) has been a part of Texas
>                       ^^^^^^^^^^
> 
> Is this a leftover from the other patch ? The lm70 driver supports
> the LM70 chip, not a specific board.

Yeah, it should be "the manufacturer of lm70".  Thanks for spotting.

Should I fix and resend this specific patch as v3 or would you edit it
while pulling?

