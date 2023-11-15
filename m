Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25887ED5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjKOVWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOVV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:21:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CED92;
        Wed, 15 Nov 2023 13:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1700083312; x=1700688112; i=rwarsow@gmx.de;
        bh=99Alm4btTapJyIk2kAvPcyVCjpKTkJABGOaRccLIHog=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=egy/EoJJtcs4rusrrR/p4UUnHESbeRl93xUXpSJF5FyWax/Ri2gOzAnz+PEH3wGX
         df85xqsAAPriC+oHbmK1sZwRN5yIBitWnO2qFGIUWSFL+UgeFj961FY4YcFvGA0Ef
         uHmh7y7Dj5expJI5CQs/yu4QjFzELszmIOq7d1N8vr+c/FN5+TL8C9LGzl0y5/t3B
         EkOi+dhcj8NADZqjKhoNzRCKP4IJrY55QmbD+u9Lx0lp2sjpjVxpOY640jdiVd+MG
         1h+tjHEK3HIelChcdlgb5wkmDb2wUHwqq7RK3IqmubwgxQDDM1I2dSOBFT5boZmsn
         5RN5sk5QTYSEQec/lA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([92.116.253.47]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBm1U-1rDFDo0jUq-00C9jL; Wed, 15
 Nov 2023 22:21:52 +0100
Message-ID: <7aca5d3c-a66a-4594-a958-fd0b8a8280db@gmx.de>
Date:   Wed, 15 Nov 2023 22:21:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Ronald Warsow <rwarsow@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.6 000/603] 6.6.2-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:K0YQYCMnrStGjOdkIoHUZJ6U8uaeHsxYQtvyPc/81zyvq/EPNWa
 mtgOgGSPVn2Qh5PkDTZuXP2HKxEtdfchRZksdUL7VfXuF2AJ6sLM5wo3aH/Pw9Ad61KQUBP
 QOHjAxJICIDwCRPFiWqdIz4STru/AZ+N+e12p8+++Yk5uSVhQ8emRCRRbJ5ThbOGbLzt1Lr
 7mHPQiyt8gb6LBQqHePeQ==
UI-OutboundReport: notjunk:1;M01:P0:KZkr6LsblHc=;+wPb7oEMlK6626HJ5a51zsGMQ3d
 RGWXChUIiq1gWanHrKZps4WL6JmdmopGpUO/ZHJOVX8Vuq8DrfLwctOsoBvlrMYnme7z/Tb2O
 WUDI8u6sCbJH1FnTGbUvHzSpoZfU8nShZ4iCzA1pr3j/yd66yfO5o7Bjp/bj4IZ5Pu05r6ZIr
 zrYkw3X83S1UXuwYeNuWFVAJ5XigO8CLXQBV2KvJKdzUWhIehqXeq5fpjibrCKxtGNUbfn8CT
 paE99EqO3QUQtQbK9mtMAytEbEmaXqJla74oDEKx3NrxfhgSlna8Co0Psa9OaDSnS0lvhpYTS
 V9EW+4dcVfirZ1coJ43SMiFJbCMirsheTHlj/oGkXbhCLGwiyxdhflZguJLwLSV17DXBd+pa/
 ACfnYB/EJZH5XSfmZd2CSlGlbcwNC2Nu29VI2HTP9BCLUz3vFtb+UFdA9DLmJQH4i3cnk14+B
 pD3kagna/JIoUURS6g+BrCc5Pqo73WjF5wwt9LudWYd+5DV6dH4gV58sj1ufZFAHKOy3uoK1/
 3Xj22ctny4eqHACiRqh3tueiDCpr2PY1qF8k+BX3dQPtO/lQ8y4DQYNZjo7cAQNIPDJQVVW7C
 qWkdMHnXPvIi0APNm4HzF0PAR+LLn/3h5vLOXSPYMfBBZOPYRVHSPwD2RRaO0Avh1CPl0Ah6H
 z5Exhl6iyUxu+mJ9fVnIdlbbmmio8+tWeIk/ODKnw2eTOzXHZjh0D5B+HnZgiWImBzR2SYnAB
 MtzEUagb78kYAa/QIhRq3ChLH66B5aQ4O6wk1BfllQEO+UuQERm7pis+0I3k2TZPWEnGj/q9C
 Din7E4RQDGEUc91yaX7uPh9ly/qXL8koyUoRXBG0zd2o762qtjhukUGzGgZ5aWxoi/kSiDs+C
 k0ZWx68uFsQ2qR8yUasuQOLTHbbOcD+W3IDX4ifgz9ZkfcRpM1uxeLDzFb+HsVdbYzUxNSjSt
 3iEh+Q==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

6.6.2-rc1

compiles, boots and runs here on x86_64
(Intel Rocket Lake: i5-11400)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

