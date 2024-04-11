Return-Path: <linux-kernel+bounces-140581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAD78A1671
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6875286B16
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA5150990;
	Thu, 11 Apr 2024 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuYQoFWL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECCC14E2C8;
	Thu, 11 Apr 2024 14:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844023; cv=none; b=XRy+sC7yqNsirSDjEDHHx4P+/nFMZ6N1pIdIbQtF1z5656sN84tIj6VsFKayvBnp0AO+zl/pgXJdY9pGi7LEM4A7KGOQ+folF4euMyrD3Fwu0PdPuK/IgvzRfjO/WdcomStiq7ici5/kpIdaGp3YBibDibjaWZns1zso8Tdf4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844023; c=relaxed/simple;
	bh=tRqmwlzhcYdgVr2YujS1WgTqkzUd0nEXs80I0voRZ+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQmJBxqLBSL/CaLPMizOHVM4HrtlV/BCh94Tq5IU+EDU9j2EyKDNoLNAv4+mq48watUtCnmKYsnQxHInGgRfZEflKyVtZj5omPkNXzte0iv/akVX8EFqmJ7AvuEdjMlQ5pNCMJZNyEptX2kUA9bXUG1I5i4zy5IaWxLDnt1Jo40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuYQoFWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C7FC113CD;
	Thu, 11 Apr 2024 14:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712844022;
	bh=tRqmwlzhcYdgVr2YujS1WgTqkzUd0nEXs80I0voRZ+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IuYQoFWLDW0TewoWOc1egpvTc7oRKlFdRDOxTdOO6mj8F+jf/LWNPnH6utlZMgCRp
	 Wlm7VdDje7q00dBLqJawgrlJWje3n8r7h5914tgSM1R4vzFi/aElZWtaxhbFhhmRgC
	 e58DoLz7Np5deIUBaY59yKM3JF4OYy/zVNTZAdncc0IZG9wlVf/Lp3ONzbho3qDhxA
	 7PiLNDS4jimFjHuyBxgGXNcQIY7QPBXIJgMAFhYS1GK6mqT4LKEvKcSN1Nce0pzVqp
	 IrVB4USDmK+/pPizmKeVnvc18vBGueLeCeNv0UC1glnbvyiNGiLZG0DyscUb1jvVjk
	 uYc17bsqWwNLA==
Date: Thu, 11 Apr 2024 16:00:16 +0200
From: Helge Deller <deller@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] video: Handle HAS_IOPORT dependencies
Message-ID: <Zhfs8CN5XdgldKUn@carbonx1>
References: <20240410142329.3567824-1-schnelle@linux.ibm.com>
 <20240410142329.3567824-2-schnelle@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410142329.3567824-2-schnelle@linux.ibm.com>

* Niklas Schnelle <schnelle@linux.ibm.com>:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to #ifdef functions and their callsites which
> unconditionally use these I/O accessors. In the include/video/vga.h
> these are conveniently all those functions with the vga_io_* prefix.

Why don't you code it like in the patch below?
inb_p(), outb_p() and outw() would then need to be defined externally
without an implementation so that they would generate link time errors
(instead of compile time errors).

diff --git a/include/video/vga.h b/include/video/vga.h
index 947c0abd04ef..32c915e109fa 100644
--- a/include/video/vga.h
+++ b/include/video/vga.h
@@ -203,18 +203,20 @@ extern int restore_vga(struct vgastate *state);
 
 static inline unsigned char vga_io_r (unsigned short port)
 {
-	return inb_p(port);
+	return IS_ENABLED(CONFIG_HAS_IOPORT) ? inb_p(port) : 0;
 }
 
 static inline void vga_io_w (unsigned short port, unsigned char val)
 {
-	outb_p(val, port);
+	if (IS_ENABLED(CONFIG_HAS_IOPORT))
+		outb_p(val, port);
 }
 
 static inline void vga_io_w_fast (unsigned short port, unsigned char reg,
 				  unsigned char val)
 {
-	outw(VGA_OUT16VAL (val, reg), port);
+	if (IS_ENABLED(CONFIG_HAS_IOPORT))
+		outw(VGA_OUT16VAL (val, reg), port);
 }
 
 static inline unsigned char vga_mm_r (void __iomem *regbase, unsigned short port)



