Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988737BC924
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 18:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjJGQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 12:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343956AbjJGQ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 12:58:25 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AEBBA
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 09:58:23 -0700 (PDT)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTP
        id p7HfqoDFUIBlVpAckqdLtK; Sat, 07 Oct 2023 16:57:54 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTPS
        id pAd9qgUeWZLuepAdAq6xs5; Sat, 07 Oct 2023 16:58:20 +0000
X-Authority-Analysis: v=2.4 cv=E+reGIRl c=1 sm=1 tr=0 ts=65218e2c
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=J9R/PiKqv2o3jGxbVGXx4w==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=bhdUkHdE2iEA:10 a=oz0wMknONp8A:10 a=LxWt8M_ywhtm8WUVVfYA:9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=c5iYOT22elVfPNtUrUd4M1WiKLFX0mjQfvAI7rmkpE8=; b=P/UKBi+qsiNhVtsBY7AucgpHJ6
        1GPcyrYP+SuEc7jQR86Q1bYSDSdoNcg3L2baPYGenioeRHLp04LR8zHAS42OI8nvCaHWHA4bc1lnX
        FMb68N+QH/r3F3VwWkG98104CHc/VM7GDK8tAsGB/zrukkG1JiUwyGmUbGdn6+gAIEMDYnGxtVGao
        FYfyv/bZjvCN0DC3AVoefj8lm1jSmz9bYOBOCzUe1Tq4eMg/fvxIGV0YUIiimgG9X3KkSYVMWetcu
        j/iNPhwmZCIR/b8R8ABuu8CFz6gvG9vjQZCx1BtYac6d5qiVuQhviisCryXD9pCVaU8cfb4SPpVKH
        KkuvZZ9g==;
Received: from [103.186.120.251] (port=39748 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <saravanan@linumiz.com>)
        id 1qpAd7-002Tlj-3D;
        Sat, 07 Oct 2023 22:28:18 +0530
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v3 0/3] Add support for mpq2286 PMIC IC
Date:   Sat,  7 Oct 2023 22:28:00 +0530
Message-Id: <20231007165803.239718-1-saravanan@linumiz.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 103.186.120.251
X-Source-L: No
X-Exim-ID: 1qpAd7-002Tlj-3D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [103.186.120.251]:39748
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 3
X-Org:  HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDRETSmI3pA3vLOxOjbTAY8uiyQHweag1AD6WUrffdRKXugXLOyMgNdW22RVpxVLIQdWfxq4D9hQnLObR03yhKWwL8JjOp4AboYcdEZSFhEPDY16Gm+N
 47KvGryc+mT+wjqQ2ykp1eVrvD7kX16AiqdcgKZGM/orIy4ezzc1iJLHlBTC8cMZ144TLEoSyqCP++93GN4ST2xaDWUlTRUmhnw=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes in v3:
 - dt-binding commit message updated the reason for 'buck0' is used instead of 'buck'

changes in v2:
 - fix dt check warnings
 - fix compiler warning on cast device_get_match_data and lexicological order of compatible



The MPQ2286 is a programmable, high frequency synchronous buck regulator with
integrated internal high side and low side power MOSFET. Application in
Automotive compenents such as ADAS, Infotainment, SOC System core, DDR memory.


Saravanan Sekar (3):
  hwmon: (pmbus/mpq7932) Get page count based on chip info
  regulator: dt-bindings: Add mps,mpq2286 power-management IC
  hwmon: (pmbus/mpq2286) Add a support for mpq2286 Power Management IC

 .../bindings/regulator/mps,mpq2286.yaml       | 59 +++++++++++++++++++
 drivers/hwmon/pmbus/mpq7932.c                 |  9 ++-
 2 files changed, 65 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml

-- 
2.34.1

