Return-Path: <linux-kernel+bounces-51128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 116C28486DE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91C951F234E0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7701C5EE93;
	Sat,  3 Feb 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marliere.net header.i=@marliere.net header.b="L3XrIXfz"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1A5EE86;
	Sat,  3 Feb 2024 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972265; cv=none; b=f6PxMaDbILX6xbT7b5Bg0m5V4yeIm0kV2dIv+RxJcL5LxN1Y7SlMxHVi1CibAjFV7jG39bJCYLmo8qlWK6wAB+8G4xvYNJhOlBjJpfxFd+amT0IC7JoWE7TXaZyMtllOZuzSpw5pBUY1pt09tqfYzWbZe0nnNLKE74ScigBJdxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972265; c=relaxed/simple;
	bh=5opwMHyS6hOmD9rUQ+qyqnc/soQP+69EJIln7q3aCi4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hlOOlED25k1BeQkoZDb7NfAHZyCGrlAvae8EkwwyyRxt7A96KbpESU9Th7FzbOfWVSvunzatEkREKybLtYH5ThXg5BGWhKHRIEhF4DO4HfqSIFvoOSDm4qLBbQzkRhHlYXafQ6WIYDW0Sop7iraZq6z0H5/Ef0lBNfcLRlMJBbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=fail (0-bit key) header.d=marliere.net header.i=@marliere.net header.b=L3XrIXfz reason="key not found in DNS"; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2500443a12.3;
        Sat, 03 Feb 2024 06:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706972263; x=1707577063;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:dkim-signature:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YLak5sdyR6WjpREo34u8ut+AGeqi3y7JCPvVOvVF2Lc=;
        b=Ek9vUDXKwAq5+9rU0Q9IuFWHVOBMPYwb7XMPZo07hDEvNCJWfCZc0VNh2iBhMejCQD
         zPFMI0noRqwsx7ZZu9i+WWJME1uoDCNrHkU9CVc+tJYz7pzbAE3MwpiH//HDfwCyzG5H
         cl8dlFIHXP1q9nG3qjGaG9WgDHKeuidVPquhTTozrWdDvOmE5U1S0Wi60x/QRP6I72LR
         3S5Qe8grK/m+U5jI/9/mWjmQR1AwgRzRcS6rqXOXh+46k6hMWKOEEPENobUjdEF6amJX
         yciIdiYGxRaVAKo53mH/XkbeK4m7XMb/+DXHPop4Vizf/qJgQdko6JlA3uA590owjtPj
         3iEQ==
X-Gm-Message-State: AOJu0YwL+FnNJFeGF7Kdd7K8tLyDcjc7/ws7aFxH//JP9OmDsmLpbQPk
	85iXhcZcDcFEO41G4U2eV/mmHysfkIgpJVrSDPuDjeIpB+BRHbHs
X-Google-Smtp-Source: AGHT+IHvNgCU2nsiSRZCKyVZZltAuAbhkuaFUHl/XrcvHgFT/GWlpCR0UEB0ZY8slpmMsZgEU2+qWQ==
X-Received: by 2002:a05:6a20:bf16:b0:19c:ac6b:74af with SMTP id gc22-20020a056a20bf1600b0019cac6b74afmr7895696pzb.58.1706972262730;
        Sat, 03 Feb 2024 06:57:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVZdA+1qNc9vVRKPZfCTZ73gS7zi51pGGom39qiHSs8FRnipPGIU+I5xhSS+4Szn4NOuJRuxu6mKoO3V3pkxCNoOAQX5hrPMnOAOYxBk3L0cVYnD0B0fTVpCEN0YpKXYdE643eD+fonxcUyOf7OgmlcbVjGKEYIJsrEx2oUAjp+QK/UZawn4NNd03mqCt3tU0oAj90IgsnBY9RZOF6cZq4a1yAGvXnGnPK2QwicsF8fQp7MZPLxBdkaNKecp0EtiXdOhgM/iniAGQeh+hp/xp1jRABr9ZKw+EQ7uh159CBo3H5YEZmgYj3E9P7ReeBp/Gzky96mc+RYflUzexacEyUnHEfjq3umn/yozACm6IhV0UIvwg5nZH9yrafC+YO4cJL+W2z+cZxU5iQloD+65CGcpC3Vs3t70Gqc1CyrBF562BJfWfLlgIk=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id le10-20020a056a004fca00b006e02f222c2esm860091pfb.30.2024.02.03.06.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 06:57:42 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2023; t=1706972260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YLak5sdyR6WjpREo34u8ut+AGeqi3y7JCPvVOvVF2Lc=;
	b=L3XrIXfzYU50vyoBiFTJxVGzJ9R1XP9313I7P3YwMAeYkLpSVs0FwLjwlPfYEu2hfRFoP9
	bOlhO+ejzk0XNXnin1U9RJAGyOpJYwG4e01FqMO2g+oZZdzaDAZIefFbjVcyS5LZgGa0ud
	qrKzqv6gDdvU4asayTVjznN9CPuSwkgF94xPaRwQYl3OBJbR7n2NhsIz5SMLet0w774HyK
	19ehNOoaRObMM5GKovumMNC5Ch9qnzYEvQYdRPLNkQdbIXmuAxvwFdZdhx3Ps0gPOt9F9H
	s6I3qZwqNNGGN8P811tsCtTmqZabx/Ti5T/0LjASw67hf5lMICrV1MTuUrwivw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Subject: [PATCH 0/6] s390: struct bus_type cleanup
