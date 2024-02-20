Return-Path: <linux-kernel+bounces-72897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD4E85BA54
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E60E1C221A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D491867E85;
	Tue, 20 Feb 2024 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s9nrO5Y/"
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D730664D9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428102; cv=none; b=ShL1UsBGE0ov1CjMqCau/KBsONRGCUz7tD+mMREnjJrlB7dDwSLmLdPiz1w8Crw/ZdH2XuB4HTxu8DV4yNC4n9/Rns2Or3GlnacwNsD37vqQ6wEBJM0CvTQ0ujR3SdQEMMIfaGv3aOtN414zisz+dbEWyqfM1yg9CHOhqwcZJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428102; c=relaxed/simple;
	bh=INHQvRB/ojgLL1jJyHv4kt04JhA8r1SShwN3sZfPsZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=RVw4A9KWOOPJmap8J3nfsBjOZn50lIdnWtYWGUJtmjFtwMxdhvoq7EA/5NHU6hy/ruKI7d8+5VLnKHNCw/0eSlV8JNSUUFNTJgddCRpIOkwb38Quv2rUiVIil1/ZDpCRfyTiV7rZOh/UvDPpDUGiykdw1Q9u9A/pSEOxWjyLHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=s9nrO5Y/; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240220112138epoutp014e1a62ae0652fc2ebd460999fae0d76b~1jk3JEODR2828228282epoutp01f
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:21:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240220112138epoutp014e1a62ae0652fc2ebd460999fae0d76b~1jk3JEODR2828228282epoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1708428098;
	bh=9fGAvkkWp12wfZXJbzbavv2ZwQH5uBgyjHpo2ixsD5g=;
	h=From:To:Cc:Subject:Date:References:From;
	b=s9nrO5Y/2+9rMxzcwO8lBRBvPHPBIM4ouJ72/qRImVKjFySSrIQpgghQQcKSogBEG
	 fUweX6u8ppsM01TrPotpPf4ou8a8vJQStDRecYXQ7ai67mGZpf+/zp7fozxuusgIIa
	 wsfkGdBEWurXdqw72A2V24O8iKSUDyKJOT1uquKw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240220112138epcas5p2f6ce1ff37994ee8c17b9d478d645c430~1jk24n3rP2571225712epcas5p2a;
	Tue, 20 Feb 2024 11:21:38 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TfH6S2xGcz4x9Pv; Tue, 20 Feb
	2024 11:21:36 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8E.F3.09672.04B84D56; Tue, 20 Feb 2024 20:21:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240220101235epcas5p16db3f82c8db1efd32299c48c875cdc87~1iokWVZc32498224982epcas5p1u;
	Tue, 20 Feb 2024 10:12:35 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240220101235epsmtrp15a637026f007baa6d501581fbe3dc121~1iokVk8672766527665epsmtrp1D;
	Tue, 20 Feb 2024 10:12:35 +0000 (GMT)
X-AuditID: b6c32a4b-60bfd700000025c8-0e-65d48b404943
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	92.43.07368.21B74D56; Tue, 20 Feb 2024 19:12:34 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
	[107.109.115.53]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240220101233epsmtip2b9ecc58a6460c97f07645740b25e1462~1iojAi0Ht1920319203epsmtip2I;
	Tue, 20 Feb 2024 10:12:33 +0000 (GMT)
From: Tamseel Shams <m.shams@samsung.com>
To: alim.akhtar@samsung.com, krzysztof.kozlowski+dt@linaro.org,
	gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Tamseel Shams
	<m.shams@samsung.com>
