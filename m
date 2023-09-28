Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661A57B10D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjI1Cd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjI1CdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:33:25 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95C4894;
        Wed, 27 Sep 2023 19:33:21 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 10:32:02
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 10:32:02 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: Clean up errors in lpfc_debugfs.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7f56629a.8a3.18ad9a1036f.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD6i5RRli3y+AA--.585W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAJB2T8PZMAAQAgsY
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
ZWxzZSBzaG91bGQgZm9sbG93IGNsb3NlIGJyYWNlICd9JwpFUlJPUjogc3BhY2VzIHJlcXVpcmVk
IGFyb3VuZCB0aGF0ICc9JyAoY3R4OlZ4VikKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQg
dGhhdCAnPCcgKGN0eDpWeFYpCgpTaWduZWQtb2ZmLWJ5OiBLYWlMb25nIFdhbmcgPHdhbmdrYWls
b25nQGphcmkuY24+Ci0tLQogZHJpdmVycy9zY3NpL2xwZmMvbHBmY19kZWJ1Z2ZzLmMgfCA4ICsr
Ky0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfZGVidWdmcy5jIGIvZHJpdmVycy9z
Y3NpL2xwZmMvbHBmY19kZWJ1Z2ZzLmMKaW5kZXggZWE5YjQyMjI1ZTYyLi5mYTAzN2M3MGFhOTYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9scGZjL2xwZmNfZGVidWdmcy5jCisrKyBiL2RyaXZl
cnMvc2NzaS9scGZjL2xwZmNfZGVidWdmcy5jCkBAIC0yOTksOCArMjk5LDcgQEAgbHBmY19kZWJ1
Z2ZzX2hicWluZm9fZGF0YShzdHJ1Y3QgbHBmY19oYmEgKnBoYmEsIGNoYXIgKmJ1ZiwgaW50IHNp
emUpCiAJCSBscGZjX2RlYnVnZnNfbGFzdF9oYnErKzsKIAkJIGlmIChscGZjX2RlYnVnZnNfbGFz
dF9oYnEgPj0gaSkKIAkJCWxwZmNfZGVidWdmc19sYXN0X2hicSA9IDA7Ci0JfQotCWVsc2UKKwl9
IGVsc2UKIAkJbHBmY19kZWJ1Z2ZzX2xhc3RfaGJxID0gMDsKIAogCWkgPSBscGZjX2RlYnVnZnNf
bGFzdF9oYnE7CkBAIC0zMjYsNyArMzI1LDcgQEAgbHBmY19kZWJ1Z2ZzX2hicWluZm9fZGF0YShz
dHJ1Y3QgbHBmY19oYmEgKnBoYmEsIGNoYXIgKmJ1ZiwgaW50IHNpemUpCiAJCWhicXMtPm5leHRf
aGJxUHV0SWR4LCBoYnFzLT5sb2NhbF9oYnFHZXRJZHgsIGdldGlkeCk7CiAKIAloYnFlID0gKHN0
cnVjdCBscGZjX2hicV9lbnRyeSAqKSBwaGJhLT5oYnFzW2ldLmhicV92aXJ0OwotCWZvciAoaj0w
OyBqPGhicXMtPmVudHJ5X2NvdW50OyBqKyspIHsKKwlmb3IgKGogPSAwOyBqIDwgaGJxcy0+ZW50
cnlfY291bnQ7IGorKykgewogCQlsZW4gKz0gIHNjbnByaW50ZihidWYrbGVuLCBzaXplLWxlbiwK
IAkJCSIlMDNkOiAlMDh4ICUwNHggJTA1eCAiLCBqLAogCQkJbGUzMl90b19jcHUoaGJxZS0+YmRl
LmFkZHJMb3cpLApAQCAtMzQzLDggKzM0Miw3IEBAIGxwZmNfZGVidWdmc19oYnFpbmZvX2RhdGEo
c3RydWN0IGxwZmNfaGJhICpwaGJhLCBjaGFyICpidWYsIGludCBzaXplKQogCQkJCQkJIlVudXNl
ZFxuIik7CiAJCQkJZ290byBza2lwaXQ7CiAJCQl9Ci0JCX0KLQkJZWxzZSB7CisJCX0gZWxzZSB7
CiAJCQlpZiAoKGogPj0gaGJxcy0+aGJxUHV0SWR4KSAmJgogCQkJCShqIDwgKGhicXMtPmVudHJ5
X2NvdW50K2xvdykpKSB7CiAJCQkJbGVuICs9ICBzY25wcmludGYoYnVmICsgbGVuLCBzaXplIC0g
bGVuLAotLSAKMi4xNy4xCg==
