Return-Path: <linux-kernel+bounces-5017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1690281855D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19ECE1C229E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6EA14ABA;
	Tue, 19 Dec 2023 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dO+ZRXru"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E212B7D;
	Tue, 19 Dec 2023 10:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a235eb41251so258129166b.3;
        Tue, 19 Dec 2023 02:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702982238; x=1703587038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvYdBgUbLN8ILqoDHw/+fzF2NrJ3PvPzv3OUIPhHu3M=;
        b=dO+ZRXruzTNEw+q+0O3pIk1OFHXwipfsmDl52WdERvpL0ZhQFHe6swB/pduQdf0GEY
         RKqp6+f6qmp+25T8f6EAmrOenlAVEX7mppEplxDCIsd8wDwWmDLjIJv9GsqgvAe7+XQr
         GpCGQzvicZ6XrmMK4koaTYLiVCIot/kYIyEjI26PtkV7O0wiPvGvklZmi8uHKIQdXsVm
         ibpaBqIyaf52GCKQhnrtrUe5uBEyt7VBZVMSFG5jhkXetzphqEgK1O5/bOgJ7bvIZ2zb
         FcsSFsnRqbKcKx2gTW1e5B15yOhnzG/6lKcAHwm8U6vzG1s9nN+n7xy3GHFqopKZFoga
         3VSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702982238; x=1703587038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bvYdBgUbLN8ILqoDHw/+fzF2NrJ3PvPzv3OUIPhHu3M=;
        b=wM9B05uFDTk7yq+X8GPY4uQunAipEyAozTZ0llJqiQG9MbQWeilokMaY7Sff3nr3dm
         EKaT0OrtfC17syjer+QKnPHAG5YJaqR9mI3HSKnTb3T9OLglqR11RJ9PXCfBq6beXomB
         zj1gFSBy4G4V3J9KGDHYqUj6TyclRw1MwXhvR1UHmjZaaUE8dZ3sjAHcJMWaGbpNTcQn
         /RqR+LYZeuQH5kpO2fQumKgieXXigYgovDtJ6fsamrW3xgQb+K6fOdpfuOEtJs94GlNo
         B1oJZPOGl9gBj7smqHUb/YjhdUel9UtfRGj+o1xth19u5dfhFkYRr7hhvmmi7reI0/02
         Bj/w==
X-Gm-Message-State: AOJu0Yz5mT6S8SxZ9ypIZWwpAqOVwA1TraDptjLPbCBvQ2/Bt4LwUUF1
	9X0uMxhT6zzn/klWj631iaZn95zpDowyrhiB+h8=
X-Google-Smtp-Source: AGHT+IF26m4+JfVhhro6alt66IQ1rZt/WmYV/jjFl9I3HsbEWYPFaqiy7vbLItMDbqPoyR5ul9XjoeiDSp5rvQwvqkU=
X-Received: by 2002:a17:906:6801:b0:a23:401e:2d5b with SMTP id
 k1-20020a170906680100b00a23401e2d5bmr1330241ejr.177.1702982238024; Tue, 19
 Dec 2023 02:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218121105.23882-1-lukas.bulwahn@gmail.com>
 <170295913267.640718.8284035097366475252.kvalo@kernel.org> <18c814f4890.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <18c814f4890.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date: Tue, 19 Dec 2023 11:37:06 +0100
Message-ID: <CAKXUXMyMz9w=Ki3ZpsODkr9j-ei_CJRe03d7NYnhLEhuO7JD-w@mail.gmail.com>
Subject: Re: MAINTAINERS: wifi: brcm80211: remove non-existing SHA-cyfmac-dev-list@infineon.com
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, Arend van Spriel <aspriel@gmail.com>, 
	Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, 
	linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 10:01=E2=80=AFAM Arend Van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On December 19, 2023 5:12:19 AM Kalle Valo <kvalo@kernel.org> wrote:
>
> > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> >> When sending an email to SHA-cyfmac-dev-list@infineon.com, the server
> >> responds '550 #5.1.0 Address rejected.'
> >>
> >> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> >
> > Patch applied to wireless.git, thanks.
> >
> > 044879ce5406 MAINTAINERS: wifi: brcm80211: remove non-existing
> > SHA-cyfmac-dev-list@infineon.com
>
> Is the claim here true? In another thread I replied all including this li=
st
> and I am not getting a bounce message.
>
> Googling error code 550 seems to indicate a sender issue:
>
> """"
> This means the recipient's server doesn't trust the domain name you are
> using. If this happens, then your email IP is blacklisted, and your
> messages will bounce.
> """
>

Well, I am using a standard gmail email account and the email is
connect from some server from google. It is unfortunate if emails from
such email accounts would be excluded to reach the people behind this
infineon.com email.

In the end, if the actual content the receivers get at this
infineon.com email is so partial, they might just use and follow all
discussion they are interested in with the tools (lei and friends)
relying on lore.kernel.org.

Lukas

