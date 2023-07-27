Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C98C765121
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjG0K27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjG0K2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:28:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5D619AD;
        Thu, 27 Jul 2023 03:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0762D61E12;
        Thu, 27 Jul 2023 10:27:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE9BC433C9;
        Thu, 27 Jul 2023 10:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690453656;
        bh=fKIZ5MqPAyaVGlFdBkHtlz/zRB0AxCGG7ERibqg6qOU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pTRhOY60TYEmu08EC0C6HEEwvFrDMKQoUX7dFtCT4BptyM+juGe5SeCSVnHB/tUej
         c8YtXot6Bhw3WGekPavtoomQLN6HHxL/76TkENGC6ljgQCQUGMHE8ddbo01w3oQOk9
         8/zyGWJ3gGpjIkrX7JQmreIfc6jllmVL445PaWyJn7s2eARmtAVnnj+f6QFGkkSVOJ
         8qKrEnEvgeVSUWuUxImb5fk9wJpITm2YfAlNp87WTYa6woH0zfusqsUd9Zn0tibVNq
         KeLzeyaDGePDnY2rX8Srvz/rvPB9cyJjhLqSlHzdSYxDSlT8Co0EiTyu0PkCwzzqyg
         PDuV+Gh5pbO4Q==
Content-Type: multipart/mixed; boundary="------------oAWxdk5ed0hcZpvqb0D0WIQ2"
Message-ID: <48bc1736-5e4e-3a9b-3715-60509c333bb1@kernel.org>
Date:   Thu, 27 Jul 2023 19:27:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
Content-Language: en-US
To:     TW <dalzot@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
 <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
 <c70caa9e-164c-fee5-8f85-67f6d02373ab@kernel.org>
 <b0ed86e0-3e4a-d4d1-7b9d-c57f20538a80@gmail.com>
 <86435987-734e-c6c1-a857-1ba80da709fe@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <86435987-734e-c6c1-a857-1ba80da709fe@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------oAWxdk5ed0hcZpvqb0D0WIQ2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/23 19:22, TW wrote:
> I managed to fix the patch file, guess the formatting messed up a bit. So will
> try with those patches installed.

Just in case, patch fil attached to avoid formatting issues.


-- 
Damien Le Moal
Western Digital Research

--------------oAWxdk5ed0hcZpvqb0D0WIQ2
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ata-scsi-do-not-issue-START-STOP-UNIT-on-resume.patch"
Content-Disposition: attachment;
 filename*0="0001-ata-scsi-do-not-issue-START-STOP-UNIT-on-resume.patch"
Content-Transfer-Encoding: base64

