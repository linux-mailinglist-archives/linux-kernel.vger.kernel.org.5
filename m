Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C231781C9A
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 08:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjHTGDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 02:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjHTGDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 02:03:22 -0400
Received: from m1344.mail.163.com (m1344.mail.163.com [220.181.13.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 644A224C00;
        Sat, 19 Aug 2023 22:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=fwhEx4wlFm4yYsaFszDjb6NVOhwAc7XdMehCTRFdgKs=; b=D
        9dsWqmfKr30TXf+utt+3acrTCZ6V1S5vfldeaKnd6oBN/WKgga38og/ylc/+jFM4
        xs87XGxaoGeP3deunM1zLKtW113FMOEfE15nKXEivU3I1P0ZCvtSgGIOa0NpV7gA
        HyGcxUpdYW2dfkv77HAsb5vA8Yvk2IiyTcO8HV2kLA=
Received: from 18500469033$163.com ( [114.250.138.216] ) by
 ajax-webmail-wmsvr44 (Coremail) ; Sun, 20 Aug 2023 13:29:11 +0800 (CST)
X-Originating-IP: [114.250.138.216]
Date:   Sun, 20 Aug 2023 13:29:11 +0800 (CST)
From:   "Dingyan Li" <18500469033@163.com>
To:     "Alan Stern" <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, hdegoede@redhat.com,
        xiaofanc@gmail.com, oneukum@suse.com, lists.tormod@gmail.com,
        sebastian.reichel@collabora.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] USB: Support 20Gbps speed for ioctl
 USBDEVFS_GET_SPEED
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <07c821ae-2391-474c-aec9-65f47d3fecf2@rowland.harvard.edu>
References: <79f3ec25.fa3.18a0c111fa9.Coremail.18500469033@163.com>
 <20230819054655.5495-1-18500469033@163.com>
 <07c821ae-2391-474c-aec9-65f47d3fecf2@rowland.harvard.edu>
X-NTES-SC: AL_QuySAPmbtksu5ySeY+kXkkYVgew6WsC4vf4k3IReOps0hiny4CAMcER9EX322d2yNSa+iyO5dCBx98JffqdAZa3uZYmMwqyRZHH6BCd1JCpu
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <75cfc7cb.b4c.18a116b2e2e.Coremail.18500469033@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LMGowABHkeinpOFkqVoXAA--.11016W
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/xtbBZwfRy1et-+4uAwAAs8
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkF0IDIwMjMtMDgtMjAgMDM6MDM6MDUsICJBbGFuIFN0ZXJuIiA8c3Rlcm5Acm93bGFuZC5oYXJ2
YXJkLmVkdT4gd3JvdGU6Cj4KPlRoaXMgd291bGQgbWFrZSBtb3JlIHNlbnNlIGlmIHlvdSBrZXB0
IHZlcnkgY2xlYXIgdGhlIGRpc3RpbmN0aW9uIAo+YmV0d2VlbiB0aGUgb3ZlcmFsbCBzcGVlZCBh
bmQgdGhlIHBoeXNpY2FsIGNvbW11bmljYXRpb24gbWVjaGFuaXNtLiAgSW4gCj5vdGhlciB3b3Jk
cywgMTAwMDAgYnBzIGlzIDEwMDAwIGJwcywgbm8gbWF0dGVyIHdoZXRoZXIgdGhlIHVuZGVybHlp
bmcgCj50ZWNobm9sb2d5IHVzZXMgb25lIGxhbmUgY2FycnlpbmcgMTAwMDAgYml0cyBwZXIgc2Vj
b25kIG9yIHR3byBsYW5lcyAKPmVhY2ggY2FycnlpbmcgNTAwMCBiaXRzIHBlciBzZWNvbmQuCj4K
PkknbSBub3Qgc3VyZSBpZiBhbnl0aGluZyBpbiB0aGUga2VybmVsIG9yIHVzZXJzcGFjZSByZWFs
bHkgY2FyZXMgYWJvdXQgCj50aGUgbnVtYmVyIG9mIGxhbmVzLCBhcyBvcHBvc2VkIHRvIHRoZSB0
b3RhbCBzcGVlZC4gIElmIGl0IHR1cm5zIG91dCAKPnRoYXQgbm90aGluZyBkb2VzLCB0aGUgdXNi
X3NzcF9yYXRlIGVudW1lcmF0aW9uIGNvdWxkIGJlIHJlbW92ZWQuICAKPkJlc2lkZXMsIGl0IHNo
b3VsZCBuYW1lZCBzb21ldGhpbmcgZWxzZSwgbGlrZSB1c2Jfc3NwX2dlbiBvciAKPnVzYl9zcF9n
ZW5lcmF0aW9uLCBzaW5jZSBpdCBpc24ndCBqdXN0IGEgcmF0ZSBkZXNpZ25hdGlvbi4gIChXaGVy
ZWFzIGFzIAo+ZW51bSB1c2JfZGV2aWNlX3NwZWVkIF9pc18ganVzdCBhIHJhdGUgZGVzaWduYXRp
b24uKQoKSXQgc2VlbXMgdGhhdCBkd2MzIGNvZGUgaGFzIGEgc2xpZ2h0bHkgZGlmZmVyZW50IGJl
aGF2aW9ycyBiZXR3ZWVuCkdFTl8xeDIgYW5kIEdFTl8yeDEsIHNvIGl0J3MgYmV0dGVyIHRvIGtl
ZXAgaXQuIEJ1dCBJIGFncmVlIHdpdGggeW91LgpJbiBlbnVtIHVzYl9kZXZpY2Vfc3BlZWQsIHdl
IG9ubHkgY2FyZSBhYm91dCBvdmVyYWxsIHNwZWVkIGluc3RlYWQgb2YKcGh5c2ljYWwgbGlua3Mu
IEFuZCB3ZSBjb3VsZCByZW5hbWUgdXNiX3NzcF9yYXRlIHRvIGEgbW9yZSBwcm9wZXIgbmFtZS4K
Cj5SZWdhcmRsZXNzIG9mIHdoYXQgaGFwcGVucyB0byB1c2Jfc3NwX3JhdGUsIHVzYl9kZXZpY2Vf
c3BlZWQgc2hvdWxkIGJlIAo+ZW5sYXJnZWQgdG8gZW5jb21wYXNzIGFsbCBwb3NzaWJsZSBleGlz
dGluZyBzcGVlZHMuICBUaGF0IHdvdWxkIAo+aW1tZWRpYXRlbHkgZml4IHRoZSBpb2N0bCBwcm9i
bGVtLiAgRG9pbmcgdGhpcyBpbiBhbiB1cHdhcmQtY29tcGF0aWJsZSAKPndheSBtaWdodCBlbmQg
dXAgYmVpbmcgYSBsaXR0bGUgYXdrd2FyZCBidXQgaXQgb3VnaHQgdG8gYmUgcG9zc2libGUuCgpU
aGFua3MgZm9yIHRoZSBkZXRhaWxlZCBleHBsYW5hdGlvbiwgd2hpY2ggbWFrZXMgdGhpbmdzIG1v
cmUgY2xlYXIuCkknbGwgdGFrZSB5b3VyIHN1Z2dlc3Rpb25zIGFuZCB0cnkgYWdhaW4uCgpSZWdh
cmRzLApEaW5neWFu
