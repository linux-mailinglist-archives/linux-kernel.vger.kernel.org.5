Return-Path: <linux-kernel+bounces-134553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDAD89B2F2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC701F226CE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 16:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5243B2A6;
	Sun,  7 Apr 2024 16:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ylgD4jQi"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0807222EE5;
	Sun,  7 Apr 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507408; cv=none; b=gVg3YZqR7QVXmnGNHraqs2GiaG6HoJHD97eCbKvedo0efHdh4j9Oo8C1rV2fRcMwbuiEC3axd2NAY0Xsj9d8lD4dDEJ2JGiXXdmvqbAZDvDRRZR9q3rpze2/61L5nBDESzQIaf5mNcZtg1zOaQOgus2K4cwb0MW9AJipHjqHJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507408; c=relaxed/simple;
	bh=N+hdJ/K/367z9AduiEVjZAfGxfY8hfBNcT/rU+ctJoA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=QtcwPFZSdrB3ZV/cDSsq4FaXGESWhiWsNZLrSR3Itw5sxJILFx+sVpmjsP2EJjQfK/I5dWPrWCmeRxkcCPy9DM8tbo+dx9fu1fZFZYnvGdFY6ss99D0TE7b/ldT7hLiK6xL0i81aGLj/qPzmm3fDCwP6gxzs3HIrsuRTyYj1QBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ylgD4jQi; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712507395; bh=rcU9GmGkfYObnRvy+6sIXXI4nFg1KITAK23jcYZUxzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ylgD4jQi6pgyFF6q9bIq8RlPRSoDqOZV2mt5gT65tMJ4iF1CEJAwzQ4L/PrGMJoMy
	 q5j9q6JFx7Ay0rin3Ni1Vbp5srHY44AIQXyevdV/OePTRKAy4Gcp+vsYVkS+81ocTv
	 pV0v/lm6VBA+eFdB2dKkUiYJD1UoiQSvRXv8A0rU=
Received: from cyy-pc.lan ([240e:379:225a:6d00:f878:7a6f:5832:7f4d])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 726A94B5; Mon, 08 Apr 2024 00:28:38 +0800
X-QQ-mid: xmsmtpt1712507323t1fs8ch17
Message-ID: <tencent_CBA62384BD9191CF4FF0407BD17118B73605@qq.com>
X-QQ-XMAILINFO: OakVxA/3u/8R12L76aW4bi3wLSBBjKGo+MGgTo8NYImiAKoZmXjzk+W6r1Qy0H
	 kyMBROiT1RxVk8iEgN5L7Tlfb38tDH0mDfv9aH402v9A/kSN90FNKStOaXt456WeMEqrPDRa/hBz
	 LiprRh4MSPNBxxPxtB6sG5W1JLxzhNTYyCb3g17mJunw4k8zAREtjKY2TFV3DGpi732HnPunD/MU
	 MOar/ks4AePCm2X40YCxP1H7RyUYf9e0ffDGr4IEINGkLyJ3AR5fhRAkLibTU5/EqnyEK5TZRQjd
	 QJvth/J9pD70ykbmSp00G7uNXxW8DEeL1ef+p9Yp2he8ulxKtGdZOv7WazVVri4YkgEWt9FzJg3Z
	 inn2C+RZtvxbd8RClpEp7obd3mFlKf+mM3iZIIP7Ebk46Ww/O0kOF9fV+MVXTKRxsed4zOM13GIi
	 wSS20ubsX9krBjqX3E1bcmk1BNDkhfJ1Ovg1Lotk3YdjPi9DRQ3lD7BCS2M/ZD456jJu3fMSUan3
	 /RSwq4j/6rgKH0nRJgRHJ57u7K1FY5BuEW0lCj0nObLadSA2NU5v+TIymOXRe23w46xyXNDd0hMd
	 vkWMh/FjRxkWHLXYu+9r69oNcdk1VHAufbK7TRNCpsBH3sX7HEItJBl64Yds2OYhDPLHmgBA9oGX
	 MACG3Mi/BeaWrRMVOhSQKhTdKXbHSxggJ9AL5awAwKJJ3iDeZ17AlIvXPqeXkBOgKBaqxtNO6Wxy
	 BaVBGJQR0Rx5JwgDxdbvBnZC5TB4oGq0LZcmqkxvYsE4OySf/tnE+V0ks8j35Ucf3E9KF7K4SO9E
	 FhMO1bQojG0arbQIG+HK6kpyzhDV9eHQBxPGWRe/kxWOemKkwxGRbTgiUS2OK9BWm31wTFH19AEV
	 FVLizEfz8gzNjqOJKh3zG2F1Vxml47SHi8V0bTpcxfbvugKkQFpsbUMId9i9+o2mp1+jlLWSpUdK
	 6eFVml2pFdSKYutBo7jR29G06FZzv/GrgCEhONMOZQlwNu0EAuFJ9GE0PdxgXbOQAA0N0fUw5rd8
	 /FBbbDE1vcTzzjDRPzkT8BQWP30ePC8BK37cYMKAiKERAnEHNFqT/scTL3Xu4=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v8 3/6] dt-bindings: timer: Add Canaan K230 CLINT
Date: Mon,  8 Apr 2024 00:28:32 +0800
X-OQ-MSGID: <20240407162835.3199788-3-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
References: <tencent_22BA0425B4DF1CA1713B62E4423C1BFBF809@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for Canaan K230 CLINT.

Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guo Ren <guoren@kernel.org>
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index fced6f2d8ecb..06c67f20ad3c 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -38,6 +38,7 @@ properties:
       - items:
           - enum:
               - allwinner,sun20i-d1-clint
+              - canaan,k230-clint
               - sophgo,cv1800b-clint
               - sophgo,cv1812h-clint
               - thead,th1520-clint
-- 
2.43.0


