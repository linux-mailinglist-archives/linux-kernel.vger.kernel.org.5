Return-Path: <linux-kernel+bounces-107062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA4587F718
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 07:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526EA1F22400
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51FA4C3D0;
	Tue, 19 Mar 2024 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIWys34m"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00B340871;
	Tue, 19 Mar 2024 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828421; cv=none; b=JSau1KpDFL/PFl5U9b66r4nGNA5XCc2gutHQSjd0QD3p8kJdjMEDY5SqIJCSOrOJDE1IyQOuXO0m+pzddZxY7HtHT4aEAuJQ+cD2NFY97nQDabOVQ5GQA4fM5xzCQfoSFtUSnVJBjJ3iwDhmSWZAC3ZUwCs5OWEGf2it3X+q+Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828421; c=relaxed/simple;
	bh=/7//9IvK644zKbbWFR+2Mg8EQuaMO1xLAgjlV0hPrGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FMt0T6sdx33v1UctYXTrLxac67iuxYakuoqguhk+7Q37+hral4csKhucdylYEOI9TfDr0GOAJL5BkivAehaTfqGgmq9Xp4un9w2q+R9+lVu7jku8bO7Xj+WOjhB1XHSDDjhEeYLwcUKyJ2AGGA+ttej0lWDL9wGV2akGEF319sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIWys34m; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29e0229d6b5so2575401a91.3;
        Mon, 18 Mar 2024 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710828419; x=1711433219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tREO4d8RmiNtsd+whKdi4MR0BBPbIXQPPfzk16lCgjE=;
        b=WIWys34mbSyj+Y/iUxiChHFBFxNQvOEXNty2HmqjEmQ4PLfYBSVdkbAoKObk+B6wew
         jifWN99WNBmtJAGVvfPdLzP5eWHfDTbqGefl8Kwp8/8OstFEVA61WJXz/mIufsqnm0w5
         4O+v9U9oXNqT3GOj38gTbssCTL6GTWINNMi9XlDZW44aJW2ibBbORffzKESaOzKF4usJ
         SFA0OkspyuwtCMRtpOJ0eenUEmWS48iJMPQDZELECsOFbkJHHfqqxhXJ61LXmqK9SzSO
         L5KmDXxKgu5KaZCVQvFtB6KqzuqPn8OZDolWiaiJe2yTA/YLv84OthHrkbOO4Z4EuYrq
         F6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710828419; x=1711433219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tREO4d8RmiNtsd+whKdi4MR0BBPbIXQPPfzk16lCgjE=;
        b=ScxIhAvxBqb4ZAz65z77+PnGGbetNX5R/J0G/mIEmivE/bLyzLEP15dXp6GT/mUgmm
         77Z1mvlnPWd4YKcP3FXyT1KEfudyMGn0trnPVac7m5WrqN3bxy5ylj9cw/j7zJk/ybRd
         QJ0/0KfIO870uXG/w5VhodFmz0sfaH6jTYPG3eUShyBicNaP+tZ8puyvkUqY4weY/sh/
         zm/421uA9riu8jC+/O72B9dm3+Jo5zs8sGm3cNjY8Aql5gPzBiwIhSByqNSmDkmHnPHi
         9zPBZUuiio6CSWS6K1U88D5kF1i5zrMnJF9AvSyRmp6Uc4CXnxbnaqTh2I22Et5cSsgp
         dT/A==
X-Forwarded-Encrypted: i=1; AJvYcCXLc9vKyIDLmhyslctSKy0h6W8fPdVKWkL0E2Vcvzu1uphXRe0pKVhwaMEpJLeTjuiFSCqEzBnLoSBdL3KCzu2sszuMKlLoYGnFnqhy
X-Gm-Message-State: AOJu0Yz6M8sJzsVwUhmB5tU5FEXc5HST9fwB06YFVciBr1CvthQ+MVVU
	Hh+ZoBzpzvP3TL4NkJLCqrWt/NptKJNoC9HOn5VXNYK9ALAKWx98QyNrYEYt
X-Google-Smtp-Source: AGHT+IH187ljG8QdZPrNOqG+UAbYRdtcWoMKe+UDZx9PIRwBTWm+C1MuVXwFjzCmoA4pTNn/2wG5pg==
X-Received: by 2002:a17:90a:17e4:b0:29d:e004:f8ce with SMTP id q91-20020a17090a17e400b0029de004f8cemr12421175pja.6.1710828418589;
        Mon, 18 Mar 2024 23:06:58 -0700 (PDT)
Received: from archlinux.srmu.edu.in ([103.4.221.252])
        by smtp.gmail.com with ESMTPSA id ee12-20020a17090afc4c00b0029ade1f7abasm8747004pjb.4.2024.03.18.23.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 23:06:58 -0700 (PDT)
From: Anshul Dalal <anshulusr@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anshul Dalal <anshulusr@gmail.com>,
	jic23@kernel.org,
	ciprian.hegbeli@analog.com,
	marcelo.schmitt@analog.com,
	dragos.bogdan@analog.com
Subject: iio: GSoC 2024: RFC on AD7294-2 driver proposal
Date: Tue, 19 Mar 2024 11:35:27 +0530
Message-ID: <20240319060528.1238089-1-anshulusr@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello everyone,

I am Anshul Dalal, a pre-final year student at SRMIST (India). I am
pursuing my Bachelor's in Computer Science and Engineering and wish to
participate in GSoC 2024 as part of The Linux Foundation under the IIO
worksgroup.

Following the suggestion from the IIO GSoC page[1], I would like to work
on a driver for AD7294-2. I am interested in the device since it offers
a wide array of functionality that is different from my past IIO
drivers[2]. I have prepared a draft proposal and would like to get early
feedback:
https://docs.google.com/document/d/1zf9yDq2-Ba8Vqh10w1cYI3buHzh0qIYwzf7xBkaEzDM

I'm aware of interest in the same device from other contributors[3]. If
required, I'm ready to work on any other part suggested by the company
or the IIO community.

Best regards,
Anshul

---

[1]: https://wiki.linuxfoundation.org/gsoc/2024-gsoc-iio-driver
[2]: Microchip MCP4821 DAC:
     https://lore.kernel.org/lkml/20231220151954.154595-1-anshulusr@gmail.com/
     LiteOn LTR390 light sensor:
     https://lore.kernel.org/lkml/20231208102211.413019-1-anshulusr@gmail.com/
     Aosong AGS02MA air quality sensor:
     https://lore.kernel.org/lkml/20231215162312.143568-1-anshulusr@gmail.com/
[3]: https://lore.kernel.org/linux-iio/20240229184636.13368-1-danascape@gmail.com/
     https://lore.kernel.org/linux-iio/YlXR0d7waKW9xncd@fedora/

