Return-Path: <linux-kernel+bounces-150810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481A88AA4CF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0147628365C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 21:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC615199E85;
	Thu, 18 Apr 2024 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="iD+Atqt+"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3830C16ABFF
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 21:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713476566; cv=none; b=Qn/2RglhbNKzHxMGU7vR30Z9LUWdEpHLTfhTjNGEQSfrHlKJrM01g0MG8QDGD70DhQCmEOgDlhsf9V5/2aZkL3602OSZ/miqUDMLIKpDHlrgf4vL0L4hHfEV+LWDqkAkCNSPKlK86xPiPhZ9ImpwsUzOHUocVNesAt1q9uB6OdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713476566; c=relaxed/simple;
	bh=FBpK683k7JYEQI9eGbTPDFbLYRnw6EqCPkmZKzpDDOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K7Twc/wBAMZMJwVMZWqzlfjqmPOftVv2RTOMVgEKSVnpuyKgg6C0TlUNPApTTbc5yKPBECXsi4Xsgnu9TPl/8UlNbFB7rP2ASu0Uz1+jFuA4NdMUdtyrSABeJPyN5GI1KMY0kB0AJUIjhkvw0JrPEMrnJF7RaRpoLWctNlyBXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=iD+Atqt+; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a5252e5aa01so167315566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1713476562; x=1714081362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F8H9AhxJ/q8m0xnlsamZwlhdiTxlkOEfPoe70oX2GZA=;
        b=iD+Atqt+V5cFtMo+MC+KNxSf4Ekz271PRknjiciKORNDpC46NNcf8wL/QWcrYp+eEE
         +euMKJJCugijZ9F2hmDTin280AIr4++4q5zlcXhI7YnmnK/jg93qkHtJjuzored4pu2E
         qS2Yy4SjfqkCtChJPi67fLAxgIC4Ajz6sTxTwuHxpzoFeKascLRBAVdB3H03ngF/vm1u
         BqUJ8BjsTil1+SgeWqEjDQ7WpEemXMqfT919bGMdGUKZR4ArrjPBng0eGXoQwGG326OP
         4mEJguxJuLF5IB4/PLqwN8TBGUAZzjT8as7jehBrOgu/8DJdkppbpYBRdlSgs9RKvr4y
         8V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713476562; x=1714081362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8H9AhxJ/q8m0xnlsamZwlhdiTxlkOEfPoe70oX2GZA=;
        b=pueItHcrwWwQnZPjylx+N+4Akj4TxbXhKF1yo3IEICWqRAOLTETTJ9N0QkROyko7ue
         4X8aCVG5TPQi2L66mwg+OLiRlpEYpvkVIoBngy5jdEsm4F5jEc/ajmJO2/w/R7JAXjgi
         DE0Bf0fOSGJ27lBc/IXIWwZjZcJhdyamitpW5CjZ/yU9NmVMrh9jSTomX+9q+K4OzjEr
         uaVjvmhU0XpakoL2aAbGaR9mDEDXnFsALyL+85FlBlUFDpFRBFTAsGelcKTZrjm65/ur
         ZlULkULYhmVkVpQbFEilcOsfeJRXIPClI4PmNvXVq8vzO4GSsxn9zlKgPQR5Gr3+Wfmo
         s8qA==
X-Gm-Message-State: AOJu0YxYMfQ6J3zxbiZd2/0uzmt0TiEe41PK8xSDvWu7/hulPZeg8JOK
	ZQmQ2UrOa3NwSfAgYloi6phAHyVa4q+cgvTSI9nNvidxRapKrT1hAaWHxwquKEI=
X-Google-Smtp-Source: AGHT+IEO2C+3PoxE1JaGfuZLNpLXk/+meGkVql36swKERfNfnPiPX+hs9Mp+6sm4kmlP9uKDF59hig==
X-Received: by 2002:a17:906:365b:b0:a52:67ce:c64d with SMTP id r27-20020a170906365b00b00a5267cec64dmr181994ejb.66.1713476562353;
        Thu, 18 Apr 2024 14:42:42 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id w25-20020a1709060a1900b00a4e40e48f8dsm1359539ejf.185.2024.04.18.14.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 14:42:41 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Deming Wang <wangdeming@inspur.com>
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] virt: acrn: Fix typos
Date: Thu, 18 Apr 2024 23:41:45 +0200
Message-ID: <20240418214143.1253-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- s/need/needs/
- s/No/Not/

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 samples/acrn/vm-sample.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/samples/acrn/vm-sample.c b/samples/acrn/vm-sample.c
index 704402c64ea3..c61e0f91456e 100644
--- a/samples/acrn/vm-sample.c
+++ b/samples/acrn/vm-sample.c
@@ -3,7 +3,7 @@
  * A sample program to run a User VM on the ACRN hypervisor
  *
  * This sample runs in a Service VM, which is a privileged VM of ACRN.
- * CONFIG_ACRN_HSM need to be enabled in the Service VM.
+ * CONFIG_ACRN_HSM needs to be enabled in the Service VM.
  *
  * Guest VM code in guest16.s will be executed after the VM launched.
  *
@@ -55,7 +55,7 @@ int main(int argc, char **argv)
 
 	ret = posix_memalign(&guest_memory, 4096, GUEST_MEMORY_SIZE);
 	if (ret < 0) {
-		printf("No enough memory!\n");
+		printf("Not enough memory!\n");
 		return -1;
 	}
 	hsm_fd = open("/dev/acrn_hsm", O_RDWR|O_CLOEXEC);
-- 
2.44.0


