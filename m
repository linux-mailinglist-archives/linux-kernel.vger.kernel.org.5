Return-Path: <linux-kernel+bounces-112795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD4A887E3B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25977B20D08
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B77D1B7E5;
	Sun, 24 Mar 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4dzoluR"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD61B26E;
	Sun, 24 Mar 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711303993; cv=none; b=QQjPt4ZPauFSVtY0FYJoROXZgmmw0KZZvzdoQY0gtzv0VbCMyFmOK62dhqXn3QsFkiDcBMIYr+VHgWrnVfHohl8WMReniCseyYylHGRV3tO7dLCPZy0XuEFcLbwkTEAl2xACsBTLOdPlMKhvwK8aKseASZGb/YyObVwx9x/5/qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711303993; c=relaxed/simple;
	bh=XgbBGGwGXULlxO4TSzA3FNjrXTBCw9cKpRq1y707mIA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=K9cXp4ho0DhmUUWF0Be6XEIj+TMq81cnEZMGtkJHL+oZmFN8PRlWKiSGcfEB4vsOmBvz0MlJvBl6MDvFRD7wFMR5YqIYFKMGlkZVd+CbnlFu8FKqYpIniRp9dXx9fazrV+YJJba4XTMyZb0Z+ao2D2wL4WgUiURVkbBrxDaOxRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4dzoluR; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4a387ff7acso2152366b.2;
        Sun, 24 Mar 2024 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711303990; x=1711908790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy7ZVUlfRPULLcIJsQocCw5EkeSKRhtzYUsef6lkqKw=;
        b=i4dzoluRABZNKAdgcyvbm2vYc3o/sHQ1eEKxrwLDwpQKqMdNb1Gtb5UeGer2soiWIN
         vXhU7eAExLP4Wo83MFszYfmUubC4ooeXwOiPz1E/9a4Jbo4mNXA4dol/t7smW/uGfjV6
         Mlds6tyhxWymyrf3yODuT6SD2BWZV5vg4njGaFZEwXuAYLb1DP/cOKRZm0FxtYDiYMDz
         v7aPVblaYZu8Ur9tf7hivhtYbap/CGWE44X34vsVyO3TzzGvvZhyEZZKc4WVVjnznRBS
         ixxtZ7dKQLWR4J+fDJHf5Zsw+391gDIUqL+cFzoIW7zWmFBFY9mQ3bw/GE0iAx8nJvG7
         VC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711303990; x=1711908790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dy7ZVUlfRPULLcIJsQocCw5EkeSKRhtzYUsef6lkqKw=;
        b=wfkF8CT4uaPYzZAbw5fKuz2Z+/2zD0qaOH7RPwICB9GMRqWQSgQ4uBbTXvPz4pVEh1
         Ku1v9I4U/2CryHxsTlMlRk2fc28ej8rd+7MlplMTThfoJAZRmblnckswgMHHe69QpMc/
         wRvz5SKAYF9Nu0Ng7NuPExh1VHHgV+4D0TcyBOwrMv3Wt6K0ozaYmU9W4kZIqTv4H678
         kqSBzVUp1kcE79fP29ag1ETMbjYRScxuTRmjVktlchakXVcxqS8E7krTJqCfwCJkVnyI
         aZ2chwJnPzvrEfCVY7PxcmRwEzrJJSVzyLYLV2D+s8vHU13F6YZNRzcievHUe6lMqy/Q
         Od2w==
X-Forwarded-Encrypted: i=1; AJvYcCXa+BW5UUyWgna9fFL56V60GWv5i7ZuKcnycFR5pViXk8C6fJmHzKzne2ysRbNNbGm/p0q+epkJGmPZNkLrj9e9AeJS9LEyUCLHn16TsFn/KRvFm+cCGA2DFHYxfq941vLpgpSP8hcOg2+yXGBfcZ0F80byPbKfTXT/IhTvJCnr56bd0z+HZZ+5qvjt3MexkGH6/izBRPEv9MPxyJIf8TYAf5p6A0O+UDlwfA==
X-Gm-Message-State: AOJu0Yz1xmAdrOTBbZpfZKRnH1WWlmqylQUjRJfntBEmcBoJ6KfvNWjE
	2WSFOOqhc80u5r+4UoT0QZa2p557WcZdPoGZ/ZvGFUsBb2yDw35Z
X-Google-Smtp-Source: AGHT+IHE2HZWu5qzpR+jX0UnZmejEC9L7cDk5g1U+zY+WqgnUfkf6nBAjxJl/3cYZwLBW8r1BvDgZQ==
X-Received: by 2002:a17:906:d0d7:b0:a47:5265:9aac with SMTP id bq23-20020a170906d0d700b00a4752659aacmr1227914ejb.55.1711303989992;
        Sun, 24 Mar 2024 11:13:09 -0700 (PDT)
Received: from localhost.localdomain ([94.120.85.57])
        by smtp.gmail.com with ESMTPSA id lb13-20020a170906adcd00b00a4750131edasm1085504ejb.206.2024.03.24.11.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 11:13:09 -0700 (PDT)
From: mustafa <mustafa.eskieksi@gmail.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	jdelvare@suse.com,
	linux@roeck-us.net,
	pavel@ucw.cz,
	lee@kernel.org,
	mustafa.eskieksi@gmail.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: [PATCH v5 0/1] platform/x86: Add wmi driver for Casper Excalibur laptops
Date: Sun, 24 Mar 2024 21:12:00 +0300
Message-ID: <20240324181201.87882-1-mustafa.eskieksi@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mustafa Ekşi <mustafa.eskieksi@gmail.com>

Hi,
I want to note that moving mutex_init to the bottom of the function
crashes the driver when mutex_lock is called. I didn't investigate it
further but I wanted to say that since Ai Chao also did it like that.

Driver sets all leds to white on start. Before that, when a led's
brightness is changed, that led's color gets set to white but others
keep their old colors which creates a bad user experience (at least for
me). Please inform me if this is a bad approach.
Also, this driver still lacks support for changing modes and I seek
advise for that.

Mustafa Ekşi (1):
  platform/x86: Add wmi driver for Casper Excalibur laptops

 MAINTAINERS                       |   6 +
 drivers/platform/x86/Kconfig      |  14 +
 drivers/platform/x86/Makefile     |   1 +
 drivers/platform/x86/casper-wmi.c | 641 ++++++++++++++++++++++++++++++
 4 files changed, 662 insertions(+)
 create mode 100644 drivers/platform/x86/casper-wmi.c

-- 
2.44.0


