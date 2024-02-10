Return-Path: <linux-kernel+bounces-60166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B578500F7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DC21F2599F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2BA652;
	Sat, 10 Feb 2024 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="kiqiJiie"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967736B
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707523633; cv=none; b=ros2k3qOxsym5Sph9RZRzuqG5Lmqr/JfC9Hw0aL8fE04EUbKjzx28PC5sZujs+3nUGg5RXyJIvs4SDoebDrhOZ76onSkJIUlwC+gg/3Ddsg9KJo6QeGCDNDJK6tiDBr2AD+a9fCBlCzyRxzwPm/XqKzpBwseDyV+KrL4WZdTDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707523633; c=relaxed/simple;
	bh=uPAkjkhNnUn2eErVPCyjQ/ycs8iGMX/5VT620BWcpNU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y819wfuq2LnIoh8liijeQGBmvLHWAsL7VO82U+SGHOAs+XsdeT/JepDsYL10UMWiHbw1zu7l9rAjJWjh4eAo1WYwWKhIVYkIM7fOXJE0UpgCVy8eFKPMiTaVpKD/Qh+/Y0f3pBg3jRJiH7B0X6LIUp/oQ1IH5Xt/7hNjvh1tEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=kiqiJiie; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d958e0d73dso11522465ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 16:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707523632; x=1708128432;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jJ/8P9/m1QyzSqfdTbTrwPfsfjkC4DETPIKZtr1GOEA=;
        b=JwLFRu+8VNyqgN1aG6/8IY0NUB8fVEv0JBi2WCWgQfie1ggRe/B2gl0PAE0B0urB9+
         XNhQ41PyEcVkvZFM67gJyXZPi7F6/vtB3N9/odTLZl+fwq69QRfU/qLCYOPB9cqIk9JI
         2AMo91EuOfg4fBM9TV/HG6owKeKuiTBNQmlb61wXFd/5hIKR/r1urFuZYafG74H0cXmj
         c4tpgfOGrzvE1jmADRaYEnemRZkG4ut1bLapd8aVZfp5OCYbDEpNKBhqcrk+CyKS6dKZ
         +TWZW8t/VryrGGU0Qb+J9rKur8ZB5+b5smLwOLMU2A6wHGZf87UnOVuAkQV7x0sFMX4k
         2XFA==
X-Forwarded-Encrypted: i=1; AJvYcCVySm+JIZyEm2N0bAy0Drs/bYnPbjYn1gvqGPW/AjYAShY4m1GkgNcXq0smWy1pgx1xOA6PMxPGgqU/905WnCYjDaizvXt6GCvO1AnA
X-Gm-Message-State: AOJu0YxJsdnOP2R038Mr/bx3St1GK7TToqyy2q3n9jTaw7/lVxaxr4sA
	bma0AmG2XQUJrayQ2oxd3XB5NtMlIedSfdt5kKAgywv841mNJIVp
X-Google-Smtp-Source: AGHT+IEQFw7ZjdLNXEsWU9/4iuzrZmSGZEl5ZmXh1Y5PhENIs7gG/v0xu+B16lGfQq/q6TBJYO7Ozg==
X-Received: by 2002:a17:903:1d2:b0:1d9:4143:5fe1 with SMTP id e18-20020a17090301d200b001d941435fe1mr1175352plh.0.1707523631576;
        Fri, 09 Feb 2024 16:07:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV9fHoG6i7/iyW1eWfe2TY57fmSS9yKawaYHI57R1vdvze3bmBsPhhBmHyX2YOOaOgvuFlFyz5t+8RUjx5bZZVMih12O+TtyBlucDPCANLblqbBg2TFw167PYpM0rDr8AMbB/mQvxlXBeDWNL3zWy0/7yLuXj92bJvEguFA+vQAgKFY7divGfzIsDz1/PA2zMNjiiKxMUTMqBtki3urLC67VTEsBfdzd39AUcDdhDoQr2fRk+X2+qBJiGg6OL7kgok3K/Xr6DBj9qCnsflk
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902d4c300b001d987771271sm2018287plg.123.2024.02.09.16.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 16:07:10 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707523629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jJ/8P9/m1QyzSqfdTbTrwPfsfjkC4DETPIKZtr1GOEA=;
	b=kiqiJiieBWKVrASvW4zc52ozJYSCAbgBrO7DkPZE61NKY75+NZL3B9Zmi/mlGOAqLYlSK3
	0PiBQKOgwHpVSeGTzd7Elo6eBxOLGEMMU+kxWF0vIO24CVEXPGrrkIDSXqL1EqW+WqFOGy
	RXJ0wsgATetDWf0xEoCE+VpAlKMjs8lADGtDQHYw1yWhH/+5qxNisPoSn4OYS89wwclBdE
	8uvlP2krTz3+ufIKtavYwZNY1fdlar/Q2JWndsVehid7jJB/tNY1yQsYcc5KLbcwVEiSrC
	/08B/I8pKiGgaPCLCEGAJuLvTEu/I6oNmCPk23ksYOdMeQkPwLWNvSnefS1+nQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/4] powerpc: struct bus_type cleanup
