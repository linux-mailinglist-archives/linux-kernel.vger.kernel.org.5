Return-Path: <linux-kernel+bounces-131294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 466118985D1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B811F27AD3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 11:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B98681ACB;
	Thu,  4 Apr 2024 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkG6uGwM"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942A811E0;
	Thu,  4 Apr 2024 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712229229; cv=none; b=XNYhJm/8ANrqK139GjQbthCWLli2ds5yt7czyydd3n0N09V1sYKbhSxzqdzeItg8NGHvtGWFvWqoeCgyPJM+JDT6lo5Haj2xNaqF2ZemAa/UJVdrkS+32bC/lCGH4IVKd3AcSEHgv54x0UyS6aPJ9lBteIcpoSuLsuepOhe2xzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712229229; c=relaxed/simple;
	bh=G/hhAJMF+CbYhDeRpV0Tleivjbkh5uITYHeK9CExz8k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AiFV1HFeHOdrIUx2GzALZdDdjpfpDijRu0xlTHOtX/0GIS/6/4Fx2mgtKAhPKsQl2ezNBrbeGMa9nKhrccV/2sNTnsioTCEiXCxRtshQTkoaXvhlll1vHy0nM+jk7XeAtCS2hI0UFbYbFjpbhse7Q4N/dH7AppkvdtkmtqOv5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkG6uGwM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso115529966b.2;
        Thu, 04 Apr 2024 04:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712229226; x=1712834026; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zCsn4lzXWs4WfV1FaDxO83EPbiXy0Y7pqCwVUGDrT6g=;
        b=jkG6uGwMtNFvGA4EySHDMQPZVqDGaWp+yVuXMVjKeOkmh+/gBcEN8ykQj2fR0RjQUc
         0ki9te0m1qtFjQl5Qp1VYMCJt2WEye4h/Hi4/aNarApd3rzcpmNzz/Qv1vzFMnHOCsEC
         LymiRlxEPdnW+i8oqvwpDMCiY+kgbYjLm+xO7WLs/Yv01f1Vh8fX09cklSONFG8okYFd
         spmbnazTcKY6CLrY1blUzIOKqETOR5oBkATst4n5CbSNJV7SoCgdH1lJbL8BH5eWXMrP
         5NxYBtlOTH0fOcw9PCHOqgN5kCrhdQsEmGuIzJkAeWC4rjvWmTF3yGftcoUu28cpb0Z3
         /q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712229226; x=1712834026;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCsn4lzXWs4WfV1FaDxO83EPbiXy0Y7pqCwVUGDrT6g=;
        b=Z3+2Zn0sBGwNLCaae1tes4kMJF+sjG4DiCT0BdAYCRsmcvnV+z0jSWwCDFqpcEPPCo
         ajLW8b5x0QIq64UNzPGkoP6dkP++yo/bBdGrCrIeeAfeVWOMGOFH2TGBPHOhfmgQq3XF
         sA1wKf8Z6kaXAURj65RQ3Mv2xSxDuq68opttsPKwAXysQTpd3j3cUr0mXWiIPl6l5+iA
         jBa3S1ch9+IIFJyxYbifI5muBNGJu4dyxJkD2VwHcj6cmbBY9AMDTLuiePOiwzk1ZRdU
         cML5j1B/P3pHOQqyaIMC+vVnSNEsUxPwxpT5wgWjw5RDH80XcE97xG9V0Z2Rjj5XRMEJ
         a85A==
X-Forwarded-Encrypted: i=1; AJvYcCUiQnCDHyzwr/9L/o/E/OBqaNZy0NyvBILpFAxNaTmfXLyvMZ6gMtwwF+gvqO6AcnqERxouOP2vJ48dSkpklOUB9VzdSkiU9Ow0dXwj
X-Gm-Message-State: AOJu0YzKgc13Oc9ieMigeXYOsptoKqvYsMynp7HWMgtgE4aUJ4RqyejC
	E5XLo5NSBiSQ7eUb32wO0Vnre2gAXsoJ0DVpqftBL07s6wO0iNnl
X-Google-Smtp-Source: AGHT+IHcTeSPLnjpRlWWP5mAM46IB1Ue2zNkQbvjFIiXOZeXf2QYd4Vbo1bMpQxdgLNlDUlCvT3spw==
X-Received: by 2002:a17:906:4554:b0:a4e:9dd2:45a4 with SMTP id s20-20020a170906455400b00a4e9dd245a4mr1685521ejq.9.1712229226122;
        Thu, 04 Apr 2024 04:13:46 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id qf4-20020a1709077f0400b00a5195edf8e8sm104659ejc.62.2024.04.04.04.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 04:13:45 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] hwmon: use device_for_each_child_node_scoped()
Date: Thu, 04 Apr 2024 13:13:26 +0200
Message-Id: <20240404-hwmon_device_for_each_child_node_scoped-v1-0-53997abde43c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFeLDmYC/x2N2wrCMBAFf6Xss4GmXij+isgSdk/NgiYlARVK/
 91F5mlgOGejjmbodB02anhbt1pc4mEgyak8EEzdaRqn0+iE/HnVwuqpgJfaGEkyS7ancqkK7lJ
 XaLjgPEeJOqdjJF9bGxb7/p9u933/AXISOJN5AAAA
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Tim Harvey <tharvey@gateworks.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712229224; l=1123;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=G/hhAJMF+CbYhDeRpV0Tleivjbkh5uITYHeK9CExz8k=;
 b=jjpFMtyQdzpDpa6B57uBezKVWY+wqIgtOVmOcSc1yViDGk8Iw9G/sIZHk0qH+zz7I4SISxiyH
 L7BvC/Xa4qcAsN4aDvlTvmd1joO1U38RB6I/nlf16ZZPzqdrSnibHEf
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to the _scoped() version introduced in commit 365130fd47af
("device property: Introduce device_for_each_child_node_scoped()")
to remove the need for manual calling of fwnode_handle_put() in the
paths where the code exits the loop early.

There are only two users of the non scoped version in the hwmon
subsystem:

- ltc2991
- gsc-hwmon

All calls of fwnode_handle_put() were in error paths.

This series is based on the master branch of linux-next (next-20240404)
to profif from the scoped version of device_for_each_child_node().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      hwmon: (ltc2991) use device_for_each_child_node_scoped()
      hwmon: (gsc-hwmon) use device_for_each_child_node_scoped()

 drivers/hwmon/gsc-hwmon.c |  7 +------
 drivers/hwmon/ltc2991.c   | 11 +++--------
 2 files changed, 4 insertions(+), 14 deletions(-)
---
base-commit: 2b3d5988ae2cb5cd945ddbc653f0a71706231fdd
change-id: 20240404-hwmon_device_for_each_child_node_scoped-6e581c1d8a31

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


