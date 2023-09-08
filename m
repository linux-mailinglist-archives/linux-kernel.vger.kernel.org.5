Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE96799190
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbjIHVoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343977AbjIHVoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:44:11 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5575ADC;
        Fri,  8 Sep 2023 14:44:07 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-500913779f5so4313648e87.2;
        Fri, 08 Sep 2023 14:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694209445; x=1694814245; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WvuWhPU0inqZFdqdKYOluIsnA+sitSaVedpZ/LgFjjo=;
        b=LYZC8SSakugHUaAoFCnUxecJrox085z/aDeSMRaqHuu6IX6Fmwmzw5qkq6BsxWAnJS
         TvDgT6W8DfHTijO5YM7676ijhybCpN2HYonN3yebs4XBDE9617NWMCgWJqxWQeK7sV04
         X3xxHe/m9QdJzgETyhxetzGBG/OMMjHObYvaQX4mLbMQb+GKxBVdspTV6zj31uXVJSrk
         sLkv9LH1PL8trYn6djyLU4SdjXqpwSV/62dv6oV6mGi2psDtpqqA0lnuyEdyRggiCobr
         rf1+/GEue6GAbG7a3R4aX5nrdVDqnHNcX03iXl9rJEZdaz7egeR8+nPHi43TnwNiQo1l
         7kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694209445; x=1694814245;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WvuWhPU0inqZFdqdKYOluIsnA+sitSaVedpZ/LgFjjo=;
        b=fGoAvlsArkuUaOFHnVoNpk9rcK65SA2AzFzeue3aQJdwGTJ0cdoNr3emKUfuJXY7CF
         E2cVqm2mxUrbf7R+k5+mF1fMutkgmLeoQbQ21t5RVFdZd7oeG40W+wCFNecipY/fPb+x
         JWlU7ExkDgYbgc52F/a0PgcOjjGPZ4R6Klh2Xi3O4/v6e2SjQRt110Al9XYtu2ZjugfV
         U47295JyAIg7pDVXWF9TZwyLNBrc2OFqUC+jecZnJaFpxc4oM5tdMl3Jx8ECTGI6yZF0
         gTO3bA+4xMGdHC/IZufcBB3u1GwBYWjBvNthTCeTmxeI9TqOWENW/MfbUKz+saiPik5F
         oDwg==
X-Gm-Message-State: AOJu0YyX+vuASy5Z7hKm/LPUiroPBFVQoIbwiLjt9+53JBzPHdM3ibMf
        hrKnBRGsdaoco+nFbjujWia7q3BP+zFyTUlm6rhUPzucW8dxug==
X-Google-Smtp-Source: AGHT+IFwOC4BUhXs6jeVgJrqGpNTI5i2OW7Q0knVoYp1bEChyUtn926MWlmzYfyitCZMtyiuGvgrts1p+1SpjHwXbvg=
X-Received: by 2002:a05:6512:b95:b0:501:bbbb:de1e with SMTP id
 b21-20020a0565120b9500b00501bbbbde1emr3563641lfv.6.1694209444423; Fri, 08 Sep
 2023 14:44:04 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 8 Sep 2023 16:43:53 -0500
Message-ID: <CAH2r5muqjAB5GAybWzmRBxvhiA2KvKo-E0a7zzA66w8evm43BQ@mail.gmail.com>
Subject: Add missing OID for SPNEGO Extended Negotiation
To:     David Howells <dhowells@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001c61d20604dfe075"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001c61d20604dfe075
Content-Type: text/plain; charset="UTF-8"

    spnego: add missing OID to oid registry

    Add missing OID to the registry. Some servers and clients (including
    Windows) now request "NEGOEX - SPNEGEO Extended Negotiation Security")

    See https://datatracker.ietf.org/doc/html/draft-zhu-negoex-02

    Signed-off-by: Steve French <stfrench@microsoft.com>

diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 0f4a8903922a..f86a08ba0207 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -67,6 +67,7 @@ enum OID {
        OID_msOutlookExpress,           /* 1.3.6.1.4.1.311.16.4 */

        OID_ntlmssp,                    /* 1.3.6.1.4.1.311.2.2.10 */
+       OID_negoex,                     /* 1.3.6.1.4.1.311.2.2.30 */

        OID_spnego,                     /* 1.3.6.1.5.5.2 */


-- 
Thanks,

Steve

--0000000000001c61d20604dfe075
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-spnego-add-missing-OID-to-oid-registry.patch"
Content-Disposition: attachment; 
	filename="0001-spnego-add-missing-OID-to-oid-registry.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lmb4il9o0>
X-Attachment-Id: f_lmb4il9o0

RnJvbSA0YzExZDE3YjNiNWVmMmEwNDY5ODY4M2M4NDc2YTQ5NGI2ODI1MDU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IEZyaSwgOCBTZXAgMjAyMyAxNjozNDo1OSAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIHNw
bmVnbzogYWRkIG1pc3NpbmcgT0lEIHRvIG9pZCByZWdpc3RyeQoKQWRkIG1pc3NpbmcgT0lEIHRv
IHRoZSByZWdpc3RyeS4gU29tZSBzZXJ2ZXJzIGFuZCBjbGllbnRzIChpbmNsdWRpbmcKV2luZG93
cykgbm93IHJlcXVlc3QgIk5FR09FWCAtIFNQTkVHRU8gRXh0ZW5kZWQgTmVnb3RpYXRpb24gU2Vj
dXJpdHkiKQoKU2VlIGh0dHBzOi8vZGF0YXRyYWNrZXIuaWV0Zi5vcmcvZG9jL2h0bWwvZHJhZnQt
emh1LW5lZ29leC0wMgoKU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNy
b3NvZnQuY29tPgotLS0KIGluY2x1ZGUvbGludXgvb2lkX3JlZ2lzdHJ5LmggfCAxICsKIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvb2lk
X3JlZ2lzdHJ5LmggYi9pbmNsdWRlL2xpbnV4L29pZF9yZWdpc3RyeS5oCmluZGV4IDBmNGE4OTAz
OTIyYS4uZjg2YTA4YmEwMjA3IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L29pZF9yZWdpc3Ry
eS5oCisrKyBiL2luY2x1ZGUvbGludXgvb2lkX3JlZ2lzdHJ5LmgKQEAgLTY3LDYgKzY3LDcgQEAg
ZW51bSBPSUQgewogCU9JRF9tc091dGxvb2tFeHByZXNzLAkJLyogMS4zLjYuMS40LjEuMzExLjE2
LjQgKi8KIAogCU9JRF9udGxtc3NwLAkJCS8qIDEuMy42LjEuNC4xLjMxMS4yLjIuMTAgKi8KKwlP
SURfbmVnb2V4LAkJCS8qIDEuMy42LjEuNC4xLjMxMS4yLjIuMzAgKi8KIAogCU9JRF9zcG5lZ28s
CQkJLyogMS4zLjYuMS41LjUuMiAqLwogCi0tIAoyLjM5LjIKCg==
--0000000000001c61d20604dfe075--