Date: Sat, 03 Feb 2024 11:57:57 -0300
Message-Id: <20240203-bus_cleanup-s390-v1-0-ac891afc7282@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHVUvmUC/x3M0QpAQBBA0V/RPNsasxJ+RZJlMKWlnVZK/t3m8
 Tzc+4ByEFZoswcCX6Jy+IQiz2DaRr+ykTkZCKlEQmtc1GHaefTxNGobNDVhRc5ZcrRAys7Ai9z
 /suvf9wOZYfNNYgAAAA==
To: Vineeth Vijayan <vneethv@linux.ibm.com>, 
 Peter Oberparleiter <oberpar@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Harald Freudenberger <freude@linux.ibm.com>, 
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Jason Herne <jjherne@linux.ibm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=5opwMHyS6hOmD9rUQ+qyqnc/soQP+69EJIln7q3aCi4=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlvlR/ek689TQpKgLRXuRnW5rbn5JS1lUyJ6CO1
 6NrPm9hBOuJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZb5UfwAKCRDJC4p8Y4ZY
 pnXrD/0XE+FYw49QWpXkzCP5YJ+rX96ET8dXHbtMfzy1dGSO0F1gbKtyedBeAVdeOU95ERkdutk
 tmrxBpHfI+VvSD5BZfQpqHXtze6lyuR2w3b9k0HZ1Xx3lPMyByPU1RUKAK8W817NMb4V3DhWoSF
 UXLdLQLxP2XcnpptplnDLwXKROuanutiAVRBFF2EKyy7vx6fnndqEv7hX85+h9M9QunpZpA2g4R
 a/jtrGVnzUUW5XxWCGKSJSIatnnbWzqXy5Rqf6SwVkz4IYGMVDog/f+VovbMju4YiaDnPRz9mXo
 oIY2M0F2jEyqKZ/XG+9034c0Ie6JW8D3PITGyS0OuEEaBtg+ssn1pgxHTVn96EPVVKtQjzkL2w/
 Oh10uuzSALb0XMjKwFNpFeXiOu5QgohbjA7+DxSn65cJmgpDZW1EYijQ6vjrgC98hHOPgEJjcJC
 GvEMcVRpxMrZzmXr2Vqzny2tDZ5QMZDcKiOvyLRZFm3GkvFSHNW5zWe08wQOktBFHjT4VCivflS
 WMPGqMTJE+i2bEgoKbR3y5cha90gV7F4C5YE8AFkK/Rhd1ifq7L75tm8GGyOXrK7syrsgPF0IU3
 uRwNCFErZJfN5rx4fCXt4ctLRQxgon7pziLtigN0moFEjxKUhgTYS5EDjFLZ+b620CWdmBadTb7
 3B6S41BKO07zOKQ==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

This series is part of an effort to cleanup the users of the driver
core, as can be seen in many recent patches authored by Greg across the
tree (e.g. [1]). Specifically, this series is part of the task of
splitting one of his TODOs [2].

---
[1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa

Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

---
Ricardo B. Marliere (6):
      s390: ccwgroup: make ccwgroup_bus_type const
      s390: cio: make css_bus_type const
      s390: cio: make ccw_bus_type const
      s390: cio: make scm_bus_type const
      s390: AP: make ap_bus_type const
      s390: vfio-ap: make matrix_bus const

 drivers/s390/cio/ccwgroup.c       | 4 ++--
 drivers/s390/cio/css.c            | 4 ++--
 drivers/s390/cio/device.c         | 4 ++--
 drivers/s390/cio/scm.c            | 2 +-
 drivers/s390/crypto/ap_bus.c      | 4 ++--
 drivers/s390/crypto/vfio_ap_drv.c | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)
---
base-commit: 8eb3db95a8c8ecd6f8bb082a99ded3bbc79b023f
change-id: 20240203-bus_cleanup-s390-82062bb32b2f

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


