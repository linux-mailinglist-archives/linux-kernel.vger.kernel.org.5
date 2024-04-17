Return-Path: <linux-kernel+bounces-148381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A418A81C9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D700A1C22438
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F5813C8FB;
	Wed, 17 Apr 2024 11:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mf5vo22U"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E7813C80B;
	Wed, 17 Apr 2024 11:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352369; cv=none; b=DSHxx2+Azolzh2TUSDJ8IwHPCDguE3A471LC3btp0H06ShnjFdudrxDNVvMAstgj7tNOfGIYc6E27opwt+Ibaspv4yRygpKfXnKvhKC4yA5RzO8QTRCu5N2qD37zWF/ZHTyOxgb/b1rU37X31VzMFbc4HQu7KQULQjvNdx6F5As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352369; c=relaxed/simple;
	bh=w7BHAEPiiQBc4yWKlXf5U4hFIr0GRkCDbTurNwZBGIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uzahjZD5D6hA89A5CkgoCoaFyaJ0kWOUrAwEKdFQfAFTUsYO5K6IK0pBspq3+JlUS05RPnNdOZw2eYn1Shn6z9K133+I6I94MDX7RXoMiJJT9EgI1nQuohUB6gZDySoESzR5DVy7z5sE8rF9i3m8Ku5LxHz8M7w7verEG8skNNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mf5vo22U; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e83a2a4f2cso1456795ad.1;
        Wed, 17 Apr 2024 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713352367; x=1713957167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znDMqSNrCUVVeJoSgBWusZB6f7cZkebLOeep7UaYw2I=;
        b=mf5vo22UZMzJ5IaOYqrPYnABt5A2F08KexElEYkKcXrjz5PMU/3Hg0/SrRtRcFKp+P
         TOPu7cQPIRWZTPNLxGyRHpqwOzp0X+OBFzS7vrOEPfaPPFowvd3On4Ww7xUsuXiqIJG8
         bk3Bn07vJyTlDo/2vidmMw3F8Cai/FySQvLhlWgPOZR4/A5nELXkLu+An8Pg3J3sxJae
         SPFtOApmyFo5oGYNYfVvVXk43xh8IvEwc1FYHXqJs4/GnQCT6UEpgMmHEFaFcJY2VeMe
         KxPwMlVxuQ771Eh6CYx8PdfMwx0rZoffQYSsc/EzyX25v86wNSUltqdItkloqSmYeBEB
         eg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713352367; x=1713957167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znDMqSNrCUVVeJoSgBWusZB6f7cZkebLOeep7UaYw2I=;
        b=tk5AZTaASsu+GTN6mry2btbvIIJJuSpynvlywSYQ11zP4gLXRDQMXMJvBfXgMBz7Et
         Y7ri/EOD4bEsKjdPfIdXv3FDeefFTd5SbrYxO0gojpjhpGit4jjf0rPg/a/yYqDcqyJD
         X+1DxuhfdfZnbN3CkospsQj7p8VyRXqKh/v9WZoSynmCN35UCgLeWWRRuO9nd0e4s6JD
         A7mqCSNre66bQI1Gu+48hE24jrB74kpznVX19SGxpOg+9jIZN3uD+otIwoqE+p8g0G5K
         r9nTKLJw4tjv5/hZYf0gx0Zoa88l8bn53TUt2uq25TcTCH6EUYZgICNpsEfgfLVpR6Qu
         XMlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjfd3hgCyeP7ebMfJyWH7LEK8HL1I+fH/xL9Tqm4nG8btPkD1kwL411WYOJCPyxP7afeaxxg/f2Bi8OYYKYDl6NAIaehWXunRSFTj0pXt/NClEueBw9WRCFr40u6C7UD5HCGKzG1TMUVM77F68vQh4iH0kuvShkbnyYvvL8sZckEjf32eq
X-Gm-Message-State: AOJu0YyllOlFfeMUmJcAw4sVEW6u9x8+3cbGdUXakq2zxqojFQ4O3OJ/
	U6D8eednlh/5XTz2iea3JiAtdLabm/VHHl82xDwArUU39hOZ2ZjA
X-Google-Smtp-Source: AGHT+IE+7jE5rMkww8GfZhXX3Gzr8kiwnkpgZAPJUZevYXgXkmWFi8vPndhOEbfcR3EN8xOak2wB8A==
X-Received: by 2002:a17:902:d512:b0:1e4:3dd0:8ce0 with SMTP id b18-20020a170902d51200b001e43dd08ce0mr17745005plg.20.1713352366808;
        Wed, 17 Apr 2024 04:12:46 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id ju14-20020a170903428e00b001e2bb03893dsm11302713plb.198.2024.04.17.04.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 04:12:46 -0700 (PDT)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: eichest@gmail.com
Cc: alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	krzysztof.kozlowski+dt@linaro.org,
	linus.walleij@linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nick@shmanahar.org,
	nicolas.ferre@microchip.com,
	robh@kernel.org,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>
Subject: RE: [PATCH v4 0/4] Add a property to turn off the max touch controller if not used 
Date: Wed, 17 Apr 2024 08:12:30 -0300
Message-Id: <20240417111230.785623-1-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240417090527.15357-1-eichest@gmail.com>
References: <20240417090527.15357-1-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Our hardware has a shared regulator that powers various peripherals such
> as the display, touch, USB hub, etc. Since the Maxtouch controller
> doesn't currently allow it to be turned off, this regulator has to stay
> on when not used. This increases the overall power consumption. In order
> to turn off the controller when the system does not use it, this series
> adds a device tree property to the maxtouch driver that allows the
> controller to be turned off completely and ensurs that it can resume
> from the power off state.
>
> Changes since v3:
> - Move the power on part to mxt_start and the power off part to
>   mxt_stop. This allows to turn the touch controller off even when not
>   in use and not only when being suspended (Dmitry)
>
> Changes since v2:
> - Add Reviewed-by tags from Linus and Krzysztof to the dt-bindings patch
>
> Changes since v1:
> - Rename the property and change the description (Krzysztof, Linus,
> Dmitry, Conor)
>
> Stefan Eichenberger (4):
>   Input: atmel_mxt_ts - add power off and power on functions
>   Input: atmel_mxt_ts - move calls to register the input device to
>     separate function
>   dt-bindings: input: atmel,maxtouch: add poweroff-sleep property
>   Input: atmel_mxt_ts - add support for poweroff-sleep
>
>  .../bindings/input/atmel,maxtouch.yaml        |   6 +
>  drivers/input/touchscreen/atmel_mxt_ts.c      | 162 +++++++++++++-----
>  2 files changed, 124 insertions(+), 44 deletions(-)
>
> --
> 2.40.1
>

Reviewed-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Regards,
Joao Paulo


