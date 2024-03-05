Return-Path: <linux-kernel+bounces-92766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5261C8725B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A2D1F28024
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427517584;
	Tue,  5 Mar 2024 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFGN7vYx"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EACE17582;
	Tue,  5 Mar 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709659852; cv=none; b=Pu9kf2OmjvtkuWhHvBx3OCD6jhGmPvurzeLLlb+MimkbZgJKKUEdNKMmeo4yDU4wRaRXAygxHchg3yVy21zlKyuXZ0NCA1pZMHR9OiyS4JKijN+ic3r+zmnCu7hhrM1RoW61LTmYAixY1tneT02WP96W/X0qpZnxz/k+H3D54O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709659852; c=relaxed/simple;
	bh=PvctEXlGZ7nrrcmY9vxGBvaQwelTdL5Q2ErosCz7WL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1biqzExv9TEUDJiD0jDpH/RJM6sTmfiQmG6OMmCt535GHMCbI9U6+I8ddn0Pa84MlEC10LLDCiQOTEztQm9fVFenSkHIdIm6FfYAbaff9QBhrvwXQ6vAb5QAdy7HANYoptHjRqnQpaUQC6K2JpmdE7RSLkm1KC2dc3XEUWgqtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFGN7vYx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dd1d9daf02so15218665ad.1;
        Tue, 05 Mar 2024 09:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709659850; x=1710264650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFSazZv9KuKOFOd0EloyZ1kxaTz5xQ+zm2q9EjRUfYg=;
        b=LFGN7vYxyfT6Jyw6RCQ11iG3vow7sV8gNtrpwkxwtjHVn2dWwgxHsaq0NXKdGNjN+f
         FETwUlWmK2a5BQikf2ULEqCksvU/dMgX+UtE7E5tyFkOodgN9mknop6zweIzYXxtCTqG
         HCJLMio6ZNfmPhaXVeZ2M05LWygYjH5tb+MMgKBkAP1pDWZauQx3PkAy89y0mgwI2JCH
         mPfNzvkH6QKI+4oQviBwpoYXU6lCVGc8Shb/3xn2j795kV5P4RxFhdxSdVdB8e/Czuwp
         hRmPLhfZAF6oOEJJSbYIvwbpjaPBmnGSuLEWmeIjkC0B+KoCiS12ofC6vY5deuE2CWo4
         aneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709659850; x=1710264650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFSazZv9KuKOFOd0EloyZ1kxaTz5xQ+zm2q9EjRUfYg=;
        b=VEZvIdsD0fwBfiVTLaya0mtGztnxsgIB42xPpz4hkMJSiGUjuE02r5UZqMzMGv3YMA
         w/H0Pkpva8a6WkEYbxKZJ+Py1bZV2OA0ZtX3mfGC+BJ0sejO1D/0ZRx1U7Q93veDCpSG
         S0dTrKiTFQs7IiXu+zq+EGZH5ZFUgDZQrL+sRs5KY9/fguMTQ4smRwdaC3pm9WiS7Rnc
         Ch3XL97l2ohCQiQXmq3g34eY2KUIWYD1+GbGc9d5K6zpIYf/XQhzLlkuFb00SRY2co6N
         aaMhHhTZbF5OFd2X3I3Z4nbw87ijxr63FcmowRR//AEOIBpoKKVyAEmT4RRdLjc4SQTJ
         iFHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFPe0CMOQX837zVwokQtU9FbCJv3UOaV3eovy0J1hQLP4mwl1PB3jmNIpQdKuZh384tQ6wk6Hx3mSQq3iTt3vb7EKdfq943O7dZcLR9HtIm1k3PpKWTTqETcMKTk7LSktyt7P5VOo9VA==
X-Gm-Message-State: AOJu0Yyb+0g/q2aiPRZHZJsy0aA9Pw36iDwkSGBfgfbJVIXDuFLynj1U
	JlTVep5yVBYUqBT1Vpxy+k4xrA9lzC/yWvTKxxYgOvbBy4/+vZHD
X-Google-Smtp-Source: AGHT+IHcbyuVE9cmFQz6s2dkLwDRoCBdnXVosptuYoHArpLCCEckbFHHjUKlL0lQFySh9483/CNm/Q==
X-Received: by 2002:a17:902:cece:b0:1dc:8f8e:63e2 with SMTP id d14-20020a170902cece00b001dc8f8e63e2mr2842097plg.46.1709659850418;
        Tue, 05 Mar 2024 09:30:50 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:a5d5:fe74:fba8:86b5])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001dcc28544dbsm10821459pls.78.2024.03.05.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 09:30:50 -0800 (PST)
Date: Tue, 5 Mar 2024 09:30:47 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/6] dt-bindings: input: touchscreen: fsl,imx6ul-tsc
 convert to YAML
Message-ID: <ZedWx79qP7QXc3Om@google.com>
References: <20240226212740.2019837-1-sre@kernel.org>
 <20240226212740.2019837-3-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226212740.2019837-3-sre@kernel.org>

On Mon, Feb 26, 2024 at 10:26:24PM +0100, Sebastian Reichel wrote:
> Convert the i.MX6UL touchscreen DT binding to YAML.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Should I pick it though my tree or you'll push the whole bunch through
some other tree? If the latter:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry

