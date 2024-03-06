Return-Path: <linux-kernel+bounces-93349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1519872E60
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E01F27789
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0331BC26;
	Wed,  6 Mar 2024 05:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yegcU/3w"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F220156C2
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 05:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709703080; cv=none; b=I/3vAZbqwAkA+RRyCOnDjA9ohP2ajYWMSdoYXLUgWenc/3IvPQ7ykmy8r5lsdGcSQFnHc867x0kZTJQcy3dzIVFFLACiF+uYsK4IoC8k6ZrpV0NSna2GiBud/9IhhzL3QZ/m3l6eGzqzTeshXxUzr9LmDfQQ84nBcpBK6UbmCdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709703080; c=relaxed/simple;
	bh=e8JwpfH2qwx+HnHr4hdjW4ovgJO7lyNp72wzuJ1ReKk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hqTJke3ABTBF+rxdCCMaLVcAN7rLj3KiMIwtN7fms8eXLCEAnB4dzUihv+beaCdk68fQ++u1eCeBbhxJCMLiLA10z8fhvJht8UKVKGvRQRcXymPSrqEz/pXxLyWffU8ctHWKr0rnpjQKuV+GF3JAaFUJLn/KgDEOLk5K0Utkp6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yegcU/3w; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5135486cfccso1871183e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 21:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709703077; x=1710307877; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ivmi9EgRcMkcjUO21DjDPofnmdLcHS1kN6hp05JrX+A=;
        b=yegcU/3wBuk8hSb60IcQGfu1422EvI+HDFQjkVpYetb+qgrKFBJStlyRFsuGBDkrFP
         qJ8BWV1wcb2X1jMoyez5PxBFutE80nTTWgkX20v502PCWIAWFJbo5LzGrwwiV9R0d1BL
         Ujn7M+jhf7i1s62apmNo817rUdGMMwO83mVf6yv4zM+QO08+jyEhseZG0v6LOobnuVbp
         I/XOXokUZj2EAFc5181EJ72nVjhb56KMa7kK8l1ksBN+6sCYKgBHU382zLfsxD1x0TXN
         S6pcl5pmueUnrmysr0+n72NQuHrnA+0Yr8EEo3ntZI6WmxldoRW+8xHvXZeTJTSStSNu
         Ei5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709703077; x=1710307877;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ivmi9EgRcMkcjUO21DjDPofnmdLcHS1kN6hp05JrX+A=;
        b=LftB1eoXBQXnS2F3/ADcKvIyXvOkhfk5oFChLVmWfGyvzSbYSCrVQZZSc2NQbyTCza
         Z6C4/BgdZPM5K60qp5q/ogUyU+UQBa1Ev9UwfeAqpDeUxWbJdK9vs1PfoyFcponNabwL
         /z7KIPB4gQEOmYFzPuXB1lwK6K2UTngINla9FdCaaGI6GMoXqAENSuWp20ApRocYAcnl
         3+AirnZEHNaFxkqJbd8YS8ma9+Oc7c7vbSTSWSloAeJcMXTl5gRI6nRY2qpcN5bN8Z0G
         z+a1TJ76efBZH0qktBTBziX6/wuxAPy0v21rtGCQsJXy+RgYBvwIxY9lIWao05aOjSc8
         fggw==
X-Forwarded-Encrypted: i=1; AJvYcCVX72wQN4Hnh+2cuVdXWlBtMva0+j2s61iCIeekbMGxQ2LHG3qz2K11dDtXEc+BgYLB//KJh3u1TFY2TCGJw5DdZC8nMKNKaKvoy+y1
X-Gm-Message-State: AOJu0YzjCuS3Nb+RuSU9HGp+wm0tMeEUzttQ2AsbZ18DoE6nUEQxHHRx
	mzQCVhNo9ET68JfozqvM8Se51ua7UeINvYAZWWzQwUu5IilbhbPVlZmaRsxiduA=
X-Google-Smtp-Source: AGHT+IHtDk/zN8qamO5T2ezKcWbmGSAbdouIyUYGl4G8wpORlh1ier2IgiPzw79t0QSYSHhV/9ZoNQ==
X-Received: by 2002:ac2:4188:0:b0:513:5d93:83ad with SMTP id z8-20020ac24188000000b005135d9383admr494662lfh.9.1709703076276;
        Tue, 05 Mar 2024 21:31:16 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c128f00b0041290cd9483sm22072535wmd.28.2024.03.05.21.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 21:31:16 -0800 (PST)
Date: Wed, 6 Mar 2024 08:31:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] thermal: core: remove unnecessary check in
 trip_point_hyst_store()
Message-ID: <3332079a-9548-4b19-bba9-69270be115ec@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code was shuffled around a bit recently.  We no longer need to
check the value of "ret" because we know it's zero.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/thermal/thermal_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 7c02d35384ce..5b533fa40437 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -181,7 +181,7 @@ trip_point_hyst_store(struct device *dev, struct device_attribute *attr,
 
 	mutex_unlock(&tz->lock);
 
-	return ret ? ret : count;
+	return count;
 }
 
 static ssize_t
-- 
2.43.0


