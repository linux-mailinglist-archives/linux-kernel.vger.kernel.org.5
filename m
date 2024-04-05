Return-Path: <linux-kernel+bounces-132763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA208999DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0751C20F2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9035F160881;
	Fri,  5 Apr 2024 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbrVApFv"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB419142E73
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310710; cv=none; b=kdVe6Swn0IuO8VLjaAey+rRf4x2XJo/sc41JEFJvmRLiJcvjgwwDatcDV3NJvOwREdGRdevnzQLl4wdhK2b6FbisXCwForljUWp1ZYwKG67lpXAJeqJaympEDG2V2fHi37TnQkiYs/WLbvN69ol9aWawWEN0bYphFRnOUfbFsIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310710; c=relaxed/simple;
	bh=9z7NXciC8Z8/xPDHcNCTcqyOvDYKe+Q//7hKlc2E1fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F00LjghQTjMJH0N40TKZJxhjTbIWodk9QEmSMyjyZ2U3LbY7DyfNj8u6XHw3Mt4qkJKxsM2luxTFPZjJ115jhyCsFs0/nqvozQDJOmGjx0+2tZtgbiepiRQSecOSPAqRKXPmcvKD8MBhLyqqqUEZhIZXMhe9F8ubdfLz0NyMtj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbrVApFv; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-516d6e23253so82667e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712310707; x=1712915507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XznLbi2Z1SKvx8bRj0+Hw75ngrOt6iwbmtsVcIRJxZA=;
        b=JbrVApFvipQKIx68+/9lcIy+ybhZTcBFyUjgjy2xBmPRu4qMbBzM6rAcCU+E8d5FPo
         VoUCbGKNK+ADHf0MtrP7kwdtCj4V3MNTMV8zYJonX0uKLekbHAIV+GCQXfix/qeFmSPb
         YzchkGUk/SJ6/w7o+EPq327QeNW5H/GeuzcYgYB/CYhJ8CJ4Z6gMlp23vJ/rtlcZ864x
         jEHLOW2EAUekATvZoNevH6dqjWd9B7tIWTJv5OmjVZfqTSdjfzkum7BAQmWKT0QPX4Qs
         1LijJde4lV6ObRX3g621WBOHxMJJj+DyJVol/10XapQyhtdKqBQQvH8hgEulcsMEMK94
         eOMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712310707; x=1712915507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XznLbi2Z1SKvx8bRj0+Hw75ngrOt6iwbmtsVcIRJxZA=;
        b=WEJB0mQDjM9xs7HFMhbEjBa7Vu/BxqzBsGC3yqA//OAXfuL6QnBL8mJ/fB3Cfp7vhA
         32NlHbxk2AapvAsk4JGB02Xldw56EOcvHQSrq4pDgOnWWB9X+2G7hnEDocnvNCy1pqQu
         MV4Dtr62y9IsyFUgH83zk3dqtUUUVu/YdUM6ZL8valp8LqT6U82ioVDJXu7Y6rPFYJDt
         r52WVcMnoux86a9N0zlghn7Tuu27rB5TMFA/QSjykRyvD8ONh81Gqp96sPtQPaei5e6Z
         bI/0lleHNmVgJ6PWsBJpPPHqYhhH0lfeKkNdTRA84zVeOKedxGQB7nx+gDPIhvi8gRMc
         bz3w==
X-Forwarded-Encrypted: i=1; AJvYcCWYrtA8j2OTahtNHo0xz+noazUfbJvyzjCjSwIGAQ9QxY73xJc3U/f/9AMR6WJy8NQIhRnbSxro//LjMXww55IBPaQqwl+PO7EFoeS/
X-Gm-Message-State: AOJu0YyWzCSIAiCvLfKVbRvP9+a6I1rTVFGzvjd9MZWtvcoV5W1Ud6L1
	vateZGd0s910yfrsFQedSu+MR28UPalQjJzmIYUuBbqxQIM94A93VAVUnV9fFZc=
