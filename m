Return-Path: <linux-kernel+bounces-88591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B37986E3D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DB72831B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DB53AC0C;
	Fri,  1 Mar 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMHy8/Bc"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D5EDB;
	Fri,  1 Mar 2024 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305153; cv=none; b=QNFYvvfZjCzMnt1ylPNjR+srBTPjkgExj4BPiHhZdv0XBLq5HFdZF/pJT3cYnVV5wxRF+1hyP6mn75duNTaB0TcRSBrBbtn1AXUIZZKGjS9XmdAJXxNgDgFWAWGxyNx4eMUyX7fkA6FWlvoQK1XTPtYaNNVF1wzT3L2gT8KgTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305153; c=relaxed/simple;
	bh=dMzft81as3iiP62L7QXb8pRBQ9sMEKQ4Xtd88MvJnMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFvhfjnAi+S7A1zULZwR2V43vamS2x6Pxoth3boMVgGtltERzh61KmjIIz0shGdyN3QrbMOk5K+T3xJNHaE+k8Gxq2Qt4397vbU927yQrZBwBxF7x305WgZZDtsfyEbRGmIwVyh7unLPObqx/Hjw51+msZVTHaSgsVm5+BdU4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMHy8/Bc; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so3586468a12.0;
        Fri, 01 Mar 2024 06:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709305149; x=1709909949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kLyuwERybQOj+h6jmDlpKw7bG2pgzNYOb9yDrzmQoPE=;
        b=DMHy8/BcUY4FPrTtLmY8OkqKD3NEd0FkO0KFT5bFT/Dger/klyt1aTpAFBQf43Fv56
         L24XbjhrQii5aKUEKlAuvsBI8/7cRRm0FKxFOQpiPFBUZKNFOwX8gusUL8OUK8mVWAAQ
         iO/UD1Pb0i1xnNpcwH2fbXuzsfGXtvWLLzoitzeDIZEiad8apOuNX2y6HwDah0+1yaAu
         zVklQY8ZwNQsgTP/NCAVWlvsEFo48cIUW/H5S2uPCtPID301367K89WGGFy0EV9M9ZHL
         PFR2Ib+rHEZagdgBYagnXkQqIsZAkT4HSQK/kj674jR9g8AFi0WAcJ3brMrhHtLHaFe5
         WkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709305149; x=1709909949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLyuwERybQOj+h6jmDlpKw7bG2pgzNYOb9yDrzmQoPE=;
        b=t33bdOkV+JeXAmC0fBB4JPLw2Ti3RS00pyCvOsBiXLnyXeWyGia68fFZt439ujx0Zr
         itvYxi6oKaJbzZv1c2DUVhkZQf8BK60W+gEG2VK7Uo7FMtRjCNxxK3ADCo7DaPDymArx
         iacJqMv618Qx871ngNEvE9y+6sPPlNatdTWQ0zKiiJcMmDgd+kpmokv/IyLJzzNRmUKU
         hqmaIhqJyPpSnSUaaD23LDoB/7t/MYgP4R9S/tDZRGCOXLcuPixNNx22qEU+mXrlBwOD
         rz5yXsQ89/b5xnsRUEbbMbndf+/Xj3eT48hquraxv64+/YfEdIUUdChrpQfjIupgymx7
         opAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmFeKnVZ1LdSHfKWmZU7Elk99rQhNl3Ed0qXvYoVrDdB7TLsqzUMgjdEtXn5aJY1EIIsMsA26DqaDtkjQmEwAb/a2kbysT+CCgutoN1Crgky/StYfpIj3N1zREVVPz6g8IhqQBnSq8YKoCeLbi1yZMSO9oOQJPbqS1+ucthJZucoThLg88UIe+
X-Gm-Message-State: AOJu0Yy41N+T3pD1lr++Gx1XNPxTZ8NIKhW45e3+kzfjhM34GP21uY7d
	um8X5HRtKFbq0dvrxxLDfFZfRLPwD/zlhCSriJuJ+d5RT83/kwNi
X-Google-Smtp-Source: AGHT+IFT3q4H46273R4HzZYK4jJH/VA5RfAXD3mgU1YfyMmd8So3nExlWrCbwQf+WzSRSEj1yL18ZQ==
X-Received: by 2002:a05:6402:3584:b0:566:f66d:bd38 with SMTP id y4-20020a056402358400b00566f66dbd38mr57579edc.25.1709305149486;
        Fri, 01 Mar 2024 06:59:09 -0800 (PST)
Received: from lola.. ([2a02:810d:7e40:14b0:d371:e319:5dd0:9b35])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7c492000000b005662d3418dfsm1619076edq.74.2024.03.01.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:59:09 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org
Cc: Eddie Huang <eddie.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in ARM/Mediatek RTC DRIVER
Date: Fri,  1 Mar 2024 15:59:07 +0100
Message-ID: <20240301145907.32732-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e8c0498505b0 ("dt-bindings: rtc: convert MT2717 RTC to the
json-schema") and commit aef3952ec13f ("dt-bindings: rtc: convert MT7622
RTC to the json-schema") convert rtc-mt{2712,7622}.txt to
mediatek,mt{2712,7622}-rtc.yaml, but misses to adjust the file entries in
MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
broken reference.

Repair these file entries in ARM/Mediatek RTC DRIVER.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fd658b710eb..76b6c2160a84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2377,8 +2377,8 @@ M:	Sean Wang <sean.wang@mediatek.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	Documentation/devicetree/bindings/rtc/rtc-mt2712.txt
-F:	Documentation/devicetree/bindings/rtc/rtc-mt7622.txt
+F:	Documentation/devicetree/bindings/rtc/mediatek,mt2712-rtc.yaml
+F:	Documentation/devicetree/bindings/rtc/mediatek,mt7622-rtc.yaml
 F:	drivers/rtc/rtc-mt2712.c
 F:	drivers/rtc/rtc-mt6397.c
 F:	drivers/rtc/rtc-mt7622.c
-- 
2.43.2


