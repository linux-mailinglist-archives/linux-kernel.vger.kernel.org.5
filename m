Return-Path: <linux-kernel+bounces-93339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EA6872E43
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC1ED28B393
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5935D1AAA5;
	Wed,  6 Mar 2024 05:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjwCZWNu"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5517741
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709702294; cv=none; b=pyOEhmC6DpJFU4tqYuNv8OlAIVHMi4jfUPZKdB6nluc3bKVID3lJFqYCB0YoPryZ7NHqzWRpSyMoA4jArkQrgVNN6JoH1pb59fxQmZohkYfeykKKSblJPNYX5wZxiKZlzVBWAr+XCvSD8pegiZ4fl/orVUzcqSfYdZNIEUTmeg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709702294; c=relaxed/simple;
	bh=W9xcAnBJ5x0edv4L8/LlSaUoUncPmyKmnbp0d6UuMDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGfJsyTFIW0u/UX5LLTRlcKHTwpPXJ1ZagLz5uTI1WsAk5dTVcfwDxD4b7U4RnhYX+QUmxO5lu5k+lBTOlmhNg3ABBTQvsl6veaRzf5OEfBAQOhF8Jf38Bskff+j/lngxgo+kyPRjiF344Ri9HIwGdwf16YlvvrD/aIIzZtjU8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vjwCZWNu; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6e61851dbaeso2057277b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 21:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709702292; x=1710307092; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vQ/WgqvK1Ci/ne6ulin8lmOr2tFPfPFW34owF2nS4yI=;
        b=vjwCZWNuPH/KlBmRjXU540yj8bycPHypzGLSZPNziqvU+8g8ccZ1/xUgIKK3sCW3pS
         jH3IaBtARPRRgIWveztFAXoib36/gSBPcItPgsftPv9i+bptTMhgH/syHfWHIfxN9OAo
         5zzodEWIe1lE8fp5ps4b9cw9Ep95er9YbpuQJS67jtIZIJuG6Rg/9ywNqNYSbe/zFuKy
         hPw0k4fvLQriwdmNdQ7uT56RbpMroP6tmo+avwmypXy8TzSl/q9XMlAsGl9TFfwcKOh1
         al9eCzLPghF6kwfcO66Tz9RwdW1C3Mu64o+B6NfnxKrBfRra7ZEr+za7/EmiQX/xd6Uq
         mLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709702292; x=1710307092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQ/WgqvK1Ci/ne6ulin8lmOr2tFPfPFW34owF2nS4yI=;
        b=J6xr9sIFMDhGA4Ywo+qiYhodRX17TdlLVSVpoyJGRg2ZB5gQjjTTkmTMkwoI9/WwmK
         m+6YwvHJ3nRcwmNbuBIrfon43qRC+JXezvDZeqxlTJFf/0dylomR+lZzq54ZLmKE/EQN
         KwBOxMzD34b4A60x7tgUZr4EAz+uEssk8XJrfqYR0WN8Nkk3wFkrjgcFA0YIFaRLqlAu
         YX2jtnaK3312UOVrKXnMPN/wesj42hDuAWziAYXrD35e8vqehQ1kNkO3S/iu+wlPpKYl
         i/xdhOaG+DL1qF49H4An/DilOczXXCI26qBMJabWgo1PzW8u97ISXCe5isGzuAYtKRlu
         gATQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTEKVYi/9Aq3UCrZn9fV7GE6k+aCStepqYrlOLhrjwJ3fZa4uKlT8TA373krWDWiDxwb2bcQG8BCIuaFREn787uhgowKFcHRSrxi0O
X-Gm-Message-State: AOJu0Yw764g9E2zwW0e59Y6dJ/xsNhLhaDA6aUtKRhAd/MzKCG+uxTIm
	f/NRbD7GF+PjT0wKkaFTi1Qk7KZ88cPkzwLegCdQJceX63eDkxmyqygsUzYH1dE=
X-Google-Smtp-Source: AGHT+IEC0Jim+2WiKJtC/woXkiOJB/InsQ4y2/FAI9UWOw6q1UH+5rkyx5WoD5BFD7VIQiYPl9LlSQ==
X-Received: by 2002:a05:6a00:2183:b0:6e4:d201:a39a with SMTP id h3-20020a056a00218300b006e4d201a39amr13664121pfi.22.1709702292297;
        Tue, 05 Mar 2024 21:18:12 -0800 (PST)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id z1-20020a62d101000000b006e5db93342asm7199839pfg.208.2024.03.05.21.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 21:18:11 -0800 (PST)
Date: Wed, 6 Mar 2024 10:48:09 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 3/3] cpufreq: qcom-nvmem: add support for IPQ5321
Message-ID: <20240306051809.rk4xhl47zai7um3n@vireshk-i7>
References: <20240228-ipq5321-sku-support-v1-0-14e4d4715f4b@quicinc.com>
 <20240228-ipq5321-sku-support-v1-3-14e4d4715f4b@quicinc.com>
 <20240304071222.cx3s37mphddk23bv@vireshk-i7>
 <20240305043503.tgy5ahl243or7lm5@vireshk-i7>
 <c82e4053-4cef-4010-a734-4dc537574201@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c82e4053-4cef-4010-a734-4dc537574201@quicinc.com>

Bjorn,

On 06-03-24, 10:10, Kathiravan Thirumoorthy wrote:
> patch 1/3 and 2/3 are already has the R-b and A-b tags. But typically those
> patches will go via qcom tree. Do you want to pick it via your tree? Sorry,
> I'm not sure on this...

Should I pick all the patches ?

-- 
viresh

