Return-Path: <linux-kernel+bounces-18909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB2D826503
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CACC281C67
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF47E13AD7;
	Sun,  7 Jan 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQPaN9Yy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFABD13AD5;
	Sun,  7 Jan 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59600dbfb58so752903eaf.1;
        Sun, 07 Jan 2024 08:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704644117; x=1705248917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV/VVD6dHaK1bYL8cRjTlIL7Oac7pxlu4WShQnN00ec=;
        b=CQPaN9Yy1o001K5TZwT+nW4lMBNpoFRz9XhslR10t95mH4NfXR2wsaJgBnlhSKKk5k
         S91luE/THxiVxu10w2e9m89FZ0eGz49Zs1vqQCF8gcCHweb7W3qLhulk8+Lbah+/S+4J
         G/CGS+P19QKFG6XV3ApA7mycqcTGjQ7IuJag9AVigJH3GjMgb1PVQdwhmjm/BUGV4t7e
         1iELAqtrNqKzOyp51O8/oXyFgmMex2LGnQycn3EbE6U7y/lVvsn/B3UjNPpODGwctsF/
         vfBslmkgFpRv0hknqbR+dawca8GeGCz0Of3KZtqjqhsd/0NaXaCBFlrc2nh1D2R9JVVU
         whXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704644117; x=1705248917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QV/VVD6dHaK1bYL8cRjTlIL7Oac7pxlu4WShQnN00ec=;
        b=eJgsgbSMMKKibpAFDFfoENZ7yTPOkqWVCZhT/DoHwgRg7BjPZYE/koDMSvYlpUdU1x
         uZMhtgegf0//r1di7qMxS3m14O+YYnLRwjnWVhU40t/L/LyNWS20hcCIK++Q690Mk5RD
         nj7QNxmbVngi4JSKkjoUmeOljaK7H8SCTW0ceZnVjz7G4BazIEDoHNRSA2kUZPvg8aQO
         s2n54e4Jczj87HXLN0wjKQxz4SbFwmOXsitodUe+hybKgbxMbdS84V9Bs17acrneCcU7
         JVGPGGjtZ2w7XQ7kuuHkX7ZySQ1vGSipQ+ISWMhwAbZsZsBwKb6BoZycBNrw+wMPqFSj
         Mi4g==
X-Gm-Message-State: AOJu0YxOkJBRMg5gb4InUDJlAVKF0ZZNh5NHxaftAj8gm76dCg9NTVWA
	hEudkSLFLjAP3Bbgo+xgJW/Ejy18bjIR86ArBaI=
X-Google-Smtp-Source: AGHT+IFOmDH9tTVrTLa2cl70prFNFxbUR/Mjctv6yhBsdm4JdnFZ/tr+sFnEyl5K+F9mL0g0JaMPutEVdcZhgPfQsP8=
X-Received: by 2002:a05:6358:784:b0:172:b74e:582 with SMTP id
 n4-20020a056358078400b00172b74e0582mr2906325rwj.29.1704644116638; Sun, 07 Jan
 2024 08:15:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106223951.387067-1-aford173@gmail.com> <90cc67e7-0c46-4313-8ad5-298b3cedbbd5@linaro.org>
In-Reply-To: <90cc67e7-0c46-4313-8ad5-298b3cedbbd5@linaro.org>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 7 Jan 2024 10:15:05 -0600
Message-ID: <CAHCN7xJtyoxc+zLEwyNTwgStk3t8s-mZ0Gh66sQ2_MizUtGjoA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: soc: imx: add fdcc clock to i.MX8MP hdmi
 blk ctrl
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Lucas Stach <l.stach@pengutronix.de>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 7, 2024 at 4:53=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/01/2024 23:39, Adam Ford wrote:
> > Per guidance from the NXP downstream kernel, if the clock is
> > disabled before HDMI/LCDIF probe, LCDIF will not get pixel
> > clock from HDMI PHY and throw an error.  Fix this by adding
> > the fdcc clock to the hdmi_blk_ctrl.
> >
>
> Adding a required clock is ABI break and commit msg is not clear whether
> this was actually necessary or how did it worked so far...

As of right now, this power domain isn't enabled in the device tree.
This power domain is necessary for the HDMI driver which is split
across several drivers which Lucas attempted to push but got some
feedback.  One of those items in question is the enabling of FDCC
during the HDMI Tx probe.  The NXP documentation is vague on what this
clock is and who uses it.  When I did my investigation into how NXP
used it, it turned out they didn't use it in the HDMI TX driver,
because they moved it to the power domain and referenced it from both
the LCDIF and the HDMI TX.  NXP's downstream commit didn't get into a
lot of detail on how to reproduce the error, but it sounded like some
sort of order of operations issue between the LCDIF and HDMI TX.
Moving this to the power domain appeared to solve the issue for them,
and it seemed like it would have also resolved the concern about its
use in the HDMI TX driver that was submitted on the mailing list.  In
the subsequent patch, I listed the error that NXP described, but I can
re-do this commit message to make it more clear if you let me know
what you're wanting to see.

adam
>
> Best regards,
> Krzysztof
>

