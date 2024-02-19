Return-Path: <linux-kernel+bounces-71164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 516AE85A184
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED822831C0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CC82C848;
	Mon, 19 Feb 2024 10:59:53 +0000 (UTC)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112F2C6B7;
	Mon, 19 Feb 2024 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340392; cv=none; b=XvoUUIl73fvMcDa8nZZGyAdhcDboJs0JLs4tOlYHw3NvXUGRiWl5ySdlv8XmQOfz2m1Ryo8l1hlJPYDgLHvQSXf1OhWsR5zJCXoxee+0wNzd7NIotsp55nG/qTXlYCbu3+/czXCkpf+4rXtGvDf1H8/4/2V7d0GiqetXKwC2Jwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340392; c=relaxed/simple;
	bh=9iYUBTrDt0nCCeA++luD/E09crSal7ZT4gRTognu6/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8TLEGnZBuXQiQSPkKT0YejdEx/Pi1lamTOl+Nm5kOIbJQdL9djTEsxkfzUUuWlfucu9ZYXQaRHvdqwvTkPrjcGOj655/Rf+WMLiaJ+ANRe/sSG0nrEeE7zTuBkMRzb1aJrur1wfkxUlS6R1VQNx7Zq6DsOWQJKEPZG/xxussuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso3923433276.1;
        Mon, 19 Feb 2024 02:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708340389; x=1708945189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsKj1zxCBujArf1Qupi8h232PRBUoq5ShZ2hvEaWeJs=;
        b=rLHjS6QqhvUyzgnx3JjtyRSnEOvD6KO/gFzZNEGkTIyIqpjoZJKiqHOaJKZLKYzJNQ
         9k5ovCx0gIcRqEJPN2Yzzfp9awU49RNH7n+Rc0woUG3M+0b3aNSeGSOhKtxMnb3J+7yl
         hWYz0vhKdHoDTSYYbkR3LJDD5qByR1SwbaXjWKb+UjbjjhYTxBE6PKSfJ+aefU4eOSgz
         n2PfULcH2ZpH8B9DtQh+RH4Vx5a633Lh2/fPh3C8+VvoCZEdxqK3eIu5nYxd0d5FC6PN
         oV9kqDVB5qAeZXKoQnI+y80x4w419G6ces0lmJ0XH6GsjnuwK6K2vzDPjRh1/3PqjCVX
         arfg==
X-Forwarded-Encrypted: i=1; AJvYcCXsDaAyjZ+13WYnWE8wsm9jjRc4bxMI5YTmlhJNhwrxBrAtHPPzhlSMnyQlCA0DtESDIp/+ZqlvbQNpwv7+NSYJAIhOdfqb9dXiaw4ruFe35YBlX2jrYmHu7XGONlUTX2ugvy5dm/BpDLuqFcxK7Nk=
X-Gm-Message-State: AOJu0YzKy1c/ifk+NaTR929TBysUUsmzpElPSrAc2TUMR4LtYmMiVG4k
	m5LcBw50jgzwfeq51pA4Hv9B5GPyJoeUOJxnO54eWm5ZfaEXHf4B8W57HwYpKug=
X-Google-Smtp-Source: AGHT+IHSRFkgSZyfJv0Zx5xHdFWYe8GF9x4eOCbZ0UdhcbwwZ43KnaZ6EFDCb9haCOV/dTtBV4SETw==
X-Received: by 2002:a25:d80a:0:b0:dca:c369:face with SMTP id p10-20020a25d80a000000b00dcac369facemr11777606ybg.18.1708340388594;
        Mon, 19 Feb 2024 02:59:48 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id 189-20020a250bc6000000b00d677aec54ffsm1416987ybl.60.2024.02.19.02.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 02:59:48 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso3923403276.1;
        Mon, 19 Feb 2024 02:59:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXKu0T2P5fxP6/iKh0GtVMPeQyu7OThca2SRnz2pbLZ5Txb4r641hUnY7pJTr+3T9339qsZy9RG7uDjIP1UDYZARn6hoM1I4AOp+kF5Gmd+F5P57wZgq1WM3EYNookzTmbC/MXxUfZMZW/mksjk4A=
