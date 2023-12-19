Return-Path: <linux-kernel+bounces-4891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BC8818360
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94927B239BA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0A911710;
	Tue, 19 Dec 2023 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErA7m7+q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023B212B69;
	Tue, 19 Dec 2023 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a2339262835so297926166b.3;
        Tue, 19 Dec 2023 00:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702974672; x=1703579472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5VFZBXoek/PmoENd13wHvQBkwNetTGq8HZiKbqScho=;
        b=ErA7m7+qTMUR7pbg4F2Wtnx7qY3nyiu4ZkVc3WWVTTdd2YD1yWdRO6Tq2oCyKiUnTe
         sH5CoBTUQ9sO2+/QWPekzPTsMxUt1MazxGqSuqpDt9jFVH6IyOwA5YCxaQ88gQssmKiN
         5ntbzAO336FAVO+adDxOhh0Lez8cA2UkzonsaYrkiabIyKFRTSjrM/QnNZrJoPHW92Xw
         rXn1mmqaHJR3Uo3W4UR9cY+pfQ6WS6HsbJyF/2BIEzPYuxTLdd40UeiICevI1uR2LpZb
         aGcsGc6OY1UA4BKce/xOfTJQozZBQ0OhuuNpzEWVYDiUuMtKvak2bgu/JygRaEHDUpWD
         tvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702974672; x=1703579472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5VFZBXoek/PmoENd13wHvQBkwNetTGq8HZiKbqScho=;
        b=BeSougi1KngTlZL3inT97kzYqS97jTedu5P+K6YZo2GSMpnubE0h09RqRS0SBr7ze2
         D+siDBM9h9tD2k+Z2JeLUR8drCJwNex8S+rSNqSU1MSHrUUsvZ0Lmm6EX6oXymKzIwtG
         9m5SwwZptxszBaSAWgdIgZKqs4bTnqtxZ96CndFFJWWaoKpsc93OFCinFK+BcHjm+ZYN
         kP5GdPW2rsLkIUcohAqlUIHCyGty+7/r+6whGGO7dCjfUr+/h7E0hBU3vRbpbJkbamJt
         ZCnOE0y3ZrtZ1AlNiJOd1ZVHZ924hMHVv+zAGLH4kZlZlzjtVIhyL3GuVtxcbJ3/LTE2
         qYcA==
X-Gm-Message-State: AOJu0YydFM7ixNdt3lDzChSUIwfirWZuwDFXqqSrjpH403aA9/0u7JJw
	iAShBxF2ITmrZTPS6Rh41alw3CwacwiOKLZmPEJwpezqlhJaRQ==
X-Google-Smtp-Source: AGHT+IER0EeD0F3ccRgxlejZrbYe3okE2GAyGDFMLJmQCmcEpMASztGNOjgzLjUdLJ3YpMtcTgLDZ6UTQoCoNj/9/Fg=
X-Received: by 2002:a17:906:d6:b0:a23:ff8:cda6 with SMTP id
 22-20020a17090600d600b00a230ff8cda6mr4758403eji.75.1702974672002; Tue, 19 Dec
 2023 00:31:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1702953057-4499-1-git-send-email-shengjiu.wang@nxp.com>
In-Reply-To: <1702953057-4499-1-git-send-email-shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 19 Dec 2023 10:31:00 +0200
Message-ID: <CAEnQRZDHrihcP5TGLWKTYW=C27XSrBis7pLd2nMrQ2byJQhAJg@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: fsl_sai: Fix channel swap issue on i.MX8MP
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
	nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org, 
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 5:12=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.co=
m> wrote:
>
> When flag mclk_with_tere and mclk_direction_output enabled,
> The SAI transmitter or receiver will be enabled in very early
> stage, that if FSL_SAI_xMR is set by previous case,
> for example previous case is one channel, current case is
> two channels, then current case started with wrong xMR in
> the beginning, then channel swap happen.
>
> The patch is to clear xMR in hw_free() to avoid such
> channel swap issue.
>
> Fixes: 3e4a82612998 ("ASoC: fsl_sai: MCLK bind with TX/RX enable bit")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