RnJvbSAyOWU4MWQxMTgxMmVlOTI0ZDE5NDI1MzQzZWM2OWFjZDM0YWY5ZDM1IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwu
b3JnPgpEYXRlOiBNb24sIDI0IEp1bCAyMDIzIDEzOjIzOjE0ICswOTAwClN1YmplY3Q6IFtQ
QVRDSF0gYXRhLHNjc2k6IGRvIG5vdCBpc3N1ZSBTVEFSVCBTVE9QIFVOSVQgb24gcmVzdW1l
CgpTaWduZWQtb2ZmLWJ5OiBEYW1pZW4gTGUgTW9hbCA8ZGxlbW9hbEBrZXJuZWwub3JnPgot
LS0KIGRyaXZlcnMvYXRhL2xpYmF0YS1zY3NpLmMgIHwgNiArKysrKysKIGRyaXZlcnMvc2Nz
aS9zZC5jICAgICAgICAgIHwgNSArKystLQogaW5jbHVkZS9zY3NpL3Njc2lfZGV2aWNlLmgg
fCAxICsKIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2F0YS9saWJhdGEtc2NzaS5jIGIvZHJpdmVycy9h
dGEvbGliYXRhLXNjc2kuYwppbmRleCAzNzBkMThhY2E3MWUuLjYxODRjN2JjYzE2YyAxMDA2
NDQKLS0tIGEvZHJpdmVycy9hdGEvbGliYXRhLXNjc2kuYworKysgYi9kcml2ZXJzL2F0YS9s
aWJhdGEtc2NzaS5jCkBAIC0xMTAwLDcgKzExMDAsMTMgQEAgaW50IGF0YV9zY3NpX2Rldl9j
b25maWcoc3RydWN0IHNjc2lfZGV2aWNlICpzZGV2LCBzdHJ1Y3QgYXRhX2RldmljZSAqZGV2
KQogCQl9CiAJfSBlbHNlIHsKIAkJc2Rldi0+c2VjdG9yX3NpemUgPSBhdGFfaWRfbG9naWNh
bF9zZWN0b3Jfc2l6ZShkZXYtPmlkKTsKKwkJLyoKKwkJICogU3RvcCB0aGUgZHJpdmUgb24g
c3VzcGVuZCBidXQgZG8gbm90IGlzc3VlIFNUQVJUIFNUT1AgVU5JVAorCQkgKiBvbiByZXN1
bWUgYXMgdGhpcyBpcyBub3QgbmVjZXNzYXJ5OiB0aGUgcG9ydCBpcyByZXNldCBvbgorCQkg
KiByZXN1bWUsIHdoaWNoIHdha2VzIHVwIHRoZSBkcml2ZS4KKwkJICovCiAJCXNkZXYtPm1h
bmFnZV9zdGFydF9zdG9wID0gMTsKKwkJc2Rldi0+bm9fc3RhcnRfb25fcmVzdW1lID0gMTsK
IAl9CiAKIAkvKgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL3NkLmMgYi9kcml2ZXJzL3Nj
c2kvc2QuYwppbmRleCA2OGIxMmFmYTA3MjEuLmI4NTg0ZmUzMTIzZSAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9zY3NpL3NkLmMKKysrIGIvZHJpdmVycy9zY3NpL3NkLmMKQEAgLTM4NzYsNyAr
Mzg3Niw3IEBAIHN0YXRpYyBpbnQgc2Rfc3VzcGVuZF9ydW50aW1lKHN0cnVjdCBkZXZpY2Ug
KmRldikKIHN0YXRpYyBpbnQgc2RfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikKIHsKIAlz
dHJ1Y3Qgc2NzaV9kaXNrICpzZGtwID0gZGV2X2dldF9kcnZkYXRhKGRldik7Ci0JaW50IHJl
dDsKKwlpbnQgcmV0ID0gMDsKIAogCWlmICghc2RrcCkJLyogRS5nLjogcnVudGltZSByZXN1
bWUgYXQgdGhlIHN0YXJ0IG9mIHNkX3Byb2JlKCkgKi8KIAkJcmV0dXJuIDA7CkBAIC0zODg1
LDcgKzM4ODUsOCBAQCBzdGF0aWMgaW50IHNkX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYp
CiAJCXJldHVybiAwOwogCiAJc2RfcHJpbnRrKEtFUk5fTk9USUNFLCBzZGtwLCAiU3RhcnRp
bmcgZGlza1xuIik7Ci0JcmV0ID0gc2Rfc3RhcnRfc3RvcF9kZXZpY2Uoc2RrcCwgMSk7CisJ
aWYgKCFzZGtwLT5kZXZpY2UtPm5vX3N0YXJ0X29uX3Jlc3VtZSkKKwkJcmV0ID0gc2Rfc3Rh
cnRfc3RvcF9kZXZpY2Uoc2RrcCwgMSk7CiAJaWYgKCFyZXQpCiAJCW9wYWxfdW5sb2NrX2Zy
b21fc3VzcGVuZChzZGtwLT5vcGFsX2Rldik7CiAJcmV0dXJuIHJldDsKZGlmZiAtLWdpdCBh
L2luY2x1ZGUvc2NzaS9zY3NpX2RldmljZS5oIGIvaW5jbHVkZS9zY3NpL3Njc2lfZGV2aWNl
LmgKaW5kZXggNzViMjIzNWI5OWUyLi5iOTIzMGI2YWRkMDQgMTAwNjQ0Ci0tLSBhL2luY2x1
ZGUvc2NzaS9zY3NpX2RldmljZS5oCisrKyBiL2luY2x1ZGUvc2NzaS9zY3NpX2RldmljZS5o
CkBAIC0xOTQsNiArMTk0LDcgQEAgc3RydWN0IHNjc2lfZGV2aWNlIHsKIAl1bnNpZ25lZCBu
b19zdGFydF9vbl9hZGQ6MTsJLyogZG8gbm90IGlzc3VlIHN0YXJ0IG9uIGFkZCAqLwogCXVu
c2lnbmVkIGFsbG93X3Jlc3RhcnQ6MTsgLyogaXNzdWUgU1RBUlRfVU5JVCBpbiBlcnJvciBo
YW5kbGVyICovCiAJdW5zaWduZWQgbWFuYWdlX3N0YXJ0X3N0b3A6MTsJLyogTGV0IEhMRCAo
c2QpIG1hbmFnZSBzdGFydC9zdG9wICovCisJdW5zaWduZWQgbm9fc3RhcnRfb25fcmVzdW1l
OjE7IC8qIERvIG5vdCBpc3N1ZSBTVEFSVF9TVE9QX1VOSVQgb24gcmVzdW1lICovCiAJdW5z
aWduZWQgc3RhcnRfc3RvcF9wd3JfY29uZDoxOwkvKiBTZXQgcG93ZXIgY29uZC4gaW4gU1RB
UlRfU1RPUF9VTklUICovCiAJdW5zaWduZWQgbm9fdWxkX2F0dGFjaDoxOyAvKiBkaXNhYmxl
IGNvbm5lY3RpbmcgdG8gdXBwZXIgbGV2ZWwgZHJpdmVycyAqLwogCXVuc2lnbmVkIHNlbGVj
dF9ub19hdG46MTsKLS0gCjIuNDEuMAoK

--------------oAWxdk5ed0hcZpvqb0D0WIQ2--
