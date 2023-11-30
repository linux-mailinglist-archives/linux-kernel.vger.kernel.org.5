Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D327C7FF792
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345851AbjK3Q6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjK3Q6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:58:35 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA43D67
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:58:40 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7b359dad0e7so14296639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701363520; x=1701968320; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kjfGUOrzOcR4VCFCR9ZAuqiy4DmfY+gNhzhv4Uomr1U=;
        b=F8OqNkGUafd5FWrSsioFV9IZrJ1u9pnpNnVr4UWnBECGKZ2jP41b9BIVe55bWrAwGn
         KMSV3xt9y738n3YnEcf2yp0edMKSD2EpxQXMc7+ftAj7H7H6X+zLSLPSG5ZH5VUrqhVm
         a/unZ30ed5vOGbSO0IXeGe0Gi0vznQZhMWgrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363520; x=1701968320;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjfGUOrzOcR4VCFCR9ZAuqiy4DmfY+gNhzhv4Uomr1U=;
        b=bBDW+dQcOg3K2/Eej3omIm954jykmFfH/X2ZM3WG9hbkRszLsaTpnvvA78CF+PnYIb
         1RUJV1aNz9AGRC2V7iyH7muL/BNJUqR7apJtlcMkfIw45yWBjMULVJbfPLWUcCmMiyrG
         hOrB8qQToGivWbqLStoU8XsAndm1He4UFUKiQ1Tvo77Ax0puBAAbnOCyETIBGB1sPh2F
         bjJga7m97fBAyYZIJbVK1VkOIq6O7cxlkoXHGJA6hJep5ymfVdeOOx2qFlCcpO3ClPGR
         wEonzcB/Sjs01JN/RZshorZPOYIWYn4tkDK0G4w+jziTai7pkL/cvv+/7kzREAZp49SD
         8uPQ==
X-Gm-Message-State: AOJu0Yx3tC2yHODnfflAt0GiqEAL6+RUXAXW+SGmbN8R2BF12MQaOmHX
        zawZUaJIIi4LLkDQOdEWV+WYP3kYlwXa2Fbb3QE=
X-Google-Smtp-Source: AGHT+IFSVsGsXT2IkoG9CBP+31+G7sAfiES8qJIDWWX0VAYPQbMR17+QOR56yYT2iZGtf5zDVFwFAw==
X-Received: by 2002:a05:6e02:b4a:b0:35c:baec:750c with SMTP id f10-20020a056e020b4a00b0035cbaec750cmr2483295ilu.1.1701363520298;
        Thu, 30 Nov 2023 08:58:40 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id d15-20020a056e021c4f00b0035c8c6045cfsm213266ilg.72.2023.11.30.08.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 08:58:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------6IEXtfpLNI6JnAsB035VsGjN"
Message-ID: <c26192e6-df1e-450a-ac2d-e18fc0d77fe9@linuxfoundation.org>
Date:   Thu, 30 Nov 2023 09:58:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit fixes update for Linux 6.7-rc4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6IEXtfpLNI6JnAsB035VsGjN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 6.7-rc4.

This KUnit fixes update for Linux 6.7-rc4 consists of three fixes to
warnings and run-time test behavior. With these fixes, test suite
counter will be reset correctly before running tests, kunit will warn
if tests are too slow, and eliminate warning when kfree() as an action.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-fixes-6.7-rc4

for you to fetch changes up to 1bddcf77ce6668692fc15e968fd0870d5524d112:

   kunit: test: Avoid cast warning when adding kfree() as an action (2023-11-14 13:01:57 -0700)

----------------------------------------------------------------
linux_kselftest-kunit-fixes-6.7-rc4

This KUnit fixes update for Linux 6.7-rc4 consists of three fixes to
warnings and run-time test behavior. With these fixes, test suite
counter will be reset correctly before running tests, kunit will warn
if tests are too slow, and eliminate warning when kfree() as an action.

----------------------------------------------------------------
Maxime Ripard (1):
       kunit: Warn if tests are slow

Michal Wajdeczko (1):
       kunit: Reset suite counter right before running tests

Richard Fitzgerald (1):
       kunit: test: Avoid cast warning when adding kfree() as an action

  lib/kunit/kunit-test.c |  2 +-
  lib/kunit/test.c       | 42 ++++++++++++++++++++++++++++++++++++++++--
  2 files changed, 41 insertions(+), 3 deletions(-)
----------------------------------------------------------------
--------------6IEXtfpLNI6JnAsB035VsGjN
Content-Type: text/x-patch; charset=UTF-8;
 name="linux_kselftest-kunit-fixes-6.7-rc4.diff"
