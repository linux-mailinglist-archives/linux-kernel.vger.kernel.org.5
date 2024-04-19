Return-Path: <linux-kernel+bounces-151217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE4F8AAB3D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 11:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FD61C21EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02FE757F6;
	Fri, 19 Apr 2024 09:14:03 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0AD4D131;
	Fri, 19 Apr 2024 09:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713518043; cv=none; b=CnkRXhTbn7WZurG9Og0z1L70UCjU01Z332ZrvwGlbpTCAiLUiqg5Fr1WwWUKacnc/yfU7uhOAUhpPBTvyLRasH2exzGVrNXFbBiXhJvnIlrUDvnHT2ZMjOZecIKYX038VZbimToTE5bcE00UI56arEqocaegc+eSajVRjdUqDAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713518043; c=relaxed/simple;
	bh=H1XCE8POymxb9O0nL575s1AZcXMw7/i6tvt14CsEffo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mprpwPp9mSsSHZX9kjKE/AP1wbkYhY0/vp13iZUHf2UTK/EiCQlEuzz8bX+TMz0IWnTxg4R2eGFEx6NEGkcGECKNeiC3KQ5l/v11eJ0CsyhXlPq88osUVbTVR9NfvU0CFmDK91nvtp9GcMXCVT8kmbbb5+5FCKptFAEpakD7c7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61804067da0so18737837b3.0;
        Fri, 19 Apr 2024 02:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713518040; x=1714122840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gVMY8E21Fl9ECgjygikdUcrBwHveHTBHkiJds8LbEk=;
        b=IIbMmn4Dc1t1lTR5ZrUZfzqtgoV3XpmsRJZoq5uQfLpS8/G+alyayPgs6u56u9bzRN
         IMw0PpnEOS2rz0mlG1MY0QaC/UrUui2vQ/4dLbjD1FCGaRVthpF2J0C0/1Yv3YAJC9Wf
         vJh52/sj3De4c5/YLTB+1yp3M7/u6jAEmoekf23pP9MFPPeuHFc5dnzrbOn5PD7bZqqu
         7ygpA3fhciZvp1b3WketftVHc6cabjedraZIl8Z7IlrgnyY+ySloBdi5tnREXYC+1fF2
         C+5sS6TMCeMQiCmGfdtdDpVWuFywe/9RBeyP63iyxHAGlC0WwjwrbbDtZOhyr1TlIs+P
         K/Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUNPO9UDNE+eWBOtaaaW7mXbzPMeIUgKTkmjyOWKELNPnvRjs1aw1wkLVwzLGXF/zLeKeABzqNCx8TTfmv41Hcrsw4oTDeSC0u5eHCsXonr94qNWIh65lXKlOBVGQfNhBsERdeXA48=
X-Gm-Message-State: AOJu0Yzlxa8tj+yQ8TgWmbszyIAYHACZgpjweoAhpUXYu7laTEPyNFzy
	dM69gy/Zz+35JvkXBVSN99sfYgeZiIKxVmrTtzExBVNNt+YxhuqQxdNP7OR4
X-Google-Smtp-Source: AGHT+IFEQJiC0JAJIwBOXvxzOJd8FBY8nlca64lUsWW/hoAZqj2pYbNtGfcuxfYUQKKbKpDLiXGvjw==
X-Received: by 2002:a05:690c:c02:b0:61a:f127:34c9 with SMTP id cl2-20020a05690c0c0200b0061af12734c9mr1457465ywb.17.1713518040034;
        Fri, 19 Apr 2024 02:14:00 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id m3-20020a0de303000000b006152af6131dsm701484ywe.119.2024.04.19.02.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 02:13:59 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de45f3f092bso2224907276.0;
        Fri, 19 Apr 2024 02:13:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpcWiTyt/dIuBDgc5hcvgYB2Z3v8haBsRAk699AFdp6zatkvd8VvJXCrN5XfyE6i31IzOAzCpz8coVj1PyEv83hgfqwolPm5XawTp4LI0VLmCJXIN89kR6meTWkSlgxfXTTMiP6xE=
X-Received: by 2002:a25:8185:0:b0:dd0:972b:d218 with SMTP id
 p5-20020a258185000000b00dd0972bd218mr1282834ybk.41.1713518039110; Fri, 19 Apr
 2024 02:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419090259.39542-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20240419090259.39542-1-yang.lee@linux.alibaba.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 19 Apr 2024 11:13:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-+32mM9pyh+RsH0oUrJrzvLi=x4OZ3MMy-_Xv_9_PKQ@mail.gmail.com>
Message-ID: <CAMuHMdX-+32mM9pyh+RsH0oUrJrzvLi=x4OZ3MMy-_Xv_9_PKQ@mail.gmail.com>
Subject: Re: [PATCH -next] dma: Add dev_id parameter description in request_dma_bycap
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 11:03=E2=80=AFAM Yang Li <yang.lee@linux.alibaba.co=
m> wrote:
> This patch adds the missing description for the dev_id parameter in the
> kernel documentation for the request_dma_bycap function.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Fixes: db9b99d461ddbbaa ("sh: dma-api channel capability extensions.")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

