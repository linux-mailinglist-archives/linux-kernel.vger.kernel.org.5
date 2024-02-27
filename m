Return-Path: <linux-kernel+bounces-83136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA6868F52
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FB82857A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFD713A25B;
	Tue, 27 Feb 2024 11:40:40 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A669013959F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034040; cv=none; b=n+2Bd69sm2omJINIETmRdawE9ufnLrpG82dOlYC2WAz237+GdPh2q6yNO4Mx6bmBAcGxJDkJ3autoJfbf7s2acDOt7HmD7DfGx2znxNk7ailZKRdKZsSMgS3pnrNuyBRJu+OAvMF8wAXkJpDnTMqmVP7OvbiXKquIBg4KUz1HRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034040; c=relaxed/simple;
	bh=M5OIGe53Z10wsg0iatzI+PuT/64yRjhhDV4t5H8Ah0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XvGU7FyH/pvM7pQEofHiRsozrMgMuhe/FHY5Mur8Up1IFTdGmA3CSZoiwQ4gA3qT2qEAERP9R1ENXbZEvCQ8EIaq3oz2Wa4R2SRHdK9Y3qt345b3JYP3d7fR9tFn8ZvUDWs1en22tKovwyPRaZsUs/o2LoIFn+UuBY+YZrTQ2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so5442784a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:40:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709034037; x=1709638837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0S9qYynRstG9CaIGMdCakOzvIOQn30B+EbyDmdBKEk0=;
        b=mOJbZB0OKKtRcQys1KHekYNlhJoKdbK8hIPGbj2EU7L2FxKEg/DfYWcDK3XSyySLoM
         NLtj8TPUEEPfBSdZgSnmx+8+fEid6+qVkS1noPM2DJnXyIXDuS9MefGxxBXcjJONAjAQ
         g7pD/3xyoryTvDlSZ3klV5XIyJEL+3+iKzAeY2Xd6/BCB4oIPJYKPKPMROOAFSkYIEYW
         U2RruC/QLokmo45PAGpt8CaZGtizTHtVLnHoqTyYZCm4c0xviXFAQpmrmvMZxO6MQMz3
         c4EtHGJsHOF/FhCV8nzSwDr0DRuPPwc0FGTHWP58vBsNMORhLm2hS9drFyUqpDeiVYuj
         OL9g==
X-Forwarded-Encrypted: i=1; AJvYcCU8S8YmKdX4f7rdsiKOQ7U5/NNJ5Z+7HPpG1xu41VLFD4/9i+mLRyluQlb/b8RpEF4FqRt1diaeoiDTZAGawEaYv461vB83WdaisfTf
X-Gm-Message-State: AOJu0YxtQJ+8m31XF3OHw8pd2MiWJLEQiRzeRacm7DwfkIWY4o6vQNtU
	AaT5KoI+u0aknEIo5cQc4njwcoOzpUuQuUHAuBJUjoU2Gbo8P3zSx4Mg2qzC
X-Google-Smtp-Source: AGHT+IG0JHxNsmMNE80wo9iaFVojapxpHbr5VYwURnXfKnIBQTiE9Gdf2521LUQvImEEcGliXhJMPg==
X-Received: by 2002:aa7:c98b:0:b0:565:edb8:7dc0 with SMTP id c11-20020aa7c98b000000b00565edb87dc0mr3675887edt.9.1709034036825;
        Tue, 27 Feb 2024 03:40:36 -0800 (PST)
Received: from nuc.fritz.box (p200300f6f7068b00fa633ffffe02074c.dip0.t-ipconnect.de. [2003:f6:f706:8b00:fa63:3fff:fe02:74c])
        by smtp.gmail.com with ESMTPSA id h24-20020aa7c958000000b00563ec73bbafsm675287edt.46.2024.02.27.03.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 03:40:36 -0800 (PST)
From: Johannes Thumshirn <jth@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Ricardo B . Marliere" <ricardo@marliere.net>,
	linux-kernel@vger.kernel.org,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 0/1] mcb: mcb updates for v6.9
Date: Tue, 27 Feb 2024 12:40:28 +0100
Message-Id: <20240227114029.22319-1-jth@kernel.org>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

Here's the one patch I've colleceted for mcb this cycle.

As you've already provided your Reviewed-by I suppose your OK with it.

Byte,
	Johannes

Ricardo B. Marliere (1):
  mcb: make mcb_bus_type const

 drivers/mcb/mcb-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.35.3


