Return-Path: <linux-kernel+bounces-125903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8270892DA9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 23:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D811F20F6E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7794D9E9;
	Sat, 30 Mar 2024 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="rx9emI40"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE122079;
	Sat, 30 Mar 2024 22:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838810; cv=none; b=KzHjeyroPq5z/6s4r1hiLY1rqMiASp/ESBO1pJSWKbGgpfzWinNCptlqSPFwOrSKUNCh2KyeWqlMDw6rJXcqlLbui9+EoChshmhQ5QCN7Y4Dmvw8oQGb25eGFirSMoRblL1SFy+8iA0VkPIMVPwvwX/0prABy0fnOBMGXaYMfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838810; c=relaxed/simple;
	bh=IQjGZ/NG+SjbqlD22izLBIlvBYvAh8AzwOg+Cl4zt4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tL2E74eQv4YA51xYKI09Mkrcbnwg9GnR/ELSxBElKBpUrM+RohFLNU5CE5JdasKYuSVOiMceNE/FhmZT3v01+SL0OausihS8aCMXvoJgyjhthgEga3ML5vG6fg2bLd3M2SMiAh+CjRYKxkwSYRcCRgsBi+MNSaezX5StYWwLaKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=rx9emI40; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1711838797; x=1712443597; i=deller@gmx.de;
	bh=vT+LQOaFur7/w1jehyazCMf+3mXqsOcuSG5RBCwISyQ=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=rx9emI40h+krjj9lZKrYfpcCk9SZFrySaSyzN5g4oHTHzYtP5J+SK65Fay72DAMY
	 hlnUWIwaDrqU2oW+lKhtfsIkbo65IQT1WhSSWdOD2nC0hFWJr4Utc1eUrqMz01rZl
	 K5ppTLNDVXprotVZKC8fDr3TtiX5gjEF0xIgFgb8I7Jabqx+q2dcJPLapcQO3dyDU
	 FpgIm5dn2zBLf0Ri9mCannfAnsBaqDB5b1Ccy7hMyE/ctrax1o2LeRgar8Jrrmi9S
	 3jNfHMFP0dgE4FThDnI0eYQOhTUYDUgn2XEA0dO2Tl9jUhzmCpv6DIbCfUe0ifoZX
	 FXhKKnKHaaTVui/G3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([89.244.187.169]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKhm-1sB6ff09DG-00OlRM; Sat, 30
 Mar 2024 23:46:37 +0100
Message-ID: <c29a12d1-840c-4fe9-b03c-200182be0191@gmx.de>
Date: Sat, 30 Mar 2024 23:46:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] parisc: vdso: remove dead code in vdso32/Makefile
To: Masahiro Yamada <masahiroy@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240330100849.426874-1-masahiroy@kernel.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240330100849.426874-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yr5OFtyBqqY+LeeQpzB02aZh69NwbtCJeNpQNcQu12ms1Y3sQyI
 Ux7RRfGpxGOaWCrtH2wXUtEq3h2+i9FEfcYr7wOMcTbU1fDeKV8qqq+jK86MdG7ab1esAFG
 v4I708202HJPXTnh3Vyto6LmqFszNxI/1KekUqM6XHrepf3ACouF47DZgVvGzIWZbeEX6Zk
 yvn534VKxlEuBYpIx5kxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EbN1QdH3gy4=;cr+BBJElkBMYAsMrrSpjNwoBqTF
 Smpglep2j3s6p6Ga4/OfcHS7Bqm8+wWGR3FPFP7jizvpzLiQL2WZuVipM/9XQaHDS0LCSBosE
 J+0hmcG0Wcm7UrA6yn82jZgoZF6BKCxkFhvJtXCzllPGEJ77cvEXNT8GpWB2X/QZJyL82QNqW
 5I1JTdgELG459BNO3njMx/IiLm/6HlFfnkAdcCx+9vGN7UqWqiMoI3n+FAPx91eGkx3FudsOC
 DtWp0y4tiZd5k9Wl0mRS9bnGgg5kv7DAXsXtn0VftxpXbsdvX6C/4eDbVD2I9Pa6qz8VxBNk4
 f+5edGvmh39SpenSoS8JggXpCdgZv5VB9zfVe//tj7/vJ+LGe+VUtqzKtFJ3mjNsoy+0oIV/O
 5Lcdi/2FO404mcskIJ2FnQNC/YyvSrRC0x7iBhnjP/pG0tPySoHeQYPqEpPDb5BRVyGcqNJ8j
 B1/4qDokEJwpas80fzUspgg5GbkeF6BMr7Qh4zBQfEjFBZ/6cGG5uLZfVz5p1zXkexe6pMS3P
 LhthuO3C9MI7Et4TvnCeKimVpKJ5knlYpSsalK+nF3DnSxuB1f+3WkZqZcDtb/Ssvxt3xsUXu
 pZlQk2G0AT24XK80kv24oCZu24CvYhJcBMZGK8ViUHuE1hHgk7lZKRypJJd1BaKaLZn0I55b5
 f/RIiOIcfDsB+x6VOblhbAHK3ZJB6qXE2L1mxHhVQDyU4TEdX0LWGse+e8NmsoRWNaXhdgXg2
 svDM+/YUUpe+nRpi+ci4qhMO7qb/sAK+SYSx5PA2Reh82a4cQQHGcGjuhuIPWGGFIOI4vXH6X
 aFceGGGCAw2rrvhpA3h59PThIhSFhYpTtM+iTPOOBkSB4=

