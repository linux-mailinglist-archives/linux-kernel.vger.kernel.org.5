Return-Path: <linux-kernel+bounces-7375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2664D81A6C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DDCB219B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628F0482E6;
	Wed, 20 Dec 2023 18:22:17 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D17482C2;
	Wed, 20 Dec 2023 18:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-20371a67c5dso552691fac.1;
        Wed, 20 Dec 2023 10:22:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703096534; x=1703701334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cz9nCY0lBWeBe/6fDVIe0LtBpt68ywz5BRZ2PUIWCi8=;
        b=HrTdt82cHS7cYSi/zPjpOvjStNUWanrP/ZZOVawxuIkhGf6yGehpjRnMHCYbwdUKDR
         /EBe1D8VmWPILwhoh4qnCASTa3SNrGEn8KWdvlCDMM/4kCF26Oi7xyO/AsBHYrS5om7s
         aex8qiCYneYZoRloUnQIgx7ad+Hzr0x8HMaeEAV9tQKfV+qFStYP87yuY3bDealt4j+y
         HM8bHDMnmN0tsuxZOVhVJWbEjcwSGEwzIWhJVTTQiM6tG3O5rY5g9JiVxd9BmDnPywfY
         bhOG4IMpnkSQuvmDddNEXl6JGrcK0+Y0usQUlOVklxRL9OvqEpXDGDOHYo0nmRTVlZFf
         x3iQ==
X-Gm-Message-State: AOJu0YxPYKWMnBDPLzaO1DayGIgvoqq6xeEBGViBrlkNJuYitFl0sQyd
	Tvk2gpd+1zwD/ovZDAqPYSSW3ylBZ74SawQkuuw=
X-Google-Smtp-Source: AGHT+IHkca90Glu/LOaj3hWXtR7Zk4zt02swIhEGuNWLa5ElftGhTBvHWBT6Du0VtP3HoIBW7N4gWPacnguEFCeN61Q=
X-Received: by 2002:a05:6870:9591:b0:203:e5bc:154a with SMTP id
 k17-20020a056870959100b00203e5bc154amr6974236oao.2.1703096533719; Wed, 20 Dec
 2023 10:22:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231220060246.511-1-rdunlap@infradead.org>
In-Reply-To: <20231220060246.511-1-rdunlap@infradead.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Dec 2023 19:22:02 +0100
Message-ID: <CAJZ5v0ibfwYt3z6OW-gHLEyJnAxXWKXpqnXngfMSAFV-mSsxDA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: repair Excess function parameter warning
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 7:02=E2=80=AFAM Randy Dunlap <rdunlap@infradead.org=
> wrote:
>
> Function swsusp_close() does not have any parameters, so remove the
> description of parameter @exclusive to prevent this warning.
>
> swap.c:1573: warning: Excess function parameter 'exclusive' description i=
n 'swsusp_close'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  kernel/power/swap.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff -- a/kernel/power/swap.c b/kernel/power/swap.c
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -1566,7 +1566,6 @@ put:
>
>  /**
>   * swsusp_close - close resume device.
> - * @exclusive: Close the resume device which is exclusively opened.
>   */
>
>  void swsusp_close(void)

Applied (under a slightly edited subject) as 6.8 material, thanks!

