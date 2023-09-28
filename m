Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910137B107A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjI1Bvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjI1Bvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:51:47 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 139A5AC;
        Wed, 27 Sep 2023 18:51:45 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 09:50:24
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 09:50:24 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Clean up errors in lpfc_sli.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <63d148.898.18ad97ae608.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDnhD_g2xRlU3e+AA--.590W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAJB2T8PZMAAQARsp
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
ImZvbyAqKiBiYXIiIHNob3VsZCBiZSAiZm9vICoqYmFyIgoKU2lnbmVkLW9mZi1ieTogR3VvSHVh
IENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0tLQogZHJpdmVycy9zY3NpL2xwZmMvbHBmY19z
bGkuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfc2xpLmggYi9kcml2ZXJzL3Nj
c2kvbHBmYy9scGZjX3NsaS5oCmluZGV4IGNkMzNkZmVjNzU4Yy4uMTAyNGY5MmRhOTYwIDEwMDY0
NAotLS0gYS9kcml2ZXJzL3Njc2kvbHBmYy9scGZjX3NsaS5oCisrKyBiL2RyaXZlcnMvc2NzaS9s
cGZjL2xwZmNfc2xpLmgKQEAgLTM3Niw3ICszNzYsNyBAQCBzdHJ1Y3QgbHBmY19zbGkgewogCQkJ
CQkgICBjbWQgKi8KIAogI2RlZmluZSBMUEZDX0lPQ0JRX0xPT0tVUF9JTkNSRU1FTlQgIDEwMjQK
LQlzdHJ1Y3QgbHBmY19pb2NicSAqKiBpb2NicV9sb29rdXA7IC8qIGFycmF5IHRvIGxvb2t1cCBJ
T0NCIGJ5IElPVEFHICovCisJc3RydWN0IGxwZmNfaW9jYnEgKippb2NicV9sb29rdXA7IC8qIGFy
cmF5IHRvIGxvb2t1cCBJT0NCIGJ5IElPVEFHICovCiAJc2l6ZV90IGlvY2JxX2xvb2t1cF9sZW47
ICAgICAgICAgICAvKiBjdXJyZW50IGxlbmdzIG9mIHRoZSBhcnJheSAqLwogCXVpbnQxNl90ICBs
YXN0X2lvdGFnOyAgICAgICAgICAgICAgLyogbGFzdCBhbGxvY2F0ZWQgSU9UQUcgKi8KIAl0aW1l
NjRfdCAgc3RhdHNfc3RhcnQ7CQkgICAvKiBpbiBzZWNvbmRzICovCi0tIAoyLjE3LjEK
