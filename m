Return-Path: <linux-kernel+bounces-2364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F43815BBA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20B41C215D4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2A2EB13;
	Sat, 16 Dec 2023 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0RqQoDK"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D60A1D557;
	Sat, 16 Dec 2023 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ce6b62746dso883535b3a.2;
        Sat, 16 Dec 2023 12:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702759107; x=1703363907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2LO6vEHv4/T1kbEpjbOJy3tLSNlB3tYBSM9vHM5WAg=;
        b=J0RqQoDKQL6DoYRCLsWYco48XSRtkkMVyMVvOVIh3FzKlgb4uB8OWFuP/devMjbgp9
         oKNXN5aLpGLd3fyfTVrnb6fqzybvpKrjUnHx565EFn4jbyEu5hPDmpIbB+H/8hReO1og
         NDCCkE40zJ80gXTC2w8wbHTixruvYjkoooSMob0jK+w7waTC8jip4+pmN+96QbGntNi4
         kvDH/VaDodG655oeUC8Y1U1gIZFBxn+i/VypxeqjT8EZpIbR9myvP44fhHUO0POvodbB
         MdcjEl8eksNg7gBig1mA/pzuNfUoNSokAhC9UEhZ77YF3znCUrzLFTUiPSN1Ty/TZNhU
         l+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702759107; x=1703363907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L2LO6vEHv4/T1kbEpjbOJy3tLSNlB3tYBSM9vHM5WAg=;
        b=TQcJ5Oiouk2jaiZiOvv6I/NEYioANUmPct/Rvn3qTAin4keweM9Z9p8B5b+hrcP+Gv
         ATXhUoPSb7w4cmQ6QYCff23Wx7BbnR+8sM1T/k2mfSKwt/LLiwQ+xXAhv8qmP2jxGBVU
         QdLXaVz7cXLXNq+3ZgkigqMQSsFXfnoqPNjLi6rKA4DlhuvLzfMfOtHWgiBXMLOibJgU
         hxaz17MaX4A1GS5MX2Y+xahHWt9uU9ZxPWGyk4DH/1zx7MluqMnUxqfBiwCGWJe+UqoA
         xPMzYOLyOzhzPNt3JMtOCwCoea2m0Qaq/lFuGYXgTHB/e8yT4xn+7LzRBgW+oXLYjXbN
         iy9Q==
X-Gm-Message-State: AOJu0YyeKpeBqoFL/b4ZbVf1Daz2bonAYBnQ4RVppZHUOcpiXkEtZyYy
	J0U+uELg5n+zclEVx5hyTA0=
X-Google-Smtp-Source: AGHT+IFxxNiLCWxmj9Sdn2ox9rHEu2kTaOtmmAmrNVA8+hOa/Gth5UnPM2qeqsYM5/wopyp2dTUdYA==
X-Received: by 2002:a05:6a20:1586:b0:18f:97c:823d with SMTP id h6-20020a056a20158600b0018f097c823dmr8436771pzj.71.1702759106746;
        Sat, 16 Dec 2023 12:38:26 -0800 (PST)
Received: from localhost.localdomain (125-229-200-221.hinet-ip.hinet.net. [125.229.200.221])
        by smtp.googlemail.com with ESMTPSA id w7-20020a1709027b8700b001d38ca8cbc2sm2976839pll.156.2023.12.16.12.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 12:38:26 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: Jes.Sorensen@gmail.com
Cc: kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com,
	Larry.Finger@lwfinger.net,
	zenmchen@gmail.com
Subject: Re: [PATCH] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU
Date: Sun, 17 Dec 2023 04:38:22 +0800
Message-ID: <20231216203822.8426-1-zenmchen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231216145655.3772-1-zenmchen@gmail.com>
References: <20231216145655.3772-1-zenmchen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

https://patchwork.kernel.org/project/linux-wireless/patch/20231216165259.5389-1-zenmchen@gmail.com/

As Larry mentioned above, I made some mistakes in my patch v2.
If this patch also has any problems, I will fix them as possible as I can, thanks.


