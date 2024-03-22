Return-Path: <linux-kernel+bounces-111802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0C788712C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E3E281EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FEA5D733;
	Fri, 22 Mar 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+SenR8z"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1795CDFA;
	Fri, 22 Mar 2024 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126100; cv=none; b=ZzGYx3JuSwy1iluezK7Wy/7FQVk14G79qIcqW8KLQpmlP0x7+QJxhhF7XLE6TbbWOk6aozQ4DWJfh+qY9RCwqnDrFjUweypT9BD5q0Z/1CHVb3VOODkdP8mZoz3X14UhxU1AQL6ZXE+1heb3JSTt8Grb+9k/s/ZrUo+lkt0QCHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126100; c=relaxed/simple;
	bh=AIxpdyQlT/B7BYVjFoMD8/QUyW+1uhLFqyaeq6EgDW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWC7/4T6D+CBUUfx5A8gTgh9/1q7ajCldM6otX8jiAyo3tFeps3E3ZLWTIB2t4OI/UnuH4jOW415uprB5w9RBHRsK0KyPGJDO9xUeWak71wHSmxAWlrw7LlTrftbVIZ3uOxyKZh+dTvy8YN0TDUHPL5bMYArKhueO+S5zeryD5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+SenR8z; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so1467200a12.1;
        Fri, 22 Mar 2024 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126098; x=1711730898; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iLWuYvxt8cJho/qyhrDkNvS5uRVsAloQRBQojo7kkCY=;
        b=m+SenR8znrNZmLAg7GWJCqvlUSpT/0BvOYuM8PMFsjm5eBQtFooZHeGFQwa+n7awHC
         Z1rjJ/UtR9KYlHsApMkUHIGtWtGXQGzxu/83+amxOHUqWNgQzjY4YfSaDJUODmeYFBl8
         wdSk7rOLSnCdX2YMeUxsVgNRe5jQlpzgqwAl86k0wxF9aF0vyMODxYjWeXPhBm0d3V4D
         xo6wIpxAYCUedsLnRu36hH9hPseoq6S9ln9hmjYQem8kjMnPt+Y6zPDa6JiDp597Wuxa
         gskeyhMZW1cc7gZ8D8Mda5uwgqVZCyokbgd6FWyMkzQYcpUeXDxf500kBNiYxHfWurTd
         0eLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126098; x=1711730898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLWuYvxt8cJho/qyhrDkNvS5uRVsAloQRBQojo7kkCY=;
        b=hgxaMMLBpSwkzNE1X8lVYLq/Qere1lbcfLXeWbeRDKzNl1J65pnu8O3A1j88SsCS2l
         Pfx0xXb9WMKq3g7KKEedcosCR8bZkTvWa8P/RPrxa7s/iauYuF1+QrPu1a6UNAWkNcO6
         EXSHMT65YQO2BR6IWVNsyFQiLmqvV+ZaMEZSaekmswNMDm8NEWH0XXJdl2XlBjBx7Uyy
         tfFJyf+/N85okUyRJXGbQ92p0Jd0Kjeb61x7yXcUCDYQzKxiCHOVNi1EL9yz45AW5jT9
         5owVUdrzkkql8fSSFDFgo/y5FRjx0LLp0euoN8pTiU9XEkCpvUnXTx6JbU1xDKIKzf44
         8n1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVb37bTfdj0dMD014I+0Q+yFGeVC3CVh/l7BAjwBWwJbJphV/BnA+CCGFx68TRhjhArWMLtmUmOGb9yw1+8mBPWPOrpqR88Gwya/+o7/mL791zK04CLQ/c4l+jfURkza3N8PTjwt6cDfHxuVXhHH0dLDvPVhmpQmLoOC7WEztkdgSIdcA==
X-Gm-Message-State: AOJu0Yw1DbxLGxverbXzmAYhUBBsAoc7K22SJesQlGdwvDBwgTtvT1SB
	7hKmsb9jn5jpuraV+yGzCM+YLU3jlbf8AZYUtdD/55ds7hJjpovV
X-Google-Smtp-Source: AGHT+IF7ZJb9s4Yx5/oto0bsQjpkkyHcU/EVUMjRlMUGYu/PgXMG5bI/6u+KSo3WZ0/VTzE6OQtw6A==
X-Received: by 2002:a17:90b:1c01:b0:29f:cd96:5952 with SMTP id oc1-20020a17090b1c0100b0029fcd965952mr187833pjb.22.1711126098455;
        Fri, 22 Mar 2024 09:48:18 -0700 (PDT)
Received: from five231003 ([2405:201:c006:31f8:d95b:eb72:e032:7eef])
        by smtp.gmail.com with ESMTPSA id si15-20020a17090b528f00b0029e05ec1cb3sm2124620pjb.52.2024.03.22.09.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:48:18 -0700 (PDT)
Date: Fri, 22 Mar 2024 22:18:12 +0530
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2] spi: dt-bindings: jcore,spi: convert spi-jcore to
 dtschema
Message-ID: <Zf22TLko8tFEYMDI@five231003>
References: <20240321180617.35390-1-five231003@gmail.com>
 <affc1b03-7a23-4fd8-bf85-4155bcd41df1@linaro.org>
 <CAN19-EfCOWFqFCrF0iCaxhfZuteWawQoH0d6pTN3cgQ7p-CK6w@mail.gmail.com>
 <5dd3237f-e0a2-4214-a63f-233e89a26b8d@linaro.org>
 <6552bcb8-e046-4882-91da-1094fff3d239@linaro.org>
 <20240322150524.GA895852-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240322150524.GA895852-robh@kernel.org>

On Fri, Mar 22, 2024 at 10:05:24AM -0500, Rob Herring wrote:
> On Fri, Mar 22, 2024 at 07:49:57AM +0100, Krzysztof Kozlowski wrote:
> > This applies to all GSoC or some Linux Mentorship programs: I suggest to
> > choose for conversion bindings with more users and bigger possible
> > impact. So first I would look at ARM64 and ARMv7 platforms. We still
> > have around 1000 and 3500 unique warnings about undocumented compatibles
> > for ARM64 defconfig and ARM multi_v7! That's the platforms you should
> > choose.
> > 
> > Not SuperH, ARC, or whatever with only one DTS which is difficult to
> > build for regular developer.
> 
> To add to this, either ask DT maintainers what would be useful to work 
> on or you can look here[1][2] to see what are the top occurring 
> undocumented (by schema) compatibles.
> 
> Rob
> 
> [1] https://gitlab.com/robherring/linux-dt/-/jobs/6453674734
> [2] https://gitlab.com/robherring/linux-dt/-/jobs/6453674732

Thank you for the valuable pieces of advice and links Krzysztof and Rob.

