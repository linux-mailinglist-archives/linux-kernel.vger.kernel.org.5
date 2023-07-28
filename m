Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543F6766769
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234968AbjG1Ijg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234952AbjG1IjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:39:06 -0400
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF36826B8;
        Fri, 28 Jul 2023 01:38:37 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:2891:0:640:3c15:0])
        by forward502b.mail.yandex.net (Yandex) with ESMTP id 981BB5F0ED;
        Fri, 28 Jul 2023 11:38:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id YcI2XP9WsCg0-KV8EQUbP;
        Fri, 28 Jul 2023 11:38:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1690533515;
        bh=cADbdLeoKzZOD3mQs+6IRakZv6AymTm7Fvyj9O3QohU=;
        h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
        b=DkVa3zJh+vkeKhP+9eFyzwX0yhwS+cyQ7E3JZD7UsXPDKxDvxbMDfyndPCKFRsQIr
         8zYMbfGNskVF/2vWWVY10SqTInTSM9P8YtKvXludW0H0GHWvaHDqgS2tw6/2Aves0e
         uEwEXKUYL85UMaXWkqcxuikWgmO5BQ0NYz1VbkXg=
Authentication-Results: mail-nwsmtp-smtp-production-main-39.myt.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <5e35d1c2846eba80f7e1eef8ea625b6afd54ea80.camel@maquefel.me>
Subject: Re: [PATCH v3 03/42] clk: ep93xx: add DT support for Cirrus EP93xx
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Date:   Fri, 28 Jul 2023 11:38:34 +0300
In-Reply-To: <3fcb760c101c5f7081235290362f5c02.sboyd@kernel.org>
References: <20230605-ep93xx-v3-0-3d63a5f1103e@maquefel.me>
         <20230605-ep93xx-v3-3-3d63a5f1103e@maquefel.me>
         <3fcb760c101c5f7081235290362f5c02.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gU3RlcGhlbiEKCk9uIFRodSwgMjAyMy0wNy0yMCBhdCAxNjoyNyAtMDcwMCwgU3RlcGhl
biBCb3lkIHdyb3RlOgo+IFF1b3RpbmcgTmlraXRhIFNodWJpbiB2aWEgQjQgUmVsYXkgKDIwMjMt
MDctMjAgMDQ6Mjk6MDMpCj4gCj4gPiArc3RhdGljIGludCBjbGtfaHdfcmVnaXN0ZXJfZGl2KHN0
cnVjdCBlcDkzeHhfY2xrICpjbGssCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29uc3Qg
Y2hhciAqbmFtZSwKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb25zdCBjaGFyICpwYXJl
bnRfbmFtZSwKPiAKPiBQbGVhc2UgdHJ5IHRvIHBhc3MgYSBkaXJlY3QgcG9pbnRlciB0byB0aGUg
cGFyZW50IGNsa19odyBpbnN0ZWFkIG9yCj4gaWYKPiB0aGUgY2xrIGV4aXN0cyBvdXRzaWRlIHRo
ZSBjb250cm9sbGVyIHBhc3MgYSBEVCBpbmRleC4KCkknbGwgdXNlIHBhcmVudF9kYXRhIGV2ZXJ5
d2hlcmUsIGhvd2V2ZXIgaSBjdXJyZW50bHkgY2FuJ3QgcGFzcyAieHRhbGkiCmFzIGluZGV4LCBh
czrCoAoKLSBtb3ZlZCBhbGwgY2xrJ3MgdGhhdCBhcmUgbm90IHVzZWQgdmlhIGRldmljZSB0cmVl
IHRvIFNvQyBkcml2ZXLCoApodHRwczovL2xvcmUua2VybmVsLm9yZy9iNC1zZW50LzIwMjMwNjA1
LWVwOTN4eC12My03LTNkNjNhNWYxMTAzZUBtYXF1ZWZlbC5tZS8KCmFuZCBTb0MgZHJpdmVyIGlz
bid0IGEgT0YgY2xvY2sgcHJvdmlkZXIsIHNob3VsZCBpIG1ha2UgaXQgY2xvY2sKcHJvdmlkZXIg
YXMgd2VsbCA/CgoK

