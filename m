Return-Path: <linux-kernel+bounces-143339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445CF8A3763
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 22:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F84287726
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3023149006;
	Fri, 12 Apr 2024 20:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kk4KEBKi"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1BD39FD5;
	Fri, 12 Apr 2024 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955460; cv=none; b=JoqB5pvXaPNKRUUxvkvwF5uFW+4B9bSl8KFBOtZWrB1Um93zWpKVmRHxfWowASpGxCBOIPeRNySzq9YAy0Z3Z0ZiKrmDDRubkbUe6YfwXtZVQ8EF2W73Vhb88gzwN0nsVty86OoPGcyrOf/YXP1L98jwSCsKGJ+yGwQDzrbogRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955460; c=relaxed/simple;
	bh=LTfEH0OW5wceSR4OBc7/jsdPA8w7QFdiyqHte0fJzYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q+w58MYugbJjVIXYaL2sILcmoqut+23lAjTsfLE8pUJkXMuUMMYqEod/9wzbfCCzf9YE9mhxywG1/9PZlLVpQ9tLUr8DG2/1v9izc2NUjvRu8ubI9f75VD5ubz1z+ubWnP9jCPNj0tFLD7oHyG9HyN+mC9ndo/vjtR4ZFopzVCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kk4KEBKi; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3462178fbf9so703594f8f.1;
        Fri, 12 Apr 2024 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712955456; x=1713560256; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dg2ahnpNhhd49pJIzFyauGmvavc6mK+oTZvc0UBJgxY=;
        b=kk4KEBKioDl7plYBwPWv+6G1EUNe0AXf2b16GdxBYUHgofQhq7j49yt+r59pW5H730
         0Gfxktj15uRxKv+690i/ATMiGiQ8RXjpz+wmAnC9104wh++Wxnh4NPZdyHGIHfqRWgjT
         62/RMbqSUPTQvQLSwxjqSLK7r3tS43/uslQr9VDOKRh9QycrCeGzbdPDzmKAolKTHo1I
         g5D9F06fSntMM7XjHOjl9eOwXCEPv91GkQEfkPLERQOc9W8/EnIhFx3Tdv8aQPD6v+ld
         ybn8k8Mj59mR+209od/F9zCxOZy+KJErMdNfG8DJ9/fAyWXM8+ivxac/5osUpTHaw1jq
         k6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712955456; x=1713560256;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dg2ahnpNhhd49pJIzFyauGmvavc6mK+oTZvc0UBJgxY=;
        b=edoQv9EAiK+maBjy50Thfx9umbazUw0r3WeIkLSkIvLFV2Bwompeow2QmIDRkcNhHp
         uS8APKQusIiTlMSutcQJzF3G7qDX3VQQU8IraaXkVO0iH27kxHH6kM99oKyLjP0x1hSG
         VeWC8iWtMRsveG43DDMU8HWTbr8i3bdIxPKwpy6vYxBcoWzDbc3bsE/q0N9aevdosBKU
         JLVMANfp/Ekn/l7bf1XC5oX76FHv1NBFAcgdDEkfmLI9ge/Ye14cs9lEezN9f05Xlf4h
         0kV7wKo3/0p4KOcwKJaynaEbt/1WOPpwEK8y1mpl7PaXSYlquGBlgUFbo2Ij5qoQRa7s
         +z/A==
X-Forwarded-Encrypted: i=1; AJvYcCVhr3GAJo03EQCjF5QxAMloCn9BDRKiSSUTHet5S/PHfop5Q0vP3LEGjArPZYlPjcpaz50zB/pKugT5JHnBZRZZiRf1ApCtcZXshhoq
X-Gm-Message-State: AOJu0YyMW55y1qs56LSIWwQWcP9dnUi71uZkfuEBRCOBoa1swixeAjvq
	fGYLBPMoheqM4GL7AZTxIlZpNjbMdmIbKML7YJ4orYLQ8lEDpDka42uAXUTf
X-Google-Smtp-Source: AGHT+IG9CTjG81WWEOCd4+OLOjxVcWFAzOSSs3Au25Q+ubb759cApR0HrsQogS1sH9U6Hpz1gZiaUQ==
X-Received: by 2002:a5d:6744:0:b0:343:a8cb:7990 with SMTP id l4-20020a5d6744000000b00343a8cb7990mr2762792wrw.29.1712955456093;
        Fri, 12 Apr 2024 13:57:36 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4808000000b0034599eca6c9sm4989203wrq.41.2024.04.12.13.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:57:35 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/6] input: use device_for_each_child_node_scoped()
Date: Fri, 12 Apr 2024 22:57:29 +0200
Message-Id: <20240412-input_device_for_each_child_node_scoped-v1-0-dbad1bc7ea84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmgGWYC/x2NUQrCMBAFr1L220AstgWvIrIs2ddmQZKQaBFK7
 26Q+RoY3juooRoa3YeDKnZrllOX62WgECVtcKbdafTjzXecpfJ5s/Y0gNdcGRIih2gv5ZQV3EI
 uUOdlmmSZRReA+lqpWO37f3o8z/MHGZsZyXkAAAA=
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712955454; l=1795;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=LTfEH0OW5wceSR4OBc7/jsdPA8w7QFdiyqHte0fJzYM=;
 b=IggHSVg34Jubfo9KeV3wgUEG6kpICuiSXv2zWHBXqWD2mnHsY2NVuMHm9RE+H+cDTL4RPq3CV
 taaJVZY20iyCoBB6bv5l0MFGiwpmUw7qsnThJyBd6aLREe+Gtvyb0MB
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to the _scoped() version introduced in commit 365130fd47af
("device property: Introduce device_for_each_child_node_scoped()")
to remove the need for manual calling of fwnode_handle_put() in the
paths where the code exits the loop early. This modification simplifies
the code and eliminates the risk of leaking memory if any early exit is
added without de-allocating the child node.

There are six users of the non-scoped version in the input subsystem:

- iqs269a
- qt1050
- gpio_keys
- gpio_keys_polled
- adc-keys
- adc-joystick

This series is based on the master branch of linux-next (next-20240412)
to have access to the scoped version of device_for_each_child_node().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (6):
      input: iqs269a: use device_for_each_child_node_scoped()
      input: qt1050: use device_for_each_child_node_scoped()
      input: gpio_keys: use device_for_each_child_node_scoped()
      input: gpio_keys_polled: use device_for_each_child_node_scoped()
      input: adc-keys: use device_for_each_child_node_scoped()
      input: adc-joystick: use device_for_each_child_node_scoped()

 drivers/input/joystick/adc-joystick.c     | 16 +++++-----------
 drivers/input/keyboard/adc-keys.c         |  5 +----
 drivers/input/keyboard/gpio_keys.c        |  4 +---
 drivers/input/keyboard/gpio_keys_polled.c |  4 +---
 drivers/input/keyboard/qt1050.c           | 12 ++++--------
 drivers/input/misc/iqs269a.c              |  7 ++-----
 6 files changed, 14 insertions(+), 34 deletions(-)
---
base-commit: 9ed46da14b9b9b2ad4edb3b0c545b6dbe5c00d39
change-id: 20240404-input_device_for_each_child_node_scoped-0a55a76ad7ee

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