Content-Disposition: attachment;
 filename="linux_kselftest-kunit-fixes-6.7-rc4.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2xpYi9rdW5pdC9rdW5pdC10ZXN0LmMgYi9saWIva3VuaXQva3VuaXQt
dGVzdC5jCmluZGV4IDk5ZDJhM2E1MjhlMS4uZGUyMTEzYTU4ZmEwIDEwMDY0NAotLS0gYS9s
aWIva3VuaXQva3VuaXQtdGVzdC5jCisrKyBiL2xpYi9rdW5pdC9rdW5pdC10ZXN0LmMKQEAg
LTU2Miw3ICs1NjIsNyBAQCBzdGF0aWMgdm9pZCBrdW5pdF9sb2dfdGVzdChzdHJ1Y3Qga3Vu
aXQgKnRlc3QpCiAJS1VOSVRfRVhQRUNUX1RSVUUodGVzdCwgdGVzdC0+bG9nLT5hcHBlbmRf
bmV3bGluZXMpOwogCiAJZnVsbF9sb2cgPSBzdHJpbmdfc3RyZWFtX2dldF9zdHJpbmcodGVz
dC0+bG9nKTsKLQlrdW5pdF9hZGRfYWN0aW9uKHRlc3QsIChrdW5pdF9hY3Rpb25fdCAqKWtm
cmVlLCBmdWxsX2xvZyk7CisJa3VuaXRfYWRkX2FjdGlvbih0ZXN0LCBrZnJlZV93cmFwcGVy
LCBmdWxsX2xvZyk7CiAJS1VOSVRfRVhQRUNUX05PVF9FUlJfT1JfTlVMTCh0ZXN0LAogCQkJ
CSAgICAgc3Ryc3RyKGZ1bGxfbG9nLCAicHV0IHRoaXMgaW4gbG9nLiIpKTsKIAlLVU5JVF9F
WFBFQ1RfTk9UX0VSUl9PUl9OVUxMKHRlc3QsCmRpZmYgLS1naXQgYS9saWIva3VuaXQvdGVz
dC5jIGIvbGliL2t1bml0L3Rlc3QuYwppbmRleCBmMmViNzFmMWE2NmMuLjdhY2ViMDdhMWFm
OSAxMDA2NDQKLS0tIGEvbGliL2t1bml0L3Rlc3QuYworKysgYi9saWIva3VuaXQvdGVzdC5j
CkBAIC0zMzgsNiArMzM4LDM2IEBAIHZvaWQga3VuaXRfaW5pdF90ZXN0KHN0cnVjdCBrdW5p
dCAqdGVzdCwgY29uc3QgY2hhciAqbmFtZSwgc3RydWN0IHN0cmluZ19zdHJlYW0KIH0KIEVY
UE9SVF9TWU1CT0xfR1BMKGt1bml0X2luaXRfdGVzdCk7CiAKKy8qIE9ubHkgd2FybiB3aGVu
IGEgdGVzdCB0YWtlcyBtb3JlIHRoYW4gdHdpY2UgdGhlIHRocmVzaG9sZCAqLworI2RlZmlu
ZSBLVU5JVF9TUEVFRF9XQVJOSU5HX01VTFRJUExJRVIJMgorCisvKiBTbG93IHRlc3RzIGFy
ZSBkZWZpbmVkIGFzIHRha2luZyBtb3JlIHRoYW4gMXMgKi8KKyNkZWZpbmUgS1VOSVRfU1BF
RURfU0xPV19USFJFU0hPTERfUwkxCisKKyNkZWZpbmUgS1VOSVRfU1BFRURfU0xPV19XQVJO
SU5HX1RIUkVTSE9MRF9TCVwKKwkoS1VOSVRfU1BFRURfV0FSTklOR19NVUxUSVBMSUVSICog
S1VOSVRfU1BFRURfU0xPV19USFJFU0hPTERfUykKKworI2RlZmluZSBzX3RvX3RpbWVzcGVj
NjQocykgbnNfdG9fdGltZXNwZWM2NCgocykgKiBOU0VDX1BFUl9TRUMpCisKK3N0YXRpYyB2
b2lkIGt1bml0X3J1bl9jYXNlX2NoZWNrX3NwZWVkKHN0cnVjdCBrdW5pdCAqdGVzdCwKKwkJ
CQkgICAgICAgc3RydWN0IGt1bml0X2Nhc2UgKnRlc3RfY2FzZSwKKwkJCQkgICAgICAgc3Ry
dWN0IHRpbWVzcGVjNjQgZHVyYXRpb24pCit7CisJc3RydWN0IHRpbWVzcGVjNjQgc2xvd190
aHIgPQorCQlzX3RvX3RpbWVzcGVjNjQoS1VOSVRfU1BFRURfU0xPV19XQVJOSU5HX1RIUkVT
SE9MRF9TKTsKKwllbnVtIGt1bml0X3NwZWVkIHNwZWVkID0gdGVzdF9jYXNlLT5hdHRyLnNw
ZWVkOworCisJaWYgKHRpbWVzcGVjNjRfY29tcGFyZSgmZHVyYXRpb24sICZzbG93X3Rocikg
PCAwKQorCQlyZXR1cm47CisKKwlpZiAoc3BlZWQgPT0gS1VOSVRfU1BFRURfVkVSWV9TTE9X
IHx8IHNwZWVkID09IEtVTklUX1NQRUVEX1NMT1cpCisJCXJldHVybjsKKworCWt1bml0X3dh
cm4odGVzdCwKKwkJICAgIlRlc3Qgc2hvdWxkIGJlIG1hcmtlZCBzbG93IChydW50aW1lOiAl
bGxkLiUwOWxkcykiLAorCQkgICBkdXJhdGlvbi50dl9zZWMsIGR1cmF0aW9uLnR2X25zZWMp
OworfQorCiAvKgogICogSW5pdGlhbGl6ZXMgYW5kIHJ1bnMgdGVzdCBjYXNlLiBEb2VzIG5v
dCBjbGVhbiB1cCBvciBkbyBwb3N0IHZhbGlkYXRpb25zLgogICovCkBAIC0zNDUsNiArMzc1
LDggQEAgc3RhdGljIHZvaWQga3VuaXRfcnVuX2Nhc2VfaW50ZXJuYWwoc3RydWN0IGt1bml0
ICp0ZXN0LAogCQkJCSAgICBzdHJ1Y3Qga3VuaXRfc3VpdGUgKnN1aXRlLAogCQkJCSAgICBz
dHJ1Y3Qga3VuaXRfY2FzZSAqdGVzdF9jYXNlKQogeworCXN0cnVjdCB0aW1lc3BlYzY0IHN0
YXJ0LCBlbmQ7CisKIAlpZiAoc3VpdGUtPmluaXQpIHsKIAkJaW50IHJldDsKIApAQCAtMzU2
LDcgKzM4OCwxMyBAQCBzdGF0aWMgdm9pZCBrdW5pdF9ydW5fY2FzZV9pbnRlcm5hbChzdHJ1
Y3Qga3VuaXQgKnRlc3QsCiAJCX0KIAl9CiAKKwlrdGltZV9nZXRfdHM2NCgmc3RhcnQpOwor
CiAJdGVzdF9jYXNlLT5ydW5fY2FzZSh0ZXN0KTsKKworCWt0aW1lX2dldF90czY0KCZlbmQp
OworCisJa3VuaXRfcnVuX2Nhc2VfY2hlY2tfc3BlZWQodGVzdCwgdGVzdF9jYXNlLCB0aW1l
c3BlYzY0X3N1YihlbmQsIHN0YXJ0KSk7CiB9CiAKIHN0YXRpYyB2b2lkIGt1bml0X2Nhc2Vf
aW50ZXJuYWxfY2xlYW51cChzdHJ1Y3Qga3VuaXQgKnRlc3QpCkBAIC02NzAsNiArNzA4LDgg
QEAgaW50IF9fa3VuaXRfdGVzdF9zdWl0ZXNfaW5pdChzdHJ1Y3Qga3VuaXRfc3VpdGUgKiBj
b25zdCAqIGNvbnN0IHN1aXRlcywgaW50IG51bV8KIAkJcmV0dXJuIDA7CiAJfQogCisJa3Vu
aXRfc3VpdGVfY291bnRlciA9IDE7CisKIAlzdGF0aWNfYnJhbmNoX2luYygma3VuaXRfcnVu
bmluZyk7CiAKIAlmb3IgKGkgPSAwOyBpIDwgbnVtX3N1aXRlczsgaSsrKSB7CkBAIC02OTYs
OCArNzM2LDYgQEAgdm9pZCBfX2t1bml0X3Rlc3Rfc3VpdGVzX2V4aXQoc3RydWN0IGt1bml0
X3N1aXRlICoqc3VpdGVzLCBpbnQgbnVtX3N1aXRlcykKIAogCWZvciAoaSA9IDA7IGkgPCBu
dW1fc3VpdGVzOyBpKyspCiAJCWt1bml0X2V4aXRfc3VpdGUoc3VpdGVzW2ldKTsKLQotCWt1
bml0X3N1aXRlX2NvdW50ZXIgPSAxOwogfQogRVhQT1JUX1NZTUJPTF9HUEwoX19rdW5pdF90
ZXN0X3N1aXRlc19leGl0KTsKIAo=

--------------6IEXtfpLNI6JnAsB035VsGjN--
