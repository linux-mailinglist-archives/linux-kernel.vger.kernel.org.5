Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0051C7B83FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 17:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbjJDPqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 11:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjJDPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 11:46:06 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546BEC9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 08:46:02 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34f69780037so2443505ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696434361; x=1697039161; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AXYm9qlPqfGMDrbCLiqmg1WtFNwa/hRn8nsfWqfPLRA=;
        b=L2PxXbFR0QeGuknLFZqknB8rDLW6ubvuGnpder4Jcfb8hongDaxATPZE8SVYA3PWgb
         zfxqXlHe2MUPGAb+7vM24vQA/WjBjNxitpIn/XWy2In8Slm2GTwQVZLxNBpJU2psBW+Q
         gDk487SVHtlNo6k0FACUUfNecLPd3qRnrpoWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696434361; x=1697039161;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXYm9qlPqfGMDrbCLiqmg1WtFNwa/hRn8nsfWqfPLRA=;
        b=jlqFqZgLzStIH6NHW43HLhKXE9QFPtXvM78QuUKw7C9yyJGEg3bBKuUvYzohyRplsP
         p1e6XhKf+795GwjhKBPFwV/t4jdQheGtvGNKvyQpEmJ6PRPLCjW6mM9DE2py3ZkHxbRB
         MTieUN+gZYeQADz8IJwy5ejMQt+K7zuW9TR11yLJHtjZez+0oWTgm1N44jXmaoHn6/kP
         /rjJodFw9zeadRcE0s9NKBeRMuvMVNWxskOMBeBIKfYcxUXniVY8x2H5rWDA3T+j+xAd
         ATOVCRm+Nryj1ReoeA3FNYHcRnDbISm8CrhD2RwO5soq6DusPBMU9R2dNXLDjYp+Ux8a
         frow==
X-Gm-Message-State: AOJu0YwW+i7v0Cweij6E4+eygc0/CTKwcDGJKFiCD8NfM05FWVs2Ph0x
        EAcbyAnbkzGONGTZ+K3Y8Gk5Ug==
X-Google-Smtp-Source: AGHT+IHeNDp7yEG0k0Lc85/gMUIbPakw8qrxT/YwwfmgUA7suxBA8/8NkXnftDMybcZh2Ya324rq/Q==
X-Received: by 2002:a05:6602:1a07:b0:79d:1c65:9bde with SMTP id bo7-20020a0566021a0700b0079d1c659bdemr3076401iob.1.1696434361658;
        Wed, 04 Oct 2023 08:46:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m20-20020a056638225400b00430245071ddsm1037451jas.176.2023.10.04.08.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 08:46:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------KkiqCNpQAN7nqMAgjL3oZSax"
Message-ID: <e9f9ee91-9e18-4a00-90a0-19b8ac47bbb3@linuxfoundation.org>
Date:   Wed, 4 Oct 2023 09:46:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 6.6-rc5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------KkiqCNpQAN7nqMAgjL3oZSax
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 6.6-rc5.

This kselftest fixes update for Linux 6.6-rc5 consists of one single
fix to Makefile to fix the incorrect TARGET name for uevent test.

diff is attached.

thanks.
-- Shuah

----------------------------------------------------------------
The following changes since commit 8ed99af4a266a3492d773b5d85c3f8e9f81254b6:

   selftests/user_events: Fix to unmount tracefs when test created mount (2023-09-18 11:04:52 -0600)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-6.6-rc5

for you to fetch changes up to 6f874fa021dfc7bf37f4f37da3a5aaa41fe9c39c:

   selftests: Fix wrong TARGET in kselftest top level Makefile (2023-09-26 18:47:37 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-6.6-rc5

This kselftest fixes update for Linux 6.6-rc5 consists of one single
fix to Makefile to fix the incorrect TARGET name for uevent test.

----------------------------------------------------------------
Juntong Deng (1):
       selftests: Fix wrong TARGET in kselftest top level Makefile

  tools/testing/selftests/Makefile | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
----------------------------------------------------------------
--------------KkiqCNpQAN7nqMAgjL3oZSax
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-6.6-rc5.diff"
Content-Disposition: attachment; filename="linux-kselftest-fixes-6.6-rc5.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvTWFrZWZpbGUKaW5kZXggNDI4MDZhZGQwMTE0Li4xYTIxZDZi
ZWViYzYgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlCisr
KyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL01ha2VmaWxlCkBAIC05Miw3ICs5Miw3IEBA
IGVuZGlmCiBUQVJHRVRTICs9IHRtcGZzCiBUQVJHRVRTICs9IHRwbTIKIFRBUkdFVFMgKz0g
dHR5Ci1UQVJHRVRTICs9IHVldmVudHMKK1RBUkdFVFMgKz0gdWV2ZW50CiBUQVJHRVRTICs9
IHVzZXIKIFRBUkdFVFMgKz0gdXNlcl9ldmVudHMKIFRBUkdFVFMgKz0gdkRTTwo=

--------------KkiqCNpQAN7nqMAgjL3oZSax--
