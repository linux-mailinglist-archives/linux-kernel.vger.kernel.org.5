Return-Path: <linux-kernel+bounces-7348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2489C81A64F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDE711F22EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267F247A6C;
	Wed, 20 Dec 2023 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INxR+WTp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD0747A4C;
	Wed, 20 Dec 2023 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7810b3c4fa9so72970385a.1;
        Wed, 20 Dec 2023 09:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703093295; x=1703698095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+OyaqFHW9V6qwRQc6pVjrvA8kLp9aIfGT/AkskV2s+w=;
        b=INxR+WTpYWrFb4YQvSzGsxEK7GMSJcseXfNW0JaptS05+O3s37AqfLljed5STRdEK/
         RaL3ckJhK3YFZfihwDjcez4V6CK1D95tSru+T3B5Isn/PBDYcRaPCdw+3RDXySQ3YMuO
         oSHcS4lT+TaPbqnVhEa0UJO5s3eCkqm2l3aBD8hAvJuLhlSi+XA5Kp8kC9HS4R7p+/op
         FtDDiA9RyjgIScKe9ALJiXdJCTuS5yvO3IRAj9dPk0lc5DCBkTYgc7m+q1Rq/QuTICFy
         RDAenbczzkid1TqrVqJ1l2ge6ZWWK5nC0UkPKa+pD4iwgggoQKEXXV+aeLe5ThYXCnZS
         fEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703093295; x=1703698095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OyaqFHW9V6qwRQc6pVjrvA8kLp9aIfGT/AkskV2s+w=;
        b=IBbQQrNWOh4OOarY09/M72vNgn15TnPhb3o1lTMyxq4624CypqZHWClUcNTPvZqSrk
         5v2c/3pnmHVDF/3wI9G53XFHv1aDuJ+Ng7LmUx0VpNAL4FzNjldE+TqX/qgDZDM5v9VT
         KioIfGNRlEzHuWDpYwkL1DQGwv02Pi6Z4nx0md2ZVw9astUdCxsBvB6tzqLuEqL9xsX2
         IGf2QwvExm9sztBkiDvL51K+KQLPAg+2ItpgvZPRpkNXEvBUgn/CLTT2pjmUbQqxVyEH
         beuw7BZqDInrzVAO05MkgOuCeBiIkrqDhcCrilKlyNVau3jUoeOtLLPFGHTDtzuKM8lY
         Q14Q==
X-Gm-Message-State: AOJu0YzCsZamAhIJL5JZqIo7GLmEaS90N6ZCH3+fJ3NFhI5gMmCNHXzR
	bAw/u+byw9tE5XvleQTBMRs=
X-Google-Smtp-Source: AGHT+IEE9JEzTSZAXdgOvlMKKzbCnREH5JGJqQHZ43XwII8azImNmvBYLv6DRRgAUyUsoOXIW8WaHg==
X-Received: by 2002:a05:6214:21c9:b0:67f:48c1:5809 with SMTP id d9-20020a05621421c900b0067f48c15809mr4133537qvh.59.1703093294966;
        Wed, 20 Dec 2023 09:28:14 -0800 (PST)
Received: from abdel ([174.95.13.129])
        by smtp.gmail.com with ESMTPSA id i17-20020a056214031100b0067f3a1a7557sm42891qvu.120.2023.12.20.09.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:28:14 -0800 (PST)
Date: Wed, 20 Dec 2023 12:28:04 -0500
From: Abdel Alkuor <alkuor@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: (lm75) Add AMS AS6200
 temperature sensor
Message-ID: <ZYMkJKYS+pRq1eMS@abdel>
References: <89fb5eec30df734ee8fc58427cf5d94929076514.1702874115.git.alkuor@gmail.com>
 <20231219-mascot-semester-7d2c492b99bc@spud>
 <ZYHEcfB7b+k2g9Ge@abdel>
 <20231220-gristle-renovate-557b8c330e4e@spud>
 <ZYMezZbvgtsCW07j@abdel>
 <20231220-elope-powwow-918b5b82b15a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220-elope-powwow-918b5b82b15a@spud>

On Wed, Dec 20, 2023 at 05:16:08PM +0000, Conor Dooley wrote:
> On Wed, Dec 20, 2023 at 12:05:17PM -0500, Abdel Alkuor wrote:
> > On Wed, Dec 20, 2023 at 04:25:15PM +0000, Conor Dooley wrote:
> > > On Tue, Dec 19, 2023 at 11:27:29AM -0500, Abdel Alkuor wrote:
> > > > On Tue, Dec 19, 2023 at 03:18:24PM +0000, Conor Dooley wrote:
> > > > > On Sun, Dec 17, 2023 at 11:52:27PM -0500, Abdel Alkuor wrote:
> > > > >  
> > > > No, not all of them support the interrupt. Just tmp101, tmp102, tmp112, and as6200.
> > > > For now, I'll add the check for ams,as6200.
> > >
> > Hi Conor,
> > > If multiple devices have the interrupt you should document it for all of
> > > them IMO.
> > 
> > The interrupt hasn't been implemented for tmp101, tmp102 and tmp112 yet.
> > Should I still add them to the interrupt property? They might be two different
> > things driver and bindings, but I just wanted to make sure.
> 
> I don't really care if the driver supports the interrupt on any of the
> platforms (including the as6200), if the hardware has an interrupt the
> binding should reflect that :)

Understood. I'll add them in v4.

Abdel



