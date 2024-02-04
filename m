Return-Path: <linux-kernel+bounces-51697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E571848E5A
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6531F221F0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36B422636;
	Sun,  4 Feb 2024 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="cbefjGrk"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C189225D2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056501; cv=none; b=jL8vvi4Qd4IpvPNPeLDz45MnYimCKGmkGhAS5GKUcFk13DuDojwEzSszjnNSh67ZRycyZ5aHkg0KG/w+6P/dwZJOpmGSarcZJhFJkDMhVyKKqCl5dRfh2VNJj5dWR1HO6ztC15vNrMktBg9pyP22PAOY7qgZrNH8bcDqDsAgg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056501; c=relaxed/simple;
	bh=g8Hjw0Un2UmuNrx1HKqd2DuS7J125zeqL4Rufxc+bvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAzEdpVS2jY6dnW3nfbrh7/69XSq/tBPoH3nckjeIYGa1HIm7N1t5rpVSk7dLmA7LbIFOHp5nSBMdcX+uu62/mBz0j0v7nAU3PNhOBV049vLoJt9hjODddn8JFir1BDVvnDrdeeY2fD7uMq29/9RrfM2zalY3rJT9PwiJjnGSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=cbefjGrk reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2285054a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 06:21:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707056499; x=1707661299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWCI+vqvVxBiSG/iqzOyq6BSjdvQw/1IHnThZEarm88=;
        b=Q+JT4qFEQYRrX6bAj4ZpF8diuebUgswkx4bdZYlMiRMf8nJJJGJWxyg5F5CZbGQ9yy
         XYSSnUb+1WxQMt7169bnsSPaFkA+XfcOdxuEl7tzcgb+qxngMZ31V4HZdN6kXPhZLiR1
         p3gOrDsFu10elDvj19k7r+XxrCf0ESzzmZE7ImymKybS6QgA160qCShml6GOWY28jt1P
         lZ+HAgUmpr/3dznbYnqe/NZq8JksRUVlMYFrz6ko6ubzpiAg4nkAXJdezli11Nwc1lcE
         qzKnikJmQJxH5W8TRezQGuTQSp6GDVpaAOk1ceHHmsI241gaYEXPLfy8+AxFATtyUh/V
         dIfw==
X-Gm-Message-State: AOJu0YwdD5FREs1DrxvLUCCp80cTvz0uFNs2QJ8melo+83gZ+1bZanCZ
	rw5PkOgCLU00vlQlTWEKBeNsQRmj50/2YdjcHdlNa9PdVzYdzED2E8iFB5ebkWC4bA==
X-Google-Smtp-Source: AGHT+IEskZfLj2ZTPXM2La+YvAGsynrKmLjr+vYWP4IKkXXLr7L91dtxUJHUEU0Je/Q0XcYvfcr55w==
X-Received: by 2002:a05:6a00:2314:b0:6dd:849a:d2f8 with SMTP id h20-20020a056a00231400b006dd849ad2f8mr13150112pfh.16.1707056498683;
        Sun, 04 Feb 2024 06:21:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUivQXCaPIDOria/tbG8UU+udpoEg1uo70idcJiJdt9QxcEycuIItUR+DkiVouQdX/Fx6wLa8p7qSYnKRiNBLE6tLMTdV+C2ZoTEQjpxvkIW6RoNehyZldbnkDjQiLzw3OguMomfLZ17FxLhn9dmzHs6+f9Vs5J/8Oa9w+tc4tJa+ZgCitfw5dV/kTU6uBOZ/L/Gs87IKpJRgPcb+q9VBbNYrKq+4GyBjz5v5DekEf18frvDqfLbFcG1O1m7zzV0DOx
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id r26-20020aa7845a000000b006ddc71607a7sm4844563pfn.191.2024.02.04.06.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 06:21:38 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1707056497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWCI+vqvVxBiSG/iqzOyq6BSjdvQw/1IHnThZEarm88=;
	b=cbefjGrkGnGYMopgkkwo/WkMlw3RZvKxDFRronR7XkZQkcFTEPlt289xL+EH5Z79lIvuwF
	Ijfhek0t99DqpN3Fp8aqO729fE53m8RaUuXmQj2+y4fgkJZyIFhr8wcYSPc6gg/P9wU+kl
	evfcGQNPwO7aAWre/k0Mw4pQYJdmrFlJC1VhkSmZrT+zqpqYQuypJJiTZmBHVpUOnVN3gD
	eiG0S+bG2AH4oTe8eMXR349QJWGqxSiNYj3h5TcPFZwFm/Ie4UFX5dFIYKJK5mrU/C+zON
	4XCyT+0nmdczEIVfryE5gUQnTs5Deq2voEO4qrTpjbfJe0uh2ck7hdpTnrEGFw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 04 Feb 2024 11:21:55 -0300
Subject: [PATCH 1/4] powerpc: cell: make spu_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-bus_cleanup-powerpc-v1-1-c763f0e142e9@marliere.net>
References: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
In-Reply-To: <20240204-bus_cleanup-powerpc-v1-0-c763f0e142e9@marliere.net>
To: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Geoff Levand <geoff@infradead.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=971; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=g8Hjw0Un2UmuNrx1HKqd2DuS7J125zeqL4Rufxc+bvQ=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlv52ItRdspNrLF6cpysl5pfj7tSlSrSpBs0/QI
 2LP21DjGReJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb+diAAKCRDJC4p8Y4ZY
 pg6YEACmjkpEiBCvlmFcn/tAz46rR5ZB9JK9GTxto8yThevzrnnVWpbKNlViKQkGqB4thL4uyl2
 pFle3tE7qQ3WUy/vr5rZkWd5nNQbcBlXOHo/EyXcgz1cA8PSKSG2NJqPbWMEjd0JCYqA2sxfMth
 dg+aEpmBX9Y0bjHVdBUyOPf96wyqTboDxM5oG1BNVzavQUSN2bCHgqNmD5VU9pdppb/Ma9bkiN0
 Lz4dKQUvYNGBkhYXG9QkrrwJyqTvh4qsbpper9rr/q/FmpNS8wIitlZKRJv3jq1nFX4E/qoaOMj
 R5TtttKuONMpQ0jgMeMjILLnv552lyIdDsMll/HsweuFEDXYQVf1TPc/PSAdDfj0zaHQqQHkEQ4
 WjSrNGDWjRIZ5IDOSz8XNZXZT53y+RXKTV+pYiDGXxNuVwW11U/m3Gkdny4IstvqnINARS0DBmJ
 jJcyS1/IfUf1VQT7CRrGMBKxLb8qylcqVthB9BjqGyAWJ9MWX3RkH+NjTIYjaMNE/6LDBZ1IKz/
 +tJDHzcSL5c6YfAEmmGRK0Hu4EOv8ctlNjGR0T676Z+Ajvla7j0eEVm3uk2BD2TJXcBBolAGfjq
 aEac2jYmgUOYyMW0ol8I1KQkQKFxRB5Yb2OISYjWWWZwdWRYsIag41bmjaXXoTNvWhQC9+zoNMF
 rpEVID097hbs+VA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Now that the driver core can properly handle constant struct bus_type,
move the spu_subsys variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/powerpc/platforms/cell/spu_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index dea6f0f25897..346e433d2706 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -465,7 +465,7 @@ void spu_init_channels(struct spu *spu)
 }
 EXPORT_SYMBOL_GPL(spu_init_channels);
 
-static struct bus_type spu_subsys = {
+static const struct bus_type spu_subsys = {
 	.name = "spu",
 	.dev_name = "spu",
 };

-- 
2.43.0


