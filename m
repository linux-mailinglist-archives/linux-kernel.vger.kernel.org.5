Return-Path: <linux-kernel+bounces-98488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3532C877AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67ACE1C213B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7360ED516;
	Mon, 11 Mar 2024 05:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMRGqWdV"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A24BAD59
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710136148; cv=none; b=P8HvsryeukWr83aqyQqLHtp9bn5ZYiwIftWK+0TG/Ox/neAnFH7higawq0uohd4rI57i02d3NLu6IMra1kzxRj2K7ejvKyS8YX6KPLWwl3/qo3ImoHttGko9rBAzOHNjfMP4f+R6JVN2QZZohM9poGnQdy+Um7buRTy+Gjd+XRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710136148; c=relaxed/simple;
	bh=iJq8I4665B6tXtRy7Ozf48bVxsc7zHGXEtSdRs+nb6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWWWZIIej8SwxlWzjbwThcdKhdQJ+72Q2ZBvJikjFAr8TrXwgbs957e85D50HKm8MkTScLZ1+fxe5IAQQagnlU+dHOf0ASEWm1miFQSrut0dKUELNkay4j0a4FtykW8dgMfjEYUkiVzTaWOOi7nwK19g2U0eKrz8clQqHdoD460=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iMRGqWdV; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e0f43074edso2810194a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 22:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710136146; x=1710740946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4QvIE9VzTbAgKqsifgCBQZyOLX6yUspxfOa9hY1WXE=;
        b=iMRGqWdVcy0+N1qlpZ2WivZ2VZ3Chl5g3eF1SPHb9+L+kZUDhuR1lfUF6hIfZvDgaf
         /BKCO0YfpLRhvOAGoiCGv1VFtLjoVV5QPhgd+HPoBmn0HlShdxYTPWNV0TwQ/YchbwBv
         rKexnq22fW8CDo0R/o41w9ahPTTY2Razcb/ubJJ0FsDFuiVBlujBjwlHN76FoYySdDwO
         PZghcv32SrOUo++viRCDg3/UwEzBLA451crUPp4Zfq9+iHoA+CZT7WaEOU77vQvznIXN
         +H1TqNN/4GW7uUHsUnXKOjhM1xzyTFr+NGHqI0dGh9mSWuHbrBYG9HdZILrgPGlGzU1p
         SHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710136146; x=1710740946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4QvIE9VzTbAgKqsifgCBQZyOLX6yUspxfOa9hY1WXE=;
        b=IA/h7mFWk4pzLW0Qo9w3iEGHvgIxtxN8sooYO+ybyG8U6thqoNAZ0Hrhardk9eKAf8
         nspaIPcf/Nnhb4HrQBeXdlENOh17HBiNrXpiIXjq+yhCMrNrUY0TsXcLsg5ItBgjIPoX
         vXPzCpHMSCnhqtjDsr+F0/fq/SU1M9wxWeM/SelFHDdV5ZlETnXULT4vhX/qj+aQWkne
         tJdeH2FlPfTGqew0TVMkTIOQhTCSE+cwwu3NoRUC90LHl3nGJAoT6Ctk3p8I2Pnvcg1u
         TaAoWDbDBCu6eX8f3fg7FHGaSpw8e7dtSeimie6b640zR5bNxaBTzoJ9pXBeOCr3I0rQ
         wyNw==
X-Forwarded-Encrypted: i=1; AJvYcCVA4jc0bMZMhzBbl6NcOPU+Ljps6lqPQaeH63jHG09bYEJv8aAYlWQbS2bGfNo2ZrbxhMhLtuu0CHvY9OKc3mdtkoTmEuBfdNiLI0Yg
X-Gm-Message-State: AOJu0YxGgHWDWqq455Z/+ycO58qxb/6D2F8kqT/Ku5k1FSUjUhTm59w1
	dS3YiGN+xr/PLbDh2x/o6oYKUn/iqg3LQuLY9IhCPdAda7aiHJT7Qg1tbcnp7Bg=
X-Google-Smtp-Source: AGHT+IGTc9RR/qldDCyHa084mMYBDLDFRMOSdRBDHjzvzzZDmDR9cw7Gtzb+pxkEKOvPNI9IDP9zGg==
X-Received: by 2002:a9d:618f:0:b0:6e4:767d:a085 with SMTP id g15-20020a9d618f000000b006e4767da085mr4576973otk.24.1710136146150;
        Sun, 10 Mar 2024 22:49:06 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id d1-20020a654241000000b005cfb6e7b0c7sm2960190pgq.39.2024.03.10.22.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 22:49:05 -0700 (PDT)
Date: Mon, 11 Mar 2024 11:19:03 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dhruva Gole <d-gole@ti.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, sudeep.holla@arm.com,
	cristian.marussi@arm.com, rafael@kernel.org,
	morten.rasmussen@arm.com, dietmar.eggemann@arm.com,
	lukasz.luba@arm.com, sboyd@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org, nm@ti.com
Subject: Re: [PATCH V3 1/2] firmware: arm_scmi: Add support for marking
 certain frequencies as boost
Message-ID: <20240311054903.x5khrkseslgyjn2z@vireshk-i7>
References: <20240308104410.385631-1-quic_sibis@quicinc.com>
 <20240308104410.385631-2-quic_sibis@quicinc.com>
 <20240311053554.36j2rq3wgtswwoom@dhruva>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311053554.36j2rq3wgtswwoom@dhruva>

On 11-03-24, 11:05, Dhruva Gole wrote:
> > +		if (freq > sustained_freq)
> > +			data.turbo = true;
> 
> It's simple enough that we can write it as
> data.turbo = (freq > sustained_freq_khz*1000) ? true : false;

Or:

data.turbo = freq > sustained_freq_khz * 1000;

-- 
viresh

