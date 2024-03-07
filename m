Return-Path: <linux-kernel+bounces-95455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD655874DD4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143A51C21EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A8E12B140;
	Thu,  7 Mar 2024 11:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3c35cPe"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41399128378;
	Thu,  7 Mar 2024 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709811783; cv=none; b=sCeBthTnHEnFCmkiEF2RNhM9FH/Bqie1A8B/F33bJL7Pk86V3CORzaHGDTYW3rBXm4UR+NxFvAZ4D5w0Uvw4/ofI6x8JXSEs5zktND0A57VDBn4SICVwHXSlo9+A2R9Udmv3taO3i4SRL6U+02vCGFMsJv/iu9ZBN+O8O5qWO2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709811783; c=relaxed/simple;
	bh=mTa5sc7SzJw8IK4sYc0Zupz/cu6Q3rGAQMTXXn56jPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EBsUs0gml/xmvHAxRD+Wb6EzPATNtYCLo0+4tisV66FPka4V0ilVcNbyopo7aPB/oY/OpKcAdnCAzYq7+KbryF6XDR0P5PYFkS5N/gZkT6y2XFzhGL5LjnviBAGJfDXHqKijTmMyGbjcN7YlVv5muR2A+QSoyDD6Ay/xcmn/dp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3c35cPe; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e6f9ce76aso71494f8f.3;
        Thu, 07 Mar 2024 03:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709811780; x=1710416580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9MPOSZA++tTQbyp/n+DD8w8PeiM1K397eA5hseFsnUo=;
        b=J3c35cPesuxzK+TXac31dWSPfKlOkWND5qWWd0CDWDXqrIbiCyFqmemIHbYyPs/BCE
         74FAYArbeGYz5S9q1zDBPkvXEM8gMfabGSTLSgAjTPHT/i6FLaqQba6jG0wn/Uff2Vk3
         ztR8EEixaDukHliaSDnfdAYYyzXmc5eYD4JwQWuPwNc+ZrE2JC/UNc9R7hS0uOy7cK22
         dkIyZzgF6taLs2kNwACvyszZ23JjXzF9GMFOtlcSLVJ/Qo3Hh2rHS4an/yHKhFD6xgLg
         ELzRyHPfMRRf8aIdL4MGCqqwYMRfrniISH6MLDVVxKhJF1/Fl5X9tCed3JrdJTRzwv1G
         J3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709811780; x=1710416580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MPOSZA++tTQbyp/n+DD8w8PeiM1K397eA5hseFsnUo=;
        b=g28LLY855C0JIuxrJD7DR1ARVRx3aNIYwWgsQyKGvGaQzy78Z/JJIeGYMAWKBd11sj
         D10M6bem9Hf5jqxmC+xpoN4TbKajfu0WGv5PH9yHLirkL1TqOgH3UJQd/dSniOv3veFL
         Zu2qs+LqyHkTzfa+dGSwRV3PNk4QLRr9xWzsC6vZ4zYdhkX+z/mPndm2ptyfZ0ozwXqe
         l9TUCgTV5D9sZqgLw9o/8VCQlO+sLSu0iDxihn5AcwmvmNzvF6qgQ+hwyo1LOWVxcGEo
         zSzidvlxd9grywSqb2TuhuxCUulKH+n/LWlrduBNCUzXuPufmAk/hl4684FGQ0DQPooh
         JQZg==
X-Forwarded-Encrypted: i=1; AJvYcCWKLB9HImAVYOWZNt0juPiDg/2LDxS4DqkwJQIWHoaXlFIS+pjYaTMuJgZH7vR5OZeGtxF1s4G0zzaa3ZwseatxbD1hPPWUf6WfHmdH9XBKVXhRr3t2NIhxSZuguwI+E1lcSKouAZxC+MLl7C+yrfIEBDcm8yFlcPzGCcZQ15Qh2069NtY3pXtjleUY
X-Gm-Message-State: AOJu0YxDEkZ5x2KrBOiXOfhwr77CYgWudPUwlDypT8DUANjL84+q+G5i
	PCFdvSu8ZXfDsxufD5mkTq6BqhcJsO6zPptVudig4rFcsmfx/x/4S4EiFnhy
X-Google-Smtp-Source: AGHT+IEx97a8s+IEsNN6uwwAeUtjU4D9Ii95oBHdlPOhtKv+f2e5gKD6Xwh/wbYpLmYa+pNzmpCuhg==
X-Received: by 2002:adf:f40e:0:b0:33e:45c2:71dc with SMTP id g14-20020adff40e000000b0033e45c271dcmr6685639wro.1.1709811780360;
        Thu, 07 Mar 2024 03:43:00 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:fef2:3c1d:a816:65f7])
        by smtp.gmail.com with ESMTPSA id h5-20020adf9cc5000000b0033dd9b050f9sm19858722wre.14.2024.03.07.03.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 03:42:59 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/2] dt-bindings: serial: renesas,scif: Validate 'interrupts' and 'interrupt-names'
Date: Thu,  7 Mar 2024 11:42:15 +0000
Message-Id: <20240307114217.34784-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series updates renesas,scif.yaml to validate the 'interrupts'
and 'interrupt-names' properties for every supported SoC.

v1- > v2
* Included RB tag for patch #1 from Geert and Krzysztof
* For patch #2 defined the properties in top-level block 
* Used Gen specific callback strings instead of each SoC

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
  dt-bindings: serial: renesas,scif: Validate 'interrupts' and
    'interrupt-names'

 .../bindings/serial/renesas,scif.yaml         | 120 +++++++++++-------
 1 file changed, 77 insertions(+), 43 deletions(-)

-- 
2.34.1


