Return-Path: <linux-kernel+bounces-108723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33451880F2C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BDC0B22502
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070823C064;
	Wed, 20 Mar 2024 09:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcDv1Znw"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021AB3B796;
	Wed, 20 Mar 2024 09:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928783; cv=none; b=dRSwOyrOevj9sTSsBu46Sj+uWovzeUbm3qyz40/rtGXjKAjkSXSXx/7V8oi4G1Tf3VyzMoTkmh8NOOoLZ7mdCNDPADY1l6X3Zs96UvjXoysvZXa9HdKohx494ng9qKLhg8lazr69RAE3GYMFGvlmZvYkO6jT9Vv0bfZVeXHzNzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928783; c=relaxed/simple;
	bh=Qt9mFouOzkHwbrnUdWvtWErPKBTBGDX4X6ZAL8Ajzfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H762PkZhFRCuP6rgeXtzuhLb6YpzNmODMn2gNXseXyb5/O4WCLC6jldjNwatZGs5bi1e5HAd3y9oPlIOiKi4DRY0UK4RRVQ1383yiHIyvUblSiAvXNQLuZZheWVCq9BeDW4Hd00rRXPYeOlsrP8aYuhPpuRH9gbgC3yMm/zbfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcDv1Znw; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21eea6aab5eso3244133fac.0;
        Wed, 20 Mar 2024 02:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710928781; x=1711533581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt9mFouOzkHwbrnUdWvtWErPKBTBGDX4X6ZAL8Ajzfc=;
        b=TcDv1Znw1d6FUAPo+/H2wngz2lq3NdLicVUl24hUGRFzgHhfK9iepj4H7TN+PVsR+y
         UWDlrUWe6+kqo5lMN0DMG1qJZEsH4bvNrqd62cWVw9Jg61YeDtgnIpivQI/+IL7CeQkY
         AONC4/OFxUT6Eu/1BV3BB/8VHSVQnANRZD1IsuuI0CcHp8R+bxnmexLVa+OMtItoeCW7
         gqyRHUJ5DrxYKPZO20ndxaNV3jK0S/1hVoldkL80KSzyGyj7X7ZJuM6sae1FXOhZK/cZ
         0IyRhMl549Mgr+L6uX43a/LFlxtcrhR75lnxRCy/c6KeiF0nLPMePuECcep/KXqPLpv+
         EJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710928781; x=1711533581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qt9mFouOzkHwbrnUdWvtWErPKBTBGDX4X6ZAL8Ajzfc=;
        b=GvAsHamkp9Xd0D6y9/UXPeSWi+g1fpEX94U4Oy7YlTnCdICNm4rEpSKC1ovin9tNz+
         2F4hTqRC5M8sq/2casqpwWFn5K5Z+1I9gU4+fBTU6pv8ndN7xy3VvyMmxcrdIsntxoY9
         FA7xQ7fNSApMA+dFZ1xm0rxyVXlb8yHpL938p1m2HnaHjVGiWuAuKghB/srJlJlWd084
         2ROwEc49nRBULGUptnlqKB5Rj4BW9i6nwd9MCRjrEAOIKX8Bj4vaFnS2H/FO/1n4+t1l
         k0R0Zse3DnNFbZQLXq5CE5+1dPmkGFOpNt6S2hjbjRcGDFN3r5MQF6+Lid3Bx26zL14j
         t3tw==
X-Forwarded-Encrypted: i=1; AJvYcCVZl1wj3/Zzy5ourPlxeI9Bme3QN2f4IopnQoK/CVNtSg86rUEjFMJiF5LibMusS8hn6F7CyGqjQxR9kFKN0BbFUaDlju2onhwYgPyez+A5WQiHtq7U+/ux5282tUa8VqnE2jzGMHdLHX7kqPP8W243B5jNYN2yxRLKVlBtY6+ST77Lvw==
X-Gm-Message-State: AOJu0Yw/Rlbs//earPyMazAh7n+ep0h63TJpE/ydD0r1ZUVXdTXP41J5
	hkVzg1gCINu0traqFSGH2JW5UqHlVkKrgpi8rNAbTQ5zWv3u8WqvMxsvLqm9NVHjp4CS/NUervh
	kqiNq26C+TKPCEkaXJAvUq8mwDWo=
X-Google-Smtp-Source: AGHT+IHKGk6zvanwsfYOUmgawsFLDcKZezrYp43j3nvQE1UIfqBX0xeVjzmmz9IeMtwoXCYwQhOPZk/vmnuGF7xcRSg=
X-Received: by 2002:a05:6871:3328:b0:21e:5008:cf62 with SMTP id
 nf40-20020a056871332800b0021e5008cf62mr5474896oac.21.1710928780879; Wed, 20
 Mar 2024 02:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320090733.96828-1-animeshagarwal28@gmail.com> <5056862e-a815-43ce-bb82-4cde39fffb2c@linaro.org>
In-Reply-To: <5056862e-a815-43ce-bb82-4cde39fffb2c@linaro.org>
From: Animesh Agarwal <animeshagarwal28@gmail.com>
Date: Wed, 20 Mar 2024 15:29:29 +0530
Message-ID: <CAE3Oz81Kpx4inqSpkM8aiu4ydGJsksjSUPyQqT2gRj_dpmhxyA@mail.gmail.com>
Subject: Re: [PATCH v8] dt-bindings: ata: imx-pata: Convert to dtschema
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:20=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi Krzysztof,
Thanks for the review.

