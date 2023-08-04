Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7790076FF35
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjHDLHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 07:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjHDLHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:07:47 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC069B;
        Fri,  4 Aug 2023 04:07:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fe0fe622c3so3305631e87.2;
        Fri, 04 Aug 2023 04:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691147264; x=1691752064;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fEy1+hL9zQHiNkyeCV6qt4c/bSL6uGGiQWAnjgglbbw=;
        b=MFDuNHIS9vvGBaqlQhiPcM7MS4Nzh9iGbsvcE2M4fzYXhAAiMVll0D5waVMCyYV5Kb
         0Im8TWE8LYmEffS4slT1P5QfCoIc+IBbwqI0y7dS2kzad/rGgiKEJC4ZUw2v+52y2Emx
         GGkS1/A6wP1z4A6ptTQPzYthHwmizWg/rnNfu4FmvK0XIZecKa/kBOXCrYZnCwPbf+gB
         d49KAoqKIUXE9JvuCLky/hAk3VGjGfJhhENBAFDEW3SxRAgose8AfSFEbSudws0880RV
         oVCzLFXTKVWk2jEVW5TqcI7iXkhclNj0jegAUotnwFN1NYqw6S1khnJlJ5953UR334yr
         vfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691147264; x=1691752064;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fEy1+hL9zQHiNkyeCV6qt4c/bSL6uGGiQWAnjgglbbw=;
        b=JCOBiD2q7gmz+f4/Zp3/ip6dPDOKtYX6DIxjgtbFBgPHphhJ8a9cRf+Gfhvw8ebITQ
         zieTTAXlo+2ipljmAN9aUE+CpdAypIAC/A3TDugUC+JntrtMHcLypnIMbQsKlxjmpLGE
         DTPPV0oPp/U6cfweQJj8H1Bm4M10yVO4kjw1YpFN8zjhSCMyMvZpSeGoCsFLRGfG7ml8
         b9gtdCsCrOqZTLoYvlG3QfWFoFBXVpQaxFoeW7xSEfyNfc2++NZ4gplE4YX5/m3e71jY
         79wYvSwruRVNflrwaw15FZNvfGk9e2lKvCnzhh5WqGro7tapkvaGuE2jEpmWBWVgesZg
         6gzQ==
X-Gm-Message-State: AOJu0YyS7vIZdVuZjSdfOWsr4VRVIAAWWEl3a0mEJ2Q9EoajGvUn/O8I
        HMllr9UffXT6LWxl/iG/4Nc=
X-Google-Smtp-Source: AGHT+IHkmshvNSeDT03iNPwTvWI8VbU7T+hWSVUpm7GSCLI6Ul2Q3ncHyw3jKYX7h7yx+hINgsUivw==
X-Received: by 2002:a19:9201:0:b0:4fb:9469:d659 with SMTP id u1-20020a199201000000b004fb9469d659mr1010973lfd.23.1691147263725;
        Fri, 04 Aug 2023 04:07:43 -0700 (PDT)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id v26-20020ac2559a000000b004fddb0eb961sm332522lfg.18.2023.08.04.04.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 04:07:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------atppxto8rPUknDM1CKkUqQJb"
Message-ID: <bd5feeb3-bc44-d4d2-7708-eea9243b49a4@gmail.com>
Date:   Fri, 4 Aug 2023 13:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM board lockups/hangs triggered by locks and mutexes
Content-Language: en-US
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-clk@vger.kernel.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     OpenWrt Development List <openwrt-devel@lists.openwrt.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
References: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
In-Reply-To: <CACna6rxpzDWE5-gnmpgMgfzPmmHvEGTZk4GJvJ8jLSMazh2bVA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------atppxto8rPUknDM1CKkUqQJb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2.08.2023 00:10, Rafał Miłecki wrote:
> Unfortunately enabling *any* of following options:
> CONFIG_DEBUG_RT_MUTEXES=y
> CONFIG_DEBUG_SPINLOCK=y
> CONFIG_DEBUG_MUTEXES=y
> seems to make locksup/hangs go away. I tried for few hours.

I decided to find out why enabling CONFIG_DEBUG_MUTEXES "fixes" kernel /
device stability for me. I tried enabling manually code that normally
hides behind the #ifdev CONFIG_DEBUG_MUTEXES.

