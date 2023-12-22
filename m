Return-Path: <linux-kernel+bounces-10004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B89281CE8E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FCE8B23945
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD52C1BF;
	Fri, 22 Dec 2023 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvapyu0z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9772C1AD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33677fb38a3so2082119f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703270730; x=1703875530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHNnaUGtuUDBiRbQTC4DjqH59Wm+XQsX9ZCVXhGxcmY=;
        b=tvapyu0zd7RhrORusE+A3rWTJyCjXc8VpDo5M8GU3Ta2uQL9emTJLwpQs8S4Rhr8DD
         fvp7duZRWme39SyHwsnCM8kEoySrXLGqrT4VtuQE43zl5rxrw9YGMAWouP86kY66gP0Q
         7THslqBEmyCQqVz7cNm1pRoxO5muZRA/5WmfdQnoNUG0a3CE5Oa4Jne5MmOAiUrroUy4
         z/lXJoeAUE6kq5FwZyQto0qPxK+WUXPIfCKTojduy7VOdHfTCBMW0F3eK1BkjAGs5r1I
         1ihhMetehE/ChAz+4rQ1NVYeEp6aoT56sG89kYvatsbHNV7uCweZrWtQpPYhduGBGVgD
         2HpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703270730; x=1703875530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHNnaUGtuUDBiRbQTC4DjqH59Wm+XQsX9ZCVXhGxcmY=;
        b=S8DBaTAFP8G7RcJqAwcUMFT2BR7rHXei/Vw6L9lK6oD25muq8m+u47rdv8TTQmnUpo
         gBFSvqXUO1pmVsQeURRaktHWZ5CwQzr2Cjz6JoIfuZPSgVP9nGCrnf8ZWnHm72ms0PIm
         5L9sxCoDW/dPzMvnVq8SqMw+fAbfnIHsDXpHhvmnNN5MlH5naDc6jAgTqMeXEmn3gb0c
         dq2u4dqqdD3ez9t0SKQmlmijYJYYmAaWbvz9yJYkuP6CPgR37zt79hv5n54GV5l1FNPC
         iLBbFOiHZR3/6vQEvevLdF5X2s0oSqbhco/ce7o6rBd/vNtTPP1dVOmnlNFx/adw1U2i
         xdVA==
X-Gm-Message-State: AOJu0YwUEZOSRdc9V3+oUORzIvUcvHGuc8ip8OWkmtXdt/eYBfuVYIay
	NkmFlle1o+7ftbkAjo6m4YtoAifHi8eIEA==
X-Google-Smtp-Source: AGHT+IFxOWH7S7Ji1RFEKXpbkuuAkL4Y7Hhou4FYDtY1KZnmMlrRW/vKSNPbQAZiUzUNXs73ZhrDBQ==
X-Received: by 2002:a5d:5f8e:0:b0:336:8770:ca09 with SMTP id dr14-20020a5d5f8e000000b003368770ca09mr1223228wrb.134.1703270730068;
        Fri, 22 Dec 2023 10:45:30 -0800 (PST)
Received: from linaro.org ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id w18-20020adfee52000000b0033657376b62sm4898525wro.105.2023.12.22.10.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 10:45:29 -0800 (PST)
Date: Fri, 22 Dec 2023 20:45:28 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] phy: qcom: edp: Allow eDP/DP configuring via
 set_mode op
Message-ID: <ZYXZSBQrpRnGTgKI@linaro.org>
References: <20231222-x1e80100-phy-edp-compatible-refactor-v2-0-ab5786c2359f@linaro.org>
 <d2a2762f-4565-4a0b-a99b-099dcce33268@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a2762f-4565-4a0b-a99b-099dcce33268@linaro.org>

On 23-12-22 16:02:56, Konrad Dybcio wrote:
> On 22.12.2023 14:01, Abel Vesa wrote:
> > Until now, all platform that supported both eDP and DP had different
> > compatibles for each mode. Using different compatibles for basically
> > the same IP block but for a different configuration is bad way all
> > around. There is a new compute platform from Qualcomm that supports
> > both eDP and DP with the same PHY. So instead of following the old
> > method, we should allow the mode to be configured via set_mode from
> > the controller driver.
> > 
> > The controller part will follow after we conclude the PHY part first.
> I got a bit lost between all the propositions, how are we going to
> discern the controller modes going forward?

Have a look here:
https://lore.kernel.org/all/CAA8EJpr8rKMBzcm-=HGu7-C5hPkNMrnG1cA78O00UjgJVT7p6Q@mail.gmail.com/

I currently implemented this locally, using the is-edp property.

Whatever property we will end up using for specifying the mode in the
controller mode, the set_mode op is still needed in the phy driver.

> 
> Konrad

