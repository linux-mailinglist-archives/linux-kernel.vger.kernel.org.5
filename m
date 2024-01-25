Return-Path: <linux-kernel+bounces-38706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E2583C460
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5605A1F2516B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6B63133;
	Thu, 25 Jan 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="My6ult1q"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE96360264
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191833; cv=none; b=H+SF7+Wrv6QA7YyZLqPWxVeeAamvZws97aypq4cSV3+bl2QRFx1L7LthNsawzpZhTz7IYwU6oFPNLLV1zSFzL4v5BudxAv3ifXYmrenn5vnsVPOQ+Rxf+aelDo0viXa01WiJ4LwQYf+uf2ELlPeake0HaSn0bFVdkhJnrBYEHP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191833; c=relaxed/simple;
	bh=GFWuoyj6kM7mp555UokZjvMLSAMuQRKEdo1HvImE3Ag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8ePyxEOYDlgriO13FzwrlRKTI7J+fWT44ElJ76DJQauG/XEHzCTRHQGaqnEgTFv4gxo+fCgCtcykaQ427R8SFevgh5LSdslm2XF1JtwQ2vdc69imJTeuCsPNLMG5S73mjRckDq6PhYEGr19MvMPWclUiggCCYn+rrgUT50t8eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=My6ult1q; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e8fec0968so86803215e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 06:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706191830; x=1706796630; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GFWuoyj6kM7mp555UokZjvMLSAMuQRKEdo1HvImE3Ag=;
        b=My6ult1qxuHJC4zQbM+ddki4s3sam6r+Z7V/qGRxai///ckiTozhu8R57mNR+nTd3w
         iEG8uM08ypE+wrOSgNdDAwUg0rqKUqLw7tWvNL/fV2ABQcLtbY+XmevQA/UacWzROHwP
         VvB+OvyiJK5UmrU/lvYkNi0ufqHpWn1rKhUS9Wk8+Yz90egnJ2v5p+SFxeLTKBUz4RpE
         iz+pAHEi+Tw5J/mTdPT0u9miPN0nykAA1KfX75vZnJugVUs1vojIQTyMSNJwVZMpWWJQ
         PcT+uql/bQTkMbEj754Z6iSi2o8JhJy+jB+L36OkS7P3Eo4X/TxdFFXFUvpAoGfMYpMG
         crVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706191830; x=1706796630;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFWuoyj6kM7mp555UokZjvMLSAMuQRKEdo1HvImE3Ag=;
        b=VAQglLuSrsto1XdqYn4kAK9anFgQcbEZ7DGN1O9slRkaoEP48+mEufT955srkxCd1Y
         RvU00AMojVp8yUmkAhlZK0f5vKzTrN3lah7jIuHUhDwBTAZdhghx2SRnxaMbUECRsCKg
         +LjHMt4RzOjTHE+OczfBBt+omf+oGuiiSgsOu4QwlHGE+Uf9+CSXfebcztrumDs2JAa/
         pQXpAZEqSDvbMka9fx80v/R6O1Hc6K5xsMcyBRRwFEUgnDlgx9sdy/KAvdSBAlgpxOXF
         KmyRU7Y/yTWU21ep4MWZ70pxQ51vnsaTlCUnq05J0hRERGLPcj4fpAufsJn0q5lvBxB7
         EWIA==
X-Gm-Message-State: AOJu0YwGHBYXGvgLIrVR/Qfj7xQSIFxnnEp38UQEB6C31In6aKhFt0Jo
	2nLJ9yMoWSAEJwq4oF0LRqC9FhoZw/xJDmPET0MSgDO+O0rjxOboZMuqceSZuxQBJKu9lK4OEpq
	gIVBACw==
X-Google-Smtp-Source: AGHT+IGRsQ095n/697hTcPYLtlxQazA8W1CfVIDPw5ka1a4U1RywC5HxBmgzKgKf82JR6cjwd/lP8g==
X-Received: by 2002:a05:600c:19c7:b0:40d:5cd2:5027 with SMTP id u7-20020a05600c19c700b0040d5cd25027mr532830wmq.61.1706191829992;
        Thu, 25 Jan 2024 06:10:29 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id t10-20020a05600c450a00b0040d8ff79fd8sm2781090wmo.7.2024.01.25.06.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 06:10:29 -0800 (PST)
Message-ID: <9a8bf6f17a0f8b4e31a6d59c1adb735823f579aa.camel@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: exynos: gs101: sysreg_peric1 needs a
 clock
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: linux-kernel@vger.kernel.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alim.akhtar@samsung.com,  peter.griffin@linaro.org
Cc: kernel-team@android.com, tudor.ambarus@linaro.org,
 willmcvicker@google.com,  daniel.lezcano@linaro.org, tglx@linutronix.de,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
Date: Thu, 25 Jan 2024 14:10:28 +0000
In-Reply-To: <20240125140139.3616119-2-andre.draszik@linaro.org>
References: <20240125140139.3616119-1-andre.draszik@linaro.org>
	 <20240125140139.3616119-2-andre.draszik@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> [PATCH v2] arm64: dts: exynos: gs101: sysreg_peric0 needs a clock

Sorry for copy/paste error in the subject :-(

I've sent an update in https://lore.kernel.org/all/20240125140644.3617587-1=
-andre.draszik@linaro.org/

Cheers,
Andre'



