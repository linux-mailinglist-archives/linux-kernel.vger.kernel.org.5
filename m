Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A567D2A96
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjJWGkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjJWGkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:40:11 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A64ED67
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9c96a82e93bso33727566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698043206; x=1698648006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rEMPoaqrAr584bmhMHYdUsDhpy12wr+01QsM/BCHbCI=;
        b=E9B+/glL55ltJcsdyRfdki0l/o7yhIAdZRLOyd8FaJUV52/IiZ8/wvjFU7nxJbVMy6
         rPFvSCA0Lh41RKTW8CwZyGctoYT0U3wK9eciuUVg3oolDcHmGvwBsLAUibF2hs9ShR+f
         EAx0swPyGPGqqIgsTW6JF6QqRRFuyaWuRiFUHLkUAsjW8zDDHT2yDe2jGcLkbd6SWGj5
         IiPF6WMoHfsiITSNb0rpFEgEKniZLCe5cJzPr/t5XQAxWkkCCebUXwkvNMGKYwpzkgBm
         2LvnZdVOfqcNenycVJIefdb1IvcRj+j7AllfaLcyjcqCpZedY88tOlfGou07UIWBCvRv
         C3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698043206; x=1698648006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEMPoaqrAr584bmhMHYdUsDhpy12wr+01QsM/BCHbCI=;
        b=wIQ73xZvk1Pg55CyStXh5wA/j2VobgWESVzHuCwNN8/+O6kl28+AOi3yNHtnT7oupW
         Yclt58WlGKSrFDv5sc3xRrWXvT8+VpqZ2FzXvLQROYTZx+pTUdem5N0zpf7qj1CC05xN
         b2erJA6iDlq3qvlrdqiLYFi1+O5SMnYCN0bzgGZF7yH7UjE/Tqdf8Bv8k98cexxuOad1
         lLb2fO5YJDtrqaUOcwvAVbPr23I6Adn6GvjrntDGCMiUxqYrzTvdgj1eVf5iKUBkg8hW
         fbjQehqFcOwWKjo2Un68f9UbNpegbjZf5MzHz9YmSlvP2rWMlcuLIGwmALQnN32r4RJp
         qdRw==
X-Gm-Message-State: AOJu0YygmQAGbK7u/YBXmXTnoPtRMdJpIEJkx9426xUIiribZp+aC2i1
        znf4TQOW4oXy5A0SLlD4Reg=
X-Google-Smtp-Source: AGHT+IEJEXXXpjEX50Iazdue/9QtEDeAgzztPJ8RGywLw8vA7t4HM4MMUXDezIS/uFkV8zbGBQnpPA==
X-Received: by 2002:a17:906:14da:b0:9c9:f8a3:621f with SMTP id y26-20020a17090614da00b009c9f8a3621fmr1549799ejc.6.1698043205996;
        Sun, 22 Oct 2023 23:40:05 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id v18-20020a1709063bd200b009737b8d47b6sm6026532ejf.203.2023.10.22.23.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 23:40:05 -0700 (PDT)
Date:   Mon, 23 Oct 2023 08:40:04 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] staging: rtl8192e: Remove unused variables from union
 tspec_body
Message-ID: <ffeb86f15454ec17d7fc2ce66151393b6757d0a7.1698042685.git.philipp.g.hortmann@gmail.com>
References: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1698042685.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variables to shorten code.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_Qos.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_Qos.h b/drivers/staging/rtl8192e/rtl819x_Qos.h
index 7f086b7a1b88..ac321952f7b3 100644
--- a/drivers/staging/rtl8192e/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192e/rtl819x_Qos.h
@@ -15,25 +15,8 @@ union qos_tsinfo {
 };
 
 union tspec_body {
-	u8		charData[55];
-
 	struct {
 		union qos_tsinfo ts_info;
-		u16	NominalMSDUsize;
-		u16	MaxMSDUsize;
-		u32	MinServiceItv;
-		u32	MaxServiceItv;
-		u32	InactivityItv;
-		u32	SuspenItv;
-		u32	ServiceStartTime;
-		u32	MinDataRate;
-		u32	MeanDataRate;
-		u32	PeakDataRate;
-		u32	MaxBurstSize;
-		u32	DelayBound;
-		u32	MinPhyRate;
-		u16	SurplusBandwidthAllowance;
-		u16	MediumTime;
 	} f;
 };
 
-- 
2.42.0