X-Received: by 2002:a25:5f0d:0:b0:dcd:3a37:bdb1 with SMTP id
 t13-20020a255f0d000000b00dcd3a37bdb1mr12200960ybb.44.1708340388188; Mon, 19
 Feb 2024 02:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202095636.868578-1-saravanak@google.com> <20240202095636.868578-3-saravanak@google.com>
In-Reply-To: <20240202095636.868578-3-saravanak@google.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Feb 2024 11:59:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVon3mdivZQ0O6D4+va0nGBrUQbDp23bEq661QD=4t7+g@mail.gmail.com>
Message-ID: <CAMuHMdVon3mdivZQ0O6D4+va0nGBrUQbDp23bEq661QD=4t7+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] driver core: fw_devlink: Improve detection of
 overlapping cycles
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Saravana,

On Fri, Feb 2, 2024 at 10:57=E2=80=AFAM Saravana Kannan <saravanak@google.c=
om> wrote:
> fw_devlink can detect most overlapping/intersecting cycles. However it wa=
s
> missing a few corner cases because of an incorrect optimization logic tha=
t
> tries to avoid repeating cycle detection for devices that are already
> marked as part of a cycle.

Nice (I assume it's due to this patch ;-), with v6.8-rc5 I see much fewer
dependency cycle messages.

E.g. on Salvator-XS:

-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef7000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef6000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef5000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef4000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef3000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef2000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef1000/ports/port@1/endpoint@0
-platform fea80000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef0000/ports/port@1/endpoint@0
-platform feaa0000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef3000/ports/port@1/endpoint@2
-platform feaa0000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef2000/ports/port@1/endpoint@2
-platform feaa0000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef1000/ports/port@1/endpoint@2
-platform feaa0000.csi2: Fixed dependency cycle(s) with
/soc/video@e6ef0000/ports/port@1/endpoint@2
-platform fead0000.hdmi: Fixed dependency cycle(s) with
/soc/sound@ec500000/ports/port@1/endpoint
-platform feae0000.hdmi: Fixed dependency cycle(s) with
/soc/sound@ec500000/ports/port@2/endpoint
-platform feb00000.display: Fixed dependency cycle(s) with
/soc/hdmi@feae0000/ports/port@0/endpoint
-platform feb00000.display: Fixed dependency cycle(s) with
/soc/hdmi@fead0000/ports/port@0/endpoint
-platform hdmi0-out: Fixed dependency cycle(s) with
/soc/hdmi@fead0000/ports/port@1/endpoint
-platform hdmi1-out: Fixed dependency cycle(s) with
/soc/hdmi@feae0000/ports/port@1/endpoint
-platform vga-encoder: Fixed dependency cycle(s) with /vga/port/endpoint
-platform vga-encoder: Fixed dependency cycle(s) with
/soc/display@feb00000/ports/port@0/endpoint

-i2c 2-0010: Fixed dependency cycle(s) with
/soc/sound@ec500000/ports/port@0/endpoint
-i2c 2-0010: Fixed dependency cycle(s) with /soc/sound@ec500000

-i2c 4-0070: Fixed dependency cycle(s) with
/soc/csi2@fea80000/ports/port@0/endpoint
-i2c 4-0070: Fixed dependency cycle(s) with
/soc/csi2@feaa0000/ports/port@0/endpoint
-i2c 4-0070: Fixed dependency cycle(s) with /hdmi-in/port/endpoint
-i2c 4-0070: Fixed dependency cycle(s) with /cvbs-in/port/endpoint

FTR, the only remaining ones (on Salvator-XS) are:

    platform soc: Fixed dependency cycle(s) with
/soc/interrupt-controller@f1010000
    platform e6060000.pinctrl: Fixed dependency cycle(s) with
/soc/pinctrl@e6060000/scif_clk

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

