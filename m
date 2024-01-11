Return-Path: <linux-kernel+bounces-23166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F070982A889
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A2A1C232F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8D3D2F3;
	Thu, 11 Jan 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLPKshkz"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A0D28F;
	Thu, 11 Jan 2024 07:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3367a304091so4425149f8f.3;
        Wed, 10 Jan 2024 23:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704959345; x=1705564145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk9dZVvi6gHkjFeJ5PX82VCiMGv5t62l2L7jmHeGkeA=;
        b=lLPKshkz331c+v+urQL/ui2VIkQA2UELxtuDBBomV0HctwMDFMuCvFD8QnYW0DzzJJ
         i/kp86ECJKpUMocs2QT/fwXXAak+rZf5riWqyOtvvms7O7nwmICY+5VhjxnEGFeaCRf3
         6sKsjfRed0pxG0gqMFED2SCkM6bxs0tTSqiAslheC33JkUnbcnpQjPhZUviWGHwh2SYL
         1krNiRlsHFsVz6ujZq22xnX1AYvCeO4xhhuQpqcaDvk/HkbtrnEcnkg3mUPWyGMEKop0
         pXl3DSNhYswKR6WeDgavJL+mjLN/vp7+nxAuXtnI+9qSB9dzJVUt0WKPEoMvDifrasSb
         tmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704959345; x=1705564145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qk9dZVvi6gHkjFeJ5PX82VCiMGv5t62l2L7jmHeGkeA=;
        b=n9+S3Ixph/ixPp/Q0G87Y+AGjfqklJmhr8pQPBXhezrXjc70Fsyqgcm6iJ52ksjqLD
         fVE7bK1p1W6GdhPZXebCHrfFPtEJWqa5IBtfSKVNk6OEeAsR3Q7Ovie5N4QeOJiNQ21m
         5Dc2ck5MU88BbhaFLsVlGqZhc7pXFSIjKQ+qX6XITyEONCXhb8ZqFJRIGmzi7aRM7PJO
         vP+GSt1rWhjtRjk2zqF96NcJxo/D6zLKLydhecTDnz+skpFz213DJiQBwdNf63BuaKl4
         QUN0kWF4hb3GQJOcDW8lWJpZwtRN2MpGohNALI3KUQmodi9jRgy/LpVYQHb2ww/zUVaN
         aH/g==
X-Gm-Message-State: AOJu0YwWuX//WeFyc8+3cvHDhRigeeqEG9GvvP33zvc1IXzP4Lnp9gxj
	v9ElWV+7/1iGqi5iRwqufns=
X-Google-Smtp-Source: AGHT+IEmMY747/wijgSOZkIcHgbbGJbAg6gFpoMer7lIwceByScxrgsHHuGDCvigc8RSL8hweM2J1Q==
X-Received: by 2002:a5d:43c5:0:b0:336:841c:c358 with SMTP id v5-20020a5d43c5000000b00336841cc358mr201118wrr.155.1704959345254;
        Wed, 10 Jan 2024 23:49:05 -0800 (PST)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d474c000000b00336aac53e75sm474657wrs.97.2024.01.10.23.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 23:49:05 -0800 (PST)
From: Benjamin Bara <bbara93@gmail.com>
To: aford173@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	festevam@gmail.com,
	kernel@pengutronix.de,
	kishon@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	robh+dt@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	vkoul@kernel.org
Subject: Re: [PATCH V2 1/2] dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
Date: Thu, 11 Jan 2024 08:48:59 +0100
Message-Id: <20240111074859.907558-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240106221907.325127-2-aford173@gmail.com>
References: <20240106221907.325127-2-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Adam,

there is already a V3 by Lucas available here[1].

I just noticed that the new PLL config has some common registers and is
therefore smaller, most likely there are other changes too.

Thanks for picking this up again,
regards
Benjamin

[1] https://lore.kernel.org/linux-arm-kernel/20230906184211.1857585-2-l.stach@pengutronix.de/

