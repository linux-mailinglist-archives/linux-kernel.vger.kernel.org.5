Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A40C7C5981
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346995AbjJKQsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjJKQsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:48:20 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A925B7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:48:18 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id qcDBqQT2LytxcqcNbqNBi2; Wed, 11 Oct 2023 16:48:15 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTPS
        id qcNYqeoUvCVtqqcNaqE5nj; Wed, 11 Oct 2023 16:48:14 +0000
X-Authority-Analysis: v=2.4 cv=RtLWkQqK c=1 sm=1 tr=0 ts=6526d1ce
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=J9R/PiKqv2o3jGxbVGXx4w==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=bhdUkHdE2iEA:10 a=oz0wMknONp8A:10 a=8_dukLawoc1J__1ghQYA:9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lrNVRxtmcUBMaOcugSW58dCqLe+RokwwhirKqMzcqNU=; b=Up+vNPJc8aNa1CFbxB3+Bal1YL
        6abewxA2+uot+ldXt1koVoIV4a3dbvN1LXtJxQBu+Z3NVDc9Bp0eOHuojICxpMmpJS65PD1DBOfym
        PUix9mnFh7snVqnuL5esWCqCiRrALIJdjQRU5JOfANmx/NBcSbNmBlMq+d1RrYRq0rSKc66jA5O+o
        zk1BT8luT/sOaoCXVmiPFwqznkA9zYxVM9YfB1vdV7ckCGjNAAKRS5eeikD1gLpXX1Ea0hdxFOf0o
        ozKI7nQ0EDcco7OJy1Pe1Wmd4AE3FfravXHxGSjXZvMCc5662ZIUtQDnENr7oAeEqK3jjc2sVLkeT
        /DhIegSA==;
Received: from [103.186.120.251] (port=36530 helo=discovery..)
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.1)
        (envelope-from <saravanan@linumiz.com>)
        id 1qqcNX-002Xlh-1W;
        Wed, 11 Oct 2023 22:18:11 +0530
From:   Saravanan Sekar <saravanan@linumiz.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Saravanan Sekar <saravanan@linumiz.com>
Subject: [PATCH v4 0/4] Add support for mpq2286 PMIC IC
Date:   Wed, 11 Oct 2023 22:17:50 +0530
Message-Id: <20231011164754.449399-1-saravanan@linumiz.com>
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
X-Exim-ID: 1qqcNX-002Xlh-1W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (discovery..) [103.186.120.251]:36530
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 3
X-Org:  HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBuK9+O2E2eqQlRnCtlPLsXC9a+JEbSxchykfX3uq6kxsYOnQdKQmP47KLAHP42yyi6EtFRhrdncoke+FUTTZZAi11vt1fQqwI/25jrTpFrOUUJ3VF9m
 eEZ2+/WkDYRTgPmImyaAfkxXhEqrQJGBtLXbnEZLOT2XASYrk0LHqxDIfOqJM9l4Qp7RjG8h87fQ76JX9MKIgCUOmpMSUbJcruM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

changes in v4:
 - dt-binding changed regulator node and name from 'buck0' to 'buck'
 - added new pmbus regulator helper to define single regulator and used in mpq2286 driver

changes in v3:
 - dt-binding commit message updated the reason for 'buck0' is used instead of 'buck'

changes in v2:
 - fix dt check warnings
 - fix compiler warning on cast device_get_match_data and lexicological order of compatible



The MPQ2286 is a programmable, high frequency synchronous buck regulator with
integrated internal high side and low side power MOSFET. Application in
Automotive compenents such as ADAS, Infotainment, SOC System core, DDR memory.



Saravanan Sekar (4):
  hwmon: (pmbus/mpq7932) Get page count based on chip info
  regulator: dt-bindings: Add mps,mpq2286 power-management IC
  hwmon: (pmbus/core) Add helper macro to define single pmbus regulator
  hwmon: (pmbus/mpq2286) Add a support for mpq2286 Power Management IC

 .../bindings/regulator/mps,mpq2286.yaml       | 59 +++++++++++++++++++
 drivers/hwmon/pmbus/mpq7932.c                 | 19 ++++--
 drivers/hwmon/pmbus/pmbus.h                   | 15 +++++
 3 files changed, 89 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq2286.yaml

-- 
2.34.1

