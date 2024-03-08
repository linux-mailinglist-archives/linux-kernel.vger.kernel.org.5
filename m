Return-Path: <linux-kernel+bounces-97024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336C2876486
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64C481C21DA3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCEC200CB;
	Fri,  8 Mar 2024 12:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCcndZdF"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210AA17745
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 12:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709902100; cv=none; b=uXTv1O0sgk/rRxH/QkAiO2NN6u5GXiDWdMWgVlac70NczVIgLN3AN03Qvqg93ZHnlBogHl1l5Qz7C1x8KcEakp//DbQZpH7J+wdq+Ah4LbIscpZRnpfO0jhMkTenK5U/MoUPB8x8hcO/DZRBdRmBopkQt7+9oRjXQDa2ghTY4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709902100; c=relaxed/simple;
	bh=xegJH4vpgWIq4jvmp7Me16zptXtBVbXQRT6nUhs+3ME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D15lEuG/lvFeclAtSyMG6yfLROxe0HHxy7nGsqzy/N9ZqdhhewcRbU216khlAD4T0D9TlsltCNCLzhy4c37VivEeItt32y+PggNnt7LrborcyqDulUShmQVgetF3aAhD5YDtcmr7pnvBetK/zV4Y2JLX1jxsfONDkVGxUjsG2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCcndZdF; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-690b0431c33so3511446d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 04:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709902095; x=1710506895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEQMPaHSrrUB490O1SAmcB35AfHIyWfslAM8bV9KDYI=;
        b=CCcndZdF+1X+ZNhdfu37CLwN+DQ2HYrZ9pY+Lw5wLj2iKQCT8sqHdk8ktyaFdxuRMV
         7JWRVWoSIFUMVp82iEhoVOT5WX8ddZKjW0jlLjh8zunu/C3QpSRNogKh0inY4oAhjw+r
         bSSXudZHCveUNJsp6K1WUzy4NTlmA2KZ1LX+prELQAlWSacp63/Zdl/gQwqD1NU+OFRc
         oVzjEP63bkp8Pg+cuM0iYOGlVBc818VvchSI7oJDR0Ra0KdoEytTYOnIfoav6MfFj6nZ
         /bJfXUtFzuzKdD5gRLhpTf9WBnqq9UDZqyFSa+vdVMMjtsBGqFowqHbDdzhX1IFbQYxI
         69hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709902095; x=1710506895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEQMPaHSrrUB490O1SAmcB35AfHIyWfslAM8bV9KDYI=;
        b=j/2sjgHIWkfhe6jvVkmLfJHX2hmqcLSj8WDml9d6CnGuBTxR4AXx/sAS8pxeYDZFQZ
         c3bYTLRQEt4bnSmjvJbeoM2MRvUfQUqmOgUjHTiPFQ0KhZ9nvsFy4peHEhnKpm6OLPAI
         IqDIF1U//dM5/Psw3YAcLfWKR1htyjeBRFn7mfGrcqXFsGMbnEh4OOt7n++n/q5B0LYh
         1UHlxuwJQ3geTuD2PkCk6IoSVL9/Ny6p83bBIr2hqlTmB8O5jrTjPlEufGbSlv4yVMzC
         ViEXtWGA7yYmckmMlrLc7Ym9+9Pd3812COcfQP2iZQa6t3cndkTxeT3GzZKLcCMm7UV3
         hRwA==
X-Forwarded-Encrypted: i=1; AJvYcCU4SRkknQWPGGcqn3DtfcgCiaCk3NwYQa18rCh83SYh2ROan1S3qQtF+0j8aiC5E7m0wG8EweUdKuBuF2bn4w57NH3y+S2nWMi8G/uL
X-Gm-Message-State: AOJu0Yxw0bUqqL6hsTYSg6MYbwtiHhfBToVugREVznRTUt/e6VH9CAMp
	X+4cl0WySrTdhDCl+7x0v6Tu/ftaUtQyuUf4kT/7FkoIX109DF3TYonUDuhdmkv55UFpsuMf2QV
	ExxN53pRo9AWyHBSBRCyMzG4bBA4=
X-Google-Smtp-Source: AGHT+IEalNH2R/tL6qfn6E3ejGPepmjQH+mg21qk5cfptxB2ajVK7ug+/PyT9sDFq9gPA/4xude96HB5BwUtKqxXYd0=
X-Received: by 2002:a05:6214:5085:b0:690:3c85:c5b with SMTP id
 kk5-20020a056214508500b006903c850c5bmr1681835qvb.3.1709902094924; Fri, 08 Mar
 2024 04:48:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNnE=tz6dfQO4fU58jAYNT2A=9g0CjtdMOQ05AVM6yDRA@mail.gmail.com>
 <c10916cd-670f-41c9-a3a7-7599b0a9a946@p183>
In-Reply-To: <c10916cd-670f-41c9-a3a7-7599b0a9a946@p183>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 8 Mar 2024 17:48:04 +0500
Message-ID: <CABXGCsOPPuDSSLsOpzvzv+t8yL9z-gzoMTBY0wAL-s1Cd+bDyg@mail.gmail.com>
Subject: Re: regression/bisected/6.8 commit 5d390df3bdd13d178eb2e02e60e9a480f7103f7b
 prevents the system going into suspend mode
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: stfrench@microsoft.com, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 11:15=E2=80=AFAM Alexey Dobriyan <adobriyan@gmail.co=
m> wrote:
>
> What? Deleting unused defines breaks suspend?
>
> Collect fs/smb/client/smbencrypt.o with and without patch and
> see them being identical.
>
> Enum in stddef.h are
>
>         enum {
>                 false =3D 0,
>                 true =3D 1,
>         };
>
> so if defines were used somehow they would expand to same values of
> same type.
>
> Something else is going on.

I understand your confusion.
But I didn't come up with it. And moreover, I saw what the revert does.

diff --git a/fs/smb/client/smbencrypt.c b/fs/smb/client/smbencrypt.c
index 1d1ee9f18f37..f0ce26414f17 100644
--- a/fs/smb/client/smbencrypt.c
+++ b/fs/smb/client/smbencrypt.c
@@ -26,6 +26,13 @@
 #include "cifsproto.h"
 #include "../common/md4.h"

+#ifndef false
+#define false 0
+#endif
+#ifndef true
+#define true 1
+#endif
+
 /* following came from the other byteorder.h to avoid include conflicts */
 #define CVAL(buf,pos) (((unsigned char *)(buf))[pos])
 #define SSVALX(buf,pos,val) (CVAL(buf,pos)=3D(val)&0xFF,CVAL(buf,pos+1)=3D=
(val)>>8)

Why did this really help is a question to which I would like to find an ans=
wer.

The most interesting thing is that I have two identical systems:
Identical:
- M/B - MSI MPG B650I EDGE WIFI
- CPU - AMD Ryzen 7950x
- GPU - AMD Radeon 7900XTX
- SSD1 for system - Intel Optane 905P SSDPE21D480GAM3
- SSD2 for data - Intel D5 P5316 Series SSDPF2NV307TZN1
- PSU - Asus ROG LOKI SFX-L 1000W Platinum
- Mouse - Logitech MX Master 3s
- Keyboard - MX Keys Mini
- Linux distro (identical version of all software) - Fedora Rawhide
On one system this bug is present, on the other it is not.

Affected system: https://linux-hardware.org/?probe=3D9a5a8c0338
Not affected system: https://linux-hardware.org/?probe=3D37c62300bb

--=20
Best Regards,
Mike Gavrilov.

