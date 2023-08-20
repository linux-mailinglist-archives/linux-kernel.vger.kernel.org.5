Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF24E781CBA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 08:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjHTG5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 02:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjHTG5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 02:57:39 -0400
Received: from m1344.mail.163.com (m1344.mail.163.com [220.181.13.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BE994C26;
        Sat, 19 Aug 2023 23:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=MGMC5FFzeauFcLuqEiBTXCO7Tw+fo101a2jc/J9g6/Q=; b=E
        MnEn+clWqITMwplcxtsTvSSmSYX3F1plHA4jXZdwIYKBQejUBv7sx/RMzmtG0Tg5
        syNspZbi3OoX0HwWCcPlgqS8n5Yup1PkL/Zz6E8BqiEfDdMAP1izqNK5nYoPXQP1
        3jJ9aXgc3nyMCCPaRHFbgXvw+rNJ4ypbqsUq9j1ZTI=
Received: from 18500469033$163.com ( [114.250.138.216] ) by
 ajax-webmail-wmsvr44 (Coremail) ; Sun, 20 Aug 2023 14:30:59 +0800 (CST)
X-Originating-IP: [114.250.138.216]
Date:   Sun, 20 Aug 2023 14:30:59 +0800 (CST)
From:   "Dingyan Li" <18500469033@163.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re:[PATCH] USB: add new speed value to USB debugfs
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <20230818153509.38814-1-18500469033@163.com>
References: <20230818153509.38814-1-18500469033@163.com>
X-NTES-SC: AL_QuySAPmavEgu7yWebekXkkYVgew6WsC4vf4k3IReOps0hiny4CAMcER9EX322d2yNSa+iyO5dCBx98JffqdAZa2nVxTdQjPRv0PoHNoDPfLp
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <563084ba.e93.18a11a3c2f2.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LMGowAC38ukjs+Fkr14XAA--.41110W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbBZwfRy1et-+4uAwABs9
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXQgMjAyMy0wOC0xOCAyMzozNTowOSwgIkRpbmd5YW4gTGkiIDwxODUwMDQ2OTAzM0AxNjMuY29t
PiB3cm90ZToKPkN1cnJlbnQgbWF4IHNwZWVkIHN1cHBvcnRlZCBpbiBVU0IgZGVidWdmcyBpcyAx
MDAwMC4KPlNpbmNlIFVTQiAzLjIgR0VOXzJ4MiBoYXMgcmVhY2hlZCAyMDAwMCwgaXQncyBiZXR0
ZXIKPnRvIGFkZCBpdC4gVGhlIGlkZWEgaXMgYm9ycm93ZWQgZnJvbSBVU0Igc3lzZnMsIHdpdGgK
PmEgY29tYmluYXRpb24gb2YgVVNCX1NQRUVEX1NVUEVSX1BMVVMgYW5kCj5VU0JfU1NQX0dFTl8y
eDIsIHRoZSBhY3R1YWwgc3BlZWQgc2hvdWxkIGJlIDIwMDAwLgo+Cj5TaWduZWQtb2ZmLWJ5OiBE
aW5neWFuIExpIDwxODUwMDQ2OTAzM0AxNjMuY29tPgo+LS0tCj4gZHJpdmVycy91c2IvY29yZS9k
ZXZpY2VzLmMgfCA2ICsrKysrLQo+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvZGV2aWNlcy5jIGIv
ZHJpdmVycy91c2IvY29yZS9kZXZpY2VzLmMKPmluZGV4IGEyNDdkYTczZjM0ZC4uNzhlYmNiNjU3
ZGNlIDEwMDY0NAo+LS0tIGEvZHJpdmVycy91c2IvY29yZS9kZXZpY2VzLmMKPisrKyBiL2RyaXZl
cnMvdXNiL2NvcmUvZGV2aWNlcy5jCj5AQCAtNDI5LDcgKzQyOSwxMSBAQCBzdGF0aWMgc3NpemVf
dCB1c2JfZGV2aWNlX2R1bXAoY2hhciBfX3VzZXIgKipidWZmZXIsIHNpemVfdCAqbmJ5dGVzLAo+
IAljYXNlIFVTQl9TUEVFRF9TVVBFUjoKPiAJCXNwZWVkID0gIjUwMDAiOyBicmVhazsKPiAJY2Fz
ZSBVU0JfU1BFRURfU1VQRVJfUExVUzoKPi0JCXNwZWVkID0gIjEwMDAwIjsgYnJlYWs7Cj4rCQlp
ZiAodXNiZGV2LT5zc3BfcmF0ZSA9PSBVU0JfU1NQX0dFTl8yeDIpCj4rCQkJc3BlZWQgPSAiMjAw
MDAiOwo+KwkJZWxzZQo+KwkJCXNwZWVkID0gIjEwMDAwIjsKPisJCWJyZWFrOwo+IAlkZWZhdWx0
Ogo+IAkJc3BlZWQgPSAiPz8iOwo+IAl9Cj4tLSAKPjIuMjUuMQoKUGxlYXNlIGlnbm9yZSB0aGlz
IHBhdGNoLCB3aGljaCB3aWxsIGJlIGNvdmVyZWQgaW4gYW5vdGhlciBwYXRjaC4KU29ycnkgZm9y
IHRoZSBpbmNvbnZlbmllbmNlLgoKUmVnYXJkcywKRGluZ3lhbg==
