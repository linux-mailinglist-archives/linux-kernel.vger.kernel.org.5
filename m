Return-Path: <linux-kernel+bounces-111263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82508869DB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30DDFB2459A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE5B288AE;
	Fri, 22 Mar 2024 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgyK8vll"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F561CD3A;
	Fri, 22 Mar 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101737; cv=none; b=VhjoZCVmf1tytC4IhqvGGdtTxTyyaKGKpt3XKcjMSySQJP7EoL2LwufV+PFSAiVmb0+1eCqseFHtRFQmXjbB9OH/vYkTnvAiu/osR1n3dOqPt6NABoapqQtcf1cEr8U8iWY4MbhQuMJ2EvPchcA9u7Hg+sXU5h09EsaqLy0TUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101737; c=relaxed/simple;
	bh=xwO2GgqpC50T10uo56H5fZ1F/Cva/4TGI1G7gtL4FTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kJbILsRo8f1QZZAHKlAiesPnToRc8kH7pgC/c8mlvk6xXRiAh0VXmxSxN2lYXuxiQvnwt4GfnMpAnx1Bf2zSQvgWGo7SXxyw5GYsIJzDoP6iRXTO1QwuMDHc9MX0MQqmvlylHI87Ypz+Z1MqDRtI/N+mti7KeqzRStbeMuKwkz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgyK8vll; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-414776775d3so8483715e9.3;
        Fri, 22 Mar 2024 03:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711101734; x=1711706534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KEuis5nIZxSUD0Y1rFUxmo4rDQiSc5NzAI47vnYpsyA=;
        b=NgyK8vllvm21tpCa+cVYbK816/L/3cN39qmbLSf0DLuJt7if+rtWnOV29IaVkgHJl+
         I+73UHDt7jaK3yg43+1aa7TzaqnRg+MNUCgkzJVUaRXx36BEwcBwQgyw0XNCZ8r1++n3
         0BDZiwEXXT1TDECsTgx6wkJJvmlwftYttwwfeWfkguP7+ygDW+QRsR4e7J+0AW2cy/YM
         k0jmCfBfGFbTIwSqVI4KjigCCTWnS+W1W7FiMRl6rOeR7k6osZ2eqbj6gJegiLNmGHE7
         1kLdVPkT0dypzCUUNGY4k1EOn2PkipVFCxB+rZkkpHcznBEM0HY7IGLzaKX9Jay1A5B6
         hGag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711101734; x=1711706534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEuis5nIZxSUD0Y1rFUxmo4rDQiSc5NzAI47vnYpsyA=;
        b=SlerAQpWm3Rj2A3jydq+KmMIkEfTZPsQDhh72a9e5jjvwtF4i0RZpivAIzzkuOqaDR
         E+/WhmayKTGq3OTiI4EhLTKsmZsnMZE0/AsIXaKq1z9MZVZRQsrXofvIjwualuozfz6/
         uelEq+YsfK7KA1/ke6Od96eWTEv241F+IhQCYGrNwGwbB27GEczuIUs1WtEe7YwDPUVj
         8sVAyjY3qEG0VhGp062iwHoYNfHVJ2wvL5AI8pCVljQu6ZgSDHKPtHDFCcM2V9mCa/0J
         3ikWR5eeWGBomO9PwFbKG3HhAYnrIKdq7lVKZ0t/PJJVjBppkIOVvWsms3Ebit4cNGWv
         wzeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxvAzJolfNTVNSqW3q2jNArj8mSlwCbH+3mFjyd9chRdqJXPa9reMtTpyqDUMfnrl8GRgbjDmORham9z4iFoRZ1A6o0f+GgrLUVytgb0q1QdamlFqft2yYyWwyAFhCHa3kBhAw8sMl6TE=
X-Gm-Message-State: AOJu0YxW4ZBR7Wwe+K3gcW2EzbwMqVl+Ioa7HPmw3UsqtpxX4yp5y2sE
	e3qJ89hiO9X5jHP+Uj+ld0ks36SF3Oek7PFRTg32ubp1UQKOMnml
X-Google-Smtp-Source: AGHT+IEkxV6Q5FhFKRpkwDfODGvz1Og1M16UYVw6WcKTs48fuIKz6/c/KPjrKjswC7mMP9p6atydFg==
X-Received: by 2002:a05:600c:1394:b0:414:7384:1ec2 with SMTP id u20-20020a05600c139400b0041473841ec2mr1001920wmf.9.1711101733371;
        Fri, 22 Mar 2024 03:02:13 -0700 (PDT)
Received: from fedora.. ([94.73.33.46])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c4e8e00b0041413aefeb9sm8389434wmq.48.2024.03.22.03.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:02:12 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: jikos@kernel.org
Cc: benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v2 0/1] Expose firmware name to identify tablets in libwacom
Date: Fri, 22 Mar 2024 10:59:57 +0100
Message-ID: <20240322100210.107152-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

This patch exposes the UCLogic tablets firmware name to user userspace.

libwacom can use it to identify this family of tablets, which has been
very difficult until now because vendor keep reusing the same VIP/PID.

This is the PR consuming the new interface:
https://github.com/linuxwacom/libwacom/pull/620

Finally, I created a tool to generate a list of firmware name <-> table
model for UCLogic-like drawing tablets:
https://github.com/JoseExposito/uclogic-firmware-names

Best wishes,
José Expósito

v1 -> v2:
Store the fw name in hid->uniq instead of using sysfs.
Thanks to Benjamin for his review!

José Expósito (1):
  HID: uclogic: Expose firmware name

 drivers/hid/hid-uclogic-params.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.44.0


