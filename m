Return-Path: <linux-kernel+bounces-89297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC66686EDEF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7831528406C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 01:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6F110795;
	Sat,  2 Mar 2024 01:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RFCjloGD"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2105747F
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709343945; cv=none; b=M8jti8087WYCEC4zzPDVFoY8EpjEpYoQCB0PT9TBkQGr9C3Eey2sUFh5xuSqLLZkexQzWrWu+D6SWn04N+GWTTT0ku8YKJtFWRI15E123bPluSfhdoearShctd7xdgiu+/xApnQoBvs1OMehJqiyUFCEQOSTnLTd1/Ij+3QmuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709343945; c=relaxed/simple;
	bh=UUdT4DeT5/dOQZ05jhj8UeaRSkQffyRcQJbuhlDryrg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lr0uLtLPNqvpSiCweKEpKjjr0pRGZYqLWdKx+ffoFzDeaIA62Hn9zYDeziodQFy/NGIFBr86SjoeyeBLN4zqxDCbhkzdh6PHXwtJoa/M1r2fGQynucdFMQqhvlz0esG+ZcEMsqxPWmVORCVfKUwb7s6WA/QWaDPS8PwlRKWE/LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RFCjloGD; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dcad814986so24227285ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 17:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709343942; x=1709948742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtnskPkRhYiZU7za9ryep8TQ6a4uPdl3XXtWJSoiADM=;
        b=RFCjloGDxX3x6YLBfGr7f8Bm7ofj4xhETV3TP/wmVKDaMhrVpOAk5hRpId0fSUfHyH
         FQdINvMD8NYGgsDmsVzIHa7WfBc230vvvNROXo1kzfrzyna+4T5menDaOo44/WXAhrGc
         JwciEPACBO2WRK/Aw3G6XdCKrH07OTwiMUgnT7yorjX/Q2fH1Bhm41ZbAMtYyAuu1Rwc
         WcmIfubGqXrjNmB+6Limzg6rVxErbcLOGAGy7+xwwmxK+rIhzYiJBlVC2K1akmJzz2bd
         fJFRYEIO7iHZyIVWR5mHQK6sUQOFSucckKSBLkj14vhxp5cdFJD/r/CCVRxXlMprL5Ij
         noVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709343942; x=1709948742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HtnskPkRhYiZU7za9ryep8TQ6a4uPdl3XXtWJSoiADM=;
        b=NwuEqbut3vg78nTDQN6O9qzSsdh1w/YNkYxQ7Q3z9eY1z2LECuOBayHbQGDmR2bj8L
         4rbc/qCG8eYUJ8W79722OHKQY57oEtYHfG4749xZLHxmZmgxNMTv5E86OvShVqC95cO8
         ivP82ppCMQ0CCIjCjc7Klj0jY/mb84oGv8HgEK9PyGnCAUDY9yYIP5EPi5K74hGA8Snj
         qivKczackO+EYlNQLZp2bRhiUTL0gOvuUfRDHo7LGnXzoV+SA5irnTLzyoLxafeMqRUi
         XAnVQsJoqsV25lMNddicBhtcpElwacXihf0OZNVcu/yELP4+QaAJotqPy8ig5OjxbKzY
         FE1A==
X-Forwarded-Encrypted: i=1; AJvYcCX7bZ3lDpR4oze4RHhpNVdX/EADT20d6BGaeV+Sfo2/vkne8vdrxSYUhQrSqqbiaL+Bi1q2pwbwkDg8/qgtb8eFlrxH2226gZWxXm9F
X-Gm-Message-State: AOJu0Yygue3EXDOZfdhRf3GpMGX8XRi5ZsFJoRpdV7Dd63lAyPZ84hP4
	b4bvVmsuwpiauEi5x5/1t+oKsFY8YylQHueN2wn7IYPnQ12eGX/vdSf5ld3sL44Su47EIxiYSUh
	t
X-Google-Smtp-Source: AGHT+IHSxlLixNtRgaHq6kfFYEYyEaOBDGvFg0CiI9J7Q5qF+AdJT4es86pFimCOz/DXUH+g9K8JWg==
X-Received: by 2002:a17:903:2408:b0:1dc:66ac:c34b with SMTP id e8-20020a170903240800b001dc66acc34bmr3661423plo.68.1709343942685;
        Fri, 01 Mar 2024 17:45:42 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id j5-20020a170902c3c500b001d71729ec9csm4129039plj.188.2024.03.01.17.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:45:42 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 01 Mar 2024 17:45:33 -0800
Subject: [PATCH v6 2/4] riscv: Only check online cpus for emulated accesses
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-disable_misaligned_probe_config-v6-2-612ebd69f430@rivosinc.com>
References: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
In-Reply-To: <20240301-disable_misaligned_probe_config-v6-0-612ebd69f430@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Eric Biggers <ebiggers@kernel.org>, 
 Elliot Berman <quic_eberman@quicinc.com>, Charles Lohr <lohr85@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709343937; l=929;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=UUdT4DeT5/dOQZ05jhj8UeaRSkQffyRcQJbuhlDryrg=;
 b=8PmXJ6dPykReAEr2oVdcdTdjbyNW1n+hkJwqkARm+ne05UxS/l+kJ7+aXvipYzLBMxOTOE/j/
 2410PfeOQLFDLfFBbI/C09RxasD89zBRF5GyE4tEEIgI5PD+ang1sQa
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

The unaligned access checker only sets valid values for online cpus.
Check for these values on online cpus rather than on present cpus.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 71c54b3d169d ("riscv: report misaligned accesses emulation to hwprobe")
---
 arch/riscv/kernel/traps_misaligned.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 8ded225e8c5b..c2ed4e689bf9 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -632,7 +632,7 @@ void unaligned_emulation_finish(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
-	for_each_present_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		if (per_cpu(misaligned_access_speed, cpu) !=
 					RISCV_HWPROBE_MISALIGNED_EMULATED) {
 			return;

-- 
2.43.2


