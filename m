Return-Path: <linux-kernel+bounces-125905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7009892DAE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 23:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 460411F21715
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97BC84F200;
	Sat, 30 Mar 2024 22:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="MfSZ27V8"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B8C4D112;
	Sat, 30 Mar 2024 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838921; cv=none; b=BrCe7ja6twGU/xs9Qde3NkUl9p92ssurFuuXBrbQmpcFiHUE6H679qVJjAS7jrlkGKYbIOtxYCrO0BpmpPHiHBTTSLSVTOYkVYqogpYWS/W+7ag+qEYEy8d6fzVf1nulamiWi2tXubRIlwa03hjKVHH0ClCDZbiYx/AoDjbWvVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838921; c=relaxed/simple;
	bh=nZvZp5iVGS/YVvrrJP/uzuMOEoN9MH70qBqhK0FtKOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLSonyECEg1KxIWdpmuW07tKYe33oeoyhBNXZrYdbMPfAumJBO4mAJ8EzUUr9Op9kK50yjat20titkDrSJ0/+imm5B2U6EHX49N+OVrhYvvr3FASwnMYE4IdCthwV+gFRHxHVGC70zDefSNYJOt6Ge0Sohv/9KjAGJHJ+4TCUoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=MfSZ27V8; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711838910; x=1712443710; i=deller@gmx.de;
	bh=/Mt6nYANl4Xr3V8zbXMCo1R9WsKVDkl65m/Lo6OXj40=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MfSZ27V8drmz/Lpk5/1fAHKoViN530embUOcNqMctbMrMi8LYk9yZaTBfr2tdG6R
	 4XQzqXjih8p9TCPiCrokU2aFZuZ/oHzxcNiSHa+yEdWX8huWk5PtUTqyiYEFqZeJa
	 cOhKF2lv7V6KcyPw07St+KlDJeTHbQEA+841oM5tg6m3imxPvVLlgC12Rs5T/gEuk
	 ysGzKZ9vOiFcqd0CDFfWohMEDZhJCUy0Uc+yzIw4xxNnbvKi96FW5lKgCMOdd0qfL
	 WBy1sweaGOztjnnWSLsC8QhxbQkGmsRDCXXQru8/W6AG5nv6ZFnhnbny9UOCLTDGN
	 gp92zAmBuzhreFw8Yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.187.169]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVDM-1s6B300MKO-00JpRR; Sat, 30
 Mar 2024 23:48:30 +0100
Message-ID: <d44941c6-c310-45f9-b2a5-c8b5c0d05a3a@gmx.de>
Date: Sat, 30 Mar 2024 23:48:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] parisc: fix vdso Makefiles slightly
To: Masahiro Yamada <masahiroy@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240330100849.426874-1-masahiroy@kernel.org>
 <20240330100849.426874-2-masahiroy@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240330100849.426874-2-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RA/Im6kEwrO2BkqPd/i6TY1F6iBR5Py1zL/MECaWFF9uiIhlpwK
 cM+mGOj7EGosyvr/4v6m5ozIfgz0Bq/q1t57IrKMG7KqqIdyzflStiUaS2XxEdCHhkyMy3I
 PKSB0xa1/KdoAuHvf99oQBZCP5/5Qli3/9waQ+Eqhj/FLlTMFTE0OsD0F8kahe72C8DluD0
 eb+D9s27c9C+BBY1fE9ZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Qq/VHLVuGDE=;nZOphKQ4b2+/n7tTR1GdpEh4QbT
 ys5juvALIMnJspKzCFnzWeMfJNuuleLf8yp3XexTwCxmS+Mv96biQbZyCZ8z9ob8NkgK5IJox
 2OLzTFJHjngW4LbsoXf3RGQ8yI6K0FHxa44iGZtGabi7X726yBWl5gbP2YLVYKwqcBJEfAqu0
 rV8MUMzVD/F6mfhB0a75YjdivCP5DkEeYmW+vgL5wCaR/O1mn1aOS7YAxDjong/rU74ten1+5
 xDlilWf9qt1a5mIHeFPCCXvTfVmePWXFAEjH2MmGQwoD4arCbs0y8eHHm317rw7vJ5iylUXXz
 nw23ns9F5eFacoW0CKV+w3ys4rC+JSR4+n/bLrginUJ5NKz6CcxCf9VhcfEJ1vXebJtI5BDxi
 OAiEs5gQi95DXpJZ5cOHO10qGDnItt9ulDlAb4/Yxtuz75Ir5NHtbkOalhAm4dZVFCMZc2qct
 wMs+3RFTVsj1Ek+RthZxmSBncY72xTUSfIDLyQ0Kj6e3iGwtXWDtCGRtpc90o1BlDS569rSZJ
 PxR0EYs5D/NAh29uPosoAOaRuAK5VE2ilEn/y3rpR6i28isIzWUvvVyPlshjnVLa8zkJDz7zw
 KUUEamW9qTKAS+M+fkrBBVKag9fU9uOCK6bwHEki/ps473VE0oMnoJvRuzeUIDrCc7Kn65ap5
 vSQOz4+F1nRZlSua3sN6SHe/w6veY0nhjTIFZfDFn2psnRLOU10lLyAByd+QNY+4i6b9N/SSU
 wTO9NEmXHJaW1tdfS0WHkX/4mCBqnA4O12Ttch/tAKeqKAdzhQIvwGoTWca/PLsVJ7zwwjhKF
 bk/QQRDx0INIalGXjOSlh5HDfHDP3HxMufWZdKUerVGgY=

