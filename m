Return-Path: <linux-kernel+bounces-10660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664A81D85A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 09:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBC1B215A2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620C31858;
	Sun, 24 Dec 2023 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeZqZWiX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BBA23C8;
	Sun, 24 Dec 2023 08:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6dba02a162aso2351529a34.0;
        Sun, 24 Dec 2023 00:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703406683; x=1704011483; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NrPhgBGbuVI3Z0yRtLhydFoUuukhWYBh50YNwwYRgSE=;
        b=AeZqZWiXyWf+nwQY37+efnneQd3TTIxV4CucPJD+fO4jswwDZuC/c6xTM3CHm2Um4C
         YxBRBVZT51mAQi+f0I5ryo1K0wgB0hda1ovpRcsGIJnMyUlbmC7hPsuhtFvSF0TCVBkR
         vJL70Fh9DmxmgJUam/APk19iKl0x4TOgbEtGTTCk6U/cWb/1Y1zGZs02SXThA+433sy6
         dVE1ZxzaiaQ8SuoteY+VyGEHJOSyyfnNEtLtQWvwScNtgqK0YCXE9rYG21HwsnfTzGX5
         UgOWkFXWKiDT4ver+I+lyGNODwlsAnwNqxbwlSB9dlmy8BtxjQ33OVarVsSyzyS0S32g
         kkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703406683; x=1704011483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrPhgBGbuVI3Z0yRtLhydFoUuukhWYBh50YNwwYRgSE=;
        b=MDG9+BG/5rNmlo6tc4JwF22JPLu0STUAcs/K4WHoOfSbgSwSpRlWVoNlz37Sv02hy6
         d+F9Q8HHWAJf9fBhbom80+Ag1twVV356yPym+orXNDseYRlgIxxeNSgy5Z5nNbD4m+3X
         dGFheHZ6Il+hqxH3r9pstq3e3T3bIlyxm25jVpe5OssRjUE5Oe/8lJmUBmqDMWN4d95w
         hCwI7W1iU/BNf1Gg0oj3to4n3e7pHTmLIeopukS8VednKMEPQQkdeym3LmnECSem1WHz
         mBOkDxAGt99O/OTRYYMiQCbiP9okxyM+dMbckOyvfkG2MiInaobLfroQb6jZVGZYYxzY
         tq8A==
X-Gm-Message-State: AOJu0YzkruWqerwjGegj0QpC9l2ZaaGq3TsnBMJIu/3W2dyytHEEKbBO
	5PfrVLJiyrCBED5q0dBU4BQ=
X-Google-Smtp-Source: AGHT+IGMLREJLFitoBIk8L+PdNLr9Rqdwm2OGFam1MME/LwW749IEUuZd9KI+3AD56OcxoDp0iRMOQ==
X-Received: by 2002:a05:6808:138c:b0:3b8:b89b:5ecb with SMTP id c12-20020a056808138c00b003b8b89b5ecbmr5143270oiw.71.1703406683496;
        Sun, 24 Dec 2023 00:31:23 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:765c:936e:ea43:6046])
        by smtp.gmail.com with ESMTPSA id hy7-20020a056a006a0700b006d28e01e2a9sm6165283pfb.1.2023.12.24.00.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Dec 2023 00:31:23 -0800 (PST)
Date: Sun, 24 Dec 2023 00:31:19 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
	rydberg@bitmath.org, linus.walleij@linaro.org,
	Jonathan.Cameron@huawei.com, u.kleine-koenig@pengutronix.de,
	heiko@sntech.de, linux-input@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: touchscreen: neonode,zforce: Use
 standard properties
Message-ID: <ZYfsV_RQqLcee4mz@google.com>
References: <20231223221213.774868-1-andreas@kemnade.info>
 <20231223221213.774868-3-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223221213.774868-3-andreas@kemnade.info>

On Sat, Dec 23, 2023 at 11:12:11PM +0100, Andreas Kemnade wrote:
> Enable touchscreen orientation to be specified by using standard
> properties.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied, thank you.

-- 
Dmitry

