Return-Path: <linux-kernel+bounces-31843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DB8833562
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 17:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14AB5B2280B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D3210949;
	Sat, 20 Jan 2024 16:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6yMl61m"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F82F101D5
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 16:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705769836; cv=none; b=YEQauWN3JcDW0cySBtpDzfebiPzShTgwXq5XX5s+Vln91z6PHA0J3QYPdHtVPD2AZ/0RD8XhU69BKPgTFYwrnTfEyb/1REyksk0HC8dMfLf41qqGZjz3rbjQzEGeAl+ZcS+Q6f11gQvZrsU1oV0MqSdHcfqoBI70sU3vOZC1GS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705769836; c=relaxed/simple;
	bh=ZGsBpgEMRShqEVubsqrqPTpj9Jf2Gr5Vk4sDR+iN44w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfM3ucKZoz1xZEACvZvchPra3jmB0mx9jTs4tO4Yv/JZFFP82iNN9lh5gOhjqPn9HfbO0QUZaLx8SBYa2VF9HOSENimbZKJO/8rYWBNd67EJ4lfp5zLwvJ6klZ3Q04J7rh66l55NV4vg9LOKt40pBp3lhjCQio08Fpj2Qp+DlXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6yMl61m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e490c2115so17299855e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705769833; x=1706374633; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tac42I2B9h9I8FHC3cTVBJpUPC7zDS2iMWbRy2mBu7A=;
        b=J6yMl61mZlKSXnPqLRdQ0ezD4QsN3D0SKg6bSHzYR4VhdidpV4PLFqV48parMzCbpT
         78jz5R8yibv3p1n88aXWEgEXzhEsDpGSHl7EctkRwqbxAnq/EEvFa12lAEF+56/ca1lG
         e7b4UGjBoMnt9BdVjpSPOG49mynSK2tH1xb2wRqh/u8Qi5zDHpYdlowiDNpEC2C87j1T
         9egv25hgHncY9L9PY7Bi0Yuj1rkz1HdVPkOpQNaosKTF8Ikan6GShX/XRYFy4giFuEFK
         uTUqPXeISHSxJJ73rfYBh15TWoCIvJ++xyGl9tyz1nApnlMu89Y6Zjmf+qTHsKS39SIQ
         wZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705769833; x=1706374633;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tac42I2B9h9I8FHC3cTVBJpUPC7zDS2iMWbRy2mBu7A=;
        b=ZLHnLvKZzxuaUMsUnx0gNeftu7PZh9D3sW6g7whbVPrJiyU9LHzk9H9ROpC3YoJ/CP
         7NnSXSlrlUZzcslqkh1eM3Vawnqz4090FmPF34pAQro4QNles72wNXiBEy7Pse+psa77
         AZLof1ck8xk8hlNR9+fA1y1cfN3wIDD/dK3g8+4rQfhJbqxNcmy1tYkCpDyW+FpI0qwH
         oGRZy0VYVfSWM1G0u2en6tdLnb88Dq7k28ClR2jpMYCLMuaPw8//DBcvNlLt2Q6etc5u
         V2Ye4BXMJAFfme/GD5n95i1A5n+5+w7f+iztY58BT6lCCg0aj4nbazMG73B36j7JWlAF
         vvgA==
X-Gm-Message-State: AOJu0YzuocQdTdj/ei0kiRtZAwtYtfhuRnVwqUZC+ipL0tk67lBhAfET
	+14u58SU7m0zvbODUU+qGxUfJnLNBX9/yszTm2lwvL8+YtUKkDHk
X-Google-Smtp-Source: AGHT+IHqXHtcBrFWeCCx7UaFE9PsTHEOMhuDr5Y3VTvmTkPtbgZ/30M3IdFT+AV+lGvLLfmudrk7jQ==
X-Received: by 2002:a05:600c:1709:b0:40e:45ae:1a83 with SMTP id c9-20020a05600c170900b0040e45ae1a83mr813583wmn.153.1705769833078;
        Sat, 20 Jan 2024 08:57:13 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id u21-20020a05600c139500b0040e4a7a7ca3sm33194086wmf.43.2024.01.20.08.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 08:57:12 -0800 (PST)
Message-ID: <65abfb68.050a0220.a9c65.ecbc@mx.google.com>
X-Google-Original-Message-ID: <Zav7ZbiB2AV3uUq-@Ansuel-xps.>
Date: Sat, 20 Jan 2024 17:57:09 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Nathan Chancellor <nathan@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Kees Cook <keescook@chromium.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH 2/2] ARM: decompressor: add option to ignore MEM ATAGs
References: <20240119201356.7903-1-ansuelsmth@gmail.com>
 <20240119201356.7903-3-ansuelsmth@gmail.com>
 <CACRpkdavA+OL-ek0JGBRFX=n_H4=j8DbB+nCr7=8htscAzrzFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdavA+OL-ek0JGBRFX=n_H4=j8DbB+nCr7=8htscAzrzFg@mail.gmail.com>

On Sat, Jan 20, 2024 at 12:51:06PM +0100, Linus Walleij wrote:
> On Fri, Jan 19, 2024 at 9:14 PM Christian Marangi <ansuelsmth@gmail.com> wrote:
> 
> > Some bootloaders can pass broken MEM ATAGs that provide hardcoded
> > information about mounted RAM size and physical location.
> > Example booloader provide RAM of size 1.7Gb but actual mounted RAM
> > size is 512Mb causing kernel panic.
> >
> > Add option CONFIG_ARM_ATAG_DTB_COMPAT_IGNORE_MEM to ignore these ATAG
> > and not augument appended DTB memory node.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> So you cannot just ignore all the ATAGs I guess?
> If it's the command line you need, you can pass an identical one in
> chosen.

Ehhh it's not that trivial... Downstream we have a patch that takes just
the bootargs from ATAGs but reality is that only MEM is broken.

Also duplicating the bootargs from bootloader in chosen is problematic
as have tons of device that use cmdlinepart to declare partitions and we
are not aware of the partitions of every device.
And also there are some device that supports dual partition and the
value is provided by the bootloader bootargs so duplicating it would
result in not having a good way to support this.

> 
> But if you really need this, it should be there.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 

-- 
	Ansuel

