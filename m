Return-Path: <linux-kernel+bounces-77793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E2F860A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5223CB2109A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54714125A4;
	Fri, 23 Feb 2024 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tr/za4bY"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CDF11CB3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708666672; cv=none; b=YvR6ei3Yhtvtq61bOBZvR3j6VKcbO7aVd3s9HM5qGFUh9d9PWNu63NMD4d9+bhQ1aK/aEb/sFNAXlG6NbkIUdAe5OtP4dkPBops8kHUhCAI1hG4TTap48Vm7mRSVeVLqgBossUm0OElyLiZU4LpLD3u+kIea2vYeoliUCkeH0Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708666672; c=relaxed/simple;
	bh=xsKSwLBBIARsj04+9pfUA2veziCGU0ghHiZxG7VQXh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9UABZOtxGf+EDUUqk20qX490ugGue/dr1vsj3AumphtQb9zX/reE/Yn9uQNjMXCPODWH3pyTbaAkJlOIv+dlTG0N/cw/7X8nBTAuXw8o95YdqGTbQC3AbNWH8a5an5fPk8oZv0dijwFlaOMeH0sTgk+CnELW0aRNFYms2kA7ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tr/za4bY; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-607bfa4c913so5300227b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708666670; x=1709271470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=piy9E/Wi6hWu5zacOupA8Uhn9Hcy3zaRnPaPm0Ffstg=;
        b=tr/za4bYqPdXEzQgSb8MAEKZMUNJM+rRDCGzFwDvy8zq6tQsLmJOMqH/BMzI4QLfXC
         CoS0g9of08hJAY10QSDHeWBnze/HG9BiosShLEtkVuHwA35dLqRfEcOE9ClvXTeLwzhU
         a+IeDIhQuk40l68F58hKRz1la+lnRxNifERZEkAbyqLlm0eMFEEHcddBCc17u9eU45IQ
         +kJPXh6HgtDpQr/HahWX57V+jToUhsBZI0XIu28i2eopH/FBH0dJ6aTFV0PY2gfW880F
         +l3EKfq62SXlzTyE8yoqVmKO6mNZFASeQRksL5vn4jTNZLjY+YPIIqyK3JoXz/qM3WuK
         GCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708666670; x=1709271470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=piy9E/Wi6hWu5zacOupA8Uhn9Hcy3zaRnPaPm0Ffstg=;
        b=g8I23G8aGM8tDrxSIHe5Uu3zFvTgu95/AP+GzmdAWS2l691UTpdxOYd4SWo2eftWRJ
         8/Q1VmAWbPNjPJjYWGuPjNLefGr6ZbVR8puJTVM+rTZGB/bseyWrpgqSRmuOKcGA+M6D
         xkxA1/vJJbLcEziCpKKvm2egaH8QxjZVLshVLq9K72f3zcOqJjICD3ahm2oU2tTP2fua
         68IKz1FQxmkoRDOWJR+8bl+luM28MAaQBhgsaVRjL7/FPoM7ruueYAx+eZMGNDd8xfiA
         JOlejUBezU+F6nNi6e0C0G5PL3NUjk6wNezwLbyuEhV0TyXUg5gWRGPHAyePE5/9sl2h
         NdAA==
X-Forwarded-Encrypted: i=1; AJvYcCUZfNeGy7bKpqFE+9Y6foeO+oxvreVvbLWawI9Ngb932VfFfir3aFMqrB4R7lwom0r/itfgkk4fwAkwnFNJFCy1BKrs87ERbjBGl3DA
X-Gm-Message-State: AOJu0YyyaqYDsxfsQzLpU/VxQoO5ANYocaqVRvZgALNzcrZLhxlqDzEW
	WyBVtiKhfFP+q+Ytnb2oVFPPma3gEbGUntaa48HHteTVACWA0l6pQt2OH6HMvRrDaUDLWHcstho
	SHAQXpRwoALIklqPTXCRI3IlMRDmBwuayaHtmzQ==
X-Google-Smtp-Source: AGHT+IHowG1djzWv8SQ+TQj50M+pnuS5txwPBX/b0kYHXIda9do+3n7ow8oYi6E8ViwH5610dsWdNg1YzjYmgmrbRSg=
X-Received: by 2002:a25:4e56:0:b0:dc7:4bab:c390 with SMTP id
 c83-20020a254e56000000b00dc74babc390mr1041815ybb.61.1708666670011; Thu, 22
 Feb 2024 21:37:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223010328.2826774-1-jthies@google.com> <20240223010328.2826774-2-jthies@google.com>
In-Reply-To: <20240223010328.2826774-2-jthies@google.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 23 Feb 2024 07:37:38 +0200
Message-ID: <CAA8EJpo_n6Fts0AAKW-C3HGArnuxxO8xF6he7b7j9y0e9CTYpg@mail.gmail.com>
Subject: Re: [PATCH 1/4] usb: typec: ucsi: Clean up UCSI_CABLE_PROP macros
To: Jameson Thies <jthies@google.com>
Cc: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	pmalani@chromium.org, bleung@google.com, abhishekpandit@chromium.org, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 03:04, Jameson Thies <jthies@google.com> wrote:
>
> Clean up UCSI_CABLE_PROP macros by fixing a bitmask shifting error for
> plug type and updating the modal support macro for consistent naming.
>
> Fixes: 3cf657f07918 ("usb: typec: ucsi: Remove all bit-fields")
> Signed-off-by: Jameson Thies <jthies@google.com>
> ---
> Tested by building v6.6 kernel.
>
>  drivers/usb/typec/ucsi/ucsi.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