On 3/30/24 11:08, Masahiro Yamada wrote:
> vdso32.lds and vdso64.lds are generated files. Prefix them with $(obj)/
> instead of $(src)/.
>
> They are generated as prerequisites of others. Add them to 'targets'
> instead of 'extra-y'.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Helge Deller <deller@gmx.de>

Helge

> ---
>
>   arch/parisc/kernel/vdso32/Makefile | 4 ++--
>   arch/parisc/kernel/vdso64/Makefile | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/parisc/kernel/vdso32/Makefile b/arch/parisc/kernel/vds=
o32/Makefile
> index e45d46bf46a2..f15367f77d49 100644
> --- a/arch/parisc/kernel/vdso32/Makefile
> +++ b/arch/parisc/kernel/vdso32/Makefile
> @@ -19,14 +19,14 @@ KBUILD_CFLAGS +=3D -DBUILD_VDSO -DDISABLE_BRANCH_PRO=
FILING
>   VDSO_LIBGCC :=3D $(shell $(CROSS32CC) -print-libgcc-file-name)
>
>   obj-y +=3D vdso32_wrapper.o
> -extra-y +=3D vdso32.lds
> +targets +=3D vdso32.lds
>   CPPFLAGS_vdso32.lds +=3D -P -C  #  -U$(ARCH)
>
>   $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so FORCE
>
>   # Force dependency (incbin is bad)
>   # link rule for the .so file, .lds has to be first
> -$(obj)/vdso32.so: $(src)/vdso32.lds $(obj-vdso32) $(VDSO_LIBGCC) FORCE
> +$(obj)/vdso32.so: $(obj)/vdso32.lds $(obj-vdso32) $(VDSO_LIBGCC) FORCE
>   	$(call if_changed,vdso32ld)
>
>   # assembly rules for the .S files
> diff --git a/arch/parisc/kernel/vdso64/Makefile b/arch/parisc/kernel/vds=
o64/Makefile
> index f3d6045793f4..25eb9a95422c 100644
> --- a/arch/parisc/kernel/vdso64/Makefile
> +++ b/arch/parisc/kernel/vdso64/Makefile
> @@ -19,14 +19,14 @@ KBUILD_CFLAGS +=3D -DBUILD_VDSO -DDISABLE_BRANCH_PRO=
FILING
>   VDSO_LIBGCC :=3D $(shell $(CC) -print-libgcc-file-name)
>
>   obj-y +=3D vdso64_wrapper.o
> -extra-y +=3D vdso64.lds
> +targets +=3D vdso64.lds
>   CPPFLAGS_vdso64.lds +=3D -P -C -U$(ARCH)
>
>   $(obj)/vdso64_wrapper.o : $(obj)/vdso64.so FORCE
>
>   # Force dependency (incbin is bad)
>   # link rule for the .so file, .lds has to be first
> -$(obj)/vdso64.so: $(src)/vdso64.lds $(obj-vdso64) $(VDSO_LIBGCC) FORCE
> +$(obj)/vdso64.so: $(obj)/vdso64.lds $(obj-vdso64) $(VDSO_LIBGCC) FORCE
>   	$(call if_changed,vdso64ld)
>
>   # assembly rules for the .S files


