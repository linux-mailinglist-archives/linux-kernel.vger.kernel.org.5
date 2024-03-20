Return-Path: <linux-kernel+bounces-109322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0948881791
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED3F81C216C1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AD985282;
	Wed, 20 Mar 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGemrQyk"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706585266
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960836; cv=none; b=Qd5p7tr6G41b6M/r9VfQdeSSVCOFETs/bked9KrqeRgZQl/RyZm8pycToPG/gtd1CDo4yfhsIK7cEeY8L/nR5xnWp4jRoAMds2Xp/Y6fAyGCr3BDJixUs2cnem8JVIoK/XzEVHG5fu7fkvEu+QEScm54sS8/lyYpcSeQVwohr0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960836; c=relaxed/simple;
	bh=kw71mCENFfkusz3NYvP2M2wcfPXvnkvuAeHbdxEATAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jKZGaeZU6ladwZiBrRHuhwSgdalxZkTrSID7LBT3srrcFhzMUpp8P/gOG4gkykwL17RfBuyn1MJ96gv0LpaSWdfZW5P4tODJ8yzQzKCXUGc3xsuPzh8L2Y7KJSentEcUDtxbTI3rt+FcGq5WZ98vFsuEJ9WS9zHQSxCf/wNk5ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGemrQyk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dedb92e540so1748835ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710960834; x=1711565634; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHo/UtzvItXgAnni/T063+9rKoFbdcxo9Fv9o/bsTdo=;
        b=PGemrQykUNRWK3o3XlMij/Qk2vx2edqoCl8vsjQqLkGrObk99r5VqSmd85ZjGLnh5+
         RDVtONXG2nYnB8uDjsx+kKTRExOfVPDbbBXo+G6dDTTe5FQAoGUaSaUZRJclEsBeIkPV
         0g8YddU+kNYFPne4mYQE8seuY6g2rOdCmhj1ukYq8nkasaoTdyt8cWx/N0Vau950QFuz
         QA9JRBPu6qafXkRMaZtAgjW/oc98nTuEXIKv9DS4qMBRwl0k38nxpMmHtnHJDTCPvDx2
         2AVfef6TXcf936Gad0uwF12XSCzKOuLkWHS0stqmcEpJVm3+wOZ/N4we8sliBhacksPF
         RlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710960834; x=1711565634;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHo/UtzvItXgAnni/T063+9rKoFbdcxo9Fv9o/bsTdo=;
        b=gYiNP7GvCSKjb8C4UeXo4gM2r51nT82RYAEX3MvWpySm20ovFefNzMYb6htyRmNoHF
         dNz6AdnaTjZF9YTij4U7k3EAIdMQotOuUHiWl8ZXdQYrZzc9TU0vHgRMGsLk7AhmOAe+
         Is0BWLzQiY2Y/df/CT2U9gbK6S5ePQG6JW9z4g+xxH0sZ0zcAXCfAF+gsUafREWkqdJs
         eseHSRm2cAqffa90qTP41H1tGoSEFXZiE0tS9AQEa1HmzIITtkmAFjubI00hCifktaON
         TtJtHBWnspSCEOXCKigno4zIwG0RzFiI+b8uchDyWC5YsABXLZVQFzn7/QXkRCyELMdA
         0WeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbz6hlJo7655llOHsDRMBg4e5EoVLTBKNnf0PihGfWKgkZOITx2eWSY/eE5FBHuJnXqks5P6nA1MQqXbFC6+1c2p5/z0b7zRr4c9sJ
X-Gm-Message-State: AOJu0YysYPDAQplbgT7d9R6Gme2WXSYzB7iOlB0lkEls4CEu/y4Fohue
	Sm49F5RMvvg6HW8IK5IeW8cYfRuH8DcJo654ZlVwd3l9NOZnv9YH
X-Google-Smtp-Source: AGHT+IE58EF9+Se+w6BvmnOU4rIe52sGQR9jSmwBLL+Nawk6f/WI8phqZOSc0KVO39scQH2DD9odxA==
X-Received: by 2002:a17:902:a3c4:b0:1df:f859:91b6 with SMTP id q4-20020a170902a3c400b001dff85991b6mr511149plb.34.1710960834450;
        Wed, 20 Mar 2024 11:53:54 -0700 (PDT)
Received: from ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx ([103.6.158.67])
        by smtp.gmail.com with ESMTPSA id y17-20020a170903011100b001db5b39635dsm13901559plc.277.2024.03.20.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:53:54 -0700 (PDT)
Date: Thu, 21 Mar 2024 00:23:50 +0530
From: Ayush Tiwari <ayushtiw0110@gmail.com>
To: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8712: Change type of local variable
Message-ID: <Zfnt4pIljgM21/BA@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Change data type of local variable blnPending from u8 to bool since it
only assumes 0 or 1 values.

Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
---
 drivers/staging/rtl8712/rtl8712_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl8712_cmd.c b/drivers/staging/rtl8712/rtl8712_cmd.c
index bb7db96ed821..32d9927981aa 100644
--- a/drivers/staging/rtl8712/rtl8712_cmd.c
+++ b/drivers/staging/rtl8712/rtl8712_cmd.c
@@ -284,7 +284,7 @@ int r8712_cmd_thread(void *context)
 		pcmd = cmd_hdl_filter(padapter, pcmd);
 		if (pcmd) { /* if pcmd != NULL, cmd will be handled by f/w */
 			struct dvobj_priv *pdvobj = &padapter->dvobjpriv;
-			u8 blnPending = 0;
+			bool blnPending = 0;
 			u16 cmdcode = pcmd->cmdcode;
 
 			pcmdpriv->cmd_issued_cnt++;
-- 
2.40.1


