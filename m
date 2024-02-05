Return-Path: <linux-kernel+bounces-52081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE798493ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A330A282E08
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00646C8DD;
	Mon,  5 Feb 2024 06:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqvqrhiY"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65DDBE6F;
	Mon,  5 Feb 2024 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707115162; cv=none; b=qLaf1U0HKp35QCSuZRMejRO5nzaaYmYHJUIzWc/NcGyK8lDKgu3yfuHByqFrDj6BQpg+U8m/87uCSH87yRb3StKUeKX0It3YSa9f6cI0x8mGdJlOV2/hE+Xdu0pmbJxJ1IWID/45K2lztrrsMrNsaUAOTAhD1TfUsjBkEEHH3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707115162; c=relaxed/simple;
	bh=qcVWKH/3nEI/rvDatUuvcvvZ2wEo+Ck8BQmU0bFEq/I=;
	h=Date:Message-Id:From:To:Cc:Subject:In-Reply-To; b=oSJUsFg1177H4h/TcsHIc7jUMCDZJrGsqy5MqavaDlIxbVmisTmyEPwvNeB032NM4MbKfd8wTNlLMNDkQexpS40/VZMj5r4XNbsfjgz8w3T/qT8X8gdZwtdnlcYuOiXvPhtuzm6RsxkOS7vvD1TO4PkqMcIB1Qx1ojz29RDlDqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqvqrhiY; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bfd3db19baso579240b6e.0;
        Sun, 04 Feb 2024 22:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707115160; x=1707719960; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=80B/WhGvs9pxwgltxy45DuyYHfhArxRc1gr5mE7Omfs=;
        b=FqvqrhiYEBn0Ui9SSXIFZ/a/lvy4/0xA3Ob7lDw/8GAr86nl74mrrDc0jLU4kScwuW
         i6mEKeOIEFP8F32MvD/O6YwgCP7EXhiNQRE+HTPyjnlegFOSUdCmJLkcQLwzETfuQ+PS
         4aRsHg9pu55hqeNFPpEjF3AtSkUpbaqAXt7co2jUlLA8F1OQBRcikMjI8gGhmJBfVPJN
         /g29XFWCcO/WxWVJIvq/wvnyoD5jq2WsekfpOHc2bif4FAKc75LwXAsjwA9tlnGmVvqO
         qK6X0Fa/JdxYkL7hmsixhetf71U6mJz9wCXp+myntcn+ycqwUnO8VawwWhmqADiUYmz6
         g5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707115160; x=1707719960;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=80B/WhGvs9pxwgltxy45DuyYHfhArxRc1gr5mE7Omfs=;
        b=NSQ4N41mx+eI2JU9KvnYV+bXJtBNo7uN8/e4GAi27seYh0bvShh104fPn/goaddD+S
         jAWTK/FMO8Ah+eaZGIPPsWMLFSvs7Fm2TlwbJeLIL1xGDKQ5WkNwBGj2v/j11L/E7NW7
         aDOq4ZJc+GVilo8XrafOnrXqYTtaOcvNnw7huFsJ8ABwlJe/hVUCxZnLVbK3BSKJsoyT
         Aw4H5JCMUYJ6qOLbn2j3T0QNl5yf9rA/D487DZNPKnWDycegH1SpcTAzqQ0CuwPlFLTS
         dbo+XxRC6rTWbidYU6sTTaT7S0WibryPmfT2N+tsF9RTNLopQSLEn6hvtBjZ9E9r8OLE
         4NGQ==
X-Gm-Message-State: AOJu0YxkC0frUOQCDRzrft4Uxe4PJu0SR8AhZyuWVcmtw0vGzhK8mvLy
	HSqVttq8YmvJGhBZrFGrd+Ehq6K+9JZ7sRu50dSZYsj0VH0SELBh
X-Google-Smtp-Source: AGHT+IHN1X0Jw72TKls0GZditcDCS/YmNqJ23Qpuxd9U4fjssO1jlmoXlKipCftvKsP8I/4ymVibWw==
X-Received: by 2002:a05:6808:19a:b0:3be:9c36:53c with SMTP id w26-20020a056808019a00b003be9c36053cmr10378659oic.49.1707115159718;
        Sun, 04 Feb 2024 22:39:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV37yf3qQUX/OafFFMHXgkwfylrPqCQGGFvs8TdFNnrp2Ef7EKSWB6UxapyyaUkIhSSzvrrVVYGltM46PQslcD0HcCGbQqVa1pn4IDv46UbefJmOHPt8eYS5tnGnoXOjTR2l+6Ri/Pc1pJlqiewsktPxYVzRZLP8ETRkjneYEqbOFAZyvHLsKBH4HnfqXBxDhq/NcFdYTFvaBVI3Os8u7FrThF49toIEo0dxi8qIPvTclKNuPO/ZfOVBug=
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id k7-20020aa788c7000000b006e03d955c6dsm1843778pff.60.2024.02.04.22.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 22:39:19 -0800 (PST)
Date: Mon, 05 Feb 2024 12:09:08 +0530
Message-Id: <87il33mn3n.fsf@doe.com>
From: Ritesh Harjani <ritesh.list@gmail.com>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>, adrian.hunter@intel.com, quic_asutoshd@quicinc.com, quic_bjorande@quicinc.com
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Jeffrey Hugo <quic_jhugo@quicinc.com>
Subject: Re: [PATCH] MAINTAINERS: Update bouncing @codeaurora addresses
In-Reply-To: <20240202163038.4080702-1-quic_jhugo@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Jeffrey Hugo <quic_jhugo@quicinc.com> writes:

> The @codeaurora email domain's servers have been decommissioned for a
> long while now, and any emails addressed there will bounce.
>
> Asutosh has an entry in .mailmap pointing to a new address, but
> MAINTAINERS still lists an old @codeaurora address.  Update MAINTAINERS
> to match .mailmap for anyone reading the file directly.
>
> Ritesh appears to have changed jobs, but looks to be still active in the
> community.  Update Ritesh's address to the one used in recient community
> postings.
>

Thanks Jeffrey for the cc. Since I am not really active in linux-mmc
anymore, I would like to propose to have a Reviewer entry (R:) for
myself which I can try to help with.

Is that ok?

Thanks again for taking this up.

> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1e5dfd169a19..ac7e524cd8f8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7803,8 +7803,8 @@ F:	drivers/media/usb/em28xx/
>  
>  EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER
>  M:	Adrian Hunter <adrian.hunter@intel.com>
> -M:	Ritesh Harjani <riteshh@codeaurora.org>
> -M:	Asutosh Das <asutoshd@codeaurora.org>
> +M:	Ritesh Harjani <ritesh.list@gmail.com>
> +M:	Asutosh Das <quic_asutoshd@quicinc.com>
>  L:	linux-mmc@vger.kernel.org
>  S:	Supported
>  F:	drivers/mmc/host/cqhci*
> -- 
> 2.34.1