Date: Fri, 09 Feb 2024 21:07:15 -0300
Message-Id: <20240209-bus_cleanup-powerpc2-v1-0-79a56dcaebb1@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADO+xmUC/x3MTQqAIBBA4avErBNskMiuEhE5TTUQJko/EN09a
 fkt3nsgcRRO0BYPRD4lye4zqrIAWke/sJIpG1Cj0aitckcaaOPRH0GF/eIYCJWxjcF6JnK2gZy
 GyLPc/7br3/cD8Lc1fWYAAAA=
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=uPAkjkhNnUn2eErVPCyjQ/ycs8iGMX/5VT620BWcpNU=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlxr5P2MxlFZPof0FmplPWNVsPWX2aQt9io6fB+
 A+IM40f+kyJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZca+TwAKCRDJC4p8Y4ZY
 plBbD/9xpcNb6D4WFKz+2DQ36EYnVeiGJjexUsSCvOrYiNyZi20rCkGtKLIRwDvw0BciZeeGcEE
 GrtiCvNkYZBYC8c56HH1YsO8zDbTR9gVDan+Tfog/wgO4Ntqk8Vw89YBZed013otm6ZtNB+tBLL
 b4cGZY1nANGa58Xpr1pkfIDwanhCbnbtxU9HBkPMGAgq/8FogzTPhKYGAI6YDxvUVFa2TRgv6Ea
 NoHMyouCaxOIfEa/lDNRKH6Z5LrN7sCcFZRNCO8swkVZR2IvXQWou1F0u74haz2MOIJD+WSyb6v
 1gUbeAx9aufVtuoOyeoIQk0eQ8NBqTWXgIxqcn0BlyoX0R/Y92pg6r14pr+8B7Rv4MHWWAUmhuB
 dkNuqtkPWvBGBG5V7kszXBF81PMLCWWGwIUzrx92QX4mURyZUtpqXnD5NJl3ILq+FOzqE4YaB2G
 rESrBg5d4evKxUOjVkvsbgZoz3Sa/TPxvx84rTlPVON2R1Yx+3MDoI5BGWnhCN+qwbO8FoWbF1x
 5ibJvs1x74HxlZvYsUbAP4TYQuPGNKY022lIQvEE9mRJVPw4+oMd8ycZ4QcKuT0VnymEcBuJko/
 O1QMaVGply37KuU3gQRt8MXHOPIO5x9GUZ3lkr53K3l+fJt8oS1KedHP4Zx1dUYu8J5y+omUtBA
 UJaYOMrjZBl7ruA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]). Patch 1/4 is a prerequisite to 2/4, but the others have
no dependency. They were built using bootlin's without warnings using
powerpc64le-power8--glibc--stable-2023.11-1 toolchain.

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (4):
      powerpc: vio: move device attributes into a new ifdef
      powerpc: vio: make vio_bus_type const
      powerpc: mpic: make mpic_subsys const
      powerpc: ibmebus: make ibmebus_bus_type const

 arch/powerpc/include/asm/ibmebus.h       |  2 +-
 arch/powerpc/include/asm/mpic.h          |  2 +-
 arch/powerpc/include/asm/vio.h           |  2 +-
 arch/powerpc/platforms/pseries/ibmebus.c |  2 +-
 arch/powerpc/platforms/pseries/vio.c     | 61 ++++++++++++++++++--------------
 arch/powerpc/sysdev/mpic.c               |  2 +-
 6 files changed, 40 insertions(+), 31 deletions(-)
---
base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
change-id: 20240209-bus_cleanup-powerpc2-498426fccb98

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


