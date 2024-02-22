Return-Path: <linux-kernel+bounces-77336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF398603F2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4048A28D121
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ED471749;
	Thu, 22 Feb 2024 20:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQbp1+SD"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43620107B4;
	Thu, 22 Feb 2024 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634955; cv=none; b=jiTHonbdVpL/iGfj+G5bo+Kj2te4JsFiHPKVfzTOCklWZ5i/lRIT5z5ms+s9bEDvaee4oebIqVEBYPK9i7d9dzVx0aLDnJxk+8rITgSnRddOE2hMHBZy3JTIKY7zkXICDeC3cW3u6v5KwoNUqI2vRvlEY2iDC3dxfeFmn0r48CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634955; c=relaxed/simple;
	bh=PWEuIIaypbi8sAbry5NJFG4ZqxZU2r0LdEbSQHq8Ivk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=Ldn61AokkOf82F/bWF59vTekfhNXYk9L0suHznO4TU3NS3VbhFwk1VDPDrAK5etKuKVhDUeLPGrjESS4MVGWMOezah9Ze0PWOUw6GJT97Ymx2XW/vdaSsv4WbPCaRxYVXwY+jM9zm2ChxuuD0C6zYtzUvG4NOqpIgv3acN2z5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQbp1+SD; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d208be133bso2911871fa.2;
        Thu, 22 Feb 2024 12:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708634952; x=1709239752; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UfU+wnc+pzxbeVAwn/zbrA7Jn6jFhL0eRNk6P5L3vnA=;
        b=TQbp1+SDmYTVTyAYhlH/HG5O++z6y1wWgPxFYJZhzlc7PAwWrRffeviUlhbqeSgg6O
         rDiRzwwYKc+zdONCAqCaqUyAwsHES6FEe5g5ihkGh4/4fITCcpFjNAW2y4lFYW5+SOL0
         wHPYIryP3PlcPyDzCg8o+nniAUCJ8qKux6DpnxnfuPnW5oY7I1kwztQ+DnhCtb9S/FV2
         2teD0wWv22Fe8JuNl19rHDwLog8TXOmOeqvdleKCIAVAYIWE0jvfLHXvuP274WSpyOIQ
         xMHtHe0Tow9UlwX6lYBN3r4dl++wdVhjOxZY39Y1aqfdmWN6lCQKyNHaTJwy+pEH/5t1
         /XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708634952; x=1709239752;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UfU+wnc+pzxbeVAwn/zbrA7Jn6jFhL0eRNk6P5L3vnA=;
        b=tfkU2VRHtIN3VswhXJfuCpXdxztm30veDmLmpfcXAI8yyzTtOdJ+o9yVb8GuCxzrk0
         GIhap6b+xUxhfKLWt5cYshWBsODV3hmfRasW40E8XTX6VYuKTIZZfNmuPzTHzLw7Rbi6
         5HZ/Bx2UcitdbLX9y72qq2BWvC1Rsw6yv92eZ5DE1JjDiJEsh67Qa0+ezcnW0fODTaAu
         u9h9TacOuBiOJWWlG2008vxOkYJ4DdV4kZupuf+CFwUCc+7CZHBRPxSD/+2QrBg/D7ea
         /dmSaAnwNC5jtPu7sLztoEajPPHdYSpQQ+R8mV9muRcILmJFAR8hk5RYR2xFH55jK+dI
         NTsw==
X-Forwarded-Encrypted: i=1; AJvYcCWD9qKBj5SGjGGg62lZ1HeuzCRFW6gkcCFp9lXZPzQuukCn/kMo5MfvWaFVWd0ftTGFT9z/XYiTnRKWGuwvnTHPvDILMUm7cGdGZmRyNYL3V7Dvq58+1CDtndes2NQ5wMXV0/0f
X-Gm-Message-State: AOJu0Yy7qJf1lECFxT6N/qOrHTKWOMUAcn3UdfQdrw8Snpa1nMRDLtct
	il0ONdKTgxzzV/V4I0wKBfgndd4eTxZu56OmOTKWdResvUCyysqi
X-Google-Smtp-Source: AGHT+IG/rWNl0cOslLcppqwHUpCaxP7yAf15k5yUMXPzL8+tiwjrCqakZ4byLW2szpfpYsTZGHFXKw==
X-Received: by 2002:a05:6512:328a:b0:512:d00c:2972 with SMTP id p10-20020a056512328a00b00512d00c2972mr171700lfe.24.1708634952078;
        Thu, 22 Feb 2024 12:49:12 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id u14-20020ac24c2e000000b00512c1de1961sm1170752lfq.115.2024.02.22.12.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 12:49:11 -0800 (PST)
Message-ID: <df300a49-7811-4126-a56a-a77100c8841b@gmail.com>
Date: Thu, 22 Feb 2024 21:48:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com, b.galvani@gmail.com,
 bpoirier@nvidia.com, gavinl@nvidia.com, martin.lau@kernel.org,
 daniel@iogearbox.net, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: add local address bind support to vxlan and
 geneve
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This series adds local address bind support to both vxlan
and geneve sockets.

Richard Gobert (2):
  net: vxlan: enable local address bind for vxlan sockets
  net: geneve: enable local address bind for geneve sockets

 drivers/net/geneve.c               | 58 +++++++++++++++++++++++++++---
 drivers/net/vxlan/vxlan_core.c     | 19 +++++++---
 include/net/geneve.h               |  6 ++++
 include/uapi/linux/if_link.h       |  2 ++
 tools/include/uapi/linux/if_link.h |  2 ++
 5 files changed, 77 insertions(+), 10 deletions(-)

-- 
2.36.1

