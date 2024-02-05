Return-Path: <linux-kernel+bounces-52344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9B58496F4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66121F2302A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9A512E46;
	Mon,  5 Feb 2024 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HsWmSEk+"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE312B8A;
	Mon,  5 Feb 2024 09:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707126620; cv=none; b=FXa+spMUColWXPM1WCCOecsTKbwyQdJVU40LeX9CK3JncIowEobXIM9wQVknNPpsdHiIgHuN2tq9nCOsaBlQDJUAn/fU4+PTbLWzj0SoST2IAlKqaISY5yP2kfxtYKzuwisPRfGrQBBS6MKc9mEo69JBQ5y5DUUG1XfV081dkWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707126620; c=relaxed/simple;
	bh=Jz/vUc3v//mCg11zZ/bCZ7VE1697NMltVJazebEOons=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kejodS0EYGxkietLQtE3FdOsfxgxYEQK8qg/CErNCjOqjHs+U/WUusc1sJ4D0qGUHeDZt0afeByzMNH2CixIztHnBIQ+UFovCluqm0kZwK+PKEEf3smmhFGQGy2/TzcBfEFdCNGYmOCqyJbxjf4W6czFPZralhLnreVCIo+A4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HsWmSEk+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e02597a0afso1365051b3a.1;
        Mon, 05 Feb 2024 01:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707126618; x=1707731418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyxLyOfbVqgM9WmxXwGUihLV7GhZ9dmSNbUWWpB1kbo=;
        b=HsWmSEk+qVA9BVzmkVec6Ta9vecrCkgGcNrmdQRTl52hTZNi52K5uvOgIu63WgnCps
         e+2swAY+PPxf3lGwzYPiAK/OzpjJ6VFA2wGFqd7nTUwpsuCvj+pXBP3a2M9fz4EoKERg
         uQRwAa0SGHygNQxgn/OanTQAJ4OwbSQUMSaYvun5Um4U/VbI/j7HNBBJmx3692N33WHW
         ypWwAwtnn5PYmHpIFmxkLbi0Niz0vE4ckaOcSi526fvwsjyqdGqNeQ9UFfRqPd4HgqO3
         dynHXd+jn7PGPBsY6P9npYvqWq/rBavirGlvZFbRcgk25U1VXdmDoptyIWJHdwukJtjA
         kMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707126618; x=1707731418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyxLyOfbVqgM9WmxXwGUihLV7GhZ9dmSNbUWWpB1kbo=;
        b=a2dYwEpcUJfzoL2FQCLZUL4Ou7QJLOKUjTm15byLJ0FHUed73+RUOprkt6KNTGq64V
         yZa7yVNyIojNhoizVz4/XeeDBb6Xz9IHrr9ROLIbfCFWaQvZIJYehWXAfliMkf48xUN5
         7nDvno24/SXiftbhxkEkEsCFOve5ppKfsPwO48EPuIJUSD6M1RicCcKVZQSMg2vQItFn
         lXFvll5304QKrnTz1odd+J//ainyBfGdCo72vafiQfkwsRQP+WAGg0xD6D1ph1BLq2es
         RTt4eTQuA/q72G3t3esxAQmnVR4tRu3l20POA5xDuxzJDl2v7J9UN0cMpXe8+q0HxtXb
         avlQ==
X-Gm-Message-State: AOJu0Yw9qrfnzrNXgzeL9CT67fN5/eg1sO5OFeskbtg6/3nDtARJtEye
	6mqHtYXtDEQQM9eTuI5Iy82bZQ9gk0wija1uRpYH7vJrA0ogFwk4
X-Google-Smtp-Source: AGHT+IEaQlbMDkqls+1z356bkMGfAyosJJfP6FT4PccIh0PILxVE9gnQR6IFhec+C5UYqdVXv36p6g==
X-Received: by 2002:a62:e712:0:b0:6e0:3ef3:db3c with SMTP id s18-20020a62e712000000b006e03ef3db3cmr2696758pfh.29.1707126618105;
        Mon, 05 Feb 2024 01:50:18 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXCwihz3NvpgC9gV7esiVF9I1di4G/tdzvEwGpDMug8aT8iuL1ZcyvFDxwioqQhicoFmS2+U0/SqaLJvUhb0WiRP/bp6CchoslH868BFpy4DgpDEbfnNZLpiE5GCqJ+c8wTTBbDHlcY5wEwtkZnmPudtAlPzQEPDvgDkvn4kejFrfvfYlrO6yEWalSJrDPGghQZbrrH0el23aBwW5Wl78DdevWRIGBetaDQ8Rl3kQWa9JDGzODztNOiRDPez+sZIeQHmRmpIvoSOSVU2NI+HMeXC9/A1rFLBPdeYvK6B91Vco25iEcf6BnqN4tsKu0ComBO/ThR23H+VgSBa/k2k42DyegcBFWE1Eczddqq8Ruey9cieXVxSLK3CVQptyqKr7V5wPOgg3cEDVT55WKsQs6+udWIHwgkGZeh2Tqo/yl0X/YwcEGrPdZnMDZXPGTXBwlDUtL1ehef3feEWXhmDptdnLGD9inMm+PMK1TyGeiLz+TPZQiU7cG2dVgpG0b27vvDA1BHzEn2ldWq37dPacfq9OJvVeS9yptfyzqtX9xmdpc8VSuUH7oimfLzyaKxqxXKjaHRGu5Oh+xqI3zblgj3Ml/aOKAXPngklDkuckbssdBUk87cqHvlBDgY9KGYXcojZ7jg8QoeTITkHmz3oJw8uOtWpv1lRdass5luG3OxqWWy04qcrf9QqaZ0TCxlI/TnKPsvL3agms3YrpDgtA7gxuQ6I3bWgvBqg7Z+5TLPgumjGqUu
Received: from t480 (89.208.247.201.16clouds.com. [89.208.247.201])
        by smtp.gmail.com with ESMTPSA id i21-20020aa787d5000000b006e038327bbesm2757236pfo.79.2024.02.05.01.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 01:50:17 -0800 (PST)
Date: Mon, 5 Feb 2024 17:50:08 +0800
From: Shawn Guo <shawn.gsc@gmail.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: imx93: drop "master" I3C node name suffix
Message-ID: <ZcCvUJNslxafvCab@t480>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
 <20240117075618.81932-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117075618.81932-2-krzysztof.kozlowski@linaro.org>

On Wed, Jan 17, 2024 at 08:56:17AM +0100, Krzysztof Kozlowski wrote:
> Following change in the I3C bindings, the "master" suffix in I3C
> controller node name is discouraged (it is "controller" now) and not
> accurate (if device supports also target mode).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!

