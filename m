Return-Path: <linux-kernel+bounces-93062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83762872A54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FA61C24B12
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186BE12B17E;
	Tue,  5 Mar 2024 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uz30EHnX"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18551DFC6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709678547; cv=none; b=TxBPvod0JTfWnfw/i67eSDXp9C+3pJUuqW74pBM+EbCZ/vKRbBefD+Ie41ziJoAvIS75yXR8OffmxaHKbnVgQ6K68qDYaTPmgx4P95oIUUsVYBUFyyl/klQ7XdfY54+ILG4XT7A6P1VqmcRG5UfHa10heP63Frziay0JxQ+BJKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709678547; c=relaxed/simple;
	bh=Kla2R5bcfkPkylWdIGVABjeBtsnshT/GLsxGridt7Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaQRJVqTCtXz8sKKTbyeOmaiMSQ5capVoWWVdp70X6AevAOU9enSWycr8kXJ6JL67LFr+F7IPhkxcVa656IUiXTZtJ00rNNTc/yO+4LMO/Uu/+H4bltNd5kp5dcx3SMq5T6+jkUJIjgGcKmXzEQZUfOKkMvptJwMnxazBrJYNpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uz30EHnX; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so5676244276.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 14:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709678545; x=1710283345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kla2R5bcfkPkylWdIGVABjeBtsnshT/GLsxGridt7Qg=;
        b=Uz30EHnXgL4NUZASHqK/PqkK5NhT//dXPGTvlHs7BxPo7ZOaCovK3EzbxEDFbuZJjm
         S5ty8ErsqAnztmN482V87In5Erc6Hw+UalRdKuoI9Kg92qUzSsnCgPIU28qsBiPl2++a
         SG1Dtcjzk6ZGRdPauq1AziXSfAUHaIX9/Q3508lPGUEp66+RS0uzLYkUzqmDMQV8QN7Q
         BjK95qtF1S6phqRoqx6qbmldzN8/MVxnCbmm838W+xPKh/gwkIKWRY3/l/HprpGQ1SFa
         PbAkqzarbWLbSG9JPkjiGe+ovVPCYP8fPYaE4vDYqbqE4sRJ8DyEt4WEIT07NOmrUz0C
         nW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709678545; x=1710283345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kla2R5bcfkPkylWdIGVABjeBtsnshT/GLsxGridt7Qg=;
        b=V3IuEsnTgQ4F/XFm7/s+MNWEKBZ5EXlpMn8xjtBC2j7t+WG8fz58LztnixVqsHehpw
         NCTZt+wN//9VLZFNypKEa+BbaTORhr9/h9q9WpWDPxHLX1e2nwPiaXF0yEBNysUm4EVt
         kmBegp+NzTHNoB3Z9ZRAIoH11R/P40a/mehCreAEM+E+tTQDfhCX9sjDlMQqtCoS/ERs
         HWwAGvzT1+t+K+Wg7+wDci+WVV3II0gV1X2MWuCPV8C1nNBZHJ7u94t7wPi8no7GLQqr
         3pkmSH2DrK2krWkTfWrwZYJXJvVWQB46FI+SxWA3RhfK6autMTHBvNtd6G9k90e/eZjm
         EjzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMO9kfiUCdvgM55DIT7qli62WW49fB0ITvt/oW3T6IghiIbEz+9MipzWDm/Glh01R7emO3x0rpRIINs05NXktGYxTpxjqqeLLCKk4V
X-Gm-Message-State: AOJu0Yz0KKcwmTuqdiD/MxzrC2k20Fv1SjmNiCq729W1I2KtgAHAM0Z5
	o/FiWZHg6dgVpoSeL9ozoIRWAFU2gEj6xJOr8PXHQFADNBUw4ECEuf8rPJeJ59vjKqW3IyQFx/1
	oSYtSjiybJAdl8NZrQZQHnOkH/33SDerSP0AX3Q==
X-Google-Smtp-Source: AGHT+IH4N2Owa4TsElQeWkLDp0eXqWO7MZkEd6Rq0/nmWb7dSWHk/5oMtnM56ZClu8pvW+FdTVEgJ+wxMYTmVHVRzAc=
X-Received: by 2002:a25:9845:0:b0:dcd:df0:e672 with SMTP id
 k5-20020a259845000000b00dcd0df0e672mr9528207ybo.47.1709678544834; Tue, 05 Mar
 2024 14:42:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301221641.159542-1-paweldembicki@gmail.com> <20240301221641.159542-7-paweldembicki@gmail.com>
In-Reply-To: <20240301221641.159542-7-paweldembicki@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Mar 2024 23:42:14 +0100
Message-ID: <CACRpkda18OgXdbVvUVvq-un4cpi-EEfxyfjqoQas+=BScSB6OQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 06/16] net: dsa: vsc73xx: add
 port_stp_state_set function
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Claudiu Manoil <claudiu.manoil@nxp.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 11:17=E2=80=AFPM Pawel Dembicki <paweldembicki@gmail=
com> wrote:

> This isn't a fully functional implementation of 802.1D, but
> port_stp_state_set is required for a future tag8021q operations.
>
> This implementation handles properly all states, but vsc73xx doesn't
> forward STP packets.
>
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

This looks like the best effort to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