> 
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
> and may be merged via subsystem specific trees at your earliest
> convenience.
> 
>  include/video/vga.h | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/include/video/vga.h b/include/video/vga.h
> index 947c0abd04ef..ed89295941c4 100644
> --- a/include/video/vga.h
> +++ b/include/video/vga.h
> @@ -201,6 +201,7 @@ extern int restore_vga(struct vgastate *state);
>   * generic VGA port read/write
>   */
>  
> +#ifdef CONFIG_HAS_IOPORT
>  static inline unsigned char vga_io_r (unsigned short port)
>  {
>  	return inb_p(port);
> @@ -210,12 +211,12 @@ static inline void vga_io_w (unsigned short port, unsigned char val)
>  {
>  	outb_p(val, port);
>  }
> -
>  static inline void vga_io_w_fast (unsigned short port, unsigned char reg,
>  				  unsigned char val)
>  {
>  	outw(VGA_OUT16VAL (val, reg), port);
>  }
> +#endif /* CONFIG_HAS_IOPORT */
>  
>  static inline unsigned char vga_mm_r (void __iomem *regbase, unsigned short port)
>  {
> @@ -235,28 +236,34 @@ static inline void vga_mm_w_fast (void __iomem *regbase, unsigned short port,
>  
>  static inline unsigned char vga_r (void __iomem *regbase, unsigned short port)
>  {
> -	if (regbase)
> -		return vga_mm_r (regbase, port);
> -	else
> +#ifdef CONFIG_HAS_IOPORT
> +	if (!regbase)
>  		return vga_io_r (port);
> +	else
> +#endif /* CONFIG_HAS_IOPORT */
> +		return vga_mm_r (regbase, port);
>  }
>  
>  static inline void vga_w (void __iomem *regbase, unsigned short port, unsigned char val)
>  {
> -	if (regbase)
> -		vga_mm_w (regbase, port, val);
> -	else
> +#ifdef CONFIG_HAS_IOPORT
> +	if (!regbase)
>  		vga_io_w (port, val);
> +	else
> +#endif /* CONFIG_HAS_IOPORT */
> +		vga_mm_w (regbase, port, val);
>  }
>  
>  
>  static inline void vga_w_fast (void __iomem *regbase, unsigned short port,
>  			       unsigned char reg, unsigned char val)
>  {
> -	if (regbase)
> -		vga_mm_w_fast (regbase, port, reg, val);
> -	else
> +#ifdef CONFIG_HAS_IOPORT
> +	if (!regbase)
>  		vga_io_w_fast (port, reg, val);
> +	else
> +#endif /* CONFIG_HAS_IOPORT */
> +		vga_mm_w_fast (regbase, port, reg, val);
>  }
>  
>  
> @@ -280,6 +287,7 @@ static inline void vga_wcrt (void __iomem *regbase, unsigned char reg, unsigned
>  #endif /* VGA_OUTW_WRITE */
>  }
>  
> +#ifdef CONFIG_HAS_IOPORT
>  static inline unsigned char vga_io_rcrt (unsigned char reg)
>  {
>          vga_io_w (VGA_CRT_IC, reg);
> @@ -295,6 +303,7 @@ static inline void vga_io_wcrt (unsigned char reg, unsigned char val)
>          vga_io_w (VGA_CRT_DC, val);
>  #endif /* VGA_OUTW_WRITE */
>  }
> +#endif /* CONFIG_HAS_IOPORT */
>  
>  static inline unsigned char vga_mm_rcrt (void __iomem *regbase, unsigned char reg)
>  {
> @@ -333,6 +342,7 @@ static inline void vga_wseq (void __iomem *regbase, unsigned char reg, unsigned
>  #endif /* VGA_OUTW_WRITE */
>  }
>  
> +#ifdef CONFIG_HAS_IOPORT
>  static inline unsigned char vga_io_rseq (unsigned char reg)
>  {
>          vga_io_w (VGA_SEQ_I, reg);
> @@ -348,6 +358,7 @@ static inline void vga_io_wseq (unsigned char reg, unsigned char val)
>          vga_io_w (VGA_SEQ_D, val);
>  #endif /* VGA_OUTW_WRITE */
>  }
> +#endif /* CONFIG_HAS_IOPORT */
>  
>  static inline unsigned char vga_mm_rseq (void __iomem *regbase, unsigned char reg)
>  {
> @@ -385,6 +396,7 @@ static inline void vga_wgfx (void __iomem *regbase, unsigned char reg, unsigned
>  #endif /* VGA_OUTW_WRITE */
>  }
>  
> +#ifdef CONFIG_HAS_IOPORT
>  static inline unsigned char vga_io_rgfx (unsigned char reg)
>  {
>          vga_io_w (VGA_GFX_I, reg);
> @@ -400,6 +412,7 @@ static inline void vga_io_wgfx (unsigned char reg, unsigned char val)
>          vga_io_w (VGA_GFX_D, val);
>  #endif /* VGA_OUTW_WRITE */
>  }
> +#endif /* CONFIG_HAS_IOPORT */
>  
>  static inline unsigned char vga_mm_rgfx (void __iomem *regbase, unsigned char reg)
>  {
> @@ -434,6 +447,7 @@ static inline void vga_wattr (void __iomem *regbase, unsigned char reg, unsigned
>          vga_w (regbase, VGA_ATT_W, val);
>  }
>  
> +#ifdef CONFIG_HAS_IOPORT
>  static inline unsigned char vga_io_rattr (unsigned char reg)
>  {
>          vga_io_w (VGA_ATT_IW, reg);
> @@ -445,6 +459,7 @@ static inline void vga_io_wattr (unsigned char reg, unsigned char val)
>          vga_io_w (VGA_ATT_IW, reg);
>          vga_io_w (VGA_ATT_W, val);
>  }
> +#endif /* CONFIG_HAS_IOPORT */
>  
>  static inline unsigned char vga_mm_rattr (void __iomem *regbase, unsigned char reg)
>  {
> -- 
> 2.40.1
> 

