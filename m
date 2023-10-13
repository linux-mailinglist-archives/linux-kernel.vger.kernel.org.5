Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70E37C7BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjJMDDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMDDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:03:06 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7B5BA9;
        Thu, 12 Oct 2023 20:03:03 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 11:01:21
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 11:01:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     linux@armlinux.org.uk
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: sfp: Clean up errors in sfp.h
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1a7c167f.942.18b26fb3ec9.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBn+D0Bsyhl7dfBAA--.682W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQADEWUnvzMAGQAIsM
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc9JyAoY3R4OlZ4VykKClNpZ25lZC1vZmYtYnk6
IEd1b0h1YSBDaGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGluY2x1ZGUvbGludXgvc2Zw
LmggfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0
aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc2ZwLmggYi9pbmNsdWRlL2xpbnV4
L3NmcC5oCmluZGV4IDkzNDZjZDQ0ODE0ZC4uNzI1YzgzODFhMzQ3IDEwMDY0NAotLS0gYS9pbmNs
dWRlL2xpbnV4L3NmcC5oCisrKyBiL2luY2x1ZGUvbGludXgvc2ZwLmgKQEAgLTI4OSwxMCArMjg5
LDEwIEBAIGVudW0gewogCVNGRjgwMjRfRU5DT0RJTkdfOEIxMEIJCT0gMHgwMSwKIAlTRkY4MDI0
X0VOQ09ESU5HXzRCNUIJCT0gMHgwMiwKIAlTRkY4MDI0X0VOQ09ESU5HX05SWgkJPSAweDAzLAot
CVNGRjgwMjRfRU5DT0RJTkdfODQ3Ml9NQU5DSEVTVEVSPSAweDA0LAorCVNGRjgwMjRfRU5DT0RJ
TkdfODQ3Ml9NQU5DSEVTVEVSID0gMHgwNCwKIAlTRkY4MDI0X0VOQ09ESU5HXzg0NzJfU09ORVQJ
PSAweDA1LAogCVNGRjgwMjRfRU5DT0RJTkdfODQ3Ml82NEI2NkIJPSAweDA2LAotCVNGRjgwMjRf
RU5DT0RJTkdfODQzNl9NQU5DSEVTVEVSPSAweDA2LAorCVNGRjgwMjRfRU5DT0RJTkdfODQzNl9N
QU5DSEVTVEVSID0gMHgwNiwKIAlTRkY4MDI0X0VOQ09ESU5HXzg0MzZfU09ORVQJPSAweDA0LAog
CVNGRjgwMjRfRU5DT0RJTkdfODQzNl82NEI2NkIJPSAweDA1LAogCVNGRjgwMjRfRU5DT0RJTkdf
MjU2QjI1N0IJPSAweDA3LApAQCAtMzA2LDExICszMDYsMTEgQEAgZW51bSB7CiAJU0ZGODAyNF9D
T05ORUNUT1JfTVRfUkoJCT0gMHgwOCwKIAlTRkY4MDI0X0NPTk5FQ1RPUl9NVQkJPSAweDA5LAog
CVNGRjgwMjRfQ09OTkVDVE9SX1NHCQk9IDB4MGEsCi0JU0ZGODAyNF9DT05ORUNUT1JfT1BUSUNB
TF9QSUdUQUlMPSAweDBiLAorCVNGRjgwMjRfQ09OTkVDVE9SX09QVElDQUxfUElHVEFJTCA9IDB4
MGIsCiAJU0ZGODAyNF9DT05ORUNUT1JfTVBPXzFYMTIJPSAweDBjLAogCVNGRjgwMjRfQ09OTkVD
VE9SX01QT18yWDE2CT0gMHgwZCwKIAlTRkY4MDI0X0NPTk5FQ1RPUl9IU1NEQ19JSQk9IDB4MjAs
Ci0JU0ZGODAyNF9DT05ORUNUT1JfQ09QUEVSX1BJR1RBSUw9IDB4MjEsCisJU0ZGODAyNF9DT05O
RUNUT1JfQ09QUEVSX1BJR1RBSUwgPSAweDIxLAogCVNGRjgwMjRfQ09OTkVDVE9SX1JKNDUJCT0g
MHgyMiwKIAlTRkY4MDI0X0NPTk5FQ1RPUl9OT1NFUEFSQVRFCT0gMHgyMywKIAlTRkY4MDI0X0NP
Tk5FQ1RPUl9NWENfMlgxNgk9IDB4MjQsCi0tIAoyLjE3LjEK
