Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74ADC7AFC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjI0Hbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjI0Hbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:31:36 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6942E10E;
        Wed, 27 Sep 2023 00:31:34 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 15:30:15
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 15:30:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [SCSI] aic7xxx: Clean up errors in scsi_iu.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <2217410b.882.18ad58bac2d.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3VUAH2hNlbPG9AA--.618W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAQsD
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
b3BlbiBicmFjZSAneycgZm9sbG93aW5nIHN0cnVjdCBnbyBvbiB0aGUgc2FtZSBsaW5lCgpTaWdu
ZWQtb2ZmLWJ5OiBHdW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBkcml2ZXJz
L3Njc2kvYWljN3h4eC9zY3NpX2l1LmggfCAzICstLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9haWM3eHh4
L3Njc2lfaXUuaCBiL2RyaXZlcnMvc2NzaS9haWM3eHh4L3Njc2lfaXUuaAppbmRleCAwZWFmZDNj
MTc3MzAuLjBmYjE4NmZiODA5NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9zY3NpL2FpYzd4eHgvc2Nz
aV9pdS5oCisrKyBiL2RyaXZlcnMvc2NzaS9haWM3eHh4L3Njc2lfaXUuaApAQCAtNCw4ICs0LDcg
QEAKICNpZm5kZWYJX1NDU0lfU0NTSV9JVV9ICiAjZGVmaW5lIF9TQ1NJX1NDU0lfSVVfSCAxCiAK
LXN0cnVjdCBzY3NpX3N0YXR1c19pdV9oZWFkZXIKLXsKK3N0cnVjdCBzY3NpX3N0YXR1c19pdV9o
ZWFkZXIgewogCXVfaW50OF90IHJlc2VydmVkWzJdOwogCXVfaW50OF90IGZsYWdzOwogI2RlZmlu
ZQlTSVVfU05TVkFMSUQgMHgyCi0tIAoyLjE3LjEK