On 3/30/24 11:08, Masahiro Yamada wrote:
> This commit removes the unused build rule because 'obj-cvdso32' is
> not defined.
>
> If you add a C file into arch/parisc/kernel/vdso32/ in the future,
> you can revert this change. The kernel does not keep code that
> may or may not be used.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Helge Deller <deller@gmx.de>

Thank you for those cleanups, Masahiro!

Shall I take your patches via parisc git tree, or will you take
them via your git trees?

Helge


> ---
>
>   arch/parisc/kernel/vdso32/Makefile | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/parisc/kernel/vdso32/Makefile b/arch/parisc/kernel/vds=
o32/Makefile
> index 4459a48d2303..e45d46bf46a2 100644
> --- a/arch/parisc/kernel/vdso32/Makefile
> +++ b/arch/parisc/kernel/vdso32/Makefile
> @@ -26,23 +26,18 @@ $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so FORCE
>
>   # Force dependency (incbin is bad)
>   # link rule for the .so file, .lds has to be first
> -$(obj)/vdso32.so: $(src)/vdso32.lds $(obj-vdso32) $(obj-cvdso32) $(VDSO=
_LIBGCC) FORCE
> +$(obj)/vdso32.so: $(src)/vdso32.lds $(obj-vdso32) $(VDSO_LIBGCC) FORCE
>   	$(call if_changed,vdso32ld)
>
>   # assembly rules for the .S files
>   $(obj-vdso32): %.o: %.S FORCE
>   	$(call if_changed_dep,vdso32as)
>
> -$(obj-cvdso32): %.o: %.c FORCE
> -	$(call if_changed_dep,vdso32cc)
> -
>   # actual build commands
>   quiet_cmd_vdso32ld =3D VDSO32L $@
>         cmd_vdso32ld =3D $(CROSS32CC) $(c_flags) -Wl,-T $(filter-out FOR=
CE, $^) -o $@
>   quiet_cmd_vdso32as =3D VDSO32A $@
>         cmd_vdso32as =3D $(CROSS32CC) $(a_flags) -c -o $@ $<
> -quiet_cmd_vdso32cc =3D VDSO32C $@
> -      cmd_vdso32cc =3D $(CROSS32CC) $(c_flags) -c -fPIC -mno-fast-indir=
ect-calls -o $@ $<
>
>   # Generate VDSO offsets using helper script
>   gen-vdsosym :=3D $(srctree)/$(src)/gen_vdso_offsets.sh


