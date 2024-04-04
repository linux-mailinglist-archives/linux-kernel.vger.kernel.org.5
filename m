Return-Path: <linux-kernel+bounces-131769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 397B3898B9D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36551F2A834
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EF412AAD7;
	Thu,  4 Apr 2024 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4er2kLl"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6E112A176;
	Thu,  4 Apr 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246043; cv=none; b=IE8S5vhD/O9Ps8wH9Jha0CRnM3+/QBaND6j7DTeXb6j+C//+fXpKe0tr/Negy9/BTavilYZUzZfSV7iG3qppsTBAOJQI2+Nq4NpCM0XkWF9m/cVcSLcIK6mtPUxlk2Zlw5XXLw18qfAvMWc1VA0q968NZhJgLO/k/HYZxdeJG+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246043; c=relaxed/simple;
	bh=/3m8tbMTKbpp8DczNbgjKG86CcVoJKTX6w3QpC6Pclo=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=JXmDH7PyHbcENDOKLg8chVDeoArGCOKBQrm2147ss80pKLVHbuYvQjjaY1O2pllgMBc52k0wFp8xTp1w5xXwdst/JrbLdTPNt9L5xVi3mQh/bk7oeCAn9lNHGy+MrhlY/nav1GuraWX4zc/BT8BMazjal1cm+f7vsXau+7WdHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4er2kLl; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3436b096690so1778443f8f.1;
        Thu, 04 Apr 2024 08:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712246040; x=1712850840; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/3m8tbMTKbpp8DczNbgjKG86CcVoJKTX6w3QpC6Pclo=;
        b=W4er2kLloJj/DzIgKX0jHW1xdpJ/eacb1AxxhiMYZQvio9s/G6qSVO3eWdcf9YXLo/
         JN4QjJJYLs38vWs3Rv9nVf6QpSCdx5YHWQEJd8zujj/O6OZOeOsPFm8NxuFp+pa44SxM
         VtkcGeamNA08hQ2q3LxVNVowYm7NPhNjqeulrNNPaZolDs+PhgtLMzuZa1fiIclrLXzQ
         Z8DU2oj4eI5h3TCznehBcT9z9dlWqH+CA9XUz0jT58jayf9v/R3nte1ceAIjwgO26L8y
         Y5nI7QebxwRGw2dhdLAWnHTDD3vzX3YaDbsQgJFmfBHRzjtXk5OIaM4bBWfJk3YBHgUo
         vQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712246040; x=1712850840;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3m8tbMTKbpp8DczNbgjKG86CcVoJKTX6w3QpC6Pclo=;
        b=EWv9YS7PBMd1YhiHxRuvcQf7UMLmdhxfr6NA/eG7ZTU2hkAVXwS0VQNgrD/FUxkPou
         ZYczpzw4xOlPZ9h+oEHP0dAZHpRqfhKd7XTNbtclBfZlouaBBepwnCXJkkymaRALHdAq
         SwvViDPu3rBtgXn7IU+L0JyolA3M6wvbsvJM7oZmPhQJtxvSuk5eQ+hTjAI+EI/G7s0w
         wBByjecKtQmh19mOb+2yujTAGMVCi3aCxqJuEtg7d8qIb84oUehbJAlNyx7gTLZl3R/F
         +poQihHdVXA/wZzR7WVqn9ZVINGB3ZVsAGlWmUewUKVf6axsD+eC4S5lI0BZ1T218zsx
         ZPLA==
X-Forwarded-Encrypted: i=1; AJvYcCUXfX1EhRPASVCzLmWH6nFvf29nwkiJeX1SeUWFBC4U2OpfQ91eYnJNDs/TMz/PKHvdrrOuShifgfQ2BZfFELZkOncibSwz5VembY7e
X-Gm-Message-State: AOJu0YyIAgOhKmsF+QflwclCmbM8Qj1MUQj6qg00Atm5DoexTn2krqxD
	q7oU+VATkwqrRnfeTszh4Pdid5DewfqN9kEFJ0jQzxDCQeKVx8A0RhzNLnEzw3E=
X-Google-Smtp-Source: AGHT+IHVFPGEZrCTsk92L3eJtuYBge9oeCNt9BZBgO+gIRZfLUwK7t6faaFK5b1/SpqxVj9fbL6r3w==
X-Received: by 2002:a05:6000:4f1:b0:343:6c07:c816 with SMTP id cr17-20020a05600004f100b003436c07c816mr3091423wrb.16.1712246040329;
        Thu, 04 Apr 2024 08:54:00 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:7d3e:f9e7:30e2:91a5? ([2001:8a0:e622:f700:7d3e:f9e7:30e2:91a5])
        by smtp.gmail.com with ESMTPSA id by7-20020a056000098700b0033ec94c6277sm20590586wrb.115.2024.04.04.08.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 08:54:00 -0700 (PDT)
Message-ID: <fccbb040330a706a4f7b34875db1d896a0bf81c8.camel@gmail.com>
Subject: iMX8M Mini suspend/resume hanging on imx8m_blk_ctrl_power_on()
From: vitor <ivitro@gmail.com>
To: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ivitro@gmail.com, vitor.soares@toradex.com, ulf.hansson@linaro.org, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, rafael@kernel.org, geert+renesas@glider.be,
 peng.fan@nxp.com,  linus.walleij@linaro.org,
 u.kleine-koenig@pengutronix.de, marex@denx.de
Date: Thu, 04 Apr 2024 16:53:58 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Greetings,

I'm trying to suspend/resume our Verdin iMX8M Mini with VPU IP using
the latest 6.9.0-rc2 Kernel. While the system can suspend without
issues, it hangs on the resume routine. After some investigation, I can
see the Kernel hanging on imx8m_blk_ctrl_power_on()[1] while resuming
the hantro-vpu power domain.

Any hint about that?

[1]https://elixir.bootlin.com/linux/v6.9-rc2/source/drivers/pmdomain/imx/im=
x8m-blk-ctrl.c#L101


