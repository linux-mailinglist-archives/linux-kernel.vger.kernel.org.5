Return-Path: <linux-kernel+bounces-75943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE685F0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F332C1F22E42
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 05:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC299168A8;
	Thu, 22 Feb 2024 05:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe2O986R"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED681426C;
	Thu, 22 Feb 2024 05:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708580039; cv=none; b=uGzXe54B2+GKtpsLdI4zOasHA19/SzQb+SAofDF82IrJrQxMw6uXDFQ8EKhRVyrHn5NqVJTUA4bS2C/Gae0N9h5+NRRxMQ4SCKDbxoBcl22ptSl0V2B1j+1AvYbSJjmyiIhKnOBaMuV4TcUaFD6HXgju5Oa+z4WbHOusCyOD3YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708580039; c=relaxed/simple;
	bh=x4hgtd5pbbZYAzpAWR0r/AY6F3nD8p1DTgVilbfppwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V5HT9DkST3+PEoJR0tDrCdc2CQzCOhHRjDKQJnIjcpia1lwiL6IarkqAgRhaKm46wiypEssi6utsoJNKWYoIyGDcdBHSE0OwQRppUSAZ7IvAm2+aWds0kDFjR+W1756UGo6sJMW7ORtzVeIGtmlWJkh27/TVZpHolW+VMundPU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe2O986R; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-512bb2ed1f7so5097975e87.3;
        Wed, 21 Feb 2024 21:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708580035; x=1709184835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUAN6efcT0bwm6zf+7k6iWx7A/6BQJaaPLnjpw2xGcs=;
        b=Qe2O986RNMCXCW4KKPXKoyNay5XRfTfliYMP+2unyHirYFhofOKA15hJefdJhIdFw4
         qS5A1KIsV2JpfAYMDhz4J5FFEiK/0tY039NGPFVP66c7NrgEi/rSFMk5nuj0Js13HUZh
         fYg2qHwbJOPm+1xm7Js0pzdN5AG2w09p/eLA/6e/8RRlUhVGq7NCmzGtS+vSSH35gZZu
         s5o39VIOC+YxZAnijypqivkopFhjgVkCYbaJnPRY/pbC8LMp6OrSWGu7mMB45eLOe1yq
         DOId88Ldc9jcPj/cPAYU0pPgEZUtwfAhhWAkw9xy3tPHegSs34JoRNuBLpkI2KGeSUlr
         rEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708580035; x=1709184835;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DUAN6efcT0bwm6zf+7k6iWx7A/6BQJaaPLnjpw2xGcs=;
        b=n+ZZ7XtFfhM8oS8RH0KAyLa6GLOM4cZPBQJeojXViidmexP+15sU1w4W5A9taCmmp2
         IpFvssGnOYfY0G9B0LhNoRrEMKDXA1Kjao0phPdeoJpS10/t8B78mFhc7Rlbh8Qa7KJT
         UaPQ6zkmeTQvvni4pqGIjJEZhCN2d9v4TQadJBJ35SHBtu/zsxaxeQjgnRHekweyzVEb
         XrpZzIwsl1zZLdPTGAas7O2d3J15QE/oCfOY2I0Rk2Q4CwUuLkHTbXlLRswhB2LNv7yR
         7N0Tulrxr6oNul+QU6XurQ+VPUgcyfM+VOz9UGg6VX5QliaLAO7kMA+O83mpcgIszINC
         fTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvFxopj5jQyixmFWnW9ubKCP8IHLHuHa9JhpHxRw9Bkt1QL6AnaazZd1JoKBNA+vvQGP0GiZPtUbbI1onByjwYLPmNkR1PPjm7/rQOlP2q6z+Zmrr6TsWb8XPAGFgLAckvdWHfM0SFm/JPzXJZxEFnC7dCgrl5oyqLxvDX4p7qKv7dXuZR
X-Gm-Message-State: AOJu0YzLNbJ9DE01NSqJGptp42vvv28DfCiFs726fjzRhReNbSBXkm8/
	ZAp2Yyj6OSSUFkHOqyM+gcTUju36db1QInnJf0tdBKY7F87sDv2Q
X-Google-Smtp-Source: AGHT+IFAXad3MqAXAgm35rjWrM8EHE/Gg+VKpRXvoL3j2ufoDYOCIJOoDXKaT3LricmVtYLIiDqDAg==
X-Received: by 2002:ac2:4244:0:b0:512:b066:be25 with SMTP id m4-20020ac24244000000b00512b066be25mr7435726lfl.37.1708580035130;
        Wed, 21 Feb 2024 21:33:55 -0800 (PST)
Received: from localhost ([2a05:3580:f312:6c02:29d4:49b1:c3dc:494c])
        by smtp.gmail.com with ESMTPSA id k24-20020a192d18000000b00512ab0bb96dsm1746745lfj.57.2024.02.21.21.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 21:33:54 -0800 (PST)
Date: Thu, 22 Feb 2024 08:33:54 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: media: i2c: add galaxycore,gc2145 DVP
 bus support
Message-ID: <ZdbcwrQG1etZkb3j@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
References: <20240217220308.594883-1-andrej.skvortzov@gmail.com>
 <20240217220308.594883-2-andrej.skvortzov@gmail.com>
 <ZdSC_xulFQ84TtLT@kekkonen.localdomain>
 <ZdSDXQg2UDPvvSh6@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZdSDXQg2UDPvvSh6@kekkonen.localdomain>

Hi Sakari,

On 24-02-20 10:47, Sakari Ailus wrote:
> On Tue, Feb 20, 2024 at 10:46:23AM +0000, Sakari Ailus wrote:
> > Hi Andrey,
> > 
> > Thanks for the patchset.
> > 
> > On Sun, Feb 18, 2024 at 01:03:07AM +0300, Andrey Skvortsov wrote:
> > > Don't require link-frequencies like it's done for ov5640, that
> > > supports both CSI-2 and DVP. And v4l2_fwnode_endpoint_alloc_parse
> > > ignores link-frequencies property for DVP endpoint. It's used only for
> > > CSI-2 endpoints
> > > 
> > > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > > ---
> > >  .../bindings/media/i2c/galaxycore,gc2145.yaml | 33 +++++++++++++++++--
> > >  1 file changed, 30 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > > index 1726ecca4c77..fb376b9d0f2a 100644
> > > --- a/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > > +++ b/Documentation/devicetree/bindings/media/i2c/galaxycore,gc2145.yaml
> > > @@ -61,9 +61,6 @@ properties:
> > >          properties:
> > >            link-frequencies: true
> > >  
> > > -        required:
> > > -          - link-frequencies
> > 
> > That seems like a bad idea to me.
> > 
> > While for parallel interface it may not be often important, for CSI-2 it
> > should stay.
> 
> You're also missing the bus-type property which should default to CSI-2
> D-PHY.

I'll add this type and make link-frequencies required based on that
for CSI-2 bus.

-- 
Best regards,
Andrey Skvortsov

