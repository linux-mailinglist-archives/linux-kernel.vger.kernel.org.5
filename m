Return-Path: <linux-kernel+bounces-166335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 389C08B992D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6777E1C20E1D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE97442A;
	Thu,  2 May 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="cDDWlnqe"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8607F56B7B;
	Thu,  2 May 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714646421; cv=none; b=fGvQI5Dx4JkQvAXESQBN9Lptyrq0nWrEVUMrxRd2u2iQpzNpg6NUzxN4IPLcxZEOKkzB7Nd1nhmIqgiD0rcv93j0n5l23/UlrO6B5tGALXrxKkLKutOc6R5rqn27UEJ3BwgIdM0E/FVrj+hUZXyxu5UVIZo8ax1lN+S8ZQ7UXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714646421; c=relaxed/simple;
	bh=O+bEwrnwg4S4cWN+/eKT9QwEoL56qOFANcTDwM8x0Jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sSfd5mb+Yz7mXtg6bxss0Mge2zGvkjss+Zwei+35r2eLJpBaXvRAeV6GugB1k4lcLLjbBk5OtYulsA9fH/V23niVQpXYkpm0KMtJtvx3aENOG50rDe+cBYN2vEs6UZz/kuOet9sWxREXwPsQdqPiERbpOv2RUNvMBef31Zgyi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=cDDWlnqe; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1714646411; x=1715251211; i=j.neuschaefer@gmx.net;
	bh=mi0PezsKxlt4YHnZxxM0jZD6ggEqlUX2jNwgc7Ancas=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cDDWlnqeeZFFzxvFuSEHECtppp8V3bO4d0UkuCq3A5b73duZ4OZldbbzH0h+ta5k
	 SbW2Kj7CgMwu+w4azimZSIEq+Vi06vhkqPKgIG8Pxw4nkEg2hHqrBa0bmIVAqrT8l
	 8S58133jSf5PKlaJR5E8BhZsdbiePGT29Yt1ZGs3pOrjegow9LXg3yiRqYGoQBxDd
	 V54n9fQAnvdgFuEySX5S++5GMwWQsYwmCbpcs91ZOFCGgAxyrrvWtT8Th23H8htXf
	 RWed7gP1ZhOCUJPbWZfE4olMjlj+HbHzpbZ4pA+QXcfWpGMtz9iw1/gkm3GmPgGhH
	 YiBS7YbZr2PrVjfOcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([89.1.59.78]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1stcLN3h0p-00sxJe; Thu, 02
 May 2024 12:40:10 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Thu, 02 May 2024 12:40:02 +0200
Subject: [PATCH v12 3/6] clk: provider: Address documentation pitfall in
 struct clk_parent_data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240502-wpcm-clk-v12-3-1d065d58df07@gmx.net>
References: <20240502-wpcm-clk-v12-0-1d065d58df07@gmx.net>
In-Reply-To: <20240502-wpcm-clk-v12-0-1d065d58df07@gmx.net>
To: openbmc@lists.ozlabs.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714646407; l=1209;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=1uiYw4A/lLLh/mTtdxttn1wy5i6b5KyOE0h65+zswio=;
 b=q8eunMEY8w2HoF/7ikaMihIPI7LizlxmNI2AG/eDzXjlhl2U+uKHSEJT5Ym5KVbp87uTYyrJE
 AsUnl9akjWMChwF/fhXANkLvLIj7hWB8pZfRegYAJxtuh1LWZmKKMIZ
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:3o8FPKXfGjyk93wzOJ3/PA3/k/PDZ5csIAPUA7P5cEj1cE6h3Ft
 O8DBykUoXJLl5+vki/ykwSOk338sas9GAaDAp4a/4AVcQUSRxU2aGDTxXoc6Ui84Zc3kiNt
 NJfqgol6F557lCLuXn9wGKWqMZbYiuAPIsvZtz+vMfWByLLri5v9NKzn1qEpZjvA0ICVrna
 BlJyDfttl367Tv7+wr7Wg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rtAsOuEidkw=;ZNWcbyZHMyEKVXpZBIBuhL/i8/B
 e95tM5/mT/kG6qejGhOA9k8j4QINJtxDZf9bFnWv12BUJjIkcI3D+HdZGDbmAXLGFUqOByZuK
 trU+p1lm1TyWfZ6WSzUyM43lnvOJE4BTEuHqGqq7dMwotwRpE6EItROCIykUvm6/8Qpyvkbck
 6XLsFjPlEYtadw1g44uWWI0MXsROdRY7mEzzu2byQ8V1zq2YuPDWWMRj2p6khcMHtttkmsLp3
 G5jvBGtzpGuEsPIeam4CevcY1cHnzqpBhBoggZZlFnXCuUI8b1CCnnHHgOvYTbkVUT9ex+j1T
 jVdiGH5iKEr1GKQ7C2gimWr/Vnny84wkgLxOlE7cJKu/innA3po25mf1uRQi1BLEo26D3BfvB
 elPPat1dqFTf3BcSlZdXdV3qWMdaARZU3Q+7y8KUHc9d3iiyKNqAl6W+KAe697sbOxmFVxP5p
 YP8GAy5f3+CVMvDyxiLOGwl46mnXNmG3sF/k9qFrBNxVYNWVJzkYvvIz4hBMG+FaCpVkTJgJO
 PVGoN16Qu84/FrBPtpJF03gClgU4oJ+6wGAJtnYnhIkSxmE8SO1NGM2zBikST3G9OpHjQ0JHA
 taEQN2XluwoYFiF+aDZGSUJRgiL8zWjJ+HM+aGlviWgKYVfiUD7nKLTM71MpZuTU5YJHwqpVR
 TYfiv9cd4Q43U2FlA+ENxUD3GYLQMzKafcLStVAx/Mf7XRwswxew69TpX/wyek7Huu8PXJ7yU
 LZ6d7pHahHwMLc8+lbnofYDw3CHu+m9zOTKccJJHwRG+vedJHF6r54a+hKpJJM0xqjUcjdw9l
 Oa/tjKX7wcS/SujMgT9JfzT+WEPMTIPVHuRZLK6ffOWsA=

For some reason, I understood the description of .index to mean an index
into the list of clocks defined by the provider itself. This is not the
case, and it caused me much confusion.

Let's be a bit more explicit for those who read the documentation after me=
.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/linux/clk-provider.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 5d537d0776a11f..88bdada390c772 100644
=2D-- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -273,7 +273,9 @@ struct clk_ops {
  * @hw: parent clk_hw pointer (used for clk providers with internal clks)
  * @fw_name: parent name local to provider registering clk
  * @name: globally unique parent name (used as a fallback)
- * @index: parent index local to provider registering clk (if @fw_name ab=
sent)
+ * @index: parent index local to provider registering clk (if @fw_name ab=
sent).
+ *         Note that this is not an index into the provider's own clocks =
but
+ *         into its list of parents!
  */
 struct clk_parent_data {
 	const struct clk_hw	*hw;

=2D-
2.43.0