Attached to this e-mail is a small patch that is enough to make my
kernel stable (mutex-fix-bcm53573.diff).

#####

It's not what's the most interesting thought. What really doesn't make
sense anymore is that below diff (on top of attached one) brings back
hangs/lockups.

I triple checked that. Dropping a single unused function breaks kernel /
device stability on BCM53573!

AFAIK the only thing below diff actually affects is location of symbols
(I actually verified that by comparing System.map before and after -
over 22'000 of relocated symbols).

Can some unfortunate location of symbols cause those hangs/lockups?


diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index 4fe40910f..c440222a4 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -34,6 +34,8 @@ void debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
  	INIT_LIST_HEAD(&waiter->list);
  }

+/* Dropping below function brings back hangs/lockups & reboots */
+#if 0
  void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
  {
  	lockdep_assert_held(&lock->wait_lock);
@@ -41,6 +43,7 @@ void debug_mutex_wake_waiter(struct mutex *lock, struct mutex_waiter *waiter)
  	DEBUG_LOCKS_WARN_ON(waiter->magic != waiter);
  	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
  }
+#endif

  void debug_mutex_free_waiter(struct mutex_waiter *waiter)
  {

--------------atppxto8rPUknDM1CKkUqQJb
Content-Type: text/x-patch; charset=UTF-8; name="mutex-fix-bcm53573.diff"
Content-Disposition: attachment; filename="mutex-fix-bcm53573.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbXV0ZXguaCBiL2luY2x1ZGUvbGludXgvbXV0
ZXguaAppbmRleCA0NzliYzk2YzMuLjE1YmQ0NjkxYiAxMDA2NDQKLS0tIGEvaW5jbHVkZS9s
aW51eC9tdXRleC5oCisrKyBiL2luY2x1ZGUvbGludXgvbXV0ZXguaApAQCAtNTcsOSArNTcs
NyBAQCBzdHJ1Y3QgbXV0ZXggewogCXN0cnVjdCBvcHRpbWlzdGljX3NwaW5fcXVldWUgb3Nx
OyAvKiBTcGlubmVyIE1DUyBsb2NrICovCiAjZW5kaWYKIAlzdHJ1Y3QgbGlzdF9oZWFkCXdh
aXRfbGlzdDsKLSNpZmRlZiBDT05GSUdfREVCVUdfTVVURVhFUwogCXZvaWQJCQkqbWFnaWM7
Ci0jZW5kaWYKICNpZmRlZiBDT05GSUdfREVCVUdfTE9DS19BTExPQwogCXN0cnVjdCBsb2Nr
ZGVwX21hcAlkZXBfbWFwOwogI2VuZGlmCkBAIC03MywxMiArNzEsMTAgQEAgc3RydWN0IG11
dGV4X3dhaXRlciB7CiAJc3RydWN0IGxpc3RfaGVhZAlsaXN0OwogCXN0cnVjdCB0YXNrX3N0
cnVjdAkqdGFzazsKIAlzdHJ1Y3Qgd3dfYWNxdWlyZV9jdHgJKnd3X2N0eDsKLSNpZmRlZiBD
T05GSUdfREVCVUdfTVVURVhFUwogCXZvaWQJCQkqbWFnaWM7Ci0jZW5kaWYKIH07CiAKLSNp
ZmRlZiBDT05GSUdfREVCVUdfTVVURVhFUworI2lmIDEgLy9kZWYgQ09ORklHX0RFQlVHX01V
VEVYRVMKIAogI2RlZmluZSBfX0RFQlVHX01VVEVYX0lOSVRJQUxJWkVSKGxvY2tuYW1lKQkJ
CQlcCiAJLCAubWFnaWMgPSAmbG9ja25hbWUKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
c2NoZWQuaCBiL2luY2x1ZGUvbGludXgvc2NoZWQuaAppbmRleCBkMGU2Mzk0OTcuLjhmZWY0
NDg1ZSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9zY2hlZC5oCisrKyBiL2luY2x1ZGUv
bGludXgvc2NoZWQuaApAQCAtOTU4LDEwICs5NTgsOCBAQCBzdHJ1Y3QgdGFza19zdHJ1Y3Qg
ewogCXN0cnVjdCBydF9tdXRleF93YWl0ZXIJCSpwaV9ibG9ja2VkX29uOwogI2VuZGlmCiAK
LSNpZmRlZiBDT05GSUdfREVCVUdfTVVURVhFUwogCS8qIE11dGV4IGRlYWRsb2NrIGRldGVj
dGlvbjogKi8KIAlzdHJ1Y3QgbXV0ZXhfd2FpdGVyCQkqYmxvY2tlZF9vbjsKLSNlbmRpZgog
CiAjaWZkZWYgQ09ORklHX0RFQlVHX0FUT01JQ19TTEVFUAogCWludAkJCQlub25fYmxvY2tf
Y291bnQ7CmRpZmYgLS1naXQgYS9rZXJuZWwvbG9ja2luZy9NYWtlZmlsZSBiL2tlcm5lbC9s
b2NraW5nL01ha2VmaWxlCmluZGV4IDQ1NDUyZmFjZi4uYjIyZTZlY2Q4IDEwMDY0NAotLS0g
YS9rZXJuZWwvbG9ja2luZy9NYWtlZmlsZQorKysgYi9rZXJuZWwvbG9ja2luZy9NYWtlZmls
ZQpAQCAtMTIsNyArMTIsNyBAQCBDRkxBR1NfUkVNT1ZFX211dGV4LWRlYnVnLm8gPSAkKEND
X0ZMQUdTX0ZUUkFDRSkKIENGTEFHU19SRU1PVkVfcnRtdXRleC1kZWJ1Zy5vID0gJChDQ19G
TEFHU19GVFJBQ0UpCiBlbmRpZgogCi1vYmotJChDT05GSUdfREVCVUdfTVVURVhFUykgKz0g
bXV0ZXgtZGVidWcubworb2JqLXkgKz0gbXV0ZXgtZGVidWcubwogb2JqLSQoQ09ORklHX0xP
Q0tERVApICs9IGxvY2tkZXAubwogaWZlcSAoJChDT05GSUdfUFJPQ19GUykseSkKIG9iai0k
KENPTkZJR19MT0NLREVQKSArPSBsb2NrZGVwX3Byb2MubwpkaWZmIC0tZ2l0IGEva2VybmVs
L2xvY2tpbmcvbXV0ZXguYyBiL2tlcm5lbC9sb2NraW5nL211dGV4LmMKaW5kZXggYjAyZmZm
MjgyLi42ZGMzZjgwYTMgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9sb2NraW5nL211dGV4LmMKKysr
IGIva2VybmVsL2xvY2tpbmcvbXV0ZXguYwpAQCAtOTQ2LDkgKzk0Niw3IEBAIF9fbXV0ZXhf
bG9ja19jb21tb24oc3RydWN0IG11dGV4ICpsb2NrLCBsb25nIHN0YXRlLCB1bnNpZ25lZCBp
bnQgc3ViY2xhc3MsCiAKIAltaWdodF9zbGVlcCgpOwogCi0jaWZkZWYgQ09ORklHX0RFQlVH
X01VVEVYRVMKIAlERUJVR19MT0NLU19XQVJOX09OKGxvY2stPm1hZ2ljICE9IGxvY2spOwot
I2VuZGlmCiAKIAl3dyA9IGNvbnRhaW5lcl9vZihsb2NrLCBzdHJ1Y3Qgd3dfbXV0ZXgsIGJh
c2UpOwogCWlmICh3d19jdHgpIHsKQEAgLTE0MTcsOSArMTQxNSw3IEBAIGludCBfX3NjaGVk
IG11dGV4X3RyeWxvY2soc3RydWN0IG11dGV4ICpsb2NrKQogewogCWJvb2wgbG9ja2VkOwog
Ci0jaWZkZWYgQ09ORklHX0RFQlVHX01VVEVYRVMKIAlERUJVR19MT0NLU19XQVJOX09OKGxv
Y2stPm1hZ2ljICE9IGxvY2spOwotI2VuZGlmCiAKIAlsb2NrZWQgPSBfX211dGV4X3RyeWxv
Y2sobG9jayk7CiAJaWYgKGxvY2tlZCkK

--------------atppxto8rPUknDM1CKkUqQJb--
