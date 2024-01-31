Return-Path: <linux-kernel+bounces-45990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEE18438D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ACCE28BE7A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8B658ACB;
	Wed, 31 Jan 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYIjIA42"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA6B5D72A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689472; cv=none; b=amuzNjRjpxMoDAN/0vUW+ypNebzJlgQP37h9lM+8ER7V2zhUwaRp+kX5h2+Er4hp7sL3v+KxhQCXmE3xjf+//bbr6H450kEIyiJGaNaH1TUtNDU420g19VSfdHM24mx43NJ1UKTgvjW8NeZWSvBRf1hjmRgask4mbFSd3Syl7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689472; c=relaxed/simple;
	bh=ZnF7iKo/ZFbGkBB2MbsvheyNsQD3je4DZX7Au09k4DA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XZDg27InLcCf64MipnlRZ2fxfCO5b+vAWqDTxrZNHVMLkJMBsLYHnS1CvqRrgI6INDGbkdo1SfWXbq0Lv0oc1lpAVMSP9Dp0QxUHvtRhmnqaINE1hY0EikjDCXqqjS1r9Og90ooPV7TkvgayNcIcN2MXtnRzLtML8kDRbObRJ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LYIjIA42; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ae7681d03so2307831f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706689469; x=1707294269; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlKKphLBogbuT0RBIYdtdc5+J5iprMNNjA2TgZhIPr8=;
        b=LYIjIA424ArZUH+A6k1TiLRxSqxKvN+2UragETnPzGYK0XyY/A2i7KxJtNErzRIR3q
         obmGR+XJOmgITikXmLhtGZUIc143UjrT4xqWmBgj9+dYLCKmCTy2d3sa/lhKCbC9srPm
         ncVoEeAtyexe4Oq12f/ufI3wv5hc5Ofh2Adfgd+KbHgmk9FhZy2bG8fWxNw6UtT8gopP
         iunBbS+p7MHmkh+rerDWPHLWSSjeMvlAtT8z4nsn7qKKfl3puDlR9QQu8FLIV8VWXy5+
         3HE+2HIhaza176QAbvU0pqs5DvRXu5GegkWeolkthvbrNcr9FQqFKOQ4ZEyjNctmYSEY
         ycrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706689469; x=1707294269;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VlKKphLBogbuT0RBIYdtdc5+J5iprMNNjA2TgZhIPr8=;
        b=S/fv1f3E4/740TREZy73qjE5hVgJ/1K0yrkGsBu+p+vO/mmmDdB6UuTahVhb97kV1H
         6csWrLAKeqBr1O9MUGwSbFP3Cho7GLg5VMFIRS9F7HhrrMcKG/OvTOvhLsAeQ6Q9tdYw
         0RawgssKBlox/vsRFf7CsDngsiooihr7q7/awqV2f7DheiYSm9xxVT7zzdFlItG7GKne
         aNwdcMn8y43kBXBCyvYr/PmRjRBlSuR1s1iifqXhqZh/CzCynlf9LtuNRuhOFnt3Qd9g
         J7QPUyZ0ZatVQ9U3ucuoPZUtWoO+uR1Pfom4LTQaniqWnHMH8KPISxFT1UaQG6DjPvLD
         uH7g==
X-Gm-Message-State: AOJu0Ywug5+Ss7x6qpPSRovojJsKtTCtY9CgEySxXN8fIXcbWxcWWUC2
	uft1w7B5bFfIv4Bu4248WCpkbb/4f96pP6MruObGfZ4zE4yXTZL/+umnhLkjkkY=
X-Google-Smtp-Source: AGHT+IG/KsmeYrAxJSxpF1zN165aGnxdGMtGJFaiuGGf+pE/DxpE2WAhuz1IAOCKENhXBOFFshzNUA==
X-Received: by 2002:a05:6000:25b:b0:33a:e52b:5a36 with SMTP id m27-20020a056000025b00b0033ae52b5a36mr470161wrz.44.1706689469111;
        Wed, 31 Jan 2024 00:24:29 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id bj26-20020a0560001e1a00b0033ae6530969sm10016575wrb.85.2024.01.31.00.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:24:28 -0800 (PST)
Date: Wed, 31 Jan 2024 11:24:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Muralidhara M K <muralidhara.mk@amd.com>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RAS/AMD/ATL: Fix array overflow in
 get_logical_coh_st_fabric_id_mi300()
Message-ID: <279c8b5e-6c00-467a-9071-9c67926abea4@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Check against ARRAY_SIZE() which is the number of elements instead of
sizeof() which is the number of bytes.  Otherwise we potentially read
beyond the end of the phy_to_log_coh_st_map_mi300[] array.

Fixes: 453f0ae79732 ("RAS/AMD/ATL: Add MI300 support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/ras/amd/atl/denormalize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
index d5d0e1fda159..49a900e066f1 100644
--- a/drivers/ras/amd/atl/denormalize.c
+++ b/drivers/ras/amd/atl/denormalize.c
@@ -405,7 +405,7 @@ static const u16 phy_to_log_coh_st_map_mi300[] = {
 
 static u16 get_logical_coh_st_fabric_id_mi300(struct addr_ctx *ctx)
 {
-	if (ctx->inst_id >= sizeof(phy_to_log_coh_st_map_mi300)) {
+	if (ctx->inst_id >= ARRAY_SIZE(phy_to_log_coh_st_map_mi300)) {
 		atl_debug(ctx, "Instance ID out of range");
 		return ~0;
 	}
-- 
2.43.0


