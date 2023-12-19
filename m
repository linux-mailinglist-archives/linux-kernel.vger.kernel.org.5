Return-Path: <linux-kernel+bounces-5991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9D7819292
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708AA1C24926
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F303B791;
	Tue, 19 Dec 2023 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esjuyzrO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0B3D0A2;
	Tue, 19 Dec 2023 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-77f524597c3so344232685a.3;
        Tue, 19 Dec 2023 13:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703022838; x=1703627638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uorEIJa1wV7XcN84uUF/pYn1OAptdc3n7/u41DV37lo=;
        b=esjuyzrO1H79P9gr7EyLlC2wD3UVUL7dTM606m/WeU0GlfEAgbBGv5yrS9mcTcLzV2
         gKKE5eYIX5KPPW6+isrHzvdcGsDjFapEtR8sl63xYemL6I+Se22DZxCJO55Nne/lK8ng
         bn54ue1yhDMAB2ogAmioEBEHb7K3l1dPGIsH0W478l01Mtd748+MhJh+zEBGfKcrCUKm
         QXz6k1xZETGfOxtR2aWGm1FAVtysTIIykhPwplYbeC1nUqOmdPYkAgBjx9msav7NLcau
         L59jhjJB+m/wIdV/SIsY+vtcpfajYlzpR5nxqT+6GUAPl/dwtzqNKe0oCOtlHwYf/Iak
         QNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703022838; x=1703627638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uorEIJa1wV7XcN84uUF/pYn1OAptdc3n7/u41DV37lo=;
        b=Fk4TWyHmCXMoMPG6hKNIBDnYlR8ul5IenYYs3wFwA9hZXeViNuCIYtTOSyiGb0QwUf
         gEeieKlTPJhUSqPg/p8avFwAR/tI/GAsheO+GOO5nN+8Tu0dhH7hda2nra3xwo+RpKO/
         Ar5+Yce9ECXroiiWa9V23s9cofzv31XGivIWoDLeMoqVk6urR36ZMT6q5oI1bRSoqklE
         eshV8EYzN2+OEqsHz6cL2iKciie7UHYaLPCZU4GYtLOnFXxfhYi+rXXgm5hHCpoFwAbO
         GQaUHuDwfFrfOD2WqdC1040ICrKu5GqF06Xhdp6Jeg/vthOpObQVNisTVntBJrBgp9BW
         i8yA==
X-Gm-Message-State: AOJu0YySUoa7IwFiMUs7VVz9zBHsiXdrgBr+Tm5e5rp3P35GEPVtWQ4g
	K7spC++YCnNwPaSyiNf5lhWhxwE+kNKFjOLOkEc=
X-Google-Smtp-Source: AGHT+IGVPnDmY+8hb2F5TdHpkLPk45ReDmKcW3M5DxmIqEZDxtJbur3DLguyhg1Ml6F5fd55X0PrxkRtZRmV13wCLiY=
X-Received: by 2002:a05:6214:1416:b0:67a:a496:4a39 with SMTP id
 pr22-20020a056214141600b0067aa4964a39mr18464073qvb.18.1703022838662; Tue, 19
 Dec 2023 13:53:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219-libstringheader-v5-0-206d4afd309a@google.com> <20231219-libstringheader-v5-2-206d4afd309a@google.com>
In-Reply-To: <20231219-libstringheader-v5-2-206d4afd309a@google.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 19 Dec 2023 23:53:22 +0200
Message-ID: <CAHp75VeLAip50O9YYcgX7nceYc4JpWjYX0aAve0sT7KkMNR0CA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] lib/string: shrink lib/string.i via IWYU
To: Tanzir Hasan <tanzirh@google.com>
Cc: Kees Cook <keescook@chromium.org>, Nick Desaulniers <nnn@google.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Greg KH <gregkh@linuxfoundation.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 8:48=E2=80=AFPM Tanzir Hasan <tanzirh@google.com> w=
rote:
>
> This diff uses an open source tool include-what-you-use (IWYU) to modify
> the include list, changing indirect includes to direct includes. IWYU is
> implemented using the IWYUScripts github repository which is a tool that
> is currently undergoing development. These changes seek to improve build
> times.
>
> This change to lib/string.c resulted in a preprocessed size of
> lib/string.i from 26371 lines to 5321 lines (-80%) for the x86
> defconfig.

This LGTM now,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko

