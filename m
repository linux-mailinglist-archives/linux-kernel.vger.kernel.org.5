Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF77867DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbjHXGwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbjHXGwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:52:13 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3603101
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 23:52:10 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 24 Aug 2023 14:51:38
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Thu, 24 Aug 2023 14:51:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/df: Clean up errors in df_v1_7.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3f93eab5.639.18a26501c55.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD_7_eZkni2SAA--.482W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQANCmTl1A4ANAACsr
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
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc9JyAoY3R4Old4VikKRVJST1I6IG9wZW4gYnJh
Y2UgJ3snIGZvbGxvd2luZyBlbnVtIGdvIG9uIHRoZSBzYW1lIGxpbmUKClNpZ25lZC1vZmYtYnk6
IFh1ZUJpbmcgQ2hlbiA8Y2hlbnh1ZWJpbmdAamFyaS5jbj4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9kZl92MV83LmggfCAxMyArKysrKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2RmX3YxXzcuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Rm
X3YxXzcuaAppbmRleCA3NDYyMTEwNGM0ODcuLjIyYjNkNjZjNGY2NiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZGZfdjFfNy5oCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2RmX3YxXzcuaApAQCAtMjUsMTQgKzI1LDEzIEBACiAjZGVmaW5lIF9fREZfVjFf
N19IX18KIAogI2luY2x1ZGUgInNvYzE1X2NvbW1vbi5oIgotZW51bSBERl9WMV83X01HQ0cKLXsK
K2VudW0gREZfVjFfN19NR0NHIHsKIAlERl9WMV83X01HQ0dfRElTQUJMRSA9IDAsCi0JREZfVjFf
N19NR0NHX0VOQUJMRV8wMF9DWUNMRV9ERUxBWSA9MSwKLQlERl9WMV83X01HQ0dfRU5BQkxFXzAx
X0NZQ0xFX0RFTEFZID0yLAotCURGX1YxXzdfTUdDR19FTkFCTEVfMTVfQ1lDTEVfREVMQVkgPTEz
LAotCURGX1YxXzdfTUdDR19FTkFCTEVfMzFfQ1lDTEVfREVMQVkgPTE0LAotCURGX1YxXzdfTUdD
R19FTkFCTEVfNjNfQ1lDTEVfREVMQVkgPTE1CisJREZfVjFfN19NR0NHX0VOQUJMRV8wMF9DWUNM
RV9ERUxBWSA9IDEsCisJREZfVjFfN19NR0NHX0VOQUJMRV8wMV9DWUNMRV9ERUxBWSA9IDIsCisJ
REZfVjFfN19NR0NHX0VOQUJMRV8xNV9DWUNMRV9ERUxBWSA9IDEzLAorCURGX1YxXzdfTUdDR19F
TkFCTEVfMzFfQ1lDTEVfREVMQVkgPSAxNCwKKwlERl9WMV83X01HQ0dfRU5BQkxFXzYzX0NZQ0xF
X0RFTEFZID0gMTUKIH07CiAKIGV4dGVybiBjb25zdCBzdHJ1Y3QgYW1kZ3B1X2RmX2Z1bmNzIGRm
X3YxXzdfZnVuY3M7Ci0tIAoyLjE3LjEK
