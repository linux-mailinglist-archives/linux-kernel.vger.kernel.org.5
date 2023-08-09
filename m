Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9281E775524
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjHIIZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjHIIZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:25:44 -0400
X-Greylist: delayed 940 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 01:25:42 PDT
Received: from m134.mail.163.com (m134.mail.163.com [220.181.13.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B23910FF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 01:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=oHp+jpr2vjkADTuuXjUDaxCMWPhZA1J4C4yio+z8Mk0=; b=O
        Kuaol/OrCo5/7BxBXPtov+8KDvCObiHOvcBEV/lkj8EP+lxwS1owvNs6vNXfbKxi
        7lp4matpNn5JUW6yjZTIksJEla15xezmgDz5ui2TAWJ6wDRGxvHKCdFDgz1G3TYv
        0v3fqcATx8Bh8z0JGvfp8A8MxvnppGuWZp0qjbjNpE=
Received: from liubaolin12138$163.com ( [118.163.20.176] ) by
 ajax-webmail-wmsvr4 (Coremail) ; Wed, 9 Aug 2023 16:09:11 +0800 (CST)
X-Originating-IP: [118.163.20.176]
Date:   Wed, 9 Aug 2023 16:09:11 +0800 (CST)
From:   "Baolin Liu" <liubaolin12138@163.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com
Cc:     hpa@zytor.com, "Baolin Liu" <liubaolin@kylinos.cn>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] x86/cpu/amd: Remove redundant break statements
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
X-NTES-SC: AL_QuySA/mdt00u5yedYekfm08VhOw8WMC1uP0k1IZSPJtwjC/k6yAcRXpDN1zf+d+vBCO+qBiXdB5hy9ZfRq9FVJwpj6g4oTdL98SlIhsqMVdY6A==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <396ba14d.2726.189d957b74b.Coremail.liubaolin12138@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: BMGowAAnjlWoSdNk7goIAA--.12812W
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/1tbitwjGylaEX-olIgAAsD
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQmFvbGluIExpdSA8bGl1YmFvbGluQGt5bGlub3MuY24+CgpUaGlzIGJyZWFrIGlzIGFm
dGVyIHRoZSByZXR1cm4gc3RhdGVtZW50LCBzbyBpdCBpcyByZWR1bmRhbnQgYW5kCnNob3VsZCBi
ZSBkZWxldGVkLgoKU2lnbmVkLW9mZi1ieTogQmFvbGluIExpdSA8bGl1YmFvbGluQGt5bGlub3Mu
Y24+Ci0tLQogYXJjaC94ODYva2VybmVsL2NwdS9hbWQuYyB8IDEgLQogMSBmaWxlIGNoYW5nZWQs
IDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2FtZC5jIGIv
YXJjaC94ODYva2VybmVsL2NwdS9hbWQuYwppbmRleCAyNmFkN2NhNDIzZTcuLmEyY2Q2OWQ5YzM5
ZCAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9hbWQuYworKysgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L2FtZC5jCkBAIC05OTYsNyArOTk2LDYgQEAgc3RhdGljIGJvb2wgY3B1X2hhc196
ZW5ibGVlZF9taWNyb2NvZGUodm9pZCkKIAogCWRlZmF1bHQ6CiAJCXJldHVybiBmYWxzZTsKLQkJ
YnJlYWs7CiAJfQogCiAJaWYgKGJvb3RfY3B1X2RhdGEubWljcm9jb2RlIDwgZ29vZF9yZXYpCi0t
IAoyLjM5LjIK
