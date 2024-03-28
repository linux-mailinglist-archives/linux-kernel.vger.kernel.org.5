Return-Path: <linux-kernel+bounces-122887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0EB88FF05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 836AFB219AC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A5E6AC0;
	Thu, 28 Mar 2024 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="BsbPaEIF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="GQTlax/W"
Received: from fallback19.i.mail.ru (fallback19.i.mail.ru [79.137.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA3EEAD5;
	Thu, 28 Mar 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.137.243.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629038; cv=none; b=lGdpj1fzzbbvP/gE+koga1YGmwOtoo9FotVinGVg/dKpWzch+xZ+sr14jsirpM8VGCHKgyXdbJ2CTVcIcLs6ac54ds7Os23y9tmVZU1cPipu7SqLinYuMlmKSB1FJQHGTKuOr+3qoKP7gVxS1xjWB2L+qTAoyUN1nxkQCfLDFm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629038; c=relaxed/simple;
	bh=d2zKm+/zdhfl5CA7Wg12p50NPX81IuLX9P5M5V07qnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASmC53B+w/amYP6t0eAtONlltCHsq5LIq46gM0qD3+jTr0oDLlFTogRw+82uO0wGxaiZ9W1UdMRbyHR1AjL4U8FabH7yWzKrPDMhAyQvN/0gALsGaInpj9OonZTnesjo+WFze+r8f7f6kCn1vD4kf0u0Q6wlHQW0chAtyjjgKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=BsbPaEIF; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=GQTlax/W; arc=none smtp.client-ip=79.137.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail4;
	h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=noytnkEgHrMBgSkifNJIOoTvaSHXWj7qb/La0lbVSa8=;
	t=1711629035;x=1711719035; 
	b=BsbPaEIFz5+bECWs8SVCCTPhT+CKnyi0W8Yj+XTh/PrDxT8diTxPrDgM0f/a5yzdBPSwXiwKD0piaMCWVTs3zjwJDTcbQOK3hXTeXW5FWyefQRMHp3AmYIrAs7wJc92eo0Q1qDSIXqyKYoyBaTJROpWZubIDDBdMHm5ZTOYEIEKwHh+wWrfIz/j3fGu4OwMnJj4byXUDwdWdsXTl9bYVvf+yQCSfy18DelhlloIH6qjElTnvgq3Nbj53A6ygbbHvpoVMlZBXpymAQSu43vLRbwWyxKDju007JNgucsYKImLds/XTdkY84WiU0z83DeX4U7/kZVBon/GiYrjyBHMSaA==;
Received: from [10.12.4.12] (port=60484 helo=smtp37.i.mail.ru)
	by fallback19.i.mail.ru with esmtp (envelope-from <hitechshell@mail.ru>)
	id 1rpotm-004BaG-Sv; Thu, 28 Mar 2024 15:30:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=noytnkEgHrMBgSkifNJIOoTvaSHXWj7qb/La0lbVSa8=; t=1711629026; x=1711719026; 
	b=GQTlax/WUlUKvreYpIpilNZQG+SEuDE7mRSYjU36mzgwXCSf9bTy+9n2P8E6CDetwap8fiomGNr
	/dVEel9izS7ZjTFZa+Sd7A3YZ1ZQJ5DkJwbZda7ob+2LRnWeKmeDFFqYH7xsc1kpslV1YlGBtzwZY
	G4JG3XEovhxOcmZaQgOQYcflvnZB22MQBlh0zWybCd1Mq+MoURpeDf3BdjJrGdy7OogSUZwzSI/4/
	ztkdMlK9WXWUzGo77ERV8v6O6UJhfj9JTl06hf7f/ygAuFQcqlU6lBrTbpki65pgSWs/DvVzKR9hb
	vkl8907UD56n85KWwxfePFozatY0aS/RA9qg==;
Received: by smtp37.i.mail.ru with esmtpa (envelope-from <hitechshell@mail.ru>)
	id 1rpotX-0000000DGai-2PUJ; Thu, 28 Mar 2024 15:30:12 +0300
From: Denis Burkov <hitechshell@mail.ru>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Denis Burkov <hitechshell@mail.ru>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: sunxi: Add PocketBook 614 Plus
Date: Thu, 28 Mar 2024 17:29:21 +0500
Message-ID: <20240328122922.13796-1-hitechshell@mail.ru>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D135BF24EC7C3B8444E3DC13B622D19F015FEA8AC207D635182A05F5380850402A63840BEB961A53AC8EDD30083ED68E00E5C6E5B6626015A8B9B88E922B8A017A2D8C9EC3405942
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7DECE8D0A5E25C0FCEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637260A91F4FDC58E7D8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8397BD209434C2FD34079A55C0CA41286D9E51DD46A17AEA720879F7C8C5043D14489FFFB0AA5F4BF176DF2183F8FC7C0D9442B0B5983000E8941B15DA834481FA18204E546F3947C0A6B3CD6EB70C818117882F4460429724CE54428C33FAD30A8DF7F3B2552694AC26CFBAC0749D213D2E47CDBA5A9658378DA827A17800CE749E2213E709ACCBA9FA2833FD35BB23DF004C90652538430302FCEF25BFAB3454AD6D5ED66289B5278DA827A17800CE74263BA4E959D734C7B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050FCCD848CCB6FE560C6E0066C2D8992A16C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C989FD0BDF65E50FB2E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F07E7064A143892FB57739F23D657EF2BB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5A3FC4CA38B4C887D5002B1117B3ED69635A13C70AD67BD7072305013E4AE841E823CB91A9FED034534781492E4B8EEADF12279BA039A6965C79554A2A72441328621D336A7BC284946AD531847A6065A535571D14F44ED41
X-C8649E89: 1C3962B70DF3F0ADE00A9FD3E00BEEDF77DD89D51EBB7742D3581295AF09D3DF87807E0823442EA2ED31085941D9CD0AF7F820E7B07EA4CF2FED8D253E228133A4579853B18093EED5D339A8608D31BA79F0C87B3D94BB1B2D55A8303E10F658F212F37558E72466B23EF4B855E7D156FBB8295D55DB7E6D2FC9D98A62B1050EE4FDFA4A036B0C3902C26D483E81D6BEAB6E9BFA52983102758FA77D78A604EFC3981EEBE9DB10F943082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojc7pp9Ls8Ei7l8H2zRNog5w==
X-Mailru-Sender: E694439511B4C78E046AD7819AB2A90AAEA6D0C4BD035DACA80142CFDE86685D0E1269017C50C07225C4B44B058F942BA84BA7EF1BC9F5022BA6FC9A786ED693E9ED072CBE033FA67EDB6CE9DEC428A48BCC081D9D5610F38C953235E64445F45E74CC5237D64E8BE0FA792AE8F3C4805FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B469FED0CC4E03BFC3F7F23553880BB0CD9CE392CF4222AACB049FFFDB7839CE9E088A9832E85284854D631DA7AE0EA53EA151BE2F96C1BCB112560523EEA406C6
X-7FA49CB5: 0D63561A33F958A5100E859E8D8509BCE8AD16A42E53ADCD62C50FAEE2DF9F00CACD7DF95DA8FC8BD5E8D9A59859A8B6D1CE9421EDE3BA6ACC7F00164DA146DAFE8445B8C89999728AA50765F79006379B350FA324A9139A389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8974648E02773F555F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA775ECD9A6C639B01B78DA827A17800CE791607F508E813406731C566533BA786AA5CC5B56E945C8DA
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojc7pp9Ls8Ei5uP0t6Jc2MRA==
X-Mailru-MI: 8000000000000800
X-Mras: Ok

Add a new board name.

Signed-off-by: Denis Burkov <hitechshell@mail.ru>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 09d835db6db5..43491e7f8a5e 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -774,6 +774,11 @@ properties:
           - const: pocketbook,touch-lux-3
           - const: allwinner,sun5i-a13
 
+      - description: PocketBook 614 Plus
+        items:
+          - const: pocketbook,614-plus
+          - const: allwinner,sun5i-a13
+
       - description: Point of View Protab2-IPS9
         items:
           - const: pov,protab2-ips9
-- 
2.43.2


