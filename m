Return-Path: <linux-kernel+bounces-10183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF90181D114
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62DC7B227B7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3830ED9;
	Sat, 23 Dec 2023 01:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="f7bzhawA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508757FD
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b7fbe3db16so96464839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1703296785; x=1703901585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ctlNalyuZXM7QXcaBDfVpD88vAj0W7y83ft+PwjwWck=;
        b=f7bzhawAyaaX5gfIBT+iPC+XSjCmjMxbaQi1ulprYxHzewhqKE1w5QZUnY/TGiIDVe
         hiE7EoyHODFllp8Gy492Ywp5zJEwdP9t7bdaEHH9phCrXVzbi1Nk3iggDKXWAKYAzGVz
         qVyEnxwAklTjxHG8wdO9rZFcVHMc1v5tpY/yMH7NUkEA17eBWVjzlhK9mwKdI1kgb+uM
         n1AQPubptdzJjNMizK8V2NU0QuoLkxqQ5/9jhOOrl3IPbKREj8dQuhsha1YlegvoOwUq
         VTbYdoAQVe/gjMkjPRysQrQOiqTImkOjFmqoUQdMLKjsDckOKQwe5y8HwwecbABv1luB
         JGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296785; x=1703901585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctlNalyuZXM7QXcaBDfVpD88vAj0W7y83ft+PwjwWck=;
        b=mmKnWoZzTM8PAJvkdT3xNaltU4TV9A+9oHXKLrJJp3TAjpkuJ95tslnjg4riYlhu9r
         Kwy6tBTqn/RlhKxB5Vbrk2c/t+4jwIPA362Gf9Iko2pgllN5cvQgDa+H53oRx7jdnfQ6
         QYVp7gM2pkoOr3yPmlOl/Idni8XAEkPPNmGeoKdKInZy4XZZ35XfKzQSpY82tWC2Vz6w
         WOxJ+uVJ22u2zuLxKglE0W09cuksv7jJQ9AH+JOAn73pBJGLXjxUVCEgX0ujR6zyXOp1
         o8H6wbhQD5Q4HGf27sEpPGOZF4dLBr7f5qqgHihxSi8xTqjVirymsb9tNNEQzJ6jcqiF
         uB4g==
X-Gm-Message-State: AOJu0YyCnjqZk8utyIiO4rhBk9LSLFQzP0F6C9f2BzeK9Q3/TQjtO8U7
	lqB5v8uXCoNsRolxVN1kCz2sqyhqD9qSOg==
X-Google-Smtp-Source: AGHT+IF5iZbH+XBKyq6KWJhJMJ6yH+JHGBoWYXlam+kXP2sbUznmPLw6x/MoYYUYHORJ9LOwfLUcRg==
X-Received: by 2002:a05:6e02:17cc:b0:35f:e2e3:803d with SMTP id z12-20020a056e0217cc00b0035fe2e3803dmr2117785ilu.2.1703296785388;
        Fri, 22 Dec 2023 17:59:45 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kg15-20020a170903060f00b001d3edef115dsm4106546plb.20.2023.12.22.17.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:59:45 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 00/20] Staging: rtl8192e: Various checkpatch fixes related to rtllib_softmac.c 
Date: Fri, 22 Dec 2023 17:59:22 -0800
Message-Id: <20231223015942.418263-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes various small checkpatch warnings and checks.
Thank you in advance to reviewers.
regards,
Tree 

Tree Davies (20):
  Staging: rtl8192e: Remove unnecessary braces from
    MgntQuery_MgntFrameTxRate()
  Staging: rtl8192e: Remove unnecessary parenthesis in
    rtllib_softmac_new_net()
  Staging: rtl8192e: Remove unnecessary parenthesis in
    rtllib_association_req()
  Staging: rtl8192e: Remove unnecessary parenthesis in
    rtllib_rx_assoc_resp()
  Staging: rtl8192e: Remove unnecessary parenthesis in
    rtllib_ap_sec_type()
  Staging: rtl8192e: Remove unnecessary parenthesis in
    rtllib_association_req()
  Staging: rtl8192e: Fixup multiple assinment in init_mgmt_queue()
  Staging: rtl8192e: Fix statement broken across 2 lines in
    rtllib_rx_assoc_resp()
  Staging: rtl8192e: Fix function definition broken across multiple
    lines
  Staging: rtl8192e: Fixup statement broken across 2 lines in
    rtllib_softmac_xmit()
  Staging: rtl8192e: Fixup statement broken across 2 lines in
    rtllib_softmac_new_net()
  Staging: rtl8192e: Rename function rtllib_MFIE_Brate()
  Staging: rtl8192e: Rename function rtllib_MFIE_Grate()
  Staging: rtl8192e: Rename function rtllib_WMM_Info()
  Staging: rtl8192e: Rename function rtllib_TURBO_Info()
  Staging: rtl8192e: Rename variable QueryRate
  Staging: rtl8192e: Rename variable BasicRate
  Staging: rtl8192e: Rename variable skb_waitQ
  Staging: rtl8192e: Rename variable bInitState
  Staging: rtl8192e: Rename function rtllib_DisableNetMonitorMode()

 .../staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c |  4 +-
 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  6 +-
 drivers/staging/rtl8192e/rtllib.h             |  6 +-
 drivers/staging/rtl8192e/rtllib_softmac.c     | 90 +++++++++----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  2 +-
 6 files changed, 52 insertions(+), 58 deletions(-)

-- 
2.39.2


