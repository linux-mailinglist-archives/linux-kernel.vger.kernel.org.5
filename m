Return-Path: <linux-kernel+bounces-163892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AB08B7562
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9E881F215F9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0918145337;
	Tue, 30 Apr 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD3TX3zD"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACE140384;
	Tue, 30 Apr 2024 12:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478763; cv=none; b=IBnwhE9oK+Ew7UiyAPWhB87ko/Q/DXGDl/D2cJd6i6FpsZzUMo8I+kFyJtBEPxsttVdt5NP5w2+/6DuL0HUG0rNlc7Fg+kzeh3YrLjR08ioXt+QCg51cl6tvPqr5klJuDI2AW/k7qXqjwc2SVPm49ScGlv/YXqDFDjL4tbkSMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478763; c=relaxed/simple;
	bh=bR3QmlDfhQeZK3/nzddsjkAyB6NL01lZ7SYdVCaJrBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YoimFDUpxtv0Rvvg8+2GPryZVBkBrhhk/6tVEZ/g0ofCWkF8/Oi5DnlR58c88kHdS1MbiVJ3RJ4yI7/+p1YGyk4/jKK3XXhAphrUAwKqXfqsSeoAedxPW0XK9m4RGS+qzBX6GVE34Vda/9bl+sN0G7FRPE6CCObSQgBuhUbtw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FD3TX3zD; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso15283785e9.3;
        Tue, 30 Apr 2024 05:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478759; x=1715083559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50O7JUjzPqq3MrEGeaDK/IH1iyedTVT6be/Or9mCL6k=;
        b=FD3TX3zDUh/lcXx+ccVYSw/xocVr4Q/2wMPqosUCp5PLOL+D1/l208uzAGEHfPVeuD
         kb178j/6ZhZjQeRdgyuYFZwTafZ6puZhCrQb9Soz4V//2hO3Zd90/b8lhBIG6TuMLrp4
         fKLJ8A1+J/NDJvxQItHlvPuCm1hPfcSsC4BxSJLjPCeJ60ue1Oj1SObIyfMRadyJm3oc
         QHZbljdqnmlEuWHNY47dYl/+h0NCMFkqtVnbASqudtA8p3/nuw+qGIP1BU2BtL13E+S4
         UWBX5Pj9WiBsNEmzNYiywFwod+XOhjJ7QDhH8pBEvNpIgdvuN3md8qMso+srfUHoAkv5
         ttxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478759; x=1715083559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50O7JUjzPqq3MrEGeaDK/IH1iyedTVT6be/Or9mCL6k=;
        b=g1ml9x1eg5QbV+w69ARPNaXkdliFL/KVPmlDwHdntEuIphz3UPbKAr8oesm7ruCpu+
         h1+LASDh8s7EC7KKk0SrjHVRzccpREiAgP/HkrMvWEXEotj84dZBX2pN6orf/ufs0R2d
         ecXvUX7IVk7eyRh+y9rdCdgNYaW6m/dGNwIeA5J/gH3iXJBqbpZ3TiC09J7laAS3fL+H
         rdENWmNiU791VN8BpbrbDbMLyTQC3RmWZocpmJiPekjERkpGSl7g1LQN1rrAPqxSqmv4
         56iaBkc00r4iuEQyasOjDkH74c40Q26EVf8wi2Ulzbi2rVeGD6HcIWHKcS2rNhi3KPYY
         qUKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwjzIFqiPfFHTSn0RG2JwftY6qSObjEX2Lq83hNK4ATqxLNqe5gvtJaHtoT9JY4jkn8ayAxhyMzOmsi0+kVCaTLYnywgG6JF146x8LMPZ0GpcOvbXKAodd085NTuWZrXjWeVF5efWY
X-Gm-Message-State: AOJu0YwPec8xut7DJwr7gtTKj0YUSxb/g2sVw6CIKkOAMlUb127Nuykw
	lyiIOmbft53lYiMeyak7vIhK3QMP40YafJ69dmvkCr+fEywfdVOji+NKiQ==
X-Google-Smtp-Source: AGHT+IHoswtU02obG7H9oSPi9PRewBFiNnqWHmYgp5VXU6PSBqYsk8bSbmrH+vIJNXuEBPXKoCIZmw==
X-Received: by 2002:a05:600c:3d9b:b0:41b:e94f:1e88 with SMTP id bi27-20020a05600c3d9b00b0041be94f1e88mr8679821wmb.24.1714478758721;
        Tue, 30 Apr 2024 05:05:58 -0700 (PDT)
Received: from debian.fritz.box ([93.184.186.109])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b0041bf45c0665sm11054324wmq.15.2024.04.30.05.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 05:05:58 -0700 (PDT)
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: 
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Hepp <andrew.hepp@ahepp.dev>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] iio: temperature: mcp9600: add newlines after if statements
Date: Tue, 30 Apr 2024 14:05:33 +0200
Message-Id: <20240430120535.46097-4-dima.fedrau@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430120535.46097-1-dima.fedrau@gmail.com>
References: <20240430120535.46097-1-dima.fedrau@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add newlines after if statements following coding guide lines.

Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
---
 drivers/iio/temperature/mcp9600.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/mcp9600.c b/drivers/iio/temperature/mcp9600.c
index 74e0782fb073..4003bc8c83d3 100644
--- a/drivers/iio/temperature/mcp9600.c
+++ b/drivers/iio/temperature/mcp9600.c
@@ -72,6 +72,7 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
 		ret = mcp9600_read(data, chan, val);
 		if (ret)
 			return ret;
+
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 62;
@@ -95,6 +96,7 @@ static int mcp9600_probe(struct i2c_client *client)
 	ret = i2c_smbus_read_byte_data(client, MCP9600_DEVICE_ID);
 	if (ret < 0)
 		return dev_err_probe(&client->dev, ret, "Failed to read device ID\n");
+
 	if (ret != MCP9600_DEVICE_ID_MCP9600)
 		dev_warn(&client->dev, "Expected ID %x, got %x\n",
 				MCP9600_DEVICE_ID_MCP9600, ret);
-- 
2.39.2


