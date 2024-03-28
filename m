Return-Path: <linux-kernel+bounces-123550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 194E9890AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2601C27F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB2513849A;
	Thu, 28 Mar 2024 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+drNiz6"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D05131BA3;
	Thu, 28 Mar 2024 20:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656821; cv=none; b=th2wQ/L3c3C2S5/2GeNttMbWS1i+atautAE86FE/YnT9wLw6nmzmWT+7op3h+VFWyDYHUiEK8DoUrZ8gRhPTTjccgLQAL23hA6b4dIqWIdYfnCCB8UZDAshbBw9OB5xalhleUIDLthRKe8XniIl/lMcexhSvwXmVyRgsPg7VWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656821; c=relaxed/simple;
	bh=xm4BNUTfDgO67+eXj8M7Qk2l7ZEhup+lEssGSxNSDOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAxl/Uoh1lnBplhFu9ceHXC0uFzedb8bcbwj+ElkZjShUZ0q2Ih33luYp+swL78YrK3VpuyeMWVB8B8QLr/6Qv7YvlkStbfdNlRavPE34bU1C65fT1Ad2eiNA/ztoEtmVbz3xrHxBHFP2eC4rYthRqjLxEi2HsXJDOMtq/6K1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+drNiz6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0f2798cd8so12553695ad.3;
        Thu, 28 Mar 2024 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711656819; x=1712261619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fgUsxV4VoJF7d2glcoMovVqVoVYDXEoEZNAbQKQAfc0=;
        b=F+drNiz6my8qMXxmwz2ZASh1ICAoZkKuq2OBNrwmEC7duI+fzZI+v8/rC3su68tZHp
         HQMXjTuwNzvRc7J0fSoJg2EbVNKovgUJieRmWh5byf+Uxdp+p8TxfQDncYm49nttiJh2
         YBkisAp6/ZUFw6dRtrsdtjCVR7bl3tU6dlVUMj8JOfQTQmMClDZtuyPRJxtJRLhp6QRR
         JakJ0DtxVAi97E0xpP7feWtU7A/MA0I4Mo6jVrU2Ck9jWNLU8yzSNZ7Z2CKjkkIQKmZ8
         3RznwWOuyAJ0MdcNy84RRVLFAdBO9c23kOVUEYLR0oAAMmbepoHySt3VSh1Lsq2xF0Rc
         0mzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711656819; x=1712261619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgUsxV4VoJF7d2glcoMovVqVoVYDXEoEZNAbQKQAfc0=;
        b=h6ydoK8Cdn85GVrRuGInUGanGj8P5voU6YyWMDJ3CFD6HIfw8Fr9PTgpJMkLK3/zku
         W2RQ3QDrrI466fprK6ZOyIYS0mfjd5U72s9kFfFSN5CoRt31SL31OW6CyC9g816//Lr0
         Z5lQAD6yrE7u1Ae/iSJXM+sZBd2zpIp5Sek4aBruzWEWsl0eg0MHgiwfTmY6ERmZs5c+
         7LmK05ECyG74QlF/ON4yHAfT6hdR/EZbK/evpK90A1uYPy4DcOWmgBAc6Nk0s+VzxPRP
         NSpgUuP8kuDDhi6ddZwaI9GtmvTQltJ0+Ua/FpkpOt3hxpZZ9KYVEB97pu0sIbcfoATS
         A21w==
X-Forwarded-Encrypted: i=1; AJvYcCV26dInLVZAkExh2dAB3mOclDlblNRuaMOGlx/RjgO80BYeSgX3qrRvP+Yqfvz0QT2AB8McsyvuUvEFvLdSJA+id0Ex7UDPm5uM2PV9
X-Gm-Message-State: AOJu0YxjaiTVMih6ohJHobyulImG+lyG03TBkK4+Bwf7z5aAE5eVxHtM
	fqzXp7rBNXj+bT2gq8MC5Ysu3t+YDyqCv3d4rGjNHhcHbtoGnoEi
X-Google-Smtp-Source: AGHT+IEJd7NvzFnPESl+PNer+0FvqA+KmSg4ExUyA9GqzEH1In5+hir0Ic4ktkG7vP8gBDl0szKvmg==
X-Received: by 2002:a17:902:ecd2:b0:1dd:a3d4:9545 with SMTP id a18-20020a170902ecd200b001dda3d49545mr669820plh.54.1711656819274;
        Thu, 28 Mar 2024 13:13:39 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id ld11-20020a170902facb00b001dd55ac5d78sm2037046plb.184.2024.03.28.13.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:13:38 -0700 (PDT)
Date: Thu, 28 Mar 2024 13:13:36 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marge Yang <marge.yang@tw.synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	david.chiu@tw.synaptics.com, derek.cheng@tw.synaptics.com,
	sam.tsai@synaptics.com, vincent.huang@tw.synaptics.com,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH V1] Input: synaptics-rmi4 - Enable support for F3A by
 default.
Message-ID: <ZgXPcBNsGMujY0m1@google.com>
References: <20231110082148.1032629-1-marge.yang@tw.synaptics.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110082148.1032629-1-marge.yang@tw.synaptics.com>

Hi Marge,

On Fri, Nov 10, 2023 at 08:21:48AM +0000, Marge Yang wrote:
> RMI4 F3A supports the touchpad GPIO function, it's designed to
> support more GPIOs and used on new touchpad. This patch will
> enable support of touchpad button.
> 
> Signed-off-by: Marge Yang <marge.yang@tw.synaptics.com>

This should go to Jiri or Benjamin (CCed).

> ---
>  drivers/hid/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index e11c1c8..f3a989e 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1082,6 +1082,7 @@ config HID_RMI
>  	select RMI4_F11
>  	select RMI4_F12
>  	select RMI4_F30
> +        select RMI4_F3A
>  	help
>  	Support for Synaptics RMI4 touchpads.
>  	Say Y here if you have a Synaptics RMI4 touchpads over i2c-hid or usbhid
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry

