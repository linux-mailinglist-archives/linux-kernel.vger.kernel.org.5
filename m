Return-Path: <linux-kernel+bounces-24604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1082BF03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB4381C20F91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FAA464CFE;
	Fri, 12 Jan 2024 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l+AI/IvF"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096264CEB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 11:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f8cf76ef5bso56150697b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 03:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705057842; x=1705662642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQj2NKX5tt96cVcGJ+2RjHHBa37oPwGgTH9TSWitTO0=;
        b=l+AI/IvF8rXKs+dfVxIhcJ8wEB/NoIExfdJVj3XRaECwfr0HXy3lutu5wex1CSuCK2
         kxtK2NpfuCtJvcWhubvKk0JHt4xihXL6kTEUeXW3mV5sasP2jmzPEi9rPAWhyltKc1oV
         Ur11TZ8U9Z/KCRdFr7JQfW3YEjFG4eCyRIBKMoDicwmGw8GLikuoz2qjca9qwK2OedaW
         co68cS8hd2O5j0TZOd1ON52qxA/gmtl8H0dBwfMEeX7n6zLZlEGY/0qWLnzmaO7h/QJ1
         pEv2Lk9dBIa8gPmTjVzXCvePC9QRl1ivY8QxsZwygp9sRHh25Hpd2TC9zeYmxsV7j4w2
         +Yfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705057842; x=1705662642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQj2NKX5tt96cVcGJ+2RjHHBa37oPwGgTH9TSWitTO0=;
        b=gGU9T9AwgW6sJpIgYr+4hLduJn9xSzQSv3wJnbI8ln0KFBRqjUassna/Wrq+0BBg7N
         BPXt4NdqV0bUm46wkkwubeJ8YY00KLhAXDj14g1Kxsn9c+2tRV55WYJ+VOoKQJDqT38Q
         j1pzBOPbb4PVNwfOftJaJlpwh9QT1hKI5DxVD4M3vVKmeyrj1/kkdA+RNIKmK6Flfp24
         sfLOqgWDWwGXqxn9/RwdOT1X/CFom/CGF+QF2NSiy9bAnYx44fRg9EbxjPtC3z1yMEBU
         DFjNjq7qhvDxtrHfs391Iiy5BZN8Ru12qbRSW/TgQzrDkFpbQI1XJ/nu15fjUDm4r/fI
         i25Q==
X-Gm-Message-State: AOJu0YyBca6sKUyFZVIyjEH4TAfZHuoUyM3cyU2Sd04TcxzSfII8IbyW
	NI7url0XP1O43+4a4OA2Ejf5Jstkd02ZXuROyODFtv0Yvu5GBw==
X-Google-Smtp-Source: AGHT+IFwL6LWdZ7EreE38I3TD6a4AheGRUwBjLUP+7il2h3PtjezrVbJVoAcxHYRi318dnP4Kk6MCExSsRqwxPTsuPw=
X-Received: by 2002:a81:9f14:0:b0:5fb:9571:ec91 with SMTP id
 s20-20020a819f14000000b005fb9571ec91mr1192176ywn.33.1705057842027; Fri, 12
 Jan 2024 03:10:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105160103.183092-1-ulf.hansson@linaro.org> <CAEnQRZB16QDJAqkQaLZ6he8eTQLcWzAFXivYt9Gj3CJns-G-NA@mail.gmail.com>
In-Reply-To: <CAEnQRZB16QDJAqkQaLZ6he8eTQLcWzAFXivYt9Gj3CJns-G-NA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Jan 2024 12:10:06 +0100
Message-ID: <CAPDyKFr+ZV0pO5L-Gn-8gKG=ARpxeXHLN3T9PPcSFxVayEG07Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] PM: domains: Add helpers for multi PM domains to
 avoid open-coding
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Nikunj Kela <nkela@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	Stephan Gerhold <stephan@gerhold.net>, Ben Horgan <Ben.Horgan@arm.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-remoteproc@vger.kernel.org, 
	linux-media@vger.kernel.org, Iuliana Prodan <iuliana.prodan@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jan 2024 at 09:44, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>
> On Fri, Jan 5, 2024 at 6:02=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> >
> > Updates in v2:
> >         - Ccing Daniel Baluta and Iuliana Prodan the NXP remoteproc pat=
ches to
> >         requests help with testing.
> >         - Fixed NULL pointer bug in patch1, pointed out by Nikunj.
> >         - Added some tested/reviewed-by tags.
>
> Thanks for doing this Ulf. I remember that I've tried introducing the
> helpers some time ago
> but got side tracked by other tasks.
>
> https://lore.kernel.org/linux-pm/20200624103247.7115-1-daniel.baluta@oss.=
nxp.com/t/

Thanks for the pointer, yes I recall that too!

I should have added your suggested-by tag to patch1 in this series,
let me update that if/when I submit a new version!

>
> Will review the series and test the remoteproc part this week.

Thanks a lot, looking forward to your feedback!

Kind regards
Uffe

