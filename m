Return-Path: <linux-kernel+bounces-27137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A490882EB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276E5285485
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F5B125AF;
	Tue, 16 Jan 2024 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="orgSwFK+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XZ2V3GOp"
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7332E11721;
	Tue, 16 Jan 2024 08:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 4D91B3200A5B;
	Tue, 16 Jan 2024 03:46:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 16 Jan 2024 03:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1705394791; x=1705481191; bh=9H8bZXRdsz
	0qz6AEubHA5FAaHG4KuZ+c/Qt2QBb1k1k=; b=orgSwFK+O3XLft3efWV1RiBlIk
	8g+t4s4VF1GvuAJDmpD4rLXokLXUsTCf6zfcGsQ8dzvuZSGI3j5HrKGLBYw9Y0KK
	dchDAMj05jpAKeBIIaitIHZ0Od6zpSx0NHmiUEbcIZ7bwjikocBNUuSu85OD5ubx
	Nha4BN3XjE4TTXO0Qto4oMfC+4EmLiA5YdQylarxIqEoBm4pGG29X1SI3mSJgS4z
	PO8ztNnspumEjr+2HGsDq1DjCJ7J0YUBH+8WdVAnjsKuvclNCFwbOmxV1QMoMlOH
	qWMKSYo2UCqLrfWMRAgxgJkg471YLmufHRAckSt+vzR5wEutVThgy4GPP8jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705394791; x=1705481191; bh=9H8bZXRdsz0qz6AEubHA5FAaHG4K
	uZ+c/Qt2QBb1k1k=; b=XZ2V3GOptCpTKdwnYDgl6qosigBPWBzYwYUzOShy3NAm
	K3f98Qbr7i0T2l4HDXUaQdmptBsnTPo5JrkQnXuRs2f0S/8c/NUW7oQly0psST4c
	9K5YZMEuMrboqokakySuOmeZWevl12kOFc9zcVbfLvq5I66HX+i4ZNGUUe+1KmBP
	uxjHL3Ex91xXB/IbEKClGsK3NFXRkA4Uc/h/OmQgQlbbrEphktmUvW4zHroCGjXB
	WgWO0VYX33ORPXluJkLUB+d4hWvGGy0DTMXYJpWBV5u5ccX5W6wCHucXdn6FHBAz
	EDZEnlaqrcYrTr4RFHSrAwjPbGBkBWPycD+HD2Ak7A==
X-ME-Sender: <xms:ZkKmZewi8wGN4FqueMN7NUF-6qZQVC78S0avGfqZ3YPThsZ7DnNrbQ>
    <xme:ZkKmZaQCbGcXJgMxoxXZMQ37Iq4d61Q32CCdpU8GmfW6Nq-4VPft6uLrsmHZXZiwj
    6q6wKR_Ew>
X-ME-Received: <xmr:ZkKmZQXQ7LFZ9mz_wxX0EIkk-slGM6SZq1p8qss9fSixsQ_KZhSkq-NF6ExpABYwM_F6f0P00QfE9Npb90lNeFAwIY02CQHpivM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejvddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvihhmucfn
    uhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvghrnh
    epudfhtdevueejjeejffeivefgtddugeefffevudfgteetheduveetheetgfeiiedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimhesfh
    gvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:ZkKmZUh8OOSM6WndYP5E0KEY50xyXY4hnvwDFK9QVTZZIrNnTVpl8w>
    <xmx:ZkKmZQBfWSrD0Wj7v17Xcz7UpaU4KYTaR11PMK3q7t2wR6Ri3xXSdg>
    <xmx:ZkKmZVIPTmjc41Ln2Nd6bYSB1l0scw7G8bmI-MCY265HTeyhk36mtw>
    <xmx:Z0KmZU6x1Q-uzQ96JhDUiNunURO9r_-pOF7dfUdxM4LUF7nPktg3Ng>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jan 2024 03:46:25 -0500 (EST)
Received: by feathertop.org (sSMTP sendmail emulation); Tue, 16 Jan 2024 19:46:21 +1100
From: Tim Lunn <tim@feathertop.org>
To: linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: Tim Lunn <tim@feathertop.org>,
	linux-arm-kernel@lists.infradead.org,
	Chris Zhong <zyw@rock-chips.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Zhang Qing <zhangqing@rock-chips.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] dt-bindings: rockchip: Add support for rk809 audio codec
Date: Tue, 16 Jan 2024 19:46:15 +1100
Message-Id: <20240116084618.3112410-1-tim@feathertop.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rockchip RK809 shares the same audio codec as the rk817 mfd, it is also
using the same rk817_codec driver. However it is missing from the
bindings.

This series documents the audio codec properties in rockchip,rk809.yaml
bindings and updates example.


Tim Lunn (3):
  dt-bindings: rockchip: Add rk809 support for rk817 audio codec
  dt-bindings: rockchip: rk809 fix compatible string in examples
  dt-bindings: rockchip: Update rk809 example with audio codec
    properties

 .../bindings/mfd/rockchip,rk809.yaml          | 40 +++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

-- 
2.40.1


