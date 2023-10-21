Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872F87D1C64
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjJUKPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjJUKPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:15:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B350D52
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:00 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507adc3381cso2368792e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697883299; x=1698488099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mA8KD11qpf6KZqgPVgnRyUQoU2OH4Y/VAnk/+JUKr/8=;
        b=HsYRIDweD6s9SqBTTvK5txr1pVJWUW1poRUonKHAb7xOM/H9LbwqMkB1ZguqYZgcbV
         Ml01dsiROGxr4Ntn2K+H3rkYJSIgtPtT0btPaWSoNFEpCrhe2nSLnHruHSUQLASMQFj9
         drydtZ+ekz0pM/0qR9gEgkXEOAg4mpp6bJkAem8ibPEWIIONCtqczxsILTVlAf+eos8v
         TiFfwcNT50tgfIJTN2xsOQk+8R8Z0XY8vux5W5b+HTFZKBniZYM+LgUMiY875Aw6iOe2
         77nmQvQIKw1z6S1irRa9n6Ub4Nij3tzYHrDHpFLzmfeM5dhQz6IWb+ptnQ7f53CXhEh4
         h4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697883299; x=1698488099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mA8KD11qpf6KZqgPVgnRyUQoU2OH4Y/VAnk/+JUKr/8=;
        b=LPY7CygUo22QaZh72w4BNktgU1Cs8X0sPFnqpCCGAefwJ/8l+cOnYZ0Fax1Pc6Kp4e
         N7Iojie8Uhj2kZuFLbm+YZhZc6UCuf0bHetZ2AU+IkwSSgzIyM5XEe6W1EX05Kl5HvhL
         YnDC2+HWFTQdChzOzrl4ZFamKVOmLpZs+6Gf+mlh3ZF62rxVT17MMlJYqmIG54hZCRjg
         2xACcgFgqeTcWHsbp7GzgQ5vDq1UDsEl3xmvb/znu1EQoqCL+D6EGCmDBTWvUNQV9Dxy
         LerN2DPtAQAHVPgCJ+aUh+s+mRslDNbDUazvBgJ8T8IQ1sUBmYTlHcIFI8qs9X6/GwZb
         DcuQ==
X-Gm-Message-State: AOJu0Yz+0oWXdc5EWOTFoIkRXcwtZx7nixHD4fL+lHQIWmSvoJEjL9jq
        5aTHouD0dXN9m/sIoX+N0Uc=
X-Google-Smtp-Source: AGHT+IFM9q6B8BGG10D4rtMe62hsk9wFcq8PPcVo8+WwGVZgFK5S/Oh8j2EyEzMsFep/6Xk+a7Kqnw==
X-Received: by 2002:a19:645c:0:b0:505:6c99:bd7c with SMTP id b28-20020a19645c000000b005056c99bd7cmr2539883lfj.57.1697883298782;
        Sat, 21 Oct 2023 03:14:58 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id d18-20020a056512369200b005007e7211f7sm803114lfs.21.2023.10.21.03.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Oct 2023 03:14:57 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH v3 2/7] staging: octeon: Fix up introduction of new typedef cvmx_helper_interface_mode_t  in octeon
Date:   Sat, 21 Oct 2023 12:12:33 +0200
Message-Id: <20231021101238.81466-3-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231021101238.81466-1-bergh.jonathan@gmail.com>
References: <20231021101238.81466-1-bergh.jonathan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the typedef for the following enum
cvmx_helper_interface_mode_t and then fixes up implementations that used
it.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
Changelog:                                                                 
v1 -> v2: Fix breaking change spread across multiple patches                
v2 -> v3: Break changes up into individual patches for each removed        
          typedef

 drivers/staging/octeon/ethernet.c     | 2 +-
 drivers/staging/octeon/octeon-stubs.h | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
index 9eee28f2940c..023b107e077a 100644
--- a/drivers/staging/octeon/ethernet.c
+++ b/drivers/staging/octeon/ethernet.c
@@ -798,7 +798,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
 
 	num_interfaces = cvmx_helper_get_number_of_interfaces();
 	for (interface = 0; interface < num_interfaces; interface++) {
-		cvmx_helper_interface_mode_t imode =
+		enum cvmx_helper_interface_mode imode =
 		    cvmx_helper_interface_get_mode(interface);
 		int num_ports = cvmx_helper_ports_on_interface(interface);
 		int port;
diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
index 9f269626b862..40c357c77679 100644
--- a/drivers/staging/octeon/octeon-stubs.h
+++ b/drivers/staging/octeon/octeon-stubs.h
@@ -220,7 +220,7 @@ enum cvmx_spi_mode {
 	CVMX_SPI_MODE_DUPLEX = 3
 };
 
-typedef enum {
+enum cvmx_helper_interface_mode {
 	CVMX_HELPER_INTERFACE_MODE_DISABLED,
 	CVMX_HELPER_INTERFACE_MODE_RGMII,
 	CVMX_HELPER_INTERFACE_MODE_GMII,
@@ -231,7 +231,7 @@ typedef enum {
 	CVMX_HELPER_INTERFACE_MODE_PICMG,
 	CVMX_HELPER_INTERFACE_MODE_NPI,
 	CVMX_HELPER_INTERFACE_MODE_LOOP,
-} cvmx_helper_interface_mode_t;
+};
 
 typedef enum {
 	CVMX_POW_WAIT = 1,
@@ -1265,7 +1265,7 @@ static inline void cvmx_pko_get_port_status(uint64_t port_num, uint64_t clear,
 					    cvmx_pko_port_status_t *status)
 { }
 
-static inline cvmx_helper_interface_mode_t cvmx_helper_interface_get_mode(int
+static inline enum cvmx_helper_interface_mode cvmx_helper_interface_get_mode(int
 								   interface)
 {
 	return 0;
-- 
2.40.1

