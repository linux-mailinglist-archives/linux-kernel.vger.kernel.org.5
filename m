Return-Path: <linux-kernel+bounces-20854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B259828648
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:51:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 917C31C23A54
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 12:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1634381DB;
	Tue,  9 Jan 2024 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OY1tnq+P"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FA16D6F5
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dbed71baa91so1666850276.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 04:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704804669; x=1705409469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qROkrwZiYfF7G3qfeBpIFh1K/Mmm7qN8BCKWKeQz2Xg=;
        b=OY1tnq+P3Q6vvno8v0wZENbjzmrUJwCN/PHwcahuwO2cP/MUTzxCVUjKs+qE9RbtKb
         1NBcBw9KZMvx1wGO6JyvfpMmKHRqk3FnzzMh8qGbA6hkyZUlsoY9qceSg2rcrZxWoYE6
         hCponmBawZvVUKR7TbGDov9gUDiWPfGqOQcBXnZ2UU/HCic2Nr1Q0wDgIB/1+T8yLJKs
         rGpHMglJ/GPkmTu2WUnGv7BuJFdKyTmZ0VDl3ddoL9AaQ6XCzWfoc6pvMjOeNeE0QuCA
         P/fnP4+CYfoPC0xGoSgWDz8YhxYuY6kS0vR9rgURu2ejOusxCX8sI8Vczukgsx6iTEt1
         hkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704804669; x=1705409469;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qROkrwZiYfF7G3qfeBpIFh1K/Mmm7qN8BCKWKeQz2Xg=;
        b=IXnpuN7+bQlyo7Z5DGv4+Ow/I1MkltebeQYC1/TWQpoz5Ity1ZQZib9+kHNA5tl4+a
         CsGCniGLQth1lOy0H74UhFMdoH4YnXhpNrKGqp4g8CjywqX/ox4eaDNy3i183RjSyFY2
         oTDWLn3zmrj6rnSuuaRkcKEDsstb9CSZ5B0iUzZ4uIxKcuIpaQEREUjMgONVyoaVZ0TJ
         sSDA59Y5xga0G5Cxregd/p/U5SUBCqL0IPUP5wfgRaE3HifOQtx1JIQ0LS9bp2dI2cDc
         YF8zWMWA/XPaUgUAHaEol+1axErPxNmZjqKkdGTI0UdfZ1mY8DJaZGW5kuq0+vNnl8Yq
         F1nA==
X-Gm-Message-State: AOJu0YySb2rwqGq9nYHj6HrZJvExyyedVrNXM3uda773H+JNKsWw3qHn
	mbq9AbS5KDr5O/G1+uRIXOx80/3yYsGGtZeWYOiCCjLuSz0iaA==
X-Google-Smtp-Source: AGHT+IH+fzv4HWsvreNV0+tSn6byYRFteteAYCO+0WhpTnneXsrnBRv9MuDla7pttJ83htiBlMzNHxSf3skPhge1yI8=
X-Received: by 2002:a25:e0ce:0:b0:dbd:572a:a106 with SMTP id
 x197-20020a25e0ce000000b00dbd572aa106mr2145429ybg.10.1704804669129; Tue, 09
 Jan 2024 04:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108201618.2798649-1-dario.binacchi@amarulasolutions.com> <20240108201618.2798649-6-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20240108201618.2798649-6-dario.binacchi@amarulasolutions.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 9 Jan 2024 13:50:58 +0100
Message-ID: <CACRpkdb73Qrs6MuiC427f=RnyD=rydH_4xVhBx-2bS8bX0mJCw@mail.gmail.com>
Subject: Re: [PATCH v5 5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

Hi Dario,

do you want me to apply patches 5,7,8 to the dri-misc
tree?

Yours,
Linus Walleij

