Return-Path: <linux-kernel+bounces-51672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05696848E1D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66911B22F8D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B33225AA;
	Sun,  4 Feb 2024 13:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="NeLnchlO"
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF022224FD
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707053993; cv=none; b=QKX897OCZyJoyOp2P7QOufeVFQxIaU/3ifeQSc2i1mJmx64TL7qAY9ZZQR4gBb4tZbeDfknFw5ETDhOYBuRQAFZSRq735mBb4/15YUPMkAW5NczX/Iy/xtVDWWHayEpYPMGic24wkIwB4bwtYHSaAPw7Gmxj4y9Ttsb6nqcqSBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707053993; c=relaxed/simple;
	bh=+WR2aLBDrX923dRpLBj8hKxMgbXa5Qh6b11Waw3A9sY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZnlAnxZzW3XbJcnUtFCPmC/woBnDO2tQW8BXmn/UqqPPWgcahYUxAlA+p9BtR6X0Lcuvq/yi2R6Ck+r2w1XlqM3HSkl34jOcDkpoNlSOgDP1kGijBJDHDFuiVfRJ3lMsrVRopmGRAgGrbi6YalLjCBYz1LnU+bqZXKyMhRgscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=NeLnchlO reason="key not found in DNS"; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-363b2cc93a8so8994985ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 05:39:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707053991; x=1707658791;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tBaWTmQT6utCl+qyfDPwlUojo2+y3dxVpluj0lh3JPk=;
        b=sC5HkKyLOmrn5Ag/yPCWn4akcLBYjJeIppf+mA8iNE0MyFYUwHRy57mFDCBV3GDEeN
         nbElJIQ/35rllwP0C0XHz24asF4OpUwlWgw0p6WzJh0MJyxdaQutkMZJ+gsr2qpslhx9
         TJkKbQqrzYAQubbqAQREQ0csqcJ88DAZtUJ5Qz5PDAIb5aiZu7Dk+JtUYPWrDQUffkVG
         QjPNPK1DpD3lcitaHv3g7Jz1XX0HcVMYFy0Lbq1IC3VMZJIYRUb4jDkBPDinTtYLFqIF
         0p02qRlrcC7qoMVyD1Tc8gnxXSgkPZdsCJmRHWk1+X6e5riosQBbzBMsdj+ThKbQmtsl
         4hFQ==
X-Gm-Message-State: AOJu0Yyh3AbJmknvfN2wr5KoEFYCpZshfhiwKAl7p817a6RsrIq92ofh
	x2QRRZtDi5Dkwu94VQ2PHoU/GSGhBRitidnqD4LgO1JNatCRHVMU
X-Google-Smtp-Source: AGHT+IEV0NfHfaIXM2vrbKYVWcWq1Zvd5rO2QM/yQngVygIaITZLjGkN9doXGkmyV/yUctSR7RrnyA==
X-Received: by 2002:a92:d188:0:b0:363:c181:ab8b with SMTP id z8-20020a92d188000000b00363c181ab8bmr3742708ilz.5.1707053990981;
        Sun, 04 Feb 2024 05:39:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVhEQTvz2DXUOVSlsvZ0mOWRZRqn8zbc1Pg7VcRoFiX1jR41UmIonHa2D9DNfVLttY8wK+i7OU/aEZ55xp06utK79Y+f5bz4Ly34Pb10GT3y+iAAWr+BGKHlJZSSh03wa9u0P5EEA1E+S/Eb3/kOKm6
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id q11-20020a63e94b000000b005d6a0b2efb3sm5074616pgj.21.2024.02.04.05.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 05:39:50 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707053989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBaWTmQT6utCl+qyfDPwlUojo2+y3dxVpluj0lh3JPk=;
	b=NeLnchlOY5Kg3xaeHUaIhAFKi5/1OT9/M3DdsMKgqaH3Bnd6MQdddQ3MEWVUXJDTVK7e/B
	5oFUa8Es5BETzUv++GudqmFwpQMyxU9ShFAluLhq0x1JhzwidNWgOfvY4QtcFztIRL80jg
	r5phw35oeEbVUUx0uJg+sEvTzXO+NU93Qic49JZ+UaXbgA7dD707BA+El6kHKnAw+3JGHG
	XM/NqQjr7KFur10GrLVAvDiJ2bMGW5ULLZFFLc4gMOz+YcVRFIFTTFJm2x0poC2IPu4tA2
	1Mcundn5emozUCXrJTSi26znhuFEJs8YqC/EtorYh4dSvQkUTOl+48/CpCshFA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 10:40:15 -0300
Subject: [PATCH 1/2] clocksource: make clocksource_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-time-v1-1-207ec18e24b8@marliere.net>
References: <20240204-bus_cleanup-time-v1-0-207ec18e24b8@marliere.net>
In-Reply-To: <20240204-bus_cleanup-time-v1-0-207ec18e24b8@marliere.net>
To: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=+WR2aLBDrX923dRpLBj8hKxMgbXa5Qh6b11Waw3A9sY=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv5PAyyq7rL/0v/yA9uoYHTejqK9ixlamJtLb6
 Br9xryZRCiJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+TwAAKCRDJC4p8Y4ZY
 pv6aD/90O6IXNFwqE1Ogx9ecJqB+bZGfxISNExVbkN9DMry1YBmGc+DSU0Xha1ebTTcP9vrsE1s
 Y0t04e2fXlqWpJhJWRgg73KbQqM0zfYAyCke0/F2OCLki8zNdei8SMWMJvGOF2nz7bJpTK2MlQG
 PqAD0F9e5rRYVeogLhU0XmBFHVcMn1lhSVJVyd+7F2NvKdy/nHAkDYQbSIihZSxFzg1rvFYxIie
 h0MDXYQCBjeh8ZHQgF/fK6vSwFWgZjpP8otc/fR0k/BDWbDMUdbLyTLt/fX2ADAvpqI1MzbWqfb
 Lvbm3b6HBQQP62uPae+I8JsMZVw5/sDhdoutSehLIioBfFk40B48Y4BDRPa+hq+OJT3HTKpPcPh
 3ia1dzfC2y7BXd3few84K6yHjeGqSDIPpMY+s8VeiQuKez364TCIeLeGfiC3UfSbIHV3gyZJ9wm
 JZGsDWDQOyKbhptImoxcfdUsnh7tkjg43z5qAm9dEuKMyLZf/gVz1YZ/B7w53XsX869Vg5tEeqj
 5ecuQ4jiwpA+G8k3eXTyCZosU1NCga6VjBcyuMuEiDSxJXksVcvAd956kcTBTbQOAdrZGI7p3o7
 Hyl1KZ3nK4l9197ufv3tcmFsMwAghDt90yirA5I2vMzDbG2EOR6iutORWK5tcUT5ocAGzvq3MX5
 lMp1EuY0SahRsQA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the clocksource_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index c108ed8a9804..4f0932f0a0f6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1445,7 +1445,7 @@ static struct attribute *clocksource_attrs[] = {
 };
 ATTRIBUTE_GROUPS(clocksource);
 
-static struct bus_type clocksource_subsys = {
+static const struct bus_type clocksource_subsys = {
 	.name = "clocksource",
 	.dev_name = "clocksource",
 };

-- 
2.43.0


