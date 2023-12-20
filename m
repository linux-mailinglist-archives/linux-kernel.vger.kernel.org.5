Return-Path: <linux-kernel+bounces-7400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C5D81A766
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 20:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 758C4B23248
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 19:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73074879F;
	Wed, 20 Dec 2023 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Boam6K5k"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE2C48780
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28bc7155755so3594a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703101592; x=1703706392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k4QGjZ3Xml/O9jwtba7pT7aKCZcT1zSBhf7/NNKNxnk=;
        b=Boam6K5kob7RTq+5RRSeJE9m/txjm0yfseH4QtWxuG/kBtQvuZHsuCB6eUHbnM6rsl
         rInrH8xJnKVttSsXchYhMvVu9DxpII+3wzVZKAC+EEAZh/6o2QUSx1/KZQcSU9JmJHS4
         apLDL8FMYW54A4F6Cjtl6lhhllz2217aQBSwIcZ7o/5p+yoM3CSb3MtODwJx4/rwWhSt
         rTY6NWTSOz9fhfIEM1H+adWMfXfTNcPRFK0SCo2WjPWY6uVGM5Q9j12XucC1OT+JUvaC
         hSBCLGLjTihIsYAEQmNI4aVomtyqXKJh/JZTGi7pU/o7pV/pSMrUWfKnOmCKwIeClNCc
         nADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703101592; x=1703706392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4QGjZ3Xml/O9jwtba7pT7aKCZcT1zSBhf7/NNKNxnk=;
        b=t/S+bbwYdggqiWUYmHQ8jCr7A/NS0maU5J7ZTk1Y+nyw+T7cSaB+W1M5r8S69WKifN
         4sRagCmGz/RBIWQYEt5klNRgWcSoP9iFwUz5JL3ii1JrUbdD75sZXigeP+/k/xL06XSa
         o2COJUIpZ4eF1+7Isw6oTik3iSpVfoGi/UGJGjcov/+6w0XScsl1Rx+pt9hzgVPD0/e7
         6qJ3z1QcYAxtFVQBsat2+U0CdCcyjw3wSbwa0SnF76XvAQL6w7M3sFDmJZ9sCIiqRVJv
         vtlQbWneuOaenfwhYAJbpqNP6saBtX1ulKyU+ZEhVPd/IGB8Rdg6SmI3lMOXHstVLQS5
         d90w==
X-Gm-Message-State: AOJu0YyBN4JlgnwPOOLRL7LIDnWwl7AX4IVvDx1MjF9d/8TLCUv7vrKS
	1uwmJxx7uFj8Klr0y706TPzu4js04TASc1ZP5d/Teg==
X-Google-Smtp-Source: AGHT+IHtSIIccZTYDEubH9f3Tq4nZAi0RAlL6e0iTE227np10QivMMFNA91pJloJyHHKBlv6ru09s7ZfXX6JcU5qO0w=
X-Received: by 2002:a17:90a:630a:b0:285:b6cb:6ab1 with SMTP id
 e10-20020a17090a630a00b00285b6cb6ab1mr9573306pjj.28.1703101592164; Wed, 20
 Dec 2023 11:46:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219-thunderbolt-pci-patch-4-v2-1-ec2d7af45a9b@chromium.org>
 <ZYIWHjr0U08tIHOk@google.com> <CAK5fCsA0ecsWeQgV-gk=9KCkjDMcgaBj8Zh6XP8jAam-Cp0COA@mail.gmail.com>
 <ZYJFq6T3uGJVv0Nh@google.com>
In-Reply-To: <ZYJFq6T3uGJVv0Nh@google.com>
From: Esther Shimanovich <eshima@google.com>
Date: Wed, 20 Dec 2023 14:46:20 -0500
Message-ID: <CAK5fCsAAXLaXBCy_pBEaynog=xjuZNSP2b0edwrcZ_3Vo4xxCQ@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Esther Shimanovich <eshimanovich@chromium.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"

> Again, maybe PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE?

Question--- PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE is defined in
"drivers/thunderbolt/nhi.h" as opposed to "include/linux/pci_ids.h".
It seems like the ids in "drivers/thunderbolt/nhi.h" are specifically
for use within the thunderbolt driver only. Would you want me to move
it into pci_ids.h so that I could use it here? Or could I ignore this
suggestion? My personal inclination is that that would make more sense
to do in a separate refactoring patch.