Subject: [PATCH v3] serial: samsung: honor fifosize from dts at first
Date: Tue, 20 Feb 2024 15:42:27 +0530
Message-Id: <20240220101227.80741-1-m.shams@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHKsWRmVeSWpSXmKPExsWy7bCmhq5D95VUg+W/BSwezNvGZtG8eD2b
	xbu5MhZ9Lx4yW2x6fI3V4vKuOWwWM87vY7I4s7iX3eJu62J2B06PTas62TzuXNvD5rF/7hp2
	j81L6j36tqxi9Pi8SS6ALSrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8x
	N9VWycUnQNctMwfoJiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFp
	XrpeXmqJlaGBgZEpUGFCdsbrX/wFxwUqTs+fwtLA+J63i5GTQ0LARGLNusfsXYxcHEICuxkl
	pk9bBeV8YpRYdO40I4TzjVFi68XzLDAts49MgkrsZZS4eXojVEsrk8TqE9OYuhg5ONgENCWO
	n+cGMUUEiiQaP/OClDALbGCUeNCzAaxEWMBVYvUCGZCZLAKqEn92dzKC2LwCFhKTW26yQ+yS
	l1i94QAzSK+EwCF2iUXXrrJBJFwkFv94A1UkLPHq+BYoW0riZX8blJ0uMfdhLxOEXSCxbNd3
	qLi9xIErc1hAbmAGOnP9Ln2IsKzE1FPrwMqZBfgken8/gWrlldgxD8ZWlPi/ux9qjLjEuxVT
	WCFsD4kVcyaAnSYkECtxtOct6wRG2VkIGxYwMq5ilEwtKM5NTy02LTDOSy2HR1Nyfu4mRnBC
	0/LewfjowQe9Q4xMHIyHGCU4mJVEeFnKr6QK8aYkVlalFuXHF5XmpBYfYjQFhtlEZinR5Hxg
	Ss0riTc0sTQwMTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaPiYNTqoFJK2TH3UT2k1V6
	Gsm7fs38E7LI89QGm+9S4u+nPzwcvHuW38pzzO7vvULEe47zHw6f7lF6UCbW3W55Tmyi3AXF
	9+ud74TUb9S8/c1Rf3tniZXH8U9Ffam13/5EXbK4duqgnq/fss0rymdnW9pVyLitfeAxm6u8
	SJwzY9/jyyeqzvopiEdfcCsydbx3d7LSYdd/T+0DTjF91Xf5N4HncN7tzFVqWd+ty9yPBOnw
	/bkY5/HiiVHRUttn8y9WCPVvNlrFaPhbR6H4bBDzOZMFOyK36IuzqQmqXuksbFxnxqH+8Wz4
	pK+2u90TXS3lXuYeZjrae+vZ56RVL55u0rnSwv5E6eTjk6vUTnhPM/Y8dj5JiaU4I9FQi7mo
	OBEAl1tpjfEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupiluLIzCtJLcpLzFFi42LZdlhJXleo+kqqwfW5lhYP5m1js2hevJ7N
	4t1cGYu+Fw+ZLTY9vsZqcXnXHDaLGef3MVmcWdzLbnG3dTG7A6fHplWdbB53ru1h89g/dw27
	x+Yl9R59W1YxenzeJBfAFsVlk5Kak1mWWqRvl8CV8foXf8FxgYrT86ewNDC+5+1i5OSQEDCR
	mH1kEmMXIxeHkMBuRomeL4fZIBLiEtN+7WeEsIUlVv57zg5R1Mwk8WPrReYuRg4ONgFNiePn
	uUFqRATKJHZ132cFqWEW2MIoce7/X3aQGmEBV4nVC2RAalgEVCX+7O4Em8krYCExueUmO8R8
	eYnVGw4wT2DkWcDIsIpRMrWgODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzi4tDR2MN6b/0/v
	ECMTB+MhRgkOZiURXpbyK6lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQ1nzE4REkhPLEnNTk0t
	SC2CyTJxcEo1MG2co3V12dY8A4/3bicYZxfdETAwEZ44zVEkWmgO34umyIAsUeFZx+M62Uw+
	8FpVMSy8XLbHO9Ha7dm8tMytmfUvJ/BEpLc68s75YWf+yjJEPHvCtlNmls9u9Yf9/vNn/e5r
	XnJM8ozR0pdMeZ8H2kov7ZrS9/65UEagxv61FW8/d+UYXjzLJRiue7PhjV4t8xmBCb1f2ZLV
	ts5z/rXxy8QNS17JlN2XTeNakZ4bGjBtJfscNs2//7fWy2i4hxX3mSzR4ZvdflCBzSax313j
	neHCqR7NrO2XAsq3htTHWXUrTdYQ+dDW+XLZ9bKkDSkfkhdFZco8DHk2+fd+i8kc3GWBS5+1
	/coQePVt7qOvSizFGYmGWsxFxYkATQEMn50CAAA=
X-CMS-MailID: 20240220101235epcas5p16db3f82c8db1efd32299c48c875cdc87
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240220101235epcas5p16db3f82c8db1efd32299c48c875cdc87
References: <CGME20240220101235epcas5p16db3f82c8db1efd32299c48c875cdc87@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Currently for platforms which passes UART fifosize from DT gets
override by local driver structure "s3c24xx_serial_drv_data",
which is not intended. Change the code to honor fifosize from
device tree at first.

Signed-off-by: Tamseel Shams <m.shams@samsung.com>
---
Change Log:
v1 -> v2:
Acknowledged Krzysztof's comments
Initialized "ret" variable

v2 -> v3:
intoduced new variable "fifosize_prop" to handle
return value from call of "of_property_read_u32"

 drivers/tty/serial/samsung_tty.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 71d17d804fda..745702ec8eda 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1952,7 +1952,7 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	struct s3c24xx_uart_port *ourport;
 	int index = probe_index;
-	int ret, prop = 0;
+	int ret, prop = 0, fifosize_prop = 1;
 
 	if (np) {
 		ret = of_alias_get_id(np, "serial");
@@ -1990,8 +1990,8 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 	}
 
 	if (np) {
-		of_property_read_u32(np,
-			"samsung,uart-fifosize", &ourport->port.fifosize);
+		fifosize_prop = of_property_read_u32(np, "samsung,uart-fifosize",
+				&ourport->port.fifosize);
 
 		if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
 			switch (prop) {
@@ -2009,10 +2009,13 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (ourport->drv_data->fifosize[index])
-		ourport->port.fifosize = ourport->drv_data->fifosize[index];
-	else if (ourport->info->fifosize)
-		ourport->port.fifosize = ourport->info->fifosize;
+	if (fifosize_prop) {
+		if (ourport->drv_data->fifosize[index])
+			ourport->port.fifosize = ourport->drv_data->fifosize[index];
+		else if (ourport->info->fifosize)
+			ourport->port.fifosize = ourport->info->fifosize;
+	}
+
 	ourport->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SAMSUNG_CONSOLE);
 
 	/*
-- 
2.17.1


