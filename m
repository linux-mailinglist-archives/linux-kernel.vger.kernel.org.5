Return-Path: <linux-kernel+bounces-99823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BACB878DEA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC95B1F21F3E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E181C121;
	Tue, 12 Mar 2024 04:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9+LvfFB"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BA4A939
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710218941; cv=none; b=tOX6S9SSH9RzIqMSr2sApsqdeJmqqGpqKmYcA+TA+Kn+Vgza3B40lx382AhX/FH8hsmi790h0aSYbCB+By3nfUzmd00h6tnVp4Ut8Ouxmxc1+EsOaviI5MbcVEeAMsiVxijlyRXVwSRPiV/zauIhthPVdsYYaxTRLD22BJMkwPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710218941; c=relaxed/simple;
	bh=seOOvWAjaia0c4pwwjG32vAhSVNwQlKE7Ph1Md6JT9o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L9QKBAlJaM9lcW5HBWg6qBFP1FPVDy1xSBGPdlKfu6V8kPsyQrOHDp+ZaA6zZWQHPF1aIYjaoYtFB+2fe2Z7HXTQT2woPdGhlyAL9Apy8am95pNFY4eDw2jM7cVtTA+D1KD8fatJ4fqO0O3V6J5Mx2uvT+Ah9GEvoj9XXGLSkTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9+LvfFB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so6718345a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 21:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710218938; x=1710823738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4H8D+j+CnCWZPGpERMleqggytqZOUvmKScd+oQhZVhc=;
        b=A9+LvfFBFkZYf9YJA83X2PseeDiaVwNMkYWWIQoWLCT98OQ58aMo5VVXhBbO/+FqFj
         cYWbU0Zf/jE8R5D9LEmh3Se3tlqOIufwp78FZ3HJg1S18kCL2W9c+VC5TCBIBvgqavCv
         rwCpSyMY8v3WLXappuexqzEKGJJAkZ6eeO+sAJNSj8qIUWINFH37pOUcBjrZVJ2rFCiJ
         J09l0RfEXjRfj7qWVz1MKPb8D11utbmNTb5d7WfX2hdGid12soIDbmdoN3A+xtdgVhbN
         8E5JwYWS3gJ35xMMG52K3UbssXKqPxrXPVLgPxyrn0hMHmnRK7qlYT9tQgukYfcRAs1S
         6JvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710218938; x=1710823738;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4H8D+j+CnCWZPGpERMleqggytqZOUvmKScd+oQhZVhc=;
        b=Be/ucANPqapPiDPMD+EgC2jzewzEncjc8AGc5FXwG5Kasd+dTzqysB3b4SJRBx5TVU
         hITBcOIYT23kPYjoWvQ03c+RbLJ6f1REOD32BY12wBmKEX5o1gGhSlp4S/1XV8Tv2YcM
         HnErxpfcoRekLcL2180nmow4c0Dz0dXQUMO8cejosweXMp4FHM/le8C3KbQlMk84TodV
         es5mhUvJoCci1kFWiMFD4XVBtNIEWLuUCnXw2OI2YpmC+S4W+rcwbOkyMGSVTiSsNuQP
         ebsLp5LIYVh48TzqKgTYf+KvKyiVWK1HNjpaAeVXbEKw+k4jnBgPmOvGkQAEEUWtKUzN
         QP0A==
X-Forwarded-Encrypted: i=1; AJvYcCWSuJYcNzNBHRu+15jjuVDOI0RkUl/E3RdJheqMWRyxM6hlY4cdiui0VTYEhuOrVQMJwAtzhgg1T7hzUQ23C4fMPS8CQG0h/LJdaugk
X-Gm-Message-State: AOJu0YxrQgf2H5A0qiPgHcmb042znZ2NihPQdCP5IkEEenGFH6DWIjSS
	ln2HBar8XjB7WrTOuCkTxWiWOQ6ZAAPwcjszY72cdTx9Ty29hsGLjF1vFv6v0+ODDn2HzTX8why
	pXx+QWBZ/aBGE/rlpMN0VJLSsxD4=
X-Google-Smtp-Source: AGHT+IF8SOmjS9xims5YlCtAGnnI0LqEZKw3Kq9meynfynIcHsVp0SZjLTGXWPYeKs3AeYSJIQ7sDNBQmuTP3ghVueI=
X-Received: by 2002:a17:906:c183:b0:a44:2ba0:8200 with SMTP id
 g3-20020a170906c18300b00a442ba08200mr5029888ejz.26.1710218937882; Mon, 11 Mar
 2024 21:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Mon, 11 Mar 2024 23:48:47 -0500
Message-ID: <CABb+yY3EByujxcqZfwawsQAcmyWjrLnkbZmTb5j7Tqzkyhb5=Q@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v6.9
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

The following changes since commit 805d849d7c3cc1f38efefd48b2480d62b7b5dcb7:

  Merge tag 'acpi-6.8-rc7' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
(2024-02-28 12:20:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox.git
tags/mailbox-v6.9

for you to fetch changes up to 8df6bab6cb9abc98736ffae410a74647995873c6:

  mailbox: imx: support i.MX95 Generic/ELE/V2X MU (2024-03-10 19:05:24 -0500)

----------------------------------------------------------------
imx: add support for i.MX95 ELE/V2X MU
misc: I will be signing-off from my personal gmail id from now on.

----------------------------------------------------------------
Peng Fan (5):
      dt-bindings: mailbox: fsl,mu: add i.MX95 Generic/ELE/V2X MU compatible
      mailbox: imx: support return value of init
      mailbox: imx: get RR/TR registers num from Parameter register
      mailbox: imx: populate sub-nodes
      mailbox: imx: support i.MX95 Generic/ELE/V2X MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml        | 58 +++++++++++++-
 drivers/mailbox/imx-mailbox.c                      | 88 ++++++++++++++++------
 2 files changed, 123 insertions(+), 23 deletions(-)

