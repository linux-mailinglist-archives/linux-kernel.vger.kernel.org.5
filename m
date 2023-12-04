Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CCC803AD9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbjLDQvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjLDQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:51:43 -0500
Received: from mxout014.mail.hostpoint.ch (mxout014.mail.hostpoint.ch [IPv6:2a00:d70:0:e::314])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F78DCA;
        Mon,  4 Dec 2023 08:51:48 -0800 (PST)
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout014.mail.hostpoint.ch with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96.2 (FreeBSD))
        (envelope-from <code@stefan-gloor.ch>)
        id 1rACAV-0007sl-1J;
        Mon, 04 Dec 2023 17:51:39 +0100
Received: from 157.20.79.83.dynamic.wline.res.cust.swisscom.ch ([83.79.20.157] helo=thinkpad.localdomain)
        by asmtp013.mail.hostpoint.ch with esmtpa (Exim 4.96.2 (FreeBSD))
        (envelope-from <code@stefan-gloor.ch>)
        id 1rACAV-000JX2-0e;
        Mon, 04 Dec 2023 17:51:39 +0100
X-Authenticated-Sender-Id: code@stefan-gloor.ch
From:   Stefan Gloor <code@stefan-gloor.ch>
To:     jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stefan Gloor <code@stefan-gloor.ch>
Subject: [PATCH v2 0/2] hwmon: sht3x: improve docs, read serial number
Date:   Mon,  4 Dec 2023 17:50:02 +0100
Message-ID: <20231204165004.8491-1-code@stefan-gloor.ch>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Vs-State: 0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The temperature/humidity sensors of the STS3x/SHT3x family are
calibrated and factory-programmed with a unique serial number.
For some sensors, this serial number can be used to obtain a calibration
certificate via an API provided by the manufacturer (Sensirion).
Expose the serial number via debugfs.

Documentation is missing information about the sts3x support, add it.

Changelog
=========

v1 -> v2:
	- Change from sysfs to debugfs
	- Add documentation improvements

In v1 I stated that the serial number readout was not
documented for the whole SHT3x/STS3x series. I found that there is a
separate document for SHT3x documenting this feature.
For STS3x, the manufacturer confirmed with me that both families work
identically. Therefore, it is not needed to introduce more IDs than "sts3x"
and "sht3x", as they don't have different functionality.

Stefan Gloor (2):
  hwmon: sht3x: add sts3x support
  hwmon: sht3x: read out sensor serial number

 Documentation/hwmon/sht3x.rst | 40 ++++++++++++++++++++-----
 drivers/hwmon/sht3x.c         | 55 +++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 8 deletions(-)

-- 
2.41.0

