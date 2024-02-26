Return-Path: <linux-kernel+bounces-82252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA71868138
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB7E28CA82
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748B012FF77;
	Mon, 26 Feb 2024 19:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brVH9n/o"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2641DFCD;
	Mon, 26 Feb 2024 19:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976464; cv=none; b=PTcnx2NhPzU5l8LeMhY7AE3YG5pr2JRmqUJ/rP0ATCDDkOWgPd6mNRCJRA24vj1gTtm9Uw7C+lWOujCBbBcT2h19y7CNPvnzMY2uvjk+cS2J8gOfkzY9xammbfK4RabcQr6XAbo1M5c68u/D71BC2mkiw8NdfJjHvmENQZ4ELvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976464; c=relaxed/simple;
	bh=R1oG0HouRE9vhJLOlmgm62g3yLIHm62/DfbcW6QzlCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TPHyPWWpCaC2JW55SbSNQopoxduQyk0ujAaSmaGc6rWSJ+eSkqLarOKMn/nEbrZd6RBgTrQbKeqeXYCPChVuPTzrykkYi7QNp0gxX07CcBkcraOEcwymamchomTDZxbiG92Cx0eAIA+YRjGZC8b8rYkDiqH+4UP/YEMr6q14lcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brVH9n/o; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-512f6f263a6so1507575e87.2;
        Mon, 26 Feb 2024 11:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708976461; x=1709581261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kij1cAfyF63c6cd4cyXhSOmsWIpVIQrrfl6VlaYtJ70=;
        b=brVH9n/oBbBm0gLMTEUtIswnbcTlnOWK4f/mmYe491eddOrg8SlSTV/Jsb1u7HncmL
         kAKrXbnBMX2mM7MWZ8CemYv+7kFYxuA2UXCvBFwkeX/54tPvCLhJmrbi5ZJlxLNc/ZE0
         Y9tVEtNyBLtb+mgYKCw9D2ER88W2fY6/sJJhICQ4AmT7TjMkgi3gfyn9tL++LpuTcltU
         T9Z45Zpq1hDYW8MrftrhDEeRTm71DTpzFvOBp9OXG9SwCQT276eDjmXtrHa3RxBjiQtf
         6od7yZ+rvg+BkP/BhrsBd4JA6Sq97pdw88w7gcicXcy9ec2QsZVOW7J9wiTHO8jjrMH0
         vSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708976461; x=1709581261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kij1cAfyF63c6cd4cyXhSOmsWIpVIQrrfl6VlaYtJ70=;
        b=I5wWqLpxt8CX1WuxQUjm3/MelBV/xcogRWWtb+8Ok9gjew7IKG+yPQ5vfk06IIE5PP
         +jSTWdR3voxiVZ8ASoX1H/4ctv24W9CCLQXxE/2n3k6WjYGwfohWaGTsgPQcXnKU7kQ6
         1adIDLImSxDQv+sKlARfKJIUwb6E6Y153kYYYhKrrwEoRkAFJie5JK95xHjOEwwS9KT6
         5mOXj8tvVn/85I12cZP2b9YzgEtPHIiHOrse4K7FP4ELFiwuSbz6pMnNbOQ8wP/b12is
         P3u7o+wTLdNRMqrRV+5GtJOoSqE2a18K2bv41Q0zbVPHgTJRPnlqXPd8Od0sQHx7xBFT
         yORg==
X-Forwarded-Encrypted: i=1; AJvYcCVLKCAF5s60KvKbdmj2ANWSanIPyyxMPvffKioq4vIv3yLUsdHN3J2tlkmAZZbXKKpVK7kWddI2OYf6/ZHLNFFCBx6bjJM8BrJdDWBMF6gprlxJzYzsTdaCZIU1rUXsti3cMketuP9U4Uc=
X-Gm-Message-State: AOJu0YyAZmugM93aHYRrxFkNZrtc2MYDMBgy9VsUHSmfcJG+ABFJAQ89
	xSmKGoIjSVo6ImdGOzAH3lHEJtIbpoOLB/X1RqlcCbi2UL+OSS9D
X-Google-Smtp-Source: AGHT+IHU3Zavq1b5sJ1h5Gqon0lsIzweoqKCAqL201Zh5liQSWm8whQAeuBgJqPoB0zix6qQ1YLW4Q==
X-Received: by 2002:a05:6512:963:b0:512:f92e:b2ee with SMTP id v3-20020a056512096300b00512f92eb2eemr3108967lft.13.1708976461012;
        Mon, 26 Feb 2024 11:41:01 -0800 (PST)
Received: from localhost.localdomain (c83-255-24-248.bredband.tele2.se. [83.255.24.248])
        by smtp.googlemail.com with ESMTPSA id e21-20020a196915000000b00512ffb9bae9sm332328lfc.143.2024.02.26.11.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 11:41:00 -0800 (PST)
From: Jonathan Bergh <bergh.jonathan@gmail.com>
To: hdegoede@redhat.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 0/6] staging: media: atomisp: Fix various small code and code style formatting issues
Date: Mon, 26 Feb 2024 20:40:17 +0100
Message-Id: <20240226194023.69070-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches address a number of small code and code style formatting
including:
 * removing unneeded braces from single line statements
 * replace "unsigned *" with "unsigned int *"
 * remove spurious whitespace and ensure trailing statements are included 
   on a newline following a conditional statement
 * remove unneeded parentheses from conditional statement
 * remove unneeded "return" statement from void function, and finally
 * remove commented code and fix multiple block comments to meet the kernel
   code style guidelines.

Jonathan Bergh (6):
  staging: media: atomisp: Remove unnecessary braces from single line
    conditional statements
  staging: media: atomisp: Fixed "unsigned int *" rather than "unsigned
    *" declaration in variable declaration
  staging: media: atomisp: Ensure trailing statements are on a newline
    and remove spurious whitespaces
  staging: media: atomisp: Remove unnecessary parentheses from
    conditional statement
  staging: media: atomisp: Remove unneeded return statement from void
    function
  staging: media: atomisp: Remove old commented code and fix multiple
    block comment style

 drivers/staging/media/atomisp/pci/sh_css_sp.c | 109 +++++++++---------
 1 file changed, 57 insertions(+), 52 deletions(-)

-- 
2.40.1


