Return-Path: <linux-kernel+bounces-2287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B37815A8A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B1228599A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D330CE3;
	Sat, 16 Dec 2023 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lAhDslOy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1509A30357;
	Sat, 16 Dec 2023 16:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso1403092a12.0;
        Sat, 16 Dec 2023 08:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702745909; x=1703350709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0OEMB3r5xVAiMPcaeFSYag9LYwQiHdes4TT0FG2G0E=;
        b=lAhDslOy6Lf2pBCPJG/RJqn6L15jZ6VKANB0muEgkvtXGvkM6jzrRAoKwr2EYUlWl4
         KTY4IFlcX7+sY/lH6uBVbinO6jYUe4+LRTTMVeKYE2PF4cJm1/is1ew3thOpDO9Ttd9Y
         CfSIzNVnlrFr+gJVGvyT841aHVpQNX/7qMpTgipcaPAM4ErIcN5khQP4mzTUzPX+PsBw
         55BmovWG5wDnQQ3Vdwj3EqAe8maGEr3SgZ/1UXUyn3AfoOUap1aNTYfK8hXuUdiA/qSE
         nCpG0KXBry/ePl4F9Sh1cJL1+gqgd+8sdAGC0wuNFETZMyUcAwer65j16dgk2Ajd2zBk
         sdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702745909; x=1703350709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0OEMB3r5xVAiMPcaeFSYag9LYwQiHdes4TT0FG2G0E=;
        b=WwIL/2+ffSLILsOZaeimoPGdSoscWVBDCDQfxG3PZqWD57zMJi2RzzRqUzRTzfpTD/
         nNuN77U6QGPYoWsmRSkwai7IU6MxaF4zeeGacc75HKjlkR3t4i2Fgdje+Hby+pCZtzBx
         jex4+QjMLwafozKT9jJuqfM9cVeRn1yNDZQy8OAMwbnLOciocXsYlEcVnHxySHlQDw2j
         jT0eRAATy/S/PP0Qi4rFhGSiCVXqaQPnv9LFtyPwfYx3IzNDRgq3sO5EEw50Q9M69cpM
         y8gEkmXVpnBfUHg0n7zP3cshlgoHOJvPu65/8cK7IZeMKq4wuOSHm6O7+RzfAwLA0AgQ
         1fRw==
X-Gm-Message-State: AOJu0YykYtLPTlvZsAF9Jwg4LiRljV//hzpGLxDAYOegw6z8EAypzAak
	7gwrFefHnHOGWFIFKh3b22yzPr1Fi62frUGn
X-Google-Smtp-Source: AGHT+IG7IoA2fnirYvJoXHfoKktiKmaLtcjaIjSZFHphKYKy8WmNLcKE6VYsX53NqNGD9oOeM4X3lw==
X-Received: by 2002:a05:6a21:6d86:b0:18b:8475:410a with SMTP id wl6-20020a056a216d8600b0018b8475410amr17660331pzb.7.1702745909143;
        Sat, 16 Dec 2023 08:58:29 -0800 (PST)
Received: from localhost.localdomain (1-170-85-161.dynamic-ip.hinet.net. [1.170.85.161])
        by smtp.googlemail.com with ESMTPSA id m2-20020a635802000000b005b6c1972c99sm14956919pgb.7.2023.12.16.08.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 08:58:28 -0800 (PST)
From: Zenm Chen <zenmchen@gmail.com>
To: zenmchen@gmail.com
Cc: Jes.Sorensen@gmail.com,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	pkshih@realtek.com,
	rtl8821cerfe2@gmail.com
Subject: [PATCH] wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices
Date: Sun, 17 Dec 2023 00:58:25 +0800
Message-ID: <20231216165825.5438-1-zenmchen@gmail.com>
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

Sorry, please drop this patch.

