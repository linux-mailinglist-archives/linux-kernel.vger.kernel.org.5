Return-Path: <linux-kernel+bounces-85608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD3186B83E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7FB2890A2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C0146015;
	Wed, 28 Feb 2024 19:34:26 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A518074413;
	Wed, 28 Feb 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148866; cv=none; b=NT6Ckm7cBV+Ixx5OiNbAa0I3c6QaxvC6qgC25rbuXXDZ+Nb4JF0B54sJpZimaM2ywVst3LfBUha8tzFDwMiiw3kxnj4mdSFCr59tWP3RSbrM70vrf7zRH4eZY3x9vdSwEXGuyNOqVqM6vZa8OD1aZhqxIL8N2lUlLGeJnUZ2mXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148866; c=relaxed/simple;
	bh=LgHMLmZ3B9+if+YLWmC0cwloFFwAeSKM4B43rv1AAQc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ji8Gkx2AkTw9r8oj6Q0ffCnuwgeOsQpHNxjGBi4vmebBv0ExzlvBqtNXod4LyrDGkcp8oObOeu9opwOpnHir1aO+tw2fgWVCHbrFkD6gRrn1aEYxi+ghyIghcsZvYc1C2c1xuxQCJ/SJVTh+9siT1zQLCr942uia0R0M4vAnAPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a0b0a2819cso1407eaf.0;
        Wed, 28 Feb 2024 11:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709148863; x=1709753663;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A5mnk5isv+Ow9mB/9wVFebffEZwvAonqMS9uw1eCA2c=;
        b=WqtZPXZW+0cuV7URzldM73m721f5eLvudmDJCFxOBLI6Wwfhzp9+wJ2JUwPMY84Sbn
         Pu7YpM4ID5Btzmpu5n1siEegymrfz3/LOTkfrFXqq0K80mYNrDFVMeCgPiskbcIWOCnY
         Lz2LTS8VOBp4oosWh8j/R6qRk21Pg1JLijFR4ksJ15Q9qh/wYbpJ/WlGjty36zYtzW3o
         1OpeAEk0uWdx5EP5tMjeWY+t744zy1J7UTYZTbjceNhV5uHmdbJgfpc2EVMi2c9lFajW
         hZih1P6Y0pkiwRUIFyniP2ZopoJ9BqoFq5DVsNGv8n1uiPv/hWjM4SP3zXS2y+Wu6EQt
         FQGg==
X-Forwarded-Encrypted: i=1; AJvYcCWAC+tw8P6Sq4YJ1l6f2MfXN0qwV3vBKqXLuCbcp9YJE2+t7fZFZn7sLL2+/dmxIohYsw0wK3m6Wjpa0gxK3sWmPnjAUt2ySsO35EWm
X-Gm-Message-State: AOJu0YxhK2uW37hDuJ8B3NoTDMCfAJwNVf0a4IJ7TaajmnYx/oAUeVSf
	QzmFmBGhL8r6sxUq+RFntm/m0V3zw8Vbr/oitShDi4Klu4X3B2XASif/XdWP0yOc4/3T0UPZaUn
	o50xWf6ttRwo98Y7ioryYvEehw8/OvQmQALA=
X-Google-Smtp-Source: AGHT+IGM6S6HH4tcOB529a9Om4/71BRSTCyU6EXlky0qwAbHxTg9/v/HnbWfYRJgXLpmTKFNHHTKNy4UolpgCt8uQ/Y=
X-Received: by 2002:a4a:d091:0:b0:5a0:4216:c5f0 with SMTP id
 i17-20020a4ad091000000b005a04216c5f0mr80191oor.0.1709148863337; Wed, 28 Feb
 2024 11:34:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Feb 2024 20:34:12 +0100
Message-ID: <CAJZ5v0gF5hjMi7m-uUtG7oeTe1Yn2TFSRp3Htv7ULkf4J-Tb8g@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.8-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.8-rc7

with top-most commit f0a0fc10abb062d122db5ac4ed42f6d1ca342649

 cpufreq: intel_pstate: fix pstate limits enforcement for adjust_perf call back

on top of commit b401b621758e46812da61fa58a67c3fd8d91de0d

 Linux 6.8-rc5

to receive a power management fix for 6.8-rc7.

This fixes a latent bug in the intel-pstate cpufreq driver that has been
exposed by the recent schedutil governor changes (Doug Smythies).

Thanks!


---------------

Doug Smythies (1):
      cpufreq: intel_pstate: fix pstate limits enforcement for
adjust_perf call back

---------------

 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

