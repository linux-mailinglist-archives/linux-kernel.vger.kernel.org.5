Return-Path: <linux-kernel+bounces-87236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B686D17E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB081C228B5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1849A13440E;
	Thu, 29 Feb 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WB943cBX"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA1C7A153;
	Thu, 29 Feb 2024 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230109; cv=none; b=DassgjbWYcTVBfuCmLSN7jGv8dWinait/+LaktW/6UGPObTHgGnwndFEX2NUll74DvKw2GKtHO0JWoCnP/vsgaCJig+vaQZsqBLlYli+cRvg+hZKcrpBYOUQbBdskveCmW3eKQGrH0TutbEAmiJpZWlN+O4r5ihCmPal3pICYnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230109; c=relaxed/simple;
	bh=cMmRYHD7l7rXiyndG0v1AfcCH8YS9H0IG1JOZeauL8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SWNUwXKjsF6E25n4v1+a090Xq2fD7SvGiXyF8VAQU/GJbX8LBkAFzZIWeFwdVdat6pFKvlfahEh6Yh7j6QVejR1ZWlyPTPbmmXaH22pE3sFrHxHVkClRV8aW/8qukvbhxIkefukd2iyM9uTAHTp6UOfVVcZPj2yWGl7nKl1Nk+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WB943cBX; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412c24280ffso3930845e9.3;
        Thu, 29 Feb 2024 10:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709230106; x=1709834906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qwB5GZyUp0vVrDZTlAHMqUR9YgdQhpTvdvLOlvDAWYw=;
        b=WB943cBXAdQW+VUjN0C+XUVQyyUz+Akx3wualWc+jWOROf48YotWnzSLZR+vcc0Okq
         8eS56kglkh5rXU009IZxQCCDLlDBgzqT3fMxkD3V/y6/yNwj7mKOIJmiNcGwrkZwk3i0
         tu1Y1fQzC/0jvxN+/ySSP9c8BOia+iCeYaUXvvvhLIJS7xbXbEriv+w3bXKPTTPaH+81
         JwdE/L2H7rufGiXxFyyJOfaCfdECDV+Stt8v1lfJjNj+CCrsAxvFtqvqHVeoUU/llvEJ
         NhjM3GXJl/NVoFBznN0X5wdXePtKpA/3dFRl4trc4GRTuGVmM2mpTTb06T9+3rlT1dXd
         c+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230106; x=1709834906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qwB5GZyUp0vVrDZTlAHMqUR9YgdQhpTvdvLOlvDAWYw=;
        b=HjxR17vgkAvQjGGm81TJKgtOvrDdrw/RZT4H1LVy2e/hULxZH1WwRB4TaVYjlttO3w
         m7i9Mp2fk03C7q7QvoelXPFkrw1dnRk6TkrihgT22MyZ04fqMoJhZK7612FCMYAYM0rw
         7tIN64s5qt34YidbBDQ8Oi8BdshSqM3+JrsJpsMDK9lfSvAkWr3pi0K6G3bbReck8koL
         qIRFGOrjcV/wbwbFWMQdxydMxx5sVPQtKuEA/CyYDZD2FqNHibBXzqdJ0BsAYYH2nsFf
         wacoYSSCQANj4ru99RGJXq+gcnXuLCroq77LS/KmSGXlDhfLEuPmc03K6PDky0zYzBd1
         1xPg==
X-Forwarded-Encrypted: i=1; AJvYcCUHMlHYVhNzSbx0MwY6ph1gtWGhFViOwow5+mMATAafAXh0RNHXIyhTz5hRzzavzZYuhA5tPJCrf9NINJnqwXsyB2WGklvlP33lYeWlsXCAFbyPBKffFhy69Opw1pfuoSJei6AGXb1O
X-Gm-Message-State: AOJu0YxMJlZt56CiJvKrEYT3Ii+fo6n01XmmZrYwc/phLBYEbL9wQop2
	q7tx3UNtmTzhUVbJG5Du+UdcxJn16iMctH/6aLpMp4gzdh2afI+k
X-Google-Smtp-Source: AGHT+IEZKYVd5CNS62ZOeTW1t45K/wAl7v40CTb7k0y84DSHsDz8uEosVxEP4VjuXQYZ2hM2eto35A==
X-Received: by 2002:a05:600c:444e:b0:412:bef2:5a5 with SMTP id v14-20020a05600c444e00b00412bef205a5mr1746599wmn.16.1709230106109;
        Thu, 29 Feb 2024 10:08:26 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id z11-20020a1c4c0b000000b00412ba5cda16sm3100620wmf.33.2024.02.29.10.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 10:08:25 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 29 Feb 2024 19:07:49 +0100
Subject: [PATCH 4/7] clk: qcom: gcc-ipq9574: fix terminating of frequency
 table arrays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-freq-table-terminator-v1-4-074334f0905c@gmail.com>
References: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
In-Reply-To: <20240229-freq-table-terminator-v1-0-074334f0905c@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
 Devi Priya <quic_devipriy@quicinc.com>, 
 Anusha Rao <quic_anusha@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Georgi Djakov <gdjakov@mm-sol.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

The frequency table arrays are supposed to be terminated with an
empty element. Add such entry to the end of the arrays where it
is missing in order to avoid possible out-of-bound access when
the table is traversed by functions like qcom_find_freq() or
qcom_find_freq_floor().

Only compile tested.

Fixes: d75b82cff488 ("clk: qcom: Add Global Clock Controller driver for IPQ9574")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/clk/qcom/gcc-ipq9574.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index e8190108e1aef..0a3f846695b80 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -2082,6 +2082,7 @@ static struct clk_branch gcc_sdcc1_apps_clk = {
 static const struct freq_tbl ftbl_sdcc_ice_core_clk_src[] = {
 	F(150000000, P_GPLL4, 8, 0, 0),
 	F(300000000, P_GPLL4, 4, 0, 0),
+	{ }
 };
 
 static struct clk_rcg2 sdcc1_ice_core_clk_src = {

-- 
2.44.0


