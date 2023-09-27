Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729E77AFBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjI0HYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjI0HYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:24:06 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0794C10E;
        Wed, 27 Sep 2023 00:24:04 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 15:22:44
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 15:22:44 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] aic7xxx: Clean up errors in queue.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <262cfc7a.880.18ad584cd79.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBn+D1E2BNlSPC9AA--.627W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAKsZ
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
c3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwoKU2lnbmVkLW9m
Zi1ieTogR3VvSHVhIENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogZHJpdmVycy9zY3Np
L2FpYzd4eHgvcXVldWUuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9haWM3eHh4L3F1ZXVlLmgg
Yi9kcml2ZXJzL3Njc2kvYWljN3h4eC9xdWV1ZS5oCmluZGV4IGY2ZTk1OGE1Zjk3My4uNzMzOGQ5
M2QyZjk1IDEwMDY0NAotLS0gYS9kcml2ZXJzL3Njc2kvYWljN3h4eC9xdWV1ZS5oCisrKyBiL2Ry
aXZlcnMvc2NzaS9haWM3eHh4L3F1ZXVlLmgKQEAgLTE4Nyw3ICsxODcsNyBAQCBzdHJ1Y3QgewkJ
CQkJCQkJXAogI2RlZmluZQlTVEFJTFFfRklSU1QoaGVhZCkJKChoZWFkKS0+c3RxaF9maXJzdCkK
IAogI2RlZmluZQlTVEFJTFFfRk9SRUFDSCh2YXIsIGhlYWQsIGZpZWxkKQkJCQlcCi0JZm9yKCh2
YXIpID0gU1RBSUxRX0ZJUlNUKChoZWFkKSk7CQkJCVwKKwlmb3IgKCh2YXIpID0gU1RBSUxRX0ZJ
UlNUKChoZWFkKSk7CQkJCVwKIAkgICAodmFyKTsJCQkJCQkJXAogCSAgICh2YXIpID0gU1RBSUxR
X05FWFQoKHZhciksIGZpZWxkKSkKIAotLSAKMi4xNy4xCg==