X-Google-Smtp-Source: AGHT+IFuRBcasfkE1HoHSCQ7OdWv+EtlpW9OQz09tguqfMAKrRd1NUyHNpjIOZuZmN0l9ZISYTgUFw==
X-Received: by 2002:ac2:5ddb:0:b0:516:d2eb:6edd with SMTP id x27-20020ac25ddb000000b00516d2eb6eddmr735020lfq.26.1712310706830;
        Fri, 05 Apr 2024 02:51:46 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id e28-20020adfa45c000000b00343e1c3298asm1428854wra.0.2024.04.05.02.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 02:51:46 -0700 (PDT)
Date: Fri, 5 Apr 2024 10:51:44 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] kdb: replace deprecated strncpy
Message-ID: <20240405095144.GB2890893@aspen.lan>
References: <20240405-strncpy-kernel-debug-kdb-kdb_io-c-v2-1-d0bf595ab301@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-strncpy-kernel-debug-kdb-kdb_io-c-v2-1-d0bf595ab301@google.com>

On Fri, Apr 05, 2024 at 02:33:58AM +0000, Justin Stitt wrote:
> We should move away from using strncpy because it is deprecated [1].
>
> Since these buffers want to be NUL-terminated, let's use strscpy() which
> guarantees this behavior.
>
> The code in question enables the visual autocomplete when using kdb tab
> completion. After pressing tab a couple times when sitting on a partial
> symbol it will attempt to fill it in.

FWIW the code that this patch changes is only executed when tab is
pressed once.


> In my testing, strscpy() provides
> the exact same autocomplete behavior that strncpy() provides here (i.e:
> it fills in the same number of characters for the user).
>
> You can confirm this by enabling kdb [3] and booting up the kernel. I
> performed my tests with qemu with this incantation (wow these get long):
>
> $ /usr/bin/qemu-system-x86_64 -display none -nodefaults -cpu Nehalem
> -append 'console=ttyS0,115200 earlycon=uart8250,io,0x3f8 rdinit=/bin/sh
> kgdboc=ttyS0,115200 nokaslr' -kernel $BUILD_DIR/arch/x86/boot/bzImage
> -initrd $REPOS/boot-utils/images/x86_64/rootfs.cpio -m 512m -serial
> mon:stdio
>
> ... then you can type some symbols and see that autocomplete still kicks
> in and performs exactly the same.
>
> For example:
> tes <tab><tab> gives you "test",
> then "test_ap" <tab><tab> gives you "test_aperfmperf"
>
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://www.kernel.org/doc/html/v5.0/dev-tools/kgdb.html#using-kdb [3]
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Changes in v2:
> - use strscpy over memcpy (thanks Daniel T.)
> - Link to v1: https://lore.kernel.org/r/20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com
> ---
> ---
>  kernel/debug/kdb/kdb_io.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 9443bc63c5a2..60be22132020 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -368,9 +368,9 @@ static char *kdb_read(char *buffer, size_t bufsize)
>  			kdb_printf("%s", buffer);
>  		} else if (tab != 2 && count > 0) {
>  			len_tmp = strlen(p_tmp);
> -			strncpy(p_tmp+len_tmp, cp, lastchar-cp+1);
> +			strscpy(p_tmp+len_tmp, cp, lastchar-cp+1);

This still looks like it is reproducing the obvious[1] error in
the original strncpy() call. The third argument does *not* provide the
number of characters in the destination buffer.

Just to be really clear, I think this patch and your original memcpy()
conversion is mechanically correct, in that the new code is equivalent
to the original strncpy(). The problem is that neither patch acts
on the warning signs that the original code is broken.


[1] I know that this code is hard to read so "obvious" is a relative
    term. However just looking at one line tells us that the source
    pointer is part of a two pointer calculation that purports to
    give the length of the destination string! Such code is almost
    always going to be wrong.


>  			len_tmp = strlen(p_tmp);
> -			strncpy(cp, p_tmp+len, len_tmp-len + 1);
> +			strscpy(cp, p_tmp+len, len_tmp-len + 1);

Again, I really don't think the third argument provides the number of
characters in the destination buffer.


Daniel.

