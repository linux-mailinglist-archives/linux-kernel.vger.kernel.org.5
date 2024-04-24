Return-Path: <linux-kernel+bounces-157123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04E68B0D20
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D3E31C24300
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293D315ECF2;
	Wed, 24 Apr 2024 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="P/0meGTR"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C4F15ECDB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970155; cv=none; b=M7YTUA3XT/84eZBgGiBAj0tPF5GAYb1dxUko92T/mZZcpaeSe3Yrh2vR16L5/vskQciX20JO3XeAa9HBLZ1UAEVsfE13Flu23EfxxjjeaYssPzA0BUrU0SfTfVWxuMSCdR8KIIGLeuwZDCIlKPLVSyOkWMtIC41IbDh6Mzor9+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970155; c=relaxed/simple;
	bh=Q31Ukp6X2FCLI8aCI5pOhuftdWSmyWC1CKtNwPgPrlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arF2NYLN+Xq6GQM5meAMlhy15pdZ51XU5qrXqfqH3cGRWzoEi0rOcaqXY0nhY1pf4A1rt52FVEyboPhgtFsdBjAgwXebTRSLFizelCbbyVtuwkDHhvbugz/khsy7apXGssHCCV1zWAGS4YUF0X8I8VdjpDgvEDZiseGLgnO4XFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=P/0meGTR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c5d05128dso6451103a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713970152; x=1714574952; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q31Ukp6X2FCLI8aCI5pOhuftdWSmyWC1CKtNwPgPrlk=;
        b=P/0meGTRffoN+Xa3jKhRwvUJRrQNWu1eBm6YMozM1EmcirnZhkh2wvX7QfluTOGhdA
         uCd8h+ifKtEUfjtyD4MNMp2dkq5Cr9+t35u8QsEALKZTv0iaLgHkecqoaVk0eP9n7lTg
         P+5mTBnT6YmWi3yBilTR3Zhe16eJ65vc2JGKlCCG0cLaewDxSSNRVHpHv1DrG1SQ0yJv
         WFRhBk5MqQ5SZkB80e726veiO2xc8F7hNtaJLUwC8R5O4HHw5a2ZAmCXdK5+sGD5bDz9
         q97miVNrAwcUGY/pJqFoCRDZrSzTXO6mjCmvAUEkk7YrI1z9nw+2qNFKK/zRBHq6rowL
         CbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713970152; x=1714574952;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q31Ukp6X2FCLI8aCI5pOhuftdWSmyWC1CKtNwPgPrlk=;
        b=RwWFU9RKgW4EuvVYluDG2Cs+zzf+sWS8mU9WlAYIvRSa7TXa7GsORUC7CpbCYePpdK
         czwp7p3Hj0Qnti/yen8/FX/mIpvYdoonJVqww3/t2bT92DrRdkFMZt050SwwFIKxj6Cg
         cc0li4AYzIQ1O/4BZA1KI81KqFkSCGGt+bBNfTN3KAyNKrl+Wfs77WLf2gR3tblSsB0j
         8xJ7799NIy4JG1G8tueIUUxhQzr42L+UiA0VGpT9SX/NyBs7ly33IaAW9JDL7nlTUIyL
         pFA9AV5wZk9d5eGHtdFDDXnMuDJ2ctSg5udMOMfBIKSD3tZs4SKxHWvFjzrgAvLYd4md
         wpaA==
X-Forwarded-Encrypted: i=1; AJvYcCULFJyA8kADRnKXjV4P+fafOzpjtQJNzxtn5fj3heqGXT7Wu2V21XaVg49MX1L5rZWQY43j7Ji2srNJ/meTBdXLye4vtWC+Ft/3dFGy
X-Gm-Message-State: AOJu0YzHVUaSNsmYm4VEFaFuebmLkEVN3vxJYGTLgOHbVMFCCHX+CaW7
	Rm3OYeGy2lAzIfFudHxX0AmMXyF8jwfMDGnuBSwGJwWk0WjIu4g8hjLIuJAYdv4=
X-Google-Smtp-Source: AGHT+IGGPlFynSDFKYaliA98nipKF9mMlCFt0dLVpikKmiKaATHgora2NlkxXYYin0L1P/PNB4phrA==
X-Received: by 2002:a17:906:a46:b0:a55:5ed2:44d5 with SMTP id x6-20020a1709060a4600b00a555ed244d5mr1681642ejf.68.1713970152344;
        Wed, 24 Apr 2024 07:49:12 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906339300b00a5592a12fe2sm6169863eja.128.2024.04.24.07.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:49:11 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:49:07 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: =?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Horatiu Vultur <horatiu.vultur@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v2 0/3] net: lan966x: flower: validate control
 flags
Message-ID: <Zikb4yKOEvG40QxD@nanopsycho>
References: <20240424125347.461995-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424125347.461995-1-ast@fiberby.net>

Wed, Apr 24, 2024 at 02:53:37PM CEST, ast@fiberby.net wrote:
>This series adds flower control flags validation to the
>lan966x driver, and changes it from assuming that it handles
>all control flags, to instead reject rules if they have
>masked any unknown/unsupported control flags.
>
>---
>Changelog:
>
>v2:
>* Split first patch into 2 (requested by Jiri)
>* Added cover letter (requested by Simon)

set-
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

