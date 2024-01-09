Return-Path: <linux-kernel+bounces-21036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 799838288DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 16:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A5AB1F24D07
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95A239FDA;
	Tue,  9 Jan 2024 15:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NcDQdF9l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7E039FC1
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704813662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=vn1ce8hywqQSUdzE/tq3PAQDOHuc7M+muFOo7RqI5C0=;
	b=NcDQdF9l8+9zIF96irLq9TVr9K4MG+GNybtjRs3eSA6O7uXu7A3nkBXZvMJ1r/5IOGWcqF
	lwXopGYW6TLi/DIEmMO0yEFHnp2PpI0+yPxxfhkrb01f/UJk5PZLgQdLhuFj/H5WblgAhM
	5+fuk+Tngzzicz+mf55CR3qL3mclhg4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-NRbeGThqMJuyX5xv38JAEg-1; Tue, 09 Jan 2024 10:21:01 -0500
X-MC-Unique: NRbeGThqMJuyX5xv38JAEg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-78330275051so60720085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 07:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704813661; x=1705418461;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vn1ce8hywqQSUdzE/tq3PAQDOHuc7M+muFOo7RqI5C0=;
        b=El20zD/qpxK9lL48iq830NdxwNlKEsTiUPLZ56xndNyegD2m6Q6H6edifB1WWiBks8
         qfXTOaKHX/v7zmLoB1xeNjmE8dxp8F8+Sew8TTt9/hk94axV2EiNTpF5EtVtJP8Z9SU/
         8IcrLY3/A+eafzlEzHmLGML6Rwgh9drJqAByDjRWOFge9yLEeQz/VyGcAqVYVP6dNNwy
         /3ZO0Wn0tCM9JDbymeevfYdwVS0vtyhK1g5eyz16drs4SfYocSaWlkLYIHRw0HJSNSPw
         CZNssRRmSZ29cKpeMSVUx//z1OXyy2wHlrOppoui0LLqo7OwmuvIrrfJN5w6va2D/ILv
         d06Q==
X-Gm-Message-State: AOJu0Yxf/AMpMpzdTOS9465ZULQq/E+Wz0JmDleyJ/6c3PdnGFYESLgQ
	zzJm67Ssxa3KisEMco+lCSErEmmnb2c0MemasS3QOKpf4nFpX40GBAMb4rmiBMVM9uB1YEvA7rM
	GgSoe0+2MrqGpK3m8WpklEFb4UM4+rIHl
X-Received: by 2002:a05:620a:4008:b0:783:314c:48c4 with SMTP id h8-20020a05620a400800b00783314c48c4mr605886qko.96.1704813660942;
        Tue, 09 Jan 2024 07:21:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEn8hS9/EPAk99SwHPz6Ctm7qGK+fZo5cmWdV36DyjYJZKlNIvEBawV15ZkWLFEopPcYMNuVQ==
X-Received: by 2002:a05:620a:4008:b0:783:314c:48c4 with SMTP id h8-20020a05620a400800b00783314c48c4mr605875qko.96.1704813660554;
        Tue, 09 Jan 2024 07:21:00 -0800 (PST)
Received: from fedora ([174.91.39.234])
        by smtp.gmail.com with ESMTPSA id h2-20020a05620a13e200b007832016a732sm874832qkl.83.2024.01.09.07.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 07:21:00 -0800 (PST)
Date: Tue, 9 Jan 2024 10:20:50 -0500
From: Lucas Karpinski <lkarpins@redhat.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sa8540p-ride: disable pcie2a node
Message-ID: <qcoqksikfvdqxk6stezbzc7l2br37ccgqswztzqejmhrkhbrwt@ta4npsm35mqk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20231103

pcie2a and pcie3a both cause interrupt storms to occur. However, when
both are enabled simultaneously, the two combined interrupt storms will
lead to rcu stalls. Red Hat is the only company still using this board
and since we still need pcie3a, just disable pcie2a.

Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
---
v2:
- don't remove the entire pcie2a node, just set status to disabled.
- update commit message.

 arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index b04f72ec097c..177b9dad6ff7 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -376,14 +376,14 @@ &pcie2a {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie2a_default>;
 
-	status = "okay";
+	status = "disabled";
 };
 
 &pcie2a_phy {
 	vdda-phy-supply = <&vreg_l11a>;
 	vdda-pll-supply = <&vreg_l3a>;
 
-	status = "okay";
+	status = "disabled";
 };
 
 &pcie3a {
-- 
2.43.0


