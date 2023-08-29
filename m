Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124AD78D0BC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241198AbjH2Xow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbjH2Xoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:44:32 -0400
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40E1B3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693352669; bh=5mNqkLH2I1e3/+A3oA7daHm/fRDQKA8KiaFggXGQ1cs=; h=Date:To:Cc:From:Subject:References:From:Subject:Reply-To; b=ZmOGXCzZYH2mVb83HJE+q9lYO/jyjjUH18eXaxtiB7FMg9qJlOJ5ZMb2ZxCatFMryVJ5lf7xSImn3lK2JZs0rmL8HsK2EEUbZfph/zCRKKu1gcdIjZIHANveEsMo/mfEoa1Jcx6rDJgMzXOFNGELf/HQJMGkWsG+y4gQmj1Vs6WFP2t9iG7MzKqprAqqUpGLsOlXDAQJrB6i2sQ0FLzw78Jf9Rdu6IcGgFg4wQxWw6UYNwy5/9vgl5Oq0apvvVXfUggVAcQOAr/aIAjlJ3n+gKD3eVhhJy8HgQ9PqImVC35aoMvlBIik1naq/4mEueBsIZrmuQpgq4M2g2NfF4KboA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1693352669; bh=DxcOxINJsqm4IbEBu5zLfi3FctwJn/Wt7g+52ouScIi=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=ORNOdTCqI+JPJ3h3KHaAyfWGqw3zxPY+oIki85sKVRggM1pejQvSHN3ZMN8rn41zSF5Lt8JA56SoLupNRPk8cggZTk8Uv8FhcUZGWd7t9Z9ysN1c4JRh1uVuEZItrSr/ba8ADic0ICxq9P3Dou25Y931/sAc2hes6Q+ZeuitxbIVFXJQoyqVZhz+qF4nL0oEAyHj3RRoRTIyFF3nhtH5cOUrTjLOQ9Z/yKIrVwlD4AcIfviD7NkX/tZvP89NeU41dnkNpYHAanm1ZIa67mjEchrb16BM45lko7HkAkJOsLoB/CzFdmmvp+7Uer1ezPZYW4eqzT1euJ2w8rJDrR6yvA==
X-YMail-OSG: wHVyQBMVM1nOY__v3howP__5zTWrZvZwTuBh8svCvsD1nSpG7uGumOfSgLDRwMb
 FQ0yca1ch4A2LVP.5uhJTw.jyuMZ46F4cdCSClypDSOI4zEwRk3DEULwMaOEbzKqceYE4I3h9RK0
 H15KAB_2MpP_wGa9KFK3c8IrZ.rx7FI5ZCvyzDzC98sKspdicTml11WduXhcUL2P80XNLGh.AxUZ
 e0A_Vexd7uaPmyYqWzHV5cM0t52fVAV1eOFjer_PDiMWhoTxOebRbPEeEpU9O6FELXcCtt5K2Ehw
 pTf6dGR5L1o0lVW1VG2vvZ1vzDQxHVV0KGYtdxMRlIpdRptthwqqQjsVwIesO4Z16MvpW9MMbHG7
 0P5XLaFKY3NPnwiNvtAGoAySelSzFk0KoMbPd.TIQ30CNCjhTzhhE44m9GcQjcDNS0XnlLuJT2dl
 m9fCpdocbWfJTKYYlf_QhytwENdqMq57VsjUnhduzoksl3SU7oFnO2YmvuoEBckG0Eu2QQEaFxnY
 tiN48r9rDh5Q_gHBuQbKcasMYyIW8UU4XMqxQyzp3WKA.0RlB2m0cJKYhH4JhQVXoVfLQNHLtR5m
 jJXRwWwzxfk6jfUZmDCyJFXTgk.aZtRZqVas9BmlHCwHclCoixO37bSQQ5UKIaDyE6MRVcV8SZcz
 WmtnKnCs325FxTS2PmWDMVI374UJsVHqGZ4qT7TNos_.st8lAhr1rDXg_AdAHFHLP.uaPnH2Vowo
 pxNMZ43bVaNdmBidCxnUDKzCik5MHKN2rbrWXmPyscDfGJotyY3g5loxzkIeukd4NgFpbqOE0W8G
 8HYdfRuDobkpemsbA0QNDMQ6oRUEhGSWtVbESbXwvFh16aSFgDJlAEqY4775dggAJdOlVNxSRPiQ
 q._mdQ7CJT8Yd3LxAo5MymD3QOpoKNtqXCd9kvinLW2fkeqZOnbi7nFWXUC48PtXQpqC97bLjZvS
 xe5v2j2pn2s0Muok4tb4m75o11ZvScWE_P2uwmjN4li2ZvlgS..h3InM5sTY2q3xfmmNuFq2vzYc
 k5ccarKhlosMsiIB4g8RFTbx35DCgIcVyutNEJuniGZYdmXX3lFq.CO9NHrjvTn_rXw6Rjy78ntw
 Td8vhvjK.tB6TTUn.o0TYuX3U_nYPlmOiyMBKm8QWmGv8DJiHtJ3Nc41D8qAYT1TZzJR7Sh74__C
 UIfmP9_yeIzKeIFF5yuv2YP6nriPiI2Yccsx4EVB3DzBMRRLkiF4vEImqbmWHDYEokP6.H.b4ghf
 FBoado9mUkHh3HihIpgmnKkeeOvHm_29iYN9SZb1suhD1SHljL_plgJORsRy22cf.AUJg51BMVLC
 kXPvKgYFURIYeNMI6Iv3X56eTm9blgMcanBuP.FHONQlewM1keY62NPg4HIO06hTTWfuUpqPjr5k
 2hSq1Ao8D7VZ9txPN2OgJjzIdlpJsUfcfAfIzP8WrmoOAU0C5zOJIArCj9n4iM13dUxK7hGXSHbU
 eKO7j5IH1xmFQAGDVL0TIYKyiU6A_YHTEU8LJKDTFeNah0FWZiwIQQFXeLcS1y_jFtbKwHkIfM9Q
 70UDCj4BrYwM7f._fKP3nJOXxTuqwc9DL40993apYps2JNr2x.1F0L13a67DXuIg1ATJDsxeheVo
 7qNPBvWeVFAD0_xfoFndMpivlw3.kVrVWUqaFhOYFu96_A2KvmP02CpYGjCyqc3X3uL1AmtGCjd4
 g8f3FwLiHWv9dpIPBb.mJXwjNNJNrAoxYgacIn0yz9oIq1hhyIiHZ8sfteD_uEGsq6yNWqnu9bx0
 w62Bn1P5ce4J8loKkyTLHx8HmrxQCmUUNUTRP805jgvxO26qQVZYSPzZXvmcpt14NY0ZOP6GJYih
 wg9zC8BJ3IS4y4QwZmxiMpzsHS7.pUK_BK9kjfFIl8x_ALqbfJZA0NtsMEYKdJtyuhPInF4a7j4H
 JYiqH8GT9JDnU.LDLZ1OzY_xdDpcpPgUV7UwpUrlR2UujL3iNuCBTl4Nr4BS0x4yNStePg8uPPW4
 9j4MOJZYBJsPCaH9_pHeEEhXxQzTsOSAP6kgx7EEIhZhfNumxrBhuyCV_SrmB7vQr75U4TnZnZlp
 FBGSvR1i_MXyiTM8W01oo29aDUz0IQ5kMkTHs28DokGUrYz55PhjALDh9Q3Ubj3WrWnHrHqD02v4
 TWREqsni.muRdX3hReeSENcuzoz5XAa7odwRGyo7bxZORnFtgHo7SyUNvLvSxzEi0bwoIrbdXxAt
 jscUqMmXyyfon8cpRB77H
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: a43a68c4-3eae-45af-9240-5c472a17f219
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Aug 2023 23:44:29 +0000
Received: by hermes--production-gq1-6b7c87dcf5-x8vcl (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID adbacdb6cc9c54678be3f7cc98d17ac2;
          Tue, 29 Aug 2023 23:44:27 +0000 (UTC)
Message-ID: <d8c21494-583f-8da2-a2cb-cd5410a13900@schaufler-ca.com>
Date:   Tue, 29 Aug 2023 16:44:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LSM List <linux-security-module@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Subject: [GIT PULL] Smack patches for 6.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
References: <d8c21494-583f-8da2-a2cb-cd5410a13900.ref@schaufler-ca.com>
X-Mailer: WebService/1.1.21763 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the Smack pull request for v6.6.

There are two patches. One is a simple spelling fix. The other is a
bounds check for a very likely underflow. These updates have been in
the next branch and pass all tests. Thank you.

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://github.com/cschaufler/smack-next tags/Smack-for-6.6

for you to fetch changes up to 3ad49d37cf5759c3b8b68d02e3563f633d9c1aee:

  smackfs: Prevent underflow in smk_set_cipso() (2023-08-07 14:09:23 -0700)

----------------------------------------------------------------
Smack updates for v6.6. Two minor fixes.

----------------------------------------------------------------
Dan Carpenter (1):
      smackfs: Prevent underflow in smk_set_cipso()

Tóth János (1):
      security: smack: smackfs: fix typo (lables->labels)

 security/smack/smackfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

